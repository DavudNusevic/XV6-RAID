
user/_javni_test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

void check_data(uint blocks, uchar *blk, uint block_size);

int
main(int argc, char *argv[])
{
   0:	715d                	addi	sp,sp,-80
   2:	e486                	sd	ra,72(sp)
   4:	e0a2                	sd	s0,64(sp)
   6:	0880                	addi	s0,sp,80
   8:	87aa                	mv	a5,a0
   a:	fab43823          	sd	a1,-80(s0)
   e:	faf42e23          	sw	a5,-68(s0)
  printf("Starting..\n");
  12:	00001517          	auipc	a0,0x1
  16:	f8e50513          	addi	a0,a0,-114 # fa0 <malloc+0x140>
  1a:	00001097          	auipc	ra,0x1
  1e:	c54080e7          	jalr	-940(ra) # c6e <printf>
  init_raid(RAID1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	78a080e7          	jalr	1930(ra) # 7ae <init_raid>

  uint disk_num, block_num, block_size;
  info_raid(&block_num, &block_size, &disk_num);
  2c:	fd440693          	addi	a3,s0,-44
  30:	fcc40713          	addi	a4,s0,-52
  34:	fd040793          	addi	a5,s0,-48
  38:	8636                	mv	a2,a3
  3a:	85ba                	mv	a1,a4
  3c:	853e                	mv	a0,a5
  3e:	00000097          	auipc	ra,0x0
  42:	798080e7          	jalr	1944(ra) # 7d6 <info_raid>

  uint blocks = (512 > block_num ? block_num : 512);
  46:	fd042783          	lw	a5,-48(s0)
  4a:	0007869b          	sext.w	a3,a5
  4e:	20000713          	li	a4,512
  52:	00d77463          	bgeu	a4,a3,5a <main+0x5a>
  56:	20000793          	li	a5,512
  5a:	fef42223          	sw	a5,-28(s0)

  uchar* blk = malloc(block_size);
  5e:	fcc42783          	lw	a5,-52(s0)
  62:	853e                	mv	a0,a5
  64:	00001097          	auipc	ra,0x1
  68:	dfc080e7          	jalr	-516(ra) # e60 <malloc>
  6c:	fca43c23          	sd	a0,-40(s0)
  for (uint i = 0; i < blocks; i++) {
  70:	fe042623          	sw	zero,-20(s0)
  74:	a085                	j	d4 <main+0xd4>
    for (uint j = 0; j < block_size; j++) {
  76:	fe042423          	sw	zero,-24(s0)
  7a:	a805                	j	aa <main+0xaa>
      blk[j] = j + i;
  7c:	fe842783          	lw	a5,-24(s0)
  80:	0ff7f693          	zext.b	a3,a5
  84:	fec42783          	lw	a5,-20(s0)
  88:	0ff7f713          	zext.b	a4,a5
  8c:	fe846783          	lwu	a5,-24(s0)
  90:	fd843603          	ld	a2,-40(s0)
  94:	97b2                	add	a5,a5,a2
  96:	9f35                	addw	a4,a4,a3
  98:	0ff77713          	zext.b	a4,a4
  9c:	00e78023          	sb	a4,0(a5)
    for (uint j = 0; j < block_size; j++) {
  a0:	fe842783          	lw	a5,-24(s0)
  a4:	2785                	addiw	a5,a5,1
  a6:	fef42423          	sw	a5,-24(s0)
  aa:	fcc42703          	lw	a4,-52(s0)
  ae:	fe842783          	lw	a5,-24(s0)
  b2:	2781                	sext.w	a5,a5
  b4:	fce7e4e3          	bltu	a5,a4,7c <main+0x7c>
    }
    write_raid(i, blk);
  b8:	fec42783          	lw	a5,-20(s0)
  bc:	fd843583          	ld	a1,-40(s0)
  c0:	853e                	mv	a0,a5
  c2:	00000097          	auipc	ra,0x0
  c6:	6fc080e7          	jalr	1788(ra) # 7be <write_raid>
  for (uint i = 0; i < blocks; i++) {
  ca:	fec42783          	lw	a5,-20(s0)
  ce:	2785                	addiw	a5,a5,1
  d0:	fef42623          	sw	a5,-20(s0)
  d4:	fec42783          	lw	a5,-20(s0)
  d8:	873e                	mv	a4,a5
  da:	fe442783          	lw	a5,-28(s0)
  de:	2701                	sext.w	a4,a4
  e0:	2781                	sext.w	a5,a5
  e2:	f8f76ae3          	bltu	a4,a5,76 <main+0x76>
  }

  check_data(blocks, blk, block_size);
  e6:	fcc42703          	lw	a4,-52(s0)
  ea:	fe442783          	lw	a5,-28(s0)
  ee:	863a                	mv	a2,a4
  f0:	fd843583          	ld	a1,-40(s0)
  f4:	853e                	mv	a0,a5
  f6:	00000097          	auipc	ra,0x0
  fa:	07a080e7          	jalr	122(ra) # 170 <check_data>
  printf("[First check finished]\n");
  fe:	00001517          	auipc	a0,0x1
 102:	eb250513          	addi	a0,a0,-334 # fb0 <malloc+0x150>
 106:	00001097          	auipc	ra,0x1
 10a:	b68080e7          	jalr	-1176(ra) # c6e <printf>

  disk_fail_raid(2);
 10e:	4509                	li	a0,2
 110:	00000097          	auipc	ra,0x0
 114:	6b6080e7          	jalr	1718(ra) # 7c6 <disk_fail_raid>

  check_data(blocks, blk, block_size);
 118:	fcc42703          	lw	a4,-52(s0)
 11c:	fe442783          	lw	a5,-28(s0)
 120:	863a                	mv	a2,a4
 122:	fd843583          	ld	a1,-40(s0)
 126:	853e                	mv	a0,a5
 128:	00000097          	auipc	ra,0x0
 12c:	048080e7          	jalr	72(ra) # 170 <check_data>
  printf("[Second check finished]\n");
 130:	00001517          	auipc	a0,0x1
 134:	e9850513          	addi	a0,a0,-360 # fc8 <malloc+0x168>
 138:	00001097          	auipc	ra,0x1
 13c:	b36080e7          	jalr	-1226(ra) # c6e <printf>

  disk_repaired_raid(2);
 140:	4509                	li	a0,2
 142:	00000097          	auipc	ra,0x0
 146:	68c080e7          	jalr	1676(ra) # 7ce <disk_repaired_raid>
//
//  check_data(blocks, blk, block_size);
//  printf("[Third check finished]\n");

  free(blk);
 14a:	fd843503          	ld	a0,-40(s0)
 14e:	00001097          	auipc	ra,0x1
 152:	b70080e7          	jalr	-1168(ra) # cbe <free>
  printf("End\n");
 156:	00001517          	auipc	a0,0x1
 15a:	e9250513          	addi	a0,a0,-366 # fe8 <malloc+0x188>
 15e:	00001097          	auipc	ra,0x1
 162:	b10080e7          	jalr	-1264(ra) # c6e <printf>
  exit(0);
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	5a6080e7          	jalr	1446(ra) # 70e <exit>

0000000000000170 <check_data>:
}

void check_data(uint blocks, uchar *blk, uint block_size)
{
 170:	7179                	addi	sp,sp,-48
 172:	f406                	sd	ra,40(sp)
 174:	f022                	sd	s0,32(sp)
 176:	1800                	addi	s0,sp,48
 178:	87aa                	mv	a5,a0
 17a:	fcb43823          	sd	a1,-48(s0)
 17e:	8732                	mv	a4,a2
 180:	fcf42e23          	sw	a5,-36(s0)
 184:	87ba                	mv	a5,a4
 186:	fcf42c23          	sw	a5,-40(s0)
  for (uint i = 0; i < blocks; i++)
 18a:	fe042623          	sw	zero,-20(s0)
 18e:	a85d                	j	244 <check_data+0xd4>
  {
    read_raid(i, blk);
 190:	fec42783          	lw	a5,-20(s0)
 194:	fd043583          	ld	a1,-48(s0)
 198:	853e                	mv	a0,a5
 19a:	00000097          	auipc	ra,0x0
 19e:	61c080e7          	jalr	1564(ra) # 7b6 <read_raid>
    for (uint j = 0; j < block_size; j++)
 1a2:	fe042423          	sw	zero,-24(s0)
 1a6:	a049                	j	228 <check_data+0xb8>
    {
      if ((uchar)(j + i) != blk[j])
 1a8:	fe842783          	lw	a5,-24(s0)
 1ac:	0ff7f713          	zext.b	a4,a5
 1b0:	fec42783          	lw	a5,-20(s0)
 1b4:	0ff7f793          	zext.b	a5,a5
 1b8:	9fb9                	addw	a5,a5,a4
 1ba:	0ff7f693          	zext.b	a3,a5
 1be:	fe846783          	lwu	a5,-24(s0)
 1c2:	fd043703          	ld	a4,-48(s0)
 1c6:	97ba                	add	a5,a5,a4
 1c8:	0007c783          	lbu	a5,0(a5)
 1cc:	8736                	mv	a4,a3
 1ce:	04f70863          	beq	a4,a5,21e <check_data+0xae>
      {
        printf("expected=%d got=%d", j + i, blk[j]);
 1d2:	fe842783          	lw	a5,-24(s0)
 1d6:	873e                	mv	a4,a5
 1d8:	fec42783          	lw	a5,-20(s0)
 1dc:	9fb9                	addw	a5,a5,a4
 1de:	0007869b          	sext.w	a3,a5
 1e2:	fe846783          	lwu	a5,-24(s0)
 1e6:	fd043703          	ld	a4,-48(s0)
 1ea:	97ba                	add	a5,a5,a4
 1ec:	0007c783          	lbu	a5,0(a5)
 1f0:	2781                	sext.w	a5,a5
 1f2:	863e                	mv	a2,a5
 1f4:	85b6                	mv	a1,a3
 1f6:	00001517          	auipc	a0,0x1
 1fa:	dfa50513          	addi	a0,a0,-518 # ff0 <malloc+0x190>
 1fe:	00001097          	auipc	ra,0x1
 202:	a70080e7          	jalr	-1424(ra) # c6e <printf>
        printf("Data in the block %d faulty\n", i);
 206:	fec42783          	lw	a5,-20(s0)
 20a:	85be                	mv	a1,a5
 20c:	00001517          	auipc	a0,0x1
 210:	dfc50513          	addi	a0,a0,-516 # 1008 <malloc+0x1a8>
 214:	00001097          	auipc	ra,0x1
 218:	a5a080e7          	jalr	-1446(ra) # c6e <printf>
        break;
 21c:	a839                	j	23a <check_data+0xca>
    for (uint j = 0; j < block_size; j++)
 21e:	fe842783          	lw	a5,-24(s0)
 222:	2785                	addiw	a5,a5,1
 224:	fef42423          	sw	a5,-24(s0)
 228:	fe842783          	lw	a5,-24(s0)
 22c:	873e                	mv	a4,a5
 22e:	fd842783          	lw	a5,-40(s0)
 232:	2701                	sext.w	a4,a4
 234:	2781                	sext.w	a5,a5
 236:	f6f769e3          	bltu	a4,a5,1a8 <check_data+0x38>
  for (uint i = 0; i < blocks; i++)
 23a:	fec42783          	lw	a5,-20(s0)
 23e:	2785                	addiw	a5,a5,1
 240:	fef42623          	sw	a5,-20(s0)
 244:	fec42783          	lw	a5,-20(s0)
 248:	873e                	mv	a4,a5
 24a:	fdc42783          	lw	a5,-36(s0)
 24e:	2701                	sext.w	a4,a4
 250:	2781                	sext.w	a5,a5
 252:	f2f76fe3          	bltu	a4,a5,190 <check_data+0x20>
      }
    }
  }
}
 256:	0001                	nop
 258:	0001                	nop
 25a:	70a2                	ld	ra,40(sp)
 25c:	7402                	ld	s0,32(sp)
 25e:	6145                	addi	sp,sp,48
 260:	8082                	ret

0000000000000262 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 262:	1141                	addi	sp,sp,-16
 264:	e406                	sd	ra,8(sp)
 266:	e022                	sd	s0,0(sp)
 268:	0800                	addi	s0,sp,16
  extern int main();
  main();
 26a:	00000097          	auipc	ra,0x0
 26e:	d96080e7          	jalr	-618(ra) # 0 <main>
  exit(0);
 272:	4501                	li	a0,0
 274:	00000097          	auipc	ra,0x0
 278:	49a080e7          	jalr	1178(ra) # 70e <exit>

000000000000027c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 27c:	7179                	addi	sp,sp,-48
 27e:	f422                	sd	s0,40(sp)
 280:	1800                	addi	s0,sp,48
 282:	fca43c23          	sd	a0,-40(s0)
 286:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 28a:	fd843783          	ld	a5,-40(s0)
 28e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 292:	0001                	nop
 294:	fd043703          	ld	a4,-48(s0)
 298:	00170793          	addi	a5,a4,1
 29c:	fcf43823          	sd	a5,-48(s0)
 2a0:	fd843783          	ld	a5,-40(s0)
 2a4:	00178693          	addi	a3,a5,1
 2a8:	fcd43c23          	sd	a3,-40(s0)
 2ac:	00074703          	lbu	a4,0(a4)
 2b0:	00e78023          	sb	a4,0(a5)
 2b4:	0007c783          	lbu	a5,0(a5)
 2b8:	fff1                	bnez	a5,294 <strcpy+0x18>
    ;
  return os;
 2ba:	fe843783          	ld	a5,-24(s0)
}
 2be:	853e                	mv	a0,a5
 2c0:	7422                	ld	s0,40(sp)
 2c2:	6145                	addi	sp,sp,48
 2c4:	8082                	ret

00000000000002c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c6:	1101                	addi	sp,sp,-32
 2c8:	ec22                	sd	s0,24(sp)
 2ca:	1000                	addi	s0,sp,32
 2cc:	fea43423          	sd	a0,-24(s0)
 2d0:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 2d4:	a819                	j	2ea <strcmp+0x24>
    p++, q++;
 2d6:	fe843783          	ld	a5,-24(s0)
 2da:	0785                	addi	a5,a5,1
 2dc:	fef43423          	sd	a5,-24(s0)
 2e0:	fe043783          	ld	a5,-32(s0)
 2e4:	0785                	addi	a5,a5,1
 2e6:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 2ea:	fe843783          	ld	a5,-24(s0)
 2ee:	0007c783          	lbu	a5,0(a5)
 2f2:	cb99                	beqz	a5,308 <strcmp+0x42>
 2f4:	fe843783          	ld	a5,-24(s0)
 2f8:	0007c703          	lbu	a4,0(a5)
 2fc:	fe043783          	ld	a5,-32(s0)
 300:	0007c783          	lbu	a5,0(a5)
 304:	fcf709e3          	beq	a4,a5,2d6 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 308:	fe843783          	ld	a5,-24(s0)
 30c:	0007c783          	lbu	a5,0(a5)
 310:	0007871b          	sext.w	a4,a5
 314:	fe043783          	ld	a5,-32(s0)
 318:	0007c783          	lbu	a5,0(a5)
 31c:	2781                	sext.w	a5,a5
 31e:	40f707bb          	subw	a5,a4,a5
 322:	2781                	sext.w	a5,a5
}
 324:	853e                	mv	a0,a5
 326:	6462                	ld	s0,24(sp)
 328:	6105                	addi	sp,sp,32
 32a:	8082                	ret

000000000000032c <strlen>:

uint
strlen(const char *s)
{
 32c:	7179                	addi	sp,sp,-48
 32e:	f422                	sd	s0,40(sp)
 330:	1800                	addi	s0,sp,48
 332:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 336:	fe042623          	sw	zero,-20(s0)
 33a:	a031                	j	346 <strlen+0x1a>
 33c:	fec42783          	lw	a5,-20(s0)
 340:	2785                	addiw	a5,a5,1
 342:	fef42623          	sw	a5,-20(s0)
 346:	fec42783          	lw	a5,-20(s0)
 34a:	fd843703          	ld	a4,-40(s0)
 34e:	97ba                	add	a5,a5,a4
 350:	0007c783          	lbu	a5,0(a5)
 354:	f7e5                	bnez	a5,33c <strlen+0x10>
    ;
  return n;
 356:	fec42783          	lw	a5,-20(s0)
}
 35a:	853e                	mv	a0,a5
 35c:	7422                	ld	s0,40(sp)
 35e:	6145                	addi	sp,sp,48
 360:	8082                	ret

0000000000000362 <memset>:

void*
memset(void *dst, int c, uint n)
{
 362:	7179                	addi	sp,sp,-48
 364:	f422                	sd	s0,40(sp)
 366:	1800                	addi	s0,sp,48
 368:	fca43c23          	sd	a0,-40(s0)
 36c:	87ae                	mv	a5,a1
 36e:	8732                	mv	a4,a2
 370:	fcf42a23          	sw	a5,-44(s0)
 374:	87ba                	mv	a5,a4
 376:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 37a:	fd843783          	ld	a5,-40(s0)
 37e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 382:	fe042623          	sw	zero,-20(s0)
 386:	a00d                	j	3a8 <memset+0x46>
    cdst[i] = c;
 388:	fec42783          	lw	a5,-20(s0)
 38c:	fe043703          	ld	a4,-32(s0)
 390:	97ba                	add	a5,a5,a4
 392:	fd442703          	lw	a4,-44(s0)
 396:	0ff77713          	zext.b	a4,a4
 39a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 39e:	fec42783          	lw	a5,-20(s0)
 3a2:	2785                	addiw	a5,a5,1
 3a4:	fef42623          	sw	a5,-20(s0)
 3a8:	fec42703          	lw	a4,-20(s0)
 3ac:	fd042783          	lw	a5,-48(s0)
 3b0:	2781                	sext.w	a5,a5
 3b2:	fcf76be3          	bltu	a4,a5,388 <memset+0x26>
  }
  return dst;
 3b6:	fd843783          	ld	a5,-40(s0)
}
 3ba:	853e                	mv	a0,a5
 3bc:	7422                	ld	s0,40(sp)
 3be:	6145                	addi	sp,sp,48
 3c0:	8082                	ret

00000000000003c2 <strchr>:

char*
strchr(const char *s, char c)
{
 3c2:	1101                	addi	sp,sp,-32
 3c4:	ec22                	sd	s0,24(sp)
 3c6:	1000                	addi	s0,sp,32
 3c8:	fea43423          	sd	a0,-24(s0)
 3cc:	87ae                	mv	a5,a1
 3ce:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 3d2:	a01d                	j	3f8 <strchr+0x36>
    if(*s == c)
 3d4:	fe843783          	ld	a5,-24(s0)
 3d8:	0007c703          	lbu	a4,0(a5)
 3dc:	fe744783          	lbu	a5,-25(s0)
 3e0:	0ff7f793          	zext.b	a5,a5
 3e4:	00e79563          	bne	a5,a4,3ee <strchr+0x2c>
      return (char*)s;
 3e8:	fe843783          	ld	a5,-24(s0)
 3ec:	a821                	j	404 <strchr+0x42>
  for(; *s; s++)
 3ee:	fe843783          	ld	a5,-24(s0)
 3f2:	0785                	addi	a5,a5,1
 3f4:	fef43423          	sd	a5,-24(s0)
 3f8:	fe843783          	ld	a5,-24(s0)
 3fc:	0007c783          	lbu	a5,0(a5)
 400:	fbf1                	bnez	a5,3d4 <strchr+0x12>
  return 0;
 402:	4781                	li	a5,0
}
 404:	853e                	mv	a0,a5
 406:	6462                	ld	s0,24(sp)
 408:	6105                	addi	sp,sp,32
 40a:	8082                	ret

000000000000040c <gets>:

char*
gets(char *buf, int max)
{
 40c:	7179                	addi	sp,sp,-48
 40e:	f406                	sd	ra,40(sp)
 410:	f022                	sd	s0,32(sp)
 412:	1800                	addi	s0,sp,48
 414:	fca43c23          	sd	a0,-40(s0)
 418:	87ae                	mv	a5,a1
 41a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 41e:	fe042623          	sw	zero,-20(s0)
 422:	a8a1                	j	47a <gets+0x6e>
    cc = read(0, &c, 1);
 424:	fe740793          	addi	a5,s0,-25
 428:	4605                	li	a2,1
 42a:	85be                	mv	a1,a5
 42c:	4501                	li	a0,0
 42e:	00000097          	auipc	ra,0x0
 432:	2f8080e7          	jalr	760(ra) # 726 <read>
 436:	87aa                	mv	a5,a0
 438:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 43c:	fe842783          	lw	a5,-24(s0)
 440:	2781                	sext.w	a5,a5
 442:	04f05763          	blez	a5,490 <gets+0x84>
      break;
    buf[i++] = c;
 446:	fec42783          	lw	a5,-20(s0)
 44a:	0017871b          	addiw	a4,a5,1
 44e:	fee42623          	sw	a4,-20(s0)
 452:	873e                	mv	a4,a5
 454:	fd843783          	ld	a5,-40(s0)
 458:	97ba                	add	a5,a5,a4
 45a:	fe744703          	lbu	a4,-25(s0)
 45e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 462:	fe744783          	lbu	a5,-25(s0)
 466:	873e                	mv	a4,a5
 468:	47a9                	li	a5,10
 46a:	02f70463          	beq	a4,a5,492 <gets+0x86>
 46e:	fe744783          	lbu	a5,-25(s0)
 472:	873e                	mv	a4,a5
 474:	47b5                	li	a5,13
 476:	00f70e63          	beq	a4,a5,492 <gets+0x86>
  for(i=0; i+1 < max; ){
 47a:	fec42783          	lw	a5,-20(s0)
 47e:	2785                	addiw	a5,a5,1
 480:	0007871b          	sext.w	a4,a5
 484:	fd442783          	lw	a5,-44(s0)
 488:	2781                	sext.w	a5,a5
 48a:	f8f74de3          	blt	a4,a5,424 <gets+0x18>
 48e:	a011                	j	492 <gets+0x86>
      break;
 490:	0001                	nop
      break;
  }
  buf[i] = '\0';
 492:	fec42783          	lw	a5,-20(s0)
 496:	fd843703          	ld	a4,-40(s0)
 49a:	97ba                	add	a5,a5,a4
 49c:	00078023          	sb	zero,0(a5)
  return buf;
 4a0:	fd843783          	ld	a5,-40(s0)
}
 4a4:	853e                	mv	a0,a5
 4a6:	70a2                	ld	ra,40(sp)
 4a8:	7402                	ld	s0,32(sp)
 4aa:	6145                	addi	sp,sp,48
 4ac:	8082                	ret

00000000000004ae <stat>:

int
stat(const char *n, struct stat *st)
{
 4ae:	7179                	addi	sp,sp,-48
 4b0:	f406                	sd	ra,40(sp)
 4b2:	f022                	sd	s0,32(sp)
 4b4:	1800                	addi	s0,sp,48
 4b6:	fca43c23          	sd	a0,-40(s0)
 4ba:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4be:	4581                	li	a1,0
 4c0:	fd843503          	ld	a0,-40(s0)
 4c4:	00000097          	auipc	ra,0x0
 4c8:	28a080e7          	jalr	650(ra) # 74e <open>
 4cc:	87aa                	mv	a5,a0
 4ce:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 4d2:	fec42783          	lw	a5,-20(s0)
 4d6:	2781                	sext.w	a5,a5
 4d8:	0007d463          	bgez	a5,4e0 <stat+0x32>
    return -1;
 4dc:	57fd                	li	a5,-1
 4de:	a035                	j	50a <stat+0x5c>
  r = fstat(fd, st);
 4e0:	fec42783          	lw	a5,-20(s0)
 4e4:	fd043583          	ld	a1,-48(s0)
 4e8:	853e                	mv	a0,a5
 4ea:	00000097          	auipc	ra,0x0
 4ee:	27c080e7          	jalr	636(ra) # 766 <fstat>
 4f2:	87aa                	mv	a5,a0
 4f4:	fef42423          	sw	a5,-24(s0)
  close(fd);
 4f8:	fec42783          	lw	a5,-20(s0)
 4fc:	853e                	mv	a0,a5
 4fe:	00000097          	auipc	ra,0x0
 502:	238080e7          	jalr	568(ra) # 736 <close>
  return r;
 506:	fe842783          	lw	a5,-24(s0)
}
 50a:	853e                	mv	a0,a5
 50c:	70a2                	ld	ra,40(sp)
 50e:	7402                	ld	s0,32(sp)
 510:	6145                	addi	sp,sp,48
 512:	8082                	ret

0000000000000514 <atoi>:

int
atoi(const char *s)
{
 514:	7179                	addi	sp,sp,-48
 516:	f422                	sd	s0,40(sp)
 518:	1800                	addi	s0,sp,48
 51a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 51e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 522:	a81d                	j	558 <atoi+0x44>
    n = n*10 + *s++ - '0';
 524:	fec42783          	lw	a5,-20(s0)
 528:	873e                	mv	a4,a5
 52a:	87ba                	mv	a5,a4
 52c:	0027979b          	slliw	a5,a5,0x2
 530:	9fb9                	addw	a5,a5,a4
 532:	0017979b          	slliw	a5,a5,0x1
 536:	0007871b          	sext.w	a4,a5
 53a:	fd843783          	ld	a5,-40(s0)
 53e:	00178693          	addi	a3,a5,1
 542:	fcd43c23          	sd	a3,-40(s0)
 546:	0007c783          	lbu	a5,0(a5)
 54a:	2781                	sext.w	a5,a5
 54c:	9fb9                	addw	a5,a5,a4
 54e:	2781                	sext.w	a5,a5
 550:	fd07879b          	addiw	a5,a5,-48
 554:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 558:	fd843783          	ld	a5,-40(s0)
 55c:	0007c783          	lbu	a5,0(a5)
 560:	873e                	mv	a4,a5
 562:	02f00793          	li	a5,47
 566:	00e7fb63          	bgeu	a5,a4,57c <atoi+0x68>
 56a:	fd843783          	ld	a5,-40(s0)
 56e:	0007c783          	lbu	a5,0(a5)
 572:	873e                	mv	a4,a5
 574:	03900793          	li	a5,57
 578:	fae7f6e3          	bgeu	a5,a4,524 <atoi+0x10>
  return n;
 57c:	fec42783          	lw	a5,-20(s0)
}
 580:	853e                	mv	a0,a5
 582:	7422                	ld	s0,40(sp)
 584:	6145                	addi	sp,sp,48
 586:	8082                	ret

0000000000000588 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 588:	7139                	addi	sp,sp,-64
 58a:	fc22                	sd	s0,56(sp)
 58c:	0080                	addi	s0,sp,64
 58e:	fca43c23          	sd	a0,-40(s0)
 592:	fcb43823          	sd	a1,-48(s0)
 596:	87b2                	mv	a5,a2
 598:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 59c:	fd843783          	ld	a5,-40(s0)
 5a0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 5a4:	fd043783          	ld	a5,-48(s0)
 5a8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 5ac:	fe043703          	ld	a4,-32(s0)
 5b0:	fe843783          	ld	a5,-24(s0)
 5b4:	02e7fc63          	bgeu	a5,a4,5ec <memmove+0x64>
    while(n-- > 0)
 5b8:	a00d                	j	5da <memmove+0x52>
      *dst++ = *src++;
 5ba:	fe043703          	ld	a4,-32(s0)
 5be:	00170793          	addi	a5,a4,1
 5c2:	fef43023          	sd	a5,-32(s0)
 5c6:	fe843783          	ld	a5,-24(s0)
 5ca:	00178693          	addi	a3,a5,1
 5ce:	fed43423          	sd	a3,-24(s0)
 5d2:	00074703          	lbu	a4,0(a4)
 5d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 5da:	fcc42783          	lw	a5,-52(s0)
 5de:	fff7871b          	addiw	a4,a5,-1
 5e2:	fce42623          	sw	a4,-52(s0)
 5e6:	fcf04ae3          	bgtz	a5,5ba <memmove+0x32>
 5ea:	a891                	j	63e <memmove+0xb6>
  } else {
    dst += n;
 5ec:	fcc42783          	lw	a5,-52(s0)
 5f0:	fe843703          	ld	a4,-24(s0)
 5f4:	97ba                	add	a5,a5,a4
 5f6:	fef43423          	sd	a5,-24(s0)
    src += n;
 5fa:	fcc42783          	lw	a5,-52(s0)
 5fe:	fe043703          	ld	a4,-32(s0)
 602:	97ba                	add	a5,a5,a4
 604:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 608:	a01d                	j	62e <memmove+0xa6>
      *--dst = *--src;
 60a:	fe043783          	ld	a5,-32(s0)
 60e:	17fd                	addi	a5,a5,-1
 610:	fef43023          	sd	a5,-32(s0)
 614:	fe843783          	ld	a5,-24(s0)
 618:	17fd                	addi	a5,a5,-1
 61a:	fef43423          	sd	a5,-24(s0)
 61e:	fe043783          	ld	a5,-32(s0)
 622:	0007c703          	lbu	a4,0(a5)
 626:	fe843783          	ld	a5,-24(s0)
 62a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 62e:	fcc42783          	lw	a5,-52(s0)
 632:	fff7871b          	addiw	a4,a5,-1
 636:	fce42623          	sw	a4,-52(s0)
 63a:	fcf048e3          	bgtz	a5,60a <memmove+0x82>
  }
  return vdst;
 63e:	fd843783          	ld	a5,-40(s0)
}
 642:	853e                	mv	a0,a5
 644:	7462                	ld	s0,56(sp)
 646:	6121                	addi	sp,sp,64
 648:	8082                	ret

000000000000064a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 64a:	7139                	addi	sp,sp,-64
 64c:	fc22                	sd	s0,56(sp)
 64e:	0080                	addi	s0,sp,64
 650:	fca43c23          	sd	a0,-40(s0)
 654:	fcb43823          	sd	a1,-48(s0)
 658:	87b2                	mv	a5,a2
 65a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 65e:	fd843783          	ld	a5,-40(s0)
 662:	fef43423          	sd	a5,-24(s0)
 666:	fd043783          	ld	a5,-48(s0)
 66a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 66e:	a0a1                	j	6b6 <memcmp+0x6c>
    if (*p1 != *p2) {
 670:	fe843783          	ld	a5,-24(s0)
 674:	0007c703          	lbu	a4,0(a5)
 678:	fe043783          	ld	a5,-32(s0)
 67c:	0007c783          	lbu	a5,0(a5)
 680:	02f70163          	beq	a4,a5,6a2 <memcmp+0x58>
      return *p1 - *p2;
 684:	fe843783          	ld	a5,-24(s0)
 688:	0007c783          	lbu	a5,0(a5)
 68c:	0007871b          	sext.w	a4,a5
 690:	fe043783          	ld	a5,-32(s0)
 694:	0007c783          	lbu	a5,0(a5)
 698:	2781                	sext.w	a5,a5
 69a:	40f707bb          	subw	a5,a4,a5
 69e:	2781                	sext.w	a5,a5
 6a0:	a01d                	j	6c6 <memcmp+0x7c>
    }
    p1++;
 6a2:	fe843783          	ld	a5,-24(s0)
 6a6:	0785                	addi	a5,a5,1
 6a8:	fef43423          	sd	a5,-24(s0)
    p2++;
 6ac:	fe043783          	ld	a5,-32(s0)
 6b0:	0785                	addi	a5,a5,1
 6b2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 6b6:	fcc42783          	lw	a5,-52(s0)
 6ba:	fff7871b          	addiw	a4,a5,-1
 6be:	fce42623          	sw	a4,-52(s0)
 6c2:	f7dd                	bnez	a5,670 <memcmp+0x26>
  }
  return 0;
 6c4:	4781                	li	a5,0
}
 6c6:	853e                	mv	a0,a5
 6c8:	7462                	ld	s0,56(sp)
 6ca:	6121                	addi	sp,sp,64
 6cc:	8082                	ret

00000000000006ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6ce:	7179                	addi	sp,sp,-48
 6d0:	f406                	sd	ra,40(sp)
 6d2:	f022                	sd	s0,32(sp)
 6d4:	1800                	addi	s0,sp,48
 6d6:	fea43423          	sd	a0,-24(s0)
 6da:	feb43023          	sd	a1,-32(s0)
 6de:	87b2                	mv	a5,a2
 6e0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 6e4:	fdc42783          	lw	a5,-36(s0)
 6e8:	863e                	mv	a2,a5
 6ea:	fe043583          	ld	a1,-32(s0)
 6ee:	fe843503          	ld	a0,-24(s0)
 6f2:	00000097          	auipc	ra,0x0
 6f6:	e96080e7          	jalr	-362(ra) # 588 <memmove>
 6fa:	87aa                	mv	a5,a0
}
 6fc:	853e                	mv	a0,a5
 6fe:	70a2                	ld	ra,40(sp)
 700:	7402                	ld	s0,32(sp)
 702:	6145                	addi	sp,sp,48
 704:	8082                	ret

0000000000000706 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 706:	4885                	li	a7,1
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <exit>:
.global exit
exit:
 li a7, SYS_exit
 70e:	4889                	li	a7,2
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <wait>:
.global wait
wait:
 li a7, SYS_wait
 716:	488d                	li	a7,3
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 71e:	4891                	li	a7,4
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <read>:
.global read
read:
 li a7, SYS_read
 726:	4895                	li	a7,5
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <write>:
.global write
write:
 li a7, SYS_write
 72e:	48c1                	li	a7,16
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <close>:
.global close
close:
 li a7, SYS_close
 736:	48d5                	li	a7,21
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <kill>:
.global kill
kill:
 li a7, SYS_kill
 73e:	4899                	li	a7,6
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <exec>:
.global exec
exec:
 li a7, SYS_exec
 746:	489d                	li	a7,7
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <open>:
.global open
open:
 li a7, SYS_open
 74e:	48bd                	li	a7,15
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 756:	48c5                	li	a7,17
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 75e:	48c9                	li	a7,18
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 766:	48a1                	li	a7,8
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <link>:
.global link
link:
 li a7, SYS_link
 76e:	48cd                	li	a7,19
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 776:	48d1                	li	a7,20
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 77e:	48a5                	li	a7,9
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <dup>:
.global dup
dup:
 li a7, SYS_dup
 786:	48a9                	li	a7,10
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 78e:	48ad                	li	a7,11
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 796:	48b1                	li	a7,12
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 79e:	48b5                	li	a7,13
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7a6:	48b9                	li	a7,14
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
 7ae:	48d9                	li	a7,22
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
 7b6:	48dd                	li	a7,23
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
 7be:	48e1                	li	a7,24
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
 7c6:	48e5                	li	a7,25
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
 7ce:	48e9                	li	a7,26
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
 7d6:	48ed                	li	a7,27
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
 7de:	48f1                	li	a7,28
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7e6:	1101                	addi	sp,sp,-32
 7e8:	ec06                	sd	ra,24(sp)
 7ea:	e822                	sd	s0,16(sp)
 7ec:	1000                	addi	s0,sp,32
 7ee:	87aa                	mv	a5,a0
 7f0:	872e                	mv	a4,a1
 7f2:	fef42623          	sw	a5,-20(s0)
 7f6:	87ba                	mv	a5,a4
 7f8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 7fc:	feb40713          	addi	a4,s0,-21
 800:	fec42783          	lw	a5,-20(s0)
 804:	4605                	li	a2,1
 806:	85ba                	mv	a1,a4
 808:	853e                	mv	a0,a5
 80a:	00000097          	auipc	ra,0x0
 80e:	f24080e7          	jalr	-220(ra) # 72e <write>
}
 812:	0001                	nop
 814:	60e2                	ld	ra,24(sp)
 816:	6442                	ld	s0,16(sp)
 818:	6105                	addi	sp,sp,32
 81a:	8082                	ret

000000000000081c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 81c:	7139                	addi	sp,sp,-64
 81e:	fc06                	sd	ra,56(sp)
 820:	f822                	sd	s0,48(sp)
 822:	0080                	addi	s0,sp,64
 824:	87aa                	mv	a5,a0
 826:	8736                	mv	a4,a3
 828:	fcf42623          	sw	a5,-52(s0)
 82c:	87ae                	mv	a5,a1
 82e:	fcf42423          	sw	a5,-56(s0)
 832:	87b2                	mv	a5,a2
 834:	fcf42223          	sw	a5,-60(s0)
 838:	87ba                	mv	a5,a4
 83a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 83e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 842:	fc042783          	lw	a5,-64(s0)
 846:	2781                	sext.w	a5,a5
 848:	c38d                	beqz	a5,86a <printint+0x4e>
 84a:	fc842783          	lw	a5,-56(s0)
 84e:	2781                	sext.w	a5,a5
 850:	0007dd63          	bgez	a5,86a <printint+0x4e>
    neg = 1;
 854:	4785                	li	a5,1
 856:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 85a:	fc842783          	lw	a5,-56(s0)
 85e:	40f007bb          	negw	a5,a5
 862:	2781                	sext.w	a5,a5
 864:	fef42223          	sw	a5,-28(s0)
 868:	a029                	j	872 <printint+0x56>
  } else {
    x = xx;
 86a:	fc842783          	lw	a5,-56(s0)
 86e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 872:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 876:	fc442783          	lw	a5,-60(s0)
 87a:	fe442703          	lw	a4,-28(s0)
 87e:	02f777bb          	remuw	a5,a4,a5
 882:	0007861b          	sext.w	a2,a5
 886:	fec42783          	lw	a5,-20(s0)
 88a:	0017871b          	addiw	a4,a5,1
 88e:	fee42623          	sw	a4,-20(s0)
 892:	00002697          	auipc	a3,0x2
 896:	afe68693          	addi	a3,a3,-1282 # 2390 <digits>
 89a:	02061713          	slli	a4,a2,0x20
 89e:	9301                	srli	a4,a4,0x20
 8a0:	9736                	add	a4,a4,a3
 8a2:	00074703          	lbu	a4,0(a4)
 8a6:	17c1                	addi	a5,a5,-16
 8a8:	97a2                	add	a5,a5,s0
 8aa:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 8ae:	fc442783          	lw	a5,-60(s0)
 8b2:	fe442703          	lw	a4,-28(s0)
 8b6:	02f757bb          	divuw	a5,a4,a5
 8ba:	fef42223          	sw	a5,-28(s0)
 8be:	fe442783          	lw	a5,-28(s0)
 8c2:	2781                	sext.w	a5,a5
 8c4:	fbcd                	bnez	a5,876 <printint+0x5a>
  if(neg)
 8c6:	fe842783          	lw	a5,-24(s0)
 8ca:	2781                	sext.w	a5,a5
 8cc:	cf85                	beqz	a5,904 <printint+0xe8>
    buf[i++] = '-';
 8ce:	fec42783          	lw	a5,-20(s0)
 8d2:	0017871b          	addiw	a4,a5,1
 8d6:	fee42623          	sw	a4,-20(s0)
 8da:	17c1                	addi	a5,a5,-16
 8dc:	97a2                	add	a5,a5,s0
 8de:	02d00713          	li	a4,45
 8e2:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 8e6:	a839                	j	904 <printint+0xe8>
    putc(fd, buf[i]);
 8e8:	fec42783          	lw	a5,-20(s0)
 8ec:	17c1                	addi	a5,a5,-16
 8ee:	97a2                	add	a5,a5,s0
 8f0:	fe07c703          	lbu	a4,-32(a5)
 8f4:	fcc42783          	lw	a5,-52(s0)
 8f8:	85ba                	mv	a1,a4
 8fa:	853e                	mv	a0,a5
 8fc:	00000097          	auipc	ra,0x0
 900:	eea080e7          	jalr	-278(ra) # 7e6 <putc>
  while(--i >= 0)
 904:	fec42783          	lw	a5,-20(s0)
 908:	37fd                	addiw	a5,a5,-1
 90a:	fef42623          	sw	a5,-20(s0)
 90e:	fec42783          	lw	a5,-20(s0)
 912:	2781                	sext.w	a5,a5
 914:	fc07dae3          	bgez	a5,8e8 <printint+0xcc>
}
 918:	0001                	nop
 91a:	0001                	nop
 91c:	70e2                	ld	ra,56(sp)
 91e:	7442                	ld	s0,48(sp)
 920:	6121                	addi	sp,sp,64
 922:	8082                	ret

0000000000000924 <printptr>:

static void
printptr(int fd, uint64 x) {
 924:	7179                	addi	sp,sp,-48
 926:	f406                	sd	ra,40(sp)
 928:	f022                	sd	s0,32(sp)
 92a:	1800                	addi	s0,sp,48
 92c:	87aa                	mv	a5,a0
 92e:	fcb43823          	sd	a1,-48(s0)
 932:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 936:	fdc42783          	lw	a5,-36(s0)
 93a:	03000593          	li	a1,48
 93e:	853e                	mv	a0,a5
 940:	00000097          	auipc	ra,0x0
 944:	ea6080e7          	jalr	-346(ra) # 7e6 <putc>
  putc(fd, 'x');
 948:	fdc42783          	lw	a5,-36(s0)
 94c:	07800593          	li	a1,120
 950:	853e                	mv	a0,a5
 952:	00000097          	auipc	ra,0x0
 956:	e94080e7          	jalr	-364(ra) # 7e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 95a:	fe042623          	sw	zero,-20(s0)
 95e:	a82d                	j	998 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 960:	fd043783          	ld	a5,-48(s0)
 964:	93f1                	srli	a5,a5,0x3c
 966:	00002717          	auipc	a4,0x2
 96a:	a2a70713          	addi	a4,a4,-1494 # 2390 <digits>
 96e:	97ba                	add	a5,a5,a4
 970:	0007c703          	lbu	a4,0(a5)
 974:	fdc42783          	lw	a5,-36(s0)
 978:	85ba                	mv	a1,a4
 97a:	853e                	mv	a0,a5
 97c:	00000097          	auipc	ra,0x0
 980:	e6a080e7          	jalr	-406(ra) # 7e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 984:	fec42783          	lw	a5,-20(s0)
 988:	2785                	addiw	a5,a5,1
 98a:	fef42623          	sw	a5,-20(s0)
 98e:	fd043783          	ld	a5,-48(s0)
 992:	0792                	slli	a5,a5,0x4
 994:	fcf43823          	sd	a5,-48(s0)
 998:	fec42783          	lw	a5,-20(s0)
 99c:	873e                	mv	a4,a5
 99e:	47bd                	li	a5,15
 9a0:	fce7f0e3          	bgeu	a5,a4,960 <printptr+0x3c>
}
 9a4:	0001                	nop
 9a6:	0001                	nop
 9a8:	70a2                	ld	ra,40(sp)
 9aa:	7402                	ld	s0,32(sp)
 9ac:	6145                	addi	sp,sp,48
 9ae:	8082                	ret

00000000000009b0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 9b0:	715d                	addi	sp,sp,-80
 9b2:	e486                	sd	ra,72(sp)
 9b4:	e0a2                	sd	s0,64(sp)
 9b6:	0880                	addi	s0,sp,80
 9b8:	87aa                	mv	a5,a0
 9ba:	fcb43023          	sd	a1,-64(s0)
 9be:	fac43c23          	sd	a2,-72(s0)
 9c2:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 9c6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9ca:	fe042223          	sw	zero,-28(s0)
 9ce:	a42d                	j	bf8 <vprintf+0x248>
    c = fmt[i] & 0xff;
 9d0:	fe442783          	lw	a5,-28(s0)
 9d4:	fc043703          	ld	a4,-64(s0)
 9d8:	97ba                	add	a5,a5,a4
 9da:	0007c783          	lbu	a5,0(a5)
 9de:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 9e2:	fe042783          	lw	a5,-32(s0)
 9e6:	2781                	sext.w	a5,a5
 9e8:	eb9d                	bnez	a5,a1e <vprintf+0x6e>
      if(c == '%'){
 9ea:	fdc42783          	lw	a5,-36(s0)
 9ee:	0007871b          	sext.w	a4,a5
 9f2:	02500793          	li	a5,37
 9f6:	00f71763          	bne	a4,a5,a04 <vprintf+0x54>
        state = '%';
 9fa:	02500793          	li	a5,37
 9fe:	fef42023          	sw	a5,-32(s0)
 a02:	a2f5                	j	bee <vprintf+0x23e>
      } else {
        putc(fd, c);
 a04:	fdc42783          	lw	a5,-36(s0)
 a08:	0ff7f713          	zext.b	a4,a5
 a0c:	fcc42783          	lw	a5,-52(s0)
 a10:	85ba                	mv	a1,a4
 a12:	853e                	mv	a0,a5
 a14:	00000097          	auipc	ra,0x0
 a18:	dd2080e7          	jalr	-558(ra) # 7e6 <putc>
 a1c:	aac9                	j	bee <vprintf+0x23e>
      }
    } else if(state == '%'){
 a1e:	fe042783          	lw	a5,-32(s0)
 a22:	0007871b          	sext.w	a4,a5
 a26:	02500793          	li	a5,37
 a2a:	1cf71263          	bne	a4,a5,bee <vprintf+0x23e>
      if(c == 'd'){
 a2e:	fdc42783          	lw	a5,-36(s0)
 a32:	0007871b          	sext.w	a4,a5
 a36:	06400793          	li	a5,100
 a3a:	02f71463          	bne	a4,a5,a62 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 a3e:	fb843783          	ld	a5,-72(s0)
 a42:	00878713          	addi	a4,a5,8
 a46:	fae43c23          	sd	a4,-72(s0)
 a4a:	4398                	lw	a4,0(a5)
 a4c:	fcc42783          	lw	a5,-52(s0)
 a50:	4685                	li	a3,1
 a52:	4629                	li	a2,10
 a54:	85ba                	mv	a1,a4
 a56:	853e                	mv	a0,a5
 a58:	00000097          	auipc	ra,0x0
 a5c:	dc4080e7          	jalr	-572(ra) # 81c <printint>
 a60:	a269                	j	bea <vprintf+0x23a>
      } else if(c == 'l') {
 a62:	fdc42783          	lw	a5,-36(s0)
 a66:	0007871b          	sext.w	a4,a5
 a6a:	06c00793          	li	a5,108
 a6e:	02f71663          	bne	a4,a5,a9a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a72:	fb843783          	ld	a5,-72(s0)
 a76:	00878713          	addi	a4,a5,8
 a7a:	fae43c23          	sd	a4,-72(s0)
 a7e:	639c                	ld	a5,0(a5)
 a80:	0007871b          	sext.w	a4,a5
 a84:	fcc42783          	lw	a5,-52(s0)
 a88:	4681                	li	a3,0
 a8a:	4629                	li	a2,10
 a8c:	85ba                	mv	a1,a4
 a8e:	853e                	mv	a0,a5
 a90:	00000097          	auipc	ra,0x0
 a94:	d8c080e7          	jalr	-628(ra) # 81c <printint>
 a98:	aa89                	j	bea <vprintf+0x23a>
      } else if(c == 'x') {
 a9a:	fdc42783          	lw	a5,-36(s0)
 a9e:	0007871b          	sext.w	a4,a5
 aa2:	07800793          	li	a5,120
 aa6:	02f71463          	bne	a4,a5,ace <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 aaa:	fb843783          	ld	a5,-72(s0)
 aae:	00878713          	addi	a4,a5,8
 ab2:	fae43c23          	sd	a4,-72(s0)
 ab6:	4398                	lw	a4,0(a5)
 ab8:	fcc42783          	lw	a5,-52(s0)
 abc:	4681                	li	a3,0
 abe:	4641                	li	a2,16
 ac0:	85ba                	mv	a1,a4
 ac2:	853e                	mv	a0,a5
 ac4:	00000097          	auipc	ra,0x0
 ac8:	d58080e7          	jalr	-680(ra) # 81c <printint>
 acc:	aa39                	j	bea <vprintf+0x23a>
      } else if(c == 'p') {
 ace:	fdc42783          	lw	a5,-36(s0)
 ad2:	0007871b          	sext.w	a4,a5
 ad6:	07000793          	li	a5,112
 ada:	02f71263          	bne	a4,a5,afe <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 ade:	fb843783          	ld	a5,-72(s0)
 ae2:	00878713          	addi	a4,a5,8
 ae6:	fae43c23          	sd	a4,-72(s0)
 aea:	6398                	ld	a4,0(a5)
 aec:	fcc42783          	lw	a5,-52(s0)
 af0:	85ba                	mv	a1,a4
 af2:	853e                	mv	a0,a5
 af4:	00000097          	auipc	ra,0x0
 af8:	e30080e7          	jalr	-464(ra) # 924 <printptr>
 afc:	a0fd                	j	bea <vprintf+0x23a>
      } else if(c == 's'){
 afe:	fdc42783          	lw	a5,-36(s0)
 b02:	0007871b          	sext.w	a4,a5
 b06:	07300793          	li	a5,115
 b0a:	04f71c63          	bne	a4,a5,b62 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 b0e:	fb843783          	ld	a5,-72(s0)
 b12:	00878713          	addi	a4,a5,8
 b16:	fae43c23          	sd	a4,-72(s0)
 b1a:	639c                	ld	a5,0(a5)
 b1c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 b20:	fe843783          	ld	a5,-24(s0)
 b24:	eb8d                	bnez	a5,b56 <vprintf+0x1a6>
          s = "(null)";
 b26:	00000797          	auipc	a5,0x0
 b2a:	50278793          	addi	a5,a5,1282 # 1028 <malloc+0x1c8>
 b2e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 b32:	a015                	j	b56 <vprintf+0x1a6>
          putc(fd, *s);
 b34:	fe843783          	ld	a5,-24(s0)
 b38:	0007c703          	lbu	a4,0(a5)
 b3c:	fcc42783          	lw	a5,-52(s0)
 b40:	85ba                	mv	a1,a4
 b42:	853e                	mv	a0,a5
 b44:	00000097          	auipc	ra,0x0
 b48:	ca2080e7          	jalr	-862(ra) # 7e6 <putc>
          s++;
 b4c:	fe843783          	ld	a5,-24(s0)
 b50:	0785                	addi	a5,a5,1
 b52:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 b56:	fe843783          	ld	a5,-24(s0)
 b5a:	0007c783          	lbu	a5,0(a5)
 b5e:	fbf9                	bnez	a5,b34 <vprintf+0x184>
 b60:	a069                	j	bea <vprintf+0x23a>
        }
      } else if(c == 'c'){
 b62:	fdc42783          	lw	a5,-36(s0)
 b66:	0007871b          	sext.w	a4,a5
 b6a:	06300793          	li	a5,99
 b6e:	02f71463          	bne	a4,a5,b96 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 b72:	fb843783          	ld	a5,-72(s0)
 b76:	00878713          	addi	a4,a5,8
 b7a:	fae43c23          	sd	a4,-72(s0)
 b7e:	439c                	lw	a5,0(a5)
 b80:	0ff7f713          	zext.b	a4,a5
 b84:	fcc42783          	lw	a5,-52(s0)
 b88:	85ba                	mv	a1,a4
 b8a:	853e                	mv	a0,a5
 b8c:	00000097          	auipc	ra,0x0
 b90:	c5a080e7          	jalr	-934(ra) # 7e6 <putc>
 b94:	a899                	j	bea <vprintf+0x23a>
      } else if(c == '%'){
 b96:	fdc42783          	lw	a5,-36(s0)
 b9a:	0007871b          	sext.w	a4,a5
 b9e:	02500793          	li	a5,37
 ba2:	00f71f63          	bne	a4,a5,bc0 <vprintf+0x210>
        putc(fd, c);
 ba6:	fdc42783          	lw	a5,-36(s0)
 baa:	0ff7f713          	zext.b	a4,a5
 bae:	fcc42783          	lw	a5,-52(s0)
 bb2:	85ba                	mv	a1,a4
 bb4:	853e                	mv	a0,a5
 bb6:	00000097          	auipc	ra,0x0
 bba:	c30080e7          	jalr	-976(ra) # 7e6 <putc>
 bbe:	a035                	j	bea <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bc0:	fcc42783          	lw	a5,-52(s0)
 bc4:	02500593          	li	a1,37
 bc8:	853e                	mv	a0,a5
 bca:	00000097          	auipc	ra,0x0
 bce:	c1c080e7          	jalr	-996(ra) # 7e6 <putc>
        putc(fd, c);
 bd2:	fdc42783          	lw	a5,-36(s0)
 bd6:	0ff7f713          	zext.b	a4,a5
 bda:	fcc42783          	lw	a5,-52(s0)
 bde:	85ba                	mv	a1,a4
 be0:	853e                	mv	a0,a5
 be2:	00000097          	auipc	ra,0x0
 be6:	c04080e7          	jalr	-1020(ra) # 7e6 <putc>
      }
      state = 0;
 bea:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 bee:	fe442783          	lw	a5,-28(s0)
 bf2:	2785                	addiw	a5,a5,1
 bf4:	fef42223          	sw	a5,-28(s0)
 bf8:	fe442783          	lw	a5,-28(s0)
 bfc:	fc043703          	ld	a4,-64(s0)
 c00:	97ba                	add	a5,a5,a4
 c02:	0007c783          	lbu	a5,0(a5)
 c06:	dc0795e3          	bnez	a5,9d0 <vprintf+0x20>
    }
  }
}
 c0a:	0001                	nop
 c0c:	0001                	nop
 c0e:	60a6                	ld	ra,72(sp)
 c10:	6406                	ld	s0,64(sp)
 c12:	6161                	addi	sp,sp,80
 c14:	8082                	ret

0000000000000c16 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c16:	7159                	addi	sp,sp,-112
 c18:	fc06                	sd	ra,56(sp)
 c1a:	f822                	sd	s0,48(sp)
 c1c:	0080                	addi	s0,sp,64
 c1e:	fcb43823          	sd	a1,-48(s0)
 c22:	e010                	sd	a2,0(s0)
 c24:	e414                	sd	a3,8(s0)
 c26:	e818                	sd	a4,16(s0)
 c28:	ec1c                	sd	a5,24(s0)
 c2a:	03043023          	sd	a6,32(s0)
 c2e:	03143423          	sd	a7,40(s0)
 c32:	87aa                	mv	a5,a0
 c34:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 c38:	03040793          	addi	a5,s0,48
 c3c:	fcf43423          	sd	a5,-56(s0)
 c40:	fc843783          	ld	a5,-56(s0)
 c44:	fd078793          	addi	a5,a5,-48
 c48:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 c4c:	fe843703          	ld	a4,-24(s0)
 c50:	fdc42783          	lw	a5,-36(s0)
 c54:	863a                	mv	a2,a4
 c56:	fd043583          	ld	a1,-48(s0)
 c5a:	853e                	mv	a0,a5
 c5c:	00000097          	auipc	ra,0x0
 c60:	d54080e7          	jalr	-684(ra) # 9b0 <vprintf>
}
 c64:	0001                	nop
 c66:	70e2                	ld	ra,56(sp)
 c68:	7442                	ld	s0,48(sp)
 c6a:	6165                	addi	sp,sp,112
 c6c:	8082                	ret

0000000000000c6e <printf>:

void
printf(const char *fmt, ...)
{
 c6e:	7159                	addi	sp,sp,-112
 c70:	f406                	sd	ra,40(sp)
 c72:	f022                	sd	s0,32(sp)
 c74:	1800                	addi	s0,sp,48
 c76:	fca43c23          	sd	a0,-40(s0)
 c7a:	e40c                	sd	a1,8(s0)
 c7c:	e810                	sd	a2,16(s0)
 c7e:	ec14                	sd	a3,24(s0)
 c80:	f018                	sd	a4,32(s0)
 c82:	f41c                	sd	a5,40(s0)
 c84:	03043823          	sd	a6,48(s0)
 c88:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c8c:	04040793          	addi	a5,s0,64
 c90:	fcf43823          	sd	a5,-48(s0)
 c94:	fd043783          	ld	a5,-48(s0)
 c98:	fc878793          	addi	a5,a5,-56
 c9c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 ca0:	fe843783          	ld	a5,-24(s0)
 ca4:	863e                	mv	a2,a5
 ca6:	fd843583          	ld	a1,-40(s0)
 caa:	4505                	li	a0,1
 cac:	00000097          	auipc	ra,0x0
 cb0:	d04080e7          	jalr	-764(ra) # 9b0 <vprintf>
}
 cb4:	0001                	nop
 cb6:	70a2                	ld	ra,40(sp)
 cb8:	7402                	ld	s0,32(sp)
 cba:	6165                	addi	sp,sp,112
 cbc:	8082                	ret

0000000000000cbe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 cbe:	7179                	addi	sp,sp,-48
 cc0:	f422                	sd	s0,40(sp)
 cc2:	1800                	addi	s0,sp,48
 cc4:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 cc8:	fd843783          	ld	a5,-40(s0)
 ccc:	17c1                	addi	a5,a5,-16
 cce:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cd2:	00001797          	auipc	a5,0x1
 cd6:	6ee78793          	addi	a5,a5,1774 # 23c0 <freep>
 cda:	639c                	ld	a5,0(a5)
 cdc:	fef43423          	sd	a5,-24(s0)
 ce0:	a815                	j	d14 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ce2:	fe843783          	ld	a5,-24(s0)
 ce6:	639c                	ld	a5,0(a5)
 ce8:	fe843703          	ld	a4,-24(s0)
 cec:	00f76f63          	bltu	a4,a5,d0a <free+0x4c>
 cf0:	fe043703          	ld	a4,-32(s0)
 cf4:	fe843783          	ld	a5,-24(s0)
 cf8:	02e7eb63          	bltu	a5,a4,d2e <free+0x70>
 cfc:	fe843783          	ld	a5,-24(s0)
 d00:	639c                	ld	a5,0(a5)
 d02:	fe043703          	ld	a4,-32(s0)
 d06:	02f76463          	bltu	a4,a5,d2e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d0a:	fe843783          	ld	a5,-24(s0)
 d0e:	639c                	ld	a5,0(a5)
 d10:	fef43423          	sd	a5,-24(s0)
 d14:	fe043703          	ld	a4,-32(s0)
 d18:	fe843783          	ld	a5,-24(s0)
 d1c:	fce7f3e3          	bgeu	a5,a4,ce2 <free+0x24>
 d20:	fe843783          	ld	a5,-24(s0)
 d24:	639c                	ld	a5,0(a5)
 d26:	fe043703          	ld	a4,-32(s0)
 d2a:	faf77ce3          	bgeu	a4,a5,ce2 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d2e:	fe043783          	ld	a5,-32(s0)
 d32:	479c                	lw	a5,8(a5)
 d34:	1782                	slli	a5,a5,0x20
 d36:	9381                	srli	a5,a5,0x20
 d38:	0792                	slli	a5,a5,0x4
 d3a:	fe043703          	ld	a4,-32(s0)
 d3e:	973e                	add	a4,a4,a5
 d40:	fe843783          	ld	a5,-24(s0)
 d44:	639c                	ld	a5,0(a5)
 d46:	02f71763          	bne	a4,a5,d74 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 d4a:	fe043783          	ld	a5,-32(s0)
 d4e:	4798                	lw	a4,8(a5)
 d50:	fe843783          	ld	a5,-24(s0)
 d54:	639c                	ld	a5,0(a5)
 d56:	479c                	lw	a5,8(a5)
 d58:	9fb9                	addw	a5,a5,a4
 d5a:	0007871b          	sext.w	a4,a5
 d5e:	fe043783          	ld	a5,-32(s0)
 d62:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 d64:	fe843783          	ld	a5,-24(s0)
 d68:	639c                	ld	a5,0(a5)
 d6a:	6398                	ld	a4,0(a5)
 d6c:	fe043783          	ld	a5,-32(s0)
 d70:	e398                	sd	a4,0(a5)
 d72:	a039                	j	d80 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 d74:	fe843783          	ld	a5,-24(s0)
 d78:	6398                	ld	a4,0(a5)
 d7a:	fe043783          	ld	a5,-32(s0)
 d7e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 d80:	fe843783          	ld	a5,-24(s0)
 d84:	479c                	lw	a5,8(a5)
 d86:	1782                	slli	a5,a5,0x20
 d88:	9381                	srli	a5,a5,0x20
 d8a:	0792                	slli	a5,a5,0x4
 d8c:	fe843703          	ld	a4,-24(s0)
 d90:	97ba                	add	a5,a5,a4
 d92:	fe043703          	ld	a4,-32(s0)
 d96:	02f71563          	bne	a4,a5,dc0 <free+0x102>
    p->s.size += bp->s.size;
 d9a:	fe843783          	ld	a5,-24(s0)
 d9e:	4798                	lw	a4,8(a5)
 da0:	fe043783          	ld	a5,-32(s0)
 da4:	479c                	lw	a5,8(a5)
 da6:	9fb9                	addw	a5,a5,a4
 da8:	0007871b          	sext.w	a4,a5
 dac:	fe843783          	ld	a5,-24(s0)
 db0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 db2:	fe043783          	ld	a5,-32(s0)
 db6:	6398                	ld	a4,0(a5)
 db8:	fe843783          	ld	a5,-24(s0)
 dbc:	e398                	sd	a4,0(a5)
 dbe:	a031                	j	dca <free+0x10c>
  } else
    p->s.ptr = bp;
 dc0:	fe843783          	ld	a5,-24(s0)
 dc4:	fe043703          	ld	a4,-32(s0)
 dc8:	e398                	sd	a4,0(a5)
  freep = p;
 dca:	00001797          	auipc	a5,0x1
 dce:	5f678793          	addi	a5,a5,1526 # 23c0 <freep>
 dd2:	fe843703          	ld	a4,-24(s0)
 dd6:	e398                	sd	a4,0(a5)
}
 dd8:	0001                	nop
 dda:	7422                	ld	s0,40(sp)
 ddc:	6145                	addi	sp,sp,48
 dde:	8082                	ret

0000000000000de0 <morecore>:

static Header*
morecore(uint nu)
{
 de0:	7179                	addi	sp,sp,-48
 de2:	f406                	sd	ra,40(sp)
 de4:	f022                	sd	s0,32(sp)
 de6:	1800                	addi	s0,sp,48
 de8:	87aa                	mv	a5,a0
 dea:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 dee:	fdc42783          	lw	a5,-36(s0)
 df2:	0007871b          	sext.w	a4,a5
 df6:	6785                	lui	a5,0x1
 df8:	00f77563          	bgeu	a4,a5,e02 <morecore+0x22>
    nu = 4096;
 dfc:	6785                	lui	a5,0x1
 dfe:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 e02:	fdc42783          	lw	a5,-36(s0)
 e06:	0047979b          	slliw	a5,a5,0x4
 e0a:	2781                	sext.w	a5,a5
 e0c:	2781                	sext.w	a5,a5
 e0e:	853e                	mv	a0,a5
 e10:	00000097          	auipc	ra,0x0
 e14:	986080e7          	jalr	-1658(ra) # 796 <sbrk>
 e18:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 e1c:	fe843703          	ld	a4,-24(s0)
 e20:	57fd                	li	a5,-1
 e22:	00f71463          	bne	a4,a5,e2a <morecore+0x4a>
    return 0;
 e26:	4781                	li	a5,0
 e28:	a03d                	j	e56 <morecore+0x76>
  hp = (Header*)p;
 e2a:	fe843783          	ld	a5,-24(s0)
 e2e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e32:	fe043783          	ld	a5,-32(s0)
 e36:	fdc42703          	lw	a4,-36(s0)
 e3a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e3c:	fe043783          	ld	a5,-32(s0)
 e40:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x1b0>
 e42:	853e                	mv	a0,a5
 e44:	00000097          	auipc	ra,0x0
 e48:	e7a080e7          	jalr	-390(ra) # cbe <free>
  return freep;
 e4c:	00001797          	auipc	a5,0x1
 e50:	57478793          	addi	a5,a5,1396 # 23c0 <freep>
 e54:	639c                	ld	a5,0(a5)
}
 e56:	853e                	mv	a0,a5
 e58:	70a2                	ld	ra,40(sp)
 e5a:	7402                	ld	s0,32(sp)
 e5c:	6145                	addi	sp,sp,48
 e5e:	8082                	ret

0000000000000e60 <malloc>:

void*
malloc(uint nbytes)
{
 e60:	7139                	addi	sp,sp,-64
 e62:	fc06                	sd	ra,56(sp)
 e64:	f822                	sd	s0,48(sp)
 e66:	0080                	addi	s0,sp,64
 e68:	87aa                	mv	a5,a0
 e6a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e6e:	fcc46783          	lwu	a5,-52(s0)
 e72:	07bd                	addi	a5,a5,15
 e74:	8391                	srli	a5,a5,0x4
 e76:	2781                	sext.w	a5,a5
 e78:	2785                	addiw	a5,a5,1
 e7a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 e7e:	00001797          	auipc	a5,0x1
 e82:	54278793          	addi	a5,a5,1346 # 23c0 <freep>
 e86:	639c                	ld	a5,0(a5)
 e88:	fef43023          	sd	a5,-32(s0)
 e8c:	fe043783          	ld	a5,-32(s0)
 e90:	ef95                	bnez	a5,ecc <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 e92:	00001797          	auipc	a5,0x1
 e96:	51e78793          	addi	a5,a5,1310 # 23b0 <base>
 e9a:	fef43023          	sd	a5,-32(s0)
 e9e:	00001797          	auipc	a5,0x1
 ea2:	52278793          	addi	a5,a5,1314 # 23c0 <freep>
 ea6:	fe043703          	ld	a4,-32(s0)
 eaa:	e398                	sd	a4,0(a5)
 eac:	00001797          	auipc	a5,0x1
 eb0:	51478793          	addi	a5,a5,1300 # 23c0 <freep>
 eb4:	6398                	ld	a4,0(a5)
 eb6:	00001797          	auipc	a5,0x1
 eba:	4fa78793          	addi	a5,a5,1274 # 23b0 <base>
 ebe:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 ec0:	00001797          	auipc	a5,0x1
 ec4:	4f078793          	addi	a5,a5,1264 # 23b0 <base>
 ec8:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ecc:	fe043783          	ld	a5,-32(s0)
 ed0:	639c                	ld	a5,0(a5)
 ed2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 ed6:	fe843783          	ld	a5,-24(s0)
 eda:	4798                	lw	a4,8(a5)
 edc:	fdc42783          	lw	a5,-36(s0)
 ee0:	2781                	sext.w	a5,a5
 ee2:	06f76763          	bltu	a4,a5,f50 <malloc+0xf0>
      if(p->s.size == nunits)
 ee6:	fe843783          	ld	a5,-24(s0)
 eea:	4798                	lw	a4,8(a5)
 eec:	fdc42783          	lw	a5,-36(s0)
 ef0:	2781                	sext.w	a5,a5
 ef2:	00e79963          	bne	a5,a4,f04 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 ef6:	fe843783          	ld	a5,-24(s0)
 efa:	6398                	ld	a4,0(a5)
 efc:	fe043783          	ld	a5,-32(s0)
 f00:	e398                	sd	a4,0(a5)
 f02:	a825                	j	f3a <malloc+0xda>
      else {
        p->s.size -= nunits;
 f04:	fe843783          	ld	a5,-24(s0)
 f08:	479c                	lw	a5,8(a5)
 f0a:	fdc42703          	lw	a4,-36(s0)
 f0e:	9f99                	subw	a5,a5,a4
 f10:	0007871b          	sext.w	a4,a5
 f14:	fe843783          	ld	a5,-24(s0)
 f18:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f1a:	fe843783          	ld	a5,-24(s0)
 f1e:	479c                	lw	a5,8(a5)
 f20:	1782                	slli	a5,a5,0x20
 f22:	9381                	srli	a5,a5,0x20
 f24:	0792                	slli	a5,a5,0x4
 f26:	fe843703          	ld	a4,-24(s0)
 f2a:	97ba                	add	a5,a5,a4
 f2c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f30:	fe843783          	ld	a5,-24(s0)
 f34:	fdc42703          	lw	a4,-36(s0)
 f38:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f3a:	00001797          	auipc	a5,0x1
 f3e:	48678793          	addi	a5,a5,1158 # 23c0 <freep>
 f42:	fe043703          	ld	a4,-32(s0)
 f46:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 f48:	fe843783          	ld	a5,-24(s0)
 f4c:	07c1                	addi	a5,a5,16
 f4e:	a091                	j	f92 <malloc+0x132>
    }
    if(p == freep)
 f50:	00001797          	auipc	a5,0x1
 f54:	47078793          	addi	a5,a5,1136 # 23c0 <freep>
 f58:	639c                	ld	a5,0(a5)
 f5a:	fe843703          	ld	a4,-24(s0)
 f5e:	02f71063          	bne	a4,a5,f7e <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 f62:	fdc42783          	lw	a5,-36(s0)
 f66:	853e                	mv	a0,a5
 f68:	00000097          	auipc	ra,0x0
 f6c:	e78080e7          	jalr	-392(ra) # de0 <morecore>
 f70:	fea43423          	sd	a0,-24(s0)
 f74:	fe843783          	ld	a5,-24(s0)
 f78:	e399                	bnez	a5,f7e <malloc+0x11e>
        return 0;
 f7a:	4781                	li	a5,0
 f7c:	a819                	j	f92 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f7e:	fe843783          	ld	a5,-24(s0)
 f82:	fef43023          	sd	a5,-32(s0)
 f86:	fe843783          	ld	a5,-24(s0)
 f8a:	639c                	ld	a5,0(a5)
 f8c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f90:	b799                	j	ed6 <malloc+0x76>
  }
}
 f92:	853e                	mv	a0,a5
 f94:	70e2                	ld	ra,56(sp)
 f96:	7442                	ld	s0,48(sp)
 f98:	6121                	addi	sp,sp,64
 f9a:	8082                	ret
