
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	4c6080e7          	jalr	1222(ra) # 4ce <fork>
  10:	87aa                	mv	a5,a0
  12:	00f05763          	blez	a5,20 <main+0x20>
    sleep(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	00000097          	auipc	ra,0x0
  1c:	54e080e7          	jalr	1358(ra) # 566 <sleep>
  exit(0);
  20:	4501                	li	a0,0
  22:	00000097          	auipc	ra,0x0
  26:	4b4080e7          	jalr	1204(ra) # 4d6 <exit>

000000000000002a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	addi	s0,sp,16
  extern int main();
  main();
  32:	00000097          	auipc	ra,0x0
  36:	fce080e7          	jalr	-50(ra) # 0 <main>
  exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	49a080e7          	jalr	1178(ra) # 4d6 <exit>

0000000000000044 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  44:	7179                	addi	sp,sp,-48
  46:	f422                	sd	s0,40(sp)
  48:	1800                	addi	s0,sp,48
  4a:	fca43c23          	sd	a0,-40(s0)
  4e:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  52:	fd843783          	ld	a5,-40(s0)
  56:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  5a:	0001                	nop
  5c:	fd043703          	ld	a4,-48(s0)
  60:	00170793          	addi	a5,a4,1
  64:	fcf43823          	sd	a5,-48(s0)
  68:	fd843783          	ld	a5,-40(s0)
  6c:	00178693          	addi	a3,a5,1
  70:	fcd43c23          	sd	a3,-40(s0)
  74:	00074703          	lbu	a4,0(a4)
  78:	00e78023          	sb	a4,0(a5)
  7c:	0007c783          	lbu	a5,0(a5)
  80:	fff1                	bnez	a5,5c <strcpy+0x18>
    ;
  return os;
  82:	fe843783          	ld	a5,-24(s0)
}
  86:	853e                	mv	a0,a5
  88:	7422                	ld	s0,40(sp)
  8a:	6145                	addi	sp,sp,48
  8c:	8082                	ret

000000000000008e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8e:	1101                	addi	sp,sp,-32
  90:	ec22                	sd	s0,24(sp)
  92:	1000                	addi	s0,sp,32
  94:	fea43423          	sd	a0,-24(s0)
  98:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  9c:	a819                	j	b2 <strcmp+0x24>
    p++, q++;
  9e:	fe843783          	ld	a5,-24(s0)
  a2:	0785                	addi	a5,a5,1
  a4:	fef43423          	sd	a5,-24(s0)
  a8:	fe043783          	ld	a5,-32(s0)
  ac:	0785                	addi	a5,a5,1
  ae:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  b2:	fe843783          	ld	a5,-24(s0)
  b6:	0007c783          	lbu	a5,0(a5)
  ba:	cb99                	beqz	a5,d0 <strcmp+0x42>
  bc:	fe843783          	ld	a5,-24(s0)
  c0:	0007c703          	lbu	a4,0(a5)
  c4:	fe043783          	ld	a5,-32(s0)
  c8:	0007c783          	lbu	a5,0(a5)
  cc:	fcf709e3          	beq	a4,a5,9e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
  d0:	fe843783          	ld	a5,-24(s0)
  d4:	0007c783          	lbu	a5,0(a5)
  d8:	0007871b          	sext.w	a4,a5
  dc:	fe043783          	ld	a5,-32(s0)
  e0:	0007c783          	lbu	a5,0(a5)
  e4:	2781                	sext.w	a5,a5
  e6:	40f707bb          	subw	a5,a4,a5
  ea:	2781                	sext.w	a5,a5
}
  ec:	853e                	mv	a0,a5
  ee:	6462                	ld	s0,24(sp)
  f0:	6105                	addi	sp,sp,32
  f2:	8082                	ret

00000000000000f4 <strlen>:

uint
strlen(const char *s)
{
  f4:	7179                	addi	sp,sp,-48
  f6:	f422                	sd	s0,40(sp)
  f8:	1800                	addi	s0,sp,48
  fa:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
  fe:	fe042623          	sw	zero,-20(s0)
 102:	a031                	j	10e <strlen+0x1a>
 104:	fec42783          	lw	a5,-20(s0)
 108:	2785                	addiw	a5,a5,1
 10a:	fef42623          	sw	a5,-20(s0)
 10e:	fec42783          	lw	a5,-20(s0)
 112:	fd843703          	ld	a4,-40(s0)
 116:	97ba                	add	a5,a5,a4
 118:	0007c783          	lbu	a5,0(a5)
 11c:	f7e5                	bnez	a5,104 <strlen+0x10>
    ;
  return n;
 11e:	fec42783          	lw	a5,-20(s0)
}
 122:	853e                	mv	a0,a5
 124:	7422                	ld	s0,40(sp)
 126:	6145                	addi	sp,sp,48
 128:	8082                	ret

000000000000012a <memset>:

void*
memset(void *dst, int c, uint n)
{
 12a:	7179                	addi	sp,sp,-48
 12c:	f422                	sd	s0,40(sp)
 12e:	1800                	addi	s0,sp,48
 130:	fca43c23          	sd	a0,-40(s0)
 134:	87ae                	mv	a5,a1
 136:	8732                	mv	a4,a2
 138:	fcf42a23          	sw	a5,-44(s0)
 13c:	87ba                	mv	a5,a4
 13e:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 142:	fd843783          	ld	a5,-40(s0)
 146:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 14a:	fe042623          	sw	zero,-20(s0)
 14e:	a00d                	j	170 <memset+0x46>
    cdst[i] = c;
 150:	fec42783          	lw	a5,-20(s0)
 154:	fe043703          	ld	a4,-32(s0)
 158:	97ba                	add	a5,a5,a4
 15a:	fd442703          	lw	a4,-44(s0)
 15e:	0ff77713          	zext.b	a4,a4
 162:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 166:	fec42783          	lw	a5,-20(s0)
 16a:	2785                	addiw	a5,a5,1
 16c:	fef42623          	sw	a5,-20(s0)
 170:	fec42703          	lw	a4,-20(s0)
 174:	fd042783          	lw	a5,-48(s0)
 178:	2781                	sext.w	a5,a5
 17a:	fcf76be3          	bltu	a4,a5,150 <memset+0x26>
  }
  return dst;
 17e:	fd843783          	ld	a5,-40(s0)
}
 182:	853e                	mv	a0,a5
 184:	7422                	ld	s0,40(sp)
 186:	6145                	addi	sp,sp,48
 188:	8082                	ret

000000000000018a <strchr>:

char*
strchr(const char *s, char c)
{
 18a:	1101                	addi	sp,sp,-32
 18c:	ec22                	sd	s0,24(sp)
 18e:	1000                	addi	s0,sp,32
 190:	fea43423          	sd	a0,-24(s0)
 194:	87ae                	mv	a5,a1
 196:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 19a:	a01d                	j	1c0 <strchr+0x36>
    if(*s == c)
 19c:	fe843783          	ld	a5,-24(s0)
 1a0:	0007c703          	lbu	a4,0(a5)
 1a4:	fe744783          	lbu	a5,-25(s0)
 1a8:	0ff7f793          	zext.b	a5,a5
 1ac:	00e79563          	bne	a5,a4,1b6 <strchr+0x2c>
      return (char*)s;
 1b0:	fe843783          	ld	a5,-24(s0)
 1b4:	a821                	j	1cc <strchr+0x42>
  for(; *s; s++)
 1b6:	fe843783          	ld	a5,-24(s0)
 1ba:	0785                	addi	a5,a5,1
 1bc:	fef43423          	sd	a5,-24(s0)
 1c0:	fe843783          	ld	a5,-24(s0)
 1c4:	0007c783          	lbu	a5,0(a5)
 1c8:	fbf1                	bnez	a5,19c <strchr+0x12>
  return 0;
 1ca:	4781                	li	a5,0
}
 1cc:	853e                	mv	a0,a5
 1ce:	6462                	ld	s0,24(sp)
 1d0:	6105                	addi	sp,sp,32
 1d2:	8082                	ret

00000000000001d4 <gets>:

char*
gets(char *buf, int max)
{
 1d4:	7179                	addi	sp,sp,-48
 1d6:	f406                	sd	ra,40(sp)
 1d8:	f022                	sd	s0,32(sp)
 1da:	1800                	addi	s0,sp,48
 1dc:	fca43c23          	sd	a0,-40(s0)
 1e0:	87ae                	mv	a5,a1
 1e2:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	fe042623          	sw	zero,-20(s0)
 1ea:	a8a1                	j	242 <gets+0x6e>
    cc = read(0, &c, 1);
 1ec:	fe740793          	addi	a5,s0,-25
 1f0:	4605                	li	a2,1
 1f2:	85be                	mv	a1,a5
 1f4:	4501                	li	a0,0
 1f6:	00000097          	auipc	ra,0x0
 1fa:	2f8080e7          	jalr	760(ra) # 4ee <read>
 1fe:	87aa                	mv	a5,a0
 200:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 204:	fe842783          	lw	a5,-24(s0)
 208:	2781                	sext.w	a5,a5
 20a:	04f05763          	blez	a5,258 <gets+0x84>
      break;
    buf[i++] = c;
 20e:	fec42783          	lw	a5,-20(s0)
 212:	0017871b          	addiw	a4,a5,1
 216:	fee42623          	sw	a4,-20(s0)
 21a:	873e                	mv	a4,a5
 21c:	fd843783          	ld	a5,-40(s0)
 220:	97ba                	add	a5,a5,a4
 222:	fe744703          	lbu	a4,-25(s0)
 226:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 22a:	fe744783          	lbu	a5,-25(s0)
 22e:	873e                	mv	a4,a5
 230:	47a9                	li	a5,10
 232:	02f70463          	beq	a4,a5,25a <gets+0x86>
 236:	fe744783          	lbu	a5,-25(s0)
 23a:	873e                	mv	a4,a5
 23c:	47b5                	li	a5,13
 23e:	00f70e63          	beq	a4,a5,25a <gets+0x86>
  for(i=0; i+1 < max; ){
 242:	fec42783          	lw	a5,-20(s0)
 246:	2785                	addiw	a5,a5,1
 248:	0007871b          	sext.w	a4,a5
 24c:	fd442783          	lw	a5,-44(s0)
 250:	2781                	sext.w	a5,a5
 252:	f8f74de3          	blt	a4,a5,1ec <gets+0x18>
 256:	a011                	j	25a <gets+0x86>
      break;
 258:	0001                	nop
      break;
  }
  buf[i] = '\0';
 25a:	fec42783          	lw	a5,-20(s0)
 25e:	fd843703          	ld	a4,-40(s0)
 262:	97ba                	add	a5,a5,a4
 264:	00078023          	sb	zero,0(a5)
  return buf;
 268:	fd843783          	ld	a5,-40(s0)
}
 26c:	853e                	mv	a0,a5
 26e:	70a2                	ld	ra,40(sp)
 270:	7402                	ld	s0,32(sp)
 272:	6145                	addi	sp,sp,48
 274:	8082                	ret

0000000000000276 <stat>:

int
stat(const char *n, struct stat *st)
{
 276:	7179                	addi	sp,sp,-48
 278:	f406                	sd	ra,40(sp)
 27a:	f022                	sd	s0,32(sp)
 27c:	1800                	addi	s0,sp,48
 27e:	fca43c23          	sd	a0,-40(s0)
 282:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 286:	4581                	li	a1,0
 288:	fd843503          	ld	a0,-40(s0)
 28c:	00000097          	auipc	ra,0x0
 290:	28a080e7          	jalr	650(ra) # 516 <open>
 294:	87aa                	mv	a5,a0
 296:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 29a:	fec42783          	lw	a5,-20(s0)
 29e:	2781                	sext.w	a5,a5
 2a0:	0007d463          	bgez	a5,2a8 <stat+0x32>
    return -1;
 2a4:	57fd                	li	a5,-1
 2a6:	a035                	j	2d2 <stat+0x5c>
  r = fstat(fd, st);
 2a8:	fec42783          	lw	a5,-20(s0)
 2ac:	fd043583          	ld	a1,-48(s0)
 2b0:	853e                	mv	a0,a5
 2b2:	00000097          	auipc	ra,0x0
 2b6:	27c080e7          	jalr	636(ra) # 52e <fstat>
 2ba:	87aa                	mv	a5,a0
 2bc:	fef42423          	sw	a5,-24(s0)
  close(fd);
 2c0:	fec42783          	lw	a5,-20(s0)
 2c4:	853e                	mv	a0,a5
 2c6:	00000097          	auipc	ra,0x0
 2ca:	238080e7          	jalr	568(ra) # 4fe <close>
  return r;
 2ce:	fe842783          	lw	a5,-24(s0)
}
 2d2:	853e                	mv	a0,a5
 2d4:	70a2                	ld	ra,40(sp)
 2d6:	7402                	ld	s0,32(sp)
 2d8:	6145                	addi	sp,sp,48
 2da:	8082                	ret

00000000000002dc <atoi>:

int
atoi(const char *s)
{
 2dc:	7179                	addi	sp,sp,-48
 2de:	f422                	sd	s0,40(sp)
 2e0:	1800                	addi	s0,sp,48
 2e2:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 2e6:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 2ea:	a81d                	j	320 <atoi+0x44>
    n = n*10 + *s++ - '0';
 2ec:	fec42783          	lw	a5,-20(s0)
 2f0:	873e                	mv	a4,a5
 2f2:	87ba                	mv	a5,a4
 2f4:	0027979b          	slliw	a5,a5,0x2
 2f8:	9fb9                	addw	a5,a5,a4
 2fa:	0017979b          	slliw	a5,a5,0x1
 2fe:	0007871b          	sext.w	a4,a5
 302:	fd843783          	ld	a5,-40(s0)
 306:	00178693          	addi	a3,a5,1
 30a:	fcd43c23          	sd	a3,-40(s0)
 30e:	0007c783          	lbu	a5,0(a5)
 312:	2781                	sext.w	a5,a5
 314:	9fb9                	addw	a5,a5,a4
 316:	2781                	sext.w	a5,a5
 318:	fd07879b          	addiw	a5,a5,-48
 31c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 320:	fd843783          	ld	a5,-40(s0)
 324:	0007c783          	lbu	a5,0(a5)
 328:	873e                	mv	a4,a5
 32a:	02f00793          	li	a5,47
 32e:	00e7fb63          	bgeu	a5,a4,344 <atoi+0x68>
 332:	fd843783          	ld	a5,-40(s0)
 336:	0007c783          	lbu	a5,0(a5)
 33a:	873e                	mv	a4,a5
 33c:	03900793          	li	a5,57
 340:	fae7f6e3          	bgeu	a5,a4,2ec <atoi+0x10>
  return n;
 344:	fec42783          	lw	a5,-20(s0)
}
 348:	853e                	mv	a0,a5
 34a:	7422                	ld	s0,40(sp)
 34c:	6145                	addi	sp,sp,48
 34e:	8082                	ret

0000000000000350 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 350:	7139                	addi	sp,sp,-64
 352:	fc22                	sd	s0,56(sp)
 354:	0080                	addi	s0,sp,64
 356:	fca43c23          	sd	a0,-40(s0)
 35a:	fcb43823          	sd	a1,-48(s0)
 35e:	87b2                	mv	a5,a2
 360:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 364:	fd843783          	ld	a5,-40(s0)
 368:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 36c:	fd043783          	ld	a5,-48(s0)
 370:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 374:	fe043703          	ld	a4,-32(s0)
 378:	fe843783          	ld	a5,-24(s0)
 37c:	02e7fc63          	bgeu	a5,a4,3b4 <memmove+0x64>
    while(n-- > 0)
 380:	a00d                	j	3a2 <memmove+0x52>
      *dst++ = *src++;
 382:	fe043703          	ld	a4,-32(s0)
 386:	00170793          	addi	a5,a4,1
 38a:	fef43023          	sd	a5,-32(s0)
 38e:	fe843783          	ld	a5,-24(s0)
 392:	00178693          	addi	a3,a5,1
 396:	fed43423          	sd	a3,-24(s0)
 39a:	00074703          	lbu	a4,0(a4)
 39e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3a2:	fcc42783          	lw	a5,-52(s0)
 3a6:	fff7871b          	addiw	a4,a5,-1
 3aa:	fce42623          	sw	a4,-52(s0)
 3ae:	fcf04ae3          	bgtz	a5,382 <memmove+0x32>
 3b2:	a891                	j	406 <memmove+0xb6>
  } else {
    dst += n;
 3b4:	fcc42783          	lw	a5,-52(s0)
 3b8:	fe843703          	ld	a4,-24(s0)
 3bc:	97ba                	add	a5,a5,a4
 3be:	fef43423          	sd	a5,-24(s0)
    src += n;
 3c2:	fcc42783          	lw	a5,-52(s0)
 3c6:	fe043703          	ld	a4,-32(s0)
 3ca:	97ba                	add	a5,a5,a4
 3cc:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 3d0:	a01d                	j	3f6 <memmove+0xa6>
      *--dst = *--src;
 3d2:	fe043783          	ld	a5,-32(s0)
 3d6:	17fd                	addi	a5,a5,-1
 3d8:	fef43023          	sd	a5,-32(s0)
 3dc:	fe843783          	ld	a5,-24(s0)
 3e0:	17fd                	addi	a5,a5,-1
 3e2:	fef43423          	sd	a5,-24(s0)
 3e6:	fe043783          	ld	a5,-32(s0)
 3ea:	0007c703          	lbu	a4,0(a5)
 3ee:	fe843783          	ld	a5,-24(s0)
 3f2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3f6:	fcc42783          	lw	a5,-52(s0)
 3fa:	fff7871b          	addiw	a4,a5,-1
 3fe:	fce42623          	sw	a4,-52(s0)
 402:	fcf048e3          	bgtz	a5,3d2 <memmove+0x82>
  }
  return vdst;
 406:	fd843783          	ld	a5,-40(s0)
}
 40a:	853e                	mv	a0,a5
 40c:	7462                	ld	s0,56(sp)
 40e:	6121                	addi	sp,sp,64
 410:	8082                	ret

0000000000000412 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 412:	7139                	addi	sp,sp,-64
 414:	fc22                	sd	s0,56(sp)
 416:	0080                	addi	s0,sp,64
 418:	fca43c23          	sd	a0,-40(s0)
 41c:	fcb43823          	sd	a1,-48(s0)
 420:	87b2                	mv	a5,a2
 422:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 426:	fd843783          	ld	a5,-40(s0)
 42a:	fef43423          	sd	a5,-24(s0)
 42e:	fd043783          	ld	a5,-48(s0)
 432:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 436:	a0a1                	j	47e <memcmp+0x6c>
    if (*p1 != *p2) {
 438:	fe843783          	ld	a5,-24(s0)
 43c:	0007c703          	lbu	a4,0(a5)
 440:	fe043783          	ld	a5,-32(s0)
 444:	0007c783          	lbu	a5,0(a5)
 448:	02f70163          	beq	a4,a5,46a <memcmp+0x58>
      return *p1 - *p2;
 44c:	fe843783          	ld	a5,-24(s0)
 450:	0007c783          	lbu	a5,0(a5)
 454:	0007871b          	sext.w	a4,a5
 458:	fe043783          	ld	a5,-32(s0)
 45c:	0007c783          	lbu	a5,0(a5)
 460:	2781                	sext.w	a5,a5
 462:	40f707bb          	subw	a5,a4,a5
 466:	2781                	sext.w	a5,a5
 468:	a01d                	j	48e <memcmp+0x7c>
    }
    p1++;
 46a:	fe843783          	ld	a5,-24(s0)
 46e:	0785                	addi	a5,a5,1
 470:	fef43423          	sd	a5,-24(s0)
    p2++;
 474:	fe043783          	ld	a5,-32(s0)
 478:	0785                	addi	a5,a5,1
 47a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 47e:	fcc42783          	lw	a5,-52(s0)
 482:	fff7871b          	addiw	a4,a5,-1
 486:	fce42623          	sw	a4,-52(s0)
 48a:	f7dd                	bnez	a5,438 <memcmp+0x26>
  }
  return 0;
 48c:	4781                	li	a5,0
}
 48e:	853e                	mv	a0,a5
 490:	7462                	ld	s0,56(sp)
 492:	6121                	addi	sp,sp,64
 494:	8082                	ret

0000000000000496 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 496:	7179                	addi	sp,sp,-48
 498:	f406                	sd	ra,40(sp)
 49a:	f022                	sd	s0,32(sp)
 49c:	1800                	addi	s0,sp,48
 49e:	fea43423          	sd	a0,-24(s0)
 4a2:	feb43023          	sd	a1,-32(s0)
 4a6:	87b2                	mv	a5,a2
 4a8:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4ac:	fdc42783          	lw	a5,-36(s0)
 4b0:	863e                	mv	a2,a5
 4b2:	fe043583          	ld	a1,-32(s0)
 4b6:	fe843503          	ld	a0,-24(s0)
 4ba:	00000097          	auipc	ra,0x0
 4be:	e96080e7          	jalr	-362(ra) # 350 <memmove>
 4c2:	87aa                	mv	a5,a0
}
 4c4:	853e                	mv	a0,a5
 4c6:	70a2                	ld	ra,40(sp)
 4c8:	7402                	ld	s0,32(sp)
 4ca:	6145                	addi	sp,sp,48
 4cc:	8082                	ret

00000000000004ce <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4ce:	4885                	li	a7,1
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4d6:	4889                	li	a7,2
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <wait>:
.global wait
wait:
 li a7, SYS_wait
 4de:	488d                	li	a7,3
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4e6:	4891                	li	a7,4
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <read>:
.global read
read:
 li a7, SYS_read
 4ee:	4895                	li	a7,5
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <write>:
.global write
write:
 li a7, SYS_write
 4f6:	48c1                	li	a7,16
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <close>:
.global close
close:
 li a7, SYS_close
 4fe:	48d5                	li	a7,21
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <kill>:
.global kill
kill:
 li a7, SYS_kill
 506:	4899                	li	a7,6
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <exec>:
.global exec
exec:
 li a7, SYS_exec
 50e:	489d                	li	a7,7
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <open>:
.global open
open:
 li a7, SYS_open
 516:	48bd                	li	a7,15
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 51e:	48c5                	li	a7,17
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 526:	48c9                	li	a7,18
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 52e:	48a1                	li	a7,8
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <link>:
.global link
link:
 li a7, SYS_link
 536:	48cd                	li	a7,19
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 53e:	48d1                	li	a7,20
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 546:	48a5                	li	a7,9
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <dup>:
.global dup
dup:
 li a7, SYS_dup
 54e:	48a9                	li	a7,10
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 556:	48ad                	li	a7,11
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 55e:	48b1                	li	a7,12
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 566:	48b5                	li	a7,13
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 56e:	48b9                	li	a7,14
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
 576:	48d9                	li	a7,22
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
 57e:	48dd                	li	a7,23
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
 586:	48e1                	li	a7,24
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
 58e:	48e5                	li	a7,25
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
 596:	48e9                	li	a7,26
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
 59e:	48ed                	li	a7,27
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
 5a6:	48f1                	li	a7,28
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5ae:	1101                	addi	sp,sp,-32
 5b0:	ec06                	sd	ra,24(sp)
 5b2:	e822                	sd	s0,16(sp)
 5b4:	1000                	addi	s0,sp,32
 5b6:	87aa                	mv	a5,a0
 5b8:	872e                	mv	a4,a1
 5ba:	fef42623          	sw	a5,-20(s0)
 5be:	87ba                	mv	a5,a4
 5c0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5c4:	feb40713          	addi	a4,s0,-21
 5c8:	fec42783          	lw	a5,-20(s0)
 5cc:	4605                	li	a2,1
 5ce:	85ba                	mv	a1,a4
 5d0:	853e                	mv	a0,a5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	f24080e7          	jalr	-220(ra) # 4f6 <write>
}
 5da:	0001                	nop
 5dc:	60e2                	ld	ra,24(sp)
 5de:	6442                	ld	s0,16(sp)
 5e0:	6105                	addi	sp,sp,32
 5e2:	8082                	ret

00000000000005e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e4:	7139                	addi	sp,sp,-64
 5e6:	fc06                	sd	ra,56(sp)
 5e8:	f822                	sd	s0,48(sp)
 5ea:	0080                	addi	s0,sp,64
 5ec:	87aa                	mv	a5,a0
 5ee:	8736                	mv	a4,a3
 5f0:	fcf42623          	sw	a5,-52(s0)
 5f4:	87ae                	mv	a5,a1
 5f6:	fcf42423          	sw	a5,-56(s0)
 5fa:	87b2                	mv	a5,a2
 5fc:	fcf42223          	sw	a5,-60(s0)
 600:	87ba                	mv	a5,a4
 602:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 606:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 60a:	fc042783          	lw	a5,-64(s0)
 60e:	2781                	sext.w	a5,a5
 610:	c38d                	beqz	a5,632 <printint+0x4e>
 612:	fc842783          	lw	a5,-56(s0)
 616:	2781                	sext.w	a5,a5
 618:	0007dd63          	bgez	a5,632 <printint+0x4e>
    neg = 1;
 61c:	4785                	li	a5,1
 61e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 622:	fc842783          	lw	a5,-56(s0)
 626:	40f007bb          	negw	a5,a5
 62a:	2781                	sext.w	a5,a5
 62c:	fef42223          	sw	a5,-28(s0)
 630:	a029                	j	63a <printint+0x56>
  } else {
    x = xx;
 632:	fc842783          	lw	a5,-56(s0)
 636:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 63a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 63e:	fc442783          	lw	a5,-60(s0)
 642:	fe442703          	lw	a4,-28(s0)
 646:	02f777bb          	remuw	a5,a4,a5
 64a:	0007861b          	sext.w	a2,a5
 64e:	fec42783          	lw	a5,-20(s0)
 652:	0017871b          	addiw	a4,a5,1
 656:	fee42623          	sw	a4,-20(s0)
 65a:	00001697          	auipc	a3,0x1
 65e:	d1668693          	addi	a3,a3,-746 # 1370 <digits>
 662:	02061713          	slli	a4,a2,0x20
 666:	9301                	srli	a4,a4,0x20
 668:	9736                	add	a4,a4,a3
 66a:	00074703          	lbu	a4,0(a4)
 66e:	17c1                	addi	a5,a5,-16
 670:	97a2                	add	a5,a5,s0
 672:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 676:	fc442783          	lw	a5,-60(s0)
 67a:	fe442703          	lw	a4,-28(s0)
 67e:	02f757bb          	divuw	a5,a4,a5
 682:	fef42223          	sw	a5,-28(s0)
 686:	fe442783          	lw	a5,-28(s0)
 68a:	2781                	sext.w	a5,a5
 68c:	fbcd                	bnez	a5,63e <printint+0x5a>
  if(neg)
 68e:	fe842783          	lw	a5,-24(s0)
 692:	2781                	sext.w	a5,a5
 694:	cf85                	beqz	a5,6cc <printint+0xe8>
    buf[i++] = '-';
 696:	fec42783          	lw	a5,-20(s0)
 69a:	0017871b          	addiw	a4,a5,1
 69e:	fee42623          	sw	a4,-20(s0)
 6a2:	17c1                	addi	a5,a5,-16
 6a4:	97a2                	add	a5,a5,s0
 6a6:	02d00713          	li	a4,45
 6aa:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6ae:	a839                	j	6cc <printint+0xe8>
    putc(fd, buf[i]);
 6b0:	fec42783          	lw	a5,-20(s0)
 6b4:	17c1                	addi	a5,a5,-16
 6b6:	97a2                	add	a5,a5,s0
 6b8:	fe07c703          	lbu	a4,-32(a5)
 6bc:	fcc42783          	lw	a5,-52(s0)
 6c0:	85ba                	mv	a1,a4
 6c2:	853e                	mv	a0,a5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	eea080e7          	jalr	-278(ra) # 5ae <putc>
  while(--i >= 0)
 6cc:	fec42783          	lw	a5,-20(s0)
 6d0:	37fd                	addiw	a5,a5,-1
 6d2:	fef42623          	sw	a5,-20(s0)
 6d6:	fec42783          	lw	a5,-20(s0)
 6da:	2781                	sext.w	a5,a5
 6dc:	fc07dae3          	bgez	a5,6b0 <printint+0xcc>
}
 6e0:	0001                	nop
 6e2:	0001                	nop
 6e4:	70e2                	ld	ra,56(sp)
 6e6:	7442                	ld	s0,48(sp)
 6e8:	6121                	addi	sp,sp,64
 6ea:	8082                	ret

00000000000006ec <printptr>:

static void
printptr(int fd, uint64 x) {
 6ec:	7179                	addi	sp,sp,-48
 6ee:	f406                	sd	ra,40(sp)
 6f0:	f022                	sd	s0,32(sp)
 6f2:	1800                	addi	s0,sp,48
 6f4:	87aa                	mv	a5,a0
 6f6:	fcb43823          	sd	a1,-48(s0)
 6fa:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 6fe:	fdc42783          	lw	a5,-36(s0)
 702:	03000593          	li	a1,48
 706:	853e                	mv	a0,a5
 708:	00000097          	auipc	ra,0x0
 70c:	ea6080e7          	jalr	-346(ra) # 5ae <putc>
  putc(fd, 'x');
 710:	fdc42783          	lw	a5,-36(s0)
 714:	07800593          	li	a1,120
 718:	853e                	mv	a0,a5
 71a:	00000097          	auipc	ra,0x0
 71e:	e94080e7          	jalr	-364(ra) # 5ae <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 722:	fe042623          	sw	zero,-20(s0)
 726:	a82d                	j	760 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 728:	fd043783          	ld	a5,-48(s0)
 72c:	93f1                	srli	a5,a5,0x3c
 72e:	00001717          	auipc	a4,0x1
 732:	c4270713          	addi	a4,a4,-958 # 1370 <digits>
 736:	97ba                	add	a5,a5,a4
 738:	0007c703          	lbu	a4,0(a5)
 73c:	fdc42783          	lw	a5,-36(s0)
 740:	85ba                	mv	a1,a4
 742:	853e                	mv	a0,a5
 744:	00000097          	auipc	ra,0x0
 748:	e6a080e7          	jalr	-406(ra) # 5ae <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 74c:	fec42783          	lw	a5,-20(s0)
 750:	2785                	addiw	a5,a5,1
 752:	fef42623          	sw	a5,-20(s0)
 756:	fd043783          	ld	a5,-48(s0)
 75a:	0792                	slli	a5,a5,0x4
 75c:	fcf43823          	sd	a5,-48(s0)
 760:	fec42783          	lw	a5,-20(s0)
 764:	873e                	mv	a4,a5
 766:	47bd                	li	a5,15
 768:	fce7f0e3          	bgeu	a5,a4,728 <printptr+0x3c>
}
 76c:	0001                	nop
 76e:	0001                	nop
 770:	70a2                	ld	ra,40(sp)
 772:	7402                	ld	s0,32(sp)
 774:	6145                	addi	sp,sp,48
 776:	8082                	ret

0000000000000778 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 778:	715d                	addi	sp,sp,-80
 77a:	e486                	sd	ra,72(sp)
 77c:	e0a2                	sd	s0,64(sp)
 77e:	0880                	addi	s0,sp,80
 780:	87aa                	mv	a5,a0
 782:	fcb43023          	sd	a1,-64(s0)
 786:	fac43c23          	sd	a2,-72(s0)
 78a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 78e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 792:	fe042223          	sw	zero,-28(s0)
 796:	a42d                	j	9c0 <vprintf+0x248>
    c = fmt[i] & 0xff;
 798:	fe442783          	lw	a5,-28(s0)
 79c:	fc043703          	ld	a4,-64(s0)
 7a0:	97ba                	add	a5,a5,a4
 7a2:	0007c783          	lbu	a5,0(a5)
 7a6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7aa:	fe042783          	lw	a5,-32(s0)
 7ae:	2781                	sext.w	a5,a5
 7b0:	eb9d                	bnez	a5,7e6 <vprintf+0x6e>
      if(c == '%'){
 7b2:	fdc42783          	lw	a5,-36(s0)
 7b6:	0007871b          	sext.w	a4,a5
 7ba:	02500793          	li	a5,37
 7be:	00f71763          	bne	a4,a5,7cc <vprintf+0x54>
        state = '%';
 7c2:	02500793          	li	a5,37
 7c6:	fef42023          	sw	a5,-32(s0)
 7ca:	a2f5                	j	9b6 <vprintf+0x23e>
      } else {
        putc(fd, c);
 7cc:	fdc42783          	lw	a5,-36(s0)
 7d0:	0ff7f713          	zext.b	a4,a5
 7d4:	fcc42783          	lw	a5,-52(s0)
 7d8:	85ba                	mv	a1,a4
 7da:	853e                	mv	a0,a5
 7dc:	00000097          	auipc	ra,0x0
 7e0:	dd2080e7          	jalr	-558(ra) # 5ae <putc>
 7e4:	aac9                	j	9b6 <vprintf+0x23e>
      }
    } else if(state == '%'){
 7e6:	fe042783          	lw	a5,-32(s0)
 7ea:	0007871b          	sext.w	a4,a5
 7ee:	02500793          	li	a5,37
 7f2:	1cf71263          	bne	a4,a5,9b6 <vprintf+0x23e>
      if(c == 'd'){
 7f6:	fdc42783          	lw	a5,-36(s0)
 7fa:	0007871b          	sext.w	a4,a5
 7fe:	06400793          	li	a5,100
 802:	02f71463          	bne	a4,a5,82a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 806:	fb843783          	ld	a5,-72(s0)
 80a:	00878713          	addi	a4,a5,8
 80e:	fae43c23          	sd	a4,-72(s0)
 812:	4398                	lw	a4,0(a5)
 814:	fcc42783          	lw	a5,-52(s0)
 818:	4685                	li	a3,1
 81a:	4629                	li	a2,10
 81c:	85ba                	mv	a1,a4
 81e:	853e                	mv	a0,a5
 820:	00000097          	auipc	ra,0x0
 824:	dc4080e7          	jalr	-572(ra) # 5e4 <printint>
 828:	a269                	j	9b2 <vprintf+0x23a>
      } else if(c == 'l') {
 82a:	fdc42783          	lw	a5,-36(s0)
 82e:	0007871b          	sext.w	a4,a5
 832:	06c00793          	li	a5,108
 836:	02f71663          	bne	a4,a5,862 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 83a:	fb843783          	ld	a5,-72(s0)
 83e:	00878713          	addi	a4,a5,8
 842:	fae43c23          	sd	a4,-72(s0)
 846:	639c                	ld	a5,0(a5)
 848:	0007871b          	sext.w	a4,a5
 84c:	fcc42783          	lw	a5,-52(s0)
 850:	4681                	li	a3,0
 852:	4629                	li	a2,10
 854:	85ba                	mv	a1,a4
 856:	853e                	mv	a0,a5
 858:	00000097          	auipc	ra,0x0
 85c:	d8c080e7          	jalr	-628(ra) # 5e4 <printint>
 860:	aa89                	j	9b2 <vprintf+0x23a>
      } else if(c == 'x') {
 862:	fdc42783          	lw	a5,-36(s0)
 866:	0007871b          	sext.w	a4,a5
 86a:	07800793          	li	a5,120
 86e:	02f71463          	bne	a4,a5,896 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 872:	fb843783          	ld	a5,-72(s0)
 876:	00878713          	addi	a4,a5,8
 87a:	fae43c23          	sd	a4,-72(s0)
 87e:	4398                	lw	a4,0(a5)
 880:	fcc42783          	lw	a5,-52(s0)
 884:	4681                	li	a3,0
 886:	4641                	li	a2,16
 888:	85ba                	mv	a1,a4
 88a:	853e                	mv	a0,a5
 88c:	00000097          	auipc	ra,0x0
 890:	d58080e7          	jalr	-680(ra) # 5e4 <printint>
 894:	aa39                	j	9b2 <vprintf+0x23a>
      } else if(c == 'p') {
 896:	fdc42783          	lw	a5,-36(s0)
 89a:	0007871b          	sext.w	a4,a5
 89e:	07000793          	li	a5,112
 8a2:	02f71263          	bne	a4,a5,8c6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8a6:	fb843783          	ld	a5,-72(s0)
 8aa:	00878713          	addi	a4,a5,8
 8ae:	fae43c23          	sd	a4,-72(s0)
 8b2:	6398                	ld	a4,0(a5)
 8b4:	fcc42783          	lw	a5,-52(s0)
 8b8:	85ba                	mv	a1,a4
 8ba:	853e                	mv	a0,a5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	e30080e7          	jalr	-464(ra) # 6ec <printptr>
 8c4:	a0fd                	j	9b2 <vprintf+0x23a>
      } else if(c == 's'){
 8c6:	fdc42783          	lw	a5,-36(s0)
 8ca:	0007871b          	sext.w	a4,a5
 8ce:	07300793          	li	a5,115
 8d2:	04f71c63          	bne	a4,a5,92a <vprintf+0x1b2>
        s = va_arg(ap, char*);
 8d6:	fb843783          	ld	a5,-72(s0)
 8da:	00878713          	addi	a4,a5,8
 8de:	fae43c23          	sd	a4,-72(s0)
 8e2:	639c                	ld	a5,0(a5)
 8e4:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 8e8:	fe843783          	ld	a5,-24(s0)
 8ec:	eb8d                	bnez	a5,91e <vprintf+0x1a6>
          s = "(null)";
 8ee:	00000797          	auipc	a5,0x0
 8f2:	48278793          	addi	a5,a5,1154 # d70 <malloc+0x148>
 8f6:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8fa:	a015                	j	91e <vprintf+0x1a6>
          putc(fd, *s);
 8fc:	fe843783          	ld	a5,-24(s0)
 900:	0007c703          	lbu	a4,0(a5)
 904:	fcc42783          	lw	a5,-52(s0)
 908:	85ba                	mv	a1,a4
 90a:	853e                	mv	a0,a5
 90c:	00000097          	auipc	ra,0x0
 910:	ca2080e7          	jalr	-862(ra) # 5ae <putc>
          s++;
 914:	fe843783          	ld	a5,-24(s0)
 918:	0785                	addi	a5,a5,1
 91a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 91e:	fe843783          	ld	a5,-24(s0)
 922:	0007c783          	lbu	a5,0(a5)
 926:	fbf9                	bnez	a5,8fc <vprintf+0x184>
 928:	a069                	j	9b2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 92a:	fdc42783          	lw	a5,-36(s0)
 92e:	0007871b          	sext.w	a4,a5
 932:	06300793          	li	a5,99
 936:	02f71463          	bne	a4,a5,95e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 93a:	fb843783          	ld	a5,-72(s0)
 93e:	00878713          	addi	a4,a5,8
 942:	fae43c23          	sd	a4,-72(s0)
 946:	439c                	lw	a5,0(a5)
 948:	0ff7f713          	zext.b	a4,a5
 94c:	fcc42783          	lw	a5,-52(s0)
 950:	85ba                	mv	a1,a4
 952:	853e                	mv	a0,a5
 954:	00000097          	auipc	ra,0x0
 958:	c5a080e7          	jalr	-934(ra) # 5ae <putc>
 95c:	a899                	j	9b2 <vprintf+0x23a>
      } else if(c == '%'){
 95e:	fdc42783          	lw	a5,-36(s0)
 962:	0007871b          	sext.w	a4,a5
 966:	02500793          	li	a5,37
 96a:	00f71f63          	bne	a4,a5,988 <vprintf+0x210>
        putc(fd, c);
 96e:	fdc42783          	lw	a5,-36(s0)
 972:	0ff7f713          	zext.b	a4,a5
 976:	fcc42783          	lw	a5,-52(s0)
 97a:	85ba                	mv	a1,a4
 97c:	853e                	mv	a0,a5
 97e:	00000097          	auipc	ra,0x0
 982:	c30080e7          	jalr	-976(ra) # 5ae <putc>
 986:	a035                	j	9b2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 988:	fcc42783          	lw	a5,-52(s0)
 98c:	02500593          	li	a1,37
 990:	853e                	mv	a0,a5
 992:	00000097          	auipc	ra,0x0
 996:	c1c080e7          	jalr	-996(ra) # 5ae <putc>
        putc(fd, c);
 99a:	fdc42783          	lw	a5,-36(s0)
 99e:	0ff7f713          	zext.b	a4,a5
 9a2:	fcc42783          	lw	a5,-52(s0)
 9a6:	85ba                	mv	a1,a4
 9a8:	853e                	mv	a0,a5
 9aa:	00000097          	auipc	ra,0x0
 9ae:	c04080e7          	jalr	-1020(ra) # 5ae <putc>
      }
      state = 0;
 9b2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9b6:	fe442783          	lw	a5,-28(s0)
 9ba:	2785                	addiw	a5,a5,1
 9bc:	fef42223          	sw	a5,-28(s0)
 9c0:	fe442783          	lw	a5,-28(s0)
 9c4:	fc043703          	ld	a4,-64(s0)
 9c8:	97ba                	add	a5,a5,a4
 9ca:	0007c783          	lbu	a5,0(a5)
 9ce:	dc0795e3          	bnez	a5,798 <vprintf+0x20>
    }
  }
}
 9d2:	0001                	nop
 9d4:	0001                	nop
 9d6:	60a6                	ld	ra,72(sp)
 9d8:	6406                	ld	s0,64(sp)
 9da:	6161                	addi	sp,sp,80
 9dc:	8082                	ret

00000000000009de <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9de:	7159                	addi	sp,sp,-112
 9e0:	fc06                	sd	ra,56(sp)
 9e2:	f822                	sd	s0,48(sp)
 9e4:	0080                	addi	s0,sp,64
 9e6:	fcb43823          	sd	a1,-48(s0)
 9ea:	e010                	sd	a2,0(s0)
 9ec:	e414                	sd	a3,8(s0)
 9ee:	e818                	sd	a4,16(s0)
 9f0:	ec1c                	sd	a5,24(s0)
 9f2:	03043023          	sd	a6,32(s0)
 9f6:	03143423          	sd	a7,40(s0)
 9fa:	87aa                	mv	a5,a0
 9fc:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a00:	03040793          	addi	a5,s0,48
 a04:	fcf43423          	sd	a5,-56(s0)
 a08:	fc843783          	ld	a5,-56(s0)
 a0c:	fd078793          	addi	a5,a5,-48
 a10:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a14:	fe843703          	ld	a4,-24(s0)
 a18:	fdc42783          	lw	a5,-36(s0)
 a1c:	863a                	mv	a2,a4
 a1e:	fd043583          	ld	a1,-48(s0)
 a22:	853e                	mv	a0,a5
 a24:	00000097          	auipc	ra,0x0
 a28:	d54080e7          	jalr	-684(ra) # 778 <vprintf>
}
 a2c:	0001                	nop
 a2e:	70e2                	ld	ra,56(sp)
 a30:	7442                	ld	s0,48(sp)
 a32:	6165                	addi	sp,sp,112
 a34:	8082                	ret

0000000000000a36 <printf>:

void
printf(const char *fmt, ...)
{
 a36:	7159                	addi	sp,sp,-112
 a38:	f406                	sd	ra,40(sp)
 a3a:	f022                	sd	s0,32(sp)
 a3c:	1800                	addi	s0,sp,48
 a3e:	fca43c23          	sd	a0,-40(s0)
 a42:	e40c                	sd	a1,8(s0)
 a44:	e810                	sd	a2,16(s0)
 a46:	ec14                	sd	a3,24(s0)
 a48:	f018                	sd	a4,32(s0)
 a4a:	f41c                	sd	a5,40(s0)
 a4c:	03043823          	sd	a6,48(s0)
 a50:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a54:	04040793          	addi	a5,s0,64
 a58:	fcf43823          	sd	a5,-48(s0)
 a5c:	fd043783          	ld	a5,-48(s0)
 a60:	fc878793          	addi	a5,a5,-56
 a64:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a68:	fe843783          	ld	a5,-24(s0)
 a6c:	863e                	mv	a2,a5
 a6e:	fd843583          	ld	a1,-40(s0)
 a72:	4505                	li	a0,1
 a74:	00000097          	auipc	ra,0x0
 a78:	d04080e7          	jalr	-764(ra) # 778 <vprintf>
}
 a7c:	0001                	nop
 a7e:	70a2                	ld	ra,40(sp)
 a80:	7402                	ld	s0,32(sp)
 a82:	6165                	addi	sp,sp,112
 a84:	8082                	ret

0000000000000a86 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a86:	7179                	addi	sp,sp,-48
 a88:	f422                	sd	s0,40(sp)
 a8a:	1800                	addi	s0,sp,48
 a8c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a90:	fd843783          	ld	a5,-40(s0)
 a94:	17c1                	addi	a5,a5,-16
 a96:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a9a:	00001797          	auipc	a5,0x1
 a9e:	90678793          	addi	a5,a5,-1786 # 13a0 <freep>
 aa2:	639c                	ld	a5,0(a5)
 aa4:	fef43423          	sd	a5,-24(s0)
 aa8:	a815                	j	adc <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aaa:	fe843783          	ld	a5,-24(s0)
 aae:	639c                	ld	a5,0(a5)
 ab0:	fe843703          	ld	a4,-24(s0)
 ab4:	00f76f63          	bltu	a4,a5,ad2 <free+0x4c>
 ab8:	fe043703          	ld	a4,-32(s0)
 abc:	fe843783          	ld	a5,-24(s0)
 ac0:	02e7eb63          	bltu	a5,a4,af6 <free+0x70>
 ac4:	fe843783          	ld	a5,-24(s0)
 ac8:	639c                	ld	a5,0(a5)
 aca:	fe043703          	ld	a4,-32(s0)
 ace:	02f76463          	bltu	a4,a5,af6 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad2:	fe843783          	ld	a5,-24(s0)
 ad6:	639c                	ld	a5,0(a5)
 ad8:	fef43423          	sd	a5,-24(s0)
 adc:	fe043703          	ld	a4,-32(s0)
 ae0:	fe843783          	ld	a5,-24(s0)
 ae4:	fce7f3e3          	bgeu	a5,a4,aaa <free+0x24>
 ae8:	fe843783          	ld	a5,-24(s0)
 aec:	639c                	ld	a5,0(a5)
 aee:	fe043703          	ld	a4,-32(s0)
 af2:	faf77ce3          	bgeu	a4,a5,aaa <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 af6:	fe043783          	ld	a5,-32(s0)
 afa:	479c                	lw	a5,8(a5)
 afc:	1782                	slli	a5,a5,0x20
 afe:	9381                	srli	a5,a5,0x20
 b00:	0792                	slli	a5,a5,0x4
 b02:	fe043703          	ld	a4,-32(s0)
 b06:	973e                	add	a4,a4,a5
 b08:	fe843783          	ld	a5,-24(s0)
 b0c:	639c                	ld	a5,0(a5)
 b0e:	02f71763          	bne	a4,a5,b3c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b12:	fe043783          	ld	a5,-32(s0)
 b16:	4798                	lw	a4,8(a5)
 b18:	fe843783          	ld	a5,-24(s0)
 b1c:	639c                	ld	a5,0(a5)
 b1e:	479c                	lw	a5,8(a5)
 b20:	9fb9                	addw	a5,a5,a4
 b22:	0007871b          	sext.w	a4,a5
 b26:	fe043783          	ld	a5,-32(s0)
 b2a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b2c:	fe843783          	ld	a5,-24(s0)
 b30:	639c                	ld	a5,0(a5)
 b32:	6398                	ld	a4,0(a5)
 b34:	fe043783          	ld	a5,-32(s0)
 b38:	e398                	sd	a4,0(a5)
 b3a:	a039                	j	b48 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b3c:	fe843783          	ld	a5,-24(s0)
 b40:	6398                	ld	a4,0(a5)
 b42:	fe043783          	ld	a5,-32(s0)
 b46:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b48:	fe843783          	ld	a5,-24(s0)
 b4c:	479c                	lw	a5,8(a5)
 b4e:	1782                	slli	a5,a5,0x20
 b50:	9381                	srli	a5,a5,0x20
 b52:	0792                	slli	a5,a5,0x4
 b54:	fe843703          	ld	a4,-24(s0)
 b58:	97ba                	add	a5,a5,a4
 b5a:	fe043703          	ld	a4,-32(s0)
 b5e:	02f71563          	bne	a4,a5,b88 <free+0x102>
    p->s.size += bp->s.size;
 b62:	fe843783          	ld	a5,-24(s0)
 b66:	4798                	lw	a4,8(a5)
 b68:	fe043783          	ld	a5,-32(s0)
 b6c:	479c                	lw	a5,8(a5)
 b6e:	9fb9                	addw	a5,a5,a4
 b70:	0007871b          	sext.w	a4,a5
 b74:	fe843783          	ld	a5,-24(s0)
 b78:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b7a:	fe043783          	ld	a5,-32(s0)
 b7e:	6398                	ld	a4,0(a5)
 b80:	fe843783          	ld	a5,-24(s0)
 b84:	e398                	sd	a4,0(a5)
 b86:	a031                	j	b92 <free+0x10c>
  } else
    p->s.ptr = bp;
 b88:	fe843783          	ld	a5,-24(s0)
 b8c:	fe043703          	ld	a4,-32(s0)
 b90:	e398                	sd	a4,0(a5)
  freep = p;
 b92:	00001797          	auipc	a5,0x1
 b96:	80e78793          	addi	a5,a5,-2034 # 13a0 <freep>
 b9a:	fe843703          	ld	a4,-24(s0)
 b9e:	e398                	sd	a4,0(a5)
}
 ba0:	0001                	nop
 ba2:	7422                	ld	s0,40(sp)
 ba4:	6145                	addi	sp,sp,48
 ba6:	8082                	ret

0000000000000ba8 <morecore>:

static Header*
morecore(uint nu)
{
 ba8:	7179                	addi	sp,sp,-48
 baa:	f406                	sd	ra,40(sp)
 bac:	f022                	sd	s0,32(sp)
 bae:	1800                	addi	s0,sp,48
 bb0:	87aa                	mv	a5,a0
 bb2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bb6:	fdc42783          	lw	a5,-36(s0)
 bba:	0007871b          	sext.w	a4,a5
 bbe:	6785                	lui	a5,0x1
 bc0:	00f77563          	bgeu	a4,a5,bca <morecore+0x22>
    nu = 4096;
 bc4:	6785                	lui	a5,0x1
 bc6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 bca:	fdc42783          	lw	a5,-36(s0)
 bce:	0047979b          	slliw	a5,a5,0x4
 bd2:	2781                	sext.w	a5,a5
 bd4:	2781                	sext.w	a5,a5
 bd6:	853e                	mv	a0,a5
 bd8:	00000097          	auipc	ra,0x0
 bdc:	986080e7          	jalr	-1658(ra) # 55e <sbrk>
 be0:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 be4:	fe843703          	ld	a4,-24(s0)
 be8:	57fd                	li	a5,-1
 bea:	00f71463          	bne	a4,a5,bf2 <morecore+0x4a>
    return 0;
 bee:	4781                	li	a5,0
 bf0:	a03d                	j	c1e <morecore+0x76>
  hp = (Header*)p;
 bf2:	fe843783          	ld	a5,-24(s0)
 bf6:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 bfa:	fe043783          	ld	a5,-32(s0)
 bfe:	fdc42703          	lw	a4,-36(s0)
 c02:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c04:	fe043783          	ld	a5,-32(s0)
 c08:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x3e8>
 c0a:	853e                	mv	a0,a5
 c0c:	00000097          	auipc	ra,0x0
 c10:	e7a080e7          	jalr	-390(ra) # a86 <free>
  return freep;
 c14:	00000797          	auipc	a5,0x0
 c18:	78c78793          	addi	a5,a5,1932 # 13a0 <freep>
 c1c:	639c                	ld	a5,0(a5)
}
 c1e:	853e                	mv	a0,a5
 c20:	70a2                	ld	ra,40(sp)
 c22:	7402                	ld	s0,32(sp)
 c24:	6145                	addi	sp,sp,48
 c26:	8082                	ret

0000000000000c28 <malloc>:

void*
malloc(uint nbytes)
{
 c28:	7139                	addi	sp,sp,-64
 c2a:	fc06                	sd	ra,56(sp)
 c2c:	f822                	sd	s0,48(sp)
 c2e:	0080                	addi	s0,sp,64
 c30:	87aa                	mv	a5,a0
 c32:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c36:	fcc46783          	lwu	a5,-52(s0)
 c3a:	07bd                	addi	a5,a5,15
 c3c:	8391                	srli	a5,a5,0x4
 c3e:	2781                	sext.w	a5,a5
 c40:	2785                	addiw	a5,a5,1
 c42:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c46:	00000797          	auipc	a5,0x0
 c4a:	75a78793          	addi	a5,a5,1882 # 13a0 <freep>
 c4e:	639c                	ld	a5,0(a5)
 c50:	fef43023          	sd	a5,-32(s0)
 c54:	fe043783          	ld	a5,-32(s0)
 c58:	ef95                	bnez	a5,c94 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c5a:	00000797          	auipc	a5,0x0
 c5e:	73678793          	addi	a5,a5,1846 # 1390 <base>
 c62:	fef43023          	sd	a5,-32(s0)
 c66:	00000797          	auipc	a5,0x0
 c6a:	73a78793          	addi	a5,a5,1850 # 13a0 <freep>
 c6e:	fe043703          	ld	a4,-32(s0)
 c72:	e398                	sd	a4,0(a5)
 c74:	00000797          	auipc	a5,0x0
 c78:	72c78793          	addi	a5,a5,1836 # 13a0 <freep>
 c7c:	6398                	ld	a4,0(a5)
 c7e:	00000797          	auipc	a5,0x0
 c82:	71278793          	addi	a5,a5,1810 # 1390 <base>
 c86:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 c88:	00000797          	auipc	a5,0x0
 c8c:	70878793          	addi	a5,a5,1800 # 1390 <base>
 c90:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c94:	fe043783          	ld	a5,-32(s0)
 c98:	639c                	ld	a5,0(a5)
 c9a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 c9e:	fe843783          	ld	a5,-24(s0)
 ca2:	4798                	lw	a4,8(a5)
 ca4:	fdc42783          	lw	a5,-36(s0)
 ca8:	2781                	sext.w	a5,a5
 caa:	06f76763          	bltu	a4,a5,d18 <malloc+0xf0>
      if(p->s.size == nunits)
 cae:	fe843783          	ld	a5,-24(s0)
 cb2:	4798                	lw	a4,8(a5)
 cb4:	fdc42783          	lw	a5,-36(s0)
 cb8:	2781                	sext.w	a5,a5
 cba:	00e79963          	bne	a5,a4,ccc <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 cbe:	fe843783          	ld	a5,-24(s0)
 cc2:	6398                	ld	a4,0(a5)
 cc4:	fe043783          	ld	a5,-32(s0)
 cc8:	e398                	sd	a4,0(a5)
 cca:	a825                	j	d02 <malloc+0xda>
      else {
        p->s.size -= nunits;
 ccc:	fe843783          	ld	a5,-24(s0)
 cd0:	479c                	lw	a5,8(a5)
 cd2:	fdc42703          	lw	a4,-36(s0)
 cd6:	9f99                	subw	a5,a5,a4
 cd8:	0007871b          	sext.w	a4,a5
 cdc:	fe843783          	ld	a5,-24(s0)
 ce0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ce2:	fe843783          	ld	a5,-24(s0)
 ce6:	479c                	lw	a5,8(a5)
 ce8:	1782                	slli	a5,a5,0x20
 cea:	9381                	srli	a5,a5,0x20
 cec:	0792                	slli	a5,a5,0x4
 cee:	fe843703          	ld	a4,-24(s0)
 cf2:	97ba                	add	a5,a5,a4
 cf4:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 cf8:	fe843783          	ld	a5,-24(s0)
 cfc:	fdc42703          	lw	a4,-36(s0)
 d00:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d02:	00000797          	auipc	a5,0x0
 d06:	69e78793          	addi	a5,a5,1694 # 13a0 <freep>
 d0a:	fe043703          	ld	a4,-32(s0)
 d0e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d10:	fe843783          	ld	a5,-24(s0)
 d14:	07c1                	addi	a5,a5,16
 d16:	a091                	j	d5a <malloc+0x132>
    }
    if(p == freep)
 d18:	00000797          	auipc	a5,0x0
 d1c:	68878793          	addi	a5,a5,1672 # 13a0 <freep>
 d20:	639c                	ld	a5,0(a5)
 d22:	fe843703          	ld	a4,-24(s0)
 d26:	02f71063          	bne	a4,a5,d46 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 d2a:	fdc42783          	lw	a5,-36(s0)
 d2e:	853e                	mv	a0,a5
 d30:	00000097          	auipc	ra,0x0
 d34:	e78080e7          	jalr	-392(ra) # ba8 <morecore>
 d38:	fea43423          	sd	a0,-24(s0)
 d3c:	fe843783          	ld	a5,-24(s0)
 d40:	e399                	bnez	a5,d46 <malloc+0x11e>
        return 0;
 d42:	4781                	li	a5,0
 d44:	a819                	j	d5a <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d46:	fe843783          	ld	a5,-24(s0)
 d4a:	fef43023          	sd	a5,-32(s0)
 d4e:	fe843783          	ld	a5,-24(s0)
 d52:	639c                	ld	a5,0(a5)
 d54:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d58:	b799                	j	c9e <malloc+0x76>
  }
}
 d5a:	853e                	mv	a0,a5
 d5c:	70e2                	ld	ra,56(sp)
 d5e:	7442                	ld	s0,48(sp)
 d60:	6121                	addi	sp,sp,64
 d62:	8082                	ret
