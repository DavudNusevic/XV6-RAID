#include "types.h"
#include "riscv.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "raid.h"
#include "defs.h"

extern struct RaidMeta raidmeta;

uint raid4blockn(void);
int raid4init(void);
int raid4read(int vblkn, uchar* data);
int raid4write(int vblkn, uchar* data);

uint
raid4blockn(void)
{
    return diskblockn() * (DISKS - 1);
}

int
raid4init(void)
{
    if (!raidmeta.diskinfo[DISKS - 1].valid)
      return -1;

    raidmeta.valid = 1;
    raidmeta.type = RAID4;
    raidmeta.read = raid4read;
    raidmeta.write = raid4write;
    raidmeta.blockn = raid4blockn;

    struct RAID4Data* raiddata = &raidmeta.data.raid4;
    for (int i = 0; i < DISKS; i++)
        initsleeplock(&raiddata->lock[i], "raid4lock");
    initsleeplock(&raiddata->grouplock, "raid4grouplock");

//    int maxdirtygroup = raidmeta.maxdirty > 0 ? raidmeta.maxdirty / GRPSIZE : raidmeta.maxdirty;
//    printf("maxdirtygroup = %d\n", maxdirtygroup);
//    for (int i = 0; i <= maxdirtygroup; i++)
//      raiddata->groupvalid[i] = 0;
//    for (int i = maxdirtygroup + 1; i < NELEM(raiddata->groupvalid); i++)
//      raiddata->groupvalid[i] = 1;

    for (int i = 0; i < NELEM(raiddata->groupvalid); i++)
      raiddata->groupvalid[i] = 0;

    writeraidmeta();
    return 0;
}
// group lock must be held when calling
int
initgroup(int grpn)
{
    if (!raidmeta.diskinfo[DISKS - 1].valid)
        return -1;

    uchar* newpg = (uchar*)kalloc();
    uchar* buff = newpg;
    uchar* parity = newpg + BSIZE;

    struct RAID4Data* raiddata = &raidmeta.data.raid4;
    for (int i = 0; i < DISKS; i++)
      acquiresleep(&raiddata->lock[i]);

    uint start = grpn * GRPSIZE;
    for (uint blockn = start; blockn < start + GRPSIZE; blockn++)
    {
      for (int i = 0; i < BSIZE; i++)
        parity[i] = 0;

      struct DiskInfo* diskinfo = raidmeta.diskinfo;

      for (int diskn = 0; diskn < DISKS - 1; diskn++)
        if (diskinfo[diskn].valid)
        {
            read_block(diskinfo[diskn].pdiskn, blockn, buff);
            for (int i = 0; i < BSIZE; i++)
              parity[i] ^= buff[i];
        }

      write_block(DISKS, blockn, parity);
    }

    raiddata->groupvalid[grpn / 8] |= 1 << (grpn % 8);

    writeraidmeta();

    for (int i = 0; i < DISKS; i++)
      releasesleep(&raiddata->lock[i]);

    kfree(newpg);
    return 0;
}

int
readinvalid(int diskn, int blockn, uchar* data)
{
  uchar* newpg = (uchar*)kalloc();
  uchar* buff = newpg;
  uchar* parity = newpg + BSIZE;

  for (int i = 0; i < BSIZE; i++)
    parity[i] = 0;


  struct RAID4Data* raiddata = &raidmeta.data.raid4;
  for (int i = 0; i < DISKS; i++)
    acquiresleep(&raiddata->lock[i]);

  struct DiskInfo* diskinfo = raidmeta.diskinfo;
  for (int i = 0; i < DISKS; i++)
    if (i != diskn)
    {
      read_block(diskinfo[i].pdiskn, blockn, buff);
      for (int j = 0; j < BSIZE; j++)
        parity[j] ^= buff[j];
    }

  for (int i = 0; i < DISKS; i++)
    releasesleep(&raiddata->lock[i]);

  for (int i = 0; i < BSIZE; i++)
    data[i] = parity[i];

  kfree(newpg);
  return 0;
}

int
raid4read(int vblkn, uchar* data)
{
    if (raidmeta.type != RAID4)
      panic("raid4read");

    uint diskn = vblkn % (DISKS - 1);
    uint pblkn = vblkn / (DISKS - 1);

    struct RAID4Data* raiddata = &raidmeta.data.raid4;
    struct DiskInfo* diskinfo = raidmeta.diskinfo;
    if (!diskinfo[diskn].valid)
    {
      for (int i = 0; i < DISKS; i++)
        if (i != diskn && !diskinfo[i].valid)
          return -1;
      return readinvalid(diskn, pblkn, data);
    }

    acquiresleep(&raiddata->lock[diskn]);
    read_block(diskinfo[diskn].pdiskn, pblkn, data);
    releasesleep(&raiddata->lock[diskn]);

    return 0;
}

int
raid4write(int vblkn, uchar* data)
{
    if (raidmeta.type != RAID4)
      panic("raid4write");

    uint diskn = vblkn % (DISKS - 1);
    uint pblkn = vblkn / (DISKS - 1);

    struct DiskInfo* diskinfo = raidmeta.diskinfo;
    if (!diskinfo[diskn].valid || !diskinfo[DISKS - 1].valid)
      return -1;

    struct RAID4Data* raiddata = &raidmeta.data.raid4;
    int grpn = pblkn / GRPSIZE;
    int grpi = (grpn / 8);

    acquiresleep(&raiddata->grouplock);
    if (!(raiddata->groupvalid[grpi] & (1 << grpn % 8)))
      initgroup(grpn);
    releasesleep(&raiddata->grouplock);

    uchar* newpg = (uchar*)kalloc();
    uchar* olddata = (uchar*)newpg;
    uchar* parity = (uchar*)newpg + BSIZE;

    acquiresleep(&raiddata->lock[diskn]);
    acquiresleep(&raiddata->lock[DISKS - 1]);

    read_block(diskinfo[diskn].pdiskn, pblkn, olddata);
    read_block(DISKS, pblkn, parity);
    for (int i = 0; i < BSIZE; i++)
      parity[i] ^= olddata[i] ^ data[i];

    write_block(diskinfo[diskn].pdiskn, pblkn, data);
    write_block(DISKS, pblkn, parity);

    releasesleep(&raiddata->lock[diskn]);
    releasesleep(&raiddata->lock[DISKS - 1]);

    kfree(newpg);
    return 0;
}

