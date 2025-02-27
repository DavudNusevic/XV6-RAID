#include "types.h"
#include "riscv.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "raid.h"
#include "defs.h"

extern struct RaidMeta raidmeta;

uint raid0_1blockn(void);
int raid0_1init(void);
int raid0_1read(int vblkn, uchar* data);
int raid0_1write(int vblkn, uchar* data);
int raid0_1repair(int diskn);

uint
raid0_1blockn(void)
{
    return diskblockn() * (DISKS / 2);
}

int
raid0_1init(void)
{
    raidmeta.valid = 1;
    raidmeta.type = RAID0_1;
    raidmeta.read = raid0_1read;
    raidmeta.write = raid0_1write;
    raidmeta.blockn = raid0_1blockn;
    raidmeta.repair = raid0_1repair;

    struct RAID0_1Data* raiddata = &raidmeta.data.raid0_1;
    for (int i = 0; i < DISKS / 2; i++)
    {
        raiddata->diskpair[i].diskinfo[0] = raidmeta.diskinfo + i;
        raiddata->diskpair[i].diskinfo[1] = raidmeta.diskinfo + i + DISKS / 2;

        initlock(&raiddata->diskpair[i].mutex, "raidlock");
        raiddata->diskpair[i].writing = 0;
        for (int j = 0; j < 2; j++)
            raiddata->diskpair[i].reading[j] = 0;
    }

	writeraidmeta();
    return 0;
}

int
raid0_1read(int vblkn, uchar* data)
{
    if (raidmeta.type != RAID0_1)
      panic("raid0_1read");

    uint pairn = vblkn % (DISKS / 2);
    uint pblkn = vblkn / (DISKS / 2);

    struct RAID0_1Data* raiddata = &raidmeta.data.raid0_1;
    struct DiskPair* diskpair = raiddata->diskpair + pairn;

    return readdiskpair(diskpair, pblkn, data);
}

int
raid0_1write(int vblkn, uchar* data)
{
    if (raidmeta.type != RAID0_1)
        panic("raid0_1read");

    uint pairn = vblkn % (DISKS / 2);
    uint pblkn = vblkn / (DISKS / 2);

    struct RAID0_1Data* raiddata = &raidmeta.data.raid0_1;
    struct DiskPair* diskpair = raiddata->diskpair + pairn;

    return writediskpair(diskpair, pblkn, data);
}

int
raid0_1repair(int diskn)
{
    struct RAID0_1Data* raiddata = &raidmeta.data.raid0_1;
    struct DiskPair* diskpair = raiddata->diskpair + diskn / 2;
    struct DiskInfo* pair = diskpair->diskinfo[1 - diskn % 2];

    if (raidmeta.diskinfo[diskn].valid)
      return 0;

    if (!pair->valid)
        return -1;

    acquire(&diskpair->mutex);
    while (1)
    {
        if (diskpair->writing || diskpair->reading[0] || diskpair->reading[1])
        {
            sleep(diskpair, &diskpair->mutex);
            continue;
        }

        diskpair->writing = 1;
        release(&diskpair->mutex);
        break;
    }

    for (int i = 0; i <= diskblockn(); i++)
    {
        uchar data[BSIZE];
        read_block(pair->pdiskn, i, data);
        write_block(raidmeta.diskinfo[diskn].pdiskn, i, data);
    }

    raidmeta.diskinfo[diskn].valid = 1;
    acquire(&diskpair->mutex);
    diskpair->writing = 0;
    release(&diskpair->mutex);
    wakeup(diskpair);

    uchar data[BSIZE] = {0};
    memmove(data, &raidmeta, sizeof(raidmeta));
    for (int i = 0; i < 1; i++)
        writediskpair(raiddata->diskpair + i, diskblockn(), data);

    return 0;
}