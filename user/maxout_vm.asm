
user/_maxout_vm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

int
main(int argc, char *argv[]) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
    for (int i = 0; i < 6000; i++) {
  12:	fe042623          	sw	zero,-20(s0)
  16:	a825                	j	4e <main+0x4e>
        uint64 a = (uint64) sbrk(4096);
  18:	6505                	lui	a0,0x1
  1a:	00000097          	auipc	ra,0x0
  1e:	588080e7          	jalr	1416(ra) # 5a2 <sbrk>
  22:	87aa                	mv	a5,a0
  24:	fef43023          	sd	a5,-32(s0)
        if (a == 0xffffffffffffffff) {
  28:	fe043703          	ld	a4,-32(s0)
  2c:	57fd                	li	a5,-1
  2e:	02f70a63          	beq	a4,a5,62 <main+0x62>
            break;
        }

        // modify the memory to make sure it's really allocated.
        *(char *) (a + 4096 - 1) = 1;
  32:	fe043703          	ld	a4,-32(s0)
  36:	6785                	lui	a5,0x1
  38:	17fd                	addi	a5,a5,-1 # fff <malloc+0x393>
  3a:	97ba                	add	a5,a5,a4
  3c:	873e                	mv	a4,a5
  3e:	4785                	li	a5,1
  40:	00f70023          	sb	a5,0(a4)
    for (int i = 0; i < 6000; i++) {
  44:	fec42783          	lw	a5,-20(s0)
  48:	2785                	addiw	a5,a5,1
  4a:	fef42623          	sw	a5,-20(s0)
  4e:	fec42783          	lw	a5,-20(s0)
  52:	0007871b          	sext.w	a4,a5
  56:	6785                	lui	a5,0x1
  58:	76f78793          	addi	a5,a5,1903 # 176f <freep+0x3cf>
  5c:	fae7dee3          	bge	a5,a4,18 <main+0x18>
  60:	a011                	j	64 <main+0x64>
            break;
  62:	0001                	nop
    }

    exit(0);
  64:	4501                	li	a0,0
  66:	00000097          	auipc	ra,0x0
  6a:	4b4080e7          	jalr	1204(ra) # 51a <exit>

000000000000006e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  6e:	1141                	addi	sp,sp,-16
  70:	e406                	sd	ra,8(sp)
  72:	e022                	sd	s0,0(sp)
  74:	0800                	addi	s0,sp,16
  extern int main();
  main();
  76:	00000097          	auipc	ra,0x0
  7a:	f8a080e7          	jalr	-118(ra) # 0 <main>
  exit(0);
  7e:	4501                	li	a0,0
  80:	00000097          	auipc	ra,0x0
  84:	49a080e7          	jalr	1178(ra) # 51a <exit>

0000000000000088 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  88:	7179                	addi	sp,sp,-48
  8a:	f422                	sd	s0,40(sp)
  8c:	1800                	addi	s0,sp,48
  8e:	fca43c23          	sd	a0,-40(s0)
  92:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  96:	fd843783          	ld	a5,-40(s0)
  9a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  9e:	0001                	nop
  a0:	fd043703          	ld	a4,-48(s0)
  a4:	00170793          	addi	a5,a4,1
  a8:	fcf43823          	sd	a5,-48(s0)
  ac:	fd843783          	ld	a5,-40(s0)
  b0:	00178693          	addi	a3,a5,1
  b4:	fcd43c23          	sd	a3,-40(s0)
  b8:	00074703          	lbu	a4,0(a4)
  bc:	00e78023          	sb	a4,0(a5)
  c0:	0007c783          	lbu	a5,0(a5)
  c4:	fff1                	bnez	a5,a0 <strcpy+0x18>
    ;
  return os;
  c6:	fe843783          	ld	a5,-24(s0)
}
  ca:	853e                	mv	a0,a5
  cc:	7422                	ld	s0,40(sp)
  ce:	6145                	addi	sp,sp,48
  d0:	8082                	ret

00000000000000d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d2:	1101                	addi	sp,sp,-32
  d4:	ec22                	sd	s0,24(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	fea43423          	sd	a0,-24(s0)
  dc:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  e0:	a819                	j	f6 <strcmp+0x24>
    p++, q++;
  e2:	fe843783          	ld	a5,-24(s0)
  e6:	0785                	addi	a5,a5,1
  e8:	fef43423          	sd	a5,-24(s0)
  ec:	fe043783          	ld	a5,-32(s0)
  f0:	0785                	addi	a5,a5,1
  f2:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  f6:	fe843783          	ld	a5,-24(s0)
  fa:	0007c783          	lbu	a5,0(a5)
  fe:	cb99                	beqz	a5,114 <strcmp+0x42>
 100:	fe843783          	ld	a5,-24(s0)
 104:	0007c703          	lbu	a4,0(a5)
 108:	fe043783          	ld	a5,-32(s0)
 10c:	0007c783          	lbu	a5,0(a5)
 110:	fcf709e3          	beq	a4,a5,e2 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 114:	fe843783          	ld	a5,-24(s0)
 118:	0007c783          	lbu	a5,0(a5)
 11c:	0007871b          	sext.w	a4,a5
 120:	fe043783          	ld	a5,-32(s0)
 124:	0007c783          	lbu	a5,0(a5)
 128:	2781                	sext.w	a5,a5
 12a:	40f707bb          	subw	a5,a4,a5
 12e:	2781                	sext.w	a5,a5
}
 130:	853e                	mv	a0,a5
 132:	6462                	ld	s0,24(sp)
 134:	6105                	addi	sp,sp,32
 136:	8082                	ret

0000000000000138 <strlen>:

uint
strlen(const char *s)
{
 138:	7179                	addi	sp,sp,-48
 13a:	f422                	sd	s0,40(sp)
 13c:	1800                	addi	s0,sp,48
 13e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 142:	fe042623          	sw	zero,-20(s0)
 146:	a031                	j	152 <strlen+0x1a>
 148:	fec42783          	lw	a5,-20(s0)
 14c:	2785                	addiw	a5,a5,1
 14e:	fef42623          	sw	a5,-20(s0)
 152:	fec42783          	lw	a5,-20(s0)
 156:	fd843703          	ld	a4,-40(s0)
 15a:	97ba                	add	a5,a5,a4
 15c:	0007c783          	lbu	a5,0(a5)
 160:	f7e5                	bnez	a5,148 <strlen+0x10>
    ;
  return n;
 162:	fec42783          	lw	a5,-20(s0)
}
 166:	853e                	mv	a0,a5
 168:	7422                	ld	s0,40(sp)
 16a:	6145                	addi	sp,sp,48
 16c:	8082                	ret

000000000000016e <memset>:

void*
memset(void *dst, int c, uint n)
{
 16e:	7179                	addi	sp,sp,-48
 170:	f422                	sd	s0,40(sp)
 172:	1800                	addi	s0,sp,48
 174:	fca43c23          	sd	a0,-40(s0)
 178:	87ae                	mv	a5,a1
 17a:	8732                	mv	a4,a2
 17c:	fcf42a23          	sw	a5,-44(s0)
 180:	87ba                	mv	a5,a4
 182:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 186:	fd843783          	ld	a5,-40(s0)
 18a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 18e:	fe042623          	sw	zero,-20(s0)
 192:	a00d                	j	1b4 <memset+0x46>
    cdst[i] = c;
 194:	fec42783          	lw	a5,-20(s0)
 198:	fe043703          	ld	a4,-32(s0)
 19c:	97ba                	add	a5,a5,a4
 19e:	fd442703          	lw	a4,-44(s0)
 1a2:	0ff77713          	zext.b	a4,a4
 1a6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1aa:	fec42783          	lw	a5,-20(s0)
 1ae:	2785                	addiw	a5,a5,1
 1b0:	fef42623          	sw	a5,-20(s0)
 1b4:	fec42703          	lw	a4,-20(s0)
 1b8:	fd042783          	lw	a5,-48(s0)
 1bc:	2781                	sext.w	a5,a5
 1be:	fcf76be3          	bltu	a4,a5,194 <memset+0x26>
  }
  return dst;
 1c2:	fd843783          	ld	a5,-40(s0)
}
 1c6:	853e                	mv	a0,a5
 1c8:	7422                	ld	s0,40(sp)
 1ca:	6145                	addi	sp,sp,48
 1cc:	8082                	ret

00000000000001ce <strchr>:

char*
strchr(const char *s, char c)
{
 1ce:	1101                	addi	sp,sp,-32
 1d0:	ec22                	sd	s0,24(sp)
 1d2:	1000                	addi	s0,sp,32
 1d4:	fea43423          	sd	a0,-24(s0)
 1d8:	87ae                	mv	a5,a1
 1da:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1de:	a01d                	j	204 <strchr+0x36>
    if(*s == c)
 1e0:	fe843783          	ld	a5,-24(s0)
 1e4:	0007c703          	lbu	a4,0(a5)
 1e8:	fe744783          	lbu	a5,-25(s0)
 1ec:	0ff7f793          	zext.b	a5,a5
 1f0:	00e79563          	bne	a5,a4,1fa <strchr+0x2c>
      return (char*)s;
 1f4:	fe843783          	ld	a5,-24(s0)
 1f8:	a821                	j	210 <strchr+0x42>
  for(; *s; s++)
 1fa:	fe843783          	ld	a5,-24(s0)
 1fe:	0785                	addi	a5,a5,1
 200:	fef43423          	sd	a5,-24(s0)
 204:	fe843783          	ld	a5,-24(s0)
 208:	0007c783          	lbu	a5,0(a5)
 20c:	fbf1                	bnez	a5,1e0 <strchr+0x12>
  return 0;
 20e:	4781                	li	a5,0
}
 210:	853e                	mv	a0,a5
 212:	6462                	ld	s0,24(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret

0000000000000218 <gets>:

char*
gets(char *buf, int max)
{
 218:	7179                	addi	sp,sp,-48
 21a:	f406                	sd	ra,40(sp)
 21c:	f022                	sd	s0,32(sp)
 21e:	1800                	addi	s0,sp,48
 220:	fca43c23          	sd	a0,-40(s0)
 224:	87ae                	mv	a5,a1
 226:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22a:	fe042623          	sw	zero,-20(s0)
 22e:	a8a1                	j	286 <gets+0x6e>
    cc = read(0, &c, 1);
 230:	fe740793          	addi	a5,s0,-25
 234:	4605                	li	a2,1
 236:	85be                	mv	a1,a5
 238:	4501                	li	a0,0
 23a:	00000097          	auipc	ra,0x0
 23e:	2f8080e7          	jalr	760(ra) # 532 <read>
 242:	87aa                	mv	a5,a0
 244:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 248:	fe842783          	lw	a5,-24(s0)
 24c:	2781                	sext.w	a5,a5
 24e:	04f05763          	blez	a5,29c <gets+0x84>
      break;
    buf[i++] = c;
 252:	fec42783          	lw	a5,-20(s0)
 256:	0017871b          	addiw	a4,a5,1
 25a:	fee42623          	sw	a4,-20(s0)
 25e:	873e                	mv	a4,a5
 260:	fd843783          	ld	a5,-40(s0)
 264:	97ba                	add	a5,a5,a4
 266:	fe744703          	lbu	a4,-25(s0)
 26a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 26e:	fe744783          	lbu	a5,-25(s0)
 272:	873e                	mv	a4,a5
 274:	47a9                	li	a5,10
 276:	02f70463          	beq	a4,a5,29e <gets+0x86>
 27a:	fe744783          	lbu	a5,-25(s0)
 27e:	873e                	mv	a4,a5
 280:	47b5                	li	a5,13
 282:	00f70e63          	beq	a4,a5,29e <gets+0x86>
  for(i=0; i+1 < max; ){
 286:	fec42783          	lw	a5,-20(s0)
 28a:	2785                	addiw	a5,a5,1
 28c:	0007871b          	sext.w	a4,a5
 290:	fd442783          	lw	a5,-44(s0)
 294:	2781                	sext.w	a5,a5
 296:	f8f74de3          	blt	a4,a5,230 <gets+0x18>
 29a:	a011                	j	29e <gets+0x86>
      break;
 29c:	0001                	nop
      break;
  }
  buf[i] = '\0';
 29e:	fec42783          	lw	a5,-20(s0)
 2a2:	fd843703          	ld	a4,-40(s0)
 2a6:	97ba                	add	a5,a5,a4
 2a8:	00078023          	sb	zero,0(a5)
  return buf;
 2ac:	fd843783          	ld	a5,-40(s0)
}
 2b0:	853e                	mv	a0,a5
 2b2:	70a2                	ld	ra,40(sp)
 2b4:	7402                	ld	s0,32(sp)
 2b6:	6145                	addi	sp,sp,48
 2b8:	8082                	ret

00000000000002ba <stat>:

int
stat(const char *n, struct stat *st)
{
 2ba:	7179                	addi	sp,sp,-48
 2bc:	f406                	sd	ra,40(sp)
 2be:	f022                	sd	s0,32(sp)
 2c0:	1800                	addi	s0,sp,48
 2c2:	fca43c23          	sd	a0,-40(s0)
 2c6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ca:	4581                	li	a1,0
 2cc:	fd843503          	ld	a0,-40(s0)
 2d0:	00000097          	auipc	ra,0x0
 2d4:	28a080e7          	jalr	650(ra) # 55a <open>
 2d8:	87aa                	mv	a5,a0
 2da:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2de:	fec42783          	lw	a5,-20(s0)
 2e2:	2781                	sext.w	a5,a5
 2e4:	0007d463          	bgez	a5,2ec <stat+0x32>
    return -1;
 2e8:	57fd                	li	a5,-1
 2ea:	a035                	j	316 <stat+0x5c>
  r = fstat(fd, st);
 2ec:	fec42783          	lw	a5,-20(s0)
 2f0:	fd043583          	ld	a1,-48(s0)
 2f4:	853e                	mv	a0,a5
 2f6:	00000097          	auipc	ra,0x0
 2fa:	27c080e7          	jalr	636(ra) # 572 <fstat>
 2fe:	87aa                	mv	a5,a0
 300:	fef42423          	sw	a5,-24(s0)
  close(fd);
 304:	fec42783          	lw	a5,-20(s0)
 308:	853e                	mv	a0,a5
 30a:	00000097          	auipc	ra,0x0
 30e:	238080e7          	jalr	568(ra) # 542 <close>
  return r;
 312:	fe842783          	lw	a5,-24(s0)
}
 316:	853e                	mv	a0,a5
 318:	70a2                	ld	ra,40(sp)
 31a:	7402                	ld	s0,32(sp)
 31c:	6145                	addi	sp,sp,48
 31e:	8082                	ret

0000000000000320 <atoi>:

int
atoi(const char *s)
{
 320:	7179                	addi	sp,sp,-48
 322:	f422                	sd	s0,40(sp)
 324:	1800                	addi	s0,sp,48
 326:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 32a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 32e:	a81d                	j	364 <atoi+0x44>
    n = n*10 + *s++ - '0';
 330:	fec42783          	lw	a5,-20(s0)
 334:	873e                	mv	a4,a5
 336:	87ba                	mv	a5,a4
 338:	0027979b          	slliw	a5,a5,0x2
 33c:	9fb9                	addw	a5,a5,a4
 33e:	0017979b          	slliw	a5,a5,0x1
 342:	0007871b          	sext.w	a4,a5
 346:	fd843783          	ld	a5,-40(s0)
 34a:	00178693          	addi	a3,a5,1
 34e:	fcd43c23          	sd	a3,-40(s0)
 352:	0007c783          	lbu	a5,0(a5)
 356:	2781                	sext.w	a5,a5
 358:	9fb9                	addw	a5,a5,a4
 35a:	2781                	sext.w	a5,a5
 35c:	fd07879b          	addiw	a5,a5,-48
 360:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 364:	fd843783          	ld	a5,-40(s0)
 368:	0007c783          	lbu	a5,0(a5)
 36c:	873e                	mv	a4,a5
 36e:	02f00793          	li	a5,47
 372:	00e7fb63          	bgeu	a5,a4,388 <atoi+0x68>
 376:	fd843783          	ld	a5,-40(s0)
 37a:	0007c783          	lbu	a5,0(a5)
 37e:	873e                	mv	a4,a5
 380:	03900793          	li	a5,57
 384:	fae7f6e3          	bgeu	a5,a4,330 <atoi+0x10>
  return n;
 388:	fec42783          	lw	a5,-20(s0)
}
 38c:	853e                	mv	a0,a5
 38e:	7422                	ld	s0,40(sp)
 390:	6145                	addi	sp,sp,48
 392:	8082                	ret

0000000000000394 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 394:	7139                	addi	sp,sp,-64
 396:	fc22                	sd	s0,56(sp)
 398:	0080                	addi	s0,sp,64
 39a:	fca43c23          	sd	a0,-40(s0)
 39e:	fcb43823          	sd	a1,-48(s0)
 3a2:	87b2                	mv	a5,a2
 3a4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3a8:	fd843783          	ld	a5,-40(s0)
 3ac:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3b0:	fd043783          	ld	a5,-48(s0)
 3b4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3b8:	fe043703          	ld	a4,-32(s0)
 3bc:	fe843783          	ld	a5,-24(s0)
 3c0:	02e7fc63          	bgeu	a5,a4,3f8 <memmove+0x64>
    while(n-- > 0)
 3c4:	a00d                	j	3e6 <memmove+0x52>
      *dst++ = *src++;
 3c6:	fe043703          	ld	a4,-32(s0)
 3ca:	00170793          	addi	a5,a4,1
 3ce:	fef43023          	sd	a5,-32(s0)
 3d2:	fe843783          	ld	a5,-24(s0)
 3d6:	00178693          	addi	a3,a5,1
 3da:	fed43423          	sd	a3,-24(s0)
 3de:	00074703          	lbu	a4,0(a4)
 3e2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3e6:	fcc42783          	lw	a5,-52(s0)
 3ea:	fff7871b          	addiw	a4,a5,-1
 3ee:	fce42623          	sw	a4,-52(s0)
 3f2:	fcf04ae3          	bgtz	a5,3c6 <memmove+0x32>
 3f6:	a891                	j	44a <memmove+0xb6>
  } else {
    dst += n;
 3f8:	fcc42783          	lw	a5,-52(s0)
 3fc:	fe843703          	ld	a4,-24(s0)
 400:	97ba                	add	a5,a5,a4
 402:	fef43423          	sd	a5,-24(s0)
    src += n;
 406:	fcc42783          	lw	a5,-52(s0)
 40a:	fe043703          	ld	a4,-32(s0)
 40e:	97ba                	add	a5,a5,a4
 410:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 414:	a01d                	j	43a <memmove+0xa6>
      *--dst = *--src;
 416:	fe043783          	ld	a5,-32(s0)
 41a:	17fd                	addi	a5,a5,-1
 41c:	fef43023          	sd	a5,-32(s0)
 420:	fe843783          	ld	a5,-24(s0)
 424:	17fd                	addi	a5,a5,-1
 426:	fef43423          	sd	a5,-24(s0)
 42a:	fe043783          	ld	a5,-32(s0)
 42e:	0007c703          	lbu	a4,0(a5)
 432:	fe843783          	ld	a5,-24(s0)
 436:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 43a:	fcc42783          	lw	a5,-52(s0)
 43e:	fff7871b          	addiw	a4,a5,-1
 442:	fce42623          	sw	a4,-52(s0)
 446:	fcf048e3          	bgtz	a5,416 <memmove+0x82>
  }
  return vdst;
 44a:	fd843783          	ld	a5,-40(s0)
}
 44e:	853e                	mv	a0,a5
 450:	7462                	ld	s0,56(sp)
 452:	6121                	addi	sp,sp,64
 454:	8082                	ret

0000000000000456 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 456:	7139                	addi	sp,sp,-64
 458:	fc22                	sd	s0,56(sp)
 45a:	0080                	addi	s0,sp,64
 45c:	fca43c23          	sd	a0,-40(s0)
 460:	fcb43823          	sd	a1,-48(s0)
 464:	87b2                	mv	a5,a2
 466:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 46a:	fd843783          	ld	a5,-40(s0)
 46e:	fef43423          	sd	a5,-24(s0)
 472:	fd043783          	ld	a5,-48(s0)
 476:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 47a:	a0a1                	j	4c2 <memcmp+0x6c>
    if (*p1 != *p2) {
 47c:	fe843783          	ld	a5,-24(s0)
 480:	0007c703          	lbu	a4,0(a5)
 484:	fe043783          	ld	a5,-32(s0)
 488:	0007c783          	lbu	a5,0(a5)
 48c:	02f70163          	beq	a4,a5,4ae <memcmp+0x58>
      return *p1 - *p2;
 490:	fe843783          	ld	a5,-24(s0)
 494:	0007c783          	lbu	a5,0(a5)
 498:	0007871b          	sext.w	a4,a5
 49c:	fe043783          	ld	a5,-32(s0)
 4a0:	0007c783          	lbu	a5,0(a5)
 4a4:	2781                	sext.w	a5,a5
 4a6:	40f707bb          	subw	a5,a4,a5
 4aa:	2781                	sext.w	a5,a5
 4ac:	a01d                	j	4d2 <memcmp+0x7c>
    }
    p1++;
 4ae:	fe843783          	ld	a5,-24(s0)
 4b2:	0785                	addi	a5,a5,1
 4b4:	fef43423          	sd	a5,-24(s0)
    p2++;
 4b8:	fe043783          	ld	a5,-32(s0)
 4bc:	0785                	addi	a5,a5,1
 4be:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c2:	fcc42783          	lw	a5,-52(s0)
 4c6:	fff7871b          	addiw	a4,a5,-1
 4ca:	fce42623          	sw	a4,-52(s0)
 4ce:	f7dd                	bnez	a5,47c <memcmp+0x26>
  }
  return 0;
 4d0:	4781                	li	a5,0
}
 4d2:	853e                	mv	a0,a5
 4d4:	7462                	ld	s0,56(sp)
 4d6:	6121                	addi	sp,sp,64
 4d8:	8082                	ret

00000000000004da <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4da:	7179                	addi	sp,sp,-48
 4dc:	f406                	sd	ra,40(sp)
 4de:	f022                	sd	s0,32(sp)
 4e0:	1800                	addi	s0,sp,48
 4e2:	fea43423          	sd	a0,-24(s0)
 4e6:	feb43023          	sd	a1,-32(s0)
 4ea:	87b2                	mv	a5,a2
 4ec:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4f0:	fdc42783          	lw	a5,-36(s0)
 4f4:	863e                	mv	a2,a5
 4f6:	fe043583          	ld	a1,-32(s0)
 4fa:	fe843503          	ld	a0,-24(s0)
 4fe:	00000097          	auipc	ra,0x0
 502:	e96080e7          	jalr	-362(ra) # 394 <memmove>
 506:	87aa                	mv	a5,a0
}
 508:	853e                	mv	a0,a5
 50a:	70a2                	ld	ra,40(sp)
 50c:	7402                	ld	s0,32(sp)
 50e:	6145                	addi	sp,sp,48
 510:	8082                	ret

0000000000000512 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 512:	4885                	li	a7,1
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <exit>:
.global exit
exit:
 li a7, SYS_exit
 51a:	4889                	li	a7,2
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <wait>:
.global wait
wait:
 li a7, SYS_wait
 522:	488d                	li	a7,3
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 52a:	4891                	li	a7,4
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <read>:
.global read
read:
 li a7, SYS_read
 532:	4895                	li	a7,5
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <write>:
.global write
write:
 li a7, SYS_write
 53a:	48c1                	li	a7,16
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <close>:
.global close
close:
 li a7, SYS_close
 542:	48d5                	li	a7,21
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <kill>:
.global kill
kill:
 li a7, SYS_kill
 54a:	4899                	li	a7,6
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <exec>:
.global exec
exec:
 li a7, SYS_exec
 552:	489d                	li	a7,7
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <open>:
.global open
open:
 li a7, SYS_open
 55a:	48bd                	li	a7,15
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 562:	48c5                	li	a7,17
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 56a:	48c9                	li	a7,18
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 572:	48a1                	li	a7,8
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <link>:
.global link
link:
 li a7, SYS_link
 57a:	48cd                	li	a7,19
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 582:	48d1                	li	a7,20
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 58a:	48a5                	li	a7,9
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <dup>:
.global dup
dup:
 li a7, SYS_dup
 592:	48a9                	li	a7,10
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 59a:	48ad                	li	a7,11
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a2:	48b1                	li	a7,12
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5aa:	48b5                	li	a7,13
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b2:	48b9                	li	a7,14
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
 5ba:	48d9                	li	a7,22
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
 5c2:	48dd                	li	a7,23
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
 5ca:	48e1                	li	a7,24
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
 5d2:	48e5                	li	a7,25
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
 5da:	48e9                	li	a7,26
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
 5e2:	48ed                	li	a7,27
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
 5ea:	48f1                	li	a7,28
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f2:	1101                	addi	sp,sp,-32
 5f4:	ec06                	sd	ra,24(sp)
 5f6:	e822                	sd	s0,16(sp)
 5f8:	1000                	addi	s0,sp,32
 5fa:	87aa                	mv	a5,a0
 5fc:	872e                	mv	a4,a1
 5fe:	fef42623          	sw	a5,-20(s0)
 602:	87ba                	mv	a5,a4
 604:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 608:	feb40713          	addi	a4,s0,-21
 60c:	fec42783          	lw	a5,-20(s0)
 610:	4605                	li	a2,1
 612:	85ba                	mv	a1,a4
 614:	853e                	mv	a0,a5
 616:	00000097          	auipc	ra,0x0
 61a:	f24080e7          	jalr	-220(ra) # 53a <write>
}
 61e:	0001                	nop
 620:	60e2                	ld	ra,24(sp)
 622:	6442                	ld	s0,16(sp)
 624:	6105                	addi	sp,sp,32
 626:	8082                	ret

0000000000000628 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 628:	7139                	addi	sp,sp,-64
 62a:	fc06                	sd	ra,56(sp)
 62c:	f822                	sd	s0,48(sp)
 62e:	0080                	addi	s0,sp,64
 630:	87aa                	mv	a5,a0
 632:	8736                	mv	a4,a3
 634:	fcf42623          	sw	a5,-52(s0)
 638:	87ae                	mv	a5,a1
 63a:	fcf42423          	sw	a5,-56(s0)
 63e:	87b2                	mv	a5,a2
 640:	fcf42223          	sw	a5,-60(s0)
 644:	87ba                	mv	a5,a4
 646:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 64a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 64e:	fc042783          	lw	a5,-64(s0)
 652:	2781                	sext.w	a5,a5
 654:	c38d                	beqz	a5,676 <printint+0x4e>
 656:	fc842783          	lw	a5,-56(s0)
 65a:	2781                	sext.w	a5,a5
 65c:	0007dd63          	bgez	a5,676 <printint+0x4e>
    neg = 1;
 660:	4785                	li	a5,1
 662:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 666:	fc842783          	lw	a5,-56(s0)
 66a:	40f007bb          	negw	a5,a5
 66e:	2781                	sext.w	a5,a5
 670:	fef42223          	sw	a5,-28(s0)
 674:	a029                	j	67e <printint+0x56>
  } else {
    x = xx;
 676:	fc842783          	lw	a5,-56(s0)
 67a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 67e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 682:	fc442783          	lw	a5,-60(s0)
 686:	fe442703          	lw	a4,-28(s0)
 68a:	02f777bb          	remuw	a5,a4,a5
 68e:	0007861b          	sext.w	a2,a5
 692:	fec42783          	lw	a5,-20(s0)
 696:	0017871b          	addiw	a4,a5,1
 69a:	fee42623          	sw	a4,-20(s0)
 69e:	00001697          	auipc	a3,0x1
 6a2:	cd268693          	addi	a3,a3,-814 # 1370 <digits>
 6a6:	02061713          	slli	a4,a2,0x20
 6aa:	9301                	srli	a4,a4,0x20
 6ac:	9736                	add	a4,a4,a3
 6ae:	00074703          	lbu	a4,0(a4)
 6b2:	17c1                	addi	a5,a5,-16
 6b4:	97a2                	add	a5,a5,s0
 6b6:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6ba:	fc442783          	lw	a5,-60(s0)
 6be:	fe442703          	lw	a4,-28(s0)
 6c2:	02f757bb          	divuw	a5,a4,a5
 6c6:	fef42223          	sw	a5,-28(s0)
 6ca:	fe442783          	lw	a5,-28(s0)
 6ce:	2781                	sext.w	a5,a5
 6d0:	fbcd                	bnez	a5,682 <printint+0x5a>
  if(neg)
 6d2:	fe842783          	lw	a5,-24(s0)
 6d6:	2781                	sext.w	a5,a5
 6d8:	cf85                	beqz	a5,710 <printint+0xe8>
    buf[i++] = '-';
 6da:	fec42783          	lw	a5,-20(s0)
 6de:	0017871b          	addiw	a4,a5,1
 6e2:	fee42623          	sw	a4,-20(s0)
 6e6:	17c1                	addi	a5,a5,-16
 6e8:	97a2                	add	a5,a5,s0
 6ea:	02d00713          	li	a4,45
 6ee:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6f2:	a839                	j	710 <printint+0xe8>
    putc(fd, buf[i]);
 6f4:	fec42783          	lw	a5,-20(s0)
 6f8:	17c1                	addi	a5,a5,-16
 6fa:	97a2                	add	a5,a5,s0
 6fc:	fe07c703          	lbu	a4,-32(a5)
 700:	fcc42783          	lw	a5,-52(s0)
 704:	85ba                	mv	a1,a4
 706:	853e                	mv	a0,a5
 708:	00000097          	auipc	ra,0x0
 70c:	eea080e7          	jalr	-278(ra) # 5f2 <putc>
  while(--i >= 0)
 710:	fec42783          	lw	a5,-20(s0)
 714:	37fd                	addiw	a5,a5,-1
 716:	fef42623          	sw	a5,-20(s0)
 71a:	fec42783          	lw	a5,-20(s0)
 71e:	2781                	sext.w	a5,a5
 720:	fc07dae3          	bgez	a5,6f4 <printint+0xcc>
}
 724:	0001                	nop
 726:	0001                	nop
 728:	70e2                	ld	ra,56(sp)
 72a:	7442                	ld	s0,48(sp)
 72c:	6121                	addi	sp,sp,64
 72e:	8082                	ret

0000000000000730 <printptr>:

static void
printptr(int fd, uint64 x) {
 730:	7179                	addi	sp,sp,-48
 732:	f406                	sd	ra,40(sp)
 734:	f022                	sd	s0,32(sp)
 736:	1800                	addi	s0,sp,48
 738:	87aa                	mv	a5,a0
 73a:	fcb43823          	sd	a1,-48(s0)
 73e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 742:	fdc42783          	lw	a5,-36(s0)
 746:	03000593          	li	a1,48
 74a:	853e                	mv	a0,a5
 74c:	00000097          	auipc	ra,0x0
 750:	ea6080e7          	jalr	-346(ra) # 5f2 <putc>
  putc(fd, 'x');
 754:	fdc42783          	lw	a5,-36(s0)
 758:	07800593          	li	a1,120
 75c:	853e                	mv	a0,a5
 75e:	00000097          	auipc	ra,0x0
 762:	e94080e7          	jalr	-364(ra) # 5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 766:	fe042623          	sw	zero,-20(s0)
 76a:	a82d                	j	7a4 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76c:	fd043783          	ld	a5,-48(s0)
 770:	93f1                	srli	a5,a5,0x3c
 772:	00001717          	auipc	a4,0x1
 776:	bfe70713          	addi	a4,a4,-1026 # 1370 <digits>
 77a:	97ba                	add	a5,a5,a4
 77c:	0007c703          	lbu	a4,0(a5)
 780:	fdc42783          	lw	a5,-36(s0)
 784:	85ba                	mv	a1,a4
 786:	853e                	mv	a0,a5
 788:	00000097          	auipc	ra,0x0
 78c:	e6a080e7          	jalr	-406(ra) # 5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 790:	fec42783          	lw	a5,-20(s0)
 794:	2785                	addiw	a5,a5,1
 796:	fef42623          	sw	a5,-20(s0)
 79a:	fd043783          	ld	a5,-48(s0)
 79e:	0792                	slli	a5,a5,0x4
 7a0:	fcf43823          	sd	a5,-48(s0)
 7a4:	fec42783          	lw	a5,-20(s0)
 7a8:	873e                	mv	a4,a5
 7aa:	47bd                	li	a5,15
 7ac:	fce7f0e3          	bgeu	a5,a4,76c <printptr+0x3c>
}
 7b0:	0001                	nop
 7b2:	0001                	nop
 7b4:	70a2                	ld	ra,40(sp)
 7b6:	7402                	ld	s0,32(sp)
 7b8:	6145                	addi	sp,sp,48
 7ba:	8082                	ret

00000000000007bc <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7bc:	715d                	addi	sp,sp,-80
 7be:	e486                	sd	ra,72(sp)
 7c0:	e0a2                	sd	s0,64(sp)
 7c2:	0880                	addi	s0,sp,80
 7c4:	87aa                	mv	a5,a0
 7c6:	fcb43023          	sd	a1,-64(s0)
 7ca:	fac43c23          	sd	a2,-72(s0)
 7ce:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7d2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7d6:	fe042223          	sw	zero,-28(s0)
 7da:	a42d                	j	a04 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7dc:	fe442783          	lw	a5,-28(s0)
 7e0:	fc043703          	ld	a4,-64(s0)
 7e4:	97ba                	add	a5,a5,a4
 7e6:	0007c783          	lbu	a5,0(a5)
 7ea:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7ee:	fe042783          	lw	a5,-32(s0)
 7f2:	2781                	sext.w	a5,a5
 7f4:	eb9d                	bnez	a5,82a <vprintf+0x6e>
      if(c == '%'){
 7f6:	fdc42783          	lw	a5,-36(s0)
 7fa:	0007871b          	sext.w	a4,a5
 7fe:	02500793          	li	a5,37
 802:	00f71763          	bne	a4,a5,810 <vprintf+0x54>
        state = '%';
 806:	02500793          	li	a5,37
 80a:	fef42023          	sw	a5,-32(s0)
 80e:	a2f5                	j	9fa <vprintf+0x23e>
      } else {
        putc(fd, c);
 810:	fdc42783          	lw	a5,-36(s0)
 814:	0ff7f713          	zext.b	a4,a5
 818:	fcc42783          	lw	a5,-52(s0)
 81c:	85ba                	mv	a1,a4
 81e:	853e                	mv	a0,a5
 820:	00000097          	auipc	ra,0x0
 824:	dd2080e7          	jalr	-558(ra) # 5f2 <putc>
 828:	aac9                	j	9fa <vprintf+0x23e>
      }
    } else if(state == '%'){
 82a:	fe042783          	lw	a5,-32(s0)
 82e:	0007871b          	sext.w	a4,a5
 832:	02500793          	li	a5,37
 836:	1cf71263          	bne	a4,a5,9fa <vprintf+0x23e>
      if(c == 'd'){
 83a:	fdc42783          	lw	a5,-36(s0)
 83e:	0007871b          	sext.w	a4,a5
 842:	06400793          	li	a5,100
 846:	02f71463          	bne	a4,a5,86e <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 84a:	fb843783          	ld	a5,-72(s0)
 84e:	00878713          	addi	a4,a5,8
 852:	fae43c23          	sd	a4,-72(s0)
 856:	4398                	lw	a4,0(a5)
 858:	fcc42783          	lw	a5,-52(s0)
 85c:	4685                	li	a3,1
 85e:	4629                	li	a2,10
 860:	85ba                	mv	a1,a4
 862:	853e                	mv	a0,a5
 864:	00000097          	auipc	ra,0x0
 868:	dc4080e7          	jalr	-572(ra) # 628 <printint>
 86c:	a269                	j	9f6 <vprintf+0x23a>
      } else if(c == 'l') {
 86e:	fdc42783          	lw	a5,-36(s0)
 872:	0007871b          	sext.w	a4,a5
 876:	06c00793          	li	a5,108
 87a:	02f71663          	bne	a4,a5,8a6 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 87e:	fb843783          	ld	a5,-72(s0)
 882:	00878713          	addi	a4,a5,8
 886:	fae43c23          	sd	a4,-72(s0)
 88a:	639c                	ld	a5,0(a5)
 88c:	0007871b          	sext.w	a4,a5
 890:	fcc42783          	lw	a5,-52(s0)
 894:	4681                	li	a3,0
 896:	4629                	li	a2,10
 898:	85ba                	mv	a1,a4
 89a:	853e                	mv	a0,a5
 89c:	00000097          	auipc	ra,0x0
 8a0:	d8c080e7          	jalr	-628(ra) # 628 <printint>
 8a4:	aa89                	j	9f6 <vprintf+0x23a>
      } else if(c == 'x') {
 8a6:	fdc42783          	lw	a5,-36(s0)
 8aa:	0007871b          	sext.w	a4,a5
 8ae:	07800793          	li	a5,120
 8b2:	02f71463          	bne	a4,a5,8da <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8b6:	fb843783          	ld	a5,-72(s0)
 8ba:	00878713          	addi	a4,a5,8
 8be:	fae43c23          	sd	a4,-72(s0)
 8c2:	4398                	lw	a4,0(a5)
 8c4:	fcc42783          	lw	a5,-52(s0)
 8c8:	4681                	li	a3,0
 8ca:	4641                	li	a2,16
 8cc:	85ba                	mv	a1,a4
 8ce:	853e                	mv	a0,a5
 8d0:	00000097          	auipc	ra,0x0
 8d4:	d58080e7          	jalr	-680(ra) # 628 <printint>
 8d8:	aa39                	j	9f6 <vprintf+0x23a>
      } else if(c == 'p') {
 8da:	fdc42783          	lw	a5,-36(s0)
 8de:	0007871b          	sext.w	a4,a5
 8e2:	07000793          	li	a5,112
 8e6:	02f71263          	bne	a4,a5,90a <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8ea:	fb843783          	ld	a5,-72(s0)
 8ee:	00878713          	addi	a4,a5,8
 8f2:	fae43c23          	sd	a4,-72(s0)
 8f6:	6398                	ld	a4,0(a5)
 8f8:	fcc42783          	lw	a5,-52(s0)
 8fc:	85ba                	mv	a1,a4
 8fe:	853e                	mv	a0,a5
 900:	00000097          	auipc	ra,0x0
 904:	e30080e7          	jalr	-464(ra) # 730 <printptr>
 908:	a0fd                	j	9f6 <vprintf+0x23a>
      } else if(c == 's'){
 90a:	fdc42783          	lw	a5,-36(s0)
 90e:	0007871b          	sext.w	a4,a5
 912:	07300793          	li	a5,115
 916:	04f71c63          	bne	a4,a5,96e <vprintf+0x1b2>
        s = va_arg(ap, char*);
 91a:	fb843783          	ld	a5,-72(s0)
 91e:	00878713          	addi	a4,a5,8
 922:	fae43c23          	sd	a4,-72(s0)
 926:	639c                	ld	a5,0(a5)
 928:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 92c:	fe843783          	ld	a5,-24(s0)
 930:	eb8d                	bnez	a5,962 <vprintf+0x1a6>
          s = "(null)";
 932:	00000797          	auipc	a5,0x0
 936:	47e78793          	addi	a5,a5,1150 # db0 <malloc+0x144>
 93a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 93e:	a015                	j	962 <vprintf+0x1a6>
          putc(fd, *s);
 940:	fe843783          	ld	a5,-24(s0)
 944:	0007c703          	lbu	a4,0(a5)
 948:	fcc42783          	lw	a5,-52(s0)
 94c:	85ba                	mv	a1,a4
 94e:	853e                	mv	a0,a5
 950:	00000097          	auipc	ra,0x0
 954:	ca2080e7          	jalr	-862(ra) # 5f2 <putc>
          s++;
 958:	fe843783          	ld	a5,-24(s0)
 95c:	0785                	addi	a5,a5,1
 95e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 962:	fe843783          	ld	a5,-24(s0)
 966:	0007c783          	lbu	a5,0(a5)
 96a:	fbf9                	bnez	a5,940 <vprintf+0x184>
 96c:	a069                	j	9f6 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 96e:	fdc42783          	lw	a5,-36(s0)
 972:	0007871b          	sext.w	a4,a5
 976:	06300793          	li	a5,99
 97a:	02f71463          	bne	a4,a5,9a2 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 97e:	fb843783          	ld	a5,-72(s0)
 982:	00878713          	addi	a4,a5,8
 986:	fae43c23          	sd	a4,-72(s0)
 98a:	439c                	lw	a5,0(a5)
 98c:	0ff7f713          	zext.b	a4,a5
 990:	fcc42783          	lw	a5,-52(s0)
 994:	85ba                	mv	a1,a4
 996:	853e                	mv	a0,a5
 998:	00000097          	auipc	ra,0x0
 99c:	c5a080e7          	jalr	-934(ra) # 5f2 <putc>
 9a0:	a899                	j	9f6 <vprintf+0x23a>
      } else if(c == '%'){
 9a2:	fdc42783          	lw	a5,-36(s0)
 9a6:	0007871b          	sext.w	a4,a5
 9aa:	02500793          	li	a5,37
 9ae:	00f71f63          	bne	a4,a5,9cc <vprintf+0x210>
        putc(fd, c);
 9b2:	fdc42783          	lw	a5,-36(s0)
 9b6:	0ff7f713          	zext.b	a4,a5
 9ba:	fcc42783          	lw	a5,-52(s0)
 9be:	85ba                	mv	a1,a4
 9c0:	853e                	mv	a0,a5
 9c2:	00000097          	auipc	ra,0x0
 9c6:	c30080e7          	jalr	-976(ra) # 5f2 <putc>
 9ca:	a035                	j	9f6 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9cc:	fcc42783          	lw	a5,-52(s0)
 9d0:	02500593          	li	a1,37
 9d4:	853e                	mv	a0,a5
 9d6:	00000097          	auipc	ra,0x0
 9da:	c1c080e7          	jalr	-996(ra) # 5f2 <putc>
        putc(fd, c);
 9de:	fdc42783          	lw	a5,-36(s0)
 9e2:	0ff7f713          	zext.b	a4,a5
 9e6:	fcc42783          	lw	a5,-52(s0)
 9ea:	85ba                	mv	a1,a4
 9ec:	853e                	mv	a0,a5
 9ee:	00000097          	auipc	ra,0x0
 9f2:	c04080e7          	jalr	-1020(ra) # 5f2 <putc>
      }
      state = 0;
 9f6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9fa:	fe442783          	lw	a5,-28(s0)
 9fe:	2785                	addiw	a5,a5,1
 a00:	fef42223          	sw	a5,-28(s0)
 a04:	fe442783          	lw	a5,-28(s0)
 a08:	fc043703          	ld	a4,-64(s0)
 a0c:	97ba                	add	a5,a5,a4
 a0e:	0007c783          	lbu	a5,0(a5)
 a12:	dc0795e3          	bnez	a5,7dc <vprintf+0x20>
    }
  }
}
 a16:	0001                	nop
 a18:	0001                	nop
 a1a:	60a6                	ld	ra,72(sp)
 a1c:	6406                	ld	s0,64(sp)
 a1e:	6161                	addi	sp,sp,80
 a20:	8082                	ret

0000000000000a22 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a22:	7159                	addi	sp,sp,-112
 a24:	fc06                	sd	ra,56(sp)
 a26:	f822                	sd	s0,48(sp)
 a28:	0080                	addi	s0,sp,64
 a2a:	fcb43823          	sd	a1,-48(s0)
 a2e:	e010                	sd	a2,0(s0)
 a30:	e414                	sd	a3,8(s0)
 a32:	e818                	sd	a4,16(s0)
 a34:	ec1c                	sd	a5,24(s0)
 a36:	03043023          	sd	a6,32(s0)
 a3a:	03143423          	sd	a7,40(s0)
 a3e:	87aa                	mv	a5,a0
 a40:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a44:	03040793          	addi	a5,s0,48
 a48:	fcf43423          	sd	a5,-56(s0)
 a4c:	fc843783          	ld	a5,-56(s0)
 a50:	fd078793          	addi	a5,a5,-48
 a54:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a58:	fe843703          	ld	a4,-24(s0)
 a5c:	fdc42783          	lw	a5,-36(s0)
 a60:	863a                	mv	a2,a4
 a62:	fd043583          	ld	a1,-48(s0)
 a66:	853e                	mv	a0,a5
 a68:	00000097          	auipc	ra,0x0
 a6c:	d54080e7          	jalr	-684(ra) # 7bc <vprintf>
}
 a70:	0001                	nop
 a72:	70e2                	ld	ra,56(sp)
 a74:	7442                	ld	s0,48(sp)
 a76:	6165                	addi	sp,sp,112
 a78:	8082                	ret

0000000000000a7a <printf>:

void
printf(const char *fmt, ...)
{
 a7a:	7159                	addi	sp,sp,-112
 a7c:	f406                	sd	ra,40(sp)
 a7e:	f022                	sd	s0,32(sp)
 a80:	1800                	addi	s0,sp,48
 a82:	fca43c23          	sd	a0,-40(s0)
 a86:	e40c                	sd	a1,8(s0)
 a88:	e810                	sd	a2,16(s0)
 a8a:	ec14                	sd	a3,24(s0)
 a8c:	f018                	sd	a4,32(s0)
 a8e:	f41c                	sd	a5,40(s0)
 a90:	03043823          	sd	a6,48(s0)
 a94:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a98:	04040793          	addi	a5,s0,64
 a9c:	fcf43823          	sd	a5,-48(s0)
 aa0:	fd043783          	ld	a5,-48(s0)
 aa4:	fc878793          	addi	a5,a5,-56
 aa8:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 aac:	fe843783          	ld	a5,-24(s0)
 ab0:	863e                	mv	a2,a5
 ab2:	fd843583          	ld	a1,-40(s0)
 ab6:	4505                	li	a0,1
 ab8:	00000097          	auipc	ra,0x0
 abc:	d04080e7          	jalr	-764(ra) # 7bc <vprintf>
}
 ac0:	0001                	nop
 ac2:	70a2                	ld	ra,40(sp)
 ac4:	7402                	ld	s0,32(sp)
 ac6:	6165                	addi	sp,sp,112
 ac8:	8082                	ret

0000000000000aca <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aca:	7179                	addi	sp,sp,-48
 acc:	f422                	sd	s0,40(sp)
 ace:	1800                	addi	s0,sp,48
 ad0:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ad4:	fd843783          	ld	a5,-40(s0)
 ad8:	17c1                	addi	a5,a5,-16
 ada:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ade:	00001797          	auipc	a5,0x1
 ae2:	8c278793          	addi	a5,a5,-1854 # 13a0 <freep>
 ae6:	639c                	ld	a5,0(a5)
 ae8:	fef43423          	sd	a5,-24(s0)
 aec:	a815                	j	b20 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aee:	fe843783          	ld	a5,-24(s0)
 af2:	639c                	ld	a5,0(a5)
 af4:	fe843703          	ld	a4,-24(s0)
 af8:	00f76f63          	bltu	a4,a5,b16 <free+0x4c>
 afc:	fe043703          	ld	a4,-32(s0)
 b00:	fe843783          	ld	a5,-24(s0)
 b04:	02e7eb63          	bltu	a5,a4,b3a <free+0x70>
 b08:	fe843783          	ld	a5,-24(s0)
 b0c:	639c                	ld	a5,0(a5)
 b0e:	fe043703          	ld	a4,-32(s0)
 b12:	02f76463          	bltu	a4,a5,b3a <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b16:	fe843783          	ld	a5,-24(s0)
 b1a:	639c                	ld	a5,0(a5)
 b1c:	fef43423          	sd	a5,-24(s0)
 b20:	fe043703          	ld	a4,-32(s0)
 b24:	fe843783          	ld	a5,-24(s0)
 b28:	fce7f3e3          	bgeu	a5,a4,aee <free+0x24>
 b2c:	fe843783          	ld	a5,-24(s0)
 b30:	639c                	ld	a5,0(a5)
 b32:	fe043703          	ld	a4,-32(s0)
 b36:	faf77ce3          	bgeu	a4,a5,aee <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b3a:	fe043783          	ld	a5,-32(s0)
 b3e:	479c                	lw	a5,8(a5)
 b40:	1782                	slli	a5,a5,0x20
 b42:	9381                	srli	a5,a5,0x20
 b44:	0792                	slli	a5,a5,0x4
 b46:	fe043703          	ld	a4,-32(s0)
 b4a:	973e                	add	a4,a4,a5
 b4c:	fe843783          	ld	a5,-24(s0)
 b50:	639c                	ld	a5,0(a5)
 b52:	02f71763          	bne	a4,a5,b80 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b56:	fe043783          	ld	a5,-32(s0)
 b5a:	4798                	lw	a4,8(a5)
 b5c:	fe843783          	ld	a5,-24(s0)
 b60:	639c                	ld	a5,0(a5)
 b62:	479c                	lw	a5,8(a5)
 b64:	9fb9                	addw	a5,a5,a4
 b66:	0007871b          	sext.w	a4,a5
 b6a:	fe043783          	ld	a5,-32(s0)
 b6e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b70:	fe843783          	ld	a5,-24(s0)
 b74:	639c                	ld	a5,0(a5)
 b76:	6398                	ld	a4,0(a5)
 b78:	fe043783          	ld	a5,-32(s0)
 b7c:	e398                	sd	a4,0(a5)
 b7e:	a039                	j	b8c <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b80:	fe843783          	ld	a5,-24(s0)
 b84:	6398                	ld	a4,0(a5)
 b86:	fe043783          	ld	a5,-32(s0)
 b8a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b8c:	fe843783          	ld	a5,-24(s0)
 b90:	479c                	lw	a5,8(a5)
 b92:	1782                	slli	a5,a5,0x20
 b94:	9381                	srli	a5,a5,0x20
 b96:	0792                	slli	a5,a5,0x4
 b98:	fe843703          	ld	a4,-24(s0)
 b9c:	97ba                	add	a5,a5,a4
 b9e:	fe043703          	ld	a4,-32(s0)
 ba2:	02f71563          	bne	a4,a5,bcc <free+0x102>
    p->s.size += bp->s.size;
 ba6:	fe843783          	ld	a5,-24(s0)
 baa:	4798                	lw	a4,8(a5)
 bac:	fe043783          	ld	a5,-32(s0)
 bb0:	479c                	lw	a5,8(a5)
 bb2:	9fb9                	addw	a5,a5,a4
 bb4:	0007871b          	sext.w	a4,a5
 bb8:	fe843783          	ld	a5,-24(s0)
 bbc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bbe:	fe043783          	ld	a5,-32(s0)
 bc2:	6398                	ld	a4,0(a5)
 bc4:	fe843783          	ld	a5,-24(s0)
 bc8:	e398                	sd	a4,0(a5)
 bca:	a031                	j	bd6 <free+0x10c>
  } else
    p->s.ptr = bp;
 bcc:	fe843783          	ld	a5,-24(s0)
 bd0:	fe043703          	ld	a4,-32(s0)
 bd4:	e398                	sd	a4,0(a5)
  freep = p;
 bd6:	00000797          	auipc	a5,0x0
 bda:	7ca78793          	addi	a5,a5,1994 # 13a0 <freep>
 bde:	fe843703          	ld	a4,-24(s0)
 be2:	e398                	sd	a4,0(a5)
}
 be4:	0001                	nop
 be6:	7422                	ld	s0,40(sp)
 be8:	6145                	addi	sp,sp,48
 bea:	8082                	ret

0000000000000bec <morecore>:

static Header*
morecore(uint nu)
{
 bec:	7179                	addi	sp,sp,-48
 bee:	f406                	sd	ra,40(sp)
 bf0:	f022                	sd	s0,32(sp)
 bf2:	1800                	addi	s0,sp,48
 bf4:	87aa                	mv	a5,a0
 bf6:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bfa:	fdc42783          	lw	a5,-36(s0)
 bfe:	0007871b          	sext.w	a4,a5
 c02:	6785                	lui	a5,0x1
 c04:	00f77563          	bgeu	a4,a5,c0e <morecore+0x22>
    nu = 4096;
 c08:	6785                	lui	a5,0x1
 c0a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c0e:	fdc42783          	lw	a5,-36(s0)
 c12:	0047979b          	slliw	a5,a5,0x4
 c16:	2781                	sext.w	a5,a5
 c18:	2781                	sext.w	a5,a5
 c1a:	853e                	mv	a0,a5
 c1c:	00000097          	auipc	ra,0x0
 c20:	986080e7          	jalr	-1658(ra) # 5a2 <sbrk>
 c24:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c28:	fe843703          	ld	a4,-24(s0)
 c2c:	57fd                	li	a5,-1
 c2e:	00f71463          	bne	a4,a5,c36 <morecore+0x4a>
    return 0;
 c32:	4781                	li	a5,0
 c34:	a03d                	j	c62 <morecore+0x76>
  hp = (Header*)p;
 c36:	fe843783          	ld	a5,-24(s0)
 c3a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c3e:	fe043783          	ld	a5,-32(s0)
 c42:	fdc42703          	lw	a4,-36(s0)
 c46:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c48:	fe043783          	ld	a5,-32(s0)
 c4c:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x3a4>
 c4e:	853e                	mv	a0,a5
 c50:	00000097          	auipc	ra,0x0
 c54:	e7a080e7          	jalr	-390(ra) # aca <free>
  return freep;
 c58:	00000797          	auipc	a5,0x0
 c5c:	74878793          	addi	a5,a5,1864 # 13a0 <freep>
 c60:	639c                	ld	a5,0(a5)
}
 c62:	853e                	mv	a0,a5
 c64:	70a2                	ld	ra,40(sp)
 c66:	7402                	ld	s0,32(sp)
 c68:	6145                	addi	sp,sp,48
 c6a:	8082                	ret

0000000000000c6c <malloc>:

void*
malloc(uint nbytes)
{
 c6c:	7139                	addi	sp,sp,-64
 c6e:	fc06                	sd	ra,56(sp)
 c70:	f822                	sd	s0,48(sp)
 c72:	0080                	addi	s0,sp,64
 c74:	87aa                	mv	a5,a0
 c76:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c7a:	fcc46783          	lwu	a5,-52(s0)
 c7e:	07bd                	addi	a5,a5,15
 c80:	8391                	srli	a5,a5,0x4
 c82:	2781                	sext.w	a5,a5
 c84:	2785                	addiw	a5,a5,1
 c86:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c8a:	00000797          	auipc	a5,0x0
 c8e:	71678793          	addi	a5,a5,1814 # 13a0 <freep>
 c92:	639c                	ld	a5,0(a5)
 c94:	fef43023          	sd	a5,-32(s0)
 c98:	fe043783          	ld	a5,-32(s0)
 c9c:	ef95                	bnez	a5,cd8 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c9e:	00000797          	auipc	a5,0x0
 ca2:	6f278793          	addi	a5,a5,1778 # 1390 <base>
 ca6:	fef43023          	sd	a5,-32(s0)
 caa:	00000797          	auipc	a5,0x0
 cae:	6f678793          	addi	a5,a5,1782 # 13a0 <freep>
 cb2:	fe043703          	ld	a4,-32(s0)
 cb6:	e398                	sd	a4,0(a5)
 cb8:	00000797          	auipc	a5,0x0
 cbc:	6e878793          	addi	a5,a5,1768 # 13a0 <freep>
 cc0:	6398                	ld	a4,0(a5)
 cc2:	00000797          	auipc	a5,0x0
 cc6:	6ce78793          	addi	a5,a5,1742 # 1390 <base>
 cca:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 ccc:	00000797          	auipc	a5,0x0
 cd0:	6c478793          	addi	a5,a5,1732 # 1390 <base>
 cd4:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cd8:	fe043783          	ld	a5,-32(s0)
 cdc:	639c                	ld	a5,0(a5)
 cde:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 ce2:	fe843783          	ld	a5,-24(s0)
 ce6:	4798                	lw	a4,8(a5)
 ce8:	fdc42783          	lw	a5,-36(s0)
 cec:	2781                	sext.w	a5,a5
 cee:	06f76763          	bltu	a4,a5,d5c <malloc+0xf0>
      if(p->s.size == nunits)
 cf2:	fe843783          	ld	a5,-24(s0)
 cf6:	4798                	lw	a4,8(a5)
 cf8:	fdc42783          	lw	a5,-36(s0)
 cfc:	2781                	sext.w	a5,a5
 cfe:	00e79963          	bne	a5,a4,d10 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d02:	fe843783          	ld	a5,-24(s0)
 d06:	6398                	ld	a4,0(a5)
 d08:	fe043783          	ld	a5,-32(s0)
 d0c:	e398                	sd	a4,0(a5)
 d0e:	a825                	j	d46 <malloc+0xda>
      else {
        p->s.size -= nunits;
 d10:	fe843783          	ld	a5,-24(s0)
 d14:	479c                	lw	a5,8(a5)
 d16:	fdc42703          	lw	a4,-36(s0)
 d1a:	9f99                	subw	a5,a5,a4
 d1c:	0007871b          	sext.w	a4,a5
 d20:	fe843783          	ld	a5,-24(s0)
 d24:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d26:	fe843783          	ld	a5,-24(s0)
 d2a:	479c                	lw	a5,8(a5)
 d2c:	1782                	slli	a5,a5,0x20
 d2e:	9381                	srli	a5,a5,0x20
 d30:	0792                	slli	a5,a5,0x4
 d32:	fe843703          	ld	a4,-24(s0)
 d36:	97ba                	add	a5,a5,a4
 d38:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d3c:	fe843783          	ld	a5,-24(s0)
 d40:	fdc42703          	lw	a4,-36(s0)
 d44:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d46:	00000797          	auipc	a5,0x0
 d4a:	65a78793          	addi	a5,a5,1626 # 13a0 <freep>
 d4e:	fe043703          	ld	a4,-32(s0)
 d52:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d54:	fe843783          	ld	a5,-24(s0)
 d58:	07c1                	addi	a5,a5,16
 d5a:	a091                	j	d9e <malloc+0x132>
    }
    if(p == freep)
 d5c:	00000797          	auipc	a5,0x0
 d60:	64478793          	addi	a5,a5,1604 # 13a0 <freep>
 d64:	639c                	ld	a5,0(a5)
 d66:	fe843703          	ld	a4,-24(s0)
 d6a:	02f71063          	bne	a4,a5,d8a <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 d6e:	fdc42783          	lw	a5,-36(s0)
 d72:	853e                	mv	a0,a5
 d74:	00000097          	auipc	ra,0x0
 d78:	e78080e7          	jalr	-392(ra) # bec <morecore>
 d7c:	fea43423          	sd	a0,-24(s0)
 d80:	fe843783          	ld	a5,-24(s0)
 d84:	e399                	bnez	a5,d8a <malloc+0x11e>
        return 0;
 d86:	4781                	li	a5,0
 d88:	a819                	j	d9e <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d8a:	fe843783          	ld	a5,-24(s0)
 d8e:	fef43023          	sd	a5,-32(s0)
 d92:	fe843783          	ld	a5,-24(s0)
 d96:	639c                	ld	a5,0(a5)
 d98:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d9c:	b799                	j	ce2 <malloc+0x76>
  }
}
 d9e:	853e                	mv	a0,a5
 da0:	70e2                	ld	ra,56(sp)
 da2:	7442                	ld	s0,48(sp)
 da4:	6121                	addi	sp,sp,64
 da6:	8082                	ret
