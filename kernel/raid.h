#define GRPSIZE 128
enum RAID_TYPE {RAID0, RAID1, RAID0_1, RAID4, RAID5};

struct DiskInfo
{
    struct spinlock mutex;
    uint8 valid;
    uint8 pdiskn;
};

struct DiskPair
{
    struct spinlock mutex;
    struct DiskInfo* diskinfo[2];
    uint8 writing;
    uint8 reading[2];
};

struct RAID0Data
{
    struct sleeplock lock[DISKS];
};

struct RAID1Data
{
    struct DiskPair diskpair[(DISKS + 1) / 2];
};

struct RAID0_1Data
{
    struct DiskPair diskpair[DISKS / 2];
};

struct RAID4Data
{
    uint8 groupvalid[(RAID_DISK_SIZE / BSIZE / GRPSIZE + 7) / 8];
    struct sleeplock lock[DISKS];
    struct sleeplock grouplock;
};

struct RaidMeta
{
    uint8 init;
    uint8 valid;
    enum RAID_TYPE type;

    struct spinlock dirty;
    int maxdirty;

    union
    {
        struct RAID0Data raid0;
        struct RAID1Data raid1;
        struct RAID0_1Data raid0_1;
        struct RAID4Data raid4;
    } data;

    struct DiskInfo diskinfo[DISKS + 1];
    int (*read)(int vblkn, uchar* data);
    int (*write)(int vblkn, uchar* data);
    uint (*blockn)(void);
    int (*repair)(int diskn);
};