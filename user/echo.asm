
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	87aa                	mv	a5,a0
   c:	fcb43023          	sd	a1,-64(s0)
  10:	fcf42623          	sw	a5,-52(s0)
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	fcf42e23          	sw	a5,-36(s0)
  1a:	a051                	j	9e <main+0x9e>
    write(1, argv[i], strlen(argv[i]));
  1c:	fdc42783          	lw	a5,-36(s0)
  20:	078e                	slli	a5,a5,0x3
  22:	fc043703          	ld	a4,-64(s0)
  26:	97ba                	add	a5,a5,a4
  28:	6384                	ld	s1,0(a5)
  2a:	fdc42783          	lw	a5,-36(s0)
  2e:	078e                	slli	a5,a5,0x3
  30:	fc043703          	ld	a4,-64(s0)
  34:	97ba                	add	a5,a5,a4
  36:	639c                	ld	a5,0(a5)
  38:	853e                	mv	a0,a5
  3a:	00000097          	auipc	ra,0x0
  3e:	14a080e7          	jalr	330(ra) # 184 <strlen>
  42:	87aa                	mv	a5,a0
  44:	2781                	sext.w	a5,a5
  46:	2781                	sext.w	a5,a5
  48:	863e                	mv	a2,a5
  4a:	85a6                	mv	a1,s1
  4c:	4505                	li	a0,1
  4e:	00000097          	auipc	ra,0x0
  52:	538080e7          	jalr	1336(ra) # 586 <write>
    if(i + 1 < argc){
  56:	fdc42783          	lw	a5,-36(s0)
  5a:	2785                	addiw	a5,a5,1
  5c:	0007871b          	sext.w	a4,a5
  60:	fcc42783          	lw	a5,-52(s0)
  64:	2781                	sext.w	a5,a5
  66:	00f75d63          	bge	a4,a5,80 <main+0x80>
      write(1, " ", 1);
  6a:	4605                	li	a2,1
  6c:	00001597          	auipc	a1,0x1
  70:	d9458593          	addi	a1,a1,-620 # e00 <malloc+0x148>
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	510080e7          	jalr	1296(ra) # 586 <write>
  7e:	a819                	j	94 <main+0x94>
    } else {
      write(1, "\n", 1);
  80:	4605                	li	a2,1
  82:	00001597          	auipc	a1,0x1
  86:	d8658593          	addi	a1,a1,-634 # e08 <malloc+0x150>
  8a:	4505                	li	a0,1
  8c:	00000097          	auipc	ra,0x0
  90:	4fa080e7          	jalr	1274(ra) # 586 <write>
  for(i = 1; i < argc; i++){
  94:	fdc42783          	lw	a5,-36(s0)
  98:	2785                	addiw	a5,a5,1
  9a:	fcf42e23          	sw	a5,-36(s0)
  9e:	fdc42783          	lw	a5,-36(s0)
  a2:	873e                	mv	a4,a5
  a4:	fcc42783          	lw	a5,-52(s0)
  a8:	2701                	sext.w	a4,a4
  aa:	2781                	sext.w	a5,a5
  ac:	f6f748e3          	blt	a4,a5,1c <main+0x1c>
    }
  }
  exit(0);
  b0:	4501                	li	a0,0
  b2:	00000097          	auipc	ra,0x0
  b6:	4b4080e7          	jalr	1204(ra) # 566 <exit>

00000000000000ba <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e406                	sd	ra,8(sp)
  be:	e022                	sd	s0,0(sp)
  c0:	0800                	addi	s0,sp,16
  extern int main();
  main();
  c2:	00000097          	auipc	ra,0x0
  c6:	f3e080e7          	jalr	-194(ra) # 0 <main>
  exit(0);
  ca:	4501                	li	a0,0
  cc:	00000097          	auipc	ra,0x0
  d0:	49a080e7          	jalr	1178(ra) # 566 <exit>

00000000000000d4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d4:	7179                	addi	sp,sp,-48
  d6:	f422                	sd	s0,40(sp)
  d8:	1800                	addi	s0,sp,48
  da:	fca43c23          	sd	a0,-40(s0)
  de:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  e2:	fd843783          	ld	a5,-40(s0)
  e6:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  ea:	0001                	nop
  ec:	fd043703          	ld	a4,-48(s0)
  f0:	00170793          	addi	a5,a4,1
  f4:	fcf43823          	sd	a5,-48(s0)
  f8:	fd843783          	ld	a5,-40(s0)
  fc:	00178693          	addi	a3,a5,1
 100:	fcd43c23          	sd	a3,-40(s0)
 104:	00074703          	lbu	a4,0(a4)
 108:	00e78023          	sb	a4,0(a5)
 10c:	0007c783          	lbu	a5,0(a5)
 110:	fff1                	bnez	a5,ec <strcpy+0x18>
    ;
  return os;
 112:	fe843783          	ld	a5,-24(s0)
}
 116:	853e                	mv	a0,a5
 118:	7422                	ld	s0,40(sp)
 11a:	6145                	addi	sp,sp,48
 11c:	8082                	ret

000000000000011e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 11e:	1101                	addi	sp,sp,-32
 120:	ec22                	sd	s0,24(sp)
 122:	1000                	addi	s0,sp,32
 124:	fea43423          	sd	a0,-24(s0)
 128:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 12c:	a819                	j	142 <strcmp+0x24>
    p++, q++;
 12e:	fe843783          	ld	a5,-24(s0)
 132:	0785                	addi	a5,a5,1
 134:	fef43423          	sd	a5,-24(s0)
 138:	fe043783          	ld	a5,-32(s0)
 13c:	0785                	addi	a5,a5,1
 13e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 142:	fe843783          	ld	a5,-24(s0)
 146:	0007c783          	lbu	a5,0(a5)
 14a:	cb99                	beqz	a5,160 <strcmp+0x42>
 14c:	fe843783          	ld	a5,-24(s0)
 150:	0007c703          	lbu	a4,0(a5)
 154:	fe043783          	ld	a5,-32(s0)
 158:	0007c783          	lbu	a5,0(a5)
 15c:	fcf709e3          	beq	a4,a5,12e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 160:	fe843783          	ld	a5,-24(s0)
 164:	0007c783          	lbu	a5,0(a5)
 168:	0007871b          	sext.w	a4,a5
 16c:	fe043783          	ld	a5,-32(s0)
 170:	0007c783          	lbu	a5,0(a5)
 174:	2781                	sext.w	a5,a5
 176:	40f707bb          	subw	a5,a4,a5
 17a:	2781                	sext.w	a5,a5
}
 17c:	853e                	mv	a0,a5
 17e:	6462                	ld	s0,24(sp)
 180:	6105                	addi	sp,sp,32
 182:	8082                	ret

0000000000000184 <strlen>:

uint
strlen(const char *s)
{
 184:	7179                	addi	sp,sp,-48
 186:	f422                	sd	s0,40(sp)
 188:	1800                	addi	s0,sp,48
 18a:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 18e:	fe042623          	sw	zero,-20(s0)
 192:	a031                	j	19e <strlen+0x1a>
 194:	fec42783          	lw	a5,-20(s0)
 198:	2785                	addiw	a5,a5,1
 19a:	fef42623          	sw	a5,-20(s0)
 19e:	fec42783          	lw	a5,-20(s0)
 1a2:	fd843703          	ld	a4,-40(s0)
 1a6:	97ba                	add	a5,a5,a4
 1a8:	0007c783          	lbu	a5,0(a5)
 1ac:	f7e5                	bnez	a5,194 <strlen+0x10>
    ;
  return n;
 1ae:	fec42783          	lw	a5,-20(s0)
}
 1b2:	853e                	mv	a0,a5
 1b4:	7422                	ld	s0,40(sp)
 1b6:	6145                	addi	sp,sp,48
 1b8:	8082                	ret

00000000000001ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ba:	7179                	addi	sp,sp,-48
 1bc:	f422                	sd	s0,40(sp)
 1be:	1800                	addi	s0,sp,48
 1c0:	fca43c23          	sd	a0,-40(s0)
 1c4:	87ae                	mv	a5,a1
 1c6:	8732                	mv	a4,a2
 1c8:	fcf42a23          	sw	a5,-44(s0)
 1cc:	87ba                	mv	a5,a4
 1ce:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1d2:	fd843783          	ld	a5,-40(s0)
 1d6:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1da:	fe042623          	sw	zero,-20(s0)
 1de:	a00d                	j	200 <memset+0x46>
    cdst[i] = c;
 1e0:	fec42783          	lw	a5,-20(s0)
 1e4:	fe043703          	ld	a4,-32(s0)
 1e8:	97ba                	add	a5,a5,a4
 1ea:	fd442703          	lw	a4,-44(s0)
 1ee:	0ff77713          	zext.b	a4,a4
 1f2:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1f6:	fec42783          	lw	a5,-20(s0)
 1fa:	2785                	addiw	a5,a5,1
 1fc:	fef42623          	sw	a5,-20(s0)
 200:	fec42703          	lw	a4,-20(s0)
 204:	fd042783          	lw	a5,-48(s0)
 208:	2781                	sext.w	a5,a5
 20a:	fcf76be3          	bltu	a4,a5,1e0 <memset+0x26>
  }
  return dst;
 20e:	fd843783          	ld	a5,-40(s0)
}
 212:	853e                	mv	a0,a5
 214:	7422                	ld	s0,40(sp)
 216:	6145                	addi	sp,sp,48
 218:	8082                	ret

000000000000021a <strchr>:

char*
strchr(const char *s, char c)
{
 21a:	1101                	addi	sp,sp,-32
 21c:	ec22                	sd	s0,24(sp)
 21e:	1000                	addi	s0,sp,32
 220:	fea43423          	sd	a0,-24(s0)
 224:	87ae                	mv	a5,a1
 226:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 22a:	a01d                	j	250 <strchr+0x36>
    if(*s == c)
 22c:	fe843783          	ld	a5,-24(s0)
 230:	0007c703          	lbu	a4,0(a5)
 234:	fe744783          	lbu	a5,-25(s0)
 238:	0ff7f793          	zext.b	a5,a5
 23c:	00e79563          	bne	a5,a4,246 <strchr+0x2c>
      return (char*)s;
 240:	fe843783          	ld	a5,-24(s0)
 244:	a821                	j	25c <strchr+0x42>
  for(; *s; s++)
 246:	fe843783          	ld	a5,-24(s0)
 24a:	0785                	addi	a5,a5,1
 24c:	fef43423          	sd	a5,-24(s0)
 250:	fe843783          	ld	a5,-24(s0)
 254:	0007c783          	lbu	a5,0(a5)
 258:	fbf1                	bnez	a5,22c <strchr+0x12>
  return 0;
 25a:	4781                	li	a5,0
}
 25c:	853e                	mv	a0,a5
 25e:	6462                	ld	s0,24(sp)
 260:	6105                	addi	sp,sp,32
 262:	8082                	ret

0000000000000264 <gets>:

char*
gets(char *buf, int max)
{
 264:	7179                	addi	sp,sp,-48
 266:	f406                	sd	ra,40(sp)
 268:	f022                	sd	s0,32(sp)
 26a:	1800                	addi	s0,sp,48
 26c:	fca43c23          	sd	a0,-40(s0)
 270:	87ae                	mv	a5,a1
 272:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 276:	fe042623          	sw	zero,-20(s0)
 27a:	a8a1                	j	2d2 <gets+0x6e>
    cc = read(0, &c, 1);
 27c:	fe740793          	addi	a5,s0,-25
 280:	4605                	li	a2,1
 282:	85be                	mv	a1,a5
 284:	4501                	li	a0,0
 286:	00000097          	auipc	ra,0x0
 28a:	2f8080e7          	jalr	760(ra) # 57e <read>
 28e:	87aa                	mv	a5,a0
 290:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 294:	fe842783          	lw	a5,-24(s0)
 298:	2781                	sext.w	a5,a5
 29a:	04f05763          	blez	a5,2e8 <gets+0x84>
      break;
    buf[i++] = c;
 29e:	fec42783          	lw	a5,-20(s0)
 2a2:	0017871b          	addiw	a4,a5,1
 2a6:	fee42623          	sw	a4,-20(s0)
 2aa:	873e                	mv	a4,a5
 2ac:	fd843783          	ld	a5,-40(s0)
 2b0:	97ba                	add	a5,a5,a4
 2b2:	fe744703          	lbu	a4,-25(s0)
 2b6:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2ba:	fe744783          	lbu	a5,-25(s0)
 2be:	873e                	mv	a4,a5
 2c0:	47a9                	li	a5,10
 2c2:	02f70463          	beq	a4,a5,2ea <gets+0x86>
 2c6:	fe744783          	lbu	a5,-25(s0)
 2ca:	873e                	mv	a4,a5
 2cc:	47b5                	li	a5,13
 2ce:	00f70e63          	beq	a4,a5,2ea <gets+0x86>
  for(i=0; i+1 < max; ){
 2d2:	fec42783          	lw	a5,-20(s0)
 2d6:	2785                	addiw	a5,a5,1
 2d8:	0007871b          	sext.w	a4,a5
 2dc:	fd442783          	lw	a5,-44(s0)
 2e0:	2781                	sext.w	a5,a5
 2e2:	f8f74de3          	blt	a4,a5,27c <gets+0x18>
 2e6:	a011                	j	2ea <gets+0x86>
      break;
 2e8:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2ea:	fec42783          	lw	a5,-20(s0)
 2ee:	fd843703          	ld	a4,-40(s0)
 2f2:	97ba                	add	a5,a5,a4
 2f4:	00078023          	sb	zero,0(a5)
  return buf;
 2f8:	fd843783          	ld	a5,-40(s0)
}
 2fc:	853e                	mv	a0,a5
 2fe:	70a2                	ld	ra,40(sp)
 300:	7402                	ld	s0,32(sp)
 302:	6145                	addi	sp,sp,48
 304:	8082                	ret

0000000000000306 <stat>:

int
stat(const char *n, struct stat *st)
{
 306:	7179                	addi	sp,sp,-48
 308:	f406                	sd	ra,40(sp)
 30a:	f022                	sd	s0,32(sp)
 30c:	1800                	addi	s0,sp,48
 30e:	fca43c23          	sd	a0,-40(s0)
 312:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 316:	4581                	li	a1,0
 318:	fd843503          	ld	a0,-40(s0)
 31c:	00000097          	auipc	ra,0x0
 320:	28a080e7          	jalr	650(ra) # 5a6 <open>
 324:	87aa                	mv	a5,a0
 326:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 32a:	fec42783          	lw	a5,-20(s0)
 32e:	2781                	sext.w	a5,a5
 330:	0007d463          	bgez	a5,338 <stat+0x32>
    return -1;
 334:	57fd                	li	a5,-1
 336:	a035                	j	362 <stat+0x5c>
  r = fstat(fd, st);
 338:	fec42783          	lw	a5,-20(s0)
 33c:	fd043583          	ld	a1,-48(s0)
 340:	853e                	mv	a0,a5
 342:	00000097          	auipc	ra,0x0
 346:	27c080e7          	jalr	636(ra) # 5be <fstat>
 34a:	87aa                	mv	a5,a0
 34c:	fef42423          	sw	a5,-24(s0)
  close(fd);
 350:	fec42783          	lw	a5,-20(s0)
 354:	853e                	mv	a0,a5
 356:	00000097          	auipc	ra,0x0
 35a:	238080e7          	jalr	568(ra) # 58e <close>
  return r;
 35e:	fe842783          	lw	a5,-24(s0)
}
 362:	853e                	mv	a0,a5
 364:	70a2                	ld	ra,40(sp)
 366:	7402                	ld	s0,32(sp)
 368:	6145                	addi	sp,sp,48
 36a:	8082                	ret

000000000000036c <atoi>:

int
atoi(const char *s)
{
 36c:	7179                	addi	sp,sp,-48
 36e:	f422                	sd	s0,40(sp)
 370:	1800                	addi	s0,sp,48
 372:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 376:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 37a:	a81d                	j	3b0 <atoi+0x44>
    n = n*10 + *s++ - '0';
 37c:	fec42783          	lw	a5,-20(s0)
 380:	873e                	mv	a4,a5
 382:	87ba                	mv	a5,a4
 384:	0027979b          	slliw	a5,a5,0x2
 388:	9fb9                	addw	a5,a5,a4
 38a:	0017979b          	slliw	a5,a5,0x1
 38e:	0007871b          	sext.w	a4,a5
 392:	fd843783          	ld	a5,-40(s0)
 396:	00178693          	addi	a3,a5,1
 39a:	fcd43c23          	sd	a3,-40(s0)
 39e:	0007c783          	lbu	a5,0(a5)
 3a2:	2781                	sext.w	a5,a5
 3a4:	9fb9                	addw	a5,a5,a4
 3a6:	2781                	sext.w	a5,a5
 3a8:	fd07879b          	addiw	a5,a5,-48
 3ac:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3b0:	fd843783          	ld	a5,-40(s0)
 3b4:	0007c783          	lbu	a5,0(a5)
 3b8:	873e                	mv	a4,a5
 3ba:	02f00793          	li	a5,47
 3be:	00e7fb63          	bgeu	a5,a4,3d4 <atoi+0x68>
 3c2:	fd843783          	ld	a5,-40(s0)
 3c6:	0007c783          	lbu	a5,0(a5)
 3ca:	873e                	mv	a4,a5
 3cc:	03900793          	li	a5,57
 3d0:	fae7f6e3          	bgeu	a5,a4,37c <atoi+0x10>
  return n;
 3d4:	fec42783          	lw	a5,-20(s0)
}
 3d8:	853e                	mv	a0,a5
 3da:	7422                	ld	s0,40(sp)
 3dc:	6145                	addi	sp,sp,48
 3de:	8082                	ret

00000000000003e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3e0:	7139                	addi	sp,sp,-64
 3e2:	fc22                	sd	s0,56(sp)
 3e4:	0080                	addi	s0,sp,64
 3e6:	fca43c23          	sd	a0,-40(s0)
 3ea:	fcb43823          	sd	a1,-48(s0)
 3ee:	87b2                	mv	a5,a2
 3f0:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3f4:	fd843783          	ld	a5,-40(s0)
 3f8:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3fc:	fd043783          	ld	a5,-48(s0)
 400:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 404:	fe043703          	ld	a4,-32(s0)
 408:	fe843783          	ld	a5,-24(s0)
 40c:	02e7fc63          	bgeu	a5,a4,444 <memmove+0x64>
    while(n-- > 0)
 410:	a00d                	j	432 <memmove+0x52>
      *dst++ = *src++;
 412:	fe043703          	ld	a4,-32(s0)
 416:	00170793          	addi	a5,a4,1
 41a:	fef43023          	sd	a5,-32(s0)
 41e:	fe843783          	ld	a5,-24(s0)
 422:	00178693          	addi	a3,a5,1
 426:	fed43423          	sd	a3,-24(s0)
 42a:	00074703          	lbu	a4,0(a4)
 42e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 432:	fcc42783          	lw	a5,-52(s0)
 436:	fff7871b          	addiw	a4,a5,-1
 43a:	fce42623          	sw	a4,-52(s0)
 43e:	fcf04ae3          	bgtz	a5,412 <memmove+0x32>
 442:	a891                	j	496 <memmove+0xb6>
  } else {
    dst += n;
 444:	fcc42783          	lw	a5,-52(s0)
 448:	fe843703          	ld	a4,-24(s0)
 44c:	97ba                	add	a5,a5,a4
 44e:	fef43423          	sd	a5,-24(s0)
    src += n;
 452:	fcc42783          	lw	a5,-52(s0)
 456:	fe043703          	ld	a4,-32(s0)
 45a:	97ba                	add	a5,a5,a4
 45c:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 460:	a01d                	j	486 <memmove+0xa6>
      *--dst = *--src;
 462:	fe043783          	ld	a5,-32(s0)
 466:	17fd                	addi	a5,a5,-1
 468:	fef43023          	sd	a5,-32(s0)
 46c:	fe843783          	ld	a5,-24(s0)
 470:	17fd                	addi	a5,a5,-1
 472:	fef43423          	sd	a5,-24(s0)
 476:	fe043783          	ld	a5,-32(s0)
 47a:	0007c703          	lbu	a4,0(a5)
 47e:	fe843783          	ld	a5,-24(s0)
 482:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 486:	fcc42783          	lw	a5,-52(s0)
 48a:	fff7871b          	addiw	a4,a5,-1
 48e:	fce42623          	sw	a4,-52(s0)
 492:	fcf048e3          	bgtz	a5,462 <memmove+0x82>
  }
  return vdst;
 496:	fd843783          	ld	a5,-40(s0)
}
 49a:	853e                	mv	a0,a5
 49c:	7462                	ld	s0,56(sp)
 49e:	6121                	addi	sp,sp,64
 4a0:	8082                	ret

00000000000004a2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a2:	7139                	addi	sp,sp,-64
 4a4:	fc22                	sd	s0,56(sp)
 4a6:	0080                	addi	s0,sp,64
 4a8:	fca43c23          	sd	a0,-40(s0)
 4ac:	fcb43823          	sd	a1,-48(s0)
 4b0:	87b2                	mv	a5,a2
 4b2:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4b6:	fd843783          	ld	a5,-40(s0)
 4ba:	fef43423          	sd	a5,-24(s0)
 4be:	fd043783          	ld	a5,-48(s0)
 4c2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c6:	a0a1                	j	50e <memcmp+0x6c>
    if (*p1 != *p2) {
 4c8:	fe843783          	ld	a5,-24(s0)
 4cc:	0007c703          	lbu	a4,0(a5)
 4d0:	fe043783          	ld	a5,-32(s0)
 4d4:	0007c783          	lbu	a5,0(a5)
 4d8:	02f70163          	beq	a4,a5,4fa <memcmp+0x58>
      return *p1 - *p2;
 4dc:	fe843783          	ld	a5,-24(s0)
 4e0:	0007c783          	lbu	a5,0(a5)
 4e4:	0007871b          	sext.w	a4,a5
 4e8:	fe043783          	ld	a5,-32(s0)
 4ec:	0007c783          	lbu	a5,0(a5)
 4f0:	2781                	sext.w	a5,a5
 4f2:	40f707bb          	subw	a5,a4,a5
 4f6:	2781                	sext.w	a5,a5
 4f8:	a01d                	j	51e <memcmp+0x7c>
    }
    p1++;
 4fa:	fe843783          	ld	a5,-24(s0)
 4fe:	0785                	addi	a5,a5,1
 500:	fef43423          	sd	a5,-24(s0)
    p2++;
 504:	fe043783          	ld	a5,-32(s0)
 508:	0785                	addi	a5,a5,1
 50a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 50e:	fcc42783          	lw	a5,-52(s0)
 512:	fff7871b          	addiw	a4,a5,-1
 516:	fce42623          	sw	a4,-52(s0)
 51a:	f7dd                	bnez	a5,4c8 <memcmp+0x26>
  }
  return 0;
 51c:	4781                	li	a5,0
}
 51e:	853e                	mv	a0,a5
 520:	7462                	ld	s0,56(sp)
 522:	6121                	addi	sp,sp,64
 524:	8082                	ret

0000000000000526 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 526:	7179                	addi	sp,sp,-48
 528:	f406                	sd	ra,40(sp)
 52a:	f022                	sd	s0,32(sp)
 52c:	1800                	addi	s0,sp,48
 52e:	fea43423          	sd	a0,-24(s0)
 532:	feb43023          	sd	a1,-32(s0)
 536:	87b2                	mv	a5,a2
 538:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 53c:	fdc42783          	lw	a5,-36(s0)
 540:	863e                	mv	a2,a5
 542:	fe043583          	ld	a1,-32(s0)
 546:	fe843503          	ld	a0,-24(s0)
 54a:	00000097          	auipc	ra,0x0
 54e:	e96080e7          	jalr	-362(ra) # 3e0 <memmove>
 552:	87aa                	mv	a5,a0
}
 554:	853e                	mv	a0,a5
 556:	70a2                	ld	ra,40(sp)
 558:	7402                	ld	s0,32(sp)
 55a:	6145                	addi	sp,sp,48
 55c:	8082                	ret

000000000000055e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 55e:	4885                	li	a7,1
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <exit>:
.global exit
exit:
 li a7, SYS_exit
 566:	4889                	li	a7,2
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <wait>:
.global wait
wait:
 li a7, SYS_wait
 56e:	488d                	li	a7,3
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 576:	4891                	li	a7,4
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <read>:
.global read
read:
 li a7, SYS_read
 57e:	4895                	li	a7,5
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <write>:
.global write
write:
 li a7, SYS_write
 586:	48c1                	li	a7,16
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <close>:
.global close
close:
 li a7, SYS_close
 58e:	48d5                	li	a7,21
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <kill>:
.global kill
kill:
 li a7, SYS_kill
 596:	4899                	li	a7,6
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <exec>:
.global exec
exec:
 li a7, SYS_exec
 59e:	489d                	li	a7,7
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <open>:
.global open
open:
 li a7, SYS_open
 5a6:	48bd                	li	a7,15
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ae:	48c5                	li	a7,17
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5b6:	48c9                	li	a7,18
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5be:	48a1                	li	a7,8
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <link>:
.global link
link:
 li a7, SYS_link
 5c6:	48cd                	li	a7,19
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ce:	48d1                	li	a7,20
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d6:	48a5                	li	a7,9
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <dup>:
.global dup
dup:
 li a7, SYS_dup
 5de:	48a9                	li	a7,10
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e6:	48ad                	li	a7,11
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ee:	48b1                	li	a7,12
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f6:	48b5                	li	a7,13
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5fe:	48b9                	li	a7,14
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
 606:	48d9                	li	a7,22
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
 60e:	48dd                	li	a7,23
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
 616:	48e1                	li	a7,24
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
 61e:	48e5                	li	a7,25
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
 626:	48e9                	li	a7,26
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
 62e:	48ed                	li	a7,27
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
 636:	48f1                	li	a7,28
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 63e:	1101                	addi	sp,sp,-32
 640:	ec06                	sd	ra,24(sp)
 642:	e822                	sd	s0,16(sp)
 644:	1000                	addi	s0,sp,32
 646:	87aa                	mv	a5,a0
 648:	872e                	mv	a4,a1
 64a:	fef42623          	sw	a5,-20(s0)
 64e:	87ba                	mv	a5,a4
 650:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 654:	feb40713          	addi	a4,s0,-21
 658:	fec42783          	lw	a5,-20(s0)
 65c:	4605                	li	a2,1
 65e:	85ba                	mv	a1,a4
 660:	853e                	mv	a0,a5
 662:	00000097          	auipc	ra,0x0
 666:	f24080e7          	jalr	-220(ra) # 586 <write>
}
 66a:	0001                	nop
 66c:	60e2                	ld	ra,24(sp)
 66e:	6442                	ld	s0,16(sp)
 670:	6105                	addi	sp,sp,32
 672:	8082                	ret

0000000000000674 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 674:	7139                	addi	sp,sp,-64
 676:	fc06                	sd	ra,56(sp)
 678:	f822                	sd	s0,48(sp)
 67a:	0080                	addi	s0,sp,64
 67c:	87aa                	mv	a5,a0
 67e:	8736                	mv	a4,a3
 680:	fcf42623          	sw	a5,-52(s0)
 684:	87ae                	mv	a5,a1
 686:	fcf42423          	sw	a5,-56(s0)
 68a:	87b2                	mv	a5,a2
 68c:	fcf42223          	sw	a5,-60(s0)
 690:	87ba                	mv	a5,a4
 692:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 696:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 69a:	fc042783          	lw	a5,-64(s0)
 69e:	2781                	sext.w	a5,a5
 6a0:	c38d                	beqz	a5,6c2 <printint+0x4e>
 6a2:	fc842783          	lw	a5,-56(s0)
 6a6:	2781                	sext.w	a5,a5
 6a8:	0007dd63          	bgez	a5,6c2 <printint+0x4e>
    neg = 1;
 6ac:	4785                	li	a5,1
 6ae:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6b2:	fc842783          	lw	a5,-56(s0)
 6b6:	40f007bb          	negw	a5,a5
 6ba:	2781                	sext.w	a5,a5
 6bc:	fef42223          	sw	a5,-28(s0)
 6c0:	a029                	j	6ca <printint+0x56>
  } else {
    x = xx;
 6c2:	fc842783          	lw	a5,-56(s0)
 6c6:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 6ca:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6ce:	fc442783          	lw	a5,-60(s0)
 6d2:	fe442703          	lw	a4,-28(s0)
 6d6:	02f777bb          	remuw	a5,a4,a5
 6da:	0007861b          	sext.w	a2,a5
 6de:	fec42783          	lw	a5,-20(s0)
 6e2:	0017871b          	addiw	a4,a5,1
 6e6:	fee42623          	sw	a4,-20(s0)
 6ea:	00001697          	auipc	a3,0x1
 6ee:	c8668693          	addi	a3,a3,-890 # 1370 <digits>
 6f2:	02061713          	slli	a4,a2,0x20
 6f6:	9301                	srli	a4,a4,0x20
 6f8:	9736                	add	a4,a4,a3
 6fa:	00074703          	lbu	a4,0(a4)
 6fe:	17c1                	addi	a5,a5,-16
 700:	97a2                	add	a5,a5,s0
 702:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 706:	fc442783          	lw	a5,-60(s0)
 70a:	fe442703          	lw	a4,-28(s0)
 70e:	02f757bb          	divuw	a5,a4,a5
 712:	fef42223          	sw	a5,-28(s0)
 716:	fe442783          	lw	a5,-28(s0)
 71a:	2781                	sext.w	a5,a5
 71c:	fbcd                	bnez	a5,6ce <printint+0x5a>
  if(neg)
 71e:	fe842783          	lw	a5,-24(s0)
 722:	2781                	sext.w	a5,a5
 724:	cf85                	beqz	a5,75c <printint+0xe8>
    buf[i++] = '-';
 726:	fec42783          	lw	a5,-20(s0)
 72a:	0017871b          	addiw	a4,a5,1
 72e:	fee42623          	sw	a4,-20(s0)
 732:	17c1                	addi	a5,a5,-16
 734:	97a2                	add	a5,a5,s0
 736:	02d00713          	li	a4,45
 73a:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 73e:	a839                	j	75c <printint+0xe8>
    putc(fd, buf[i]);
 740:	fec42783          	lw	a5,-20(s0)
 744:	17c1                	addi	a5,a5,-16
 746:	97a2                	add	a5,a5,s0
 748:	fe07c703          	lbu	a4,-32(a5)
 74c:	fcc42783          	lw	a5,-52(s0)
 750:	85ba                	mv	a1,a4
 752:	853e                	mv	a0,a5
 754:	00000097          	auipc	ra,0x0
 758:	eea080e7          	jalr	-278(ra) # 63e <putc>
  while(--i >= 0)
 75c:	fec42783          	lw	a5,-20(s0)
 760:	37fd                	addiw	a5,a5,-1
 762:	fef42623          	sw	a5,-20(s0)
 766:	fec42783          	lw	a5,-20(s0)
 76a:	2781                	sext.w	a5,a5
 76c:	fc07dae3          	bgez	a5,740 <printint+0xcc>
}
 770:	0001                	nop
 772:	0001                	nop
 774:	70e2                	ld	ra,56(sp)
 776:	7442                	ld	s0,48(sp)
 778:	6121                	addi	sp,sp,64
 77a:	8082                	ret

000000000000077c <printptr>:

static void
printptr(int fd, uint64 x) {
 77c:	7179                	addi	sp,sp,-48
 77e:	f406                	sd	ra,40(sp)
 780:	f022                	sd	s0,32(sp)
 782:	1800                	addi	s0,sp,48
 784:	87aa                	mv	a5,a0
 786:	fcb43823          	sd	a1,-48(s0)
 78a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 78e:	fdc42783          	lw	a5,-36(s0)
 792:	03000593          	li	a1,48
 796:	853e                	mv	a0,a5
 798:	00000097          	auipc	ra,0x0
 79c:	ea6080e7          	jalr	-346(ra) # 63e <putc>
  putc(fd, 'x');
 7a0:	fdc42783          	lw	a5,-36(s0)
 7a4:	07800593          	li	a1,120
 7a8:	853e                	mv	a0,a5
 7aa:	00000097          	auipc	ra,0x0
 7ae:	e94080e7          	jalr	-364(ra) # 63e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b2:	fe042623          	sw	zero,-20(s0)
 7b6:	a82d                	j	7f0 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b8:	fd043783          	ld	a5,-48(s0)
 7bc:	93f1                	srli	a5,a5,0x3c
 7be:	00001717          	auipc	a4,0x1
 7c2:	bb270713          	addi	a4,a4,-1102 # 1370 <digits>
 7c6:	97ba                	add	a5,a5,a4
 7c8:	0007c703          	lbu	a4,0(a5)
 7cc:	fdc42783          	lw	a5,-36(s0)
 7d0:	85ba                	mv	a1,a4
 7d2:	853e                	mv	a0,a5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	e6a080e7          	jalr	-406(ra) # 63e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7dc:	fec42783          	lw	a5,-20(s0)
 7e0:	2785                	addiw	a5,a5,1
 7e2:	fef42623          	sw	a5,-20(s0)
 7e6:	fd043783          	ld	a5,-48(s0)
 7ea:	0792                	slli	a5,a5,0x4
 7ec:	fcf43823          	sd	a5,-48(s0)
 7f0:	fec42783          	lw	a5,-20(s0)
 7f4:	873e                	mv	a4,a5
 7f6:	47bd                	li	a5,15
 7f8:	fce7f0e3          	bgeu	a5,a4,7b8 <printptr+0x3c>
}
 7fc:	0001                	nop
 7fe:	0001                	nop
 800:	70a2                	ld	ra,40(sp)
 802:	7402                	ld	s0,32(sp)
 804:	6145                	addi	sp,sp,48
 806:	8082                	ret

0000000000000808 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 808:	715d                	addi	sp,sp,-80
 80a:	e486                	sd	ra,72(sp)
 80c:	e0a2                	sd	s0,64(sp)
 80e:	0880                	addi	s0,sp,80
 810:	87aa                	mv	a5,a0
 812:	fcb43023          	sd	a1,-64(s0)
 816:	fac43c23          	sd	a2,-72(s0)
 81a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 81e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 822:	fe042223          	sw	zero,-28(s0)
 826:	a42d                	j	a50 <vprintf+0x248>
    c = fmt[i] & 0xff;
 828:	fe442783          	lw	a5,-28(s0)
 82c:	fc043703          	ld	a4,-64(s0)
 830:	97ba                	add	a5,a5,a4
 832:	0007c783          	lbu	a5,0(a5)
 836:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 83a:	fe042783          	lw	a5,-32(s0)
 83e:	2781                	sext.w	a5,a5
 840:	eb9d                	bnez	a5,876 <vprintf+0x6e>
      if(c == '%'){
 842:	fdc42783          	lw	a5,-36(s0)
 846:	0007871b          	sext.w	a4,a5
 84a:	02500793          	li	a5,37
 84e:	00f71763          	bne	a4,a5,85c <vprintf+0x54>
        state = '%';
 852:	02500793          	li	a5,37
 856:	fef42023          	sw	a5,-32(s0)
 85a:	a2f5                	j	a46 <vprintf+0x23e>
      } else {
        putc(fd, c);
 85c:	fdc42783          	lw	a5,-36(s0)
 860:	0ff7f713          	zext.b	a4,a5
 864:	fcc42783          	lw	a5,-52(s0)
 868:	85ba                	mv	a1,a4
 86a:	853e                	mv	a0,a5
 86c:	00000097          	auipc	ra,0x0
 870:	dd2080e7          	jalr	-558(ra) # 63e <putc>
 874:	aac9                	j	a46 <vprintf+0x23e>
      }
    } else if(state == '%'){
 876:	fe042783          	lw	a5,-32(s0)
 87a:	0007871b          	sext.w	a4,a5
 87e:	02500793          	li	a5,37
 882:	1cf71263          	bne	a4,a5,a46 <vprintf+0x23e>
      if(c == 'd'){
 886:	fdc42783          	lw	a5,-36(s0)
 88a:	0007871b          	sext.w	a4,a5
 88e:	06400793          	li	a5,100
 892:	02f71463          	bne	a4,a5,8ba <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 896:	fb843783          	ld	a5,-72(s0)
 89a:	00878713          	addi	a4,a5,8
 89e:	fae43c23          	sd	a4,-72(s0)
 8a2:	4398                	lw	a4,0(a5)
 8a4:	fcc42783          	lw	a5,-52(s0)
 8a8:	4685                	li	a3,1
 8aa:	4629                	li	a2,10
 8ac:	85ba                	mv	a1,a4
 8ae:	853e                	mv	a0,a5
 8b0:	00000097          	auipc	ra,0x0
 8b4:	dc4080e7          	jalr	-572(ra) # 674 <printint>
 8b8:	a269                	j	a42 <vprintf+0x23a>
      } else if(c == 'l') {
 8ba:	fdc42783          	lw	a5,-36(s0)
 8be:	0007871b          	sext.w	a4,a5
 8c2:	06c00793          	li	a5,108
 8c6:	02f71663          	bne	a4,a5,8f2 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ca:	fb843783          	ld	a5,-72(s0)
 8ce:	00878713          	addi	a4,a5,8
 8d2:	fae43c23          	sd	a4,-72(s0)
 8d6:	639c                	ld	a5,0(a5)
 8d8:	0007871b          	sext.w	a4,a5
 8dc:	fcc42783          	lw	a5,-52(s0)
 8e0:	4681                	li	a3,0
 8e2:	4629                	li	a2,10
 8e4:	85ba                	mv	a1,a4
 8e6:	853e                	mv	a0,a5
 8e8:	00000097          	auipc	ra,0x0
 8ec:	d8c080e7          	jalr	-628(ra) # 674 <printint>
 8f0:	aa89                	j	a42 <vprintf+0x23a>
      } else if(c == 'x') {
 8f2:	fdc42783          	lw	a5,-36(s0)
 8f6:	0007871b          	sext.w	a4,a5
 8fa:	07800793          	li	a5,120
 8fe:	02f71463          	bne	a4,a5,926 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 902:	fb843783          	ld	a5,-72(s0)
 906:	00878713          	addi	a4,a5,8
 90a:	fae43c23          	sd	a4,-72(s0)
 90e:	4398                	lw	a4,0(a5)
 910:	fcc42783          	lw	a5,-52(s0)
 914:	4681                	li	a3,0
 916:	4641                	li	a2,16
 918:	85ba                	mv	a1,a4
 91a:	853e                	mv	a0,a5
 91c:	00000097          	auipc	ra,0x0
 920:	d58080e7          	jalr	-680(ra) # 674 <printint>
 924:	aa39                	j	a42 <vprintf+0x23a>
      } else if(c == 'p') {
 926:	fdc42783          	lw	a5,-36(s0)
 92a:	0007871b          	sext.w	a4,a5
 92e:	07000793          	li	a5,112
 932:	02f71263          	bne	a4,a5,956 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 936:	fb843783          	ld	a5,-72(s0)
 93a:	00878713          	addi	a4,a5,8
 93e:	fae43c23          	sd	a4,-72(s0)
 942:	6398                	ld	a4,0(a5)
 944:	fcc42783          	lw	a5,-52(s0)
 948:	85ba                	mv	a1,a4
 94a:	853e                	mv	a0,a5
 94c:	00000097          	auipc	ra,0x0
 950:	e30080e7          	jalr	-464(ra) # 77c <printptr>
 954:	a0fd                	j	a42 <vprintf+0x23a>
      } else if(c == 's'){
 956:	fdc42783          	lw	a5,-36(s0)
 95a:	0007871b          	sext.w	a4,a5
 95e:	07300793          	li	a5,115
 962:	04f71c63          	bne	a4,a5,9ba <vprintf+0x1b2>
        s = va_arg(ap, char*);
 966:	fb843783          	ld	a5,-72(s0)
 96a:	00878713          	addi	a4,a5,8
 96e:	fae43c23          	sd	a4,-72(s0)
 972:	639c                	ld	a5,0(a5)
 974:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 978:	fe843783          	ld	a5,-24(s0)
 97c:	eb8d                	bnez	a5,9ae <vprintf+0x1a6>
          s = "(null)";
 97e:	00000797          	auipc	a5,0x0
 982:	49278793          	addi	a5,a5,1170 # e10 <malloc+0x158>
 986:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 98a:	a015                	j	9ae <vprintf+0x1a6>
          putc(fd, *s);
 98c:	fe843783          	ld	a5,-24(s0)
 990:	0007c703          	lbu	a4,0(a5)
 994:	fcc42783          	lw	a5,-52(s0)
 998:	85ba                	mv	a1,a4
 99a:	853e                	mv	a0,a5
 99c:	00000097          	auipc	ra,0x0
 9a0:	ca2080e7          	jalr	-862(ra) # 63e <putc>
          s++;
 9a4:	fe843783          	ld	a5,-24(s0)
 9a8:	0785                	addi	a5,a5,1
 9aa:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9ae:	fe843783          	ld	a5,-24(s0)
 9b2:	0007c783          	lbu	a5,0(a5)
 9b6:	fbf9                	bnez	a5,98c <vprintf+0x184>
 9b8:	a069                	j	a42 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 9ba:	fdc42783          	lw	a5,-36(s0)
 9be:	0007871b          	sext.w	a4,a5
 9c2:	06300793          	li	a5,99
 9c6:	02f71463          	bne	a4,a5,9ee <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 9ca:	fb843783          	ld	a5,-72(s0)
 9ce:	00878713          	addi	a4,a5,8
 9d2:	fae43c23          	sd	a4,-72(s0)
 9d6:	439c                	lw	a5,0(a5)
 9d8:	0ff7f713          	zext.b	a4,a5
 9dc:	fcc42783          	lw	a5,-52(s0)
 9e0:	85ba                	mv	a1,a4
 9e2:	853e                	mv	a0,a5
 9e4:	00000097          	auipc	ra,0x0
 9e8:	c5a080e7          	jalr	-934(ra) # 63e <putc>
 9ec:	a899                	j	a42 <vprintf+0x23a>
      } else if(c == '%'){
 9ee:	fdc42783          	lw	a5,-36(s0)
 9f2:	0007871b          	sext.w	a4,a5
 9f6:	02500793          	li	a5,37
 9fa:	00f71f63          	bne	a4,a5,a18 <vprintf+0x210>
        putc(fd, c);
 9fe:	fdc42783          	lw	a5,-36(s0)
 a02:	0ff7f713          	zext.b	a4,a5
 a06:	fcc42783          	lw	a5,-52(s0)
 a0a:	85ba                	mv	a1,a4
 a0c:	853e                	mv	a0,a5
 a0e:	00000097          	auipc	ra,0x0
 a12:	c30080e7          	jalr	-976(ra) # 63e <putc>
 a16:	a035                	j	a42 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a18:	fcc42783          	lw	a5,-52(s0)
 a1c:	02500593          	li	a1,37
 a20:	853e                	mv	a0,a5
 a22:	00000097          	auipc	ra,0x0
 a26:	c1c080e7          	jalr	-996(ra) # 63e <putc>
        putc(fd, c);
 a2a:	fdc42783          	lw	a5,-36(s0)
 a2e:	0ff7f713          	zext.b	a4,a5
 a32:	fcc42783          	lw	a5,-52(s0)
 a36:	85ba                	mv	a1,a4
 a38:	853e                	mv	a0,a5
 a3a:	00000097          	auipc	ra,0x0
 a3e:	c04080e7          	jalr	-1020(ra) # 63e <putc>
      }
      state = 0;
 a42:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a46:	fe442783          	lw	a5,-28(s0)
 a4a:	2785                	addiw	a5,a5,1
 a4c:	fef42223          	sw	a5,-28(s0)
 a50:	fe442783          	lw	a5,-28(s0)
 a54:	fc043703          	ld	a4,-64(s0)
 a58:	97ba                	add	a5,a5,a4
 a5a:	0007c783          	lbu	a5,0(a5)
 a5e:	dc0795e3          	bnez	a5,828 <vprintf+0x20>
    }
  }
}
 a62:	0001                	nop
 a64:	0001                	nop
 a66:	60a6                	ld	ra,72(sp)
 a68:	6406                	ld	s0,64(sp)
 a6a:	6161                	addi	sp,sp,80
 a6c:	8082                	ret

0000000000000a6e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a6e:	7159                	addi	sp,sp,-112
 a70:	fc06                	sd	ra,56(sp)
 a72:	f822                	sd	s0,48(sp)
 a74:	0080                	addi	s0,sp,64
 a76:	fcb43823          	sd	a1,-48(s0)
 a7a:	e010                	sd	a2,0(s0)
 a7c:	e414                	sd	a3,8(s0)
 a7e:	e818                	sd	a4,16(s0)
 a80:	ec1c                	sd	a5,24(s0)
 a82:	03043023          	sd	a6,32(s0)
 a86:	03143423          	sd	a7,40(s0)
 a8a:	87aa                	mv	a5,a0
 a8c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a90:	03040793          	addi	a5,s0,48
 a94:	fcf43423          	sd	a5,-56(s0)
 a98:	fc843783          	ld	a5,-56(s0)
 a9c:	fd078793          	addi	a5,a5,-48
 aa0:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 aa4:	fe843703          	ld	a4,-24(s0)
 aa8:	fdc42783          	lw	a5,-36(s0)
 aac:	863a                	mv	a2,a4
 aae:	fd043583          	ld	a1,-48(s0)
 ab2:	853e                	mv	a0,a5
 ab4:	00000097          	auipc	ra,0x0
 ab8:	d54080e7          	jalr	-684(ra) # 808 <vprintf>
}
 abc:	0001                	nop
 abe:	70e2                	ld	ra,56(sp)
 ac0:	7442                	ld	s0,48(sp)
 ac2:	6165                	addi	sp,sp,112
 ac4:	8082                	ret

0000000000000ac6 <printf>:

void
printf(const char *fmt, ...)
{
 ac6:	7159                	addi	sp,sp,-112
 ac8:	f406                	sd	ra,40(sp)
 aca:	f022                	sd	s0,32(sp)
 acc:	1800                	addi	s0,sp,48
 ace:	fca43c23          	sd	a0,-40(s0)
 ad2:	e40c                	sd	a1,8(s0)
 ad4:	e810                	sd	a2,16(s0)
 ad6:	ec14                	sd	a3,24(s0)
 ad8:	f018                	sd	a4,32(s0)
 ada:	f41c                	sd	a5,40(s0)
 adc:	03043823          	sd	a6,48(s0)
 ae0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ae4:	04040793          	addi	a5,s0,64
 ae8:	fcf43823          	sd	a5,-48(s0)
 aec:	fd043783          	ld	a5,-48(s0)
 af0:	fc878793          	addi	a5,a5,-56
 af4:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 af8:	fe843783          	ld	a5,-24(s0)
 afc:	863e                	mv	a2,a5
 afe:	fd843583          	ld	a1,-40(s0)
 b02:	4505                	li	a0,1
 b04:	00000097          	auipc	ra,0x0
 b08:	d04080e7          	jalr	-764(ra) # 808 <vprintf>
}
 b0c:	0001                	nop
 b0e:	70a2                	ld	ra,40(sp)
 b10:	7402                	ld	s0,32(sp)
 b12:	6165                	addi	sp,sp,112
 b14:	8082                	ret

0000000000000b16 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b16:	7179                	addi	sp,sp,-48
 b18:	f422                	sd	s0,40(sp)
 b1a:	1800                	addi	s0,sp,48
 b1c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b20:	fd843783          	ld	a5,-40(s0)
 b24:	17c1                	addi	a5,a5,-16
 b26:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b2a:	00001797          	auipc	a5,0x1
 b2e:	87678793          	addi	a5,a5,-1930 # 13a0 <freep>
 b32:	639c                	ld	a5,0(a5)
 b34:	fef43423          	sd	a5,-24(s0)
 b38:	a815                	j	b6c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b3a:	fe843783          	ld	a5,-24(s0)
 b3e:	639c                	ld	a5,0(a5)
 b40:	fe843703          	ld	a4,-24(s0)
 b44:	00f76f63          	bltu	a4,a5,b62 <free+0x4c>
 b48:	fe043703          	ld	a4,-32(s0)
 b4c:	fe843783          	ld	a5,-24(s0)
 b50:	02e7eb63          	bltu	a5,a4,b86 <free+0x70>
 b54:	fe843783          	ld	a5,-24(s0)
 b58:	639c                	ld	a5,0(a5)
 b5a:	fe043703          	ld	a4,-32(s0)
 b5e:	02f76463          	bltu	a4,a5,b86 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b62:	fe843783          	ld	a5,-24(s0)
 b66:	639c                	ld	a5,0(a5)
 b68:	fef43423          	sd	a5,-24(s0)
 b6c:	fe043703          	ld	a4,-32(s0)
 b70:	fe843783          	ld	a5,-24(s0)
 b74:	fce7f3e3          	bgeu	a5,a4,b3a <free+0x24>
 b78:	fe843783          	ld	a5,-24(s0)
 b7c:	639c                	ld	a5,0(a5)
 b7e:	fe043703          	ld	a4,-32(s0)
 b82:	faf77ce3          	bgeu	a4,a5,b3a <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b86:	fe043783          	ld	a5,-32(s0)
 b8a:	479c                	lw	a5,8(a5)
 b8c:	1782                	slli	a5,a5,0x20
 b8e:	9381                	srli	a5,a5,0x20
 b90:	0792                	slli	a5,a5,0x4
 b92:	fe043703          	ld	a4,-32(s0)
 b96:	973e                	add	a4,a4,a5
 b98:	fe843783          	ld	a5,-24(s0)
 b9c:	639c                	ld	a5,0(a5)
 b9e:	02f71763          	bne	a4,a5,bcc <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 ba2:	fe043783          	ld	a5,-32(s0)
 ba6:	4798                	lw	a4,8(a5)
 ba8:	fe843783          	ld	a5,-24(s0)
 bac:	639c                	ld	a5,0(a5)
 bae:	479c                	lw	a5,8(a5)
 bb0:	9fb9                	addw	a5,a5,a4
 bb2:	0007871b          	sext.w	a4,a5
 bb6:	fe043783          	ld	a5,-32(s0)
 bba:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 bbc:	fe843783          	ld	a5,-24(s0)
 bc0:	639c                	ld	a5,0(a5)
 bc2:	6398                	ld	a4,0(a5)
 bc4:	fe043783          	ld	a5,-32(s0)
 bc8:	e398                	sd	a4,0(a5)
 bca:	a039                	j	bd8 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 bcc:	fe843783          	ld	a5,-24(s0)
 bd0:	6398                	ld	a4,0(a5)
 bd2:	fe043783          	ld	a5,-32(s0)
 bd6:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 bd8:	fe843783          	ld	a5,-24(s0)
 bdc:	479c                	lw	a5,8(a5)
 bde:	1782                	slli	a5,a5,0x20
 be0:	9381                	srli	a5,a5,0x20
 be2:	0792                	slli	a5,a5,0x4
 be4:	fe843703          	ld	a4,-24(s0)
 be8:	97ba                	add	a5,a5,a4
 bea:	fe043703          	ld	a4,-32(s0)
 bee:	02f71563          	bne	a4,a5,c18 <free+0x102>
    p->s.size += bp->s.size;
 bf2:	fe843783          	ld	a5,-24(s0)
 bf6:	4798                	lw	a4,8(a5)
 bf8:	fe043783          	ld	a5,-32(s0)
 bfc:	479c                	lw	a5,8(a5)
 bfe:	9fb9                	addw	a5,a5,a4
 c00:	0007871b          	sext.w	a4,a5
 c04:	fe843783          	ld	a5,-24(s0)
 c08:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c0a:	fe043783          	ld	a5,-32(s0)
 c0e:	6398                	ld	a4,0(a5)
 c10:	fe843783          	ld	a5,-24(s0)
 c14:	e398                	sd	a4,0(a5)
 c16:	a031                	j	c22 <free+0x10c>
  } else
    p->s.ptr = bp;
 c18:	fe843783          	ld	a5,-24(s0)
 c1c:	fe043703          	ld	a4,-32(s0)
 c20:	e398                	sd	a4,0(a5)
  freep = p;
 c22:	00000797          	auipc	a5,0x0
 c26:	77e78793          	addi	a5,a5,1918 # 13a0 <freep>
 c2a:	fe843703          	ld	a4,-24(s0)
 c2e:	e398                	sd	a4,0(a5)
}
 c30:	0001                	nop
 c32:	7422                	ld	s0,40(sp)
 c34:	6145                	addi	sp,sp,48
 c36:	8082                	ret

0000000000000c38 <morecore>:

static Header*
morecore(uint nu)
{
 c38:	7179                	addi	sp,sp,-48
 c3a:	f406                	sd	ra,40(sp)
 c3c:	f022                	sd	s0,32(sp)
 c3e:	1800                	addi	s0,sp,48
 c40:	87aa                	mv	a5,a0
 c42:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c46:	fdc42783          	lw	a5,-36(s0)
 c4a:	0007871b          	sext.w	a4,a5
 c4e:	6785                	lui	a5,0x1
 c50:	00f77563          	bgeu	a4,a5,c5a <morecore+0x22>
    nu = 4096;
 c54:	6785                	lui	a5,0x1
 c56:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c5a:	fdc42783          	lw	a5,-36(s0)
 c5e:	0047979b          	slliw	a5,a5,0x4
 c62:	2781                	sext.w	a5,a5
 c64:	2781                	sext.w	a5,a5
 c66:	853e                	mv	a0,a5
 c68:	00000097          	auipc	ra,0x0
 c6c:	986080e7          	jalr	-1658(ra) # 5ee <sbrk>
 c70:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c74:	fe843703          	ld	a4,-24(s0)
 c78:	57fd                	li	a5,-1
 c7a:	00f71463          	bne	a4,a5,c82 <morecore+0x4a>
    return 0;
 c7e:	4781                	li	a5,0
 c80:	a03d                	j	cae <morecore+0x76>
  hp = (Header*)p;
 c82:	fe843783          	ld	a5,-24(s0)
 c86:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c8a:	fe043783          	ld	a5,-32(s0)
 c8e:	fdc42703          	lw	a4,-36(s0)
 c92:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c94:	fe043783          	ld	a5,-32(s0)
 c98:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x358>
 c9a:	853e                	mv	a0,a5
 c9c:	00000097          	auipc	ra,0x0
 ca0:	e7a080e7          	jalr	-390(ra) # b16 <free>
  return freep;
 ca4:	00000797          	auipc	a5,0x0
 ca8:	6fc78793          	addi	a5,a5,1788 # 13a0 <freep>
 cac:	639c                	ld	a5,0(a5)
}
 cae:	853e                	mv	a0,a5
 cb0:	70a2                	ld	ra,40(sp)
 cb2:	7402                	ld	s0,32(sp)
 cb4:	6145                	addi	sp,sp,48
 cb6:	8082                	ret

0000000000000cb8 <malloc>:

void*
malloc(uint nbytes)
{
 cb8:	7139                	addi	sp,sp,-64
 cba:	fc06                	sd	ra,56(sp)
 cbc:	f822                	sd	s0,48(sp)
 cbe:	0080                	addi	s0,sp,64
 cc0:	87aa                	mv	a5,a0
 cc2:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cc6:	fcc46783          	lwu	a5,-52(s0)
 cca:	07bd                	addi	a5,a5,15
 ccc:	8391                	srli	a5,a5,0x4
 cce:	2781                	sext.w	a5,a5
 cd0:	2785                	addiw	a5,a5,1
 cd2:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 cd6:	00000797          	auipc	a5,0x0
 cda:	6ca78793          	addi	a5,a5,1738 # 13a0 <freep>
 cde:	639c                	ld	a5,0(a5)
 ce0:	fef43023          	sd	a5,-32(s0)
 ce4:	fe043783          	ld	a5,-32(s0)
 ce8:	ef95                	bnez	a5,d24 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 cea:	00000797          	auipc	a5,0x0
 cee:	6a678793          	addi	a5,a5,1702 # 1390 <base>
 cf2:	fef43023          	sd	a5,-32(s0)
 cf6:	00000797          	auipc	a5,0x0
 cfa:	6aa78793          	addi	a5,a5,1706 # 13a0 <freep>
 cfe:	fe043703          	ld	a4,-32(s0)
 d02:	e398                	sd	a4,0(a5)
 d04:	00000797          	auipc	a5,0x0
 d08:	69c78793          	addi	a5,a5,1692 # 13a0 <freep>
 d0c:	6398                	ld	a4,0(a5)
 d0e:	00000797          	auipc	a5,0x0
 d12:	68278793          	addi	a5,a5,1666 # 1390 <base>
 d16:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d18:	00000797          	auipc	a5,0x0
 d1c:	67878793          	addi	a5,a5,1656 # 1390 <base>
 d20:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d24:	fe043783          	ld	a5,-32(s0)
 d28:	639c                	ld	a5,0(a5)
 d2a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d2e:	fe843783          	ld	a5,-24(s0)
 d32:	4798                	lw	a4,8(a5)
 d34:	fdc42783          	lw	a5,-36(s0)
 d38:	2781                	sext.w	a5,a5
 d3a:	06f76763          	bltu	a4,a5,da8 <malloc+0xf0>
      if(p->s.size == nunits)
 d3e:	fe843783          	ld	a5,-24(s0)
 d42:	4798                	lw	a4,8(a5)
 d44:	fdc42783          	lw	a5,-36(s0)
 d48:	2781                	sext.w	a5,a5
 d4a:	00e79963          	bne	a5,a4,d5c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d4e:	fe843783          	ld	a5,-24(s0)
 d52:	6398                	ld	a4,0(a5)
 d54:	fe043783          	ld	a5,-32(s0)
 d58:	e398                	sd	a4,0(a5)
 d5a:	a825                	j	d92 <malloc+0xda>
      else {
        p->s.size -= nunits;
 d5c:	fe843783          	ld	a5,-24(s0)
 d60:	479c                	lw	a5,8(a5)
 d62:	fdc42703          	lw	a4,-36(s0)
 d66:	9f99                	subw	a5,a5,a4
 d68:	0007871b          	sext.w	a4,a5
 d6c:	fe843783          	ld	a5,-24(s0)
 d70:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d72:	fe843783          	ld	a5,-24(s0)
 d76:	479c                	lw	a5,8(a5)
 d78:	1782                	slli	a5,a5,0x20
 d7a:	9381                	srli	a5,a5,0x20
 d7c:	0792                	slli	a5,a5,0x4
 d7e:	fe843703          	ld	a4,-24(s0)
 d82:	97ba                	add	a5,a5,a4
 d84:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d88:	fe843783          	ld	a5,-24(s0)
 d8c:	fdc42703          	lw	a4,-36(s0)
 d90:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d92:	00000797          	auipc	a5,0x0
 d96:	60e78793          	addi	a5,a5,1550 # 13a0 <freep>
 d9a:	fe043703          	ld	a4,-32(s0)
 d9e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 da0:	fe843783          	ld	a5,-24(s0)
 da4:	07c1                	addi	a5,a5,16
 da6:	a091                	j	dea <malloc+0x132>
    }
    if(p == freep)
 da8:	00000797          	auipc	a5,0x0
 dac:	5f878793          	addi	a5,a5,1528 # 13a0 <freep>
 db0:	639c                	ld	a5,0(a5)
 db2:	fe843703          	ld	a4,-24(s0)
 db6:	02f71063          	bne	a4,a5,dd6 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 dba:	fdc42783          	lw	a5,-36(s0)
 dbe:	853e                	mv	a0,a5
 dc0:	00000097          	auipc	ra,0x0
 dc4:	e78080e7          	jalr	-392(ra) # c38 <morecore>
 dc8:	fea43423          	sd	a0,-24(s0)
 dcc:	fe843783          	ld	a5,-24(s0)
 dd0:	e399                	bnez	a5,dd6 <malloc+0x11e>
        return 0;
 dd2:	4781                	li	a5,0
 dd4:	a819                	j	dea <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dd6:	fe843783          	ld	a5,-24(s0)
 dda:	fef43023          	sd	a5,-32(s0)
 dde:	fe843783          	ld	a5,-24(s0)
 de2:	639c                	ld	a5,0(a5)
 de4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 de8:	b799                	j	d2e <malloc+0x76>
  }
}
 dea:	853e                	mv	a0,a5
 dec:	70e2                	ld	ra,56(sp)
 dee:	7442                	ld	s0,48(sp)
 df0:	6121                	addi	sp,sp,64
 df2:	8082                	ret
