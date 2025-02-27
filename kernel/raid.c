#include "types.h"
#include "riscv.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "raid.h"
#include "defs.h"

extern int raid0init(void);
extern int raid1init(void);
extern int raid0_1init(void);
extern int raid4init(void);
// TODO raidfail: sacuvati raidmeta na diskove, takodje i u repair
int (*initTable[])(void) =
{
    [RAID0] = raid0init,
    [RAID1] = raid1init,
    [RAID0_1] = raid0_1init,
    [RAID4] = raid4init,
};

struct RaidMeta raidmeta;

uint
diskblockn(void)
{
    return RAID_DISK_SIZE / BSIZE - 1;
}

uint
raidblockn(void)
{
  if (!raidmeta.valid)
    return -1;
  return raidmeta.blockn();
}

void
writeraidmeta(void)
{
  for (int i = 0; i < DISKS; i++)
  {
    struct DiskInfo* diskinfo = raidmeta.diskinfo + i;
    if (diskinfo->valid)
    {
        uchar data[BSIZE] = {0};
        memmove(data, &raidmeta, sizeof(raidmeta));
        int lastblock = diskblockn();
        write_block(diskinfo->pdiskn, lastblock, data);
    }
  }

}

void
loadraid(void)
{
    uchar data[BSIZE];
    int lastblock = diskblockn();
    read_block(1, lastblock, data);
    memmove(&raidmeta, data, sizeof(raidmeta));

    if (!raidmeta.init)
    {
        for (int i = 0; i < DISKS; i++)
        {
            raidmeta.diskinfo[i].pdiskn = i + 1;
            raidmeta.diskinfo[i].valid = 1;
            initlock(&raidmeta.diskinfo[i].mutex, "diskinfomutex");
        }
        raidmeta.diskinfo[DISKS].valid = 0;

        initlock(&raidmeta.dirty, "raidmetadirty");

        raidmeta.init = 1;
        raidmeta.valid = 0;
        raidmeta.maxdirty = 0;
        raidmeta.read = 0;
        raidmeta.write = 0;
        raidmeta.blockn = 0;
        raidmeta.maxdirty = -1;

        writeraidmeta();
        return;
    }

}

int
setraidtype(int type)
{
  if (type < 0 || type >= NELEM(initTable))
    return -1;

  return (*initTable[type])();
}

int
readraid(int vblkn, uchar* data)
{
  if (!raidmeta.valid)
    return -1;

  if (vblkn < 0 || vblkn >= raidmeta.blockn())
     return -2;

  return raidmeta.read(vblkn, data);
}

int
writeraid(int vblkn, uchar* data)
{
    if (!raidmeta.valid)
        return -1;

    if (vblkn < 0 || vblkn >= raidmeta.blockn())
        return -2;

    return raidmeta.write(vblkn, data);
}

uint64
readdiskpair(struct DiskPair* diskpair, int pblkn, uchar* data)
{
    int diskn = -1, readfrom = -1;

    acquire(&diskpair->mutex);
    while (1)
    {

        if (diskpair->diskinfo[0]->valid == 0 && diskpair->diskinfo[1]->valid == 0)
        {
            release(&diskpair->mutex);
            return -1;
        }

        if (diskpair->writing)
        {
            sleep(diskpair, &diskpair->mutex);
            continue;
        }

        for (int i = 0; i < 2; i++)
            if ((!diskpair->reading[i]) && diskpair->diskinfo[i]->valid)
            {
                diskpair->reading[i] = 1;
                release(&diskpair->mutex);
                diskn = diskpair->diskinfo[i]->pdiskn;
                readfrom = i;
                goto readdiskpairloopend;
            }


       sleep(diskpair, &diskpair->mutex);
    }
readdiskpairloopend:
    if (diskn == -1 || readfrom == -1)
        panic("readdiskpair");

    read_block(diskn, pblkn, data);

    acquire(&diskpair->mutex);
    diskpair->reading[readfrom] = 0;
    release(&diskpair->mutex);
    wakeup(diskpair);

    return 0;
}

uint64
writediskpair(struct DiskPair* diskpair, int pblkn, uchar* data)
{
    acquire(&diskpair->mutex);

    while (1)
    {
        if (diskpair->diskinfo[0]->valid == 0 && diskpair->diskinfo[1]->valid == 0)
        {
            release(&diskpair->mutex);
            return -1;
        }

        if (diskpair->writing)
        {
            sleep(diskpair, &diskpair->mutex);
            continue;
        }

        if (diskpair->reading[0] || diskpair->reading[1])
        {
            sleep(diskpair, &diskpair->mutex);
            continue;
        }

        diskpair->writing = 1;
        release(&diskpair->mutex);
        break;
    }

    for (int i = 0; i < 2; i++)
        if (diskpair->diskinfo[i]->valid)
            write_block(diskpair->diskinfo[i]->pdiskn, pblkn, (uchar*)data);

    acquire(&diskpair->mutex);
    diskpair->writing = 0;
    release(&diskpair->mutex);
    wakeup(diskpair);

    return 0;
}

int
raidfail(int diskn)
{
  if (diskn >= DISKS)
    return -1;
  raidmeta.diskinfo[diskn].valid = 0;
  return 0;
}

int
raidrepair(int diskn)
{
  if (!raidmeta.valid)
    return -1;

  return raidmeta.repair(diskn);
}