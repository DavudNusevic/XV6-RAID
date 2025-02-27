
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
  12:	fdc42783          	lw	a5,-36(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	4785                	li	a5,1
  1c:	02e7c063          	blt	a5,a4,3c <main+0x3c>
    fprintf(2, "usage: kill pid...\n");
  20:	00001597          	auipc	a1,0x1
  24:	db058593          	addi	a1,a1,-592 # dd0 <malloc+0x144>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	a18080e7          	jalr	-1512(ra) # a42 <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	506080e7          	jalr	1286(ra) # 53a <exit>
  }
  for(i=1; i<argc; i++)
  3c:	4785                	li	a5,1
  3e:	fef42623          	sw	a5,-20(s0)
  42:	a805                	j	72 <main+0x72>
    kill(atoi(argv[i]));
  44:	fec42783          	lw	a5,-20(s0)
  48:	078e                	slli	a5,a5,0x3
  4a:	fd043703          	ld	a4,-48(s0)
  4e:	97ba                	add	a5,a5,a4
  50:	639c                	ld	a5,0(a5)
  52:	853e                	mv	a0,a5
  54:	00000097          	auipc	ra,0x0
  58:	2ec080e7          	jalr	748(ra) # 340 <atoi>
  5c:	87aa                	mv	a5,a0
  5e:	853e                	mv	a0,a5
  60:	00000097          	auipc	ra,0x0
  64:	50a080e7          	jalr	1290(ra) # 56a <kill>
  for(i=1; i<argc; i++)
  68:	fec42783          	lw	a5,-20(s0)
  6c:	2785                	addiw	a5,a5,1
  6e:	fef42623          	sw	a5,-20(s0)
  72:	fec42783          	lw	a5,-20(s0)
  76:	873e                	mv	a4,a5
  78:	fdc42783          	lw	a5,-36(s0)
  7c:	2701                	sext.w	a4,a4
  7e:	2781                	sext.w	a5,a5
  80:	fcf742e3          	blt	a4,a5,44 <main+0x44>
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	4b4080e7          	jalr	1204(ra) # 53a <exit>

000000000000008e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  8e:	1141                	addi	sp,sp,-16
  90:	e406                	sd	ra,8(sp)
  92:	e022                	sd	s0,0(sp)
  94:	0800                	addi	s0,sp,16
  extern int main();
  main();
  96:	00000097          	auipc	ra,0x0
  9a:	f6a080e7          	jalr	-150(ra) # 0 <main>
  exit(0);
  9e:	4501                	li	a0,0
  a0:	00000097          	auipc	ra,0x0
  a4:	49a080e7          	jalr	1178(ra) # 53a <exit>

00000000000000a8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  a8:	7179                	addi	sp,sp,-48
  aa:	f422                	sd	s0,40(sp)
  ac:	1800                	addi	s0,sp,48
  ae:	fca43c23          	sd	a0,-40(s0)
  b2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  b6:	fd843783          	ld	a5,-40(s0)
  ba:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  be:	0001                	nop
  c0:	fd043703          	ld	a4,-48(s0)
  c4:	00170793          	addi	a5,a4,1
  c8:	fcf43823          	sd	a5,-48(s0)
  cc:	fd843783          	ld	a5,-40(s0)
  d0:	00178693          	addi	a3,a5,1
  d4:	fcd43c23          	sd	a3,-40(s0)
  d8:	00074703          	lbu	a4,0(a4)
  dc:	00e78023          	sb	a4,0(a5)
  e0:	0007c783          	lbu	a5,0(a5)
  e4:	fff1                	bnez	a5,c0 <strcpy+0x18>
    ;
  return os;
  e6:	fe843783          	ld	a5,-24(s0)
}
  ea:	853e                	mv	a0,a5
  ec:	7422                	ld	s0,40(sp)
  ee:	6145                	addi	sp,sp,48
  f0:	8082                	ret

00000000000000f2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f2:	1101                	addi	sp,sp,-32
  f4:	ec22                	sd	s0,24(sp)
  f6:	1000                	addi	s0,sp,32
  f8:	fea43423          	sd	a0,-24(s0)
  fc:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 100:	a819                	j	116 <strcmp+0x24>
    p++, q++;
 102:	fe843783          	ld	a5,-24(s0)
 106:	0785                	addi	a5,a5,1
 108:	fef43423          	sd	a5,-24(s0)
 10c:	fe043783          	ld	a5,-32(s0)
 110:	0785                	addi	a5,a5,1
 112:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 116:	fe843783          	ld	a5,-24(s0)
 11a:	0007c783          	lbu	a5,0(a5)
 11e:	cb99                	beqz	a5,134 <strcmp+0x42>
 120:	fe843783          	ld	a5,-24(s0)
 124:	0007c703          	lbu	a4,0(a5)
 128:	fe043783          	ld	a5,-32(s0)
 12c:	0007c783          	lbu	a5,0(a5)
 130:	fcf709e3          	beq	a4,a5,102 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 134:	fe843783          	ld	a5,-24(s0)
 138:	0007c783          	lbu	a5,0(a5)
 13c:	0007871b          	sext.w	a4,a5
 140:	fe043783          	ld	a5,-32(s0)
 144:	0007c783          	lbu	a5,0(a5)
 148:	2781                	sext.w	a5,a5
 14a:	40f707bb          	subw	a5,a4,a5
 14e:	2781                	sext.w	a5,a5
}
 150:	853e                	mv	a0,a5
 152:	6462                	ld	s0,24(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret

0000000000000158 <strlen>:

uint
strlen(const char *s)
{
 158:	7179                	addi	sp,sp,-48
 15a:	f422                	sd	s0,40(sp)
 15c:	1800                	addi	s0,sp,48
 15e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 162:	fe042623          	sw	zero,-20(s0)
 166:	a031                	j	172 <strlen+0x1a>
 168:	fec42783          	lw	a5,-20(s0)
 16c:	2785                	addiw	a5,a5,1
 16e:	fef42623          	sw	a5,-20(s0)
 172:	fec42783          	lw	a5,-20(s0)
 176:	fd843703          	ld	a4,-40(s0)
 17a:	97ba                	add	a5,a5,a4
 17c:	0007c783          	lbu	a5,0(a5)
 180:	f7e5                	bnez	a5,168 <strlen+0x10>
    ;
  return n;
 182:	fec42783          	lw	a5,-20(s0)
}
 186:	853e                	mv	a0,a5
 188:	7422                	ld	s0,40(sp)
 18a:	6145                	addi	sp,sp,48
 18c:	8082                	ret

000000000000018e <memset>:

void*
memset(void *dst, int c, uint n)
{
 18e:	7179                	addi	sp,sp,-48
 190:	f422                	sd	s0,40(sp)
 192:	1800                	addi	s0,sp,48
 194:	fca43c23          	sd	a0,-40(s0)
 198:	87ae                	mv	a5,a1
 19a:	8732                	mv	a4,a2
 19c:	fcf42a23          	sw	a5,-44(s0)
 1a0:	87ba                	mv	a5,a4
 1a2:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1a6:	fd843783          	ld	a5,-40(s0)
 1aa:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1ae:	fe042623          	sw	zero,-20(s0)
 1b2:	a00d                	j	1d4 <memset+0x46>
    cdst[i] = c;
 1b4:	fec42783          	lw	a5,-20(s0)
 1b8:	fe043703          	ld	a4,-32(s0)
 1bc:	97ba                	add	a5,a5,a4
 1be:	fd442703          	lw	a4,-44(s0)
 1c2:	0ff77713          	zext.b	a4,a4
 1c6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1ca:	fec42783          	lw	a5,-20(s0)
 1ce:	2785                	addiw	a5,a5,1
 1d0:	fef42623          	sw	a5,-20(s0)
 1d4:	fec42703          	lw	a4,-20(s0)
 1d8:	fd042783          	lw	a5,-48(s0)
 1dc:	2781                	sext.w	a5,a5
 1de:	fcf76be3          	bltu	a4,a5,1b4 <memset+0x26>
  }
  return dst;
 1e2:	fd843783          	ld	a5,-40(s0)
}
 1e6:	853e                	mv	a0,a5
 1e8:	7422                	ld	s0,40(sp)
 1ea:	6145                	addi	sp,sp,48
 1ec:	8082                	ret

00000000000001ee <strchr>:

char*
strchr(const char *s, char c)
{
 1ee:	1101                	addi	sp,sp,-32
 1f0:	ec22                	sd	s0,24(sp)
 1f2:	1000                	addi	s0,sp,32
 1f4:	fea43423          	sd	a0,-24(s0)
 1f8:	87ae                	mv	a5,a1
 1fa:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1fe:	a01d                	j	224 <strchr+0x36>
    if(*s == c)
 200:	fe843783          	ld	a5,-24(s0)
 204:	0007c703          	lbu	a4,0(a5)
 208:	fe744783          	lbu	a5,-25(s0)
 20c:	0ff7f793          	zext.b	a5,a5
 210:	00e79563          	bne	a5,a4,21a <strchr+0x2c>
      return (char*)s;
 214:	fe843783          	ld	a5,-24(s0)
 218:	a821                	j	230 <strchr+0x42>
  for(; *s; s++)
 21a:	fe843783          	ld	a5,-24(s0)
 21e:	0785                	addi	a5,a5,1
 220:	fef43423          	sd	a5,-24(s0)
 224:	fe843783          	ld	a5,-24(s0)
 228:	0007c783          	lbu	a5,0(a5)
 22c:	fbf1                	bnez	a5,200 <strchr+0x12>
  return 0;
 22e:	4781                	li	a5,0
}
 230:	853e                	mv	a0,a5
 232:	6462                	ld	s0,24(sp)
 234:	6105                	addi	sp,sp,32
 236:	8082                	ret

0000000000000238 <gets>:

char*
gets(char *buf, int max)
{
 238:	7179                	addi	sp,sp,-48
 23a:	f406                	sd	ra,40(sp)
 23c:	f022                	sd	s0,32(sp)
 23e:	1800                	addi	s0,sp,48
 240:	fca43c23          	sd	a0,-40(s0)
 244:	87ae                	mv	a5,a1
 246:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24a:	fe042623          	sw	zero,-20(s0)
 24e:	a8a1                	j	2a6 <gets+0x6e>
    cc = read(0, &c, 1);
 250:	fe740793          	addi	a5,s0,-25
 254:	4605                	li	a2,1
 256:	85be                	mv	a1,a5
 258:	4501                	li	a0,0
 25a:	00000097          	auipc	ra,0x0
 25e:	2f8080e7          	jalr	760(ra) # 552 <read>
 262:	87aa                	mv	a5,a0
 264:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 268:	fe842783          	lw	a5,-24(s0)
 26c:	2781                	sext.w	a5,a5
 26e:	04f05763          	blez	a5,2bc <gets+0x84>
      break;
    buf[i++] = c;
 272:	fec42783          	lw	a5,-20(s0)
 276:	0017871b          	addiw	a4,a5,1
 27a:	fee42623          	sw	a4,-20(s0)
 27e:	873e                	mv	a4,a5
 280:	fd843783          	ld	a5,-40(s0)
 284:	97ba                	add	a5,a5,a4
 286:	fe744703          	lbu	a4,-25(s0)
 28a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 28e:	fe744783          	lbu	a5,-25(s0)
 292:	873e                	mv	a4,a5
 294:	47a9                	li	a5,10
 296:	02f70463          	beq	a4,a5,2be <gets+0x86>
 29a:	fe744783          	lbu	a5,-25(s0)
 29e:	873e                	mv	a4,a5
 2a0:	47b5                	li	a5,13
 2a2:	00f70e63          	beq	a4,a5,2be <gets+0x86>
  for(i=0; i+1 < max; ){
 2a6:	fec42783          	lw	a5,-20(s0)
 2aa:	2785                	addiw	a5,a5,1
 2ac:	0007871b          	sext.w	a4,a5
 2b0:	fd442783          	lw	a5,-44(s0)
 2b4:	2781                	sext.w	a5,a5
 2b6:	f8f74de3          	blt	a4,a5,250 <gets+0x18>
 2ba:	a011                	j	2be <gets+0x86>
      break;
 2bc:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2be:	fec42783          	lw	a5,-20(s0)
 2c2:	fd843703          	ld	a4,-40(s0)
 2c6:	97ba                	add	a5,a5,a4
 2c8:	00078023          	sb	zero,0(a5)
  return buf;
 2cc:	fd843783          	ld	a5,-40(s0)
}
 2d0:	853e                	mv	a0,a5
 2d2:	70a2                	ld	ra,40(sp)
 2d4:	7402                	ld	s0,32(sp)
 2d6:	6145                	addi	sp,sp,48
 2d8:	8082                	ret

00000000000002da <stat>:

int
stat(const char *n, struct stat *st)
{
 2da:	7179                	addi	sp,sp,-48
 2dc:	f406                	sd	ra,40(sp)
 2de:	f022                	sd	s0,32(sp)
 2e0:	1800                	addi	s0,sp,48
 2e2:	fca43c23          	sd	a0,-40(s0)
 2e6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ea:	4581                	li	a1,0
 2ec:	fd843503          	ld	a0,-40(s0)
 2f0:	00000097          	auipc	ra,0x0
 2f4:	28a080e7          	jalr	650(ra) # 57a <open>
 2f8:	87aa                	mv	a5,a0
 2fa:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2fe:	fec42783          	lw	a5,-20(s0)
 302:	2781                	sext.w	a5,a5
 304:	0007d463          	bgez	a5,30c <stat+0x32>
    return -1;
 308:	57fd                	li	a5,-1
 30a:	a035                	j	336 <stat+0x5c>
  r = fstat(fd, st);
 30c:	fec42783          	lw	a5,-20(s0)
 310:	fd043583          	ld	a1,-48(s0)
 314:	853e                	mv	a0,a5
 316:	00000097          	auipc	ra,0x0
 31a:	27c080e7          	jalr	636(ra) # 592 <fstat>
 31e:	87aa                	mv	a5,a0
 320:	fef42423          	sw	a5,-24(s0)
  close(fd);
 324:	fec42783          	lw	a5,-20(s0)
 328:	853e                	mv	a0,a5
 32a:	00000097          	auipc	ra,0x0
 32e:	238080e7          	jalr	568(ra) # 562 <close>
  return r;
 332:	fe842783          	lw	a5,-24(s0)
}
 336:	853e                	mv	a0,a5
 338:	70a2                	ld	ra,40(sp)
 33a:	7402                	ld	s0,32(sp)
 33c:	6145                	addi	sp,sp,48
 33e:	8082                	ret

0000000000000340 <atoi>:

int
atoi(const char *s)
{
 340:	7179                	addi	sp,sp,-48
 342:	f422                	sd	s0,40(sp)
 344:	1800                	addi	s0,sp,48
 346:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 34a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 34e:	a81d                	j	384 <atoi+0x44>
    n = n*10 + *s++ - '0';
 350:	fec42783          	lw	a5,-20(s0)
 354:	873e                	mv	a4,a5
 356:	87ba                	mv	a5,a4
 358:	0027979b          	slliw	a5,a5,0x2
 35c:	9fb9                	addw	a5,a5,a4
 35e:	0017979b          	slliw	a5,a5,0x1
 362:	0007871b          	sext.w	a4,a5
 366:	fd843783          	ld	a5,-40(s0)
 36a:	00178693          	addi	a3,a5,1
 36e:	fcd43c23          	sd	a3,-40(s0)
 372:	0007c783          	lbu	a5,0(a5)
 376:	2781                	sext.w	a5,a5
 378:	9fb9                	addw	a5,a5,a4
 37a:	2781                	sext.w	a5,a5
 37c:	fd07879b          	addiw	a5,a5,-48
 380:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 384:	fd843783          	ld	a5,-40(s0)
 388:	0007c783          	lbu	a5,0(a5)
 38c:	873e                	mv	a4,a5
 38e:	02f00793          	li	a5,47
 392:	00e7fb63          	bgeu	a5,a4,3a8 <atoi+0x68>
 396:	fd843783          	ld	a5,-40(s0)
 39a:	0007c783          	lbu	a5,0(a5)
 39e:	873e                	mv	a4,a5
 3a0:	03900793          	li	a5,57
 3a4:	fae7f6e3          	bgeu	a5,a4,350 <atoi+0x10>
  return n;
 3a8:	fec42783          	lw	a5,-20(s0)
}
 3ac:	853e                	mv	a0,a5
 3ae:	7422                	ld	s0,40(sp)
 3b0:	6145                	addi	sp,sp,48
 3b2:	8082                	ret

00000000000003b4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b4:	7139                	addi	sp,sp,-64
 3b6:	fc22                	sd	s0,56(sp)
 3b8:	0080                	addi	s0,sp,64
 3ba:	fca43c23          	sd	a0,-40(s0)
 3be:	fcb43823          	sd	a1,-48(s0)
 3c2:	87b2                	mv	a5,a2
 3c4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3c8:	fd843783          	ld	a5,-40(s0)
 3cc:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3d0:	fd043783          	ld	a5,-48(s0)
 3d4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3d8:	fe043703          	ld	a4,-32(s0)
 3dc:	fe843783          	ld	a5,-24(s0)
 3e0:	02e7fc63          	bgeu	a5,a4,418 <memmove+0x64>
    while(n-- > 0)
 3e4:	a00d                	j	406 <memmove+0x52>
      *dst++ = *src++;
 3e6:	fe043703          	ld	a4,-32(s0)
 3ea:	00170793          	addi	a5,a4,1
 3ee:	fef43023          	sd	a5,-32(s0)
 3f2:	fe843783          	ld	a5,-24(s0)
 3f6:	00178693          	addi	a3,a5,1
 3fa:	fed43423          	sd	a3,-24(s0)
 3fe:	00074703          	lbu	a4,0(a4)
 402:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 406:	fcc42783          	lw	a5,-52(s0)
 40a:	fff7871b          	addiw	a4,a5,-1
 40e:	fce42623          	sw	a4,-52(s0)
 412:	fcf04ae3          	bgtz	a5,3e6 <memmove+0x32>
 416:	a891                	j	46a <memmove+0xb6>
  } else {
    dst += n;
 418:	fcc42783          	lw	a5,-52(s0)
 41c:	fe843703          	ld	a4,-24(s0)
 420:	97ba                	add	a5,a5,a4
 422:	fef43423          	sd	a5,-24(s0)
    src += n;
 426:	fcc42783          	lw	a5,-52(s0)
 42a:	fe043703          	ld	a4,-32(s0)
 42e:	97ba                	add	a5,a5,a4
 430:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 434:	a01d                	j	45a <memmove+0xa6>
      *--dst = *--src;
 436:	fe043783          	ld	a5,-32(s0)
 43a:	17fd                	addi	a5,a5,-1
 43c:	fef43023          	sd	a5,-32(s0)
 440:	fe843783          	ld	a5,-24(s0)
 444:	17fd                	addi	a5,a5,-1
 446:	fef43423          	sd	a5,-24(s0)
 44a:	fe043783          	ld	a5,-32(s0)
 44e:	0007c703          	lbu	a4,0(a5)
 452:	fe843783          	ld	a5,-24(s0)
 456:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 45a:	fcc42783          	lw	a5,-52(s0)
 45e:	fff7871b          	addiw	a4,a5,-1
 462:	fce42623          	sw	a4,-52(s0)
 466:	fcf048e3          	bgtz	a5,436 <memmove+0x82>
  }
  return vdst;
 46a:	fd843783          	ld	a5,-40(s0)
}
 46e:	853e                	mv	a0,a5
 470:	7462                	ld	s0,56(sp)
 472:	6121                	addi	sp,sp,64
 474:	8082                	ret

0000000000000476 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 476:	7139                	addi	sp,sp,-64
 478:	fc22                	sd	s0,56(sp)
 47a:	0080                	addi	s0,sp,64
 47c:	fca43c23          	sd	a0,-40(s0)
 480:	fcb43823          	sd	a1,-48(s0)
 484:	87b2                	mv	a5,a2
 486:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 48a:	fd843783          	ld	a5,-40(s0)
 48e:	fef43423          	sd	a5,-24(s0)
 492:	fd043783          	ld	a5,-48(s0)
 496:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 49a:	a0a1                	j	4e2 <memcmp+0x6c>
    if (*p1 != *p2) {
 49c:	fe843783          	ld	a5,-24(s0)
 4a0:	0007c703          	lbu	a4,0(a5)
 4a4:	fe043783          	ld	a5,-32(s0)
 4a8:	0007c783          	lbu	a5,0(a5)
 4ac:	02f70163          	beq	a4,a5,4ce <memcmp+0x58>
      return *p1 - *p2;
 4b0:	fe843783          	ld	a5,-24(s0)
 4b4:	0007c783          	lbu	a5,0(a5)
 4b8:	0007871b          	sext.w	a4,a5
 4bc:	fe043783          	ld	a5,-32(s0)
 4c0:	0007c783          	lbu	a5,0(a5)
 4c4:	2781                	sext.w	a5,a5
 4c6:	40f707bb          	subw	a5,a4,a5
 4ca:	2781                	sext.w	a5,a5
 4cc:	a01d                	j	4f2 <memcmp+0x7c>
    }
    p1++;
 4ce:	fe843783          	ld	a5,-24(s0)
 4d2:	0785                	addi	a5,a5,1
 4d4:	fef43423          	sd	a5,-24(s0)
    p2++;
 4d8:	fe043783          	ld	a5,-32(s0)
 4dc:	0785                	addi	a5,a5,1
 4de:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4e2:	fcc42783          	lw	a5,-52(s0)
 4e6:	fff7871b          	addiw	a4,a5,-1
 4ea:	fce42623          	sw	a4,-52(s0)
 4ee:	f7dd                	bnez	a5,49c <memcmp+0x26>
  }
  return 0;
 4f0:	4781                	li	a5,0
}
 4f2:	853e                	mv	a0,a5
 4f4:	7462                	ld	s0,56(sp)
 4f6:	6121                	addi	sp,sp,64
 4f8:	8082                	ret

00000000000004fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4fa:	7179                	addi	sp,sp,-48
 4fc:	f406                	sd	ra,40(sp)
 4fe:	f022                	sd	s0,32(sp)
 500:	1800                	addi	s0,sp,48
 502:	fea43423          	sd	a0,-24(s0)
 506:	feb43023          	sd	a1,-32(s0)
 50a:	87b2                	mv	a5,a2
 50c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 510:	fdc42783          	lw	a5,-36(s0)
 514:	863e                	mv	a2,a5
 516:	fe043583          	ld	a1,-32(s0)
 51a:	fe843503          	ld	a0,-24(s0)
 51e:	00000097          	auipc	ra,0x0
 522:	e96080e7          	jalr	-362(ra) # 3b4 <memmove>
 526:	87aa                	mv	a5,a0
}
 528:	853e                	mv	a0,a5
 52a:	70a2                	ld	ra,40(sp)
 52c:	7402                	ld	s0,32(sp)
 52e:	6145                	addi	sp,sp,48
 530:	8082                	ret

0000000000000532 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 532:	4885                	li	a7,1
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <exit>:
.global exit
exit:
 li a7, SYS_exit
 53a:	4889                	li	a7,2
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <wait>:
.global wait
wait:
 li a7, SYS_wait
 542:	488d                	li	a7,3
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 54a:	4891                	li	a7,4
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <read>:
.global read
read:
 li a7, SYS_read
 552:	4895                	li	a7,5
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <write>:
.global write
write:
 li a7, SYS_write
 55a:	48c1                	li	a7,16
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <close>:
.global close
close:
 li a7, SYS_close
 562:	48d5                	li	a7,21
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <kill>:
.global kill
kill:
 li a7, SYS_kill
 56a:	4899                	li	a7,6
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <exec>:
.global exec
exec:
 li a7, SYS_exec
 572:	489d                	li	a7,7
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <open>:
.global open
open:
 li a7, SYS_open
 57a:	48bd                	li	a7,15
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 582:	48c5                	li	a7,17
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 58a:	48c9                	li	a7,18
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 592:	48a1                	li	a7,8
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <link>:
.global link
link:
 li a7, SYS_link
 59a:	48cd                	li	a7,19
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a2:	48d1                	li	a7,20
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5aa:	48a5                	li	a7,9
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b2:	48a9                	li	a7,10
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ba:	48ad                	li	a7,11
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c2:	48b1                	li	a7,12
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ca:	48b5                	li	a7,13
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d2:	48b9                	li	a7,14
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
 5da:	48d9                	li	a7,22
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
 5e2:	48dd                	li	a7,23
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
 5ea:	48e1                	li	a7,24
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
 5f2:	48e5                	li	a7,25
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
 5fa:	48e9                	li	a7,26
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
 602:	48ed                	li	a7,27
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
 60a:	48f1                	li	a7,28
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 612:	1101                	addi	sp,sp,-32
 614:	ec06                	sd	ra,24(sp)
 616:	e822                	sd	s0,16(sp)
 618:	1000                	addi	s0,sp,32
 61a:	87aa                	mv	a5,a0
 61c:	872e                	mv	a4,a1
 61e:	fef42623          	sw	a5,-20(s0)
 622:	87ba                	mv	a5,a4
 624:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 628:	feb40713          	addi	a4,s0,-21
 62c:	fec42783          	lw	a5,-20(s0)
 630:	4605                	li	a2,1
 632:	85ba                	mv	a1,a4
 634:	853e                	mv	a0,a5
 636:	00000097          	auipc	ra,0x0
 63a:	f24080e7          	jalr	-220(ra) # 55a <write>
}
 63e:	0001                	nop
 640:	60e2                	ld	ra,24(sp)
 642:	6442                	ld	s0,16(sp)
 644:	6105                	addi	sp,sp,32
 646:	8082                	ret

0000000000000648 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 648:	7139                	addi	sp,sp,-64
 64a:	fc06                	sd	ra,56(sp)
 64c:	f822                	sd	s0,48(sp)
 64e:	0080                	addi	s0,sp,64
 650:	87aa                	mv	a5,a0
 652:	8736                	mv	a4,a3
 654:	fcf42623          	sw	a5,-52(s0)
 658:	87ae                	mv	a5,a1
 65a:	fcf42423          	sw	a5,-56(s0)
 65e:	87b2                	mv	a5,a2
 660:	fcf42223          	sw	a5,-60(s0)
 664:	87ba                	mv	a5,a4
 666:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 66a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 66e:	fc042783          	lw	a5,-64(s0)
 672:	2781                	sext.w	a5,a5
 674:	c38d                	beqz	a5,696 <printint+0x4e>
 676:	fc842783          	lw	a5,-56(s0)
 67a:	2781                	sext.w	a5,a5
 67c:	0007dd63          	bgez	a5,696 <printint+0x4e>
    neg = 1;
 680:	4785                	li	a5,1
 682:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 686:	fc842783          	lw	a5,-56(s0)
 68a:	40f007bb          	negw	a5,a5
 68e:	2781                	sext.w	a5,a5
 690:	fef42223          	sw	a5,-28(s0)
 694:	a029                	j	69e <printint+0x56>
  } else {
    x = xx;
 696:	fc842783          	lw	a5,-56(s0)
 69a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 69e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6a2:	fc442783          	lw	a5,-60(s0)
 6a6:	fe442703          	lw	a4,-28(s0)
 6aa:	02f777bb          	remuw	a5,a4,a5
 6ae:	0007861b          	sext.w	a2,a5
 6b2:	fec42783          	lw	a5,-20(s0)
 6b6:	0017871b          	addiw	a4,a5,1
 6ba:	fee42623          	sw	a4,-20(s0)
 6be:	00001697          	auipc	a3,0x1
 6c2:	cb268693          	addi	a3,a3,-846 # 1370 <digits>
 6c6:	02061713          	slli	a4,a2,0x20
 6ca:	9301                	srli	a4,a4,0x20
 6cc:	9736                	add	a4,a4,a3
 6ce:	00074703          	lbu	a4,0(a4)
 6d2:	17c1                	addi	a5,a5,-16
 6d4:	97a2                	add	a5,a5,s0
 6d6:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6da:	fc442783          	lw	a5,-60(s0)
 6de:	fe442703          	lw	a4,-28(s0)
 6e2:	02f757bb          	divuw	a5,a4,a5
 6e6:	fef42223          	sw	a5,-28(s0)
 6ea:	fe442783          	lw	a5,-28(s0)
 6ee:	2781                	sext.w	a5,a5
 6f0:	fbcd                	bnez	a5,6a2 <printint+0x5a>
  if(neg)
 6f2:	fe842783          	lw	a5,-24(s0)
 6f6:	2781                	sext.w	a5,a5
 6f8:	cf85                	beqz	a5,730 <printint+0xe8>
    buf[i++] = '-';
 6fa:	fec42783          	lw	a5,-20(s0)
 6fe:	0017871b          	addiw	a4,a5,1
 702:	fee42623          	sw	a4,-20(s0)
 706:	17c1                	addi	a5,a5,-16
 708:	97a2                	add	a5,a5,s0
 70a:	02d00713          	li	a4,45
 70e:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 712:	a839                	j	730 <printint+0xe8>
    putc(fd, buf[i]);
 714:	fec42783          	lw	a5,-20(s0)
 718:	17c1                	addi	a5,a5,-16
 71a:	97a2                	add	a5,a5,s0
 71c:	fe07c703          	lbu	a4,-32(a5)
 720:	fcc42783          	lw	a5,-52(s0)
 724:	85ba                	mv	a1,a4
 726:	853e                	mv	a0,a5
 728:	00000097          	auipc	ra,0x0
 72c:	eea080e7          	jalr	-278(ra) # 612 <putc>
  while(--i >= 0)
 730:	fec42783          	lw	a5,-20(s0)
 734:	37fd                	addiw	a5,a5,-1
 736:	fef42623          	sw	a5,-20(s0)
 73a:	fec42783          	lw	a5,-20(s0)
 73e:	2781                	sext.w	a5,a5
 740:	fc07dae3          	bgez	a5,714 <printint+0xcc>
}
 744:	0001                	nop
 746:	0001                	nop
 748:	70e2                	ld	ra,56(sp)
 74a:	7442                	ld	s0,48(sp)
 74c:	6121                	addi	sp,sp,64
 74e:	8082                	ret

0000000000000750 <printptr>:

static void
printptr(int fd, uint64 x) {
 750:	7179                	addi	sp,sp,-48
 752:	f406                	sd	ra,40(sp)
 754:	f022                	sd	s0,32(sp)
 756:	1800                	addi	s0,sp,48
 758:	87aa                	mv	a5,a0
 75a:	fcb43823          	sd	a1,-48(s0)
 75e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 762:	fdc42783          	lw	a5,-36(s0)
 766:	03000593          	li	a1,48
 76a:	853e                	mv	a0,a5
 76c:	00000097          	auipc	ra,0x0
 770:	ea6080e7          	jalr	-346(ra) # 612 <putc>
  putc(fd, 'x');
 774:	fdc42783          	lw	a5,-36(s0)
 778:	07800593          	li	a1,120
 77c:	853e                	mv	a0,a5
 77e:	00000097          	auipc	ra,0x0
 782:	e94080e7          	jalr	-364(ra) # 612 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 786:	fe042623          	sw	zero,-20(s0)
 78a:	a82d                	j	7c4 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 78c:	fd043783          	ld	a5,-48(s0)
 790:	93f1                	srli	a5,a5,0x3c
 792:	00001717          	auipc	a4,0x1
 796:	bde70713          	addi	a4,a4,-1058 # 1370 <digits>
 79a:	97ba                	add	a5,a5,a4
 79c:	0007c703          	lbu	a4,0(a5)
 7a0:	fdc42783          	lw	a5,-36(s0)
 7a4:	85ba                	mv	a1,a4
 7a6:	853e                	mv	a0,a5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	e6a080e7          	jalr	-406(ra) # 612 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b0:	fec42783          	lw	a5,-20(s0)
 7b4:	2785                	addiw	a5,a5,1
 7b6:	fef42623          	sw	a5,-20(s0)
 7ba:	fd043783          	ld	a5,-48(s0)
 7be:	0792                	slli	a5,a5,0x4
 7c0:	fcf43823          	sd	a5,-48(s0)
 7c4:	fec42783          	lw	a5,-20(s0)
 7c8:	873e                	mv	a4,a5
 7ca:	47bd                	li	a5,15
 7cc:	fce7f0e3          	bgeu	a5,a4,78c <printptr+0x3c>
}
 7d0:	0001                	nop
 7d2:	0001                	nop
 7d4:	70a2                	ld	ra,40(sp)
 7d6:	7402                	ld	s0,32(sp)
 7d8:	6145                	addi	sp,sp,48
 7da:	8082                	ret

00000000000007dc <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7dc:	715d                	addi	sp,sp,-80
 7de:	e486                	sd	ra,72(sp)
 7e0:	e0a2                	sd	s0,64(sp)
 7e2:	0880                	addi	s0,sp,80
 7e4:	87aa                	mv	a5,a0
 7e6:	fcb43023          	sd	a1,-64(s0)
 7ea:	fac43c23          	sd	a2,-72(s0)
 7ee:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7f2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7f6:	fe042223          	sw	zero,-28(s0)
 7fa:	a42d                	j	a24 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7fc:	fe442783          	lw	a5,-28(s0)
 800:	fc043703          	ld	a4,-64(s0)
 804:	97ba                	add	a5,a5,a4
 806:	0007c783          	lbu	a5,0(a5)
 80a:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 80e:	fe042783          	lw	a5,-32(s0)
 812:	2781                	sext.w	a5,a5
 814:	eb9d                	bnez	a5,84a <vprintf+0x6e>
      if(c == '%'){
 816:	fdc42783          	lw	a5,-36(s0)
 81a:	0007871b          	sext.w	a4,a5
 81e:	02500793          	li	a5,37
 822:	00f71763          	bne	a4,a5,830 <vprintf+0x54>
        state = '%';
 826:	02500793          	li	a5,37
 82a:	fef42023          	sw	a5,-32(s0)
 82e:	a2f5                	j	a1a <vprintf+0x23e>
      } else {
        putc(fd, c);
 830:	fdc42783          	lw	a5,-36(s0)
 834:	0ff7f713          	zext.b	a4,a5
 838:	fcc42783          	lw	a5,-52(s0)
 83c:	85ba                	mv	a1,a4
 83e:	853e                	mv	a0,a5
 840:	00000097          	auipc	ra,0x0
 844:	dd2080e7          	jalr	-558(ra) # 612 <putc>
 848:	aac9                	j	a1a <vprintf+0x23e>
      }
    } else if(state == '%'){
 84a:	fe042783          	lw	a5,-32(s0)
 84e:	0007871b          	sext.w	a4,a5
 852:	02500793          	li	a5,37
 856:	1cf71263          	bne	a4,a5,a1a <vprintf+0x23e>
      if(c == 'd'){
 85a:	fdc42783          	lw	a5,-36(s0)
 85e:	0007871b          	sext.w	a4,a5
 862:	06400793          	li	a5,100
 866:	02f71463          	bne	a4,a5,88e <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 86a:	fb843783          	ld	a5,-72(s0)
 86e:	00878713          	addi	a4,a5,8
 872:	fae43c23          	sd	a4,-72(s0)
 876:	4398                	lw	a4,0(a5)
 878:	fcc42783          	lw	a5,-52(s0)
 87c:	4685                	li	a3,1
 87e:	4629                	li	a2,10
 880:	85ba                	mv	a1,a4
 882:	853e                	mv	a0,a5
 884:	00000097          	auipc	ra,0x0
 888:	dc4080e7          	jalr	-572(ra) # 648 <printint>
 88c:	a269                	j	a16 <vprintf+0x23a>
      } else if(c == 'l') {
 88e:	fdc42783          	lw	a5,-36(s0)
 892:	0007871b          	sext.w	a4,a5
 896:	06c00793          	li	a5,108
 89a:	02f71663          	bne	a4,a5,8c6 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 89e:	fb843783          	ld	a5,-72(s0)
 8a2:	00878713          	addi	a4,a5,8
 8a6:	fae43c23          	sd	a4,-72(s0)
 8aa:	639c                	ld	a5,0(a5)
 8ac:	0007871b          	sext.w	a4,a5
 8b0:	fcc42783          	lw	a5,-52(s0)
 8b4:	4681                	li	a3,0
 8b6:	4629                	li	a2,10
 8b8:	85ba                	mv	a1,a4
 8ba:	853e                	mv	a0,a5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	d8c080e7          	jalr	-628(ra) # 648 <printint>
 8c4:	aa89                	j	a16 <vprintf+0x23a>
      } else if(c == 'x') {
 8c6:	fdc42783          	lw	a5,-36(s0)
 8ca:	0007871b          	sext.w	a4,a5
 8ce:	07800793          	li	a5,120
 8d2:	02f71463          	bne	a4,a5,8fa <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8d6:	fb843783          	ld	a5,-72(s0)
 8da:	00878713          	addi	a4,a5,8
 8de:	fae43c23          	sd	a4,-72(s0)
 8e2:	4398                	lw	a4,0(a5)
 8e4:	fcc42783          	lw	a5,-52(s0)
 8e8:	4681                	li	a3,0
 8ea:	4641                	li	a2,16
 8ec:	85ba                	mv	a1,a4
 8ee:	853e                	mv	a0,a5
 8f0:	00000097          	auipc	ra,0x0
 8f4:	d58080e7          	jalr	-680(ra) # 648 <printint>
 8f8:	aa39                	j	a16 <vprintf+0x23a>
      } else if(c == 'p') {
 8fa:	fdc42783          	lw	a5,-36(s0)
 8fe:	0007871b          	sext.w	a4,a5
 902:	07000793          	li	a5,112
 906:	02f71263          	bne	a4,a5,92a <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 90a:	fb843783          	ld	a5,-72(s0)
 90e:	00878713          	addi	a4,a5,8
 912:	fae43c23          	sd	a4,-72(s0)
 916:	6398                	ld	a4,0(a5)
 918:	fcc42783          	lw	a5,-52(s0)
 91c:	85ba                	mv	a1,a4
 91e:	853e                	mv	a0,a5
 920:	00000097          	auipc	ra,0x0
 924:	e30080e7          	jalr	-464(ra) # 750 <printptr>
 928:	a0fd                	j	a16 <vprintf+0x23a>
      } else if(c == 's'){
 92a:	fdc42783          	lw	a5,-36(s0)
 92e:	0007871b          	sext.w	a4,a5
 932:	07300793          	li	a5,115
 936:	04f71c63          	bne	a4,a5,98e <vprintf+0x1b2>
        s = va_arg(ap, char*);
 93a:	fb843783          	ld	a5,-72(s0)
 93e:	00878713          	addi	a4,a5,8
 942:	fae43c23          	sd	a4,-72(s0)
 946:	639c                	ld	a5,0(a5)
 948:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 94c:	fe843783          	ld	a5,-24(s0)
 950:	eb8d                	bnez	a5,982 <vprintf+0x1a6>
          s = "(null)";
 952:	00000797          	auipc	a5,0x0
 956:	49678793          	addi	a5,a5,1174 # de8 <malloc+0x15c>
 95a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 95e:	a015                	j	982 <vprintf+0x1a6>
          putc(fd, *s);
 960:	fe843783          	ld	a5,-24(s0)
 964:	0007c703          	lbu	a4,0(a5)
 968:	fcc42783          	lw	a5,-52(s0)
 96c:	85ba                	mv	a1,a4
 96e:	853e                	mv	a0,a5
 970:	00000097          	auipc	ra,0x0
 974:	ca2080e7          	jalr	-862(ra) # 612 <putc>
          s++;
 978:	fe843783          	ld	a5,-24(s0)
 97c:	0785                	addi	a5,a5,1
 97e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 982:	fe843783          	ld	a5,-24(s0)
 986:	0007c783          	lbu	a5,0(a5)
 98a:	fbf9                	bnez	a5,960 <vprintf+0x184>
 98c:	a069                	j	a16 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 98e:	fdc42783          	lw	a5,-36(s0)
 992:	0007871b          	sext.w	a4,a5
 996:	06300793          	li	a5,99
 99a:	02f71463          	bne	a4,a5,9c2 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 99e:	fb843783          	ld	a5,-72(s0)
 9a2:	00878713          	addi	a4,a5,8
 9a6:	fae43c23          	sd	a4,-72(s0)
 9aa:	439c                	lw	a5,0(a5)
 9ac:	0ff7f713          	zext.b	a4,a5
 9b0:	fcc42783          	lw	a5,-52(s0)
 9b4:	85ba                	mv	a1,a4
 9b6:	853e                	mv	a0,a5
 9b8:	00000097          	auipc	ra,0x0
 9bc:	c5a080e7          	jalr	-934(ra) # 612 <putc>
 9c0:	a899                	j	a16 <vprintf+0x23a>
      } else if(c == '%'){
 9c2:	fdc42783          	lw	a5,-36(s0)
 9c6:	0007871b          	sext.w	a4,a5
 9ca:	02500793          	li	a5,37
 9ce:	00f71f63          	bne	a4,a5,9ec <vprintf+0x210>
        putc(fd, c);
 9d2:	fdc42783          	lw	a5,-36(s0)
 9d6:	0ff7f713          	zext.b	a4,a5
 9da:	fcc42783          	lw	a5,-52(s0)
 9de:	85ba                	mv	a1,a4
 9e0:	853e                	mv	a0,a5
 9e2:	00000097          	auipc	ra,0x0
 9e6:	c30080e7          	jalr	-976(ra) # 612 <putc>
 9ea:	a035                	j	a16 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9ec:	fcc42783          	lw	a5,-52(s0)
 9f0:	02500593          	li	a1,37
 9f4:	853e                	mv	a0,a5
 9f6:	00000097          	auipc	ra,0x0
 9fa:	c1c080e7          	jalr	-996(ra) # 612 <putc>
        putc(fd, c);
 9fe:	fdc42783          	lw	a5,-36(s0)
 a02:	0ff7f713          	zext.b	a4,a5
 a06:	fcc42783          	lw	a5,-52(s0)
 a0a:	85ba                	mv	a1,a4
 a0c:	853e                	mv	a0,a5
 a0e:	00000097          	auipc	ra,0x0
 a12:	c04080e7          	jalr	-1020(ra) # 612 <putc>
      }
      state = 0;
 a16:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a1a:	fe442783          	lw	a5,-28(s0)
 a1e:	2785                	addiw	a5,a5,1
 a20:	fef42223          	sw	a5,-28(s0)
 a24:	fe442783          	lw	a5,-28(s0)
 a28:	fc043703          	ld	a4,-64(s0)
 a2c:	97ba                	add	a5,a5,a4
 a2e:	0007c783          	lbu	a5,0(a5)
 a32:	dc0795e3          	bnez	a5,7fc <vprintf+0x20>
    }
  }
}
 a36:	0001                	nop
 a38:	0001                	nop
 a3a:	60a6                	ld	ra,72(sp)
 a3c:	6406                	ld	s0,64(sp)
 a3e:	6161                	addi	sp,sp,80
 a40:	8082                	ret

0000000000000a42 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a42:	7159                	addi	sp,sp,-112
 a44:	fc06                	sd	ra,56(sp)
 a46:	f822                	sd	s0,48(sp)
 a48:	0080                	addi	s0,sp,64
 a4a:	fcb43823          	sd	a1,-48(s0)
 a4e:	e010                	sd	a2,0(s0)
 a50:	e414                	sd	a3,8(s0)
 a52:	e818                	sd	a4,16(s0)
 a54:	ec1c                	sd	a5,24(s0)
 a56:	03043023          	sd	a6,32(s0)
 a5a:	03143423          	sd	a7,40(s0)
 a5e:	87aa                	mv	a5,a0
 a60:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a64:	03040793          	addi	a5,s0,48
 a68:	fcf43423          	sd	a5,-56(s0)
 a6c:	fc843783          	ld	a5,-56(s0)
 a70:	fd078793          	addi	a5,a5,-48
 a74:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a78:	fe843703          	ld	a4,-24(s0)
 a7c:	fdc42783          	lw	a5,-36(s0)
 a80:	863a                	mv	a2,a4
 a82:	fd043583          	ld	a1,-48(s0)
 a86:	853e                	mv	a0,a5
 a88:	00000097          	auipc	ra,0x0
 a8c:	d54080e7          	jalr	-684(ra) # 7dc <vprintf>
}
 a90:	0001                	nop
 a92:	70e2                	ld	ra,56(sp)
 a94:	7442                	ld	s0,48(sp)
 a96:	6165                	addi	sp,sp,112
 a98:	8082                	ret

0000000000000a9a <printf>:

void
printf(const char *fmt, ...)
{
 a9a:	7159                	addi	sp,sp,-112
 a9c:	f406                	sd	ra,40(sp)
 a9e:	f022                	sd	s0,32(sp)
 aa0:	1800                	addi	s0,sp,48
 aa2:	fca43c23          	sd	a0,-40(s0)
 aa6:	e40c                	sd	a1,8(s0)
 aa8:	e810                	sd	a2,16(s0)
 aaa:	ec14                	sd	a3,24(s0)
 aac:	f018                	sd	a4,32(s0)
 aae:	f41c                	sd	a5,40(s0)
 ab0:	03043823          	sd	a6,48(s0)
 ab4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ab8:	04040793          	addi	a5,s0,64
 abc:	fcf43823          	sd	a5,-48(s0)
 ac0:	fd043783          	ld	a5,-48(s0)
 ac4:	fc878793          	addi	a5,a5,-56
 ac8:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 acc:	fe843783          	ld	a5,-24(s0)
 ad0:	863e                	mv	a2,a5
 ad2:	fd843583          	ld	a1,-40(s0)
 ad6:	4505                	li	a0,1
 ad8:	00000097          	auipc	ra,0x0
 adc:	d04080e7          	jalr	-764(ra) # 7dc <vprintf>
}
 ae0:	0001                	nop
 ae2:	70a2                	ld	ra,40(sp)
 ae4:	7402                	ld	s0,32(sp)
 ae6:	6165                	addi	sp,sp,112
 ae8:	8082                	ret

0000000000000aea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aea:	7179                	addi	sp,sp,-48
 aec:	f422                	sd	s0,40(sp)
 aee:	1800                	addi	s0,sp,48
 af0:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 af4:	fd843783          	ld	a5,-40(s0)
 af8:	17c1                	addi	a5,a5,-16
 afa:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 afe:	00001797          	auipc	a5,0x1
 b02:	8a278793          	addi	a5,a5,-1886 # 13a0 <freep>
 b06:	639c                	ld	a5,0(a5)
 b08:	fef43423          	sd	a5,-24(s0)
 b0c:	a815                	j	b40 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0e:	fe843783          	ld	a5,-24(s0)
 b12:	639c                	ld	a5,0(a5)
 b14:	fe843703          	ld	a4,-24(s0)
 b18:	00f76f63          	bltu	a4,a5,b36 <free+0x4c>
 b1c:	fe043703          	ld	a4,-32(s0)
 b20:	fe843783          	ld	a5,-24(s0)
 b24:	02e7eb63          	bltu	a5,a4,b5a <free+0x70>
 b28:	fe843783          	ld	a5,-24(s0)
 b2c:	639c                	ld	a5,0(a5)
 b2e:	fe043703          	ld	a4,-32(s0)
 b32:	02f76463          	bltu	a4,a5,b5a <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b36:	fe843783          	ld	a5,-24(s0)
 b3a:	639c                	ld	a5,0(a5)
 b3c:	fef43423          	sd	a5,-24(s0)
 b40:	fe043703          	ld	a4,-32(s0)
 b44:	fe843783          	ld	a5,-24(s0)
 b48:	fce7f3e3          	bgeu	a5,a4,b0e <free+0x24>
 b4c:	fe843783          	ld	a5,-24(s0)
 b50:	639c                	ld	a5,0(a5)
 b52:	fe043703          	ld	a4,-32(s0)
 b56:	faf77ce3          	bgeu	a4,a5,b0e <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b5a:	fe043783          	ld	a5,-32(s0)
 b5e:	479c                	lw	a5,8(a5)
 b60:	1782                	slli	a5,a5,0x20
 b62:	9381                	srli	a5,a5,0x20
 b64:	0792                	slli	a5,a5,0x4
 b66:	fe043703          	ld	a4,-32(s0)
 b6a:	973e                	add	a4,a4,a5
 b6c:	fe843783          	ld	a5,-24(s0)
 b70:	639c                	ld	a5,0(a5)
 b72:	02f71763          	bne	a4,a5,ba0 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b76:	fe043783          	ld	a5,-32(s0)
 b7a:	4798                	lw	a4,8(a5)
 b7c:	fe843783          	ld	a5,-24(s0)
 b80:	639c                	ld	a5,0(a5)
 b82:	479c                	lw	a5,8(a5)
 b84:	9fb9                	addw	a5,a5,a4
 b86:	0007871b          	sext.w	a4,a5
 b8a:	fe043783          	ld	a5,-32(s0)
 b8e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b90:	fe843783          	ld	a5,-24(s0)
 b94:	639c                	ld	a5,0(a5)
 b96:	6398                	ld	a4,0(a5)
 b98:	fe043783          	ld	a5,-32(s0)
 b9c:	e398                	sd	a4,0(a5)
 b9e:	a039                	j	bac <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 ba0:	fe843783          	ld	a5,-24(s0)
 ba4:	6398                	ld	a4,0(a5)
 ba6:	fe043783          	ld	a5,-32(s0)
 baa:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 bac:	fe843783          	ld	a5,-24(s0)
 bb0:	479c                	lw	a5,8(a5)
 bb2:	1782                	slli	a5,a5,0x20
 bb4:	9381                	srli	a5,a5,0x20
 bb6:	0792                	slli	a5,a5,0x4
 bb8:	fe843703          	ld	a4,-24(s0)
 bbc:	97ba                	add	a5,a5,a4
 bbe:	fe043703          	ld	a4,-32(s0)
 bc2:	02f71563          	bne	a4,a5,bec <free+0x102>
    p->s.size += bp->s.size;
 bc6:	fe843783          	ld	a5,-24(s0)
 bca:	4798                	lw	a4,8(a5)
 bcc:	fe043783          	ld	a5,-32(s0)
 bd0:	479c                	lw	a5,8(a5)
 bd2:	9fb9                	addw	a5,a5,a4
 bd4:	0007871b          	sext.w	a4,a5
 bd8:	fe843783          	ld	a5,-24(s0)
 bdc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bde:	fe043783          	ld	a5,-32(s0)
 be2:	6398                	ld	a4,0(a5)
 be4:	fe843783          	ld	a5,-24(s0)
 be8:	e398                	sd	a4,0(a5)
 bea:	a031                	j	bf6 <free+0x10c>
  } else
    p->s.ptr = bp;
 bec:	fe843783          	ld	a5,-24(s0)
 bf0:	fe043703          	ld	a4,-32(s0)
 bf4:	e398                	sd	a4,0(a5)
  freep = p;
 bf6:	00000797          	auipc	a5,0x0
 bfa:	7aa78793          	addi	a5,a5,1962 # 13a0 <freep>
 bfe:	fe843703          	ld	a4,-24(s0)
 c02:	e398                	sd	a4,0(a5)
}
 c04:	0001                	nop
 c06:	7422                	ld	s0,40(sp)
 c08:	6145                	addi	sp,sp,48
 c0a:	8082                	ret

0000000000000c0c <morecore>:

static Header*
morecore(uint nu)
{
 c0c:	7179                	addi	sp,sp,-48
 c0e:	f406                	sd	ra,40(sp)
 c10:	f022                	sd	s0,32(sp)
 c12:	1800                	addi	s0,sp,48
 c14:	87aa                	mv	a5,a0
 c16:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c1a:	fdc42783          	lw	a5,-36(s0)
 c1e:	0007871b          	sext.w	a4,a5
 c22:	6785                	lui	a5,0x1
 c24:	00f77563          	bgeu	a4,a5,c2e <morecore+0x22>
    nu = 4096;
 c28:	6785                	lui	a5,0x1
 c2a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c2e:	fdc42783          	lw	a5,-36(s0)
 c32:	0047979b          	slliw	a5,a5,0x4
 c36:	2781                	sext.w	a5,a5
 c38:	2781                	sext.w	a5,a5
 c3a:	853e                	mv	a0,a5
 c3c:	00000097          	auipc	ra,0x0
 c40:	986080e7          	jalr	-1658(ra) # 5c2 <sbrk>
 c44:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c48:	fe843703          	ld	a4,-24(s0)
 c4c:	57fd                	li	a5,-1
 c4e:	00f71463          	bne	a4,a5,c56 <morecore+0x4a>
    return 0;
 c52:	4781                	li	a5,0
 c54:	a03d                	j	c82 <morecore+0x76>
  hp = (Header*)p;
 c56:	fe843783          	ld	a5,-24(s0)
 c5a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c5e:	fe043783          	ld	a5,-32(s0)
 c62:	fdc42703          	lw	a4,-36(s0)
 c66:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c68:	fe043783          	ld	a5,-32(s0)
 c6c:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x384>
 c6e:	853e                	mv	a0,a5
 c70:	00000097          	auipc	ra,0x0
 c74:	e7a080e7          	jalr	-390(ra) # aea <free>
  return freep;
 c78:	00000797          	auipc	a5,0x0
 c7c:	72878793          	addi	a5,a5,1832 # 13a0 <freep>
 c80:	639c                	ld	a5,0(a5)
}
 c82:	853e                	mv	a0,a5
 c84:	70a2                	ld	ra,40(sp)
 c86:	7402                	ld	s0,32(sp)
 c88:	6145                	addi	sp,sp,48
 c8a:	8082                	ret

0000000000000c8c <malloc>:

void*
malloc(uint nbytes)
{
 c8c:	7139                	addi	sp,sp,-64
 c8e:	fc06                	sd	ra,56(sp)
 c90:	f822                	sd	s0,48(sp)
 c92:	0080                	addi	s0,sp,64
 c94:	87aa                	mv	a5,a0
 c96:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c9a:	fcc46783          	lwu	a5,-52(s0)
 c9e:	07bd                	addi	a5,a5,15
 ca0:	8391                	srli	a5,a5,0x4
 ca2:	2781                	sext.w	a5,a5
 ca4:	2785                	addiw	a5,a5,1
 ca6:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 caa:	00000797          	auipc	a5,0x0
 cae:	6f678793          	addi	a5,a5,1782 # 13a0 <freep>
 cb2:	639c                	ld	a5,0(a5)
 cb4:	fef43023          	sd	a5,-32(s0)
 cb8:	fe043783          	ld	a5,-32(s0)
 cbc:	ef95                	bnez	a5,cf8 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 cbe:	00000797          	auipc	a5,0x0
 cc2:	6d278793          	addi	a5,a5,1746 # 1390 <base>
 cc6:	fef43023          	sd	a5,-32(s0)
 cca:	00000797          	auipc	a5,0x0
 cce:	6d678793          	addi	a5,a5,1750 # 13a0 <freep>
 cd2:	fe043703          	ld	a4,-32(s0)
 cd6:	e398                	sd	a4,0(a5)
 cd8:	00000797          	auipc	a5,0x0
 cdc:	6c878793          	addi	a5,a5,1736 # 13a0 <freep>
 ce0:	6398                	ld	a4,0(a5)
 ce2:	00000797          	auipc	a5,0x0
 ce6:	6ae78793          	addi	a5,a5,1710 # 1390 <base>
 cea:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cec:	00000797          	auipc	a5,0x0
 cf0:	6a478793          	addi	a5,a5,1700 # 1390 <base>
 cf4:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cf8:	fe043783          	ld	a5,-32(s0)
 cfc:	639c                	ld	a5,0(a5)
 cfe:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d02:	fe843783          	ld	a5,-24(s0)
 d06:	4798                	lw	a4,8(a5)
 d08:	fdc42783          	lw	a5,-36(s0)
 d0c:	2781                	sext.w	a5,a5
 d0e:	06f76763          	bltu	a4,a5,d7c <malloc+0xf0>
      if(p->s.size == nunits)
 d12:	fe843783          	ld	a5,-24(s0)
 d16:	4798                	lw	a4,8(a5)
 d18:	fdc42783          	lw	a5,-36(s0)
 d1c:	2781                	sext.w	a5,a5
 d1e:	00e79963          	bne	a5,a4,d30 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d22:	fe843783          	ld	a5,-24(s0)
 d26:	6398                	ld	a4,0(a5)
 d28:	fe043783          	ld	a5,-32(s0)
 d2c:	e398                	sd	a4,0(a5)
 d2e:	a825                	j	d66 <malloc+0xda>
      else {
        p->s.size -= nunits;
 d30:	fe843783          	ld	a5,-24(s0)
 d34:	479c                	lw	a5,8(a5)
 d36:	fdc42703          	lw	a4,-36(s0)
 d3a:	9f99                	subw	a5,a5,a4
 d3c:	0007871b          	sext.w	a4,a5
 d40:	fe843783          	ld	a5,-24(s0)
 d44:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d46:	fe843783          	ld	a5,-24(s0)
 d4a:	479c                	lw	a5,8(a5)
 d4c:	1782                	slli	a5,a5,0x20
 d4e:	9381                	srli	a5,a5,0x20
 d50:	0792                	slli	a5,a5,0x4
 d52:	fe843703          	ld	a4,-24(s0)
 d56:	97ba                	add	a5,a5,a4
 d58:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d5c:	fe843783          	ld	a5,-24(s0)
 d60:	fdc42703          	lw	a4,-36(s0)
 d64:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d66:	00000797          	auipc	a5,0x0
 d6a:	63a78793          	addi	a5,a5,1594 # 13a0 <freep>
 d6e:	fe043703          	ld	a4,-32(s0)
 d72:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d74:	fe843783          	ld	a5,-24(s0)
 d78:	07c1                	addi	a5,a5,16
 d7a:	a091                	j	dbe <malloc+0x132>
    }
    if(p == freep)
 d7c:	00000797          	auipc	a5,0x0
 d80:	62478793          	addi	a5,a5,1572 # 13a0 <freep>
 d84:	639c                	ld	a5,0(a5)
 d86:	fe843703          	ld	a4,-24(s0)
 d8a:	02f71063          	bne	a4,a5,daa <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 d8e:	fdc42783          	lw	a5,-36(s0)
 d92:	853e                	mv	a0,a5
 d94:	00000097          	auipc	ra,0x0
 d98:	e78080e7          	jalr	-392(ra) # c0c <morecore>
 d9c:	fea43423          	sd	a0,-24(s0)
 da0:	fe843783          	ld	a5,-24(s0)
 da4:	e399                	bnez	a5,daa <malloc+0x11e>
        return 0;
 da6:	4781                	li	a5,0
 da8:	a819                	j	dbe <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 daa:	fe843783          	ld	a5,-24(s0)
 dae:	fef43023          	sd	a5,-32(s0)
 db2:	fe843783          	ld	a5,-24(s0)
 db6:	639c                	ld	a5,0(a5)
 db8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 dbc:	b799                	j	d02 <malloc+0x76>
  }
}
 dbe:	853e                	mv	a0,a5
 dc0:	70e2                	ld	ra,56(sp)
 dc2:	7442                	ld	s0,48(sp)
 dc4:	6121                	addi	sp,sp,64
 dc6:	8082                	ret
