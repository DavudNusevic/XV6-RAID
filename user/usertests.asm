
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <r_sp>:
  return (x & SSTATUS_SIE) != 0;
}

static inline uint64
r_sp()
{
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
       6:	878a                	mv	a5,sp
       8:	fef43423          	sd	a5,-24(s0)
  return x;
       c:	fe843783          	ld	a5,-24(s0)
}
      10:	853e                	mv	a0,a5
      12:	6462                	ld	s0,24(sp)
      14:	6105                	addi	sp,sp,32
      16:	8082                	ret

0000000000000018 <copyin>:

// what if you pass ridiculous pointers to system calls
// that read user memory with copyin?
void
copyin(char *s)
{
      18:	715d                	addi	sp,sp,-80
      1a:	e486                	sd	ra,72(sp)
      1c:	e0a2                	sd	s0,64(sp)
      1e:	0880                	addi	s0,sp,80
      20:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
      24:	4785                	li	a5,1
      26:	07fe                	slli	a5,a5,0x1f
      28:	fcf43423          	sd	a5,-56(s0)
      2c:	57fd                	li	a5,-1
      2e:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
      32:	fe042623          	sw	zero,-20(s0)
      36:	aa79                	j	1d4 <copyin+0x1bc>
    uint64 addr = addrs[ai];
      38:	fec42783          	lw	a5,-20(s0)
      3c:	078e                	slli	a5,a5,0x3
      3e:	17c1                	addi	a5,a5,-16
      40:	97a2                	add	a5,a5,s0
      42:	fd87b783          	ld	a5,-40(a5)
      46:	fef43023          	sd	a5,-32(s0)

    int fd = open("copyin1", O_CREATE|O_WRONLY);
      4a:	20100593          	li	a1,513
      4e:	00008517          	auipc	a0,0x8
      52:	e5250513          	addi	a0,a0,-430 # 7ea0 <malloc+0x13c>
      56:	00007097          	auipc	ra,0x7
      5a:	5fc080e7          	jalr	1532(ra) # 7652 <open>
      5e:	87aa                	mv	a5,a0
      60:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
      64:	fdc42783          	lw	a5,-36(s0)
      68:	2781                	sext.w	a5,a5
      6a:	0007df63          	bgez	a5,88 <copyin+0x70>
      printf("open(copyin1) failed\n");
      6e:	00008517          	auipc	a0,0x8
      72:	e3a50513          	addi	a0,a0,-454 # 7ea8 <malloc+0x144>
      76:	00008097          	auipc	ra,0x8
      7a:	afc080e7          	jalr	-1284(ra) # 7b72 <printf>
      exit(1);
      7e:	4505                	li	a0,1
      80:	00007097          	auipc	ra,0x7
      84:	592080e7          	jalr	1426(ra) # 7612 <exit>
    }
    int n = write(fd, (void*)addr, 8192);
      88:	fe043703          	ld	a4,-32(s0)
      8c:	fdc42783          	lw	a5,-36(s0)
      90:	6609                	lui	a2,0x2
      92:	85ba                	mv	a1,a4
      94:	853e                	mv	a0,a5
      96:	00007097          	auipc	ra,0x7
      9a:	59c080e7          	jalr	1436(ra) # 7632 <write>
      9e:	87aa                	mv	a5,a0
      a0:	fcf42c23          	sw	a5,-40(s0)
    if(n >= 0){
      a4:	fd842783          	lw	a5,-40(s0)
      a8:	2781                	sext.w	a5,a5
      aa:	0207c463          	bltz	a5,d2 <copyin+0xba>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
      ae:	fd842783          	lw	a5,-40(s0)
      b2:	863e                	mv	a2,a5
      b4:	fe043583          	ld	a1,-32(s0)
      b8:	00008517          	auipc	a0,0x8
      bc:	e0850513          	addi	a0,a0,-504 # 7ec0 <malloc+0x15c>
      c0:	00008097          	auipc	ra,0x8
      c4:	ab2080e7          	jalr	-1358(ra) # 7b72 <printf>
      exit(1);
      c8:	4505                	li	a0,1
      ca:	00007097          	auipc	ra,0x7
      ce:	548080e7          	jalr	1352(ra) # 7612 <exit>
    }
    close(fd);
      d2:	fdc42783          	lw	a5,-36(s0)
      d6:	853e                	mv	a0,a5
      d8:	00007097          	auipc	ra,0x7
      dc:	562080e7          	jalr	1378(ra) # 763a <close>
    unlink("copyin1");
      e0:	00008517          	auipc	a0,0x8
      e4:	dc050513          	addi	a0,a0,-576 # 7ea0 <malloc+0x13c>
      e8:	00007097          	auipc	ra,0x7
      ec:	57a080e7          	jalr	1402(ra) # 7662 <unlink>

    n = write(1, (char*)addr, 8192);
      f0:	fe043783          	ld	a5,-32(s0)
      f4:	6609                	lui	a2,0x2
      f6:	85be                	mv	a1,a5
      f8:	4505                	li	a0,1
      fa:	00007097          	auipc	ra,0x7
      fe:	538080e7          	jalr	1336(ra) # 7632 <write>
     102:	87aa                	mv	a5,a0
     104:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     108:	fd842783          	lw	a5,-40(s0)
     10c:	2781                	sext.w	a5,a5
     10e:	02f05463          	blez	a5,136 <copyin+0x11e>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     112:	fd842783          	lw	a5,-40(s0)
     116:	863e                	mv	a2,a5
     118:	fe043583          	ld	a1,-32(s0)
     11c:	00008517          	auipc	a0,0x8
     120:	dd450513          	addi	a0,a0,-556 # 7ef0 <malloc+0x18c>
     124:	00008097          	auipc	ra,0x8
     128:	a4e080e7          	jalr	-1458(ra) # 7b72 <printf>
      exit(1);
     12c:	4505                	li	a0,1
     12e:	00007097          	auipc	ra,0x7
     132:	4e4080e7          	jalr	1252(ra) # 7612 <exit>
    }

    int fds[2];
    if(pipe(fds) < 0){
     136:	fc040793          	addi	a5,s0,-64
     13a:	853e                	mv	a0,a5
     13c:	00007097          	auipc	ra,0x7
     140:	4e6080e7          	jalr	1254(ra) # 7622 <pipe>
     144:	87aa                	mv	a5,a0
     146:	0007df63          	bgez	a5,164 <copyin+0x14c>
      printf("pipe() failed\n");
     14a:	00008517          	auipc	a0,0x8
     14e:	dd650513          	addi	a0,a0,-554 # 7f20 <malloc+0x1bc>
     152:	00008097          	auipc	ra,0x8
     156:	a20080e7          	jalr	-1504(ra) # 7b72 <printf>
      exit(1);
     15a:	4505                	li	a0,1
     15c:	00007097          	auipc	ra,0x7
     160:	4b6080e7          	jalr	1206(ra) # 7612 <exit>
    }
    n = write(fds[1], (char*)addr, 8192);
     164:	fc442783          	lw	a5,-60(s0)
     168:	fe043703          	ld	a4,-32(s0)
     16c:	6609                	lui	a2,0x2
     16e:	85ba                	mv	a1,a4
     170:	853e                	mv	a0,a5
     172:	00007097          	auipc	ra,0x7
     176:	4c0080e7          	jalr	1216(ra) # 7632 <write>
     17a:	87aa                	mv	a5,a0
     17c:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     180:	fd842783          	lw	a5,-40(s0)
     184:	2781                	sext.w	a5,a5
     186:	02f05463          	blez	a5,1ae <copyin+0x196>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     18a:	fd842783          	lw	a5,-40(s0)
     18e:	863e                	mv	a2,a5
     190:	fe043583          	ld	a1,-32(s0)
     194:	00008517          	auipc	a0,0x8
     198:	d9c50513          	addi	a0,a0,-612 # 7f30 <malloc+0x1cc>
     19c:	00008097          	auipc	ra,0x8
     1a0:	9d6080e7          	jalr	-1578(ra) # 7b72 <printf>
      exit(1);
     1a4:	4505                	li	a0,1
     1a6:	00007097          	auipc	ra,0x7
     1aa:	46c080e7          	jalr	1132(ra) # 7612 <exit>
    }
    close(fds[0]);
     1ae:	fc042783          	lw	a5,-64(s0)
     1b2:	853e                	mv	a0,a5
     1b4:	00007097          	auipc	ra,0x7
     1b8:	486080e7          	jalr	1158(ra) # 763a <close>
    close(fds[1]);
     1bc:	fc442783          	lw	a5,-60(s0)
     1c0:	853e                	mv	a0,a5
     1c2:	00007097          	auipc	ra,0x7
     1c6:	478080e7          	jalr	1144(ra) # 763a <close>
  for(int ai = 0; ai < 2; ai++){
     1ca:	fec42783          	lw	a5,-20(s0)
     1ce:	2785                	addiw	a5,a5,1
     1d0:	fef42623          	sw	a5,-20(s0)
     1d4:	fec42783          	lw	a5,-20(s0)
     1d8:	0007871b          	sext.w	a4,a5
     1dc:	4785                	li	a5,1
     1de:	e4e7dde3          	bge	a5,a4,38 <copyin+0x20>
  }
}
     1e2:	0001                	nop
     1e4:	0001                	nop
     1e6:	60a6                	ld	ra,72(sp)
     1e8:	6406                	ld	s0,64(sp)
     1ea:	6161                	addi	sp,sp,80
     1ec:	8082                	ret

00000000000001ee <copyout>:

// what if you pass ridiculous pointers to system calls
// that write user memory with copyout?
void
copyout(char *s)
{
     1ee:	715d                	addi	sp,sp,-80
     1f0:	e486                	sd	ra,72(sp)
     1f2:	e0a2                	sd	s0,64(sp)
     1f4:	0880                	addi	s0,sp,80
     1f6:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     1fa:	4785                	li	a5,1
     1fc:	07fe                	slli	a5,a5,0x1f
     1fe:	fcf43423          	sd	a5,-56(s0)
     202:	57fd                	li	a5,-1
     204:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     208:	fe042623          	sw	zero,-20(s0)
     20c:	a271                	j	398 <copyout+0x1aa>
    uint64 addr = addrs[ai];
     20e:	fec42783          	lw	a5,-20(s0)
     212:	078e                	slli	a5,a5,0x3
     214:	17c1                	addi	a5,a5,-16
     216:	97a2                	add	a5,a5,s0
     218:	fd87b783          	ld	a5,-40(a5)
     21c:	fef43023          	sd	a5,-32(s0)

    int fd = open("README", 0);
     220:	4581                	li	a1,0
     222:	00008517          	auipc	a0,0x8
     226:	d3e50513          	addi	a0,a0,-706 # 7f60 <malloc+0x1fc>
     22a:	00007097          	auipc	ra,0x7
     22e:	428080e7          	jalr	1064(ra) # 7652 <open>
     232:	87aa                	mv	a5,a0
     234:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
     238:	fdc42783          	lw	a5,-36(s0)
     23c:	2781                	sext.w	a5,a5
     23e:	0007df63          	bgez	a5,25c <copyout+0x6e>
      printf("open(README) failed\n");
     242:	00008517          	auipc	a0,0x8
     246:	d2650513          	addi	a0,a0,-730 # 7f68 <malloc+0x204>
     24a:	00008097          	auipc	ra,0x8
     24e:	928080e7          	jalr	-1752(ra) # 7b72 <printf>
      exit(1);
     252:	4505                	li	a0,1
     254:	00007097          	auipc	ra,0x7
     258:	3be080e7          	jalr	958(ra) # 7612 <exit>
    }
    int n = read(fd, (void*)addr, 8192);
     25c:	fe043703          	ld	a4,-32(s0)
     260:	fdc42783          	lw	a5,-36(s0)
     264:	6609                	lui	a2,0x2
     266:	85ba                	mv	a1,a4
     268:	853e                	mv	a0,a5
     26a:	00007097          	auipc	ra,0x7
     26e:	3c0080e7          	jalr	960(ra) # 762a <read>
     272:	87aa                	mv	a5,a0
     274:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     278:	fd842783          	lw	a5,-40(s0)
     27c:	2781                	sext.w	a5,a5
     27e:	02f05463          	blez	a5,2a6 <copyout+0xb8>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     282:	fd842783          	lw	a5,-40(s0)
     286:	863e                	mv	a2,a5
     288:	fe043583          	ld	a1,-32(s0)
     28c:	00008517          	auipc	a0,0x8
     290:	cf450513          	addi	a0,a0,-780 # 7f80 <malloc+0x21c>
     294:	00008097          	auipc	ra,0x8
     298:	8de080e7          	jalr	-1826(ra) # 7b72 <printf>
      exit(1);
     29c:	4505                	li	a0,1
     29e:	00007097          	auipc	ra,0x7
     2a2:	374080e7          	jalr	884(ra) # 7612 <exit>
    }
    close(fd);
     2a6:	fdc42783          	lw	a5,-36(s0)
     2aa:	853e                	mv	a0,a5
     2ac:	00007097          	auipc	ra,0x7
     2b0:	38e080e7          	jalr	910(ra) # 763a <close>

    int fds[2];
    if(pipe(fds) < 0){
     2b4:	fc040793          	addi	a5,s0,-64
     2b8:	853e                	mv	a0,a5
     2ba:	00007097          	auipc	ra,0x7
     2be:	368080e7          	jalr	872(ra) # 7622 <pipe>
     2c2:	87aa                	mv	a5,a0
     2c4:	0007df63          	bgez	a5,2e2 <copyout+0xf4>
      printf("pipe() failed\n");
     2c8:	00008517          	auipc	a0,0x8
     2cc:	c5850513          	addi	a0,a0,-936 # 7f20 <malloc+0x1bc>
     2d0:	00008097          	auipc	ra,0x8
     2d4:	8a2080e7          	jalr	-1886(ra) # 7b72 <printf>
      exit(1);
     2d8:	4505                	li	a0,1
     2da:	00007097          	auipc	ra,0x7
     2de:	338080e7          	jalr	824(ra) # 7612 <exit>
    }
    n = write(fds[1], "x", 1);
     2e2:	fc442783          	lw	a5,-60(s0)
     2e6:	4605                	li	a2,1
     2e8:	00008597          	auipc	a1,0x8
     2ec:	cc858593          	addi	a1,a1,-824 # 7fb0 <malloc+0x24c>
     2f0:	853e                	mv	a0,a5
     2f2:	00007097          	auipc	ra,0x7
     2f6:	340080e7          	jalr	832(ra) # 7632 <write>
     2fa:	87aa                	mv	a5,a0
     2fc:	fcf42c23          	sw	a5,-40(s0)
    if(n != 1){
     300:	fd842783          	lw	a5,-40(s0)
     304:	0007871b          	sext.w	a4,a5
     308:	4785                	li	a5,1
     30a:	00f70f63          	beq	a4,a5,328 <copyout+0x13a>
      printf("pipe write failed\n");
     30e:	00008517          	auipc	a0,0x8
     312:	caa50513          	addi	a0,a0,-854 # 7fb8 <malloc+0x254>
     316:	00008097          	auipc	ra,0x8
     31a:	85c080e7          	jalr	-1956(ra) # 7b72 <printf>
      exit(1);
     31e:	4505                	li	a0,1
     320:	00007097          	auipc	ra,0x7
     324:	2f2080e7          	jalr	754(ra) # 7612 <exit>
    }
    n = read(fds[0], (void*)addr, 8192);
     328:	fc042783          	lw	a5,-64(s0)
     32c:	fe043703          	ld	a4,-32(s0)
     330:	6609                	lui	a2,0x2
     332:	85ba                	mv	a1,a4
     334:	853e                	mv	a0,a5
     336:	00007097          	auipc	ra,0x7
     33a:	2f4080e7          	jalr	756(ra) # 762a <read>
     33e:	87aa                	mv	a5,a0
     340:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     344:	fd842783          	lw	a5,-40(s0)
     348:	2781                	sext.w	a5,a5
     34a:	02f05463          	blez	a5,372 <copyout+0x184>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     34e:	fd842783          	lw	a5,-40(s0)
     352:	863e                	mv	a2,a5
     354:	fe043583          	ld	a1,-32(s0)
     358:	00008517          	auipc	a0,0x8
     35c:	c7850513          	addi	a0,a0,-904 # 7fd0 <malloc+0x26c>
     360:	00008097          	auipc	ra,0x8
     364:	812080e7          	jalr	-2030(ra) # 7b72 <printf>
      exit(1);
     368:	4505                	li	a0,1
     36a:	00007097          	auipc	ra,0x7
     36e:	2a8080e7          	jalr	680(ra) # 7612 <exit>
    }
    close(fds[0]);
     372:	fc042783          	lw	a5,-64(s0)
     376:	853e                	mv	a0,a5
     378:	00007097          	auipc	ra,0x7
     37c:	2c2080e7          	jalr	706(ra) # 763a <close>
    close(fds[1]);
     380:	fc442783          	lw	a5,-60(s0)
     384:	853e                	mv	a0,a5
     386:	00007097          	auipc	ra,0x7
     38a:	2b4080e7          	jalr	692(ra) # 763a <close>
  for(int ai = 0; ai < 2; ai++){
     38e:	fec42783          	lw	a5,-20(s0)
     392:	2785                	addiw	a5,a5,1
     394:	fef42623          	sw	a5,-20(s0)
     398:	fec42783          	lw	a5,-20(s0)
     39c:	0007871b          	sext.w	a4,a5
     3a0:	4785                	li	a5,1
     3a2:	e6e7d6e3          	bge	a5,a4,20e <copyout+0x20>
  }
}
     3a6:	0001                	nop
     3a8:	0001                	nop
     3aa:	60a6                	ld	ra,72(sp)
     3ac:	6406                	ld	s0,64(sp)
     3ae:	6161                	addi	sp,sp,80
     3b0:	8082                	ret

00000000000003b2 <copyinstr1>:

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
     3b2:	715d                	addi	sp,sp,-80
     3b4:	e486                	sd	ra,72(sp)
     3b6:	e0a2                	sd	s0,64(sp)
     3b8:	0880                	addi	s0,sp,80
     3ba:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     3be:	4785                	li	a5,1
     3c0:	07fe                	slli	a5,a5,0x1f
     3c2:	fcf43423          	sd	a5,-56(s0)
     3c6:	57fd                	li	a5,-1
     3c8:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     3cc:	fe042623          	sw	zero,-20(s0)
     3d0:	a095                	j	434 <copyinstr1+0x82>
    uint64 addr = addrs[ai];
     3d2:	fec42783          	lw	a5,-20(s0)
     3d6:	078e                	slli	a5,a5,0x3
     3d8:	17c1                	addi	a5,a5,-16
     3da:	97a2                	add	a5,a5,s0
     3dc:	fd87b783          	ld	a5,-40(a5)
     3e0:	fef43023          	sd	a5,-32(s0)

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
     3e4:	fe043783          	ld	a5,-32(s0)
     3e8:	20100593          	li	a1,513
     3ec:	853e                	mv	a0,a5
     3ee:	00007097          	auipc	ra,0x7
     3f2:	264080e7          	jalr	612(ra) # 7652 <open>
     3f6:	87aa                	mv	a5,a0
     3f8:	fcf42e23          	sw	a5,-36(s0)
    if(fd >= 0){
     3fc:	fdc42783          	lw	a5,-36(s0)
     400:	2781                	sext.w	a5,a5
     402:	0207c463          	bltz	a5,42a <copyinstr1+0x78>
      printf("open(%p) returned %d, not -1\n", addr, fd);
     406:	fdc42783          	lw	a5,-36(s0)
     40a:	863e                	mv	a2,a5
     40c:	fe043583          	ld	a1,-32(s0)
     410:	00008517          	auipc	a0,0x8
     414:	bf050513          	addi	a0,a0,-1040 # 8000 <malloc+0x29c>
     418:	00007097          	auipc	ra,0x7
     41c:	75a080e7          	jalr	1882(ra) # 7b72 <printf>
      exit(1);
     420:	4505                	li	a0,1
     422:	00007097          	auipc	ra,0x7
     426:	1f0080e7          	jalr	496(ra) # 7612 <exit>
  for(int ai = 0; ai < 2; ai++){
     42a:	fec42783          	lw	a5,-20(s0)
     42e:	2785                	addiw	a5,a5,1
     430:	fef42623          	sw	a5,-20(s0)
     434:	fec42783          	lw	a5,-20(s0)
     438:	0007871b          	sext.w	a4,a5
     43c:	4785                	li	a5,1
     43e:	f8e7dae3          	bge	a5,a4,3d2 <copyinstr1+0x20>
    }
  }
}
     442:	0001                	nop
     444:	0001                	nop
     446:	60a6                	ld	ra,72(sp)
     448:	6406                	ld	s0,64(sp)
     44a:	6161                	addi	sp,sp,80
     44c:	8082                	ret

000000000000044e <copyinstr2>:
// what if a string system call argument is exactly the size
// of the kernel buffer it is copied into, so that the null
// would fall just beyond the end of the kernel buffer?
void
copyinstr2(char *s)
{
     44e:	7151                	addi	sp,sp,-240
     450:	f586                	sd	ra,232(sp)
     452:	f1a2                	sd	s0,224(sp)
     454:	1980                	addi	s0,sp,240
     456:	f0a43c23          	sd	a0,-232(s0)
  char b[MAXPATH+1];

  for(int i = 0; i < MAXPATH; i++)
     45a:	fe042623          	sw	zero,-20(s0)
     45e:	a831                	j	47a <copyinstr2+0x2c>
    b[i] = 'x';
     460:	fec42783          	lw	a5,-20(s0)
     464:	17c1                	addi	a5,a5,-16
     466:	97a2                	add	a5,a5,s0
     468:	07800713          	li	a4,120
     46c:	f6e78423          	sb	a4,-152(a5)
  for(int i = 0; i < MAXPATH; i++)
     470:	fec42783          	lw	a5,-20(s0)
     474:	2785                	addiw	a5,a5,1
     476:	fef42623          	sw	a5,-20(s0)
     47a:	fec42783          	lw	a5,-20(s0)
     47e:	0007871b          	sext.w	a4,a5
     482:	07f00793          	li	a5,127
     486:	fce7dde3          	bge	a5,a4,460 <copyinstr2+0x12>
  b[MAXPATH] = '\0';
     48a:	fc040c23          	sb	zero,-40(s0)

  int ret = unlink(b);
     48e:	f5840793          	addi	a5,s0,-168
     492:	853e                	mv	a0,a5
     494:	00007097          	auipc	ra,0x7
     498:	1ce080e7          	jalr	462(ra) # 7662 <unlink>
     49c:	87aa                	mv	a5,a0
     49e:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     4a2:	fe442783          	lw	a5,-28(s0)
     4a6:	0007871b          	sext.w	a4,a5
     4aa:	57fd                	li	a5,-1
     4ac:	02f70563          	beq	a4,a5,4d6 <copyinstr2+0x88>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     4b0:	fe442703          	lw	a4,-28(s0)
     4b4:	f5840793          	addi	a5,s0,-168
     4b8:	863a                	mv	a2,a4
     4ba:	85be                	mv	a1,a5
     4bc:	00008517          	auipc	a0,0x8
     4c0:	b6450513          	addi	a0,a0,-1180 # 8020 <malloc+0x2bc>
     4c4:	00007097          	auipc	ra,0x7
     4c8:	6ae080e7          	jalr	1710(ra) # 7b72 <printf>
    exit(1);
     4cc:	4505                	li	a0,1
     4ce:	00007097          	auipc	ra,0x7
     4d2:	144080e7          	jalr	324(ra) # 7612 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     4d6:	f5840793          	addi	a5,s0,-168
     4da:	20100593          	li	a1,513
     4de:	853e                	mv	a0,a5
     4e0:	00007097          	auipc	ra,0x7
     4e4:	172080e7          	jalr	370(ra) # 7652 <open>
     4e8:	87aa                	mv	a5,a0
     4ea:	fef42023          	sw	a5,-32(s0)
  if(fd != -1){
     4ee:	fe042783          	lw	a5,-32(s0)
     4f2:	0007871b          	sext.w	a4,a5
     4f6:	57fd                	li	a5,-1
     4f8:	02f70563          	beq	a4,a5,522 <copyinstr2+0xd4>
    printf("open(%s) returned %d, not -1\n", b, fd);
     4fc:	fe042703          	lw	a4,-32(s0)
     500:	f5840793          	addi	a5,s0,-168
     504:	863a                	mv	a2,a4
     506:	85be                	mv	a1,a5
     508:	00008517          	auipc	a0,0x8
     50c:	b3850513          	addi	a0,a0,-1224 # 8040 <malloc+0x2dc>
     510:	00007097          	auipc	ra,0x7
     514:	662080e7          	jalr	1634(ra) # 7b72 <printf>
    exit(1);
     518:	4505                	li	a0,1
     51a:	00007097          	auipc	ra,0x7
     51e:	0f8080e7          	jalr	248(ra) # 7612 <exit>
  }

  ret = link(b, b);
     522:	f5840713          	addi	a4,s0,-168
     526:	f5840793          	addi	a5,s0,-168
     52a:	85ba                	mv	a1,a4
     52c:	853e                	mv	a0,a5
     52e:	00007097          	auipc	ra,0x7
     532:	144080e7          	jalr	324(ra) # 7672 <link>
     536:	87aa                	mv	a5,a0
     538:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     53c:	fe442783          	lw	a5,-28(s0)
     540:	0007871b          	sext.w	a4,a5
     544:	57fd                	li	a5,-1
     546:	02f70763          	beq	a4,a5,574 <copyinstr2+0x126>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     54a:	fe442683          	lw	a3,-28(s0)
     54e:	f5840713          	addi	a4,s0,-168
     552:	f5840793          	addi	a5,s0,-168
     556:	863a                	mv	a2,a4
     558:	85be                	mv	a1,a5
     55a:	00008517          	auipc	a0,0x8
     55e:	b0650513          	addi	a0,a0,-1274 # 8060 <malloc+0x2fc>
     562:	00007097          	auipc	ra,0x7
     566:	610080e7          	jalr	1552(ra) # 7b72 <printf>
    exit(1);
     56a:	4505                	li	a0,1
     56c:	00007097          	auipc	ra,0x7
     570:	0a6080e7          	jalr	166(ra) # 7612 <exit>
  }

  char *args[] = { "xx", 0 };
     574:	00008797          	auipc	a5,0x8
     578:	b1478793          	addi	a5,a5,-1260 # 8088 <malloc+0x324>
     57c:	f4f43423          	sd	a5,-184(s0)
     580:	f4043823          	sd	zero,-176(s0)
  ret = exec(b, args);
     584:	f4840713          	addi	a4,s0,-184
     588:	f5840793          	addi	a5,s0,-168
     58c:	85ba                	mv	a1,a4
     58e:	853e                	mv	a0,a5
     590:	00007097          	auipc	ra,0x7
     594:	0ba080e7          	jalr	186(ra) # 764a <exec>
     598:	87aa                	mv	a5,a0
     59a:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     59e:	fe442783          	lw	a5,-28(s0)
     5a2:	0007871b          	sext.w	a4,a5
     5a6:	57fd                	li	a5,-1
     5a8:	02f70563          	beq	a4,a5,5d2 <copyinstr2+0x184>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     5ac:	fe042703          	lw	a4,-32(s0)
     5b0:	f5840793          	addi	a5,s0,-168
     5b4:	863a                	mv	a2,a4
     5b6:	85be                	mv	a1,a5
     5b8:	00008517          	auipc	a0,0x8
     5bc:	ad850513          	addi	a0,a0,-1320 # 8090 <malloc+0x32c>
     5c0:	00007097          	auipc	ra,0x7
     5c4:	5b2080e7          	jalr	1458(ra) # 7b72 <printf>
    exit(1);
     5c8:	4505                	li	a0,1
     5ca:	00007097          	auipc	ra,0x7
     5ce:	048080e7          	jalr	72(ra) # 7612 <exit>
  }

  int pid = fork();
     5d2:	00007097          	auipc	ra,0x7
     5d6:	038080e7          	jalr	56(ra) # 760a <fork>
     5da:	87aa                	mv	a5,a0
     5dc:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
     5e0:	fdc42783          	lw	a5,-36(s0)
     5e4:	2781                	sext.w	a5,a5
     5e6:	0007df63          	bgez	a5,604 <copyinstr2+0x1b6>
    printf("fork failed\n");
     5ea:	00008517          	auipc	a0,0x8
     5ee:	ac650513          	addi	a0,a0,-1338 # 80b0 <malloc+0x34c>
     5f2:	00007097          	auipc	ra,0x7
     5f6:	580080e7          	jalr	1408(ra) # 7b72 <printf>
    exit(1);
     5fa:	4505                	li	a0,1
     5fc:	00007097          	auipc	ra,0x7
     600:	016080e7          	jalr	22(ra) # 7612 <exit>
  }
  if(pid == 0){
     604:	fdc42783          	lw	a5,-36(s0)
     608:	2781                	sext.w	a5,a5
     60a:	efd5                	bnez	a5,6c6 <copyinstr2+0x278>
    static char big[PGSIZE+1];
    for(int i = 0; i < PGSIZE; i++)
     60c:	fe042423          	sw	zero,-24(s0)
     610:	a00d                	j	632 <copyinstr2+0x1e4>
      big[i] = 'x';
     612:	00011717          	auipc	a4,0x11
     616:	3de70713          	addi	a4,a4,990 # 119f0 <big.0>
     61a:	fe842783          	lw	a5,-24(s0)
     61e:	97ba                	add	a5,a5,a4
     620:	07800713          	li	a4,120
     624:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
     628:	fe842783          	lw	a5,-24(s0)
     62c:	2785                	addiw	a5,a5,1
     62e:	fef42423          	sw	a5,-24(s0)
     632:	fe842783          	lw	a5,-24(s0)
     636:	0007871b          	sext.w	a4,a5
     63a:	6785                	lui	a5,0x1
     63c:	fcf74be3          	blt	a4,a5,612 <copyinstr2+0x1c4>
    big[PGSIZE] = '\0';
     640:	00011717          	auipc	a4,0x11
     644:	3b070713          	addi	a4,a4,944 # 119f0 <big.0>
     648:	6785                	lui	a5,0x1
     64a:	97ba                	add	a5,a5,a4
     64c:	00078023          	sb	zero,0(a5) # 1000 <truncate3+0x1b2>
    char *args2[] = { big, big, big, 0 };
     650:	00008797          	auipc	a5,0x8
     654:	ad078793          	addi	a5,a5,-1328 # 8120 <malloc+0x3bc>
     658:	6390                	ld	a2,0(a5)
     65a:	6794                	ld	a3,8(a5)
     65c:	6b98                	ld	a4,16(a5)
     65e:	6f9c                	ld	a5,24(a5)
     660:	f2c43023          	sd	a2,-224(s0)
     664:	f2d43423          	sd	a3,-216(s0)
     668:	f2e43823          	sd	a4,-208(s0)
     66c:	f2f43c23          	sd	a5,-200(s0)
    ret = exec("echo", args2);
     670:	f2040793          	addi	a5,s0,-224
     674:	85be                	mv	a1,a5
     676:	00008517          	auipc	a0,0x8
     67a:	a4a50513          	addi	a0,a0,-1462 # 80c0 <malloc+0x35c>
     67e:	00007097          	auipc	ra,0x7
     682:	fcc080e7          	jalr	-52(ra) # 764a <exec>
     686:	87aa                	mv	a5,a0
     688:	fef42223          	sw	a5,-28(s0)
    if(ret != -1){
     68c:	fe442783          	lw	a5,-28(s0)
     690:	0007871b          	sext.w	a4,a5
     694:	57fd                	li	a5,-1
     696:	02f70263          	beq	a4,a5,6ba <copyinstr2+0x26c>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
     69a:	fe042783          	lw	a5,-32(s0)
     69e:	85be                	mv	a1,a5
     6a0:	00008517          	auipc	a0,0x8
     6a4:	a2850513          	addi	a0,a0,-1496 # 80c8 <malloc+0x364>
     6a8:	00007097          	auipc	ra,0x7
     6ac:	4ca080e7          	jalr	1226(ra) # 7b72 <printf>
      exit(1);
     6b0:	4505                	li	a0,1
     6b2:	00007097          	auipc	ra,0x7
     6b6:	f60080e7          	jalr	-160(ra) # 7612 <exit>
    }
    exit(747); // OK
     6ba:	2eb00513          	li	a0,747
     6be:	00007097          	auipc	ra,0x7
     6c2:	f54080e7          	jalr	-172(ra) # 7612 <exit>
  }

  int st = 0;
     6c6:	f4042223          	sw	zero,-188(s0)
  wait(&st);
     6ca:	f4440793          	addi	a5,s0,-188
     6ce:	853e                	mv	a0,a5
     6d0:	00007097          	auipc	ra,0x7
     6d4:	f4a080e7          	jalr	-182(ra) # 761a <wait>
  if(st != 747){
     6d8:	f4442783          	lw	a5,-188(s0)
     6dc:	873e                	mv	a4,a5
     6de:	2eb00793          	li	a5,747
     6e2:	00f70f63          	beq	a4,a5,700 <copyinstr2+0x2b2>
    printf("exec(echo, BIG) succeeded, should have failed\n");
     6e6:	00008517          	auipc	a0,0x8
     6ea:	a0a50513          	addi	a0,a0,-1526 # 80f0 <malloc+0x38c>
     6ee:	00007097          	auipc	ra,0x7
     6f2:	484080e7          	jalr	1156(ra) # 7b72 <printf>
    exit(1);
     6f6:	4505                	li	a0,1
     6f8:	00007097          	auipc	ra,0x7
     6fc:	f1a080e7          	jalr	-230(ra) # 7612 <exit>
  }
}
     700:	0001                	nop
     702:	70ae                	ld	ra,232(sp)
     704:	740e                	ld	s0,224(sp)
     706:	616d                	addi	sp,sp,240
     708:	8082                	ret

000000000000070a <copyinstr3>:

// what if a string argument crosses over the end of last user page?
void
copyinstr3(char *s)
{
     70a:	715d                	addi	sp,sp,-80
     70c:	e486                	sd	ra,72(sp)
     70e:	e0a2                	sd	s0,64(sp)
     710:	0880                	addi	s0,sp,80
     712:	faa43c23          	sd	a0,-72(s0)
  sbrk(8192);
     716:	6509                	lui	a0,0x2
     718:	00007097          	auipc	ra,0x7
     71c:	f82080e7          	jalr	-126(ra) # 769a <sbrk>
  uint64 top = (uint64) sbrk(0);
     720:	4501                	li	a0,0
     722:	00007097          	auipc	ra,0x7
     726:	f78080e7          	jalr	-136(ra) # 769a <sbrk>
     72a:	87aa                	mv	a5,a0
     72c:	fef43423          	sd	a5,-24(s0)
  if((top % PGSIZE) != 0){
     730:	fe843703          	ld	a4,-24(s0)
     734:	6785                	lui	a5,0x1
     736:	17fd                	addi	a5,a5,-1 # fff <truncate3+0x1b1>
     738:	8ff9                	and	a5,a5,a4
     73a:	c39d                	beqz	a5,760 <copyinstr3+0x56>
    sbrk(PGSIZE - (top % PGSIZE));
     73c:	fe843783          	ld	a5,-24(s0)
     740:	2781                	sext.w	a5,a5
     742:	873e                	mv	a4,a5
     744:	6785                	lui	a5,0x1
     746:	17fd                	addi	a5,a5,-1 # fff <truncate3+0x1b1>
     748:	8ff9                	and	a5,a5,a4
     74a:	2781                	sext.w	a5,a5
     74c:	6705                	lui	a4,0x1
     74e:	40f707bb          	subw	a5,a4,a5
     752:	2781                	sext.w	a5,a5
     754:	2781                	sext.w	a5,a5
     756:	853e                	mv	a0,a5
     758:	00007097          	auipc	ra,0x7
     75c:	f42080e7          	jalr	-190(ra) # 769a <sbrk>
  }
  top = (uint64) sbrk(0);
     760:	4501                	li	a0,0
     762:	00007097          	auipc	ra,0x7
     766:	f38080e7          	jalr	-200(ra) # 769a <sbrk>
     76a:	87aa                	mv	a5,a0
     76c:	fef43423          	sd	a5,-24(s0)
  if(top % PGSIZE){
     770:	fe843703          	ld	a4,-24(s0)
     774:	6785                	lui	a5,0x1
     776:	17fd                	addi	a5,a5,-1 # fff <truncate3+0x1b1>
     778:	8ff9                	and	a5,a5,a4
     77a:	cf91                	beqz	a5,796 <copyinstr3+0x8c>
    printf("oops\n");
     77c:	00008517          	auipc	a0,0x8
     780:	9c450513          	addi	a0,a0,-1596 # 8140 <malloc+0x3dc>
     784:	00007097          	auipc	ra,0x7
     788:	3ee080e7          	jalr	1006(ra) # 7b72 <printf>
    exit(1);
     78c:	4505                	li	a0,1
     78e:	00007097          	auipc	ra,0x7
     792:	e84080e7          	jalr	-380(ra) # 7612 <exit>
  }

  char *b = (char *) (top - 1);
     796:	fe843783          	ld	a5,-24(s0)
     79a:	17fd                	addi	a5,a5,-1
     79c:	fef43023          	sd	a5,-32(s0)
  *b = 'x';
     7a0:	fe043783          	ld	a5,-32(s0)
     7a4:	07800713          	li	a4,120
     7a8:	00e78023          	sb	a4,0(a5)

  int ret = unlink(b);
     7ac:	fe043503          	ld	a0,-32(s0)
     7b0:	00007097          	auipc	ra,0x7
     7b4:	eb2080e7          	jalr	-334(ra) # 7662 <unlink>
     7b8:	87aa                	mv	a5,a0
     7ba:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     7be:	fdc42783          	lw	a5,-36(s0)
     7c2:	0007871b          	sext.w	a4,a5
     7c6:	57fd                	li	a5,-1
     7c8:	02f70463          	beq	a4,a5,7f0 <copyinstr3+0xe6>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     7cc:	fdc42783          	lw	a5,-36(s0)
     7d0:	863e                	mv	a2,a5
     7d2:	fe043583          	ld	a1,-32(s0)
     7d6:	00008517          	auipc	a0,0x8
     7da:	84a50513          	addi	a0,a0,-1974 # 8020 <malloc+0x2bc>
     7de:	00007097          	auipc	ra,0x7
     7e2:	394080e7          	jalr	916(ra) # 7b72 <printf>
    exit(1);
     7e6:	4505                	li	a0,1
     7e8:	00007097          	auipc	ra,0x7
     7ec:	e2a080e7          	jalr	-470(ra) # 7612 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     7f0:	20100593          	li	a1,513
     7f4:	fe043503          	ld	a0,-32(s0)
     7f8:	00007097          	auipc	ra,0x7
     7fc:	e5a080e7          	jalr	-422(ra) # 7652 <open>
     800:	87aa                	mv	a5,a0
     802:	fcf42c23          	sw	a5,-40(s0)
  if(fd != -1){
     806:	fd842783          	lw	a5,-40(s0)
     80a:	0007871b          	sext.w	a4,a5
     80e:	57fd                	li	a5,-1
     810:	02f70463          	beq	a4,a5,838 <copyinstr3+0x12e>
    printf("open(%s) returned %d, not -1\n", b, fd);
     814:	fd842783          	lw	a5,-40(s0)
     818:	863e                	mv	a2,a5
     81a:	fe043583          	ld	a1,-32(s0)
     81e:	00008517          	auipc	a0,0x8
     822:	82250513          	addi	a0,a0,-2014 # 8040 <malloc+0x2dc>
     826:	00007097          	auipc	ra,0x7
     82a:	34c080e7          	jalr	844(ra) # 7b72 <printf>
    exit(1);
     82e:	4505                	li	a0,1
     830:	00007097          	auipc	ra,0x7
     834:	de2080e7          	jalr	-542(ra) # 7612 <exit>
  }

  ret = link(b, b);
     838:	fe043583          	ld	a1,-32(s0)
     83c:	fe043503          	ld	a0,-32(s0)
     840:	00007097          	auipc	ra,0x7
     844:	e32080e7          	jalr	-462(ra) # 7672 <link>
     848:	87aa                	mv	a5,a0
     84a:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     84e:	fdc42783          	lw	a5,-36(s0)
     852:	0007871b          	sext.w	a4,a5
     856:	57fd                	li	a5,-1
     858:	02f70663          	beq	a4,a5,884 <copyinstr3+0x17a>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     85c:	fdc42783          	lw	a5,-36(s0)
     860:	86be                	mv	a3,a5
     862:	fe043603          	ld	a2,-32(s0)
     866:	fe043583          	ld	a1,-32(s0)
     86a:	00007517          	auipc	a0,0x7
     86e:	7f650513          	addi	a0,a0,2038 # 8060 <malloc+0x2fc>
     872:	00007097          	auipc	ra,0x7
     876:	300080e7          	jalr	768(ra) # 7b72 <printf>
    exit(1);
     87a:	4505                	li	a0,1
     87c:	00007097          	auipc	ra,0x7
     880:	d96080e7          	jalr	-618(ra) # 7612 <exit>
  }

  char *args[] = { "xx", 0 };
     884:	00008797          	auipc	a5,0x8
     888:	80478793          	addi	a5,a5,-2044 # 8088 <malloc+0x324>
     88c:	fcf43423          	sd	a5,-56(s0)
     890:	fc043823          	sd	zero,-48(s0)
  ret = exec(b, args);
     894:	fc840793          	addi	a5,s0,-56
     898:	85be                	mv	a1,a5
     89a:	fe043503          	ld	a0,-32(s0)
     89e:	00007097          	auipc	ra,0x7
     8a2:	dac080e7          	jalr	-596(ra) # 764a <exec>
     8a6:	87aa                	mv	a5,a0
     8a8:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     8ac:	fdc42783          	lw	a5,-36(s0)
     8b0:	0007871b          	sext.w	a4,a5
     8b4:	57fd                	li	a5,-1
     8b6:	02f70463          	beq	a4,a5,8de <copyinstr3+0x1d4>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     8ba:	fd842783          	lw	a5,-40(s0)
     8be:	863e                	mv	a2,a5
     8c0:	fe043583          	ld	a1,-32(s0)
     8c4:	00007517          	auipc	a0,0x7
     8c8:	7cc50513          	addi	a0,a0,1996 # 8090 <malloc+0x32c>
     8cc:	00007097          	auipc	ra,0x7
     8d0:	2a6080e7          	jalr	678(ra) # 7b72 <printf>
    exit(1);
     8d4:	4505                	li	a0,1
     8d6:	00007097          	auipc	ra,0x7
     8da:	d3c080e7          	jalr	-708(ra) # 7612 <exit>
  }
}
     8de:	0001                	nop
     8e0:	60a6                	ld	ra,72(sp)
     8e2:	6406                	ld	s0,64(sp)
     8e4:	6161                	addi	sp,sp,80
     8e6:	8082                	ret

00000000000008e8 <rwsbrk>:

// See if the kernel refuses to read/write user memory that the
// application doesn't have anymore, because it returned it.
void
rwsbrk()
{
     8e8:	1101                	addi	sp,sp,-32
     8ea:	ec06                	sd	ra,24(sp)
     8ec:	e822                	sd	s0,16(sp)
     8ee:	1000                	addi	s0,sp,32
  int fd, n;

  uint64 a = (uint64) sbrk(8192);
     8f0:	6509                	lui	a0,0x2
     8f2:	00007097          	auipc	ra,0x7
     8f6:	da8080e7          	jalr	-600(ra) # 769a <sbrk>
     8fa:	87aa                	mv	a5,a0
     8fc:	fef43423          	sd	a5,-24(s0)

  if(a == 0xffffffffffffffffLL) {
     900:	fe843703          	ld	a4,-24(s0)
     904:	57fd                	li	a5,-1
     906:	00f71f63          	bne	a4,a5,924 <rwsbrk+0x3c>
    printf("sbrk(rwsbrk) failed\n");
     90a:	00008517          	auipc	a0,0x8
     90e:	83e50513          	addi	a0,a0,-1986 # 8148 <malloc+0x3e4>
     912:	00007097          	auipc	ra,0x7
     916:	260080e7          	jalr	608(ra) # 7b72 <printf>
    exit(1);
     91a:	4505                	li	a0,1
     91c:	00007097          	auipc	ra,0x7
     920:	cf6080e7          	jalr	-778(ra) # 7612 <exit>
  }

  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
     924:	7579                	lui	a0,0xffffe
     926:	00007097          	auipc	ra,0x7
     92a:	d74080e7          	jalr	-652(ra) # 769a <sbrk>
     92e:	872a                	mv	a4,a0
     930:	57fd                	li	a5,-1
     932:	00f71f63          	bne	a4,a5,950 <rwsbrk+0x68>
    printf("sbrk(rwsbrk) shrink failed\n");
     936:	00008517          	auipc	a0,0x8
     93a:	82a50513          	addi	a0,a0,-2006 # 8160 <malloc+0x3fc>
     93e:	00007097          	auipc	ra,0x7
     942:	234080e7          	jalr	564(ra) # 7b72 <printf>
    exit(1);
     946:	4505                	li	a0,1
     948:	00007097          	auipc	ra,0x7
     94c:	cca080e7          	jalr	-822(ra) # 7612 <exit>
  }

  fd = open("rwsbrk", O_CREATE|O_WRONLY);
     950:	20100593          	li	a1,513
     954:	00008517          	auipc	a0,0x8
     958:	82c50513          	addi	a0,a0,-2004 # 8180 <malloc+0x41c>
     95c:	00007097          	auipc	ra,0x7
     960:	cf6080e7          	jalr	-778(ra) # 7652 <open>
     964:	87aa                	mv	a5,a0
     966:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     96a:	fe442783          	lw	a5,-28(s0)
     96e:	2781                	sext.w	a5,a5
     970:	0007df63          	bgez	a5,98e <rwsbrk+0xa6>
    printf("open(rwsbrk) failed\n");
     974:	00008517          	auipc	a0,0x8
     978:	81450513          	addi	a0,a0,-2028 # 8188 <malloc+0x424>
     97c:	00007097          	auipc	ra,0x7
     980:	1f6080e7          	jalr	502(ra) # 7b72 <printf>
    exit(1);
     984:	4505                	li	a0,1
     986:	00007097          	auipc	ra,0x7
     98a:	c8c080e7          	jalr	-884(ra) # 7612 <exit>
  }
  n = write(fd, (void*)(a+4096), 1024);
     98e:	fe843703          	ld	a4,-24(s0)
     992:	6785                	lui	a5,0x1
     994:	97ba                	add	a5,a5,a4
     996:	873e                	mv	a4,a5
     998:	fe442783          	lw	a5,-28(s0)
     99c:	40000613          	li	a2,1024
     9a0:	85ba                	mv	a1,a4
     9a2:	853e                	mv	a0,a5
     9a4:	00007097          	auipc	ra,0x7
     9a8:	c8e080e7          	jalr	-882(ra) # 7632 <write>
     9ac:	87aa                	mv	a5,a0
     9ae:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     9b2:	fe042783          	lw	a5,-32(s0)
     9b6:	2781                	sext.w	a5,a5
     9b8:	0207c763          	bltz	a5,9e6 <rwsbrk+0xfe>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
     9bc:	fe843703          	ld	a4,-24(s0)
     9c0:	6785                	lui	a5,0x1
     9c2:	97ba                	add	a5,a5,a4
     9c4:	fe042703          	lw	a4,-32(s0)
     9c8:	863a                	mv	a2,a4
     9ca:	85be                	mv	a1,a5
     9cc:	00007517          	auipc	a0,0x7
     9d0:	7d450513          	addi	a0,a0,2004 # 81a0 <malloc+0x43c>
     9d4:	00007097          	auipc	ra,0x7
     9d8:	19e080e7          	jalr	414(ra) # 7b72 <printf>
    exit(1);
     9dc:	4505                	li	a0,1
     9de:	00007097          	auipc	ra,0x7
     9e2:	c34080e7          	jalr	-972(ra) # 7612 <exit>
  }
  close(fd);
     9e6:	fe442783          	lw	a5,-28(s0)
     9ea:	853e                	mv	a0,a5
     9ec:	00007097          	auipc	ra,0x7
     9f0:	c4e080e7          	jalr	-946(ra) # 763a <close>
  unlink("rwsbrk");
     9f4:	00007517          	auipc	a0,0x7
     9f8:	78c50513          	addi	a0,a0,1932 # 8180 <malloc+0x41c>
     9fc:	00007097          	auipc	ra,0x7
     a00:	c66080e7          	jalr	-922(ra) # 7662 <unlink>

  fd = open("README", O_RDONLY);
     a04:	4581                	li	a1,0
     a06:	00007517          	auipc	a0,0x7
     a0a:	55a50513          	addi	a0,a0,1370 # 7f60 <malloc+0x1fc>
     a0e:	00007097          	auipc	ra,0x7
     a12:	c44080e7          	jalr	-956(ra) # 7652 <open>
     a16:	87aa                	mv	a5,a0
     a18:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     a1c:	fe442783          	lw	a5,-28(s0)
     a20:	2781                	sext.w	a5,a5
     a22:	0007df63          	bgez	a5,a40 <rwsbrk+0x158>
    printf("open(rwsbrk) failed\n");
     a26:	00007517          	auipc	a0,0x7
     a2a:	76250513          	addi	a0,a0,1890 # 8188 <malloc+0x424>
     a2e:	00007097          	auipc	ra,0x7
     a32:	144080e7          	jalr	324(ra) # 7b72 <printf>
    exit(1);
     a36:	4505                	li	a0,1
     a38:	00007097          	auipc	ra,0x7
     a3c:	bda080e7          	jalr	-1062(ra) # 7612 <exit>
  }
  n = read(fd, (void*)(a+4096), 10);
     a40:	fe843703          	ld	a4,-24(s0)
     a44:	6785                	lui	a5,0x1
     a46:	97ba                	add	a5,a5,a4
     a48:	873e                	mv	a4,a5
     a4a:	fe442783          	lw	a5,-28(s0)
     a4e:	4629                	li	a2,10
     a50:	85ba                	mv	a1,a4
     a52:	853e                	mv	a0,a5
     a54:	00007097          	auipc	ra,0x7
     a58:	bd6080e7          	jalr	-1066(ra) # 762a <read>
     a5c:	87aa                	mv	a5,a0
     a5e:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     a62:	fe042783          	lw	a5,-32(s0)
     a66:	2781                	sext.w	a5,a5
     a68:	0207c763          	bltz	a5,a96 <rwsbrk+0x1ae>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
     a6c:	fe843703          	ld	a4,-24(s0)
     a70:	6785                	lui	a5,0x1
     a72:	97ba                	add	a5,a5,a4
     a74:	fe042703          	lw	a4,-32(s0)
     a78:	863a                	mv	a2,a4
     a7a:	85be                	mv	a1,a5
     a7c:	00007517          	auipc	a0,0x7
     a80:	75450513          	addi	a0,a0,1876 # 81d0 <malloc+0x46c>
     a84:	00007097          	auipc	ra,0x7
     a88:	0ee080e7          	jalr	238(ra) # 7b72 <printf>
    exit(1);
     a8c:	4505                	li	a0,1
     a8e:	00007097          	auipc	ra,0x7
     a92:	b84080e7          	jalr	-1148(ra) # 7612 <exit>
  }
  close(fd);
     a96:	fe442783          	lw	a5,-28(s0)
     a9a:	853e                	mv	a0,a5
     a9c:	00007097          	auipc	ra,0x7
     aa0:	b9e080e7          	jalr	-1122(ra) # 763a <close>

  exit(0);
     aa4:	4501                	li	a0,0
     aa6:	00007097          	auipc	ra,0x7
     aaa:	b6c080e7          	jalr	-1172(ra) # 7612 <exit>

0000000000000aae <truncate1>:
}

// test O_TRUNC.
void
truncate1(char *s)
{
     aae:	715d                	addi	sp,sp,-80
     ab0:	e486                	sd	ra,72(sp)
     ab2:	e0a2                	sd	s0,64(sp)
     ab4:	0880                	addi	s0,sp,80
     ab6:	faa43c23          	sd	a0,-72(s0)
  char buf[32];

  unlink("truncfile");
     aba:	00007517          	auipc	a0,0x7
     abe:	73e50513          	addi	a0,a0,1854 # 81f8 <malloc+0x494>
     ac2:	00007097          	auipc	ra,0x7
     ac6:	ba0080e7          	jalr	-1120(ra) # 7662 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     aca:	60100593          	li	a1,1537
     ace:	00007517          	auipc	a0,0x7
     ad2:	72a50513          	addi	a0,a0,1834 # 81f8 <malloc+0x494>
     ad6:	00007097          	auipc	ra,0x7
     ada:	b7c080e7          	jalr	-1156(ra) # 7652 <open>
     ade:	87aa                	mv	a5,a0
     ae0:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     ae4:	fec42783          	lw	a5,-20(s0)
     ae8:	4611                	li	a2,4
     aea:	00007597          	auipc	a1,0x7
     aee:	71e58593          	addi	a1,a1,1822 # 8208 <malloc+0x4a4>
     af2:	853e                	mv	a0,a5
     af4:	00007097          	auipc	ra,0x7
     af8:	b3e080e7          	jalr	-1218(ra) # 7632 <write>
  close(fd1);
     afc:	fec42783          	lw	a5,-20(s0)
     b00:	853e                	mv	a0,a5
     b02:	00007097          	auipc	ra,0x7
     b06:	b38080e7          	jalr	-1224(ra) # 763a <close>

  int fd2 = open("truncfile", O_RDONLY);
     b0a:	4581                	li	a1,0
     b0c:	00007517          	auipc	a0,0x7
     b10:	6ec50513          	addi	a0,a0,1772 # 81f8 <malloc+0x494>
     b14:	00007097          	auipc	ra,0x7
     b18:	b3e080e7          	jalr	-1218(ra) # 7652 <open>
     b1c:	87aa                	mv	a5,a0
     b1e:	fef42423          	sw	a5,-24(s0)
  int n = read(fd2, buf, sizeof(buf));
     b22:	fc040713          	addi	a4,s0,-64
     b26:	fe842783          	lw	a5,-24(s0)
     b2a:	02000613          	li	a2,32
     b2e:	85ba                	mv	a1,a4
     b30:	853e                	mv	a0,a5
     b32:	00007097          	auipc	ra,0x7
     b36:	af8080e7          	jalr	-1288(ra) # 762a <read>
     b3a:	87aa                	mv	a5,a0
     b3c:	fef42223          	sw	a5,-28(s0)
  if(n != 4){
     b40:	fe442783          	lw	a5,-28(s0)
     b44:	0007871b          	sext.w	a4,a5
     b48:	4791                	li	a5,4
     b4a:	02f70463          	beq	a4,a5,b72 <truncate1+0xc4>
    printf("%s: read %d bytes, wanted 4\n", s, n);
     b4e:	fe442783          	lw	a5,-28(s0)
     b52:	863e                	mv	a2,a5
     b54:	fb843583          	ld	a1,-72(s0)
     b58:	00007517          	auipc	a0,0x7
     b5c:	6b850513          	addi	a0,a0,1720 # 8210 <malloc+0x4ac>
     b60:	00007097          	auipc	ra,0x7
     b64:	012080e7          	jalr	18(ra) # 7b72 <printf>
    exit(1);
     b68:	4505                	li	a0,1
     b6a:	00007097          	auipc	ra,0x7
     b6e:	aa8080e7          	jalr	-1368(ra) # 7612 <exit>
  }

  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     b72:	40100593          	li	a1,1025
     b76:	00007517          	auipc	a0,0x7
     b7a:	68250513          	addi	a0,a0,1666 # 81f8 <malloc+0x494>
     b7e:	00007097          	auipc	ra,0x7
     b82:	ad4080e7          	jalr	-1324(ra) # 7652 <open>
     b86:	87aa                	mv	a5,a0
     b88:	fef42623          	sw	a5,-20(s0)

  int fd3 = open("truncfile", O_RDONLY);
     b8c:	4581                	li	a1,0
     b8e:	00007517          	auipc	a0,0x7
     b92:	66a50513          	addi	a0,a0,1642 # 81f8 <malloc+0x494>
     b96:	00007097          	auipc	ra,0x7
     b9a:	abc080e7          	jalr	-1348(ra) # 7652 <open>
     b9e:	87aa                	mv	a5,a0
     ba0:	fef42023          	sw	a5,-32(s0)
  n = read(fd3, buf, sizeof(buf));
     ba4:	fc040713          	addi	a4,s0,-64
     ba8:	fe042783          	lw	a5,-32(s0)
     bac:	02000613          	li	a2,32
     bb0:	85ba                	mv	a1,a4
     bb2:	853e                	mv	a0,a5
     bb4:	00007097          	auipc	ra,0x7
     bb8:	a76080e7          	jalr	-1418(ra) # 762a <read>
     bbc:	87aa                	mv	a5,a0
     bbe:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     bc2:	fe442783          	lw	a5,-28(s0)
     bc6:	2781                	sext.w	a5,a5
     bc8:	cf95                	beqz	a5,c04 <truncate1+0x156>
    printf("aaa fd3=%d\n", fd3);
     bca:	fe042783          	lw	a5,-32(s0)
     bce:	85be                	mv	a1,a5
     bd0:	00007517          	auipc	a0,0x7
     bd4:	66050513          	addi	a0,a0,1632 # 8230 <malloc+0x4cc>
     bd8:	00007097          	auipc	ra,0x7
     bdc:	f9a080e7          	jalr	-102(ra) # 7b72 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     be0:	fe442783          	lw	a5,-28(s0)
     be4:	863e                	mv	a2,a5
     be6:	fb843583          	ld	a1,-72(s0)
     bea:	00007517          	auipc	a0,0x7
     bee:	65650513          	addi	a0,a0,1622 # 8240 <malloc+0x4dc>
     bf2:	00007097          	auipc	ra,0x7
     bf6:	f80080e7          	jalr	-128(ra) # 7b72 <printf>
    exit(1);
     bfa:	4505                	li	a0,1
     bfc:	00007097          	auipc	ra,0x7
     c00:	a16080e7          	jalr	-1514(ra) # 7612 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     c04:	fc040713          	addi	a4,s0,-64
     c08:	fe842783          	lw	a5,-24(s0)
     c0c:	02000613          	li	a2,32
     c10:	85ba                	mv	a1,a4
     c12:	853e                	mv	a0,a5
     c14:	00007097          	auipc	ra,0x7
     c18:	a16080e7          	jalr	-1514(ra) # 762a <read>
     c1c:	87aa                	mv	a5,a0
     c1e:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     c22:	fe442783          	lw	a5,-28(s0)
     c26:	2781                	sext.w	a5,a5
     c28:	cf95                	beqz	a5,c64 <truncate1+0x1b6>
    printf("bbb fd2=%d\n", fd2);
     c2a:	fe842783          	lw	a5,-24(s0)
     c2e:	85be                	mv	a1,a5
     c30:	00007517          	auipc	a0,0x7
     c34:	63050513          	addi	a0,a0,1584 # 8260 <malloc+0x4fc>
     c38:	00007097          	auipc	ra,0x7
     c3c:	f3a080e7          	jalr	-198(ra) # 7b72 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     c40:	fe442783          	lw	a5,-28(s0)
     c44:	863e                	mv	a2,a5
     c46:	fb843583          	ld	a1,-72(s0)
     c4a:	00007517          	auipc	a0,0x7
     c4e:	5f650513          	addi	a0,a0,1526 # 8240 <malloc+0x4dc>
     c52:	00007097          	auipc	ra,0x7
     c56:	f20080e7          	jalr	-224(ra) # 7b72 <printf>
    exit(1);
     c5a:	4505                	li	a0,1
     c5c:	00007097          	auipc	ra,0x7
     c60:	9b6080e7          	jalr	-1610(ra) # 7612 <exit>
  }

  write(fd1, "abcdef", 6);
     c64:	fec42783          	lw	a5,-20(s0)
     c68:	4619                	li	a2,6
     c6a:	00007597          	auipc	a1,0x7
     c6e:	60658593          	addi	a1,a1,1542 # 8270 <malloc+0x50c>
     c72:	853e                	mv	a0,a5
     c74:	00007097          	auipc	ra,0x7
     c78:	9be080e7          	jalr	-1602(ra) # 7632 <write>

  n = read(fd3, buf, sizeof(buf));
     c7c:	fc040713          	addi	a4,s0,-64
     c80:	fe042783          	lw	a5,-32(s0)
     c84:	02000613          	li	a2,32
     c88:	85ba                	mv	a1,a4
     c8a:	853e                	mv	a0,a5
     c8c:	00007097          	auipc	ra,0x7
     c90:	99e080e7          	jalr	-1634(ra) # 762a <read>
     c94:	87aa                	mv	a5,a0
     c96:	fef42223          	sw	a5,-28(s0)
  if(n != 6){
     c9a:	fe442783          	lw	a5,-28(s0)
     c9e:	0007871b          	sext.w	a4,a5
     ca2:	4799                	li	a5,6
     ca4:	02f70463          	beq	a4,a5,ccc <truncate1+0x21e>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     ca8:	fe442783          	lw	a5,-28(s0)
     cac:	863e                	mv	a2,a5
     cae:	fb843583          	ld	a1,-72(s0)
     cb2:	00007517          	auipc	a0,0x7
     cb6:	5c650513          	addi	a0,a0,1478 # 8278 <malloc+0x514>
     cba:	00007097          	auipc	ra,0x7
     cbe:	eb8080e7          	jalr	-328(ra) # 7b72 <printf>
    exit(1);
     cc2:	4505                	li	a0,1
     cc4:	00007097          	auipc	ra,0x7
     cc8:	94e080e7          	jalr	-1714(ra) # 7612 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     ccc:	fc040713          	addi	a4,s0,-64
     cd0:	fe842783          	lw	a5,-24(s0)
     cd4:	02000613          	li	a2,32
     cd8:	85ba                	mv	a1,a4
     cda:	853e                	mv	a0,a5
     cdc:	00007097          	auipc	ra,0x7
     ce0:	94e080e7          	jalr	-1714(ra) # 762a <read>
     ce4:	87aa                	mv	a5,a0
     ce6:	fef42223          	sw	a5,-28(s0)
  if(n != 2){
     cea:	fe442783          	lw	a5,-28(s0)
     cee:	0007871b          	sext.w	a4,a5
     cf2:	4789                	li	a5,2
     cf4:	02f70463          	beq	a4,a5,d1c <truncate1+0x26e>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     cf8:	fe442783          	lw	a5,-28(s0)
     cfc:	863e                	mv	a2,a5
     cfe:	fb843583          	ld	a1,-72(s0)
     d02:	00007517          	auipc	a0,0x7
     d06:	59650513          	addi	a0,a0,1430 # 8298 <malloc+0x534>
     d0a:	00007097          	auipc	ra,0x7
     d0e:	e68080e7          	jalr	-408(ra) # 7b72 <printf>
    exit(1);
     d12:	4505                	li	a0,1
     d14:	00007097          	auipc	ra,0x7
     d18:	8fe080e7          	jalr	-1794(ra) # 7612 <exit>
  }

  unlink("truncfile");
     d1c:	00007517          	auipc	a0,0x7
     d20:	4dc50513          	addi	a0,a0,1244 # 81f8 <malloc+0x494>
     d24:	00007097          	auipc	ra,0x7
     d28:	93e080e7          	jalr	-1730(ra) # 7662 <unlink>

  close(fd1);
     d2c:	fec42783          	lw	a5,-20(s0)
     d30:	853e                	mv	a0,a5
     d32:	00007097          	auipc	ra,0x7
     d36:	908080e7          	jalr	-1784(ra) # 763a <close>
  close(fd2);
     d3a:	fe842783          	lw	a5,-24(s0)
     d3e:	853e                	mv	a0,a5
     d40:	00007097          	auipc	ra,0x7
     d44:	8fa080e7          	jalr	-1798(ra) # 763a <close>
  close(fd3);
     d48:	fe042783          	lw	a5,-32(s0)
     d4c:	853e                	mv	a0,a5
     d4e:	00007097          	auipc	ra,0x7
     d52:	8ec080e7          	jalr	-1812(ra) # 763a <close>
}
     d56:	0001                	nop
     d58:	60a6                	ld	ra,72(sp)
     d5a:	6406                	ld	s0,64(sp)
     d5c:	6161                	addi	sp,sp,80
     d5e:	8082                	ret

0000000000000d60 <truncate2>:
// this causes a write at an offset beyond the end of the file.
// such writes fail on xv6 (unlike POSIX) but at least
// they don't crash.
void
truncate2(char *s)
{
     d60:	7179                	addi	sp,sp,-48
     d62:	f406                	sd	ra,40(sp)
     d64:	f022                	sd	s0,32(sp)
     d66:	1800                	addi	s0,sp,48
     d68:	fca43c23          	sd	a0,-40(s0)
  unlink("truncfile");
     d6c:	00007517          	auipc	a0,0x7
     d70:	48c50513          	addi	a0,a0,1164 # 81f8 <malloc+0x494>
     d74:	00007097          	auipc	ra,0x7
     d78:	8ee080e7          	jalr	-1810(ra) # 7662 <unlink>

  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     d7c:	60100593          	li	a1,1537
     d80:	00007517          	auipc	a0,0x7
     d84:	47850513          	addi	a0,a0,1144 # 81f8 <malloc+0x494>
     d88:	00007097          	auipc	ra,0x7
     d8c:	8ca080e7          	jalr	-1846(ra) # 7652 <open>
     d90:	87aa                	mv	a5,a0
     d92:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     d96:	fec42783          	lw	a5,-20(s0)
     d9a:	4611                	li	a2,4
     d9c:	00007597          	auipc	a1,0x7
     da0:	46c58593          	addi	a1,a1,1132 # 8208 <malloc+0x4a4>
     da4:	853e                	mv	a0,a5
     da6:	00007097          	auipc	ra,0x7
     daa:	88c080e7          	jalr	-1908(ra) # 7632 <write>

  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     dae:	40100593          	li	a1,1025
     db2:	00007517          	auipc	a0,0x7
     db6:	44650513          	addi	a0,a0,1094 # 81f8 <malloc+0x494>
     dba:	00007097          	auipc	ra,0x7
     dbe:	898080e7          	jalr	-1896(ra) # 7652 <open>
     dc2:	87aa                	mv	a5,a0
     dc4:	fef42423          	sw	a5,-24(s0)

  int n = write(fd1, "x", 1);
     dc8:	fec42783          	lw	a5,-20(s0)
     dcc:	4605                	li	a2,1
     dce:	00007597          	auipc	a1,0x7
     dd2:	1e258593          	addi	a1,a1,482 # 7fb0 <malloc+0x24c>
     dd6:	853e                	mv	a0,a5
     dd8:	00007097          	auipc	ra,0x7
     ddc:	85a080e7          	jalr	-1958(ra) # 7632 <write>
     de0:	87aa                	mv	a5,a0
     de2:	fef42223          	sw	a5,-28(s0)
  if(n != -1){
     de6:	fe442783          	lw	a5,-28(s0)
     dea:	0007871b          	sext.w	a4,a5
     dee:	57fd                	li	a5,-1
     df0:	02f70463          	beq	a4,a5,e18 <truncate2+0xb8>
    printf("%s: write returned %d, expected -1\n", s, n);
     df4:	fe442783          	lw	a5,-28(s0)
     df8:	863e                	mv	a2,a5
     dfa:	fd843583          	ld	a1,-40(s0)
     dfe:	00007517          	auipc	a0,0x7
     e02:	4ba50513          	addi	a0,a0,1210 # 82b8 <malloc+0x554>
     e06:	00007097          	auipc	ra,0x7
     e0a:	d6c080e7          	jalr	-660(ra) # 7b72 <printf>
    exit(1);
     e0e:	4505                	li	a0,1
     e10:	00007097          	auipc	ra,0x7
     e14:	802080e7          	jalr	-2046(ra) # 7612 <exit>
  }

  unlink("truncfile");
     e18:	00007517          	auipc	a0,0x7
     e1c:	3e050513          	addi	a0,a0,992 # 81f8 <malloc+0x494>
     e20:	00007097          	auipc	ra,0x7
     e24:	842080e7          	jalr	-1982(ra) # 7662 <unlink>
  close(fd1);
     e28:	fec42783          	lw	a5,-20(s0)
     e2c:	853e                	mv	a0,a5
     e2e:	00007097          	auipc	ra,0x7
     e32:	80c080e7          	jalr	-2036(ra) # 763a <close>
  close(fd2);
     e36:	fe842783          	lw	a5,-24(s0)
     e3a:	853e                	mv	a0,a5
     e3c:	00006097          	auipc	ra,0x6
     e40:	7fe080e7          	jalr	2046(ra) # 763a <close>
}
     e44:	0001                	nop
     e46:	70a2                	ld	ra,40(sp)
     e48:	7402                	ld	s0,32(sp)
     e4a:	6145                	addi	sp,sp,48
     e4c:	8082                	ret

0000000000000e4e <truncate3>:

void
truncate3(char *s)
{
     e4e:	711d                	addi	sp,sp,-96
     e50:	ec86                	sd	ra,88(sp)
     e52:	e8a2                	sd	s0,80(sp)
     e54:	1080                	addi	s0,sp,96
     e56:	faa43423          	sd	a0,-88(s0)
  int pid, xstatus;

  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
     e5a:	60100593          	li	a1,1537
     e5e:	00007517          	auipc	a0,0x7
     e62:	39a50513          	addi	a0,a0,922 # 81f8 <malloc+0x494>
     e66:	00006097          	auipc	ra,0x6
     e6a:	7ec080e7          	jalr	2028(ra) # 7652 <open>
     e6e:	87aa                	mv	a5,a0
     e70:	853e                	mv	a0,a5
     e72:	00006097          	auipc	ra,0x6
     e76:	7c8080e7          	jalr	1992(ra) # 763a <close>

  pid = fork();
     e7a:	00006097          	auipc	ra,0x6
     e7e:	790080e7          	jalr	1936(ra) # 760a <fork>
     e82:	87aa                	mv	a5,a0
     e84:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
     e88:	fe442783          	lw	a5,-28(s0)
     e8c:	2781                	sext.w	a5,a5
     e8e:	0207d163          	bgez	a5,eb0 <truncate3+0x62>
    printf("%s: fork failed\n", s);
     e92:	fa843583          	ld	a1,-88(s0)
     e96:	00007517          	auipc	a0,0x7
     e9a:	44a50513          	addi	a0,a0,1098 # 82e0 <malloc+0x57c>
     e9e:	00007097          	auipc	ra,0x7
     ea2:	cd4080e7          	jalr	-812(ra) # 7b72 <printf>
    exit(1);
     ea6:	4505                	li	a0,1
     ea8:	00006097          	auipc	ra,0x6
     eac:	76a080e7          	jalr	1898(ra) # 7612 <exit>
  }

  if(pid == 0){
     eb0:	fe442783          	lw	a5,-28(s0)
     eb4:	2781                	sext.w	a5,a5
     eb6:	10079563          	bnez	a5,fc0 <truncate3+0x172>
    for(int i = 0; i < 100; i++){
     eba:	fe042623          	sw	zero,-20(s0)
     ebe:	a0e5                	j	fa6 <truncate3+0x158>
      char buf[32];
      int fd = open("truncfile", O_WRONLY);
     ec0:	4585                	li	a1,1
     ec2:	00007517          	auipc	a0,0x7
     ec6:	33650513          	addi	a0,a0,822 # 81f8 <malloc+0x494>
     eca:	00006097          	auipc	ra,0x6
     ece:	788080e7          	jalr	1928(ra) # 7652 <open>
     ed2:	87aa                	mv	a5,a0
     ed4:	fcf42c23          	sw	a5,-40(s0)
      if(fd < 0){
     ed8:	fd842783          	lw	a5,-40(s0)
     edc:	2781                	sext.w	a5,a5
     ede:	0207d163          	bgez	a5,f00 <truncate3+0xb2>
        printf("%s: open failed\n", s);
     ee2:	fa843583          	ld	a1,-88(s0)
     ee6:	00007517          	auipc	a0,0x7
     eea:	41250513          	addi	a0,a0,1042 # 82f8 <malloc+0x594>
     eee:	00007097          	auipc	ra,0x7
     ef2:	c84080e7          	jalr	-892(ra) # 7b72 <printf>
        exit(1);
     ef6:	4505                	li	a0,1
     ef8:	00006097          	auipc	ra,0x6
     efc:	71a080e7          	jalr	1818(ra) # 7612 <exit>
      }
      int n = write(fd, "1234567890", 10);
     f00:	fd842783          	lw	a5,-40(s0)
     f04:	4629                	li	a2,10
     f06:	00007597          	auipc	a1,0x7
     f0a:	40a58593          	addi	a1,a1,1034 # 8310 <malloc+0x5ac>
     f0e:	853e                	mv	a0,a5
     f10:	00006097          	auipc	ra,0x6
     f14:	722080e7          	jalr	1826(ra) # 7632 <write>
     f18:	87aa                	mv	a5,a0
     f1a:	fcf42a23          	sw	a5,-44(s0)
      if(n != 10){
     f1e:	fd442783          	lw	a5,-44(s0)
     f22:	0007871b          	sext.w	a4,a5
     f26:	47a9                	li	a5,10
     f28:	02f70463          	beq	a4,a5,f50 <truncate3+0x102>
        printf("%s: write got %d, expected 10\n", s, n);
     f2c:	fd442783          	lw	a5,-44(s0)
     f30:	863e                	mv	a2,a5
     f32:	fa843583          	ld	a1,-88(s0)
     f36:	00007517          	auipc	a0,0x7
     f3a:	3ea50513          	addi	a0,a0,1002 # 8320 <malloc+0x5bc>
     f3e:	00007097          	auipc	ra,0x7
     f42:	c34080e7          	jalr	-972(ra) # 7b72 <printf>
        exit(1);
     f46:	4505                	li	a0,1
     f48:	00006097          	auipc	ra,0x6
     f4c:	6ca080e7          	jalr	1738(ra) # 7612 <exit>
      }
      close(fd);
     f50:	fd842783          	lw	a5,-40(s0)
     f54:	853e                	mv	a0,a5
     f56:	00006097          	auipc	ra,0x6
     f5a:	6e4080e7          	jalr	1764(ra) # 763a <close>
      fd = open("truncfile", O_RDONLY);
     f5e:	4581                	li	a1,0
     f60:	00007517          	auipc	a0,0x7
     f64:	29850513          	addi	a0,a0,664 # 81f8 <malloc+0x494>
     f68:	00006097          	auipc	ra,0x6
     f6c:	6ea080e7          	jalr	1770(ra) # 7652 <open>
     f70:	87aa                	mv	a5,a0
     f72:	fcf42c23          	sw	a5,-40(s0)
      read(fd, buf, sizeof(buf));
     f76:	fb040713          	addi	a4,s0,-80
     f7a:	fd842783          	lw	a5,-40(s0)
     f7e:	02000613          	li	a2,32
     f82:	85ba                	mv	a1,a4
     f84:	853e                	mv	a0,a5
     f86:	00006097          	auipc	ra,0x6
     f8a:	6a4080e7          	jalr	1700(ra) # 762a <read>
      close(fd);
     f8e:	fd842783          	lw	a5,-40(s0)
     f92:	853e                	mv	a0,a5
     f94:	00006097          	auipc	ra,0x6
     f98:	6a6080e7          	jalr	1702(ra) # 763a <close>
    for(int i = 0; i < 100; i++){
     f9c:	fec42783          	lw	a5,-20(s0)
     fa0:	2785                	addiw	a5,a5,1 # 1001 <truncate3+0x1b3>
     fa2:	fef42623          	sw	a5,-20(s0)
     fa6:	fec42783          	lw	a5,-20(s0)
     faa:	0007871b          	sext.w	a4,a5
     fae:	06300793          	li	a5,99
     fb2:	f0e7d7e3          	bge	a5,a4,ec0 <truncate3+0x72>
    }
    exit(0);
     fb6:	4501                	li	a0,0
     fb8:	00006097          	auipc	ra,0x6
     fbc:	65a080e7          	jalr	1626(ra) # 7612 <exit>
  }

  for(int i = 0; i < 150; i++){
     fc0:	fe042423          	sw	zero,-24(s0)
     fc4:	a075                	j	1070 <truncate3+0x222>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     fc6:	60100593          	li	a1,1537
     fca:	00007517          	auipc	a0,0x7
     fce:	22e50513          	addi	a0,a0,558 # 81f8 <malloc+0x494>
     fd2:	00006097          	auipc	ra,0x6
     fd6:	680080e7          	jalr	1664(ra) # 7652 <open>
     fda:	87aa                	mv	a5,a0
     fdc:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
     fe0:	fe042783          	lw	a5,-32(s0)
     fe4:	2781                	sext.w	a5,a5
     fe6:	0207d163          	bgez	a5,1008 <truncate3+0x1ba>
      printf("%s: open failed\n", s);
     fea:	fa843583          	ld	a1,-88(s0)
     fee:	00007517          	auipc	a0,0x7
     ff2:	30a50513          	addi	a0,a0,778 # 82f8 <malloc+0x594>
     ff6:	00007097          	auipc	ra,0x7
     ffa:	b7c080e7          	jalr	-1156(ra) # 7b72 <printf>
      exit(1);
     ffe:	4505                	li	a0,1
    1000:	00006097          	auipc	ra,0x6
    1004:	612080e7          	jalr	1554(ra) # 7612 <exit>
    }
    int n = write(fd, "xxx", 3);
    1008:	fe042783          	lw	a5,-32(s0)
    100c:	460d                	li	a2,3
    100e:	00007597          	auipc	a1,0x7
    1012:	33258593          	addi	a1,a1,818 # 8340 <malloc+0x5dc>
    1016:	853e                	mv	a0,a5
    1018:	00006097          	auipc	ra,0x6
    101c:	61a080e7          	jalr	1562(ra) # 7632 <write>
    1020:	87aa                	mv	a5,a0
    1022:	fcf42e23          	sw	a5,-36(s0)
    if(n != 3){
    1026:	fdc42783          	lw	a5,-36(s0)
    102a:	0007871b          	sext.w	a4,a5
    102e:	478d                	li	a5,3
    1030:	02f70463          	beq	a4,a5,1058 <truncate3+0x20a>
      printf("%s: write got %d, expected 3\n", s, n);
    1034:	fdc42783          	lw	a5,-36(s0)
    1038:	863e                	mv	a2,a5
    103a:	fa843583          	ld	a1,-88(s0)
    103e:	00007517          	auipc	a0,0x7
    1042:	30a50513          	addi	a0,a0,778 # 8348 <malloc+0x5e4>
    1046:	00007097          	auipc	ra,0x7
    104a:	b2c080e7          	jalr	-1236(ra) # 7b72 <printf>
      exit(1);
    104e:	4505                	li	a0,1
    1050:	00006097          	auipc	ra,0x6
    1054:	5c2080e7          	jalr	1474(ra) # 7612 <exit>
    }
    close(fd);
    1058:	fe042783          	lw	a5,-32(s0)
    105c:	853e                	mv	a0,a5
    105e:	00006097          	auipc	ra,0x6
    1062:	5dc080e7          	jalr	1500(ra) # 763a <close>
  for(int i = 0; i < 150; i++){
    1066:	fe842783          	lw	a5,-24(s0)
    106a:	2785                	addiw	a5,a5,1
    106c:	fef42423          	sw	a5,-24(s0)
    1070:	fe842783          	lw	a5,-24(s0)
    1074:	0007871b          	sext.w	a4,a5
    1078:	09500793          	li	a5,149
    107c:	f4e7d5e3          	bge	a5,a4,fc6 <truncate3+0x178>
  }

  wait(&xstatus);
    1080:	fd040793          	addi	a5,s0,-48
    1084:	853e                	mv	a0,a5
    1086:	00006097          	auipc	ra,0x6
    108a:	594080e7          	jalr	1428(ra) # 761a <wait>
  unlink("truncfile");
    108e:	00007517          	auipc	a0,0x7
    1092:	16a50513          	addi	a0,a0,362 # 81f8 <malloc+0x494>
    1096:	00006097          	auipc	ra,0x6
    109a:	5cc080e7          	jalr	1484(ra) # 7662 <unlink>
  exit(xstatus);
    109e:	fd042783          	lw	a5,-48(s0)
    10a2:	853e                	mv	a0,a5
    10a4:	00006097          	auipc	ra,0x6
    10a8:	56e080e7          	jalr	1390(ra) # 7612 <exit>

00000000000010ac <iputtest>:


// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(char *s)
{
    10ac:	1101                	addi	sp,sp,-32
    10ae:	ec06                	sd	ra,24(sp)
    10b0:	e822                	sd	s0,16(sp)
    10b2:	1000                	addi	s0,sp,32
    10b4:	fea43423          	sd	a0,-24(s0)
  if(mkdir("iputdir") < 0){
    10b8:	00007517          	auipc	a0,0x7
    10bc:	2b050513          	addi	a0,a0,688 # 8368 <malloc+0x604>
    10c0:	00006097          	auipc	ra,0x6
    10c4:	5ba080e7          	jalr	1466(ra) # 767a <mkdir>
    10c8:	87aa                	mv	a5,a0
    10ca:	0207d163          	bgez	a5,10ec <iputtest+0x40>
    printf("%s: mkdir failed\n", s);
    10ce:	fe843583          	ld	a1,-24(s0)
    10d2:	00007517          	auipc	a0,0x7
    10d6:	29e50513          	addi	a0,a0,670 # 8370 <malloc+0x60c>
    10da:	00007097          	auipc	ra,0x7
    10de:	a98080e7          	jalr	-1384(ra) # 7b72 <printf>
    exit(1);
    10e2:	4505                	li	a0,1
    10e4:	00006097          	auipc	ra,0x6
    10e8:	52e080e7          	jalr	1326(ra) # 7612 <exit>
  }
  if(chdir("iputdir") < 0){
    10ec:	00007517          	auipc	a0,0x7
    10f0:	27c50513          	addi	a0,a0,636 # 8368 <malloc+0x604>
    10f4:	00006097          	auipc	ra,0x6
    10f8:	58e080e7          	jalr	1422(ra) # 7682 <chdir>
    10fc:	87aa                	mv	a5,a0
    10fe:	0207d163          	bgez	a5,1120 <iputtest+0x74>
    printf("%s: chdir iputdir failed\n", s);
    1102:	fe843583          	ld	a1,-24(s0)
    1106:	00007517          	auipc	a0,0x7
    110a:	28250513          	addi	a0,a0,642 # 8388 <malloc+0x624>
    110e:	00007097          	auipc	ra,0x7
    1112:	a64080e7          	jalr	-1436(ra) # 7b72 <printf>
    exit(1);
    1116:	4505                	li	a0,1
    1118:	00006097          	auipc	ra,0x6
    111c:	4fa080e7          	jalr	1274(ra) # 7612 <exit>
  }
  if(unlink("../iputdir") < 0){
    1120:	00007517          	auipc	a0,0x7
    1124:	28850513          	addi	a0,a0,648 # 83a8 <malloc+0x644>
    1128:	00006097          	auipc	ra,0x6
    112c:	53a080e7          	jalr	1338(ra) # 7662 <unlink>
    1130:	87aa                	mv	a5,a0
    1132:	0207d163          	bgez	a5,1154 <iputtest+0xa8>
    printf("%s: unlink ../iputdir failed\n", s);
    1136:	fe843583          	ld	a1,-24(s0)
    113a:	00007517          	auipc	a0,0x7
    113e:	27e50513          	addi	a0,a0,638 # 83b8 <malloc+0x654>
    1142:	00007097          	auipc	ra,0x7
    1146:	a30080e7          	jalr	-1488(ra) # 7b72 <printf>
    exit(1);
    114a:	4505                	li	a0,1
    114c:	00006097          	auipc	ra,0x6
    1150:	4c6080e7          	jalr	1222(ra) # 7612 <exit>
  }
  if(chdir("/") < 0){
    1154:	00007517          	auipc	a0,0x7
    1158:	28450513          	addi	a0,a0,644 # 83d8 <malloc+0x674>
    115c:	00006097          	auipc	ra,0x6
    1160:	526080e7          	jalr	1318(ra) # 7682 <chdir>
    1164:	87aa                	mv	a5,a0
    1166:	0207d163          	bgez	a5,1188 <iputtest+0xdc>
    printf("%s: chdir / failed\n", s);
    116a:	fe843583          	ld	a1,-24(s0)
    116e:	00007517          	auipc	a0,0x7
    1172:	27250513          	addi	a0,a0,626 # 83e0 <malloc+0x67c>
    1176:	00007097          	auipc	ra,0x7
    117a:	9fc080e7          	jalr	-1540(ra) # 7b72 <printf>
    exit(1);
    117e:	4505                	li	a0,1
    1180:	00006097          	auipc	ra,0x6
    1184:	492080e7          	jalr	1170(ra) # 7612 <exit>
  }
}
    1188:	0001                	nop
    118a:	60e2                	ld	ra,24(sp)
    118c:	6442                	ld	s0,16(sp)
    118e:	6105                	addi	sp,sp,32
    1190:	8082                	ret

0000000000001192 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(char *s)
{
    1192:	7179                	addi	sp,sp,-48
    1194:	f406                	sd	ra,40(sp)
    1196:	f022                	sd	s0,32(sp)
    1198:	1800                	addi	s0,sp,48
    119a:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  pid = fork();
    119e:	00006097          	auipc	ra,0x6
    11a2:	46c080e7          	jalr	1132(ra) # 760a <fork>
    11a6:	87aa                	mv	a5,a0
    11a8:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    11ac:	fec42783          	lw	a5,-20(s0)
    11b0:	2781                	sext.w	a5,a5
    11b2:	0207d163          	bgez	a5,11d4 <exitiputtest+0x42>
    printf("%s: fork failed\n", s);
    11b6:	fd843583          	ld	a1,-40(s0)
    11ba:	00007517          	auipc	a0,0x7
    11be:	12650513          	addi	a0,a0,294 # 82e0 <malloc+0x57c>
    11c2:	00007097          	auipc	ra,0x7
    11c6:	9b0080e7          	jalr	-1616(ra) # 7b72 <printf>
    exit(1);
    11ca:	4505                	li	a0,1
    11cc:	00006097          	auipc	ra,0x6
    11d0:	446080e7          	jalr	1094(ra) # 7612 <exit>
  }
  if(pid == 0){
    11d4:	fec42783          	lw	a5,-20(s0)
    11d8:	2781                	sext.w	a5,a5
    11da:	e7c5                	bnez	a5,1282 <exitiputtest+0xf0>
    if(mkdir("iputdir") < 0){
    11dc:	00007517          	auipc	a0,0x7
    11e0:	18c50513          	addi	a0,a0,396 # 8368 <malloc+0x604>
    11e4:	00006097          	auipc	ra,0x6
    11e8:	496080e7          	jalr	1174(ra) # 767a <mkdir>
    11ec:	87aa                	mv	a5,a0
    11ee:	0207d163          	bgez	a5,1210 <exitiputtest+0x7e>
      printf("%s: mkdir failed\n", s);
    11f2:	fd843583          	ld	a1,-40(s0)
    11f6:	00007517          	auipc	a0,0x7
    11fa:	17a50513          	addi	a0,a0,378 # 8370 <malloc+0x60c>
    11fe:	00007097          	auipc	ra,0x7
    1202:	974080e7          	jalr	-1676(ra) # 7b72 <printf>
      exit(1);
    1206:	4505                	li	a0,1
    1208:	00006097          	auipc	ra,0x6
    120c:	40a080e7          	jalr	1034(ra) # 7612 <exit>
    }
    if(chdir("iputdir") < 0){
    1210:	00007517          	auipc	a0,0x7
    1214:	15850513          	addi	a0,a0,344 # 8368 <malloc+0x604>
    1218:	00006097          	auipc	ra,0x6
    121c:	46a080e7          	jalr	1130(ra) # 7682 <chdir>
    1220:	87aa                	mv	a5,a0
    1222:	0207d163          	bgez	a5,1244 <exitiputtest+0xb2>
      printf("%s: child chdir failed\n", s);
    1226:	fd843583          	ld	a1,-40(s0)
    122a:	00007517          	auipc	a0,0x7
    122e:	1ce50513          	addi	a0,a0,462 # 83f8 <malloc+0x694>
    1232:	00007097          	auipc	ra,0x7
    1236:	940080e7          	jalr	-1728(ra) # 7b72 <printf>
      exit(1);
    123a:	4505                	li	a0,1
    123c:	00006097          	auipc	ra,0x6
    1240:	3d6080e7          	jalr	982(ra) # 7612 <exit>
    }
    if(unlink("../iputdir") < 0){
    1244:	00007517          	auipc	a0,0x7
    1248:	16450513          	addi	a0,a0,356 # 83a8 <malloc+0x644>
    124c:	00006097          	auipc	ra,0x6
    1250:	416080e7          	jalr	1046(ra) # 7662 <unlink>
    1254:	87aa                	mv	a5,a0
    1256:	0207d163          	bgez	a5,1278 <exitiputtest+0xe6>
      printf("%s: unlink ../iputdir failed\n", s);
    125a:	fd843583          	ld	a1,-40(s0)
    125e:	00007517          	auipc	a0,0x7
    1262:	15a50513          	addi	a0,a0,346 # 83b8 <malloc+0x654>
    1266:	00007097          	auipc	ra,0x7
    126a:	90c080e7          	jalr	-1780(ra) # 7b72 <printf>
      exit(1);
    126e:	4505                	li	a0,1
    1270:	00006097          	auipc	ra,0x6
    1274:	3a2080e7          	jalr	930(ra) # 7612 <exit>
    }
    exit(0);
    1278:	4501                	li	a0,0
    127a:	00006097          	auipc	ra,0x6
    127e:	398080e7          	jalr	920(ra) # 7612 <exit>
  }
  wait(&xstatus);
    1282:	fe840793          	addi	a5,s0,-24
    1286:	853e                	mv	a0,a5
    1288:	00006097          	auipc	ra,0x6
    128c:	392080e7          	jalr	914(ra) # 761a <wait>
  exit(xstatus);
    1290:	fe842783          	lw	a5,-24(s0)
    1294:	853e                	mv	a0,a5
    1296:	00006097          	auipc	ra,0x6
    129a:	37c080e7          	jalr	892(ra) # 7612 <exit>

000000000000129e <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(char *s)
{
    129e:	7179                	addi	sp,sp,-48
    12a0:	f406                	sd	ra,40(sp)
    12a2:	f022                	sd	s0,32(sp)
    12a4:	1800                	addi	s0,sp,48
    12a6:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  if(mkdir("oidir") < 0){
    12aa:	00007517          	auipc	a0,0x7
    12ae:	16650513          	addi	a0,a0,358 # 8410 <malloc+0x6ac>
    12b2:	00006097          	auipc	ra,0x6
    12b6:	3c8080e7          	jalr	968(ra) # 767a <mkdir>
    12ba:	87aa                	mv	a5,a0
    12bc:	0207d163          	bgez	a5,12de <openiputtest+0x40>
    printf("%s: mkdir oidir failed\n", s);
    12c0:	fd843583          	ld	a1,-40(s0)
    12c4:	00007517          	auipc	a0,0x7
    12c8:	15450513          	addi	a0,a0,340 # 8418 <malloc+0x6b4>
    12cc:	00007097          	auipc	ra,0x7
    12d0:	8a6080e7          	jalr	-1882(ra) # 7b72 <printf>
    exit(1);
    12d4:	4505                	li	a0,1
    12d6:	00006097          	auipc	ra,0x6
    12da:	33c080e7          	jalr	828(ra) # 7612 <exit>
  }
  pid = fork();
    12de:	00006097          	auipc	ra,0x6
    12e2:	32c080e7          	jalr	812(ra) # 760a <fork>
    12e6:	87aa                	mv	a5,a0
    12e8:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    12ec:	fec42783          	lw	a5,-20(s0)
    12f0:	2781                	sext.w	a5,a5
    12f2:	0207d163          	bgez	a5,1314 <openiputtest+0x76>
    printf("%s: fork failed\n", s);
    12f6:	fd843583          	ld	a1,-40(s0)
    12fa:	00007517          	auipc	a0,0x7
    12fe:	fe650513          	addi	a0,a0,-26 # 82e0 <malloc+0x57c>
    1302:	00007097          	auipc	ra,0x7
    1306:	870080e7          	jalr	-1936(ra) # 7b72 <printf>
    exit(1);
    130a:	4505                	li	a0,1
    130c:	00006097          	auipc	ra,0x6
    1310:	306080e7          	jalr	774(ra) # 7612 <exit>
  }
  if(pid == 0){
    1314:	fec42783          	lw	a5,-20(s0)
    1318:	2781                	sext.w	a5,a5
    131a:	e7b1                	bnez	a5,1366 <openiputtest+0xc8>
    int fd = open("oidir", O_RDWR);
    131c:	4589                	li	a1,2
    131e:	00007517          	auipc	a0,0x7
    1322:	0f250513          	addi	a0,a0,242 # 8410 <malloc+0x6ac>
    1326:	00006097          	auipc	ra,0x6
    132a:	32c080e7          	jalr	812(ra) # 7652 <open>
    132e:	87aa                	mv	a5,a0
    1330:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0){
    1334:	fe842783          	lw	a5,-24(s0)
    1338:	2781                	sext.w	a5,a5
    133a:	0207c163          	bltz	a5,135c <openiputtest+0xbe>
      printf("%s: open directory for write succeeded\n", s);
    133e:	fd843583          	ld	a1,-40(s0)
    1342:	00007517          	auipc	a0,0x7
    1346:	0ee50513          	addi	a0,a0,238 # 8430 <malloc+0x6cc>
    134a:	00007097          	auipc	ra,0x7
    134e:	828080e7          	jalr	-2008(ra) # 7b72 <printf>
      exit(1);
    1352:	4505                	li	a0,1
    1354:	00006097          	auipc	ra,0x6
    1358:	2be080e7          	jalr	702(ra) # 7612 <exit>
    }
    exit(0);
    135c:	4501                	li	a0,0
    135e:	00006097          	auipc	ra,0x6
    1362:	2b4080e7          	jalr	692(ra) # 7612 <exit>
  }
  sleep(1);
    1366:	4505                	li	a0,1
    1368:	00006097          	auipc	ra,0x6
    136c:	33a080e7          	jalr	826(ra) # 76a2 <sleep>
  if(unlink("oidir") != 0){
    1370:	00007517          	auipc	a0,0x7
    1374:	0a050513          	addi	a0,a0,160 # 8410 <malloc+0x6ac>
    1378:	00006097          	auipc	ra,0x6
    137c:	2ea080e7          	jalr	746(ra) # 7662 <unlink>
    1380:	87aa                	mv	a5,a0
    1382:	c385                	beqz	a5,13a2 <openiputtest+0x104>
    printf("%s: unlink failed\n", s);
    1384:	fd843583          	ld	a1,-40(s0)
    1388:	00007517          	auipc	a0,0x7
    138c:	0d050513          	addi	a0,a0,208 # 8458 <malloc+0x6f4>
    1390:	00006097          	auipc	ra,0x6
    1394:	7e2080e7          	jalr	2018(ra) # 7b72 <printf>
    exit(1);
    1398:	4505                	li	a0,1
    139a:	00006097          	auipc	ra,0x6
    139e:	278080e7          	jalr	632(ra) # 7612 <exit>
  }
  wait(&xstatus);
    13a2:	fe440793          	addi	a5,s0,-28
    13a6:	853e                	mv	a0,a5
    13a8:	00006097          	auipc	ra,0x6
    13ac:	272080e7          	jalr	626(ra) # 761a <wait>
  exit(xstatus);
    13b0:	fe442783          	lw	a5,-28(s0)
    13b4:	853e                	mv	a0,a5
    13b6:	00006097          	auipc	ra,0x6
    13ba:	25c080e7          	jalr	604(ra) # 7612 <exit>

00000000000013be <opentest>:

// simple file system tests

void
opentest(char *s)
{
    13be:	7179                	addi	sp,sp,-48
    13c0:	f406                	sd	ra,40(sp)
    13c2:	f022                	sd	s0,32(sp)
    13c4:	1800                	addi	s0,sp,48
    13c6:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("echo", 0);
    13ca:	4581                	li	a1,0
    13cc:	00007517          	auipc	a0,0x7
    13d0:	cf450513          	addi	a0,a0,-780 # 80c0 <malloc+0x35c>
    13d4:	00006097          	auipc	ra,0x6
    13d8:	27e080e7          	jalr	638(ra) # 7652 <open>
    13dc:	87aa                	mv	a5,a0
    13de:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    13e2:	fec42783          	lw	a5,-20(s0)
    13e6:	2781                	sext.w	a5,a5
    13e8:	0207d163          	bgez	a5,140a <opentest+0x4c>
    printf("%s: open echo failed!\n", s);
    13ec:	fd843583          	ld	a1,-40(s0)
    13f0:	00007517          	auipc	a0,0x7
    13f4:	08050513          	addi	a0,a0,128 # 8470 <malloc+0x70c>
    13f8:	00006097          	auipc	ra,0x6
    13fc:	77a080e7          	jalr	1914(ra) # 7b72 <printf>
    exit(1);
    1400:	4505                	li	a0,1
    1402:	00006097          	auipc	ra,0x6
    1406:	210080e7          	jalr	528(ra) # 7612 <exit>
  }
  close(fd);
    140a:	fec42783          	lw	a5,-20(s0)
    140e:	853e                	mv	a0,a5
    1410:	00006097          	auipc	ra,0x6
    1414:	22a080e7          	jalr	554(ra) # 763a <close>
  fd = open("doesnotexist", 0);
    1418:	4581                	li	a1,0
    141a:	00007517          	auipc	a0,0x7
    141e:	06e50513          	addi	a0,a0,110 # 8488 <malloc+0x724>
    1422:	00006097          	auipc	ra,0x6
    1426:	230080e7          	jalr	560(ra) # 7652 <open>
    142a:	87aa                	mv	a5,a0
    142c:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    1430:	fec42783          	lw	a5,-20(s0)
    1434:	2781                	sext.w	a5,a5
    1436:	0207c163          	bltz	a5,1458 <opentest+0x9a>
    printf("%s: open doesnotexist succeeded!\n", s);
    143a:	fd843583          	ld	a1,-40(s0)
    143e:	00007517          	auipc	a0,0x7
    1442:	05a50513          	addi	a0,a0,90 # 8498 <malloc+0x734>
    1446:	00006097          	auipc	ra,0x6
    144a:	72c080e7          	jalr	1836(ra) # 7b72 <printf>
    exit(1);
    144e:	4505                	li	a0,1
    1450:	00006097          	auipc	ra,0x6
    1454:	1c2080e7          	jalr	450(ra) # 7612 <exit>
  }
}
    1458:	0001                	nop
    145a:	70a2                	ld	ra,40(sp)
    145c:	7402                	ld	s0,32(sp)
    145e:	6145                	addi	sp,sp,48
    1460:	8082                	ret

0000000000001462 <writetest>:

void
writetest(char *s)
{
    1462:	7179                	addi	sp,sp,-48
    1464:	f406                	sd	ra,40(sp)
    1466:	f022                	sd	s0,32(sp)
    1468:	1800                	addi	s0,sp,48
    146a:	fca43c23          	sd	a0,-40(s0)
  int fd;
  int i;
  enum { N=100, SZ=10 };

  fd = open("small", O_CREATE|O_RDWR);
    146e:	20200593          	li	a1,514
    1472:	00007517          	auipc	a0,0x7
    1476:	04e50513          	addi	a0,a0,78 # 84c0 <malloc+0x75c>
    147a:	00006097          	auipc	ra,0x6
    147e:	1d8080e7          	jalr	472(ra) # 7652 <open>
    1482:	87aa                	mv	a5,a0
    1484:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1488:	fe842783          	lw	a5,-24(s0)
    148c:	2781                	sext.w	a5,a5
    148e:	0207d163          	bgez	a5,14b0 <writetest+0x4e>
    printf("%s: error: creat small failed!\n", s);
    1492:	fd843583          	ld	a1,-40(s0)
    1496:	00007517          	auipc	a0,0x7
    149a:	03250513          	addi	a0,a0,50 # 84c8 <malloc+0x764>
    149e:	00006097          	auipc	ra,0x6
    14a2:	6d4080e7          	jalr	1748(ra) # 7b72 <printf>
    exit(1);
    14a6:	4505                	li	a0,1
    14a8:	00006097          	auipc	ra,0x6
    14ac:	16a080e7          	jalr	362(ra) # 7612 <exit>
  }
  for(i = 0; i < N; i++){
    14b0:	fe042623          	sw	zero,-20(s0)
    14b4:	a861                	j	154c <writetest+0xea>
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
    14b6:	fe842783          	lw	a5,-24(s0)
    14ba:	4629                	li	a2,10
    14bc:	00007597          	auipc	a1,0x7
    14c0:	02c58593          	addi	a1,a1,44 # 84e8 <malloc+0x784>
    14c4:	853e                	mv	a0,a5
    14c6:	00006097          	auipc	ra,0x6
    14ca:	16c080e7          	jalr	364(ra) # 7632 <write>
    14ce:	87aa                	mv	a5,a0
    14d0:	873e                	mv	a4,a5
    14d2:	47a9                	li	a5,10
    14d4:	02f70463          	beq	a4,a5,14fc <writetest+0x9a>
      printf("%s: error: write aa %d new file failed\n", s, i);
    14d8:	fec42783          	lw	a5,-20(s0)
    14dc:	863e                	mv	a2,a5
    14de:	fd843583          	ld	a1,-40(s0)
    14e2:	00007517          	auipc	a0,0x7
    14e6:	01650513          	addi	a0,a0,22 # 84f8 <malloc+0x794>
    14ea:	00006097          	auipc	ra,0x6
    14ee:	688080e7          	jalr	1672(ra) # 7b72 <printf>
      exit(1);
    14f2:	4505                	li	a0,1
    14f4:	00006097          	auipc	ra,0x6
    14f8:	11e080e7          	jalr	286(ra) # 7612 <exit>
    }
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
    14fc:	fe842783          	lw	a5,-24(s0)
    1500:	4629                	li	a2,10
    1502:	00007597          	auipc	a1,0x7
    1506:	01e58593          	addi	a1,a1,30 # 8520 <malloc+0x7bc>
    150a:	853e                	mv	a0,a5
    150c:	00006097          	auipc	ra,0x6
    1510:	126080e7          	jalr	294(ra) # 7632 <write>
    1514:	87aa                	mv	a5,a0
    1516:	873e                	mv	a4,a5
    1518:	47a9                	li	a5,10
    151a:	02f70463          	beq	a4,a5,1542 <writetest+0xe0>
      printf("%s: error: write bb %d new file failed\n", s, i);
    151e:	fec42783          	lw	a5,-20(s0)
    1522:	863e                	mv	a2,a5
    1524:	fd843583          	ld	a1,-40(s0)
    1528:	00007517          	auipc	a0,0x7
    152c:	00850513          	addi	a0,a0,8 # 8530 <malloc+0x7cc>
    1530:	00006097          	auipc	ra,0x6
    1534:	642080e7          	jalr	1602(ra) # 7b72 <printf>
      exit(1);
    1538:	4505                	li	a0,1
    153a:	00006097          	auipc	ra,0x6
    153e:	0d8080e7          	jalr	216(ra) # 7612 <exit>
  for(i = 0; i < N; i++){
    1542:	fec42783          	lw	a5,-20(s0)
    1546:	2785                	addiw	a5,a5,1
    1548:	fef42623          	sw	a5,-20(s0)
    154c:	fec42783          	lw	a5,-20(s0)
    1550:	0007871b          	sext.w	a4,a5
    1554:	06300793          	li	a5,99
    1558:	f4e7dfe3          	bge	a5,a4,14b6 <writetest+0x54>
    }
  }
  close(fd);
    155c:	fe842783          	lw	a5,-24(s0)
    1560:	853e                	mv	a0,a5
    1562:	00006097          	auipc	ra,0x6
    1566:	0d8080e7          	jalr	216(ra) # 763a <close>
  fd = open("small", O_RDONLY);
    156a:	4581                	li	a1,0
    156c:	00007517          	auipc	a0,0x7
    1570:	f5450513          	addi	a0,a0,-172 # 84c0 <malloc+0x75c>
    1574:	00006097          	auipc	ra,0x6
    1578:	0de080e7          	jalr	222(ra) # 7652 <open>
    157c:	87aa                	mv	a5,a0
    157e:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1582:	fe842783          	lw	a5,-24(s0)
    1586:	2781                	sext.w	a5,a5
    1588:	0207d163          	bgez	a5,15aa <writetest+0x148>
    printf("%s: error: open small failed!\n", s);
    158c:	fd843583          	ld	a1,-40(s0)
    1590:	00007517          	auipc	a0,0x7
    1594:	fc850513          	addi	a0,a0,-56 # 8558 <malloc+0x7f4>
    1598:	00006097          	auipc	ra,0x6
    159c:	5da080e7          	jalr	1498(ra) # 7b72 <printf>
    exit(1);
    15a0:	4505                	li	a0,1
    15a2:	00006097          	auipc	ra,0x6
    15a6:	070080e7          	jalr	112(ra) # 7612 <exit>
  }
  i = read(fd, buf, N*SZ*2);
    15aa:	fe842783          	lw	a5,-24(s0)
    15ae:	7d000613          	li	a2,2000
    15b2:	0000b597          	auipc	a1,0xb
    15b6:	d2e58593          	addi	a1,a1,-722 # c2e0 <buf>
    15ba:	853e                	mv	a0,a5
    15bc:	00006097          	auipc	ra,0x6
    15c0:	06e080e7          	jalr	110(ra) # 762a <read>
    15c4:	87aa                	mv	a5,a0
    15c6:	fef42623          	sw	a5,-20(s0)
  if(i != N*SZ*2){
    15ca:	fec42783          	lw	a5,-20(s0)
    15ce:	0007871b          	sext.w	a4,a5
    15d2:	7d000793          	li	a5,2000
    15d6:	02f70163          	beq	a4,a5,15f8 <writetest+0x196>
    printf("%s: read failed\n", s);
    15da:	fd843583          	ld	a1,-40(s0)
    15de:	00007517          	auipc	a0,0x7
    15e2:	f9a50513          	addi	a0,a0,-102 # 8578 <malloc+0x814>
    15e6:	00006097          	auipc	ra,0x6
    15ea:	58c080e7          	jalr	1420(ra) # 7b72 <printf>
    exit(1);
    15ee:	4505                	li	a0,1
    15f0:	00006097          	auipc	ra,0x6
    15f4:	022080e7          	jalr	34(ra) # 7612 <exit>
  }
  close(fd);
    15f8:	fe842783          	lw	a5,-24(s0)
    15fc:	853e                	mv	a0,a5
    15fe:	00006097          	auipc	ra,0x6
    1602:	03c080e7          	jalr	60(ra) # 763a <close>

  if(unlink("small") < 0){
    1606:	00007517          	auipc	a0,0x7
    160a:	eba50513          	addi	a0,a0,-326 # 84c0 <malloc+0x75c>
    160e:	00006097          	auipc	ra,0x6
    1612:	054080e7          	jalr	84(ra) # 7662 <unlink>
    1616:	87aa                	mv	a5,a0
    1618:	0207d163          	bgez	a5,163a <writetest+0x1d8>
    printf("%s: unlink small failed\n", s);
    161c:	fd843583          	ld	a1,-40(s0)
    1620:	00007517          	auipc	a0,0x7
    1624:	f7050513          	addi	a0,a0,-144 # 8590 <malloc+0x82c>
    1628:	00006097          	auipc	ra,0x6
    162c:	54a080e7          	jalr	1354(ra) # 7b72 <printf>
    exit(1);
    1630:	4505                	li	a0,1
    1632:	00006097          	auipc	ra,0x6
    1636:	fe0080e7          	jalr	-32(ra) # 7612 <exit>
  }
}
    163a:	0001                	nop
    163c:	70a2                	ld	ra,40(sp)
    163e:	7402                	ld	s0,32(sp)
    1640:	6145                	addi	sp,sp,48
    1642:	8082                	ret

0000000000001644 <writebig>:

void
writebig(char *s)
{
    1644:	7179                	addi	sp,sp,-48
    1646:	f406                	sd	ra,40(sp)
    1648:	f022                	sd	s0,32(sp)
    164a:	1800                	addi	s0,sp,48
    164c:	fca43c23          	sd	a0,-40(s0)
  int i, fd, n;

  fd = open("big", O_CREATE|O_RDWR);
    1650:	20200593          	li	a1,514
    1654:	00007517          	auipc	a0,0x7
    1658:	f5c50513          	addi	a0,a0,-164 # 85b0 <malloc+0x84c>
    165c:	00006097          	auipc	ra,0x6
    1660:	ff6080e7          	jalr	-10(ra) # 7652 <open>
    1664:	87aa                	mv	a5,a0
    1666:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    166a:	fe442783          	lw	a5,-28(s0)
    166e:	2781                	sext.w	a5,a5
    1670:	0207d163          	bgez	a5,1692 <writebig+0x4e>
    printf("%s: error: creat big failed!\n", s);
    1674:	fd843583          	ld	a1,-40(s0)
    1678:	00007517          	auipc	a0,0x7
    167c:	f4050513          	addi	a0,a0,-192 # 85b8 <malloc+0x854>
    1680:	00006097          	auipc	ra,0x6
    1684:	4f2080e7          	jalr	1266(ra) # 7b72 <printf>
    exit(1);
    1688:	4505                	li	a0,1
    168a:	00006097          	auipc	ra,0x6
    168e:	f88080e7          	jalr	-120(ra) # 7612 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
    1692:	fe042623          	sw	zero,-20(s0)
    1696:	a095                	j	16fa <writebig+0xb6>
    ((int*)buf)[0] = i;
    1698:	0000b797          	auipc	a5,0xb
    169c:	c4878793          	addi	a5,a5,-952 # c2e0 <buf>
    16a0:	fec42703          	lw	a4,-20(s0)
    16a4:	c398                	sw	a4,0(a5)
    if(write(fd, buf, BSIZE) != BSIZE){
    16a6:	fe442783          	lw	a5,-28(s0)
    16aa:	40000613          	li	a2,1024
    16ae:	0000b597          	auipc	a1,0xb
    16b2:	c3258593          	addi	a1,a1,-974 # c2e0 <buf>
    16b6:	853e                	mv	a0,a5
    16b8:	00006097          	auipc	ra,0x6
    16bc:	f7a080e7          	jalr	-134(ra) # 7632 <write>
    16c0:	87aa                	mv	a5,a0
    16c2:	873e                	mv	a4,a5
    16c4:	40000793          	li	a5,1024
    16c8:	02f70463          	beq	a4,a5,16f0 <writebig+0xac>
      printf("%s: error: write big file failed\n", s, i);
    16cc:	fec42783          	lw	a5,-20(s0)
    16d0:	863e                	mv	a2,a5
    16d2:	fd843583          	ld	a1,-40(s0)
    16d6:	00007517          	auipc	a0,0x7
    16da:	f0250513          	addi	a0,a0,-254 # 85d8 <malloc+0x874>
    16de:	00006097          	auipc	ra,0x6
    16e2:	494080e7          	jalr	1172(ra) # 7b72 <printf>
      exit(1);
    16e6:	4505                	li	a0,1
    16e8:	00006097          	auipc	ra,0x6
    16ec:	f2a080e7          	jalr	-214(ra) # 7612 <exit>
  for(i = 0; i < MAXFILE; i++){
    16f0:	fec42783          	lw	a5,-20(s0)
    16f4:	2785                	addiw	a5,a5,1
    16f6:	fef42623          	sw	a5,-20(s0)
    16fa:	fec42783          	lw	a5,-20(s0)
    16fe:	873e                	mv	a4,a5
    1700:	10b00793          	li	a5,267
    1704:	f8e7fae3          	bgeu	a5,a4,1698 <writebig+0x54>
    }
  }

  close(fd);
    1708:	fe442783          	lw	a5,-28(s0)
    170c:	853e                	mv	a0,a5
    170e:	00006097          	auipc	ra,0x6
    1712:	f2c080e7          	jalr	-212(ra) # 763a <close>

  fd = open("big", O_RDONLY);
    1716:	4581                	li	a1,0
    1718:	00007517          	auipc	a0,0x7
    171c:	e9850513          	addi	a0,a0,-360 # 85b0 <malloc+0x84c>
    1720:	00006097          	auipc	ra,0x6
    1724:	f32080e7          	jalr	-206(ra) # 7652 <open>
    1728:	87aa                	mv	a5,a0
    172a:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    172e:	fe442783          	lw	a5,-28(s0)
    1732:	2781                	sext.w	a5,a5
    1734:	0207d163          	bgez	a5,1756 <writebig+0x112>
    printf("%s: error: open big failed!\n", s);
    1738:	fd843583          	ld	a1,-40(s0)
    173c:	00007517          	auipc	a0,0x7
    1740:	ec450513          	addi	a0,a0,-316 # 8600 <malloc+0x89c>
    1744:	00006097          	auipc	ra,0x6
    1748:	42e080e7          	jalr	1070(ra) # 7b72 <printf>
    exit(1);
    174c:	4505                	li	a0,1
    174e:	00006097          	auipc	ra,0x6
    1752:	ec4080e7          	jalr	-316(ra) # 7612 <exit>
  }

  n = 0;
    1756:	fe042423          	sw	zero,-24(s0)
  for(;;){
    i = read(fd, buf, BSIZE);
    175a:	fe442783          	lw	a5,-28(s0)
    175e:	40000613          	li	a2,1024
    1762:	0000b597          	auipc	a1,0xb
    1766:	b7e58593          	addi	a1,a1,-1154 # c2e0 <buf>
    176a:	853e                	mv	a0,a5
    176c:	00006097          	auipc	ra,0x6
    1770:	ebe080e7          	jalr	-322(ra) # 762a <read>
    1774:	87aa                	mv	a5,a0
    1776:	fef42623          	sw	a5,-20(s0)
    if(i == 0){
    177a:	fec42783          	lw	a5,-20(s0)
    177e:	2781                	sext.w	a5,a5
    1780:	eb9d                	bnez	a5,17b6 <writebig+0x172>
      if(n == MAXFILE - 1){
    1782:	fe842783          	lw	a5,-24(s0)
    1786:	0007871b          	sext.w	a4,a5
    178a:	10b00793          	li	a5,267
    178e:	0af71663          	bne	a4,a5,183a <writebig+0x1f6>
        printf("%s: read only %d blocks from big", s, n);
    1792:	fe842783          	lw	a5,-24(s0)
    1796:	863e                	mv	a2,a5
    1798:	fd843583          	ld	a1,-40(s0)
    179c:	00007517          	auipc	a0,0x7
    17a0:	e8450513          	addi	a0,a0,-380 # 8620 <malloc+0x8bc>
    17a4:	00006097          	auipc	ra,0x6
    17a8:	3ce080e7          	jalr	974(ra) # 7b72 <printf>
        exit(1);
    17ac:	4505                	li	a0,1
    17ae:	00006097          	auipc	ra,0x6
    17b2:	e64080e7          	jalr	-412(ra) # 7612 <exit>
      }
      break;
    } else if(i != BSIZE){
    17b6:	fec42783          	lw	a5,-20(s0)
    17ba:	0007871b          	sext.w	a4,a5
    17be:	40000793          	li	a5,1024
    17c2:	02f70463          	beq	a4,a5,17ea <writebig+0x1a6>
      printf("%s: read failed %d\n", s, i);
    17c6:	fec42783          	lw	a5,-20(s0)
    17ca:	863e                	mv	a2,a5
    17cc:	fd843583          	ld	a1,-40(s0)
    17d0:	00007517          	auipc	a0,0x7
    17d4:	e7850513          	addi	a0,a0,-392 # 8648 <malloc+0x8e4>
    17d8:	00006097          	auipc	ra,0x6
    17dc:	39a080e7          	jalr	922(ra) # 7b72 <printf>
      exit(1);
    17e0:	4505                	li	a0,1
    17e2:	00006097          	auipc	ra,0x6
    17e6:	e30080e7          	jalr	-464(ra) # 7612 <exit>
    }
    if(((int*)buf)[0] != n){
    17ea:	0000b797          	auipc	a5,0xb
    17ee:	af678793          	addi	a5,a5,-1290 # c2e0 <buf>
    17f2:	4398                	lw	a4,0(a5)
    17f4:	fe842783          	lw	a5,-24(s0)
    17f8:	2781                	sext.w	a5,a5
    17fa:	02e78a63          	beq	a5,a4,182e <writebig+0x1ea>
      printf("%s: read content of block %d is %d\n", s,
             n, ((int*)buf)[0]);
    17fe:	0000b797          	auipc	a5,0xb
    1802:	ae278793          	addi	a5,a5,-1310 # c2e0 <buf>
      printf("%s: read content of block %d is %d\n", s,
    1806:	4398                	lw	a4,0(a5)
    1808:	fe842783          	lw	a5,-24(s0)
    180c:	86ba                	mv	a3,a4
    180e:	863e                	mv	a2,a5
    1810:	fd843583          	ld	a1,-40(s0)
    1814:	00007517          	auipc	a0,0x7
    1818:	e4c50513          	addi	a0,a0,-436 # 8660 <malloc+0x8fc>
    181c:	00006097          	auipc	ra,0x6
    1820:	356080e7          	jalr	854(ra) # 7b72 <printf>
      exit(1);
    1824:	4505                	li	a0,1
    1826:	00006097          	auipc	ra,0x6
    182a:	dec080e7          	jalr	-532(ra) # 7612 <exit>
    }
    n++;
    182e:	fe842783          	lw	a5,-24(s0)
    1832:	2785                	addiw	a5,a5,1
    1834:	fef42423          	sw	a5,-24(s0)
    i = read(fd, buf, BSIZE);
    1838:	b70d                	j	175a <writebig+0x116>
      break;
    183a:	0001                	nop
  }
  close(fd);
    183c:	fe442783          	lw	a5,-28(s0)
    1840:	853e                	mv	a0,a5
    1842:	00006097          	auipc	ra,0x6
    1846:	df8080e7          	jalr	-520(ra) # 763a <close>
  if(unlink("big") < 0){
    184a:	00007517          	auipc	a0,0x7
    184e:	d6650513          	addi	a0,a0,-666 # 85b0 <malloc+0x84c>
    1852:	00006097          	auipc	ra,0x6
    1856:	e10080e7          	jalr	-496(ra) # 7662 <unlink>
    185a:	87aa                	mv	a5,a0
    185c:	0207d163          	bgez	a5,187e <writebig+0x23a>
    printf("%s: unlink big failed\n", s);
    1860:	fd843583          	ld	a1,-40(s0)
    1864:	00007517          	auipc	a0,0x7
    1868:	e2450513          	addi	a0,a0,-476 # 8688 <malloc+0x924>
    186c:	00006097          	auipc	ra,0x6
    1870:	306080e7          	jalr	774(ra) # 7b72 <printf>
    exit(1);
    1874:	4505                	li	a0,1
    1876:	00006097          	auipc	ra,0x6
    187a:	d9c080e7          	jalr	-612(ra) # 7612 <exit>
  }
}
    187e:	0001                	nop
    1880:	70a2                	ld	ra,40(sp)
    1882:	7402                	ld	s0,32(sp)
    1884:	6145                	addi	sp,sp,48
    1886:	8082                	ret

0000000000001888 <createtest>:

// many creates, followed by unlink test
void
createtest(char *s)
{
    1888:	7179                	addi	sp,sp,-48
    188a:	f406                	sd	ra,40(sp)
    188c:	f022                	sd	s0,32(sp)
    188e:	1800                	addi	s0,sp,48
    1890:	fca43c23          	sd	a0,-40(s0)
  int i, fd;
  enum { N=52 };

  char name[3];
  name[0] = 'a';
    1894:	06100793          	li	a5,97
    1898:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    189c:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    18a0:	fe042623          	sw	zero,-20(s0)
    18a4:	a099                	j	18ea <createtest+0x62>
    name[1] = '0' + i;
    18a6:	fec42783          	lw	a5,-20(s0)
    18aa:	0ff7f793          	zext.b	a5,a5
    18ae:	0307879b          	addiw	a5,a5,48
    18b2:	0ff7f793          	zext.b	a5,a5
    18b6:	fef400a3          	sb	a5,-31(s0)
    fd = open(name, O_CREATE|O_RDWR);
    18ba:	fe040793          	addi	a5,s0,-32
    18be:	20200593          	li	a1,514
    18c2:	853e                	mv	a0,a5
    18c4:	00006097          	auipc	ra,0x6
    18c8:	d8e080e7          	jalr	-626(ra) # 7652 <open>
    18cc:	87aa                	mv	a5,a0
    18ce:	fef42423          	sw	a5,-24(s0)
    close(fd);
    18d2:	fe842783          	lw	a5,-24(s0)
    18d6:	853e                	mv	a0,a5
    18d8:	00006097          	auipc	ra,0x6
    18dc:	d62080e7          	jalr	-670(ra) # 763a <close>
  for(i = 0; i < N; i++){
    18e0:	fec42783          	lw	a5,-20(s0)
    18e4:	2785                	addiw	a5,a5,1
    18e6:	fef42623          	sw	a5,-20(s0)
    18ea:	fec42783          	lw	a5,-20(s0)
    18ee:	0007871b          	sext.w	a4,a5
    18f2:	03300793          	li	a5,51
    18f6:	fae7d8e3          	bge	a5,a4,18a6 <createtest+0x1e>
  }
  name[0] = 'a';
    18fa:	06100793          	li	a5,97
    18fe:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    1902:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    1906:	fe042623          	sw	zero,-20(s0)
    190a:	a03d                	j	1938 <createtest+0xb0>
    name[1] = '0' + i;
    190c:	fec42783          	lw	a5,-20(s0)
    1910:	0ff7f793          	zext.b	a5,a5
    1914:	0307879b          	addiw	a5,a5,48
    1918:	0ff7f793          	zext.b	a5,a5
    191c:	fef400a3          	sb	a5,-31(s0)
    unlink(name);
    1920:	fe040793          	addi	a5,s0,-32
    1924:	853e                	mv	a0,a5
    1926:	00006097          	auipc	ra,0x6
    192a:	d3c080e7          	jalr	-708(ra) # 7662 <unlink>
  for(i = 0; i < N; i++){
    192e:	fec42783          	lw	a5,-20(s0)
    1932:	2785                	addiw	a5,a5,1
    1934:	fef42623          	sw	a5,-20(s0)
    1938:	fec42783          	lw	a5,-20(s0)
    193c:	0007871b          	sext.w	a4,a5
    1940:	03300793          	li	a5,51
    1944:	fce7d4e3          	bge	a5,a4,190c <createtest+0x84>
  }
}
    1948:	0001                	nop
    194a:	0001                	nop
    194c:	70a2                	ld	ra,40(sp)
    194e:	7402                	ld	s0,32(sp)
    1950:	6145                	addi	sp,sp,48
    1952:	8082                	ret

0000000000001954 <dirtest>:

void dirtest(char *s)
{
    1954:	1101                	addi	sp,sp,-32
    1956:	ec06                	sd	ra,24(sp)
    1958:	e822                	sd	s0,16(sp)
    195a:	1000                	addi	s0,sp,32
    195c:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dir0") < 0){
    1960:	00007517          	auipc	a0,0x7
    1964:	d4050513          	addi	a0,a0,-704 # 86a0 <malloc+0x93c>
    1968:	00006097          	auipc	ra,0x6
    196c:	d12080e7          	jalr	-750(ra) # 767a <mkdir>
    1970:	87aa                	mv	a5,a0
    1972:	0207d163          	bgez	a5,1994 <dirtest+0x40>
    printf("%s: mkdir failed\n", s);
    1976:	fe843583          	ld	a1,-24(s0)
    197a:	00007517          	auipc	a0,0x7
    197e:	9f650513          	addi	a0,a0,-1546 # 8370 <malloc+0x60c>
    1982:	00006097          	auipc	ra,0x6
    1986:	1f0080e7          	jalr	496(ra) # 7b72 <printf>
    exit(1);
    198a:	4505                	li	a0,1
    198c:	00006097          	auipc	ra,0x6
    1990:	c86080e7          	jalr	-890(ra) # 7612 <exit>
  }

  if(chdir("dir0") < 0){
    1994:	00007517          	auipc	a0,0x7
    1998:	d0c50513          	addi	a0,a0,-756 # 86a0 <malloc+0x93c>
    199c:	00006097          	auipc	ra,0x6
    19a0:	ce6080e7          	jalr	-794(ra) # 7682 <chdir>
    19a4:	87aa                	mv	a5,a0
    19a6:	0207d163          	bgez	a5,19c8 <dirtest+0x74>
    printf("%s: chdir dir0 failed\n", s);
    19aa:	fe843583          	ld	a1,-24(s0)
    19ae:	00007517          	auipc	a0,0x7
    19b2:	cfa50513          	addi	a0,a0,-774 # 86a8 <malloc+0x944>
    19b6:	00006097          	auipc	ra,0x6
    19ba:	1bc080e7          	jalr	444(ra) # 7b72 <printf>
    exit(1);
    19be:	4505                	li	a0,1
    19c0:	00006097          	auipc	ra,0x6
    19c4:	c52080e7          	jalr	-942(ra) # 7612 <exit>
  }

  if(chdir("..") < 0){
    19c8:	00007517          	auipc	a0,0x7
    19cc:	cf850513          	addi	a0,a0,-776 # 86c0 <malloc+0x95c>
    19d0:	00006097          	auipc	ra,0x6
    19d4:	cb2080e7          	jalr	-846(ra) # 7682 <chdir>
    19d8:	87aa                	mv	a5,a0
    19da:	0207d163          	bgez	a5,19fc <dirtest+0xa8>
    printf("%s: chdir .. failed\n", s);
    19de:	fe843583          	ld	a1,-24(s0)
    19e2:	00007517          	auipc	a0,0x7
    19e6:	ce650513          	addi	a0,a0,-794 # 86c8 <malloc+0x964>
    19ea:	00006097          	auipc	ra,0x6
    19ee:	188080e7          	jalr	392(ra) # 7b72 <printf>
    exit(1);
    19f2:	4505                	li	a0,1
    19f4:	00006097          	auipc	ra,0x6
    19f8:	c1e080e7          	jalr	-994(ra) # 7612 <exit>
  }

  if(unlink("dir0") < 0){
    19fc:	00007517          	auipc	a0,0x7
    1a00:	ca450513          	addi	a0,a0,-860 # 86a0 <malloc+0x93c>
    1a04:	00006097          	auipc	ra,0x6
    1a08:	c5e080e7          	jalr	-930(ra) # 7662 <unlink>
    1a0c:	87aa                	mv	a5,a0
    1a0e:	0207d163          	bgez	a5,1a30 <dirtest+0xdc>
    printf("%s: unlink dir0 failed\n", s);
    1a12:	fe843583          	ld	a1,-24(s0)
    1a16:	00007517          	auipc	a0,0x7
    1a1a:	cca50513          	addi	a0,a0,-822 # 86e0 <malloc+0x97c>
    1a1e:	00006097          	auipc	ra,0x6
    1a22:	154080e7          	jalr	340(ra) # 7b72 <printf>
    exit(1);
    1a26:	4505                	li	a0,1
    1a28:	00006097          	auipc	ra,0x6
    1a2c:	bea080e7          	jalr	-1046(ra) # 7612 <exit>
  }
}
    1a30:	0001                	nop
    1a32:	60e2                	ld	ra,24(sp)
    1a34:	6442                	ld	s0,16(sp)
    1a36:	6105                	addi	sp,sp,32
    1a38:	8082                	ret

0000000000001a3a <exectest>:

void
exectest(char *s)
{
    1a3a:	715d                	addi	sp,sp,-80
    1a3c:	e486                	sd	ra,72(sp)
    1a3e:	e0a2                	sd	s0,64(sp)
    1a40:	0880                	addi	s0,sp,80
    1a42:	faa43c23          	sd	a0,-72(s0)
  int fd, xstatus, pid;
  char *echoargv[] = { "echo", "OK", 0 };
    1a46:	00006797          	auipc	a5,0x6
    1a4a:	67a78793          	addi	a5,a5,1658 # 80c0 <malloc+0x35c>
    1a4e:	fcf43423          	sd	a5,-56(s0)
    1a52:	00007797          	auipc	a5,0x7
    1a56:	ca678793          	addi	a5,a5,-858 # 86f8 <malloc+0x994>
    1a5a:	fcf43823          	sd	a5,-48(s0)
    1a5e:	fc043c23          	sd	zero,-40(s0)
  char buf[3];

  unlink("echo-ok");
    1a62:	00007517          	auipc	a0,0x7
    1a66:	c9e50513          	addi	a0,a0,-866 # 8700 <malloc+0x99c>
    1a6a:	00006097          	auipc	ra,0x6
    1a6e:	bf8080e7          	jalr	-1032(ra) # 7662 <unlink>
  pid = fork();
    1a72:	00006097          	auipc	ra,0x6
    1a76:	b98080e7          	jalr	-1128(ra) # 760a <fork>
    1a7a:	87aa                	mv	a5,a0
    1a7c:	fef42623          	sw	a5,-20(s0)
  if(pid < 0) {
    1a80:	fec42783          	lw	a5,-20(s0)
    1a84:	2781                	sext.w	a5,a5
    1a86:	0207d163          	bgez	a5,1aa8 <exectest+0x6e>
     printf("%s: fork failed\n", s);
    1a8a:	fb843583          	ld	a1,-72(s0)
    1a8e:	00007517          	auipc	a0,0x7
    1a92:	85250513          	addi	a0,a0,-1966 # 82e0 <malloc+0x57c>
    1a96:	00006097          	auipc	ra,0x6
    1a9a:	0dc080e7          	jalr	220(ra) # 7b72 <printf>
     exit(1);
    1a9e:	4505                	li	a0,1
    1aa0:	00006097          	auipc	ra,0x6
    1aa4:	b72080e7          	jalr	-1166(ra) # 7612 <exit>
  }
  if(pid == 0) {
    1aa8:	fec42783          	lw	a5,-20(s0)
    1aac:	2781                	sext.w	a5,a5
    1aae:	ebd5                	bnez	a5,1b62 <exectest+0x128>
    close(1);
    1ab0:	4505                	li	a0,1
    1ab2:	00006097          	auipc	ra,0x6
    1ab6:	b88080e7          	jalr	-1144(ra) # 763a <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1aba:	20100593          	li	a1,513
    1abe:	00007517          	auipc	a0,0x7
    1ac2:	c4250513          	addi	a0,a0,-958 # 8700 <malloc+0x99c>
    1ac6:	00006097          	auipc	ra,0x6
    1aca:	b8c080e7          	jalr	-1140(ra) # 7652 <open>
    1ace:	87aa                	mv	a5,a0
    1ad0:	fef42423          	sw	a5,-24(s0)
    if(fd < 0) {
    1ad4:	fe842783          	lw	a5,-24(s0)
    1ad8:	2781                	sext.w	a5,a5
    1ada:	0207d163          	bgez	a5,1afc <exectest+0xc2>
      printf("%s: create failed\n", s);
    1ade:	fb843583          	ld	a1,-72(s0)
    1ae2:	00007517          	auipc	a0,0x7
    1ae6:	c2650513          	addi	a0,a0,-986 # 8708 <malloc+0x9a4>
    1aea:	00006097          	auipc	ra,0x6
    1aee:	088080e7          	jalr	136(ra) # 7b72 <printf>
      exit(1);
    1af2:	4505                	li	a0,1
    1af4:	00006097          	auipc	ra,0x6
    1af8:	b1e080e7          	jalr	-1250(ra) # 7612 <exit>
    }
    if(fd != 1) {
    1afc:	fe842783          	lw	a5,-24(s0)
    1b00:	0007871b          	sext.w	a4,a5
    1b04:	4785                	li	a5,1
    1b06:	02f70163          	beq	a4,a5,1b28 <exectest+0xee>
      printf("%s: wrong fd\n", s);
    1b0a:	fb843583          	ld	a1,-72(s0)
    1b0e:	00007517          	auipc	a0,0x7
    1b12:	c1250513          	addi	a0,a0,-1006 # 8720 <malloc+0x9bc>
    1b16:	00006097          	auipc	ra,0x6
    1b1a:	05c080e7          	jalr	92(ra) # 7b72 <printf>
      exit(1);
    1b1e:	4505                	li	a0,1
    1b20:	00006097          	auipc	ra,0x6
    1b24:	af2080e7          	jalr	-1294(ra) # 7612 <exit>
    }
    if(exec("echo", echoargv) < 0){
    1b28:	fc840793          	addi	a5,s0,-56
    1b2c:	85be                	mv	a1,a5
    1b2e:	00006517          	auipc	a0,0x6
    1b32:	59250513          	addi	a0,a0,1426 # 80c0 <malloc+0x35c>
    1b36:	00006097          	auipc	ra,0x6
    1b3a:	b14080e7          	jalr	-1260(ra) # 764a <exec>
    1b3e:	87aa                	mv	a5,a0
    1b40:	0207d163          	bgez	a5,1b62 <exectest+0x128>
      printf("%s: exec echo failed\n", s);
    1b44:	fb843583          	ld	a1,-72(s0)
    1b48:	00007517          	auipc	a0,0x7
    1b4c:	be850513          	addi	a0,a0,-1048 # 8730 <malloc+0x9cc>
    1b50:	00006097          	auipc	ra,0x6
    1b54:	022080e7          	jalr	34(ra) # 7b72 <printf>
      exit(1);
    1b58:	4505                	li	a0,1
    1b5a:	00006097          	auipc	ra,0x6
    1b5e:	ab8080e7          	jalr	-1352(ra) # 7612 <exit>
    }
    // won't get to here
  }
  if (wait(&xstatus) != pid) {
    1b62:	fe440793          	addi	a5,s0,-28
    1b66:	853e                	mv	a0,a5
    1b68:	00006097          	auipc	ra,0x6
    1b6c:	ab2080e7          	jalr	-1358(ra) # 761a <wait>
    1b70:	87aa                	mv	a5,a0
    1b72:	873e                	mv	a4,a5
    1b74:	fec42783          	lw	a5,-20(s0)
    1b78:	2781                	sext.w	a5,a5
    1b7a:	00e78c63          	beq	a5,a4,1b92 <exectest+0x158>
    printf("%s: wait failed!\n", s);
    1b7e:	fb843583          	ld	a1,-72(s0)
    1b82:	00007517          	auipc	a0,0x7
    1b86:	bc650513          	addi	a0,a0,-1082 # 8748 <malloc+0x9e4>
    1b8a:	00006097          	auipc	ra,0x6
    1b8e:	fe8080e7          	jalr	-24(ra) # 7b72 <printf>
  }
  if(xstatus != 0)
    1b92:	fe442783          	lw	a5,-28(s0)
    1b96:	cb81                	beqz	a5,1ba6 <exectest+0x16c>
    exit(xstatus);
    1b98:	fe442783          	lw	a5,-28(s0)
    1b9c:	853e                	mv	a0,a5
    1b9e:	00006097          	auipc	ra,0x6
    1ba2:	a74080e7          	jalr	-1420(ra) # 7612 <exit>

  fd = open("echo-ok", O_RDONLY);
    1ba6:	4581                	li	a1,0
    1ba8:	00007517          	auipc	a0,0x7
    1bac:	b5850513          	addi	a0,a0,-1192 # 8700 <malloc+0x99c>
    1bb0:	00006097          	auipc	ra,0x6
    1bb4:	aa2080e7          	jalr	-1374(ra) # 7652 <open>
    1bb8:	87aa                	mv	a5,a0
    1bba:	fef42423          	sw	a5,-24(s0)
  if(fd < 0) {
    1bbe:	fe842783          	lw	a5,-24(s0)
    1bc2:	2781                	sext.w	a5,a5
    1bc4:	0207d163          	bgez	a5,1be6 <exectest+0x1ac>
    printf("%s: open failed\n", s);
    1bc8:	fb843583          	ld	a1,-72(s0)
    1bcc:	00006517          	auipc	a0,0x6
    1bd0:	72c50513          	addi	a0,a0,1836 # 82f8 <malloc+0x594>
    1bd4:	00006097          	auipc	ra,0x6
    1bd8:	f9e080e7          	jalr	-98(ra) # 7b72 <printf>
    exit(1);
    1bdc:	4505                	li	a0,1
    1bde:	00006097          	auipc	ra,0x6
    1be2:	a34080e7          	jalr	-1484(ra) # 7612 <exit>
  }
  if (read(fd, buf, 2) != 2) {
    1be6:	fc040713          	addi	a4,s0,-64
    1bea:	fe842783          	lw	a5,-24(s0)
    1bee:	4609                	li	a2,2
    1bf0:	85ba                	mv	a1,a4
    1bf2:	853e                	mv	a0,a5
    1bf4:	00006097          	auipc	ra,0x6
    1bf8:	a36080e7          	jalr	-1482(ra) # 762a <read>
    1bfc:	87aa                	mv	a5,a0
    1bfe:	873e                	mv	a4,a5
    1c00:	4789                	li	a5,2
    1c02:	02f70163          	beq	a4,a5,1c24 <exectest+0x1ea>
    printf("%s: read failed\n", s);
    1c06:	fb843583          	ld	a1,-72(s0)
    1c0a:	00007517          	auipc	a0,0x7
    1c0e:	96e50513          	addi	a0,a0,-1682 # 8578 <malloc+0x814>
    1c12:	00006097          	auipc	ra,0x6
    1c16:	f60080e7          	jalr	-160(ra) # 7b72 <printf>
    exit(1);
    1c1a:	4505                	li	a0,1
    1c1c:	00006097          	auipc	ra,0x6
    1c20:	9f6080e7          	jalr	-1546(ra) # 7612 <exit>
  }
  unlink("echo-ok");
    1c24:	00007517          	auipc	a0,0x7
    1c28:	adc50513          	addi	a0,a0,-1316 # 8700 <malloc+0x99c>
    1c2c:	00006097          	auipc	ra,0x6
    1c30:	a36080e7          	jalr	-1482(ra) # 7662 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1c34:	fc044783          	lbu	a5,-64(s0)
    1c38:	873e                	mv	a4,a5
    1c3a:	04f00793          	li	a5,79
    1c3e:	00f71e63          	bne	a4,a5,1c5a <exectest+0x220>
    1c42:	fc144783          	lbu	a5,-63(s0)
    1c46:	873e                	mv	a4,a5
    1c48:	04b00793          	li	a5,75
    1c4c:	00f71763          	bne	a4,a5,1c5a <exectest+0x220>
    exit(0);
    1c50:	4501                	li	a0,0
    1c52:	00006097          	auipc	ra,0x6
    1c56:	9c0080e7          	jalr	-1600(ra) # 7612 <exit>
  else {
    printf("%s: wrong output\n", s);
    1c5a:	fb843583          	ld	a1,-72(s0)
    1c5e:	00007517          	auipc	a0,0x7
    1c62:	b0250513          	addi	a0,a0,-1278 # 8760 <malloc+0x9fc>
    1c66:	00006097          	auipc	ra,0x6
    1c6a:	f0c080e7          	jalr	-244(ra) # 7b72 <printf>
    exit(1);
    1c6e:	4505                	li	a0,1
    1c70:	00006097          	auipc	ra,0x6
    1c74:	9a2080e7          	jalr	-1630(ra) # 7612 <exit>

0000000000001c78 <pipe1>:

// simple fork and pipe read/write

void
pipe1(char *s)
{
    1c78:	715d                	addi	sp,sp,-80
    1c7a:	e486                	sd	ra,72(sp)
    1c7c:	e0a2                	sd	s0,64(sp)
    1c7e:	0880                	addi	s0,sp,80
    1c80:	faa43c23          	sd	a0,-72(s0)
  int fds[2], pid, xstatus;
  int seq, i, n, cc, total;
  enum { N=5, SZ=1033 };

  if(pipe(fds) != 0){
    1c84:	fd040793          	addi	a5,s0,-48
    1c88:	853e                	mv	a0,a5
    1c8a:	00006097          	auipc	ra,0x6
    1c8e:	998080e7          	jalr	-1640(ra) # 7622 <pipe>
    1c92:	87aa                	mv	a5,a0
    1c94:	c385                	beqz	a5,1cb4 <pipe1+0x3c>
    printf("%s: pipe() failed\n", s);
    1c96:	fb843583          	ld	a1,-72(s0)
    1c9a:	00007517          	auipc	a0,0x7
    1c9e:	ade50513          	addi	a0,a0,-1314 # 8778 <malloc+0xa14>
    1ca2:	00006097          	auipc	ra,0x6
    1ca6:	ed0080e7          	jalr	-304(ra) # 7b72 <printf>
    exit(1);
    1caa:	4505                	li	a0,1
    1cac:	00006097          	auipc	ra,0x6
    1cb0:	966080e7          	jalr	-1690(ra) # 7612 <exit>
  }
  pid = fork();
    1cb4:	00006097          	auipc	ra,0x6
    1cb8:	956080e7          	jalr	-1706(ra) # 760a <fork>
    1cbc:	87aa                	mv	a5,a0
    1cbe:	fcf42c23          	sw	a5,-40(s0)
  seq = 0;
    1cc2:	fe042623          	sw	zero,-20(s0)
  if(pid == 0){
    1cc6:	fd842783          	lw	a5,-40(s0)
    1cca:	2781                	sext.w	a5,a5
    1ccc:	efdd                	bnez	a5,1d8a <pipe1+0x112>
    close(fds[0]);
    1cce:	fd042783          	lw	a5,-48(s0)
    1cd2:	853e                	mv	a0,a5
    1cd4:	00006097          	auipc	ra,0x6
    1cd8:	966080e7          	jalr	-1690(ra) # 763a <close>
    for(n = 0; n < N; n++){
    1cdc:	fe042223          	sw	zero,-28(s0)
    1ce0:	a849                	j	1d72 <pipe1+0xfa>
      for(i = 0; i < SZ; i++)
    1ce2:	fe042423          	sw	zero,-24(s0)
    1ce6:	a03d                	j	1d14 <pipe1+0x9c>
        buf[i] = seq++;
    1ce8:	fec42783          	lw	a5,-20(s0)
    1cec:	0017871b          	addiw	a4,a5,1
    1cf0:	fee42623          	sw	a4,-20(s0)
    1cf4:	0ff7f713          	zext.b	a4,a5
    1cf8:	0000a697          	auipc	a3,0xa
    1cfc:	5e868693          	addi	a3,a3,1512 # c2e0 <buf>
    1d00:	fe842783          	lw	a5,-24(s0)
    1d04:	97b6                	add	a5,a5,a3
    1d06:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1d0a:	fe842783          	lw	a5,-24(s0)
    1d0e:	2785                	addiw	a5,a5,1
    1d10:	fef42423          	sw	a5,-24(s0)
    1d14:	fe842783          	lw	a5,-24(s0)
    1d18:	0007871b          	sext.w	a4,a5
    1d1c:	40800793          	li	a5,1032
    1d20:	fce7d4e3          	bge	a5,a4,1ce8 <pipe1+0x70>
      if(write(fds[1], buf, SZ) != SZ){
    1d24:	fd442783          	lw	a5,-44(s0)
    1d28:	40900613          	li	a2,1033
    1d2c:	0000a597          	auipc	a1,0xa
    1d30:	5b458593          	addi	a1,a1,1460 # c2e0 <buf>
    1d34:	853e                	mv	a0,a5
    1d36:	00006097          	auipc	ra,0x6
    1d3a:	8fc080e7          	jalr	-1796(ra) # 7632 <write>
    1d3e:	87aa                	mv	a5,a0
    1d40:	873e                	mv	a4,a5
    1d42:	40900793          	li	a5,1033
    1d46:	02f70163          	beq	a4,a5,1d68 <pipe1+0xf0>
        printf("%s: pipe1 oops 1\n", s);
    1d4a:	fb843583          	ld	a1,-72(s0)
    1d4e:	00007517          	auipc	a0,0x7
    1d52:	a4250513          	addi	a0,a0,-1470 # 8790 <malloc+0xa2c>
    1d56:	00006097          	auipc	ra,0x6
    1d5a:	e1c080e7          	jalr	-484(ra) # 7b72 <printf>
        exit(1);
    1d5e:	4505                	li	a0,1
    1d60:	00006097          	auipc	ra,0x6
    1d64:	8b2080e7          	jalr	-1870(ra) # 7612 <exit>
    for(n = 0; n < N; n++){
    1d68:	fe442783          	lw	a5,-28(s0)
    1d6c:	2785                	addiw	a5,a5,1
    1d6e:	fef42223          	sw	a5,-28(s0)
    1d72:	fe442783          	lw	a5,-28(s0)
    1d76:	0007871b          	sext.w	a4,a5
    1d7a:	4791                	li	a5,4
    1d7c:	f6e7d3e3          	bge	a5,a4,1ce2 <pipe1+0x6a>
      }
    }
    exit(0);
    1d80:	4501                	li	a0,0
    1d82:	00006097          	auipc	ra,0x6
    1d86:	890080e7          	jalr	-1904(ra) # 7612 <exit>
  } else if(pid > 0){
    1d8a:	fd842783          	lw	a5,-40(s0)
    1d8e:	2781                	sext.w	a5,a5
    1d90:	12f05d63          	blez	a5,1eca <pipe1+0x252>
    close(fds[1]);
    1d94:	fd442783          	lw	a5,-44(s0)
    1d98:	853e                	mv	a0,a5
    1d9a:	00006097          	auipc	ra,0x6
    1d9e:	8a0080e7          	jalr	-1888(ra) # 763a <close>
    total = 0;
    1da2:	fc042e23          	sw	zero,-36(s0)
    cc = 1;
    1da6:	4785                	li	a5,1
    1da8:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1dac:	a859                	j	1e42 <pipe1+0x1ca>
      for(i = 0; i < n; i++){
    1dae:	fe042423          	sw	zero,-24(s0)
    1db2:	a881                	j	1e02 <pipe1+0x18a>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1db4:	0000a717          	auipc	a4,0xa
    1db8:	52c70713          	addi	a4,a4,1324 # c2e0 <buf>
    1dbc:	fe842783          	lw	a5,-24(s0)
    1dc0:	97ba                	add	a5,a5,a4
    1dc2:	0007c783          	lbu	a5,0(a5)
    1dc6:	0007869b          	sext.w	a3,a5
    1dca:	fec42783          	lw	a5,-20(s0)
    1dce:	0017871b          	addiw	a4,a5,1
    1dd2:	fee42623          	sw	a4,-20(s0)
    1dd6:	0ff7f793          	zext.b	a5,a5
    1dda:	2781                	sext.w	a5,a5
    1ddc:	8736                	mv	a4,a3
    1dde:	00f70d63          	beq	a4,a5,1df8 <pipe1+0x180>
          printf("%s: pipe1 oops 2\n", s);
    1de2:	fb843583          	ld	a1,-72(s0)
    1de6:	00007517          	auipc	a0,0x7
    1dea:	9c250513          	addi	a0,a0,-1598 # 87a8 <malloc+0xa44>
    1dee:	00006097          	auipc	ra,0x6
    1df2:	d84080e7          	jalr	-636(ra) # 7b72 <printf>
          return;
    1df6:	a8cd                	j	1ee8 <pipe1+0x270>
      for(i = 0; i < n; i++){
    1df8:	fe842783          	lw	a5,-24(s0)
    1dfc:	2785                	addiw	a5,a5,1
    1dfe:	fef42423          	sw	a5,-24(s0)
    1e02:	fe842783          	lw	a5,-24(s0)
    1e06:	873e                	mv	a4,a5
    1e08:	fe442783          	lw	a5,-28(s0)
    1e0c:	2701                	sext.w	a4,a4
    1e0e:	2781                	sext.w	a5,a5
    1e10:	faf742e3          	blt	a4,a5,1db4 <pipe1+0x13c>
        }
      }
      total += n;
    1e14:	fdc42783          	lw	a5,-36(s0)
    1e18:	873e                	mv	a4,a5
    1e1a:	fe442783          	lw	a5,-28(s0)
    1e1e:	9fb9                	addw	a5,a5,a4
    1e20:	fcf42e23          	sw	a5,-36(s0)
      cc = cc * 2;
    1e24:	fe042783          	lw	a5,-32(s0)
    1e28:	0017979b          	slliw	a5,a5,0x1
    1e2c:	fef42023          	sw	a5,-32(s0)
      if(cc > sizeof(buf))
    1e30:	fe042783          	lw	a5,-32(s0)
    1e34:	873e                	mv	a4,a5
    1e36:	678d                	lui	a5,0x3
    1e38:	00e7f563          	bgeu	a5,a4,1e42 <pipe1+0x1ca>
        cc = sizeof(buf);
    1e3c:	678d                	lui	a5,0x3
    1e3e:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1e42:	fd042783          	lw	a5,-48(s0)
    1e46:	fe042703          	lw	a4,-32(s0)
    1e4a:	863a                	mv	a2,a4
    1e4c:	0000a597          	auipc	a1,0xa
    1e50:	49458593          	addi	a1,a1,1172 # c2e0 <buf>
    1e54:	853e                	mv	a0,a5
    1e56:	00005097          	auipc	ra,0x5
    1e5a:	7d4080e7          	jalr	2004(ra) # 762a <read>
    1e5e:	87aa                	mv	a5,a0
    1e60:	fef42223          	sw	a5,-28(s0)
    1e64:	fe442783          	lw	a5,-28(s0)
    1e68:	2781                	sext.w	a5,a5
    1e6a:	f4f042e3          	bgtz	a5,1dae <pipe1+0x136>
    }
    if(total != N * SZ){
    1e6e:	fdc42783          	lw	a5,-36(s0)
    1e72:	0007871b          	sext.w	a4,a5
    1e76:	6785                	lui	a5,0x1
    1e78:	42d78793          	addi	a5,a5,1069 # 142d <opentest+0x6f>
    1e7c:	02f70263          	beq	a4,a5,1ea0 <pipe1+0x228>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1e80:	fdc42783          	lw	a5,-36(s0)
    1e84:	85be                	mv	a1,a5
    1e86:	00007517          	auipc	a0,0x7
    1e8a:	93a50513          	addi	a0,a0,-1734 # 87c0 <malloc+0xa5c>
    1e8e:	00006097          	auipc	ra,0x6
    1e92:	ce4080e7          	jalr	-796(ra) # 7b72 <printf>
      exit(1);
    1e96:	4505                	li	a0,1
    1e98:	00005097          	auipc	ra,0x5
    1e9c:	77a080e7          	jalr	1914(ra) # 7612 <exit>
    }
    close(fds[0]);
    1ea0:	fd042783          	lw	a5,-48(s0)
    1ea4:	853e                	mv	a0,a5
    1ea6:	00005097          	auipc	ra,0x5
    1eaa:	794080e7          	jalr	1940(ra) # 763a <close>
    wait(&xstatus);
    1eae:	fcc40793          	addi	a5,s0,-52
    1eb2:	853e                	mv	a0,a5
    1eb4:	00005097          	auipc	ra,0x5
    1eb8:	766080e7          	jalr	1894(ra) # 761a <wait>
    exit(xstatus);
    1ebc:	fcc42783          	lw	a5,-52(s0)
    1ec0:	853e                	mv	a0,a5
    1ec2:	00005097          	auipc	ra,0x5
    1ec6:	750080e7          	jalr	1872(ra) # 7612 <exit>
  } else {
    printf("%s: fork() failed\n", s);
    1eca:	fb843583          	ld	a1,-72(s0)
    1ece:	00007517          	auipc	a0,0x7
    1ed2:	91250513          	addi	a0,a0,-1774 # 87e0 <malloc+0xa7c>
    1ed6:	00006097          	auipc	ra,0x6
    1eda:	c9c080e7          	jalr	-868(ra) # 7b72 <printf>
    exit(1);
    1ede:	4505                	li	a0,1
    1ee0:	00005097          	auipc	ra,0x5
    1ee4:	732080e7          	jalr	1842(ra) # 7612 <exit>
  }
}
    1ee8:	60a6                	ld	ra,72(sp)
    1eea:	6406                	ld	s0,64(sp)
    1eec:	6161                	addi	sp,sp,80
    1eee:	8082                	ret

0000000000001ef0 <killstatus>:


// test if child is killed (status = -1)
void
killstatus(char *s)
{
    1ef0:	7179                	addi	sp,sp,-48
    1ef2:	f406                	sd	ra,40(sp)
    1ef4:	f022                	sd	s0,32(sp)
    1ef6:	1800                	addi	s0,sp,48
    1ef8:	fca43c23          	sd	a0,-40(s0)
  int xst;

  for(int i = 0; i < 100; i++){
    1efc:	fe042623          	sw	zero,-20(s0)
    1f00:	a055                	j	1fa4 <killstatus+0xb4>
    int pid1 = fork();
    1f02:	00005097          	auipc	ra,0x5
    1f06:	708080e7          	jalr	1800(ra) # 760a <fork>
    1f0a:	87aa                	mv	a5,a0
    1f0c:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    1f10:	fe842783          	lw	a5,-24(s0)
    1f14:	2781                	sext.w	a5,a5
    1f16:	0207d163          	bgez	a5,1f38 <killstatus+0x48>
      printf("%s: fork failed\n", s);
    1f1a:	fd843583          	ld	a1,-40(s0)
    1f1e:	00006517          	auipc	a0,0x6
    1f22:	3c250513          	addi	a0,a0,962 # 82e0 <malloc+0x57c>
    1f26:	00006097          	auipc	ra,0x6
    1f2a:	c4c080e7          	jalr	-948(ra) # 7b72 <printf>
      exit(1);
    1f2e:	4505                	li	a0,1
    1f30:	00005097          	auipc	ra,0x5
    1f34:	6e2080e7          	jalr	1762(ra) # 7612 <exit>
    }
    if(pid1 == 0){
    1f38:	fe842783          	lw	a5,-24(s0)
    1f3c:	2781                	sext.w	a5,a5
    1f3e:	e791                	bnez	a5,1f4a <killstatus+0x5a>
      while(1) {
        getpid();
    1f40:	00005097          	auipc	ra,0x5
    1f44:	752080e7          	jalr	1874(ra) # 7692 <getpid>
    1f48:	bfe5                	j	1f40 <killstatus+0x50>
      }
      exit(0);
    }
    sleep(1);
    1f4a:	4505                	li	a0,1
    1f4c:	00005097          	auipc	ra,0x5
    1f50:	756080e7          	jalr	1878(ra) # 76a2 <sleep>
    kill(pid1);
    1f54:	fe842783          	lw	a5,-24(s0)
    1f58:	853e                	mv	a0,a5
    1f5a:	00005097          	auipc	ra,0x5
    1f5e:	6e8080e7          	jalr	1768(ra) # 7642 <kill>
    wait(&xst);
    1f62:	fe440793          	addi	a5,s0,-28
    1f66:	853e                	mv	a0,a5
    1f68:	00005097          	auipc	ra,0x5
    1f6c:	6b2080e7          	jalr	1714(ra) # 761a <wait>
    if(xst != -1) {
    1f70:	fe442783          	lw	a5,-28(s0)
    1f74:	873e                	mv	a4,a5
    1f76:	57fd                	li	a5,-1
    1f78:	02f70163          	beq	a4,a5,1f9a <killstatus+0xaa>
       printf("%s: status should be -1\n", s);
    1f7c:	fd843583          	ld	a1,-40(s0)
    1f80:	00007517          	auipc	a0,0x7
    1f84:	87850513          	addi	a0,a0,-1928 # 87f8 <malloc+0xa94>
    1f88:	00006097          	auipc	ra,0x6
    1f8c:	bea080e7          	jalr	-1046(ra) # 7b72 <printf>
       exit(1);
    1f90:	4505                	li	a0,1
    1f92:	00005097          	auipc	ra,0x5
    1f96:	680080e7          	jalr	1664(ra) # 7612 <exit>
  for(int i = 0; i < 100; i++){
    1f9a:	fec42783          	lw	a5,-20(s0)
    1f9e:	2785                	addiw	a5,a5,1
    1fa0:	fef42623          	sw	a5,-20(s0)
    1fa4:	fec42783          	lw	a5,-20(s0)
    1fa8:	0007871b          	sext.w	a4,a5
    1fac:	06300793          	li	a5,99
    1fb0:	f4e7d9e3          	bge	a5,a4,1f02 <killstatus+0x12>
    }
  }
  exit(0);
    1fb4:	4501                	li	a0,0
    1fb6:	00005097          	auipc	ra,0x5
    1fba:	65c080e7          	jalr	1628(ra) # 7612 <exit>

0000000000001fbe <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(char *s)
{
    1fbe:	7139                	addi	sp,sp,-64
    1fc0:	fc06                	sd	ra,56(sp)
    1fc2:	f822                	sd	s0,48(sp)
    1fc4:	0080                	addi	s0,sp,64
    1fc6:	fca43423          	sd	a0,-56(s0)
  int pid1, pid2, pid3;
  int pfds[2];

  pid1 = fork();
    1fca:	00005097          	auipc	ra,0x5
    1fce:	640080e7          	jalr	1600(ra) # 760a <fork>
    1fd2:	87aa                	mv	a5,a0
    1fd4:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0) {
    1fd8:	fec42783          	lw	a5,-20(s0)
    1fdc:	2781                	sext.w	a5,a5
    1fde:	0207d163          	bgez	a5,2000 <preempt+0x42>
    printf("%s: fork failed", s);
    1fe2:	fc843583          	ld	a1,-56(s0)
    1fe6:	00007517          	auipc	a0,0x7
    1fea:	83250513          	addi	a0,a0,-1998 # 8818 <malloc+0xab4>
    1fee:	00006097          	auipc	ra,0x6
    1ff2:	b84080e7          	jalr	-1148(ra) # 7b72 <printf>
    exit(1);
    1ff6:	4505                	li	a0,1
    1ff8:	00005097          	auipc	ra,0x5
    1ffc:	61a080e7          	jalr	1562(ra) # 7612 <exit>
  }
  if(pid1 == 0)
    2000:	fec42783          	lw	a5,-20(s0)
    2004:	2781                	sext.w	a5,a5
    2006:	e399                	bnez	a5,200c <preempt+0x4e>
    for(;;)
    2008:	0001                	nop
    200a:	bffd                	j	2008 <preempt+0x4a>
      ;

  pid2 = fork();
    200c:	00005097          	auipc	ra,0x5
    2010:	5fe080e7          	jalr	1534(ra) # 760a <fork>
    2014:	87aa                	mv	a5,a0
    2016:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0) {
    201a:	fe842783          	lw	a5,-24(s0)
    201e:	2781                	sext.w	a5,a5
    2020:	0207d163          	bgez	a5,2042 <preempt+0x84>
    printf("%s: fork failed\n", s);
    2024:	fc843583          	ld	a1,-56(s0)
    2028:	00006517          	auipc	a0,0x6
    202c:	2b850513          	addi	a0,a0,696 # 82e0 <malloc+0x57c>
    2030:	00006097          	auipc	ra,0x6
    2034:	b42080e7          	jalr	-1214(ra) # 7b72 <printf>
    exit(1);
    2038:	4505                	li	a0,1
    203a:	00005097          	auipc	ra,0x5
    203e:	5d8080e7          	jalr	1496(ra) # 7612 <exit>
  }
  if(pid2 == 0)
    2042:	fe842783          	lw	a5,-24(s0)
    2046:	2781                	sext.w	a5,a5
    2048:	e399                	bnez	a5,204e <preempt+0x90>
    for(;;)
    204a:	0001                	nop
    204c:	bffd                	j	204a <preempt+0x8c>
      ;

  pipe(pfds);
    204e:	fd840793          	addi	a5,s0,-40
    2052:	853e                	mv	a0,a5
    2054:	00005097          	auipc	ra,0x5
    2058:	5ce080e7          	jalr	1486(ra) # 7622 <pipe>
  pid3 = fork();
    205c:	00005097          	auipc	ra,0x5
    2060:	5ae080e7          	jalr	1454(ra) # 760a <fork>
    2064:	87aa                	mv	a5,a0
    2066:	fef42223          	sw	a5,-28(s0)
  if(pid3 < 0) {
    206a:	fe442783          	lw	a5,-28(s0)
    206e:	2781                	sext.w	a5,a5
    2070:	0207d163          	bgez	a5,2092 <preempt+0xd4>
     printf("%s: fork failed\n", s);
    2074:	fc843583          	ld	a1,-56(s0)
    2078:	00006517          	auipc	a0,0x6
    207c:	26850513          	addi	a0,a0,616 # 82e0 <malloc+0x57c>
    2080:	00006097          	auipc	ra,0x6
    2084:	af2080e7          	jalr	-1294(ra) # 7b72 <printf>
     exit(1);
    2088:	4505                	li	a0,1
    208a:	00005097          	auipc	ra,0x5
    208e:	588080e7          	jalr	1416(ra) # 7612 <exit>
  }
  if(pid3 == 0){
    2092:	fe442783          	lw	a5,-28(s0)
    2096:	2781                	sext.w	a5,a5
    2098:	efa1                	bnez	a5,20f0 <preempt+0x132>
    close(pfds[0]);
    209a:	fd842783          	lw	a5,-40(s0)
    209e:	853e                	mv	a0,a5
    20a0:	00005097          	auipc	ra,0x5
    20a4:	59a080e7          	jalr	1434(ra) # 763a <close>
    if(write(pfds[1], "x", 1) != 1)
    20a8:	fdc42783          	lw	a5,-36(s0)
    20ac:	4605                	li	a2,1
    20ae:	00006597          	auipc	a1,0x6
    20b2:	f0258593          	addi	a1,a1,-254 # 7fb0 <malloc+0x24c>
    20b6:	853e                	mv	a0,a5
    20b8:	00005097          	auipc	ra,0x5
    20bc:	57a080e7          	jalr	1402(ra) # 7632 <write>
    20c0:	87aa                	mv	a5,a0
    20c2:	873e                	mv	a4,a5
    20c4:	4785                	li	a5,1
    20c6:	00f70c63          	beq	a4,a5,20de <preempt+0x120>
      printf("%s: preempt write error", s);
    20ca:	fc843583          	ld	a1,-56(s0)
    20ce:	00006517          	auipc	a0,0x6
    20d2:	75a50513          	addi	a0,a0,1882 # 8828 <malloc+0xac4>
    20d6:	00006097          	auipc	ra,0x6
    20da:	a9c080e7          	jalr	-1380(ra) # 7b72 <printf>
    close(pfds[1]);
    20de:	fdc42783          	lw	a5,-36(s0)
    20e2:	853e                	mv	a0,a5
    20e4:	00005097          	auipc	ra,0x5
    20e8:	556080e7          	jalr	1366(ra) # 763a <close>
    for(;;)
    20ec:	0001                	nop
    20ee:	bffd                	j	20ec <preempt+0x12e>
      ;
  }

  close(pfds[1]);
    20f0:	fdc42783          	lw	a5,-36(s0)
    20f4:	853e                	mv	a0,a5
    20f6:	00005097          	auipc	ra,0x5
    20fa:	544080e7          	jalr	1348(ra) # 763a <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    20fe:	fd842783          	lw	a5,-40(s0)
    2102:	660d                	lui	a2,0x3
    2104:	0000a597          	auipc	a1,0xa
    2108:	1dc58593          	addi	a1,a1,476 # c2e0 <buf>
    210c:	853e                	mv	a0,a5
    210e:	00005097          	auipc	ra,0x5
    2112:	51c080e7          	jalr	1308(ra) # 762a <read>
    2116:	87aa                	mv	a5,a0
    2118:	873e                	mv	a4,a5
    211a:	4785                	li	a5,1
    211c:	00f70d63          	beq	a4,a5,2136 <preempt+0x178>
    printf("%s: preempt read error", s);
    2120:	fc843583          	ld	a1,-56(s0)
    2124:	00006517          	auipc	a0,0x6
    2128:	71c50513          	addi	a0,a0,1820 # 8840 <malloc+0xadc>
    212c:	00006097          	auipc	ra,0x6
    2130:	a46080e7          	jalr	-1466(ra) # 7b72 <printf>
    2134:	a8a5                	j	21ac <preempt+0x1ee>
    return;
  }
  close(pfds[0]);
    2136:	fd842783          	lw	a5,-40(s0)
    213a:	853e                	mv	a0,a5
    213c:	00005097          	auipc	ra,0x5
    2140:	4fe080e7          	jalr	1278(ra) # 763a <close>
  printf("kill... ");
    2144:	00006517          	auipc	a0,0x6
    2148:	71450513          	addi	a0,a0,1812 # 8858 <malloc+0xaf4>
    214c:	00006097          	auipc	ra,0x6
    2150:	a26080e7          	jalr	-1498(ra) # 7b72 <printf>
  kill(pid1);
    2154:	fec42783          	lw	a5,-20(s0)
    2158:	853e                	mv	a0,a5
    215a:	00005097          	auipc	ra,0x5
    215e:	4e8080e7          	jalr	1256(ra) # 7642 <kill>
  kill(pid2);
    2162:	fe842783          	lw	a5,-24(s0)
    2166:	853e                	mv	a0,a5
    2168:	00005097          	auipc	ra,0x5
    216c:	4da080e7          	jalr	1242(ra) # 7642 <kill>
  kill(pid3);
    2170:	fe442783          	lw	a5,-28(s0)
    2174:	853e                	mv	a0,a5
    2176:	00005097          	auipc	ra,0x5
    217a:	4cc080e7          	jalr	1228(ra) # 7642 <kill>
  printf("wait... ");
    217e:	00006517          	auipc	a0,0x6
    2182:	6ea50513          	addi	a0,a0,1770 # 8868 <malloc+0xb04>
    2186:	00006097          	auipc	ra,0x6
    218a:	9ec080e7          	jalr	-1556(ra) # 7b72 <printf>
  wait(0);
    218e:	4501                	li	a0,0
    2190:	00005097          	auipc	ra,0x5
    2194:	48a080e7          	jalr	1162(ra) # 761a <wait>
  wait(0);
    2198:	4501                	li	a0,0
    219a:	00005097          	auipc	ra,0x5
    219e:	480080e7          	jalr	1152(ra) # 761a <wait>
  wait(0);
    21a2:	4501                	li	a0,0
    21a4:	00005097          	auipc	ra,0x5
    21a8:	476080e7          	jalr	1142(ra) # 761a <wait>
}
    21ac:	70e2                	ld	ra,56(sp)
    21ae:	7442                	ld	s0,48(sp)
    21b0:	6121                	addi	sp,sp,64
    21b2:	8082                	ret

00000000000021b4 <exitwait>:

// try to find any races between exit and wait
void
exitwait(char *s)
{
    21b4:	7179                	addi	sp,sp,-48
    21b6:	f406                	sd	ra,40(sp)
    21b8:	f022                	sd	s0,32(sp)
    21ba:	1800                	addi	s0,sp,48
    21bc:	fca43c23          	sd	a0,-40(s0)
  int i, pid;

  for(i = 0; i < 100; i++){
    21c0:	fe042623          	sw	zero,-20(s0)
    21c4:	a87d                	j	2282 <exitwait+0xce>
    pid = fork();
    21c6:	00005097          	auipc	ra,0x5
    21ca:	444080e7          	jalr	1092(ra) # 760a <fork>
    21ce:	87aa                	mv	a5,a0
    21d0:	fef42423          	sw	a5,-24(s0)
    if(pid < 0){
    21d4:	fe842783          	lw	a5,-24(s0)
    21d8:	2781                	sext.w	a5,a5
    21da:	0207d163          	bgez	a5,21fc <exitwait+0x48>
      printf("%s: fork failed\n", s);
    21de:	fd843583          	ld	a1,-40(s0)
    21e2:	00006517          	auipc	a0,0x6
    21e6:	0fe50513          	addi	a0,a0,254 # 82e0 <malloc+0x57c>
    21ea:	00006097          	auipc	ra,0x6
    21ee:	988080e7          	jalr	-1656(ra) # 7b72 <printf>
      exit(1);
    21f2:	4505                	li	a0,1
    21f4:	00005097          	auipc	ra,0x5
    21f8:	41e080e7          	jalr	1054(ra) # 7612 <exit>
    }
    if(pid){
    21fc:	fe842783          	lw	a5,-24(s0)
    2200:	2781                	sext.w	a5,a5
    2202:	c7a5                	beqz	a5,226a <exitwait+0xb6>
      int xstate;
      if(wait(&xstate) != pid){
    2204:	fe440793          	addi	a5,s0,-28
    2208:	853e                	mv	a0,a5
    220a:	00005097          	auipc	ra,0x5
    220e:	410080e7          	jalr	1040(ra) # 761a <wait>
    2212:	87aa                	mv	a5,a0
    2214:	873e                	mv	a4,a5
    2216:	fe842783          	lw	a5,-24(s0)
    221a:	2781                	sext.w	a5,a5
    221c:	02e78163          	beq	a5,a4,223e <exitwait+0x8a>
        printf("%s: wait wrong pid\n", s);
    2220:	fd843583          	ld	a1,-40(s0)
    2224:	00006517          	auipc	a0,0x6
    2228:	65450513          	addi	a0,a0,1620 # 8878 <malloc+0xb14>
    222c:	00006097          	auipc	ra,0x6
    2230:	946080e7          	jalr	-1722(ra) # 7b72 <printf>
        exit(1);
    2234:	4505                	li	a0,1
    2236:	00005097          	auipc	ra,0x5
    223a:	3dc080e7          	jalr	988(ra) # 7612 <exit>
      }
      if(i != xstate) {
    223e:	fe442703          	lw	a4,-28(s0)
    2242:	fec42783          	lw	a5,-20(s0)
    2246:	2781                	sext.w	a5,a5
    2248:	02e78863          	beq	a5,a4,2278 <exitwait+0xc4>
        printf("%s: wait wrong exit status\n", s);
    224c:	fd843583          	ld	a1,-40(s0)
    2250:	00006517          	auipc	a0,0x6
    2254:	64050513          	addi	a0,a0,1600 # 8890 <malloc+0xb2c>
    2258:	00006097          	auipc	ra,0x6
    225c:	91a080e7          	jalr	-1766(ra) # 7b72 <printf>
        exit(1);
    2260:	4505                	li	a0,1
    2262:	00005097          	auipc	ra,0x5
    2266:	3b0080e7          	jalr	944(ra) # 7612 <exit>
      }
    } else {
      exit(i);
    226a:	fec42783          	lw	a5,-20(s0)
    226e:	853e                	mv	a0,a5
    2270:	00005097          	auipc	ra,0x5
    2274:	3a2080e7          	jalr	930(ra) # 7612 <exit>
  for(i = 0; i < 100; i++){
    2278:	fec42783          	lw	a5,-20(s0)
    227c:	2785                	addiw	a5,a5,1
    227e:	fef42623          	sw	a5,-20(s0)
    2282:	fec42783          	lw	a5,-20(s0)
    2286:	0007871b          	sext.w	a4,a5
    228a:	06300793          	li	a5,99
    228e:	f2e7dce3          	bge	a5,a4,21c6 <exitwait+0x12>
    }
  }
}
    2292:	0001                	nop
    2294:	0001                	nop
    2296:	70a2                	ld	ra,40(sp)
    2298:	7402                	ld	s0,32(sp)
    229a:	6145                	addi	sp,sp,48
    229c:	8082                	ret

000000000000229e <reparent>:
// try to find races in the reparenting
// code that handles a parent exiting
// when it still has live children.
void
reparent(char *s)
{
    229e:	7179                	addi	sp,sp,-48
    22a0:	f406                	sd	ra,40(sp)
    22a2:	f022                	sd	s0,32(sp)
    22a4:	1800                	addi	s0,sp,48
    22a6:	fca43c23          	sd	a0,-40(s0)
  int master_pid = getpid();
    22aa:	00005097          	auipc	ra,0x5
    22ae:	3e8080e7          	jalr	1000(ra) # 7692 <getpid>
    22b2:	87aa                	mv	a5,a0
    22b4:	fef42423          	sw	a5,-24(s0)
  for(int i = 0; i < 200; i++){
    22b8:	fe042623          	sw	zero,-20(s0)
    22bc:	a86d                	j	2376 <reparent+0xd8>
    int pid = fork();
    22be:	00005097          	auipc	ra,0x5
    22c2:	34c080e7          	jalr	844(ra) # 760a <fork>
    22c6:	87aa                	mv	a5,a0
    22c8:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    22cc:	fe442783          	lw	a5,-28(s0)
    22d0:	2781                	sext.w	a5,a5
    22d2:	0207d163          	bgez	a5,22f4 <reparent+0x56>
      printf("%s: fork failed\n", s);
    22d6:	fd843583          	ld	a1,-40(s0)
    22da:	00006517          	auipc	a0,0x6
    22de:	00650513          	addi	a0,a0,6 # 82e0 <malloc+0x57c>
    22e2:	00006097          	auipc	ra,0x6
    22e6:	890080e7          	jalr	-1904(ra) # 7b72 <printf>
      exit(1);
    22ea:	4505                	li	a0,1
    22ec:	00005097          	auipc	ra,0x5
    22f0:	326080e7          	jalr	806(ra) # 7612 <exit>
    }
    if(pid){
    22f4:	fe442783          	lw	a5,-28(s0)
    22f8:	2781                	sext.w	a5,a5
    22fa:	cf85                	beqz	a5,2332 <reparent+0x94>
      if(wait(0) != pid){
    22fc:	4501                	li	a0,0
    22fe:	00005097          	auipc	ra,0x5
    2302:	31c080e7          	jalr	796(ra) # 761a <wait>
    2306:	87aa                	mv	a5,a0
    2308:	873e                	mv	a4,a5
    230a:	fe442783          	lw	a5,-28(s0)
    230e:	2781                	sext.w	a5,a5
    2310:	04e78e63          	beq	a5,a4,236c <reparent+0xce>
        printf("%s: wait wrong pid\n", s);
    2314:	fd843583          	ld	a1,-40(s0)
    2318:	00006517          	auipc	a0,0x6
    231c:	56050513          	addi	a0,a0,1376 # 8878 <malloc+0xb14>
    2320:	00006097          	auipc	ra,0x6
    2324:	852080e7          	jalr	-1966(ra) # 7b72 <printf>
        exit(1);
    2328:	4505                	li	a0,1
    232a:	00005097          	auipc	ra,0x5
    232e:	2e8080e7          	jalr	744(ra) # 7612 <exit>
      }
    } else {
      int pid2 = fork();
    2332:	00005097          	auipc	ra,0x5
    2336:	2d8080e7          	jalr	728(ra) # 760a <fork>
    233a:	87aa                	mv	a5,a0
    233c:	fef42023          	sw	a5,-32(s0)
      if(pid2 < 0){
    2340:	fe042783          	lw	a5,-32(s0)
    2344:	2781                	sext.w	a5,a5
    2346:	0007de63          	bgez	a5,2362 <reparent+0xc4>
        kill(master_pid);
    234a:	fe842783          	lw	a5,-24(s0)
    234e:	853e                	mv	a0,a5
    2350:	00005097          	auipc	ra,0x5
    2354:	2f2080e7          	jalr	754(ra) # 7642 <kill>
        exit(1);
    2358:	4505                	li	a0,1
    235a:	00005097          	auipc	ra,0x5
    235e:	2b8080e7          	jalr	696(ra) # 7612 <exit>
      }
      exit(0);
    2362:	4501                	li	a0,0
    2364:	00005097          	auipc	ra,0x5
    2368:	2ae080e7          	jalr	686(ra) # 7612 <exit>
  for(int i = 0; i < 200; i++){
    236c:	fec42783          	lw	a5,-20(s0)
    2370:	2785                	addiw	a5,a5,1
    2372:	fef42623          	sw	a5,-20(s0)
    2376:	fec42783          	lw	a5,-20(s0)
    237a:	0007871b          	sext.w	a4,a5
    237e:	0c700793          	li	a5,199
    2382:	f2e7dee3          	bge	a5,a4,22be <reparent+0x20>
    }
  }
  exit(0);
    2386:	4501                	li	a0,0
    2388:	00005097          	auipc	ra,0x5
    238c:	28a080e7          	jalr	650(ra) # 7612 <exit>

0000000000002390 <twochildren>:
}

// what if two children exit() at the same time?
void
twochildren(char *s)
{
    2390:	7179                	addi	sp,sp,-48
    2392:	f406                	sd	ra,40(sp)
    2394:	f022                	sd	s0,32(sp)
    2396:	1800                	addi	s0,sp,48
    2398:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 1000; i++){
    239c:	fe042623          	sw	zero,-20(s0)
    23a0:	a845                	j	2450 <twochildren+0xc0>
    int pid1 = fork();
    23a2:	00005097          	auipc	ra,0x5
    23a6:	268080e7          	jalr	616(ra) # 760a <fork>
    23aa:	87aa                	mv	a5,a0
    23ac:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    23b0:	fe842783          	lw	a5,-24(s0)
    23b4:	2781                	sext.w	a5,a5
    23b6:	0207d163          	bgez	a5,23d8 <twochildren+0x48>
      printf("%s: fork failed\n", s);
    23ba:	fd843583          	ld	a1,-40(s0)
    23be:	00006517          	auipc	a0,0x6
    23c2:	f2250513          	addi	a0,a0,-222 # 82e0 <malloc+0x57c>
    23c6:	00005097          	auipc	ra,0x5
    23ca:	7ac080e7          	jalr	1964(ra) # 7b72 <printf>
      exit(1);
    23ce:	4505                	li	a0,1
    23d0:	00005097          	auipc	ra,0x5
    23d4:	242080e7          	jalr	578(ra) # 7612 <exit>
    }
    if(pid1 == 0){
    23d8:	fe842783          	lw	a5,-24(s0)
    23dc:	2781                	sext.w	a5,a5
    23de:	e791                	bnez	a5,23ea <twochildren+0x5a>
      exit(0);
    23e0:	4501                	li	a0,0
    23e2:	00005097          	auipc	ra,0x5
    23e6:	230080e7          	jalr	560(ra) # 7612 <exit>
    } else {
      int pid2 = fork();
    23ea:	00005097          	auipc	ra,0x5
    23ee:	220080e7          	jalr	544(ra) # 760a <fork>
    23f2:	87aa                	mv	a5,a0
    23f4:	fef42223          	sw	a5,-28(s0)
      if(pid2 < 0){
    23f8:	fe442783          	lw	a5,-28(s0)
    23fc:	2781                	sext.w	a5,a5
    23fe:	0207d163          	bgez	a5,2420 <twochildren+0x90>
        printf("%s: fork failed\n", s);
    2402:	fd843583          	ld	a1,-40(s0)
    2406:	00006517          	auipc	a0,0x6
    240a:	eda50513          	addi	a0,a0,-294 # 82e0 <malloc+0x57c>
    240e:	00005097          	auipc	ra,0x5
    2412:	764080e7          	jalr	1892(ra) # 7b72 <printf>
        exit(1);
    2416:	4505                	li	a0,1
    2418:	00005097          	auipc	ra,0x5
    241c:	1fa080e7          	jalr	506(ra) # 7612 <exit>
      }
      if(pid2 == 0){
    2420:	fe442783          	lw	a5,-28(s0)
    2424:	2781                	sext.w	a5,a5
    2426:	e791                	bnez	a5,2432 <twochildren+0xa2>
        exit(0);
    2428:	4501                	li	a0,0
    242a:	00005097          	auipc	ra,0x5
    242e:	1e8080e7          	jalr	488(ra) # 7612 <exit>
      } else {
        wait(0);
    2432:	4501                	li	a0,0
    2434:	00005097          	auipc	ra,0x5
    2438:	1e6080e7          	jalr	486(ra) # 761a <wait>
        wait(0);
    243c:	4501                	li	a0,0
    243e:	00005097          	auipc	ra,0x5
    2442:	1dc080e7          	jalr	476(ra) # 761a <wait>
  for(int i = 0; i < 1000; i++){
    2446:	fec42783          	lw	a5,-20(s0)
    244a:	2785                	addiw	a5,a5,1
    244c:	fef42623          	sw	a5,-20(s0)
    2450:	fec42783          	lw	a5,-20(s0)
    2454:	0007871b          	sext.w	a4,a5
    2458:	3e700793          	li	a5,999
    245c:	f4e7d3e3          	bge	a5,a4,23a2 <twochildren+0x12>
      }
    }
  }
}
    2460:	0001                	nop
    2462:	0001                	nop
    2464:	70a2                	ld	ra,40(sp)
    2466:	7402                	ld	s0,32(sp)
    2468:	6145                	addi	sp,sp,48
    246a:	8082                	ret

000000000000246c <forkfork>:

// concurrent forks to try to expose locking bugs.
void
forkfork(char *s)
{
    246c:	7139                	addi	sp,sp,-64
    246e:	fc06                	sd	ra,56(sp)
    2470:	f822                	sd	s0,48(sp)
    2472:	0080                	addi	s0,sp,64
    2474:	fca43423          	sd	a0,-56(s0)
  enum { N=2 };

  for(int i = 0; i < N; i++){
    2478:	fe042623          	sw	zero,-20(s0)
    247c:	a84d                	j	252e <forkfork+0xc2>
    int pid = fork();
    247e:	00005097          	auipc	ra,0x5
    2482:	18c080e7          	jalr	396(ra) # 760a <fork>
    2486:	87aa                	mv	a5,a0
    2488:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    248c:	fe042783          	lw	a5,-32(s0)
    2490:	2781                	sext.w	a5,a5
    2492:	0207d163          	bgez	a5,24b4 <forkfork+0x48>
      printf("%s: fork failed", s);
    2496:	fc843583          	ld	a1,-56(s0)
    249a:	00006517          	auipc	a0,0x6
    249e:	37e50513          	addi	a0,a0,894 # 8818 <malloc+0xab4>
    24a2:	00005097          	auipc	ra,0x5
    24a6:	6d0080e7          	jalr	1744(ra) # 7b72 <printf>
      exit(1);
    24aa:	4505                	li	a0,1
    24ac:	00005097          	auipc	ra,0x5
    24b0:	166080e7          	jalr	358(ra) # 7612 <exit>
    }
    if(pid == 0){
    24b4:	fe042783          	lw	a5,-32(s0)
    24b8:	2781                	sext.w	a5,a5
    24ba:	e7ad                	bnez	a5,2524 <forkfork+0xb8>
      for(int j = 0; j < 200; j++){
    24bc:	fe042423          	sw	zero,-24(s0)
    24c0:	a0a9                	j	250a <forkfork+0x9e>
        int pid1 = fork();
    24c2:	00005097          	auipc	ra,0x5
    24c6:	148080e7          	jalr	328(ra) # 760a <fork>
    24ca:	87aa                	mv	a5,a0
    24cc:	fcf42e23          	sw	a5,-36(s0)
        if(pid1 < 0){
    24d0:	fdc42783          	lw	a5,-36(s0)
    24d4:	2781                	sext.w	a5,a5
    24d6:	0007d763          	bgez	a5,24e4 <forkfork+0x78>
          exit(1);
    24da:	4505                	li	a0,1
    24dc:	00005097          	auipc	ra,0x5
    24e0:	136080e7          	jalr	310(ra) # 7612 <exit>
        }
        if(pid1 == 0){
    24e4:	fdc42783          	lw	a5,-36(s0)
    24e8:	2781                	sext.w	a5,a5
    24ea:	e791                	bnez	a5,24f6 <forkfork+0x8a>
          exit(0);
    24ec:	4501                	li	a0,0
    24ee:	00005097          	auipc	ra,0x5
    24f2:	124080e7          	jalr	292(ra) # 7612 <exit>
        }
        wait(0);
    24f6:	4501                	li	a0,0
    24f8:	00005097          	auipc	ra,0x5
    24fc:	122080e7          	jalr	290(ra) # 761a <wait>
      for(int j = 0; j < 200; j++){
    2500:	fe842783          	lw	a5,-24(s0)
    2504:	2785                	addiw	a5,a5,1
    2506:	fef42423          	sw	a5,-24(s0)
    250a:	fe842783          	lw	a5,-24(s0)
    250e:	0007871b          	sext.w	a4,a5
    2512:	0c700793          	li	a5,199
    2516:	fae7d6e3          	bge	a5,a4,24c2 <forkfork+0x56>
      }
      exit(0);
    251a:	4501                	li	a0,0
    251c:	00005097          	auipc	ra,0x5
    2520:	0f6080e7          	jalr	246(ra) # 7612 <exit>
  for(int i = 0; i < N; i++){
    2524:	fec42783          	lw	a5,-20(s0)
    2528:	2785                	addiw	a5,a5,1
    252a:	fef42623          	sw	a5,-20(s0)
    252e:	fec42783          	lw	a5,-20(s0)
    2532:	0007871b          	sext.w	a4,a5
    2536:	4785                	li	a5,1
    2538:	f4e7d3e3          	bge	a5,a4,247e <forkfork+0x12>
    }
  }

  int xstatus;
  for(int i = 0; i < N; i++){
    253c:	fe042223          	sw	zero,-28(s0)
    2540:	a83d                	j	257e <forkfork+0x112>
    wait(&xstatus);
    2542:	fd840793          	addi	a5,s0,-40
    2546:	853e                	mv	a0,a5
    2548:	00005097          	auipc	ra,0x5
    254c:	0d2080e7          	jalr	210(ra) # 761a <wait>
    if(xstatus != 0) {
    2550:	fd842783          	lw	a5,-40(s0)
    2554:	c385                	beqz	a5,2574 <forkfork+0x108>
      printf("%s: fork in child failed", s);
    2556:	fc843583          	ld	a1,-56(s0)
    255a:	00006517          	auipc	a0,0x6
    255e:	35650513          	addi	a0,a0,854 # 88b0 <malloc+0xb4c>
    2562:	00005097          	auipc	ra,0x5
    2566:	610080e7          	jalr	1552(ra) # 7b72 <printf>
      exit(1);
    256a:	4505                	li	a0,1
    256c:	00005097          	auipc	ra,0x5
    2570:	0a6080e7          	jalr	166(ra) # 7612 <exit>
  for(int i = 0; i < N; i++){
    2574:	fe442783          	lw	a5,-28(s0)
    2578:	2785                	addiw	a5,a5,1
    257a:	fef42223          	sw	a5,-28(s0)
    257e:	fe442783          	lw	a5,-28(s0)
    2582:	0007871b          	sext.w	a4,a5
    2586:	4785                	li	a5,1
    2588:	fae7dde3          	bge	a5,a4,2542 <forkfork+0xd6>
    }
  }
}
    258c:	0001                	nop
    258e:	0001                	nop
    2590:	70e2                	ld	ra,56(sp)
    2592:	7442                	ld	s0,48(sp)
    2594:	6121                	addi	sp,sp,64
    2596:	8082                	ret

0000000000002598 <forkforkfork>:

void
forkforkfork(char *s)
{
    2598:	7179                	addi	sp,sp,-48
    259a:	f406                	sd	ra,40(sp)
    259c:	f022                	sd	s0,32(sp)
    259e:	1800                	addi	s0,sp,48
    25a0:	fca43c23          	sd	a0,-40(s0)
  unlink("stopforking");
    25a4:	00006517          	auipc	a0,0x6
    25a8:	32c50513          	addi	a0,a0,812 # 88d0 <malloc+0xb6c>
    25ac:	00005097          	auipc	ra,0x5
    25b0:	0b6080e7          	jalr	182(ra) # 7662 <unlink>

  int pid = fork();
    25b4:	00005097          	auipc	ra,0x5
    25b8:	056080e7          	jalr	86(ra) # 760a <fork>
    25bc:	87aa                	mv	a5,a0
    25be:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    25c2:	fec42783          	lw	a5,-20(s0)
    25c6:	2781                	sext.w	a5,a5
    25c8:	0207d163          	bgez	a5,25ea <forkforkfork+0x52>
    printf("%s: fork failed", s);
    25cc:	fd843583          	ld	a1,-40(s0)
    25d0:	00006517          	auipc	a0,0x6
    25d4:	24850513          	addi	a0,a0,584 # 8818 <malloc+0xab4>
    25d8:	00005097          	auipc	ra,0x5
    25dc:	59a080e7          	jalr	1434(ra) # 7b72 <printf>
    exit(1);
    25e0:	4505                	li	a0,1
    25e2:	00005097          	auipc	ra,0x5
    25e6:	030080e7          	jalr	48(ra) # 7612 <exit>
  }
  if(pid == 0){
    25ea:	fec42783          	lw	a5,-20(s0)
    25ee:	2781                	sext.w	a5,a5
    25f0:	efb9                	bnez	a5,264e <forkforkfork+0xb6>
    while(1){
      int fd = open("stopforking", 0);
    25f2:	4581                	li	a1,0
    25f4:	00006517          	auipc	a0,0x6
    25f8:	2dc50513          	addi	a0,a0,732 # 88d0 <malloc+0xb6c>
    25fc:	00005097          	auipc	ra,0x5
    2600:	056080e7          	jalr	86(ra) # 7652 <open>
    2604:	87aa                	mv	a5,a0
    2606:	fef42423          	sw	a5,-24(s0)
      if(fd >= 0){
    260a:	fe842783          	lw	a5,-24(s0)
    260e:	2781                	sext.w	a5,a5
    2610:	0007c763          	bltz	a5,261e <forkforkfork+0x86>
        exit(0);
    2614:	4501                	li	a0,0
    2616:	00005097          	auipc	ra,0x5
    261a:	ffc080e7          	jalr	-4(ra) # 7612 <exit>
      }
      if(fork() < 0){
    261e:	00005097          	auipc	ra,0x5
    2622:	fec080e7          	jalr	-20(ra) # 760a <fork>
    2626:	87aa                	mv	a5,a0
    2628:	fc07d5e3          	bgez	a5,25f2 <forkforkfork+0x5a>
        close(open("stopforking", O_CREATE|O_RDWR));
    262c:	20200593          	li	a1,514
    2630:	00006517          	auipc	a0,0x6
    2634:	2a050513          	addi	a0,a0,672 # 88d0 <malloc+0xb6c>
    2638:	00005097          	auipc	ra,0x5
    263c:	01a080e7          	jalr	26(ra) # 7652 <open>
    2640:	87aa                	mv	a5,a0
    2642:	853e                	mv	a0,a5
    2644:	00005097          	auipc	ra,0x5
    2648:	ff6080e7          	jalr	-10(ra) # 763a <close>
    while(1){
    264c:	b75d                	j	25f2 <forkforkfork+0x5a>
    }

    exit(0);
  }

  sleep(20); // two seconds
    264e:	4551                	li	a0,20
    2650:	00005097          	auipc	ra,0x5
    2654:	052080e7          	jalr	82(ra) # 76a2 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    2658:	20200593          	li	a1,514
    265c:	00006517          	auipc	a0,0x6
    2660:	27450513          	addi	a0,a0,628 # 88d0 <malloc+0xb6c>
    2664:	00005097          	auipc	ra,0x5
    2668:	fee080e7          	jalr	-18(ra) # 7652 <open>
    266c:	87aa                	mv	a5,a0
    266e:	853e                	mv	a0,a5
    2670:	00005097          	auipc	ra,0x5
    2674:	fca080e7          	jalr	-54(ra) # 763a <close>
  wait(0);
    2678:	4501                	li	a0,0
    267a:	00005097          	auipc	ra,0x5
    267e:	fa0080e7          	jalr	-96(ra) # 761a <wait>
  sleep(10); // one second
    2682:	4529                	li	a0,10
    2684:	00005097          	auipc	ra,0x5
    2688:	01e080e7          	jalr	30(ra) # 76a2 <sleep>
}
    268c:	0001                	nop
    268e:	70a2                	ld	ra,40(sp)
    2690:	7402                	ld	s0,32(sp)
    2692:	6145                	addi	sp,sp,48
    2694:	8082                	ret

0000000000002696 <reparent2>:
// deadlocks against init's wait()? also used to trigger a "panic:
// release" due to exit() releasing a different p->parent->lock than
// it acquired.
void
reparent2(char *s)
{
    2696:	7179                	addi	sp,sp,-48
    2698:	f406                	sd	ra,40(sp)
    269a:	f022                	sd	s0,32(sp)
    269c:	1800                	addi	s0,sp,48
    269e:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 800; i++){
    26a2:	fe042623          	sw	zero,-20(s0)
    26a6:	a0ad                	j	2710 <reparent2+0x7a>
    int pid1 = fork();
    26a8:	00005097          	auipc	ra,0x5
    26ac:	f62080e7          	jalr	-158(ra) # 760a <fork>
    26b0:	87aa                	mv	a5,a0
    26b2:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    26b6:	fe842783          	lw	a5,-24(s0)
    26ba:	2781                	sext.w	a5,a5
    26bc:	0007df63          	bgez	a5,26da <reparent2+0x44>
      printf("fork failed\n");
    26c0:	00006517          	auipc	a0,0x6
    26c4:	9f050513          	addi	a0,a0,-1552 # 80b0 <malloc+0x34c>
    26c8:	00005097          	auipc	ra,0x5
    26cc:	4aa080e7          	jalr	1194(ra) # 7b72 <printf>
      exit(1);
    26d0:	4505                	li	a0,1
    26d2:	00005097          	auipc	ra,0x5
    26d6:	f40080e7          	jalr	-192(ra) # 7612 <exit>
    }
    if(pid1 == 0){
    26da:	fe842783          	lw	a5,-24(s0)
    26de:	2781                	sext.w	a5,a5
    26e0:	ef91                	bnez	a5,26fc <reparent2+0x66>
      fork();
    26e2:	00005097          	auipc	ra,0x5
    26e6:	f28080e7          	jalr	-216(ra) # 760a <fork>
      fork();
    26ea:	00005097          	auipc	ra,0x5
    26ee:	f20080e7          	jalr	-224(ra) # 760a <fork>
      exit(0);
    26f2:	4501                	li	a0,0
    26f4:	00005097          	auipc	ra,0x5
    26f8:	f1e080e7          	jalr	-226(ra) # 7612 <exit>
    }
    wait(0);
    26fc:	4501                	li	a0,0
    26fe:	00005097          	auipc	ra,0x5
    2702:	f1c080e7          	jalr	-228(ra) # 761a <wait>
  for(int i = 0; i < 800; i++){
    2706:	fec42783          	lw	a5,-20(s0)
    270a:	2785                	addiw	a5,a5,1
    270c:	fef42623          	sw	a5,-20(s0)
    2710:	fec42783          	lw	a5,-20(s0)
    2714:	0007871b          	sext.w	a4,a5
    2718:	31f00793          	li	a5,799
    271c:	f8e7d6e3          	bge	a5,a4,26a8 <reparent2+0x12>
  }

  exit(0);
    2720:	4501                	li	a0,0
    2722:	00005097          	auipc	ra,0x5
    2726:	ef0080e7          	jalr	-272(ra) # 7612 <exit>

000000000000272a <mem>:
}

// allocate all mem, free it, and allocate again
void
mem(char *s)
{
    272a:	7139                	addi	sp,sp,-64
    272c:	fc06                	sd	ra,56(sp)
    272e:	f822                	sd	s0,48(sp)
    2730:	0080                	addi	s0,sp,64
    2732:	fca43423          	sd	a0,-56(s0)
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    2736:	00005097          	auipc	ra,0x5
    273a:	ed4080e7          	jalr	-300(ra) # 760a <fork>
    273e:	87aa                	mv	a5,a0
    2740:	fef42223          	sw	a5,-28(s0)
    2744:	fe442783          	lw	a5,-28(s0)
    2748:	2781                	sext.w	a5,a5
    274a:	e3c5                	bnez	a5,27ea <mem+0xc0>
    m1 = 0;
    274c:	fe043423          	sd	zero,-24(s0)
    while((m2 = malloc(10001)) != 0){
    2750:	a811                	j	2764 <mem+0x3a>
      *(char**)m2 = m1;
    2752:	fd843783          	ld	a5,-40(s0)
    2756:	fe843703          	ld	a4,-24(s0)
    275a:	e398                	sd	a4,0(a5)
      m1 = m2;
    275c:	fd843783          	ld	a5,-40(s0)
    2760:	fef43423          	sd	a5,-24(s0)
    while((m2 = malloc(10001)) != 0){
    2764:	6789                	lui	a5,0x2
    2766:	71178513          	addi	a0,a5,1809 # 2711 <reparent2+0x7b>
    276a:	00005097          	auipc	ra,0x5
    276e:	5fa080e7          	jalr	1530(ra) # 7d64 <malloc>
    2772:	fca43c23          	sd	a0,-40(s0)
    2776:	fd843783          	ld	a5,-40(s0)
    277a:	ffe1                	bnez	a5,2752 <mem+0x28>
    }
    while(m1){
    277c:	a005                	j	279c <mem+0x72>
      m2 = *(char**)m1;
    277e:	fe843783          	ld	a5,-24(s0)
    2782:	639c                	ld	a5,0(a5)
    2784:	fcf43c23          	sd	a5,-40(s0)
      free(m1);
    2788:	fe843503          	ld	a0,-24(s0)
    278c:	00005097          	auipc	ra,0x5
    2790:	436080e7          	jalr	1078(ra) # 7bc2 <free>
      m1 = m2;
    2794:	fd843783          	ld	a5,-40(s0)
    2798:	fef43423          	sd	a5,-24(s0)
    while(m1){
    279c:	fe843783          	ld	a5,-24(s0)
    27a0:	fff9                	bnez	a5,277e <mem+0x54>
    }
    m1 = malloc(1024*20);
    27a2:	6515                	lui	a0,0x5
    27a4:	00005097          	auipc	ra,0x5
    27a8:	5c0080e7          	jalr	1472(ra) # 7d64 <malloc>
    27ac:	fea43423          	sd	a0,-24(s0)
    if(m1 == 0){
    27b0:	fe843783          	ld	a5,-24(s0)
    27b4:	e385                	bnez	a5,27d4 <mem+0xaa>
      printf("couldn't allocate mem?!!\n", s);
    27b6:	fc843583          	ld	a1,-56(s0)
    27ba:	00006517          	auipc	a0,0x6
    27be:	12650513          	addi	a0,a0,294 # 88e0 <malloc+0xb7c>
    27c2:	00005097          	auipc	ra,0x5
    27c6:	3b0080e7          	jalr	944(ra) # 7b72 <printf>
      exit(1);
    27ca:	4505                	li	a0,1
    27cc:	00005097          	auipc	ra,0x5
    27d0:	e46080e7          	jalr	-442(ra) # 7612 <exit>
    }
    free(m1);
    27d4:	fe843503          	ld	a0,-24(s0)
    27d8:	00005097          	auipc	ra,0x5
    27dc:	3ea080e7          	jalr	1002(ra) # 7bc2 <free>
    exit(0);
    27e0:	4501                	li	a0,0
    27e2:	00005097          	auipc	ra,0x5
    27e6:	e30080e7          	jalr	-464(ra) # 7612 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    27ea:	fd440793          	addi	a5,s0,-44
    27ee:	853e                	mv	a0,a5
    27f0:	00005097          	auipc	ra,0x5
    27f4:	e2a080e7          	jalr	-470(ra) # 761a <wait>
    if(xstatus == -1){
    27f8:	fd442783          	lw	a5,-44(s0)
    27fc:	873e                	mv	a4,a5
    27fe:	57fd                	li	a5,-1
    2800:	00f71763          	bne	a4,a5,280e <mem+0xe4>
      // probably page fault, so might be lazy lab,
      // so OK.
      exit(0);
    2804:	4501                	li	a0,0
    2806:	00005097          	auipc	ra,0x5
    280a:	e0c080e7          	jalr	-500(ra) # 7612 <exit>
    }
    exit(xstatus);
    280e:	fd442783          	lw	a5,-44(s0)
    2812:	853e                	mv	a0,a5
    2814:	00005097          	auipc	ra,0x5
    2818:	dfe080e7          	jalr	-514(ra) # 7612 <exit>

000000000000281c <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(char *s)
{
    281c:	715d                	addi	sp,sp,-80
    281e:	e486                	sd	ra,72(sp)
    2820:	e0a2                	sd	s0,64(sp)
    2822:	0880                	addi	s0,sp,80
    2824:	faa43c23          	sd	a0,-72(s0)
  int fd, pid, i, n, nc, np;
  enum { N = 1000, SZ=10};
  char buf[SZ];

  unlink("sharedfd");
    2828:	00006517          	auipc	a0,0x6
    282c:	0d850513          	addi	a0,a0,216 # 8900 <malloc+0xb9c>
    2830:	00005097          	auipc	ra,0x5
    2834:	e32080e7          	jalr	-462(ra) # 7662 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2838:	20200593          	li	a1,514
    283c:	00006517          	auipc	a0,0x6
    2840:	0c450513          	addi	a0,a0,196 # 8900 <malloc+0xb9c>
    2844:	00005097          	auipc	ra,0x5
    2848:	e0e080e7          	jalr	-498(ra) # 7652 <open>
    284c:	87aa                	mv	a5,a0
    284e:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    2852:	fe042783          	lw	a5,-32(s0)
    2856:	2781                	sext.w	a5,a5
    2858:	0207d163          	bgez	a5,287a <sharedfd+0x5e>
    printf("%s: cannot open sharedfd for writing", s);
    285c:	fb843583          	ld	a1,-72(s0)
    2860:	00006517          	auipc	a0,0x6
    2864:	0b050513          	addi	a0,a0,176 # 8910 <malloc+0xbac>
    2868:	00005097          	auipc	ra,0x5
    286c:	30a080e7          	jalr	778(ra) # 7b72 <printf>
    exit(1);
    2870:	4505                	li	a0,1
    2872:	00005097          	auipc	ra,0x5
    2876:	da0080e7          	jalr	-608(ra) # 7612 <exit>
  }
  pid = fork();
    287a:	00005097          	auipc	ra,0x5
    287e:	d90080e7          	jalr	-624(ra) # 760a <fork>
    2882:	87aa                	mv	a5,a0
    2884:	fcf42e23          	sw	a5,-36(s0)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2888:	fdc42783          	lw	a5,-36(s0)
    288c:	2781                	sext.w	a5,a5
    288e:	e781                	bnez	a5,2896 <sharedfd+0x7a>
    2890:	06300793          	li	a5,99
    2894:	a019                	j	289a <sharedfd+0x7e>
    2896:	07000793          	li	a5,112
    289a:	fc840713          	addi	a4,s0,-56
    289e:	4629                	li	a2,10
    28a0:	85be                	mv	a1,a5
    28a2:	853a                	mv	a0,a4
    28a4:	00005097          	auipc	ra,0x5
    28a8:	9c2080e7          	jalr	-1598(ra) # 7266 <memset>
  for(i = 0; i < N; i++){
    28ac:	fe042623          	sw	zero,-20(s0)
    28b0:	a0a9                	j	28fa <sharedfd+0xde>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    28b2:	fc840713          	addi	a4,s0,-56
    28b6:	fe042783          	lw	a5,-32(s0)
    28ba:	4629                	li	a2,10
    28bc:	85ba                	mv	a1,a4
    28be:	853e                	mv	a0,a5
    28c0:	00005097          	auipc	ra,0x5
    28c4:	d72080e7          	jalr	-654(ra) # 7632 <write>
    28c8:	87aa                	mv	a5,a0
    28ca:	873e                	mv	a4,a5
    28cc:	47a9                	li	a5,10
    28ce:	02f70163          	beq	a4,a5,28f0 <sharedfd+0xd4>
      printf("%s: write sharedfd failed\n", s);
    28d2:	fb843583          	ld	a1,-72(s0)
    28d6:	00006517          	auipc	a0,0x6
    28da:	06250513          	addi	a0,a0,98 # 8938 <malloc+0xbd4>
    28de:	00005097          	auipc	ra,0x5
    28e2:	294080e7          	jalr	660(ra) # 7b72 <printf>
      exit(1);
    28e6:	4505                	li	a0,1
    28e8:	00005097          	auipc	ra,0x5
    28ec:	d2a080e7          	jalr	-726(ra) # 7612 <exit>
  for(i = 0; i < N; i++){
    28f0:	fec42783          	lw	a5,-20(s0)
    28f4:	2785                	addiw	a5,a5,1
    28f6:	fef42623          	sw	a5,-20(s0)
    28fa:	fec42783          	lw	a5,-20(s0)
    28fe:	0007871b          	sext.w	a4,a5
    2902:	3e700793          	li	a5,999
    2906:	fae7d6e3          	bge	a5,a4,28b2 <sharedfd+0x96>
    }
  }
  if(pid == 0) {
    290a:	fdc42783          	lw	a5,-36(s0)
    290e:	2781                	sext.w	a5,a5
    2910:	e791                	bnez	a5,291c <sharedfd+0x100>
    exit(0);
    2912:	4501                	li	a0,0
    2914:	00005097          	auipc	ra,0x5
    2918:	cfe080e7          	jalr	-770(ra) # 7612 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    291c:	fc440793          	addi	a5,s0,-60
    2920:	853e                	mv	a0,a5
    2922:	00005097          	auipc	ra,0x5
    2926:	cf8080e7          	jalr	-776(ra) # 761a <wait>
    if(xstatus != 0)
    292a:	fc442783          	lw	a5,-60(s0)
    292e:	cb81                	beqz	a5,293e <sharedfd+0x122>
      exit(xstatus);
    2930:	fc442783          	lw	a5,-60(s0)
    2934:	853e                	mv	a0,a5
    2936:	00005097          	auipc	ra,0x5
    293a:	cdc080e7          	jalr	-804(ra) # 7612 <exit>
  }

  close(fd);
    293e:	fe042783          	lw	a5,-32(s0)
    2942:	853e                	mv	a0,a5
    2944:	00005097          	auipc	ra,0x5
    2948:	cf6080e7          	jalr	-778(ra) # 763a <close>
  fd = open("sharedfd", 0);
    294c:	4581                	li	a1,0
    294e:	00006517          	auipc	a0,0x6
    2952:	fb250513          	addi	a0,a0,-78 # 8900 <malloc+0xb9c>
    2956:	00005097          	auipc	ra,0x5
    295a:	cfc080e7          	jalr	-772(ra) # 7652 <open>
    295e:	87aa                	mv	a5,a0
    2960:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    2964:	fe042783          	lw	a5,-32(s0)
    2968:	2781                	sext.w	a5,a5
    296a:	0207d163          	bgez	a5,298c <sharedfd+0x170>
    printf("%s: cannot open sharedfd for reading\n", s);
    296e:	fb843583          	ld	a1,-72(s0)
    2972:	00006517          	auipc	a0,0x6
    2976:	fe650513          	addi	a0,a0,-26 # 8958 <malloc+0xbf4>
    297a:	00005097          	auipc	ra,0x5
    297e:	1f8080e7          	jalr	504(ra) # 7b72 <printf>
    exit(1);
    2982:	4505                	li	a0,1
    2984:	00005097          	auipc	ra,0x5
    2988:	c8e080e7          	jalr	-882(ra) # 7612 <exit>
  }
  nc = np = 0;
    298c:	fe042223          	sw	zero,-28(s0)
    2990:	fe442783          	lw	a5,-28(s0)
    2994:	fef42423          	sw	a5,-24(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2998:	a8b9                	j	29f6 <sharedfd+0x1da>
    for(i = 0; i < sizeof(buf); i++){
    299a:	fe042623          	sw	zero,-20(s0)
    299e:	a0b1                	j	29ea <sharedfd+0x1ce>
      if(buf[i] == 'c')
    29a0:	fec42783          	lw	a5,-20(s0)
    29a4:	17c1                	addi	a5,a5,-16
    29a6:	97a2                	add	a5,a5,s0
    29a8:	fd87c783          	lbu	a5,-40(a5)
    29ac:	873e                	mv	a4,a5
    29ae:	06300793          	li	a5,99
    29b2:	00f71763          	bne	a4,a5,29c0 <sharedfd+0x1a4>
        nc++;
    29b6:	fe842783          	lw	a5,-24(s0)
    29ba:	2785                	addiw	a5,a5,1
    29bc:	fef42423          	sw	a5,-24(s0)
      if(buf[i] == 'p')
    29c0:	fec42783          	lw	a5,-20(s0)
    29c4:	17c1                	addi	a5,a5,-16
    29c6:	97a2                	add	a5,a5,s0
    29c8:	fd87c783          	lbu	a5,-40(a5)
    29cc:	873e                	mv	a4,a5
    29ce:	07000793          	li	a5,112
    29d2:	00f71763          	bne	a4,a5,29e0 <sharedfd+0x1c4>
        np++;
    29d6:	fe442783          	lw	a5,-28(s0)
    29da:	2785                	addiw	a5,a5,1
    29dc:	fef42223          	sw	a5,-28(s0)
    for(i = 0; i < sizeof(buf); i++){
    29e0:	fec42783          	lw	a5,-20(s0)
    29e4:	2785                	addiw	a5,a5,1
    29e6:	fef42623          	sw	a5,-20(s0)
    29ea:	fec42783          	lw	a5,-20(s0)
    29ee:	873e                	mv	a4,a5
    29f0:	47a5                	li	a5,9
    29f2:	fae7f7e3          	bgeu	a5,a4,29a0 <sharedfd+0x184>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    29f6:	fc840713          	addi	a4,s0,-56
    29fa:	fe042783          	lw	a5,-32(s0)
    29fe:	4629                	li	a2,10
    2a00:	85ba                	mv	a1,a4
    2a02:	853e                	mv	a0,a5
    2a04:	00005097          	auipc	ra,0x5
    2a08:	c26080e7          	jalr	-986(ra) # 762a <read>
    2a0c:	87aa                	mv	a5,a0
    2a0e:	fcf42c23          	sw	a5,-40(s0)
    2a12:	fd842783          	lw	a5,-40(s0)
    2a16:	2781                	sext.w	a5,a5
    2a18:	f8f041e3          	bgtz	a5,299a <sharedfd+0x17e>
    }
  }
  close(fd);
    2a1c:	fe042783          	lw	a5,-32(s0)
    2a20:	853e                	mv	a0,a5
    2a22:	00005097          	auipc	ra,0x5
    2a26:	c18080e7          	jalr	-1000(ra) # 763a <close>
  unlink("sharedfd");
    2a2a:	00006517          	auipc	a0,0x6
    2a2e:	ed650513          	addi	a0,a0,-298 # 8900 <malloc+0xb9c>
    2a32:	00005097          	auipc	ra,0x5
    2a36:	c30080e7          	jalr	-976(ra) # 7662 <unlink>
  if(nc == N*SZ && np == N*SZ){
    2a3a:	fe842783          	lw	a5,-24(s0)
    2a3e:	0007871b          	sext.w	a4,a5
    2a42:	6789                	lui	a5,0x2
    2a44:	71078793          	addi	a5,a5,1808 # 2710 <reparent2+0x7a>
    2a48:	02f71063          	bne	a4,a5,2a68 <sharedfd+0x24c>
    2a4c:	fe442783          	lw	a5,-28(s0)
    2a50:	0007871b          	sext.w	a4,a5
    2a54:	6789                	lui	a5,0x2
    2a56:	71078793          	addi	a5,a5,1808 # 2710 <reparent2+0x7a>
    2a5a:	00f71763          	bne	a4,a5,2a68 <sharedfd+0x24c>
    exit(0);
    2a5e:	4501                	li	a0,0
    2a60:	00005097          	auipc	ra,0x5
    2a64:	bb2080e7          	jalr	-1102(ra) # 7612 <exit>
  } else {
    printf("%s: nc/np test fails\n", s);
    2a68:	fb843583          	ld	a1,-72(s0)
    2a6c:	00006517          	auipc	a0,0x6
    2a70:	f1450513          	addi	a0,a0,-236 # 8980 <malloc+0xc1c>
    2a74:	00005097          	auipc	ra,0x5
    2a78:	0fe080e7          	jalr	254(ra) # 7b72 <printf>
    exit(1);
    2a7c:	4505                	li	a0,1
    2a7e:	00005097          	auipc	ra,0x5
    2a82:	b94080e7          	jalr	-1132(ra) # 7612 <exit>

0000000000002a86 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(char *s)
{
    2a86:	7159                	addi	sp,sp,-112
    2a88:	f486                	sd	ra,104(sp)
    2a8a:	f0a2                	sd	s0,96(sp)
    2a8c:	1880                	addi	s0,sp,112
    2a8e:	f8a43c23          	sd	a0,-104(s0)
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    2a92:	00006797          	auipc	a5,0x6
    2a96:	f7678793          	addi	a5,a5,-138 # 8a08 <malloc+0xca4>
    2a9a:	6390                	ld	a2,0(a5)
    2a9c:	6794                	ld	a3,8(a5)
    2a9e:	6b98                	ld	a4,16(a5)
    2aa0:	6f9c                	ld	a5,24(a5)
    2aa2:	fac43423          	sd	a2,-88(s0)
    2aa6:	fad43823          	sd	a3,-80(s0)
    2aaa:	fae43c23          	sd	a4,-72(s0)
    2aae:	fcf43023          	sd	a5,-64(s0)
  char *fname;
  enum { N=12, NCHILD=4, SZ=500 };

  for(pi = 0; pi < NCHILD; pi++){
    2ab2:	fe042023          	sw	zero,-32(s0)
    2ab6:	aa3d                	j	2bf4 <fourfiles+0x16e>
    fname = names[pi];
    2ab8:	fe042783          	lw	a5,-32(s0)
    2abc:	078e                	slli	a5,a5,0x3
    2abe:	17c1                	addi	a5,a5,-16
    2ac0:	97a2                	add	a5,a5,s0
    2ac2:	fb87b783          	ld	a5,-72(a5)
    2ac6:	fcf43c23          	sd	a5,-40(s0)
    unlink(fname);
    2aca:	fd843503          	ld	a0,-40(s0)
    2ace:	00005097          	auipc	ra,0x5
    2ad2:	b94080e7          	jalr	-1132(ra) # 7662 <unlink>

    pid = fork();
    2ad6:	00005097          	auipc	ra,0x5
    2ada:	b34080e7          	jalr	-1228(ra) # 760a <fork>
    2ade:	87aa                	mv	a5,a0
    2ae0:	fcf42623          	sw	a5,-52(s0)
    if(pid < 0){
    2ae4:	fcc42783          	lw	a5,-52(s0)
    2ae8:	2781                	sext.w	a5,a5
    2aea:	0207d163          	bgez	a5,2b0c <fourfiles+0x86>
      printf("fork failed\n", s);
    2aee:	f9843583          	ld	a1,-104(s0)
    2af2:	00005517          	auipc	a0,0x5
    2af6:	5be50513          	addi	a0,a0,1470 # 80b0 <malloc+0x34c>
    2afa:	00005097          	auipc	ra,0x5
    2afe:	078080e7          	jalr	120(ra) # 7b72 <printf>
      exit(1);
    2b02:	4505                	li	a0,1
    2b04:	00005097          	auipc	ra,0x5
    2b08:	b0e080e7          	jalr	-1266(ra) # 7612 <exit>
    }

    if(pid == 0){
    2b0c:	fcc42783          	lw	a5,-52(s0)
    2b10:	2781                	sext.w	a5,a5
    2b12:	efe1                	bnez	a5,2bea <fourfiles+0x164>
      fd = open(fname, O_CREATE | O_RDWR);
    2b14:	20200593          	li	a1,514
    2b18:	fd843503          	ld	a0,-40(s0)
    2b1c:	00005097          	auipc	ra,0x5
    2b20:	b36080e7          	jalr	-1226(ra) # 7652 <open>
    2b24:	87aa                	mv	a5,a0
    2b26:	fcf42a23          	sw	a5,-44(s0)
      if(fd < 0){
    2b2a:	fd442783          	lw	a5,-44(s0)
    2b2e:	2781                	sext.w	a5,a5
    2b30:	0207d163          	bgez	a5,2b52 <fourfiles+0xcc>
        printf("create failed\n", s);
    2b34:	f9843583          	ld	a1,-104(s0)
    2b38:	00006517          	auipc	a0,0x6
    2b3c:	e6050513          	addi	a0,a0,-416 # 8998 <malloc+0xc34>
    2b40:	00005097          	auipc	ra,0x5
    2b44:	032080e7          	jalr	50(ra) # 7b72 <printf>
        exit(1);
    2b48:	4505                	li	a0,1
    2b4a:	00005097          	auipc	ra,0x5
    2b4e:	ac8080e7          	jalr	-1336(ra) # 7612 <exit>
      }

      memset(buf, '0'+pi, SZ);
    2b52:	fe042783          	lw	a5,-32(s0)
    2b56:	0307879b          	addiw	a5,a5,48
    2b5a:	2781                	sext.w	a5,a5
    2b5c:	1f400613          	li	a2,500
    2b60:	85be                	mv	a1,a5
    2b62:	00009517          	auipc	a0,0x9
    2b66:	77e50513          	addi	a0,a0,1918 # c2e0 <buf>
    2b6a:	00004097          	auipc	ra,0x4
    2b6e:	6fc080e7          	jalr	1788(ra) # 7266 <memset>
      for(i = 0; i < N; i++){
    2b72:	fe042623          	sw	zero,-20(s0)
    2b76:	a8b1                	j	2bd2 <fourfiles+0x14c>
        if((n = write(fd, buf, SZ)) != SZ){
    2b78:	fd442783          	lw	a5,-44(s0)
    2b7c:	1f400613          	li	a2,500
    2b80:	00009597          	auipc	a1,0x9
    2b84:	76058593          	addi	a1,a1,1888 # c2e0 <buf>
    2b88:	853e                	mv	a0,a5
    2b8a:	00005097          	auipc	ra,0x5
    2b8e:	aa8080e7          	jalr	-1368(ra) # 7632 <write>
    2b92:	87aa                	mv	a5,a0
    2b94:	fcf42823          	sw	a5,-48(s0)
    2b98:	fd042783          	lw	a5,-48(s0)
    2b9c:	0007871b          	sext.w	a4,a5
    2ba0:	1f400793          	li	a5,500
    2ba4:	02f70263          	beq	a4,a5,2bc8 <fourfiles+0x142>
          printf("write failed %d\n", n);
    2ba8:	fd042783          	lw	a5,-48(s0)
    2bac:	85be                	mv	a1,a5
    2bae:	00006517          	auipc	a0,0x6
    2bb2:	dfa50513          	addi	a0,a0,-518 # 89a8 <malloc+0xc44>
    2bb6:	00005097          	auipc	ra,0x5
    2bba:	fbc080e7          	jalr	-68(ra) # 7b72 <printf>
          exit(1);
    2bbe:	4505                	li	a0,1
    2bc0:	00005097          	auipc	ra,0x5
    2bc4:	a52080e7          	jalr	-1454(ra) # 7612 <exit>
      for(i = 0; i < N; i++){
    2bc8:	fec42783          	lw	a5,-20(s0)
    2bcc:	2785                	addiw	a5,a5,1
    2bce:	fef42623          	sw	a5,-20(s0)
    2bd2:	fec42783          	lw	a5,-20(s0)
    2bd6:	0007871b          	sext.w	a4,a5
    2bda:	47ad                	li	a5,11
    2bdc:	f8e7dee3          	bge	a5,a4,2b78 <fourfiles+0xf2>
        }
      }
      exit(0);
    2be0:	4501                	li	a0,0
    2be2:	00005097          	auipc	ra,0x5
    2be6:	a30080e7          	jalr	-1488(ra) # 7612 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2bea:	fe042783          	lw	a5,-32(s0)
    2bee:	2785                	addiw	a5,a5,1
    2bf0:	fef42023          	sw	a5,-32(s0)
    2bf4:	fe042783          	lw	a5,-32(s0)
    2bf8:	0007871b          	sext.w	a4,a5
    2bfc:	478d                	li	a5,3
    2bfe:	eae7dde3          	bge	a5,a4,2ab8 <fourfiles+0x32>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2c02:	fe042023          	sw	zero,-32(s0)
    2c06:	a03d                	j	2c34 <fourfiles+0x1ae>
    wait(&xstatus);
    2c08:	fa440793          	addi	a5,s0,-92
    2c0c:	853e                	mv	a0,a5
    2c0e:	00005097          	auipc	ra,0x5
    2c12:	a0c080e7          	jalr	-1524(ra) # 761a <wait>
    if(xstatus != 0)
    2c16:	fa442783          	lw	a5,-92(s0)
    2c1a:	cb81                	beqz	a5,2c2a <fourfiles+0x1a4>
      exit(xstatus);
    2c1c:	fa442783          	lw	a5,-92(s0)
    2c20:	853e                	mv	a0,a5
    2c22:	00005097          	auipc	ra,0x5
    2c26:	9f0080e7          	jalr	-1552(ra) # 7612 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2c2a:	fe042783          	lw	a5,-32(s0)
    2c2e:	2785                	addiw	a5,a5,1
    2c30:	fef42023          	sw	a5,-32(s0)
    2c34:	fe042783          	lw	a5,-32(s0)
    2c38:	0007871b          	sext.w	a4,a5
    2c3c:	478d                	li	a5,3
    2c3e:	fce7d5e3          	bge	a5,a4,2c08 <fourfiles+0x182>
  }

  for(i = 0; i < NCHILD; i++){
    2c42:	fe042623          	sw	zero,-20(s0)
    2c46:	a205                	j	2d66 <fourfiles+0x2e0>
    fname = names[i];
    2c48:	fec42783          	lw	a5,-20(s0)
    2c4c:	078e                	slli	a5,a5,0x3
    2c4e:	17c1                	addi	a5,a5,-16
    2c50:	97a2                	add	a5,a5,s0
    2c52:	fb87b783          	ld	a5,-72(a5)
    2c56:	fcf43c23          	sd	a5,-40(s0)
    fd = open(fname, 0);
    2c5a:	4581                	li	a1,0
    2c5c:	fd843503          	ld	a0,-40(s0)
    2c60:	00005097          	auipc	ra,0x5
    2c64:	9f2080e7          	jalr	-1550(ra) # 7652 <open>
    2c68:	87aa                	mv	a5,a0
    2c6a:	fcf42a23          	sw	a5,-44(s0)
    total = 0;
    2c6e:	fe042223          	sw	zero,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2c72:	a89d                	j	2ce8 <fourfiles+0x262>
      for(j = 0; j < n; j++){
    2c74:	fe042423          	sw	zero,-24(s0)
    2c78:	a0b9                	j	2cc6 <fourfiles+0x240>
        if(buf[j] != '0'+i){
    2c7a:	00009717          	auipc	a4,0x9
    2c7e:	66670713          	addi	a4,a4,1638 # c2e0 <buf>
    2c82:	fe842783          	lw	a5,-24(s0)
    2c86:	97ba                	add	a5,a5,a4
    2c88:	0007c783          	lbu	a5,0(a5)
    2c8c:	0007871b          	sext.w	a4,a5
    2c90:	fec42783          	lw	a5,-20(s0)
    2c94:	0307879b          	addiw	a5,a5,48
    2c98:	2781                	sext.w	a5,a5
    2c9a:	02f70163          	beq	a4,a5,2cbc <fourfiles+0x236>
          printf("wrong char\n", s);
    2c9e:	f9843583          	ld	a1,-104(s0)
    2ca2:	00006517          	auipc	a0,0x6
    2ca6:	d1e50513          	addi	a0,a0,-738 # 89c0 <malloc+0xc5c>
    2caa:	00005097          	auipc	ra,0x5
    2cae:	ec8080e7          	jalr	-312(ra) # 7b72 <printf>
          exit(1);
    2cb2:	4505                	li	a0,1
    2cb4:	00005097          	auipc	ra,0x5
    2cb8:	95e080e7          	jalr	-1698(ra) # 7612 <exit>
      for(j = 0; j < n; j++){
    2cbc:	fe842783          	lw	a5,-24(s0)
    2cc0:	2785                	addiw	a5,a5,1
    2cc2:	fef42423          	sw	a5,-24(s0)
    2cc6:	fe842783          	lw	a5,-24(s0)
    2cca:	873e                	mv	a4,a5
    2ccc:	fd042783          	lw	a5,-48(s0)
    2cd0:	2701                	sext.w	a4,a4
    2cd2:	2781                	sext.w	a5,a5
    2cd4:	faf743e3          	blt	a4,a5,2c7a <fourfiles+0x1f4>
        }
      }
      total += n;
    2cd8:	fe442783          	lw	a5,-28(s0)
    2cdc:	873e                	mv	a4,a5
    2cde:	fd042783          	lw	a5,-48(s0)
    2ce2:	9fb9                	addw	a5,a5,a4
    2ce4:	fef42223          	sw	a5,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2ce8:	fd442783          	lw	a5,-44(s0)
    2cec:	660d                	lui	a2,0x3
    2cee:	00009597          	auipc	a1,0x9
    2cf2:	5f258593          	addi	a1,a1,1522 # c2e0 <buf>
    2cf6:	853e                	mv	a0,a5
    2cf8:	00005097          	auipc	ra,0x5
    2cfc:	932080e7          	jalr	-1742(ra) # 762a <read>
    2d00:	87aa                	mv	a5,a0
    2d02:	fcf42823          	sw	a5,-48(s0)
    2d06:	fd042783          	lw	a5,-48(s0)
    2d0a:	2781                	sext.w	a5,a5
    2d0c:	f6f044e3          	bgtz	a5,2c74 <fourfiles+0x1ee>
    }
    close(fd);
    2d10:	fd442783          	lw	a5,-44(s0)
    2d14:	853e                	mv	a0,a5
    2d16:	00005097          	auipc	ra,0x5
    2d1a:	924080e7          	jalr	-1756(ra) # 763a <close>
    if(total != N*SZ){
    2d1e:	fe442783          	lw	a5,-28(s0)
    2d22:	0007871b          	sext.w	a4,a5
    2d26:	6785                	lui	a5,0x1
    2d28:	77078793          	addi	a5,a5,1904 # 1770 <writebig+0x12c>
    2d2c:	02f70263          	beq	a4,a5,2d50 <fourfiles+0x2ca>
      printf("wrong length %d\n", total);
    2d30:	fe442783          	lw	a5,-28(s0)
    2d34:	85be                	mv	a1,a5
    2d36:	00006517          	auipc	a0,0x6
    2d3a:	c9a50513          	addi	a0,a0,-870 # 89d0 <malloc+0xc6c>
    2d3e:	00005097          	auipc	ra,0x5
    2d42:	e34080e7          	jalr	-460(ra) # 7b72 <printf>
      exit(1);
    2d46:	4505                	li	a0,1
    2d48:	00005097          	auipc	ra,0x5
    2d4c:	8ca080e7          	jalr	-1846(ra) # 7612 <exit>
    }
    unlink(fname);
    2d50:	fd843503          	ld	a0,-40(s0)
    2d54:	00005097          	auipc	ra,0x5
    2d58:	90e080e7          	jalr	-1778(ra) # 7662 <unlink>
  for(i = 0; i < NCHILD; i++){
    2d5c:	fec42783          	lw	a5,-20(s0)
    2d60:	2785                	addiw	a5,a5,1
    2d62:	fef42623          	sw	a5,-20(s0)
    2d66:	fec42783          	lw	a5,-20(s0)
    2d6a:	0007871b          	sext.w	a4,a5
    2d6e:	478d                	li	a5,3
    2d70:	ece7dce3          	bge	a5,a4,2c48 <fourfiles+0x1c2>
  }
}
    2d74:	0001                	nop
    2d76:	0001                	nop
    2d78:	70a6                	ld	ra,104(sp)
    2d7a:	7406                	ld	s0,96(sp)
    2d7c:	6165                	addi	sp,sp,112
    2d7e:	8082                	ret

0000000000002d80 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(char *s)
{
    2d80:	711d                	addi	sp,sp,-96
    2d82:	ec86                	sd	ra,88(sp)
    2d84:	e8a2                	sd	s0,80(sp)
    2d86:	1080                	addi	s0,sp,96
    2d88:	faa43423          	sd	a0,-88(s0)
  enum { N = 20, NCHILD=4 };
  int pid, i, fd, pi;
  char name[32];

  for(pi = 0; pi < NCHILD; pi++){
    2d8c:	fe042423          	sw	zero,-24(s0)
    2d90:	aa91                	j	2ee4 <createdelete+0x164>
    pid = fork();
    2d92:	00005097          	auipc	ra,0x5
    2d96:	878080e7          	jalr	-1928(ra) # 760a <fork>
    2d9a:	87aa                	mv	a5,a0
    2d9c:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    2da0:	fe042783          	lw	a5,-32(s0)
    2da4:	2781                	sext.w	a5,a5
    2da6:	0207d163          	bgez	a5,2dc8 <createdelete+0x48>
      printf("fork failed\n", s);
    2daa:	fa843583          	ld	a1,-88(s0)
    2dae:	00005517          	auipc	a0,0x5
    2db2:	30250513          	addi	a0,a0,770 # 80b0 <malloc+0x34c>
    2db6:	00005097          	auipc	ra,0x5
    2dba:	dbc080e7          	jalr	-580(ra) # 7b72 <printf>
      exit(1);
    2dbe:	4505                	li	a0,1
    2dc0:	00005097          	auipc	ra,0x5
    2dc4:	852080e7          	jalr	-1966(ra) # 7612 <exit>
    }

    if(pid == 0){
    2dc8:	fe042783          	lw	a5,-32(s0)
    2dcc:	2781                	sext.w	a5,a5
    2dce:	10079663          	bnez	a5,2eda <createdelete+0x15a>
      name[0] = 'p' + pi;
    2dd2:	fe842783          	lw	a5,-24(s0)
    2dd6:	0ff7f793          	zext.b	a5,a5
    2dda:	0707879b          	addiw	a5,a5,112
    2dde:	0ff7f793          	zext.b	a5,a5
    2de2:	fcf40023          	sb	a5,-64(s0)
      name[2] = '\0';
    2de6:	fc040123          	sb	zero,-62(s0)
      for(i = 0; i < N; i++){
    2dea:	fe042623          	sw	zero,-20(s0)
    2dee:	a8d1                	j	2ec2 <createdelete+0x142>
        name[1] = '0' + i;
    2df0:	fec42783          	lw	a5,-20(s0)
    2df4:	0ff7f793          	zext.b	a5,a5
    2df8:	0307879b          	addiw	a5,a5,48
    2dfc:	0ff7f793          	zext.b	a5,a5
    2e00:	fcf400a3          	sb	a5,-63(s0)
        fd = open(name, O_CREATE | O_RDWR);
    2e04:	fc040793          	addi	a5,s0,-64
    2e08:	20200593          	li	a1,514
    2e0c:	853e                	mv	a0,a5
    2e0e:	00005097          	auipc	ra,0x5
    2e12:	844080e7          	jalr	-1980(ra) # 7652 <open>
    2e16:	87aa                	mv	a5,a0
    2e18:	fef42223          	sw	a5,-28(s0)
        if(fd < 0){
    2e1c:	fe442783          	lw	a5,-28(s0)
    2e20:	2781                	sext.w	a5,a5
    2e22:	0207d163          	bgez	a5,2e44 <createdelete+0xc4>
          printf("%s: create failed\n", s);
    2e26:	fa843583          	ld	a1,-88(s0)
    2e2a:	00006517          	auipc	a0,0x6
    2e2e:	8de50513          	addi	a0,a0,-1826 # 8708 <malloc+0x9a4>
    2e32:	00005097          	auipc	ra,0x5
    2e36:	d40080e7          	jalr	-704(ra) # 7b72 <printf>
          exit(1);
    2e3a:	4505                	li	a0,1
    2e3c:	00004097          	auipc	ra,0x4
    2e40:	7d6080e7          	jalr	2006(ra) # 7612 <exit>
        }
        close(fd);
    2e44:	fe442783          	lw	a5,-28(s0)
    2e48:	853e                	mv	a0,a5
    2e4a:	00004097          	auipc	ra,0x4
    2e4e:	7f0080e7          	jalr	2032(ra) # 763a <close>
        if(i > 0 && (i % 2 ) == 0){
    2e52:	fec42783          	lw	a5,-20(s0)
    2e56:	2781                	sext.w	a5,a5
    2e58:	06f05063          	blez	a5,2eb8 <createdelete+0x138>
    2e5c:	fec42783          	lw	a5,-20(s0)
    2e60:	8b85                	andi	a5,a5,1
    2e62:	2781                	sext.w	a5,a5
    2e64:	ebb1                	bnez	a5,2eb8 <createdelete+0x138>
          name[1] = '0' + (i / 2);
    2e66:	fec42783          	lw	a5,-20(s0)
    2e6a:	01f7d71b          	srliw	a4,a5,0x1f
    2e6e:	9fb9                	addw	a5,a5,a4
    2e70:	4017d79b          	sraiw	a5,a5,0x1
    2e74:	2781                	sext.w	a5,a5
    2e76:	0ff7f793          	zext.b	a5,a5
    2e7a:	0307879b          	addiw	a5,a5,48
    2e7e:	0ff7f793          	zext.b	a5,a5
    2e82:	fcf400a3          	sb	a5,-63(s0)
          if(unlink(name) < 0){
    2e86:	fc040793          	addi	a5,s0,-64
    2e8a:	853e                	mv	a0,a5
    2e8c:	00004097          	auipc	ra,0x4
    2e90:	7d6080e7          	jalr	2006(ra) # 7662 <unlink>
    2e94:	87aa                	mv	a5,a0
    2e96:	0207d163          	bgez	a5,2eb8 <createdelete+0x138>
            printf("%s: unlink failed\n", s);
    2e9a:	fa843583          	ld	a1,-88(s0)
    2e9e:	00005517          	auipc	a0,0x5
    2ea2:	5ba50513          	addi	a0,a0,1466 # 8458 <malloc+0x6f4>
    2ea6:	00005097          	auipc	ra,0x5
    2eaa:	ccc080e7          	jalr	-820(ra) # 7b72 <printf>
            exit(1);
    2eae:	4505                	li	a0,1
    2eb0:	00004097          	auipc	ra,0x4
    2eb4:	762080e7          	jalr	1890(ra) # 7612 <exit>
      for(i = 0; i < N; i++){
    2eb8:	fec42783          	lw	a5,-20(s0)
    2ebc:	2785                	addiw	a5,a5,1
    2ebe:	fef42623          	sw	a5,-20(s0)
    2ec2:	fec42783          	lw	a5,-20(s0)
    2ec6:	0007871b          	sext.w	a4,a5
    2eca:	47cd                	li	a5,19
    2ecc:	f2e7d2e3          	bge	a5,a4,2df0 <createdelete+0x70>
          }
        }
      }
      exit(0);
    2ed0:	4501                	li	a0,0
    2ed2:	00004097          	auipc	ra,0x4
    2ed6:	740080e7          	jalr	1856(ra) # 7612 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2eda:	fe842783          	lw	a5,-24(s0)
    2ede:	2785                	addiw	a5,a5,1
    2ee0:	fef42423          	sw	a5,-24(s0)
    2ee4:	fe842783          	lw	a5,-24(s0)
    2ee8:	0007871b          	sext.w	a4,a5
    2eec:	478d                	li	a5,3
    2eee:	eae7d2e3          	bge	a5,a4,2d92 <createdelete+0x12>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2ef2:	fe042423          	sw	zero,-24(s0)
    2ef6:	a02d                	j	2f20 <createdelete+0x1a0>
    wait(&xstatus);
    2ef8:	fbc40793          	addi	a5,s0,-68
    2efc:	853e                	mv	a0,a5
    2efe:	00004097          	auipc	ra,0x4
    2f02:	71c080e7          	jalr	1820(ra) # 761a <wait>
    if(xstatus != 0)
    2f06:	fbc42783          	lw	a5,-68(s0)
    2f0a:	c791                	beqz	a5,2f16 <createdelete+0x196>
      exit(1);
    2f0c:	4505                	li	a0,1
    2f0e:	00004097          	auipc	ra,0x4
    2f12:	704080e7          	jalr	1796(ra) # 7612 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2f16:	fe842783          	lw	a5,-24(s0)
    2f1a:	2785                	addiw	a5,a5,1
    2f1c:	fef42423          	sw	a5,-24(s0)
    2f20:	fe842783          	lw	a5,-24(s0)
    2f24:	0007871b          	sext.w	a4,a5
    2f28:	478d                	li	a5,3
    2f2a:	fce7d7e3          	bge	a5,a4,2ef8 <createdelete+0x178>
  }

  name[0] = name[1] = name[2] = 0;
    2f2e:	fc040123          	sb	zero,-62(s0)
    2f32:	fc244783          	lbu	a5,-62(s0)
    2f36:	fcf400a3          	sb	a5,-63(s0)
    2f3a:	fc144783          	lbu	a5,-63(s0)
    2f3e:	fcf40023          	sb	a5,-64(s0)
  for(i = 0; i < N; i++){
    2f42:	fe042623          	sw	zero,-20(s0)
    2f46:	a229                	j	3050 <createdelete+0x2d0>
    for(pi = 0; pi < NCHILD; pi++){
    2f48:	fe042423          	sw	zero,-24(s0)
    2f4c:	a0f5                	j	3038 <createdelete+0x2b8>
      name[0] = 'p' + pi;
    2f4e:	fe842783          	lw	a5,-24(s0)
    2f52:	0ff7f793          	zext.b	a5,a5
    2f56:	0707879b          	addiw	a5,a5,112
    2f5a:	0ff7f793          	zext.b	a5,a5
    2f5e:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    2f62:	fec42783          	lw	a5,-20(s0)
    2f66:	0ff7f793          	zext.b	a5,a5
    2f6a:	0307879b          	addiw	a5,a5,48
    2f6e:	0ff7f793          	zext.b	a5,a5
    2f72:	fcf400a3          	sb	a5,-63(s0)
      fd = open(name, 0);
    2f76:	fc040793          	addi	a5,s0,-64
    2f7a:	4581                	li	a1,0
    2f7c:	853e                	mv	a0,a5
    2f7e:	00004097          	auipc	ra,0x4
    2f82:	6d4080e7          	jalr	1748(ra) # 7652 <open>
    2f86:	87aa                	mv	a5,a0
    2f88:	fef42223          	sw	a5,-28(s0)
      if((i == 0 || i >= N/2) && fd < 0){
    2f8c:	fec42783          	lw	a5,-20(s0)
    2f90:	2781                	sext.w	a5,a5
    2f92:	cb81                	beqz	a5,2fa2 <createdelete+0x222>
    2f94:	fec42783          	lw	a5,-20(s0)
    2f98:	0007871b          	sext.w	a4,a5
    2f9c:	47a5                	li	a5,9
    2f9e:	02e7d963          	bge	a5,a4,2fd0 <createdelete+0x250>
    2fa2:	fe442783          	lw	a5,-28(s0)
    2fa6:	2781                	sext.w	a5,a5
    2fa8:	0207d463          	bgez	a5,2fd0 <createdelete+0x250>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    2fac:	fc040793          	addi	a5,s0,-64
    2fb0:	863e                	mv	a2,a5
    2fb2:	fa843583          	ld	a1,-88(s0)
    2fb6:	00006517          	auipc	a0,0x6
    2fba:	a7250513          	addi	a0,a0,-1422 # 8a28 <malloc+0xcc4>
    2fbe:	00005097          	auipc	ra,0x5
    2fc2:	bb4080e7          	jalr	-1100(ra) # 7b72 <printf>
        exit(1);
    2fc6:	4505                	li	a0,1
    2fc8:	00004097          	auipc	ra,0x4
    2fcc:	64a080e7          	jalr	1610(ra) # 7612 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2fd0:	fec42783          	lw	a5,-20(s0)
    2fd4:	2781                	sext.w	a5,a5
    2fd6:	04f05063          	blez	a5,3016 <createdelete+0x296>
    2fda:	fec42783          	lw	a5,-20(s0)
    2fde:	0007871b          	sext.w	a4,a5
    2fe2:	47a5                	li	a5,9
    2fe4:	02e7c963          	blt	a5,a4,3016 <createdelete+0x296>
    2fe8:	fe442783          	lw	a5,-28(s0)
    2fec:	2781                	sext.w	a5,a5
    2fee:	0207c463          	bltz	a5,3016 <createdelete+0x296>
        printf("%s: oops createdelete %s did exist\n", s, name);
    2ff2:	fc040793          	addi	a5,s0,-64
    2ff6:	863e                	mv	a2,a5
    2ff8:	fa843583          	ld	a1,-88(s0)
    2ffc:	00006517          	auipc	a0,0x6
    3000:	a5450513          	addi	a0,a0,-1452 # 8a50 <malloc+0xcec>
    3004:	00005097          	auipc	ra,0x5
    3008:	b6e080e7          	jalr	-1170(ra) # 7b72 <printf>
        exit(1);
    300c:	4505                	li	a0,1
    300e:	00004097          	auipc	ra,0x4
    3012:	604080e7          	jalr	1540(ra) # 7612 <exit>
      }
      if(fd >= 0)
    3016:	fe442783          	lw	a5,-28(s0)
    301a:	2781                	sext.w	a5,a5
    301c:	0007c963          	bltz	a5,302e <createdelete+0x2ae>
        close(fd);
    3020:	fe442783          	lw	a5,-28(s0)
    3024:	853e                	mv	a0,a5
    3026:	00004097          	auipc	ra,0x4
    302a:	614080e7          	jalr	1556(ra) # 763a <close>
    for(pi = 0; pi < NCHILD; pi++){
    302e:	fe842783          	lw	a5,-24(s0)
    3032:	2785                	addiw	a5,a5,1
    3034:	fef42423          	sw	a5,-24(s0)
    3038:	fe842783          	lw	a5,-24(s0)
    303c:	0007871b          	sext.w	a4,a5
    3040:	478d                	li	a5,3
    3042:	f0e7d6e3          	bge	a5,a4,2f4e <createdelete+0x1ce>
  for(i = 0; i < N; i++){
    3046:	fec42783          	lw	a5,-20(s0)
    304a:	2785                	addiw	a5,a5,1
    304c:	fef42623          	sw	a5,-20(s0)
    3050:	fec42783          	lw	a5,-20(s0)
    3054:	0007871b          	sext.w	a4,a5
    3058:	47cd                	li	a5,19
    305a:	eee7d7e3          	bge	a5,a4,2f48 <createdelete+0x1c8>
    }
  }

  for(i = 0; i < N; i++){
    305e:	fe042623          	sw	zero,-20(s0)
    3062:	a085                	j	30c2 <createdelete+0x342>
    for(pi = 0; pi < NCHILD; pi++){
    3064:	fe042423          	sw	zero,-24(s0)
    3068:	a089                	j	30aa <createdelete+0x32a>
      name[0] = 'p' + i;
    306a:	fec42783          	lw	a5,-20(s0)
    306e:	0ff7f793          	zext.b	a5,a5
    3072:	0707879b          	addiw	a5,a5,112
    3076:	0ff7f793          	zext.b	a5,a5
    307a:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    307e:	fec42783          	lw	a5,-20(s0)
    3082:	0ff7f793          	zext.b	a5,a5
    3086:	0307879b          	addiw	a5,a5,48
    308a:	0ff7f793          	zext.b	a5,a5
    308e:	fcf400a3          	sb	a5,-63(s0)
      unlink(name);
    3092:	fc040793          	addi	a5,s0,-64
    3096:	853e                	mv	a0,a5
    3098:	00004097          	auipc	ra,0x4
    309c:	5ca080e7          	jalr	1482(ra) # 7662 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    30a0:	fe842783          	lw	a5,-24(s0)
    30a4:	2785                	addiw	a5,a5,1
    30a6:	fef42423          	sw	a5,-24(s0)
    30aa:	fe842783          	lw	a5,-24(s0)
    30ae:	0007871b          	sext.w	a4,a5
    30b2:	478d                	li	a5,3
    30b4:	fae7dbe3          	bge	a5,a4,306a <createdelete+0x2ea>
  for(i = 0; i < N; i++){
    30b8:	fec42783          	lw	a5,-20(s0)
    30bc:	2785                	addiw	a5,a5,1
    30be:	fef42623          	sw	a5,-20(s0)
    30c2:	fec42783          	lw	a5,-20(s0)
    30c6:	0007871b          	sext.w	a4,a5
    30ca:	47cd                	li	a5,19
    30cc:	f8e7dce3          	bge	a5,a4,3064 <createdelete+0x2e4>
    }
  }
}
    30d0:	0001                	nop
    30d2:	0001                	nop
    30d4:	60e6                	ld	ra,88(sp)
    30d6:	6446                	ld	s0,80(sp)
    30d8:	6125                	addi	sp,sp,96
    30da:	8082                	ret

00000000000030dc <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(char *s)
{
    30dc:	7179                	addi	sp,sp,-48
    30de:	f406                	sd	ra,40(sp)
    30e0:	f022                	sd	s0,32(sp)
    30e2:	1800                	addi	s0,sp,48
    30e4:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd, fd1;

  fd = open("unlinkread", O_CREATE | O_RDWR);
    30e8:	20200593          	li	a1,514
    30ec:	00006517          	auipc	a0,0x6
    30f0:	98c50513          	addi	a0,a0,-1652 # 8a78 <malloc+0xd14>
    30f4:	00004097          	auipc	ra,0x4
    30f8:	55e080e7          	jalr	1374(ra) # 7652 <open>
    30fc:	87aa                	mv	a5,a0
    30fe:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3102:	fec42783          	lw	a5,-20(s0)
    3106:	2781                	sext.w	a5,a5
    3108:	0207d163          	bgez	a5,312a <unlinkread+0x4e>
    printf("%s: create unlinkread failed\n", s);
    310c:	fd843583          	ld	a1,-40(s0)
    3110:	00006517          	auipc	a0,0x6
    3114:	97850513          	addi	a0,a0,-1672 # 8a88 <malloc+0xd24>
    3118:	00005097          	auipc	ra,0x5
    311c:	a5a080e7          	jalr	-1446(ra) # 7b72 <printf>
    exit(1);
    3120:	4505                	li	a0,1
    3122:	00004097          	auipc	ra,0x4
    3126:	4f0080e7          	jalr	1264(ra) # 7612 <exit>
  }
  write(fd, "hello", SZ);
    312a:	fec42783          	lw	a5,-20(s0)
    312e:	4615                	li	a2,5
    3130:	00006597          	auipc	a1,0x6
    3134:	97858593          	addi	a1,a1,-1672 # 8aa8 <malloc+0xd44>
    3138:	853e                	mv	a0,a5
    313a:	00004097          	auipc	ra,0x4
    313e:	4f8080e7          	jalr	1272(ra) # 7632 <write>
  close(fd);
    3142:	fec42783          	lw	a5,-20(s0)
    3146:	853e                	mv	a0,a5
    3148:	00004097          	auipc	ra,0x4
    314c:	4f2080e7          	jalr	1266(ra) # 763a <close>

  fd = open("unlinkread", O_RDWR);
    3150:	4589                	li	a1,2
    3152:	00006517          	auipc	a0,0x6
    3156:	92650513          	addi	a0,a0,-1754 # 8a78 <malloc+0xd14>
    315a:	00004097          	auipc	ra,0x4
    315e:	4f8080e7          	jalr	1272(ra) # 7652 <open>
    3162:	87aa                	mv	a5,a0
    3164:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3168:	fec42783          	lw	a5,-20(s0)
    316c:	2781                	sext.w	a5,a5
    316e:	0207d163          	bgez	a5,3190 <unlinkread+0xb4>
    printf("%s: open unlinkread failed\n", s);
    3172:	fd843583          	ld	a1,-40(s0)
    3176:	00006517          	auipc	a0,0x6
    317a:	93a50513          	addi	a0,a0,-1734 # 8ab0 <malloc+0xd4c>
    317e:	00005097          	auipc	ra,0x5
    3182:	9f4080e7          	jalr	-1548(ra) # 7b72 <printf>
    exit(1);
    3186:	4505                	li	a0,1
    3188:	00004097          	auipc	ra,0x4
    318c:	48a080e7          	jalr	1162(ra) # 7612 <exit>
  }
  if(unlink("unlinkread") != 0){
    3190:	00006517          	auipc	a0,0x6
    3194:	8e850513          	addi	a0,a0,-1816 # 8a78 <malloc+0xd14>
    3198:	00004097          	auipc	ra,0x4
    319c:	4ca080e7          	jalr	1226(ra) # 7662 <unlink>
    31a0:	87aa                	mv	a5,a0
    31a2:	c385                	beqz	a5,31c2 <unlinkread+0xe6>
    printf("%s: unlink unlinkread failed\n", s);
    31a4:	fd843583          	ld	a1,-40(s0)
    31a8:	00006517          	auipc	a0,0x6
    31ac:	92850513          	addi	a0,a0,-1752 # 8ad0 <malloc+0xd6c>
    31b0:	00005097          	auipc	ra,0x5
    31b4:	9c2080e7          	jalr	-1598(ra) # 7b72 <printf>
    exit(1);
    31b8:	4505                	li	a0,1
    31ba:	00004097          	auipc	ra,0x4
    31be:	458080e7          	jalr	1112(ra) # 7612 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    31c2:	20200593          	li	a1,514
    31c6:	00006517          	auipc	a0,0x6
    31ca:	8b250513          	addi	a0,a0,-1870 # 8a78 <malloc+0xd14>
    31ce:	00004097          	auipc	ra,0x4
    31d2:	484080e7          	jalr	1156(ra) # 7652 <open>
    31d6:	87aa                	mv	a5,a0
    31d8:	fef42423          	sw	a5,-24(s0)
  write(fd1, "yyy", 3);
    31dc:	fe842783          	lw	a5,-24(s0)
    31e0:	460d                	li	a2,3
    31e2:	00006597          	auipc	a1,0x6
    31e6:	90e58593          	addi	a1,a1,-1778 # 8af0 <malloc+0xd8c>
    31ea:	853e                	mv	a0,a5
    31ec:	00004097          	auipc	ra,0x4
    31f0:	446080e7          	jalr	1094(ra) # 7632 <write>
  close(fd1);
    31f4:	fe842783          	lw	a5,-24(s0)
    31f8:	853e                	mv	a0,a5
    31fa:	00004097          	auipc	ra,0x4
    31fe:	440080e7          	jalr	1088(ra) # 763a <close>

  if(read(fd, buf, sizeof(buf)) != SZ){
    3202:	fec42783          	lw	a5,-20(s0)
    3206:	660d                	lui	a2,0x3
    3208:	00009597          	auipc	a1,0x9
    320c:	0d858593          	addi	a1,a1,216 # c2e0 <buf>
    3210:	853e                	mv	a0,a5
    3212:	00004097          	auipc	ra,0x4
    3216:	418080e7          	jalr	1048(ra) # 762a <read>
    321a:	87aa                	mv	a5,a0
    321c:	873e                	mv	a4,a5
    321e:	4795                	li	a5,5
    3220:	02f70163          	beq	a4,a5,3242 <unlinkread+0x166>
    printf("%s: unlinkread read failed", s);
    3224:	fd843583          	ld	a1,-40(s0)
    3228:	00006517          	auipc	a0,0x6
    322c:	8d050513          	addi	a0,a0,-1840 # 8af8 <malloc+0xd94>
    3230:	00005097          	auipc	ra,0x5
    3234:	942080e7          	jalr	-1726(ra) # 7b72 <printf>
    exit(1);
    3238:	4505                	li	a0,1
    323a:	00004097          	auipc	ra,0x4
    323e:	3d8080e7          	jalr	984(ra) # 7612 <exit>
  }
  if(buf[0] != 'h'){
    3242:	00009797          	auipc	a5,0x9
    3246:	09e78793          	addi	a5,a5,158 # c2e0 <buf>
    324a:	0007c783          	lbu	a5,0(a5)
    324e:	873e                	mv	a4,a5
    3250:	06800793          	li	a5,104
    3254:	02f70163          	beq	a4,a5,3276 <unlinkread+0x19a>
    printf("%s: unlinkread wrong data\n", s);
    3258:	fd843583          	ld	a1,-40(s0)
    325c:	00006517          	auipc	a0,0x6
    3260:	8bc50513          	addi	a0,a0,-1860 # 8b18 <malloc+0xdb4>
    3264:	00005097          	auipc	ra,0x5
    3268:	90e080e7          	jalr	-1778(ra) # 7b72 <printf>
    exit(1);
    326c:	4505                	li	a0,1
    326e:	00004097          	auipc	ra,0x4
    3272:	3a4080e7          	jalr	932(ra) # 7612 <exit>
  }
  if(write(fd, buf, 10) != 10){
    3276:	fec42783          	lw	a5,-20(s0)
    327a:	4629                	li	a2,10
    327c:	00009597          	auipc	a1,0x9
    3280:	06458593          	addi	a1,a1,100 # c2e0 <buf>
    3284:	853e                	mv	a0,a5
    3286:	00004097          	auipc	ra,0x4
    328a:	3ac080e7          	jalr	940(ra) # 7632 <write>
    328e:	87aa                	mv	a5,a0
    3290:	873e                	mv	a4,a5
    3292:	47a9                	li	a5,10
    3294:	02f70163          	beq	a4,a5,32b6 <unlinkread+0x1da>
    printf("%s: unlinkread write failed\n", s);
    3298:	fd843583          	ld	a1,-40(s0)
    329c:	00006517          	auipc	a0,0x6
    32a0:	89c50513          	addi	a0,a0,-1892 # 8b38 <malloc+0xdd4>
    32a4:	00005097          	auipc	ra,0x5
    32a8:	8ce080e7          	jalr	-1842(ra) # 7b72 <printf>
    exit(1);
    32ac:	4505                	li	a0,1
    32ae:	00004097          	auipc	ra,0x4
    32b2:	364080e7          	jalr	868(ra) # 7612 <exit>
  }
  close(fd);
    32b6:	fec42783          	lw	a5,-20(s0)
    32ba:	853e                	mv	a0,a5
    32bc:	00004097          	auipc	ra,0x4
    32c0:	37e080e7          	jalr	894(ra) # 763a <close>
  unlink("unlinkread");
    32c4:	00005517          	auipc	a0,0x5
    32c8:	7b450513          	addi	a0,a0,1972 # 8a78 <malloc+0xd14>
    32cc:	00004097          	auipc	ra,0x4
    32d0:	396080e7          	jalr	918(ra) # 7662 <unlink>
}
    32d4:	0001                	nop
    32d6:	70a2                	ld	ra,40(sp)
    32d8:	7402                	ld	s0,32(sp)
    32da:	6145                	addi	sp,sp,48
    32dc:	8082                	ret

00000000000032de <linktest>:

void
linktest(char *s)
{
    32de:	7179                	addi	sp,sp,-48
    32e0:	f406                	sd	ra,40(sp)
    32e2:	f022                	sd	s0,32(sp)
    32e4:	1800                	addi	s0,sp,48
    32e6:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd;

  unlink("lf1");
    32ea:	00006517          	auipc	a0,0x6
    32ee:	86e50513          	addi	a0,a0,-1938 # 8b58 <malloc+0xdf4>
    32f2:	00004097          	auipc	ra,0x4
    32f6:	370080e7          	jalr	880(ra) # 7662 <unlink>
  unlink("lf2");
    32fa:	00006517          	auipc	a0,0x6
    32fe:	86650513          	addi	a0,a0,-1946 # 8b60 <malloc+0xdfc>
    3302:	00004097          	auipc	ra,0x4
    3306:	360080e7          	jalr	864(ra) # 7662 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    330a:	20200593          	li	a1,514
    330e:	00006517          	auipc	a0,0x6
    3312:	84a50513          	addi	a0,a0,-1974 # 8b58 <malloc+0xdf4>
    3316:	00004097          	auipc	ra,0x4
    331a:	33c080e7          	jalr	828(ra) # 7652 <open>
    331e:	87aa                	mv	a5,a0
    3320:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3324:	fec42783          	lw	a5,-20(s0)
    3328:	2781                	sext.w	a5,a5
    332a:	0207d163          	bgez	a5,334c <linktest+0x6e>
    printf("%s: create lf1 failed\n", s);
    332e:	fd843583          	ld	a1,-40(s0)
    3332:	00006517          	auipc	a0,0x6
    3336:	83650513          	addi	a0,a0,-1994 # 8b68 <malloc+0xe04>
    333a:	00005097          	auipc	ra,0x5
    333e:	838080e7          	jalr	-1992(ra) # 7b72 <printf>
    exit(1);
    3342:	4505                	li	a0,1
    3344:	00004097          	auipc	ra,0x4
    3348:	2ce080e7          	jalr	718(ra) # 7612 <exit>
  }
  if(write(fd, "hello", SZ) != SZ){
    334c:	fec42783          	lw	a5,-20(s0)
    3350:	4615                	li	a2,5
    3352:	00005597          	auipc	a1,0x5
    3356:	75658593          	addi	a1,a1,1878 # 8aa8 <malloc+0xd44>
    335a:	853e                	mv	a0,a5
    335c:	00004097          	auipc	ra,0x4
    3360:	2d6080e7          	jalr	726(ra) # 7632 <write>
    3364:	87aa                	mv	a5,a0
    3366:	873e                	mv	a4,a5
    3368:	4795                	li	a5,5
    336a:	02f70163          	beq	a4,a5,338c <linktest+0xae>
    printf("%s: write lf1 failed\n", s);
    336e:	fd843583          	ld	a1,-40(s0)
    3372:	00006517          	auipc	a0,0x6
    3376:	80e50513          	addi	a0,a0,-2034 # 8b80 <malloc+0xe1c>
    337a:	00004097          	auipc	ra,0x4
    337e:	7f8080e7          	jalr	2040(ra) # 7b72 <printf>
    exit(1);
    3382:	4505                	li	a0,1
    3384:	00004097          	auipc	ra,0x4
    3388:	28e080e7          	jalr	654(ra) # 7612 <exit>
  }
  close(fd);
    338c:	fec42783          	lw	a5,-20(s0)
    3390:	853e                	mv	a0,a5
    3392:	00004097          	auipc	ra,0x4
    3396:	2a8080e7          	jalr	680(ra) # 763a <close>

  if(link("lf1", "lf2") < 0){
    339a:	00005597          	auipc	a1,0x5
    339e:	7c658593          	addi	a1,a1,1990 # 8b60 <malloc+0xdfc>
    33a2:	00005517          	auipc	a0,0x5
    33a6:	7b650513          	addi	a0,a0,1974 # 8b58 <malloc+0xdf4>
    33aa:	00004097          	auipc	ra,0x4
    33ae:	2c8080e7          	jalr	712(ra) # 7672 <link>
    33b2:	87aa                	mv	a5,a0
    33b4:	0207d163          	bgez	a5,33d6 <linktest+0xf8>
    printf("%s: link lf1 lf2 failed\n", s);
    33b8:	fd843583          	ld	a1,-40(s0)
    33bc:	00005517          	auipc	a0,0x5
    33c0:	7dc50513          	addi	a0,a0,2012 # 8b98 <malloc+0xe34>
    33c4:	00004097          	auipc	ra,0x4
    33c8:	7ae080e7          	jalr	1966(ra) # 7b72 <printf>
    exit(1);
    33cc:	4505                	li	a0,1
    33ce:	00004097          	auipc	ra,0x4
    33d2:	244080e7          	jalr	580(ra) # 7612 <exit>
  }
  unlink("lf1");
    33d6:	00005517          	auipc	a0,0x5
    33da:	78250513          	addi	a0,a0,1922 # 8b58 <malloc+0xdf4>
    33de:	00004097          	auipc	ra,0x4
    33e2:	284080e7          	jalr	644(ra) # 7662 <unlink>

  if(open("lf1", 0) >= 0){
    33e6:	4581                	li	a1,0
    33e8:	00005517          	auipc	a0,0x5
    33ec:	77050513          	addi	a0,a0,1904 # 8b58 <malloc+0xdf4>
    33f0:	00004097          	auipc	ra,0x4
    33f4:	262080e7          	jalr	610(ra) # 7652 <open>
    33f8:	87aa                	mv	a5,a0
    33fa:	0207c163          	bltz	a5,341c <linktest+0x13e>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    33fe:	fd843583          	ld	a1,-40(s0)
    3402:	00005517          	auipc	a0,0x5
    3406:	7b650513          	addi	a0,a0,1974 # 8bb8 <malloc+0xe54>
    340a:	00004097          	auipc	ra,0x4
    340e:	768080e7          	jalr	1896(ra) # 7b72 <printf>
    exit(1);
    3412:	4505                	li	a0,1
    3414:	00004097          	auipc	ra,0x4
    3418:	1fe080e7          	jalr	510(ra) # 7612 <exit>
  }

  fd = open("lf2", 0);
    341c:	4581                	li	a1,0
    341e:	00005517          	auipc	a0,0x5
    3422:	74250513          	addi	a0,a0,1858 # 8b60 <malloc+0xdfc>
    3426:	00004097          	auipc	ra,0x4
    342a:	22c080e7          	jalr	556(ra) # 7652 <open>
    342e:	87aa                	mv	a5,a0
    3430:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3434:	fec42783          	lw	a5,-20(s0)
    3438:	2781                	sext.w	a5,a5
    343a:	0207d163          	bgez	a5,345c <linktest+0x17e>
    printf("%s: open lf2 failed\n", s);
    343e:	fd843583          	ld	a1,-40(s0)
    3442:	00005517          	auipc	a0,0x5
    3446:	7a650513          	addi	a0,a0,1958 # 8be8 <malloc+0xe84>
    344a:	00004097          	auipc	ra,0x4
    344e:	728080e7          	jalr	1832(ra) # 7b72 <printf>
    exit(1);
    3452:	4505                	li	a0,1
    3454:	00004097          	auipc	ra,0x4
    3458:	1be080e7          	jalr	446(ra) # 7612 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != SZ){
    345c:	fec42783          	lw	a5,-20(s0)
    3460:	660d                	lui	a2,0x3
    3462:	00009597          	auipc	a1,0x9
    3466:	e7e58593          	addi	a1,a1,-386 # c2e0 <buf>
    346a:	853e                	mv	a0,a5
    346c:	00004097          	auipc	ra,0x4
    3470:	1be080e7          	jalr	446(ra) # 762a <read>
    3474:	87aa                	mv	a5,a0
    3476:	873e                	mv	a4,a5
    3478:	4795                	li	a5,5
    347a:	02f70163          	beq	a4,a5,349c <linktest+0x1be>
    printf("%s: read lf2 failed\n", s);
    347e:	fd843583          	ld	a1,-40(s0)
    3482:	00005517          	auipc	a0,0x5
    3486:	77e50513          	addi	a0,a0,1918 # 8c00 <malloc+0xe9c>
    348a:	00004097          	auipc	ra,0x4
    348e:	6e8080e7          	jalr	1768(ra) # 7b72 <printf>
    exit(1);
    3492:	4505                	li	a0,1
    3494:	00004097          	auipc	ra,0x4
    3498:	17e080e7          	jalr	382(ra) # 7612 <exit>
  }
  close(fd);
    349c:	fec42783          	lw	a5,-20(s0)
    34a0:	853e                	mv	a0,a5
    34a2:	00004097          	auipc	ra,0x4
    34a6:	198080e7          	jalr	408(ra) # 763a <close>

  if(link("lf2", "lf2") >= 0){
    34aa:	00005597          	auipc	a1,0x5
    34ae:	6b658593          	addi	a1,a1,1718 # 8b60 <malloc+0xdfc>
    34b2:	00005517          	auipc	a0,0x5
    34b6:	6ae50513          	addi	a0,a0,1710 # 8b60 <malloc+0xdfc>
    34ba:	00004097          	auipc	ra,0x4
    34be:	1b8080e7          	jalr	440(ra) # 7672 <link>
    34c2:	87aa                	mv	a5,a0
    34c4:	0207c163          	bltz	a5,34e6 <linktest+0x208>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    34c8:	fd843583          	ld	a1,-40(s0)
    34cc:	00005517          	auipc	a0,0x5
    34d0:	74c50513          	addi	a0,a0,1868 # 8c18 <malloc+0xeb4>
    34d4:	00004097          	auipc	ra,0x4
    34d8:	69e080e7          	jalr	1694(ra) # 7b72 <printf>
    exit(1);
    34dc:	4505                	li	a0,1
    34de:	00004097          	auipc	ra,0x4
    34e2:	134080e7          	jalr	308(ra) # 7612 <exit>
  }

  unlink("lf2");
    34e6:	00005517          	auipc	a0,0x5
    34ea:	67a50513          	addi	a0,a0,1658 # 8b60 <malloc+0xdfc>
    34ee:	00004097          	auipc	ra,0x4
    34f2:	174080e7          	jalr	372(ra) # 7662 <unlink>
  if(link("lf2", "lf1") >= 0){
    34f6:	00005597          	auipc	a1,0x5
    34fa:	66258593          	addi	a1,a1,1634 # 8b58 <malloc+0xdf4>
    34fe:	00005517          	auipc	a0,0x5
    3502:	66250513          	addi	a0,a0,1634 # 8b60 <malloc+0xdfc>
    3506:	00004097          	auipc	ra,0x4
    350a:	16c080e7          	jalr	364(ra) # 7672 <link>
    350e:	87aa                	mv	a5,a0
    3510:	0207c163          	bltz	a5,3532 <linktest+0x254>
    printf("%s: link non-existent succeeded! oops\n", s);
    3514:	fd843583          	ld	a1,-40(s0)
    3518:	00005517          	auipc	a0,0x5
    351c:	72850513          	addi	a0,a0,1832 # 8c40 <malloc+0xedc>
    3520:	00004097          	auipc	ra,0x4
    3524:	652080e7          	jalr	1618(ra) # 7b72 <printf>
    exit(1);
    3528:	4505                	li	a0,1
    352a:	00004097          	auipc	ra,0x4
    352e:	0e8080e7          	jalr	232(ra) # 7612 <exit>
  }

  if(link(".", "lf1") >= 0){
    3532:	00005597          	auipc	a1,0x5
    3536:	62658593          	addi	a1,a1,1574 # 8b58 <malloc+0xdf4>
    353a:	00005517          	auipc	a0,0x5
    353e:	72e50513          	addi	a0,a0,1838 # 8c68 <malloc+0xf04>
    3542:	00004097          	auipc	ra,0x4
    3546:	130080e7          	jalr	304(ra) # 7672 <link>
    354a:	87aa                	mv	a5,a0
    354c:	0207c163          	bltz	a5,356e <linktest+0x290>
    printf("%s: link . lf1 succeeded! oops\n", s);
    3550:	fd843583          	ld	a1,-40(s0)
    3554:	00005517          	auipc	a0,0x5
    3558:	71c50513          	addi	a0,a0,1820 # 8c70 <malloc+0xf0c>
    355c:	00004097          	auipc	ra,0x4
    3560:	616080e7          	jalr	1558(ra) # 7b72 <printf>
    exit(1);
    3564:	4505                	li	a0,1
    3566:	00004097          	auipc	ra,0x4
    356a:	0ac080e7          	jalr	172(ra) # 7612 <exit>
  }
}
    356e:	0001                	nop
    3570:	70a2                	ld	ra,40(sp)
    3572:	7402                	ld	s0,32(sp)
    3574:	6145                	addi	sp,sp,48
    3576:	8082                	ret

0000000000003578 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(char *s)
{
    3578:	7119                	addi	sp,sp,-128
    357a:	fc86                	sd	ra,120(sp)
    357c:	f8a2                	sd	s0,112(sp)
    357e:	0100                	addi	s0,sp,128
    3580:	f8a43423          	sd	a0,-120(s0)
  struct {
    ushort inum;
    char name[DIRSIZ];
  } de;

  file[0] = 'C';
    3584:	04300793          	li	a5,67
    3588:	fcf40c23          	sb	a5,-40(s0)
  file[2] = '\0';
    358c:	fc040d23          	sb	zero,-38(s0)
  for(i = 0; i < N; i++){
    3590:	fe042623          	sw	zero,-20(s0)
    3594:	a225                	j	36bc <concreate+0x144>
    file[1] = '0' + i;
    3596:	fec42783          	lw	a5,-20(s0)
    359a:	0ff7f793          	zext.b	a5,a5
    359e:	0307879b          	addiw	a5,a5,48
    35a2:	0ff7f793          	zext.b	a5,a5
    35a6:	fcf40ca3          	sb	a5,-39(s0)
    unlink(file);
    35aa:	fd840793          	addi	a5,s0,-40
    35ae:	853e                	mv	a0,a5
    35b0:	00004097          	auipc	ra,0x4
    35b4:	0b2080e7          	jalr	178(ra) # 7662 <unlink>
    pid = fork();
    35b8:	00004097          	auipc	ra,0x4
    35bc:	052080e7          	jalr	82(ra) # 760a <fork>
    35c0:	87aa                	mv	a5,a0
    35c2:	fef42023          	sw	a5,-32(s0)
    if(pid && (i % 3) == 1){
    35c6:	fe042783          	lw	a5,-32(s0)
    35ca:	2781                	sext.w	a5,a5
    35cc:	cb85                	beqz	a5,35fc <concreate+0x84>
    35ce:	fec42783          	lw	a5,-20(s0)
    35d2:	873e                	mv	a4,a5
    35d4:	478d                	li	a5,3
    35d6:	02f767bb          	remw	a5,a4,a5
    35da:	2781                	sext.w	a5,a5
    35dc:	873e                	mv	a4,a5
    35de:	4785                	li	a5,1
    35e0:	00f71e63          	bne	a4,a5,35fc <concreate+0x84>
      link("C0", file);
    35e4:	fd840793          	addi	a5,s0,-40
    35e8:	85be                	mv	a1,a5
    35ea:	00005517          	auipc	a0,0x5
    35ee:	6a650513          	addi	a0,a0,1702 # 8c90 <malloc+0xf2c>
    35f2:	00004097          	auipc	ra,0x4
    35f6:	080080e7          	jalr	128(ra) # 7672 <link>
    35fa:	a061                	j	3682 <concreate+0x10a>
    } else if(pid == 0 && (i % 5) == 1){
    35fc:	fe042783          	lw	a5,-32(s0)
    3600:	2781                	sext.w	a5,a5
    3602:	eb85                	bnez	a5,3632 <concreate+0xba>
    3604:	fec42783          	lw	a5,-20(s0)
    3608:	873e                	mv	a4,a5
    360a:	4795                	li	a5,5
    360c:	02f767bb          	remw	a5,a4,a5
    3610:	2781                	sext.w	a5,a5
    3612:	873e                	mv	a4,a5
    3614:	4785                	li	a5,1
    3616:	00f71e63          	bne	a4,a5,3632 <concreate+0xba>
      link("C0", file);
    361a:	fd840793          	addi	a5,s0,-40
    361e:	85be                	mv	a1,a5
    3620:	00005517          	auipc	a0,0x5
    3624:	67050513          	addi	a0,a0,1648 # 8c90 <malloc+0xf2c>
    3628:	00004097          	auipc	ra,0x4
    362c:	04a080e7          	jalr	74(ra) # 7672 <link>
    3630:	a889                	j	3682 <concreate+0x10a>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    3632:	fd840793          	addi	a5,s0,-40
    3636:	20200593          	li	a1,514
    363a:	853e                	mv	a0,a5
    363c:	00004097          	auipc	ra,0x4
    3640:	016080e7          	jalr	22(ra) # 7652 <open>
    3644:	87aa                	mv	a5,a0
    3646:	fef42223          	sw	a5,-28(s0)
      if(fd < 0){
    364a:	fe442783          	lw	a5,-28(s0)
    364e:	2781                	sext.w	a5,a5
    3650:	0207d263          	bgez	a5,3674 <concreate+0xfc>
        printf("concreate create %s failed\n", file);
    3654:	fd840793          	addi	a5,s0,-40
    3658:	85be                	mv	a1,a5
    365a:	00005517          	auipc	a0,0x5
    365e:	63e50513          	addi	a0,a0,1598 # 8c98 <malloc+0xf34>
    3662:	00004097          	auipc	ra,0x4
    3666:	510080e7          	jalr	1296(ra) # 7b72 <printf>
        exit(1);
    366a:	4505                	li	a0,1
    366c:	00004097          	auipc	ra,0x4
    3670:	fa6080e7          	jalr	-90(ra) # 7612 <exit>
      }
      close(fd);
    3674:	fe442783          	lw	a5,-28(s0)
    3678:	853e                	mv	a0,a5
    367a:	00004097          	auipc	ra,0x4
    367e:	fc0080e7          	jalr	-64(ra) # 763a <close>
    }
    if(pid == 0) {
    3682:	fe042783          	lw	a5,-32(s0)
    3686:	2781                	sext.w	a5,a5
    3688:	e791                	bnez	a5,3694 <concreate+0x11c>
      exit(0);
    368a:	4501                	li	a0,0
    368c:	00004097          	auipc	ra,0x4
    3690:	f86080e7          	jalr	-122(ra) # 7612 <exit>
    } else {
      int xstatus;
      wait(&xstatus);
    3694:	f9c40793          	addi	a5,s0,-100
    3698:	853e                	mv	a0,a5
    369a:	00004097          	auipc	ra,0x4
    369e:	f80080e7          	jalr	-128(ra) # 761a <wait>
      if(xstatus != 0)
    36a2:	f9c42783          	lw	a5,-100(s0)
    36a6:	c791                	beqz	a5,36b2 <concreate+0x13a>
        exit(1);
    36a8:	4505                	li	a0,1
    36aa:	00004097          	auipc	ra,0x4
    36ae:	f68080e7          	jalr	-152(ra) # 7612 <exit>
  for(i = 0; i < N; i++){
    36b2:	fec42783          	lw	a5,-20(s0)
    36b6:	2785                	addiw	a5,a5,1
    36b8:	fef42623          	sw	a5,-20(s0)
    36bc:	fec42783          	lw	a5,-20(s0)
    36c0:	0007871b          	sext.w	a4,a5
    36c4:	02700793          	li	a5,39
    36c8:	ece7d7e3          	bge	a5,a4,3596 <concreate+0x1e>
    }
  }

  memset(fa, 0, sizeof(fa));
    36cc:	fb040793          	addi	a5,s0,-80
    36d0:	02800613          	li	a2,40
    36d4:	4581                	li	a1,0
    36d6:	853e                	mv	a0,a5
    36d8:	00004097          	auipc	ra,0x4
    36dc:	b8e080e7          	jalr	-1138(ra) # 7266 <memset>
  fd = open(".", 0);
    36e0:	4581                	li	a1,0
    36e2:	00005517          	auipc	a0,0x5
    36e6:	58650513          	addi	a0,a0,1414 # 8c68 <malloc+0xf04>
    36ea:	00004097          	auipc	ra,0x4
    36ee:	f68080e7          	jalr	-152(ra) # 7652 <open>
    36f2:	87aa                	mv	a5,a0
    36f4:	fef42223          	sw	a5,-28(s0)
  n = 0;
    36f8:	fe042423          	sw	zero,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    36fc:	a865                	j	37b4 <concreate+0x23c>
    if(de.inum == 0)
    36fe:	fa045783          	lhu	a5,-96(s0)
    3702:	cbc5                	beqz	a5,37b2 <concreate+0x23a>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3704:	fa244783          	lbu	a5,-94(s0)
    3708:	873e                	mv	a4,a5
    370a:	04300793          	li	a5,67
    370e:	0af71363          	bne	a4,a5,37b4 <concreate+0x23c>
    3712:	fa444783          	lbu	a5,-92(s0)
    3716:	efd9                	bnez	a5,37b4 <concreate+0x23c>
      i = de.name[1] - '0';
    3718:	fa344783          	lbu	a5,-93(s0)
    371c:	2781                	sext.w	a5,a5
    371e:	fd07879b          	addiw	a5,a5,-48
    3722:	fef42623          	sw	a5,-20(s0)
      if(i < 0 || i >= sizeof(fa)){
    3726:	fec42783          	lw	a5,-20(s0)
    372a:	2781                	sext.w	a5,a5
    372c:	0007c963          	bltz	a5,373e <concreate+0x1c6>
    3730:	fec42783          	lw	a5,-20(s0)
    3734:	873e                	mv	a4,a5
    3736:	02700793          	li	a5,39
    373a:	02e7f563          	bgeu	a5,a4,3764 <concreate+0x1ec>
        printf("%s: concreate weird file %s\n", s, de.name);
    373e:	fa040793          	addi	a5,s0,-96
    3742:	0789                	addi	a5,a5,2
    3744:	863e                	mv	a2,a5
    3746:	f8843583          	ld	a1,-120(s0)
    374a:	00005517          	auipc	a0,0x5
    374e:	56e50513          	addi	a0,a0,1390 # 8cb8 <malloc+0xf54>
    3752:	00004097          	auipc	ra,0x4
    3756:	420080e7          	jalr	1056(ra) # 7b72 <printf>
        exit(1);
    375a:	4505                	li	a0,1
    375c:	00004097          	auipc	ra,0x4
    3760:	eb6080e7          	jalr	-330(ra) # 7612 <exit>
      }
      if(fa[i]){
    3764:	fec42783          	lw	a5,-20(s0)
    3768:	17c1                	addi	a5,a5,-16
    376a:	97a2                	add	a5,a5,s0
    376c:	fc07c783          	lbu	a5,-64(a5)
    3770:	c785                	beqz	a5,3798 <concreate+0x220>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    3772:	fa040793          	addi	a5,s0,-96
    3776:	0789                	addi	a5,a5,2
    3778:	863e                	mv	a2,a5
    377a:	f8843583          	ld	a1,-120(s0)
    377e:	00005517          	auipc	a0,0x5
    3782:	55a50513          	addi	a0,a0,1370 # 8cd8 <malloc+0xf74>
    3786:	00004097          	auipc	ra,0x4
    378a:	3ec080e7          	jalr	1004(ra) # 7b72 <printf>
        exit(1);
    378e:	4505                	li	a0,1
    3790:	00004097          	auipc	ra,0x4
    3794:	e82080e7          	jalr	-382(ra) # 7612 <exit>
      }
      fa[i] = 1;
    3798:	fec42783          	lw	a5,-20(s0)
    379c:	17c1                	addi	a5,a5,-16
    379e:	97a2                	add	a5,a5,s0
    37a0:	4705                	li	a4,1
    37a2:	fce78023          	sb	a4,-64(a5)
      n++;
    37a6:	fe842783          	lw	a5,-24(s0)
    37aa:	2785                	addiw	a5,a5,1
    37ac:	fef42423          	sw	a5,-24(s0)
    37b0:	a011                	j	37b4 <concreate+0x23c>
      continue;
    37b2:	0001                	nop
  while(read(fd, &de, sizeof(de)) > 0){
    37b4:	fa040713          	addi	a4,s0,-96
    37b8:	fe442783          	lw	a5,-28(s0)
    37bc:	4641                	li	a2,16
    37be:	85ba                	mv	a1,a4
    37c0:	853e                	mv	a0,a5
    37c2:	00004097          	auipc	ra,0x4
    37c6:	e68080e7          	jalr	-408(ra) # 762a <read>
    37ca:	87aa                	mv	a5,a0
    37cc:	f2f049e3          	bgtz	a5,36fe <concreate+0x186>
    }
  }
  close(fd);
    37d0:	fe442783          	lw	a5,-28(s0)
    37d4:	853e                	mv	a0,a5
    37d6:	00004097          	auipc	ra,0x4
    37da:	e64080e7          	jalr	-412(ra) # 763a <close>

  if(n != N){
    37de:	fe842783          	lw	a5,-24(s0)
    37e2:	0007871b          	sext.w	a4,a5
    37e6:	02800793          	li	a5,40
    37ea:	02f70163          	beq	a4,a5,380c <concreate+0x294>
    printf("%s: concreate not enough files in directory listing\n", s);
    37ee:	f8843583          	ld	a1,-120(s0)
    37f2:	00005517          	auipc	a0,0x5
    37f6:	50e50513          	addi	a0,a0,1294 # 8d00 <malloc+0xf9c>
    37fa:	00004097          	auipc	ra,0x4
    37fe:	378080e7          	jalr	888(ra) # 7b72 <printf>
    exit(1);
    3802:	4505                	li	a0,1
    3804:	00004097          	auipc	ra,0x4
    3808:	e0e080e7          	jalr	-498(ra) # 7612 <exit>
  }

  for(i = 0; i < N; i++){
    380c:	fe042623          	sw	zero,-20(s0)
    3810:	a25d                	j	39b6 <concreate+0x43e>
    file[1] = '0' + i;
    3812:	fec42783          	lw	a5,-20(s0)
    3816:	0ff7f793          	zext.b	a5,a5
    381a:	0307879b          	addiw	a5,a5,48
    381e:	0ff7f793          	zext.b	a5,a5
    3822:	fcf40ca3          	sb	a5,-39(s0)
    pid = fork();
    3826:	00004097          	auipc	ra,0x4
    382a:	de4080e7          	jalr	-540(ra) # 760a <fork>
    382e:	87aa                	mv	a5,a0
    3830:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    3834:	fe042783          	lw	a5,-32(s0)
    3838:	2781                	sext.w	a5,a5
    383a:	0207d163          	bgez	a5,385c <concreate+0x2e4>
      printf("%s: fork failed\n", s);
    383e:	f8843583          	ld	a1,-120(s0)
    3842:	00005517          	auipc	a0,0x5
    3846:	a9e50513          	addi	a0,a0,-1378 # 82e0 <malloc+0x57c>
    384a:	00004097          	auipc	ra,0x4
    384e:	328080e7          	jalr	808(ra) # 7b72 <printf>
      exit(1);
    3852:	4505                	li	a0,1
    3854:	00004097          	auipc	ra,0x4
    3858:	dbe080e7          	jalr	-578(ra) # 7612 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    385c:	fec42783          	lw	a5,-20(s0)
    3860:	873e                	mv	a4,a5
    3862:	478d                	li	a5,3
    3864:	02f767bb          	remw	a5,a4,a5
    3868:	2781                	sext.w	a5,a5
    386a:	e789                	bnez	a5,3874 <concreate+0x2fc>
    386c:	fe042783          	lw	a5,-32(s0)
    3870:	2781                	sext.w	a5,a5
    3872:	c385                	beqz	a5,3892 <concreate+0x31a>
       ((i % 3) == 1 && pid != 0)){
    3874:	fec42783          	lw	a5,-20(s0)
    3878:	873e                	mv	a4,a5
    387a:	478d                	li	a5,3
    387c:	02f767bb          	remw	a5,a4,a5
    3880:	2781                	sext.w	a5,a5
    if(((i % 3) == 0 && pid == 0) ||
    3882:	873e                	mv	a4,a5
    3884:	4785                	li	a5,1
    3886:	0af71b63          	bne	a4,a5,393c <concreate+0x3c4>
       ((i % 3) == 1 && pid != 0)){
    388a:	fe042783          	lw	a5,-32(s0)
    388e:	2781                	sext.w	a5,a5
    3890:	c7d5                	beqz	a5,393c <concreate+0x3c4>
      close(open(file, 0));
    3892:	fd840793          	addi	a5,s0,-40
    3896:	4581                	li	a1,0
    3898:	853e                	mv	a0,a5
    389a:	00004097          	auipc	ra,0x4
    389e:	db8080e7          	jalr	-584(ra) # 7652 <open>
    38a2:	87aa                	mv	a5,a0
    38a4:	853e                	mv	a0,a5
    38a6:	00004097          	auipc	ra,0x4
    38aa:	d94080e7          	jalr	-620(ra) # 763a <close>
      close(open(file, 0));
    38ae:	fd840793          	addi	a5,s0,-40
    38b2:	4581                	li	a1,0
    38b4:	853e                	mv	a0,a5
    38b6:	00004097          	auipc	ra,0x4
    38ba:	d9c080e7          	jalr	-612(ra) # 7652 <open>
    38be:	87aa                	mv	a5,a0
    38c0:	853e                	mv	a0,a5
    38c2:	00004097          	auipc	ra,0x4
    38c6:	d78080e7          	jalr	-648(ra) # 763a <close>
      close(open(file, 0));
    38ca:	fd840793          	addi	a5,s0,-40
    38ce:	4581                	li	a1,0
    38d0:	853e                	mv	a0,a5
    38d2:	00004097          	auipc	ra,0x4
    38d6:	d80080e7          	jalr	-640(ra) # 7652 <open>
    38da:	87aa                	mv	a5,a0
    38dc:	853e                	mv	a0,a5
    38de:	00004097          	auipc	ra,0x4
    38e2:	d5c080e7          	jalr	-676(ra) # 763a <close>
      close(open(file, 0));
    38e6:	fd840793          	addi	a5,s0,-40
    38ea:	4581                	li	a1,0
    38ec:	853e                	mv	a0,a5
    38ee:	00004097          	auipc	ra,0x4
    38f2:	d64080e7          	jalr	-668(ra) # 7652 <open>
    38f6:	87aa                	mv	a5,a0
    38f8:	853e                	mv	a0,a5
    38fa:	00004097          	auipc	ra,0x4
    38fe:	d40080e7          	jalr	-704(ra) # 763a <close>
      close(open(file, 0));
    3902:	fd840793          	addi	a5,s0,-40
    3906:	4581                	li	a1,0
    3908:	853e                	mv	a0,a5
    390a:	00004097          	auipc	ra,0x4
    390e:	d48080e7          	jalr	-696(ra) # 7652 <open>
    3912:	87aa                	mv	a5,a0
    3914:	853e                	mv	a0,a5
    3916:	00004097          	auipc	ra,0x4
    391a:	d24080e7          	jalr	-732(ra) # 763a <close>
      close(open(file, 0));
    391e:	fd840793          	addi	a5,s0,-40
    3922:	4581                	li	a1,0
    3924:	853e                	mv	a0,a5
    3926:	00004097          	auipc	ra,0x4
    392a:	d2c080e7          	jalr	-724(ra) # 7652 <open>
    392e:	87aa                	mv	a5,a0
    3930:	853e                	mv	a0,a5
    3932:	00004097          	auipc	ra,0x4
    3936:	d08080e7          	jalr	-760(ra) # 763a <close>
    393a:	a899                	j	3990 <concreate+0x418>
    } else {
      unlink(file);
    393c:	fd840793          	addi	a5,s0,-40
    3940:	853e                	mv	a0,a5
    3942:	00004097          	auipc	ra,0x4
    3946:	d20080e7          	jalr	-736(ra) # 7662 <unlink>
      unlink(file);
    394a:	fd840793          	addi	a5,s0,-40
    394e:	853e                	mv	a0,a5
    3950:	00004097          	auipc	ra,0x4
    3954:	d12080e7          	jalr	-750(ra) # 7662 <unlink>
      unlink(file);
    3958:	fd840793          	addi	a5,s0,-40
    395c:	853e                	mv	a0,a5
    395e:	00004097          	auipc	ra,0x4
    3962:	d04080e7          	jalr	-764(ra) # 7662 <unlink>
      unlink(file);
    3966:	fd840793          	addi	a5,s0,-40
    396a:	853e                	mv	a0,a5
    396c:	00004097          	auipc	ra,0x4
    3970:	cf6080e7          	jalr	-778(ra) # 7662 <unlink>
      unlink(file);
    3974:	fd840793          	addi	a5,s0,-40
    3978:	853e                	mv	a0,a5
    397a:	00004097          	auipc	ra,0x4
    397e:	ce8080e7          	jalr	-792(ra) # 7662 <unlink>
      unlink(file);
    3982:	fd840793          	addi	a5,s0,-40
    3986:	853e                	mv	a0,a5
    3988:	00004097          	auipc	ra,0x4
    398c:	cda080e7          	jalr	-806(ra) # 7662 <unlink>
    }
    if(pid == 0)
    3990:	fe042783          	lw	a5,-32(s0)
    3994:	2781                	sext.w	a5,a5
    3996:	e791                	bnez	a5,39a2 <concreate+0x42a>
      exit(0);
    3998:	4501                	li	a0,0
    399a:	00004097          	auipc	ra,0x4
    399e:	c78080e7          	jalr	-904(ra) # 7612 <exit>
    else
      wait(0);
    39a2:	4501                	li	a0,0
    39a4:	00004097          	auipc	ra,0x4
    39a8:	c76080e7          	jalr	-906(ra) # 761a <wait>
  for(i = 0; i < N; i++){
    39ac:	fec42783          	lw	a5,-20(s0)
    39b0:	2785                	addiw	a5,a5,1
    39b2:	fef42623          	sw	a5,-20(s0)
    39b6:	fec42783          	lw	a5,-20(s0)
    39ba:	0007871b          	sext.w	a4,a5
    39be:	02700793          	li	a5,39
    39c2:	e4e7d8e3          	bge	a5,a4,3812 <concreate+0x29a>
  }
}
    39c6:	0001                	nop
    39c8:	0001                	nop
    39ca:	70e6                	ld	ra,120(sp)
    39cc:	7446                	ld	s0,112(sp)
    39ce:	6109                	addi	sp,sp,128
    39d0:	8082                	ret

00000000000039d2 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink(char *s)
{
    39d2:	7179                	addi	sp,sp,-48
    39d4:	f406                	sd	ra,40(sp)
    39d6:	f022                	sd	s0,32(sp)
    39d8:	1800                	addi	s0,sp,48
    39da:	fca43c23          	sd	a0,-40(s0)
  int pid, i;

  unlink("x");
    39de:	00004517          	auipc	a0,0x4
    39e2:	5d250513          	addi	a0,a0,1490 # 7fb0 <malloc+0x24c>
    39e6:	00004097          	auipc	ra,0x4
    39ea:	c7c080e7          	jalr	-900(ra) # 7662 <unlink>
  pid = fork();
    39ee:	00004097          	auipc	ra,0x4
    39f2:	c1c080e7          	jalr	-996(ra) # 760a <fork>
    39f6:	87aa                	mv	a5,a0
    39f8:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
    39fc:	fe442783          	lw	a5,-28(s0)
    3a00:	2781                	sext.w	a5,a5
    3a02:	0207d163          	bgez	a5,3a24 <linkunlink+0x52>
    printf("%s: fork failed\n", s);
    3a06:	fd843583          	ld	a1,-40(s0)
    3a0a:	00005517          	auipc	a0,0x5
    3a0e:	8d650513          	addi	a0,a0,-1834 # 82e0 <malloc+0x57c>
    3a12:	00004097          	auipc	ra,0x4
    3a16:	160080e7          	jalr	352(ra) # 7b72 <printf>
    exit(1);
    3a1a:	4505                	li	a0,1
    3a1c:	00004097          	auipc	ra,0x4
    3a20:	bf6080e7          	jalr	-1034(ra) # 7612 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    3a24:	fe442783          	lw	a5,-28(s0)
    3a28:	2781                	sext.w	a5,a5
    3a2a:	c399                	beqz	a5,3a30 <linkunlink+0x5e>
    3a2c:	4785                	li	a5,1
    3a2e:	a019                	j	3a34 <linkunlink+0x62>
    3a30:	06100793          	li	a5,97
    3a34:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 100; i++){
    3a38:	fe042623          	sw	zero,-20(s0)
    3a3c:	a045                	j	3adc <linkunlink+0x10a>
    x = x * 1103515245 + 12345;
    3a3e:	fe842783          	lw	a5,-24(s0)
    3a42:	873e                	mv	a4,a5
    3a44:	41c657b7          	lui	a5,0x41c65
    3a48:	e6d7879b          	addiw	a5,a5,-403 # 41c64e6d <freep+0x41c52365>
    3a4c:	02f707bb          	mulw	a5,a4,a5
    3a50:	0007871b          	sext.w	a4,a5
    3a54:	678d                	lui	a5,0x3
    3a56:	0397879b          	addiw	a5,a5,57 # 3039 <createdelete+0x2b9>
    3a5a:	9fb9                	addw	a5,a5,a4
    3a5c:	fef42423          	sw	a5,-24(s0)
    if((x % 3) == 0){
    3a60:	fe842783          	lw	a5,-24(s0)
    3a64:	873e                	mv	a4,a5
    3a66:	478d                	li	a5,3
    3a68:	02f777bb          	remuw	a5,a4,a5
    3a6c:	2781                	sext.w	a5,a5
    3a6e:	e395                	bnez	a5,3a92 <linkunlink+0xc0>
      close(open("x", O_RDWR | O_CREATE));
    3a70:	20200593          	li	a1,514
    3a74:	00004517          	auipc	a0,0x4
    3a78:	53c50513          	addi	a0,a0,1340 # 7fb0 <malloc+0x24c>
    3a7c:	00004097          	auipc	ra,0x4
    3a80:	bd6080e7          	jalr	-1066(ra) # 7652 <open>
    3a84:	87aa                	mv	a5,a0
    3a86:	853e                	mv	a0,a5
    3a88:	00004097          	auipc	ra,0x4
    3a8c:	bb2080e7          	jalr	-1102(ra) # 763a <close>
    3a90:	a089                	j	3ad2 <linkunlink+0x100>
    } else if((x % 3) == 1){
    3a92:	fe842783          	lw	a5,-24(s0)
    3a96:	873e                	mv	a4,a5
    3a98:	478d                	li	a5,3
    3a9a:	02f777bb          	remuw	a5,a4,a5
    3a9e:	2781                	sext.w	a5,a5
    3aa0:	873e                	mv	a4,a5
    3aa2:	4785                	li	a5,1
    3aa4:	00f71f63          	bne	a4,a5,3ac2 <linkunlink+0xf0>
      link("cat", "x");
    3aa8:	00004597          	auipc	a1,0x4
    3aac:	50858593          	addi	a1,a1,1288 # 7fb0 <malloc+0x24c>
    3ab0:	00005517          	auipc	a0,0x5
    3ab4:	28850513          	addi	a0,a0,648 # 8d38 <malloc+0xfd4>
    3ab8:	00004097          	auipc	ra,0x4
    3abc:	bba080e7          	jalr	-1094(ra) # 7672 <link>
    3ac0:	a809                	j	3ad2 <linkunlink+0x100>
    } else {
      unlink("x");
    3ac2:	00004517          	auipc	a0,0x4
    3ac6:	4ee50513          	addi	a0,a0,1262 # 7fb0 <malloc+0x24c>
    3aca:	00004097          	auipc	ra,0x4
    3ace:	b98080e7          	jalr	-1128(ra) # 7662 <unlink>
  for(i = 0; i < 100; i++){
    3ad2:	fec42783          	lw	a5,-20(s0)
    3ad6:	2785                	addiw	a5,a5,1
    3ad8:	fef42623          	sw	a5,-20(s0)
    3adc:	fec42783          	lw	a5,-20(s0)
    3ae0:	0007871b          	sext.w	a4,a5
    3ae4:	06300793          	li	a5,99
    3ae8:	f4e7dbe3          	bge	a5,a4,3a3e <linkunlink+0x6c>
    }
  }

  if(pid)
    3aec:	fe442783          	lw	a5,-28(s0)
    3af0:	2781                	sext.w	a5,a5
    3af2:	c799                	beqz	a5,3b00 <linkunlink+0x12e>
    wait(0);
    3af4:	4501                	li	a0,0
    3af6:	00004097          	auipc	ra,0x4
    3afa:	b24080e7          	jalr	-1244(ra) # 761a <wait>
  else
    exit(0);
}
    3afe:	a031                	j	3b0a <linkunlink+0x138>
    exit(0);
    3b00:	4501                	li	a0,0
    3b02:	00004097          	auipc	ra,0x4
    3b06:	b10080e7          	jalr	-1264(ra) # 7612 <exit>
}
    3b0a:	70a2                	ld	ra,40(sp)
    3b0c:	7402                	ld	s0,32(sp)
    3b0e:	6145                	addi	sp,sp,48
    3b10:	8082                	ret

0000000000003b12 <subdir>:


void
subdir(char *s)
{
    3b12:	7179                	addi	sp,sp,-48
    3b14:	f406                	sd	ra,40(sp)
    3b16:	f022                	sd	s0,32(sp)
    3b18:	1800                	addi	s0,sp,48
    3b1a:	fca43c23          	sd	a0,-40(s0)
  int fd, cc;

  unlink("ff");
    3b1e:	00005517          	auipc	a0,0x5
    3b22:	22250513          	addi	a0,a0,546 # 8d40 <malloc+0xfdc>
    3b26:	00004097          	auipc	ra,0x4
    3b2a:	b3c080e7          	jalr	-1220(ra) # 7662 <unlink>
  if(mkdir("dd") != 0){
    3b2e:	00005517          	auipc	a0,0x5
    3b32:	21a50513          	addi	a0,a0,538 # 8d48 <malloc+0xfe4>
    3b36:	00004097          	auipc	ra,0x4
    3b3a:	b44080e7          	jalr	-1212(ra) # 767a <mkdir>
    3b3e:	87aa                	mv	a5,a0
    3b40:	c385                	beqz	a5,3b60 <subdir+0x4e>
    printf("%s: mkdir dd failed\n", s);
    3b42:	fd843583          	ld	a1,-40(s0)
    3b46:	00005517          	auipc	a0,0x5
    3b4a:	20a50513          	addi	a0,a0,522 # 8d50 <malloc+0xfec>
    3b4e:	00004097          	auipc	ra,0x4
    3b52:	024080e7          	jalr	36(ra) # 7b72 <printf>
    exit(1);
    3b56:	4505                	li	a0,1
    3b58:	00004097          	auipc	ra,0x4
    3b5c:	aba080e7          	jalr	-1350(ra) # 7612 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3b60:	20200593          	li	a1,514
    3b64:	00005517          	auipc	a0,0x5
    3b68:	20450513          	addi	a0,a0,516 # 8d68 <malloc+0x1004>
    3b6c:	00004097          	auipc	ra,0x4
    3b70:	ae6080e7          	jalr	-1306(ra) # 7652 <open>
    3b74:	87aa                	mv	a5,a0
    3b76:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3b7a:	fec42783          	lw	a5,-20(s0)
    3b7e:	2781                	sext.w	a5,a5
    3b80:	0207d163          	bgez	a5,3ba2 <subdir+0x90>
    printf("%s: create dd/ff failed\n", s);
    3b84:	fd843583          	ld	a1,-40(s0)
    3b88:	00005517          	auipc	a0,0x5
    3b8c:	1e850513          	addi	a0,a0,488 # 8d70 <malloc+0x100c>
    3b90:	00004097          	auipc	ra,0x4
    3b94:	fe2080e7          	jalr	-30(ra) # 7b72 <printf>
    exit(1);
    3b98:	4505                	li	a0,1
    3b9a:	00004097          	auipc	ra,0x4
    3b9e:	a78080e7          	jalr	-1416(ra) # 7612 <exit>
  }
  write(fd, "ff", 2);
    3ba2:	fec42783          	lw	a5,-20(s0)
    3ba6:	4609                	li	a2,2
    3ba8:	00005597          	auipc	a1,0x5
    3bac:	19858593          	addi	a1,a1,408 # 8d40 <malloc+0xfdc>
    3bb0:	853e                	mv	a0,a5
    3bb2:	00004097          	auipc	ra,0x4
    3bb6:	a80080e7          	jalr	-1408(ra) # 7632 <write>
  close(fd);
    3bba:	fec42783          	lw	a5,-20(s0)
    3bbe:	853e                	mv	a0,a5
    3bc0:	00004097          	auipc	ra,0x4
    3bc4:	a7a080e7          	jalr	-1414(ra) # 763a <close>

  if(unlink("dd") >= 0){
    3bc8:	00005517          	auipc	a0,0x5
    3bcc:	18050513          	addi	a0,a0,384 # 8d48 <malloc+0xfe4>
    3bd0:	00004097          	auipc	ra,0x4
    3bd4:	a92080e7          	jalr	-1390(ra) # 7662 <unlink>
    3bd8:	87aa                	mv	a5,a0
    3bda:	0207c163          	bltz	a5,3bfc <subdir+0xea>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3bde:	fd843583          	ld	a1,-40(s0)
    3be2:	00005517          	auipc	a0,0x5
    3be6:	1ae50513          	addi	a0,a0,430 # 8d90 <malloc+0x102c>
    3bea:	00004097          	auipc	ra,0x4
    3bee:	f88080e7          	jalr	-120(ra) # 7b72 <printf>
    exit(1);
    3bf2:	4505                	li	a0,1
    3bf4:	00004097          	auipc	ra,0x4
    3bf8:	a1e080e7          	jalr	-1506(ra) # 7612 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    3bfc:	00005517          	auipc	a0,0x5
    3c00:	1c450513          	addi	a0,a0,452 # 8dc0 <malloc+0x105c>
    3c04:	00004097          	auipc	ra,0x4
    3c08:	a76080e7          	jalr	-1418(ra) # 767a <mkdir>
    3c0c:	87aa                	mv	a5,a0
    3c0e:	c385                	beqz	a5,3c2e <subdir+0x11c>
    printf("subdir mkdir dd/dd failed\n", s);
    3c10:	fd843583          	ld	a1,-40(s0)
    3c14:	00005517          	auipc	a0,0x5
    3c18:	1b450513          	addi	a0,a0,436 # 8dc8 <malloc+0x1064>
    3c1c:	00004097          	auipc	ra,0x4
    3c20:	f56080e7          	jalr	-170(ra) # 7b72 <printf>
    exit(1);
    3c24:	4505                	li	a0,1
    3c26:	00004097          	auipc	ra,0x4
    3c2a:	9ec080e7          	jalr	-1556(ra) # 7612 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3c2e:	20200593          	li	a1,514
    3c32:	00005517          	auipc	a0,0x5
    3c36:	1b650513          	addi	a0,a0,438 # 8de8 <malloc+0x1084>
    3c3a:	00004097          	auipc	ra,0x4
    3c3e:	a18080e7          	jalr	-1512(ra) # 7652 <open>
    3c42:	87aa                	mv	a5,a0
    3c44:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3c48:	fec42783          	lw	a5,-20(s0)
    3c4c:	2781                	sext.w	a5,a5
    3c4e:	0207d163          	bgez	a5,3c70 <subdir+0x15e>
    printf("%s: create dd/dd/ff failed\n", s);
    3c52:	fd843583          	ld	a1,-40(s0)
    3c56:	00005517          	auipc	a0,0x5
    3c5a:	1a250513          	addi	a0,a0,418 # 8df8 <malloc+0x1094>
    3c5e:	00004097          	auipc	ra,0x4
    3c62:	f14080e7          	jalr	-236(ra) # 7b72 <printf>
    exit(1);
    3c66:	4505                	li	a0,1
    3c68:	00004097          	auipc	ra,0x4
    3c6c:	9aa080e7          	jalr	-1622(ra) # 7612 <exit>
  }
  write(fd, "FF", 2);
    3c70:	fec42783          	lw	a5,-20(s0)
    3c74:	4609                	li	a2,2
    3c76:	00005597          	auipc	a1,0x5
    3c7a:	1a258593          	addi	a1,a1,418 # 8e18 <malloc+0x10b4>
    3c7e:	853e                	mv	a0,a5
    3c80:	00004097          	auipc	ra,0x4
    3c84:	9b2080e7          	jalr	-1614(ra) # 7632 <write>
  close(fd);
    3c88:	fec42783          	lw	a5,-20(s0)
    3c8c:	853e                	mv	a0,a5
    3c8e:	00004097          	auipc	ra,0x4
    3c92:	9ac080e7          	jalr	-1620(ra) # 763a <close>

  fd = open("dd/dd/../ff", 0);
    3c96:	4581                	li	a1,0
    3c98:	00005517          	auipc	a0,0x5
    3c9c:	18850513          	addi	a0,a0,392 # 8e20 <malloc+0x10bc>
    3ca0:	00004097          	auipc	ra,0x4
    3ca4:	9b2080e7          	jalr	-1614(ra) # 7652 <open>
    3ca8:	87aa                	mv	a5,a0
    3caa:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3cae:	fec42783          	lw	a5,-20(s0)
    3cb2:	2781                	sext.w	a5,a5
    3cb4:	0207d163          	bgez	a5,3cd6 <subdir+0x1c4>
    printf("%s: open dd/dd/../ff failed\n", s);
    3cb8:	fd843583          	ld	a1,-40(s0)
    3cbc:	00005517          	auipc	a0,0x5
    3cc0:	17450513          	addi	a0,a0,372 # 8e30 <malloc+0x10cc>
    3cc4:	00004097          	auipc	ra,0x4
    3cc8:	eae080e7          	jalr	-338(ra) # 7b72 <printf>
    exit(1);
    3ccc:	4505                	li	a0,1
    3cce:	00004097          	auipc	ra,0x4
    3cd2:	944080e7          	jalr	-1724(ra) # 7612 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    3cd6:	fec42783          	lw	a5,-20(s0)
    3cda:	660d                	lui	a2,0x3
    3cdc:	00008597          	auipc	a1,0x8
    3ce0:	60458593          	addi	a1,a1,1540 # c2e0 <buf>
    3ce4:	853e                	mv	a0,a5
    3ce6:	00004097          	auipc	ra,0x4
    3cea:	944080e7          	jalr	-1724(ra) # 762a <read>
    3cee:	87aa                	mv	a5,a0
    3cf0:	fef42423          	sw	a5,-24(s0)
  if(cc != 2 || buf[0] != 'f'){
    3cf4:	fe842783          	lw	a5,-24(s0)
    3cf8:	0007871b          	sext.w	a4,a5
    3cfc:	4789                	li	a5,2
    3cfe:	00f71d63          	bne	a4,a5,3d18 <subdir+0x206>
    3d02:	00008797          	auipc	a5,0x8
    3d06:	5de78793          	addi	a5,a5,1502 # c2e0 <buf>
    3d0a:	0007c783          	lbu	a5,0(a5)
    3d0e:	873e                	mv	a4,a5
    3d10:	06600793          	li	a5,102
    3d14:	02f70163          	beq	a4,a5,3d36 <subdir+0x224>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3d18:	fd843583          	ld	a1,-40(s0)
    3d1c:	00005517          	auipc	a0,0x5
    3d20:	13450513          	addi	a0,a0,308 # 8e50 <malloc+0x10ec>
    3d24:	00004097          	auipc	ra,0x4
    3d28:	e4e080e7          	jalr	-434(ra) # 7b72 <printf>
    exit(1);
    3d2c:	4505                	li	a0,1
    3d2e:	00004097          	auipc	ra,0x4
    3d32:	8e4080e7          	jalr	-1820(ra) # 7612 <exit>
  }
  close(fd);
    3d36:	fec42783          	lw	a5,-20(s0)
    3d3a:	853e                	mv	a0,a5
    3d3c:	00004097          	auipc	ra,0x4
    3d40:	8fe080e7          	jalr	-1794(ra) # 763a <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3d44:	00005597          	auipc	a1,0x5
    3d48:	12c58593          	addi	a1,a1,300 # 8e70 <malloc+0x110c>
    3d4c:	00005517          	auipc	a0,0x5
    3d50:	09c50513          	addi	a0,a0,156 # 8de8 <malloc+0x1084>
    3d54:	00004097          	auipc	ra,0x4
    3d58:	91e080e7          	jalr	-1762(ra) # 7672 <link>
    3d5c:	87aa                	mv	a5,a0
    3d5e:	c385                	beqz	a5,3d7e <subdir+0x26c>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3d60:	fd843583          	ld	a1,-40(s0)
    3d64:	00005517          	auipc	a0,0x5
    3d68:	11c50513          	addi	a0,a0,284 # 8e80 <malloc+0x111c>
    3d6c:	00004097          	auipc	ra,0x4
    3d70:	e06080e7          	jalr	-506(ra) # 7b72 <printf>
    exit(1);
    3d74:	4505                	li	a0,1
    3d76:	00004097          	auipc	ra,0x4
    3d7a:	89c080e7          	jalr	-1892(ra) # 7612 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    3d7e:	00005517          	auipc	a0,0x5
    3d82:	06a50513          	addi	a0,a0,106 # 8de8 <malloc+0x1084>
    3d86:	00004097          	auipc	ra,0x4
    3d8a:	8dc080e7          	jalr	-1828(ra) # 7662 <unlink>
    3d8e:	87aa                	mv	a5,a0
    3d90:	c385                	beqz	a5,3db0 <subdir+0x29e>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3d92:	fd843583          	ld	a1,-40(s0)
    3d96:	00005517          	auipc	a0,0x5
    3d9a:	11250513          	addi	a0,a0,274 # 8ea8 <malloc+0x1144>
    3d9e:	00004097          	auipc	ra,0x4
    3da2:	dd4080e7          	jalr	-556(ra) # 7b72 <printf>
    exit(1);
    3da6:	4505                	li	a0,1
    3da8:	00004097          	auipc	ra,0x4
    3dac:	86a080e7          	jalr	-1942(ra) # 7612 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3db0:	4581                	li	a1,0
    3db2:	00005517          	auipc	a0,0x5
    3db6:	03650513          	addi	a0,a0,54 # 8de8 <malloc+0x1084>
    3dba:	00004097          	auipc	ra,0x4
    3dbe:	898080e7          	jalr	-1896(ra) # 7652 <open>
    3dc2:	87aa                	mv	a5,a0
    3dc4:	0207c163          	bltz	a5,3de6 <subdir+0x2d4>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3dc8:	fd843583          	ld	a1,-40(s0)
    3dcc:	00005517          	auipc	a0,0x5
    3dd0:	0fc50513          	addi	a0,a0,252 # 8ec8 <malloc+0x1164>
    3dd4:	00004097          	auipc	ra,0x4
    3dd8:	d9e080e7          	jalr	-610(ra) # 7b72 <printf>
    exit(1);
    3ddc:	4505                	li	a0,1
    3dde:	00004097          	auipc	ra,0x4
    3de2:	834080e7          	jalr	-1996(ra) # 7612 <exit>
  }

  if(chdir("dd") != 0){
    3de6:	00005517          	auipc	a0,0x5
    3dea:	f6250513          	addi	a0,a0,-158 # 8d48 <malloc+0xfe4>
    3dee:	00004097          	auipc	ra,0x4
    3df2:	894080e7          	jalr	-1900(ra) # 7682 <chdir>
    3df6:	87aa                	mv	a5,a0
    3df8:	c385                	beqz	a5,3e18 <subdir+0x306>
    printf("%s: chdir dd failed\n", s);
    3dfa:	fd843583          	ld	a1,-40(s0)
    3dfe:	00005517          	auipc	a0,0x5
    3e02:	0f250513          	addi	a0,a0,242 # 8ef0 <malloc+0x118c>
    3e06:	00004097          	auipc	ra,0x4
    3e0a:	d6c080e7          	jalr	-660(ra) # 7b72 <printf>
    exit(1);
    3e0e:	4505                	li	a0,1
    3e10:	00004097          	auipc	ra,0x4
    3e14:	802080e7          	jalr	-2046(ra) # 7612 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    3e18:	00005517          	auipc	a0,0x5
    3e1c:	0f050513          	addi	a0,a0,240 # 8f08 <malloc+0x11a4>
    3e20:	00004097          	auipc	ra,0x4
    3e24:	862080e7          	jalr	-1950(ra) # 7682 <chdir>
    3e28:	87aa                	mv	a5,a0
    3e2a:	c385                	beqz	a5,3e4a <subdir+0x338>
    printf("%s: chdir dd/../../dd failed\n", s);
    3e2c:	fd843583          	ld	a1,-40(s0)
    3e30:	00005517          	auipc	a0,0x5
    3e34:	0e850513          	addi	a0,a0,232 # 8f18 <malloc+0x11b4>
    3e38:	00004097          	auipc	ra,0x4
    3e3c:	d3a080e7          	jalr	-710(ra) # 7b72 <printf>
    exit(1);
    3e40:	4505                	li	a0,1
    3e42:	00003097          	auipc	ra,0x3
    3e46:	7d0080e7          	jalr	2000(ra) # 7612 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    3e4a:	00005517          	auipc	a0,0x5
    3e4e:	0ee50513          	addi	a0,a0,238 # 8f38 <malloc+0x11d4>
    3e52:	00004097          	auipc	ra,0x4
    3e56:	830080e7          	jalr	-2000(ra) # 7682 <chdir>
    3e5a:	87aa                	mv	a5,a0
    3e5c:	c385                	beqz	a5,3e7c <subdir+0x36a>
    printf("chdir dd/../../dd failed\n", s);
    3e5e:	fd843583          	ld	a1,-40(s0)
    3e62:	00005517          	auipc	a0,0x5
    3e66:	0e650513          	addi	a0,a0,230 # 8f48 <malloc+0x11e4>
    3e6a:	00004097          	auipc	ra,0x4
    3e6e:	d08080e7          	jalr	-760(ra) # 7b72 <printf>
    exit(1);
    3e72:	4505                	li	a0,1
    3e74:	00003097          	auipc	ra,0x3
    3e78:	79e080e7          	jalr	1950(ra) # 7612 <exit>
  }
  if(chdir("./..") != 0){
    3e7c:	00005517          	auipc	a0,0x5
    3e80:	0ec50513          	addi	a0,a0,236 # 8f68 <malloc+0x1204>
    3e84:	00003097          	auipc	ra,0x3
    3e88:	7fe080e7          	jalr	2046(ra) # 7682 <chdir>
    3e8c:	87aa                	mv	a5,a0
    3e8e:	c385                	beqz	a5,3eae <subdir+0x39c>
    printf("%s: chdir ./.. failed\n", s);
    3e90:	fd843583          	ld	a1,-40(s0)
    3e94:	00005517          	auipc	a0,0x5
    3e98:	0dc50513          	addi	a0,a0,220 # 8f70 <malloc+0x120c>
    3e9c:	00004097          	auipc	ra,0x4
    3ea0:	cd6080e7          	jalr	-810(ra) # 7b72 <printf>
    exit(1);
    3ea4:	4505                	li	a0,1
    3ea6:	00003097          	auipc	ra,0x3
    3eaa:	76c080e7          	jalr	1900(ra) # 7612 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    3eae:	4581                	li	a1,0
    3eb0:	00005517          	auipc	a0,0x5
    3eb4:	fc050513          	addi	a0,a0,-64 # 8e70 <malloc+0x110c>
    3eb8:	00003097          	auipc	ra,0x3
    3ebc:	79a080e7          	jalr	1946(ra) # 7652 <open>
    3ec0:	87aa                	mv	a5,a0
    3ec2:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3ec6:	fec42783          	lw	a5,-20(s0)
    3eca:	2781                	sext.w	a5,a5
    3ecc:	0207d163          	bgez	a5,3eee <subdir+0x3dc>
    printf("%s: open dd/dd/ffff failed\n", s);
    3ed0:	fd843583          	ld	a1,-40(s0)
    3ed4:	00005517          	auipc	a0,0x5
    3ed8:	0b450513          	addi	a0,a0,180 # 8f88 <malloc+0x1224>
    3edc:	00004097          	auipc	ra,0x4
    3ee0:	c96080e7          	jalr	-874(ra) # 7b72 <printf>
    exit(1);
    3ee4:	4505                	li	a0,1
    3ee6:	00003097          	auipc	ra,0x3
    3eea:	72c080e7          	jalr	1836(ra) # 7612 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    3eee:	fec42783          	lw	a5,-20(s0)
    3ef2:	660d                	lui	a2,0x3
    3ef4:	00008597          	auipc	a1,0x8
    3ef8:	3ec58593          	addi	a1,a1,1004 # c2e0 <buf>
    3efc:	853e                	mv	a0,a5
    3efe:	00003097          	auipc	ra,0x3
    3f02:	72c080e7          	jalr	1836(ra) # 762a <read>
    3f06:	87aa                	mv	a5,a0
    3f08:	873e                	mv	a4,a5
    3f0a:	4789                	li	a5,2
    3f0c:	02f70163          	beq	a4,a5,3f2e <subdir+0x41c>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3f10:	fd843583          	ld	a1,-40(s0)
    3f14:	00005517          	auipc	a0,0x5
    3f18:	09450513          	addi	a0,a0,148 # 8fa8 <malloc+0x1244>
    3f1c:	00004097          	auipc	ra,0x4
    3f20:	c56080e7          	jalr	-938(ra) # 7b72 <printf>
    exit(1);
    3f24:	4505                	li	a0,1
    3f26:	00003097          	auipc	ra,0x3
    3f2a:	6ec080e7          	jalr	1772(ra) # 7612 <exit>
  }
  close(fd);
    3f2e:	fec42783          	lw	a5,-20(s0)
    3f32:	853e                	mv	a0,a5
    3f34:	00003097          	auipc	ra,0x3
    3f38:	706080e7          	jalr	1798(ra) # 763a <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3f3c:	4581                	li	a1,0
    3f3e:	00005517          	auipc	a0,0x5
    3f42:	eaa50513          	addi	a0,a0,-342 # 8de8 <malloc+0x1084>
    3f46:	00003097          	auipc	ra,0x3
    3f4a:	70c080e7          	jalr	1804(ra) # 7652 <open>
    3f4e:	87aa                	mv	a5,a0
    3f50:	0207c163          	bltz	a5,3f72 <subdir+0x460>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3f54:	fd843583          	ld	a1,-40(s0)
    3f58:	00005517          	auipc	a0,0x5
    3f5c:	07050513          	addi	a0,a0,112 # 8fc8 <malloc+0x1264>
    3f60:	00004097          	auipc	ra,0x4
    3f64:	c12080e7          	jalr	-1006(ra) # 7b72 <printf>
    exit(1);
    3f68:	4505                	li	a0,1
    3f6a:	00003097          	auipc	ra,0x3
    3f6e:	6a8080e7          	jalr	1704(ra) # 7612 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3f72:	20200593          	li	a1,514
    3f76:	00005517          	auipc	a0,0x5
    3f7a:	08250513          	addi	a0,a0,130 # 8ff8 <malloc+0x1294>
    3f7e:	00003097          	auipc	ra,0x3
    3f82:	6d4080e7          	jalr	1748(ra) # 7652 <open>
    3f86:	87aa                	mv	a5,a0
    3f88:	0207c163          	bltz	a5,3faa <subdir+0x498>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3f8c:	fd843583          	ld	a1,-40(s0)
    3f90:	00005517          	auipc	a0,0x5
    3f94:	07850513          	addi	a0,a0,120 # 9008 <malloc+0x12a4>
    3f98:	00004097          	auipc	ra,0x4
    3f9c:	bda080e7          	jalr	-1062(ra) # 7b72 <printf>
    exit(1);
    3fa0:	4505                	li	a0,1
    3fa2:	00003097          	auipc	ra,0x3
    3fa6:	670080e7          	jalr	1648(ra) # 7612 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    3faa:	20200593          	li	a1,514
    3fae:	00005517          	auipc	a0,0x5
    3fb2:	07a50513          	addi	a0,a0,122 # 9028 <malloc+0x12c4>
    3fb6:	00003097          	auipc	ra,0x3
    3fba:	69c080e7          	jalr	1692(ra) # 7652 <open>
    3fbe:	87aa                	mv	a5,a0
    3fc0:	0207c163          	bltz	a5,3fe2 <subdir+0x4d0>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3fc4:	fd843583          	ld	a1,-40(s0)
    3fc8:	00005517          	auipc	a0,0x5
    3fcc:	07050513          	addi	a0,a0,112 # 9038 <malloc+0x12d4>
    3fd0:	00004097          	auipc	ra,0x4
    3fd4:	ba2080e7          	jalr	-1118(ra) # 7b72 <printf>
    exit(1);
    3fd8:	4505                	li	a0,1
    3fda:	00003097          	auipc	ra,0x3
    3fde:	638080e7          	jalr	1592(ra) # 7612 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    3fe2:	20000593          	li	a1,512
    3fe6:	00005517          	auipc	a0,0x5
    3fea:	d6250513          	addi	a0,a0,-670 # 8d48 <malloc+0xfe4>
    3fee:	00003097          	auipc	ra,0x3
    3ff2:	664080e7          	jalr	1636(ra) # 7652 <open>
    3ff6:	87aa                	mv	a5,a0
    3ff8:	0207c163          	bltz	a5,401a <subdir+0x508>
    printf("%s: create dd succeeded!\n", s);
    3ffc:	fd843583          	ld	a1,-40(s0)
    4000:	00005517          	auipc	a0,0x5
    4004:	05850513          	addi	a0,a0,88 # 9058 <malloc+0x12f4>
    4008:	00004097          	auipc	ra,0x4
    400c:	b6a080e7          	jalr	-1174(ra) # 7b72 <printf>
    exit(1);
    4010:	4505                	li	a0,1
    4012:	00003097          	auipc	ra,0x3
    4016:	600080e7          	jalr	1536(ra) # 7612 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    401a:	4589                	li	a1,2
    401c:	00005517          	auipc	a0,0x5
    4020:	d2c50513          	addi	a0,a0,-724 # 8d48 <malloc+0xfe4>
    4024:	00003097          	auipc	ra,0x3
    4028:	62e080e7          	jalr	1582(ra) # 7652 <open>
    402c:	87aa                	mv	a5,a0
    402e:	0207c163          	bltz	a5,4050 <subdir+0x53e>
    printf("%s: open dd rdwr succeeded!\n", s);
    4032:	fd843583          	ld	a1,-40(s0)
    4036:	00005517          	auipc	a0,0x5
    403a:	04250513          	addi	a0,a0,66 # 9078 <malloc+0x1314>
    403e:	00004097          	auipc	ra,0x4
    4042:	b34080e7          	jalr	-1228(ra) # 7b72 <printf>
    exit(1);
    4046:	4505                	li	a0,1
    4048:	00003097          	auipc	ra,0x3
    404c:	5ca080e7          	jalr	1482(ra) # 7612 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    4050:	4585                	li	a1,1
    4052:	00005517          	auipc	a0,0x5
    4056:	cf650513          	addi	a0,a0,-778 # 8d48 <malloc+0xfe4>
    405a:	00003097          	auipc	ra,0x3
    405e:	5f8080e7          	jalr	1528(ra) # 7652 <open>
    4062:	87aa                	mv	a5,a0
    4064:	0207c163          	bltz	a5,4086 <subdir+0x574>
    printf("%s: open dd wronly succeeded!\n", s);
    4068:	fd843583          	ld	a1,-40(s0)
    406c:	00005517          	auipc	a0,0x5
    4070:	02c50513          	addi	a0,a0,44 # 9098 <malloc+0x1334>
    4074:	00004097          	auipc	ra,0x4
    4078:	afe080e7          	jalr	-1282(ra) # 7b72 <printf>
    exit(1);
    407c:	4505                	li	a0,1
    407e:	00003097          	auipc	ra,0x3
    4082:	594080e7          	jalr	1428(ra) # 7612 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    4086:	00005597          	auipc	a1,0x5
    408a:	03258593          	addi	a1,a1,50 # 90b8 <malloc+0x1354>
    408e:	00005517          	auipc	a0,0x5
    4092:	f6a50513          	addi	a0,a0,-150 # 8ff8 <malloc+0x1294>
    4096:	00003097          	auipc	ra,0x3
    409a:	5dc080e7          	jalr	1500(ra) # 7672 <link>
    409e:	87aa                	mv	a5,a0
    40a0:	e385                	bnez	a5,40c0 <subdir+0x5ae>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    40a2:	fd843583          	ld	a1,-40(s0)
    40a6:	00005517          	auipc	a0,0x5
    40aa:	02250513          	addi	a0,a0,34 # 90c8 <malloc+0x1364>
    40ae:	00004097          	auipc	ra,0x4
    40b2:	ac4080e7          	jalr	-1340(ra) # 7b72 <printf>
    exit(1);
    40b6:	4505                	li	a0,1
    40b8:	00003097          	auipc	ra,0x3
    40bc:	55a080e7          	jalr	1370(ra) # 7612 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    40c0:	00005597          	auipc	a1,0x5
    40c4:	ff858593          	addi	a1,a1,-8 # 90b8 <malloc+0x1354>
    40c8:	00005517          	auipc	a0,0x5
    40cc:	f6050513          	addi	a0,a0,-160 # 9028 <malloc+0x12c4>
    40d0:	00003097          	auipc	ra,0x3
    40d4:	5a2080e7          	jalr	1442(ra) # 7672 <link>
    40d8:	87aa                	mv	a5,a0
    40da:	e385                	bnez	a5,40fa <subdir+0x5e8>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    40dc:	fd843583          	ld	a1,-40(s0)
    40e0:	00005517          	auipc	a0,0x5
    40e4:	01050513          	addi	a0,a0,16 # 90f0 <malloc+0x138c>
    40e8:	00004097          	auipc	ra,0x4
    40ec:	a8a080e7          	jalr	-1398(ra) # 7b72 <printf>
    exit(1);
    40f0:	4505                	li	a0,1
    40f2:	00003097          	auipc	ra,0x3
    40f6:	520080e7          	jalr	1312(ra) # 7612 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    40fa:	00005597          	auipc	a1,0x5
    40fe:	d7658593          	addi	a1,a1,-650 # 8e70 <malloc+0x110c>
    4102:	00005517          	auipc	a0,0x5
    4106:	c6650513          	addi	a0,a0,-922 # 8d68 <malloc+0x1004>
    410a:	00003097          	auipc	ra,0x3
    410e:	568080e7          	jalr	1384(ra) # 7672 <link>
    4112:	87aa                	mv	a5,a0
    4114:	e385                	bnez	a5,4134 <subdir+0x622>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    4116:	fd843583          	ld	a1,-40(s0)
    411a:	00005517          	auipc	a0,0x5
    411e:	ffe50513          	addi	a0,a0,-2 # 9118 <malloc+0x13b4>
    4122:	00004097          	auipc	ra,0x4
    4126:	a50080e7          	jalr	-1456(ra) # 7b72 <printf>
    exit(1);
    412a:	4505                	li	a0,1
    412c:	00003097          	auipc	ra,0x3
    4130:	4e6080e7          	jalr	1254(ra) # 7612 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    4134:	00005517          	auipc	a0,0x5
    4138:	ec450513          	addi	a0,a0,-316 # 8ff8 <malloc+0x1294>
    413c:	00003097          	auipc	ra,0x3
    4140:	53e080e7          	jalr	1342(ra) # 767a <mkdir>
    4144:	87aa                	mv	a5,a0
    4146:	e385                	bnez	a5,4166 <subdir+0x654>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    4148:	fd843583          	ld	a1,-40(s0)
    414c:	00005517          	auipc	a0,0x5
    4150:	ff450513          	addi	a0,a0,-12 # 9140 <malloc+0x13dc>
    4154:	00004097          	auipc	ra,0x4
    4158:	a1e080e7          	jalr	-1506(ra) # 7b72 <printf>
    exit(1);
    415c:	4505                	li	a0,1
    415e:	00003097          	auipc	ra,0x3
    4162:	4b4080e7          	jalr	1204(ra) # 7612 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    4166:	00005517          	auipc	a0,0x5
    416a:	ec250513          	addi	a0,a0,-318 # 9028 <malloc+0x12c4>
    416e:	00003097          	auipc	ra,0x3
    4172:	50c080e7          	jalr	1292(ra) # 767a <mkdir>
    4176:	87aa                	mv	a5,a0
    4178:	e385                	bnez	a5,4198 <subdir+0x686>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    417a:	fd843583          	ld	a1,-40(s0)
    417e:	00005517          	auipc	a0,0x5
    4182:	fe250513          	addi	a0,a0,-30 # 9160 <malloc+0x13fc>
    4186:	00004097          	auipc	ra,0x4
    418a:	9ec080e7          	jalr	-1556(ra) # 7b72 <printf>
    exit(1);
    418e:	4505                	li	a0,1
    4190:	00003097          	auipc	ra,0x3
    4194:	482080e7          	jalr	1154(ra) # 7612 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    4198:	00005517          	auipc	a0,0x5
    419c:	cd850513          	addi	a0,a0,-808 # 8e70 <malloc+0x110c>
    41a0:	00003097          	auipc	ra,0x3
    41a4:	4da080e7          	jalr	1242(ra) # 767a <mkdir>
    41a8:	87aa                	mv	a5,a0
    41aa:	e385                	bnez	a5,41ca <subdir+0x6b8>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    41ac:	fd843583          	ld	a1,-40(s0)
    41b0:	00005517          	auipc	a0,0x5
    41b4:	fd050513          	addi	a0,a0,-48 # 9180 <malloc+0x141c>
    41b8:	00004097          	auipc	ra,0x4
    41bc:	9ba080e7          	jalr	-1606(ra) # 7b72 <printf>
    exit(1);
    41c0:	4505                	li	a0,1
    41c2:	00003097          	auipc	ra,0x3
    41c6:	450080e7          	jalr	1104(ra) # 7612 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    41ca:	00005517          	auipc	a0,0x5
    41ce:	e5e50513          	addi	a0,a0,-418 # 9028 <malloc+0x12c4>
    41d2:	00003097          	auipc	ra,0x3
    41d6:	490080e7          	jalr	1168(ra) # 7662 <unlink>
    41da:	87aa                	mv	a5,a0
    41dc:	e385                	bnez	a5,41fc <subdir+0x6ea>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    41de:	fd843583          	ld	a1,-40(s0)
    41e2:	00005517          	auipc	a0,0x5
    41e6:	fc650513          	addi	a0,a0,-58 # 91a8 <malloc+0x1444>
    41ea:	00004097          	auipc	ra,0x4
    41ee:	988080e7          	jalr	-1656(ra) # 7b72 <printf>
    exit(1);
    41f2:	4505                	li	a0,1
    41f4:	00003097          	auipc	ra,0x3
    41f8:	41e080e7          	jalr	1054(ra) # 7612 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    41fc:	00005517          	auipc	a0,0x5
    4200:	dfc50513          	addi	a0,a0,-516 # 8ff8 <malloc+0x1294>
    4204:	00003097          	auipc	ra,0x3
    4208:	45e080e7          	jalr	1118(ra) # 7662 <unlink>
    420c:	87aa                	mv	a5,a0
    420e:	e385                	bnez	a5,422e <subdir+0x71c>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    4210:	fd843583          	ld	a1,-40(s0)
    4214:	00005517          	auipc	a0,0x5
    4218:	fb450513          	addi	a0,a0,-76 # 91c8 <malloc+0x1464>
    421c:	00004097          	auipc	ra,0x4
    4220:	956080e7          	jalr	-1706(ra) # 7b72 <printf>
    exit(1);
    4224:	4505                	li	a0,1
    4226:	00003097          	auipc	ra,0x3
    422a:	3ec080e7          	jalr	1004(ra) # 7612 <exit>
  }
  if(chdir("dd/ff") == 0){
    422e:	00005517          	auipc	a0,0x5
    4232:	b3a50513          	addi	a0,a0,-1222 # 8d68 <malloc+0x1004>
    4236:	00003097          	auipc	ra,0x3
    423a:	44c080e7          	jalr	1100(ra) # 7682 <chdir>
    423e:	87aa                	mv	a5,a0
    4240:	e385                	bnez	a5,4260 <subdir+0x74e>
    printf("%s: chdir dd/ff succeeded!\n", s);
    4242:	fd843583          	ld	a1,-40(s0)
    4246:	00005517          	auipc	a0,0x5
    424a:	fa250513          	addi	a0,a0,-94 # 91e8 <malloc+0x1484>
    424e:	00004097          	auipc	ra,0x4
    4252:	924080e7          	jalr	-1756(ra) # 7b72 <printf>
    exit(1);
    4256:	4505                	li	a0,1
    4258:	00003097          	auipc	ra,0x3
    425c:	3ba080e7          	jalr	954(ra) # 7612 <exit>
  }
  if(chdir("dd/xx") == 0){
    4260:	00005517          	auipc	a0,0x5
    4264:	fa850513          	addi	a0,a0,-88 # 9208 <malloc+0x14a4>
    4268:	00003097          	auipc	ra,0x3
    426c:	41a080e7          	jalr	1050(ra) # 7682 <chdir>
    4270:	87aa                	mv	a5,a0
    4272:	e385                	bnez	a5,4292 <subdir+0x780>
    printf("%s: chdir dd/xx succeeded!\n", s);
    4274:	fd843583          	ld	a1,-40(s0)
    4278:	00005517          	auipc	a0,0x5
    427c:	f9850513          	addi	a0,a0,-104 # 9210 <malloc+0x14ac>
    4280:	00004097          	auipc	ra,0x4
    4284:	8f2080e7          	jalr	-1806(ra) # 7b72 <printf>
    exit(1);
    4288:	4505                	li	a0,1
    428a:	00003097          	auipc	ra,0x3
    428e:	388080e7          	jalr	904(ra) # 7612 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    4292:	00005517          	auipc	a0,0x5
    4296:	bde50513          	addi	a0,a0,-1058 # 8e70 <malloc+0x110c>
    429a:	00003097          	auipc	ra,0x3
    429e:	3c8080e7          	jalr	968(ra) # 7662 <unlink>
    42a2:	87aa                	mv	a5,a0
    42a4:	c385                	beqz	a5,42c4 <subdir+0x7b2>
    printf("%s: unlink dd/dd/ff failed\n", s);
    42a6:	fd843583          	ld	a1,-40(s0)
    42aa:	00005517          	auipc	a0,0x5
    42ae:	bfe50513          	addi	a0,a0,-1026 # 8ea8 <malloc+0x1144>
    42b2:	00004097          	auipc	ra,0x4
    42b6:	8c0080e7          	jalr	-1856(ra) # 7b72 <printf>
    exit(1);
    42ba:	4505                	li	a0,1
    42bc:	00003097          	auipc	ra,0x3
    42c0:	356080e7          	jalr	854(ra) # 7612 <exit>
  }
  if(unlink("dd/ff") != 0){
    42c4:	00005517          	auipc	a0,0x5
    42c8:	aa450513          	addi	a0,a0,-1372 # 8d68 <malloc+0x1004>
    42cc:	00003097          	auipc	ra,0x3
    42d0:	396080e7          	jalr	918(ra) # 7662 <unlink>
    42d4:	87aa                	mv	a5,a0
    42d6:	c385                	beqz	a5,42f6 <subdir+0x7e4>
    printf("%s: unlink dd/ff failed\n", s);
    42d8:	fd843583          	ld	a1,-40(s0)
    42dc:	00005517          	auipc	a0,0x5
    42e0:	f5450513          	addi	a0,a0,-172 # 9230 <malloc+0x14cc>
    42e4:	00004097          	auipc	ra,0x4
    42e8:	88e080e7          	jalr	-1906(ra) # 7b72 <printf>
    exit(1);
    42ec:	4505                	li	a0,1
    42ee:	00003097          	auipc	ra,0x3
    42f2:	324080e7          	jalr	804(ra) # 7612 <exit>
  }
  if(unlink("dd") == 0){
    42f6:	00005517          	auipc	a0,0x5
    42fa:	a5250513          	addi	a0,a0,-1454 # 8d48 <malloc+0xfe4>
    42fe:	00003097          	auipc	ra,0x3
    4302:	364080e7          	jalr	868(ra) # 7662 <unlink>
    4306:	87aa                	mv	a5,a0
    4308:	e385                	bnez	a5,4328 <subdir+0x816>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    430a:	fd843583          	ld	a1,-40(s0)
    430e:	00005517          	auipc	a0,0x5
    4312:	f4250513          	addi	a0,a0,-190 # 9250 <malloc+0x14ec>
    4316:	00004097          	auipc	ra,0x4
    431a:	85c080e7          	jalr	-1956(ra) # 7b72 <printf>
    exit(1);
    431e:	4505                	li	a0,1
    4320:	00003097          	auipc	ra,0x3
    4324:	2f2080e7          	jalr	754(ra) # 7612 <exit>
  }
  if(unlink("dd/dd") < 0){
    4328:	00005517          	auipc	a0,0x5
    432c:	f5050513          	addi	a0,a0,-176 # 9278 <malloc+0x1514>
    4330:	00003097          	auipc	ra,0x3
    4334:	332080e7          	jalr	818(ra) # 7662 <unlink>
    4338:	87aa                	mv	a5,a0
    433a:	0207d163          	bgez	a5,435c <subdir+0x84a>
    printf("%s: unlink dd/dd failed\n", s);
    433e:	fd843583          	ld	a1,-40(s0)
    4342:	00005517          	auipc	a0,0x5
    4346:	f3e50513          	addi	a0,a0,-194 # 9280 <malloc+0x151c>
    434a:	00004097          	auipc	ra,0x4
    434e:	828080e7          	jalr	-2008(ra) # 7b72 <printf>
    exit(1);
    4352:	4505                	li	a0,1
    4354:	00003097          	auipc	ra,0x3
    4358:	2be080e7          	jalr	702(ra) # 7612 <exit>
  }
  if(unlink("dd") < 0){
    435c:	00005517          	auipc	a0,0x5
    4360:	9ec50513          	addi	a0,a0,-1556 # 8d48 <malloc+0xfe4>
    4364:	00003097          	auipc	ra,0x3
    4368:	2fe080e7          	jalr	766(ra) # 7662 <unlink>
    436c:	87aa                	mv	a5,a0
    436e:	0207d163          	bgez	a5,4390 <subdir+0x87e>
    printf("%s: unlink dd failed\n", s);
    4372:	fd843583          	ld	a1,-40(s0)
    4376:	00005517          	auipc	a0,0x5
    437a:	f2a50513          	addi	a0,a0,-214 # 92a0 <malloc+0x153c>
    437e:	00003097          	auipc	ra,0x3
    4382:	7f4080e7          	jalr	2036(ra) # 7b72 <printf>
    exit(1);
    4386:	4505                	li	a0,1
    4388:	00003097          	auipc	ra,0x3
    438c:	28a080e7          	jalr	650(ra) # 7612 <exit>
  }
}
    4390:	0001                	nop
    4392:	70a2                	ld	ra,40(sp)
    4394:	7402                	ld	s0,32(sp)
    4396:	6145                	addi	sp,sp,48
    4398:	8082                	ret

000000000000439a <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(char *s)
{
    439a:	7179                	addi	sp,sp,-48
    439c:	f406                	sd	ra,40(sp)
    439e:	f022                	sd	s0,32(sp)
    43a0:	1800                	addi	s0,sp,48
    43a2:	fca43c23          	sd	a0,-40(s0)
  int fd, sz;

  unlink("bigwrite");
    43a6:	00005517          	auipc	a0,0x5
    43aa:	f1250513          	addi	a0,a0,-238 # 92b8 <malloc+0x1554>
    43ae:	00003097          	auipc	ra,0x3
    43b2:	2b4080e7          	jalr	692(ra) # 7662 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    43b6:	1f300793          	li	a5,499
    43ba:	fef42623          	sw	a5,-20(s0)
    43be:	a0ed                	j	44a8 <bigwrite+0x10e>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    43c0:	20200593          	li	a1,514
    43c4:	00005517          	auipc	a0,0x5
    43c8:	ef450513          	addi	a0,a0,-268 # 92b8 <malloc+0x1554>
    43cc:	00003097          	auipc	ra,0x3
    43d0:	286080e7          	jalr	646(ra) # 7652 <open>
    43d4:	87aa                	mv	a5,a0
    43d6:	fef42223          	sw	a5,-28(s0)
    if(fd < 0){
    43da:	fe442783          	lw	a5,-28(s0)
    43de:	2781                	sext.w	a5,a5
    43e0:	0207d163          	bgez	a5,4402 <bigwrite+0x68>
      printf("%s: cannot create bigwrite\n", s);
    43e4:	fd843583          	ld	a1,-40(s0)
    43e8:	00005517          	auipc	a0,0x5
    43ec:	ee050513          	addi	a0,a0,-288 # 92c8 <malloc+0x1564>
    43f0:	00003097          	auipc	ra,0x3
    43f4:	782080e7          	jalr	1922(ra) # 7b72 <printf>
      exit(1);
    43f8:	4505                	li	a0,1
    43fa:	00003097          	auipc	ra,0x3
    43fe:	218080e7          	jalr	536(ra) # 7612 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    4402:	fe042423          	sw	zero,-24(s0)
    4406:	a0ad                	j	4470 <bigwrite+0xd6>
      int cc = write(fd, buf, sz);
    4408:	fec42703          	lw	a4,-20(s0)
    440c:	fe442783          	lw	a5,-28(s0)
    4410:	863a                	mv	a2,a4
    4412:	00008597          	auipc	a1,0x8
    4416:	ece58593          	addi	a1,a1,-306 # c2e0 <buf>
    441a:	853e                	mv	a0,a5
    441c:	00003097          	auipc	ra,0x3
    4420:	216080e7          	jalr	534(ra) # 7632 <write>
    4424:	87aa                	mv	a5,a0
    4426:	fef42023          	sw	a5,-32(s0)
      if(cc != sz){
    442a:	fe042783          	lw	a5,-32(s0)
    442e:	873e                	mv	a4,a5
    4430:	fec42783          	lw	a5,-20(s0)
    4434:	2701                	sext.w	a4,a4
    4436:	2781                	sext.w	a5,a5
    4438:	02f70763          	beq	a4,a5,4466 <bigwrite+0xcc>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
    443c:	fe042703          	lw	a4,-32(s0)
    4440:	fec42783          	lw	a5,-20(s0)
    4444:	86ba                	mv	a3,a4
    4446:	863e                	mv	a2,a5
    4448:	fd843583          	ld	a1,-40(s0)
    444c:	00005517          	auipc	a0,0x5
    4450:	e9c50513          	addi	a0,a0,-356 # 92e8 <malloc+0x1584>
    4454:	00003097          	auipc	ra,0x3
    4458:	71e080e7          	jalr	1822(ra) # 7b72 <printf>
        exit(1);
    445c:	4505                	li	a0,1
    445e:	00003097          	auipc	ra,0x3
    4462:	1b4080e7          	jalr	436(ra) # 7612 <exit>
    for(i = 0; i < 2; i++){
    4466:	fe842783          	lw	a5,-24(s0)
    446a:	2785                	addiw	a5,a5,1
    446c:	fef42423          	sw	a5,-24(s0)
    4470:	fe842783          	lw	a5,-24(s0)
    4474:	0007871b          	sext.w	a4,a5
    4478:	4785                	li	a5,1
    447a:	f8e7d7e3          	bge	a5,a4,4408 <bigwrite+0x6e>
      }
    }
    close(fd);
    447e:	fe442783          	lw	a5,-28(s0)
    4482:	853e                	mv	a0,a5
    4484:	00003097          	auipc	ra,0x3
    4488:	1b6080e7          	jalr	438(ra) # 763a <close>
    unlink("bigwrite");
    448c:	00005517          	auipc	a0,0x5
    4490:	e2c50513          	addi	a0,a0,-468 # 92b8 <malloc+0x1554>
    4494:	00003097          	auipc	ra,0x3
    4498:	1ce080e7          	jalr	462(ra) # 7662 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    449c:	fec42783          	lw	a5,-20(s0)
    44a0:	1d77879b          	addiw	a5,a5,471
    44a4:	fef42623          	sw	a5,-20(s0)
    44a8:	fec42783          	lw	a5,-20(s0)
    44ac:	0007871b          	sext.w	a4,a5
    44b0:	678d                	lui	a5,0x3
    44b2:	f0f747e3          	blt	a4,a5,43c0 <bigwrite+0x26>
  }
}
    44b6:	0001                	nop
    44b8:	0001                	nop
    44ba:	70a2                	ld	ra,40(sp)
    44bc:	7402                	ld	s0,32(sp)
    44be:	6145                	addi	sp,sp,48
    44c0:	8082                	ret

00000000000044c2 <bigfile>:


void
bigfile(char *s)
{
    44c2:	7179                	addi	sp,sp,-48
    44c4:	f406                	sd	ra,40(sp)
    44c6:	f022                	sd	s0,32(sp)
    44c8:	1800                	addi	s0,sp,48
    44ca:	fca43c23          	sd	a0,-40(s0)
  enum { N = 20, SZ=600 };
  int fd, i, total, cc;

  unlink("bigfile.dat");
    44ce:	00005517          	auipc	a0,0x5
    44d2:	e3250513          	addi	a0,a0,-462 # 9300 <malloc+0x159c>
    44d6:	00003097          	auipc	ra,0x3
    44da:	18c080e7          	jalr	396(ra) # 7662 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    44de:	20200593          	li	a1,514
    44e2:	00005517          	auipc	a0,0x5
    44e6:	e1e50513          	addi	a0,a0,-482 # 9300 <malloc+0x159c>
    44ea:	00003097          	auipc	ra,0x3
    44ee:	168080e7          	jalr	360(ra) # 7652 <open>
    44f2:	87aa                	mv	a5,a0
    44f4:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    44f8:	fe442783          	lw	a5,-28(s0)
    44fc:	2781                	sext.w	a5,a5
    44fe:	0207d163          	bgez	a5,4520 <bigfile+0x5e>
    printf("%s: cannot create bigfile", s);
    4502:	fd843583          	ld	a1,-40(s0)
    4506:	00005517          	auipc	a0,0x5
    450a:	e0a50513          	addi	a0,a0,-502 # 9310 <malloc+0x15ac>
    450e:	00003097          	auipc	ra,0x3
    4512:	664080e7          	jalr	1636(ra) # 7b72 <printf>
    exit(1);
    4516:	4505                	li	a0,1
    4518:	00003097          	auipc	ra,0x3
    451c:	0fa080e7          	jalr	250(ra) # 7612 <exit>
  }
  for(i = 0; i < N; i++){
    4520:	fe042623          	sw	zero,-20(s0)
    4524:	a0ad                	j	458e <bigfile+0xcc>
    memset(buf, i, SZ);
    4526:	fec42783          	lw	a5,-20(s0)
    452a:	25800613          	li	a2,600
    452e:	85be                	mv	a1,a5
    4530:	00008517          	auipc	a0,0x8
    4534:	db050513          	addi	a0,a0,-592 # c2e0 <buf>
    4538:	00003097          	auipc	ra,0x3
    453c:	d2e080e7          	jalr	-722(ra) # 7266 <memset>
    if(write(fd, buf, SZ) != SZ){
    4540:	fe442783          	lw	a5,-28(s0)
    4544:	25800613          	li	a2,600
    4548:	00008597          	auipc	a1,0x8
    454c:	d9858593          	addi	a1,a1,-616 # c2e0 <buf>
    4550:	853e                	mv	a0,a5
    4552:	00003097          	auipc	ra,0x3
    4556:	0e0080e7          	jalr	224(ra) # 7632 <write>
    455a:	87aa                	mv	a5,a0
    455c:	873e                	mv	a4,a5
    455e:	25800793          	li	a5,600
    4562:	02f70163          	beq	a4,a5,4584 <bigfile+0xc2>
      printf("%s: write bigfile failed\n", s);
    4566:	fd843583          	ld	a1,-40(s0)
    456a:	00005517          	auipc	a0,0x5
    456e:	dc650513          	addi	a0,a0,-570 # 9330 <malloc+0x15cc>
    4572:	00003097          	auipc	ra,0x3
    4576:	600080e7          	jalr	1536(ra) # 7b72 <printf>
      exit(1);
    457a:	4505                	li	a0,1
    457c:	00003097          	auipc	ra,0x3
    4580:	096080e7          	jalr	150(ra) # 7612 <exit>
  for(i = 0; i < N; i++){
    4584:	fec42783          	lw	a5,-20(s0)
    4588:	2785                	addiw	a5,a5,1 # 3001 <createdelete+0x281>
    458a:	fef42623          	sw	a5,-20(s0)
    458e:	fec42783          	lw	a5,-20(s0)
    4592:	0007871b          	sext.w	a4,a5
    4596:	47cd                	li	a5,19
    4598:	f8e7d7e3          	bge	a5,a4,4526 <bigfile+0x64>
    }
  }
  close(fd);
    459c:	fe442783          	lw	a5,-28(s0)
    45a0:	853e                	mv	a0,a5
    45a2:	00003097          	auipc	ra,0x3
    45a6:	098080e7          	jalr	152(ra) # 763a <close>

  fd = open("bigfile.dat", 0);
    45aa:	4581                	li	a1,0
    45ac:	00005517          	auipc	a0,0x5
    45b0:	d5450513          	addi	a0,a0,-684 # 9300 <malloc+0x159c>
    45b4:	00003097          	auipc	ra,0x3
    45b8:	09e080e7          	jalr	158(ra) # 7652 <open>
    45bc:	87aa                	mv	a5,a0
    45be:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    45c2:	fe442783          	lw	a5,-28(s0)
    45c6:	2781                	sext.w	a5,a5
    45c8:	0207d163          	bgez	a5,45ea <bigfile+0x128>
    printf("%s: cannot open bigfile\n", s);
    45cc:	fd843583          	ld	a1,-40(s0)
    45d0:	00005517          	auipc	a0,0x5
    45d4:	d8050513          	addi	a0,a0,-640 # 9350 <malloc+0x15ec>
    45d8:	00003097          	auipc	ra,0x3
    45dc:	59a080e7          	jalr	1434(ra) # 7b72 <printf>
    exit(1);
    45e0:	4505                	li	a0,1
    45e2:	00003097          	auipc	ra,0x3
    45e6:	030080e7          	jalr	48(ra) # 7612 <exit>
  }
  total = 0;
    45ea:	fe042423          	sw	zero,-24(s0)
  for(i = 0; ; i++){
    45ee:	fe042623          	sw	zero,-20(s0)
    cc = read(fd, buf, SZ/2);
    45f2:	fe442783          	lw	a5,-28(s0)
    45f6:	12c00613          	li	a2,300
    45fa:	00008597          	auipc	a1,0x8
    45fe:	ce658593          	addi	a1,a1,-794 # c2e0 <buf>
    4602:	853e                	mv	a0,a5
    4604:	00003097          	auipc	ra,0x3
    4608:	026080e7          	jalr	38(ra) # 762a <read>
    460c:	87aa                	mv	a5,a0
    460e:	fef42023          	sw	a5,-32(s0)
    if(cc < 0){
    4612:	fe042783          	lw	a5,-32(s0)
    4616:	2781                	sext.w	a5,a5
    4618:	0207d163          	bgez	a5,463a <bigfile+0x178>
      printf("%s: read bigfile failed\n", s);
    461c:	fd843583          	ld	a1,-40(s0)
    4620:	00005517          	auipc	a0,0x5
    4624:	d5050513          	addi	a0,a0,-688 # 9370 <malloc+0x160c>
    4628:	00003097          	auipc	ra,0x3
    462c:	54a080e7          	jalr	1354(ra) # 7b72 <printf>
      exit(1);
    4630:	4505                	li	a0,1
    4632:	00003097          	auipc	ra,0x3
    4636:	fe0080e7          	jalr	-32(ra) # 7612 <exit>
    }
    if(cc == 0)
    463a:	fe042783          	lw	a5,-32(s0)
    463e:	2781                	sext.w	a5,a5
    4640:	cbdd                	beqz	a5,46f6 <bigfile+0x234>
      break;
    if(cc != SZ/2){
    4642:	fe042783          	lw	a5,-32(s0)
    4646:	0007871b          	sext.w	a4,a5
    464a:	12c00793          	li	a5,300
    464e:	02f70163          	beq	a4,a5,4670 <bigfile+0x1ae>
      printf("%s: short read bigfile\n", s);
    4652:	fd843583          	ld	a1,-40(s0)
    4656:	00005517          	auipc	a0,0x5
    465a:	d3a50513          	addi	a0,a0,-710 # 9390 <malloc+0x162c>
    465e:	00003097          	auipc	ra,0x3
    4662:	514080e7          	jalr	1300(ra) # 7b72 <printf>
      exit(1);
    4666:	4505                	li	a0,1
    4668:	00003097          	auipc	ra,0x3
    466c:	faa080e7          	jalr	-86(ra) # 7612 <exit>
    }
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4670:	00008797          	auipc	a5,0x8
    4674:	c7078793          	addi	a5,a5,-912 # c2e0 <buf>
    4678:	0007c783          	lbu	a5,0(a5)
    467c:	0007869b          	sext.w	a3,a5
    4680:	fec42783          	lw	a5,-20(s0)
    4684:	01f7d71b          	srliw	a4,a5,0x1f
    4688:	9fb9                	addw	a5,a5,a4
    468a:	4017d79b          	sraiw	a5,a5,0x1
    468e:	2781                	sext.w	a5,a5
    4690:	8736                	mv	a4,a3
    4692:	02f71563          	bne	a4,a5,46bc <bigfile+0x1fa>
    4696:	00008797          	auipc	a5,0x8
    469a:	c4a78793          	addi	a5,a5,-950 # c2e0 <buf>
    469e:	12b7c783          	lbu	a5,299(a5)
    46a2:	0007869b          	sext.w	a3,a5
    46a6:	fec42783          	lw	a5,-20(s0)
    46aa:	01f7d71b          	srliw	a4,a5,0x1f
    46ae:	9fb9                	addw	a5,a5,a4
    46b0:	4017d79b          	sraiw	a5,a5,0x1
    46b4:	2781                	sext.w	a5,a5
    46b6:	8736                	mv	a4,a3
    46b8:	02f70163          	beq	a4,a5,46da <bigfile+0x218>
      printf("%s: read bigfile wrong data\n", s);
    46bc:	fd843583          	ld	a1,-40(s0)
    46c0:	00005517          	auipc	a0,0x5
    46c4:	ce850513          	addi	a0,a0,-792 # 93a8 <malloc+0x1644>
    46c8:	00003097          	auipc	ra,0x3
    46cc:	4aa080e7          	jalr	1194(ra) # 7b72 <printf>
      exit(1);
    46d0:	4505                	li	a0,1
    46d2:	00003097          	auipc	ra,0x3
    46d6:	f40080e7          	jalr	-192(ra) # 7612 <exit>
    }
    total += cc;
    46da:	fe842783          	lw	a5,-24(s0)
    46de:	873e                	mv	a4,a5
    46e0:	fe042783          	lw	a5,-32(s0)
    46e4:	9fb9                	addw	a5,a5,a4
    46e6:	fef42423          	sw	a5,-24(s0)
  for(i = 0; ; i++){
    46ea:	fec42783          	lw	a5,-20(s0)
    46ee:	2785                	addiw	a5,a5,1
    46f0:	fef42623          	sw	a5,-20(s0)
    cc = read(fd, buf, SZ/2);
    46f4:	bdfd                	j	45f2 <bigfile+0x130>
      break;
    46f6:	0001                	nop
  }
  close(fd);
    46f8:	fe442783          	lw	a5,-28(s0)
    46fc:	853e                	mv	a0,a5
    46fe:	00003097          	auipc	ra,0x3
    4702:	f3c080e7          	jalr	-196(ra) # 763a <close>
  if(total != N*SZ){
    4706:	fe842783          	lw	a5,-24(s0)
    470a:	0007871b          	sext.w	a4,a5
    470e:	678d                	lui	a5,0x3
    4710:	ee078793          	addi	a5,a5,-288 # 2ee0 <createdelete+0x160>
    4714:	02f70163          	beq	a4,a5,4736 <bigfile+0x274>
    printf("%s: read bigfile wrong total\n", s);
    4718:	fd843583          	ld	a1,-40(s0)
    471c:	00005517          	auipc	a0,0x5
    4720:	cac50513          	addi	a0,a0,-852 # 93c8 <malloc+0x1664>
    4724:	00003097          	auipc	ra,0x3
    4728:	44e080e7          	jalr	1102(ra) # 7b72 <printf>
    exit(1);
    472c:	4505                	li	a0,1
    472e:	00003097          	auipc	ra,0x3
    4732:	ee4080e7          	jalr	-284(ra) # 7612 <exit>
  }
  unlink("bigfile.dat");
    4736:	00005517          	auipc	a0,0x5
    473a:	bca50513          	addi	a0,a0,-1078 # 9300 <malloc+0x159c>
    473e:	00003097          	auipc	ra,0x3
    4742:	f24080e7          	jalr	-220(ra) # 7662 <unlink>
}
    4746:	0001                	nop
    4748:	70a2                	ld	ra,40(sp)
    474a:	7402                	ld	s0,32(sp)
    474c:	6145                	addi	sp,sp,48
    474e:	8082                	ret

0000000000004750 <fourteen>:

void
fourteen(char *s)
{
    4750:	7179                	addi	sp,sp,-48
    4752:	f406                	sd	ra,40(sp)
    4754:	f022                	sd	s0,32(sp)
    4756:	1800                	addi	s0,sp,48
    4758:	fca43c23          	sd	a0,-40(s0)
  int fd;

  // DIRSIZ is 14.

  if(mkdir("12345678901234") != 0){
    475c:	00005517          	auipc	a0,0x5
    4760:	c8c50513          	addi	a0,a0,-884 # 93e8 <malloc+0x1684>
    4764:	00003097          	auipc	ra,0x3
    4768:	f16080e7          	jalr	-234(ra) # 767a <mkdir>
    476c:	87aa                	mv	a5,a0
    476e:	c385                	beqz	a5,478e <fourteen+0x3e>
    printf("%s: mkdir 12345678901234 failed\n", s);
    4770:	fd843583          	ld	a1,-40(s0)
    4774:	00005517          	auipc	a0,0x5
    4778:	c8450513          	addi	a0,a0,-892 # 93f8 <malloc+0x1694>
    477c:	00003097          	auipc	ra,0x3
    4780:	3f6080e7          	jalr	1014(ra) # 7b72 <printf>
    exit(1);
    4784:	4505                	li	a0,1
    4786:	00003097          	auipc	ra,0x3
    478a:	e8c080e7          	jalr	-372(ra) # 7612 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    478e:	00005517          	auipc	a0,0x5
    4792:	c9250513          	addi	a0,a0,-878 # 9420 <malloc+0x16bc>
    4796:	00003097          	auipc	ra,0x3
    479a:	ee4080e7          	jalr	-284(ra) # 767a <mkdir>
    479e:	87aa                	mv	a5,a0
    47a0:	c385                	beqz	a5,47c0 <fourteen+0x70>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    47a2:	fd843583          	ld	a1,-40(s0)
    47a6:	00005517          	auipc	a0,0x5
    47aa:	c9a50513          	addi	a0,a0,-870 # 9440 <malloc+0x16dc>
    47ae:	00003097          	auipc	ra,0x3
    47b2:	3c4080e7          	jalr	964(ra) # 7b72 <printf>
    exit(1);
    47b6:	4505                	li	a0,1
    47b8:	00003097          	auipc	ra,0x3
    47bc:	e5a080e7          	jalr	-422(ra) # 7612 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    47c0:	20000593          	li	a1,512
    47c4:	00005517          	auipc	a0,0x5
    47c8:	cb450513          	addi	a0,a0,-844 # 9478 <malloc+0x1714>
    47cc:	00003097          	auipc	ra,0x3
    47d0:	e86080e7          	jalr	-378(ra) # 7652 <open>
    47d4:	87aa                	mv	a5,a0
    47d6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    47da:	fec42783          	lw	a5,-20(s0)
    47de:	2781                	sext.w	a5,a5
    47e0:	0207d163          	bgez	a5,4802 <fourteen+0xb2>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    47e4:	fd843583          	ld	a1,-40(s0)
    47e8:	00005517          	auipc	a0,0x5
    47ec:	cc050513          	addi	a0,a0,-832 # 94a8 <malloc+0x1744>
    47f0:	00003097          	auipc	ra,0x3
    47f4:	382080e7          	jalr	898(ra) # 7b72 <printf>
    exit(1);
    47f8:	4505                	li	a0,1
    47fa:	00003097          	auipc	ra,0x3
    47fe:	e18080e7          	jalr	-488(ra) # 7612 <exit>
  }
  close(fd);
    4802:	fec42783          	lw	a5,-20(s0)
    4806:	853e                	mv	a0,a5
    4808:	00003097          	auipc	ra,0x3
    480c:	e32080e7          	jalr	-462(ra) # 763a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    4810:	4581                	li	a1,0
    4812:	00005517          	auipc	a0,0x5
    4816:	cde50513          	addi	a0,a0,-802 # 94f0 <malloc+0x178c>
    481a:	00003097          	auipc	ra,0x3
    481e:	e38080e7          	jalr	-456(ra) # 7652 <open>
    4822:	87aa                	mv	a5,a0
    4824:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4828:	fec42783          	lw	a5,-20(s0)
    482c:	2781                	sext.w	a5,a5
    482e:	0207d163          	bgez	a5,4850 <fourteen+0x100>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    4832:	fd843583          	ld	a1,-40(s0)
    4836:	00005517          	auipc	a0,0x5
    483a:	cea50513          	addi	a0,a0,-790 # 9520 <malloc+0x17bc>
    483e:	00003097          	auipc	ra,0x3
    4842:	334080e7          	jalr	820(ra) # 7b72 <printf>
    exit(1);
    4846:	4505                	li	a0,1
    4848:	00003097          	auipc	ra,0x3
    484c:	dca080e7          	jalr	-566(ra) # 7612 <exit>
  }
  close(fd);
    4850:	fec42783          	lw	a5,-20(s0)
    4854:	853e                	mv	a0,a5
    4856:	00003097          	auipc	ra,0x3
    485a:	de4080e7          	jalr	-540(ra) # 763a <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    485e:	00005517          	auipc	a0,0x5
    4862:	d0250513          	addi	a0,a0,-766 # 9560 <malloc+0x17fc>
    4866:	00003097          	auipc	ra,0x3
    486a:	e14080e7          	jalr	-492(ra) # 767a <mkdir>
    486e:	87aa                	mv	a5,a0
    4870:	e385                	bnez	a5,4890 <fourteen+0x140>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    4872:	fd843583          	ld	a1,-40(s0)
    4876:	00005517          	auipc	a0,0x5
    487a:	d0a50513          	addi	a0,a0,-758 # 9580 <malloc+0x181c>
    487e:	00003097          	auipc	ra,0x3
    4882:	2f4080e7          	jalr	756(ra) # 7b72 <printf>
    exit(1);
    4886:	4505                	li	a0,1
    4888:	00003097          	auipc	ra,0x3
    488c:	d8a080e7          	jalr	-630(ra) # 7612 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    4890:	00005517          	auipc	a0,0x5
    4894:	d2850513          	addi	a0,a0,-728 # 95b8 <malloc+0x1854>
    4898:	00003097          	auipc	ra,0x3
    489c:	de2080e7          	jalr	-542(ra) # 767a <mkdir>
    48a0:	87aa                	mv	a5,a0
    48a2:	e385                	bnez	a5,48c2 <fourteen+0x172>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    48a4:	fd843583          	ld	a1,-40(s0)
    48a8:	00005517          	auipc	a0,0x5
    48ac:	d3050513          	addi	a0,a0,-720 # 95d8 <malloc+0x1874>
    48b0:	00003097          	auipc	ra,0x3
    48b4:	2c2080e7          	jalr	706(ra) # 7b72 <printf>
    exit(1);
    48b8:	4505                	li	a0,1
    48ba:	00003097          	auipc	ra,0x3
    48be:	d58080e7          	jalr	-680(ra) # 7612 <exit>
  }

  // clean up
  unlink("123456789012345/12345678901234");
    48c2:	00005517          	auipc	a0,0x5
    48c6:	cf650513          	addi	a0,a0,-778 # 95b8 <malloc+0x1854>
    48ca:	00003097          	auipc	ra,0x3
    48ce:	d98080e7          	jalr	-616(ra) # 7662 <unlink>
  unlink("12345678901234/12345678901234");
    48d2:	00005517          	auipc	a0,0x5
    48d6:	c8e50513          	addi	a0,a0,-882 # 9560 <malloc+0x17fc>
    48da:	00003097          	auipc	ra,0x3
    48de:	d88080e7          	jalr	-632(ra) # 7662 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    48e2:	00005517          	auipc	a0,0x5
    48e6:	c0e50513          	addi	a0,a0,-1010 # 94f0 <malloc+0x178c>
    48ea:	00003097          	auipc	ra,0x3
    48ee:	d78080e7          	jalr	-648(ra) # 7662 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    48f2:	00005517          	auipc	a0,0x5
    48f6:	b8650513          	addi	a0,a0,-1146 # 9478 <malloc+0x1714>
    48fa:	00003097          	auipc	ra,0x3
    48fe:	d68080e7          	jalr	-664(ra) # 7662 <unlink>
  unlink("12345678901234/123456789012345");
    4902:	00005517          	auipc	a0,0x5
    4906:	b1e50513          	addi	a0,a0,-1250 # 9420 <malloc+0x16bc>
    490a:	00003097          	auipc	ra,0x3
    490e:	d58080e7          	jalr	-680(ra) # 7662 <unlink>
  unlink("12345678901234");
    4912:	00005517          	auipc	a0,0x5
    4916:	ad650513          	addi	a0,a0,-1322 # 93e8 <malloc+0x1684>
    491a:	00003097          	auipc	ra,0x3
    491e:	d48080e7          	jalr	-696(ra) # 7662 <unlink>
}
    4922:	0001                	nop
    4924:	70a2                	ld	ra,40(sp)
    4926:	7402                	ld	s0,32(sp)
    4928:	6145                	addi	sp,sp,48
    492a:	8082                	ret

000000000000492c <rmdot>:

void
rmdot(char *s)
{
    492c:	1101                	addi	sp,sp,-32
    492e:	ec06                	sd	ra,24(sp)
    4930:	e822                	sd	s0,16(sp)
    4932:	1000                	addi	s0,sp,32
    4934:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dots") != 0){
    4938:	00005517          	auipc	a0,0x5
    493c:	cd850513          	addi	a0,a0,-808 # 9610 <malloc+0x18ac>
    4940:	00003097          	auipc	ra,0x3
    4944:	d3a080e7          	jalr	-710(ra) # 767a <mkdir>
    4948:	87aa                	mv	a5,a0
    494a:	c385                	beqz	a5,496a <rmdot+0x3e>
    printf("%s: mkdir dots failed\n", s);
    494c:	fe843583          	ld	a1,-24(s0)
    4950:	00005517          	auipc	a0,0x5
    4954:	cc850513          	addi	a0,a0,-824 # 9618 <malloc+0x18b4>
    4958:	00003097          	auipc	ra,0x3
    495c:	21a080e7          	jalr	538(ra) # 7b72 <printf>
    exit(1);
    4960:	4505                	li	a0,1
    4962:	00003097          	auipc	ra,0x3
    4966:	cb0080e7          	jalr	-848(ra) # 7612 <exit>
  }
  if(chdir("dots") != 0){
    496a:	00005517          	auipc	a0,0x5
    496e:	ca650513          	addi	a0,a0,-858 # 9610 <malloc+0x18ac>
    4972:	00003097          	auipc	ra,0x3
    4976:	d10080e7          	jalr	-752(ra) # 7682 <chdir>
    497a:	87aa                	mv	a5,a0
    497c:	c385                	beqz	a5,499c <rmdot+0x70>
    printf("%s: chdir dots failed\n", s);
    497e:	fe843583          	ld	a1,-24(s0)
    4982:	00005517          	auipc	a0,0x5
    4986:	cae50513          	addi	a0,a0,-850 # 9630 <malloc+0x18cc>
    498a:	00003097          	auipc	ra,0x3
    498e:	1e8080e7          	jalr	488(ra) # 7b72 <printf>
    exit(1);
    4992:	4505                	li	a0,1
    4994:	00003097          	auipc	ra,0x3
    4998:	c7e080e7          	jalr	-898(ra) # 7612 <exit>
  }
  if(unlink(".") == 0){
    499c:	00004517          	auipc	a0,0x4
    49a0:	2cc50513          	addi	a0,a0,716 # 8c68 <malloc+0xf04>
    49a4:	00003097          	auipc	ra,0x3
    49a8:	cbe080e7          	jalr	-834(ra) # 7662 <unlink>
    49ac:	87aa                	mv	a5,a0
    49ae:	e385                	bnez	a5,49ce <rmdot+0xa2>
    printf("%s: rm . worked!\n", s);
    49b0:	fe843583          	ld	a1,-24(s0)
    49b4:	00005517          	auipc	a0,0x5
    49b8:	c9450513          	addi	a0,a0,-876 # 9648 <malloc+0x18e4>
    49bc:	00003097          	auipc	ra,0x3
    49c0:	1b6080e7          	jalr	438(ra) # 7b72 <printf>
    exit(1);
    49c4:	4505                	li	a0,1
    49c6:	00003097          	auipc	ra,0x3
    49ca:	c4c080e7          	jalr	-948(ra) # 7612 <exit>
  }
  if(unlink("..") == 0){
    49ce:	00004517          	auipc	a0,0x4
    49d2:	cf250513          	addi	a0,a0,-782 # 86c0 <malloc+0x95c>
    49d6:	00003097          	auipc	ra,0x3
    49da:	c8c080e7          	jalr	-884(ra) # 7662 <unlink>
    49de:	87aa                	mv	a5,a0
    49e0:	e385                	bnez	a5,4a00 <rmdot+0xd4>
    printf("%s: rm .. worked!\n", s);
    49e2:	fe843583          	ld	a1,-24(s0)
    49e6:	00005517          	auipc	a0,0x5
    49ea:	c7a50513          	addi	a0,a0,-902 # 9660 <malloc+0x18fc>
    49ee:	00003097          	auipc	ra,0x3
    49f2:	184080e7          	jalr	388(ra) # 7b72 <printf>
    exit(1);
    49f6:	4505                	li	a0,1
    49f8:	00003097          	auipc	ra,0x3
    49fc:	c1a080e7          	jalr	-998(ra) # 7612 <exit>
  }
  if(chdir("/") != 0){
    4a00:	00004517          	auipc	a0,0x4
    4a04:	9d850513          	addi	a0,a0,-1576 # 83d8 <malloc+0x674>
    4a08:	00003097          	auipc	ra,0x3
    4a0c:	c7a080e7          	jalr	-902(ra) # 7682 <chdir>
    4a10:	87aa                	mv	a5,a0
    4a12:	c385                	beqz	a5,4a32 <rmdot+0x106>
    printf("%s: chdir / failed\n", s);
    4a14:	fe843583          	ld	a1,-24(s0)
    4a18:	00004517          	auipc	a0,0x4
    4a1c:	9c850513          	addi	a0,a0,-1592 # 83e0 <malloc+0x67c>
    4a20:	00003097          	auipc	ra,0x3
    4a24:	152080e7          	jalr	338(ra) # 7b72 <printf>
    exit(1);
    4a28:	4505                	li	a0,1
    4a2a:	00003097          	auipc	ra,0x3
    4a2e:	be8080e7          	jalr	-1048(ra) # 7612 <exit>
  }
  if(unlink("dots/.") == 0){
    4a32:	00005517          	auipc	a0,0x5
    4a36:	c4650513          	addi	a0,a0,-954 # 9678 <malloc+0x1914>
    4a3a:	00003097          	auipc	ra,0x3
    4a3e:	c28080e7          	jalr	-984(ra) # 7662 <unlink>
    4a42:	87aa                	mv	a5,a0
    4a44:	e385                	bnez	a5,4a64 <rmdot+0x138>
    printf("%s: unlink dots/. worked!\n", s);
    4a46:	fe843583          	ld	a1,-24(s0)
    4a4a:	00005517          	auipc	a0,0x5
    4a4e:	c3650513          	addi	a0,a0,-970 # 9680 <malloc+0x191c>
    4a52:	00003097          	auipc	ra,0x3
    4a56:	120080e7          	jalr	288(ra) # 7b72 <printf>
    exit(1);
    4a5a:	4505                	li	a0,1
    4a5c:	00003097          	auipc	ra,0x3
    4a60:	bb6080e7          	jalr	-1098(ra) # 7612 <exit>
  }
  if(unlink("dots/..") == 0){
    4a64:	00005517          	auipc	a0,0x5
    4a68:	c3c50513          	addi	a0,a0,-964 # 96a0 <malloc+0x193c>
    4a6c:	00003097          	auipc	ra,0x3
    4a70:	bf6080e7          	jalr	-1034(ra) # 7662 <unlink>
    4a74:	87aa                	mv	a5,a0
    4a76:	e385                	bnez	a5,4a96 <rmdot+0x16a>
    printf("%s: unlink dots/.. worked!\n", s);
    4a78:	fe843583          	ld	a1,-24(s0)
    4a7c:	00005517          	auipc	a0,0x5
    4a80:	c2c50513          	addi	a0,a0,-980 # 96a8 <malloc+0x1944>
    4a84:	00003097          	auipc	ra,0x3
    4a88:	0ee080e7          	jalr	238(ra) # 7b72 <printf>
    exit(1);
    4a8c:	4505                	li	a0,1
    4a8e:	00003097          	auipc	ra,0x3
    4a92:	b84080e7          	jalr	-1148(ra) # 7612 <exit>
  }
  if(unlink("dots") != 0){
    4a96:	00005517          	auipc	a0,0x5
    4a9a:	b7a50513          	addi	a0,a0,-1158 # 9610 <malloc+0x18ac>
    4a9e:	00003097          	auipc	ra,0x3
    4aa2:	bc4080e7          	jalr	-1084(ra) # 7662 <unlink>
    4aa6:	87aa                	mv	a5,a0
    4aa8:	c385                	beqz	a5,4ac8 <rmdot+0x19c>
    printf("%s: unlink dots failed!\n", s);
    4aaa:	fe843583          	ld	a1,-24(s0)
    4aae:	00005517          	auipc	a0,0x5
    4ab2:	c1a50513          	addi	a0,a0,-998 # 96c8 <malloc+0x1964>
    4ab6:	00003097          	auipc	ra,0x3
    4aba:	0bc080e7          	jalr	188(ra) # 7b72 <printf>
    exit(1);
    4abe:	4505                	li	a0,1
    4ac0:	00003097          	auipc	ra,0x3
    4ac4:	b52080e7          	jalr	-1198(ra) # 7612 <exit>
  }
}
    4ac8:	0001                	nop
    4aca:	60e2                	ld	ra,24(sp)
    4acc:	6442                	ld	s0,16(sp)
    4ace:	6105                	addi	sp,sp,32
    4ad0:	8082                	ret

0000000000004ad2 <dirfile>:

void
dirfile(char *s)
{
    4ad2:	7179                	addi	sp,sp,-48
    4ad4:	f406                	sd	ra,40(sp)
    4ad6:	f022                	sd	s0,32(sp)
    4ad8:	1800                	addi	s0,sp,48
    4ada:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("dirfile", O_CREATE);
    4ade:	20000593          	li	a1,512
    4ae2:	00005517          	auipc	a0,0x5
    4ae6:	c0650513          	addi	a0,a0,-1018 # 96e8 <malloc+0x1984>
    4aea:	00003097          	auipc	ra,0x3
    4aee:	b68080e7          	jalr	-1176(ra) # 7652 <open>
    4af2:	87aa                	mv	a5,a0
    4af4:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4af8:	fec42783          	lw	a5,-20(s0)
    4afc:	2781                	sext.w	a5,a5
    4afe:	0207d163          	bgez	a5,4b20 <dirfile+0x4e>
    printf("%s: create dirfile failed\n", s);
    4b02:	fd843583          	ld	a1,-40(s0)
    4b06:	00005517          	auipc	a0,0x5
    4b0a:	bea50513          	addi	a0,a0,-1046 # 96f0 <malloc+0x198c>
    4b0e:	00003097          	auipc	ra,0x3
    4b12:	064080e7          	jalr	100(ra) # 7b72 <printf>
    exit(1);
    4b16:	4505                	li	a0,1
    4b18:	00003097          	auipc	ra,0x3
    4b1c:	afa080e7          	jalr	-1286(ra) # 7612 <exit>
  }
  close(fd);
    4b20:	fec42783          	lw	a5,-20(s0)
    4b24:	853e                	mv	a0,a5
    4b26:	00003097          	auipc	ra,0x3
    4b2a:	b14080e7          	jalr	-1260(ra) # 763a <close>
  if(chdir("dirfile") == 0){
    4b2e:	00005517          	auipc	a0,0x5
    4b32:	bba50513          	addi	a0,a0,-1094 # 96e8 <malloc+0x1984>
    4b36:	00003097          	auipc	ra,0x3
    4b3a:	b4c080e7          	jalr	-1204(ra) # 7682 <chdir>
    4b3e:	87aa                	mv	a5,a0
    4b40:	e385                	bnez	a5,4b60 <dirfile+0x8e>
    printf("%s: chdir dirfile succeeded!\n", s);
    4b42:	fd843583          	ld	a1,-40(s0)
    4b46:	00005517          	auipc	a0,0x5
    4b4a:	bca50513          	addi	a0,a0,-1078 # 9710 <malloc+0x19ac>
    4b4e:	00003097          	auipc	ra,0x3
    4b52:	024080e7          	jalr	36(ra) # 7b72 <printf>
    exit(1);
    4b56:	4505                	li	a0,1
    4b58:	00003097          	auipc	ra,0x3
    4b5c:	aba080e7          	jalr	-1350(ra) # 7612 <exit>
  }
  fd = open("dirfile/xx", 0);
    4b60:	4581                	li	a1,0
    4b62:	00005517          	auipc	a0,0x5
    4b66:	bce50513          	addi	a0,a0,-1074 # 9730 <malloc+0x19cc>
    4b6a:	00003097          	auipc	ra,0x3
    4b6e:	ae8080e7          	jalr	-1304(ra) # 7652 <open>
    4b72:	87aa                	mv	a5,a0
    4b74:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4b78:	fec42783          	lw	a5,-20(s0)
    4b7c:	2781                	sext.w	a5,a5
    4b7e:	0207c163          	bltz	a5,4ba0 <dirfile+0xce>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4b82:	fd843583          	ld	a1,-40(s0)
    4b86:	00005517          	auipc	a0,0x5
    4b8a:	bba50513          	addi	a0,a0,-1094 # 9740 <malloc+0x19dc>
    4b8e:	00003097          	auipc	ra,0x3
    4b92:	fe4080e7          	jalr	-28(ra) # 7b72 <printf>
    exit(1);
    4b96:	4505                	li	a0,1
    4b98:	00003097          	auipc	ra,0x3
    4b9c:	a7a080e7          	jalr	-1414(ra) # 7612 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    4ba0:	20000593          	li	a1,512
    4ba4:	00005517          	auipc	a0,0x5
    4ba8:	b8c50513          	addi	a0,a0,-1140 # 9730 <malloc+0x19cc>
    4bac:	00003097          	auipc	ra,0x3
    4bb0:	aa6080e7          	jalr	-1370(ra) # 7652 <open>
    4bb4:	87aa                	mv	a5,a0
    4bb6:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4bba:	fec42783          	lw	a5,-20(s0)
    4bbe:	2781                	sext.w	a5,a5
    4bc0:	0207c163          	bltz	a5,4be2 <dirfile+0x110>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4bc4:	fd843583          	ld	a1,-40(s0)
    4bc8:	00005517          	auipc	a0,0x5
    4bcc:	b7850513          	addi	a0,a0,-1160 # 9740 <malloc+0x19dc>
    4bd0:	00003097          	auipc	ra,0x3
    4bd4:	fa2080e7          	jalr	-94(ra) # 7b72 <printf>
    exit(1);
    4bd8:	4505                	li	a0,1
    4bda:	00003097          	auipc	ra,0x3
    4bde:	a38080e7          	jalr	-1480(ra) # 7612 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    4be2:	00005517          	auipc	a0,0x5
    4be6:	b4e50513          	addi	a0,a0,-1202 # 9730 <malloc+0x19cc>
    4bea:	00003097          	auipc	ra,0x3
    4bee:	a90080e7          	jalr	-1392(ra) # 767a <mkdir>
    4bf2:	87aa                	mv	a5,a0
    4bf4:	e385                	bnez	a5,4c14 <dirfile+0x142>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4bf6:	fd843583          	ld	a1,-40(s0)
    4bfa:	00005517          	auipc	a0,0x5
    4bfe:	b6e50513          	addi	a0,a0,-1170 # 9768 <malloc+0x1a04>
    4c02:	00003097          	auipc	ra,0x3
    4c06:	f70080e7          	jalr	-144(ra) # 7b72 <printf>
    exit(1);
    4c0a:	4505                	li	a0,1
    4c0c:	00003097          	auipc	ra,0x3
    4c10:	a06080e7          	jalr	-1530(ra) # 7612 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    4c14:	00005517          	auipc	a0,0x5
    4c18:	b1c50513          	addi	a0,a0,-1252 # 9730 <malloc+0x19cc>
    4c1c:	00003097          	auipc	ra,0x3
    4c20:	a46080e7          	jalr	-1466(ra) # 7662 <unlink>
    4c24:	87aa                	mv	a5,a0
    4c26:	e385                	bnez	a5,4c46 <dirfile+0x174>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    4c28:	fd843583          	ld	a1,-40(s0)
    4c2c:	00005517          	auipc	a0,0x5
    4c30:	b6450513          	addi	a0,a0,-1180 # 9790 <malloc+0x1a2c>
    4c34:	00003097          	auipc	ra,0x3
    4c38:	f3e080e7          	jalr	-194(ra) # 7b72 <printf>
    exit(1);
    4c3c:	4505                	li	a0,1
    4c3e:	00003097          	auipc	ra,0x3
    4c42:	9d4080e7          	jalr	-1580(ra) # 7612 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    4c46:	00005597          	auipc	a1,0x5
    4c4a:	aea58593          	addi	a1,a1,-1302 # 9730 <malloc+0x19cc>
    4c4e:	00003517          	auipc	a0,0x3
    4c52:	31250513          	addi	a0,a0,786 # 7f60 <malloc+0x1fc>
    4c56:	00003097          	auipc	ra,0x3
    4c5a:	a1c080e7          	jalr	-1508(ra) # 7672 <link>
    4c5e:	87aa                	mv	a5,a0
    4c60:	e385                	bnez	a5,4c80 <dirfile+0x1ae>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    4c62:	fd843583          	ld	a1,-40(s0)
    4c66:	00005517          	auipc	a0,0x5
    4c6a:	b5250513          	addi	a0,a0,-1198 # 97b8 <malloc+0x1a54>
    4c6e:	00003097          	auipc	ra,0x3
    4c72:	f04080e7          	jalr	-252(ra) # 7b72 <printf>
    exit(1);
    4c76:	4505                	li	a0,1
    4c78:	00003097          	auipc	ra,0x3
    4c7c:	99a080e7          	jalr	-1638(ra) # 7612 <exit>
  }
  if(unlink("dirfile") != 0){
    4c80:	00005517          	auipc	a0,0x5
    4c84:	a6850513          	addi	a0,a0,-1432 # 96e8 <malloc+0x1984>
    4c88:	00003097          	auipc	ra,0x3
    4c8c:	9da080e7          	jalr	-1574(ra) # 7662 <unlink>
    4c90:	87aa                	mv	a5,a0
    4c92:	c385                	beqz	a5,4cb2 <dirfile+0x1e0>
    printf("%s: unlink dirfile failed!\n", s);
    4c94:	fd843583          	ld	a1,-40(s0)
    4c98:	00005517          	auipc	a0,0x5
    4c9c:	b4850513          	addi	a0,a0,-1208 # 97e0 <malloc+0x1a7c>
    4ca0:	00003097          	auipc	ra,0x3
    4ca4:	ed2080e7          	jalr	-302(ra) # 7b72 <printf>
    exit(1);
    4ca8:	4505                	li	a0,1
    4caa:	00003097          	auipc	ra,0x3
    4cae:	968080e7          	jalr	-1688(ra) # 7612 <exit>
  }

  fd = open(".", O_RDWR);
    4cb2:	4589                	li	a1,2
    4cb4:	00004517          	auipc	a0,0x4
    4cb8:	fb450513          	addi	a0,a0,-76 # 8c68 <malloc+0xf04>
    4cbc:	00003097          	auipc	ra,0x3
    4cc0:	996080e7          	jalr	-1642(ra) # 7652 <open>
    4cc4:	87aa                	mv	a5,a0
    4cc6:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4cca:	fec42783          	lw	a5,-20(s0)
    4cce:	2781                	sext.w	a5,a5
    4cd0:	0207c163          	bltz	a5,4cf2 <dirfile+0x220>
    printf("%s: open . for writing succeeded!\n", s);
    4cd4:	fd843583          	ld	a1,-40(s0)
    4cd8:	00005517          	auipc	a0,0x5
    4cdc:	b2850513          	addi	a0,a0,-1240 # 9800 <malloc+0x1a9c>
    4ce0:	00003097          	auipc	ra,0x3
    4ce4:	e92080e7          	jalr	-366(ra) # 7b72 <printf>
    exit(1);
    4ce8:	4505                	li	a0,1
    4cea:	00003097          	auipc	ra,0x3
    4cee:	928080e7          	jalr	-1752(ra) # 7612 <exit>
  }
  fd = open(".", 0);
    4cf2:	4581                	li	a1,0
    4cf4:	00004517          	auipc	a0,0x4
    4cf8:	f7450513          	addi	a0,a0,-140 # 8c68 <malloc+0xf04>
    4cfc:	00003097          	auipc	ra,0x3
    4d00:	956080e7          	jalr	-1706(ra) # 7652 <open>
    4d04:	87aa                	mv	a5,a0
    4d06:	fef42623          	sw	a5,-20(s0)
  if(write(fd, "x", 1) > 0){
    4d0a:	fec42783          	lw	a5,-20(s0)
    4d0e:	4605                	li	a2,1
    4d10:	00003597          	auipc	a1,0x3
    4d14:	2a058593          	addi	a1,a1,672 # 7fb0 <malloc+0x24c>
    4d18:	853e                	mv	a0,a5
    4d1a:	00003097          	auipc	ra,0x3
    4d1e:	918080e7          	jalr	-1768(ra) # 7632 <write>
    4d22:	87aa                	mv	a5,a0
    4d24:	02f05163          	blez	a5,4d46 <dirfile+0x274>
    printf("%s: write . succeeded!\n", s);
    4d28:	fd843583          	ld	a1,-40(s0)
    4d2c:	00005517          	auipc	a0,0x5
    4d30:	afc50513          	addi	a0,a0,-1284 # 9828 <malloc+0x1ac4>
    4d34:	00003097          	auipc	ra,0x3
    4d38:	e3e080e7          	jalr	-450(ra) # 7b72 <printf>
    exit(1);
    4d3c:	4505                	li	a0,1
    4d3e:	00003097          	auipc	ra,0x3
    4d42:	8d4080e7          	jalr	-1836(ra) # 7612 <exit>
  }
  close(fd);
    4d46:	fec42783          	lw	a5,-20(s0)
    4d4a:	853e                	mv	a0,a5
    4d4c:	00003097          	auipc	ra,0x3
    4d50:	8ee080e7          	jalr	-1810(ra) # 763a <close>
}
    4d54:	0001                	nop
    4d56:	70a2                	ld	ra,40(sp)
    4d58:	7402                	ld	s0,32(sp)
    4d5a:	6145                	addi	sp,sp,48
    4d5c:	8082                	ret

0000000000004d5e <iref>:

// test that iput() is called at the end of _namei().
// also tests empty file names.
void
iref(char *s)
{
    4d5e:	7179                	addi	sp,sp,-48
    4d60:	f406                	sd	ra,40(sp)
    4d62:	f022                	sd	s0,32(sp)
    4d64:	1800                	addi	s0,sp,48
    4d66:	fca43c23          	sd	a0,-40(s0)
  int i, fd;

  for(i = 0; i < NINODE + 1; i++){
    4d6a:	fe042623          	sw	zero,-20(s0)
    4d6e:	a231                	j	4e7a <iref+0x11c>
    if(mkdir("irefd") != 0){
    4d70:	00005517          	auipc	a0,0x5
    4d74:	ad050513          	addi	a0,a0,-1328 # 9840 <malloc+0x1adc>
    4d78:	00003097          	auipc	ra,0x3
    4d7c:	902080e7          	jalr	-1790(ra) # 767a <mkdir>
    4d80:	87aa                	mv	a5,a0
    4d82:	c385                	beqz	a5,4da2 <iref+0x44>
      printf("%s: mkdir irefd failed\n", s);
    4d84:	fd843583          	ld	a1,-40(s0)
    4d88:	00005517          	auipc	a0,0x5
    4d8c:	ac050513          	addi	a0,a0,-1344 # 9848 <malloc+0x1ae4>
    4d90:	00003097          	auipc	ra,0x3
    4d94:	de2080e7          	jalr	-542(ra) # 7b72 <printf>
      exit(1);
    4d98:	4505                	li	a0,1
    4d9a:	00003097          	auipc	ra,0x3
    4d9e:	878080e7          	jalr	-1928(ra) # 7612 <exit>
    }
    if(chdir("irefd") != 0){
    4da2:	00005517          	auipc	a0,0x5
    4da6:	a9e50513          	addi	a0,a0,-1378 # 9840 <malloc+0x1adc>
    4daa:	00003097          	auipc	ra,0x3
    4dae:	8d8080e7          	jalr	-1832(ra) # 7682 <chdir>
    4db2:	87aa                	mv	a5,a0
    4db4:	c385                	beqz	a5,4dd4 <iref+0x76>
      printf("%s: chdir irefd failed\n", s);
    4db6:	fd843583          	ld	a1,-40(s0)
    4dba:	00005517          	auipc	a0,0x5
    4dbe:	aa650513          	addi	a0,a0,-1370 # 9860 <malloc+0x1afc>
    4dc2:	00003097          	auipc	ra,0x3
    4dc6:	db0080e7          	jalr	-592(ra) # 7b72 <printf>
      exit(1);
    4dca:	4505                	li	a0,1
    4dcc:	00003097          	auipc	ra,0x3
    4dd0:	846080e7          	jalr	-1978(ra) # 7612 <exit>
    }

    mkdir("");
    4dd4:	00005517          	auipc	a0,0x5
    4dd8:	aa450513          	addi	a0,a0,-1372 # 9878 <malloc+0x1b14>
    4ddc:	00003097          	auipc	ra,0x3
    4de0:	89e080e7          	jalr	-1890(ra) # 767a <mkdir>
    link("README", "");
    4de4:	00005597          	auipc	a1,0x5
    4de8:	a9458593          	addi	a1,a1,-1388 # 9878 <malloc+0x1b14>
    4dec:	00003517          	auipc	a0,0x3
    4df0:	17450513          	addi	a0,a0,372 # 7f60 <malloc+0x1fc>
    4df4:	00003097          	auipc	ra,0x3
    4df8:	87e080e7          	jalr	-1922(ra) # 7672 <link>
    fd = open("", O_CREATE);
    4dfc:	20000593          	li	a1,512
    4e00:	00005517          	auipc	a0,0x5
    4e04:	a7850513          	addi	a0,a0,-1416 # 9878 <malloc+0x1b14>
    4e08:	00003097          	auipc	ra,0x3
    4e0c:	84a080e7          	jalr	-1974(ra) # 7652 <open>
    4e10:	87aa                	mv	a5,a0
    4e12:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    4e16:	fe842783          	lw	a5,-24(s0)
    4e1a:	2781                	sext.w	a5,a5
    4e1c:	0007c963          	bltz	a5,4e2e <iref+0xd0>
      close(fd);
    4e20:	fe842783          	lw	a5,-24(s0)
    4e24:	853e                	mv	a0,a5
    4e26:	00003097          	auipc	ra,0x3
    4e2a:	814080e7          	jalr	-2028(ra) # 763a <close>
    fd = open("xx", O_CREATE);
    4e2e:	20000593          	li	a1,512
    4e32:	00003517          	auipc	a0,0x3
    4e36:	25650513          	addi	a0,a0,598 # 8088 <malloc+0x324>
    4e3a:	00003097          	auipc	ra,0x3
    4e3e:	818080e7          	jalr	-2024(ra) # 7652 <open>
    4e42:	87aa                	mv	a5,a0
    4e44:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    4e48:	fe842783          	lw	a5,-24(s0)
    4e4c:	2781                	sext.w	a5,a5
    4e4e:	0007c963          	bltz	a5,4e60 <iref+0x102>
      close(fd);
    4e52:	fe842783          	lw	a5,-24(s0)
    4e56:	853e                	mv	a0,a5
    4e58:	00002097          	auipc	ra,0x2
    4e5c:	7e2080e7          	jalr	2018(ra) # 763a <close>
    unlink("xx");
    4e60:	00003517          	auipc	a0,0x3
    4e64:	22850513          	addi	a0,a0,552 # 8088 <malloc+0x324>
    4e68:	00002097          	auipc	ra,0x2
    4e6c:	7fa080e7          	jalr	2042(ra) # 7662 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4e70:	fec42783          	lw	a5,-20(s0)
    4e74:	2785                	addiw	a5,a5,1
    4e76:	fef42623          	sw	a5,-20(s0)
    4e7a:	fec42783          	lw	a5,-20(s0)
    4e7e:	0007871b          	sext.w	a4,a5
    4e82:	03200793          	li	a5,50
    4e86:	eee7d5e3          	bge	a5,a4,4d70 <iref+0x12>
  }

  // clean up
  for(i = 0; i < NINODE + 1; i++){
    4e8a:	fe042623          	sw	zero,-20(s0)
    4e8e:	a035                	j	4eba <iref+0x15c>
    chdir("..");
    4e90:	00004517          	auipc	a0,0x4
    4e94:	83050513          	addi	a0,a0,-2000 # 86c0 <malloc+0x95c>
    4e98:	00002097          	auipc	ra,0x2
    4e9c:	7ea080e7          	jalr	2026(ra) # 7682 <chdir>
    unlink("irefd");
    4ea0:	00005517          	auipc	a0,0x5
    4ea4:	9a050513          	addi	a0,a0,-1632 # 9840 <malloc+0x1adc>
    4ea8:	00002097          	auipc	ra,0x2
    4eac:	7ba080e7          	jalr	1978(ra) # 7662 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4eb0:	fec42783          	lw	a5,-20(s0)
    4eb4:	2785                	addiw	a5,a5,1
    4eb6:	fef42623          	sw	a5,-20(s0)
    4eba:	fec42783          	lw	a5,-20(s0)
    4ebe:	0007871b          	sext.w	a4,a5
    4ec2:	03200793          	li	a5,50
    4ec6:	fce7d5e3          	bge	a5,a4,4e90 <iref+0x132>
  }

  chdir("/");
    4eca:	00003517          	auipc	a0,0x3
    4ece:	50e50513          	addi	a0,a0,1294 # 83d8 <malloc+0x674>
    4ed2:	00002097          	auipc	ra,0x2
    4ed6:	7b0080e7          	jalr	1968(ra) # 7682 <chdir>
}
    4eda:	0001                	nop
    4edc:	70a2                	ld	ra,40(sp)
    4ede:	7402                	ld	s0,32(sp)
    4ee0:	6145                	addi	sp,sp,48
    4ee2:	8082                	ret

0000000000004ee4 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(char *s)
{
    4ee4:	7179                	addi	sp,sp,-48
    4ee6:	f406                	sd	ra,40(sp)
    4ee8:	f022                	sd	s0,32(sp)
    4eea:	1800                	addi	s0,sp,48
    4eec:	fca43c23          	sd	a0,-40(s0)
  enum{ N = 1000 };
  int n, pid;

  for(n=0; n<N; n++){
    4ef0:	fe042623          	sw	zero,-20(s0)
    4ef4:	a81d                	j	4f2a <forktest+0x46>
    pid = fork();
    4ef6:	00002097          	auipc	ra,0x2
    4efa:	714080e7          	jalr	1812(ra) # 760a <fork>
    4efe:	87aa                	mv	a5,a0
    4f00:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
    4f04:	fe842783          	lw	a5,-24(s0)
    4f08:	2781                	sext.w	a5,a5
    4f0a:	0207c963          	bltz	a5,4f3c <forktest+0x58>
      break;
    if(pid == 0)
    4f0e:	fe842783          	lw	a5,-24(s0)
    4f12:	2781                	sext.w	a5,a5
    4f14:	e791                	bnez	a5,4f20 <forktest+0x3c>
      exit(0);
    4f16:	4501                	li	a0,0
    4f18:	00002097          	auipc	ra,0x2
    4f1c:	6fa080e7          	jalr	1786(ra) # 7612 <exit>
  for(n=0; n<N; n++){
    4f20:	fec42783          	lw	a5,-20(s0)
    4f24:	2785                	addiw	a5,a5,1
    4f26:	fef42623          	sw	a5,-20(s0)
    4f2a:	fec42783          	lw	a5,-20(s0)
    4f2e:	0007871b          	sext.w	a4,a5
    4f32:	3e700793          	li	a5,999
    4f36:	fce7d0e3          	bge	a5,a4,4ef6 <forktest+0x12>
    4f3a:	a011                	j	4f3e <forktest+0x5a>
      break;
    4f3c:	0001                	nop
  }

  if (n == 0) {
    4f3e:	fec42783          	lw	a5,-20(s0)
    4f42:	2781                	sext.w	a5,a5
    4f44:	e385                	bnez	a5,4f64 <forktest+0x80>
    printf("%s: no fork at all!\n", s);
    4f46:	fd843583          	ld	a1,-40(s0)
    4f4a:	00005517          	auipc	a0,0x5
    4f4e:	93650513          	addi	a0,a0,-1738 # 9880 <malloc+0x1b1c>
    4f52:	00003097          	auipc	ra,0x3
    4f56:	c20080e7          	jalr	-992(ra) # 7b72 <printf>
    exit(1);
    4f5a:	4505                	li	a0,1
    4f5c:	00002097          	auipc	ra,0x2
    4f60:	6b6080e7          	jalr	1718(ra) # 7612 <exit>
  }

  if(n == N){
    4f64:	fec42783          	lw	a5,-20(s0)
    4f68:	0007871b          	sext.w	a4,a5
    4f6c:	3e800793          	li	a5,1000
    4f70:	04f71d63          	bne	a4,a5,4fca <forktest+0xe6>
    printf("%s: fork claimed to work 1000 times!\n", s);
    4f74:	fd843583          	ld	a1,-40(s0)
    4f78:	00005517          	auipc	a0,0x5
    4f7c:	92050513          	addi	a0,a0,-1760 # 9898 <malloc+0x1b34>
    4f80:	00003097          	auipc	ra,0x3
    4f84:	bf2080e7          	jalr	-1038(ra) # 7b72 <printf>
    exit(1);
    4f88:	4505                	li	a0,1
    4f8a:	00002097          	auipc	ra,0x2
    4f8e:	688080e7          	jalr	1672(ra) # 7612 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
    4f92:	4501                	li	a0,0
    4f94:	00002097          	auipc	ra,0x2
    4f98:	686080e7          	jalr	1670(ra) # 761a <wait>
    4f9c:	87aa                	mv	a5,a0
    4f9e:	0207d163          	bgez	a5,4fc0 <forktest+0xdc>
      printf("%s: wait stopped early\n", s);
    4fa2:	fd843583          	ld	a1,-40(s0)
    4fa6:	00005517          	auipc	a0,0x5
    4faa:	91a50513          	addi	a0,a0,-1766 # 98c0 <malloc+0x1b5c>
    4fae:	00003097          	auipc	ra,0x3
    4fb2:	bc4080e7          	jalr	-1084(ra) # 7b72 <printf>
      exit(1);
    4fb6:	4505                	li	a0,1
    4fb8:	00002097          	auipc	ra,0x2
    4fbc:	65a080e7          	jalr	1626(ra) # 7612 <exit>
  for(; n > 0; n--){
    4fc0:	fec42783          	lw	a5,-20(s0)
    4fc4:	37fd                	addiw	a5,a5,-1
    4fc6:	fef42623          	sw	a5,-20(s0)
    4fca:	fec42783          	lw	a5,-20(s0)
    4fce:	2781                	sext.w	a5,a5
    4fd0:	fcf041e3          	bgtz	a5,4f92 <forktest+0xae>
    }
  }

  if(wait(0) != -1){
    4fd4:	4501                	li	a0,0
    4fd6:	00002097          	auipc	ra,0x2
    4fda:	644080e7          	jalr	1604(ra) # 761a <wait>
    4fde:	87aa                	mv	a5,a0
    4fe0:	873e                	mv	a4,a5
    4fe2:	57fd                	li	a5,-1
    4fe4:	02f70163          	beq	a4,a5,5006 <forktest+0x122>
    printf("%s: wait got too many\n", s);
    4fe8:	fd843583          	ld	a1,-40(s0)
    4fec:	00005517          	auipc	a0,0x5
    4ff0:	8ec50513          	addi	a0,a0,-1812 # 98d8 <malloc+0x1b74>
    4ff4:	00003097          	auipc	ra,0x3
    4ff8:	b7e080e7          	jalr	-1154(ra) # 7b72 <printf>
    exit(1);
    4ffc:	4505                	li	a0,1
    4ffe:	00002097          	auipc	ra,0x2
    5002:	614080e7          	jalr	1556(ra) # 7612 <exit>
  }
}
    5006:	0001                	nop
    5008:	70a2                	ld	ra,40(sp)
    500a:	7402                	ld	s0,32(sp)
    500c:	6145                	addi	sp,sp,48
    500e:	8082                	ret

0000000000005010 <sbrkbasic>:

void
sbrkbasic(char *s)
{
    5010:	715d                	addi	sp,sp,-80
    5012:	e486                	sd	ra,72(sp)
    5014:	e0a2                	sd	s0,64(sp)
    5016:	0880                	addi	s0,sp,80
    5018:	faa43c23          	sd	a0,-72(s0)
  enum { TOOMUCH=1024*1024*1024};
  int i, pid, xstatus;
  char *c, *a, *b;

  // does sbrk() return the expected failure value?
  pid = fork();
    501c:	00002097          	auipc	ra,0x2
    5020:	5ee080e7          	jalr	1518(ra) # 760a <fork>
    5024:	87aa                	mv	a5,a0
    5026:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    502a:	fd442783          	lw	a5,-44(s0)
    502e:	2781                	sext.w	a5,a5
    5030:	0007df63          	bgez	a5,504e <sbrkbasic+0x3e>
    printf("fork failed in sbrkbasic\n");
    5034:	00005517          	auipc	a0,0x5
    5038:	8bc50513          	addi	a0,a0,-1860 # 98f0 <malloc+0x1b8c>
    503c:	00003097          	auipc	ra,0x3
    5040:	b36080e7          	jalr	-1226(ra) # 7b72 <printf>
    exit(1);
    5044:	4505                	li	a0,1
    5046:	00002097          	auipc	ra,0x2
    504a:	5cc080e7          	jalr	1484(ra) # 7612 <exit>
  }
  if(pid == 0){
    504e:	fd442783          	lw	a5,-44(s0)
    5052:	2781                	sext.w	a5,a5
    5054:	e3b5                	bnez	a5,50b8 <sbrkbasic+0xa8>
    a = sbrk(TOOMUCH);
    5056:	40000537          	lui	a0,0x40000
    505a:	00002097          	auipc	ra,0x2
    505e:	640080e7          	jalr	1600(ra) # 769a <sbrk>
    5062:	fea43023          	sd	a0,-32(s0)
    if(a == (char*)0xffffffffffffffffL){
    5066:	fe043703          	ld	a4,-32(s0)
    506a:	57fd                	li	a5,-1
    506c:	00f71763          	bne	a4,a5,507a <sbrkbasic+0x6a>
      // it's OK if this fails.
      exit(0);
    5070:	4501                	li	a0,0
    5072:	00002097          	auipc	ra,0x2
    5076:	5a0080e7          	jalr	1440(ra) # 7612 <exit>
    }

    for(b = a; b < a+TOOMUCH; b += 4096){
    507a:	fe043783          	ld	a5,-32(s0)
    507e:	fcf43c23          	sd	a5,-40(s0)
    5082:	a829                	j	509c <sbrkbasic+0x8c>
      *b = 99;
    5084:	fd843783          	ld	a5,-40(s0)
    5088:	06300713          	li	a4,99
    508c:	00e78023          	sb	a4,0(a5)
    for(b = a; b < a+TOOMUCH; b += 4096){
    5090:	fd843703          	ld	a4,-40(s0)
    5094:	6785                	lui	a5,0x1
    5096:	97ba                	add	a5,a5,a4
    5098:	fcf43c23          	sd	a5,-40(s0)
    509c:	fe043703          	ld	a4,-32(s0)
    50a0:	400007b7          	lui	a5,0x40000
    50a4:	97ba                	add	a5,a5,a4
    50a6:	fd843703          	ld	a4,-40(s0)
    50aa:	fcf76de3          	bltu	a4,a5,5084 <sbrkbasic+0x74>
    }

    // we should not get here! either sbrk(TOOMUCH)
    // should have failed, or (with lazy allocation)
    // a pagefault should have killed this process.
    exit(1);
    50ae:	4505                	li	a0,1
    50b0:	00002097          	auipc	ra,0x2
    50b4:	562080e7          	jalr	1378(ra) # 7612 <exit>
  }

  wait(&xstatus);
    50b8:	fc440793          	addi	a5,s0,-60
    50bc:	853e                	mv	a0,a5
    50be:	00002097          	auipc	ra,0x2
    50c2:	55c080e7          	jalr	1372(ra) # 761a <wait>
  if(xstatus == 1){
    50c6:	fc442783          	lw	a5,-60(s0)
    50ca:	873e                	mv	a4,a5
    50cc:	4785                	li	a5,1
    50ce:	02f71163          	bne	a4,a5,50f0 <sbrkbasic+0xe0>
    printf("%s: too much memory allocated!\n", s);
    50d2:	fb843583          	ld	a1,-72(s0)
    50d6:	00005517          	auipc	a0,0x5
    50da:	83a50513          	addi	a0,a0,-1990 # 9910 <malloc+0x1bac>
    50de:	00003097          	auipc	ra,0x3
    50e2:	a94080e7          	jalr	-1388(ra) # 7b72 <printf>
    exit(1);
    50e6:	4505                	li	a0,1
    50e8:	00002097          	auipc	ra,0x2
    50ec:	52a080e7          	jalr	1322(ra) # 7612 <exit>
  }

  // can one sbrk() less than a page?
  a = sbrk(0);
    50f0:	4501                	li	a0,0
    50f2:	00002097          	auipc	ra,0x2
    50f6:	5a8080e7          	jalr	1448(ra) # 769a <sbrk>
    50fa:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < 5000; i++){
    50fe:	fe042623          	sw	zero,-20(s0)
    5102:	a09d                	j	5168 <sbrkbasic+0x158>
    b = sbrk(1);
    5104:	4505                	li	a0,1
    5106:	00002097          	auipc	ra,0x2
    510a:	594080e7          	jalr	1428(ra) # 769a <sbrk>
    510e:	fca43c23          	sd	a0,-40(s0)
    if(b != a){
    5112:	fd843703          	ld	a4,-40(s0)
    5116:	fe043783          	ld	a5,-32(s0)
    511a:	02f70863          	beq	a4,a5,514a <sbrkbasic+0x13a>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    511e:	fec42783          	lw	a5,-20(s0)
    5122:	fd843703          	ld	a4,-40(s0)
    5126:	fe043683          	ld	a3,-32(s0)
    512a:	863e                	mv	a2,a5
    512c:	fb843583          	ld	a1,-72(s0)
    5130:	00005517          	auipc	a0,0x5
    5134:	80050513          	addi	a0,a0,-2048 # 9930 <malloc+0x1bcc>
    5138:	00003097          	auipc	ra,0x3
    513c:	a3a080e7          	jalr	-1478(ra) # 7b72 <printf>
      exit(1);
    5140:	4505                	li	a0,1
    5142:	00002097          	auipc	ra,0x2
    5146:	4d0080e7          	jalr	1232(ra) # 7612 <exit>
    }
    *b = 1;
    514a:	fd843783          	ld	a5,-40(s0)
    514e:	4705                	li	a4,1
    5150:	00e78023          	sb	a4,0(a5) # 40000000 <freep+0x3ffed4f8>
    a = b + 1;
    5154:	fd843783          	ld	a5,-40(s0)
    5158:	0785                	addi	a5,a5,1
    515a:	fef43023          	sd	a5,-32(s0)
  for(i = 0; i < 5000; i++){
    515e:	fec42783          	lw	a5,-20(s0)
    5162:	2785                	addiw	a5,a5,1
    5164:	fef42623          	sw	a5,-20(s0)
    5168:	fec42783          	lw	a5,-20(s0)
    516c:	0007871b          	sext.w	a4,a5
    5170:	6785                	lui	a5,0x1
    5172:	38778793          	addi	a5,a5,903 # 1387 <openiputtest+0xe9>
    5176:	f8e7d7e3          	bge	a5,a4,5104 <sbrkbasic+0xf4>
  }
  pid = fork();
    517a:	00002097          	auipc	ra,0x2
    517e:	490080e7          	jalr	1168(ra) # 760a <fork>
    5182:	87aa                	mv	a5,a0
    5184:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    5188:	fd442783          	lw	a5,-44(s0)
    518c:	2781                	sext.w	a5,a5
    518e:	0207d163          	bgez	a5,51b0 <sbrkbasic+0x1a0>
    printf("%s: sbrk test fork failed\n", s);
    5192:	fb843583          	ld	a1,-72(s0)
    5196:	00004517          	auipc	a0,0x4
    519a:	7ba50513          	addi	a0,a0,1978 # 9950 <malloc+0x1bec>
    519e:	00003097          	auipc	ra,0x3
    51a2:	9d4080e7          	jalr	-1580(ra) # 7b72 <printf>
    exit(1);
    51a6:	4505                	li	a0,1
    51a8:	00002097          	auipc	ra,0x2
    51ac:	46a080e7          	jalr	1130(ra) # 7612 <exit>
  }
  c = sbrk(1);
    51b0:	4505                	li	a0,1
    51b2:	00002097          	auipc	ra,0x2
    51b6:	4e8080e7          	jalr	1256(ra) # 769a <sbrk>
    51ba:	fca43423          	sd	a0,-56(s0)
  c = sbrk(1);
    51be:	4505                	li	a0,1
    51c0:	00002097          	auipc	ra,0x2
    51c4:	4da080e7          	jalr	1242(ra) # 769a <sbrk>
    51c8:	fca43423          	sd	a0,-56(s0)
  if(c != a + 1){
    51cc:	fe043783          	ld	a5,-32(s0)
    51d0:	0785                	addi	a5,a5,1
    51d2:	fc843703          	ld	a4,-56(s0)
    51d6:	02f70163          	beq	a4,a5,51f8 <sbrkbasic+0x1e8>
    printf("%s: sbrk test failed post-fork\n", s);
    51da:	fb843583          	ld	a1,-72(s0)
    51de:	00004517          	auipc	a0,0x4
    51e2:	79250513          	addi	a0,a0,1938 # 9970 <malloc+0x1c0c>
    51e6:	00003097          	auipc	ra,0x3
    51ea:	98c080e7          	jalr	-1652(ra) # 7b72 <printf>
    exit(1);
    51ee:	4505                	li	a0,1
    51f0:	00002097          	auipc	ra,0x2
    51f4:	422080e7          	jalr	1058(ra) # 7612 <exit>
  }
  if(pid == 0)
    51f8:	fd442783          	lw	a5,-44(s0)
    51fc:	2781                	sext.w	a5,a5
    51fe:	e791                	bnez	a5,520a <sbrkbasic+0x1fa>
    exit(0);
    5200:	4501                	li	a0,0
    5202:	00002097          	auipc	ra,0x2
    5206:	410080e7          	jalr	1040(ra) # 7612 <exit>
  wait(&xstatus);
    520a:	fc440793          	addi	a5,s0,-60
    520e:	853e                	mv	a0,a5
    5210:	00002097          	auipc	ra,0x2
    5214:	40a080e7          	jalr	1034(ra) # 761a <wait>
  exit(xstatus);
    5218:	fc442783          	lw	a5,-60(s0)
    521c:	853e                	mv	a0,a5
    521e:	00002097          	auipc	ra,0x2
    5222:	3f4080e7          	jalr	1012(ra) # 7612 <exit>

0000000000005226 <sbrkmuch>:
}

void
sbrkmuch(char *s)
{
    5226:	1101                	addi	sp,sp,-32
    5228:	ec22                	sd	s0,24(sp)
    522a:	1000                	addi	s0,sp,32
    522c:	fea43423          	sd	a0,-24(s0)
//  c = sbrk(-(sbrk(0) - oldbrk));
//  if(c != a){
//    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
//    exit(1);
//  }
}
    5230:	0001                	nop
    5232:	6462                	ld	s0,24(sp)
    5234:	6105                	addi	sp,sp,32
    5236:	8082                	ret

0000000000005238 <kernmem>:

// can we read the kernel's memory?
void
kernmem(char *s)
{
    5238:	7179                	addi	sp,sp,-48
    523a:	f406                	sd	ra,40(sp)
    523c:	f022                	sd	s0,32(sp)
    523e:	1800                	addi	s0,sp,48
    5240:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int pid;

  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5244:	4785                	li	a5,1
    5246:	07fe                	slli	a5,a5,0x1f
    5248:	fef43423          	sd	a5,-24(s0)
    524c:	a04d                	j	52ee <kernmem+0xb6>
    pid = fork();
    524e:	00002097          	auipc	ra,0x2
    5252:	3bc080e7          	jalr	956(ra) # 760a <fork>
    5256:	87aa                	mv	a5,a0
    5258:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    525c:	fe442783          	lw	a5,-28(s0)
    5260:	2781                	sext.w	a5,a5
    5262:	0207d163          	bgez	a5,5284 <kernmem+0x4c>
      printf("%s: fork failed\n", s);
    5266:	fd843583          	ld	a1,-40(s0)
    526a:	00003517          	auipc	a0,0x3
    526e:	07650513          	addi	a0,a0,118 # 82e0 <malloc+0x57c>
    5272:	00003097          	auipc	ra,0x3
    5276:	900080e7          	jalr	-1792(ra) # 7b72 <printf>
      exit(1);
    527a:	4505                	li	a0,1
    527c:	00002097          	auipc	ra,0x2
    5280:	396080e7          	jalr	918(ra) # 7612 <exit>
    }
    if(pid == 0){
    5284:	fe442783          	lw	a5,-28(s0)
    5288:	2781                	sext.w	a5,a5
    528a:	eb85                	bnez	a5,52ba <kernmem+0x82>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    528c:	fe843783          	ld	a5,-24(s0)
    5290:	0007c783          	lbu	a5,0(a5)
    5294:	2781                	sext.w	a5,a5
    5296:	86be                	mv	a3,a5
    5298:	fe843603          	ld	a2,-24(s0)
    529c:	fd843583          	ld	a1,-40(s0)
    52a0:	00004517          	auipc	a0,0x4
    52a4:	6f050513          	addi	a0,a0,1776 # 9990 <malloc+0x1c2c>
    52a8:	00003097          	auipc	ra,0x3
    52ac:	8ca080e7          	jalr	-1846(ra) # 7b72 <printf>
      exit(1);
    52b0:	4505                	li	a0,1
    52b2:	00002097          	auipc	ra,0x2
    52b6:	360080e7          	jalr	864(ra) # 7612 <exit>
    }
    int xstatus;
    wait(&xstatus);
    52ba:	fe040793          	addi	a5,s0,-32
    52be:	853e                	mv	a0,a5
    52c0:	00002097          	auipc	ra,0x2
    52c4:	35a080e7          	jalr	858(ra) # 761a <wait>
    if(xstatus != -1)  // did kernel kill child?
    52c8:	fe042783          	lw	a5,-32(s0)
    52cc:	873e                	mv	a4,a5
    52ce:	57fd                	li	a5,-1
    52d0:	00f70763          	beq	a4,a5,52de <kernmem+0xa6>
      exit(1);
    52d4:	4505                	li	a0,1
    52d6:	00002097          	auipc	ra,0x2
    52da:	33c080e7          	jalr	828(ra) # 7612 <exit>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    52de:	fe843703          	ld	a4,-24(s0)
    52e2:	67b1                	lui	a5,0xc
    52e4:	35078793          	addi	a5,a5,848 # c350 <buf+0x70>
    52e8:	97ba                	add	a5,a5,a4
    52ea:	fef43423          	sd	a5,-24(s0)
    52ee:	fe843703          	ld	a4,-24(s0)
    52f2:	1003d7b7          	lui	a5,0x1003d
    52f6:	078e                	slli	a5,a5,0x3
    52f8:	47f78793          	addi	a5,a5,1151 # 1003d47f <freep+0x1002a977>
    52fc:	f4e7f9e3          	bgeu	a5,a4,524e <kernmem+0x16>
  }
}
    5300:	0001                	nop
    5302:	0001                	nop
    5304:	70a2                	ld	ra,40(sp)
    5306:	7402                	ld	s0,32(sp)
    5308:	6145                	addi	sp,sp,48
    530a:	8082                	ret

000000000000530c <MAXVAplus>:

// user code should not be able to write to addresses above MAXVA.
void
MAXVAplus(char *s)
{
    530c:	7139                	addi	sp,sp,-64
    530e:	fc06                	sd	ra,56(sp)
    5310:	f822                	sd	s0,48(sp)
    5312:	0080                	addi	s0,sp,64
    5314:	fca43423          	sd	a0,-56(s0)
  volatile uint64 a = MAXVA;
    5318:	4785                	li	a5,1
    531a:	179a                	slli	a5,a5,0x26
    531c:	fef43023          	sd	a5,-32(s0)
  for( ; a != 0; a <<= 1){
    5320:	a045                	j	53c0 <MAXVAplus+0xb4>
    int pid;
    pid = fork();
    5322:	00002097          	auipc	ra,0x2
    5326:	2e8080e7          	jalr	744(ra) # 760a <fork>
    532a:	87aa                	mv	a5,a0
    532c:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
    5330:	fec42783          	lw	a5,-20(s0)
    5334:	2781                	sext.w	a5,a5
    5336:	0207d163          	bgez	a5,5358 <MAXVAplus+0x4c>
      printf("%s: fork failed\n", s);
    533a:	fc843583          	ld	a1,-56(s0)
    533e:	00003517          	auipc	a0,0x3
    5342:	fa250513          	addi	a0,a0,-94 # 82e0 <malloc+0x57c>
    5346:	00003097          	auipc	ra,0x3
    534a:	82c080e7          	jalr	-2004(ra) # 7b72 <printf>
      exit(1);
    534e:	4505                	li	a0,1
    5350:	00002097          	auipc	ra,0x2
    5354:	2c2080e7          	jalr	706(ra) # 7612 <exit>
    }
    if(pid == 0){
    5358:	fec42783          	lw	a5,-20(s0)
    535c:	2781                	sext.w	a5,a5
    535e:	eb95                	bnez	a5,5392 <MAXVAplus+0x86>
      *(char*)a = 99;
    5360:	fe043783          	ld	a5,-32(s0)
    5364:	873e                	mv	a4,a5
    5366:	06300793          	li	a5,99
    536a:	00f70023          	sb	a5,0(a4)
      printf("%s: oops wrote %x\n", s, a);
    536e:	fe043783          	ld	a5,-32(s0)
    5372:	863e                	mv	a2,a5
    5374:	fc843583          	ld	a1,-56(s0)
    5378:	00004517          	auipc	a0,0x4
    537c:	63850513          	addi	a0,a0,1592 # 99b0 <malloc+0x1c4c>
    5380:	00002097          	auipc	ra,0x2
    5384:	7f2080e7          	jalr	2034(ra) # 7b72 <printf>
      exit(1);
    5388:	4505                	li	a0,1
    538a:	00002097          	auipc	ra,0x2
    538e:	288080e7          	jalr	648(ra) # 7612 <exit>
    }
    int xstatus;
    wait(&xstatus);
    5392:	fdc40793          	addi	a5,s0,-36
    5396:	853e                	mv	a0,a5
    5398:	00002097          	auipc	ra,0x2
    539c:	282080e7          	jalr	642(ra) # 761a <wait>
    if(xstatus != -1)  // did kernel kill child?
    53a0:	fdc42783          	lw	a5,-36(s0)
    53a4:	873e                	mv	a4,a5
    53a6:	57fd                	li	a5,-1
    53a8:	00f70763          	beq	a4,a5,53b6 <MAXVAplus+0xaa>
      exit(1);
    53ac:	4505                	li	a0,1
    53ae:	00002097          	auipc	ra,0x2
    53b2:	264080e7          	jalr	612(ra) # 7612 <exit>
  for( ; a != 0; a <<= 1){
    53b6:	fe043783          	ld	a5,-32(s0)
    53ba:	0786                	slli	a5,a5,0x1
    53bc:	fef43023          	sd	a5,-32(s0)
    53c0:	fe043783          	ld	a5,-32(s0)
    53c4:	ffb9                	bnez	a5,5322 <MAXVAplus+0x16>
  }
}
    53c6:	0001                	nop
    53c8:	0001                	nop
    53ca:	70e2                	ld	ra,56(sp)
    53cc:	7442                	ld	s0,48(sp)
    53ce:	6121                	addi	sp,sp,64
    53d0:	8082                	ret

00000000000053d2 <sbrkfail>:

// if we run the system out of memory, does it clean up the last
// failed allocation?
void
sbrkfail(char *s)
{
    53d2:	7119                	addi	sp,sp,-128
    53d4:	fc86                	sd	ra,120(sp)
    53d6:	f8a2                	sd	s0,112(sp)
    53d8:	0100                	addi	s0,sp,128
    53da:	f8a43423          	sd	a0,-120(s0)
  char scratch;
  char *c, *a;
  int pids[10];
  int pid;

  if(pipe(fds) != 0){
    53de:	fc040793          	addi	a5,s0,-64
    53e2:	853e                	mv	a0,a5
    53e4:	00002097          	auipc	ra,0x2
    53e8:	23e080e7          	jalr	574(ra) # 7622 <pipe>
    53ec:	87aa                	mv	a5,a0
    53ee:	c385                	beqz	a5,540e <sbrkfail+0x3c>
    printf("%s: pipe() failed\n", s);
    53f0:	f8843583          	ld	a1,-120(s0)
    53f4:	00003517          	auipc	a0,0x3
    53f8:	38450513          	addi	a0,a0,900 # 8778 <malloc+0xa14>
    53fc:	00002097          	auipc	ra,0x2
    5400:	776080e7          	jalr	1910(ra) # 7b72 <printf>
    exit(1);
    5404:	4505                	li	a0,1
    5406:	00002097          	auipc	ra,0x2
    540a:	20c080e7          	jalr	524(ra) # 7612 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    540e:	fe042623          	sw	zero,-20(s0)
    5412:	a075                	j	54be <sbrkfail+0xec>
    if((pids[i] = fork()) == 0){
    5414:	00002097          	auipc	ra,0x2
    5418:	1f6080e7          	jalr	502(ra) # 760a <fork>
    541c:	87aa                	mv	a5,a0
    541e:	873e                	mv	a4,a5
    5420:	fec42783          	lw	a5,-20(s0)
    5424:	078a                	slli	a5,a5,0x2
    5426:	17c1                	addi	a5,a5,-16
    5428:	97a2                	add	a5,a5,s0
    542a:	fae7a023          	sw	a4,-96(a5)
    542e:	fec42783          	lw	a5,-20(s0)
    5432:	078a                	slli	a5,a5,0x2
    5434:	17c1                	addi	a5,a5,-16
    5436:	97a2                	add	a5,a5,s0
    5438:	fa07a783          	lw	a5,-96(a5)
    543c:	e7b1                	bnez	a5,5488 <sbrkfail+0xb6>
      // allocate a lot of memory
      sbrk(BIG - (uint64)sbrk(0));
    543e:	4501                	li	a0,0
    5440:	00002097          	auipc	ra,0x2
    5444:	25a080e7          	jalr	602(ra) # 769a <sbrk>
    5448:	87aa                	mv	a5,a0
    544a:	2781                	sext.w	a5,a5
    544c:	06400737          	lui	a4,0x6400
    5450:	40f707bb          	subw	a5,a4,a5
    5454:	2781                	sext.w	a5,a5
    5456:	2781                	sext.w	a5,a5
    5458:	853e                	mv	a0,a5
    545a:	00002097          	auipc	ra,0x2
    545e:	240080e7          	jalr	576(ra) # 769a <sbrk>
      write(fds[1], "x", 1);
    5462:	fc442783          	lw	a5,-60(s0)
    5466:	4605                	li	a2,1
    5468:	00003597          	auipc	a1,0x3
    546c:	b4858593          	addi	a1,a1,-1208 # 7fb0 <malloc+0x24c>
    5470:	853e                	mv	a0,a5
    5472:	00002097          	auipc	ra,0x2
    5476:	1c0080e7          	jalr	448(ra) # 7632 <write>
      // sit around until killed
      for(;;) sleep(1000);
    547a:	3e800513          	li	a0,1000
    547e:	00002097          	auipc	ra,0x2
    5482:	224080e7          	jalr	548(ra) # 76a2 <sleep>
    5486:	bfd5                	j	547a <sbrkfail+0xa8>
    }
    if(pids[i] != -1)
    5488:	fec42783          	lw	a5,-20(s0)
    548c:	078a                	slli	a5,a5,0x2
    548e:	17c1                	addi	a5,a5,-16
    5490:	97a2                	add	a5,a5,s0
    5492:	fa07a783          	lw	a5,-96(a5)
    5496:	873e                	mv	a4,a5
    5498:	57fd                	li	a5,-1
    549a:	00f70d63          	beq	a4,a5,54b4 <sbrkfail+0xe2>
      read(fds[0], &scratch, 1);
    549e:	fc042783          	lw	a5,-64(s0)
    54a2:	fbf40713          	addi	a4,s0,-65
    54a6:	4605                	li	a2,1
    54a8:	85ba                	mv	a1,a4
    54aa:	853e                	mv	a0,a5
    54ac:	00002097          	auipc	ra,0x2
    54b0:	17e080e7          	jalr	382(ra) # 762a <read>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    54b4:	fec42783          	lw	a5,-20(s0)
    54b8:	2785                	addiw	a5,a5,1
    54ba:	fef42623          	sw	a5,-20(s0)
    54be:	fec42783          	lw	a5,-20(s0)
    54c2:	873e                	mv	a4,a5
    54c4:	47a5                	li	a5,9
    54c6:	f4e7f7e3          	bgeu	a5,a4,5414 <sbrkfail+0x42>
  }

  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(PGSIZE);
    54ca:	6505                	lui	a0,0x1
    54cc:	00002097          	auipc	ra,0x2
    54d0:	1ce080e7          	jalr	462(ra) # 769a <sbrk>
    54d4:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    54d8:	fe042623          	sw	zero,-20(s0)
    54dc:	a0a1                	j	5524 <sbrkfail+0x152>
    if(pids[i] == -1)
    54de:	fec42783          	lw	a5,-20(s0)
    54e2:	078a                	slli	a5,a5,0x2
    54e4:	17c1                	addi	a5,a5,-16
    54e6:	97a2                	add	a5,a5,s0
    54e8:	fa07a783          	lw	a5,-96(a5)
    54ec:	873e                	mv	a4,a5
    54ee:	57fd                	li	a5,-1
    54f0:	02f70463          	beq	a4,a5,5518 <sbrkfail+0x146>
      continue;
    kill(pids[i]);
    54f4:	fec42783          	lw	a5,-20(s0)
    54f8:	078a                	slli	a5,a5,0x2
    54fa:	17c1                	addi	a5,a5,-16
    54fc:	97a2                	add	a5,a5,s0
    54fe:	fa07a783          	lw	a5,-96(a5)
    5502:	853e                	mv	a0,a5
    5504:	00002097          	auipc	ra,0x2
    5508:	13e080e7          	jalr	318(ra) # 7642 <kill>
    wait(0);
    550c:	4501                	li	a0,0
    550e:	00002097          	auipc	ra,0x2
    5512:	10c080e7          	jalr	268(ra) # 761a <wait>
    5516:	a011                	j	551a <sbrkfail+0x148>
      continue;
    5518:	0001                	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    551a:	fec42783          	lw	a5,-20(s0)
    551e:	2785                	addiw	a5,a5,1
    5520:	fef42623          	sw	a5,-20(s0)
    5524:	fec42783          	lw	a5,-20(s0)
    5528:	873e                	mv	a4,a5
    552a:	47a5                	li	a5,9
    552c:	fae7f9e3          	bgeu	a5,a4,54de <sbrkfail+0x10c>
  }
  if(c == (char*)0xffffffffffffffffL){
    5530:	fe043703          	ld	a4,-32(s0)
    5534:	57fd                	li	a5,-1
    5536:	02f71163          	bne	a4,a5,5558 <sbrkfail+0x186>
    printf("%s: failed sbrk leaked memory\n", s);
    553a:	f8843583          	ld	a1,-120(s0)
    553e:	00004517          	auipc	a0,0x4
    5542:	48a50513          	addi	a0,a0,1162 # 99c8 <malloc+0x1c64>
    5546:	00002097          	auipc	ra,0x2
    554a:	62c080e7          	jalr	1580(ra) # 7b72 <printf>
    exit(1);
    554e:	4505                	li	a0,1
    5550:	00002097          	auipc	ra,0x2
    5554:	0c2080e7          	jalr	194(ra) # 7612 <exit>
  }

  // test running fork with the above allocated page
  pid = fork();
    5558:	00002097          	auipc	ra,0x2
    555c:	0b2080e7          	jalr	178(ra) # 760a <fork>
    5560:	87aa                	mv	a5,a0
    5562:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
    5566:	fdc42783          	lw	a5,-36(s0)
    556a:	2781                	sext.w	a5,a5
    556c:	0207d163          	bgez	a5,558e <sbrkfail+0x1bc>
    printf("%s: fork failed\n", s);
    5570:	f8843583          	ld	a1,-120(s0)
    5574:	00003517          	auipc	a0,0x3
    5578:	d6c50513          	addi	a0,a0,-660 # 82e0 <malloc+0x57c>
    557c:	00002097          	auipc	ra,0x2
    5580:	5f6080e7          	jalr	1526(ra) # 7b72 <printf>
    exit(1);
    5584:	4505                	li	a0,1
    5586:	00002097          	auipc	ra,0x2
    558a:	08c080e7          	jalr	140(ra) # 7612 <exit>
  }
  if(pid == 0){
    558e:	fdc42783          	lw	a5,-36(s0)
    5592:	2781                	sext.w	a5,a5
    5594:	e3c9                	bnez	a5,5616 <sbrkfail+0x244>
    // allocate a lot of memory.
    // this should produce a page fault,
    // and thus not complete.
    a = sbrk(0);
    5596:	4501                	li	a0,0
    5598:	00002097          	auipc	ra,0x2
    559c:	102080e7          	jalr	258(ra) # 769a <sbrk>
    55a0:	fca43823          	sd	a0,-48(s0)
    sbrk(10*BIG);
    55a4:	3e800537          	lui	a0,0x3e800
    55a8:	00002097          	auipc	ra,0x2
    55ac:	0f2080e7          	jalr	242(ra) # 769a <sbrk>
    int n = 0;
    55b0:	fe042423          	sw	zero,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    55b4:	fe042623          	sw	zero,-20(s0)
    55b8:	a02d                	j	55e2 <sbrkfail+0x210>
      n += *(a+i);
    55ba:	fec42783          	lw	a5,-20(s0)
    55be:	fd043703          	ld	a4,-48(s0)
    55c2:	97ba                	add	a5,a5,a4
    55c4:	0007c783          	lbu	a5,0(a5)
    55c8:	2781                	sext.w	a5,a5
    55ca:	fe842703          	lw	a4,-24(s0)
    55ce:	9fb9                	addw	a5,a5,a4
    55d0:	fef42423          	sw	a5,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    55d4:	fec42783          	lw	a5,-20(s0)
    55d8:	873e                	mv	a4,a5
    55da:	6785                	lui	a5,0x1
    55dc:	9fb9                	addw	a5,a5,a4
    55de:	fef42623          	sw	a5,-20(s0)
    55e2:	fec42783          	lw	a5,-20(s0)
    55e6:	0007871b          	sext.w	a4,a5
    55ea:	3e8007b7          	lui	a5,0x3e800
    55ee:	fcf746e3          	blt	a4,a5,55ba <sbrkfail+0x1e8>
    }
    // print n so the compiler doesn't optimize away
    // the for loop.
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    55f2:	fe842783          	lw	a5,-24(s0)
    55f6:	863e                	mv	a2,a5
    55f8:	f8843583          	ld	a1,-120(s0)
    55fc:	00004517          	auipc	a0,0x4
    5600:	3ec50513          	addi	a0,a0,1004 # 99e8 <malloc+0x1c84>
    5604:	00002097          	auipc	ra,0x2
    5608:	56e080e7          	jalr	1390(ra) # 7b72 <printf>
    exit(1);
    560c:	4505                	li	a0,1
    560e:	00002097          	auipc	ra,0x2
    5612:	004080e7          	jalr	4(ra) # 7612 <exit>
  }
  wait(&xstatus);
    5616:	fcc40793          	addi	a5,s0,-52
    561a:	853e                	mv	a0,a5
    561c:	00002097          	auipc	ra,0x2
    5620:	ffe080e7          	jalr	-2(ra) # 761a <wait>
  if(xstatus != -1 && xstatus != 2)
    5624:	fcc42783          	lw	a5,-52(s0)
    5628:	873e                	mv	a4,a5
    562a:	57fd                	li	a5,-1
    562c:	00f70d63          	beq	a4,a5,5646 <sbrkfail+0x274>
    5630:	fcc42783          	lw	a5,-52(s0)
    5634:	873e                	mv	a4,a5
    5636:	4789                	li	a5,2
    5638:	00f70763          	beq	a4,a5,5646 <sbrkfail+0x274>
    exit(1);
    563c:	4505                	li	a0,1
    563e:	00002097          	auipc	ra,0x2
    5642:	fd4080e7          	jalr	-44(ra) # 7612 <exit>
}
    5646:	0001                	nop
    5648:	70e6                	ld	ra,120(sp)
    564a:	7446                	ld	s0,112(sp)
    564c:	6109                	addi	sp,sp,128
    564e:	8082                	ret

0000000000005650 <sbrkarg>:


// test reads/writes from/to allocated memory
void
sbrkarg(char *s)
{
    5650:	7179                	addi	sp,sp,-48
    5652:	f406                	sd	ra,40(sp)
    5654:	f022                	sd	s0,32(sp)
    5656:	1800                	addi	s0,sp,48
    5658:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int fd, n;

  a = sbrk(PGSIZE);
    565c:	6505                	lui	a0,0x1
    565e:	00002097          	auipc	ra,0x2
    5662:	03c080e7          	jalr	60(ra) # 769a <sbrk>
    5666:	fea43423          	sd	a0,-24(s0)
  fd = open("sbrk", O_CREATE|O_WRONLY);
    566a:	20100593          	li	a1,513
    566e:	00004517          	auipc	a0,0x4
    5672:	3aa50513          	addi	a0,a0,938 # 9a18 <malloc+0x1cb4>
    5676:	00002097          	auipc	ra,0x2
    567a:	fdc080e7          	jalr	-36(ra) # 7652 <open>
    567e:	87aa                	mv	a5,a0
    5680:	fef42223          	sw	a5,-28(s0)
  unlink("sbrk");
    5684:	00004517          	auipc	a0,0x4
    5688:	39450513          	addi	a0,a0,916 # 9a18 <malloc+0x1cb4>
    568c:	00002097          	auipc	ra,0x2
    5690:	fd6080e7          	jalr	-42(ra) # 7662 <unlink>
  if(fd < 0)  {
    5694:	fe442783          	lw	a5,-28(s0)
    5698:	2781                	sext.w	a5,a5
    569a:	0207d163          	bgez	a5,56bc <sbrkarg+0x6c>
    printf("%s: open sbrk failed\n", s);
    569e:	fd843583          	ld	a1,-40(s0)
    56a2:	00004517          	auipc	a0,0x4
    56a6:	37e50513          	addi	a0,a0,894 # 9a20 <malloc+0x1cbc>
    56aa:	00002097          	auipc	ra,0x2
    56ae:	4c8080e7          	jalr	1224(ra) # 7b72 <printf>
    exit(1);
    56b2:	4505                	li	a0,1
    56b4:	00002097          	auipc	ra,0x2
    56b8:	f5e080e7          	jalr	-162(ra) # 7612 <exit>
  }
  if ((n = write(fd, a, PGSIZE)) < 0) {
    56bc:	fe442783          	lw	a5,-28(s0)
    56c0:	6605                	lui	a2,0x1
    56c2:	fe843583          	ld	a1,-24(s0)
    56c6:	853e                	mv	a0,a5
    56c8:	00002097          	auipc	ra,0x2
    56cc:	f6a080e7          	jalr	-150(ra) # 7632 <write>
    56d0:	87aa                	mv	a5,a0
    56d2:	fef42023          	sw	a5,-32(s0)
    56d6:	fe042783          	lw	a5,-32(s0)
    56da:	2781                	sext.w	a5,a5
    56dc:	0207d163          	bgez	a5,56fe <sbrkarg+0xae>
    printf("%s: write sbrk failed\n", s);
    56e0:	fd843583          	ld	a1,-40(s0)
    56e4:	00004517          	auipc	a0,0x4
    56e8:	35450513          	addi	a0,a0,852 # 9a38 <malloc+0x1cd4>
    56ec:	00002097          	auipc	ra,0x2
    56f0:	486080e7          	jalr	1158(ra) # 7b72 <printf>
    exit(1);
    56f4:	4505                	li	a0,1
    56f6:	00002097          	auipc	ra,0x2
    56fa:	f1c080e7          	jalr	-228(ra) # 7612 <exit>
  }
  close(fd);
    56fe:	fe442783          	lw	a5,-28(s0)
    5702:	853e                	mv	a0,a5
    5704:	00002097          	auipc	ra,0x2
    5708:	f36080e7          	jalr	-202(ra) # 763a <close>

  // test writes to allocated memory
  a = sbrk(PGSIZE);
    570c:	6505                	lui	a0,0x1
    570e:	00002097          	auipc	ra,0x2
    5712:	f8c080e7          	jalr	-116(ra) # 769a <sbrk>
    5716:	fea43423          	sd	a0,-24(s0)
  if(pipe((int *) a) != 0){
    571a:	fe843503          	ld	a0,-24(s0)
    571e:	00002097          	auipc	ra,0x2
    5722:	f04080e7          	jalr	-252(ra) # 7622 <pipe>
    5726:	87aa                	mv	a5,a0
    5728:	c385                	beqz	a5,5748 <sbrkarg+0xf8>
    printf("%s: pipe() failed\n", s);
    572a:	fd843583          	ld	a1,-40(s0)
    572e:	00003517          	auipc	a0,0x3
    5732:	04a50513          	addi	a0,a0,74 # 8778 <malloc+0xa14>
    5736:	00002097          	auipc	ra,0x2
    573a:	43c080e7          	jalr	1084(ra) # 7b72 <printf>
    exit(1);
    573e:	4505                	li	a0,1
    5740:	00002097          	auipc	ra,0x2
    5744:	ed2080e7          	jalr	-302(ra) # 7612 <exit>
  }
}
    5748:	0001                	nop
    574a:	70a2                	ld	ra,40(sp)
    574c:	7402                	ld	s0,32(sp)
    574e:	6145                	addi	sp,sp,48
    5750:	8082                	ret

0000000000005752 <validatetest>:

void
validatetest(char *s)
{
    5752:	7179                	addi	sp,sp,-48
    5754:	f406                	sd	ra,40(sp)
    5756:	f022                	sd	s0,32(sp)
    5758:	1800                	addi	s0,sp,48
    575a:	fca43c23          	sd	a0,-40(s0)
  int hi;
  uint64 p;

  hi = 1100*1024;
    575e:	001137b7          	lui	a5,0x113
    5762:	fef42223          	sw	a5,-28(s0)
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    5766:	fe043423          	sd	zero,-24(s0)
    576a:	a0b1                	j	57b6 <validatetest+0x64>
    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    576c:	fe843783          	ld	a5,-24(s0)
    5770:	85be                	mv	a1,a5
    5772:	00004517          	auipc	a0,0x4
    5776:	2de50513          	addi	a0,a0,734 # 9a50 <malloc+0x1cec>
    577a:	00002097          	auipc	ra,0x2
    577e:	ef8080e7          	jalr	-264(ra) # 7672 <link>
    5782:	87aa                	mv	a5,a0
    5784:	873e                	mv	a4,a5
    5786:	57fd                	li	a5,-1
    5788:	02f70163          	beq	a4,a5,57aa <validatetest+0x58>
      printf("%s: link should not succeed\n", s);
    578c:	fd843583          	ld	a1,-40(s0)
    5790:	00004517          	auipc	a0,0x4
    5794:	2d050513          	addi	a0,a0,720 # 9a60 <malloc+0x1cfc>
    5798:	00002097          	auipc	ra,0x2
    579c:	3da080e7          	jalr	986(ra) # 7b72 <printf>
      exit(1);
    57a0:	4505                	li	a0,1
    57a2:	00002097          	auipc	ra,0x2
    57a6:	e70080e7          	jalr	-400(ra) # 7612 <exit>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    57aa:	fe843703          	ld	a4,-24(s0)
    57ae:	6785                	lui	a5,0x1
    57b0:	97ba                	add	a5,a5,a4
    57b2:	fef43423          	sd	a5,-24(s0)
    57b6:	fe442783          	lw	a5,-28(s0)
    57ba:	1782                	slli	a5,a5,0x20
    57bc:	9381                	srli	a5,a5,0x20
    57be:	fe843703          	ld	a4,-24(s0)
    57c2:	fae7f5e3          	bgeu	a5,a4,576c <validatetest+0x1a>
    }
  }
}
    57c6:	0001                	nop
    57c8:	0001                	nop
    57ca:	70a2                	ld	ra,40(sp)
    57cc:	7402                	ld	s0,32(sp)
    57ce:	6145                	addi	sp,sp,48
    57d0:	8082                	ret

00000000000057d2 <bsstest>:

// does uninitialized data start out zero?
char uninit[10000];
void
bsstest(char *s)
{
    57d2:	7179                	addi	sp,sp,-48
    57d4:	f406                	sd	ra,40(sp)
    57d6:	f022                	sd	s0,32(sp)
    57d8:	1800                	addi	s0,sp,48
    57da:	fca43c23          	sd	a0,-40(s0)
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    57de:	fe042623          	sw	zero,-20(s0)
    57e2:	a83d                	j	5820 <bsstest+0x4e>
    if(uninit[i] != '\0'){
    57e4:	0000a717          	auipc	a4,0xa
    57e8:	afc70713          	addi	a4,a4,-1284 # f2e0 <uninit>
    57ec:	fec42783          	lw	a5,-20(s0)
    57f0:	97ba                	add	a5,a5,a4
    57f2:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1b2>
    57f6:	c385                	beqz	a5,5816 <bsstest+0x44>
      printf("%s: bss test failed\n", s);
    57f8:	fd843583          	ld	a1,-40(s0)
    57fc:	00004517          	auipc	a0,0x4
    5800:	28450513          	addi	a0,a0,644 # 9a80 <malloc+0x1d1c>
    5804:	00002097          	auipc	ra,0x2
    5808:	36e080e7          	jalr	878(ra) # 7b72 <printf>
      exit(1);
    580c:	4505                	li	a0,1
    580e:	00002097          	auipc	ra,0x2
    5812:	e04080e7          	jalr	-508(ra) # 7612 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    5816:	fec42783          	lw	a5,-20(s0)
    581a:	2785                	addiw	a5,a5,1
    581c:	fef42623          	sw	a5,-20(s0)
    5820:	fec42783          	lw	a5,-20(s0)
    5824:	873e                	mv	a4,a5
    5826:	6789                	lui	a5,0x2
    5828:	70f78793          	addi	a5,a5,1807 # 270f <reparent2+0x79>
    582c:	fae7fce3          	bgeu	a5,a4,57e4 <bsstest+0x12>
    }
  }
}
    5830:	0001                	nop
    5832:	0001                	nop
    5834:	70a2                	ld	ra,40(sp)
    5836:	7402                	ld	s0,32(sp)
    5838:	6145                	addi	sp,sp,48
    583a:	8082                	ret

000000000000583c <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(char *s)
{
    583c:	7179                	addi	sp,sp,-48
    583e:	f406                	sd	ra,40(sp)
    5840:	f022                	sd	s0,32(sp)
    5842:	1800                	addi	s0,sp,48
    5844:	fca43c23          	sd	a0,-40(s0)
  int pid, fd, xstatus;

  unlink("bigarg-ok");
    5848:	00004517          	auipc	a0,0x4
    584c:	25050513          	addi	a0,a0,592 # 9a98 <malloc+0x1d34>
    5850:	00002097          	auipc	ra,0x2
    5854:	e12080e7          	jalr	-494(ra) # 7662 <unlink>
  pid = fork();
    5858:	00002097          	auipc	ra,0x2
    585c:	db2080e7          	jalr	-590(ra) # 760a <fork>
    5860:	87aa                	mv	a5,a0
    5862:	fef42423          	sw	a5,-24(s0)
  if(pid == 0){
    5866:	fe842783          	lw	a5,-24(s0)
    586a:	2781                	sext.w	a5,a5
    586c:	ebc1                	bnez	a5,58fc <bigargtest+0xc0>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    586e:	fe042623          	sw	zero,-20(s0)
    5872:	a01d                	j	5898 <bigargtest+0x5c>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    5874:	0000d717          	auipc	a4,0xd
    5878:	18470713          	addi	a4,a4,388 # 129f8 <args.1>
    587c:	fec42783          	lw	a5,-20(s0)
    5880:	078e                	slli	a5,a5,0x3
    5882:	97ba                	add	a5,a5,a4
    5884:	00004717          	auipc	a4,0x4
    5888:	22470713          	addi	a4,a4,548 # 9aa8 <malloc+0x1d44>
    588c:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    588e:	fec42783          	lw	a5,-20(s0)
    5892:	2785                	addiw	a5,a5,1
    5894:	fef42623          	sw	a5,-20(s0)
    5898:	fec42783          	lw	a5,-20(s0)
    589c:	0007871b          	sext.w	a4,a5
    58a0:	47f9                	li	a5,30
    58a2:	fce7d9e3          	bge	a5,a4,5874 <bigargtest+0x38>
    args[MAXARG-1] = 0;
    58a6:	0000d797          	auipc	a5,0xd
    58aa:	15278793          	addi	a5,a5,338 # 129f8 <args.1>
    58ae:	0e07bc23          	sd	zero,248(a5)
    exec("echo", args);
    58b2:	0000d597          	auipc	a1,0xd
    58b6:	14658593          	addi	a1,a1,326 # 129f8 <args.1>
    58ba:	00003517          	auipc	a0,0x3
    58be:	80650513          	addi	a0,a0,-2042 # 80c0 <malloc+0x35c>
    58c2:	00002097          	auipc	ra,0x2
    58c6:	d88080e7          	jalr	-632(ra) # 764a <exec>
    fd = open("bigarg-ok", O_CREATE);
    58ca:	20000593          	li	a1,512
    58ce:	00004517          	auipc	a0,0x4
    58d2:	1ca50513          	addi	a0,a0,458 # 9a98 <malloc+0x1d34>
    58d6:	00002097          	auipc	ra,0x2
    58da:	d7c080e7          	jalr	-644(ra) # 7652 <open>
    58de:	87aa                	mv	a5,a0
    58e0:	fef42223          	sw	a5,-28(s0)
    close(fd);
    58e4:	fe442783          	lw	a5,-28(s0)
    58e8:	853e                	mv	a0,a5
    58ea:	00002097          	auipc	ra,0x2
    58ee:	d50080e7          	jalr	-688(ra) # 763a <close>
    exit(0);
    58f2:	4501                	li	a0,0
    58f4:	00002097          	auipc	ra,0x2
    58f8:	d1e080e7          	jalr	-738(ra) # 7612 <exit>
  } else if(pid < 0){
    58fc:	fe842783          	lw	a5,-24(s0)
    5900:	2781                	sext.w	a5,a5
    5902:	0207d163          	bgez	a5,5924 <bigargtest+0xe8>
    printf("%s: bigargtest: fork failed\n", s);
    5906:	fd843583          	ld	a1,-40(s0)
    590a:	00004517          	auipc	a0,0x4
    590e:	27e50513          	addi	a0,a0,638 # 9b88 <malloc+0x1e24>
    5912:	00002097          	auipc	ra,0x2
    5916:	260080e7          	jalr	608(ra) # 7b72 <printf>
    exit(1);
    591a:	4505                	li	a0,1
    591c:	00002097          	auipc	ra,0x2
    5920:	cf6080e7          	jalr	-778(ra) # 7612 <exit>
  }

  wait(&xstatus);
    5924:	fe040793          	addi	a5,s0,-32
    5928:	853e                	mv	a0,a5
    592a:	00002097          	auipc	ra,0x2
    592e:	cf0080e7          	jalr	-784(ra) # 761a <wait>
  if(xstatus != 0)
    5932:	fe042783          	lw	a5,-32(s0)
    5936:	cb81                	beqz	a5,5946 <bigargtest+0x10a>
    exit(xstatus);
    5938:	fe042783          	lw	a5,-32(s0)
    593c:	853e                	mv	a0,a5
    593e:	00002097          	auipc	ra,0x2
    5942:	cd4080e7          	jalr	-812(ra) # 7612 <exit>
  fd = open("bigarg-ok", 0);
    5946:	4581                	li	a1,0
    5948:	00004517          	auipc	a0,0x4
    594c:	15050513          	addi	a0,a0,336 # 9a98 <malloc+0x1d34>
    5950:	00002097          	auipc	ra,0x2
    5954:	d02080e7          	jalr	-766(ra) # 7652 <open>
    5958:	87aa                	mv	a5,a0
    595a:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    595e:	fe442783          	lw	a5,-28(s0)
    5962:	2781                	sext.w	a5,a5
    5964:	0207d163          	bgez	a5,5986 <bigargtest+0x14a>
    printf("%s: bigarg test failed!\n", s);
    5968:	fd843583          	ld	a1,-40(s0)
    596c:	00004517          	auipc	a0,0x4
    5970:	23c50513          	addi	a0,a0,572 # 9ba8 <malloc+0x1e44>
    5974:	00002097          	auipc	ra,0x2
    5978:	1fe080e7          	jalr	510(ra) # 7b72 <printf>
    exit(1);
    597c:	4505                	li	a0,1
    597e:	00002097          	auipc	ra,0x2
    5982:	c94080e7          	jalr	-876(ra) # 7612 <exit>
  }
  close(fd);
    5986:	fe442783          	lw	a5,-28(s0)
    598a:	853e                	mv	a0,a5
    598c:	00002097          	auipc	ra,0x2
    5990:	cae080e7          	jalr	-850(ra) # 763a <close>
}
    5994:	0001                	nop
    5996:	70a2                	ld	ra,40(sp)
    5998:	7402                	ld	s0,32(sp)
    599a:	6145                	addi	sp,sp,48
    599c:	8082                	ret

000000000000599e <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    599e:	7159                	addi	sp,sp,-112
    59a0:	f486                	sd	ra,104(sp)
    59a2:	f0a2                	sd	s0,96(sp)
    59a4:	1880                	addi	s0,sp,112
  int nfiles;
  int fsblocks = 0;
    59a6:	fe042423          	sw	zero,-24(s0)

  printf("fsfull test\n");
    59aa:	00004517          	auipc	a0,0x4
    59ae:	21e50513          	addi	a0,a0,542 # 9bc8 <malloc+0x1e64>
    59b2:	00002097          	auipc	ra,0x2
    59b6:	1c0080e7          	jalr	448(ra) # 7b72 <printf>

  for(nfiles = 0; ; nfiles++){
    59ba:	fe042623          	sw	zero,-20(s0)
    char name[64];
    name[0] = 'f';
    59be:	06600793          	li	a5,102
    59c2:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    59c6:	fec42783          	lw	a5,-20(s0)
    59ca:	873e                	mv	a4,a5
    59cc:	3e800793          	li	a5,1000
    59d0:	02f747bb          	divw	a5,a4,a5
    59d4:	2781                	sext.w	a5,a5
    59d6:	0ff7f793          	zext.b	a5,a5
    59da:	0307879b          	addiw	a5,a5,48
    59de:	0ff7f793          	zext.b	a5,a5
    59e2:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    59e6:	fec42783          	lw	a5,-20(s0)
    59ea:	873e                	mv	a4,a5
    59ec:	3e800793          	li	a5,1000
    59f0:	02f767bb          	remw	a5,a4,a5
    59f4:	2781                	sext.w	a5,a5
    59f6:	873e                	mv	a4,a5
    59f8:	06400793          	li	a5,100
    59fc:	02f747bb          	divw	a5,a4,a5
    5a00:	2781                	sext.w	a5,a5
    5a02:	0ff7f793          	zext.b	a5,a5
    5a06:	0307879b          	addiw	a5,a5,48
    5a0a:	0ff7f793          	zext.b	a5,a5
    5a0e:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5a12:	fec42783          	lw	a5,-20(s0)
    5a16:	873e                	mv	a4,a5
    5a18:	06400793          	li	a5,100
    5a1c:	02f767bb          	remw	a5,a4,a5
    5a20:	2781                	sext.w	a5,a5
    5a22:	873e                	mv	a4,a5
    5a24:	47a9                	li	a5,10
    5a26:	02f747bb          	divw	a5,a4,a5
    5a2a:	2781                	sext.w	a5,a5
    5a2c:	0ff7f793          	zext.b	a5,a5
    5a30:	0307879b          	addiw	a5,a5,48
    5a34:	0ff7f793          	zext.b	a5,a5
    5a38:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    5a3c:	fec42783          	lw	a5,-20(s0)
    5a40:	873e                	mv	a4,a5
    5a42:	47a9                	li	a5,10
    5a44:	02f767bb          	remw	a5,a4,a5
    5a48:	2781                	sext.w	a5,a5
    5a4a:	0ff7f793          	zext.b	a5,a5
    5a4e:	0307879b          	addiw	a5,a5,48
    5a52:	0ff7f793          	zext.b	a5,a5
    5a56:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    5a5a:	f8040ea3          	sb	zero,-99(s0)
    printf("writing %s\n", name);
    5a5e:	f9840793          	addi	a5,s0,-104
    5a62:	85be                	mv	a1,a5
    5a64:	00004517          	auipc	a0,0x4
    5a68:	17450513          	addi	a0,a0,372 # 9bd8 <malloc+0x1e74>
    5a6c:	00002097          	auipc	ra,0x2
    5a70:	106080e7          	jalr	262(ra) # 7b72 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5a74:	f9840793          	addi	a5,s0,-104
    5a78:	20200593          	li	a1,514
    5a7c:	853e                	mv	a0,a5
    5a7e:	00002097          	auipc	ra,0x2
    5a82:	bd4080e7          	jalr	-1068(ra) # 7652 <open>
    5a86:	87aa                	mv	a5,a0
    5a88:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    5a8c:	fe042783          	lw	a5,-32(s0)
    5a90:	2781                	sext.w	a5,a5
    5a92:	0007de63          	bgez	a5,5aae <fsfull+0x110>
      printf("open %s failed\n", name);
    5a96:	f9840793          	addi	a5,s0,-104
    5a9a:	85be                	mv	a1,a5
    5a9c:	00004517          	auipc	a0,0x4
    5aa0:	14c50513          	addi	a0,a0,332 # 9be8 <malloc+0x1e84>
    5aa4:	00002097          	auipc	ra,0x2
    5aa8:	0ce080e7          	jalr	206(ra) # 7b72 <printf>
      break;
    5aac:	a079                	j	5b3a <fsfull+0x19c>
    }
    int total = 0;
    5aae:	fe042223          	sw	zero,-28(s0)
    while(1){
      int cc = write(fd, buf, BSIZE);
    5ab2:	fe042783          	lw	a5,-32(s0)
    5ab6:	40000613          	li	a2,1024
    5aba:	00007597          	auipc	a1,0x7
    5abe:	82658593          	addi	a1,a1,-2010 # c2e0 <buf>
    5ac2:	853e                	mv	a0,a5
    5ac4:	00002097          	auipc	ra,0x2
    5ac8:	b6e080e7          	jalr	-1170(ra) # 7632 <write>
    5acc:	87aa                	mv	a5,a0
    5ace:	fcf42e23          	sw	a5,-36(s0)
      if(cc < BSIZE)
    5ad2:	fdc42783          	lw	a5,-36(s0)
    5ad6:	0007871b          	sext.w	a4,a5
    5ada:	3ff00793          	li	a5,1023
    5ade:	02e7d063          	bge	a5,a4,5afe <fsfull+0x160>
        break;
      total += cc;
    5ae2:	fe442783          	lw	a5,-28(s0)
    5ae6:	873e                	mv	a4,a5
    5ae8:	fdc42783          	lw	a5,-36(s0)
    5aec:	9fb9                	addw	a5,a5,a4
    5aee:	fef42223          	sw	a5,-28(s0)
      fsblocks++;
    5af2:	fe842783          	lw	a5,-24(s0)
    5af6:	2785                	addiw	a5,a5,1
    5af8:	fef42423          	sw	a5,-24(s0)
    while(1){
    5afc:	bf5d                	j	5ab2 <fsfull+0x114>
        break;
    5afe:	0001                	nop
    }
    printf("wrote %d bytes\n", total);
    5b00:	fe442783          	lw	a5,-28(s0)
    5b04:	85be                	mv	a1,a5
    5b06:	00004517          	auipc	a0,0x4
    5b0a:	0f250513          	addi	a0,a0,242 # 9bf8 <malloc+0x1e94>
    5b0e:	00002097          	auipc	ra,0x2
    5b12:	064080e7          	jalr	100(ra) # 7b72 <printf>
    close(fd);
    5b16:	fe042783          	lw	a5,-32(s0)
    5b1a:	853e                	mv	a0,a5
    5b1c:	00002097          	auipc	ra,0x2
    5b20:	b1e080e7          	jalr	-1250(ra) # 763a <close>
    if(total == 0)
    5b24:	fe442783          	lw	a5,-28(s0)
    5b28:	2781                	sext.w	a5,a5
    5b2a:	c799                	beqz	a5,5b38 <fsfull+0x19a>
  for(nfiles = 0; ; nfiles++){
    5b2c:	fec42783          	lw	a5,-20(s0)
    5b30:	2785                	addiw	a5,a5,1
    5b32:	fef42623          	sw	a5,-20(s0)
    5b36:	b561                	j	59be <fsfull+0x20>
      break;
    5b38:	0001                	nop
  }

  while(nfiles >= 0){
    5b3a:	a86d                	j	5bf4 <fsfull+0x256>
    char name[64];
    name[0] = 'f';
    5b3c:	06600793          	li	a5,102
    5b40:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    5b44:	fec42783          	lw	a5,-20(s0)
    5b48:	873e                	mv	a4,a5
    5b4a:	3e800793          	li	a5,1000
    5b4e:	02f747bb          	divw	a5,a4,a5
    5b52:	2781                	sext.w	a5,a5
    5b54:	0ff7f793          	zext.b	a5,a5
    5b58:	0307879b          	addiw	a5,a5,48
    5b5c:	0ff7f793          	zext.b	a5,a5
    5b60:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5b64:	fec42783          	lw	a5,-20(s0)
    5b68:	873e                	mv	a4,a5
    5b6a:	3e800793          	li	a5,1000
    5b6e:	02f767bb          	remw	a5,a4,a5
    5b72:	2781                	sext.w	a5,a5
    5b74:	873e                	mv	a4,a5
    5b76:	06400793          	li	a5,100
    5b7a:	02f747bb          	divw	a5,a4,a5
    5b7e:	2781                	sext.w	a5,a5
    5b80:	0ff7f793          	zext.b	a5,a5
    5b84:	0307879b          	addiw	a5,a5,48
    5b88:	0ff7f793          	zext.b	a5,a5
    5b8c:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5b90:	fec42783          	lw	a5,-20(s0)
    5b94:	873e                	mv	a4,a5
    5b96:	06400793          	li	a5,100
    5b9a:	02f767bb          	remw	a5,a4,a5
    5b9e:	2781                	sext.w	a5,a5
    5ba0:	873e                	mv	a4,a5
    5ba2:	47a9                	li	a5,10
    5ba4:	02f747bb          	divw	a5,a4,a5
    5ba8:	2781                	sext.w	a5,a5
    5baa:	0ff7f793          	zext.b	a5,a5
    5bae:	0307879b          	addiw	a5,a5,48
    5bb2:	0ff7f793          	zext.b	a5,a5
    5bb6:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    5bba:	fec42783          	lw	a5,-20(s0)
    5bbe:	873e                	mv	a4,a5
    5bc0:	47a9                	li	a5,10
    5bc2:	02f767bb          	remw	a5,a4,a5
    5bc6:	2781                	sext.w	a5,a5
    5bc8:	0ff7f793          	zext.b	a5,a5
    5bcc:	0307879b          	addiw	a5,a5,48
    5bd0:	0ff7f793          	zext.b	a5,a5
    5bd4:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    5bd8:	f8040ea3          	sb	zero,-99(s0)
    unlink(name);
    5bdc:	f9840793          	addi	a5,s0,-104
    5be0:	853e                	mv	a0,a5
    5be2:	00002097          	auipc	ra,0x2
    5be6:	a80080e7          	jalr	-1408(ra) # 7662 <unlink>
    nfiles--;
    5bea:	fec42783          	lw	a5,-20(s0)
    5bee:	37fd                	addiw	a5,a5,-1
    5bf0:	fef42623          	sw	a5,-20(s0)
  while(nfiles >= 0){
    5bf4:	fec42783          	lw	a5,-20(s0)
    5bf8:	2781                	sext.w	a5,a5
    5bfa:	f407d1e3          	bgez	a5,5b3c <fsfull+0x19e>
  }

  printf("fsfull test finished\n");
    5bfe:	00004517          	auipc	a0,0x4
    5c02:	00a50513          	addi	a0,a0,10 # 9c08 <malloc+0x1ea4>
    5c06:	00002097          	auipc	ra,0x2
    5c0a:	f6c080e7          	jalr	-148(ra) # 7b72 <printf>
}
    5c0e:	0001                	nop
    5c10:	70a6                	ld	ra,104(sp)
    5c12:	7406                	ld	s0,96(sp)
    5c14:	6165                	addi	sp,sp,112
    5c16:	8082                	ret

0000000000005c18 <argptest>:

void argptest(char *s)
{
    5c18:	7179                	addi	sp,sp,-48
    5c1a:	f406                	sd	ra,40(sp)
    5c1c:	f022                	sd	s0,32(sp)
    5c1e:	1800                	addi	s0,sp,48
    5c20:	fca43c23          	sd	a0,-40(s0)
  int fd;
  fd = open("init", O_RDONLY);
    5c24:	4581                	li	a1,0
    5c26:	00004517          	auipc	a0,0x4
    5c2a:	ffa50513          	addi	a0,a0,-6 # 9c20 <malloc+0x1ebc>
    5c2e:	00002097          	auipc	ra,0x2
    5c32:	a24080e7          	jalr	-1500(ra) # 7652 <open>
    5c36:	87aa                	mv	a5,a0
    5c38:	fef42623          	sw	a5,-20(s0)
  if (fd < 0) {
    5c3c:	fec42783          	lw	a5,-20(s0)
    5c40:	2781                	sext.w	a5,a5
    5c42:	0207d163          	bgez	a5,5c64 <argptest+0x4c>
    printf("%s: open failed\n", s);
    5c46:	fd843583          	ld	a1,-40(s0)
    5c4a:	00002517          	auipc	a0,0x2
    5c4e:	6ae50513          	addi	a0,a0,1710 # 82f8 <malloc+0x594>
    5c52:	00002097          	auipc	ra,0x2
    5c56:	f20080e7          	jalr	-224(ra) # 7b72 <printf>
    exit(1);
    5c5a:	4505                	li	a0,1
    5c5c:	00002097          	auipc	ra,0x2
    5c60:	9b6080e7          	jalr	-1610(ra) # 7612 <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    5c64:	4501                	li	a0,0
    5c66:	00002097          	auipc	ra,0x2
    5c6a:	a34080e7          	jalr	-1484(ra) # 769a <sbrk>
    5c6e:	87aa                	mv	a5,a0
    5c70:	fff78713          	addi	a4,a5,-1
    5c74:	fec42783          	lw	a5,-20(s0)
    5c78:	567d                	li	a2,-1
    5c7a:	85ba                	mv	a1,a4
    5c7c:	853e                	mv	a0,a5
    5c7e:	00002097          	auipc	ra,0x2
    5c82:	9ac080e7          	jalr	-1620(ra) # 762a <read>
  close(fd);
    5c86:	fec42783          	lw	a5,-20(s0)
    5c8a:	853e                	mv	a0,a5
    5c8c:	00002097          	auipc	ra,0x2
    5c90:	9ae080e7          	jalr	-1618(ra) # 763a <close>
}
    5c94:	0001                	nop
    5c96:	70a2                	ld	ra,40(sp)
    5c98:	7402                	ld	s0,32(sp)
    5c9a:	6145                	addi	sp,sp,48
    5c9c:	8082                	ret

0000000000005c9e <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
    5c9e:	7139                	addi	sp,sp,-64
    5ca0:	fc06                	sd	ra,56(sp)
    5ca2:	f822                	sd	s0,48(sp)
    5ca4:	0080                	addi	s0,sp,64
    5ca6:	fca43423          	sd	a0,-56(s0)
  int pid;
  int xstatus;

  pid = fork();
    5caa:	00002097          	auipc	ra,0x2
    5cae:	960080e7          	jalr	-1696(ra) # 760a <fork>
    5cb2:	87aa                	mv	a5,a0
    5cb4:	fef42623          	sw	a5,-20(s0)
  if(pid == 0) {
    5cb8:	fec42783          	lw	a5,-20(s0)
    5cbc:	2781                	sext.w	a5,a5
    5cbe:	e3b9                	bnez	a5,5d04 <stacktest+0x66>
    char *sp = (char *) r_sp();
    5cc0:	ffffa097          	auipc	ra,0xffffa
    5cc4:	340080e7          	jalr	832(ra) # 0 <r_sp>
    5cc8:	87aa                	mv	a5,a0
    5cca:	fef43023          	sd	a5,-32(s0)
    sp -= PGSIZE;
    5cce:	fe043703          	ld	a4,-32(s0)
    5cd2:	77fd                	lui	a5,0xfffff
    5cd4:	97ba                	add	a5,a5,a4
    5cd6:	fef43023          	sd	a5,-32(s0)
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    5cda:	fe043783          	ld	a5,-32(s0)
    5cde:	0007c783          	lbu	a5,0(a5) # fffffffffffff000 <freep+0xfffffffffffec4f8>
    5ce2:	2781                	sext.w	a5,a5
    5ce4:	863e                	mv	a2,a5
    5ce6:	fc843583          	ld	a1,-56(s0)
    5cea:	00004517          	auipc	a0,0x4
    5cee:	f3e50513          	addi	a0,a0,-194 # 9c28 <malloc+0x1ec4>
    5cf2:	00002097          	auipc	ra,0x2
    5cf6:	e80080e7          	jalr	-384(ra) # 7b72 <printf>
    exit(1);
    5cfa:	4505                	li	a0,1
    5cfc:	00002097          	auipc	ra,0x2
    5d00:	916080e7          	jalr	-1770(ra) # 7612 <exit>
  } else if(pid < 0){
    5d04:	fec42783          	lw	a5,-20(s0)
    5d08:	2781                	sext.w	a5,a5
    5d0a:	0207d163          	bgez	a5,5d2c <stacktest+0x8e>
    printf("%s: fork failed\n", s);
    5d0e:	fc843583          	ld	a1,-56(s0)
    5d12:	00002517          	auipc	a0,0x2
    5d16:	5ce50513          	addi	a0,a0,1486 # 82e0 <malloc+0x57c>
    5d1a:	00002097          	auipc	ra,0x2
    5d1e:	e58080e7          	jalr	-424(ra) # 7b72 <printf>
    exit(1);
    5d22:	4505                	li	a0,1
    5d24:	00002097          	auipc	ra,0x2
    5d28:	8ee080e7          	jalr	-1810(ra) # 7612 <exit>
  }
  wait(&xstatus);
    5d2c:	fdc40793          	addi	a5,s0,-36
    5d30:	853e                	mv	a0,a5
    5d32:	00002097          	auipc	ra,0x2
    5d36:	8e8080e7          	jalr	-1816(ra) # 761a <wait>
  if(xstatus == -1)  // kernel killed child?
    5d3a:	fdc42783          	lw	a5,-36(s0)
    5d3e:	873e                	mv	a4,a5
    5d40:	57fd                	li	a5,-1
    5d42:	00f71763          	bne	a4,a5,5d50 <stacktest+0xb2>
    exit(0);
    5d46:	4501                	li	a0,0
    5d48:	00002097          	auipc	ra,0x2
    5d4c:	8ca080e7          	jalr	-1846(ra) # 7612 <exit>
  else
    exit(xstatus);
    5d50:	fdc42783          	lw	a5,-36(s0)
    5d54:	853e                	mv	a0,a5
    5d56:	00002097          	auipc	ra,0x2
    5d5a:	8bc080e7          	jalr	-1860(ra) # 7612 <exit>

0000000000005d5e <textwrite>:
}

// check that writes to text segment fault
void
textwrite(char *s)
{
    5d5e:	7139                	addi	sp,sp,-64
    5d60:	fc06                	sd	ra,56(sp)
    5d62:	f822                	sd	s0,48(sp)
    5d64:	0080                	addi	s0,sp,64
    5d66:	fca43423          	sd	a0,-56(s0)
  int pid;
  int xstatus;

  pid = fork();
    5d6a:	00002097          	auipc	ra,0x2
    5d6e:	8a0080e7          	jalr	-1888(ra) # 760a <fork>
    5d72:	87aa                	mv	a5,a0
    5d74:	fef42623          	sw	a5,-20(s0)
  if(pid == 0) {
    5d78:	fec42783          	lw	a5,-20(s0)
    5d7c:	2781                	sext.w	a5,a5
    5d7e:	ef81                	bnez	a5,5d96 <textwrite+0x38>
    volatile int *addr = (int *) 0;
    5d80:	fe043023          	sd	zero,-32(s0)
    *addr = 10;
    5d84:	fe043783          	ld	a5,-32(s0)
    5d88:	4729                	li	a4,10
    5d8a:	c398                	sw	a4,0(a5)
    exit(1);
    5d8c:	4505                	li	a0,1
    5d8e:	00002097          	auipc	ra,0x2
    5d92:	884080e7          	jalr	-1916(ra) # 7612 <exit>
  } else if(pid < 0){
    5d96:	fec42783          	lw	a5,-20(s0)
    5d9a:	2781                	sext.w	a5,a5
    5d9c:	0207d163          	bgez	a5,5dbe <textwrite+0x60>
    printf("%s: fork failed\n", s);
    5da0:	fc843583          	ld	a1,-56(s0)
    5da4:	00002517          	auipc	a0,0x2
    5da8:	53c50513          	addi	a0,a0,1340 # 82e0 <malloc+0x57c>
    5dac:	00002097          	auipc	ra,0x2
    5db0:	dc6080e7          	jalr	-570(ra) # 7b72 <printf>
    exit(1);
    5db4:	4505                	li	a0,1
    5db6:	00002097          	auipc	ra,0x2
    5dba:	85c080e7          	jalr	-1956(ra) # 7612 <exit>
  }
  wait(&xstatus);
    5dbe:	fdc40793          	addi	a5,s0,-36
    5dc2:	853e                	mv	a0,a5
    5dc4:	00002097          	auipc	ra,0x2
    5dc8:	856080e7          	jalr	-1962(ra) # 761a <wait>
  if(xstatus == -1)  // kernel killed child?
    5dcc:	fdc42783          	lw	a5,-36(s0)
    5dd0:	873e                	mv	a4,a5
    5dd2:	57fd                	li	a5,-1
    5dd4:	00f71763          	bne	a4,a5,5de2 <textwrite+0x84>
    exit(0);
    5dd8:	4501                	li	a0,0
    5dda:	00002097          	auipc	ra,0x2
    5dde:	838080e7          	jalr	-1992(ra) # 7612 <exit>
  else
    exit(xstatus);
    5de2:	fdc42783          	lw	a5,-36(s0)
    5de6:	853e                	mv	a0,a5
    5de8:	00002097          	auipc	ra,0x2
    5dec:	82a080e7          	jalr	-2006(ra) # 7612 <exit>

0000000000005df0 <pgbug>:
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void *big = (void*) 0xeaeb0b5b00002f5e;
void
pgbug(char *s)
{
    5df0:	7179                	addi	sp,sp,-48
    5df2:	f406                	sd	ra,40(sp)
    5df4:	f022                	sd	s0,32(sp)
    5df6:	1800                	addi	s0,sp,48
    5df8:	fca43c23          	sd	a0,-40(s0)
  char *argv[1];
  argv[0] = 0;
    5dfc:	fe043423          	sd	zero,-24(s0)
  exec(big, argv);
    5e00:	00006797          	auipc	a5,0x6
    5e04:	09078793          	addi	a5,a5,144 # be90 <big>
    5e08:	639c                	ld	a5,0(a5)
    5e0a:	fe840713          	addi	a4,s0,-24
    5e0e:	85ba                	mv	a1,a4
    5e10:	853e                	mv	a0,a5
    5e12:	00002097          	auipc	ra,0x2
    5e16:	838080e7          	jalr	-1992(ra) # 764a <exec>
  pipe(big);
    5e1a:	00006797          	auipc	a5,0x6
    5e1e:	07678793          	addi	a5,a5,118 # be90 <big>
    5e22:	639c                	ld	a5,0(a5)
    5e24:	853e                	mv	a0,a5
    5e26:	00001097          	auipc	ra,0x1
    5e2a:	7fc080e7          	jalr	2044(ra) # 7622 <pipe>

  exit(0);
    5e2e:	4501                	li	a0,0
    5e30:	00001097          	auipc	ra,0x1
    5e34:	7e2080e7          	jalr	2018(ra) # 7612 <exit>

0000000000005e38 <sbrkbugs>:
// regression test. does the kernel panic if a process sbrk()s its
// size to be less than a page, or zero, or reduces the break by an
// amount too small to cause a page to be freed?
void
sbrkbugs(char *s)
{
    5e38:	7179                	addi	sp,sp,-48
    5e3a:	f406                	sd	ra,40(sp)
    5e3c:	f022                	sd	s0,32(sp)
    5e3e:	1800                	addi	s0,sp,48
    5e40:	fca43c23          	sd	a0,-40(s0)
  int pid = fork();
    5e44:	00001097          	auipc	ra,0x1
    5e48:	7c6080e7          	jalr	1990(ra) # 760a <fork>
    5e4c:	87aa                	mv	a5,a0
    5e4e:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    5e52:	fec42783          	lw	a5,-20(s0)
    5e56:	2781                	sext.w	a5,a5
    5e58:	0007df63          	bgez	a5,5e76 <sbrkbugs+0x3e>
    printf("fork failed\n");
    5e5c:	00002517          	auipc	a0,0x2
    5e60:	25450513          	addi	a0,a0,596 # 80b0 <malloc+0x34c>
    5e64:	00002097          	auipc	ra,0x2
    5e68:	d0e080e7          	jalr	-754(ra) # 7b72 <printf>
    exit(1);
    5e6c:	4505                	li	a0,1
    5e6e:	00001097          	auipc	ra,0x1
    5e72:	7a4080e7          	jalr	1956(ra) # 7612 <exit>
  }
  if(pid == 0){
    5e76:	fec42783          	lw	a5,-20(s0)
    5e7a:	2781                	sext.w	a5,a5
    5e7c:	eb85                	bnez	a5,5eac <sbrkbugs+0x74>
    int sz = (uint64) sbrk(0);
    5e7e:	4501                	li	a0,0
    5e80:	00002097          	auipc	ra,0x2
    5e84:	81a080e7          	jalr	-2022(ra) # 769a <sbrk>
    5e88:	87aa                	mv	a5,a0
    5e8a:	fef42223          	sw	a5,-28(s0)
    // free all user memory; there used to be a bug that
    // would not adjust p->sz correctly in this case,
    // causing exit() to panic.
    sbrk(-sz);
    5e8e:	fe442783          	lw	a5,-28(s0)
    5e92:	40f007bb          	negw	a5,a5
    5e96:	2781                	sext.w	a5,a5
    5e98:	853e                	mv	a0,a5
    5e9a:	00002097          	auipc	ra,0x2
    5e9e:	800080e7          	jalr	-2048(ra) # 769a <sbrk>
    // user page fault here.
    exit(0);
    5ea2:	4501                	li	a0,0
    5ea4:	00001097          	auipc	ra,0x1
    5ea8:	76e080e7          	jalr	1902(ra) # 7612 <exit>
  }
  wait(0);
    5eac:	4501                	li	a0,0
    5eae:	00001097          	auipc	ra,0x1
    5eb2:	76c080e7          	jalr	1900(ra) # 761a <wait>

  pid = fork();
    5eb6:	00001097          	auipc	ra,0x1
    5eba:	754080e7          	jalr	1876(ra) # 760a <fork>
    5ebe:	87aa                	mv	a5,a0
    5ec0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    5ec4:	fec42783          	lw	a5,-20(s0)
    5ec8:	2781                	sext.w	a5,a5
    5eca:	0007df63          	bgez	a5,5ee8 <sbrkbugs+0xb0>
    printf("fork failed\n");
    5ece:	00002517          	auipc	a0,0x2
    5ed2:	1e250513          	addi	a0,a0,482 # 80b0 <malloc+0x34c>
    5ed6:	00002097          	auipc	ra,0x2
    5eda:	c9c080e7          	jalr	-868(ra) # 7b72 <printf>
    exit(1);
    5ede:	4505                	li	a0,1
    5ee0:	00001097          	auipc	ra,0x1
    5ee4:	732080e7          	jalr	1842(ra) # 7612 <exit>
  }
  if(pid == 0){
    5ee8:	fec42783          	lw	a5,-20(s0)
    5eec:	2781                	sext.w	a5,a5
    5eee:	eb95                	bnez	a5,5f22 <sbrkbugs+0xea>
    int sz = (uint64) sbrk(0);
    5ef0:	4501                	li	a0,0
    5ef2:	00001097          	auipc	ra,0x1
    5ef6:	7a8080e7          	jalr	1960(ra) # 769a <sbrk>
    5efa:	87aa                	mv	a5,a0
    5efc:	fef42423          	sw	a5,-24(s0)
    // set the break to somewhere in the very first
    // page; there used to be a bug that would incorrectly
    // free the first page.
    sbrk(-(sz - 3500));
    5f00:	6785                	lui	a5,0x1
    5f02:	dac7879b          	addiw	a5,a5,-596 # dac <truncate2+0x4c>
    5f06:	fe842703          	lw	a4,-24(s0)
    5f0a:	9f99                	subw	a5,a5,a4
    5f0c:	2781                	sext.w	a5,a5
    5f0e:	853e                	mv	a0,a5
    5f10:	00001097          	auipc	ra,0x1
    5f14:	78a080e7          	jalr	1930(ra) # 769a <sbrk>
    exit(0);
    5f18:	4501                	li	a0,0
    5f1a:	00001097          	auipc	ra,0x1
    5f1e:	6f8080e7          	jalr	1784(ra) # 7612 <exit>
  }
  wait(0);
    5f22:	4501                	li	a0,0
    5f24:	00001097          	auipc	ra,0x1
    5f28:	6f6080e7          	jalr	1782(ra) # 761a <wait>

  pid = fork();
    5f2c:	00001097          	auipc	ra,0x1
    5f30:	6de080e7          	jalr	1758(ra) # 760a <fork>
    5f34:	87aa                	mv	a5,a0
    5f36:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    5f3a:	fec42783          	lw	a5,-20(s0)
    5f3e:	2781                	sext.w	a5,a5
    5f40:	0007df63          	bgez	a5,5f5e <sbrkbugs+0x126>
    printf("fork failed\n");
    5f44:	00002517          	auipc	a0,0x2
    5f48:	16c50513          	addi	a0,a0,364 # 80b0 <malloc+0x34c>
    5f4c:	00002097          	auipc	ra,0x2
    5f50:	c26080e7          	jalr	-986(ra) # 7b72 <printf>
    exit(1);
    5f54:	4505                	li	a0,1
    5f56:	00001097          	auipc	ra,0x1
    5f5a:	6bc080e7          	jalr	1724(ra) # 7612 <exit>
  }
  if(pid == 0){
    5f5e:	fec42783          	lw	a5,-20(s0)
    5f62:	2781                	sext.w	a5,a5
    5f64:	ef95                	bnez	a5,5fa0 <sbrkbugs+0x168>
    // set the break in the middle of a page.
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    5f66:	4501                	li	a0,0
    5f68:	00001097          	auipc	ra,0x1
    5f6c:	732080e7          	jalr	1842(ra) # 769a <sbrk>
    5f70:	87aa                	mv	a5,a0
    5f72:	2781                	sext.w	a5,a5
    5f74:	672d                	lui	a4,0xb
    5f76:	8007071b          	addiw	a4,a4,-2048 # a800 <malloc+0x2a9c>
    5f7a:	40f707bb          	subw	a5,a4,a5
    5f7e:	2781                	sext.w	a5,a5
    5f80:	2781                	sext.w	a5,a5
    5f82:	853e                	mv	a0,a5
    5f84:	00001097          	auipc	ra,0x1
    5f88:	716080e7          	jalr	1814(ra) # 769a <sbrk>

    // reduce the break a bit, but not enough to
    // cause a page to be freed. this used to cause
    // a panic.
    sbrk(-10);
    5f8c:	5559                	li	a0,-10
    5f8e:	00001097          	auipc	ra,0x1
    5f92:	70c080e7          	jalr	1804(ra) # 769a <sbrk>

    exit(0);
    5f96:	4501                	li	a0,0
    5f98:	00001097          	auipc	ra,0x1
    5f9c:	67a080e7          	jalr	1658(ra) # 7612 <exit>
  }
  wait(0);
    5fa0:	4501                	li	a0,0
    5fa2:	00001097          	auipc	ra,0x1
    5fa6:	678080e7          	jalr	1656(ra) # 761a <wait>

  exit(0);
    5faa:	4501                	li	a0,0
    5fac:	00001097          	auipc	ra,0x1
    5fb0:	666080e7          	jalr	1638(ra) # 7612 <exit>

0000000000005fb4 <sbrklast>:
// if process size was somewhat more than a page boundary, and then
// shrunk to be somewhat less than that page boundary, can the kernel
// still copyin() from addresses in the last page?
void
sbrklast(char *s)
{
    5fb4:	7139                	addi	sp,sp,-64
    5fb6:	fc06                	sd	ra,56(sp)
    5fb8:	f822                	sd	s0,48(sp)
    5fba:	0080                	addi	s0,sp,64
    5fbc:	fca43423          	sd	a0,-56(s0)
  uint64 top = (uint64) sbrk(0);
    5fc0:	4501                	li	a0,0
    5fc2:	00001097          	auipc	ra,0x1
    5fc6:	6d8080e7          	jalr	1752(ra) # 769a <sbrk>
    5fca:	87aa                	mv	a5,a0
    5fcc:	fef43423          	sd	a5,-24(s0)
  if((top % 4096) != 0)
    5fd0:	fe843703          	ld	a4,-24(s0)
    5fd4:	6785                	lui	a5,0x1
    5fd6:	17fd                	addi	a5,a5,-1 # fff <truncate3+0x1b1>
    5fd8:	8ff9                	and	a5,a5,a4
    5fda:	c39d                	beqz	a5,6000 <sbrklast+0x4c>
    sbrk(4096 - (top % 4096));
    5fdc:	fe843783          	ld	a5,-24(s0)
    5fe0:	2781                	sext.w	a5,a5
    5fe2:	873e                	mv	a4,a5
    5fe4:	6785                	lui	a5,0x1
    5fe6:	17fd                	addi	a5,a5,-1 # fff <truncate3+0x1b1>
    5fe8:	8ff9                	and	a5,a5,a4
    5fea:	2781                	sext.w	a5,a5
    5fec:	6705                	lui	a4,0x1
    5fee:	40f707bb          	subw	a5,a4,a5
    5ff2:	2781                	sext.w	a5,a5
    5ff4:	2781                	sext.w	a5,a5
    5ff6:	853e                	mv	a0,a5
    5ff8:	00001097          	auipc	ra,0x1
    5ffc:	6a2080e7          	jalr	1698(ra) # 769a <sbrk>
  sbrk(4096);
    6000:	6505                	lui	a0,0x1
    6002:	00001097          	auipc	ra,0x1
    6006:	698080e7          	jalr	1688(ra) # 769a <sbrk>
  sbrk(10);
    600a:	4529                	li	a0,10
    600c:	00001097          	auipc	ra,0x1
    6010:	68e080e7          	jalr	1678(ra) # 769a <sbrk>
  sbrk(-20);
    6014:	5531                	li	a0,-20
    6016:	00001097          	auipc	ra,0x1
    601a:	684080e7          	jalr	1668(ra) # 769a <sbrk>
  top = (uint64) sbrk(0);
    601e:	4501                	li	a0,0
    6020:	00001097          	auipc	ra,0x1
    6024:	67a080e7          	jalr	1658(ra) # 769a <sbrk>
    6028:	87aa                	mv	a5,a0
    602a:	fef43423          	sd	a5,-24(s0)
  char *p = (char *) (top - 64);
    602e:	fe843783          	ld	a5,-24(s0)
    6032:	fc078793          	addi	a5,a5,-64
    6036:	fef43023          	sd	a5,-32(s0)
  p[0] = 'x';
    603a:	fe043783          	ld	a5,-32(s0)
    603e:	07800713          	li	a4,120
    6042:	00e78023          	sb	a4,0(a5)
  p[1] = '\0';
    6046:	fe043783          	ld	a5,-32(s0)
    604a:	0785                	addi	a5,a5,1
    604c:	00078023          	sb	zero,0(a5)
  int fd = open(p, O_RDWR|O_CREATE);
    6050:	20200593          	li	a1,514
    6054:	fe043503          	ld	a0,-32(s0)
    6058:	00001097          	auipc	ra,0x1
    605c:	5fa080e7          	jalr	1530(ra) # 7652 <open>
    6060:	87aa                	mv	a5,a0
    6062:	fcf42e23          	sw	a5,-36(s0)
  write(fd, p, 1);
    6066:	fdc42783          	lw	a5,-36(s0)
    606a:	4605                	li	a2,1
    606c:	fe043583          	ld	a1,-32(s0)
    6070:	853e                	mv	a0,a5
    6072:	00001097          	auipc	ra,0x1
    6076:	5c0080e7          	jalr	1472(ra) # 7632 <write>
  close(fd);
    607a:	fdc42783          	lw	a5,-36(s0)
    607e:	853e                	mv	a0,a5
    6080:	00001097          	auipc	ra,0x1
    6084:	5ba080e7          	jalr	1466(ra) # 763a <close>
  fd = open(p, O_RDWR);
    6088:	4589                	li	a1,2
    608a:	fe043503          	ld	a0,-32(s0)
    608e:	00001097          	auipc	ra,0x1
    6092:	5c4080e7          	jalr	1476(ra) # 7652 <open>
    6096:	87aa                	mv	a5,a0
    6098:	fcf42e23          	sw	a5,-36(s0)
  p[0] = '\0';
    609c:	fe043783          	ld	a5,-32(s0)
    60a0:	00078023          	sb	zero,0(a5)
  read(fd, p, 1);
    60a4:	fdc42783          	lw	a5,-36(s0)
    60a8:	4605                	li	a2,1
    60aa:	fe043583          	ld	a1,-32(s0)
    60ae:	853e                	mv	a0,a5
    60b0:	00001097          	auipc	ra,0x1
    60b4:	57a080e7          	jalr	1402(ra) # 762a <read>
  if(p[0] != 'x')
    60b8:	fe043783          	ld	a5,-32(s0)
    60bc:	0007c783          	lbu	a5,0(a5)
    60c0:	873e                	mv	a4,a5
    60c2:	07800793          	li	a5,120
    60c6:	00f70763          	beq	a4,a5,60d4 <sbrklast+0x120>
    exit(1);
    60ca:	4505                	li	a0,1
    60cc:	00001097          	auipc	ra,0x1
    60d0:	546080e7          	jalr	1350(ra) # 7612 <exit>
}
    60d4:	0001                	nop
    60d6:	70e2                	ld	ra,56(sp)
    60d8:	7442                	ld	s0,48(sp)
    60da:	6121                	addi	sp,sp,64
    60dc:	8082                	ret

00000000000060de <sbrk8000>:

// does sbrk handle signed int32 wrap-around with
// negative arguments?
void
sbrk8000(char *s)
{
    60de:	7179                	addi	sp,sp,-48
    60e0:	f406                	sd	ra,40(sp)
    60e2:	f022                	sd	s0,32(sp)
    60e4:	1800                	addi	s0,sp,48
    60e6:	fca43c23          	sd	a0,-40(s0)
  sbrk(0x80000004);
    60ea:	800007b7          	lui	a5,0x80000
    60ee:	00478513          	addi	a0,a5,4 # ffffffff80000004 <freep+0xffffffff7ffed4fc>
    60f2:	00001097          	auipc	ra,0x1
    60f6:	5a8080e7          	jalr	1448(ra) # 769a <sbrk>
  volatile char *top = sbrk(0);
    60fa:	4501                	li	a0,0
    60fc:	00001097          	auipc	ra,0x1
    6100:	59e080e7          	jalr	1438(ra) # 769a <sbrk>
    6104:	fea43423          	sd	a0,-24(s0)
  *(top-1) = *(top-1) + 1;
    6108:	fe843783          	ld	a5,-24(s0)
    610c:	17fd                	addi	a5,a5,-1
    610e:	0007c783          	lbu	a5,0(a5)
    6112:	0ff7f713          	zext.b	a4,a5
    6116:	fe843783          	ld	a5,-24(s0)
    611a:	17fd                	addi	a5,a5,-1
    611c:	2705                	addiw	a4,a4,1 # 1001 <truncate3+0x1b3>
    611e:	0ff77713          	zext.b	a4,a4
    6122:	00e78023          	sb	a4,0(a5)
}
    6126:	0001                	nop
    6128:	70a2                	ld	ra,40(sp)
    612a:	7402                	ld	s0,32(sp)
    612c:	6145                	addi	sp,sp,48
    612e:	8082                	ret

0000000000006130 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    6130:	7139                	addi	sp,sp,-64
    6132:	fc06                	sd	ra,56(sp)
    6134:	f822                	sd	s0,48(sp)
    6136:	0080                	addi	s0,sp,64
    6138:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 50000; i++){
    613c:	fe042623          	sw	zero,-20(s0)
    6140:	a03d                	j	616e <badarg+0x3e>
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    6142:	57fd                	li	a5,-1
    6144:	9381                	srli	a5,a5,0x20
    6146:	fcf43c23          	sd	a5,-40(s0)
    argv[1] = 0;
    614a:	fe043023          	sd	zero,-32(s0)
    exec("echo", argv);
    614e:	fd840793          	addi	a5,s0,-40
    6152:	85be                	mv	a1,a5
    6154:	00002517          	auipc	a0,0x2
    6158:	f6c50513          	addi	a0,a0,-148 # 80c0 <malloc+0x35c>
    615c:	00001097          	auipc	ra,0x1
    6160:	4ee080e7          	jalr	1262(ra) # 764a <exec>
  for(int i = 0; i < 50000; i++){
    6164:	fec42783          	lw	a5,-20(s0)
    6168:	2785                	addiw	a5,a5,1
    616a:	fef42623          	sw	a5,-20(s0)
    616e:	fec42783          	lw	a5,-20(s0)
    6172:	0007871b          	sext.w	a4,a5
    6176:	67b1                	lui	a5,0xc
    6178:	34f78793          	addi	a5,a5,847 # c34f <buf+0x6f>
    617c:	fce7d3e3          	bge	a5,a4,6142 <badarg+0x12>
  }

  exit(0);
    6180:	4501                	li	a0,0
    6182:	00001097          	auipc	ra,0x1
    6186:	490080e7          	jalr	1168(ra) # 7612 <exit>

000000000000618a <bigdir>:
//

// directory that uses indirect blocks
void
bigdir(char *s)
{
    618a:	7139                	addi	sp,sp,-64
    618c:	fc06                	sd	ra,56(sp)
    618e:	f822                	sd	s0,48(sp)
    6190:	0080                	addi	s0,sp,64
    6192:	fca43423          	sd	a0,-56(s0)
  enum { N = 500 };
  int i, fd;
  char name[10];

  unlink("bd");
    6196:	00004517          	auipc	a0,0x4
    619a:	d9250513          	addi	a0,a0,-622 # 9f28 <malloc+0x21c4>
    619e:	00001097          	auipc	ra,0x1
    61a2:	4c4080e7          	jalr	1220(ra) # 7662 <unlink>

  fd = open("bd", O_CREATE);
    61a6:	20000593          	li	a1,512
    61aa:	00004517          	auipc	a0,0x4
    61ae:	d7e50513          	addi	a0,a0,-642 # 9f28 <malloc+0x21c4>
    61b2:	00001097          	auipc	ra,0x1
    61b6:	4a0080e7          	jalr	1184(ra) # 7652 <open>
    61ba:	87aa                	mv	a5,a0
    61bc:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    61c0:	fe842783          	lw	a5,-24(s0)
    61c4:	2781                	sext.w	a5,a5
    61c6:	0207d163          	bgez	a5,61e8 <bigdir+0x5e>
    printf("%s: bigdir create failed\n", s);
    61ca:	fc843583          	ld	a1,-56(s0)
    61ce:	00004517          	auipc	a0,0x4
    61d2:	d6250513          	addi	a0,a0,-670 # 9f30 <malloc+0x21cc>
    61d6:	00002097          	auipc	ra,0x2
    61da:	99c080e7          	jalr	-1636(ra) # 7b72 <printf>
    exit(1);
    61de:	4505                	li	a0,1
    61e0:	00001097          	auipc	ra,0x1
    61e4:	432080e7          	jalr	1074(ra) # 7612 <exit>
  }
  close(fd);
    61e8:	fe842783          	lw	a5,-24(s0)
    61ec:	853e                	mv	a0,a5
    61ee:	00001097          	auipc	ra,0x1
    61f2:	44c080e7          	jalr	1100(ra) # 763a <close>

  for(i = 0; i < N; i++){
    61f6:	fe042623          	sw	zero,-20(s0)
    61fa:	a055                	j	629e <bigdir+0x114>
    name[0] = 'x';
    61fc:	07800793          	li	a5,120
    6200:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    6204:	fec42783          	lw	a5,-20(s0)
    6208:	41f7d71b          	sraiw	a4,a5,0x1f
    620c:	01a7571b          	srliw	a4,a4,0x1a
    6210:	9fb9                	addw	a5,a5,a4
    6212:	4067d79b          	sraiw	a5,a5,0x6
    6216:	2781                	sext.w	a5,a5
    6218:	0ff7f793          	zext.b	a5,a5
    621c:	0307879b          	addiw	a5,a5,48
    6220:	0ff7f793          	zext.b	a5,a5
    6224:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    6228:	fec42783          	lw	a5,-20(s0)
    622c:	873e                	mv	a4,a5
    622e:	41f7579b          	sraiw	a5,a4,0x1f
    6232:	01a7d79b          	srliw	a5,a5,0x1a
    6236:	9f3d                	addw	a4,a4,a5
    6238:	03f77713          	andi	a4,a4,63
    623c:	40f707bb          	subw	a5,a4,a5
    6240:	2781                	sext.w	a5,a5
    6242:	0ff7f793          	zext.b	a5,a5
    6246:	0307879b          	addiw	a5,a5,48
    624a:	0ff7f793          	zext.b	a5,a5
    624e:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    6252:	fc040da3          	sb	zero,-37(s0)
    if(link("bd", name) != 0){
    6256:	fd840793          	addi	a5,s0,-40
    625a:	85be                	mv	a1,a5
    625c:	00004517          	auipc	a0,0x4
    6260:	ccc50513          	addi	a0,a0,-820 # 9f28 <malloc+0x21c4>
    6264:	00001097          	auipc	ra,0x1
    6268:	40e080e7          	jalr	1038(ra) # 7672 <link>
    626c:	87aa                	mv	a5,a0
    626e:	c39d                	beqz	a5,6294 <bigdir+0x10a>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    6270:	fd840793          	addi	a5,s0,-40
    6274:	863e                	mv	a2,a5
    6276:	fc843583          	ld	a1,-56(s0)
    627a:	00004517          	auipc	a0,0x4
    627e:	cd650513          	addi	a0,a0,-810 # 9f50 <malloc+0x21ec>
    6282:	00002097          	auipc	ra,0x2
    6286:	8f0080e7          	jalr	-1808(ra) # 7b72 <printf>
      exit(1);
    628a:	4505                	li	a0,1
    628c:	00001097          	auipc	ra,0x1
    6290:	386080e7          	jalr	902(ra) # 7612 <exit>
  for(i = 0; i < N; i++){
    6294:	fec42783          	lw	a5,-20(s0)
    6298:	2785                	addiw	a5,a5,1
    629a:	fef42623          	sw	a5,-20(s0)
    629e:	fec42783          	lw	a5,-20(s0)
    62a2:	0007871b          	sext.w	a4,a5
    62a6:	1f300793          	li	a5,499
    62aa:	f4e7d9e3          	bge	a5,a4,61fc <bigdir+0x72>
    }
  }

  unlink("bd");
    62ae:	00004517          	auipc	a0,0x4
    62b2:	c7a50513          	addi	a0,a0,-902 # 9f28 <malloc+0x21c4>
    62b6:	00001097          	auipc	ra,0x1
    62ba:	3ac080e7          	jalr	940(ra) # 7662 <unlink>
  for(i = 0; i < N; i++){
    62be:	fe042623          	sw	zero,-20(s0)
    62c2:	a859                	j	6358 <bigdir+0x1ce>
    name[0] = 'x';
    62c4:	07800793          	li	a5,120
    62c8:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    62cc:	fec42783          	lw	a5,-20(s0)
    62d0:	41f7d71b          	sraiw	a4,a5,0x1f
    62d4:	01a7571b          	srliw	a4,a4,0x1a
    62d8:	9fb9                	addw	a5,a5,a4
    62da:	4067d79b          	sraiw	a5,a5,0x6
    62de:	2781                	sext.w	a5,a5
    62e0:	0ff7f793          	zext.b	a5,a5
    62e4:	0307879b          	addiw	a5,a5,48
    62e8:	0ff7f793          	zext.b	a5,a5
    62ec:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    62f0:	fec42783          	lw	a5,-20(s0)
    62f4:	873e                	mv	a4,a5
    62f6:	41f7579b          	sraiw	a5,a4,0x1f
    62fa:	01a7d79b          	srliw	a5,a5,0x1a
    62fe:	9f3d                	addw	a4,a4,a5
    6300:	03f77713          	andi	a4,a4,63
    6304:	40f707bb          	subw	a5,a4,a5
    6308:	2781                	sext.w	a5,a5
    630a:	0ff7f793          	zext.b	a5,a5
    630e:	0307879b          	addiw	a5,a5,48
    6312:	0ff7f793          	zext.b	a5,a5
    6316:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    631a:	fc040da3          	sb	zero,-37(s0)
    if(unlink(name) != 0){
    631e:	fd840793          	addi	a5,s0,-40
    6322:	853e                	mv	a0,a5
    6324:	00001097          	auipc	ra,0x1
    6328:	33e080e7          	jalr	830(ra) # 7662 <unlink>
    632c:	87aa                	mv	a5,a0
    632e:	c385                	beqz	a5,634e <bigdir+0x1c4>
      printf("%s: bigdir unlink failed", s);
    6330:	fc843583          	ld	a1,-56(s0)
    6334:	00004517          	auipc	a0,0x4
    6338:	c3c50513          	addi	a0,a0,-964 # 9f70 <malloc+0x220c>
    633c:	00002097          	auipc	ra,0x2
    6340:	836080e7          	jalr	-1994(ra) # 7b72 <printf>
      exit(1);
    6344:	4505                	li	a0,1
    6346:	00001097          	auipc	ra,0x1
    634a:	2cc080e7          	jalr	716(ra) # 7612 <exit>
  for(i = 0; i < N; i++){
    634e:	fec42783          	lw	a5,-20(s0)
    6352:	2785                	addiw	a5,a5,1
    6354:	fef42623          	sw	a5,-20(s0)
    6358:	fec42783          	lw	a5,-20(s0)
    635c:	0007871b          	sext.w	a4,a5
    6360:	1f300793          	li	a5,499
    6364:	f6e7d0e3          	bge	a5,a4,62c4 <bigdir+0x13a>
    }
  }
}
    6368:	0001                	nop
    636a:	0001                	nop
    636c:	70e2                	ld	ra,56(sp)
    636e:	7442                	ld	s0,48(sp)
    6370:	6121                	addi	sp,sp,64
    6372:	8082                	ret

0000000000006374 <manywrites>:

// concurrent writes to try to provoke deadlock in the virtio disk
// driver.
void
manywrites(char *s)
{
    6374:	711d                	addi	sp,sp,-96
    6376:	ec86                	sd	ra,88(sp)
    6378:	e8a2                	sd	s0,80(sp)
    637a:	1080                	addi	s0,sp,96
    637c:	faa43423          	sd	a0,-88(s0)
  int nchildren = 4;
    6380:	4791                	li	a5,4
    6382:	fcf42e23          	sw	a5,-36(s0)
  int howmany = 30; // increase to look for deadlock
    6386:	47f9                	li	a5,30
    6388:	fcf42c23          	sw	a5,-40(s0)

  for(int ci = 0; ci < nchildren; ci++){
    638c:	fe042623          	sw	zero,-20(s0)
    6390:	aa61                	j	6528 <manywrites+0x1b4>
    int pid = fork();
    6392:	00001097          	auipc	ra,0x1
    6396:	278080e7          	jalr	632(ra) # 760a <fork>
    639a:	87aa                	mv	a5,a0
    639c:	fcf42a23          	sw	a5,-44(s0)
    if(pid < 0){
    63a0:	fd442783          	lw	a5,-44(s0)
    63a4:	2781                	sext.w	a5,a5
    63a6:	0007df63          	bgez	a5,63c4 <manywrites+0x50>
      printf("fork failed\n");
    63aa:	00002517          	auipc	a0,0x2
    63ae:	d0650513          	addi	a0,a0,-762 # 80b0 <malloc+0x34c>
    63b2:	00001097          	auipc	ra,0x1
    63b6:	7c0080e7          	jalr	1984(ra) # 7b72 <printf>
      exit(1);
    63ba:	4505                	li	a0,1
    63bc:	00001097          	auipc	ra,0x1
    63c0:	256080e7          	jalr	598(ra) # 7612 <exit>
    }

    if(pid == 0){
    63c4:	fd442783          	lw	a5,-44(s0)
    63c8:	2781                	sext.w	a5,a5
    63ca:	14079a63          	bnez	a5,651e <manywrites+0x1aa>
      char name[3];
      name[0] = 'b';
    63ce:	06200793          	li	a5,98
    63d2:	fcf40023          	sb	a5,-64(s0)
      name[1] = 'a' + ci;
    63d6:	fec42783          	lw	a5,-20(s0)
    63da:	0ff7f793          	zext.b	a5,a5
    63de:	0617879b          	addiw	a5,a5,97
    63e2:	0ff7f793          	zext.b	a5,a5
    63e6:	fcf400a3          	sb	a5,-63(s0)
      name[2] = '\0';
    63ea:	fc040123          	sb	zero,-62(s0)
      unlink(name);
    63ee:	fc040793          	addi	a5,s0,-64
    63f2:	853e                	mv	a0,a5
    63f4:	00001097          	auipc	ra,0x1
    63f8:	26e080e7          	jalr	622(ra) # 7662 <unlink>

      for(int iters = 0; iters < howmany; iters++){
    63fc:	fe042423          	sw	zero,-24(s0)
    6400:	a8d5                	j	64f4 <manywrites+0x180>
        for(int i = 0; i < ci+1; i++){
    6402:	fe042223          	sw	zero,-28(s0)
    6406:	a0d1                	j	64ca <manywrites+0x156>
          int fd = open(name, O_CREATE | O_RDWR);
    6408:	fc040793          	addi	a5,s0,-64
    640c:	20200593          	li	a1,514
    6410:	853e                	mv	a0,a5
    6412:	00001097          	auipc	ra,0x1
    6416:	240080e7          	jalr	576(ra) # 7652 <open>
    641a:	87aa                	mv	a5,a0
    641c:	fcf42823          	sw	a5,-48(s0)
          if(fd < 0){
    6420:	fd042783          	lw	a5,-48(s0)
    6424:	2781                	sext.w	a5,a5
    6426:	0207d463          	bgez	a5,644e <manywrites+0xda>
            printf("%s: cannot create %s\n", s, name);
    642a:	fc040793          	addi	a5,s0,-64
    642e:	863e                	mv	a2,a5
    6430:	fa843583          	ld	a1,-88(s0)
    6434:	00004517          	auipc	a0,0x4
    6438:	b5c50513          	addi	a0,a0,-1188 # 9f90 <malloc+0x222c>
    643c:	00001097          	auipc	ra,0x1
    6440:	736080e7          	jalr	1846(ra) # 7b72 <printf>
            exit(1);
    6444:	4505                	li	a0,1
    6446:	00001097          	auipc	ra,0x1
    644a:	1cc080e7          	jalr	460(ra) # 7612 <exit>
          }
          int sz = sizeof(buf);
    644e:	678d                	lui	a5,0x3
    6450:	fcf42623          	sw	a5,-52(s0)
          int cc = write(fd, buf, sz);
    6454:	fcc42703          	lw	a4,-52(s0)
    6458:	fd042783          	lw	a5,-48(s0)
    645c:	863a                	mv	a2,a4
    645e:	00006597          	auipc	a1,0x6
    6462:	e8258593          	addi	a1,a1,-382 # c2e0 <buf>
    6466:	853e                	mv	a0,a5
    6468:	00001097          	auipc	ra,0x1
    646c:	1ca080e7          	jalr	458(ra) # 7632 <write>
    6470:	87aa                	mv	a5,a0
    6472:	fcf42423          	sw	a5,-56(s0)
          if(cc != sz){
    6476:	fc842783          	lw	a5,-56(s0)
    647a:	873e                	mv	a4,a5
    647c:	fcc42783          	lw	a5,-52(s0)
    6480:	2701                	sext.w	a4,a4
    6482:	2781                	sext.w	a5,a5
    6484:	02f70763          	beq	a4,a5,64b2 <manywrites+0x13e>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    6488:	fc842703          	lw	a4,-56(s0)
    648c:	fcc42783          	lw	a5,-52(s0)
    6490:	86ba                	mv	a3,a4
    6492:	863e                	mv	a2,a5
    6494:	fa843583          	ld	a1,-88(s0)
    6498:	00003517          	auipc	a0,0x3
    649c:	e5050513          	addi	a0,a0,-432 # 92e8 <malloc+0x1584>
    64a0:	00001097          	auipc	ra,0x1
    64a4:	6d2080e7          	jalr	1746(ra) # 7b72 <printf>
            exit(1);
    64a8:	4505                	li	a0,1
    64aa:	00001097          	auipc	ra,0x1
    64ae:	168080e7          	jalr	360(ra) # 7612 <exit>
          }
          close(fd);
    64b2:	fd042783          	lw	a5,-48(s0)
    64b6:	853e                	mv	a0,a5
    64b8:	00001097          	auipc	ra,0x1
    64bc:	182080e7          	jalr	386(ra) # 763a <close>
        for(int i = 0; i < ci+1; i++){
    64c0:	fe442783          	lw	a5,-28(s0)
    64c4:	2785                	addiw	a5,a5,1 # 3001 <createdelete+0x281>
    64c6:	fef42223          	sw	a5,-28(s0)
    64ca:	fec42783          	lw	a5,-20(s0)
    64ce:	873e                	mv	a4,a5
    64d0:	fe442783          	lw	a5,-28(s0)
    64d4:	2701                	sext.w	a4,a4
    64d6:	2781                	sext.w	a5,a5
    64d8:	f2f758e3          	bge	a4,a5,6408 <manywrites+0x94>
        }
        unlink(name);
    64dc:	fc040793          	addi	a5,s0,-64
    64e0:	853e                	mv	a0,a5
    64e2:	00001097          	auipc	ra,0x1
    64e6:	180080e7          	jalr	384(ra) # 7662 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    64ea:	fe842783          	lw	a5,-24(s0)
    64ee:	2785                	addiw	a5,a5,1
    64f0:	fef42423          	sw	a5,-24(s0)
    64f4:	fe842783          	lw	a5,-24(s0)
    64f8:	873e                	mv	a4,a5
    64fa:	fd842783          	lw	a5,-40(s0)
    64fe:	2701                	sext.w	a4,a4
    6500:	2781                	sext.w	a5,a5
    6502:	f0f740e3          	blt	a4,a5,6402 <manywrites+0x8e>
      }

      unlink(name);
    6506:	fc040793          	addi	a5,s0,-64
    650a:	853e                	mv	a0,a5
    650c:	00001097          	auipc	ra,0x1
    6510:	156080e7          	jalr	342(ra) # 7662 <unlink>
      exit(0);
    6514:	4501                	li	a0,0
    6516:	00001097          	auipc	ra,0x1
    651a:	0fc080e7          	jalr	252(ra) # 7612 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    651e:	fec42783          	lw	a5,-20(s0)
    6522:	2785                	addiw	a5,a5,1
    6524:	fef42623          	sw	a5,-20(s0)
    6528:	fec42783          	lw	a5,-20(s0)
    652c:	873e                	mv	a4,a5
    652e:	fdc42783          	lw	a5,-36(s0)
    6532:	2701                	sext.w	a4,a4
    6534:	2781                	sext.w	a5,a5
    6536:	e4f74ee3          	blt	a4,a5,6392 <manywrites+0x1e>
    }
  }

  for(int ci = 0; ci < nchildren; ci++){
    653a:	fe042023          	sw	zero,-32(s0)
    653e:	a80d                	j	6570 <manywrites+0x1fc>
    int st = 0;
    6540:	fa042e23          	sw	zero,-68(s0)
    wait(&st);
    6544:	fbc40793          	addi	a5,s0,-68
    6548:	853e                	mv	a0,a5
    654a:	00001097          	auipc	ra,0x1
    654e:	0d0080e7          	jalr	208(ra) # 761a <wait>
    if(st != 0)
    6552:	fbc42783          	lw	a5,-68(s0)
    6556:	cb81                	beqz	a5,6566 <manywrites+0x1f2>
      exit(st);
    6558:	fbc42783          	lw	a5,-68(s0)
    655c:	853e                	mv	a0,a5
    655e:	00001097          	auipc	ra,0x1
    6562:	0b4080e7          	jalr	180(ra) # 7612 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    6566:	fe042783          	lw	a5,-32(s0)
    656a:	2785                	addiw	a5,a5,1
    656c:	fef42023          	sw	a5,-32(s0)
    6570:	fe042783          	lw	a5,-32(s0)
    6574:	873e                	mv	a4,a5
    6576:	fdc42783          	lw	a5,-36(s0)
    657a:	2701                	sext.w	a4,a4
    657c:	2781                	sext.w	a5,a5
    657e:	fcf741e3          	blt	a4,a5,6540 <manywrites+0x1cc>
  }
  exit(0);
    6582:	4501                	li	a0,0
    6584:	00001097          	auipc	ra,0x1
    6588:	08e080e7          	jalr	142(ra) # 7612 <exit>

000000000000658c <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
    658c:	7179                	addi	sp,sp,-48
    658e:	f406                	sd	ra,40(sp)
    6590:	f022                	sd	s0,32(sp)
    6592:	1800                	addi	s0,sp,48
    6594:	fca43c23          	sd	a0,-40(s0)
  int assumed_free = 600;
    6598:	25800793          	li	a5,600
    659c:	fef42423          	sw	a5,-24(s0)

  unlink("junk");
    65a0:	00004517          	auipc	a0,0x4
    65a4:	a0850513          	addi	a0,a0,-1528 # 9fa8 <malloc+0x2244>
    65a8:	00001097          	auipc	ra,0x1
    65ac:	0ba080e7          	jalr	186(ra) # 7662 <unlink>
  for(int i = 0; i < assumed_free; i++){
    65b0:	fe042623          	sw	zero,-20(s0)
    65b4:	a8bd                	j	6632 <badwrite+0xa6>
    int fd = open("junk", O_CREATE|O_WRONLY);
    65b6:	20100593          	li	a1,513
    65ba:	00004517          	auipc	a0,0x4
    65be:	9ee50513          	addi	a0,a0,-1554 # 9fa8 <malloc+0x2244>
    65c2:	00001097          	auipc	ra,0x1
    65c6:	090080e7          	jalr	144(ra) # 7652 <open>
    65ca:	87aa                	mv	a5,a0
    65cc:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    65d0:	fe042783          	lw	a5,-32(s0)
    65d4:	2781                	sext.w	a5,a5
    65d6:	0007df63          	bgez	a5,65f4 <badwrite+0x68>
      printf("open junk failed\n");
    65da:	00004517          	auipc	a0,0x4
    65de:	9d650513          	addi	a0,a0,-1578 # 9fb0 <malloc+0x224c>
    65e2:	00001097          	auipc	ra,0x1
    65e6:	590080e7          	jalr	1424(ra) # 7b72 <printf>
      exit(1);
    65ea:	4505                	li	a0,1
    65ec:	00001097          	auipc	ra,0x1
    65f0:	026080e7          	jalr	38(ra) # 7612 <exit>
    }
    write(fd, (char*)0xffffffffffL, 1);
    65f4:	fe042703          	lw	a4,-32(s0)
    65f8:	4605                	li	a2,1
    65fa:	57fd                	li	a5,-1
    65fc:	0187d593          	srli	a1,a5,0x18
    6600:	853a                	mv	a0,a4
    6602:	00001097          	auipc	ra,0x1
    6606:	030080e7          	jalr	48(ra) # 7632 <write>
    close(fd);
    660a:	fe042783          	lw	a5,-32(s0)
    660e:	853e                	mv	a0,a5
    6610:	00001097          	auipc	ra,0x1
    6614:	02a080e7          	jalr	42(ra) # 763a <close>
    unlink("junk");
    6618:	00004517          	auipc	a0,0x4
    661c:	99050513          	addi	a0,a0,-1648 # 9fa8 <malloc+0x2244>
    6620:	00001097          	auipc	ra,0x1
    6624:	042080e7          	jalr	66(ra) # 7662 <unlink>
  for(int i = 0; i < assumed_free; i++){
    6628:	fec42783          	lw	a5,-20(s0)
    662c:	2785                	addiw	a5,a5,1
    662e:	fef42623          	sw	a5,-20(s0)
    6632:	fec42783          	lw	a5,-20(s0)
    6636:	873e                	mv	a4,a5
    6638:	fe842783          	lw	a5,-24(s0)
    663c:	2701                	sext.w	a4,a4
    663e:	2781                	sext.w	a5,a5
    6640:	f6f74be3          	blt	a4,a5,65b6 <badwrite+0x2a>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
    6644:	20100593          	li	a1,513
    6648:	00004517          	auipc	a0,0x4
    664c:	96050513          	addi	a0,a0,-1696 # 9fa8 <malloc+0x2244>
    6650:	00001097          	auipc	ra,0x1
    6654:	002080e7          	jalr	2(ra) # 7652 <open>
    6658:	87aa                	mv	a5,a0
    665a:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    665e:	fe442783          	lw	a5,-28(s0)
    6662:	2781                	sext.w	a5,a5
    6664:	0007df63          	bgez	a5,6682 <badwrite+0xf6>
    printf("open junk failed\n");
    6668:	00004517          	auipc	a0,0x4
    666c:	94850513          	addi	a0,a0,-1720 # 9fb0 <malloc+0x224c>
    6670:	00001097          	auipc	ra,0x1
    6674:	502080e7          	jalr	1282(ra) # 7b72 <printf>
    exit(1);
    6678:	4505                	li	a0,1
    667a:	00001097          	auipc	ra,0x1
    667e:	f98080e7          	jalr	-104(ra) # 7612 <exit>
  }
  if(write(fd, "x", 1) != 1){
    6682:	fe442783          	lw	a5,-28(s0)
    6686:	4605                	li	a2,1
    6688:	00002597          	auipc	a1,0x2
    668c:	92858593          	addi	a1,a1,-1752 # 7fb0 <malloc+0x24c>
    6690:	853e                	mv	a0,a5
    6692:	00001097          	auipc	ra,0x1
    6696:	fa0080e7          	jalr	-96(ra) # 7632 <write>
    669a:	87aa                	mv	a5,a0
    669c:	873e                	mv	a4,a5
    669e:	4785                	li	a5,1
    66a0:	00f70f63          	beq	a4,a5,66be <badwrite+0x132>
    printf("write failed\n");
    66a4:	00004517          	auipc	a0,0x4
    66a8:	92450513          	addi	a0,a0,-1756 # 9fc8 <malloc+0x2264>
    66ac:	00001097          	auipc	ra,0x1
    66b0:	4c6080e7          	jalr	1222(ra) # 7b72 <printf>
    exit(1);
    66b4:	4505                	li	a0,1
    66b6:	00001097          	auipc	ra,0x1
    66ba:	f5c080e7          	jalr	-164(ra) # 7612 <exit>
  }
  close(fd);
    66be:	fe442783          	lw	a5,-28(s0)
    66c2:	853e                	mv	a0,a5
    66c4:	00001097          	auipc	ra,0x1
    66c8:	f76080e7          	jalr	-138(ra) # 763a <close>
  unlink("junk");
    66cc:	00004517          	auipc	a0,0x4
    66d0:	8dc50513          	addi	a0,a0,-1828 # 9fa8 <malloc+0x2244>
    66d4:	00001097          	auipc	ra,0x1
    66d8:	f8e080e7          	jalr	-114(ra) # 7662 <unlink>

  exit(0);
    66dc:	4501                	li	a0,0
    66de:	00001097          	auipc	ra,0x1
    66e2:	f34080e7          	jalr	-204(ra) # 7612 <exit>

00000000000066e6 <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    66e6:	715d                	addi	sp,sp,-80
    66e8:	e486                	sd	ra,72(sp)
    66ea:	e0a2                	sd	s0,64(sp)
    66ec:	0880                	addi	s0,sp,80
    66ee:	faa43c23          	sd	a0,-72(s0)
  for(int avail = 0; avail < 15; avail++){
    66f2:	fe042623          	sw	zero,-20(s0)
    66f6:	a8cd                	j	67e8 <execout+0x102>
    int pid = fork();
    66f8:	00001097          	auipc	ra,0x1
    66fc:	f12080e7          	jalr	-238(ra) # 760a <fork>
    6700:	87aa                	mv	a5,a0
    6702:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    6706:	fe442783          	lw	a5,-28(s0)
    670a:	2781                	sext.w	a5,a5
    670c:	0007df63          	bgez	a5,672a <execout+0x44>
      printf("fork failed\n");
    6710:	00002517          	auipc	a0,0x2
    6714:	9a050513          	addi	a0,a0,-1632 # 80b0 <malloc+0x34c>
    6718:	00001097          	auipc	ra,0x1
    671c:	45a080e7          	jalr	1114(ra) # 7b72 <printf>
      exit(1);
    6720:	4505                	li	a0,1
    6722:	00001097          	auipc	ra,0x1
    6726:	ef0080e7          	jalr	-272(ra) # 7612 <exit>
    } else if(pid == 0){
    672a:	fe442783          	lw	a5,-28(s0)
    672e:	2781                	sext.w	a5,a5
    6730:	e3d5                	bnez	a5,67d4 <execout+0xee>
      // allocate all of memory.
      while(1){
        uint64 a = (uint64) sbrk(4096);
    6732:	6505                	lui	a0,0x1
    6734:	00001097          	auipc	ra,0x1
    6738:	f66080e7          	jalr	-154(ra) # 769a <sbrk>
    673c:	87aa                	mv	a5,a0
    673e:	fcf43c23          	sd	a5,-40(s0)
        if(a == 0xffffffffffffffffLL)
    6742:	fd843703          	ld	a4,-40(s0)
    6746:	57fd                	li	a5,-1
    6748:	00f70c63          	beq	a4,a5,6760 <execout+0x7a>
          break;
        *(char*)(a + 4096 - 1) = 1;
    674c:	fd843703          	ld	a4,-40(s0)
    6750:	6785                	lui	a5,0x1
    6752:	17fd                	addi	a5,a5,-1 # fff <truncate3+0x1b1>
    6754:	97ba                	add	a5,a5,a4
    6756:	873e                	mv	a4,a5
    6758:	4785                	li	a5,1
    675a:	00f70023          	sb	a5,0(a4)
      while(1){
    675e:	bfd1                	j	6732 <execout+0x4c>
          break;
    6760:	0001                	nop
      }

      // free a few pages, in order to let exec() make some
      // progress.
      for(int i = 0; i < avail; i++)
    6762:	fe042423          	sw	zero,-24(s0)
    6766:	a819                	j	677c <execout+0x96>
        sbrk(-4096);
    6768:	757d                	lui	a0,0xfffff
    676a:	00001097          	auipc	ra,0x1
    676e:	f30080e7          	jalr	-208(ra) # 769a <sbrk>
      for(int i = 0; i < avail; i++)
    6772:	fe842783          	lw	a5,-24(s0)
    6776:	2785                	addiw	a5,a5,1
    6778:	fef42423          	sw	a5,-24(s0)
    677c:	fe842783          	lw	a5,-24(s0)
    6780:	873e                	mv	a4,a5
    6782:	fec42783          	lw	a5,-20(s0)
    6786:	2701                	sext.w	a4,a4
    6788:	2781                	sext.w	a5,a5
    678a:	fcf74fe3          	blt	a4,a5,6768 <execout+0x82>

      close(1);
    678e:	4505                	li	a0,1
    6790:	00001097          	auipc	ra,0x1
    6794:	eaa080e7          	jalr	-342(ra) # 763a <close>
      char *args[] = { "echo", "x", 0 };
    6798:	00002797          	auipc	a5,0x2
    679c:	92878793          	addi	a5,a5,-1752 # 80c0 <malloc+0x35c>
    67a0:	fcf43023          	sd	a5,-64(s0)
    67a4:	00002797          	auipc	a5,0x2
    67a8:	80c78793          	addi	a5,a5,-2036 # 7fb0 <malloc+0x24c>
    67ac:	fcf43423          	sd	a5,-56(s0)
    67b0:	fc043823          	sd	zero,-48(s0)
      exec("echo", args);
    67b4:	fc040793          	addi	a5,s0,-64
    67b8:	85be                	mv	a1,a5
    67ba:	00002517          	auipc	a0,0x2
    67be:	90650513          	addi	a0,a0,-1786 # 80c0 <malloc+0x35c>
    67c2:	00001097          	auipc	ra,0x1
    67c6:	e88080e7          	jalr	-376(ra) # 764a <exec>
      exit(0);
    67ca:	4501                	li	a0,0
    67cc:	00001097          	auipc	ra,0x1
    67d0:	e46080e7          	jalr	-442(ra) # 7612 <exit>
    } else {
      wait((int*)0);
    67d4:	4501                	li	a0,0
    67d6:	00001097          	auipc	ra,0x1
    67da:	e44080e7          	jalr	-444(ra) # 761a <wait>
  for(int avail = 0; avail < 15; avail++){
    67de:	fec42783          	lw	a5,-20(s0)
    67e2:	2785                	addiw	a5,a5,1
    67e4:	fef42623          	sw	a5,-20(s0)
    67e8:	fec42783          	lw	a5,-20(s0)
    67ec:	0007871b          	sext.w	a4,a5
    67f0:	47b9                	li	a5,14
    67f2:	f0e7d3e3          	bge	a5,a4,66f8 <execout+0x12>
    }
  }

  exit(0);
    67f6:	4501                	li	a0,0
    67f8:	00001097          	auipc	ra,0x1
    67fc:	e1a080e7          	jalr	-486(ra) # 7612 <exit>

0000000000006800 <diskfull>:
}

// can the kernel tolerate running out of disk space?
void
diskfull(char *s)
{
    6800:	b9010113          	addi	sp,sp,-1136
    6804:	46113423          	sd	ra,1128(sp)
    6808:	46813023          	sd	s0,1120(sp)
    680c:	47010413          	addi	s0,sp,1136
    6810:	b8a43c23          	sd	a0,-1128(s0)
  int fi;
  int done = 0;
    6814:	fe042423          	sw	zero,-24(s0)

  unlink("diskfulldir");
    6818:	00003517          	auipc	a0,0x3
    681c:	7c050513          	addi	a0,a0,1984 # 9fd8 <malloc+0x2274>
    6820:	00001097          	auipc	ra,0x1
    6824:	e42080e7          	jalr	-446(ra) # 7662 <unlink>

  for(fi = 0; done == 0; fi++){
    6828:	fe042623          	sw	zero,-20(s0)
    682c:	a8d5                	j	6920 <diskfull+0x120>
    char name[32];
    name[0] = 'b';
    682e:	06200793          	li	a5,98
    6832:	baf40423          	sb	a5,-1112(s0)
    name[1] = 'i';
    6836:	06900793          	li	a5,105
    683a:	baf404a3          	sb	a5,-1111(s0)
    name[2] = 'g';
    683e:	06700793          	li	a5,103
    6842:	baf40523          	sb	a5,-1110(s0)
    name[3] = '0' + fi;
    6846:	fec42783          	lw	a5,-20(s0)
    684a:	0ff7f793          	zext.b	a5,a5
    684e:	0307879b          	addiw	a5,a5,48
    6852:	0ff7f793          	zext.b	a5,a5
    6856:	baf405a3          	sb	a5,-1109(s0)
    name[4] = '\0';
    685a:	ba040623          	sb	zero,-1108(s0)
    unlink(name);
    685e:	ba840793          	addi	a5,s0,-1112
    6862:	853e                	mv	a0,a5
    6864:	00001097          	auipc	ra,0x1
    6868:	dfe080e7          	jalr	-514(ra) # 7662 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    686c:	ba840793          	addi	a5,s0,-1112
    6870:	60200593          	li	a1,1538
    6874:	853e                	mv	a0,a5
    6876:	00001097          	auipc	ra,0x1
    687a:	ddc080e7          	jalr	-548(ra) # 7652 <open>
    687e:	87aa                	mv	a5,a0
    6880:	fcf42a23          	sw	a5,-44(s0)
    if(fd < 0){
    6884:	fd442783          	lw	a5,-44(s0)
    6888:	2781                	sext.w	a5,a5
    688a:	0207d363          	bgez	a5,68b0 <diskfull+0xb0>
      // oops, ran out of inodes before running out of blocks.
      printf("%s: could not create file %s\n", s, name);
    688e:	ba840793          	addi	a5,s0,-1112
    6892:	863e                	mv	a2,a5
    6894:	b9843583          	ld	a1,-1128(s0)
    6898:	00003517          	auipc	a0,0x3
    689c:	75050513          	addi	a0,a0,1872 # 9fe8 <malloc+0x2284>
    68a0:	00001097          	auipc	ra,0x1
    68a4:	2d2080e7          	jalr	722(ra) # 7b72 <printf>
      done = 1;
    68a8:	4785                	li	a5,1
    68aa:	fef42423          	sw	a5,-24(s0)
    68ae:	a8ad                	j	6928 <diskfull+0x128>
      break;
    }
    for(int i = 0; i < MAXFILE; i++){
    68b0:	fe042223          	sw	zero,-28(s0)
    68b4:	a099                	j	68fa <diskfull+0xfa>
      char buf[BSIZE];
      if(write(fd, buf, BSIZE) != BSIZE){
    68b6:	bc840713          	addi	a4,s0,-1080
    68ba:	fd442783          	lw	a5,-44(s0)
    68be:	40000613          	li	a2,1024
    68c2:	85ba                	mv	a1,a4
    68c4:	853e                	mv	a0,a5
    68c6:	00001097          	auipc	ra,0x1
    68ca:	d6c080e7          	jalr	-660(ra) # 7632 <write>
    68ce:	87aa                	mv	a5,a0
    68d0:	873e                	mv	a4,a5
    68d2:	40000793          	li	a5,1024
    68d6:	00f70d63          	beq	a4,a5,68f0 <diskfull+0xf0>
        done = 1;
    68da:	4785                	li	a5,1
    68dc:	fef42423          	sw	a5,-24(s0)
        close(fd);
    68e0:	fd442783          	lw	a5,-44(s0)
    68e4:	853e                	mv	a0,a5
    68e6:	00001097          	auipc	ra,0x1
    68ea:	d54080e7          	jalr	-684(ra) # 763a <close>
    68ee:	a829                	j	6908 <diskfull+0x108>
    for(int i = 0; i < MAXFILE; i++){
    68f0:	fe442783          	lw	a5,-28(s0)
    68f4:	2785                	addiw	a5,a5,1
    68f6:	fef42223          	sw	a5,-28(s0)
    68fa:	fe442783          	lw	a5,-28(s0)
    68fe:	873e                	mv	a4,a5
    6900:	10b00793          	li	a5,267
    6904:	fae7f9e3          	bgeu	a5,a4,68b6 <diskfull+0xb6>
        break;
      }
    }
    close(fd);
    6908:	fd442783          	lw	a5,-44(s0)
    690c:	853e                	mv	a0,a5
    690e:	00001097          	auipc	ra,0x1
    6912:	d2c080e7          	jalr	-724(ra) # 763a <close>
  for(fi = 0; done == 0; fi++){
    6916:	fec42783          	lw	a5,-20(s0)
    691a:	2785                	addiw	a5,a5,1
    691c:	fef42623          	sw	a5,-20(s0)
    6920:	fe842783          	lw	a5,-24(s0)
    6924:	2781                	sext.w	a5,a5
    6926:	d781                	beqz	a5,682e <diskfull+0x2e>

  // now that there are no free blocks, test that dirlink()
  // merely fails (doesn't panic) if it can't extend
  // directory content. one of these file creations
  // is expected to fail.
  int nzz = 128;
    6928:	08000793          	li	a5,128
    692c:	fcf42823          	sw	a5,-48(s0)
  for(int i = 0; i < nzz; i++){
    6930:	fe042023          	sw	zero,-32(s0)
    6934:	a06d                	j	69de <diskfull+0x1de>
    char name[32];
    name[0] = 'z';
    6936:	07a00793          	li	a5,122
    693a:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'z';
    693e:	07a00793          	li	a5,122
    6942:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = '0' + (i / 32);
    6946:	fe042783          	lw	a5,-32(s0)
    694a:	41f7d71b          	sraiw	a4,a5,0x1f
    694e:	01b7571b          	srliw	a4,a4,0x1b
    6952:	9fb9                	addw	a5,a5,a4
    6954:	4057d79b          	sraiw	a5,a5,0x5
    6958:	2781                	sext.w	a5,a5
    695a:	0ff7f793          	zext.b	a5,a5
    695e:	0307879b          	addiw	a5,a5,48
    6962:	0ff7f793          	zext.b	a5,a5
    6966:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + (i % 32);
    696a:	fe042783          	lw	a5,-32(s0)
    696e:	873e                	mv	a4,a5
    6970:	41f7579b          	sraiw	a5,a4,0x1f
    6974:	01b7d79b          	srliw	a5,a5,0x1b
    6978:	9f3d                	addw	a4,a4,a5
    697a:	8b7d                	andi	a4,a4,31
    697c:	40f707bb          	subw	a5,a4,a5
    6980:	2781                	sext.w	a5,a5
    6982:	0ff7f793          	zext.b	a5,a5
    6986:	0307879b          	addiw	a5,a5,48
    698a:	0ff7f793          	zext.b	a5,a5
    698e:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    6992:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    6996:	bc840793          	addi	a5,s0,-1080
    699a:	853e                	mv	a0,a5
    699c:	00001097          	auipc	ra,0x1
    69a0:	cc6080e7          	jalr	-826(ra) # 7662 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    69a4:	bc840793          	addi	a5,s0,-1080
    69a8:	60200593          	li	a1,1538
    69ac:	853e                	mv	a0,a5
    69ae:	00001097          	auipc	ra,0x1
    69b2:	ca4080e7          	jalr	-860(ra) # 7652 <open>
    69b6:	87aa                	mv	a5,a0
    69b8:	fcf42623          	sw	a5,-52(s0)
    if(fd < 0)
    69bc:	fcc42783          	lw	a5,-52(s0)
    69c0:	2781                	sext.w	a5,a5
    69c2:	0207c863          	bltz	a5,69f2 <diskfull+0x1f2>
      break;
    close(fd);
    69c6:	fcc42783          	lw	a5,-52(s0)
    69ca:	853e                	mv	a0,a5
    69cc:	00001097          	auipc	ra,0x1
    69d0:	c6e080e7          	jalr	-914(ra) # 763a <close>
  for(int i = 0; i < nzz; i++){
    69d4:	fe042783          	lw	a5,-32(s0)
    69d8:	2785                	addiw	a5,a5,1
    69da:	fef42023          	sw	a5,-32(s0)
    69de:	fe042783          	lw	a5,-32(s0)
    69e2:	873e                	mv	a4,a5
    69e4:	fd042783          	lw	a5,-48(s0)
    69e8:	2701                	sext.w	a4,a4
    69ea:	2781                	sext.w	a5,a5
    69ec:	f4f745e3          	blt	a4,a5,6936 <diskfull+0x136>
    69f0:	a011                	j	69f4 <diskfull+0x1f4>
      break;
    69f2:	0001                	nop
  }

  // this mkdir() is expected to fail.
  if(mkdir("diskfulldir") == 0)
    69f4:	00003517          	auipc	a0,0x3
    69f8:	5e450513          	addi	a0,a0,1508 # 9fd8 <malloc+0x2274>
    69fc:	00001097          	auipc	ra,0x1
    6a00:	c7e080e7          	jalr	-898(ra) # 767a <mkdir>
    6a04:	87aa                	mv	a5,a0
    6a06:	eb89                	bnez	a5,6a18 <diskfull+0x218>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    6a08:	00003517          	auipc	a0,0x3
    6a0c:	60050513          	addi	a0,a0,1536 # a008 <malloc+0x22a4>
    6a10:	00001097          	auipc	ra,0x1
    6a14:	162080e7          	jalr	354(ra) # 7b72 <printf>

  unlink("diskfulldir");
    6a18:	00003517          	auipc	a0,0x3
    6a1c:	5c050513          	addi	a0,a0,1472 # 9fd8 <malloc+0x2274>
    6a20:	00001097          	auipc	ra,0x1
    6a24:	c42080e7          	jalr	-958(ra) # 7662 <unlink>

  for(int i = 0; i < nzz; i++){
    6a28:	fc042e23          	sw	zero,-36(s0)
    6a2c:	a8ad                	j	6aa6 <diskfull+0x2a6>
    char name[32];
    name[0] = 'z';
    6a2e:	07a00793          	li	a5,122
    6a32:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'z';
    6a36:	07a00793          	li	a5,122
    6a3a:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = '0' + (i / 32);
    6a3e:	fdc42783          	lw	a5,-36(s0)
    6a42:	41f7d71b          	sraiw	a4,a5,0x1f
    6a46:	01b7571b          	srliw	a4,a4,0x1b
    6a4a:	9fb9                	addw	a5,a5,a4
    6a4c:	4057d79b          	sraiw	a5,a5,0x5
    6a50:	2781                	sext.w	a5,a5
    6a52:	0ff7f793          	zext.b	a5,a5
    6a56:	0307879b          	addiw	a5,a5,48
    6a5a:	0ff7f793          	zext.b	a5,a5
    6a5e:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + (i % 32);
    6a62:	fdc42783          	lw	a5,-36(s0)
    6a66:	873e                	mv	a4,a5
    6a68:	41f7579b          	sraiw	a5,a4,0x1f
    6a6c:	01b7d79b          	srliw	a5,a5,0x1b
    6a70:	9f3d                	addw	a4,a4,a5
    6a72:	8b7d                	andi	a4,a4,31
    6a74:	40f707bb          	subw	a5,a4,a5
    6a78:	2781                	sext.w	a5,a5
    6a7a:	0ff7f793          	zext.b	a5,a5
    6a7e:	0307879b          	addiw	a5,a5,48
    6a82:	0ff7f793          	zext.b	a5,a5
    6a86:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    6a8a:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    6a8e:	bc840793          	addi	a5,s0,-1080
    6a92:	853e                	mv	a0,a5
    6a94:	00001097          	auipc	ra,0x1
    6a98:	bce080e7          	jalr	-1074(ra) # 7662 <unlink>
  for(int i = 0; i < nzz; i++){
    6a9c:	fdc42783          	lw	a5,-36(s0)
    6aa0:	2785                	addiw	a5,a5,1
    6aa2:	fcf42e23          	sw	a5,-36(s0)
    6aa6:	fdc42783          	lw	a5,-36(s0)
    6aaa:	873e                	mv	a4,a5
    6aac:	fd042783          	lw	a5,-48(s0)
    6ab0:	2701                	sext.w	a4,a4
    6ab2:	2781                	sext.w	a5,a5
    6ab4:	f6f74de3          	blt	a4,a5,6a2e <diskfull+0x22e>
  }

  for(int i = 0; i < fi; i++){
    6ab8:	fc042c23          	sw	zero,-40(s0)
    6abc:	a0a9                	j	6b06 <diskfull+0x306>
    char name[32];
    name[0] = 'b';
    6abe:	06200793          	li	a5,98
    6ac2:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'i';
    6ac6:	06900793          	li	a5,105
    6aca:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = 'g';
    6ace:	06700793          	li	a5,103
    6ad2:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + i;
    6ad6:	fd842783          	lw	a5,-40(s0)
    6ada:	0ff7f793          	zext.b	a5,a5
    6ade:	0307879b          	addiw	a5,a5,48
    6ae2:	0ff7f793          	zext.b	a5,a5
    6ae6:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    6aea:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    6aee:	bc840793          	addi	a5,s0,-1080
    6af2:	853e                	mv	a0,a5
    6af4:	00001097          	auipc	ra,0x1
    6af8:	b6e080e7          	jalr	-1170(ra) # 7662 <unlink>
  for(int i = 0; i < fi; i++){
    6afc:	fd842783          	lw	a5,-40(s0)
    6b00:	2785                	addiw	a5,a5,1
    6b02:	fcf42c23          	sw	a5,-40(s0)
    6b06:	fd842783          	lw	a5,-40(s0)
    6b0a:	873e                	mv	a4,a5
    6b0c:	fec42783          	lw	a5,-20(s0)
    6b10:	2701                	sext.w	a4,a4
    6b12:	2781                	sext.w	a5,a5
    6b14:	faf745e3          	blt	a4,a5,6abe <diskfull+0x2be>
  }
}
    6b18:	0001                	nop
    6b1a:	0001                	nop
    6b1c:	46813083          	ld	ra,1128(sp)
    6b20:	46013403          	ld	s0,1120(sp)
    6b24:	47010113          	addi	sp,sp,1136
    6b28:	8082                	ret

0000000000006b2a <outofinodes>:

void
outofinodes(char *s)
{
    6b2a:	715d                	addi	sp,sp,-80
    6b2c:	e486                	sd	ra,72(sp)
    6b2e:	e0a2                	sd	s0,64(sp)
    6b30:	0880                	addi	s0,sp,80
    6b32:	faa43c23          	sd	a0,-72(s0)
  int nzz = 32*32;
    6b36:	40000793          	li	a5,1024
    6b3a:	fef42223          	sw	a5,-28(s0)
  for(int i = 0; i < nzz; i++){
    6b3e:	fe042623          	sw	zero,-20(s0)
    6b42:	a06d                	j	6bec <outofinodes+0xc2>
    char name[32];
    name[0] = 'z';
    6b44:	07a00793          	li	a5,122
    6b48:	fcf40023          	sb	a5,-64(s0)
    name[1] = 'z';
    6b4c:	07a00793          	li	a5,122
    6b50:	fcf400a3          	sb	a5,-63(s0)
    name[2] = '0' + (i / 32);
    6b54:	fec42783          	lw	a5,-20(s0)
    6b58:	41f7d71b          	sraiw	a4,a5,0x1f
    6b5c:	01b7571b          	srliw	a4,a4,0x1b
    6b60:	9fb9                	addw	a5,a5,a4
    6b62:	4057d79b          	sraiw	a5,a5,0x5
    6b66:	2781                	sext.w	a5,a5
    6b68:	0ff7f793          	zext.b	a5,a5
    6b6c:	0307879b          	addiw	a5,a5,48
    6b70:	0ff7f793          	zext.b	a5,a5
    6b74:	fcf40123          	sb	a5,-62(s0)
    name[3] = '0' + (i % 32);
    6b78:	fec42783          	lw	a5,-20(s0)
    6b7c:	873e                	mv	a4,a5
    6b7e:	41f7579b          	sraiw	a5,a4,0x1f
    6b82:	01b7d79b          	srliw	a5,a5,0x1b
    6b86:	9f3d                	addw	a4,a4,a5
    6b88:	8b7d                	andi	a4,a4,31
    6b8a:	40f707bb          	subw	a5,a4,a5
    6b8e:	2781                	sext.w	a5,a5
    6b90:	0ff7f793          	zext.b	a5,a5
    6b94:	0307879b          	addiw	a5,a5,48
    6b98:	0ff7f793          	zext.b	a5,a5
    6b9c:	fcf401a3          	sb	a5,-61(s0)
    name[4] = '\0';
    6ba0:	fc040223          	sb	zero,-60(s0)
    unlink(name);
    6ba4:	fc040793          	addi	a5,s0,-64
    6ba8:	853e                	mv	a0,a5
    6baa:	00001097          	auipc	ra,0x1
    6bae:	ab8080e7          	jalr	-1352(ra) # 7662 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    6bb2:	fc040793          	addi	a5,s0,-64
    6bb6:	60200593          	li	a1,1538
    6bba:	853e                	mv	a0,a5
    6bbc:	00001097          	auipc	ra,0x1
    6bc0:	a96080e7          	jalr	-1386(ra) # 7652 <open>
    6bc4:	87aa                	mv	a5,a0
    6bc6:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    6bca:	fe042783          	lw	a5,-32(s0)
    6bce:	2781                	sext.w	a5,a5
    6bd0:	0207c863          	bltz	a5,6c00 <outofinodes+0xd6>
      // failure is eventually expected.
      break;
    }
    close(fd);
    6bd4:	fe042783          	lw	a5,-32(s0)
    6bd8:	853e                	mv	a0,a5
    6bda:	00001097          	auipc	ra,0x1
    6bde:	a60080e7          	jalr	-1440(ra) # 763a <close>
  for(int i = 0; i < nzz; i++){
    6be2:	fec42783          	lw	a5,-20(s0)
    6be6:	2785                	addiw	a5,a5,1
    6be8:	fef42623          	sw	a5,-20(s0)
    6bec:	fec42783          	lw	a5,-20(s0)
    6bf0:	873e                	mv	a4,a5
    6bf2:	fe442783          	lw	a5,-28(s0)
    6bf6:	2701                	sext.w	a4,a4
    6bf8:	2781                	sext.w	a5,a5
    6bfa:	f4f745e3          	blt	a4,a5,6b44 <outofinodes+0x1a>
    6bfe:	a011                	j	6c02 <outofinodes+0xd8>
      break;
    6c00:	0001                	nop
  }

  for(int i = 0; i < nzz; i++){
    6c02:	fe042423          	sw	zero,-24(s0)
    6c06:	a8ad                	j	6c80 <outofinodes+0x156>
    char name[32];
    name[0] = 'z';
    6c08:	07a00793          	li	a5,122
    6c0c:	fcf40023          	sb	a5,-64(s0)
    name[1] = 'z';
    6c10:	07a00793          	li	a5,122
    6c14:	fcf400a3          	sb	a5,-63(s0)
    name[2] = '0' + (i / 32);
    6c18:	fe842783          	lw	a5,-24(s0)
    6c1c:	41f7d71b          	sraiw	a4,a5,0x1f
    6c20:	01b7571b          	srliw	a4,a4,0x1b
    6c24:	9fb9                	addw	a5,a5,a4
    6c26:	4057d79b          	sraiw	a5,a5,0x5
    6c2a:	2781                	sext.w	a5,a5
    6c2c:	0ff7f793          	zext.b	a5,a5
    6c30:	0307879b          	addiw	a5,a5,48
    6c34:	0ff7f793          	zext.b	a5,a5
    6c38:	fcf40123          	sb	a5,-62(s0)
    name[3] = '0' + (i % 32);
    6c3c:	fe842783          	lw	a5,-24(s0)
    6c40:	873e                	mv	a4,a5
    6c42:	41f7579b          	sraiw	a5,a4,0x1f
    6c46:	01b7d79b          	srliw	a5,a5,0x1b
    6c4a:	9f3d                	addw	a4,a4,a5
    6c4c:	8b7d                	andi	a4,a4,31
    6c4e:	40f707bb          	subw	a5,a4,a5
    6c52:	2781                	sext.w	a5,a5
    6c54:	0ff7f793          	zext.b	a5,a5
    6c58:	0307879b          	addiw	a5,a5,48
    6c5c:	0ff7f793          	zext.b	a5,a5
    6c60:	fcf401a3          	sb	a5,-61(s0)
    name[4] = '\0';
    6c64:	fc040223          	sb	zero,-60(s0)
    unlink(name);
    6c68:	fc040793          	addi	a5,s0,-64
    6c6c:	853e                	mv	a0,a5
    6c6e:	00001097          	auipc	ra,0x1
    6c72:	9f4080e7          	jalr	-1548(ra) # 7662 <unlink>
  for(int i = 0; i < nzz; i++){
    6c76:	fe842783          	lw	a5,-24(s0)
    6c7a:	2785                	addiw	a5,a5,1
    6c7c:	fef42423          	sw	a5,-24(s0)
    6c80:	fe842783          	lw	a5,-24(s0)
    6c84:	873e                	mv	a4,a5
    6c86:	fe442783          	lw	a5,-28(s0)
    6c8a:	2701                	sext.w	a4,a4
    6c8c:	2781                	sext.w	a5,a5
    6c8e:	f6f74de3          	blt	a4,a5,6c08 <outofinodes+0xde>
  }
}
    6c92:	0001                	nop
    6c94:	0001                	nop
    6c96:	60a6                	ld	ra,72(sp)
    6c98:	6406                	ld	s0,64(sp)
    6c9a:	6161                	addi	sp,sp,80
    6c9c:	8082                	ret

0000000000006c9e <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    6c9e:	7179                	addi	sp,sp,-48
    6ca0:	f406                	sd	ra,40(sp)
    6ca2:	f022                	sd	s0,32(sp)
    6ca4:	1800                	addi	s0,sp,48
    6ca6:	fca43c23          	sd	a0,-40(s0)
    6caa:	fcb43823          	sd	a1,-48(s0)
  int pid;
  int xstatus;

  printf("test %s: ", s);
    6cae:	fd043583          	ld	a1,-48(s0)
    6cb2:	00003517          	auipc	a0,0x3
    6cb6:	3d650513          	addi	a0,a0,982 # a088 <malloc+0x2324>
    6cba:	00001097          	auipc	ra,0x1
    6cbe:	eb8080e7          	jalr	-328(ra) # 7b72 <printf>
  if((pid = fork()) < 0) {
    6cc2:	00001097          	auipc	ra,0x1
    6cc6:	948080e7          	jalr	-1720(ra) # 760a <fork>
    6cca:	87aa                	mv	a5,a0
    6ccc:	fef42623          	sw	a5,-20(s0)
    6cd0:	fec42783          	lw	a5,-20(s0)
    6cd4:	2781                	sext.w	a5,a5
    6cd6:	0007df63          	bgez	a5,6cf4 <run+0x56>
    printf("runtest: fork error\n");
    6cda:	00003517          	auipc	a0,0x3
    6cde:	3be50513          	addi	a0,a0,958 # a098 <malloc+0x2334>
    6ce2:	00001097          	auipc	ra,0x1
    6ce6:	e90080e7          	jalr	-368(ra) # 7b72 <printf>
    exit(1);
    6cea:	4505                	li	a0,1
    6cec:	00001097          	auipc	ra,0x1
    6cf0:	926080e7          	jalr	-1754(ra) # 7612 <exit>
  }
  if(pid == 0) {
    6cf4:	fec42783          	lw	a5,-20(s0)
    6cf8:	2781                	sext.w	a5,a5
    6cfa:	eb99                	bnez	a5,6d10 <run+0x72>
    f(s);
    6cfc:	fd843783          	ld	a5,-40(s0)
    6d00:	fd043503          	ld	a0,-48(s0)
    6d04:	9782                	jalr	a5
    exit(0);
    6d06:	4501                	li	a0,0
    6d08:	00001097          	auipc	ra,0x1
    6d0c:	90a080e7          	jalr	-1782(ra) # 7612 <exit>
  } else {
    wait(&xstatus);
    6d10:	fe840793          	addi	a5,s0,-24
    6d14:	853e                	mv	a0,a5
    6d16:	00001097          	auipc	ra,0x1
    6d1a:	904080e7          	jalr	-1788(ra) # 761a <wait>
    if(xstatus != 0)
    6d1e:	fe842783          	lw	a5,-24(s0)
    6d22:	cb91                	beqz	a5,6d36 <run+0x98>
      printf("FAILED\n");
    6d24:	00003517          	auipc	a0,0x3
    6d28:	38c50513          	addi	a0,a0,908 # a0b0 <malloc+0x234c>
    6d2c:	00001097          	auipc	ra,0x1
    6d30:	e46080e7          	jalr	-442(ra) # 7b72 <printf>
    6d34:	a809                	j	6d46 <run+0xa8>
    else
      printf("OK\n");
    6d36:	00003517          	auipc	a0,0x3
    6d3a:	38250513          	addi	a0,a0,898 # a0b8 <malloc+0x2354>
    6d3e:	00001097          	auipc	ra,0x1
    6d42:	e34080e7          	jalr	-460(ra) # 7b72 <printf>
    return xstatus == 0;
    6d46:	fe842783          	lw	a5,-24(s0)
    6d4a:	0017b793          	seqz	a5,a5
    6d4e:	0ff7f793          	zext.b	a5,a5
    6d52:	2781                	sext.w	a5,a5
  }
}
    6d54:	853e                	mv	a0,a5
    6d56:	70a2                	ld	ra,40(sp)
    6d58:	7402                	ld	s0,32(sp)
    6d5a:	6145                	addi	sp,sp,48
    6d5c:	8082                	ret

0000000000006d5e <runtests>:

int
runtests(struct test *tests, char *justone) {
    6d5e:	7179                	addi	sp,sp,-48
    6d60:	f406                	sd	ra,40(sp)
    6d62:	f022                	sd	s0,32(sp)
    6d64:	1800                	addi	s0,sp,48
    6d66:	fca43c23          	sd	a0,-40(s0)
    6d6a:	fcb43823          	sd	a1,-48(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6d6e:	fd843783          	ld	a5,-40(s0)
    6d72:	fef43423          	sd	a5,-24(s0)
    6d76:	a8a9                	j	6dd0 <runtests+0x72>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    6d78:	fd043783          	ld	a5,-48(s0)
    6d7c:	cf89                	beqz	a5,6d96 <runtests+0x38>
    6d7e:	fe843783          	ld	a5,-24(s0)
    6d82:	679c                	ld	a5,8(a5)
    6d84:	fd043583          	ld	a1,-48(s0)
    6d88:	853e                	mv	a0,a5
    6d8a:	00000097          	auipc	ra,0x0
    6d8e:	440080e7          	jalr	1088(ra) # 71ca <strcmp>
    6d92:	87aa                	mv	a5,a0
    6d94:	eb8d                	bnez	a5,6dc6 <runtests+0x68>
      if(!run(t->f, t->s)){
    6d96:	fe843783          	ld	a5,-24(s0)
    6d9a:	6398                	ld	a4,0(a5)
    6d9c:	fe843783          	ld	a5,-24(s0)
    6da0:	679c                	ld	a5,8(a5)
    6da2:	85be                	mv	a1,a5
    6da4:	853a                	mv	a0,a4
    6da6:	00000097          	auipc	ra,0x0
    6daa:	ef8080e7          	jalr	-264(ra) # 6c9e <run>
    6dae:	87aa                	mv	a5,a0
    6db0:	eb99                	bnez	a5,6dc6 <runtests+0x68>
        printf("SOME TESTS FAILED\n");
    6db2:	00003517          	auipc	a0,0x3
    6db6:	30e50513          	addi	a0,a0,782 # a0c0 <malloc+0x235c>
    6dba:	00001097          	auipc	ra,0x1
    6dbe:	db8080e7          	jalr	-584(ra) # 7b72 <printf>
        return 1;
    6dc2:	4785                	li	a5,1
    6dc4:	a819                	j	6dda <runtests+0x7c>
  for (struct test *t = tests; t->s != 0; t++) {
    6dc6:	fe843783          	ld	a5,-24(s0)
    6dca:	07c1                	addi	a5,a5,16
    6dcc:	fef43423          	sd	a5,-24(s0)
    6dd0:	fe843783          	ld	a5,-24(s0)
    6dd4:	679c                	ld	a5,8(a5)
    6dd6:	f3cd                	bnez	a5,6d78 <runtests+0x1a>
      }
    }
  }
  return 0;
    6dd8:	4781                	li	a5,0
}
    6dda:	853e                	mv	a0,a5
    6ddc:	70a2                	ld	ra,40(sp)
    6dde:	7402                	ld	s0,32(sp)
    6de0:	6145                	addi	sp,sp,48
    6de2:	8082                	ret

0000000000006de4 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    6de4:	7139                	addi	sp,sp,-64
    6de6:	fc06                	sd	ra,56(sp)
    6de8:	f822                	sd	s0,48(sp)
    6dea:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    6dec:	fd040793          	addi	a5,s0,-48
    6df0:	853e                	mv	a0,a5
    6df2:	00001097          	auipc	ra,0x1
    6df6:	830080e7          	jalr	-2000(ra) # 7622 <pipe>
    6dfa:	87aa                	mv	a5,a0
    6dfc:	0007df63          	bgez	a5,6e1a <countfree+0x36>
    printf("pipe() failed in countfree()\n");
    6e00:	00003517          	auipc	a0,0x3
    6e04:	2d850513          	addi	a0,a0,728 # a0d8 <malloc+0x2374>
    6e08:	00001097          	auipc	ra,0x1
    6e0c:	d6a080e7          	jalr	-662(ra) # 7b72 <printf>
    exit(1);
    6e10:	4505                	li	a0,1
    6e12:	00001097          	auipc	ra,0x1
    6e16:	800080e7          	jalr	-2048(ra) # 7612 <exit>
  }

  int pid = fork();
    6e1a:	00000097          	auipc	ra,0x0
    6e1e:	7f0080e7          	jalr	2032(ra) # 760a <fork>
    6e22:	87aa                	mv	a5,a0
    6e24:	fef42423          	sw	a5,-24(s0)

  if(pid < 0){
    6e28:	fe842783          	lw	a5,-24(s0)
    6e2c:	2781                	sext.w	a5,a5
    6e2e:	0007df63          	bgez	a5,6e4c <countfree+0x68>
    printf("fork failed in countfree()\n");
    6e32:	00003517          	auipc	a0,0x3
    6e36:	2c650513          	addi	a0,a0,710 # a0f8 <malloc+0x2394>
    6e3a:	00001097          	auipc	ra,0x1
    6e3e:	d38080e7          	jalr	-712(ra) # 7b72 <printf>
    exit(1);
    6e42:	4505                	li	a0,1
    6e44:	00000097          	auipc	ra,0x0
    6e48:	7ce080e7          	jalr	1998(ra) # 7612 <exit>
  }

  if(pid == 0){
    6e4c:	fe842783          	lw	a5,-24(s0)
    6e50:	2781                	sext.w	a5,a5
    6e52:	e3d1                	bnez	a5,6ed6 <countfree+0xf2>
    close(fds[0]);
    6e54:	fd042783          	lw	a5,-48(s0)
    6e58:	853e                	mv	a0,a5
    6e5a:	00000097          	auipc	ra,0x0
    6e5e:	7e0080e7          	jalr	2016(ra) # 763a <close>

    while(1){
      uint64 a = (uint64) sbrk(4096);
    6e62:	6505                	lui	a0,0x1
    6e64:	00001097          	auipc	ra,0x1
    6e68:	836080e7          	jalr	-1994(ra) # 769a <sbrk>
    6e6c:	87aa                	mv	a5,a0
    6e6e:	fcf43c23          	sd	a5,-40(s0)
      if(a == 0xffffffffffffffff){
    6e72:	fd843703          	ld	a4,-40(s0)
    6e76:	57fd                	li	a5,-1
    6e78:	04f70963          	beq	a4,a5,6eca <countfree+0xe6>
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    6e7c:	fd843703          	ld	a4,-40(s0)
    6e80:	6785                	lui	a5,0x1
    6e82:	17fd                	addi	a5,a5,-1 # fff <truncate3+0x1b1>
    6e84:	97ba                	add	a5,a5,a4
    6e86:	873e                	mv	a4,a5
    6e88:	4785                	li	a5,1
    6e8a:	00f70023          	sb	a5,0(a4)

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    6e8e:	fd442783          	lw	a5,-44(s0)
    6e92:	4605                	li	a2,1
    6e94:	00001597          	auipc	a1,0x1
    6e98:	11c58593          	addi	a1,a1,284 # 7fb0 <malloc+0x24c>
    6e9c:	853e                	mv	a0,a5
    6e9e:	00000097          	auipc	ra,0x0
    6ea2:	794080e7          	jalr	1940(ra) # 7632 <write>
    6ea6:	87aa                	mv	a5,a0
    6ea8:	873e                	mv	a4,a5
    6eaa:	4785                	li	a5,1
    6eac:	faf70be3          	beq	a4,a5,6e62 <countfree+0x7e>
        printf("write() failed in countfree()\n");
    6eb0:	00003517          	auipc	a0,0x3
    6eb4:	26850513          	addi	a0,a0,616 # a118 <malloc+0x23b4>
    6eb8:	00001097          	auipc	ra,0x1
    6ebc:	cba080e7          	jalr	-838(ra) # 7b72 <printf>
        exit(1);
    6ec0:	4505                	li	a0,1
    6ec2:	00000097          	auipc	ra,0x0
    6ec6:	750080e7          	jalr	1872(ra) # 7612 <exit>
        break;
    6eca:	0001                	nop
      }
    }

    exit(0);
    6ecc:	4501                	li	a0,0
    6ece:	00000097          	auipc	ra,0x0
    6ed2:	744080e7          	jalr	1860(ra) # 7612 <exit>
  }

  close(fds[1]);
    6ed6:	fd442783          	lw	a5,-44(s0)
    6eda:	853e                	mv	a0,a5
    6edc:	00000097          	auipc	ra,0x0
    6ee0:	75e080e7          	jalr	1886(ra) # 763a <close>

  int n = 0;
    6ee4:	fe042623          	sw	zero,-20(s0)
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    6ee8:	fd042783          	lw	a5,-48(s0)
    6eec:	fcf40713          	addi	a4,s0,-49
    6ef0:	4605                	li	a2,1
    6ef2:	85ba                	mv	a1,a4
    6ef4:	853e                	mv	a0,a5
    6ef6:	00000097          	auipc	ra,0x0
    6efa:	734080e7          	jalr	1844(ra) # 762a <read>
    6efe:	87aa                	mv	a5,a0
    6f00:	fef42223          	sw	a5,-28(s0)
    if(cc < 0){
    6f04:	fe442783          	lw	a5,-28(s0)
    6f08:	2781                	sext.w	a5,a5
    6f0a:	0007df63          	bgez	a5,6f28 <countfree+0x144>
      printf("read() failed in countfree()\n");
    6f0e:	00003517          	auipc	a0,0x3
    6f12:	22a50513          	addi	a0,a0,554 # a138 <malloc+0x23d4>
    6f16:	00001097          	auipc	ra,0x1
    6f1a:	c5c080e7          	jalr	-932(ra) # 7b72 <printf>
      exit(1);
    6f1e:	4505                	li	a0,1
    6f20:	00000097          	auipc	ra,0x0
    6f24:	6f2080e7          	jalr	1778(ra) # 7612 <exit>
    }
    if(cc == 0)
    6f28:	fe442783          	lw	a5,-28(s0)
    6f2c:	2781                	sext.w	a5,a5
    6f2e:	e385                	bnez	a5,6f4e <countfree+0x16a>
      break;
    n += 1;
  }

  close(fds[0]);
    6f30:	fd042783          	lw	a5,-48(s0)
    6f34:	853e                	mv	a0,a5
    6f36:	00000097          	auipc	ra,0x0
    6f3a:	704080e7          	jalr	1796(ra) # 763a <close>
  wait((int*)0);
    6f3e:	4501                	li	a0,0
    6f40:	00000097          	auipc	ra,0x0
    6f44:	6da080e7          	jalr	1754(ra) # 761a <wait>

  return n;
    6f48:	fec42783          	lw	a5,-20(s0)
    6f4c:	a039                	j	6f5a <countfree+0x176>
    n += 1;
    6f4e:	fec42783          	lw	a5,-20(s0)
    6f52:	2785                	addiw	a5,a5,1
    6f54:	fef42623          	sw	a5,-20(s0)
  while(1){
    6f58:	bf41                	j	6ee8 <countfree+0x104>
}
    6f5a:	853e                	mv	a0,a5
    6f5c:	70e2                	ld	ra,56(sp)
    6f5e:	7442                	ld	s0,48(sp)
    6f60:	6121                	addi	sp,sp,64
    6f62:	8082                	ret

0000000000006f64 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    6f64:	1101                	addi	sp,sp,-32
    6f66:	ec06                	sd	ra,24(sp)
    6f68:	e822                	sd	s0,16(sp)
    6f6a:	1000                	addi	s0,sp,32
    6f6c:	87aa                	mv	a5,a0
    6f6e:	872e                	mv	a4,a1
    6f70:	fec43023          	sd	a2,-32(s0)
    6f74:	fef42623          	sw	a5,-20(s0)
    6f78:	87ba                	mv	a5,a4
    6f7a:	fef42423          	sw	a5,-24(s0)
  do {
    printf("usertests starting\n");
    6f7e:	00003517          	auipc	a0,0x3
    6f82:	1da50513          	addi	a0,a0,474 # a158 <malloc+0x23f4>
    6f86:	00001097          	auipc	ra,0x1
    6f8a:	bec080e7          	jalr	-1044(ra) # 7b72 <printf>
    if (runtests(quicktests, justone)) {
    6f8e:	fe043583          	ld	a1,-32(s0)
    6f92:	00005517          	auipc	a0,0x5
    6f96:	f0e50513          	addi	a0,a0,-242 # bea0 <quicktests>
    6f9a:	00000097          	auipc	ra,0x0
    6f9e:	dc4080e7          	jalr	-572(ra) # 6d5e <runtests>
    6fa2:	87aa                	mv	a5,a0
    6fa4:	cb91                	beqz	a5,6fb8 <drivetests+0x54>
      if(continuous != 2) {
    6fa6:	fe842783          	lw	a5,-24(s0)
    6faa:	0007871b          	sext.w	a4,a5
    6fae:	4789                	li	a5,2
    6fb0:	00f70463          	beq	a4,a5,6fb8 <drivetests+0x54>
        return 1;
    6fb4:	4785                	li	a5,1
    6fb6:	a891                	j	700a <drivetests+0xa6>
      }
    }
    if(!quick) {
    6fb8:	fec42783          	lw	a5,-20(s0)
    6fbc:	2781                	sext.w	a5,a5
    6fbe:	e3a9                	bnez	a5,7000 <drivetests+0x9c>
      if (justone == 0)
    6fc0:	fe043783          	ld	a5,-32(s0)
    6fc4:	eb89                	bnez	a5,6fd6 <drivetests+0x72>
        printf("usertests slow tests starting\n");
    6fc6:	00003517          	auipc	a0,0x3
    6fca:	1aa50513          	addi	a0,a0,426 # a170 <malloc+0x240c>
    6fce:	00001097          	auipc	ra,0x1
    6fd2:	ba4080e7          	jalr	-1116(ra) # 7b72 <printf>
      if (runtests(slowtests, justone)) {
    6fd6:	fe043583          	ld	a1,-32(s0)
    6fda:	00005517          	auipc	a0,0x5
    6fde:	27650513          	addi	a0,a0,630 # c250 <slowtests>
    6fe2:	00000097          	auipc	ra,0x0
    6fe6:	d7c080e7          	jalr	-644(ra) # 6d5e <runtests>
    6fea:	87aa                	mv	a5,a0
    6fec:	cb91                	beqz	a5,7000 <drivetests+0x9c>
        if(continuous != 2) {
    6fee:	fe842783          	lw	a5,-24(s0)
    6ff2:	0007871b          	sext.w	a4,a5
    6ff6:	4789                	li	a5,2
    6ff8:	00f70463          	beq	a4,a5,7000 <drivetests+0x9c>
          return 1;
    6ffc:	4785                	li	a5,1
    6ffe:	a031                	j	700a <drivetests+0xa6>
        }
      }
    }
  } while(continuous);
    7000:	fe842783          	lw	a5,-24(s0)
    7004:	2781                	sext.w	a5,a5
    7006:	ffa5                	bnez	a5,6f7e <drivetests+0x1a>
  return 0;
    7008:	4781                	li	a5,0
}
    700a:	853e                	mv	a0,a5
    700c:	60e2                	ld	ra,24(sp)
    700e:	6442                	ld	s0,16(sp)
    7010:	6105                	addi	sp,sp,32
    7012:	8082                	ret

0000000000007014 <main>:

int
main(int argc, char *argv[])
{
    7014:	7179                	addi	sp,sp,-48
    7016:	f406                	sd	ra,40(sp)
    7018:	f022                	sd	s0,32(sp)
    701a:	1800                	addi	s0,sp,48
    701c:	87aa                	mv	a5,a0
    701e:	fcb43823          	sd	a1,-48(s0)
    7022:	fcf42e23          	sw	a5,-36(s0)
  int continuous = 0;
    7026:	fe042623          	sw	zero,-20(s0)
  int quick = 0;
    702a:	fe042423          	sw	zero,-24(s0)
  char *justone = 0;
    702e:	fe043023          	sd	zero,-32(s0)

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    7032:	fdc42783          	lw	a5,-36(s0)
    7036:	0007871b          	sext.w	a4,a5
    703a:	4789                	li	a5,2
    703c:	02f71563          	bne	a4,a5,7066 <main+0x52>
    7040:	fd043783          	ld	a5,-48(s0)
    7044:	07a1                	addi	a5,a5,8
    7046:	639c                	ld	a5,0(a5)
    7048:	00003597          	auipc	a1,0x3
    704c:	14858593          	addi	a1,a1,328 # a190 <malloc+0x242c>
    7050:	853e                	mv	a0,a5
    7052:	00000097          	auipc	ra,0x0
    7056:	178080e7          	jalr	376(ra) # 71ca <strcmp>
    705a:	87aa                	mv	a5,a0
    705c:	e789                	bnez	a5,7066 <main+0x52>
    quick = 1;
    705e:	4785                	li	a5,1
    7060:	fef42423          	sw	a5,-24(s0)
    7064:	a0c9                	j	7126 <main+0x112>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    7066:	fdc42783          	lw	a5,-36(s0)
    706a:	0007871b          	sext.w	a4,a5
    706e:	4789                	li	a5,2
    7070:	02f71563          	bne	a4,a5,709a <main+0x86>
    7074:	fd043783          	ld	a5,-48(s0)
    7078:	07a1                	addi	a5,a5,8
    707a:	639c                	ld	a5,0(a5)
    707c:	00003597          	auipc	a1,0x3
    7080:	11c58593          	addi	a1,a1,284 # a198 <malloc+0x2434>
    7084:	853e                	mv	a0,a5
    7086:	00000097          	auipc	ra,0x0
    708a:	144080e7          	jalr	324(ra) # 71ca <strcmp>
    708e:	87aa                	mv	a5,a0
    7090:	e789                	bnez	a5,709a <main+0x86>
    continuous = 1;
    7092:	4785                	li	a5,1
    7094:	fef42623          	sw	a5,-20(s0)
    7098:	a079                	j	7126 <main+0x112>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    709a:	fdc42783          	lw	a5,-36(s0)
    709e:	0007871b          	sext.w	a4,a5
    70a2:	4789                	li	a5,2
    70a4:	02f71563          	bne	a4,a5,70ce <main+0xba>
    70a8:	fd043783          	ld	a5,-48(s0)
    70ac:	07a1                	addi	a5,a5,8
    70ae:	639c                	ld	a5,0(a5)
    70b0:	00003597          	auipc	a1,0x3
    70b4:	0f058593          	addi	a1,a1,240 # a1a0 <malloc+0x243c>
    70b8:	853e                	mv	a0,a5
    70ba:	00000097          	auipc	ra,0x0
    70be:	110080e7          	jalr	272(ra) # 71ca <strcmp>
    70c2:	87aa                	mv	a5,a0
    70c4:	e789                	bnez	a5,70ce <main+0xba>
    continuous = 2;
    70c6:	4789                	li	a5,2
    70c8:	fef42623          	sw	a5,-20(s0)
    70cc:	a8a9                	j	7126 <main+0x112>
  } else if(argc == 2 && argv[1][0] != '-'){
    70ce:	fdc42783          	lw	a5,-36(s0)
    70d2:	0007871b          	sext.w	a4,a5
    70d6:	4789                	li	a5,2
    70d8:	02f71363          	bne	a4,a5,70fe <main+0xea>
    70dc:	fd043783          	ld	a5,-48(s0)
    70e0:	07a1                	addi	a5,a5,8
    70e2:	639c                	ld	a5,0(a5)
    70e4:	0007c783          	lbu	a5,0(a5)
    70e8:	873e                	mv	a4,a5
    70ea:	02d00793          	li	a5,45
    70ee:	00f70863          	beq	a4,a5,70fe <main+0xea>
    justone = argv[1];
    70f2:	fd043783          	ld	a5,-48(s0)
    70f6:	679c                	ld	a5,8(a5)
    70f8:	fef43023          	sd	a5,-32(s0)
    70fc:	a02d                	j	7126 <main+0x112>
  } else if(argc > 1){
    70fe:	fdc42783          	lw	a5,-36(s0)
    7102:	0007871b          	sext.w	a4,a5
    7106:	4785                	li	a5,1
    7108:	00e7df63          	bge	a5,a4,7126 <main+0x112>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    710c:	00003517          	auipc	a0,0x3
    7110:	09c50513          	addi	a0,a0,156 # a1a8 <malloc+0x2444>
    7114:	00001097          	auipc	ra,0x1
    7118:	a5e080e7          	jalr	-1442(ra) # 7b72 <printf>
    exit(1);
    711c:	4505                	li	a0,1
    711e:	00000097          	auipc	ra,0x0
    7122:	4f4080e7          	jalr	1268(ra) # 7612 <exit>
  }
  if (drivetests(quick, continuous, justone)) {
    7126:	fec42703          	lw	a4,-20(s0)
    712a:	fe842783          	lw	a5,-24(s0)
    712e:	fe043603          	ld	a2,-32(s0)
    7132:	85ba                	mv	a1,a4
    7134:	853e                	mv	a0,a5
    7136:	00000097          	auipc	ra,0x0
    713a:	e2e080e7          	jalr	-466(ra) # 6f64 <drivetests>
    713e:	87aa                	mv	a5,a0
    7140:	c791                	beqz	a5,714c <main+0x138>
    exit(1);
    7142:	4505                	li	a0,1
    7144:	00000097          	auipc	ra,0x0
    7148:	4ce080e7          	jalr	1230(ra) # 7612 <exit>
  }
  printf("ALL TESTS PASSED\n");
    714c:	00003517          	auipc	a0,0x3
    7150:	08c50513          	addi	a0,a0,140 # a1d8 <malloc+0x2474>
    7154:	00001097          	auipc	ra,0x1
    7158:	a1e080e7          	jalr	-1506(ra) # 7b72 <printf>
  exit(0);
    715c:	4501                	li	a0,0
    715e:	00000097          	auipc	ra,0x0
    7162:	4b4080e7          	jalr	1204(ra) # 7612 <exit>

0000000000007166 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    7166:	1141                	addi	sp,sp,-16
    7168:	e406                	sd	ra,8(sp)
    716a:	e022                	sd	s0,0(sp)
    716c:	0800                	addi	s0,sp,16
  extern int main();
  main();
    716e:	00000097          	auipc	ra,0x0
    7172:	ea6080e7          	jalr	-346(ra) # 7014 <main>
  exit(0);
    7176:	4501                	li	a0,0
    7178:	00000097          	auipc	ra,0x0
    717c:	49a080e7          	jalr	1178(ra) # 7612 <exit>

0000000000007180 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    7180:	7179                	addi	sp,sp,-48
    7182:	f422                	sd	s0,40(sp)
    7184:	1800                	addi	s0,sp,48
    7186:	fca43c23          	sd	a0,-40(s0)
    718a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
    718e:	fd843783          	ld	a5,-40(s0)
    7192:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
    7196:	0001                	nop
    7198:	fd043703          	ld	a4,-48(s0)
    719c:	00170793          	addi	a5,a4,1
    71a0:	fcf43823          	sd	a5,-48(s0)
    71a4:	fd843783          	ld	a5,-40(s0)
    71a8:	00178693          	addi	a3,a5,1
    71ac:	fcd43c23          	sd	a3,-40(s0)
    71b0:	00074703          	lbu	a4,0(a4)
    71b4:	00e78023          	sb	a4,0(a5)
    71b8:	0007c783          	lbu	a5,0(a5)
    71bc:	fff1                	bnez	a5,7198 <strcpy+0x18>
    ;
  return os;
    71be:	fe843783          	ld	a5,-24(s0)
}
    71c2:	853e                	mv	a0,a5
    71c4:	7422                	ld	s0,40(sp)
    71c6:	6145                	addi	sp,sp,48
    71c8:	8082                	ret

00000000000071ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
    71ca:	1101                	addi	sp,sp,-32
    71cc:	ec22                	sd	s0,24(sp)
    71ce:	1000                	addi	s0,sp,32
    71d0:	fea43423          	sd	a0,-24(s0)
    71d4:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
    71d8:	a819                	j	71ee <strcmp+0x24>
    p++, q++;
    71da:	fe843783          	ld	a5,-24(s0)
    71de:	0785                	addi	a5,a5,1
    71e0:	fef43423          	sd	a5,-24(s0)
    71e4:	fe043783          	ld	a5,-32(s0)
    71e8:	0785                	addi	a5,a5,1
    71ea:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
    71ee:	fe843783          	ld	a5,-24(s0)
    71f2:	0007c783          	lbu	a5,0(a5)
    71f6:	cb99                	beqz	a5,720c <strcmp+0x42>
    71f8:	fe843783          	ld	a5,-24(s0)
    71fc:	0007c703          	lbu	a4,0(a5)
    7200:	fe043783          	ld	a5,-32(s0)
    7204:	0007c783          	lbu	a5,0(a5)
    7208:	fcf709e3          	beq	a4,a5,71da <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
    720c:	fe843783          	ld	a5,-24(s0)
    7210:	0007c783          	lbu	a5,0(a5)
    7214:	0007871b          	sext.w	a4,a5
    7218:	fe043783          	ld	a5,-32(s0)
    721c:	0007c783          	lbu	a5,0(a5)
    7220:	2781                	sext.w	a5,a5
    7222:	40f707bb          	subw	a5,a4,a5
    7226:	2781                	sext.w	a5,a5
}
    7228:	853e                	mv	a0,a5
    722a:	6462                	ld	s0,24(sp)
    722c:	6105                	addi	sp,sp,32
    722e:	8082                	ret

0000000000007230 <strlen>:

uint
strlen(const char *s)
{
    7230:	7179                	addi	sp,sp,-48
    7232:	f422                	sd	s0,40(sp)
    7234:	1800                	addi	s0,sp,48
    7236:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    723a:	fe042623          	sw	zero,-20(s0)
    723e:	a031                	j	724a <strlen+0x1a>
    7240:	fec42783          	lw	a5,-20(s0)
    7244:	2785                	addiw	a5,a5,1
    7246:	fef42623          	sw	a5,-20(s0)
    724a:	fec42783          	lw	a5,-20(s0)
    724e:	fd843703          	ld	a4,-40(s0)
    7252:	97ba                	add	a5,a5,a4
    7254:	0007c783          	lbu	a5,0(a5)
    7258:	f7e5                	bnez	a5,7240 <strlen+0x10>
    ;
  return n;
    725a:	fec42783          	lw	a5,-20(s0)
}
    725e:	853e                	mv	a0,a5
    7260:	7422                	ld	s0,40(sp)
    7262:	6145                	addi	sp,sp,48
    7264:	8082                	ret

0000000000007266 <memset>:

void*
memset(void *dst, int c, uint n)
{
    7266:	7179                	addi	sp,sp,-48
    7268:	f422                	sd	s0,40(sp)
    726a:	1800                	addi	s0,sp,48
    726c:	fca43c23          	sd	a0,-40(s0)
    7270:	87ae                	mv	a5,a1
    7272:	8732                	mv	a4,a2
    7274:	fcf42a23          	sw	a5,-44(s0)
    7278:	87ba                	mv	a5,a4
    727a:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    727e:	fd843783          	ld	a5,-40(s0)
    7282:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    7286:	fe042623          	sw	zero,-20(s0)
    728a:	a00d                	j	72ac <memset+0x46>
    cdst[i] = c;
    728c:	fec42783          	lw	a5,-20(s0)
    7290:	fe043703          	ld	a4,-32(s0)
    7294:	97ba                	add	a5,a5,a4
    7296:	fd442703          	lw	a4,-44(s0)
    729a:	0ff77713          	zext.b	a4,a4
    729e:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    72a2:	fec42783          	lw	a5,-20(s0)
    72a6:	2785                	addiw	a5,a5,1
    72a8:	fef42623          	sw	a5,-20(s0)
    72ac:	fec42703          	lw	a4,-20(s0)
    72b0:	fd042783          	lw	a5,-48(s0)
    72b4:	2781                	sext.w	a5,a5
    72b6:	fcf76be3          	bltu	a4,a5,728c <memset+0x26>
  }
  return dst;
    72ba:	fd843783          	ld	a5,-40(s0)
}
    72be:	853e                	mv	a0,a5
    72c0:	7422                	ld	s0,40(sp)
    72c2:	6145                	addi	sp,sp,48
    72c4:	8082                	ret

00000000000072c6 <strchr>:

char*
strchr(const char *s, char c)
{
    72c6:	1101                	addi	sp,sp,-32
    72c8:	ec22                	sd	s0,24(sp)
    72ca:	1000                	addi	s0,sp,32
    72cc:	fea43423          	sd	a0,-24(s0)
    72d0:	87ae                	mv	a5,a1
    72d2:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    72d6:	a01d                	j	72fc <strchr+0x36>
    if(*s == c)
    72d8:	fe843783          	ld	a5,-24(s0)
    72dc:	0007c703          	lbu	a4,0(a5)
    72e0:	fe744783          	lbu	a5,-25(s0)
    72e4:	0ff7f793          	zext.b	a5,a5
    72e8:	00e79563          	bne	a5,a4,72f2 <strchr+0x2c>
      return (char*)s;
    72ec:	fe843783          	ld	a5,-24(s0)
    72f0:	a821                	j	7308 <strchr+0x42>
  for(; *s; s++)
    72f2:	fe843783          	ld	a5,-24(s0)
    72f6:	0785                	addi	a5,a5,1
    72f8:	fef43423          	sd	a5,-24(s0)
    72fc:	fe843783          	ld	a5,-24(s0)
    7300:	0007c783          	lbu	a5,0(a5)
    7304:	fbf1                	bnez	a5,72d8 <strchr+0x12>
  return 0;
    7306:	4781                	li	a5,0
}
    7308:	853e                	mv	a0,a5
    730a:	6462                	ld	s0,24(sp)
    730c:	6105                	addi	sp,sp,32
    730e:	8082                	ret

0000000000007310 <gets>:

char*
gets(char *buf, int max)
{
    7310:	7179                	addi	sp,sp,-48
    7312:	f406                	sd	ra,40(sp)
    7314:	f022                	sd	s0,32(sp)
    7316:	1800                	addi	s0,sp,48
    7318:	fca43c23          	sd	a0,-40(s0)
    731c:	87ae                	mv	a5,a1
    731e:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    7322:	fe042623          	sw	zero,-20(s0)
    7326:	a8a1                	j	737e <gets+0x6e>
    cc = read(0, &c, 1);
    7328:	fe740793          	addi	a5,s0,-25
    732c:	4605                	li	a2,1
    732e:	85be                	mv	a1,a5
    7330:	4501                	li	a0,0
    7332:	00000097          	auipc	ra,0x0
    7336:	2f8080e7          	jalr	760(ra) # 762a <read>
    733a:	87aa                	mv	a5,a0
    733c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    7340:	fe842783          	lw	a5,-24(s0)
    7344:	2781                	sext.w	a5,a5
    7346:	04f05763          	blez	a5,7394 <gets+0x84>
      break;
    buf[i++] = c;
    734a:	fec42783          	lw	a5,-20(s0)
    734e:	0017871b          	addiw	a4,a5,1
    7352:	fee42623          	sw	a4,-20(s0)
    7356:	873e                	mv	a4,a5
    7358:	fd843783          	ld	a5,-40(s0)
    735c:	97ba                	add	a5,a5,a4
    735e:	fe744703          	lbu	a4,-25(s0)
    7362:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    7366:	fe744783          	lbu	a5,-25(s0)
    736a:	873e                	mv	a4,a5
    736c:	47a9                	li	a5,10
    736e:	02f70463          	beq	a4,a5,7396 <gets+0x86>
    7372:	fe744783          	lbu	a5,-25(s0)
    7376:	873e                	mv	a4,a5
    7378:	47b5                	li	a5,13
    737a:	00f70e63          	beq	a4,a5,7396 <gets+0x86>
  for(i=0; i+1 < max; ){
    737e:	fec42783          	lw	a5,-20(s0)
    7382:	2785                	addiw	a5,a5,1
    7384:	0007871b          	sext.w	a4,a5
    7388:	fd442783          	lw	a5,-44(s0)
    738c:	2781                	sext.w	a5,a5
    738e:	f8f74de3          	blt	a4,a5,7328 <gets+0x18>
    7392:	a011                	j	7396 <gets+0x86>
      break;
    7394:	0001                	nop
      break;
  }
  buf[i] = '\0';
    7396:	fec42783          	lw	a5,-20(s0)
    739a:	fd843703          	ld	a4,-40(s0)
    739e:	97ba                	add	a5,a5,a4
    73a0:	00078023          	sb	zero,0(a5)
  return buf;
    73a4:	fd843783          	ld	a5,-40(s0)
}
    73a8:	853e                	mv	a0,a5
    73aa:	70a2                	ld	ra,40(sp)
    73ac:	7402                	ld	s0,32(sp)
    73ae:	6145                	addi	sp,sp,48
    73b0:	8082                	ret

00000000000073b2 <stat>:

int
stat(const char *n, struct stat *st)
{
    73b2:	7179                	addi	sp,sp,-48
    73b4:	f406                	sd	ra,40(sp)
    73b6:	f022                	sd	s0,32(sp)
    73b8:	1800                	addi	s0,sp,48
    73ba:	fca43c23          	sd	a0,-40(s0)
    73be:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    73c2:	4581                	li	a1,0
    73c4:	fd843503          	ld	a0,-40(s0)
    73c8:	00000097          	auipc	ra,0x0
    73cc:	28a080e7          	jalr	650(ra) # 7652 <open>
    73d0:	87aa                	mv	a5,a0
    73d2:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    73d6:	fec42783          	lw	a5,-20(s0)
    73da:	2781                	sext.w	a5,a5
    73dc:	0007d463          	bgez	a5,73e4 <stat+0x32>
    return -1;
    73e0:	57fd                	li	a5,-1
    73e2:	a035                	j	740e <stat+0x5c>
  r = fstat(fd, st);
    73e4:	fec42783          	lw	a5,-20(s0)
    73e8:	fd043583          	ld	a1,-48(s0)
    73ec:	853e                	mv	a0,a5
    73ee:	00000097          	auipc	ra,0x0
    73f2:	27c080e7          	jalr	636(ra) # 766a <fstat>
    73f6:	87aa                	mv	a5,a0
    73f8:	fef42423          	sw	a5,-24(s0)
  close(fd);
    73fc:	fec42783          	lw	a5,-20(s0)
    7400:	853e                	mv	a0,a5
    7402:	00000097          	auipc	ra,0x0
    7406:	238080e7          	jalr	568(ra) # 763a <close>
  return r;
    740a:	fe842783          	lw	a5,-24(s0)
}
    740e:	853e                	mv	a0,a5
    7410:	70a2                	ld	ra,40(sp)
    7412:	7402                	ld	s0,32(sp)
    7414:	6145                	addi	sp,sp,48
    7416:	8082                	ret

0000000000007418 <atoi>:

int
atoi(const char *s)
{
    7418:	7179                	addi	sp,sp,-48
    741a:	f422                	sd	s0,40(sp)
    741c:	1800                	addi	s0,sp,48
    741e:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    7422:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    7426:	a81d                	j	745c <atoi+0x44>
    n = n*10 + *s++ - '0';
    7428:	fec42783          	lw	a5,-20(s0)
    742c:	873e                	mv	a4,a5
    742e:	87ba                	mv	a5,a4
    7430:	0027979b          	slliw	a5,a5,0x2
    7434:	9fb9                	addw	a5,a5,a4
    7436:	0017979b          	slliw	a5,a5,0x1
    743a:	0007871b          	sext.w	a4,a5
    743e:	fd843783          	ld	a5,-40(s0)
    7442:	00178693          	addi	a3,a5,1
    7446:	fcd43c23          	sd	a3,-40(s0)
    744a:	0007c783          	lbu	a5,0(a5)
    744e:	2781                	sext.w	a5,a5
    7450:	9fb9                	addw	a5,a5,a4
    7452:	2781                	sext.w	a5,a5
    7454:	fd07879b          	addiw	a5,a5,-48
    7458:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    745c:	fd843783          	ld	a5,-40(s0)
    7460:	0007c783          	lbu	a5,0(a5)
    7464:	873e                	mv	a4,a5
    7466:	02f00793          	li	a5,47
    746a:	00e7fb63          	bgeu	a5,a4,7480 <atoi+0x68>
    746e:	fd843783          	ld	a5,-40(s0)
    7472:	0007c783          	lbu	a5,0(a5)
    7476:	873e                	mv	a4,a5
    7478:	03900793          	li	a5,57
    747c:	fae7f6e3          	bgeu	a5,a4,7428 <atoi+0x10>
  return n;
    7480:	fec42783          	lw	a5,-20(s0)
}
    7484:	853e                	mv	a0,a5
    7486:	7422                	ld	s0,40(sp)
    7488:	6145                	addi	sp,sp,48
    748a:	8082                	ret

000000000000748c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    748c:	7139                	addi	sp,sp,-64
    748e:	fc22                	sd	s0,56(sp)
    7490:	0080                	addi	s0,sp,64
    7492:	fca43c23          	sd	a0,-40(s0)
    7496:	fcb43823          	sd	a1,-48(s0)
    749a:	87b2                	mv	a5,a2
    749c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    74a0:	fd843783          	ld	a5,-40(s0)
    74a4:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    74a8:	fd043783          	ld	a5,-48(s0)
    74ac:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    74b0:	fe043703          	ld	a4,-32(s0)
    74b4:	fe843783          	ld	a5,-24(s0)
    74b8:	02e7fc63          	bgeu	a5,a4,74f0 <memmove+0x64>
    while(n-- > 0)
    74bc:	a00d                	j	74de <memmove+0x52>
      *dst++ = *src++;
    74be:	fe043703          	ld	a4,-32(s0)
    74c2:	00170793          	addi	a5,a4,1
    74c6:	fef43023          	sd	a5,-32(s0)
    74ca:	fe843783          	ld	a5,-24(s0)
    74ce:	00178693          	addi	a3,a5,1
    74d2:	fed43423          	sd	a3,-24(s0)
    74d6:	00074703          	lbu	a4,0(a4)
    74da:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    74de:	fcc42783          	lw	a5,-52(s0)
    74e2:	fff7871b          	addiw	a4,a5,-1
    74e6:	fce42623          	sw	a4,-52(s0)
    74ea:	fcf04ae3          	bgtz	a5,74be <memmove+0x32>
    74ee:	a891                	j	7542 <memmove+0xb6>
  } else {
    dst += n;
    74f0:	fcc42783          	lw	a5,-52(s0)
    74f4:	fe843703          	ld	a4,-24(s0)
    74f8:	97ba                	add	a5,a5,a4
    74fa:	fef43423          	sd	a5,-24(s0)
    src += n;
    74fe:	fcc42783          	lw	a5,-52(s0)
    7502:	fe043703          	ld	a4,-32(s0)
    7506:	97ba                	add	a5,a5,a4
    7508:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    750c:	a01d                	j	7532 <memmove+0xa6>
      *--dst = *--src;
    750e:	fe043783          	ld	a5,-32(s0)
    7512:	17fd                	addi	a5,a5,-1
    7514:	fef43023          	sd	a5,-32(s0)
    7518:	fe843783          	ld	a5,-24(s0)
    751c:	17fd                	addi	a5,a5,-1
    751e:	fef43423          	sd	a5,-24(s0)
    7522:	fe043783          	ld	a5,-32(s0)
    7526:	0007c703          	lbu	a4,0(a5)
    752a:	fe843783          	ld	a5,-24(s0)
    752e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    7532:	fcc42783          	lw	a5,-52(s0)
    7536:	fff7871b          	addiw	a4,a5,-1
    753a:	fce42623          	sw	a4,-52(s0)
    753e:	fcf048e3          	bgtz	a5,750e <memmove+0x82>
  }
  return vdst;
    7542:	fd843783          	ld	a5,-40(s0)
}
    7546:	853e                	mv	a0,a5
    7548:	7462                	ld	s0,56(sp)
    754a:	6121                	addi	sp,sp,64
    754c:	8082                	ret

000000000000754e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    754e:	7139                	addi	sp,sp,-64
    7550:	fc22                	sd	s0,56(sp)
    7552:	0080                	addi	s0,sp,64
    7554:	fca43c23          	sd	a0,-40(s0)
    7558:	fcb43823          	sd	a1,-48(s0)
    755c:	87b2                	mv	a5,a2
    755e:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    7562:	fd843783          	ld	a5,-40(s0)
    7566:	fef43423          	sd	a5,-24(s0)
    756a:	fd043783          	ld	a5,-48(s0)
    756e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    7572:	a0a1                	j	75ba <memcmp+0x6c>
    if (*p1 != *p2) {
    7574:	fe843783          	ld	a5,-24(s0)
    7578:	0007c703          	lbu	a4,0(a5)
    757c:	fe043783          	ld	a5,-32(s0)
    7580:	0007c783          	lbu	a5,0(a5)
    7584:	02f70163          	beq	a4,a5,75a6 <memcmp+0x58>
      return *p1 - *p2;
    7588:	fe843783          	ld	a5,-24(s0)
    758c:	0007c783          	lbu	a5,0(a5)
    7590:	0007871b          	sext.w	a4,a5
    7594:	fe043783          	ld	a5,-32(s0)
    7598:	0007c783          	lbu	a5,0(a5)
    759c:	2781                	sext.w	a5,a5
    759e:	40f707bb          	subw	a5,a4,a5
    75a2:	2781                	sext.w	a5,a5
    75a4:	a01d                	j	75ca <memcmp+0x7c>
    }
    p1++;
    75a6:	fe843783          	ld	a5,-24(s0)
    75aa:	0785                	addi	a5,a5,1
    75ac:	fef43423          	sd	a5,-24(s0)
    p2++;
    75b0:	fe043783          	ld	a5,-32(s0)
    75b4:	0785                	addi	a5,a5,1
    75b6:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    75ba:	fcc42783          	lw	a5,-52(s0)
    75be:	fff7871b          	addiw	a4,a5,-1
    75c2:	fce42623          	sw	a4,-52(s0)
    75c6:	f7dd                	bnez	a5,7574 <memcmp+0x26>
  }
  return 0;
    75c8:	4781                	li	a5,0
}
    75ca:	853e                	mv	a0,a5
    75cc:	7462                	ld	s0,56(sp)
    75ce:	6121                	addi	sp,sp,64
    75d0:	8082                	ret

00000000000075d2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    75d2:	7179                	addi	sp,sp,-48
    75d4:	f406                	sd	ra,40(sp)
    75d6:	f022                	sd	s0,32(sp)
    75d8:	1800                	addi	s0,sp,48
    75da:	fea43423          	sd	a0,-24(s0)
    75de:	feb43023          	sd	a1,-32(s0)
    75e2:	87b2                	mv	a5,a2
    75e4:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    75e8:	fdc42783          	lw	a5,-36(s0)
    75ec:	863e                	mv	a2,a5
    75ee:	fe043583          	ld	a1,-32(s0)
    75f2:	fe843503          	ld	a0,-24(s0)
    75f6:	00000097          	auipc	ra,0x0
    75fa:	e96080e7          	jalr	-362(ra) # 748c <memmove>
    75fe:	87aa                	mv	a5,a0
}
    7600:	853e                	mv	a0,a5
    7602:	70a2                	ld	ra,40(sp)
    7604:	7402                	ld	s0,32(sp)
    7606:	6145                	addi	sp,sp,48
    7608:	8082                	ret

000000000000760a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    760a:	4885                	li	a7,1
 ecall
    760c:	00000073          	ecall
 ret
    7610:	8082                	ret

0000000000007612 <exit>:
.global exit
exit:
 li a7, SYS_exit
    7612:	4889                	li	a7,2
 ecall
    7614:	00000073          	ecall
 ret
    7618:	8082                	ret

000000000000761a <wait>:
.global wait
wait:
 li a7, SYS_wait
    761a:	488d                	li	a7,3
 ecall
    761c:	00000073          	ecall
 ret
    7620:	8082                	ret

0000000000007622 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    7622:	4891                	li	a7,4
 ecall
    7624:	00000073          	ecall
 ret
    7628:	8082                	ret

000000000000762a <read>:
.global read
read:
 li a7, SYS_read
    762a:	4895                	li	a7,5
 ecall
    762c:	00000073          	ecall
 ret
    7630:	8082                	ret

0000000000007632 <write>:
.global write
write:
 li a7, SYS_write
    7632:	48c1                	li	a7,16
 ecall
    7634:	00000073          	ecall
 ret
    7638:	8082                	ret

000000000000763a <close>:
.global close
close:
 li a7, SYS_close
    763a:	48d5                	li	a7,21
 ecall
    763c:	00000073          	ecall
 ret
    7640:	8082                	ret

0000000000007642 <kill>:
.global kill
kill:
 li a7, SYS_kill
    7642:	4899                	li	a7,6
 ecall
    7644:	00000073          	ecall
 ret
    7648:	8082                	ret

000000000000764a <exec>:
.global exec
exec:
 li a7, SYS_exec
    764a:	489d                	li	a7,7
 ecall
    764c:	00000073          	ecall
 ret
    7650:	8082                	ret

0000000000007652 <open>:
.global open
open:
 li a7, SYS_open
    7652:	48bd                	li	a7,15
 ecall
    7654:	00000073          	ecall
 ret
    7658:	8082                	ret

000000000000765a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    765a:	48c5                	li	a7,17
 ecall
    765c:	00000073          	ecall
 ret
    7660:	8082                	ret

0000000000007662 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    7662:	48c9                	li	a7,18
 ecall
    7664:	00000073          	ecall
 ret
    7668:	8082                	ret

000000000000766a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    766a:	48a1                	li	a7,8
 ecall
    766c:	00000073          	ecall
 ret
    7670:	8082                	ret

0000000000007672 <link>:
.global link
link:
 li a7, SYS_link
    7672:	48cd                	li	a7,19
 ecall
    7674:	00000073          	ecall
 ret
    7678:	8082                	ret

000000000000767a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    767a:	48d1                	li	a7,20
 ecall
    767c:	00000073          	ecall
 ret
    7680:	8082                	ret

0000000000007682 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    7682:	48a5                	li	a7,9
 ecall
    7684:	00000073          	ecall
 ret
    7688:	8082                	ret

000000000000768a <dup>:
.global dup
dup:
 li a7, SYS_dup
    768a:	48a9                	li	a7,10
 ecall
    768c:	00000073          	ecall
 ret
    7690:	8082                	ret

0000000000007692 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    7692:	48ad                	li	a7,11
 ecall
    7694:	00000073          	ecall
 ret
    7698:	8082                	ret

000000000000769a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    769a:	48b1                	li	a7,12
 ecall
    769c:	00000073          	ecall
 ret
    76a0:	8082                	ret

00000000000076a2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    76a2:	48b5                	li	a7,13
 ecall
    76a4:	00000073          	ecall
 ret
    76a8:	8082                	ret

00000000000076aa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    76aa:	48b9                	li	a7,14
 ecall
    76ac:	00000073          	ecall
 ret
    76b0:	8082                	ret

00000000000076b2 <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
    76b2:	48d9                	li	a7,22
 ecall
    76b4:	00000073          	ecall
 ret
    76b8:	8082                	ret

00000000000076ba <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
    76ba:	48dd                	li	a7,23
 ecall
    76bc:	00000073          	ecall
 ret
    76c0:	8082                	ret

00000000000076c2 <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
    76c2:	48e1                	li	a7,24
 ecall
    76c4:	00000073          	ecall
 ret
    76c8:	8082                	ret

00000000000076ca <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
    76ca:	48e5                	li	a7,25
 ecall
    76cc:	00000073          	ecall
 ret
    76d0:	8082                	ret

00000000000076d2 <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
    76d2:	48e9                	li	a7,26
 ecall
    76d4:	00000073          	ecall
 ret
    76d8:	8082                	ret

00000000000076da <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
    76da:	48ed                	li	a7,27
 ecall
    76dc:	00000073          	ecall
 ret
    76e0:	8082                	ret

00000000000076e2 <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
    76e2:	48f1                	li	a7,28
 ecall
    76e4:	00000073          	ecall
 ret
    76e8:	8082                	ret

00000000000076ea <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    76ea:	1101                	addi	sp,sp,-32
    76ec:	ec06                	sd	ra,24(sp)
    76ee:	e822                	sd	s0,16(sp)
    76f0:	1000                	addi	s0,sp,32
    76f2:	87aa                	mv	a5,a0
    76f4:	872e                	mv	a4,a1
    76f6:	fef42623          	sw	a5,-20(s0)
    76fa:	87ba                	mv	a5,a4
    76fc:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    7700:	feb40713          	addi	a4,s0,-21
    7704:	fec42783          	lw	a5,-20(s0)
    7708:	4605                	li	a2,1
    770a:	85ba                	mv	a1,a4
    770c:	853e                	mv	a0,a5
    770e:	00000097          	auipc	ra,0x0
    7712:	f24080e7          	jalr	-220(ra) # 7632 <write>
}
    7716:	0001                	nop
    7718:	60e2                	ld	ra,24(sp)
    771a:	6442                	ld	s0,16(sp)
    771c:	6105                	addi	sp,sp,32
    771e:	8082                	ret

0000000000007720 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    7720:	7139                	addi	sp,sp,-64
    7722:	fc06                	sd	ra,56(sp)
    7724:	f822                	sd	s0,48(sp)
    7726:	0080                	addi	s0,sp,64
    7728:	87aa                	mv	a5,a0
    772a:	8736                	mv	a4,a3
    772c:	fcf42623          	sw	a5,-52(s0)
    7730:	87ae                	mv	a5,a1
    7732:	fcf42423          	sw	a5,-56(s0)
    7736:	87b2                	mv	a5,a2
    7738:	fcf42223          	sw	a5,-60(s0)
    773c:	87ba                	mv	a5,a4
    773e:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    7742:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    7746:	fc042783          	lw	a5,-64(s0)
    774a:	2781                	sext.w	a5,a5
    774c:	c38d                	beqz	a5,776e <printint+0x4e>
    774e:	fc842783          	lw	a5,-56(s0)
    7752:	2781                	sext.w	a5,a5
    7754:	0007dd63          	bgez	a5,776e <printint+0x4e>
    neg = 1;
    7758:	4785                	li	a5,1
    775a:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    775e:	fc842783          	lw	a5,-56(s0)
    7762:	40f007bb          	negw	a5,a5
    7766:	2781                	sext.w	a5,a5
    7768:	fef42223          	sw	a5,-28(s0)
    776c:	a029                	j	7776 <printint+0x56>
  } else {
    x = xx;
    776e:	fc842783          	lw	a5,-56(s0)
    7772:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    7776:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    777a:	fc442783          	lw	a5,-60(s0)
    777e:	fe442703          	lw	a4,-28(s0)
    7782:	02f777bb          	remuw	a5,a4,a5
    7786:	0007861b          	sext.w	a2,a5
    778a:	fec42783          	lw	a5,-20(s0)
    778e:	0017871b          	addiw	a4,a5,1
    7792:	fee42623          	sw	a4,-20(s0)
    7796:	00005697          	auipc	a3,0x5
    779a:	b2a68693          	addi	a3,a3,-1238 # c2c0 <digits>
    779e:	02061713          	slli	a4,a2,0x20
    77a2:	9301                	srli	a4,a4,0x20
    77a4:	9736                	add	a4,a4,a3
    77a6:	00074703          	lbu	a4,0(a4)
    77aa:	17c1                	addi	a5,a5,-16
    77ac:	97a2                	add	a5,a5,s0
    77ae:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    77b2:	fc442783          	lw	a5,-60(s0)
    77b6:	fe442703          	lw	a4,-28(s0)
    77ba:	02f757bb          	divuw	a5,a4,a5
    77be:	fef42223          	sw	a5,-28(s0)
    77c2:	fe442783          	lw	a5,-28(s0)
    77c6:	2781                	sext.w	a5,a5
    77c8:	fbcd                	bnez	a5,777a <printint+0x5a>
  if(neg)
    77ca:	fe842783          	lw	a5,-24(s0)
    77ce:	2781                	sext.w	a5,a5
    77d0:	cf85                	beqz	a5,7808 <printint+0xe8>
    buf[i++] = '-';
    77d2:	fec42783          	lw	a5,-20(s0)
    77d6:	0017871b          	addiw	a4,a5,1
    77da:	fee42623          	sw	a4,-20(s0)
    77de:	17c1                	addi	a5,a5,-16
    77e0:	97a2                	add	a5,a5,s0
    77e2:	02d00713          	li	a4,45
    77e6:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    77ea:	a839                	j	7808 <printint+0xe8>
    putc(fd, buf[i]);
    77ec:	fec42783          	lw	a5,-20(s0)
    77f0:	17c1                	addi	a5,a5,-16
    77f2:	97a2                	add	a5,a5,s0
    77f4:	fe07c703          	lbu	a4,-32(a5)
    77f8:	fcc42783          	lw	a5,-52(s0)
    77fc:	85ba                	mv	a1,a4
    77fe:	853e                	mv	a0,a5
    7800:	00000097          	auipc	ra,0x0
    7804:	eea080e7          	jalr	-278(ra) # 76ea <putc>
  while(--i >= 0)
    7808:	fec42783          	lw	a5,-20(s0)
    780c:	37fd                	addiw	a5,a5,-1
    780e:	fef42623          	sw	a5,-20(s0)
    7812:	fec42783          	lw	a5,-20(s0)
    7816:	2781                	sext.w	a5,a5
    7818:	fc07dae3          	bgez	a5,77ec <printint+0xcc>
}
    781c:	0001                	nop
    781e:	0001                	nop
    7820:	70e2                	ld	ra,56(sp)
    7822:	7442                	ld	s0,48(sp)
    7824:	6121                	addi	sp,sp,64
    7826:	8082                	ret

0000000000007828 <printptr>:

static void
printptr(int fd, uint64 x) {
    7828:	7179                	addi	sp,sp,-48
    782a:	f406                	sd	ra,40(sp)
    782c:	f022                	sd	s0,32(sp)
    782e:	1800                	addi	s0,sp,48
    7830:	87aa                	mv	a5,a0
    7832:	fcb43823          	sd	a1,-48(s0)
    7836:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    783a:	fdc42783          	lw	a5,-36(s0)
    783e:	03000593          	li	a1,48
    7842:	853e                	mv	a0,a5
    7844:	00000097          	auipc	ra,0x0
    7848:	ea6080e7          	jalr	-346(ra) # 76ea <putc>
  putc(fd, 'x');
    784c:	fdc42783          	lw	a5,-36(s0)
    7850:	07800593          	li	a1,120
    7854:	853e                	mv	a0,a5
    7856:	00000097          	auipc	ra,0x0
    785a:	e94080e7          	jalr	-364(ra) # 76ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    785e:	fe042623          	sw	zero,-20(s0)
    7862:	a82d                	j	789c <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    7864:	fd043783          	ld	a5,-48(s0)
    7868:	93f1                	srli	a5,a5,0x3c
    786a:	00005717          	auipc	a4,0x5
    786e:	a5670713          	addi	a4,a4,-1450 # c2c0 <digits>
    7872:	97ba                	add	a5,a5,a4
    7874:	0007c703          	lbu	a4,0(a5)
    7878:	fdc42783          	lw	a5,-36(s0)
    787c:	85ba                	mv	a1,a4
    787e:	853e                	mv	a0,a5
    7880:	00000097          	auipc	ra,0x0
    7884:	e6a080e7          	jalr	-406(ra) # 76ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    7888:	fec42783          	lw	a5,-20(s0)
    788c:	2785                	addiw	a5,a5,1
    788e:	fef42623          	sw	a5,-20(s0)
    7892:	fd043783          	ld	a5,-48(s0)
    7896:	0792                	slli	a5,a5,0x4
    7898:	fcf43823          	sd	a5,-48(s0)
    789c:	fec42783          	lw	a5,-20(s0)
    78a0:	873e                	mv	a4,a5
    78a2:	47bd                	li	a5,15
    78a4:	fce7f0e3          	bgeu	a5,a4,7864 <printptr+0x3c>
}
    78a8:	0001                	nop
    78aa:	0001                	nop
    78ac:	70a2                	ld	ra,40(sp)
    78ae:	7402                	ld	s0,32(sp)
    78b0:	6145                	addi	sp,sp,48
    78b2:	8082                	ret

00000000000078b4 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    78b4:	715d                	addi	sp,sp,-80
    78b6:	e486                	sd	ra,72(sp)
    78b8:	e0a2                	sd	s0,64(sp)
    78ba:	0880                	addi	s0,sp,80
    78bc:	87aa                	mv	a5,a0
    78be:	fcb43023          	sd	a1,-64(s0)
    78c2:	fac43c23          	sd	a2,-72(s0)
    78c6:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    78ca:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    78ce:	fe042223          	sw	zero,-28(s0)
    78d2:	a42d                	j	7afc <vprintf+0x248>
    c = fmt[i] & 0xff;
    78d4:	fe442783          	lw	a5,-28(s0)
    78d8:	fc043703          	ld	a4,-64(s0)
    78dc:	97ba                	add	a5,a5,a4
    78de:	0007c783          	lbu	a5,0(a5)
    78e2:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    78e6:	fe042783          	lw	a5,-32(s0)
    78ea:	2781                	sext.w	a5,a5
    78ec:	eb9d                	bnez	a5,7922 <vprintf+0x6e>
      if(c == '%'){
    78ee:	fdc42783          	lw	a5,-36(s0)
    78f2:	0007871b          	sext.w	a4,a5
    78f6:	02500793          	li	a5,37
    78fa:	00f71763          	bne	a4,a5,7908 <vprintf+0x54>
        state = '%';
    78fe:	02500793          	li	a5,37
    7902:	fef42023          	sw	a5,-32(s0)
    7906:	a2f5                	j	7af2 <vprintf+0x23e>
      } else {
        putc(fd, c);
    7908:	fdc42783          	lw	a5,-36(s0)
    790c:	0ff7f713          	zext.b	a4,a5
    7910:	fcc42783          	lw	a5,-52(s0)
    7914:	85ba                	mv	a1,a4
    7916:	853e                	mv	a0,a5
    7918:	00000097          	auipc	ra,0x0
    791c:	dd2080e7          	jalr	-558(ra) # 76ea <putc>
    7920:	aac9                	j	7af2 <vprintf+0x23e>
      }
    } else if(state == '%'){
    7922:	fe042783          	lw	a5,-32(s0)
    7926:	0007871b          	sext.w	a4,a5
    792a:	02500793          	li	a5,37
    792e:	1cf71263          	bne	a4,a5,7af2 <vprintf+0x23e>
      if(c == 'd'){
    7932:	fdc42783          	lw	a5,-36(s0)
    7936:	0007871b          	sext.w	a4,a5
    793a:	06400793          	li	a5,100
    793e:	02f71463          	bne	a4,a5,7966 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    7942:	fb843783          	ld	a5,-72(s0)
    7946:	00878713          	addi	a4,a5,8
    794a:	fae43c23          	sd	a4,-72(s0)
    794e:	4398                	lw	a4,0(a5)
    7950:	fcc42783          	lw	a5,-52(s0)
    7954:	4685                	li	a3,1
    7956:	4629                	li	a2,10
    7958:	85ba                	mv	a1,a4
    795a:	853e                	mv	a0,a5
    795c:	00000097          	auipc	ra,0x0
    7960:	dc4080e7          	jalr	-572(ra) # 7720 <printint>
    7964:	a269                	j	7aee <vprintf+0x23a>
      } else if(c == 'l') {
    7966:	fdc42783          	lw	a5,-36(s0)
    796a:	0007871b          	sext.w	a4,a5
    796e:	06c00793          	li	a5,108
    7972:	02f71663          	bne	a4,a5,799e <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    7976:	fb843783          	ld	a5,-72(s0)
    797a:	00878713          	addi	a4,a5,8
    797e:	fae43c23          	sd	a4,-72(s0)
    7982:	639c                	ld	a5,0(a5)
    7984:	0007871b          	sext.w	a4,a5
    7988:	fcc42783          	lw	a5,-52(s0)
    798c:	4681                	li	a3,0
    798e:	4629                	li	a2,10
    7990:	85ba                	mv	a1,a4
    7992:	853e                	mv	a0,a5
    7994:	00000097          	auipc	ra,0x0
    7998:	d8c080e7          	jalr	-628(ra) # 7720 <printint>
    799c:	aa89                	j	7aee <vprintf+0x23a>
      } else if(c == 'x') {
    799e:	fdc42783          	lw	a5,-36(s0)
    79a2:	0007871b          	sext.w	a4,a5
    79a6:	07800793          	li	a5,120
    79aa:	02f71463          	bne	a4,a5,79d2 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    79ae:	fb843783          	ld	a5,-72(s0)
    79b2:	00878713          	addi	a4,a5,8
    79b6:	fae43c23          	sd	a4,-72(s0)
    79ba:	4398                	lw	a4,0(a5)
    79bc:	fcc42783          	lw	a5,-52(s0)
    79c0:	4681                	li	a3,0
    79c2:	4641                	li	a2,16
    79c4:	85ba                	mv	a1,a4
    79c6:	853e                	mv	a0,a5
    79c8:	00000097          	auipc	ra,0x0
    79cc:	d58080e7          	jalr	-680(ra) # 7720 <printint>
    79d0:	aa39                	j	7aee <vprintf+0x23a>
      } else if(c == 'p') {
    79d2:	fdc42783          	lw	a5,-36(s0)
    79d6:	0007871b          	sext.w	a4,a5
    79da:	07000793          	li	a5,112
    79de:	02f71263          	bne	a4,a5,7a02 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    79e2:	fb843783          	ld	a5,-72(s0)
    79e6:	00878713          	addi	a4,a5,8
    79ea:	fae43c23          	sd	a4,-72(s0)
    79ee:	6398                	ld	a4,0(a5)
    79f0:	fcc42783          	lw	a5,-52(s0)
    79f4:	85ba                	mv	a1,a4
    79f6:	853e                	mv	a0,a5
    79f8:	00000097          	auipc	ra,0x0
    79fc:	e30080e7          	jalr	-464(ra) # 7828 <printptr>
    7a00:	a0fd                	j	7aee <vprintf+0x23a>
      } else if(c == 's'){
    7a02:	fdc42783          	lw	a5,-36(s0)
    7a06:	0007871b          	sext.w	a4,a5
    7a0a:	07300793          	li	a5,115
    7a0e:	04f71c63          	bne	a4,a5,7a66 <vprintf+0x1b2>
        s = va_arg(ap, char*);
    7a12:	fb843783          	ld	a5,-72(s0)
    7a16:	00878713          	addi	a4,a5,8
    7a1a:	fae43c23          	sd	a4,-72(s0)
    7a1e:	639c                	ld	a5,0(a5)
    7a20:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    7a24:	fe843783          	ld	a5,-24(s0)
    7a28:	eb8d                	bnez	a5,7a5a <vprintf+0x1a6>
          s = "(null)";
    7a2a:	00002797          	auipc	a5,0x2
    7a2e:	7c678793          	addi	a5,a5,1990 # a1f0 <malloc+0x248c>
    7a32:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    7a36:	a015                	j	7a5a <vprintf+0x1a6>
          putc(fd, *s);
    7a38:	fe843783          	ld	a5,-24(s0)
    7a3c:	0007c703          	lbu	a4,0(a5)
    7a40:	fcc42783          	lw	a5,-52(s0)
    7a44:	85ba                	mv	a1,a4
    7a46:	853e                	mv	a0,a5
    7a48:	00000097          	auipc	ra,0x0
    7a4c:	ca2080e7          	jalr	-862(ra) # 76ea <putc>
          s++;
    7a50:	fe843783          	ld	a5,-24(s0)
    7a54:	0785                	addi	a5,a5,1
    7a56:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    7a5a:	fe843783          	ld	a5,-24(s0)
    7a5e:	0007c783          	lbu	a5,0(a5)
    7a62:	fbf9                	bnez	a5,7a38 <vprintf+0x184>
    7a64:	a069                	j	7aee <vprintf+0x23a>
        }
      } else if(c == 'c'){
    7a66:	fdc42783          	lw	a5,-36(s0)
    7a6a:	0007871b          	sext.w	a4,a5
    7a6e:	06300793          	li	a5,99
    7a72:	02f71463          	bne	a4,a5,7a9a <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    7a76:	fb843783          	ld	a5,-72(s0)
    7a7a:	00878713          	addi	a4,a5,8
    7a7e:	fae43c23          	sd	a4,-72(s0)
    7a82:	439c                	lw	a5,0(a5)
    7a84:	0ff7f713          	zext.b	a4,a5
    7a88:	fcc42783          	lw	a5,-52(s0)
    7a8c:	85ba                	mv	a1,a4
    7a8e:	853e                	mv	a0,a5
    7a90:	00000097          	auipc	ra,0x0
    7a94:	c5a080e7          	jalr	-934(ra) # 76ea <putc>
    7a98:	a899                	j	7aee <vprintf+0x23a>
      } else if(c == '%'){
    7a9a:	fdc42783          	lw	a5,-36(s0)
    7a9e:	0007871b          	sext.w	a4,a5
    7aa2:	02500793          	li	a5,37
    7aa6:	00f71f63          	bne	a4,a5,7ac4 <vprintf+0x210>
        putc(fd, c);
    7aaa:	fdc42783          	lw	a5,-36(s0)
    7aae:	0ff7f713          	zext.b	a4,a5
    7ab2:	fcc42783          	lw	a5,-52(s0)
    7ab6:	85ba                	mv	a1,a4
    7ab8:	853e                	mv	a0,a5
    7aba:	00000097          	auipc	ra,0x0
    7abe:	c30080e7          	jalr	-976(ra) # 76ea <putc>
    7ac2:	a035                	j	7aee <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    7ac4:	fcc42783          	lw	a5,-52(s0)
    7ac8:	02500593          	li	a1,37
    7acc:	853e                	mv	a0,a5
    7ace:	00000097          	auipc	ra,0x0
    7ad2:	c1c080e7          	jalr	-996(ra) # 76ea <putc>
        putc(fd, c);
    7ad6:	fdc42783          	lw	a5,-36(s0)
    7ada:	0ff7f713          	zext.b	a4,a5
    7ade:	fcc42783          	lw	a5,-52(s0)
    7ae2:	85ba                	mv	a1,a4
    7ae4:	853e                	mv	a0,a5
    7ae6:	00000097          	auipc	ra,0x0
    7aea:	c04080e7          	jalr	-1020(ra) # 76ea <putc>
      }
      state = 0;
    7aee:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    7af2:	fe442783          	lw	a5,-28(s0)
    7af6:	2785                	addiw	a5,a5,1
    7af8:	fef42223          	sw	a5,-28(s0)
    7afc:	fe442783          	lw	a5,-28(s0)
    7b00:	fc043703          	ld	a4,-64(s0)
    7b04:	97ba                	add	a5,a5,a4
    7b06:	0007c783          	lbu	a5,0(a5)
    7b0a:	dc0795e3          	bnez	a5,78d4 <vprintf+0x20>
    }
  }
}
    7b0e:	0001                	nop
    7b10:	0001                	nop
    7b12:	60a6                	ld	ra,72(sp)
    7b14:	6406                	ld	s0,64(sp)
    7b16:	6161                	addi	sp,sp,80
    7b18:	8082                	ret

0000000000007b1a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    7b1a:	7159                	addi	sp,sp,-112
    7b1c:	fc06                	sd	ra,56(sp)
    7b1e:	f822                	sd	s0,48(sp)
    7b20:	0080                	addi	s0,sp,64
    7b22:	fcb43823          	sd	a1,-48(s0)
    7b26:	e010                	sd	a2,0(s0)
    7b28:	e414                	sd	a3,8(s0)
    7b2a:	e818                	sd	a4,16(s0)
    7b2c:	ec1c                	sd	a5,24(s0)
    7b2e:	03043023          	sd	a6,32(s0)
    7b32:	03143423          	sd	a7,40(s0)
    7b36:	87aa                	mv	a5,a0
    7b38:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    7b3c:	03040793          	addi	a5,s0,48
    7b40:	fcf43423          	sd	a5,-56(s0)
    7b44:	fc843783          	ld	a5,-56(s0)
    7b48:	fd078793          	addi	a5,a5,-48
    7b4c:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    7b50:	fe843703          	ld	a4,-24(s0)
    7b54:	fdc42783          	lw	a5,-36(s0)
    7b58:	863a                	mv	a2,a4
    7b5a:	fd043583          	ld	a1,-48(s0)
    7b5e:	853e                	mv	a0,a5
    7b60:	00000097          	auipc	ra,0x0
    7b64:	d54080e7          	jalr	-684(ra) # 78b4 <vprintf>
}
    7b68:	0001                	nop
    7b6a:	70e2                	ld	ra,56(sp)
    7b6c:	7442                	ld	s0,48(sp)
    7b6e:	6165                	addi	sp,sp,112
    7b70:	8082                	ret

0000000000007b72 <printf>:

void
printf(const char *fmt, ...)
{
    7b72:	7159                	addi	sp,sp,-112
    7b74:	f406                	sd	ra,40(sp)
    7b76:	f022                	sd	s0,32(sp)
    7b78:	1800                	addi	s0,sp,48
    7b7a:	fca43c23          	sd	a0,-40(s0)
    7b7e:	e40c                	sd	a1,8(s0)
    7b80:	e810                	sd	a2,16(s0)
    7b82:	ec14                	sd	a3,24(s0)
    7b84:	f018                	sd	a4,32(s0)
    7b86:	f41c                	sd	a5,40(s0)
    7b88:	03043823          	sd	a6,48(s0)
    7b8c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    7b90:	04040793          	addi	a5,s0,64
    7b94:	fcf43823          	sd	a5,-48(s0)
    7b98:	fd043783          	ld	a5,-48(s0)
    7b9c:	fc878793          	addi	a5,a5,-56
    7ba0:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    7ba4:	fe843783          	ld	a5,-24(s0)
    7ba8:	863e                	mv	a2,a5
    7baa:	fd843583          	ld	a1,-40(s0)
    7bae:	4505                	li	a0,1
    7bb0:	00000097          	auipc	ra,0x0
    7bb4:	d04080e7          	jalr	-764(ra) # 78b4 <vprintf>
}
    7bb8:	0001                	nop
    7bba:	70a2                	ld	ra,40(sp)
    7bbc:	7402                	ld	s0,32(sp)
    7bbe:	6165                	addi	sp,sp,112
    7bc0:	8082                	ret

0000000000007bc2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    7bc2:	7179                	addi	sp,sp,-48
    7bc4:	f422                	sd	s0,40(sp)
    7bc6:	1800                	addi	s0,sp,48
    7bc8:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    7bcc:	fd843783          	ld	a5,-40(s0)
    7bd0:	17c1                	addi	a5,a5,-16
    7bd2:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    7bd6:	0000b797          	auipc	a5,0xb
    7bda:	f3278793          	addi	a5,a5,-206 # 12b08 <freep>
    7bde:	639c                	ld	a5,0(a5)
    7be0:	fef43423          	sd	a5,-24(s0)
    7be4:	a815                	j	7c18 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    7be6:	fe843783          	ld	a5,-24(s0)
    7bea:	639c                	ld	a5,0(a5)
    7bec:	fe843703          	ld	a4,-24(s0)
    7bf0:	00f76f63          	bltu	a4,a5,7c0e <free+0x4c>
    7bf4:	fe043703          	ld	a4,-32(s0)
    7bf8:	fe843783          	ld	a5,-24(s0)
    7bfc:	02e7eb63          	bltu	a5,a4,7c32 <free+0x70>
    7c00:	fe843783          	ld	a5,-24(s0)
    7c04:	639c                	ld	a5,0(a5)
    7c06:	fe043703          	ld	a4,-32(s0)
    7c0a:	02f76463          	bltu	a4,a5,7c32 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    7c0e:	fe843783          	ld	a5,-24(s0)
    7c12:	639c                	ld	a5,0(a5)
    7c14:	fef43423          	sd	a5,-24(s0)
    7c18:	fe043703          	ld	a4,-32(s0)
    7c1c:	fe843783          	ld	a5,-24(s0)
    7c20:	fce7f3e3          	bgeu	a5,a4,7be6 <free+0x24>
    7c24:	fe843783          	ld	a5,-24(s0)
    7c28:	639c                	ld	a5,0(a5)
    7c2a:	fe043703          	ld	a4,-32(s0)
    7c2e:	faf77ce3          	bgeu	a4,a5,7be6 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    7c32:	fe043783          	ld	a5,-32(s0)
    7c36:	479c                	lw	a5,8(a5)
    7c38:	1782                	slli	a5,a5,0x20
    7c3a:	9381                	srli	a5,a5,0x20
    7c3c:	0792                	slli	a5,a5,0x4
    7c3e:	fe043703          	ld	a4,-32(s0)
    7c42:	973e                	add	a4,a4,a5
    7c44:	fe843783          	ld	a5,-24(s0)
    7c48:	639c                	ld	a5,0(a5)
    7c4a:	02f71763          	bne	a4,a5,7c78 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    7c4e:	fe043783          	ld	a5,-32(s0)
    7c52:	4798                	lw	a4,8(a5)
    7c54:	fe843783          	ld	a5,-24(s0)
    7c58:	639c                	ld	a5,0(a5)
    7c5a:	479c                	lw	a5,8(a5)
    7c5c:	9fb9                	addw	a5,a5,a4
    7c5e:	0007871b          	sext.w	a4,a5
    7c62:	fe043783          	ld	a5,-32(s0)
    7c66:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    7c68:	fe843783          	ld	a5,-24(s0)
    7c6c:	639c                	ld	a5,0(a5)
    7c6e:	6398                	ld	a4,0(a5)
    7c70:	fe043783          	ld	a5,-32(s0)
    7c74:	e398                	sd	a4,0(a5)
    7c76:	a039                	j	7c84 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    7c78:	fe843783          	ld	a5,-24(s0)
    7c7c:	6398                	ld	a4,0(a5)
    7c7e:	fe043783          	ld	a5,-32(s0)
    7c82:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    7c84:	fe843783          	ld	a5,-24(s0)
    7c88:	479c                	lw	a5,8(a5)
    7c8a:	1782                	slli	a5,a5,0x20
    7c8c:	9381                	srli	a5,a5,0x20
    7c8e:	0792                	slli	a5,a5,0x4
    7c90:	fe843703          	ld	a4,-24(s0)
    7c94:	97ba                	add	a5,a5,a4
    7c96:	fe043703          	ld	a4,-32(s0)
    7c9a:	02f71563          	bne	a4,a5,7cc4 <free+0x102>
    p->s.size += bp->s.size;
    7c9e:	fe843783          	ld	a5,-24(s0)
    7ca2:	4798                	lw	a4,8(a5)
    7ca4:	fe043783          	ld	a5,-32(s0)
    7ca8:	479c                	lw	a5,8(a5)
    7caa:	9fb9                	addw	a5,a5,a4
    7cac:	0007871b          	sext.w	a4,a5
    7cb0:	fe843783          	ld	a5,-24(s0)
    7cb4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    7cb6:	fe043783          	ld	a5,-32(s0)
    7cba:	6398                	ld	a4,0(a5)
    7cbc:	fe843783          	ld	a5,-24(s0)
    7cc0:	e398                	sd	a4,0(a5)
    7cc2:	a031                	j	7cce <free+0x10c>
  } else
    p->s.ptr = bp;
    7cc4:	fe843783          	ld	a5,-24(s0)
    7cc8:	fe043703          	ld	a4,-32(s0)
    7ccc:	e398                	sd	a4,0(a5)
  freep = p;
    7cce:	0000b797          	auipc	a5,0xb
    7cd2:	e3a78793          	addi	a5,a5,-454 # 12b08 <freep>
    7cd6:	fe843703          	ld	a4,-24(s0)
    7cda:	e398                	sd	a4,0(a5)
}
    7cdc:	0001                	nop
    7cde:	7422                	ld	s0,40(sp)
    7ce0:	6145                	addi	sp,sp,48
    7ce2:	8082                	ret

0000000000007ce4 <morecore>:

static Header*
morecore(uint nu)
{
    7ce4:	7179                	addi	sp,sp,-48
    7ce6:	f406                	sd	ra,40(sp)
    7ce8:	f022                	sd	s0,32(sp)
    7cea:	1800                	addi	s0,sp,48
    7cec:	87aa                	mv	a5,a0
    7cee:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    7cf2:	fdc42783          	lw	a5,-36(s0)
    7cf6:	0007871b          	sext.w	a4,a5
    7cfa:	6785                	lui	a5,0x1
    7cfc:	00f77563          	bgeu	a4,a5,7d06 <morecore+0x22>
    nu = 4096;
    7d00:	6785                	lui	a5,0x1
    7d02:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    7d06:	fdc42783          	lw	a5,-36(s0)
    7d0a:	0047979b          	slliw	a5,a5,0x4
    7d0e:	2781                	sext.w	a5,a5
    7d10:	2781                	sext.w	a5,a5
    7d12:	853e                	mv	a0,a5
    7d14:	00000097          	auipc	ra,0x0
    7d18:	986080e7          	jalr	-1658(ra) # 769a <sbrk>
    7d1c:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    7d20:	fe843703          	ld	a4,-24(s0)
    7d24:	57fd                	li	a5,-1
    7d26:	00f71463          	bne	a4,a5,7d2e <morecore+0x4a>
    return 0;
    7d2a:	4781                	li	a5,0
    7d2c:	a03d                	j	7d5a <morecore+0x76>
  hp = (Header*)p;
    7d2e:	fe843783          	ld	a5,-24(s0)
    7d32:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    7d36:	fe043783          	ld	a5,-32(s0)
    7d3a:	fdc42703          	lw	a4,-36(s0)
    7d3e:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    7d40:	fe043783          	ld	a5,-32(s0)
    7d44:	07c1                	addi	a5,a5,16 # 1010 <truncate3+0x1c2>
    7d46:	853e                	mv	a0,a5
    7d48:	00000097          	auipc	ra,0x0
    7d4c:	e7a080e7          	jalr	-390(ra) # 7bc2 <free>
  return freep;
    7d50:	0000b797          	auipc	a5,0xb
    7d54:	db878793          	addi	a5,a5,-584 # 12b08 <freep>
    7d58:	639c                	ld	a5,0(a5)
}
    7d5a:	853e                	mv	a0,a5
    7d5c:	70a2                	ld	ra,40(sp)
    7d5e:	7402                	ld	s0,32(sp)
    7d60:	6145                	addi	sp,sp,48
    7d62:	8082                	ret

0000000000007d64 <malloc>:

void*
malloc(uint nbytes)
{
    7d64:	7139                	addi	sp,sp,-64
    7d66:	fc06                	sd	ra,56(sp)
    7d68:	f822                	sd	s0,48(sp)
    7d6a:	0080                	addi	s0,sp,64
    7d6c:	87aa                	mv	a5,a0
    7d6e:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    7d72:	fcc46783          	lwu	a5,-52(s0)
    7d76:	07bd                	addi	a5,a5,15
    7d78:	8391                	srli	a5,a5,0x4
    7d7a:	2781                	sext.w	a5,a5
    7d7c:	2785                	addiw	a5,a5,1
    7d7e:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    7d82:	0000b797          	auipc	a5,0xb
    7d86:	d8678793          	addi	a5,a5,-634 # 12b08 <freep>
    7d8a:	639c                	ld	a5,0(a5)
    7d8c:	fef43023          	sd	a5,-32(s0)
    7d90:	fe043783          	ld	a5,-32(s0)
    7d94:	ef95                	bnez	a5,7dd0 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    7d96:	0000b797          	auipc	a5,0xb
    7d9a:	d6278793          	addi	a5,a5,-670 # 12af8 <base>
    7d9e:	fef43023          	sd	a5,-32(s0)
    7da2:	0000b797          	auipc	a5,0xb
    7da6:	d6678793          	addi	a5,a5,-666 # 12b08 <freep>
    7daa:	fe043703          	ld	a4,-32(s0)
    7dae:	e398                	sd	a4,0(a5)
    7db0:	0000b797          	auipc	a5,0xb
    7db4:	d5878793          	addi	a5,a5,-680 # 12b08 <freep>
    7db8:	6398                	ld	a4,0(a5)
    7dba:	0000b797          	auipc	a5,0xb
    7dbe:	d3e78793          	addi	a5,a5,-706 # 12af8 <base>
    7dc2:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    7dc4:	0000b797          	auipc	a5,0xb
    7dc8:	d3478793          	addi	a5,a5,-716 # 12af8 <base>
    7dcc:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7dd0:	fe043783          	ld	a5,-32(s0)
    7dd4:	639c                	ld	a5,0(a5)
    7dd6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7dda:	fe843783          	ld	a5,-24(s0)
    7dde:	4798                	lw	a4,8(a5)
    7de0:	fdc42783          	lw	a5,-36(s0)
    7de4:	2781                	sext.w	a5,a5
    7de6:	06f76763          	bltu	a4,a5,7e54 <malloc+0xf0>
      if(p->s.size == nunits)
    7dea:	fe843783          	ld	a5,-24(s0)
    7dee:	4798                	lw	a4,8(a5)
    7df0:	fdc42783          	lw	a5,-36(s0)
    7df4:	2781                	sext.w	a5,a5
    7df6:	00e79963          	bne	a5,a4,7e08 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    7dfa:	fe843783          	ld	a5,-24(s0)
    7dfe:	6398                	ld	a4,0(a5)
    7e00:	fe043783          	ld	a5,-32(s0)
    7e04:	e398                	sd	a4,0(a5)
    7e06:	a825                	j	7e3e <malloc+0xda>
      else {
        p->s.size -= nunits;
    7e08:	fe843783          	ld	a5,-24(s0)
    7e0c:	479c                	lw	a5,8(a5)
    7e0e:	fdc42703          	lw	a4,-36(s0)
    7e12:	9f99                	subw	a5,a5,a4
    7e14:	0007871b          	sext.w	a4,a5
    7e18:	fe843783          	ld	a5,-24(s0)
    7e1c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    7e1e:	fe843783          	ld	a5,-24(s0)
    7e22:	479c                	lw	a5,8(a5)
    7e24:	1782                	slli	a5,a5,0x20
    7e26:	9381                	srli	a5,a5,0x20
    7e28:	0792                	slli	a5,a5,0x4
    7e2a:	fe843703          	ld	a4,-24(s0)
    7e2e:	97ba                	add	a5,a5,a4
    7e30:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    7e34:	fe843783          	ld	a5,-24(s0)
    7e38:	fdc42703          	lw	a4,-36(s0)
    7e3c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    7e3e:	0000b797          	auipc	a5,0xb
    7e42:	cca78793          	addi	a5,a5,-822 # 12b08 <freep>
    7e46:	fe043703          	ld	a4,-32(s0)
    7e4a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    7e4c:	fe843783          	ld	a5,-24(s0)
    7e50:	07c1                	addi	a5,a5,16
    7e52:	a091                	j	7e96 <malloc+0x132>
    }
    if(p == freep)
    7e54:	0000b797          	auipc	a5,0xb
    7e58:	cb478793          	addi	a5,a5,-844 # 12b08 <freep>
    7e5c:	639c                	ld	a5,0(a5)
    7e5e:	fe843703          	ld	a4,-24(s0)
    7e62:	02f71063          	bne	a4,a5,7e82 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    7e66:	fdc42783          	lw	a5,-36(s0)
    7e6a:	853e                	mv	a0,a5
    7e6c:	00000097          	auipc	ra,0x0
    7e70:	e78080e7          	jalr	-392(ra) # 7ce4 <morecore>
    7e74:	fea43423          	sd	a0,-24(s0)
    7e78:	fe843783          	ld	a5,-24(s0)
    7e7c:	e399                	bnez	a5,7e82 <malloc+0x11e>
        return 0;
    7e7e:	4781                	li	a5,0
    7e80:	a819                	j	7e96 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7e82:	fe843783          	ld	a5,-24(s0)
    7e86:	fef43023          	sd	a5,-32(s0)
    7e8a:	fe843783          	ld	a5,-24(s0)
    7e8e:	639c                	ld	a5,0(a5)
    7e90:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7e94:	b799                	j	7dda <malloc+0x76>
  }
}
    7e96:	853e                	mv	a0,a5
    7e98:	70e2                	ld	ra,56(sp)
    7e9a:	7442                	ld	s0,48(sp)
    7e9c:	6121                	addi	sp,sp,64
    7e9e:	8082                	ret
