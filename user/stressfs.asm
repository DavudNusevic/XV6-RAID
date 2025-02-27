
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dc010113          	addi	sp,sp,-576
   4:	22113c23          	sd	ra,568(sp)
   8:	22813823          	sd	s0,560(sp)
   c:	0480                	addi	s0,sp,576
   e:	87aa                	mv	a5,a0
  10:	dcb43023          	sd	a1,-576(s0)
  14:	dcf42623          	sw	a5,-564(s0)
  int fd, i;
  char path[] = "stressfs0";
  18:	00001797          	auipc	a5,0x1
  1c:	ee878793          	addi	a5,a5,-280 # f00 <malloc+0x178>
  20:	6398                	ld	a4,0(a5)
  22:	fce43c23          	sd	a4,-40(s0)
  26:	0087d783          	lhu	a5,8(a5)
  2a:	fef41023          	sh	a5,-32(s0)
  char data[512];

  printf("stressfs starting\n");
  2e:	00001517          	auipc	a0,0x1
  32:	ea250513          	addi	a0,a0,-350 # ed0 <malloc+0x148>
  36:	00001097          	auipc	ra,0x1
  3a:	b60080e7          	jalr	-1184(ra) # b96 <printf>
  memset(data, 'a', sizeof(data));
  3e:	dd840793          	addi	a5,s0,-552
  42:	20000613          	li	a2,512
  46:	06100593          	li	a1,97
  4a:	853e                	mv	a0,a5
  4c:	00000097          	auipc	ra,0x0
  50:	23e080e7          	jalr	574(ra) # 28a <memset>

  for(i = 0; i < 4; i++)
  54:	fe042623          	sw	zero,-20(s0)
  58:	a829                	j	72 <main+0x72>
    if(fork() > 0)
  5a:	00000097          	auipc	ra,0x0
  5e:	5d4080e7          	jalr	1492(ra) # 62e <fork>
  62:	87aa                	mv	a5,a0
  64:	00f04f63          	bgtz	a5,82 <main+0x82>
  for(i = 0; i < 4; i++)
  68:	fec42783          	lw	a5,-20(s0)
  6c:	2785                	addiw	a5,a5,1
  6e:	fef42623          	sw	a5,-20(s0)
  72:	fec42783          	lw	a5,-20(s0)
  76:	0007871b          	sext.w	a4,a5
  7a:	478d                	li	a5,3
  7c:	fce7dfe3          	bge	a5,a4,5a <main+0x5a>
  80:	a011                	j	84 <main+0x84>
      break;
  82:	0001                	nop

  printf("write %d\n", i);
  84:	fec42783          	lw	a5,-20(s0)
  88:	85be                	mv	a1,a5
  8a:	00001517          	auipc	a0,0x1
  8e:	e5e50513          	addi	a0,a0,-418 # ee8 <malloc+0x160>
  92:	00001097          	auipc	ra,0x1
  96:	b04080e7          	jalr	-1276(ra) # b96 <printf>

  path[8] += i;
  9a:	fe044703          	lbu	a4,-32(s0)
  9e:	fec42783          	lw	a5,-20(s0)
  a2:	0ff7f793          	zext.b	a5,a5
  a6:	9fb9                	addw	a5,a5,a4
  a8:	0ff7f793          	zext.b	a5,a5
  ac:	fef40023          	sb	a5,-32(s0)
  fd = open(path, O_CREATE | O_RDWR);
  b0:	fd840793          	addi	a5,s0,-40
  b4:	20200593          	li	a1,514
  b8:	853e                	mv	a0,a5
  ba:	00000097          	auipc	ra,0x0
  be:	5bc080e7          	jalr	1468(ra) # 676 <open>
  c2:	87aa                	mv	a5,a0
  c4:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 20; i++)
  c8:	fe042623          	sw	zero,-20(s0)
  cc:	a015                	j	f0 <main+0xf0>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  ce:	dd840713          	addi	a4,s0,-552
  d2:	fe842783          	lw	a5,-24(s0)
  d6:	20000613          	li	a2,512
  da:	85ba                	mv	a1,a4
  dc:	853e                	mv	a0,a5
  de:	00000097          	auipc	ra,0x0
  e2:	578080e7          	jalr	1400(ra) # 656 <write>
  for(i = 0; i < 20; i++)
  e6:	fec42783          	lw	a5,-20(s0)
  ea:	2785                	addiw	a5,a5,1
  ec:	fef42623          	sw	a5,-20(s0)
  f0:	fec42783          	lw	a5,-20(s0)
  f4:	0007871b          	sext.w	a4,a5
  f8:	47cd                	li	a5,19
  fa:	fce7dae3          	bge	a5,a4,ce <main+0xce>
  close(fd);
  fe:	fe842783          	lw	a5,-24(s0)
 102:	853e                	mv	a0,a5
 104:	00000097          	auipc	ra,0x0
 108:	55a080e7          	jalr	1370(ra) # 65e <close>

  printf("read\n");
 10c:	00001517          	auipc	a0,0x1
 110:	dec50513          	addi	a0,a0,-532 # ef8 <malloc+0x170>
 114:	00001097          	auipc	ra,0x1
 118:	a82080e7          	jalr	-1406(ra) # b96 <printf>

  fd = open(path, O_RDONLY);
 11c:	fd840793          	addi	a5,s0,-40
 120:	4581                	li	a1,0
 122:	853e                	mv	a0,a5
 124:	00000097          	auipc	ra,0x0
 128:	552080e7          	jalr	1362(ra) # 676 <open>
 12c:	87aa                	mv	a5,a0
 12e:	fef42423          	sw	a5,-24(s0)
  for (i = 0; i < 20; i++)
 132:	fe042623          	sw	zero,-20(s0)
 136:	a015                	j	15a <main+0x15a>
    read(fd, data, sizeof(data));
 138:	dd840713          	addi	a4,s0,-552
 13c:	fe842783          	lw	a5,-24(s0)
 140:	20000613          	li	a2,512
 144:	85ba                	mv	a1,a4
 146:	853e                	mv	a0,a5
 148:	00000097          	auipc	ra,0x0
 14c:	506080e7          	jalr	1286(ra) # 64e <read>
  for (i = 0; i < 20; i++)
 150:	fec42783          	lw	a5,-20(s0)
 154:	2785                	addiw	a5,a5,1
 156:	fef42623          	sw	a5,-20(s0)
 15a:	fec42783          	lw	a5,-20(s0)
 15e:	0007871b          	sext.w	a4,a5
 162:	47cd                	li	a5,19
 164:	fce7dae3          	bge	a5,a4,138 <main+0x138>
  close(fd);
 168:	fe842783          	lw	a5,-24(s0)
 16c:	853e                	mv	a0,a5
 16e:	00000097          	auipc	ra,0x0
 172:	4f0080e7          	jalr	1264(ra) # 65e <close>

  wait(0);
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	4c6080e7          	jalr	1222(ra) # 63e <wait>

  exit(0);
 180:	4501                	li	a0,0
 182:	00000097          	auipc	ra,0x0
 186:	4b4080e7          	jalr	1204(ra) # 636 <exit>

000000000000018a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e406                	sd	ra,8(sp)
 18e:	e022                	sd	s0,0(sp)
 190:	0800                	addi	s0,sp,16
  extern int main();
  main();
 192:	00000097          	auipc	ra,0x0
 196:	e6e080e7          	jalr	-402(ra) # 0 <main>
  exit(0);
 19a:	4501                	li	a0,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	49a080e7          	jalr	1178(ra) # 636 <exit>

00000000000001a4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1a4:	7179                	addi	sp,sp,-48
 1a6:	f422                	sd	s0,40(sp)
 1a8:	1800                	addi	s0,sp,48
 1aa:	fca43c23          	sd	a0,-40(s0)
 1ae:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 1b2:	fd843783          	ld	a5,-40(s0)
 1b6:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 1ba:	0001                	nop
 1bc:	fd043703          	ld	a4,-48(s0)
 1c0:	00170793          	addi	a5,a4,1
 1c4:	fcf43823          	sd	a5,-48(s0)
 1c8:	fd843783          	ld	a5,-40(s0)
 1cc:	00178693          	addi	a3,a5,1
 1d0:	fcd43c23          	sd	a3,-40(s0)
 1d4:	00074703          	lbu	a4,0(a4)
 1d8:	00e78023          	sb	a4,0(a5)
 1dc:	0007c783          	lbu	a5,0(a5)
 1e0:	fff1                	bnez	a5,1bc <strcpy+0x18>
    ;
  return os;
 1e2:	fe843783          	ld	a5,-24(s0)
}
 1e6:	853e                	mv	a0,a5
 1e8:	7422                	ld	s0,40(sp)
 1ea:	6145                	addi	sp,sp,48
 1ec:	8082                	ret

00000000000001ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ee:	1101                	addi	sp,sp,-32
 1f0:	ec22                	sd	s0,24(sp)
 1f2:	1000                	addi	s0,sp,32
 1f4:	fea43423          	sd	a0,-24(s0)
 1f8:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 1fc:	a819                	j	212 <strcmp+0x24>
    p++, q++;
 1fe:	fe843783          	ld	a5,-24(s0)
 202:	0785                	addi	a5,a5,1
 204:	fef43423          	sd	a5,-24(s0)
 208:	fe043783          	ld	a5,-32(s0)
 20c:	0785                	addi	a5,a5,1
 20e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 212:	fe843783          	ld	a5,-24(s0)
 216:	0007c783          	lbu	a5,0(a5)
 21a:	cb99                	beqz	a5,230 <strcmp+0x42>
 21c:	fe843783          	ld	a5,-24(s0)
 220:	0007c703          	lbu	a4,0(a5)
 224:	fe043783          	ld	a5,-32(s0)
 228:	0007c783          	lbu	a5,0(a5)
 22c:	fcf709e3          	beq	a4,a5,1fe <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 230:	fe843783          	ld	a5,-24(s0)
 234:	0007c783          	lbu	a5,0(a5)
 238:	0007871b          	sext.w	a4,a5
 23c:	fe043783          	ld	a5,-32(s0)
 240:	0007c783          	lbu	a5,0(a5)
 244:	2781                	sext.w	a5,a5
 246:	40f707bb          	subw	a5,a4,a5
 24a:	2781                	sext.w	a5,a5
}
 24c:	853e                	mv	a0,a5
 24e:	6462                	ld	s0,24(sp)
 250:	6105                	addi	sp,sp,32
 252:	8082                	ret

0000000000000254 <strlen>:

uint
strlen(const char *s)
{
 254:	7179                	addi	sp,sp,-48
 256:	f422                	sd	s0,40(sp)
 258:	1800                	addi	s0,sp,48
 25a:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 25e:	fe042623          	sw	zero,-20(s0)
 262:	a031                	j	26e <strlen+0x1a>
 264:	fec42783          	lw	a5,-20(s0)
 268:	2785                	addiw	a5,a5,1
 26a:	fef42623          	sw	a5,-20(s0)
 26e:	fec42783          	lw	a5,-20(s0)
 272:	fd843703          	ld	a4,-40(s0)
 276:	97ba                	add	a5,a5,a4
 278:	0007c783          	lbu	a5,0(a5)
 27c:	f7e5                	bnez	a5,264 <strlen+0x10>
    ;
  return n;
 27e:	fec42783          	lw	a5,-20(s0)
}
 282:	853e                	mv	a0,a5
 284:	7422                	ld	s0,40(sp)
 286:	6145                	addi	sp,sp,48
 288:	8082                	ret

000000000000028a <memset>:

void*
memset(void *dst, int c, uint n)
{
 28a:	7179                	addi	sp,sp,-48
 28c:	f422                	sd	s0,40(sp)
 28e:	1800                	addi	s0,sp,48
 290:	fca43c23          	sd	a0,-40(s0)
 294:	87ae                	mv	a5,a1
 296:	8732                	mv	a4,a2
 298:	fcf42a23          	sw	a5,-44(s0)
 29c:	87ba                	mv	a5,a4
 29e:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 2a2:	fd843783          	ld	a5,-40(s0)
 2a6:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 2aa:	fe042623          	sw	zero,-20(s0)
 2ae:	a00d                	j	2d0 <memset+0x46>
    cdst[i] = c;
 2b0:	fec42783          	lw	a5,-20(s0)
 2b4:	fe043703          	ld	a4,-32(s0)
 2b8:	97ba                	add	a5,a5,a4
 2ba:	fd442703          	lw	a4,-44(s0)
 2be:	0ff77713          	zext.b	a4,a4
 2c2:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 2c6:	fec42783          	lw	a5,-20(s0)
 2ca:	2785                	addiw	a5,a5,1
 2cc:	fef42623          	sw	a5,-20(s0)
 2d0:	fec42703          	lw	a4,-20(s0)
 2d4:	fd042783          	lw	a5,-48(s0)
 2d8:	2781                	sext.w	a5,a5
 2da:	fcf76be3          	bltu	a4,a5,2b0 <memset+0x26>
  }
  return dst;
 2de:	fd843783          	ld	a5,-40(s0)
}
 2e2:	853e                	mv	a0,a5
 2e4:	7422                	ld	s0,40(sp)
 2e6:	6145                	addi	sp,sp,48
 2e8:	8082                	ret

00000000000002ea <strchr>:

char*
strchr(const char *s, char c)
{
 2ea:	1101                	addi	sp,sp,-32
 2ec:	ec22                	sd	s0,24(sp)
 2ee:	1000                	addi	s0,sp,32
 2f0:	fea43423          	sd	a0,-24(s0)
 2f4:	87ae                	mv	a5,a1
 2f6:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2fa:	a01d                	j	320 <strchr+0x36>
    if(*s == c)
 2fc:	fe843783          	ld	a5,-24(s0)
 300:	0007c703          	lbu	a4,0(a5)
 304:	fe744783          	lbu	a5,-25(s0)
 308:	0ff7f793          	zext.b	a5,a5
 30c:	00e79563          	bne	a5,a4,316 <strchr+0x2c>
      return (char*)s;
 310:	fe843783          	ld	a5,-24(s0)
 314:	a821                	j	32c <strchr+0x42>
  for(; *s; s++)
 316:	fe843783          	ld	a5,-24(s0)
 31a:	0785                	addi	a5,a5,1
 31c:	fef43423          	sd	a5,-24(s0)
 320:	fe843783          	ld	a5,-24(s0)
 324:	0007c783          	lbu	a5,0(a5)
 328:	fbf1                	bnez	a5,2fc <strchr+0x12>
  return 0;
 32a:	4781                	li	a5,0
}
 32c:	853e                	mv	a0,a5
 32e:	6462                	ld	s0,24(sp)
 330:	6105                	addi	sp,sp,32
 332:	8082                	ret

0000000000000334 <gets>:

char*
gets(char *buf, int max)
{
 334:	7179                	addi	sp,sp,-48
 336:	f406                	sd	ra,40(sp)
 338:	f022                	sd	s0,32(sp)
 33a:	1800                	addi	s0,sp,48
 33c:	fca43c23          	sd	a0,-40(s0)
 340:	87ae                	mv	a5,a1
 342:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 346:	fe042623          	sw	zero,-20(s0)
 34a:	a8a1                	j	3a2 <gets+0x6e>
    cc = read(0, &c, 1);
 34c:	fe740793          	addi	a5,s0,-25
 350:	4605                	li	a2,1
 352:	85be                	mv	a1,a5
 354:	4501                	li	a0,0
 356:	00000097          	auipc	ra,0x0
 35a:	2f8080e7          	jalr	760(ra) # 64e <read>
 35e:	87aa                	mv	a5,a0
 360:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 364:	fe842783          	lw	a5,-24(s0)
 368:	2781                	sext.w	a5,a5
 36a:	04f05763          	blez	a5,3b8 <gets+0x84>
      break;
    buf[i++] = c;
 36e:	fec42783          	lw	a5,-20(s0)
 372:	0017871b          	addiw	a4,a5,1
 376:	fee42623          	sw	a4,-20(s0)
 37a:	873e                	mv	a4,a5
 37c:	fd843783          	ld	a5,-40(s0)
 380:	97ba                	add	a5,a5,a4
 382:	fe744703          	lbu	a4,-25(s0)
 386:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 38a:	fe744783          	lbu	a5,-25(s0)
 38e:	873e                	mv	a4,a5
 390:	47a9                	li	a5,10
 392:	02f70463          	beq	a4,a5,3ba <gets+0x86>
 396:	fe744783          	lbu	a5,-25(s0)
 39a:	873e                	mv	a4,a5
 39c:	47b5                	li	a5,13
 39e:	00f70e63          	beq	a4,a5,3ba <gets+0x86>
  for(i=0; i+1 < max; ){
 3a2:	fec42783          	lw	a5,-20(s0)
 3a6:	2785                	addiw	a5,a5,1
 3a8:	0007871b          	sext.w	a4,a5
 3ac:	fd442783          	lw	a5,-44(s0)
 3b0:	2781                	sext.w	a5,a5
 3b2:	f8f74de3          	blt	a4,a5,34c <gets+0x18>
 3b6:	a011                	j	3ba <gets+0x86>
      break;
 3b8:	0001                	nop
      break;
  }
  buf[i] = '\0';
 3ba:	fec42783          	lw	a5,-20(s0)
 3be:	fd843703          	ld	a4,-40(s0)
 3c2:	97ba                	add	a5,a5,a4
 3c4:	00078023          	sb	zero,0(a5)
  return buf;
 3c8:	fd843783          	ld	a5,-40(s0)
}
 3cc:	853e                	mv	a0,a5
 3ce:	70a2                	ld	ra,40(sp)
 3d0:	7402                	ld	s0,32(sp)
 3d2:	6145                	addi	sp,sp,48
 3d4:	8082                	ret

00000000000003d6 <stat>:

int
stat(const char *n, struct stat *st)
{
 3d6:	7179                	addi	sp,sp,-48
 3d8:	f406                	sd	ra,40(sp)
 3da:	f022                	sd	s0,32(sp)
 3dc:	1800                	addi	s0,sp,48
 3de:	fca43c23          	sd	a0,-40(s0)
 3e2:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e6:	4581                	li	a1,0
 3e8:	fd843503          	ld	a0,-40(s0)
 3ec:	00000097          	auipc	ra,0x0
 3f0:	28a080e7          	jalr	650(ra) # 676 <open>
 3f4:	87aa                	mv	a5,a0
 3f6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3fa:	fec42783          	lw	a5,-20(s0)
 3fe:	2781                	sext.w	a5,a5
 400:	0007d463          	bgez	a5,408 <stat+0x32>
    return -1;
 404:	57fd                	li	a5,-1
 406:	a035                	j	432 <stat+0x5c>
  r = fstat(fd, st);
 408:	fec42783          	lw	a5,-20(s0)
 40c:	fd043583          	ld	a1,-48(s0)
 410:	853e                	mv	a0,a5
 412:	00000097          	auipc	ra,0x0
 416:	27c080e7          	jalr	636(ra) # 68e <fstat>
 41a:	87aa                	mv	a5,a0
 41c:	fef42423          	sw	a5,-24(s0)
  close(fd);
 420:	fec42783          	lw	a5,-20(s0)
 424:	853e                	mv	a0,a5
 426:	00000097          	auipc	ra,0x0
 42a:	238080e7          	jalr	568(ra) # 65e <close>
  return r;
 42e:	fe842783          	lw	a5,-24(s0)
}
 432:	853e                	mv	a0,a5
 434:	70a2                	ld	ra,40(sp)
 436:	7402                	ld	s0,32(sp)
 438:	6145                	addi	sp,sp,48
 43a:	8082                	ret

000000000000043c <atoi>:

int
atoi(const char *s)
{
 43c:	7179                	addi	sp,sp,-48
 43e:	f422                	sd	s0,40(sp)
 440:	1800                	addi	s0,sp,48
 442:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 446:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 44a:	a81d                	j	480 <atoi+0x44>
    n = n*10 + *s++ - '0';
 44c:	fec42783          	lw	a5,-20(s0)
 450:	873e                	mv	a4,a5
 452:	87ba                	mv	a5,a4
 454:	0027979b          	slliw	a5,a5,0x2
 458:	9fb9                	addw	a5,a5,a4
 45a:	0017979b          	slliw	a5,a5,0x1
 45e:	0007871b          	sext.w	a4,a5
 462:	fd843783          	ld	a5,-40(s0)
 466:	00178693          	addi	a3,a5,1
 46a:	fcd43c23          	sd	a3,-40(s0)
 46e:	0007c783          	lbu	a5,0(a5)
 472:	2781                	sext.w	a5,a5
 474:	9fb9                	addw	a5,a5,a4
 476:	2781                	sext.w	a5,a5
 478:	fd07879b          	addiw	a5,a5,-48
 47c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 480:	fd843783          	ld	a5,-40(s0)
 484:	0007c783          	lbu	a5,0(a5)
 488:	873e                	mv	a4,a5
 48a:	02f00793          	li	a5,47
 48e:	00e7fb63          	bgeu	a5,a4,4a4 <atoi+0x68>
 492:	fd843783          	ld	a5,-40(s0)
 496:	0007c783          	lbu	a5,0(a5)
 49a:	873e                	mv	a4,a5
 49c:	03900793          	li	a5,57
 4a0:	fae7f6e3          	bgeu	a5,a4,44c <atoi+0x10>
  return n;
 4a4:	fec42783          	lw	a5,-20(s0)
}
 4a8:	853e                	mv	a0,a5
 4aa:	7422                	ld	s0,40(sp)
 4ac:	6145                	addi	sp,sp,48
 4ae:	8082                	ret

00000000000004b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4b0:	7139                	addi	sp,sp,-64
 4b2:	fc22                	sd	s0,56(sp)
 4b4:	0080                	addi	s0,sp,64
 4b6:	fca43c23          	sd	a0,-40(s0)
 4ba:	fcb43823          	sd	a1,-48(s0)
 4be:	87b2                	mv	a5,a2
 4c0:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 4c4:	fd843783          	ld	a5,-40(s0)
 4c8:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 4cc:	fd043783          	ld	a5,-48(s0)
 4d0:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 4d4:	fe043703          	ld	a4,-32(s0)
 4d8:	fe843783          	ld	a5,-24(s0)
 4dc:	02e7fc63          	bgeu	a5,a4,514 <memmove+0x64>
    while(n-- > 0)
 4e0:	a00d                	j	502 <memmove+0x52>
      *dst++ = *src++;
 4e2:	fe043703          	ld	a4,-32(s0)
 4e6:	00170793          	addi	a5,a4,1
 4ea:	fef43023          	sd	a5,-32(s0)
 4ee:	fe843783          	ld	a5,-24(s0)
 4f2:	00178693          	addi	a3,a5,1
 4f6:	fed43423          	sd	a3,-24(s0)
 4fa:	00074703          	lbu	a4,0(a4)
 4fe:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 502:	fcc42783          	lw	a5,-52(s0)
 506:	fff7871b          	addiw	a4,a5,-1
 50a:	fce42623          	sw	a4,-52(s0)
 50e:	fcf04ae3          	bgtz	a5,4e2 <memmove+0x32>
 512:	a891                	j	566 <memmove+0xb6>
  } else {
    dst += n;
 514:	fcc42783          	lw	a5,-52(s0)
 518:	fe843703          	ld	a4,-24(s0)
 51c:	97ba                	add	a5,a5,a4
 51e:	fef43423          	sd	a5,-24(s0)
    src += n;
 522:	fcc42783          	lw	a5,-52(s0)
 526:	fe043703          	ld	a4,-32(s0)
 52a:	97ba                	add	a5,a5,a4
 52c:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 530:	a01d                	j	556 <memmove+0xa6>
      *--dst = *--src;
 532:	fe043783          	ld	a5,-32(s0)
 536:	17fd                	addi	a5,a5,-1
 538:	fef43023          	sd	a5,-32(s0)
 53c:	fe843783          	ld	a5,-24(s0)
 540:	17fd                	addi	a5,a5,-1
 542:	fef43423          	sd	a5,-24(s0)
 546:	fe043783          	ld	a5,-32(s0)
 54a:	0007c703          	lbu	a4,0(a5)
 54e:	fe843783          	ld	a5,-24(s0)
 552:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 556:	fcc42783          	lw	a5,-52(s0)
 55a:	fff7871b          	addiw	a4,a5,-1
 55e:	fce42623          	sw	a4,-52(s0)
 562:	fcf048e3          	bgtz	a5,532 <memmove+0x82>
  }
  return vdst;
 566:	fd843783          	ld	a5,-40(s0)
}
 56a:	853e                	mv	a0,a5
 56c:	7462                	ld	s0,56(sp)
 56e:	6121                	addi	sp,sp,64
 570:	8082                	ret

0000000000000572 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 572:	7139                	addi	sp,sp,-64
 574:	fc22                	sd	s0,56(sp)
 576:	0080                	addi	s0,sp,64
 578:	fca43c23          	sd	a0,-40(s0)
 57c:	fcb43823          	sd	a1,-48(s0)
 580:	87b2                	mv	a5,a2
 582:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 586:	fd843783          	ld	a5,-40(s0)
 58a:	fef43423          	sd	a5,-24(s0)
 58e:	fd043783          	ld	a5,-48(s0)
 592:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 596:	a0a1                	j	5de <memcmp+0x6c>
    if (*p1 != *p2) {
 598:	fe843783          	ld	a5,-24(s0)
 59c:	0007c703          	lbu	a4,0(a5)
 5a0:	fe043783          	ld	a5,-32(s0)
 5a4:	0007c783          	lbu	a5,0(a5)
 5a8:	02f70163          	beq	a4,a5,5ca <memcmp+0x58>
      return *p1 - *p2;
 5ac:	fe843783          	ld	a5,-24(s0)
 5b0:	0007c783          	lbu	a5,0(a5)
 5b4:	0007871b          	sext.w	a4,a5
 5b8:	fe043783          	ld	a5,-32(s0)
 5bc:	0007c783          	lbu	a5,0(a5)
 5c0:	2781                	sext.w	a5,a5
 5c2:	40f707bb          	subw	a5,a4,a5
 5c6:	2781                	sext.w	a5,a5
 5c8:	a01d                	j	5ee <memcmp+0x7c>
    }
    p1++;
 5ca:	fe843783          	ld	a5,-24(s0)
 5ce:	0785                	addi	a5,a5,1
 5d0:	fef43423          	sd	a5,-24(s0)
    p2++;
 5d4:	fe043783          	ld	a5,-32(s0)
 5d8:	0785                	addi	a5,a5,1
 5da:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5de:	fcc42783          	lw	a5,-52(s0)
 5e2:	fff7871b          	addiw	a4,a5,-1
 5e6:	fce42623          	sw	a4,-52(s0)
 5ea:	f7dd                	bnez	a5,598 <memcmp+0x26>
  }
  return 0;
 5ec:	4781                	li	a5,0
}
 5ee:	853e                	mv	a0,a5
 5f0:	7462                	ld	s0,56(sp)
 5f2:	6121                	addi	sp,sp,64
 5f4:	8082                	ret

00000000000005f6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5f6:	7179                	addi	sp,sp,-48
 5f8:	f406                	sd	ra,40(sp)
 5fa:	f022                	sd	s0,32(sp)
 5fc:	1800                	addi	s0,sp,48
 5fe:	fea43423          	sd	a0,-24(s0)
 602:	feb43023          	sd	a1,-32(s0)
 606:	87b2                	mv	a5,a2
 608:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 60c:	fdc42783          	lw	a5,-36(s0)
 610:	863e                	mv	a2,a5
 612:	fe043583          	ld	a1,-32(s0)
 616:	fe843503          	ld	a0,-24(s0)
 61a:	00000097          	auipc	ra,0x0
 61e:	e96080e7          	jalr	-362(ra) # 4b0 <memmove>
 622:	87aa                	mv	a5,a0
}
 624:	853e                	mv	a0,a5
 626:	70a2                	ld	ra,40(sp)
 628:	7402                	ld	s0,32(sp)
 62a:	6145                	addi	sp,sp,48
 62c:	8082                	ret

000000000000062e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 62e:	4885                	li	a7,1
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <exit>:
.global exit
exit:
 li a7, SYS_exit
 636:	4889                	li	a7,2
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <wait>:
.global wait
wait:
 li a7, SYS_wait
 63e:	488d                	li	a7,3
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 646:	4891                	li	a7,4
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <read>:
.global read
read:
 li a7, SYS_read
 64e:	4895                	li	a7,5
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <write>:
.global write
write:
 li a7, SYS_write
 656:	48c1                	li	a7,16
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <close>:
.global close
close:
 li a7, SYS_close
 65e:	48d5                	li	a7,21
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <kill>:
.global kill
kill:
 li a7, SYS_kill
 666:	4899                	li	a7,6
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <exec>:
.global exec
exec:
 li a7, SYS_exec
 66e:	489d                	li	a7,7
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <open>:
.global open
open:
 li a7, SYS_open
 676:	48bd                	li	a7,15
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 67e:	48c5                	li	a7,17
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 686:	48c9                	li	a7,18
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 68e:	48a1                	li	a7,8
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <link>:
.global link
link:
 li a7, SYS_link
 696:	48cd                	li	a7,19
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 69e:	48d1                	li	a7,20
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6a6:	48a5                	li	a7,9
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <dup>:
.global dup
dup:
 li a7, SYS_dup
 6ae:	48a9                	li	a7,10
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6b6:	48ad                	li	a7,11
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6be:	48b1                	li	a7,12
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6c6:	48b5                	li	a7,13
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6ce:	48b9                	li	a7,14
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
 6d6:	48d9                	li	a7,22
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
 6de:	48dd                	li	a7,23
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
 6e6:	48e1                	li	a7,24
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
 6ee:	48e5                	li	a7,25
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
 6f6:	48e9                	li	a7,26
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
 6fe:	48ed                	li	a7,27
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
 706:	48f1                	li	a7,28
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 70e:	1101                	addi	sp,sp,-32
 710:	ec06                	sd	ra,24(sp)
 712:	e822                	sd	s0,16(sp)
 714:	1000                	addi	s0,sp,32
 716:	87aa                	mv	a5,a0
 718:	872e                	mv	a4,a1
 71a:	fef42623          	sw	a5,-20(s0)
 71e:	87ba                	mv	a5,a4
 720:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 724:	feb40713          	addi	a4,s0,-21
 728:	fec42783          	lw	a5,-20(s0)
 72c:	4605                	li	a2,1
 72e:	85ba                	mv	a1,a4
 730:	853e                	mv	a0,a5
 732:	00000097          	auipc	ra,0x0
 736:	f24080e7          	jalr	-220(ra) # 656 <write>
}
 73a:	0001                	nop
 73c:	60e2                	ld	ra,24(sp)
 73e:	6442                	ld	s0,16(sp)
 740:	6105                	addi	sp,sp,32
 742:	8082                	ret

0000000000000744 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 744:	7139                	addi	sp,sp,-64
 746:	fc06                	sd	ra,56(sp)
 748:	f822                	sd	s0,48(sp)
 74a:	0080                	addi	s0,sp,64
 74c:	87aa                	mv	a5,a0
 74e:	8736                	mv	a4,a3
 750:	fcf42623          	sw	a5,-52(s0)
 754:	87ae                	mv	a5,a1
 756:	fcf42423          	sw	a5,-56(s0)
 75a:	87b2                	mv	a5,a2
 75c:	fcf42223          	sw	a5,-60(s0)
 760:	87ba                	mv	a5,a4
 762:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 766:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 76a:	fc042783          	lw	a5,-64(s0)
 76e:	2781                	sext.w	a5,a5
 770:	c38d                	beqz	a5,792 <printint+0x4e>
 772:	fc842783          	lw	a5,-56(s0)
 776:	2781                	sext.w	a5,a5
 778:	0007dd63          	bgez	a5,792 <printint+0x4e>
    neg = 1;
 77c:	4785                	li	a5,1
 77e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 782:	fc842783          	lw	a5,-56(s0)
 786:	40f007bb          	negw	a5,a5
 78a:	2781                	sext.w	a5,a5
 78c:	fef42223          	sw	a5,-28(s0)
 790:	a029                	j	79a <printint+0x56>
  } else {
    x = xx;
 792:	fc842783          	lw	a5,-56(s0)
 796:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 79a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 79e:	fc442783          	lw	a5,-60(s0)
 7a2:	fe442703          	lw	a4,-28(s0)
 7a6:	02f777bb          	remuw	a5,a4,a5
 7aa:	0007861b          	sext.w	a2,a5
 7ae:	fec42783          	lw	a5,-20(s0)
 7b2:	0017871b          	addiw	a4,a5,1
 7b6:	fee42623          	sw	a4,-20(s0)
 7ba:	00001697          	auipc	a3,0x1
 7be:	bb668693          	addi	a3,a3,-1098 # 1370 <digits>
 7c2:	02061713          	slli	a4,a2,0x20
 7c6:	9301                	srli	a4,a4,0x20
 7c8:	9736                	add	a4,a4,a3
 7ca:	00074703          	lbu	a4,0(a4)
 7ce:	17c1                	addi	a5,a5,-16
 7d0:	97a2                	add	a5,a5,s0
 7d2:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 7d6:	fc442783          	lw	a5,-60(s0)
 7da:	fe442703          	lw	a4,-28(s0)
 7de:	02f757bb          	divuw	a5,a4,a5
 7e2:	fef42223          	sw	a5,-28(s0)
 7e6:	fe442783          	lw	a5,-28(s0)
 7ea:	2781                	sext.w	a5,a5
 7ec:	fbcd                	bnez	a5,79e <printint+0x5a>
  if(neg)
 7ee:	fe842783          	lw	a5,-24(s0)
 7f2:	2781                	sext.w	a5,a5
 7f4:	cf85                	beqz	a5,82c <printint+0xe8>
    buf[i++] = '-';
 7f6:	fec42783          	lw	a5,-20(s0)
 7fa:	0017871b          	addiw	a4,a5,1
 7fe:	fee42623          	sw	a4,-20(s0)
 802:	17c1                	addi	a5,a5,-16
 804:	97a2                	add	a5,a5,s0
 806:	02d00713          	li	a4,45
 80a:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 80e:	a839                	j	82c <printint+0xe8>
    putc(fd, buf[i]);
 810:	fec42783          	lw	a5,-20(s0)
 814:	17c1                	addi	a5,a5,-16
 816:	97a2                	add	a5,a5,s0
 818:	fe07c703          	lbu	a4,-32(a5)
 81c:	fcc42783          	lw	a5,-52(s0)
 820:	85ba                	mv	a1,a4
 822:	853e                	mv	a0,a5
 824:	00000097          	auipc	ra,0x0
 828:	eea080e7          	jalr	-278(ra) # 70e <putc>
  while(--i >= 0)
 82c:	fec42783          	lw	a5,-20(s0)
 830:	37fd                	addiw	a5,a5,-1
 832:	fef42623          	sw	a5,-20(s0)
 836:	fec42783          	lw	a5,-20(s0)
 83a:	2781                	sext.w	a5,a5
 83c:	fc07dae3          	bgez	a5,810 <printint+0xcc>
}
 840:	0001                	nop
 842:	0001                	nop
 844:	70e2                	ld	ra,56(sp)
 846:	7442                	ld	s0,48(sp)
 848:	6121                	addi	sp,sp,64
 84a:	8082                	ret

000000000000084c <printptr>:

static void
printptr(int fd, uint64 x) {
 84c:	7179                	addi	sp,sp,-48
 84e:	f406                	sd	ra,40(sp)
 850:	f022                	sd	s0,32(sp)
 852:	1800                	addi	s0,sp,48
 854:	87aa                	mv	a5,a0
 856:	fcb43823          	sd	a1,-48(s0)
 85a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 85e:	fdc42783          	lw	a5,-36(s0)
 862:	03000593          	li	a1,48
 866:	853e                	mv	a0,a5
 868:	00000097          	auipc	ra,0x0
 86c:	ea6080e7          	jalr	-346(ra) # 70e <putc>
  putc(fd, 'x');
 870:	fdc42783          	lw	a5,-36(s0)
 874:	07800593          	li	a1,120
 878:	853e                	mv	a0,a5
 87a:	00000097          	auipc	ra,0x0
 87e:	e94080e7          	jalr	-364(ra) # 70e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 882:	fe042623          	sw	zero,-20(s0)
 886:	a82d                	j	8c0 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 888:	fd043783          	ld	a5,-48(s0)
 88c:	93f1                	srli	a5,a5,0x3c
 88e:	00001717          	auipc	a4,0x1
 892:	ae270713          	addi	a4,a4,-1310 # 1370 <digits>
 896:	97ba                	add	a5,a5,a4
 898:	0007c703          	lbu	a4,0(a5)
 89c:	fdc42783          	lw	a5,-36(s0)
 8a0:	85ba                	mv	a1,a4
 8a2:	853e                	mv	a0,a5
 8a4:	00000097          	auipc	ra,0x0
 8a8:	e6a080e7          	jalr	-406(ra) # 70e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ac:	fec42783          	lw	a5,-20(s0)
 8b0:	2785                	addiw	a5,a5,1
 8b2:	fef42623          	sw	a5,-20(s0)
 8b6:	fd043783          	ld	a5,-48(s0)
 8ba:	0792                	slli	a5,a5,0x4
 8bc:	fcf43823          	sd	a5,-48(s0)
 8c0:	fec42783          	lw	a5,-20(s0)
 8c4:	873e                	mv	a4,a5
 8c6:	47bd                	li	a5,15
 8c8:	fce7f0e3          	bgeu	a5,a4,888 <printptr+0x3c>
}
 8cc:	0001                	nop
 8ce:	0001                	nop
 8d0:	70a2                	ld	ra,40(sp)
 8d2:	7402                	ld	s0,32(sp)
 8d4:	6145                	addi	sp,sp,48
 8d6:	8082                	ret

00000000000008d8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8d8:	715d                	addi	sp,sp,-80
 8da:	e486                	sd	ra,72(sp)
 8dc:	e0a2                	sd	s0,64(sp)
 8de:	0880                	addi	s0,sp,80
 8e0:	87aa                	mv	a5,a0
 8e2:	fcb43023          	sd	a1,-64(s0)
 8e6:	fac43c23          	sd	a2,-72(s0)
 8ea:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 8ee:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 8f2:	fe042223          	sw	zero,-28(s0)
 8f6:	a42d                	j	b20 <vprintf+0x248>
    c = fmt[i] & 0xff;
 8f8:	fe442783          	lw	a5,-28(s0)
 8fc:	fc043703          	ld	a4,-64(s0)
 900:	97ba                	add	a5,a5,a4
 902:	0007c783          	lbu	a5,0(a5)
 906:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 90a:	fe042783          	lw	a5,-32(s0)
 90e:	2781                	sext.w	a5,a5
 910:	eb9d                	bnez	a5,946 <vprintf+0x6e>
      if(c == '%'){
 912:	fdc42783          	lw	a5,-36(s0)
 916:	0007871b          	sext.w	a4,a5
 91a:	02500793          	li	a5,37
 91e:	00f71763          	bne	a4,a5,92c <vprintf+0x54>
        state = '%';
 922:	02500793          	li	a5,37
 926:	fef42023          	sw	a5,-32(s0)
 92a:	a2f5                	j	b16 <vprintf+0x23e>
      } else {
        putc(fd, c);
 92c:	fdc42783          	lw	a5,-36(s0)
 930:	0ff7f713          	zext.b	a4,a5
 934:	fcc42783          	lw	a5,-52(s0)
 938:	85ba                	mv	a1,a4
 93a:	853e                	mv	a0,a5
 93c:	00000097          	auipc	ra,0x0
 940:	dd2080e7          	jalr	-558(ra) # 70e <putc>
 944:	aac9                	j	b16 <vprintf+0x23e>
      }
    } else if(state == '%'){
 946:	fe042783          	lw	a5,-32(s0)
 94a:	0007871b          	sext.w	a4,a5
 94e:	02500793          	li	a5,37
 952:	1cf71263          	bne	a4,a5,b16 <vprintf+0x23e>
      if(c == 'd'){
 956:	fdc42783          	lw	a5,-36(s0)
 95a:	0007871b          	sext.w	a4,a5
 95e:	06400793          	li	a5,100
 962:	02f71463          	bne	a4,a5,98a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 966:	fb843783          	ld	a5,-72(s0)
 96a:	00878713          	addi	a4,a5,8
 96e:	fae43c23          	sd	a4,-72(s0)
 972:	4398                	lw	a4,0(a5)
 974:	fcc42783          	lw	a5,-52(s0)
 978:	4685                	li	a3,1
 97a:	4629                	li	a2,10
 97c:	85ba                	mv	a1,a4
 97e:	853e                	mv	a0,a5
 980:	00000097          	auipc	ra,0x0
 984:	dc4080e7          	jalr	-572(ra) # 744 <printint>
 988:	a269                	j	b12 <vprintf+0x23a>
      } else if(c == 'l') {
 98a:	fdc42783          	lw	a5,-36(s0)
 98e:	0007871b          	sext.w	a4,a5
 992:	06c00793          	li	a5,108
 996:	02f71663          	bne	a4,a5,9c2 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 99a:	fb843783          	ld	a5,-72(s0)
 99e:	00878713          	addi	a4,a5,8
 9a2:	fae43c23          	sd	a4,-72(s0)
 9a6:	639c                	ld	a5,0(a5)
 9a8:	0007871b          	sext.w	a4,a5
 9ac:	fcc42783          	lw	a5,-52(s0)
 9b0:	4681                	li	a3,0
 9b2:	4629                	li	a2,10
 9b4:	85ba                	mv	a1,a4
 9b6:	853e                	mv	a0,a5
 9b8:	00000097          	auipc	ra,0x0
 9bc:	d8c080e7          	jalr	-628(ra) # 744 <printint>
 9c0:	aa89                	j	b12 <vprintf+0x23a>
      } else if(c == 'x') {
 9c2:	fdc42783          	lw	a5,-36(s0)
 9c6:	0007871b          	sext.w	a4,a5
 9ca:	07800793          	li	a5,120
 9ce:	02f71463          	bne	a4,a5,9f6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 9d2:	fb843783          	ld	a5,-72(s0)
 9d6:	00878713          	addi	a4,a5,8
 9da:	fae43c23          	sd	a4,-72(s0)
 9de:	4398                	lw	a4,0(a5)
 9e0:	fcc42783          	lw	a5,-52(s0)
 9e4:	4681                	li	a3,0
 9e6:	4641                	li	a2,16
 9e8:	85ba                	mv	a1,a4
 9ea:	853e                	mv	a0,a5
 9ec:	00000097          	auipc	ra,0x0
 9f0:	d58080e7          	jalr	-680(ra) # 744 <printint>
 9f4:	aa39                	j	b12 <vprintf+0x23a>
      } else if(c == 'p') {
 9f6:	fdc42783          	lw	a5,-36(s0)
 9fa:	0007871b          	sext.w	a4,a5
 9fe:	07000793          	li	a5,112
 a02:	02f71263          	bne	a4,a5,a26 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 a06:	fb843783          	ld	a5,-72(s0)
 a0a:	00878713          	addi	a4,a5,8
 a0e:	fae43c23          	sd	a4,-72(s0)
 a12:	6398                	ld	a4,0(a5)
 a14:	fcc42783          	lw	a5,-52(s0)
 a18:	85ba                	mv	a1,a4
 a1a:	853e                	mv	a0,a5
 a1c:	00000097          	auipc	ra,0x0
 a20:	e30080e7          	jalr	-464(ra) # 84c <printptr>
 a24:	a0fd                	j	b12 <vprintf+0x23a>
      } else if(c == 's'){
 a26:	fdc42783          	lw	a5,-36(s0)
 a2a:	0007871b          	sext.w	a4,a5
 a2e:	07300793          	li	a5,115
 a32:	04f71c63          	bne	a4,a5,a8a <vprintf+0x1b2>
        s = va_arg(ap, char*);
 a36:	fb843783          	ld	a5,-72(s0)
 a3a:	00878713          	addi	a4,a5,8
 a3e:	fae43c23          	sd	a4,-72(s0)
 a42:	639c                	ld	a5,0(a5)
 a44:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 a48:	fe843783          	ld	a5,-24(s0)
 a4c:	eb8d                	bnez	a5,a7e <vprintf+0x1a6>
          s = "(null)";
 a4e:	00000797          	auipc	a5,0x0
 a52:	4c278793          	addi	a5,a5,1218 # f10 <malloc+0x188>
 a56:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a5a:	a015                	j	a7e <vprintf+0x1a6>
          putc(fd, *s);
 a5c:	fe843783          	ld	a5,-24(s0)
 a60:	0007c703          	lbu	a4,0(a5)
 a64:	fcc42783          	lw	a5,-52(s0)
 a68:	85ba                	mv	a1,a4
 a6a:	853e                	mv	a0,a5
 a6c:	00000097          	auipc	ra,0x0
 a70:	ca2080e7          	jalr	-862(ra) # 70e <putc>
          s++;
 a74:	fe843783          	ld	a5,-24(s0)
 a78:	0785                	addi	a5,a5,1
 a7a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a7e:	fe843783          	ld	a5,-24(s0)
 a82:	0007c783          	lbu	a5,0(a5)
 a86:	fbf9                	bnez	a5,a5c <vprintf+0x184>
 a88:	a069                	j	b12 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a8a:	fdc42783          	lw	a5,-36(s0)
 a8e:	0007871b          	sext.w	a4,a5
 a92:	06300793          	li	a5,99
 a96:	02f71463          	bne	a4,a5,abe <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a9a:	fb843783          	ld	a5,-72(s0)
 a9e:	00878713          	addi	a4,a5,8
 aa2:	fae43c23          	sd	a4,-72(s0)
 aa6:	439c                	lw	a5,0(a5)
 aa8:	0ff7f713          	zext.b	a4,a5
 aac:	fcc42783          	lw	a5,-52(s0)
 ab0:	85ba                	mv	a1,a4
 ab2:	853e                	mv	a0,a5
 ab4:	00000097          	auipc	ra,0x0
 ab8:	c5a080e7          	jalr	-934(ra) # 70e <putc>
 abc:	a899                	j	b12 <vprintf+0x23a>
      } else if(c == '%'){
 abe:	fdc42783          	lw	a5,-36(s0)
 ac2:	0007871b          	sext.w	a4,a5
 ac6:	02500793          	li	a5,37
 aca:	00f71f63          	bne	a4,a5,ae8 <vprintf+0x210>
        putc(fd, c);
 ace:	fdc42783          	lw	a5,-36(s0)
 ad2:	0ff7f713          	zext.b	a4,a5
 ad6:	fcc42783          	lw	a5,-52(s0)
 ada:	85ba                	mv	a1,a4
 adc:	853e                	mv	a0,a5
 ade:	00000097          	auipc	ra,0x0
 ae2:	c30080e7          	jalr	-976(ra) # 70e <putc>
 ae6:	a035                	j	b12 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 ae8:	fcc42783          	lw	a5,-52(s0)
 aec:	02500593          	li	a1,37
 af0:	853e                	mv	a0,a5
 af2:	00000097          	auipc	ra,0x0
 af6:	c1c080e7          	jalr	-996(ra) # 70e <putc>
        putc(fd, c);
 afa:	fdc42783          	lw	a5,-36(s0)
 afe:	0ff7f713          	zext.b	a4,a5
 b02:	fcc42783          	lw	a5,-52(s0)
 b06:	85ba                	mv	a1,a4
 b08:	853e                	mv	a0,a5
 b0a:	00000097          	auipc	ra,0x0
 b0e:	c04080e7          	jalr	-1020(ra) # 70e <putc>
      }
      state = 0;
 b12:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 b16:	fe442783          	lw	a5,-28(s0)
 b1a:	2785                	addiw	a5,a5,1
 b1c:	fef42223          	sw	a5,-28(s0)
 b20:	fe442783          	lw	a5,-28(s0)
 b24:	fc043703          	ld	a4,-64(s0)
 b28:	97ba                	add	a5,a5,a4
 b2a:	0007c783          	lbu	a5,0(a5)
 b2e:	dc0795e3          	bnez	a5,8f8 <vprintf+0x20>
    }
  }
}
 b32:	0001                	nop
 b34:	0001                	nop
 b36:	60a6                	ld	ra,72(sp)
 b38:	6406                	ld	s0,64(sp)
 b3a:	6161                	addi	sp,sp,80
 b3c:	8082                	ret

0000000000000b3e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b3e:	7159                	addi	sp,sp,-112
 b40:	fc06                	sd	ra,56(sp)
 b42:	f822                	sd	s0,48(sp)
 b44:	0080                	addi	s0,sp,64
 b46:	fcb43823          	sd	a1,-48(s0)
 b4a:	e010                	sd	a2,0(s0)
 b4c:	e414                	sd	a3,8(s0)
 b4e:	e818                	sd	a4,16(s0)
 b50:	ec1c                	sd	a5,24(s0)
 b52:	03043023          	sd	a6,32(s0)
 b56:	03143423          	sd	a7,40(s0)
 b5a:	87aa                	mv	a5,a0
 b5c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 b60:	03040793          	addi	a5,s0,48
 b64:	fcf43423          	sd	a5,-56(s0)
 b68:	fc843783          	ld	a5,-56(s0)
 b6c:	fd078793          	addi	a5,a5,-48
 b70:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 b74:	fe843703          	ld	a4,-24(s0)
 b78:	fdc42783          	lw	a5,-36(s0)
 b7c:	863a                	mv	a2,a4
 b7e:	fd043583          	ld	a1,-48(s0)
 b82:	853e                	mv	a0,a5
 b84:	00000097          	auipc	ra,0x0
 b88:	d54080e7          	jalr	-684(ra) # 8d8 <vprintf>
}
 b8c:	0001                	nop
 b8e:	70e2                	ld	ra,56(sp)
 b90:	7442                	ld	s0,48(sp)
 b92:	6165                	addi	sp,sp,112
 b94:	8082                	ret

0000000000000b96 <printf>:

void
printf(const char *fmt, ...)
{
 b96:	7159                	addi	sp,sp,-112
 b98:	f406                	sd	ra,40(sp)
 b9a:	f022                	sd	s0,32(sp)
 b9c:	1800                	addi	s0,sp,48
 b9e:	fca43c23          	sd	a0,-40(s0)
 ba2:	e40c                	sd	a1,8(s0)
 ba4:	e810                	sd	a2,16(s0)
 ba6:	ec14                	sd	a3,24(s0)
 ba8:	f018                	sd	a4,32(s0)
 baa:	f41c                	sd	a5,40(s0)
 bac:	03043823          	sd	a6,48(s0)
 bb0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bb4:	04040793          	addi	a5,s0,64
 bb8:	fcf43823          	sd	a5,-48(s0)
 bbc:	fd043783          	ld	a5,-48(s0)
 bc0:	fc878793          	addi	a5,a5,-56
 bc4:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 bc8:	fe843783          	ld	a5,-24(s0)
 bcc:	863e                	mv	a2,a5
 bce:	fd843583          	ld	a1,-40(s0)
 bd2:	4505                	li	a0,1
 bd4:	00000097          	auipc	ra,0x0
 bd8:	d04080e7          	jalr	-764(ra) # 8d8 <vprintf>
}
 bdc:	0001                	nop
 bde:	70a2                	ld	ra,40(sp)
 be0:	7402                	ld	s0,32(sp)
 be2:	6165                	addi	sp,sp,112
 be4:	8082                	ret

0000000000000be6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be6:	7179                	addi	sp,sp,-48
 be8:	f422                	sd	s0,40(sp)
 bea:	1800                	addi	s0,sp,48
 bec:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bf0:	fd843783          	ld	a5,-40(s0)
 bf4:	17c1                	addi	a5,a5,-16
 bf6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bfa:	00000797          	auipc	a5,0x0
 bfe:	7a678793          	addi	a5,a5,1958 # 13a0 <freep>
 c02:	639c                	ld	a5,0(a5)
 c04:	fef43423          	sd	a5,-24(s0)
 c08:	a815                	j	c3c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c0a:	fe843783          	ld	a5,-24(s0)
 c0e:	639c                	ld	a5,0(a5)
 c10:	fe843703          	ld	a4,-24(s0)
 c14:	00f76f63          	bltu	a4,a5,c32 <free+0x4c>
 c18:	fe043703          	ld	a4,-32(s0)
 c1c:	fe843783          	ld	a5,-24(s0)
 c20:	02e7eb63          	bltu	a5,a4,c56 <free+0x70>
 c24:	fe843783          	ld	a5,-24(s0)
 c28:	639c                	ld	a5,0(a5)
 c2a:	fe043703          	ld	a4,-32(s0)
 c2e:	02f76463          	bltu	a4,a5,c56 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c32:	fe843783          	ld	a5,-24(s0)
 c36:	639c                	ld	a5,0(a5)
 c38:	fef43423          	sd	a5,-24(s0)
 c3c:	fe043703          	ld	a4,-32(s0)
 c40:	fe843783          	ld	a5,-24(s0)
 c44:	fce7f3e3          	bgeu	a5,a4,c0a <free+0x24>
 c48:	fe843783          	ld	a5,-24(s0)
 c4c:	639c                	ld	a5,0(a5)
 c4e:	fe043703          	ld	a4,-32(s0)
 c52:	faf77ce3          	bgeu	a4,a5,c0a <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c56:	fe043783          	ld	a5,-32(s0)
 c5a:	479c                	lw	a5,8(a5)
 c5c:	1782                	slli	a5,a5,0x20
 c5e:	9381                	srli	a5,a5,0x20
 c60:	0792                	slli	a5,a5,0x4
 c62:	fe043703          	ld	a4,-32(s0)
 c66:	973e                	add	a4,a4,a5
 c68:	fe843783          	ld	a5,-24(s0)
 c6c:	639c                	ld	a5,0(a5)
 c6e:	02f71763          	bne	a4,a5,c9c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 c72:	fe043783          	ld	a5,-32(s0)
 c76:	4798                	lw	a4,8(a5)
 c78:	fe843783          	ld	a5,-24(s0)
 c7c:	639c                	ld	a5,0(a5)
 c7e:	479c                	lw	a5,8(a5)
 c80:	9fb9                	addw	a5,a5,a4
 c82:	0007871b          	sext.w	a4,a5
 c86:	fe043783          	ld	a5,-32(s0)
 c8a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c8c:	fe843783          	ld	a5,-24(s0)
 c90:	639c                	ld	a5,0(a5)
 c92:	6398                	ld	a4,0(a5)
 c94:	fe043783          	ld	a5,-32(s0)
 c98:	e398                	sd	a4,0(a5)
 c9a:	a039                	j	ca8 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c9c:	fe843783          	ld	a5,-24(s0)
 ca0:	6398                	ld	a4,0(a5)
 ca2:	fe043783          	ld	a5,-32(s0)
 ca6:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 ca8:	fe843783          	ld	a5,-24(s0)
 cac:	479c                	lw	a5,8(a5)
 cae:	1782                	slli	a5,a5,0x20
 cb0:	9381                	srli	a5,a5,0x20
 cb2:	0792                	slli	a5,a5,0x4
 cb4:	fe843703          	ld	a4,-24(s0)
 cb8:	97ba                	add	a5,a5,a4
 cba:	fe043703          	ld	a4,-32(s0)
 cbe:	02f71563          	bne	a4,a5,ce8 <free+0x102>
    p->s.size += bp->s.size;
 cc2:	fe843783          	ld	a5,-24(s0)
 cc6:	4798                	lw	a4,8(a5)
 cc8:	fe043783          	ld	a5,-32(s0)
 ccc:	479c                	lw	a5,8(a5)
 cce:	9fb9                	addw	a5,a5,a4
 cd0:	0007871b          	sext.w	a4,a5
 cd4:	fe843783          	ld	a5,-24(s0)
 cd8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 cda:	fe043783          	ld	a5,-32(s0)
 cde:	6398                	ld	a4,0(a5)
 ce0:	fe843783          	ld	a5,-24(s0)
 ce4:	e398                	sd	a4,0(a5)
 ce6:	a031                	j	cf2 <free+0x10c>
  } else
    p->s.ptr = bp;
 ce8:	fe843783          	ld	a5,-24(s0)
 cec:	fe043703          	ld	a4,-32(s0)
 cf0:	e398                	sd	a4,0(a5)
  freep = p;
 cf2:	00000797          	auipc	a5,0x0
 cf6:	6ae78793          	addi	a5,a5,1710 # 13a0 <freep>
 cfa:	fe843703          	ld	a4,-24(s0)
 cfe:	e398                	sd	a4,0(a5)
}
 d00:	0001                	nop
 d02:	7422                	ld	s0,40(sp)
 d04:	6145                	addi	sp,sp,48
 d06:	8082                	ret

0000000000000d08 <morecore>:

static Header*
morecore(uint nu)
{
 d08:	7179                	addi	sp,sp,-48
 d0a:	f406                	sd	ra,40(sp)
 d0c:	f022                	sd	s0,32(sp)
 d0e:	1800                	addi	s0,sp,48
 d10:	87aa                	mv	a5,a0
 d12:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 d16:	fdc42783          	lw	a5,-36(s0)
 d1a:	0007871b          	sext.w	a4,a5
 d1e:	6785                	lui	a5,0x1
 d20:	00f77563          	bgeu	a4,a5,d2a <morecore+0x22>
    nu = 4096;
 d24:	6785                	lui	a5,0x1
 d26:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 d2a:	fdc42783          	lw	a5,-36(s0)
 d2e:	0047979b          	slliw	a5,a5,0x4
 d32:	2781                	sext.w	a5,a5
 d34:	2781                	sext.w	a5,a5
 d36:	853e                	mv	a0,a5
 d38:	00000097          	auipc	ra,0x0
 d3c:	986080e7          	jalr	-1658(ra) # 6be <sbrk>
 d40:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 d44:	fe843703          	ld	a4,-24(s0)
 d48:	57fd                	li	a5,-1
 d4a:	00f71463          	bne	a4,a5,d52 <morecore+0x4a>
    return 0;
 d4e:	4781                	li	a5,0
 d50:	a03d                	j	d7e <morecore+0x76>
  hp = (Header*)p;
 d52:	fe843783          	ld	a5,-24(s0)
 d56:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 d5a:	fe043783          	ld	a5,-32(s0)
 d5e:	fdc42703          	lw	a4,-36(s0)
 d62:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 d64:	fe043783          	ld	a5,-32(s0)
 d68:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x288>
 d6a:	853e                	mv	a0,a5
 d6c:	00000097          	auipc	ra,0x0
 d70:	e7a080e7          	jalr	-390(ra) # be6 <free>
  return freep;
 d74:	00000797          	auipc	a5,0x0
 d78:	62c78793          	addi	a5,a5,1580 # 13a0 <freep>
 d7c:	639c                	ld	a5,0(a5)
}
 d7e:	853e                	mv	a0,a5
 d80:	70a2                	ld	ra,40(sp)
 d82:	7402                	ld	s0,32(sp)
 d84:	6145                	addi	sp,sp,48
 d86:	8082                	ret

0000000000000d88 <malloc>:

void*
malloc(uint nbytes)
{
 d88:	7139                	addi	sp,sp,-64
 d8a:	fc06                	sd	ra,56(sp)
 d8c:	f822                	sd	s0,48(sp)
 d8e:	0080                	addi	s0,sp,64
 d90:	87aa                	mv	a5,a0
 d92:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d96:	fcc46783          	lwu	a5,-52(s0)
 d9a:	07bd                	addi	a5,a5,15
 d9c:	8391                	srli	a5,a5,0x4
 d9e:	2781                	sext.w	a5,a5
 da0:	2785                	addiw	a5,a5,1
 da2:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 da6:	00000797          	auipc	a5,0x0
 daa:	5fa78793          	addi	a5,a5,1530 # 13a0 <freep>
 dae:	639c                	ld	a5,0(a5)
 db0:	fef43023          	sd	a5,-32(s0)
 db4:	fe043783          	ld	a5,-32(s0)
 db8:	ef95                	bnez	a5,df4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 dba:	00000797          	auipc	a5,0x0
 dbe:	5d678793          	addi	a5,a5,1494 # 1390 <base>
 dc2:	fef43023          	sd	a5,-32(s0)
 dc6:	00000797          	auipc	a5,0x0
 dca:	5da78793          	addi	a5,a5,1498 # 13a0 <freep>
 dce:	fe043703          	ld	a4,-32(s0)
 dd2:	e398                	sd	a4,0(a5)
 dd4:	00000797          	auipc	a5,0x0
 dd8:	5cc78793          	addi	a5,a5,1484 # 13a0 <freep>
 ddc:	6398                	ld	a4,0(a5)
 dde:	00000797          	auipc	a5,0x0
 de2:	5b278793          	addi	a5,a5,1458 # 1390 <base>
 de6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 de8:	00000797          	auipc	a5,0x0
 dec:	5a878793          	addi	a5,a5,1448 # 1390 <base>
 df0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 df4:	fe043783          	ld	a5,-32(s0)
 df8:	639c                	ld	a5,0(a5)
 dfa:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 dfe:	fe843783          	ld	a5,-24(s0)
 e02:	4798                	lw	a4,8(a5)
 e04:	fdc42783          	lw	a5,-36(s0)
 e08:	2781                	sext.w	a5,a5
 e0a:	06f76763          	bltu	a4,a5,e78 <malloc+0xf0>
      if(p->s.size == nunits)
 e0e:	fe843783          	ld	a5,-24(s0)
 e12:	4798                	lw	a4,8(a5)
 e14:	fdc42783          	lw	a5,-36(s0)
 e18:	2781                	sext.w	a5,a5
 e1a:	00e79963          	bne	a5,a4,e2c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 e1e:	fe843783          	ld	a5,-24(s0)
 e22:	6398                	ld	a4,0(a5)
 e24:	fe043783          	ld	a5,-32(s0)
 e28:	e398                	sd	a4,0(a5)
 e2a:	a825                	j	e62 <malloc+0xda>
      else {
        p->s.size -= nunits;
 e2c:	fe843783          	ld	a5,-24(s0)
 e30:	479c                	lw	a5,8(a5)
 e32:	fdc42703          	lw	a4,-36(s0)
 e36:	9f99                	subw	a5,a5,a4
 e38:	0007871b          	sext.w	a4,a5
 e3c:	fe843783          	ld	a5,-24(s0)
 e40:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e42:	fe843783          	ld	a5,-24(s0)
 e46:	479c                	lw	a5,8(a5)
 e48:	1782                	slli	a5,a5,0x20
 e4a:	9381                	srli	a5,a5,0x20
 e4c:	0792                	slli	a5,a5,0x4
 e4e:	fe843703          	ld	a4,-24(s0)
 e52:	97ba                	add	a5,a5,a4
 e54:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 e58:	fe843783          	ld	a5,-24(s0)
 e5c:	fdc42703          	lw	a4,-36(s0)
 e60:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 e62:	00000797          	auipc	a5,0x0
 e66:	53e78793          	addi	a5,a5,1342 # 13a0 <freep>
 e6a:	fe043703          	ld	a4,-32(s0)
 e6e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 e70:	fe843783          	ld	a5,-24(s0)
 e74:	07c1                	addi	a5,a5,16
 e76:	a091                	j	eba <malloc+0x132>
    }
    if(p == freep)
 e78:	00000797          	auipc	a5,0x0
 e7c:	52878793          	addi	a5,a5,1320 # 13a0 <freep>
 e80:	639c                	ld	a5,0(a5)
 e82:	fe843703          	ld	a4,-24(s0)
 e86:	02f71063          	bne	a4,a5,ea6 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 e8a:	fdc42783          	lw	a5,-36(s0)
 e8e:	853e                	mv	a0,a5
 e90:	00000097          	auipc	ra,0x0
 e94:	e78080e7          	jalr	-392(ra) # d08 <morecore>
 e98:	fea43423          	sd	a0,-24(s0)
 e9c:	fe843783          	ld	a5,-24(s0)
 ea0:	e399                	bnez	a5,ea6 <malloc+0x11e>
        return 0;
 ea2:	4781                	li	a5,0
 ea4:	a819                	j	eba <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ea6:	fe843783          	ld	a5,-24(s0)
 eaa:	fef43023          	sd	a5,-32(s0)
 eae:	fe843783          	ld	a5,-24(s0)
 eb2:	639c                	ld	a5,0(a5)
 eb4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 eb8:	b799                	j	dfe <malloc+0x76>
  }
}
 eba:	853e                	mv	a0,a5
 ebc:	70e2                	ld	ra,56(sp)
 ebe:	7442                	ld	s0,48(sp)
 ec0:	6121                	addi	sp,sp,64
 ec2:	8082                	ret
