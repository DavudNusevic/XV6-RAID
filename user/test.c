#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

uchar
noise(int i, int j)
{
  int n = i + j;
  switch (n%3)
  {
    case 0:
      return '&' + (i & 3);
    case 1:
      return 'F' + (j & 3);
    default:
      return '<' + (i & 7);
  }
}

int
main(void)
{
  printf("Starting..\n");

  if (init_raid(RAID1) < 0)
  {
    printf("Fatal error on init_raid\n");
    exit(-1);
  }

  uint diskn, blkn, blks;
  if (info_raid(&blkn, &blks, &diskn) < 0)
  {
    printf("Fatal error on info_raid\n");
    exit(-1);
  }

  printf("blkn=%d, blks=%d, diskn=%d\n", blkn, blks, diskn);

  uchar data[blks];
  int step = 500;
  int l = 0, u = step;


  for (int i = 1; i < 10; i++)
    if (fork() == 0)
    {
      l = step * (i + 1);
      u = step * (i + 2);
      break;
    }

  for (int i = l; i < u; i++)
  {
    for (int j = 0; j < blks; j++)
      data[j] = noise(i, j);
    if (write_raid(i, data) < 0)
    {
      printf("Fatal error in write_raid\n");
      exit(-2);
    }
  }

  disk_repaired_raid(2);

  for (int i = l; i < u; i++)
  {
    for (int j = 0; j < blks; j++)
      data[j] = 'c';

    if (read_raid(i, data) < 0)
    {
      printf("Fatal error in read_raid\n");
      exit(-3);
    }

    for (int j = 0; j < blks; j++)
      if (data[j] != noise(i, j))
      {
        printf("Bad read\n");
        exit(-4);
      }
  }

  printf("Good read\n");
  exit(0);
}

