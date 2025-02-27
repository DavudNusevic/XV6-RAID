
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <runcmd>:
void runcmd(struct cmd*) __attribute__((noreturn));

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	715d                	addi	sp,sp,-80
       2:	e486                	sd	ra,72(sp)
       4:	e0a2                	sd	s0,64(sp)
       6:	0880                	addi	s0,sp,80
       8:	faa43c23          	sd	a0,-72(s0)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       c:	fb843783          	ld	a5,-72(s0)
      10:	e791                	bnez	a5,1c <runcmd+0x1c>
    exit(1);
      12:	4505                	li	a0,1
      14:	00001097          	auipc	ra,0x1
      18:	3f6080e7          	jalr	1014(ra) # 140a <exit>

  switch(cmd->type){
      1c:	fb843783          	ld	a5,-72(s0)
      20:	439c                	lw	a5,0(a5)
      22:	86be                	mv	a3,a5
      24:	4715                	li	a4,5
      26:	02d76263          	bltu	a4,a3,4a <runcmd+0x4a>
      2a:	00279713          	slli	a4,a5,0x2
      2e:	00002797          	auipc	a5,0x2
      32:	ca278793          	addi	a5,a5,-862 # 1cd0 <malloc+0x174>
      36:	97ba                	add	a5,a5,a4
      38:	439c                	lw	a5,0(a5)
      3a:	0007871b          	sext.w	a4,a5
      3e:	00002797          	auipc	a5,0x2
      42:	c9278793          	addi	a5,a5,-878 # 1cd0 <malloc+0x174>
      46:	97ba                	add	a5,a5,a4
      48:	8782                	jr	a5
  default:
    panic("runcmd");
      4a:	00002517          	auipc	a0,0x2
      4e:	c5650513          	addi	a0,a0,-938 # 1ca0 <malloc+0x144>
      52:	00000097          	auipc	ra,0x0
      56:	3da080e7          	jalr	986(ra) # 42c <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      5a:	fb843783          	ld	a5,-72(s0)
      5e:	fcf43423          	sd	a5,-56(s0)
    if(ecmd->argv[0] == 0)
      62:	fc843783          	ld	a5,-56(s0)
      66:	679c                	ld	a5,8(a5)
      68:	e791                	bnez	a5,74 <runcmd+0x74>
      exit(1);
      6a:	4505                	li	a0,1
      6c:	00001097          	auipc	ra,0x1
      70:	39e080e7          	jalr	926(ra) # 140a <exit>
    exec(ecmd->argv[0], ecmd->argv);
      74:	fc843783          	ld	a5,-56(s0)
      78:	6798                	ld	a4,8(a5)
      7a:	fc843783          	ld	a5,-56(s0)
      7e:	07a1                	addi	a5,a5,8
      80:	85be                	mv	a1,a5
      82:	853a                	mv	a0,a4
      84:	00001097          	auipc	ra,0x1
      88:	3be080e7          	jalr	958(ra) # 1442 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      8c:	fc843783          	ld	a5,-56(s0)
      90:	679c                	ld	a5,8(a5)
      92:	863e                	mv	a2,a5
      94:	00002597          	auipc	a1,0x2
      98:	c1458593          	addi	a1,a1,-1004 # 1ca8 <malloc+0x14c>
      9c:	4509                	li	a0,2
      9e:	00002097          	auipc	ra,0x2
      a2:	874080e7          	jalr	-1932(ra) # 1912 <fprintf>
    break;
      a6:	a2f9                	j	274 <runcmd+0x274>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      a8:	fb843783          	ld	a5,-72(s0)
      ac:	fcf43823          	sd	a5,-48(s0)
    close(rcmd->fd);
      b0:	fd043783          	ld	a5,-48(s0)
      b4:	53dc                	lw	a5,36(a5)
      b6:	853e                	mv	a0,a5
      b8:	00001097          	auipc	ra,0x1
      bc:	37a080e7          	jalr	890(ra) # 1432 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      c0:	fd043783          	ld	a5,-48(s0)
      c4:	6b98                	ld	a4,16(a5)
      c6:	fd043783          	ld	a5,-48(s0)
      ca:	539c                	lw	a5,32(a5)
      cc:	85be                	mv	a1,a5
      ce:	853a                	mv	a0,a4
      d0:	00001097          	auipc	ra,0x1
      d4:	37a080e7          	jalr	890(ra) # 144a <open>
      d8:	87aa                	mv	a5,a0
      da:	0207d463          	bgez	a5,102 <runcmd+0x102>
      fprintf(2, "open %s failed\n", rcmd->file);
      de:	fd043783          	ld	a5,-48(s0)
      e2:	6b9c                	ld	a5,16(a5)
      e4:	863e                	mv	a2,a5
      e6:	00002597          	auipc	a1,0x2
      ea:	bd258593          	addi	a1,a1,-1070 # 1cb8 <malloc+0x15c>
      ee:	4509                	li	a0,2
      f0:	00002097          	auipc	ra,0x2
      f4:	822080e7          	jalr	-2014(ra) # 1912 <fprintf>
      exit(1);
      f8:	4505                	li	a0,1
      fa:	00001097          	auipc	ra,0x1
      fe:	310080e7          	jalr	784(ra) # 140a <exit>
    }
    runcmd(rcmd->cmd);
     102:	fd043783          	ld	a5,-48(s0)
     106:	679c                	ld	a5,8(a5)
     108:	853e                	mv	a0,a5
     10a:	00000097          	auipc	ra,0x0
     10e:	ef6080e7          	jalr	-266(ra) # 0 <runcmd>
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
     112:	fb843783          	ld	a5,-72(s0)
     116:	fef43023          	sd	a5,-32(s0)
    if(fork1() == 0)
     11a:	00000097          	auipc	ra,0x0
     11e:	33e080e7          	jalr	830(ra) # 458 <fork1>
     122:	87aa                	mv	a5,a0
     124:	eb89                	bnez	a5,136 <runcmd+0x136>
      runcmd(lcmd->left);
     126:	fe043783          	ld	a5,-32(s0)
     12a:	679c                	ld	a5,8(a5)
     12c:	853e                	mv	a0,a5
     12e:	00000097          	auipc	ra,0x0
     132:	ed2080e7          	jalr	-302(ra) # 0 <runcmd>
    wait(0);
     136:	4501                	li	a0,0
     138:	00001097          	auipc	ra,0x1
     13c:	2da080e7          	jalr	730(ra) # 1412 <wait>
    runcmd(lcmd->right);
     140:	fe043783          	ld	a5,-32(s0)
     144:	6b9c                	ld	a5,16(a5)
     146:	853e                	mv	a0,a5
     148:	00000097          	auipc	ra,0x0
     14c:	eb8080e7          	jalr	-328(ra) # 0 <runcmd>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     150:	fb843783          	ld	a5,-72(s0)
     154:	fcf43c23          	sd	a5,-40(s0)
    if(pipe(p) < 0)
     158:	fc040793          	addi	a5,s0,-64
     15c:	853e                	mv	a0,a5
     15e:	00001097          	auipc	ra,0x1
     162:	2bc080e7          	jalr	700(ra) # 141a <pipe>
     166:	87aa                	mv	a5,a0
     168:	0007da63          	bgez	a5,17c <runcmd+0x17c>
      panic("pipe");
     16c:	00002517          	auipc	a0,0x2
     170:	b5c50513          	addi	a0,a0,-1188 # 1cc8 <malloc+0x16c>
     174:	00000097          	auipc	ra,0x0
     178:	2b8080e7          	jalr	696(ra) # 42c <panic>
    if(fork1() == 0){
     17c:	00000097          	auipc	ra,0x0
     180:	2dc080e7          	jalr	732(ra) # 458 <fork1>
     184:	87aa                	mv	a5,a0
     186:	e3b9                	bnez	a5,1cc <runcmd+0x1cc>
      close(1);
     188:	4505                	li	a0,1
     18a:	00001097          	auipc	ra,0x1
     18e:	2a8080e7          	jalr	680(ra) # 1432 <close>
      dup(p[1]);
     192:	fc442783          	lw	a5,-60(s0)
     196:	853e                	mv	a0,a5
     198:	00001097          	auipc	ra,0x1
     19c:	2ea080e7          	jalr	746(ra) # 1482 <dup>
      close(p[0]);
     1a0:	fc042783          	lw	a5,-64(s0)
     1a4:	853e                	mv	a0,a5
     1a6:	00001097          	auipc	ra,0x1
     1aa:	28c080e7          	jalr	652(ra) # 1432 <close>
      close(p[1]);
     1ae:	fc442783          	lw	a5,-60(s0)
     1b2:	853e                	mv	a0,a5
     1b4:	00001097          	auipc	ra,0x1
     1b8:	27e080e7          	jalr	638(ra) # 1432 <close>
      runcmd(pcmd->left);
     1bc:	fd843783          	ld	a5,-40(s0)
     1c0:	679c                	ld	a5,8(a5)
     1c2:	853e                	mv	a0,a5
     1c4:	00000097          	auipc	ra,0x0
     1c8:	e3c080e7          	jalr	-452(ra) # 0 <runcmd>
    }
    if(fork1() == 0){
     1cc:	00000097          	auipc	ra,0x0
     1d0:	28c080e7          	jalr	652(ra) # 458 <fork1>
     1d4:	87aa                	mv	a5,a0
     1d6:	e3b9                	bnez	a5,21c <runcmd+0x21c>
      close(0);
     1d8:	4501                	li	a0,0
     1da:	00001097          	auipc	ra,0x1
     1de:	258080e7          	jalr	600(ra) # 1432 <close>
      dup(p[0]);
     1e2:	fc042783          	lw	a5,-64(s0)
     1e6:	853e                	mv	a0,a5
     1e8:	00001097          	auipc	ra,0x1
     1ec:	29a080e7          	jalr	666(ra) # 1482 <dup>
      close(p[0]);
     1f0:	fc042783          	lw	a5,-64(s0)
     1f4:	853e                	mv	a0,a5
     1f6:	00001097          	auipc	ra,0x1
     1fa:	23c080e7          	jalr	572(ra) # 1432 <close>
      close(p[1]);
     1fe:	fc442783          	lw	a5,-60(s0)
     202:	853e                	mv	a0,a5
     204:	00001097          	auipc	ra,0x1
     208:	22e080e7          	jalr	558(ra) # 1432 <close>
      runcmd(pcmd->right);
     20c:	fd843783          	ld	a5,-40(s0)
     210:	6b9c                	ld	a5,16(a5)
     212:	853e                	mv	a0,a5
     214:	00000097          	auipc	ra,0x0
     218:	dec080e7          	jalr	-532(ra) # 0 <runcmd>
    }
    close(p[0]);
     21c:	fc042783          	lw	a5,-64(s0)
     220:	853e                	mv	a0,a5
     222:	00001097          	auipc	ra,0x1
     226:	210080e7          	jalr	528(ra) # 1432 <close>
    close(p[1]);
     22a:	fc442783          	lw	a5,-60(s0)
     22e:	853e                	mv	a0,a5
     230:	00001097          	auipc	ra,0x1
     234:	202080e7          	jalr	514(ra) # 1432 <close>
    wait(0);
     238:	4501                	li	a0,0
     23a:	00001097          	auipc	ra,0x1
     23e:	1d8080e7          	jalr	472(ra) # 1412 <wait>
    wait(0);
     242:	4501                	li	a0,0
     244:	00001097          	auipc	ra,0x1
     248:	1ce080e7          	jalr	462(ra) # 1412 <wait>
    break;
     24c:	a025                	j	274 <runcmd+0x274>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     24e:	fb843783          	ld	a5,-72(s0)
     252:	fef43423          	sd	a5,-24(s0)
    if(fork1() == 0)
     256:	00000097          	auipc	ra,0x0
     25a:	202080e7          	jalr	514(ra) # 458 <fork1>
     25e:	87aa                	mv	a5,a0
     260:	eb89                	bnez	a5,272 <runcmd+0x272>
      runcmd(bcmd->cmd);
     262:	fe843783          	ld	a5,-24(s0)
     266:	679c                	ld	a5,8(a5)
     268:	853e                	mv	a0,a5
     26a:	00000097          	auipc	ra,0x0
     26e:	d96080e7          	jalr	-618(ra) # 0 <runcmd>
    break;
     272:	0001                	nop
  }
  exit(0);
     274:	4501                	li	a0,0
     276:	00001097          	auipc	ra,0x1
     27a:	194080e7          	jalr	404(ra) # 140a <exit>

000000000000027e <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     27e:	1101                	addi	sp,sp,-32
     280:	ec06                	sd	ra,24(sp)
     282:	e822                	sd	s0,16(sp)
     284:	1000                	addi	s0,sp,32
     286:	fea43423          	sd	a0,-24(s0)
     28a:	87ae                	mv	a5,a1
     28c:	fef42223          	sw	a5,-28(s0)
  write(2, "$ ", 2);
     290:	4609                	li	a2,2
     292:	00002597          	auipc	a1,0x2
     296:	a5658593          	addi	a1,a1,-1450 # 1ce8 <malloc+0x18c>
     29a:	4509                	li	a0,2
     29c:	00001097          	auipc	ra,0x1
     2a0:	18e080e7          	jalr	398(ra) # 142a <write>
  memset(buf, 0, nbuf);
     2a4:	fe442783          	lw	a5,-28(s0)
     2a8:	863e                	mv	a2,a5
     2aa:	4581                	li	a1,0
     2ac:	fe843503          	ld	a0,-24(s0)
     2b0:	00001097          	auipc	ra,0x1
     2b4:	dae080e7          	jalr	-594(ra) # 105e <memset>
  gets(buf, nbuf);
     2b8:	fe442783          	lw	a5,-28(s0)
     2bc:	85be                	mv	a1,a5
     2be:	fe843503          	ld	a0,-24(s0)
     2c2:	00001097          	auipc	ra,0x1
     2c6:	e46080e7          	jalr	-442(ra) # 1108 <gets>
  if(buf[0] == 0) // EOF
     2ca:	fe843783          	ld	a5,-24(s0)
     2ce:	0007c783          	lbu	a5,0(a5)
     2d2:	e399                	bnez	a5,2d8 <getcmd+0x5a>
    return -1;
     2d4:	57fd                	li	a5,-1
     2d6:	a011                	j	2da <getcmd+0x5c>
  return 0;
     2d8:	4781                	li	a5,0
}
     2da:	853e                	mv	a0,a5
     2dc:	60e2                	ld	ra,24(sp)
     2de:	6442                	ld	s0,16(sp)
     2e0:	6105                	addi	sp,sp,32
     2e2:	8082                	ret

00000000000002e4 <main>:

int
main(void)
{
     2e4:	1101                	addi	sp,sp,-32
     2e6:	ec06                	sd	ra,24(sp)
     2e8:	e822                	sd	s0,16(sp)
     2ea:	1000                	addi	s0,sp,32
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
     2ec:	a005                	j	30c <main+0x28>
    if(fd >= 3){
     2ee:	fec42783          	lw	a5,-20(s0)
     2f2:	0007871b          	sext.w	a4,a5
     2f6:	4789                	li	a5,2
     2f8:	00e7da63          	bge	a5,a4,30c <main+0x28>
      close(fd);
     2fc:	fec42783          	lw	a5,-20(s0)
     300:	853e                	mv	a0,a5
     302:	00001097          	auipc	ra,0x1
     306:	130080e7          	jalr	304(ra) # 1432 <close>
      break;
     30a:	a015                	j	32e <main+0x4a>
  while((fd = open("console", O_RDWR)) >= 0){
     30c:	4589                	li	a1,2
     30e:	00002517          	auipc	a0,0x2
     312:	9e250513          	addi	a0,a0,-1566 # 1cf0 <malloc+0x194>
     316:	00001097          	auipc	ra,0x1
     31a:	134080e7          	jalr	308(ra) # 144a <open>
     31e:	87aa                	mv	a5,a0
     320:	fef42623          	sw	a5,-20(s0)
     324:	fec42783          	lw	a5,-20(s0)
     328:	2781                	sext.w	a5,a5
     32a:	fc07d2e3          	bgez	a5,2ee <main+0xa>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     32e:	a8e9                	j	408 <main+0x124>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     330:	00002797          	auipc	a5,0x2
     334:	34078793          	addi	a5,a5,832 # 2670 <buf.0>
     338:	0007c783          	lbu	a5,0(a5)
     33c:	873e                	mv	a4,a5
     33e:	06300793          	li	a5,99
     342:	08f71863          	bne	a4,a5,3d2 <main+0xee>
     346:	00002797          	auipc	a5,0x2
     34a:	32a78793          	addi	a5,a5,810 # 2670 <buf.0>
     34e:	0017c783          	lbu	a5,1(a5)
     352:	873e                	mv	a4,a5
     354:	06400793          	li	a5,100
     358:	06f71d63          	bne	a4,a5,3d2 <main+0xee>
     35c:	00002797          	auipc	a5,0x2
     360:	31478793          	addi	a5,a5,788 # 2670 <buf.0>
     364:	0027c783          	lbu	a5,2(a5)
     368:	873e                	mv	a4,a5
     36a:	02000793          	li	a5,32
     36e:	06f71263          	bne	a4,a5,3d2 <main+0xee>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     372:	00002517          	auipc	a0,0x2
     376:	2fe50513          	addi	a0,a0,766 # 2670 <buf.0>
     37a:	00001097          	auipc	ra,0x1
     37e:	cae080e7          	jalr	-850(ra) # 1028 <strlen>
     382:	87aa                	mv	a5,a0
     384:	2781                	sext.w	a5,a5
     386:	37fd                	addiw	a5,a5,-1
     388:	2781                	sext.w	a5,a5
     38a:	00002717          	auipc	a4,0x2
     38e:	2e670713          	addi	a4,a4,742 # 2670 <buf.0>
     392:	1782                	slli	a5,a5,0x20
     394:	9381                	srli	a5,a5,0x20
     396:	97ba                	add	a5,a5,a4
     398:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     39c:	00002797          	auipc	a5,0x2
     3a0:	2d778793          	addi	a5,a5,727 # 2673 <buf.0+0x3>
     3a4:	853e                	mv	a0,a5
     3a6:	00001097          	auipc	ra,0x1
     3aa:	0d4080e7          	jalr	212(ra) # 147a <chdir>
     3ae:	87aa                	mv	a5,a0
     3b0:	0407db63          	bgez	a5,406 <main+0x122>
        fprintf(2, "cannot cd %s\n", buf+3);
     3b4:	00002797          	auipc	a5,0x2
     3b8:	2bf78793          	addi	a5,a5,703 # 2673 <buf.0+0x3>
     3bc:	863e                	mv	a2,a5
     3be:	00002597          	auipc	a1,0x2
     3c2:	93a58593          	addi	a1,a1,-1734 # 1cf8 <malloc+0x19c>
     3c6:	4509                	li	a0,2
     3c8:	00001097          	auipc	ra,0x1
     3cc:	54a080e7          	jalr	1354(ra) # 1912 <fprintf>
      continue;
     3d0:	a81d                	j	406 <main+0x122>
    }
    if(fork1() == 0)
     3d2:	00000097          	auipc	ra,0x0
     3d6:	086080e7          	jalr	134(ra) # 458 <fork1>
     3da:	87aa                	mv	a5,a0
     3dc:	ef99                	bnez	a5,3fa <main+0x116>
      runcmd(parsecmd(buf));
     3de:	00002517          	auipc	a0,0x2
     3e2:	29250513          	addi	a0,a0,658 # 2670 <buf.0>
     3e6:	00000097          	auipc	ra,0x0
     3ea:	4e6080e7          	jalr	1254(ra) # 8cc <parsecmd>
     3ee:	87aa                	mv	a5,a0
     3f0:	853e                	mv	a0,a5
     3f2:	00000097          	auipc	ra,0x0
     3f6:	c0e080e7          	jalr	-1010(ra) # 0 <runcmd>
    wait(0);
     3fa:	4501                	li	a0,0
     3fc:	00001097          	auipc	ra,0x1
     400:	016080e7          	jalr	22(ra) # 1412 <wait>
     404:	a011                	j	408 <main+0x124>
      continue;
     406:	0001                	nop
  while(getcmd(buf, sizeof(buf)) >= 0){
     408:	06400593          	li	a1,100
     40c:	00002517          	auipc	a0,0x2
     410:	26450513          	addi	a0,a0,612 # 2670 <buf.0>
     414:	00000097          	auipc	ra,0x0
     418:	e6a080e7          	jalr	-406(ra) # 27e <getcmd>
     41c:	87aa                	mv	a5,a0
     41e:	f007d9e3          	bgez	a5,330 <main+0x4c>
  }
  exit(0);
     422:	4501                	li	a0,0
     424:	00001097          	auipc	ra,0x1
     428:	fe6080e7          	jalr	-26(ra) # 140a <exit>

000000000000042c <panic>:
}

void
panic(char *s)
{
     42c:	1101                	addi	sp,sp,-32
     42e:	ec06                	sd	ra,24(sp)
     430:	e822                	sd	s0,16(sp)
     432:	1000                	addi	s0,sp,32
     434:	fea43423          	sd	a0,-24(s0)
  fprintf(2, "%s\n", s);
     438:	fe843603          	ld	a2,-24(s0)
     43c:	00002597          	auipc	a1,0x2
     440:	8cc58593          	addi	a1,a1,-1844 # 1d08 <malloc+0x1ac>
     444:	4509                	li	a0,2
     446:	00001097          	auipc	ra,0x1
     44a:	4cc080e7          	jalr	1228(ra) # 1912 <fprintf>
  exit(1);
     44e:	4505                	li	a0,1
     450:	00001097          	auipc	ra,0x1
     454:	fba080e7          	jalr	-70(ra) # 140a <exit>

0000000000000458 <fork1>:
}

int
fork1(void)
{
     458:	1101                	addi	sp,sp,-32
     45a:	ec06                	sd	ra,24(sp)
     45c:	e822                	sd	s0,16(sp)
     45e:	1000                	addi	s0,sp,32
  int pid;

  pid = fork();
     460:	00001097          	auipc	ra,0x1
     464:	fa2080e7          	jalr	-94(ra) # 1402 <fork>
     468:	87aa                	mv	a5,a0
     46a:	fef42623          	sw	a5,-20(s0)
  if(pid == -1)
     46e:	fec42783          	lw	a5,-20(s0)
     472:	0007871b          	sext.w	a4,a5
     476:	57fd                	li	a5,-1
     478:	00f71a63          	bne	a4,a5,48c <fork1+0x34>
    panic("fork");
     47c:	00002517          	auipc	a0,0x2
     480:	89450513          	addi	a0,a0,-1900 # 1d10 <malloc+0x1b4>
     484:	00000097          	auipc	ra,0x0
     488:	fa8080e7          	jalr	-88(ra) # 42c <panic>
  return pid;
     48c:	fec42783          	lw	a5,-20(s0)
}
     490:	853e                	mv	a0,a5
     492:	60e2                	ld	ra,24(sp)
     494:	6442                	ld	s0,16(sp)
     496:	6105                	addi	sp,sp,32
     498:	8082                	ret

000000000000049a <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     49a:	1101                	addi	sp,sp,-32
     49c:	ec06                	sd	ra,24(sp)
     49e:	e822                	sd	s0,16(sp)
     4a0:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a2:	0a800513          	li	a0,168
     4a6:	00001097          	auipc	ra,0x1
     4aa:	6b6080e7          	jalr	1718(ra) # 1b5c <malloc>
     4ae:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     4b2:	0a800613          	li	a2,168
     4b6:	4581                	li	a1,0
     4b8:	fe843503          	ld	a0,-24(s0)
     4bc:	00001097          	auipc	ra,0x1
     4c0:	ba2080e7          	jalr	-1118(ra) # 105e <memset>
  cmd->type = EXEC;
     4c4:	fe843783          	ld	a5,-24(s0)
     4c8:	4705                	li	a4,1
     4ca:	c398                	sw	a4,0(a5)
  return (struct cmd*)cmd;
     4cc:	fe843783          	ld	a5,-24(s0)
}
     4d0:	853e                	mv	a0,a5
     4d2:	60e2                	ld	ra,24(sp)
     4d4:	6442                	ld	s0,16(sp)
     4d6:	6105                	addi	sp,sp,32
     4d8:	8082                	ret

00000000000004da <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     4da:	7139                	addi	sp,sp,-64
     4dc:	fc06                	sd	ra,56(sp)
     4de:	f822                	sd	s0,48(sp)
     4e0:	0080                	addi	s0,sp,64
     4e2:	fca43c23          	sd	a0,-40(s0)
     4e6:	fcb43823          	sd	a1,-48(s0)
     4ea:	fcc43423          	sd	a2,-56(s0)
     4ee:	87b6                	mv	a5,a3
     4f0:	fcf42223          	sw	a5,-60(s0)
     4f4:	87ba                	mv	a5,a4
     4f6:	fcf42023          	sw	a5,-64(s0)
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4fa:	02800513          	li	a0,40
     4fe:	00001097          	auipc	ra,0x1
     502:	65e080e7          	jalr	1630(ra) # 1b5c <malloc>
     506:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     50a:	02800613          	li	a2,40
     50e:	4581                	li	a1,0
     510:	fe843503          	ld	a0,-24(s0)
     514:	00001097          	auipc	ra,0x1
     518:	b4a080e7          	jalr	-1206(ra) # 105e <memset>
  cmd->type = REDIR;
     51c:	fe843783          	ld	a5,-24(s0)
     520:	4709                	li	a4,2
     522:	c398                	sw	a4,0(a5)
  cmd->cmd = subcmd;
     524:	fe843783          	ld	a5,-24(s0)
     528:	fd843703          	ld	a4,-40(s0)
     52c:	e798                	sd	a4,8(a5)
  cmd->file = file;
     52e:	fe843783          	ld	a5,-24(s0)
     532:	fd043703          	ld	a4,-48(s0)
     536:	eb98                	sd	a4,16(a5)
  cmd->efile = efile;
     538:	fe843783          	ld	a5,-24(s0)
     53c:	fc843703          	ld	a4,-56(s0)
     540:	ef98                	sd	a4,24(a5)
  cmd->mode = mode;
     542:	fe843783          	ld	a5,-24(s0)
     546:	fc442703          	lw	a4,-60(s0)
     54a:	d398                	sw	a4,32(a5)
  cmd->fd = fd;
     54c:	fe843783          	ld	a5,-24(s0)
     550:	fc042703          	lw	a4,-64(s0)
     554:	d3d8                	sw	a4,36(a5)
  return (struct cmd*)cmd;
     556:	fe843783          	ld	a5,-24(s0)
}
     55a:	853e                	mv	a0,a5
     55c:	70e2                	ld	ra,56(sp)
     55e:	7442                	ld	s0,48(sp)
     560:	6121                	addi	sp,sp,64
     562:	8082                	ret

0000000000000564 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     564:	7179                	addi	sp,sp,-48
     566:	f406                	sd	ra,40(sp)
     568:	f022                	sd	s0,32(sp)
     56a:	1800                	addi	s0,sp,48
     56c:	fca43c23          	sd	a0,-40(s0)
     570:	fcb43823          	sd	a1,-48(s0)
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     574:	4561                	li	a0,24
     576:	00001097          	auipc	ra,0x1
     57a:	5e6080e7          	jalr	1510(ra) # 1b5c <malloc>
     57e:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     582:	4661                	li	a2,24
     584:	4581                	li	a1,0
     586:	fe843503          	ld	a0,-24(s0)
     58a:	00001097          	auipc	ra,0x1
     58e:	ad4080e7          	jalr	-1324(ra) # 105e <memset>
  cmd->type = PIPE;
     592:	fe843783          	ld	a5,-24(s0)
     596:	470d                	li	a4,3
     598:	c398                	sw	a4,0(a5)
  cmd->left = left;
     59a:	fe843783          	ld	a5,-24(s0)
     59e:	fd843703          	ld	a4,-40(s0)
     5a2:	e798                	sd	a4,8(a5)
  cmd->right = right;
     5a4:	fe843783          	ld	a5,-24(s0)
     5a8:	fd043703          	ld	a4,-48(s0)
     5ac:	eb98                	sd	a4,16(a5)
  return (struct cmd*)cmd;
     5ae:	fe843783          	ld	a5,-24(s0)
}
     5b2:	853e                	mv	a0,a5
     5b4:	70a2                	ld	ra,40(sp)
     5b6:	7402                	ld	s0,32(sp)
     5b8:	6145                	addi	sp,sp,48
     5ba:	8082                	ret

00000000000005bc <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     5bc:	7179                	addi	sp,sp,-48
     5be:	f406                	sd	ra,40(sp)
     5c0:	f022                	sd	s0,32(sp)
     5c2:	1800                	addi	s0,sp,48
     5c4:	fca43c23          	sd	a0,-40(s0)
     5c8:	fcb43823          	sd	a1,-48(s0)
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5cc:	4561                	li	a0,24
     5ce:	00001097          	auipc	ra,0x1
     5d2:	58e080e7          	jalr	1422(ra) # 1b5c <malloc>
     5d6:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     5da:	4661                	li	a2,24
     5dc:	4581                	li	a1,0
     5de:	fe843503          	ld	a0,-24(s0)
     5e2:	00001097          	auipc	ra,0x1
     5e6:	a7c080e7          	jalr	-1412(ra) # 105e <memset>
  cmd->type = LIST;
     5ea:	fe843783          	ld	a5,-24(s0)
     5ee:	4711                	li	a4,4
     5f0:	c398                	sw	a4,0(a5)
  cmd->left = left;
     5f2:	fe843783          	ld	a5,-24(s0)
     5f6:	fd843703          	ld	a4,-40(s0)
     5fa:	e798                	sd	a4,8(a5)
  cmd->right = right;
     5fc:	fe843783          	ld	a5,-24(s0)
     600:	fd043703          	ld	a4,-48(s0)
     604:	eb98                	sd	a4,16(a5)
  return (struct cmd*)cmd;
     606:	fe843783          	ld	a5,-24(s0)
}
     60a:	853e                	mv	a0,a5
     60c:	70a2                	ld	ra,40(sp)
     60e:	7402                	ld	s0,32(sp)
     610:	6145                	addi	sp,sp,48
     612:	8082                	ret

0000000000000614 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     614:	7179                	addi	sp,sp,-48
     616:	f406                	sd	ra,40(sp)
     618:	f022                	sd	s0,32(sp)
     61a:	1800                	addi	s0,sp,48
     61c:	fca43c23          	sd	a0,-40(s0)
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     620:	4541                	li	a0,16
     622:	00001097          	auipc	ra,0x1
     626:	53a080e7          	jalr	1338(ra) # 1b5c <malloc>
     62a:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     62e:	4641                	li	a2,16
     630:	4581                	li	a1,0
     632:	fe843503          	ld	a0,-24(s0)
     636:	00001097          	auipc	ra,0x1
     63a:	a28080e7          	jalr	-1496(ra) # 105e <memset>
  cmd->type = BACK;
     63e:	fe843783          	ld	a5,-24(s0)
     642:	4715                	li	a4,5
     644:	c398                	sw	a4,0(a5)
  cmd->cmd = subcmd;
     646:	fe843783          	ld	a5,-24(s0)
     64a:	fd843703          	ld	a4,-40(s0)
     64e:	e798                	sd	a4,8(a5)
  return (struct cmd*)cmd;
     650:	fe843783          	ld	a5,-24(s0)
}
     654:	853e                	mv	a0,a5
     656:	70a2                	ld	ra,40(sp)
     658:	7402                	ld	s0,32(sp)
     65a:	6145                	addi	sp,sp,48
     65c:	8082                	ret

000000000000065e <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     65e:	7139                	addi	sp,sp,-64
     660:	fc06                	sd	ra,56(sp)
     662:	f822                	sd	s0,48(sp)
     664:	0080                	addi	s0,sp,64
     666:	fca43c23          	sd	a0,-40(s0)
     66a:	fcb43823          	sd	a1,-48(s0)
     66e:	fcc43423          	sd	a2,-56(s0)
     672:	fcd43023          	sd	a3,-64(s0)
  char *s;
  int ret;

  s = *ps;
     676:	fd843783          	ld	a5,-40(s0)
     67a:	639c                	ld	a5,0(a5)
     67c:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     680:	a031                	j	68c <gettoken+0x2e>
    s++;
     682:	fe843783          	ld	a5,-24(s0)
     686:	0785                	addi	a5,a5,1
     688:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     68c:	fe843703          	ld	a4,-24(s0)
     690:	fd043783          	ld	a5,-48(s0)
     694:	02f77163          	bgeu	a4,a5,6b6 <gettoken+0x58>
     698:	fe843783          	ld	a5,-24(s0)
     69c:	0007c783          	lbu	a5,0(a5)
     6a0:	85be                	mv	a1,a5
     6a2:	00002517          	auipc	a0,0x2
     6a6:	f9e50513          	addi	a0,a0,-98 # 2640 <whitespace>
     6aa:	00001097          	auipc	ra,0x1
     6ae:	a14080e7          	jalr	-1516(ra) # 10be <strchr>
     6b2:	87aa                	mv	a5,a0
     6b4:	f7f9                	bnez	a5,682 <gettoken+0x24>
  if(q)
     6b6:	fc843783          	ld	a5,-56(s0)
     6ba:	c791                	beqz	a5,6c6 <gettoken+0x68>
    *q = s;
     6bc:	fc843783          	ld	a5,-56(s0)
     6c0:	fe843703          	ld	a4,-24(s0)
     6c4:	e398                	sd	a4,0(a5)
  ret = *s;
     6c6:	fe843783          	ld	a5,-24(s0)
     6ca:	0007c783          	lbu	a5,0(a5)
     6ce:	fef42223          	sw	a5,-28(s0)
  switch(*s){
     6d2:	fe843783          	ld	a5,-24(s0)
     6d6:	0007c783          	lbu	a5,0(a5)
     6da:	2781                	sext.w	a5,a5
     6dc:	86be                	mv	a3,a5
     6de:	07c00713          	li	a4,124
     6e2:	04e68b63          	beq	a3,a4,738 <gettoken+0xda>
     6e6:	86be                	mv	a3,a5
     6e8:	07c00713          	li	a4,124
     6ec:	08d74463          	blt	a4,a3,774 <gettoken+0x116>
     6f0:	86be                	mv	a3,a5
     6f2:	03e00713          	li	a4,62
     6f6:	04e68763          	beq	a3,a4,744 <gettoken+0xe6>
     6fa:	86be                	mv	a3,a5
     6fc:	03e00713          	li	a4,62
     700:	06d74a63          	blt	a4,a3,774 <gettoken+0x116>
     704:	86be                	mv	a3,a5
     706:	03c00713          	li	a4,60
     70a:	06d74563          	blt	a4,a3,774 <gettoken+0x116>
     70e:	86be                	mv	a3,a5
     710:	03b00713          	li	a4,59
     714:	02e6d263          	bge	a3,a4,738 <gettoken+0xda>
     718:	86be                	mv	a3,a5
     71a:	02900713          	li	a4,41
     71e:	04d74b63          	blt	a4,a3,774 <gettoken+0x116>
     722:	86be                	mv	a3,a5
     724:	02800713          	li	a4,40
     728:	00e6d863          	bge	a3,a4,738 <gettoken+0xda>
     72c:	c3dd                	beqz	a5,7d2 <gettoken+0x174>
     72e:	873e                	mv	a4,a5
     730:	02600793          	li	a5,38
     734:	04f71063          	bne	a4,a5,774 <gettoken+0x116>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     738:	fe843783          	ld	a5,-24(s0)
     73c:	0785                	addi	a5,a5,1
     73e:	fef43423          	sd	a5,-24(s0)
    break;
     742:	a869                	j	7dc <gettoken+0x17e>
  case '>':
    s++;
     744:	fe843783          	ld	a5,-24(s0)
     748:	0785                	addi	a5,a5,1
     74a:	fef43423          	sd	a5,-24(s0)
    if(*s == '>'){
     74e:	fe843783          	ld	a5,-24(s0)
     752:	0007c783          	lbu	a5,0(a5)
     756:	873e                	mv	a4,a5
     758:	03e00793          	li	a5,62
     75c:	06f71d63          	bne	a4,a5,7d6 <gettoken+0x178>
      ret = '+';
     760:	02b00793          	li	a5,43
     764:	fef42223          	sw	a5,-28(s0)
      s++;
     768:	fe843783          	ld	a5,-24(s0)
     76c:	0785                	addi	a5,a5,1
     76e:	fef43423          	sd	a5,-24(s0)
    }
    break;
     772:	a095                	j	7d6 <gettoken+0x178>
  default:
    ret = 'a';
     774:	06100793          	li	a5,97
     778:	fef42223          	sw	a5,-28(s0)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     77c:	a031                	j	788 <gettoken+0x12a>
      s++;
     77e:	fe843783          	ld	a5,-24(s0)
     782:	0785                	addi	a5,a5,1
     784:	fef43423          	sd	a5,-24(s0)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     788:	fe843703          	ld	a4,-24(s0)
     78c:	fd043783          	ld	a5,-48(s0)
     790:	04f77563          	bgeu	a4,a5,7da <gettoken+0x17c>
     794:	fe843783          	ld	a5,-24(s0)
     798:	0007c783          	lbu	a5,0(a5)
     79c:	85be                	mv	a1,a5
     79e:	00002517          	auipc	a0,0x2
     7a2:	ea250513          	addi	a0,a0,-350 # 2640 <whitespace>
     7a6:	00001097          	auipc	ra,0x1
     7aa:	918080e7          	jalr	-1768(ra) # 10be <strchr>
     7ae:	87aa                	mv	a5,a0
     7b0:	e78d                	bnez	a5,7da <gettoken+0x17c>
     7b2:	fe843783          	ld	a5,-24(s0)
     7b6:	0007c783          	lbu	a5,0(a5)
     7ba:	85be                	mv	a1,a5
     7bc:	00002517          	auipc	a0,0x2
     7c0:	e8c50513          	addi	a0,a0,-372 # 2648 <symbols>
     7c4:	00001097          	auipc	ra,0x1
     7c8:	8fa080e7          	jalr	-1798(ra) # 10be <strchr>
     7cc:	87aa                	mv	a5,a0
     7ce:	dbc5                	beqz	a5,77e <gettoken+0x120>
    break;
     7d0:	a029                	j	7da <gettoken+0x17c>
    break;
     7d2:	0001                	nop
     7d4:	a021                	j	7dc <gettoken+0x17e>
    break;
     7d6:	0001                	nop
     7d8:	a011                	j	7dc <gettoken+0x17e>
    break;
     7da:	0001                	nop
  }
  if(eq)
     7dc:	fc043783          	ld	a5,-64(s0)
     7e0:	cf81                	beqz	a5,7f8 <gettoken+0x19a>
    *eq = s;
     7e2:	fc043783          	ld	a5,-64(s0)
     7e6:	fe843703          	ld	a4,-24(s0)
     7ea:	e398                	sd	a4,0(a5)

  while(s < es && strchr(whitespace, *s))
     7ec:	a031                	j	7f8 <gettoken+0x19a>
    s++;
     7ee:	fe843783          	ld	a5,-24(s0)
     7f2:	0785                	addi	a5,a5,1
     7f4:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     7f8:	fe843703          	ld	a4,-24(s0)
     7fc:	fd043783          	ld	a5,-48(s0)
     800:	02f77163          	bgeu	a4,a5,822 <gettoken+0x1c4>
     804:	fe843783          	ld	a5,-24(s0)
     808:	0007c783          	lbu	a5,0(a5)
     80c:	85be                	mv	a1,a5
     80e:	00002517          	auipc	a0,0x2
     812:	e3250513          	addi	a0,a0,-462 # 2640 <whitespace>
     816:	00001097          	auipc	ra,0x1
     81a:	8a8080e7          	jalr	-1880(ra) # 10be <strchr>
     81e:	87aa                	mv	a5,a0
     820:	f7f9                	bnez	a5,7ee <gettoken+0x190>
  *ps = s;
     822:	fd843783          	ld	a5,-40(s0)
     826:	fe843703          	ld	a4,-24(s0)
     82a:	e398                	sd	a4,0(a5)
  return ret;
     82c:	fe442783          	lw	a5,-28(s0)
}
     830:	853e                	mv	a0,a5
     832:	70e2                	ld	ra,56(sp)
     834:	7442                	ld	s0,48(sp)
     836:	6121                	addi	sp,sp,64
     838:	8082                	ret

000000000000083a <peek>:

int
peek(char **ps, char *es, char *toks)
{
     83a:	7139                	addi	sp,sp,-64
     83c:	fc06                	sd	ra,56(sp)
     83e:	f822                	sd	s0,48(sp)
     840:	0080                	addi	s0,sp,64
     842:	fca43c23          	sd	a0,-40(s0)
     846:	fcb43823          	sd	a1,-48(s0)
     84a:	fcc43423          	sd	a2,-56(s0)
  char *s;

  s = *ps;
     84e:	fd843783          	ld	a5,-40(s0)
     852:	639c                	ld	a5,0(a5)
     854:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     858:	a031                	j	864 <peek+0x2a>
    s++;
     85a:	fe843783          	ld	a5,-24(s0)
     85e:	0785                	addi	a5,a5,1
     860:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     864:	fe843703          	ld	a4,-24(s0)
     868:	fd043783          	ld	a5,-48(s0)
     86c:	02f77163          	bgeu	a4,a5,88e <peek+0x54>
     870:	fe843783          	ld	a5,-24(s0)
     874:	0007c783          	lbu	a5,0(a5)
     878:	85be                	mv	a1,a5
     87a:	00002517          	auipc	a0,0x2
     87e:	dc650513          	addi	a0,a0,-570 # 2640 <whitespace>
     882:	00001097          	auipc	ra,0x1
     886:	83c080e7          	jalr	-1988(ra) # 10be <strchr>
     88a:	87aa                	mv	a5,a0
     88c:	f7f9                	bnez	a5,85a <peek+0x20>
  *ps = s;
     88e:	fd843783          	ld	a5,-40(s0)
     892:	fe843703          	ld	a4,-24(s0)
     896:	e398                	sd	a4,0(a5)
  return *s && strchr(toks, *s);
     898:	fe843783          	ld	a5,-24(s0)
     89c:	0007c783          	lbu	a5,0(a5)
     8a0:	c385                	beqz	a5,8c0 <peek+0x86>
     8a2:	fe843783          	ld	a5,-24(s0)
     8a6:	0007c783          	lbu	a5,0(a5)
     8aa:	85be                	mv	a1,a5
     8ac:	fc843503          	ld	a0,-56(s0)
     8b0:	00001097          	auipc	ra,0x1
     8b4:	80e080e7          	jalr	-2034(ra) # 10be <strchr>
     8b8:	87aa                	mv	a5,a0
     8ba:	c399                	beqz	a5,8c0 <peek+0x86>
     8bc:	4785                	li	a5,1
     8be:	a011                	j	8c2 <peek+0x88>
     8c0:	4781                	li	a5,0
}
     8c2:	853e                	mv	a0,a5
     8c4:	70e2                	ld	ra,56(sp)
     8c6:	7442                	ld	s0,48(sp)
     8c8:	6121                	addi	sp,sp,64
     8ca:	8082                	ret

00000000000008cc <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     8cc:	7139                	addi	sp,sp,-64
     8ce:	fc06                	sd	ra,56(sp)
     8d0:	f822                	sd	s0,48(sp)
     8d2:	f426                	sd	s1,40(sp)
     8d4:	0080                	addi	s0,sp,64
     8d6:	fca43423          	sd	a0,-56(s0)
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     8da:	fc843483          	ld	s1,-56(s0)
     8de:	fc843783          	ld	a5,-56(s0)
     8e2:	853e                	mv	a0,a5
     8e4:	00000097          	auipc	ra,0x0
     8e8:	744080e7          	jalr	1860(ra) # 1028 <strlen>
     8ec:	87aa                	mv	a5,a0
     8ee:	2781                	sext.w	a5,a5
     8f0:	1782                	slli	a5,a5,0x20
     8f2:	9381                	srli	a5,a5,0x20
     8f4:	97a6                	add	a5,a5,s1
     8f6:	fcf43c23          	sd	a5,-40(s0)
  cmd = parseline(&s, es);
     8fa:	fc840793          	addi	a5,s0,-56
     8fe:	fd843583          	ld	a1,-40(s0)
     902:	853e                	mv	a0,a5
     904:	00000097          	auipc	ra,0x0
     908:	076080e7          	jalr	118(ra) # 97a <parseline>
     90c:	fca43823          	sd	a0,-48(s0)
  peek(&s, es, "");
     910:	fc840793          	addi	a5,s0,-56
     914:	00001617          	auipc	a2,0x1
     918:	40460613          	addi	a2,a2,1028 # 1d18 <malloc+0x1bc>
     91c:	fd843583          	ld	a1,-40(s0)
     920:	853e                	mv	a0,a5
     922:	00000097          	auipc	ra,0x0
     926:	f18080e7          	jalr	-232(ra) # 83a <peek>
  if(s != es){
     92a:	fc843783          	ld	a5,-56(s0)
     92e:	fd843703          	ld	a4,-40(s0)
     932:	02f70663          	beq	a4,a5,95e <parsecmd+0x92>
    fprintf(2, "leftovers: %s\n", s);
     936:	fc843783          	ld	a5,-56(s0)
     93a:	863e                	mv	a2,a5
     93c:	00001597          	auipc	a1,0x1
     940:	3e458593          	addi	a1,a1,996 # 1d20 <malloc+0x1c4>
     944:	4509                	li	a0,2
     946:	00001097          	auipc	ra,0x1
     94a:	fcc080e7          	jalr	-52(ra) # 1912 <fprintf>
    panic("syntax");
     94e:	00001517          	auipc	a0,0x1
     952:	3e250513          	addi	a0,a0,994 # 1d30 <malloc+0x1d4>
     956:	00000097          	auipc	ra,0x0
     95a:	ad6080e7          	jalr	-1322(ra) # 42c <panic>
  }
  nulterminate(cmd);
     95e:	fd043503          	ld	a0,-48(s0)
     962:	00000097          	auipc	ra,0x0
     966:	4da080e7          	jalr	1242(ra) # e3c <nulterminate>
  return cmd;
     96a:	fd043783          	ld	a5,-48(s0)
}
     96e:	853e                	mv	a0,a5
     970:	70e2                	ld	ra,56(sp)
     972:	7442                	ld	s0,48(sp)
     974:	74a2                	ld	s1,40(sp)
     976:	6121                	addi	sp,sp,64
     978:	8082                	ret

000000000000097a <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     97a:	7179                	addi	sp,sp,-48
     97c:	f406                	sd	ra,40(sp)
     97e:	f022                	sd	s0,32(sp)
     980:	1800                	addi	s0,sp,48
     982:	fca43c23          	sd	a0,-40(s0)
     986:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     98a:	fd043583          	ld	a1,-48(s0)
     98e:	fd843503          	ld	a0,-40(s0)
     992:	00000097          	auipc	ra,0x0
     996:	0b0080e7          	jalr	176(ra) # a42 <parsepipe>
     99a:	fea43423          	sd	a0,-24(s0)
  while(peek(ps, es, "&")){
     99e:	a01d                	j	9c4 <parseline+0x4a>
    gettoken(ps, es, 0, 0);
     9a0:	4681                	li	a3,0
     9a2:	4601                	li	a2,0
     9a4:	fd043583          	ld	a1,-48(s0)
     9a8:	fd843503          	ld	a0,-40(s0)
     9ac:	00000097          	auipc	ra,0x0
     9b0:	cb2080e7          	jalr	-846(ra) # 65e <gettoken>
    cmd = backcmd(cmd);
     9b4:	fe843503          	ld	a0,-24(s0)
     9b8:	00000097          	auipc	ra,0x0
     9bc:	c5c080e7          	jalr	-932(ra) # 614 <backcmd>
     9c0:	fea43423          	sd	a0,-24(s0)
  while(peek(ps, es, "&")){
     9c4:	00001617          	auipc	a2,0x1
     9c8:	37460613          	addi	a2,a2,884 # 1d38 <malloc+0x1dc>
     9cc:	fd043583          	ld	a1,-48(s0)
     9d0:	fd843503          	ld	a0,-40(s0)
     9d4:	00000097          	auipc	ra,0x0
     9d8:	e66080e7          	jalr	-410(ra) # 83a <peek>
     9dc:	87aa                	mv	a5,a0
     9de:	f3e9                	bnez	a5,9a0 <parseline+0x26>
  }
  if(peek(ps, es, ";")){
     9e0:	00001617          	auipc	a2,0x1
     9e4:	36060613          	addi	a2,a2,864 # 1d40 <malloc+0x1e4>
     9e8:	fd043583          	ld	a1,-48(s0)
     9ec:	fd843503          	ld	a0,-40(s0)
     9f0:	00000097          	auipc	ra,0x0
     9f4:	e4a080e7          	jalr	-438(ra) # 83a <peek>
     9f8:	87aa                	mv	a5,a0
     9fa:	cf8d                	beqz	a5,a34 <parseline+0xba>
    gettoken(ps, es, 0, 0);
     9fc:	4681                	li	a3,0
     9fe:	4601                	li	a2,0
     a00:	fd043583          	ld	a1,-48(s0)
     a04:	fd843503          	ld	a0,-40(s0)
     a08:	00000097          	auipc	ra,0x0
     a0c:	c56080e7          	jalr	-938(ra) # 65e <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     a10:	fd043583          	ld	a1,-48(s0)
     a14:	fd843503          	ld	a0,-40(s0)
     a18:	00000097          	auipc	ra,0x0
     a1c:	f62080e7          	jalr	-158(ra) # 97a <parseline>
     a20:	87aa                	mv	a5,a0
     a22:	85be                	mv	a1,a5
     a24:	fe843503          	ld	a0,-24(s0)
     a28:	00000097          	auipc	ra,0x0
     a2c:	b94080e7          	jalr	-1132(ra) # 5bc <listcmd>
     a30:	fea43423          	sd	a0,-24(s0)
  }
  return cmd;
     a34:	fe843783          	ld	a5,-24(s0)
}
     a38:	853e                	mv	a0,a5
     a3a:	70a2                	ld	ra,40(sp)
     a3c:	7402                	ld	s0,32(sp)
     a3e:	6145                	addi	sp,sp,48
     a40:	8082                	ret

0000000000000a42 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     a42:	7179                	addi	sp,sp,-48
     a44:	f406                	sd	ra,40(sp)
     a46:	f022                	sd	s0,32(sp)
     a48:	1800                	addi	s0,sp,48
     a4a:	fca43c23          	sd	a0,-40(s0)
     a4e:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     a52:	fd043583          	ld	a1,-48(s0)
     a56:	fd843503          	ld	a0,-40(s0)
     a5a:	00000097          	auipc	ra,0x0
     a5e:	270080e7          	jalr	624(ra) # cca <parseexec>
     a62:	fea43423          	sd	a0,-24(s0)
  if(peek(ps, es, "|")){
     a66:	00001617          	auipc	a2,0x1
     a6a:	2e260613          	addi	a2,a2,738 # 1d48 <malloc+0x1ec>
     a6e:	fd043583          	ld	a1,-48(s0)
     a72:	fd843503          	ld	a0,-40(s0)
     a76:	00000097          	auipc	ra,0x0
     a7a:	dc4080e7          	jalr	-572(ra) # 83a <peek>
     a7e:	87aa                	mv	a5,a0
     a80:	cf8d                	beqz	a5,aba <parsepipe+0x78>
    gettoken(ps, es, 0, 0);
     a82:	4681                	li	a3,0
     a84:	4601                	li	a2,0
     a86:	fd043583          	ld	a1,-48(s0)
     a8a:	fd843503          	ld	a0,-40(s0)
     a8e:	00000097          	auipc	ra,0x0
     a92:	bd0080e7          	jalr	-1072(ra) # 65e <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a96:	fd043583          	ld	a1,-48(s0)
     a9a:	fd843503          	ld	a0,-40(s0)
     a9e:	00000097          	auipc	ra,0x0
     aa2:	fa4080e7          	jalr	-92(ra) # a42 <parsepipe>
     aa6:	87aa                	mv	a5,a0
     aa8:	85be                	mv	a1,a5
     aaa:	fe843503          	ld	a0,-24(s0)
     aae:	00000097          	auipc	ra,0x0
     ab2:	ab6080e7          	jalr	-1354(ra) # 564 <pipecmd>
     ab6:	fea43423          	sd	a0,-24(s0)
  }
  return cmd;
     aba:	fe843783          	ld	a5,-24(s0)
}
     abe:	853e                	mv	a0,a5
     ac0:	70a2                	ld	ra,40(sp)
     ac2:	7402                	ld	s0,32(sp)
     ac4:	6145                	addi	sp,sp,48
     ac6:	8082                	ret

0000000000000ac8 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     ac8:	715d                	addi	sp,sp,-80
     aca:	e486                	sd	ra,72(sp)
     acc:	e0a2                	sd	s0,64(sp)
     ace:	0880                	addi	s0,sp,80
     ad0:	fca43423          	sd	a0,-56(s0)
     ad4:	fcb43023          	sd	a1,-64(s0)
     ad8:	fac43c23          	sd	a2,-72(s0)
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     adc:	a8e5                	j	bd4 <parseredirs+0x10c>
    tok = gettoken(ps, es, 0, 0);
     ade:	4681                	li	a3,0
     ae0:	4601                	li	a2,0
     ae2:	fb843583          	ld	a1,-72(s0)
     ae6:	fc043503          	ld	a0,-64(s0)
     aea:	00000097          	auipc	ra,0x0
     aee:	b74080e7          	jalr	-1164(ra) # 65e <gettoken>
     af2:	87aa                	mv	a5,a0
     af4:	fef42623          	sw	a5,-20(s0)
    if(gettoken(ps, es, &q, &eq) != 'a')
     af8:	fd840713          	addi	a4,s0,-40
     afc:	fe040793          	addi	a5,s0,-32
     b00:	86ba                	mv	a3,a4
     b02:	863e                	mv	a2,a5
     b04:	fb843583          	ld	a1,-72(s0)
     b08:	fc043503          	ld	a0,-64(s0)
     b0c:	00000097          	auipc	ra,0x0
     b10:	b52080e7          	jalr	-1198(ra) # 65e <gettoken>
     b14:	87aa                	mv	a5,a0
     b16:	873e                	mv	a4,a5
     b18:	06100793          	li	a5,97
     b1c:	00f70a63          	beq	a4,a5,b30 <parseredirs+0x68>
      panic("missing file for redirection");
     b20:	00001517          	auipc	a0,0x1
     b24:	23050513          	addi	a0,a0,560 # 1d50 <malloc+0x1f4>
     b28:	00000097          	auipc	ra,0x0
     b2c:	904080e7          	jalr	-1788(ra) # 42c <panic>
    switch(tok){
     b30:	fec42783          	lw	a5,-20(s0)
     b34:	0007871b          	sext.w	a4,a5
     b38:	03e00793          	li	a5,62
     b3c:	04f70a63          	beq	a4,a5,b90 <parseredirs+0xc8>
     b40:	fec42783          	lw	a5,-20(s0)
     b44:	0007871b          	sext.w	a4,a5
     b48:	03e00793          	li	a5,62
     b4c:	08e7c463          	blt	a5,a4,bd4 <parseredirs+0x10c>
     b50:	fec42783          	lw	a5,-20(s0)
     b54:	0007871b          	sext.w	a4,a5
     b58:	02b00793          	li	a5,43
     b5c:	04f70b63          	beq	a4,a5,bb2 <parseredirs+0xea>
     b60:	fec42783          	lw	a5,-20(s0)
     b64:	0007871b          	sext.w	a4,a5
     b68:	03c00793          	li	a5,60
     b6c:	06f71463          	bne	a4,a5,bd4 <parseredirs+0x10c>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     b70:	fe043783          	ld	a5,-32(s0)
     b74:	fd843603          	ld	a2,-40(s0)
     b78:	4701                	li	a4,0
     b7a:	4681                	li	a3,0
     b7c:	85be                	mv	a1,a5
     b7e:	fc843503          	ld	a0,-56(s0)
     b82:	00000097          	auipc	ra,0x0
     b86:	958080e7          	jalr	-1704(ra) # 4da <redircmd>
     b8a:	fca43423          	sd	a0,-56(s0)
      break;
     b8e:	a099                	j	bd4 <parseredirs+0x10c>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     b90:	fe043783          	ld	a5,-32(s0)
     b94:	fd843603          	ld	a2,-40(s0)
     b98:	4705                	li	a4,1
     b9a:	60100693          	li	a3,1537
     b9e:	85be                	mv	a1,a5
     ba0:	fc843503          	ld	a0,-56(s0)
     ba4:	00000097          	auipc	ra,0x0
     ba8:	936080e7          	jalr	-1738(ra) # 4da <redircmd>
     bac:	fca43423          	sd	a0,-56(s0)
      break;
     bb0:	a015                	j	bd4 <parseredirs+0x10c>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     bb2:	fe043783          	ld	a5,-32(s0)
     bb6:	fd843603          	ld	a2,-40(s0)
     bba:	4705                	li	a4,1
     bbc:	20100693          	li	a3,513
     bc0:	85be                	mv	a1,a5
     bc2:	fc843503          	ld	a0,-56(s0)
     bc6:	00000097          	auipc	ra,0x0
     bca:	914080e7          	jalr	-1772(ra) # 4da <redircmd>
     bce:	fca43423          	sd	a0,-56(s0)
      break;
     bd2:	0001                	nop
  while(peek(ps, es, "<>")){
     bd4:	00001617          	auipc	a2,0x1
     bd8:	19c60613          	addi	a2,a2,412 # 1d70 <malloc+0x214>
     bdc:	fb843583          	ld	a1,-72(s0)
     be0:	fc043503          	ld	a0,-64(s0)
     be4:	00000097          	auipc	ra,0x0
     be8:	c56080e7          	jalr	-938(ra) # 83a <peek>
     bec:	87aa                	mv	a5,a0
     bee:	ee0798e3          	bnez	a5,ade <parseredirs+0x16>
    }
  }
  return cmd;
     bf2:	fc843783          	ld	a5,-56(s0)
}
     bf6:	853e                	mv	a0,a5
     bf8:	60a6                	ld	ra,72(sp)
     bfa:	6406                	ld	s0,64(sp)
     bfc:	6161                	addi	sp,sp,80
     bfe:	8082                	ret

0000000000000c00 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     c00:	7179                	addi	sp,sp,-48
     c02:	f406                	sd	ra,40(sp)
     c04:	f022                	sd	s0,32(sp)
     c06:	1800                	addi	s0,sp,48
     c08:	fca43c23          	sd	a0,-40(s0)
     c0c:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     c10:	00001617          	auipc	a2,0x1
     c14:	16860613          	addi	a2,a2,360 # 1d78 <malloc+0x21c>
     c18:	fd043583          	ld	a1,-48(s0)
     c1c:	fd843503          	ld	a0,-40(s0)
     c20:	00000097          	auipc	ra,0x0
     c24:	c1a080e7          	jalr	-998(ra) # 83a <peek>
     c28:	87aa                	mv	a5,a0
     c2a:	eb89                	bnez	a5,c3c <parseblock+0x3c>
    panic("parseblock");
     c2c:	00001517          	auipc	a0,0x1
     c30:	15450513          	addi	a0,a0,340 # 1d80 <malloc+0x224>
     c34:	fffff097          	auipc	ra,0xfffff
     c38:	7f8080e7          	jalr	2040(ra) # 42c <panic>
  gettoken(ps, es, 0, 0);
     c3c:	4681                	li	a3,0
     c3e:	4601                	li	a2,0
     c40:	fd043583          	ld	a1,-48(s0)
     c44:	fd843503          	ld	a0,-40(s0)
     c48:	00000097          	auipc	ra,0x0
     c4c:	a16080e7          	jalr	-1514(ra) # 65e <gettoken>
  cmd = parseline(ps, es);
     c50:	fd043583          	ld	a1,-48(s0)
     c54:	fd843503          	ld	a0,-40(s0)
     c58:	00000097          	auipc	ra,0x0
     c5c:	d22080e7          	jalr	-734(ra) # 97a <parseline>
     c60:	fea43423          	sd	a0,-24(s0)
  if(!peek(ps, es, ")"))
     c64:	00001617          	auipc	a2,0x1
     c68:	12c60613          	addi	a2,a2,300 # 1d90 <malloc+0x234>
     c6c:	fd043583          	ld	a1,-48(s0)
     c70:	fd843503          	ld	a0,-40(s0)
     c74:	00000097          	auipc	ra,0x0
     c78:	bc6080e7          	jalr	-1082(ra) # 83a <peek>
     c7c:	87aa                	mv	a5,a0
     c7e:	eb89                	bnez	a5,c90 <parseblock+0x90>
    panic("syntax - missing )");
     c80:	00001517          	auipc	a0,0x1
     c84:	11850513          	addi	a0,a0,280 # 1d98 <malloc+0x23c>
     c88:	fffff097          	auipc	ra,0xfffff
     c8c:	7a4080e7          	jalr	1956(ra) # 42c <panic>
  gettoken(ps, es, 0, 0);
     c90:	4681                	li	a3,0
     c92:	4601                	li	a2,0
     c94:	fd043583          	ld	a1,-48(s0)
     c98:	fd843503          	ld	a0,-40(s0)
     c9c:	00000097          	auipc	ra,0x0
     ca0:	9c2080e7          	jalr	-1598(ra) # 65e <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ca4:	fd043603          	ld	a2,-48(s0)
     ca8:	fd843583          	ld	a1,-40(s0)
     cac:	fe843503          	ld	a0,-24(s0)
     cb0:	00000097          	auipc	ra,0x0
     cb4:	e18080e7          	jalr	-488(ra) # ac8 <parseredirs>
     cb8:	fea43423          	sd	a0,-24(s0)
  return cmd;
     cbc:	fe843783          	ld	a5,-24(s0)
}
     cc0:	853e                	mv	a0,a5
     cc2:	70a2                	ld	ra,40(sp)
     cc4:	7402                	ld	s0,32(sp)
     cc6:	6145                	addi	sp,sp,48
     cc8:	8082                	ret

0000000000000cca <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     cca:	715d                	addi	sp,sp,-80
     ccc:	e486                	sd	ra,72(sp)
     cce:	e0a2                	sd	s0,64(sp)
     cd0:	0880                	addi	s0,sp,80
     cd2:	faa43c23          	sd	a0,-72(s0)
     cd6:	fab43823          	sd	a1,-80(s0)
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     cda:	00001617          	auipc	a2,0x1
     cde:	09e60613          	addi	a2,a2,158 # 1d78 <malloc+0x21c>
     ce2:	fb043583          	ld	a1,-80(s0)
     ce6:	fb843503          	ld	a0,-72(s0)
     cea:	00000097          	auipc	ra,0x0
     cee:	b50080e7          	jalr	-1200(ra) # 83a <peek>
     cf2:	87aa                	mv	a5,a0
     cf4:	cb99                	beqz	a5,d0a <parseexec+0x40>
    return parseblock(ps, es);
     cf6:	fb043583          	ld	a1,-80(s0)
     cfa:	fb843503          	ld	a0,-72(s0)
     cfe:	00000097          	auipc	ra,0x0
     d02:	f02080e7          	jalr	-254(ra) # c00 <parseblock>
     d06:	87aa                	mv	a5,a0
     d08:	a22d                	j	e32 <parseexec+0x168>

  ret = execcmd();
     d0a:	fffff097          	auipc	ra,0xfffff
     d0e:	790080e7          	jalr	1936(ra) # 49a <execcmd>
     d12:	fea43023          	sd	a0,-32(s0)
  cmd = (struct execcmd*)ret;
     d16:	fe043783          	ld	a5,-32(s0)
     d1a:	fcf43c23          	sd	a5,-40(s0)

  argc = 0;
     d1e:	fe042623          	sw	zero,-20(s0)
  ret = parseredirs(ret, ps, es);
     d22:	fb043603          	ld	a2,-80(s0)
     d26:	fb843583          	ld	a1,-72(s0)
     d2a:	fe043503          	ld	a0,-32(s0)
     d2e:	00000097          	auipc	ra,0x0
     d32:	d9a080e7          	jalr	-614(ra) # ac8 <parseredirs>
     d36:	fea43023          	sd	a0,-32(s0)
  while(!peek(ps, es, "|)&;")){
     d3a:	a84d                	j	dec <parseexec+0x122>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     d3c:	fc040713          	addi	a4,s0,-64
     d40:	fc840793          	addi	a5,s0,-56
     d44:	86ba                	mv	a3,a4
     d46:	863e                	mv	a2,a5
     d48:	fb043583          	ld	a1,-80(s0)
     d4c:	fb843503          	ld	a0,-72(s0)
     d50:	00000097          	auipc	ra,0x0
     d54:	90e080e7          	jalr	-1778(ra) # 65e <gettoken>
     d58:	87aa                	mv	a5,a0
     d5a:	fcf42a23          	sw	a5,-44(s0)
     d5e:	fd442783          	lw	a5,-44(s0)
     d62:	2781                	sext.w	a5,a5
     d64:	c3dd                	beqz	a5,e0a <parseexec+0x140>
      break;
    if(tok != 'a')
     d66:	fd442783          	lw	a5,-44(s0)
     d6a:	0007871b          	sext.w	a4,a5
     d6e:	06100793          	li	a5,97
     d72:	00f70a63          	beq	a4,a5,d86 <parseexec+0xbc>
      panic("syntax");
     d76:	00001517          	auipc	a0,0x1
     d7a:	fba50513          	addi	a0,a0,-70 # 1d30 <malloc+0x1d4>
     d7e:	fffff097          	auipc	ra,0xfffff
     d82:	6ae080e7          	jalr	1710(ra) # 42c <panic>
    cmd->argv[argc] = q;
     d86:	fc843703          	ld	a4,-56(s0)
     d8a:	fd843683          	ld	a3,-40(s0)
     d8e:	fec42783          	lw	a5,-20(s0)
     d92:	078e                	slli	a5,a5,0x3
     d94:	97b6                	add	a5,a5,a3
     d96:	e798                	sd	a4,8(a5)
    cmd->eargv[argc] = eq;
     d98:	fc043703          	ld	a4,-64(s0)
     d9c:	fd843683          	ld	a3,-40(s0)
     da0:	fec42783          	lw	a5,-20(s0)
     da4:	07a9                	addi	a5,a5,10
     da6:	078e                	slli	a5,a5,0x3
     da8:	97b6                	add	a5,a5,a3
     daa:	e798                	sd	a4,8(a5)
    argc++;
     dac:	fec42783          	lw	a5,-20(s0)
     db0:	2785                	addiw	a5,a5,1
     db2:	fef42623          	sw	a5,-20(s0)
    if(argc >= MAXARGS)
     db6:	fec42783          	lw	a5,-20(s0)
     dba:	0007871b          	sext.w	a4,a5
     dbe:	47a5                	li	a5,9
     dc0:	00e7da63          	bge	a5,a4,dd4 <parseexec+0x10a>
      panic("too many args");
     dc4:	00001517          	auipc	a0,0x1
     dc8:	fec50513          	addi	a0,a0,-20 # 1db0 <malloc+0x254>
     dcc:	fffff097          	auipc	ra,0xfffff
     dd0:	660080e7          	jalr	1632(ra) # 42c <panic>
    ret = parseredirs(ret, ps, es);
     dd4:	fb043603          	ld	a2,-80(s0)
     dd8:	fb843583          	ld	a1,-72(s0)
     ddc:	fe043503          	ld	a0,-32(s0)
     de0:	00000097          	auipc	ra,0x0
     de4:	ce8080e7          	jalr	-792(ra) # ac8 <parseredirs>
     de8:	fea43023          	sd	a0,-32(s0)
  while(!peek(ps, es, "|)&;")){
     dec:	00001617          	auipc	a2,0x1
     df0:	fd460613          	addi	a2,a2,-44 # 1dc0 <malloc+0x264>
     df4:	fb043583          	ld	a1,-80(s0)
     df8:	fb843503          	ld	a0,-72(s0)
     dfc:	00000097          	auipc	ra,0x0
     e00:	a3e080e7          	jalr	-1474(ra) # 83a <peek>
     e04:	87aa                	mv	a5,a0
     e06:	db9d                	beqz	a5,d3c <parseexec+0x72>
     e08:	a011                	j	e0c <parseexec+0x142>
      break;
     e0a:	0001                	nop
  }
  cmd->argv[argc] = 0;
     e0c:	fd843703          	ld	a4,-40(s0)
     e10:	fec42783          	lw	a5,-20(s0)
     e14:	078e                	slli	a5,a5,0x3
     e16:	97ba                	add	a5,a5,a4
     e18:	0007b423          	sd	zero,8(a5)
  cmd->eargv[argc] = 0;
     e1c:	fd843703          	ld	a4,-40(s0)
     e20:	fec42783          	lw	a5,-20(s0)
     e24:	07a9                	addi	a5,a5,10
     e26:	078e                	slli	a5,a5,0x3
     e28:	97ba                	add	a5,a5,a4
     e2a:	0007b423          	sd	zero,8(a5)
  return ret;
     e2e:	fe043783          	ld	a5,-32(s0)
}
     e32:	853e                	mv	a0,a5
     e34:	60a6                	ld	ra,72(sp)
     e36:	6406                	ld	s0,64(sp)
     e38:	6161                	addi	sp,sp,80
     e3a:	8082                	ret

0000000000000e3c <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     e3c:	715d                	addi	sp,sp,-80
     e3e:	e486                	sd	ra,72(sp)
     e40:	e0a2                	sd	s0,64(sp)
     e42:	0880                	addi	s0,sp,80
     e44:	faa43c23          	sd	a0,-72(s0)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     e48:	fb843783          	ld	a5,-72(s0)
     e4c:	e399                	bnez	a5,e52 <nulterminate+0x16>
    return 0;
     e4e:	4781                	li	a5,0
     e50:	a211                	j	f54 <nulterminate+0x118>

  switch(cmd->type){
     e52:	fb843783          	ld	a5,-72(s0)
     e56:	439c                	lw	a5,0(a5)
     e58:	86be                	mv	a3,a5
     e5a:	4715                	li	a4,5
     e5c:	0ed76a63          	bltu	a4,a3,f50 <nulterminate+0x114>
     e60:	00279713          	slli	a4,a5,0x2
     e64:	00001797          	auipc	a5,0x1
     e68:	f6478793          	addi	a5,a5,-156 # 1dc8 <malloc+0x26c>
     e6c:	97ba                	add	a5,a5,a4
     e6e:	439c                	lw	a5,0(a5)
     e70:	0007871b          	sext.w	a4,a5
     e74:	00001797          	auipc	a5,0x1
     e78:	f5478793          	addi	a5,a5,-172 # 1dc8 <malloc+0x26c>
     e7c:	97ba                	add	a5,a5,a4
     e7e:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     e80:	fb843783          	ld	a5,-72(s0)
     e84:	fcf43023          	sd	a5,-64(s0)
    for(i=0; ecmd->argv[i]; i++)
     e88:	fe042623          	sw	zero,-20(s0)
     e8c:	a005                	j	eac <nulterminate+0x70>
      *ecmd->eargv[i] = 0;
     e8e:	fc043703          	ld	a4,-64(s0)
     e92:	fec42783          	lw	a5,-20(s0)
     e96:	07a9                	addi	a5,a5,10
     e98:	078e                	slli	a5,a5,0x3
     e9a:	97ba                	add	a5,a5,a4
     e9c:	679c                	ld	a5,8(a5)
     e9e:	00078023          	sb	zero,0(a5)
    for(i=0; ecmd->argv[i]; i++)
     ea2:	fec42783          	lw	a5,-20(s0)
     ea6:	2785                	addiw	a5,a5,1
     ea8:	fef42623          	sw	a5,-20(s0)
     eac:	fc043703          	ld	a4,-64(s0)
     eb0:	fec42783          	lw	a5,-20(s0)
     eb4:	078e                	slli	a5,a5,0x3
     eb6:	97ba                	add	a5,a5,a4
     eb8:	679c                	ld	a5,8(a5)
     eba:	fbf1                	bnez	a5,e8e <nulterminate+0x52>
    break;
     ebc:	a851                	j	f50 <nulterminate+0x114>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     ebe:	fb843783          	ld	a5,-72(s0)
     ec2:	fcf43423          	sd	a5,-56(s0)
    nulterminate(rcmd->cmd);
     ec6:	fc843783          	ld	a5,-56(s0)
     eca:	679c                	ld	a5,8(a5)
     ecc:	853e                	mv	a0,a5
     ece:	00000097          	auipc	ra,0x0
     ed2:	f6e080e7          	jalr	-146(ra) # e3c <nulterminate>
    *rcmd->efile = 0;
     ed6:	fc843783          	ld	a5,-56(s0)
     eda:	6f9c                	ld	a5,24(a5)
     edc:	00078023          	sb	zero,0(a5)
    break;
     ee0:	a885                	j	f50 <nulterminate+0x114>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     ee2:	fb843783          	ld	a5,-72(s0)
     ee6:	fcf43823          	sd	a5,-48(s0)
    nulterminate(pcmd->left);
     eea:	fd043783          	ld	a5,-48(s0)
     eee:	679c                	ld	a5,8(a5)
     ef0:	853e                	mv	a0,a5
     ef2:	00000097          	auipc	ra,0x0
     ef6:	f4a080e7          	jalr	-182(ra) # e3c <nulterminate>
    nulterminate(pcmd->right);
     efa:	fd043783          	ld	a5,-48(s0)
     efe:	6b9c                	ld	a5,16(a5)
     f00:	853e                	mv	a0,a5
     f02:	00000097          	auipc	ra,0x0
     f06:	f3a080e7          	jalr	-198(ra) # e3c <nulterminate>
    break;
     f0a:	a099                	j	f50 <nulterminate+0x114>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     f0c:	fb843783          	ld	a5,-72(s0)
     f10:	fcf43c23          	sd	a5,-40(s0)
    nulterminate(lcmd->left);
     f14:	fd843783          	ld	a5,-40(s0)
     f18:	679c                	ld	a5,8(a5)
     f1a:	853e                	mv	a0,a5
     f1c:	00000097          	auipc	ra,0x0
     f20:	f20080e7          	jalr	-224(ra) # e3c <nulterminate>
    nulterminate(lcmd->right);
     f24:	fd843783          	ld	a5,-40(s0)
     f28:	6b9c                	ld	a5,16(a5)
     f2a:	853e                	mv	a0,a5
     f2c:	00000097          	auipc	ra,0x0
     f30:	f10080e7          	jalr	-240(ra) # e3c <nulterminate>
    break;
     f34:	a831                	j	f50 <nulterminate+0x114>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     f36:	fb843783          	ld	a5,-72(s0)
     f3a:	fef43023          	sd	a5,-32(s0)
    nulterminate(bcmd->cmd);
     f3e:	fe043783          	ld	a5,-32(s0)
     f42:	679c                	ld	a5,8(a5)
     f44:	853e                	mv	a0,a5
     f46:	00000097          	auipc	ra,0x0
     f4a:	ef6080e7          	jalr	-266(ra) # e3c <nulterminate>
    break;
     f4e:	0001                	nop
  }
  return cmd;
     f50:	fb843783          	ld	a5,-72(s0)
}
     f54:	853e                	mv	a0,a5
     f56:	60a6                	ld	ra,72(sp)
     f58:	6406                	ld	s0,64(sp)
     f5a:	6161                	addi	sp,sp,80
     f5c:	8082                	ret

0000000000000f5e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     f5e:	1141                	addi	sp,sp,-16
     f60:	e406                	sd	ra,8(sp)
     f62:	e022                	sd	s0,0(sp)
     f64:	0800                	addi	s0,sp,16
  extern int main();
  main();
     f66:	fffff097          	auipc	ra,0xfffff
     f6a:	37e080e7          	jalr	894(ra) # 2e4 <main>
  exit(0);
     f6e:	4501                	li	a0,0
     f70:	00000097          	auipc	ra,0x0
     f74:	49a080e7          	jalr	1178(ra) # 140a <exit>

0000000000000f78 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     f78:	7179                	addi	sp,sp,-48
     f7a:	f422                	sd	s0,40(sp)
     f7c:	1800                	addi	s0,sp,48
     f7e:	fca43c23          	sd	a0,-40(s0)
     f82:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     f86:	fd843783          	ld	a5,-40(s0)
     f8a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     f8e:	0001                	nop
     f90:	fd043703          	ld	a4,-48(s0)
     f94:	00170793          	addi	a5,a4,1
     f98:	fcf43823          	sd	a5,-48(s0)
     f9c:	fd843783          	ld	a5,-40(s0)
     fa0:	00178693          	addi	a3,a5,1
     fa4:	fcd43c23          	sd	a3,-40(s0)
     fa8:	00074703          	lbu	a4,0(a4)
     fac:	00e78023          	sb	a4,0(a5)
     fb0:	0007c783          	lbu	a5,0(a5)
     fb4:	fff1                	bnez	a5,f90 <strcpy+0x18>
    ;
  return os;
     fb6:	fe843783          	ld	a5,-24(s0)
}
     fba:	853e                	mv	a0,a5
     fbc:	7422                	ld	s0,40(sp)
     fbe:	6145                	addi	sp,sp,48
     fc0:	8082                	ret

0000000000000fc2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     fc2:	1101                	addi	sp,sp,-32
     fc4:	ec22                	sd	s0,24(sp)
     fc6:	1000                	addi	s0,sp,32
     fc8:	fea43423          	sd	a0,-24(s0)
     fcc:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     fd0:	a819                	j	fe6 <strcmp+0x24>
    p++, q++;
     fd2:	fe843783          	ld	a5,-24(s0)
     fd6:	0785                	addi	a5,a5,1
     fd8:	fef43423          	sd	a5,-24(s0)
     fdc:	fe043783          	ld	a5,-32(s0)
     fe0:	0785                	addi	a5,a5,1
     fe2:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     fe6:	fe843783          	ld	a5,-24(s0)
     fea:	0007c783          	lbu	a5,0(a5)
     fee:	cb99                	beqz	a5,1004 <strcmp+0x42>
     ff0:	fe843783          	ld	a5,-24(s0)
     ff4:	0007c703          	lbu	a4,0(a5)
     ff8:	fe043783          	ld	a5,-32(s0)
     ffc:	0007c783          	lbu	a5,0(a5)
    1000:	fcf709e3          	beq	a4,a5,fd2 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
    1004:	fe843783          	ld	a5,-24(s0)
    1008:	0007c783          	lbu	a5,0(a5)
    100c:	0007871b          	sext.w	a4,a5
    1010:	fe043783          	ld	a5,-32(s0)
    1014:	0007c783          	lbu	a5,0(a5)
    1018:	2781                	sext.w	a5,a5
    101a:	40f707bb          	subw	a5,a4,a5
    101e:	2781                	sext.w	a5,a5
}
    1020:	853e                	mv	a0,a5
    1022:	6462                	ld	s0,24(sp)
    1024:	6105                	addi	sp,sp,32
    1026:	8082                	ret

0000000000001028 <strlen>:

uint
strlen(const char *s)
{
    1028:	7179                	addi	sp,sp,-48
    102a:	f422                	sd	s0,40(sp)
    102c:	1800                	addi	s0,sp,48
    102e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    1032:	fe042623          	sw	zero,-20(s0)
    1036:	a031                	j	1042 <strlen+0x1a>
    1038:	fec42783          	lw	a5,-20(s0)
    103c:	2785                	addiw	a5,a5,1
    103e:	fef42623          	sw	a5,-20(s0)
    1042:	fec42783          	lw	a5,-20(s0)
    1046:	fd843703          	ld	a4,-40(s0)
    104a:	97ba                	add	a5,a5,a4
    104c:	0007c783          	lbu	a5,0(a5)
    1050:	f7e5                	bnez	a5,1038 <strlen+0x10>
    ;
  return n;
    1052:	fec42783          	lw	a5,-20(s0)
}
    1056:	853e                	mv	a0,a5
    1058:	7422                	ld	s0,40(sp)
    105a:	6145                	addi	sp,sp,48
    105c:	8082                	ret

000000000000105e <memset>:

void*
memset(void *dst, int c, uint n)
{
    105e:	7179                	addi	sp,sp,-48
    1060:	f422                	sd	s0,40(sp)
    1062:	1800                	addi	s0,sp,48
    1064:	fca43c23          	sd	a0,-40(s0)
    1068:	87ae                	mv	a5,a1
    106a:	8732                	mv	a4,a2
    106c:	fcf42a23          	sw	a5,-44(s0)
    1070:	87ba                	mv	a5,a4
    1072:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    1076:	fd843783          	ld	a5,-40(s0)
    107a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    107e:	fe042623          	sw	zero,-20(s0)
    1082:	a00d                	j	10a4 <memset+0x46>
    cdst[i] = c;
    1084:	fec42783          	lw	a5,-20(s0)
    1088:	fe043703          	ld	a4,-32(s0)
    108c:	97ba                	add	a5,a5,a4
    108e:	fd442703          	lw	a4,-44(s0)
    1092:	0ff77713          	zext.b	a4,a4
    1096:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    109a:	fec42783          	lw	a5,-20(s0)
    109e:	2785                	addiw	a5,a5,1
    10a0:	fef42623          	sw	a5,-20(s0)
    10a4:	fec42703          	lw	a4,-20(s0)
    10a8:	fd042783          	lw	a5,-48(s0)
    10ac:	2781                	sext.w	a5,a5
    10ae:	fcf76be3          	bltu	a4,a5,1084 <memset+0x26>
  }
  return dst;
    10b2:	fd843783          	ld	a5,-40(s0)
}
    10b6:	853e                	mv	a0,a5
    10b8:	7422                	ld	s0,40(sp)
    10ba:	6145                	addi	sp,sp,48
    10bc:	8082                	ret

00000000000010be <strchr>:

char*
strchr(const char *s, char c)
{
    10be:	1101                	addi	sp,sp,-32
    10c0:	ec22                	sd	s0,24(sp)
    10c2:	1000                	addi	s0,sp,32
    10c4:	fea43423          	sd	a0,-24(s0)
    10c8:	87ae                	mv	a5,a1
    10ca:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    10ce:	a01d                	j	10f4 <strchr+0x36>
    if(*s == c)
    10d0:	fe843783          	ld	a5,-24(s0)
    10d4:	0007c703          	lbu	a4,0(a5)
    10d8:	fe744783          	lbu	a5,-25(s0)
    10dc:	0ff7f793          	zext.b	a5,a5
    10e0:	00e79563          	bne	a5,a4,10ea <strchr+0x2c>
      return (char*)s;
    10e4:	fe843783          	ld	a5,-24(s0)
    10e8:	a821                	j	1100 <strchr+0x42>
  for(; *s; s++)
    10ea:	fe843783          	ld	a5,-24(s0)
    10ee:	0785                	addi	a5,a5,1
    10f0:	fef43423          	sd	a5,-24(s0)
    10f4:	fe843783          	ld	a5,-24(s0)
    10f8:	0007c783          	lbu	a5,0(a5)
    10fc:	fbf1                	bnez	a5,10d0 <strchr+0x12>
  return 0;
    10fe:	4781                	li	a5,0
}
    1100:	853e                	mv	a0,a5
    1102:	6462                	ld	s0,24(sp)
    1104:	6105                	addi	sp,sp,32
    1106:	8082                	ret

0000000000001108 <gets>:

char*
gets(char *buf, int max)
{
    1108:	7179                	addi	sp,sp,-48
    110a:	f406                	sd	ra,40(sp)
    110c:	f022                	sd	s0,32(sp)
    110e:	1800                	addi	s0,sp,48
    1110:	fca43c23          	sd	a0,-40(s0)
    1114:	87ae                	mv	a5,a1
    1116:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    111a:	fe042623          	sw	zero,-20(s0)
    111e:	a8a1                	j	1176 <gets+0x6e>
    cc = read(0, &c, 1);
    1120:	fe740793          	addi	a5,s0,-25
    1124:	4605                	li	a2,1
    1126:	85be                	mv	a1,a5
    1128:	4501                	li	a0,0
    112a:	00000097          	auipc	ra,0x0
    112e:	2f8080e7          	jalr	760(ra) # 1422 <read>
    1132:	87aa                	mv	a5,a0
    1134:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    1138:	fe842783          	lw	a5,-24(s0)
    113c:	2781                	sext.w	a5,a5
    113e:	04f05763          	blez	a5,118c <gets+0x84>
      break;
    buf[i++] = c;
    1142:	fec42783          	lw	a5,-20(s0)
    1146:	0017871b          	addiw	a4,a5,1
    114a:	fee42623          	sw	a4,-20(s0)
    114e:	873e                	mv	a4,a5
    1150:	fd843783          	ld	a5,-40(s0)
    1154:	97ba                	add	a5,a5,a4
    1156:	fe744703          	lbu	a4,-25(s0)
    115a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    115e:	fe744783          	lbu	a5,-25(s0)
    1162:	873e                	mv	a4,a5
    1164:	47a9                	li	a5,10
    1166:	02f70463          	beq	a4,a5,118e <gets+0x86>
    116a:	fe744783          	lbu	a5,-25(s0)
    116e:	873e                	mv	a4,a5
    1170:	47b5                	li	a5,13
    1172:	00f70e63          	beq	a4,a5,118e <gets+0x86>
  for(i=0; i+1 < max; ){
    1176:	fec42783          	lw	a5,-20(s0)
    117a:	2785                	addiw	a5,a5,1
    117c:	0007871b          	sext.w	a4,a5
    1180:	fd442783          	lw	a5,-44(s0)
    1184:	2781                	sext.w	a5,a5
    1186:	f8f74de3          	blt	a4,a5,1120 <gets+0x18>
    118a:	a011                	j	118e <gets+0x86>
      break;
    118c:	0001                	nop
      break;
  }
  buf[i] = '\0';
    118e:	fec42783          	lw	a5,-20(s0)
    1192:	fd843703          	ld	a4,-40(s0)
    1196:	97ba                	add	a5,a5,a4
    1198:	00078023          	sb	zero,0(a5)
  return buf;
    119c:	fd843783          	ld	a5,-40(s0)
}
    11a0:	853e                	mv	a0,a5
    11a2:	70a2                	ld	ra,40(sp)
    11a4:	7402                	ld	s0,32(sp)
    11a6:	6145                	addi	sp,sp,48
    11a8:	8082                	ret

00000000000011aa <stat>:

int
stat(const char *n, struct stat *st)
{
    11aa:	7179                	addi	sp,sp,-48
    11ac:	f406                	sd	ra,40(sp)
    11ae:	f022                	sd	s0,32(sp)
    11b0:	1800                	addi	s0,sp,48
    11b2:	fca43c23          	sd	a0,-40(s0)
    11b6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11ba:	4581                	li	a1,0
    11bc:	fd843503          	ld	a0,-40(s0)
    11c0:	00000097          	auipc	ra,0x0
    11c4:	28a080e7          	jalr	650(ra) # 144a <open>
    11c8:	87aa                	mv	a5,a0
    11ca:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    11ce:	fec42783          	lw	a5,-20(s0)
    11d2:	2781                	sext.w	a5,a5
    11d4:	0007d463          	bgez	a5,11dc <stat+0x32>
    return -1;
    11d8:	57fd                	li	a5,-1
    11da:	a035                	j	1206 <stat+0x5c>
  r = fstat(fd, st);
    11dc:	fec42783          	lw	a5,-20(s0)
    11e0:	fd043583          	ld	a1,-48(s0)
    11e4:	853e                	mv	a0,a5
    11e6:	00000097          	auipc	ra,0x0
    11ea:	27c080e7          	jalr	636(ra) # 1462 <fstat>
    11ee:	87aa                	mv	a5,a0
    11f0:	fef42423          	sw	a5,-24(s0)
  close(fd);
    11f4:	fec42783          	lw	a5,-20(s0)
    11f8:	853e                	mv	a0,a5
    11fa:	00000097          	auipc	ra,0x0
    11fe:	238080e7          	jalr	568(ra) # 1432 <close>
  return r;
    1202:	fe842783          	lw	a5,-24(s0)
}
    1206:	853e                	mv	a0,a5
    1208:	70a2                	ld	ra,40(sp)
    120a:	7402                	ld	s0,32(sp)
    120c:	6145                	addi	sp,sp,48
    120e:	8082                	ret

0000000000001210 <atoi>:

int
atoi(const char *s)
{
    1210:	7179                	addi	sp,sp,-48
    1212:	f422                	sd	s0,40(sp)
    1214:	1800                	addi	s0,sp,48
    1216:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    121a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    121e:	a81d                	j	1254 <atoi+0x44>
    n = n*10 + *s++ - '0';
    1220:	fec42783          	lw	a5,-20(s0)
    1224:	873e                	mv	a4,a5
    1226:	87ba                	mv	a5,a4
    1228:	0027979b          	slliw	a5,a5,0x2
    122c:	9fb9                	addw	a5,a5,a4
    122e:	0017979b          	slliw	a5,a5,0x1
    1232:	0007871b          	sext.w	a4,a5
    1236:	fd843783          	ld	a5,-40(s0)
    123a:	00178693          	addi	a3,a5,1
    123e:	fcd43c23          	sd	a3,-40(s0)
    1242:	0007c783          	lbu	a5,0(a5)
    1246:	2781                	sext.w	a5,a5
    1248:	9fb9                	addw	a5,a5,a4
    124a:	2781                	sext.w	a5,a5
    124c:	fd07879b          	addiw	a5,a5,-48
    1250:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    1254:	fd843783          	ld	a5,-40(s0)
    1258:	0007c783          	lbu	a5,0(a5)
    125c:	873e                	mv	a4,a5
    125e:	02f00793          	li	a5,47
    1262:	00e7fb63          	bgeu	a5,a4,1278 <atoi+0x68>
    1266:	fd843783          	ld	a5,-40(s0)
    126a:	0007c783          	lbu	a5,0(a5)
    126e:	873e                	mv	a4,a5
    1270:	03900793          	li	a5,57
    1274:	fae7f6e3          	bgeu	a5,a4,1220 <atoi+0x10>
  return n;
    1278:	fec42783          	lw	a5,-20(s0)
}
    127c:	853e                	mv	a0,a5
    127e:	7422                	ld	s0,40(sp)
    1280:	6145                	addi	sp,sp,48
    1282:	8082                	ret

0000000000001284 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1284:	7139                	addi	sp,sp,-64
    1286:	fc22                	sd	s0,56(sp)
    1288:	0080                	addi	s0,sp,64
    128a:	fca43c23          	sd	a0,-40(s0)
    128e:	fcb43823          	sd	a1,-48(s0)
    1292:	87b2                	mv	a5,a2
    1294:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    1298:	fd843783          	ld	a5,-40(s0)
    129c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    12a0:	fd043783          	ld	a5,-48(s0)
    12a4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    12a8:	fe043703          	ld	a4,-32(s0)
    12ac:	fe843783          	ld	a5,-24(s0)
    12b0:	02e7fc63          	bgeu	a5,a4,12e8 <memmove+0x64>
    while(n-- > 0)
    12b4:	a00d                	j	12d6 <memmove+0x52>
      *dst++ = *src++;
    12b6:	fe043703          	ld	a4,-32(s0)
    12ba:	00170793          	addi	a5,a4,1
    12be:	fef43023          	sd	a5,-32(s0)
    12c2:	fe843783          	ld	a5,-24(s0)
    12c6:	00178693          	addi	a3,a5,1
    12ca:	fed43423          	sd	a3,-24(s0)
    12ce:	00074703          	lbu	a4,0(a4)
    12d2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    12d6:	fcc42783          	lw	a5,-52(s0)
    12da:	fff7871b          	addiw	a4,a5,-1
    12de:	fce42623          	sw	a4,-52(s0)
    12e2:	fcf04ae3          	bgtz	a5,12b6 <memmove+0x32>
    12e6:	a891                	j	133a <memmove+0xb6>
  } else {
    dst += n;
    12e8:	fcc42783          	lw	a5,-52(s0)
    12ec:	fe843703          	ld	a4,-24(s0)
    12f0:	97ba                	add	a5,a5,a4
    12f2:	fef43423          	sd	a5,-24(s0)
    src += n;
    12f6:	fcc42783          	lw	a5,-52(s0)
    12fa:	fe043703          	ld	a4,-32(s0)
    12fe:	97ba                	add	a5,a5,a4
    1300:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    1304:	a01d                	j	132a <memmove+0xa6>
      *--dst = *--src;
    1306:	fe043783          	ld	a5,-32(s0)
    130a:	17fd                	addi	a5,a5,-1
    130c:	fef43023          	sd	a5,-32(s0)
    1310:	fe843783          	ld	a5,-24(s0)
    1314:	17fd                	addi	a5,a5,-1
    1316:	fef43423          	sd	a5,-24(s0)
    131a:	fe043783          	ld	a5,-32(s0)
    131e:	0007c703          	lbu	a4,0(a5)
    1322:	fe843783          	ld	a5,-24(s0)
    1326:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    132a:	fcc42783          	lw	a5,-52(s0)
    132e:	fff7871b          	addiw	a4,a5,-1
    1332:	fce42623          	sw	a4,-52(s0)
    1336:	fcf048e3          	bgtz	a5,1306 <memmove+0x82>
  }
  return vdst;
    133a:	fd843783          	ld	a5,-40(s0)
}
    133e:	853e                	mv	a0,a5
    1340:	7462                	ld	s0,56(sp)
    1342:	6121                	addi	sp,sp,64
    1344:	8082                	ret

0000000000001346 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    1346:	7139                	addi	sp,sp,-64
    1348:	fc22                	sd	s0,56(sp)
    134a:	0080                	addi	s0,sp,64
    134c:	fca43c23          	sd	a0,-40(s0)
    1350:	fcb43823          	sd	a1,-48(s0)
    1354:	87b2                	mv	a5,a2
    1356:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    135a:	fd843783          	ld	a5,-40(s0)
    135e:	fef43423          	sd	a5,-24(s0)
    1362:	fd043783          	ld	a5,-48(s0)
    1366:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    136a:	a0a1                	j	13b2 <memcmp+0x6c>
    if (*p1 != *p2) {
    136c:	fe843783          	ld	a5,-24(s0)
    1370:	0007c703          	lbu	a4,0(a5)
    1374:	fe043783          	ld	a5,-32(s0)
    1378:	0007c783          	lbu	a5,0(a5)
    137c:	02f70163          	beq	a4,a5,139e <memcmp+0x58>
      return *p1 - *p2;
    1380:	fe843783          	ld	a5,-24(s0)
    1384:	0007c783          	lbu	a5,0(a5)
    1388:	0007871b          	sext.w	a4,a5
    138c:	fe043783          	ld	a5,-32(s0)
    1390:	0007c783          	lbu	a5,0(a5)
    1394:	2781                	sext.w	a5,a5
    1396:	40f707bb          	subw	a5,a4,a5
    139a:	2781                	sext.w	a5,a5
    139c:	a01d                	j	13c2 <memcmp+0x7c>
    }
    p1++;
    139e:	fe843783          	ld	a5,-24(s0)
    13a2:	0785                	addi	a5,a5,1
    13a4:	fef43423          	sd	a5,-24(s0)
    p2++;
    13a8:	fe043783          	ld	a5,-32(s0)
    13ac:	0785                	addi	a5,a5,1
    13ae:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    13b2:	fcc42783          	lw	a5,-52(s0)
    13b6:	fff7871b          	addiw	a4,a5,-1
    13ba:	fce42623          	sw	a4,-52(s0)
    13be:	f7dd                	bnez	a5,136c <memcmp+0x26>
  }
  return 0;
    13c0:	4781                	li	a5,0
}
    13c2:	853e                	mv	a0,a5
    13c4:	7462                	ld	s0,56(sp)
    13c6:	6121                	addi	sp,sp,64
    13c8:	8082                	ret

00000000000013ca <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    13ca:	7179                	addi	sp,sp,-48
    13cc:	f406                	sd	ra,40(sp)
    13ce:	f022                	sd	s0,32(sp)
    13d0:	1800                	addi	s0,sp,48
    13d2:	fea43423          	sd	a0,-24(s0)
    13d6:	feb43023          	sd	a1,-32(s0)
    13da:	87b2                	mv	a5,a2
    13dc:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    13e0:	fdc42783          	lw	a5,-36(s0)
    13e4:	863e                	mv	a2,a5
    13e6:	fe043583          	ld	a1,-32(s0)
    13ea:	fe843503          	ld	a0,-24(s0)
    13ee:	00000097          	auipc	ra,0x0
    13f2:	e96080e7          	jalr	-362(ra) # 1284 <memmove>
    13f6:	87aa                	mv	a5,a0
}
    13f8:	853e                	mv	a0,a5
    13fa:	70a2                	ld	ra,40(sp)
    13fc:	7402                	ld	s0,32(sp)
    13fe:	6145                	addi	sp,sp,48
    1400:	8082                	ret

0000000000001402 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    1402:	4885                	li	a7,1
 ecall
    1404:	00000073          	ecall
 ret
    1408:	8082                	ret

000000000000140a <exit>:
.global exit
exit:
 li a7, SYS_exit
    140a:	4889                	li	a7,2
 ecall
    140c:	00000073          	ecall
 ret
    1410:	8082                	ret

0000000000001412 <wait>:
.global wait
wait:
 li a7, SYS_wait
    1412:	488d                	li	a7,3
 ecall
    1414:	00000073          	ecall
 ret
    1418:	8082                	ret

000000000000141a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    141a:	4891                	li	a7,4
 ecall
    141c:	00000073          	ecall
 ret
    1420:	8082                	ret

0000000000001422 <read>:
.global read
read:
 li a7, SYS_read
    1422:	4895                	li	a7,5
 ecall
    1424:	00000073          	ecall
 ret
    1428:	8082                	ret

000000000000142a <write>:
.global write
write:
 li a7, SYS_write
    142a:	48c1                	li	a7,16
 ecall
    142c:	00000073          	ecall
 ret
    1430:	8082                	ret

0000000000001432 <close>:
.global close
close:
 li a7, SYS_close
    1432:	48d5                	li	a7,21
 ecall
    1434:	00000073          	ecall
 ret
    1438:	8082                	ret

000000000000143a <kill>:
.global kill
kill:
 li a7, SYS_kill
    143a:	4899                	li	a7,6
 ecall
    143c:	00000073          	ecall
 ret
    1440:	8082                	ret

0000000000001442 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1442:	489d                	li	a7,7
 ecall
    1444:	00000073          	ecall
 ret
    1448:	8082                	ret

000000000000144a <open>:
.global open
open:
 li a7, SYS_open
    144a:	48bd                	li	a7,15
 ecall
    144c:	00000073          	ecall
 ret
    1450:	8082                	ret

0000000000001452 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1452:	48c5                	li	a7,17
 ecall
    1454:	00000073          	ecall
 ret
    1458:	8082                	ret

000000000000145a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    145a:	48c9                	li	a7,18
 ecall
    145c:	00000073          	ecall
 ret
    1460:	8082                	ret

0000000000001462 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1462:	48a1                	li	a7,8
 ecall
    1464:	00000073          	ecall
 ret
    1468:	8082                	ret

000000000000146a <link>:
.global link
link:
 li a7, SYS_link
    146a:	48cd                	li	a7,19
 ecall
    146c:	00000073          	ecall
 ret
    1470:	8082                	ret

0000000000001472 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1472:	48d1                	li	a7,20
 ecall
    1474:	00000073          	ecall
 ret
    1478:	8082                	ret

000000000000147a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    147a:	48a5                	li	a7,9
 ecall
    147c:	00000073          	ecall
 ret
    1480:	8082                	ret

0000000000001482 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1482:	48a9                	li	a7,10
 ecall
    1484:	00000073          	ecall
 ret
    1488:	8082                	ret

000000000000148a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    148a:	48ad                	li	a7,11
 ecall
    148c:	00000073          	ecall
 ret
    1490:	8082                	ret

0000000000001492 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1492:	48b1                	li	a7,12
 ecall
    1494:	00000073          	ecall
 ret
    1498:	8082                	ret

000000000000149a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    149a:	48b5                	li	a7,13
 ecall
    149c:	00000073          	ecall
 ret
    14a0:	8082                	ret

00000000000014a2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    14a2:	48b9                	li	a7,14
 ecall
    14a4:	00000073          	ecall
 ret
    14a8:	8082                	ret

00000000000014aa <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
    14aa:	48d9                	li	a7,22
 ecall
    14ac:	00000073          	ecall
 ret
    14b0:	8082                	ret

00000000000014b2 <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
    14b2:	48dd                	li	a7,23
 ecall
    14b4:	00000073          	ecall
 ret
    14b8:	8082                	ret

00000000000014ba <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
    14ba:	48e1                	li	a7,24
 ecall
    14bc:	00000073          	ecall
 ret
    14c0:	8082                	ret

00000000000014c2 <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
    14c2:	48e5                	li	a7,25
 ecall
    14c4:	00000073          	ecall
 ret
    14c8:	8082                	ret

00000000000014ca <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
    14ca:	48e9                	li	a7,26
 ecall
    14cc:	00000073          	ecall
 ret
    14d0:	8082                	ret

00000000000014d2 <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
    14d2:	48ed                	li	a7,27
 ecall
    14d4:	00000073          	ecall
 ret
    14d8:	8082                	ret

00000000000014da <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
    14da:	48f1                	li	a7,28
 ecall
    14dc:	00000073          	ecall
 ret
    14e0:	8082                	ret

00000000000014e2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    14e2:	1101                	addi	sp,sp,-32
    14e4:	ec06                	sd	ra,24(sp)
    14e6:	e822                	sd	s0,16(sp)
    14e8:	1000                	addi	s0,sp,32
    14ea:	87aa                	mv	a5,a0
    14ec:	872e                	mv	a4,a1
    14ee:	fef42623          	sw	a5,-20(s0)
    14f2:	87ba                	mv	a5,a4
    14f4:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    14f8:	feb40713          	addi	a4,s0,-21
    14fc:	fec42783          	lw	a5,-20(s0)
    1500:	4605                	li	a2,1
    1502:	85ba                	mv	a1,a4
    1504:	853e                	mv	a0,a5
    1506:	00000097          	auipc	ra,0x0
    150a:	f24080e7          	jalr	-220(ra) # 142a <write>
}
    150e:	0001                	nop
    1510:	60e2                	ld	ra,24(sp)
    1512:	6442                	ld	s0,16(sp)
    1514:	6105                	addi	sp,sp,32
    1516:	8082                	ret

0000000000001518 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1518:	7139                	addi	sp,sp,-64
    151a:	fc06                	sd	ra,56(sp)
    151c:	f822                	sd	s0,48(sp)
    151e:	0080                	addi	s0,sp,64
    1520:	87aa                	mv	a5,a0
    1522:	8736                	mv	a4,a3
    1524:	fcf42623          	sw	a5,-52(s0)
    1528:	87ae                	mv	a5,a1
    152a:	fcf42423          	sw	a5,-56(s0)
    152e:	87b2                	mv	a5,a2
    1530:	fcf42223          	sw	a5,-60(s0)
    1534:	87ba                	mv	a5,a4
    1536:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    153a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    153e:	fc042783          	lw	a5,-64(s0)
    1542:	2781                	sext.w	a5,a5
    1544:	c38d                	beqz	a5,1566 <printint+0x4e>
    1546:	fc842783          	lw	a5,-56(s0)
    154a:	2781                	sext.w	a5,a5
    154c:	0007dd63          	bgez	a5,1566 <printint+0x4e>
    neg = 1;
    1550:	4785                	li	a5,1
    1552:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    1556:	fc842783          	lw	a5,-56(s0)
    155a:	40f007bb          	negw	a5,a5
    155e:	2781                	sext.w	a5,a5
    1560:	fef42223          	sw	a5,-28(s0)
    1564:	a029                	j	156e <printint+0x56>
  } else {
    x = xx;
    1566:	fc842783          	lw	a5,-56(s0)
    156a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    156e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    1572:	fc442783          	lw	a5,-60(s0)
    1576:	fe442703          	lw	a4,-28(s0)
    157a:	02f777bb          	remuw	a5,a4,a5
    157e:	0007861b          	sext.w	a2,a5
    1582:	fec42783          	lw	a5,-20(s0)
    1586:	0017871b          	addiw	a4,a5,1
    158a:	fee42623          	sw	a4,-20(s0)
    158e:	00001697          	auipc	a3,0x1
    1592:	0c268693          	addi	a3,a3,194 # 2650 <digits>
    1596:	02061713          	slli	a4,a2,0x20
    159a:	9301                	srli	a4,a4,0x20
    159c:	9736                	add	a4,a4,a3
    159e:	00074703          	lbu	a4,0(a4)
    15a2:	17c1                	addi	a5,a5,-16
    15a4:	97a2                	add	a5,a5,s0
    15a6:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    15aa:	fc442783          	lw	a5,-60(s0)
    15ae:	fe442703          	lw	a4,-28(s0)
    15b2:	02f757bb          	divuw	a5,a4,a5
    15b6:	fef42223          	sw	a5,-28(s0)
    15ba:	fe442783          	lw	a5,-28(s0)
    15be:	2781                	sext.w	a5,a5
    15c0:	fbcd                	bnez	a5,1572 <printint+0x5a>
  if(neg)
    15c2:	fe842783          	lw	a5,-24(s0)
    15c6:	2781                	sext.w	a5,a5
    15c8:	cf85                	beqz	a5,1600 <printint+0xe8>
    buf[i++] = '-';
    15ca:	fec42783          	lw	a5,-20(s0)
    15ce:	0017871b          	addiw	a4,a5,1
    15d2:	fee42623          	sw	a4,-20(s0)
    15d6:	17c1                	addi	a5,a5,-16
    15d8:	97a2                	add	a5,a5,s0
    15da:	02d00713          	li	a4,45
    15de:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    15e2:	a839                	j	1600 <printint+0xe8>
    putc(fd, buf[i]);
    15e4:	fec42783          	lw	a5,-20(s0)
    15e8:	17c1                	addi	a5,a5,-16
    15ea:	97a2                	add	a5,a5,s0
    15ec:	fe07c703          	lbu	a4,-32(a5)
    15f0:	fcc42783          	lw	a5,-52(s0)
    15f4:	85ba                	mv	a1,a4
    15f6:	853e                	mv	a0,a5
    15f8:	00000097          	auipc	ra,0x0
    15fc:	eea080e7          	jalr	-278(ra) # 14e2 <putc>
  while(--i >= 0)
    1600:	fec42783          	lw	a5,-20(s0)
    1604:	37fd                	addiw	a5,a5,-1
    1606:	fef42623          	sw	a5,-20(s0)
    160a:	fec42783          	lw	a5,-20(s0)
    160e:	2781                	sext.w	a5,a5
    1610:	fc07dae3          	bgez	a5,15e4 <printint+0xcc>
}
    1614:	0001                	nop
    1616:	0001                	nop
    1618:	70e2                	ld	ra,56(sp)
    161a:	7442                	ld	s0,48(sp)
    161c:	6121                	addi	sp,sp,64
    161e:	8082                	ret

0000000000001620 <printptr>:

static void
printptr(int fd, uint64 x) {
    1620:	7179                	addi	sp,sp,-48
    1622:	f406                	sd	ra,40(sp)
    1624:	f022                	sd	s0,32(sp)
    1626:	1800                	addi	s0,sp,48
    1628:	87aa                	mv	a5,a0
    162a:	fcb43823          	sd	a1,-48(s0)
    162e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    1632:	fdc42783          	lw	a5,-36(s0)
    1636:	03000593          	li	a1,48
    163a:	853e                	mv	a0,a5
    163c:	00000097          	auipc	ra,0x0
    1640:	ea6080e7          	jalr	-346(ra) # 14e2 <putc>
  putc(fd, 'x');
    1644:	fdc42783          	lw	a5,-36(s0)
    1648:	07800593          	li	a1,120
    164c:	853e                	mv	a0,a5
    164e:	00000097          	auipc	ra,0x0
    1652:	e94080e7          	jalr	-364(ra) # 14e2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1656:	fe042623          	sw	zero,-20(s0)
    165a:	a82d                	j	1694 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    165c:	fd043783          	ld	a5,-48(s0)
    1660:	93f1                	srli	a5,a5,0x3c
    1662:	00001717          	auipc	a4,0x1
    1666:	fee70713          	addi	a4,a4,-18 # 2650 <digits>
    166a:	97ba                	add	a5,a5,a4
    166c:	0007c703          	lbu	a4,0(a5)
    1670:	fdc42783          	lw	a5,-36(s0)
    1674:	85ba                	mv	a1,a4
    1676:	853e                	mv	a0,a5
    1678:	00000097          	auipc	ra,0x0
    167c:	e6a080e7          	jalr	-406(ra) # 14e2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1680:	fec42783          	lw	a5,-20(s0)
    1684:	2785                	addiw	a5,a5,1
    1686:	fef42623          	sw	a5,-20(s0)
    168a:	fd043783          	ld	a5,-48(s0)
    168e:	0792                	slli	a5,a5,0x4
    1690:	fcf43823          	sd	a5,-48(s0)
    1694:	fec42783          	lw	a5,-20(s0)
    1698:	873e                	mv	a4,a5
    169a:	47bd                	li	a5,15
    169c:	fce7f0e3          	bgeu	a5,a4,165c <printptr+0x3c>
}
    16a0:	0001                	nop
    16a2:	0001                	nop
    16a4:	70a2                	ld	ra,40(sp)
    16a6:	7402                	ld	s0,32(sp)
    16a8:	6145                	addi	sp,sp,48
    16aa:	8082                	ret

00000000000016ac <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    16ac:	715d                	addi	sp,sp,-80
    16ae:	e486                	sd	ra,72(sp)
    16b0:	e0a2                	sd	s0,64(sp)
    16b2:	0880                	addi	s0,sp,80
    16b4:	87aa                	mv	a5,a0
    16b6:	fcb43023          	sd	a1,-64(s0)
    16ba:	fac43c23          	sd	a2,-72(s0)
    16be:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    16c2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    16c6:	fe042223          	sw	zero,-28(s0)
    16ca:	a42d                	j	18f4 <vprintf+0x248>
    c = fmt[i] & 0xff;
    16cc:	fe442783          	lw	a5,-28(s0)
    16d0:	fc043703          	ld	a4,-64(s0)
    16d4:	97ba                	add	a5,a5,a4
    16d6:	0007c783          	lbu	a5,0(a5)
    16da:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    16de:	fe042783          	lw	a5,-32(s0)
    16e2:	2781                	sext.w	a5,a5
    16e4:	eb9d                	bnez	a5,171a <vprintf+0x6e>
      if(c == '%'){
    16e6:	fdc42783          	lw	a5,-36(s0)
    16ea:	0007871b          	sext.w	a4,a5
    16ee:	02500793          	li	a5,37
    16f2:	00f71763          	bne	a4,a5,1700 <vprintf+0x54>
        state = '%';
    16f6:	02500793          	li	a5,37
    16fa:	fef42023          	sw	a5,-32(s0)
    16fe:	a2f5                	j	18ea <vprintf+0x23e>
      } else {
        putc(fd, c);
    1700:	fdc42783          	lw	a5,-36(s0)
    1704:	0ff7f713          	zext.b	a4,a5
    1708:	fcc42783          	lw	a5,-52(s0)
    170c:	85ba                	mv	a1,a4
    170e:	853e                	mv	a0,a5
    1710:	00000097          	auipc	ra,0x0
    1714:	dd2080e7          	jalr	-558(ra) # 14e2 <putc>
    1718:	aac9                	j	18ea <vprintf+0x23e>
      }
    } else if(state == '%'){
    171a:	fe042783          	lw	a5,-32(s0)
    171e:	0007871b          	sext.w	a4,a5
    1722:	02500793          	li	a5,37
    1726:	1cf71263          	bne	a4,a5,18ea <vprintf+0x23e>
      if(c == 'd'){
    172a:	fdc42783          	lw	a5,-36(s0)
    172e:	0007871b          	sext.w	a4,a5
    1732:	06400793          	li	a5,100
    1736:	02f71463          	bne	a4,a5,175e <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    173a:	fb843783          	ld	a5,-72(s0)
    173e:	00878713          	addi	a4,a5,8
    1742:	fae43c23          	sd	a4,-72(s0)
    1746:	4398                	lw	a4,0(a5)
    1748:	fcc42783          	lw	a5,-52(s0)
    174c:	4685                	li	a3,1
    174e:	4629                	li	a2,10
    1750:	85ba                	mv	a1,a4
    1752:	853e                	mv	a0,a5
    1754:	00000097          	auipc	ra,0x0
    1758:	dc4080e7          	jalr	-572(ra) # 1518 <printint>
    175c:	a269                	j	18e6 <vprintf+0x23a>
      } else if(c == 'l') {
    175e:	fdc42783          	lw	a5,-36(s0)
    1762:	0007871b          	sext.w	a4,a5
    1766:	06c00793          	li	a5,108
    176a:	02f71663          	bne	a4,a5,1796 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    176e:	fb843783          	ld	a5,-72(s0)
    1772:	00878713          	addi	a4,a5,8
    1776:	fae43c23          	sd	a4,-72(s0)
    177a:	639c                	ld	a5,0(a5)
    177c:	0007871b          	sext.w	a4,a5
    1780:	fcc42783          	lw	a5,-52(s0)
    1784:	4681                	li	a3,0
    1786:	4629                	li	a2,10
    1788:	85ba                	mv	a1,a4
    178a:	853e                	mv	a0,a5
    178c:	00000097          	auipc	ra,0x0
    1790:	d8c080e7          	jalr	-628(ra) # 1518 <printint>
    1794:	aa89                	j	18e6 <vprintf+0x23a>
      } else if(c == 'x') {
    1796:	fdc42783          	lw	a5,-36(s0)
    179a:	0007871b          	sext.w	a4,a5
    179e:	07800793          	li	a5,120
    17a2:	02f71463          	bne	a4,a5,17ca <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    17a6:	fb843783          	ld	a5,-72(s0)
    17aa:	00878713          	addi	a4,a5,8
    17ae:	fae43c23          	sd	a4,-72(s0)
    17b2:	4398                	lw	a4,0(a5)
    17b4:	fcc42783          	lw	a5,-52(s0)
    17b8:	4681                	li	a3,0
    17ba:	4641                	li	a2,16
    17bc:	85ba                	mv	a1,a4
    17be:	853e                	mv	a0,a5
    17c0:	00000097          	auipc	ra,0x0
    17c4:	d58080e7          	jalr	-680(ra) # 1518 <printint>
    17c8:	aa39                	j	18e6 <vprintf+0x23a>
      } else if(c == 'p') {
    17ca:	fdc42783          	lw	a5,-36(s0)
    17ce:	0007871b          	sext.w	a4,a5
    17d2:	07000793          	li	a5,112
    17d6:	02f71263          	bne	a4,a5,17fa <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    17da:	fb843783          	ld	a5,-72(s0)
    17de:	00878713          	addi	a4,a5,8
    17e2:	fae43c23          	sd	a4,-72(s0)
    17e6:	6398                	ld	a4,0(a5)
    17e8:	fcc42783          	lw	a5,-52(s0)
    17ec:	85ba                	mv	a1,a4
    17ee:	853e                	mv	a0,a5
    17f0:	00000097          	auipc	ra,0x0
    17f4:	e30080e7          	jalr	-464(ra) # 1620 <printptr>
    17f8:	a0fd                	j	18e6 <vprintf+0x23a>
      } else if(c == 's'){
    17fa:	fdc42783          	lw	a5,-36(s0)
    17fe:	0007871b          	sext.w	a4,a5
    1802:	07300793          	li	a5,115
    1806:	04f71c63          	bne	a4,a5,185e <vprintf+0x1b2>
        s = va_arg(ap, char*);
    180a:	fb843783          	ld	a5,-72(s0)
    180e:	00878713          	addi	a4,a5,8
    1812:	fae43c23          	sd	a4,-72(s0)
    1816:	639c                	ld	a5,0(a5)
    1818:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    181c:	fe843783          	ld	a5,-24(s0)
    1820:	eb8d                	bnez	a5,1852 <vprintf+0x1a6>
          s = "(null)";
    1822:	00000797          	auipc	a5,0x0
    1826:	5be78793          	addi	a5,a5,1470 # 1de0 <malloc+0x284>
    182a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    182e:	a015                	j	1852 <vprintf+0x1a6>
          putc(fd, *s);
    1830:	fe843783          	ld	a5,-24(s0)
    1834:	0007c703          	lbu	a4,0(a5)
    1838:	fcc42783          	lw	a5,-52(s0)
    183c:	85ba                	mv	a1,a4
    183e:	853e                	mv	a0,a5
    1840:	00000097          	auipc	ra,0x0
    1844:	ca2080e7          	jalr	-862(ra) # 14e2 <putc>
          s++;
    1848:	fe843783          	ld	a5,-24(s0)
    184c:	0785                	addi	a5,a5,1
    184e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    1852:	fe843783          	ld	a5,-24(s0)
    1856:	0007c783          	lbu	a5,0(a5)
    185a:	fbf9                	bnez	a5,1830 <vprintf+0x184>
    185c:	a069                	j	18e6 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    185e:	fdc42783          	lw	a5,-36(s0)
    1862:	0007871b          	sext.w	a4,a5
    1866:	06300793          	li	a5,99
    186a:	02f71463          	bne	a4,a5,1892 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    186e:	fb843783          	ld	a5,-72(s0)
    1872:	00878713          	addi	a4,a5,8
    1876:	fae43c23          	sd	a4,-72(s0)
    187a:	439c                	lw	a5,0(a5)
    187c:	0ff7f713          	zext.b	a4,a5
    1880:	fcc42783          	lw	a5,-52(s0)
    1884:	85ba                	mv	a1,a4
    1886:	853e                	mv	a0,a5
    1888:	00000097          	auipc	ra,0x0
    188c:	c5a080e7          	jalr	-934(ra) # 14e2 <putc>
    1890:	a899                	j	18e6 <vprintf+0x23a>
      } else if(c == '%'){
    1892:	fdc42783          	lw	a5,-36(s0)
    1896:	0007871b          	sext.w	a4,a5
    189a:	02500793          	li	a5,37
    189e:	00f71f63          	bne	a4,a5,18bc <vprintf+0x210>
        putc(fd, c);
    18a2:	fdc42783          	lw	a5,-36(s0)
    18a6:	0ff7f713          	zext.b	a4,a5
    18aa:	fcc42783          	lw	a5,-52(s0)
    18ae:	85ba                	mv	a1,a4
    18b0:	853e                	mv	a0,a5
    18b2:	00000097          	auipc	ra,0x0
    18b6:	c30080e7          	jalr	-976(ra) # 14e2 <putc>
    18ba:	a035                	j	18e6 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    18bc:	fcc42783          	lw	a5,-52(s0)
    18c0:	02500593          	li	a1,37
    18c4:	853e                	mv	a0,a5
    18c6:	00000097          	auipc	ra,0x0
    18ca:	c1c080e7          	jalr	-996(ra) # 14e2 <putc>
        putc(fd, c);
    18ce:	fdc42783          	lw	a5,-36(s0)
    18d2:	0ff7f713          	zext.b	a4,a5
    18d6:	fcc42783          	lw	a5,-52(s0)
    18da:	85ba                	mv	a1,a4
    18dc:	853e                	mv	a0,a5
    18de:	00000097          	auipc	ra,0x0
    18e2:	c04080e7          	jalr	-1020(ra) # 14e2 <putc>
      }
      state = 0;
    18e6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    18ea:	fe442783          	lw	a5,-28(s0)
    18ee:	2785                	addiw	a5,a5,1
    18f0:	fef42223          	sw	a5,-28(s0)
    18f4:	fe442783          	lw	a5,-28(s0)
    18f8:	fc043703          	ld	a4,-64(s0)
    18fc:	97ba                	add	a5,a5,a4
    18fe:	0007c783          	lbu	a5,0(a5)
    1902:	dc0795e3          	bnez	a5,16cc <vprintf+0x20>
    }
  }
}
    1906:	0001                	nop
    1908:	0001                	nop
    190a:	60a6                	ld	ra,72(sp)
    190c:	6406                	ld	s0,64(sp)
    190e:	6161                	addi	sp,sp,80
    1910:	8082                	ret

0000000000001912 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1912:	7159                	addi	sp,sp,-112
    1914:	fc06                	sd	ra,56(sp)
    1916:	f822                	sd	s0,48(sp)
    1918:	0080                	addi	s0,sp,64
    191a:	fcb43823          	sd	a1,-48(s0)
    191e:	e010                	sd	a2,0(s0)
    1920:	e414                	sd	a3,8(s0)
    1922:	e818                	sd	a4,16(s0)
    1924:	ec1c                	sd	a5,24(s0)
    1926:	03043023          	sd	a6,32(s0)
    192a:	03143423          	sd	a7,40(s0)
    192e:	87aa                	mv	a5,a0
    1930:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    1934:	03040793          	addi	a5,s0,48
    1938:	fcf43423          	sd	a5,-56(s0)
    193c:	fc843783          	ld	a5,-56(s0)
    1940:	fd078793          	addi	a5,a5,-48
    1944:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    1948:	fe843703          	ld	a4,-24(s0)
    194c:	fdc42783          	lw	a5,-36(s0)
    1950:	863a                	mv	a2,a4
    1952:	fd043583          	ld	a1,-48(s0)
    1956:	853e                	mv	a0,a5
    1958:	00000097          	auipc	ra,0x0
    195c:	d54080e7          	jalr	-684(ra) # 16ac <vprintf>
}
    1960:	0001                	nop
    1962:	70e2                	ld	ra,56(sp)
    1964:	7442                	ld	s0,48(sp)
    1966:	6165                	addi	sp,sp,112
    1968:	8082                	ret

000000000000196a <printf>:

void
printf(const char *fmt, ...)
{
    196a:	7159                	addi	sp,sp,-112
    196c:	f406                	sd	ra,40(sp)
    196e:	f022                	sd	s0,32(sp)
    1970:	1800                	addi	s0,sp,48
    1972:	fca43c23          	sd	a0,-40(s0)
    1976:	e40c                	sd	a1,8(s0)
    1978:	e810                	sd	a2,16(s0)
    197a:	ec14                	sd	a3,24(s0)
    197c:	f018                	sd	a4,32(s0)
    197e:	f41c                	sd	a5,40(s0)
    1980:	03043823          	sd	a6,48(s0)
    1984:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1988:	04040793          	addi	a5,s0,64
    198c:	fcf43823          	sd	a5,-48(s0)
    1990:	fd043783          	ld	a5,-48(s0)
    1994:	fc878793          	addi	a5,a5,-56
    1998:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    199c:	fe843783          	ld	a5,-24(s0)
    19a0:	863e                	mv	a2,a5
    19a2:	fd843583          	ld	a1,-40(s0)
    19a6:	4505                	li	a0,1
    19a8:	00000097          	auipc	ra,0x0
    19ac:	d04080e7          	jalr	-764(ra) # 16ac <vprintf>
}
    19b0:	0001                	nop
    19b2:	70a2                	ld	ra,40(sp)
    19b4:	7402                	ld	s0,32(sp)
    19b6:	6165                	addi	sp,sp,112
    19b8:	8082                	ret

00000000000019ba <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    19ba:	7179                	addi	sp,sp,-48
    19bc:	f422                	sd	s0,40(sp)
    19be:	1800                	addi	s0,sp,48
    19c0:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    19c4:	fd843783          	ld	a5,-40(s0)
    19c8:	17c1                	addi	a5,a5,-16
    19ca:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    19ce:	00001797          	auipc	a5,0x1
    19d2:	d1a78793          	addi	a5,a5,-742 # 26e8 <freep>
    19d6:	639c                	ld	a5,0(a5)
    19d8:	fef43423          	sd	a5,-24(s0)
    19dc:	a815                	j	1a10 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    19de:	fe843783          	ld	a5,-24(s0)
    19e2:	639c                	ld	a5,0(a5)
    19e4:	fe843703          	ld	a4,-24(s0)
    19e8:	00f76f63          	bltu	a4,a5,1a06 <free+0x4c>
    19ec:	fe043703          	ld	a4,-32(s0)
    19f0:	fe843783          	ld	a5,-24(s0)
    19f4:	02e7eb63          	bltu	a5,a4,1a2a <free+0x70>
    19f8:	fe843783          	ld	a5,-24(s0)
    19fc:	639c                	ld	a5,0(a5)
    19fe:	fe043703          	ld	a4,-32(s0)
    1a02:	02f76463          	bltu	a4,a5,1a2a <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a06:	fe843783          	ld	a5,-24(s0)
    1a0a:	639c                	ld	a5,0(a5)
    1a0c:	fef43423          	sd	a5,-24(s0)
    1a10:	fe043703          	ld	a4,-32(s0)
    1a14:	fe843783          	ld	a5,-24(s0)
    1a18:	fce7f3e3          	bgeu	a5,a4,19de <free+0x24>
    1a1c:	fe843783          	ld	a5,-24(s0)
    1a20:	639c                	ld	a5,0(a5)
    1a22:	fe043703          	ld	a4,-32(s0)
    1a26:	faf77ce3          	bgeu	a4,a5,19de <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1a2a:	fe043783          	ld	a5,-32(s0)
    1a2e:	479c                	lw	a5,8(a5)
    1a30:	1782                	slli	a5,a5,0x20
    1a32:	9381                	srli	a5,a5,0x20
    1a34:	0792                	slli	a5,a5,0x4
    1a36:	fe043703          	ld	a4,-32(s0)
    1a3a:	973e                	add	a4,a4,a5
    1a3c:	fe843783          	ld	a5,-24(s0)
    1a40:	639c                	ld	a5,0(a5)
    1a42:	02f71763          	bne	a4,a5,1a70 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    1a46:	fe043783          	ld	a5,-32(s0)
    1a4a:	4798                	lw	a4,8(a5)
    1a4c:	fe843783          	ld	a5,-24(s0)
    1a50:	639c                	ld	a5,0(a5)
    1a52:	479c                	lw	a5,8(a5)
    1a54:	9fb9                	addw	a5,a5,a4
    1a56:	0007871b          	sext.w	a4,a5
    1a5a:	fe043783          	ld	a5,-32(s0)
    1a5e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    1a60:	fe843783          	ld	a5,-24(s0)
    1a64:	639c                	ld	a5,0(a5)
    1a66:	6398                	ld	a4,0(a5)
    1a68:	fe043783          	ld	a5,-32(s0)
    1a6c:	e398                	sd	a4,0(a5)
    1a6e:	a039                	j	1a7c <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    1a70:	fe843783          	ld	a5,-24(s0)
    1a74:	6398                	ld	a4,0(a5)
    1a76:	fe043783          	ld	a5,-32(s0)
    1a7a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1a7c:	fe843783          	ld	a5,-24(s0)
    1a80:	479c                	lw	a5,8(a5)
    1a82:	1782                	slli	a5,a5,0x20
    1a84:	9381                	srli	a5,a5,0x20
    1a86:	0792                	slli	a5,a5,0x4
    1a88:	fe843703          	ld	a4,-24(s0)
    1a8c:	97ba                	add	a5,a5,a4
    1a8e:	fe043703          	ld	a4,-32(s0)
    1a92:	02f71563          	bne	a4,a5,1abc <free+0x102>
    p->s.size += bp->s.size;
    1a96:	fe843783          	ld	a5,-24(s0)
    1a9a:	4798                	lw	a4,8(a5)
    1a9c:	fe043783          	ld	a5,-32(s0)
    1aa0:	479c                	lw	a5,8(a5)
    1aa2:	9fb9                	addw	a5,a5,a4
    1aa4:	0007871b          	sext.w	a4,a5
    1aa8:	fe843783          	ld	a5,-24(s0)
    1aac:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1aae:	fe043783          	ld	a5,-32(s0)
    1ab2:	6398                	ld	a4,0(a5)
    1ab4:	fe843783          	ld	a5,-24(s0)
    1ab8:	e398                	sd	a4,0(a5)
    1aba:	a031                	j	1ac6 <free+0x10c>
  } else
    p->s.ptr = bp;
    1abc:	fe843783          	ld	a5,-24(s0)
    1ac0:	fe043703          	ld	a4,-32(s0)
    1ac4:	e398                	sd	a4,0(a5)
  freep = p;
    1ac6:	00001797          	auipc	a5,0x1
    1aca:	c2278793          	addi	a5,a5,-990 # 26e8 <freep>
    1ace:	fe843703          	ld	a4,-24(s0)
    1ad2:	e398                	sd	a4,0(a5)
}
    1ad4:	0001                	nop
    1ad6:	7422                	ld	s0,40(sp)
    1ad8:	6145                	addi	sp,sp,48
    1ada:	8082                	ret

0000000000001adc <morecore>:

static Header*
morecore(uint nu)
{
    1adc:	7179                	addi	sp,sp,-48
    1ade:	f406                	sd	ra,40(sp)
    1ae0:	f022                	sd	s0,32(sp)
    1ae2:	1800                	addi	s0,sp,48
    1ae4:	87aa                	mv	a5,a0
    1ae6:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    1aea:	fdc42783          	lw	a5,-36(s0)
    1aee:	0007871b          	sext.w	a4,a5
    1af2:	6785                	lui	a5,0x1
    1af4:	00f77563          	bgeu	a4,a5,1afe <morecore+0x22>
    nu = 4096;
    1af8:	6785                	lui	a5,0x1
    1afa:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1afe:	fdc42783          	lw	a5,-36(s0)
    1b02:	0047979b          	slliw	a5,a5,0x4
    1b06:	2781                	sext.w	a5,a5
    1b08:	2781                	sext.w	a5,a5
    1b0a:	853e                	mv	a0,a5
    1b0c:	00000097          	auipc	ra,0x0
    1b10:	986080e7          	jalr	-1658(ra) # 1492 <sbrk>
    1b14:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    1b18:	fe843703          	ld	a4,-24(s0)
    1b1c:	57fd                	li	a5,-1
    1b1e:	00f71463          	bne	a4,a5,1b26 <morecore+0x4a>
    return 0;
    1b22:	4781                	li	a5,0
    1b24:	a03d                	j	1b52 <morecore+0x76>
  hp = (Header*)p;
    1b26:	fe843783          	ld	a5,-24(s0)
    1b2a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1b2e:	fe043783          	ld	a5,-32(s0)
    1b32:	fdc42703          	lw	a4,-36(s0)
    1b36:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1b38:	fe043783          	ld	a5,-32(s0)
    1b3c:	07c1                	addi	a5,a5,16 # 1010 <strcmp+0x4e>
    1b3e:	853e                	mv	a0,a5
    1b40:	00000097          	auipc	ra,0x0
    1b44:	e7a080e7          	jalr	-390(ra) # 19ba <free>
  return freep;
    1b48:	00001797          	auipc	a5,0x1
    1b4c:	ba078793          	addi	a5,a5,-1120 # 26e8 <freep>
    1b50:	639c                	ld	a5,0(a5)
}
    1b52:	853e                	mv	a0,a5
    1b54:	70a2                	ld	ra,40(sp)
    1b56:	7402                	ld	s0,32(sp)
    1b58:	6145                	addi	sp,sp,48
    1b5a:	8082                	ret

0000000000001b5c <malloc>:

void*
malloc(uint nbytes)
{
    1b5c:	7139                	addi	sp,sp,-64
    1b5e:	fc06                	sd	ra,56(sp)
    1b60:	f822                	sd	s0,48(sp)
    1b62:	0080                	addi	s0,sp,64
    1b64:	87aa                	mv	a5,a0
    1b66:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1b6a:	fcc46783          	lwu	a5,-52(s0)
    1b6e:	07bd                	addi	a5,a5,15
    1b70:	8391                	srli	a5,a5,0x4
    1b72:	2781                	sext.w	a5,a5
    1b74:	2785                	addiw	a5,a5,1
    1b76:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1b7a:	00001797          	auipc	a5,0x1
    1b7e:	b6e78793          	addi	a5,a5,-1170 # 26e8 <freep>
    1b82:	639c                	ld	a5,0(a5)
    1b84:	fef43023          	sd	a5,-32(s0)
    1b88:	fe043783          	ld	a5,-32(s0)
    1b8c:	ef95                	bnez	a5,1bc8 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1b8e:	00001797          	auipc	a5,0x1
    1b92:	b4a78793          	addi	a5,a5,-1206 # 26d8 <base>
    1b96:	fef43023          	sd	a5,-32(s0)
    1b9a:	00001797          	auipc	a5,0x1
    1b9e:	b4e78793          	addi	a5,a5,-1202 # 26e8 <freep>
    1ba2:	fe043703          	ld	a4,-32(s0)
    1ba6:	e398                	sd	a4,0(a5)
    1ba8:	00001797          	auipc	a5,0x1
    1bac:	b4078793          	addi	a5,a5,-1216 # 26e8 <freep>
    1bb0:	6398                	ld	a4,0(a5)
    1bb2:	00001797          	auipc	a5,0x1
    1bb6:	b2678793          	addi	a5,a5,-1242 # 26d8 <base>
    1bba:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1bbc:	00001797          	auipc	a5,0x1
    1bc0:	b1c78793          	addi	a5,a5,-1252 # 26d8 <base>
    1bc4:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1bc8:	fe043783          	ld	a5,-32(s0)
    1bcc:	639c                	ld	a5,0(a5)
    1bce:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1bd2:	fe843783          	ld	a5,-24(s0)
    1bd6:	4798                	lw	a4,8(a5)
    1bd8:	fdc42783          	lw	a5,-36(s0)
    1bdc:	2781                	sext.w	a5,a5
    1bde:	06f76763          	bltu	a4,a5,1c4c <malloc+0xf0>
      if(p->s.size == nunits)
    1be2:	fe843783          	ld	a5,-24(s0)
    1be6:	4798                	lw	a4,8(a5)
    1be8:	fdc42783          	lw	a5,-36(s0)
    1bec:	2781                	sext.w	a5,a5
    1bee:	00e79963          	bne	a5,a4,1c00 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1bf2:	fe843783          	ld	a5,-24(s0)
    1bf6:	6398                	ld	a4,0(a5)
    1bf8:	fe043783          	ld	a5,-32(s0)
    1bfc:	e398                	sd	a4,0(a5)
    1bfe:	a825                	j	1c36 <malloc+0xda>
      else {
        p->s.size -= nunits;
    1c00:	fe843783          	ld	a5,-24(s0)
    1c04:	479c                	lw	a5,8(a5)
    1c06:	fdc42703          	lw	a4,-36(s0)
    1c0a:	9f99                	subw	a5,a5,a4
    1c0c:	0007871b          	sext.w	a4,a5
    1c10:	fe843783          	ld	a5,-24(s0)
    1c14:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1c16:	fe843783          	ld	a5,-24(s0)
    1c1a:	479c                	lw	a5,8(a5)
    1c1c:	1782                	slli	a5,a5,0x20
    1c1e:	9381                	srli	a5,a5,0x20
    1c20:	0792                	slli	a5,a5,0x4
    1c22:	fe843703          	ld	a4,-24(s0)
    1c26:	97ba                	add	a5,a5,a4
    1c28:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1c2c:	fe843783          	ld	a5,-24(s0)
    1c30:	fdc42703          	lw	a4,-36(s0)
    1c34:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1c36:	00001797          	auipc	a5,0x1
    1c3a:	ab278793          	addi	a5,a5,-1358 # 26e8 <freep>
    1c3e:	fe043703          	ld	a4,-32(s0)
    1c42:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1c44:	fe843783          	ld	a5,-24(s0)
    1c48:	07c1                	addi	a5,a5,16
    1c4a:	a091                	j	1c8e <malloc+0x132>
    }
    if(p == freep)
    1c4c:	00001797          	auipc	a5,0x1
    1c50:	a9c78793          	addi	a5,a5,-1380 # 26e8 <freep>
    1c54:	639c                	ld	a5,0(a5)
    1c56:	fe843703          	ld	a4,-24(s0)
    1c5a:	02f71063          	bne	a4,a5,1c7a <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    1c5e:	fdc42783          	lw	a5,-36(s0)
    1c62:	853e                	mv	a0,a5
    1c64:	00000097          	auipc	ra,0x0
    1c68:	e78080e7          	jalr	-392(ra) # 1adc <morecore>
    1c6c:	fea43423          	sd	a0,-24(s0)
    1c70:	fe843783          	ld	a5,-24(s0)
    1c74:	e399                	bnez	a5,1c7a <malloc+0x11e>
        return 0;
    1c76:	4781                	li	a5,0
    1c78:	a819                	j	1c8e <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c7a:	fe843783          	ld	a5,-24(s0)
    1c7e:	fef43023          	sd	a5,-32(s0)
    1c82:	fe843783          	ld	a5,-24(s0)
    1c86:	639c                	ld	a5,0(a5)
    1c88:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1c8c:	b799                	j	1bd2 <malloc+0x76>
  }
}
    1c8e:	853e                	mv	a0,a5
    1c90:	70e2                	ld	ra,56(sp)
    1c92:	7442                	ld	s0,48(sp)
    1c94:	6121                	addi	sp,sp,64
    1c96:	8082                	ret
