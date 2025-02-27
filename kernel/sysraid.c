#include "types.h"
#include "riscv.h"
#include "fs.h"
#include "param.h"
#include "spinlock.h"
#include "proc.h"
#include "defs.h"

uint64
sys_init_raid(void)
{
  // Fetch argument
  int type;
  argint(0, &type);

  return setraidtype(type);
}

uint64
sys_info_raid(void)
{
  // Fetch arguments and check are they valid
  uint64 blkn_addr, blks_addr, diskn_addr;
  argaddr(0, &blkn_addr);
  argaddr(1, &blks_addr);
  argaddr(2, &diskn_addr);
  if (blkn_addr < 0 || blks_addr < 0 || diskn_addr < 0)
    return -1;

  uint blkn = raidblockn() == -1 ? 0 : raidblockn();
  uint blks = BSIZE;
  uint diskn = DISKS;

  // Write result
  struct proc *p = myproc();
  if (copyout(p->pagetable, blkn_addr, (char*)(&blkn), sizeof(blkn)) < 0)
    return -1;
  if (copyout(p->pagetable, blks_addr, (char*)(&blks), sizeof(blks)) < 0)
    return -1;
  if (copyout(p->pagetable, diskn_addr, (char*)(&diskn), sizeof(diskn)) < 0)
    return -1;

  return 0;
}

uint64
sys_read_raid(void)
{
  // Fetch arguments and check are they valid
  int vblkn;
  argint(0, &vblkn);

  uint64 data_addr;
  argaddr(1, &data_addr);

  if (data_addr < 0)
    return -1;

  char data[BSIZE];
  if (readraid(vblkn, (uchar*)data) < 0)
    return -2;

  struct proc *p = myproc();
  if (copyout(p->pagetable, data_addr, data, BSIZE) < 0)
    return -3;

  return 0;
}

uint64
sys_write_raid(void)
{
  // Fetch arguments and check are they valid
  int vblkn;
  argint(0, &vblkn);

  uint64 data_addr;
  argaddr(1, &data_addr);

  if (data_addr < 0)
    return -1;

  struct proc *p = myproc();
  char data[BSIZE];
  if (copyin(p->pagetable, data, data_addr, BSIZE) < 0)
    return -2;

  if (writeraid(vblkn, (uchar*)data) < 0)
    return -3;

  return 0;
}

uint64
sys_disk_fail_raid(void)
{
  int diskn;
  argint(0, &diskn);
  diskn--;
  if (diskn < 0)
    return -1;

  return raidfail(diskn);
}

uint64
sys_disk_repaired_raid(void)
{
  int diskn;
  argint(0, &diskn);
  diskn--;
  if (diskn < 0)
    return -1;

  return raidrepair(diskn);
}