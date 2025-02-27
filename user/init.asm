
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   8:	4589                	li	a1,2
   a:	00001517          	auipc	a0,0x1
   e:	e5e50513          	addi	a0,a0,-418 # e68 <malloc+0x14a>
  12:	00000097          	auipc	ra,0x0
  16:	5fa080e7          	jalr	1530(ra) # 60c <open>
  1a:	87aa                	mv	a5,a0
  1c:	0207d563          	bgez	a5,46 <main+0x46>
    mknod("console", CONSOLE, 0);
  20:	4601                	li	a2,0
  22:	4585                	li	a1,1
  24:	00001517          	auipc	a0,0x1
  28:	e4450513          	addi	a0,a0,-444 # e68 <malloc+0x14a>
  2c:	00000097          	auipc	ra,0x0
  30:	5e8080e7          	jalr	1512(ra) # 614 <mknod>
    open("console", O_RDWR);
  34:	4589                	li	a1,2
  36:	00001517          	auipc	a0,0x1
  3a:	e3250513          	addi	a0,a0,-462 # e68 <malloc+0x14a>
  3e:	00000097          	auipc	ra,0x0
  42:	5ce080e7          	jalr	1486(ra) # 60c <open>
  }
  dup(0);  // stdout
  46:	4501                	li	a0,0
  48:	00000097          	auipc	ra,0x0
  4c:	5fc080e7          	jalr	1532(ra) # 644 <dup>
  dup(0);  // stderr
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	5f2080e7          	jalr	1522(ra) # 644 <dup>

  for(;;){
    printf("init: starting sh\n");
  5a:	00001517          	auipc	a0,0x1
  5e:	e1650513          	addi	a0,a0,-490 # e70 <malloc+0x152>
  62:	00001097          	auipc	ra,0x1
  66:	aca080e7          	jalr	-1334(ra) # b2c <printf>
    pid = fork();
  6a:	00000097          	auipc	ra,0x0
  6e:	55a080e7          	jalr	1370(ra) # 5c4 <fork>
  72:	87aa                	mv	a5,a0
  74:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
  78:	fec42783          	lw	a5,-20(s0)
  7c:	2781                	sext.w	a5,a5
  7e:	0007df63          	bgez	a5,9c <main+0x9c>
      printf("init: fork failed\n");
  82:	00001517          	auipc	a0,0x1
  86:	e0650513          	addi	a0,a0,-506 # e88 <malloc+0x16a>
  8a:	00001097          	auipc	ra,0x1
  8e:	aa2080e7          	jalr	-1374(ra) # b2c <printf>
      exit(1);
  92:	4505                	li	a0,1
  94:	00000097          	auipc	ra,0x0
  98:	538080e7          	jalr	1336(ra) # 5cc <exit>
    }
    if(pid == 0){
  9c:	fec42783          	lw	a5,-20(s0)
  a0:	2781                	sext.w	a5,a5
  a2:	eb95                	bnez	a5,d6 <main+0xd6>
      exec("sh", argv);
  a4:	00001597          	auipc	a1,0x1
  a8:	2cc58593          	addi	a1,a1,716 # 1370 <argv>
  ac:	00001517          	auipc	a0,0x1
  b0:	db450513          	addi	a0,a0,-588 # e60 <malloc+0x142>
  b4:	00000097          	auipc	ra,0x0
  b8:	550080e7          	jalr	1360(ra) # 604 <exec>
      printf("init: exec sh failed\n");
  bc:	00001517          	auipc	a0,0x1
  c0:	de450513          	addi	a0,a0,-540 # ea0 <malloc+0x182>
  c4:	00001097          	auipc	ra,0x1
  c8:	a68080e7          	jalr	-1432(ra) # b2c <printf>
      exit(1);
  cc:	4505                	li	a0,1
  ce:	00000097          	auipc	ra,0x0
  d2:	4fe080e7          	jalr	1278(ra) # 5cc <exit>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  d6:	4501                	li	a0,0
  d8:	00000097          	auipc	ra,0x0
  dc:	4fc080e7          	jalr	1276(ra) # 5d4 <wait>
  e0:	87aa                	mv	a5,a0
  e2:	fef42423          	sw	a5,-24(s0)
      if(wpid == pid){
  e6:	fe842783          	lw	a5,-24(s0)
  ea:	873e                	mv	a4,a5
  ec:	fec42783          	lw	a5,-20(s0)
  f0:	2701                	sext.w	a4,a4
  f2:	2781                	sext.w	a5,a5
  f4:	02f70463          	beq	a4,a5,11c <main+0x11c>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  f8:	fe842783          	lw	a5,-24(s0)
  fc:	2781                	sext.w	a5,a5
  fe:	fc07dce3          	bgez	a5,d6 <main+0xd6>
        printf("init: wait returned an error\n");
 102:	00001517          	auipc	a0,0x1
 106:	db650513          	addi	a0,a0,-586 # eb8 <malloc+0x19a>
 10a:	00001097          	auipc	ra,0x1
 10e:	a22080e7          	jalr	-1502(ra) # b2c <printf>
        exit(1);
 112:	4505                	li	a0,1
 114:	00000097          	auipc	ra,0x0
 118:	4b8080e7          	jalr	1208(ra) # 5cc <exit>
        break;
 11c:	0001                	nop
    printf("init: starting sh\n");
 11e:	bf35                	j	5a <main+0x5a>

0000000000000120 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 120:	1141                	addi	sp,sp,-16
 122:	e406                	sd	ra,8(sp)
 124:	e022                	sd	s0,0(sp)
 126:	0800                	addi	s0,sp,16
  extern int main();
  main();
 128:	00000097          	auipc	ra,0x0
 12c:	ed8080e7          	jalr	-296(ra) # 0 <main>
  exit(0);
 130:	4501                	li	a0,0
 132:	00000097          	auipc	ra,0x0
 136:	49a080e7          	jalr	1178(ra) # 5cc <exit>

000000000000013a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 13a:	7179                	addi	sp,sp,-48
 13c:	f422                	sd	s0,40(sp)
 13e:	1800                	addi	s0,sp,48
 140:	fca43c23          	sd	a0,-40(s0)
 144:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 148:	fd843783          	ld	a5,-40(s0)
 14c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 150:	0001                	nop
 152:	fd043703          	ld	a4,-48(s0)
 156:	00170793          	addi	a5,a4,1
 15a:	fcf43823          	sd	a5,-48(s0)
 15e:	fd843783          	ld	a5,-40(s0)
 162:	00178693          	addi	a3,a5,1
 166:	fcd43c23          	sd	a3,-40(s0)
 16a:	00074703          	lbu	a4,0(a4)
 16e:	00e78023          	sb	a4,0(a5)
 172:	0007c783          	lbu	a5,0(a5)
 176:	fff1                	bnez	a5,152 <strcpy+0x18>
    ;
  return os;
 178:	fe843783          	ld	a5,-24(s0)
}
 17c:	853e                	mv	a0,a5
 17e:	7422                	ld	s0,40(sp)
 180:	6145                	addi	sp,sp,48
 182:	8082                	ret

0000000000000184 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 184:	1101                	addi	sp,sp,-32
 186:	ec22                	sd	s0,24(sp)
 188:	1000                	addi	s0,sp,32
 18a:	fea43423          	sd	a0,-24(s0)
 18e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 192:	a819                	j	1a8 <strcmp+0x24>
    p++, q++;
 194:	fe843783          	ld	a5,-24(s0)
 198:	0785                	addi	a5,a5,1
 19a:	fef43423          	sd	a5,-24(s0)
 19e:	fe043783          	ld	a5,-32(s0)
 1a2:	0785                	addi	a5,a5,1
 1a4:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1a8:	fe843783          	ld	a5,-24(s0)
 1ac:	0007c783          	lbu	a5,0(a5)
 1b0:	cb99                	beqz	a5,1c6 <strcmp+0x42>
 1b2:	fe843783          	ld	a5,-24(s0)
 1b6:	0007c703          	lbu	a4,0(a5)
 1ba:	fe043783          	ld	a5,-32(s0)
 1be:	0007c783          	lbu	a5,0(a5)
 1c2:	fcf709e3          	beq	a4,a5,194 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1c6:	fe843783          	ld	a5,-24(s0)
 1ca:	0007c783          	lbu	a5,0(a5)
 1ce:	0007871b          	sext.w	a4,a5
 1d2:	fe043783          	ld	a5,-32(s0)
 1d6:	0007c783          	lbu	a5,0(a5)
 1da:	2781                	sext.w	a5,a5
 1dc:	40f707bb          	subw	a5,a4,a5
 1e0:	2781                	sext.w	a5,a5
}
 1e2:	853e                	mv	a0,a5
 1e4:	6462                	ld	s0,24(sp)
 1e6:	6105                	addi	sp,sp,32
 1e8:	8082                	ret

00000000000001ea <strlen>:

uint
strlen(const char *s)
{
 1ea:	7179                	addi	sp,sp,-48
 1ec:	f422                	sd	s0,40(sp)
 1ee:	1800                	addi	s0,sp,48
 1f0:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 1f4:	fe042623          	sw	zero,-20(s0)
 1f8:	a031                	j	204 <strlen+0x1a>
 1fa:	fec42783          	lw	a5,-20(s0)
 1fe:	2785                	addiw	a5,a5,1
 200:	fef42623          	sw	a5,-20(s0)
 204:	fec42783          	lw	a5,-20(s0)
 208:	fd843703          	ld	a4,-40(s0)
 20c:	97ba                	add	a5,a5,a4
 20e:	0007c783          	lbu	a5,0(a5)
 212:	f7e5                	bnez	a5,1fa <strlen+0x10>
    ;
  return n;
 214:	fec42783          	lw	a5,-20(s0)
}
 218:	853e                	mv	a0,a5
 21a:	7422                	ld	s0,40(sp)
 21c:	6145                	addi	sp,sp,48
 21e:	8082                	ret

0000000000000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	7179                	addi	sp,sp,-48
 222:	f422                	sd	s0,40(sp)
 224:	1800                	addi	s0,sp,48
 226:	fca43c23          	sd	a0,-40(s0)
 22a:	87ae                	mv	a5,a1
 22c:	8732                	mv	a4,a2
 22e:	fcf42a23          	sw	a5,-44(s0)
 232:	87ba                	mv	a5,a4
 234:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 238:	fd843783          	ld	a5,-40(s0)
 23c:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 240:	fe042623          	sw	zero,-20(s0)
 244:	a00d                	j	266 <memset+0x46>
    cdst[i] = c;
 246:	fec42783          	lw	a5,-20(s0)
 24a:	fe043703          	ld	a4,-32(s0)
 24e:	97ba                	add	a5,a5,a4
 250:	fd442703          	lw	a4,-44(s0)
 254:	0ff77713          	zext.b	a4,a4
 258:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 25c:	fec42783          	lw	a5,-20(s0)
 260:	2785                	addiw	a5,a5,1
 262:	fef42623          	sw	a5,-20(s0)
 266:	fec42703          	lw	a4,-20(s0)
 26a:	fd042783          	lw	a5,-48(s0)
 26e:	2781                	sext.w	a5,a5
 270:	fcf76be3          	bltu	a4,a5,246 <memset+0x26>
  }
  return dst;
 274:	fd843783          	ld	a5,-40(s0)
}
 278:	853e                	mv	a0,a5
 27a:	7422                	ld	s0,40(sp)
 27c:	6145                	addi	sp,sp,48
 27e:	8082                	ret

0000000000000280 <strchr>:

char*
strchr(const char *s, char c)
{
 280:	1101                	addi	sp,sp,-32
 282:	ec22                	sd	s0,24(sp)
 284:	1000                	addi	s0,sp,32
 286:	fea43423          	sd	a0,-24(s0)
 28a:	87ae                	mv	a5,a1
 28c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 290:	a01d                	j	2b6 <strchr+0x36>
    if(*s == c)
 292:	fe843783          	ld	a5,-24(s0)
 296:	0007c703          	lbu	a4,0(a5)
 29a:	fe744783          	lbu	a5,-25(s0)
 29e:	0ff7f793          	zext.b	a5,a5
 2a2:	00e79563          	bne	a5,a4,2ac <strchr+0x2c>
      return (char*)s;
 2a6:	fe843783          	ld	a5,-24(s0)
 2aa:	a821                	j	2c2 <strchr+0x42>
  for(; *s; s++)
 2ac:	fe843783          	ld	a5,-24(s0)
 2b0:	0785                	addi	a5,a5,1
 2b2:	fef43423          	sd	a5,-24(s0)
 2b6:	fe843783          	ld	a5,-24(s0)
 2ba:	0007c783          	lbu	a5,0(a5)
 2be:	fbf1                	bnez	a5,292 <strchr+0x12>
  return 0;
 2c0:	4781                	li	a5,0
}
 2c2:	853e                	mv	a0,a5
 2c4:	6462                	ld	s0,24(sp)
 2c6:	6105                	addi	sp,sp,32
 2c8:	8082                	ret

00000000000002ca <gets>:

char*
gets(char *buf, int max)
{
 2ca:	7179                	addi	sp,sp,-48
 2cc:	f406                	sd	ra,40(sp)
 2ce:	f022                	sd	s0,32(sp)
 2d0:	1800                	addi	s0,sp,48
 2d2:	fca43c23          	sd	a0,-40(s0)
 2d6:	87ae                	mv	a5,a1
 2d8:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2dc:	fe042623          	sw	zero,-20(s0)
 2e0:	a8a1                	j	338 <gets+0x6e>
    cc = read(0, &c, 1);
 2e2:	fe740793          	addi	a5,s0,-25
 2e6:	4605                	li	a2,1
 2e8:	85be                	mv	a1,a5
 2ea:	4501                	li	a0,0
 2ec:	00000097          	auipc	ra,0x0
 2f0:	2f8080e7          	jalr	760(ra) # 5e4 <read>
 2f4:	87aa                	mv	a5,a0
 2f6:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2fa:	fe842783          	lw	a5,-24(s0)
 2fe:	2781                	sext.w	a5,a5
 300:	04f05763          	blez	a5,34e <gets+0x84>
      break;
    buf[i++] = c;
 304:	fec42783          	lw	a5,-20(s0)
 308:	0017871b          	addiw	a4,a5,1
 30c:	fee42623          	sw	a4,-20(s0)
 310:	873e                	mv	a4,a5
 312:	fd843783          	ld	a5,-40(s0)
 316:	97ba                	add	a5,a5,a4
 318:	fe744703          	lbu	a4,-25(s0)
 31c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 320:	fe744783          	lbu	a5,-25(s0)
 324:	873e                	mv	a4,a5
 326:	47a9                	li	a5,10
 328:	02f70463          	beq	a4,a5,350 <gets+0x86>
 32c:	fe744783          	lbu	a5,-25(s0)
 330:	873e                	mv	a4,a5
 332:	47b5                	li	a5,13
 334:	00f70e63          	beq	a4,a5,350 <gets+0x86>
  for(i=0; i+1 < max; ){
 338:	fec42783          	lw	a5,-20(s0)
 33c:	2785                	addiw	a5,a5,1
 33e:	0007871b          	sext.w	a4,a5
 342:	fd442783          	lw	a5,-44(s0)
 346:	2781                	sext.w	a5,a5
 348:	f8f74de3          	blt	a4,a5,2e2 <gets+0x18>
 34c:	a011                	j	350 <gets+0x86>
      break;
 34e:	0001                	nop
      break;
  }
  buf[i] = '\0';
 350:	fec42783          	lw	a5,-20(s0)
 354:	fd843703          	ld	a4,-40(s0)
 358:	97ba                	add	a5,a5,a4
 35a:	00078023          	sb	zero,0(a5)
  return buf;
 35e:	fd843783          	ld	a5,-40(s0)
}
 362:	853e                	mv	a0,a5
 364:	70a2                	ld	ra,40(sp)
 366:	7402                	ld	s0,32(sp)
 368:	6145                	addi	sp,sp,48
 36a:	8082                	ret

000000000000036c <stat>:

int
stat(const char *n, struct stat *st)
{
 36c:	7179                	addi	sp,sp,-48
 36e:	f406                	sd	ra,40(sp)
 370:	f022                	sd	s0,32(sp)
 372:	1800                	addi	s0,sp,48
 374:	fca43c23          	sd	a0,-40(s0)
 378:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 37c:	4581                	li	a1,0
 37e:	fd843503          	ld	a0,-40(s0)
 382:	00000097          	auipc	ra,0x0
 386:	28a080e7          	jalr	650(ra) # 60c <open>
 38a:	87aa                	mv	a5,a0
 38c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 390:	fec42783          	lw	a5,-20(s0)
 394:	2781                	sext.w	a5,a5
 396:	0007d463          	bgez	a5,39e <stat+0x32>
    return -1;
 39a:	57fd                	li	a5,-1
 39c:	a035                	j	3c8 <stat+0x5c>
  r = fstat(fd, st);
 39e:	fec42783          	lw	a5,-20(s0)
 3a2:	fd043583          	ld	a1,-48(s0)
 3a6:	853e                	mv	a0,a5
 3a8:	00000097          	auipc	ra,0x0
 3ac:	27c080e7          	jalr	636(ra) # 624 <fstat>
 3b0:	87aa                	mv	a5,a0
 3b2:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3b6:	fec42783          	lw	a5,-20(s0)
 3ba:	853e                	mv	a0,a5
 3bc:	00000097          	auipc	ra,0x0
 3c0:	238080e7          	jalr	568(ra) # 5f4 <close>
  return r;
 3c4:	fe842783          	lw	a5,-24(s0)
}
 3c8:	853e                	mv	a0,a5
 3ca:	70a2                	ld	ra,40(sp)
 3cc:	7402                	ld	s0,32(sp)
 3ce:	6145                	addi	sp,sp,48
 3d0:	8082                	ret

00000000000003d2 <atoi>:

int
atoi(const char *s)
{
 3d2:	7179                	addi	sp,sp,-48
 3d4:	f422                	sd	s0,40(sp)
 3d6:	1800                	addi	s0,sp,48
 3d8:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3dc:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3e0:	a81d                	j	416 <atoi+0x44>
    n = n*10 + *s++ - '0';
 3e2:	fec42783          	lw	a5,-20(s0)
 3e6:	873e                	mv	a4,a5
 3e8:	87ba                	mv	a5,a4
 3ea:	0027979b          	slliw	a5,a5,0x2
 3ee:	9fb9                	addw	a5,a5,a4
 3f0:	0017979b          	slliw	a5,a5,0x1
 3f4:	0007871b          	sext.w	a4,a5
 3f8:	fd843783          	ld	a5,-40(s0)
 3fc:	00178693          	addi	a3,a5,1
 400:	fcd43c23          	sd	a3,-40(s0)
 404:	0007c783          	lbu	a5,0(a5)
 408:	2781                	sext.w	a5,a5
 40a:	9fb9                	addw	a5,a5,a4
 40c:	2781                	sext.w	a5,a5
 40e:	fd07879b          	addiw	a5,a5,-48
 412:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 416:	fd843783          	ld	a5,-40(s0)
 41a:	0007c783          	lbu	a5,0(a5)
 41e:	873e                	mv	a4,a5
 420:	02f00793          	li	a5,47
 424:	00e7fb63          	bgeu	a5,a4,43a <atoi+0x68>
 428:	fd843783          	ld	a5,-40(s0)
 42c:	0007c783          	lbu	a5,0(a5)
 430:	873e                	mv	a4,a5
 432:	03900793          	li	a5,57
 436:	fae7f6e3          	bgeu	a5,a4,3e2 <atoi+0x10>
  return n;
 43a:	fec42783          	lw	a5,-20(s0)
}
 43e:	853e                	mv	a0,a5
 440:	7422                	ld	s0,40(sp)
 442:	6145                	addi	sp,sp,48
 444:	8082                	ret

0000000000000446 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 446:	7139                	addi	sp,sp,-64
 448:	fc22                	sd	s0,56(sp)
 44a:	0080                	addi	s0,sp,64
 44c:	fca43c23          	sd	a0,-40(s0)
 450:	fcb43823          	sd	a1,-48(s0)
 454:	87b2                	mv	a5,a2
 456:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 45a:	fd843783          	ld	a5,-40(s0)
 45e:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 462:	fd043783          	ld	a5,-48(s0)
 466:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 46a:	fe043703          	ld	a4,-32(s0)
 46e:	fe843783          	ld	a5,-24(s0)
 472:	02e7fc63          	bgeu	a5,a4,4aa <memmove+0x64>
    while(n-- > 0)
 476:	a00d                	j	498 <memmove+0x52>
      *dst++ = *src++;
 478:	fe043703          	ld	a4,-32(s0)
 47c:	00170793          	addi	a5,a4,1
 480:	fef43023          	sd	a5,-32(s0)
 484:	fe843783          	ld	a5,-24(s0)
 488:	00178693          	addi	a3,a5,1
 48c:	fed43423          	sd	a3,-24(s0)
 490:	00074703          	lbu	a4,0(a4)
 494:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 498:	fcc42783          	lw	a5,-52(s0)
 49c:	fff7871b          	addiw	a4,a5,-1
 4a0:	fce42623          	sw	a4,-52(s0)
 4a4:	fcf04ae3          	bgtz	a5,478 <memmove+0x32>
 4a8:	a891                	j	4fc <memmove+0xb6>
  } else {
    dst += n;
 4aa:	fcc42783          	lw	a5,-52(s0)
 4ae:	fe843703          	ld	a4,-24(s0)
 4b2:	97ba                	add	a5,a5,a4
 4b4:	fef43423          	sd	a5,-24(s0)
    src += n;
 4b8:	fcc42783          	lw	a5,-52(s0)
 4bc:	fe043703          	ld	a4,-32(s0)
 4c0:	97ba                	add	a5,a5,a4
 4c2:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4c6:	a01d                	j	4ec <memmove+0xa6>
      *--dst = *--src;
 4c8:	fe043783          	ld	a5,-32(s0)
 4cc:	17fd                	addi	a5,a5,-1
 4ce:	fef43023          	sd	a5,-32(s0)
 4d2:	fe843783          	ld	a5,-24(s0)
 4d6:	17fd                	addi	a5,a5,-1
 4d8:	fef43423          	sd	a5,-24(s0)
 4dc:	fe043783          	ld	a5,-32(s0)
 4e0:	0007c703          	lbu	a4,0(a5)
 4e4:	fe843783          	ld	a5,-24(s0)
 4e8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4ec:	fcc42783          	lw	a5,-52(s0)
 4f0:	fff7871b          	addiw	a4,a5,-1
 4f4:	fce42623          	sw	a4,-52(s0)
 4f8:	fcf048e3          	bgtz	a5,4c8 <memmove+0x82>
  }
  return vdst;
 4fc:	fd843783          	ld	a5,-40(s0)
}
 500:	853e                	mv	a0,a5
 502:	7462                	ld	s0,56(sp)
 504:	6121                	addi	sp,sp,64
 506:	8082                	ret

0000000000000508 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 508:	7139                	addi	sp,sp,-64
 50a:	fc22                	sd	s0,56(sp)
 50c:	0080                	addi	s0,sp,64
 50e:	fca43c23          	sd	a0,-40(s0)
 512:	fcb43823          	sd	a1,-48(s0)
 516:	87b2                	mv	a5,a2
 518:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 51c:	fd843783          	ld	a5,-40(s0)
 520:	fef43423          	sd	a5,-24(s0)
 524:	fd043783          	ld	a5,-48(s0)
 528:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 52c:	a0a1                	j	574 <memcmp+0x6c>
    if (*p1 != *p2) {
 52e:	fe843783          	ld	a5,-24(s0)
 532:	0007c703          	lbu	a4,0(a5)
 536:	fe043783          	ld	a5,-32(s0)
 53a:	0007c783          	lbu	a5,0(a5)
 53e:	02f70163          	beq	a4,a5,560 <memcmp+0x58>
      return *p1 - *p2;
 542:	fe843783          	ld	a5,-24(s0)
 546:	0007c783          	lbu	a5,0(a5)
 54a:	0007871b          	sext.w	a4,a5
 54e:	fe043783          	ld	a5,-32(s0)
 552:	0007c783          	lbu	a5,0(a5)
 556:	2781                	sext.w	a5,a5
 558:	40f707bb          	subw	a5,a4,a5
 55c:	2781                	sext.w	a5,a5
 55e:	a01d                	j	584 <memcmp+0x7c>
    }
    p1++;
 560:	fe843783          	ld	a5,-24(s0)
 564:	0785                	addi	a5,a5,1
 566:	fef43423          	sd	a5,-24(s0)
    p2++;
 56a:	fe043783          	ld	a5,-32(s0)
 56e:	0785                	addi	a5,a5,1
 570:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 574:	fcc42783          	lw	a5,-52(s0)
 578:	fff7871b          	addiw	a4,a5,-1
 57c:	fce42623          	sw	a4,-52(s0)
 580:	f7dd                	bnez	a5,52e <memcmp+0x26>
  }
  return 0;
 582:	4781                	li	a5,0
}
 584:	853e                	mv	a0,a5
 586:	7462                	ld	s0,56(sp)
 588:	6121                	addi	sp,sp,64
 58a:	8082                	ret

000000000000058c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 58c:	7179                	addi	sp,sp,-48
 58e:	f406                	sd	ra,40(sp)
 590:	f022                	sd	s0,32(sp)
 592:	1800                	addi	s0,sp,48
 594:	fea43423          	sd	a0,-24(s0)
 598:	feb43023          	sd	a1,-32(s0)
 59c:	87b2                	mv	a5,a2
 59e:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5a2:	fdc42783          	lw	a5,-36(s0)
 5a6:	863e                	mv	a2,a5
 5a8:	fe043583          	ld	a1,-32(s0)
 5ac:	fe843503          	ld	a0,-24(s0)
 5b0:	00000097          	auipc	ra,0x0
 5b4:	e96080e7          	jalr	-362(ra) # 446 <memmove>
 5b8:	87aa                	mv	a5,a0
}
 5ba:	853e                	mv	a0,a5
 5bc:	70a2                	ld	ra,40(sp)
 5be:	7402                	ld	s0,32(sp)
 5c0:	6145                	addi	sp,sp,48
 5c2:	8082                	ret

00000000000005c4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5c4:	4885                	li	a7,1
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <exit>:
.global exit
exit:
 li a7, SYS_exit
 5cc:	4889                	li	a7,2
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5d4:	488d                	li	a7,3
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5dc:	4891                	li	a7,4
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <read>:
.global read
read:
 li a7, SYS_read
 5e4:	4895                	li	a7,5
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <write>:
.global write
write:
 li a7, SYS_write
 5ec:	48c1                	li	a7,16
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <close>:
.global close
close:
 li a7, SYS_close
 5f4:	48d5                	li	a7,21
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <kill>:
.global kill
kill:
 li a7, SYS_kill
 5fc:	4899                	li	a7,6
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <exec>:
.global exec
exec:
 li a7, SYS_exec
 604:	489d                	li	a7,7
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <open>:
.global open
open:
 li a7, SYS_open
 60c:	48bd                	li	a7,15
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 614:	48c5                	li	a7,17
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 61c:	48c9                	li	a7,18
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 624:	48a1                	li	a7,8
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <link>:
.global link
link:
 li a7, SYS_link
 62c:	48cd                	li	a7,19
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 634:	48d1                	li	a7,20
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 63c:	48a5                	li	a7,9
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <dup>:
.global dup
dup:
 li a7, SYS_dup
 644:	48a9                	li	a7,10
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 64c:	48ad                	li	a7,11
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 654:	48b1                	li	a7,12
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 65c:	48b5                	li	a7,13
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 664:	48b9                	li	a7,14
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
 66c:	48d9                	li	a7,22
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
 674:	48dd                	li	a7,23
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
 67c:	48e1                	li	a7,24
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
 684:	48e5                	li	a7,25
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
 68c:	48e9                	li	a7,26
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
 694:	48ed                	li	a7,27
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
 69c:	48f1                	li	a7,28
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6a4:	1101                	addi	sp,sp,-32
 6a6:	ec06                	sd	ra,24(sp)
 6a8:	e822                	sd	s0,16(sp)
 6aa:	1000                	addi	s0,sp,32
 6ac:	87aa                	mv	a5,a0
 6ae:	872e                	mv	a4,a1
 6b0:	fef42623          	sw	a5,-20(s0)
 6b4:	87ba                	mv	a5,a4
 6b6:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 6ba:	feb40713          	addi	a4,s0,-21
 6be:	fec42783          	lw	a5,-20(s0)
 6c2:	4605                	li	a2,1
 6c4:	85ba                	mv	a1,a4
 6c6:	853e                	mv	a0,a5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	f24080e7          	jalr	-220(ra) # 5ec <write>
}
 6d0:	0001                	nop
 6d2:	60e2                	ld	ra,24(sp)
 6d4:	6442                	ld	s0,16(sp)
 6d6:	6105                	addi	sp,sp,32
 6d8:	8082                	ret

00000000000006da <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6da:	7139                	addi	sp,sp,-64
 6dc:	fc06                	sd	ra,56(sp)
 6de:	f822                	sd	s0,48(sp)
 6e0:	0080                	addi	s0,sp,64
 6e2:	87aa                	mv	a5,a0
 6e4:	8736                	mv	a4,a3
 6e6:	fcf42623          	sw	a5,-52(s0)
 6ea:	87ae                	mv	a5,a1
 6ec:	fcf42423          	sw	a5,-56(s0)
 6f0:	87b2                	mv	a5,a2
 6f2:	fcf42223          	sw	a5,-60(s0)
 6f6:	87ba                	mv	a5,a4
 6f8:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6fc:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 700:	fc042783          	lw	a5,-64(s0)
 704:	2781                	sext.w	a5,a5
 706:	c38d                	beqz	a5,728 <printint+0x4e>
 708:	fc842783          	lw	a5,-56(s0)
 70c:	2781                	sext.w	a5,a5
 70e:	0007dd63          	bgez	a5,728 <printint+0x4e>
    neg = 1;
 712:	4785                	li	a5,1
 714:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 718:	fc842783          	lw	a5,-56(s0)
 71c:	40f007bb          	negw	a5,a5
 720:	2781                	sext.w	a5,a5
 722:	fef42223          	sw	a5,-28(s0)
 726:	a029                	j	730 <printint+0x56>
  } else {
    x = xx;
 728:	fc842783          	lw	a5,-56(s0)
 72c:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 730:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 734:	fc442783          	lw	a5,-60(s0)
 738:	fe442703          	lw	a4,-28(s0)
 73c:	02f777bb          	remuw	a5,a4,a5
 740:	0007861b          	sext.w	a2,a5
 744:	fec42783          	lw	a5,-20(s0)
 748:	0017871b          	addiw	a4,a5,1
 74c:	fee42623          	sw	a4,-20(s0)
 750:	00001697          	auipc	a3,0x1
 754:	c3068693          	addi	a3,a3,-976 # 1380 <digits>
 758:	02061713          	slli	a4,a2,0x20
 75c:	9301                	srli	a4,a4,0x20
 75e:	9736                	add	a4,a4,a3
 760:	00074703          	lbu	a4,0(a4)
 764:	17c1                	addi	a5,a5,-16
 766:	97a2                	add	a5,a5,s0
 768:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 76c:	fc442783          	lw	a5,-60(s0)
 770:	fe442703          	lw	a4,-28(s0)
 774:	02f757bb          	divuw	a5,a4,a5
 778:	fef42223          	sw	a5,-28(s0)
 77c:	fe442783          	lw	a5,-28(s0)
 780:	2781                	sext.w	a5,a5
 782:	fbcd                	bnez	a5,734 <printint+0x5a>
  if(neg)
 784:	fe842783          	lw	a5,-24(s0)
 788:	2781                	sext.w	a5,a5
 78a:	cf85                	beqz	a5,7c2 <printint+0xe8>
    buf[i++] = '-';
 78c:	fec42783          	lw	a5,-20(s0)
 790:	0017871b          	addiw	a4,a5,1
 794:	fee42623          	sw	a4,-20(s0)
 798:	17c1                	addi	a5,a5,-16
 79a:	97a2                	add	a5,a5,s0
 79c:	02d00713          	li	a4,45
 7a0:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 7a4:	a839                	j	7c2 <printint+0xe8>
    putc(fd, buf[i]);
 7a6:	fec42783          	lw	a5,-20(s0)
 7aa:	17c1                	addi	a5,a5,-16
 7ac:	97a2                	add	a5,a5,s0
 7ae:	fe07c703          	lbu	a4,-32(a5)
 7b2:	fcc42783          	lw	a5,-52(s0)
 7b6:	85ba                	mv	a1,a4
 7b8:	853e                	mv	a0,a5
 7ba:	00000097          	auipc	ra,0x0
 7be:	eea080e7          	jalr	-278(ra) # 6a4 <putc>
  while(--i >= 0)
 7c2:	fec42783          	lw	a5,-20(s0)
 7c6:	37fd                	addiw	a5,a5,-1
 7c8:	fef42623          	sw	a5,-20(s0)
 7cc:	fec42783          	lw	a5,-20(s0)
 7d0:	2781                	sext.w	a5,a5
 7d2:	fc07dae3          	bgez	a5,7a6 <printint+0xcc>
}
 7d6:	0001                	nop
 7d8:	0001                	nop
 7da:	70e2                	ld	ra,56(sp)
 7dc:	7442                	ld	s0,48(sp)
 7de:	6121                	addi	sp,sp,64
 7e0:	8082                	ret

00000000000007e2 <printptr>:

static void
printptr(int fd, uint64 x) {
 7e2:	7179                	addi	sp,sp,-48
 7e4:	f406                	sd	ra,40(sp)
 7e6:	f022                	sd	s0,32(sp)
 7e8:	1800                	addi	s0,sp,48
 7ea:	87aa                	mv	a5,a0
 7ec:	fcb43823          	sd	a1,-48(s0)
 7f0:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 7f4:	fdc42783          	lw	a5,-36(s0)
 7f8:	03000593          	li	a1,48
 7fc:	853e                	mv	a0,a5
 7fe:	00000097          	auipc	ra,0x0
 802:	ea6080e7          	jalr	-346(ra) # 6a4 <putc>
  putc(fd, 'x');
 806:	fdc42783          	lw	a5,-36(s0)
 80a:	07800593          	li	a1,120
 80e:	853e                	mv	a0,a5
 810:	00000097          	auipc	ra,0x0
 814:	e94080e7          	jalr	-364(ra) # 6a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 818:	fe042623          	sw	zero,-20(s0)
 81c:	a82d                	j	856 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 81e:	fd043783          	ld	a5,-48(s0)
 822:	93f1                	srli	a5,a5,0x3c
 824:	00001717          	auipc	a4,0x1
 828:	b5c70713          	addi	a4,a4,-1188 # 1380 <digits>
 82c:	97ba                	add	a5,a5,a4
 82e:	0007c703          	lbu	a4,0(a5)
 832:	fdc42783          	lw	a5,-36(s0)
 836:	85ba                	mv	a1,a4
 838:	853e                	mv	a0,a5
 83a:	00000097          	auipc	ra,0x0
 83e:	e6a080e7          	jalr	-406(ra) # 6a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 842:	fec42783          	lw	a5,-20(s0)
 846:	2785                	addiw	a5,a5,1
 848:	fef42623          	sw	a5,-20(s0)
 84c:	fd043783          	ld	a5,-48(s0)
 850:	0792                	slli	a5,a5,0x4
 852:	fcf43823          	sd	a5,-48(s0)
 856:	fec42783          	lw	a5,-20(s0)
 85a:	873e                	mv	a4,a5
 85c:	47bd                	li	a5,15
 85e:	fce7f0e3          	bgeu	a5,a4,81e <printptr+0x3c>
}
 862:	0001                	nop
 864:	0001                	nop
 866:	70a2                	ld	ra,40(sp)
 868:	7402                	ld	s0,32(sp)
 86a:	6145                	addi	sp,sp,48
 86c:	8082                	ret

000000000000086e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 86e:	715d                	addi	sp,sp,-80
 870:	e486                	sd	ra,72(sp)
 872:	e0a2                	sd	s0,64(sp)
 874:	0880                	addi	s0,sp,80
 876:	87aa                	mv	a5,a0
 878:	fcb43023          	sd	a1,-64(s0)
 87c:	fac43c23          	sd	a2,-72(s0)
 880:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 884:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 888:	fe042223          	sw	zero,-28(s0)
 88c:	a42d                	j	ab6 <vprintf+0x248>
    c = fmt[i] & 0xff;
 88e:	fe442783          	lw	a5,-28(s0)
 892:	fc043703          	ld	a4,-64(s0)
 896:	97ba                	add	a5,a5,a4
 898:	0007c783          	lbu	a5,0(a5)
 89c:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 8a0:	fe042783          	lw	a5,-32(s0)
 8a4:	2781                	sext.w	a5,a5
 8a6:	eb9d                	bnez	a5,8dc <vprintf+0x6e>
      if(c == '%'){
 8a8:	fdc42783          	lw	a5,-36(s0)
 8ac:	0007871b          	sext.w	a4,a5
 8b0:	02500793          	li	a5,37
 8b4:	00f71763          	bne	a4,a5,8c2 <vprintf+0x54>
        state = '%';
 8b8:	02500793          	li	a5,37
 8bc:	fef42023          	sw	a5,-32(s0)
 8c0:	a2f5                	j	aac <vprintf+0x23e>
      } else {
        putc(fd, c);
 8c2:	fdc42783          	lw	a5,-36(s0)
 8c6:	0ff7f713          	zext.b	a4,a5
 8ca:	fcc42783          	lw	a5,-52(s0)
 8ce:	85ba                	mv	a1,a4
 8d0:	853e                	mv	a0,a5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	dd2080e7          	jalr	-558(ra) # 6a4 <putc>
 8da:	aac9                	j	aac <vprintf+0x23e>
      }
    } else if(state == '%'){
 8dc:	fe042783          	lw	a5,-32(s0)
 8e0:	0007871b          	sext.w	a4,a5
 8e4:	02500793          	li	a5,37
 8e8:	1cf71263          	bne	a4,a5,aac <vprintf+0x23e>
      if(c == 'd'){
 8ec:	fdc42783          	lw	a5,-36(s0)
 8f0:	0007871b          	sext.w	a4,a5
 8f4:	06400793          	li	a5,100
 8f8:	02f71463          	bne	a4,a5,920 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 8fc:	fb843783          	ld	a5,-72(s0)
 900:	00878713          	addi	a4,a5,8
 904:	fae43c23          	sd	a4,-72(s0)
 908:	4398                	lw	a4,0(a5)
 90a:	fcc42783          	lw	a5,-52(s0)
 90e:	4685                	li	a3,1
 910:	4629                	li	a2,10
 912:	85ba                	mv	a1,a4
 914:	853e                	mv	a0,a5
 916:	00000097          	auipc	ra,0x0
 91a:	dc4080e7          	jalr	-572(ra) # 6da <printint>
 91e:	a269                	j	aa8 <vprintf+0x23a>
      } else if(c == 'l') {
 920:	fdc42783          	lw	a5,-36(s0)
 924:	0007871b          	sext.w	a4,a5
 928:	06c00793          	li	a5,108
 92c:	02f71663          	bne	a4,a5,958 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 930:	fb843783          	ld	a5,-72(s0)
 934:	00878713          	addi	a4,a5,8
 938:	fae43c23          	sd	a4,-72(s0)
 93c:	639c                	ld	a5,0(a5)
 93e:	0007871b          	sext.w	a4,a5
 942:	fcc42783          	lw	a5,-52(s0)
 946:	4681                	li	a3,0
 948:	4629                	li	a2,10
 94a:	85ba                	mv	a1,a4
 94c:	853e                	mv	a0,a5
 94e:	00000097          	auipc	ra,0x0
 952:	d8c080e7          	jalr	-628(ra) # 6da <printint>
 956:	aa89                	j	aa8 <vprintf+0x23a>
      } else if(c == 'x') {
 958:	fdc42783          	lw	a5,-36(s0)
 95c:	0007871b          	sext.w	a4,a5
 960:	07800793          	li	a5,120
 964:	02f71463          	bne	a4,a5,98c <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 968:	fb843783          	ld	a5,-72(s0)
 96c:	00878713          	addi	a4,a5,8
 970:	fae43c23          	sd	a4,-72(s0)
 974:	4398                	lw	a4,0(a5)
 976:	fcc42783          	lw	a5,-52(s0)
 97a:	4681                	li	a3,0
 97c:	4641                	li	a2,16
 97e:	85ba                	mv	a1,a4
 980:	853e                	mv	a0,a5
 982:	00000097          	auipc	ra,0x0
 986:	d58080e7          	jalr	-680(ra) # 6da <printint>
 98a:	aa39                	j	aa8 <vprintf+0x23a>
      } else if(c == 'p') {
 98c:	fdc42783          	lw	a5,-36(s0)
 990:	0007871b          	sext.w	a4,a5
 994:	07000793          	li	a5,112
 998:	02f71263          	bne	a4,a5,9bc <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 99c:	fb843783          	ld	a5,-72(s0)
 9a0:	00878713          	addi	a4,a5,8
 9a4:	fae43c23          	sd	a4,-72(s0)
 9a8:	6398                	ld	a4,0(a5)
 9aa:	fcc42783          	lw	a5,-52(s0)
 9ae:	85ba                	mv	a1,a4
 9b0:	853e                	mv	a0,a5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	e30080e7          	jalr	-464(ra) # 7e2 <printptr>
 9ba:	a0fd                	j	aa8 <vprintf+0x23a>
      } else if(c == 's'){
 9bc:	fdc42783          	lw	a5,-36(s0)
 9c0:	0007871b          	sext.w	a4,a5
 9c4:	07300793          	li	a5,115
 9c8:	04f71c63          	bne	a4,a5,a20 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 9cc:	fb843783          	ld	a5,-72(s0)
 9d0:	00878713          	addi	a4,a5,8
 9d4:	fae43c23          	sd	a4,-72(s0)
 9d8:	639c                	ld	a5,0(a5)
 9da:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 9de:	fe843783          	ld	a5,-24(s0)
 9e2:	eb8d                	bnez	a5,a14 <vprintf+0x1a6>
          s = "(null)";
 9e4:	00000797          	auipc	a5,0x0
 9e8:	4f478793          	addi	a5,a5,1268 # ed8 <malloc+0x1ba>
 9ec:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9f0:	a015                	j	a14 <vprintf+0x1a6>
          putc(fd, *s);
 9f2:	fe843783          	ld	a5,-24(s0)
 9f6:	0007c703          	lbu	a4,0(a5)
 9fa:	fcc42783          	lw	a5,-52(s0)
 9fe:	85ba                	mv	a1,a4
 a00:	853e                	mv	a0,a5
 a02:	00000097          	auipc	ra,0x0
 a06:	ca2080e7          	jalr	-862(ra) # 6a4 <putc>
          s++;
 a0a:	fe843783          	ld	a5,-24(s0)
 a0e:	0785                	addi	a5,a5,1
 a10:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a14:	fe843783          	ld	a5,-24(s0)
 a18:	0007c783          	lbu	a5,0(a5)
 a1c:	fbf9                	bnez	a5,9f2 <vprintf+0x184>
 a1e:	a069                	j	aa8 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a20:	fdc42783          	lw	a5,-36(s0)
 a24:	0007871b          	sext.w	a4,a5
 a28:	06300793          	li	a5,99
 a2c:	02f71463          	bne	a4,a5,a54 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a30:	fb843783          	ld	a5,-72(s0)
 a34:	00878713          	addi	a4,a5,8
 a38:	fae43c23          	sd	a4,-72(s0)
 a3c:	439c                	lw	a5,0(a5)
 a3e:	0ff7f713          	zext.b	a4,a5
 a42:	fcc42783          	lw	a5,-52(s0)
 a46:	85ba                	mv	a1,a4
 a48:	853e                	mv	a0,a5
 a4a:	00000097          	auipc	ra,0x0
 a4e:	c5a080e7          	jalr	-934(ra) # 6a4 <putc>
 a52:	a899                	j	aa8 <vprintf+0x23a>
      } else if(c == '%'){
 a54:	fdc42783          	lw	a5,-36(s0)
 a58:	0007871b          	sext.w	a4,a5
 a5c:	02500793          	li	a5,37
 a60:	00f71f63          	bne	a4,a5,a7e <vprintf+0x210>
        putc(fd, c);
 a64:	fdc42783          	lw	a5,-36(s0)
 a68:	0ff7f713          	zext.b	a4,a5
 a6c:	fcc42783          	lw	a5,-52(s0)
 a70:	85ba                	mv	a1,a4
 a72:	853e                	mv	a0,a5
 a74:	00000097          	auipc	ra,0x0
 a78:	c30080e7          	jalr	-976(ra) # 6a4 <putc>
 a7c:	a035                	j	aa8 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a7e:	fcc42783          	lw	a5,-52(s0)
 a82:	02500593          	li	a1,37
 a86:	853e                	mv	a0,a5
 a88:	00000097          	auipc	ra,0x0
 a8c:	c1c080e7          	jalr	-996(ra) # 6a4 <putc>
        putc(fd, c);
 a90:	fdc42783          	lw	a5,-36(s0)
 a94:	0ff7f713          	zext.b	a4,a5
 a98:	fcc42783          	lw	a5,-52(s0)
 a9c:	85ba                	mv	a1,a4
 a9e:	853e                	mv	a0,a5
 aa0:	00000097          	auipc	ra,0x0
 aa4:	c04080e7          	jalr	-1020(ra) # 6a4 <putc>
      }
      state = 0;
 aa8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 aac:	fe442783          	lw	a5,-28(s0)
 ab0:	2785                	addiw	a5,a5,1
 ab2:	fef42223          	sw	a5,-28(s0)
 ab6:	fe442783          	lw	a5,-28(s0)
 aba:	fc043703          	ld	a4,-64(s0)
 abe:	97ba                	add	a5,a5,a4
 ac0:	0007c783          	lbu	a5,0(a5)
 ac4:	dc0795e3          	bnez	a5,88e <vprintf+0x20>
    }
  }
}
 ac8:	0001                	nop
 aca:	0001                	nop
 acc:	60a6                	ld	ra,72(sp)
 ace:	6406                	ld	s0,64(sp)
 ad0:	6161                	addi	sp,sp,80
 ad2:	8082                	ret

0000000000000ad4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ad4:	7159                	addi	sp,sp,-112
 ad6:	fc06                	sd	ra,56(sp)
 ad8:	f822                	sd	s0,48(sp)
 ada:	0080                	addi	s0,sp,64
 adc:	fcb43823          	sd	a1,-48(s0)
 ae0:	e010                	sd	a2,0(s0)
 ae2:	e414                	sd	a3,8(s0)
 ae4:	e818                	sd	a4,16(s0)
 ae6:	ec1c                	sd	a5,24(s0)
 ae8:	03043023          	sd	a6,32(s0)
 aec:	03143423          	sd	a7,40(s0)
 af0:	87aa                	mv	a5,a0
 af2:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 af6:	03040793          	addi	a5,s0,48
 afa:	fcf43423          	sd	a5,-56(s0)
 afe:	fc843783          	ld	a5,-56(s0)
 b02:	fd078793          	addi	a5,a5,-48
 b06:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 b0a:	fe843703          	ld	a4,-24(s0)
 b0e:	fdc42783          	lw	a5,-36(s0)
 b12:	863a                	mv	a2,a4
 b14:	fd043583          	ld	a1,-48(s0)
 b18:	853e                	mv	a0,a5
 b1a:	00000097          	auipc	ra,0x0
 b1e:	d54080e7          	jalr	-684(ra) # 86e <vprintf>
}
 b22:	0001                	nop
 b24:	70e2                	ld	ra,56(sp)
 b26:	7442                	ld	s0,48(sp)
 b28:	6165                	addi	sp,sp,112
 b2a:	8082                	ret

0000000000000b2c <printf>:

void
printf(const char *fmt, ...)
{
 b2c:	7159                	addi	sp,sp,-112
 b2e:	f406                	sd	ra,40(sp)
 b30:	f022                	sd	s0,32(sp)
 b32:	1800                	addi	s0,sp,48
 b34:	fca43c23          	sd	a0,-40(s0)
 b38:	e40c                	sd	a1,8(s0)
 b3a:	e810                	sd	a2,16(s0)
 b3c:	ec14                	sd	a3,24(s0)
 b3e:	f018                	sd	a4,32(s0)
 b40:	f41c                	sd	a5,40(s0)
 b42:	03043823          	sd	a6,48(s0)
 b46:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b4a:	04040793          	addi	a5,s0,64
 b4e:	fcf43823          	sd	a5,-48(s0)
 b52:	fd043783          	ld	a5,-48(s0)
 b56:	fc878793          	addi	a5,a5,-56
 b5a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b5e:	fe843783          	ld	a5,-24(s0)
 b62:	863e                	mv	a2,a5
 b64:	fd843583          	ld	a1,-40(s0)
 b68:	4505                	li	a0,1
 b6a:	00000097          	auipc	ra,0x0
 b6e:	d04080e7          	jalr	-764(ra) # 86e <vprintf>
}
 b72:	0001                	nop
 b74:	70a2                	ld	ra,40(sp)
 b76:	7402                	ld	s0,32(sp)
 b78:	6165                	addi	sp,sp,112
 b7a:	8082                	ret

0000000000000b7c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b7c:	7179                	addi	sp,sp,-48
 b7e:	f422                	sd	s0,40(sp)
 b80:	1800                	addi	s0,sp,48
 b82:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b86:	fd843783          	ld	a5,-40(s0)
 b8a:	17c1                	addi	a5,a5,-16
 b8c:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b90:	00001797          	auipc	a5,0x1
 b94:	82078793          	addi	a5,a5,-2016 # 13b0 <freep>
 b98:	639c                	ld	a5,0(a5)
 b9a:	fef43423          	sd	a5,-24(s0)
 b9e:	a815                	j	bd2 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ba0:	fe843783          	ld	a5,-24(s0)
 ba4:	639c                	ld	a5,0(a5)
 ba6:	fe843703          	ld	a4,-24(s0)
 baa:	00f76f63          	bltu	a4,a5,bc8 <free+0x4c>
 bae:	fe043703          	ld	a4,-32(s0)
 bb2:	fe843783          	ld	a5,-24(s0)
 bb6:	02e7eb63          	bltu	a5,a4,bec <free+0x70>
 bba:	fe843783          	ld	a5,-24(s0)
 bbe:	639c                	ld	a5,0(a5)
 bc0:	fe043703          	ld	a4,-32(s0)
 bc4:	02f76463          	bltu	a4,a5,bec <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bc8:	fe843783          	ld	a5,-24(s0)
 bcc:	639c                	ld	a5,0(a5)
 bce:	fef43423          	sd	a5,-24(s0)
 bd2:	fe043703          	ld	a4,-32(s0)
 bd6:	fe843783          	ld	a5,-24(s0)
 bda:	fce7f3e3          	bgeu	a5,a4,ba0 <free+0x24>
 bde:	fe843783          	ld	a5,-24(s0)
 be2:	639c                	ld	a5,0(a5)
 be4:	fe043703          	ld	a4,-32(s0)
 be8:	faf77ce3          	bgeu	a4,a5,ba0 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bec:	fe043783          	ld	a5,-32(s0)
 bf0:	479c                	lw	a5,8(a5)
 bf2:	1782                	slli	a5,a5,0x20
 bf4:	9381                	srli	a5,a5,0x20
 bf6:	0792                	slli	a5,a5,0x4
 bf8:	fe043703          	ld	a4,-32(s0)
 bfc:	973e                	add	a4,a4,a5
 bfe:	fe843783          	ld	a5,-24(s0)
 c02:	639c                	ld	a5,0(a5)
 c04:	02f71763          	bne	a4,a5,c32 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 c08:	fe043783          	ld	a5,-32(s0)
 c0c:	4798                	lw	a4,8(a5)
 c0e:	fe843783          	ld	a5,-24(s0)
 c12:	639c                	ld	a5,0(a5)
 c14:	479c                	lw	a5,8(a5)
 c16:	9fb9                	addw	a5,a5,a4
 c18:	0007871b          	sext.w	a4,a5
 c1c:	fe043783          	ld	a5,-32(s0)
 c20:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c22:	fe843783          	ld	a5,-24(s0)
 c26:	639c                	ld	a5,0(a5)
 c28:	6398                	ld	a4,0(a5)
 c2a:	fe043783          	ld	a5,-32(s0)
 c2e:	e398                	sd	a4,0(a5)
 c30:	a039                	j	c3e <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c32:	fe843783          	ld	a5,-24(s0)
 c36:	6398                	ld	a4,0(a5)
 c38:	fe043783          	ld	a5,-32(s0)
 c3c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 c3e:	fe843783          	ld	a5,-24(s0)
 c42:	479c                	lw	a5,8(a5)
 c44:	1782                	slli	a5,a5,0x20
 c46:	9381                	srli	a5,a5,0x20
 c48:	0792                	slli	a5,a5,0x4
 c4a:	fe843703          	ld	a4,-24(s0)
 c4e:	97ba                	add	a5,a5,a4
 c50:	fe043703          	ld	a4,-32(s0)
 c54:	02f71563          	bne	a4,a5,c7e <free+0x102>
    p->s.size += bp->s.size;
 c58:	fe843783          	ld	a5,-24(s0)
 c5c:	4798                	lw	a4,8(a5)
 c5e:	fe043783          	ld	a5,-32(s0)
 c62:	479c                	lw	a5,8(a5)
 c64:	9fb9                	addw	a5,a5,a4
 c66:	0007871b          	sext.w	a4,a5
 c6a:	fe843783          	ld	a5,-24(s0)
 c6e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c70:	fe043783          	ld	a5,-32(s0)
 c74:	6398                	ld	a4,0(a5)
 c76:	fe843783          	ld	a5,-24(s0)
 c7a:	e398                	sd	a4,0(a5)
 c7c:	a031                	j	c88 <free+0x10c>
  } else
    p->s.ptr = bp;
 c7e:	fe843783          	ld	a5,-24(s0)
 c82:	fe043703          	ld	a4,-32(s0)
 c86:	e398                	sd	a4,0(a5)
  freep = p;
 c88:	00000797          	auipc	a5,0x0
 c8c:	72878793          	addi	a5,a5,1832 # 13b0 <freep>
 c90:	fe843703          	ld	a4,-24(s0)
 c94:	e398                	sd	a4,0(a5)
}
 c96:	0001                	nop
 c98:	7422                	ld	s0,40(sp)
 c9a:	6145                	addi	sp,sp,48
 c9c:	8082                	ret

0000000000000c9e <morecore>:

static Header*
morecore(uint nu)
{
 c9e:	7179                	addi	sp,sp,-48
 ca0:	f406                	sd	ra,40(sp)
 ca2:	f022                	sd	s0,32(sp)
 ca4:	1800                	addi	s0,sp,48
 ca6:	87aa                	mv	a5,a0
 ca8:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 cac:	fdc42783          	lw	a5,-36(s0)
 cb0:	0007871b          	sext.w	a4,a5
 cb4:	6785                	lui	a5,0x1
 cb6:	00f77563          	bgeu	a4,a5,cc0 <morecore+0x22>
    nu = 4096;
 cba:	6785                	lui	a5,0x1
 cbc:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 cc0:	fdc42783          	lw	a5,-36(s0)
 cc4:	0047979b          	slliw	a5,a5,0x4
 cc8:	2781                	sext.w	a5,a5
 cca:	2781                	sext.w	a5,a5
 ccc:	853e                	mv	a0,a5
 cce:	00000097          	auipc	ra,0x0
 cd2:	986080e7          	jalr	-1658(ra) # 654 <sbrk>
 cd6:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 cda:	fe843703          	ld	a4,-24(s0)
 cde:	57fd                	li	a5,-1
 ce0:	00f71463          	bne	a4,a5,ce8 <morecore+0x4a>
    return 0;
 ce4:	4781                	li	a5,0
 ce6:	a03d                	j	d14 <morecore+0x76>
  hp = (Header*)p;
 ce8:	fe843783          	ld	a5,-24(s0)
 cec:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 cf0:	fe043783          	ld	a5,-32(s0)
 cf4:	fdc42703          	lw	a4,-36(s0)
 cf8:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 cfa:	fe043783          	ld	a5,-32(s0)
 cfe:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x2f2>
 d00:	853e                	mv	a0,a5
 d02:	00000097          	auipc	ra,0x0
 d06:	e7a080e7          	jalr	-390(ra) # b7c <free>
  return freep;
 d0a:	00000797          	auipc	a5,0x0
 d0e:	6a678793          	addi	a5,a5,1702 # 13b0 <freep>
 d12:	639c                	ld	a5,0(a5)
}
 d14:	853e                	mv	a0,a5
 d16:	70a2                	ld	ra,40(sp)
 d18:	7402                	ld	s0,32(sp)
 d1a:	6145                	addi	sp,sp,48
 d1c:	8082                	ret

0000000000000d1e <malloc>:

void*
malloc(uint nbytes)
{
 d1e:	7139                	addi	sp,sp,-64
 d20:	fc06                	sd	ra,56(sp)
 d22:	f822                	sd	s0,48(sp)
 d24:	0080                	addi	s0,sp,64
 d26:	87aa                	mv	a5,a0
 d28:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d2c:	fcc46783          	lwu	a5,-52(s0)
 d30:	07bd                	addi	a5,a5,15
 d32:	8391                	srli	a5,a5,0x4
 d34:	2781                	sext.w	a5,a5
 d36:	2785                	addiw	a5,a5,1
 d38:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 d3c:	00000797          	auipc	a5,0x0
 d40:	67478793          	addi	a5,a5,1652 # 13b0 <freep>
 d44:	639c                	ld	a5,0(a5)
 d46:	fef43023          	sd	a5,-32(s0)
 d4a:	fe043783          	ld	a5,-32(s0)
 d4e:	ef95                	bnez	a5,d8a <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d50:	00000797          	auipc	a5,0x0
 d54:	65078793          	addi	a5,a5,1616 # 13a0 <base>
 d58:	fef43023          	sd	a5,-32(s0)
 d5c:	00000797          	auipc	a5,0x0
 d60:	65478793          	addi	a5,a5,1620 # 13b0 <freep>
 d64:	fe043703          	ld	a4,-32(s0)
 d68:	e398                	sd	a4,0(a5)
 d6a:	00000797          	auipc	a5,0x0
 d6e:	64678793          	addi	a5,a5,1606 # 13b0 <freep>
 d72:	6398                	ld	a4,0(a5)
 d74:	00000797          	auipc	a5,0x0
 d78:	62c78793          	addi	a5,a5,1580 # 13a0 <base>
 d7c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d7e:	00000797          	auipc	a5,0x0
 d82:	62278793          	addi	a5,a5,1570 # 13a0 <base>
 d86:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d8a:	fe043783          	ld	a5,-32(s0)
 d8e:	639c                	ld	a5,0(a5)
 d90:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d94:	fe843783          	ld	a5,-24(s0)
 d98:	4798                	lw	a4,8(a5)
 d9a:	fdc42783          	lw	a5,-36(s0)
 d9e:	2781                	sext.w	a5,a5
 da0:	06f76763          	bltu	a4,a5,e0e <malloc+0xf0>
      if(p->s.size == nunits)
 da4:	fe843783          	ld	a5,-24(s0)
 da8:	4798                	lw	a4,8(a5)
 daa:	fdc42783          	lw	a5,-36(s0)
 dae:	2781                	sext.w	a5,a5
 db0:	00e79963          	bne	a5,a4,dc2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 db4:	fe843783          	ld	a5,-24(s0)
 db8:	6398                	ld	a4,0(a5)
 dba:	fe043783          	ld	a5,-32(s0)
 dbe:	e398                	sd	a4,0(a5)
 dc0:	a825                	j	df8 <malloc+0xda>
      else {
        p->s.size -= nunits;
 dc2:	fe843783          	ld	a5,-24(s0)
 dc6:	479c                	lw	a5,8(a5)
 dc8:	fdc42703          	lw	a4,-36(s0)
 dcc:	9f99                	subw	a5,a5,a4
 dce:	0007871b          	sext.w	a4,a5
 dd2:	fe843783          	ld	a5,-24(s0)
 dd6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 dd8:	fe843783          	ld	a5,-24(s0)
 ddc:	479c                	lw	a5,8(a5)
 dde:	1782                	slli	a5,a5,0x20
 de0:	9381                	srli	a5,a5,0x20
 de2:	0792                	slli	a5,a5,0x4
 de4:	fe843703          	ld	a4,-24(s0)
 de8:	97ba                	add	a5,a5,a4
 dea:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 dee:	fe843783          	ld	a5,-24(s0)
 df2:	fdc42703          	lw	a4,-36(s0)
 df6:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 df8:	00000797          	auipc	a5,0x0
 dfc:	5b878793          	addi	a5,a5,1464 # 13b0 <freep>
 e00:	fe043703          	ld	a4,-32(s0)
 e04:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 e06:	fe843783          	ld	a5,-24(s0)
 e0a:	07c1                	addi	a5,a5,16
 e0c:	a091                	j	e50 <malloc+0x132>
    }
    if(p == freep)
 e0e:	00000797          	auipc	a5,0x0
 e12:	5a278793          	addi	a5,a5,1442 # 13b0 <freep>
 e16:	639c                	ld	a5,0(a5)
 e18:	fe843703          	ld	a4,-24(s0)
 e1c:	02f71063          	bne	a4,a5,e3c <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 e20:	fdc42783          	lw	a5,-36(s0)
 e24:	853e                	mv	a0,a5
 e26:	00000097          	auipc	ra,0x0
 e2a:	e78080e7          	jalr	-392(ra) # c9e <morecore>
 e2e:	fea43423          	sd	a0,-24(s0)
 e32:	fe843783          	ld	a5,-24(s0)
 e36:	e399                	bnez	a5,e3c <malloc+0x11e>
        return 0;
 e38:	4781                	li	a5,0
 e3a:	a819                	j	e50 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e3c:	fe843783          	ld	a5,-24(s0)
 e40:	fef43023          	sd	a5,-32(s0)
 e44:	fe843783          	ld	a5,-24(s0)
 e48:	639c                	ld	a5,0(a5)
 e4a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e4e:	b799                	j	d94 <malloc+0x76>
  }
}
 e50:	853e                	mv	a0,a5
 e52:	70e2                	ld	ra,56(sp)
 e54:	7442                	ld	s0,48(sp)
 e56:	6121                	addi	sp,sp,64
 e58:	8082                	ret
