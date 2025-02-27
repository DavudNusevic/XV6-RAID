#include "types.h"
#include "riscv.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "raid.h"
#include "defs.h"

extern struct RaidMeta raidmeta;

uint raid0blockn(void);
int raid0init(void);
int raid0read(int vblkn, uchar* data);
int raid0write(int vblkn, uchar* data);
int raid0repair(int diskn);

uint
raid0blockn(void)
{
  return diskblockn() * DISKS;
}

int
raid0init(void)
{
  raidmeta.valid = 1;
  raidmeta.type = RAID0;
  raidmeta.read = raid0read;
  raidmeta.write = raid0write;
  raidmeta.blockn = raid0blockn;
  raidmeta.repair = raid0repair;

  struct RAID0Data* raiddata = &raidmeta.data.raid0;
  for (int i = 0; i < DISKS; i++)
    initsleeplock(&raiddata->lock[i], "raid0lock");

  writeraidmeta();
  return 0;
}

int
raid0read(int vblkn, uchar* data)
{
  if (raidmeta.type != RAID0)
    panic("raid0read");

  uint diskn = vblkn % DISKS;
  uint pblockn = vblkn / DISKS;

  struct RAID0Data* raiddata = &raidmeta.data.raid0;
  struct DiskInfo* diskinfo = raidmeta.diskinfo + diskn;

  if (!diskinfo->valid)
    return -1;

  acquiresleep(&raiddata->lock[diskn]);
  read_block(diskinfo->pdiskn, pblockn, data);
  releasesleep(&raiddata->lock[diskn]);

  return 0;
}

int
raid0write(int vblkn, uchar* data)
{
  if (raidmeta.type != RAID0)
    panic("raid0write");

  if (vblkn < 0 || vblkn >= raid0blockn())
    return -1;

  uint diskn = vblkn % DISKS;
  uint pblockn = vblkn / DISKS;

  struct RAID0Data* raiddata = &raidmeta.data.raid0;
  struct DiskInfo* diskinfo = raidmeta.diskinfo + diskn;

  if (!diskinfo->valid)
    return -1;

  acquiresleep(&raiddata->lock[diskn]);
  write_block(diskinfo->pdiskn, pblockn, data);
  releasesleep(&raiddata->lock[diskn]);

  return 0;
}

int
raid0repair(int diskn)
{
  return -1;
}