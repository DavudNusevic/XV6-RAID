
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	fca43423          	sd	a0,-56(s0)
       c:	87ae                	mv	a5,a1
       e:	fcf42223          	sw	a5,-60(s0)
  int n, m;
  char *p, *q;

  m = 0;
      12:	fe042623          	sw	zero,-20(s0)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      16:	a0c5                	j	f6 <grep+0xf6>
    m += n;
      18:	fec42783          	lw	a5,-20(s0)
      1c:	873e                	mv	a4,a5
      1e:	fdc42783          	lw	a5,-36(s0)
      22:	9fb9                	addw	a5,a5,a4
      24:	fef42623          	sw	a5,-20(s0)
    buf[m] = '\0';
      28:	00002717          	auipc	a4,0x2
      2c:	40870713          	addi	a4,a4,1032 # 2430 <buf>
      30:	fec42783          	lw	a5,-20(s0)
      34:	97ba                	add	a5,a5,a4
      36:	00078023          	sb	zero,0(a5)
    p = buf;
      3a:	00002797          	auipc	a5,0x2
      3e:	3f678793          	addi	a5,a5,1014 # 2430 <buf>
      42:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      46:	a891                	j	9a <grep+0x9a>
      *q = 0;
      48:	fd043783          	ld	a5,-48(s0)
      4c:	00078023          	sb	zero,0(a5)
      if(match(pattern, p)){
      50:	fe043583          	ld	a1,-32(s0)
      54:	fc843503          	ld	a0,-56(s0)
      58:	00000097          	auipc	ra,0x0
      5c:	1fc080e7          	jalr	508(ra) # 254 <match>
      60:	87aa                	mv	a5,a0
      62:	c79d                	beqz	a5,90 <grep+0x90>
        *q = '\n';
      64:	fd043783          	ld	a5,-48(s0)
      68:	4729                	li	a4,10
      6a:	00e78023          	sb	a4,0(a5)
        write(1, p, q+1 - p);
      6e:	fd043783          	ld	a5,-48(s0)
      72:	00178713          	addi	a4,a5,1
      76:	fe043783          	ld	a5,-32(s0)
      7a:	40f707b3          	sub	a5,a4,a5
      7e:	2781                	sext.w	a5,a5
      80:	863e                	mv	a2,a5
      82:	fe043583          	ld	a1,-32(s0)
      86:	4505                	li	a0,1
      88:	00001097          	auipc	ra,0x1
      8c:	860080e7          	jalr	-1952(ra) # 8e8 <write>
      }
      p = q+1;
      90:	fd043783          	ld	a5,-48(s0)
      94:	0785                	addi	a5,a5,1
      96:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      9a:	45a9                	li	a1,10
      9c:	fe043503          	ld	a0,-32(s0)
      a0:	00000097          	auipc	ra,0x0
      a4:	4dc080e7          	jalr	1244(ra) # 57c <strchr>
      a8:	fca43823          	sd	a0,-48(s0)
      ac:	fd043783          	ld	a5,-48(s0)
      b0:	ffc1                	bnez	a5,48 <grep+0x48>
    }
    if(m > 0){
      b2:	fec42783          	lw	a5,-20(s0)
      b6:	2781                	sext.w	a5,a5
      b8:	02f05f63          	blez	a5,f6 <grep+0xf6>
      m -= p - buf;
      bc:	fec42703          	lw	a4,-20(s0)
      c0:	fe043683          	ld	a3,-32(s0)
      c4:	00002797          	auipc	a5,0x2
      c8:	36c78793          	addi	a5,a5,876 # 2430 <buf>
      cc:	40f687b3          	sub	a5,a3,a5
      d0:	2781                	sext.w	a5,a5
      d2:	40f707bb          	subw	a5,a4,a5
      d6:	2781                	sext.w	a5,a5
      d8:	fef42623          	sw	a5,-20(s0)
      memmove(buf, p, m);
      dc:	fec42783          	lw	a5,-20(s0)
      e0:	863e                	mv	a2,a5
      e2:	fe043583          	ld	a1,-32(s0)
      e6:	00002517          	auipc	a0,0x2
      ea:	34a50513          	addi	a0,a0,842 # 2430 <buf>
      ee:	00000097          	auipc	ra,0x0
      f2:	654080e7          	jalr	1620(ra) # 742 <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      f6:	fec42703          	lw	a4,-20(s0)
      fa:	00002797          	auipc	a5,0x2
      fe:	33678793          	addi	a5,a5,822 # 2430 <buf>
     102:	00f706b3          	add	a3,a4,a5
     106:	fec42783          	lw	a5,-20(s0)
     10a:	3ff00713          	li	a4,1023
     10e:	40f707bb          	subw	a5,a4,a5
     112:	2781                	sext.w	a5,a5
     114:	0007871b          	sext.w	a4,a5
     118:	fc442783          	lw	a5,-60(s0)
     11c:	863a                	mv	a2,a4
     11e:	85b6                	mv	a1,a3
     120:	853e                	mv	a0,a5
     122:	00000097          	auipc	ra,0x0
     126:	7be080e7          	jalr	1982(ra) # 8e0 <read>
     12a:	87aa                	mv	a5,a0
     12c:	fcf42e23          	sw	a5,-36(s0)
     130:	fdc42783          	lw	a5,-36(s0)
     134:	2781                	sext.w	a5,a5
     136:	eef041e3          	bgtz	a5,18 <grep+0x18>
    }
  }
}
     13a:	0001                	nop
     13c:	0001                	nop
     13e:	70e2                	ld	ra,56(sp)
     140:	7442                	ld	s0,48(sp)
     142:	6121                	addi	sp,sp,64
     144:	8082                	ret

0000000000000146 <main>:

int
main(int argc, char *argv[])
{
     146:	7139                	addi	sp,sp,-64
     148:	fc06                	sd	ra,56(sp)
     14a:	f822                	sd	s0,48(sp)
     14c:	0080                	addi	s0,sp,64
     14e:	87aa                	mv	a5,a0
     150:	fcb43023          	sd	a1,-64(s0)
     154:	fcf42623          	sw	a5,-52(s0)
  int fd, i;
  char *pattern;

  if(argc <= 1){
     158:	fcc42783          	lw	a5,-52(s0)
     15c:	0007871b          	sext.w	a4,a5
     160:	4785                	li	a5,1
     162:	02e7c063          	blt	a5,a4,182 <main+0x3c>
    fprintf(2, "usage: grep pattern [file ...]\n");
     166:	00001597          	auipc	a1,0x1
     16a:	ffa58593          	addi	a1,a1,-6 # 1160 <malloc+0x146>
     16e:	4509                	li	a0,2
     170:	00001097          	auipc	ra,0x1
     174:	c60080e7          	jalr	-928(ra) # dd0 <fprintf>
    exit(1);
     178:	4505                	li	a0,1
     17a:	00000097          	auipc	ra,0x0
     17e:	74e080e7          	jalr	1870(ra) # 8c8 <exit>
  }
  pattern = argv[1];
     182:	fc043783          	ld	a5,-64(s0)
     186:	679c                	ld	a5,8(a5)
     188:	fef43023          	sd	a5,-32(s0)

  if(argc <= 2){
     18c:	fcc42783          	lw	a5,-52(s0)
     190:	0007871b          	sext.w	a4,a5
     194:	4789                	li	a5,2
     196:	00e7ce63          	blt	a5,a4,1b2 <main+0x6c>
    grep(pattern, 0);
     19a:	4581                	li	a1,0
     19c:	fe043503          	ld	a0,-32(s0)
     1a0:	00000097          	auipc	ra,0x0
     1a4:	e60080e7          	jalr	-416(ra) # 0 <grep>
    exit(0);
     1a8:	4501                	li	a0,0
     1aa:	00000097          	auipc	ra,0x0
     1ae:	71e080e7          	jalr	1822(ra) # 8c8 <exit>
  }

  for(i = 2; i < argc; i++){
     1b2:	4789                	li	a5,2
     1b4:	fef42623          	sw	a5,-20(s0)
     1b8:	a041                	j	238 <main+0xf2>
    if((fd = open(argv[i], 0)) < 0){
     1ba:	fec42783          	lw	a5,-20(s0)
     1be:	078e                	slli	a5,a5,0x3
     1c0:	fc043703          	ld	a4,-64(s0)
     1c4:	97ba                	add	a5,a5,a4
     1c6:	639c                	ld	a5,0(a5)
     1c8:	4581                	li	a1,0
     1ca:	853e                	mv	a0,a5
     1cc:	00000097          	auipc	ra,0x0
     1d0:	73c080e7          	jalr	1852(ra) # 908 <open>
     1d4:	87aa                	mv	a5,a0
     1d6:	fcf42e23          	sw	a5,-36(s0)
     1da:	fdc42783          	lw	a5,-36(s0)
     1de:	2781                	sext.w	a5,a5
     1e0:	0207d763          	bgez	a5,20e <main+0xc8>
      printf("grep: cannot open %s\n", argv[i]);
     1e4:	fec42783          	lw	a5,-20(s0)
     1e8:	078e                	slli	a5,a5,0x3
     1ea:	fc043703          	ld	a4,-64(s0)
     1ee:	97ba                	add	a5,a5,a4
     1f0:	639c                	ld	a5,0(a5)
     1f2:	85be                	mv	a1,a5
     1f4:	00001517          	auipc	a0,0x1
     1f8:	f8c50513          	addi	a0,a0,-116 # 1180 <malloc+0x166>
     1fc:	00001097          	auipc	ra,0x1
     200:	c2c080e7          	jalr	-980(ra) # e28 <printf>
      exit(1);
     204:	4505                	li	a0,1
     206:	00000097          	auipc	ra,0x0
     20a:	6c2080e7          	jalr	1730(ra) # 8c8 <exit>
    }
    grep(pattern, fd);
     20e:	fdc42783          	lw	a5,-36(s0)
     212:	85be                	mv	a1,a5
     214:	fe043503          	ld	a0,-32(s0)
     218:	00000097          	auipc	ra,0x0
     21c:	de8080e7          	jalr	-536(ra) # 0 <grep>
    close(fd);
     220:	fdc42783          	lw	a5,-36(s0)
     224:	853e                	mv	a0,a5
     226:	00000097          	auipc	ra,0x0
     22a:	6ca080e7          	jalr	1738(ra) # 8f0 <close>
  for(i = 2; i < argc; i++){
     22e:	fec42783          	lw	a5,-20(s0)
     232:	2785                	addiw	a5,a5,1
     234:	fef42623          	sw	a5,-20(s0)
     238:	fec42783          	lw	a5,-20(s0)
     23c:	873e                	mv	a4,a5
     23e:	fcc42783          	lw	a5,-52(s0)
     242:	2701                	sext.w	a4,a4
     244:	2781                	sext.w	a5,a5
     246:	f6f74ae3          	blt	a4,a5,1ba <main+0x74>
  }
  exit(0);
     24a:	4501                	li	a0,0
     24c:	00000097          	auipc	ra,0x0
     250:	67c080e7          	jalr	1660(ra) # 8c8 <exit>

0000000000000254 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     254:	1101                	addi	sp,sp,-32
     256:	ec06                	sd	ra,24(sp)
     258:	e822                	sd	s0,16(sp)
     25a:	1000                	addi	s0,sp,32
     25c:	fea43423          	sd	a0,-24(s0)
     260:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '^')
     264:	fe843783          	ld	a5,-24(s0)
     268:	0007c783          	lbu	a5,0(a5)
     26c:	873e                	mv	a4,a5
     26e:	05e00793          	li	a5,94
     272:	00f71e63          	bne	a4,a5,28e <match+0x3a>
    return matchhere(re+1, text);
     276:	fe843783          	ld	a5,-24(s0)
     27a:	0785                	addi	a5,a5,1
     27c:	fe043583          	ld	a1,-32(s0)
     280:	853e                	mv	a0,a5
     282:	00000097          	auipc	ra,0x0
     286:	042080e7          	jalr	66(ra) # 2c4 <matchhere>
     28a:	87aa                	mv	a5,a0
     28c:	a03d                	j	2ba <match+0x66>
  do{  // must look at empty string
    if(matchhere(re, text))
     28e:	fe043583          	ld	a1,-32(s0)
     292:	fe843503          	ld	a0,-24(s0)
     296:	00000097          	auipc	ra,0x0
     29a:	02e080e7          	jalr	46(ra) # 2c4 <matchhere>
     29e:	87aa                	mv	a5,a0
     2a0:	c399                	beqz	a5,2a6 <match+0x52>
      return 1;
     2a2:	4785                	li	a5,1
     2a4:	a819                	j	2ba <match+0x66>
  }while(*text++ != '\0');
     2a6:	fe043783          	ld	a5,-32(s0)
     2aa:	00178713          	addi	a4,a5,1
     2ae:	fee43023          	sd	a4,-32(s0)
     2b2:	0007c783          	lbu	a5,0(a5)
     2b6:	ffe1                	bnez	a5,28e <match+0x3a>
  return 0;
     2b8:	4781                	li	a5,0
}
     2ba:	853e                	mv	a0,a5
     2bc:	60e2                	ld	ra,24(sp)
     2be:	6442                	ld	s0,16(sp)
     2c0:	6105                	addi	sp,sp,32
     2c2:	8082                	ret

00000000000002c4 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     2c4:	1101                	addi	sp,sp,-32
     2c6:	ec06                	sd	ra,24(sp)
     2c8:	e822                	sd	s0,16(sp)
     2ca:	1000                	addi	s0,sp,32
     2cc:	fea43423          	sd	a0,-24(s0)
     2d0:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '\0')
     2d4:	fe843783          	ld	a5,-24(s0)
     2d8:	0007c783          	lbu	a5,0(a5)
     2dc:	e399                	bnez	a5,2e2 <matchhere+0x1e>
    return 1;
     2de:	4785                	li	a5,1
     2e0:	a0c1                	j	3a0 <matchhere+0xdc>
  if(re[1] == '*')
     2e2:	fe843783          	ld	a5,-24(s0)
     2e6:	0785                	addi	a5,a5,1
     2e8:	0007c783          	lbu	a5,0(a5)
     2ec:	873e                	mv	a4,a5
     2ee:	02a00793          	li	a5,42
     2f2:	02f71563          	bne	a4,a5,31c <matchhere+0x58>
    return matchstar(re[0], re+2, text);
     2f6:	fe843783          	ld	a5,-24(s0)
     2fa:	0007c783          	lbu	a5,0(a5)
     2fe:	0007871b          	sext.w	a4,a5
     302:	fe843783          	ld	a5,-24(s0)
     306:	0789                	addi	a5,a5,2
     308:	fe043603          	ld	a2,-32(s0)
     30c:	85be                	mv	a1,a5
     30e:	853a                	mv	a0,a4
     310:	00000097          	auipc	ra,0x0
     314:	09a080e7          	jalr	154(ra) # 3aa <matchstar>
     318:	87aa                	mv	a5,a0
     31a:	a059                	j	3a0 <matchhere+0xdc>
  if(re[0] == '$' && re[1] == '\0')
     31c:	fe843783          	ld	a5,-24(s0)
     320:	0007c783          	lbu	a5,0(a5)
     324:	873e                	mv	a4,a5
     326:	02400793          	li	a5,36
     32a:	02f71363          	bne	a4,a5,350 <matchhere+0x8c>
     32e:	fe843783          	ld	a5,-24(s0)
     332:	0785                	addi	a5,a5,1
     334:	0007c783          	lbu	a5,0(a5)
     338:	ef81                	bnez	a5,350 <matchhere+0x8c>
    return *text == '\0';
     33a:	fe043783          	ld	a5,-32(s0)
     33e:	0007c783          	lbu	a5,0(a5)
     342:	2781                	sext.w	a5,a5
     344:	0017b793          	seqz	a5,a5
     348:	0ff7f793          	zext.b	a5,a5
     34c:	2781                	sext.w	a5,a5
     34e:	a889                	j	3a0 <matchhere+0xdc>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     350:	fe043783          	ld	a5,-32(s0)
     354:	0007c783          	lbu	a5,0(a5)
     358:	c3b9                	beqz	a5,39e <matchhere+0xda>
     35a:	fe843783          	ld	a5,-24(s0)
     35e:	0007c783          	lbu	a5,0(a5)
     362:	873e                	mv	a4,a5
     364:	02e00793          	li	a5,46
     368:	00f70c63          	beq	a4,a5,380 <matchhere+0xbc>
     36c:	fe843783          	ld	a5,-24(s0)
     370:	0007c703          	lbu	a4,0(a5)
     374:	fe043783          	ld	a5,-32(s0)
     378:	0007c783          	lbu	a5,0(a5)
     37c:	02f71163          	bne	a4,a5,39e <matchhere+0xda>
    return matchhere(re+1, text+1);
     380:	fe843783          	ld	a5,-24(s0)
     384:	00178713          	addi	a4,a5,1
     388:	fe043783          	ld	a5,-32(s0)
     38c:	0785                	addi	a5,a5,1
     38e:	85be                	mv	a1,a5
     390:	853a                	mv	a0,a4
     392:	00000097          	auipc	ra,0x0
     396:	f32080e7          	jalr	-206(ra) # 2c4 <matchhere>
     39a:	87aa                	mv	a5,a0
     39c:	a011                	j	3a0 <matchhere+0xdc>
  return 0;
     39e:	4781                	li	a5,0
}
     3a0:	853e                	mv	a0,a5
     3a2:	60e2                	ld	ra,24(sp)
     3a4:	6442                	ld	s0,16(sp)
     3a6:	6105                	addi	sp,sp,32
     3a8:	8082                	ret

00000000000003aa <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     3aa:	7179                	addi	sp,sp,-48
     3ac:	f406                	sd	ra,40(sp)
     3ae:	f022                	sd	s0,32(sp)
     3b0:	1800                	addi	s0,sp,48
     3b2:	87aa                	mv	a5,a0
     3b4:	feb43023          	sd	a1,-32(s0)
     3b8:	fcc43c23          	sd	a2,-40(s0)
     3bc:	fef42623          	sw	a5,-20(s0)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     3c0:	fd843583          	ld	a1,-40(s0)
     3c4:	fe043503          	ld	a0,-32(s0)
     3c8:	00000097          	auipc	ra,0x0
     3cc:	efc080e7          	jalr	-260(ra) # 2c4 <matchhere>
     3d0:	87aa                	mv	a5,a0
     3d2:	c399                	beqz	a5,3d8 <matchstar+0x2e>
      return 1;
     3d4:	4785                	li	a5,1
     3d6:	a835                	j	412 <matchstar+0x68>
  }while(*text!='\0' && (*text++==c || c=='.'));
     3d8:	fd843783          	ld	a5,-40(s0)
     3dc:	0007c783          	lbu	a5,0(a5)
     3e0:	cb85                	beqz	a5,410 <matchstar+0x66>
     3e2:	fd843783          	ld	a5,-40(s0)
     3e6:	00178713          	addi	a4,a5,1
     3ea:	fce43c23          	sd	a4,-40(s0)
     3ee:	0007c783          	lbu	a5,0(a5)
     3f2:	0007871b          	sext.w	a4,a5
     3f6:	fec42783          	lw	a5,-20(s0)
     3fa:	2781                	sext.w	a5,a5
     3fc:	fce782e3          	beq	a5,a4,3c0 <matchstar+0x16>
     400:	fec42783          	lw	a5,-20(s0)
     404:	0007871b          	sext.w	a4,a5
     408:	02e00793          	li	a5,46
     40c:	faf70ae3          	beq	a4,a5,3c0 <matchstar+0x16>
  return 0;
     410:	4781                	li	a5,0
}
     412:	853e                	mv	a0,a5
     414:	70a2                	ld	ra,40(sp)
     416:	7402                	ld	s0,32(sp)
     418:	6145                	addi	sp,sp,48
     41a:	8082                	ret

000000000000041c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     41c:	1141                	addi	sp,sp,-16
     41e:	e406                	sd	ra,8(sp)
     420:	e022                	sd	s0,0(sp)
     422:	0800                	addi	s0,sp,16
  extern int main();
  main();
     424:	00000097          	auipc	ra,0x0
     428:	d22080e7          	jalr	-734(ra) # 146 <main>
  exit(0);
     42c:	4501                	li	a0,0
     42e:	00000097          	auipc	ra,0x0
     432:	49a080e7          	jalr	1178(ra) # 8c8 <exit>

0000000000000436 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     436:	7179                	addi	sp,sp,-48
     438:	f422                	sd	s0,40(sp)
     43a:	1800                	addi	s0,sp,48
     43c:	fca43c23          	sd	a0,-40(s0)
     440:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     444:	fd843783          	ld	a5,-40(s0)
     448:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     44c:	0001                	nop
     44e:	fd043703          	ld	a4,-48(s0)
     452:	00170793          	addi	a5,a4,1
     456:	fcf43823          	sd	a5,-48(s0)
     45a:	fd843783          	ld	a5,-40(s0)
     45e:	00178693          	addi	a3,a5,1
     462:	fcd43c23          	sd	a3,-40(s0)
     466:	00074703          	lbu	a4,0(a4)
     46a:	00e78023          	sb	a4,0(a5)
     46e:	0007c783          	lbu	a5,0(a5)
     472:	fff1                	bnez	a5,44e <strcpy+0x18>
    ;
  return os;
     474:	fe843783          	ld	a5,-24(s0)
}
     478:	853e                	mv	a0,a5
     47a:	7422                	ld	s0,40(sp)
     47c:	6145                	addi	sp,sp,48
     47e:	8082                	ret

0000000000000480 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     480:	1101                	addi	sp,sp,-32
     482:	ec22                	sd	s0,24(sp)
     484:	1000                	addi	s0,sp,32
     486:	fea43423          	sd	a0,-24(s0)
     48a:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     48e:	a819                	j	4a4 <strcmp+0x24>
    p++, q++;
     490:	fe843783          	ld	a5,-24(s0)
     494:	0785                	addi	a5,a5,1
     496:	fef43423          	sd	a5,-24(s0)
     49a:	fe043783          	ld	a5,-32(s0)
     49e:	0785                	addi	a5,a5,1
     4a0:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     4a4:	fe843783          	ld	a5,-24(s0)
     4a8:	0007c783          	lbu	a5,0(a5)
     4ac:	cb99                	beqz	a5,4c2 <strcmp+0x42>
     4ae:	fe843783          	ld	a5,-24(s0)
     4b2:	0007c703          	lbu	a4,0(a5)
     4b6:	fe043783          	ld	a5,-32(s0)
     4ba:	0007c783          	lbu	a5,0(a5)
     4be:	fcf709e3          	beq	a4,a5,490 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     4c2:	fe843783          	ld	a5,-24(s0)
     4c6:	0007c783          	lbu	a5,0(a5)
     4ca:	0007871b          	sext.w	a4,a5
     4ce:	fe043783          	ld	a5,-32(s0)
     4d2:	0007c783          	lbu	a5,0(a5)
     4d6:	2781                	sext.w	a5,a5
     4d8:	40f707bb          	subw	a5,a4,a5
     4dc:	2781                	sext.w	a5,a5
}
     4de:	853e                	mv	a0,a5
     4e0:	6462                	ld	s0,24(sp)
     4e2:	6105                	addi	sp,sp,32
     4e4:	8082                	ret

00000000000004e6 <strlen>:

uint
strlen(const char *s)
{
     4e6:	7179                	addi	sp,sp,-48
     4e8:	f422                	sd	s0,40(sp)
     4ea:	1800                	addi	s0,sp,48
     4ec:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     4f0:	fe042623          	sw	zero,-20(s0)
     4f4:	a031                	j	500 <strlen+0x1a>
     4f6:	fec42783          	lw	a5,-20(s0)
     4fa:	2785                	addiw	a5,a5,1
     4fc:	fef42623          	sw	a5,-20(s0)
     500:	fec42783          	lw	a5,-20(s0)
     504:	fd843703          	ld	a4,-40(s0)
     508:	97ba                	add	a5,a5,a4
     50a:	0007c783          	lbu	a5,0(a5)
     50e:	f7e5                	bnez	a5,4f6 <strlen+0x10>
    ;
  return n;
     510:	fec42783          	lw	a5,-20(s0)
}
     514:	853e                	mv	a0,a5
     516:	7422                	ld	s0,40(sp)
     518:	6145                	addi	sp,sp,48
     51a:	8082                	ret

000000000000051c <memset>:

void*
memset(void *dst, int c, uint n)
{
     51c:	7179                	addi	sp,sp,-48
     51e:	f422                	sd	s0,40(sp)
     520:	1800                	addi	s0,sp,48
     522:	fca43c23          	sd	a0,-40(s0)
     526:	87ae                	mv	a5,a1
     528:	8732                	mv	a4,a2
     52a:	fcf42a23          	sw	a5,-44(s0)
     52e:	87ba                	mv	a5,a4
     530:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     534:	fd843783          	ld	a5,-40(s0)
     538:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     53c:	fe042623          	sw	zero,-20(s0)
     540:	a00d                	j	562 <memset+0x46>
    cdst[i] = c;
     542:	fec42783          	lw	a5,-20(s0)
     546:	fe043703          	ld	a4,-32(s0)
     54a:	97ba                	add	a5,a5,a4
     54c:	fd442703          	lw	a4,-44(s0)
     550:	0ff77713          	zext.b	a4,a4
     554:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     558:	fec42783          	lw	a5,-20(s0)
     55c:	2785                	addiw	a5,a5,1
     55e:	fef42623          	sw	a5,-20(s0)
     562:	fec42703          	lw	a4,-20(s0)
     566:	fd042783          	lw	a5,-48(s0)
     56a:	2781                	sext.w	a5,a5
     56c:	fcf76be3          	bltu	a4,a5,542 <memset+0x26>
  }
  return dst;
     570:	fd843783          	ld	a5,-40(s0)
}
     574:	853e                	mv	a0,a5
     576:	7422                	ld	s0,40(sp)
     578:	6145                	addi	sp,sp,48
     57a:	8082                	ret

000000000000057c <strchr>:

char*
strchr(const char *s, char c)
{
     57c:	1101                	addi	sp,sp,-32
     57e:	ec22                	sd	s0,24(sp)
     580:	1000                	addi	s0,sp,32
     582:	fea43423          	sd	a0,-24(s0)
     586:	87ae                	mv	a5,a1
     588:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     58c:	a01d                	j	5b2 <strchr+0x36>
    if(*s == c)
     58e:	fe843783          	ld	a5,-24(s0)
     592:	0007c703          	lbu	a4,0(a5)
     596:	fe744783          	lbu	a5,-25(s0)
     59a:	0ff7f793          	zext.b	a5,a5
     59e:	00e79563          	bne	a5,a4,5a8 <strchr+0x2c>
      return (char*)s;
     5a2:	fe843783          	ld	a5,-24(s0)
     5a6:	a821                	j	5be <strchr+0x42>
  for(; *s; s++)
     5a8:	fe843783          	ld	a5,-24(s0)
     5ac:	0785                	addi	a5,a5,1
     5ae:	fef43423          	sd	a5,-24(s0)
     5b2:	fe843783          	ld	a5,-24(s0)
     5b6:	0007c783          	lbu	a5,0(a5)
     5ba:	fbf1                	bnez	a5,58e <strchr+0x12>
  return 0;
     5bc:	4781                	li	a5,0
}
     5be:	853e                	mv	a0,a5
     5c0:	6462                	ld	s0,24(sp)
     5c2:	6105                	addi	sp,sp,32
     5c4:	8082                	ret

00000000000005c6 <gets>:

char*
gets(char *buf, int max)
{
     5c6:	7179                	addi	sp,sp,-48
     5c8:	f406                	sd	ra,40(sp)
     5ca:	f022                	sd	s0,32(sp)
     5cc:	1800                	addi	s0,sp,48
     5ce:	fca43c23          	sd	a0,-40(s0)
     5d2:	87ae                	mv	a5,a1
     5d4:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     5d8:	fe042623          	sw	zero,-20(s0)
     5dc:	a8a1                	j	634 <gets+0x6e>
    cc = read(0, &c, 1);
     5de:	fe740793          	addi	a5,s0,-25
     5e2:	4605                	li	a2,1
     5e4:	85be                	mv	a1,a5
     5e6:	4501                	li	a0,0
     5e8:	00000097          	auipc	ra,0x0
     5ec:	2f8080e7          	jalr	760(ra) # 8e0 <read>
     5f0:	87aa                	mv	a5,a0
     5f2:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     5f6:	fe842783          	lw	a5,-24(s0)
     5fa:	2781                	sext.w	a5,a5
     5fc:	04f05763          	blez	a5,64a <gets+0x84>
      break;
    buf[i++] = c;
     600:	fec42783          	lw	a5,-20(s0)
     604:	0017871b          	addiw	a4,a5,1
     608:	fee42623          	sw	a4,-20(s0)
     60c:	873e                	mv	a4,a5
     60e:	fd843783          	ld	a5,-40(s0)
     612:	97ba                	add	a5,a5,a4
     614:	fe744703          	lbu	a4,-25(s0)
     618:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     61c:	fe744783          	lbu	a5,-25(s0)
     620:	873e                	mv	a4,a5
     622:	47a9                	li	a5,10
     624:	02f70463          	beq	a4,a5,64c <gets+0x86>
     628:	fe744783          	lbu	a5,-25(s0)
     62c:	873e                	mv	a4,a5
     62e:	47b5                	li	a5,13
     630:	00f70e63          	beq	a4,a5,64c <gets+0x86>
  for(i=0; i+1 < max; ){
     634:	fec42783          	lw	a5,-20(s0)
     638:	2785                	addiw	a5,a5,1
     63a:	0007871b          	sext.w	a4,a5
     63e:	fd442783          	lw	a5,-44(s0)
     642:	2781                	sext.w	a5,a5
     644:	f8f74de3          	blt	a4,a5,5de <gets+0x18>
     648:	a011                	j	64c <gets+0x86>
      break;
     64a:	0001                	nop
      break;
  }
  buf[i] = '\0';
     64c:	fec42783          	lw	a5,-20(s0)
     650:	fd843703          	ld	a4,-40(s0)
     654:	97ba                	add	a5,a5,a4
     656:	00078023          	sb	zero,0(a5)
  return buf;
     65a:	fd843783          	ld	a5,-40(s0)
}
     65e:	853e                	mv	a0,a5
     660:	70a2                	ld	ra,40(sp)
     662:	7402                	ld	s0,32(sp)
     664:	6145                	addi	sp,sp,48
     666:	8082                	ret

0000000000000668 <stat>:

int
stat(const char *n, struct stat *st)
{
     668:	7179                	addi	sp,sp,-48
     66a:	f406                	sd	ra,40(sp)
     66c:	f022                	sd	s0,32(sp)
     66e:	1800                	addi	s0,sp,48
     670:	fca43c23          	sd	a0,-40(s0)
     674:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     678:	4581                	li	a1,0
     67a:	fd843503          	ld	a0,-40(s0)
     67e:	00000097          	auipc	ra,0x0
     682:	28a080e7          	jalr	650(ra) # 908 <open>
     686:	87aa                	mv	a5,a0
     688:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     68c:	fec42783          	lw	a5,-20(s0)
     690:	2781                	sext.w	a5,a5
     692:	0007d463          	bgez	a5,69a <stat+0x32>
    return -1;
     696:	57fd                	li	a5,-1
     698:	a035                	j	6c4 <stat+0x5c>
  r = fstat(fd, st);
     69a:	fec42783          	lw	a5,-20(s0)
     69e:	fd043583          	ld	a1,-48(s0)
     6a2:	853e                	mv	a0,a5
     6a4:	00000097          	auipc	ra,0x0
     6a8:	27c080e7          	jalr	636(ra) # 920 <fstat>
     6ac:	87aa                	mv	a5,a0
     6ae:	fef42423          	sw	a5,-24(s0)
  close(fd);
     6b2:	fec42783          	lw	a5,-20(s0)
     6b6:	853e                	mv	a0,a5
     6b8:	00000097          	auipc	ra,0x0
     6bc:	238080e7          	jalr	568(ra) # 8f0 <close>
  return r;
     6c0:	fe842783          	lw	a5,-24(s0)
}
     6c4:	853e                	mv	a0,a5
     6c6:	70a2                	ld	ra,40(sp)
     6c8:	7402                	ld	s0,32(sp)
     6ca:	6145                	addi	sp,sp,48
     6cc:	8082                	ret

00000000000006ce <atoi>:

int
atoi(const char *s)
{
     6ce:	7179                	addi	sp,sp,-48
     6d0:	f422                	sd	s0,40(sp)
     6d2:	1800                	addi	s0,sp,48
     6d4:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     6d8:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     6dc:	a81d                	j	712 <atoi+0x44>
    n = n*10 + *s++ - '0';
     6de:	fec42783          	lw	a5,-20(s0)
     6e2:	873e                	mv	a4,a5
     6e4:	87ba                	mv	a5,a4
     6e6:	0027979b          	slliw	a5,a5,0x2
     6ea:	9fb9                	addw	a5,a5,a4
     6ec:	0017979b          	slliw	a5,a5,0x1
     6f0:	0007871b          	sext.w	a4,a5
     6f4:	fd843783          	ld	a5,-40(s0)
     6f8:	00178693          	addi	a3,a5,1
     6fc:	fcd43c23          	sd	a3,-40(s0)
     700:	0007c783          	lbu	a5,0(a5)
     704:	2781                	sext.w	a5,a5
     706:	9fb9                	addw	a5,a5,a4
     708:	2781                	sext.w	a5,a5
     70a:	fd07879b          	addiw	a5,a5,-48
     70e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     712:	fd843783          	ld	a5,-40(s0)
     716:	0007c783          	lbu	a5,0(a5)
     71a:	873e                	mv	a4,a5
     71c:	02f00793          	li	a5,47
     720:	00e7fb63          	bgeu	a5,a4,736 <atoi+0x68>
     724:	fd843783          	ld	a5,-40(s0)
     728:	0007c783          	lbu	a5,0(a5)
     72c:	873e                	mv	a4,a5
     72e:	03900793          	li	a5,57
     732:	fae7f6e3          	bgeu	a5,a4,6de <atoi+0x10>
  return n;
     736:	fec42783          	lw	a5,-20(s0)
}
     73a:	853e                	mv	a0,a5
     73c:	7422                	ld	s0,40(sp)
     73e:	6145                	addi	sp,sp,48
     740:	8082                	ret

0000000000000742 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     742:	7139                	addi	sp,sp,-64
     744:	fc22                	sd	s0,56(sp)
     746:	0080                	addi	s0,sp,64
     748:	fca43c23          	sd	a0,-40(s0)
     74c:	fcb43823          	sd	a1,-48(s0)
     750:	87b2                	mv	a5,a2
     752:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     756:	fd843783          	ld	a5,-40(s0)
     75a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     75e:	fd043783          	ld	a5,-48(s0)
     762:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     766:	fe043703          	ld	a4,-32(s0)
     76a:	fe843783          	ld	a5,-24(s0)
     76e:	02e7fc63          	bgeu	a5,a4,7a6 <memmove+0x64>
    while(n-- > 0)
     772:	a00d                	j	794 <memmove+0x52>
      *dst++ = *src++;
     774:	fe043703          	ld	a4,-32(s0)
     778:	00170793          	addi	a5,a4,1
     77c:	fef43023          	sd	a5,-32(s0)
     780:	fe843783          	ld	a5,-24(s0)
     784:	00178693          	addi	a3,a5,1
     788:	fed43423          	sd	a3,-24(s0)
     78c:	00074703          	lbu	a4,0(a4)
     790:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     794:	fcc42783          	lw	a5,-52(s0)
     798:	fff7871b          	addiw	a4,a5,-1
     79c:	fce42623          	sw	a4,-52(s0)
     7a0:	fcf04ae3          	bgtz	a5,774 <memmove+0x32>
     7a4:	a891                	j	7f8 <memmove+0xb6>
  } else {
    dst += n;
     7a6:	fcc42783          	lw	a5,-52(s0)
     7aa:	fe843703          	ld	a4,-24(s0)
     7ae:	97ba                	add	a5,a5,a4
     7b0:	fef43423          	sd	a5,-24(s0)
    src += n;
     7b4:	fcc42783          	lw	a5,-52(s0)
     7b8:	fe043703          	ld	a4,-32(s0)
     7bc:	97ba                	add	a5,a5,a4
     7be:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     7c2:	a01d                	j	7e8 <memmove+0xa6>
      *--dst = *--src;
     7c4:	fe043783          	ld	a5,-32(s0)
     7c8:	17fd                	addi	a5,a5,-1
     7ca:	fef43023          	sd	a5,-32(s0)
     7ce:	fe843783          	ld	a5,-24(s0)
     7d2:	17fd                	addi	a5,a5,-1
     7d4:	fef43423          	sd	a5,-24(s0)
     7d8:	fe043783          	ld	a5,-32(s0)
     7dc:	0007c703          	lbu	a4,0(a5)
     7e0:	fe843783          	ld	a5,-24(s0)
     7e4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     7e8:	fcc42783          	lw	a5,-52(s0)
     7ec:	fff7871b          	addiw	a4,a5,-1
     7f0:	fce42623          	sw	a4,-52(s0)
     7f4:	fcf048e3          	bgtz	a5,7c4 <memmove+0x82>
  }
  return vdst;
     7f8:	fd843783          	ld	a5,-40(s0)
}
     7fc:	853e                	mv	a0,a5
     7fe:	7462                	ld	s0,56(sp)
     800:	6121                	addi	sp,sp,64
     802:	8082                	ret

0000000000000804 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     804:	7139                	addi	sp,sp,-64
     806:	fc22                	sd	s0,56(sp)
     808:	0080                	addi	s0,sp,64
     80a:	fca43c23          	sd	a0,-40(s0)
     80e:	fcb43823          	sd	a1,-48(s0)
     812:	87b2                	mv	a5,a2
     814:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     818:	fd843783          	ld	a5,-40(s0)
     81c:	fef43423          	sd	a5,-24(s0)
     820:	fd043783          	ld	a5,-48(s0)
     824:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     828:	a0a1                	j	870 <memcmp+0x6c>
    if (*p1 != *p2) {
     82a:	fe843783          	ld	a5,-24(s0)
     82e:	0007c703          	lbu	a4,0(a5)
     832:	fe043783          	ld	a5,-32(s0)
     836:	0007c783          	lbu	a5,0(a5)
     83a:	02f70163          	beq	a4,a5,85c <memcmp+0x58>
      return *p1 - *p2;
     83e:	fe843783          	ld	a5,-24(s0)
     842:	0007c783          	lbu	a5,0(a5)
     846:	0007871b          	sext.w	a4,a5
     84a:	fe043783          	ld	a5,-32(s0)
     84e:	0007c783          	lbu	a5,0(a5)
     852:	2781                	sext.w	a5,a5
     854:	40f707bb          	subw	a5,a4,a5
     858:	2781                	sext.w	a5,a5
     85a:	a01d                	j	880 <memcmp+0x7c>
    }
    p1++;
     85c:	fe843783          	ld	a5,-24(s0)
     860:	0785                	addi	a5,a5,1
     862:	fef43423          	sd	a5,-24(s0)
    p2++;
     866:	fe043783          	ld	a5,-32(s0)
     86a:	0785                	addi	a5,a5,1
     86c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     870:	fcc42783          	lw	a5,-52(s0)
     874:	fff7871b          	addiw	a4,a5,-1
     878:	fce42623          	sw	a4,-52(s0)
     87c:	f7dd                	bnez	a5,82a <memcmp+0x26>
  }
  return 0;
     87e:	4781                	li	a5,0
}
     880:	853e                	mv	a0,a5
     882:	7462                	ld	s0,56(sp)
     884:	6121                	addi	sp,sp,64
     886:	8082                	ret

0000000000000888 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     888:	7179                	addi	sp,sp,-48
     88a:	f406                	sd	ra,40(sp)
     88c:	f022                	sd	s0,32(sp)
     88e:	1800                	addi	s0,sp,48
     890:	fea43423          	sd	a0,-24(s0)
     894:	feb43023          	sd	a1,-32(s0)
     898:	87b2                	mv	a5,a2
     89a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     89e:	fdc42783          	lw	a5,-36(s0)
     8a2:	863e                	mv	a2,a5
     8a4:	fe043583          	ld	a1,-32(s0)
     8a8:	fe843503          	ld	a0,-24(s0)
     8ac:	00000097          	auipc	ra,0x0
     8b0:	e96080e7          	jalr	-362(ra) # 742 <memmove>
     8b4:	87aa                	mv	a5,a0
}
     8b6:	853e                	mv	a0,a5
     8b8:	70a2                	ld	ra,40(sp)
     8ba:	7402                	ld	s0,32(sp)
     8bc:	6145                	addi	sp,sp,48
     8be:	8082                	ret

00000000000008c0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     8c0:	4885                	li	a7,1
 ecall
     8c2:	00000073          	ecall
 ret
     8c6:	8082                	ret

00000000000008c8 <exit>:
.global exit
exit:
 li a7, SYS_exit
     8c8:	4889                	li	a7,2
 ecall
     8ca:	00000073          	ecall
 ret
     8ce:	8082                	ret

00000000000008d0 <wait>:
.global wait
wait:
 li a7, SYS_wait
     8d0:	488d                	li	a7,3
 ecall
     8d2:	00000073          	ecall
 ret
     8d6:	8082                	ret

00000000000008d8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     8d8:	4891                	li	a7,4
 ecall
     8da:	00000073          	ecall
 ret
     8de:	8082                	ret

00000000000008e0 <read>:
.global read
read:
 li a7, SYS_read
     8e0:	4895                	li	a7,5
 ecall
     8e2:	00000073          	ecall
 ret
     8e6:	8082                	ret

00000000000008e8 <write>:
.global write
write:
 li a7, SYS_write
     8e8:	48c1                	li	a7,16
 ecall
     8ea:	00000073          	ecall
 ret
     8ee:	8082                	ret

00000000000008f0 <close>:
.global close
close:
 li a7, SYS_close
     8f0:	48d5                	li	a7,21
 ecall
     8f2:	00000073          	ecall
 ret
     8f6:	8082                	ret

00000000000008f8 <kill>:
.global kill
kill:
 li a7, SYS_kill
     8f8:	4899                	li	a7,6
 ecall
     8fa:	00000073          	ecall
 ret
     8fe:	8082                	ret

0000000000000900 <exec>:
.global exec
exec:
 li a7, SYS_exec
     900:	489d                	li	a7,7
 ecall
     902:	00000073          	ecall
 ret
     906:	8082                	ret

0000000000000908 <open>:
.global open
open:
 li a7, SYS_open
     908:	48bd                	li	a7,15
 ecall
     90a:	00000073          	ecall
 ret
     90e:	8082                	ret

0000000000000910 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     910:	48c5                	li	a7,17
 ecall
     912:	00000073          	ecall
 ret
     916:	8082                	ret

0000000000000918 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     918:	48c9                	li	a7,18
 ecall
     91a:	00000073          	ecall
 ret
     91e:	8082                	ret

0000000000000920 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     920:	48a1                	li	a7,8
 ecall
     922:	00000073          	ecall
 ret
     926:	8082                	ret

0000000000000928 <link>:
.global link
link:
 li a7, SYS_link
     928:	48cd                	li	a7,19
 ecall
     92a:	00000073          	ecall
 ret
     92e:	8082                	ret

0000000000000930 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     930:	48d1                	li	a7,20
 ecall
     932:	00000073          	ecall
 ret
     936:	8082                	ret

0000000000000938 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     938:	48a5                	li	a7,9
 ecall
     93a:	00000073          	ecall
 ret
     93e:	8082                	ret

0000000000000940 <dup>:
.global dup
dup:
 li a7, SYS_dup
     940:	48a9                	li	a7,10
 ecall
     942:	00000073          	ecall
 ret
     946:	8082                	ret

0000000000000948 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     948:	48ad                	li	a7,11
 ecall
     94a:	00000073          	ecall
 ret
     94e:	8082                	ret

0000000000000950 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     950:	48b1                	li	a7,12
 ecall
     952:	00000073          	ecall
 ret
     956:	8082                	ret

0000000000000958 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     958:	48b5                	li	a7,13
 ecall
     95a:	00000073          	ecall
 ret
     95e:	8082                	ret

0000000000000960 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     960:	48b9                	li	a7,14
 ecall
     962:	00000073          	ecall
 ret
     966:	8082                	ret

0000000000000968 <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
     968:	48d9                	li	a7,22
 ecall
     96a:	00000073          	ecall
 ret
     96e:	8082                	ret

0000000000000970 <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
     970:	48dd                	li	a7,23
 ecall
     972:	00000073          	ecall
 ret
     976:	8082                	ret

0000000000000978 <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
     978:	48e1                	li	a7,24
 ecall
     97a:	00000073          	ecall
 ret
     97e:	8082                	ret

0000000000000980 <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
     980:	48e5                	li	a7,25
 ecall
     982:	00000073          	ecall
 ret
     986:	8082                	ret

0000000000000988 <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
     988:	48e9                	li	a7,26
 ecall
     98a:	00000073          	ecall
 ret
     98e:	8082                	ret

0000000000000990 <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
     990:	48ed                	li	a7,27
 ecall
     992:	00000073          	ecall
 ret
     996:	8082                	ret

0000000000000998 <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
     998:	48f1                	li	a7,28
 ecall
     99a:	00000073          	ecall
 ret
     99e:	8082                	ret

00000000000009a0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     9a0:	1101                	addi	sp,sp,-32
     9a2:	ec06                	sd	ra,24(sp)
     9a4:	e822                	sd	s0,16(sp)
     9a6:	1000                	addi	s0,sp,32
     9a8:	87aa                	mv	a5,a0
     9aa:	872e                	mv	a4,a1
     9ac:	fef42623          	sw	a5,-20(s0)
     9b0:	87ba                	mv	a5,a4
     9b2:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     9b6:	feb40713          	addi	a4,s0,-21
     9ba:	fec42783          	lw	a5,-20(s0)
     9be:	4605                	li	a2,1
     9c0:	85ba                	mv	a1,a4
     9c2:	853e                	mv	a0,a5
     9c4:	00000097          	auipc	ra,0x0
     9c8:	f24080e7          	jalr	-220(ra) # 8e8 <write>
}
     9cc:	0001                	nop
     9ce:	60e2                	ld	ra,24(sp)
     9d0:	6442                	ld	s0,16(sp)
     9d2:	6105                	addi	sp,sp,32
     9d4:	8082                	ret

00000000000009d6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     9d6:	7139                	addi	sp,sp,-64
     9d8:	fc06                	sd	ra,56(sp)
     9da:	f822                	sd	s0,48(sp)
     9dc:	0080                	addi	s0,sp,64
     9de:	87aa                	mv	a5,a0
     9e0:	8736                	mv	a4,a3
     9e2:	fcf42623          	sw	a5,-52(s0)
     9e6:	87ae                	mv	a5,a1
     9e8:	fcf42423          	sw	a5,-56(s0)
     9ec:	87b2                	mv	a5,a2
     9ee:	fcf42223          	sw	a5,-60(s0)
     9f2:	87ba                	mv	a5,a4
     9f4:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     9f8:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     9fc:	fc042783          	lw	a5,-64(s0)
     a00:	2781                	sext.w	a5,a5
     a02:	c38d                	beqz	a5,a24 <printint+0x4e>
     a04:	fc842783          	lw	a5,-56(s0)
     a08:	2781                	sext.w	a5,a5
     a0a:	0007dd63          	bgez	a5,a24 <printint+0x4e>
    neg = 1;
     a0e:	4785                	li	a5,1
     a10:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     a14:	fc842783          	lw	a5,-56(s0)
     a18:	40f007bb          	negw	a5,a5
     a1c:	2781                	sext.w	a5,a5
     a1e:	fef42223          	sw	a5,-28(s0)
     a22:	a029                	j	a2c <printint+0x56>
  } else {
    x = xx;
     a24:	fc842783          	lw	a5,-56(s0)
     a28:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     a2c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     a30:	fc442783          	lw	a5,-60(s0)
     a34:	fe442703          	lw	a4,-28(s0)
     a38:	02f777bb          	remuw	a5,a4,a5
     a3c:	0007861b          	sext.w	a2,a5
     a40:	fec42783          	lw	a5,-20(s0)
     a44:	0017871b          	addiw	a4,a5,1
     a48:	fee42623          	sw	a4,-20(s0)
     a4c:	00002697          	auipc	a3,0x2
     a50:	9c468693          	addi	a3,a3,-1596 # 2410 <digits>
     a54:	02061713          	slli	a4,a2,0x20
     a58:	9301                	srli	a4,a4,0x20
     a5a:	9736                	add	a4,a4,a3
     a5c:	00074703          	lbu	a4,0(a4)
     a60:	17c1                	addi	a5,a5,-16
     a62:	97a2                	add	a5,a5,s0
     a64:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     a68:	fc442783          	lw	a5,-60(s0)
     a6c:	fe442703          	lw	a4,-28(s0)
     a70:	02f757bb          	divuw	a5,a4,a5
     a74:	fef42223          	sw	a5,-28(s0)
     a78:	fe442783          	lw	a5,-28(s0)
     a7c:	2781                	sext.w	a5,a5
     a7e:	fbcd                	bnez	a5,a30 <printint+0x5a>
  if(neg)
     a80:	fe842783          	lw	a5,-24(s0)
     a84:	2781                	sext.w	a5,a5
     a86:	cf85                	beqz	a5,abe <printint+0xe8>
    buf[i++] = '-';
     a88:	fec42783          	lw	a5,-20(s0)
     a8c:	0017871b          	addiw	a4,a5,1
     a90:	fee42623          	sw	a4,-20(s0)
     a94:	17c1                	addi	a5,a5,-16
     a96:	97a2                	add	a5,a5,s0
     a98:	02d00713          	li	a4,45
     a9c:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     aa0:	a839                	j	abe <printint+0xe8>
    putc(fd, buf[i]);
     aa2:	fec42783          	lw	a5,-20(s0)
     aa6:	17c1                	addi	a5,a5,-16
     aa8:	97a2                	add	a5,a5,s0
     aaa:	fe07c703          	lbu	a4,-32(a5)
     aae:	fcc42783          	lw	a5,-52(s0)
     ab2:	85ba                	mv	a1,a4
     ab4:	853e                	mv	a0,a5
     ab6:	00000097          	auipc	ra,0x0
     aba:	eea080e7          	jalr	-278(ra) # 9a0 <putc>
  while(--i >= 0)
     abe:	fec42783          	lw	a5,-20(s0)
     ac2:	37fd                	addiw	a5,a5,-1
     ac4:	fef42623          	sw	a5,-20(s0)
     ac8:	fec42783          	lw	a5,-20(s0)
     acc:	2781                	sext.w	a5,a5
     ace:	fc07dae3          	bgez	a5,aa2 <printint+0xcc>
}
     ad2:	0001                	nop
     ad4:	0001                	nop
     ad6:	70e2                	ld	ra,56(sp)
     ad8:	7442                	ld	s0,48(sp)
     ada:	6121                	addi	sp,sp,64
     adc:	8082                	ret

0000000000000ade <printptr>:

static void
printptr(int fd, uint64 x) {
     ade:	7179                	addi	sp,sp,-48
     ae0:	f406                	sd	ra,40(sp)
     ae2:	f022                	sd	s0,32(sp)
     ae4:	1800                	addi	s0,sp,48
     ae6:	87aa                	mv	a5,a0
     ae8:	fcb43823          	sd	a1,-48(s0)
     aec:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     af0:	fdc42783          	lw	a5,-36(s0)
     af4:	03000593          	li	a1,48
     af8:	853e                	mv	a0,a5
     afa:	00000097          	auipc	ra,0x0
     afe:	ea6080e7          	jalr	-346(ra) # 9a0 <putc>
  putc(fd, 'x');
     b02:	fdc42783          	lw	a5,-36(s0)
     b06:	07800593          	li	a1,120
     b0a:	853e                	mv	a0,a5
     b0c:	00000097          	auipc	ra,0x0
     b10:	e94080e7          	jalr	-364(ra) # 9a0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b14:	fe042623          	sw	zero,-20(s0)
     b18:	a82d                	j	b52 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     b1a:	fd043783          	ld	a5,-48(s0)
     b1e:	93f1                	srli	a5,a5,0x3c
     b20:	00002717          	auipc	a4,0x2
     b24:	8f070713          	addi	a4,a4,-1808 # 2410 <digits>
     b28:	97ba                	add	a5,a5,a4
     b2a:	0007c703          	lbu	a4,0(a5)
     b2e:	fdc42783          	lw	a5,-36(s0)
     b32:	85ba                	mv	a1,a4
     b34:	853e                	mv	a0,a5
     b36:	00000097          	auipc	ra,0x0
     b3a:	e6a080e7          	jalr	-406(ra) # 9a0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b3e:	fec42783          	lw	a5,-20(s0)
     b42:	2785                	addiw	a5,a5,1
     b44:	fef42623          	sw	a5,-20(s0)
     b48:	fd043783          	ld	a5,-48(s0)
     b4c:	0792                	slli	a5,a5,0x4
     b4e:	fcf43823          	sd	a5,-48(s0)
     b52:	fec42783          	lw	a5,-20(s0)
     b56:	873e                	mv	a4,a5
     b58:	47bd                	li	a5,15
     b5a:	fce7f0e3          	bgeu	a5,a4,b1a <printptr+0x3c>
}
     b5e:	0001                	nop
     b60:	0001                	nop
     b62:	70a2                	ld	ra,40(sp)
     b64:	7402                	ld	s0,32(sp)
     b66:	6145                	addi	sp,sp,48
     b68:	8082                	ret

0000000000000b6a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     b6a:	715d                	addi	sp,sp,-80
     b6c:	e486                	sd	ra,72(sp)
     b6e:	e0a2                	sd	s0,64(sp)
     b70:	0880                	addi	s0,sp,80
     b72:	87aa                	mv	a5,a0
     b74:	fcb43023          	sd	a1,-64(s0)
     b78:	fac43c23          	sd	a2,-72(s0)
     b7c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     b80:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b84:	fe042223          	sw	zero,-28(s0)
     b88:	a42d                	j	db2 <vprintf+0x248>
    c = fmt[i] & 0xff;
     b8a:	fe442783          	lw	a5,-28(s0)
     b8e:	fc043703          	ld	a4,-64(s0)
     b92:	97ba                	add	a5,a5,a4
     b94:	0007c783          	lbu	a5,0(a5)
     b98:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     b9c:	fe042783          	lw	a5,-32(s0)
     ba0:	2781                	sext.w	a5,a5
     ba2:	eb9d                	bnez	a5,bd8 <vprintf+0x6e>
      if(c == '%'){
     ba4:	fdc42783          	lw	a5,-36(s0)
     ba8:	0007871b          	sext.w	a4,a5
     bac:	02500793          	li	a5,37
     bb0:	00f71763          	bne	a4,a5,bbe <vprintf+0x54>
        state = '%';
     bb4:	02500793          	li	a5,37
     bb8:	fef42023          	sw	a5,-32(s0)
     bbc:	a2f5                	j	da8 <vprintf+0x23e>
      } else {
        putc(fd, c);
     bbe:	fdc42783          	lw	a5,-36(s0)
     bc2:	0ff7f713          	zext.b	a4,a5
     bc6:	fcc42783          	lw	a5,-52(s0)
     bca:	85ba                	mv	a1,a4
     bcc:	853e                	mv	a0,a5
     bce:	00000097          	auipc	ra,0x0
     bd2:	dd2080e7          	jalr	-558(ra) # 9a0 <putc>
     bd6:	aac9                	j	da8 <vprintf+0x23e>
      }
    } else if(state == '%'){
     bd8:	fe042783          	lw	a5,-32(s0)
     bdc:	0007871b          	sext.w	a4,a5
     be0:	02500793          	li	a5,37
     be4:	1cf71263          	bne	a4,a5,da8 <vprintf+0x23e>
      if(c == 'd'){
     be8:	fdc42783          	lw	a5,-36(s0)
     bec:	0007871b          	sext.w	a4,a5
     bf0:	06400793          	li	a5,100
     bf4:	02f71463          	bne	a4,a5,c1c <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     bf8:	fb843783          	ld	a5,-72(s0)
     bfc:	00878713          	addi	a4,a5,8
     c00:	fae43c23          	sd	a4,-72(s0)
     c04:	4398                	lw	a4,0(a5)
     c06:	fcc42783          	lw	a5,-52(s0)
     c0a:	4685                	li	a3,1
     c0c:	4629                	li	a2,10
     c0e:	85ba                	mv	a1,a4
     c10:	853e                	mv	a0,a5
     c12:	00000097          	auipc	ra,0x0
     c16:	dc4080e7          	jalr	-572(ra) # 9d6 <printint>
     c1a:	a269                	j	da4 <vprintf+0x23a>
      } else if(c == 'l') {
     c1c:	fdc42783          	lw	a5,-36(s0)
     c20:	0007871b          	sext.w	a4,a5
     c24:	06c00793          	li	a5,108
     c28:	02f71663          	bne	a4,a5,c54 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     c2c:	fb843783          	ld	a5,-72(s0)
     c30:	00878713          	addi	a4,a5,8
     c34:	fae43c23          	sd	a4,-72(s0)
     c38:	639c                	ld	a5,0(a5)
     c3a:	0007871b          	sext.w	a4,a5
     c3e:	fcc42783          	lw	a5,-52(s0)
     c42:	4681                	li	a3,0
     c44:	4629                	li	a2,10
     c46:	85ba                	mv	a1,a4
     c48:	853e                	mv	a0,a5
     c4a:	00000097          	auipc	ra,0x0
     c4e:	d8c080e7          	jalr	-628(ra) # 9d6 <printint>
     c52:	aa89                	j	da4 <vprintf+0x23a>
      } else if(c == 'x') {
     c54:	fdc42783          	lw	a5,-36(s0)
     c58:	0007871b          	sext.w	a4,a5
     c5c:	07800793          	li	a5,120
     c60:	02f71463          	bne	a4,a5,c88 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     c64:	fb843783          	ld	a5,-72(s0)
     c68:	00878713          	addi	a4,a5,8
     c6c:	fae43c23          	sd	a4,-72(s0)
     c70:	4398                	lw	a4,0(a5)
     c72:	fcc42783          	lw	a5,-52(s0)
     c76:	4681                	li	a3,0
     c78:	4641                	li	a2,16
     c7a:	85ba                	mv	a1,a4
     c7c:	853e                	mv	a0,a5
     c7e:	00000097          	auipc	ra,0x0
     c82:	d58080e7          	jalr	-680(ra) # 9d6 <printint>
     c86:	aa39                	j	da4 <vprintf+0x23a>
      } else if(c == 'p') {
     c88:	fdc42783          	lw	a5,-36(s0)
     c8c:	0007871b          	sext.w	a4,a5
     c90:	07000793          	li	a5,112
     c94:	02f71263          	bne	a4,a5,cb8 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     c98:	fb843783          	ld	a5,-72(s0)
     c9c:	00878713          	addi	a4,a5,8
     ca0:	fae43c23          	sd	a4,-72(s0)
     ca4:	6398                	ld	a4,0(a5)
     ca6:	fcc42783          	lw	a5,-52(s0)
     caa:	85ba                	mv	a1,a4
     cac:	853e                	mv	a0,a5
     cae:	00000097          	auipc	ra,0x0
     cb2:	e30080e7          	jalr	-464(ra) # ade <printptr>
     cb6:	a0fd                	j	da4 <vprintf+0x23a>
      } else if(c == 's'){
     cb8:	fdc42783          	lw	a5,-36(s0)
     cbc:	0007871b          	sext.w	a4,a5
     cc0:	07300793          	li	a5,115
     cc4:	04f71c63          	bne	a4,a5,d1c <vprintf+0x1b2>
        s = va_arg(ap, char*);
     cc8:	fb843783          	ld	a5,-72(s0)
     ccc:	00878713          	addi	a4,a5,8
     cd0:	fae43c23          	sd	a4,-72(s0)
     cd4:	639c                	ld	a5,0(a5)
     cd6:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     cda:	fe843783          	ld	a5,-24(s0)
     cde:	eb8d                	bnez	a5,d10 <vprintf+0x1a6>
          s = "(null)";
     ce0:	00000797          	auipc	a5,0x0
     ce4:	4b878793          	addi	a5,a5,1208 # 1198 <malloc+0x17e>
     ce8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     cec:	a015                	j	d10 <vprintf+0x1a6>
          putc(fd, *s);
     cee:	fe843783          	ld	a5,-24(s0)
     cf2:	0007c703          	lbu	a4,0(a5)
     cf6:	fcc42783          	lw	a5,-52(s0)
     cfa:	85ba                	mv	a1,a4
     cfc:	853e                	mv	a0,a5
     cfe:	00000097          	auipc	ra,0x0
     d02:	ca2080e7          	jalr	-862(ra) # 9a0 <putc>
          s++;
     d06:	fe843783          	ld	a5,-24(s0)
     d0a:	0785                	addi	a5,a5,1
     d0c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	0007c783          	lbu	a5,0(a5)
     d18:	fbf9                	bnez	a5,cee <vprintf+0x184>
     d1a:	a069                	j	da4 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     d1c:	fdc42783          	lw	a5,-36(s0)
     d20:	0007871b          	sext.w	a4,a5
     d24:	06300793          	li	a5,99
     d28:	02f71463          	bne	a4,a5,d50 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     d2c:	fb843783          	ld	a5,-72(s0)
     d30:	00878713          	addi	a4,a5,8
     d34:	fae43c23          	sd	a4,-72(s0)
     d38:	439c                	lw	a5,0(a5)
     d3a:	0ff7f713          	zext.b	a4,a5
     d3e:	fcc42783          	lw	a5,-52(s0)
     d42:	85ba                	mv	a1,a4
     d44:	853e                	mv	a0,a5
     d46:	00000097          	auipc	ra,0x0
     d4a:	c5a080e7          	jalr	-934(ra) # 9a0 <putc>
     d4e:	a899                	j	da4 <vprintf+0x23a>
      } else if(c == '%'){
     d50:	fdc42783          	lw	a5,-36(s0)
     d54:	0007871b          	sext.w	a4,a5
     d58:	02500793          	li	a5,37
     d5c:	00f71f63          	bne	a4,a5,d7a <vprintf+0x210>
        putc(fd, c);
     d60:	fdc42783          	lw	a5,-36(s0)
     d64:	0ff7f713          	zext.b	a4,a5
     d68:	fcc42783          	lw	a5,-52(s0)
     d6c:	85ba                	mv	a1,a4
     d6e:	853e                	mv	a0,a5
     d70:	00000097          	auipc	ra,0x0
     d74:	c30080e7          	jalr	-976(ra) # 9a0 <putc>
     d78:	a035                	j	da4 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d7a:	fcc42783          	lw	a5,-52(s0)
     d7e:	02500593          	li	a1,37
     d82:	853e                	mv	a0,a5
     d84:	00000097          	auipc	ra,0x0
     d88:	c1c080e7          	jalr	-996(ra) # 9a0 <putc>
        putc(fd, c);
     d8c:	fdc42783          	lw	a5,-36(s0)
     d90:	0ff7f713          	zext.b	a4,a5
     d94:	fcc42783          	lw	a5,-52(s0)
     d98:	85ba                	mv	a1,a4
     d9a:	853e                	mv	a0,a5
     d9c:	00000097          	auipc	ra,0x0
     da0:	c04080e7          	jalr	-1020(ra) # 9a0 <putc>
      }
      state = 0;
     da4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     da8:	fe442783          	lw	a5,-28(s0)
     dac:	2785                	addiw	a5,a5,1
     dae:	fef42223          	sw	a5,-28(s0)
     db2:	fe442783          	lw	a5,-28(s0)
     db6:	fc043703          	ld	a4,-64(s0)
     dba:	97ba                	add	a5,a5,a4
     dbc:	0007c783          	lbu	a5,0(a5)
     dc0:	dc0795e3          	bnez	a5,b8a <vprintf+0x20>
    }
  }
}
     dc4:	0001                	nop
     dc6:	0001                	nop
     dc8:	60a6                	ld	ra,72(sp)
     dca:	6406                	ld	s0,64(sp)
     dcc:	6161                	addi	sp,sp,80
     dce:	8082                	ret

0000000000000dd0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     dd0:	7159                	addi	sp,sp,-112
     dd2:	fc06                	sd	ra,56(sp)
     dd4:	f822                	sd	s0,48(sp)
     dd6:	0080                	addi	s0,sp,64
     dd8:	fcb43823          	sd	a1,-48(s0)
     ddc:	e010                	sd	a2,0(s0)
     dde:	e414                	sd	a3,8(s0)
     de0:	e818                	sd	a4,16(s0)
     de2:	ec1c                	sd	a5,24(s0)
     de4:	03043023          	sd	a6,32(s0)
     de8:	03143423          	sd	a7,40(s0)
     dec:	87aa                	mv	a5,a0
     dee:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     df2:	03040793          	addi	a5,s0,48
     df6:	fcf43423          	sd	a5,-56(s0)
     dfa:	fc843783          	ld	a5,-56(s0)
     dfe:	fd078793          	addi	a5,a5,-48
     e02:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     e06:	fe843703          	ld	a4,-24(s0)
     e0a:	fdc42783          	lw	a5,-36(s0)
     e0e:	863a                	mv	a2,a4
     e10:	fd043583          	ld	a1,-48(s0)
     e14:	853e                	mv	a0,a5
     e16:	00000097          	auipc	ra,0x0
     e1a:	d54080e7          	jalr	-684(ra) # b6a <vprintf>
}
     e1e:	0001                	nop
     e20:	70e2                	ld	ra,56(sp)
     e22:	7442                	ld	s0,48(sp)
     e24:	6165                	addi	sp,sp,112
     e26:	8082                	ret

0000000000000e28 <printf>:

void
printf(const char *fmt, ...)
{
     e28:	7159                	addi	sp,sp,-112
     e2a:	f406                	sd	ra,40(sp)
     e2c:	f022                	sd	s0,32(sp)
     e2e:	1800                	addi	s0,sp,48
     e30:	fca43c23          	sd	a0,-40(s0)
     e34:	e40c                	sd	a1,8(s0)
     e36:	e810                	sd	a2,16(s0)
     e38:	ec14                	sd	a3,24(s0)
     e3a:	f018                	sd	a4,32(s0)
     e3c:	f41c                	sd	a5,40(s0)
     e3e:	03043823          	sd	a6,48(s0)
     e42:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     e46:	04040793          	addi	a5,s0,64
     e4a:	fcf43823          	sd	a5,-48(s0)
     e4e:	fd043783          	ld	a5,-48(s0)
     e52:	fc878793          	addi	a5,a5,-56
     e56:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     e5a:	fe843783          	ld	a5,-24(s0)
     e5e:	863e                	mv	a2,a5
     e60:	fd843583          	ld	a1,-40(s0)
     e64:	4505                	li	a0,1
     e66:	00000097          	auipc	ra,0x0
     e6a:	d04080e7          	jalr	-764(ra) # b6a <vprintf>
}
     e6e:	0001                	nop
     e70:	70a2                	ld	ra,40(sp)
     e72:	7402                	ld	s0,32(sp)
     e74:	6165                	addi	sp,sp,112
     e76:	8082                	ret

0000000000000e78 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e78:	7179                	addi	sp,sp,-48
     e7a:	f422                	sd	s0,40(sp)
     e7c:	1800                	addi	s0,sp,48
     e7e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e82:	fd843783          	ld	a5,-40(s0)
     e86:	17c1                	addi	a5,a5,-16
     e88:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e8c:	00002797          	auipc	a5,0x2
     e90:	9b478793          	addi	a5,a5,-1612 # 2840 <freep>
     e94:	639c                	ld	a5,0(a5)
     e96:	fef43423          	sd	a5,-24(s0)
     e9a:	a815                	j	ece <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e9c:	fe843783          	ld	a5,-24(s0)
     ea0:	639c                	ld	a5,0(a5)
     ea2:	fe843703          	ld	a4,-24(s0)
     ea6:	00f76f63          	bltu	a4,a5,ec4 <free+0x4c>
     eaa:	fe043703          	ld	a4,-32(s0)
     eae:	fe843783          	ld	a5,-24(s0)
     eb2:	02e7eb63          	bltu	a5,a4,ee8 <free+0x70>
     eb6:	fe843783          	ld	a5,-24(s0)
     eba:	639c                	ld	a5,0(a5)
     ebc:	fe043703          	ld	a4,-32(s0)
     ec0:	02f76463          	bltu	a4,a5,ee8 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ec4:	fe843783          	ld	a5,-24(s0)
     ec8:	639c                	ld	a5,0(a5)
     eca:	fef43423          	sd	a5,-24(s0)
     ece:	fe043703          	ld	a4,-32(s0)
     ed2:	fe843783          	ld	a5,-24(s0)
     ed6:	fce7f3e3          	bgeu	a5,a4,e9c <free+0x24>
     eda:	fe843783          	ld	a5,-24(s0)
     ede:	639c                	ld	a5,0(a5)
     ee0:	fe043703          	ld	a4,-32(s0)
     ee4:	faf77ce3          	bgeu	a4,a5,e9c <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ee8:	fe043783          	ld	a5,-32(s0)
     eec:	479c                	lw	a5,8(a5)
     eee:	1782                	slli	a5,a5,0x20
     ef0:	9381                	srli	a5,a5,0x20
     ef2:	0792                	slli	a5,a5,0x4
     ef4:	fe043703          	ld	a4,-32(s0)
     ef8:	973e                	add	a4,a4,a5
     efa:	fe843783          	ld	a5,-24(s0)
     efe:	639c                	ld	a5,0(a5)
     f00:	02f71763          	bne	a4,a5,f2e <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     f04:	fe043783          	ld	a5,-32(s0)
     f08:	4798                	lw	a4,8(a5)
     f0a:	fe843783          	ld	a5,-24(s0)
     f0e:	639c                	ld	a5,0(a5)
     f10:	479c                	lw	a5,8(a5)
     f12:	9fb9                	addw	a5,a5,a4
     f14:	0007871b          	sext.w	a4,a5
     f18:	fe043783          	ld	a5,-32(s0)
     f1c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     f1e:	fe843783          	ld	a5,-24(s0)
     f22:	639c                	ld	a5,0(a5)
     f24:	6398                	ld	a4,0(a5)
     f26:	fe043783          	ld	a5,-32(s0)
     f2a:	e398                	sd	a4,0(a5)
     f2c:	a039                	j	f3a <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     f2e:	fe843783          	ld	a5,-24(s0)
     f32:	6398                	ld	a4,0(a5)
     f34:	fe043783          	ld	a5,-32(s0)
     f38:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     f3a:	fe843783          	ld	a5,-24(s0)
     f3e:	479c                	lw	a5,8(a5)
     f40:	1782                	slli	a5,a5,0x20
     f42:	9381                	srli	a5,a5,0x20
     f44:	0792                	slli	a5,a5,0x4
     f46:	fe843703          	ld	a4,-24(s0)
     f4a:	97ba                	add	a5,a5,a4
     f4c:	fe043703          	ld	a4,-32(s0)
     f50:	02f71563          	bne	a4,a5,f7a <free+0x102>
    p->s.size += bp->s.size;
     f54:	fe843783          	ld	a5,-24(s0)
     f58:	4798                	lw	a4,8(a5)
     f5a:	fe043783          	ld	a5,-32(s0)
     f5e:	479c                	lw	a5,8(a5)
     f60:	9fb9                	addw	a5,a5,a4
     f62:	0007871b          	sext.w	a4,a5
     f66:	fe843783          	ld	a5,-24(s0)
     f6a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f6c:	fe043783          	ld	a5,-32(s0)
     f70:	6398                	ld	a4,0(a5)
     f72:	fe843783          	ld	a5,-24(s0)
     f76:	e398                	sd	a4,0(a5)
     f78:	a031                	j	f84 <free+0x10c>
  } else
    p->s.ptr = bp;
     f7a:	fe843783          	ld	a5,-24(s0)
     f7e:	fe043703          	ld	a4,-32(s0)
     f82:	e398                	sd	a4,0(a5)
  freep = p;
     f84:	00002797          	auipc	a5,0x2
     f88:	8bc78793          	addi	a5,a5,-1860 # 2840 <freep>
     f8c:	fe843703          	ld	a4,-24(s0)
     f90:	e398                	sd	a4,0(a5)
}
     f92:	0001                	nop
     f94:	7422                	ld	s0,40(sp)
     f96:	6145                	addi	sp,sp,48
     f98:	8082                	ret

0000000000000f9a <morecore>:

static Header*
morecore(uint nu)
{
     f9a:	7179                	addi	sp,sp,-48
     f9c:	f406                	sd	ra,40(sp)
     f9e:	f022                	sd	s0,32(sp)
     fa0:	1800                	addi	s0,sp,48
     fa2:	87aa                	mv	a5,a0
     fa4:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     fa8:	fdc42783          	lw	a5,-36(s0)
     fac:	0007871b          	sext.w	a4,a5
     fb0:	6785                	lui	a5,0x1
     fb2:	00f77563          	bgeu	a4,a5,fbc <morecore+0x22>
    nu = 4096;
     fb6:	6785                	lui	a5,0x1
     fb8:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     fbc:	fdc42783          	lw	a5,-36(s0)
     fc0:	0047979b          	slliw	a5,a5,0x4
     fc4:	2781                	sext.w	a5,a5
     fc6:	2781                	sext.w	a5,a5
     fc8:	853e                	mv	a0,a5
     fca:	00000097          	auipc	ra,0x0
     fce:	986080e7          	jalr	-1658(ra) # 950 <sbrk>
     fd2:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     fd6:	fe843703          	ld	a4,-24(s0)
     fda:	57fd                	li	a5,-1
     fdc:	00f71463          	bne	a4,a5,fe4 <morecore+0x4a>
    return 0;
     fe0:	4781                	li	a5,0
     fe2:	a03d                	j	1010 <morecore+0x76>
  hp = (Header*)p;
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     fec:	fe043783          	ld	a5,-32(s0)
     ff0:	fdc42703          	lw	a4,-36(s0)
     ff4:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     ff6:	fe043783          	ld	a5,-32(s0)
     ffa:	07c1                	addi	a5,a5,16 # 1010 <morecore+0x76>
     ffc:	853e                	mv	a0,a5
     ffe:	00000097          	auipc	ra,0x0
    1002:	e7a080e7          	jalr	-390(ra) # e78 <free>
  return freep;
    1006:	00002797          	auipc	a5,0x2
    100a:	83a78793          	addi	a5,a5,-1990 # 2840 <freep>
    100e:	639c                	ld	a5,0(a5)
}
    1010:	853e                	mv	a0,a5
    1012:	70a2                	ld	ra,40(sp)
    1014:	7402                	ld	s0,32(sp)
    1016:	6145                	addi	sp,sp,48
    1018:	8082                	ret

000000000000101a <malloc>:

void*
malloc(uint nbytes)
{
    101a:	7139                	addi	sp,sp,-64
    101c:	fc06                	sd	ra,56(sp)
    101e:	f822                	sd	s0,48(sp)
    1020:	0080                	addi	s0,sp,64
    1022:	87aa                	mv	a5,a0
    1024:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1028:	fcc46783          	lwu	a5,-52(s0)
    102c:	07bd                	addi	a5,a5,15
    102e:	8391                	srli	a5,a5,0x4
    1030:	2781                	sext.w	a5,a5
    1032:	2785                	addiw	a5,a5,1
    1034:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1038:	00002797          	auipc	a5,0x2
    103c:	80878793          	addi	a5,a5,-2040 # 2840 <freep>
    1040:	639c                	ld	a5,0(a5)
    1042:	fef43023          	sd	a5,-32(s0)
    1046:	fe043783          	ld	a5,-32(s0)
    104a:	ef95                	bnez	a5,1086 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    104c:	00001797          	auipc	a5,0x1
    1050:	7e478793          	addi	a5,a5,2020 # 2830 <base>
    1054:	fef43023          	sd	a5,-32(s0)
    1058:	00001797          	auipc	a5,0x1
    105c:	7e878793          	addi	a5,a5,2024 # 2840 <freep>
    1060:	fe043703          	ld	a4,-32(s0)
    1064:	e398                	sd	a4,0(a5)
    1066:	00001797          	auipc	a5,0x1
    106a:	7da78793          	addi	a5,a5,2010 # 2840 <freep>
    106e:	6398                	ld	a4,0(a5)
    1070:	00001797          	auipc	a5,0x1
    1074:	7c078793          	addi	a5,a5,1984 # 2830 <base>
    1078:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    107a:	00001797          	auipc	a5,0x1
    107e:	7b678793          	addi	a5,a5,1974 # 2830 <base>
    1082:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1086:	fe043783          	ld	a5,-32(s0)
    108a:	639c                	ld	a5,0(a5)
    108c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1090:	fe843783          	ld	a5,-24(s0)
    1094:	4798                	lw	a4,8(a5)
    1096:	fdc42783          	lw	a5,-36(s0)
    109a:	2781                	sext.w	a5,a5
    109c:	06f76763          	bltu	a4,a5,110a <malloc+0xf0>
      if(p->s.size == nunits)
    10a0:	fe843783          	ld	a5,-24(s0)
    10a4:	4798                	lw	a4,8(a5)
    10a6:	fdc42783          	lw	a5,-36(s0)
    10aa:	2781                	sext.w	a5,a5
    10ac:	00e79963          	bne	a5,a4,10be <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    10b0:	fe843783          	ld	a5,-24(s0)
    10b4:	6398                	ld	a4,0(a5)
    10b6:	fe043783          	ld	a5,-32(s0)
    10ba:	e398                	sd	a4,0(a5)
    10bc:	a825                	j	10f4 <malloc+0xda>
      else {
        p->s.size -= nunits;
    10be:	fe843783          	ld	a5,-24(s0)
    10c2:	479c                	lw	a5,8(a5)
    10c4:	fdc42703          	lw	a4,-36(s0)
    10c8:	9f99                	subw	a5,a5,a4
    10ca:	0007871b          	sext.w	a4,a5
    10ce:	fe843783          	ld	a5,-24(s0)
    10d2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    10d4:	fe843783          	ld	a5,-24(s0)
    10d8:	479c                	lw	a5,8(a5)
    10da:	1782                	slli	a5,a5,0x20
    10dc:	9381                	srli	a5,a5,0x20
    10de:	0792                	slli	a5,a5,0x4
    10e0:	fe843703          	ld	a4,-24(s0)
    10e4:	97ba                	add	a5,a5,a4
    10e6:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    10ea:	fe843783          	ld	a5,-24(s0)
    10ee:	fdc42703          	lw	a4,-36(s0)
    10f2:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    10f4:	00001797          	auipc	a5,0x1
    10f8:	74c78793          	addi	a5,a5,1868 # 2840 <freep>
    10fc:	fe043703          	ld	a4,-32(s0)
    1100:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1102:	fe843783          	ld	a5,-24(s0)
    1106:	07c1                	addi	a5,a5,16
    1108:	a091                	j	114c <malloc+0x132>
    }
    if(p == freep)
    110a:	00001797          	auipc	a5,0x1
    110e:	73678793          	addi	a5,a5,1846 # 2840 <freep>
    1112:	639c                	ld	a5,0(a5)
    1114:	fe843703          	ld	a4,-24(s0)
    1118:	02f71063          	bne	a4,a5,1138 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    111c:	fdc42783          	lw	a5,-36(s0)
    1120:	853e                	mv	a0,a5
    1122:	00000097          	auipc	ra,0x0
    1126:	e78080e7          	jalr	-392(ra) # f9a <morecore>
    112a:	fea43423          	sd	a0,-24(s0)
    112e:	fe843783          	ld	a5,-24(s0)
    1132:	e399                	bnez	a5,1138 <malloc+0x11e>
        return 0;
    1134:	4781                	li	a5,0
    1136:	a819                	j	114c <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1138:	fe843783          	ld	a5,-24(s0)
    113c:	fef43023          	sd	a5,-32(s0)
    1140:	fe843783          	ld	a5,-24(s0)
    1144:	639c                	ld	a5,0(a5)
    1146:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    114a:	b799                	j	1090 <malloc+0x76>
  }
}
    114c:	853e                	mv	a0,a5
    114e:	70e2                	ld	ra,56(sp)
    1150:	7442                	ld	s0,48(sp)
    1152:	6121                	addi	sp,sp,64
    1154:	8082                	ret
