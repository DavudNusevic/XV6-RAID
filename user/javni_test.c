#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void check_data(uint blocks, uchar *blk, uint block_size);

int
main(int argc, char *argv[])
{
  printf("Starting..\n");
  init_raid(RAID1);

  uint disk_num, block_num, block_size;
  info_raid(&block_num, &block_size, &disk_num);

  uint blocks = (512 > block_num ? block_num : 512);

  uchar* blk = malloc(block_size);
  for (uint i = 0; i < blocks; i++) {
    for (uint j = 0; j < block_size; j++) {
      blk[j] = j + i;
    }
    write_raid(i, blk);
  }

  check_data(blocks, blk, block_size);
  printf("[First check finished]\n");

  disk_fail_raid(2);

  check_data(blocks, blk, block_size);
  printf("[Second check finished]\n");

  disk_repaired_raid(2);
//
//  check_data(blocks, blk, block_size);
//  printf("[Third check finished]\n");

  free(blk);
  printf("End\n");
  exit(0);
}

void check_data(uint blocks, uchar *blk, uint block_size)
{
  for (uint i = 0; i < blocks; i++)
  {
    read_raid(i, blk);
    for (uint j = 0; j < block_size; j++)
    {
      if ((uchar)(j + i) != blk[j])
      {
        printf("expected=%d got=%d", j + i, blk[j]);
        printf("Data in the block %d faulty\n", i);
        break;
      }
    }
  }
}
