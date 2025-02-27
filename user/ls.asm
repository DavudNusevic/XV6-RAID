
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	f426                	sd	s1,40(sp)
       8:	0080                	addi	s0,sp,64
       a:	fca43423          	sd	a0,-56(s0)
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       e:	fc843503          	ld	a0,-56(s0)
      12:	00000097          	auipc	ra,0x0
      16:	45a080e7          	jalr	1114(ra) # 46c <strlen>
      1a:	87aa                	mv	a5,a0
      1c:	2781                	sext.w	a5,a5
      1e:	1782                	slli	a5,a5,0x20
      20:	9381                	srli	a5,a5,0x20
      22:	fc843703          	ld	a4,-56(s0)
      26:	97ba                	add	a5,a5,a4
      28:	fcf43c23          	sd	a5,-40(s0)
      2c:	a031                	j	38 <fmtname+0x38>
      2e:	fd843783          	ld	a5,-40(s0)
      32:	17fd                	addi	a5,a5,-1
      34:	fcf43c23          	sd	a5,-40(s0)
      38:	fd843703          	ld	a4,-40(s0)
      3c:	fc843783          	ld	a5,-56(s0)
      40:	00f76b63          	bltu	a4,a5,56 <fmtname+0x56>
      44:	fd843783          	ld	a5,-40(s0)
      48:	0007c783          	lbu	a5,0(a5)
      4c:	873e                	mv	a4,a5
      4e:	02f00793          	li	a5,47
      52:	fcf71ee3          	bne	a4,a5,2e <fmtname+0x2e>
    ;
  p++;
      56:	fd843783          	ld	a5,-40(s0)
      5a:	0785                	addi	a5,a5,1
      5c:	fcf43c23          	sd	a5,-40(s0)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      60:	fd843503          	ld	a0,-40(s0)
      64:	00000097          	auipc	ra,0x0
      68:	408080e7          	jalr	1032(ra) # 46c <strlen>
      6c:	87aa                	mv	a5,a0
      6e:	2781                	sext.w	a5,a5
      70:	873e                	mv	a4,a5
      72:	47b5                	li	a5,13
      74:	00e7f563          	bgeu	a5,a4,7e <fmtname+0x7e>
    return p;
      78:	fd843783          	ld	a5,-40(s0)
      7c:	a8b5                	j	f8 <fmtname+0xf8>
  memmove(buf, p, strlen(p));
      7e:	fd843503          	ld	a0,-40(s0)
      82:	00000097          	auipc	ra,0x0
      86:	3ea080e7          	jalr	1002(ra) # 46c <strlen>
      8a:	87aa                	mv	a5,a0
      8c:	2781                	sext.w	a5,a5
      8e:	2781                	sext.w	a5,a5
      90:	863e                	mv	a2,a5
      92:	fd843583          	ld	a1,-40(s0)
      96:	00002517          	auipc	a0,0x2
      9a:	34a50513          	addi	a0,a0,842 # 23e0 <buf.0>
      9e:	00000097          	auipc	ra,0x0
      a2:	62a080e7          	jalr	1578(ra) # 6c8 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      a6:	fd843503          	ld	a0,-40(s0)
      aa:	00000097          	auipc	ra,0x0
      ae:	3c2080e7          	jalr	962(ra) # 46c <strlen>
      b2:	87aa                	mv	a5,a0
      b4:	2781                	sext.w	a5,a5
      b6:	02079713          	slli	a4,a5,0x20
      ba:	9301                	srli	a4,a4,0x20
      bc:	00002797          	auipc	a5,0x2
      c0:	32478793          	addi	a5,a5,804 # 23e0 <buf.0>
      c4:	00f704b3          	add	s1,a4,a5
      c8:	fd843503          	ld	a0,-40(s0)
      cc:	00000097          	auipc	ra,0x0
      d0:	3a0080e7          	jalr	928(ra) # 46c <strlen>
      d4:	87aa                	mv	a5,a0
      d6:	2781                	sext.w	a5,a5
      d8:	4739                	li	a4,14
      da:	40f707bb          	subw	a5,a4,a5
      de:	2781                	sext.w	a5,a5
      e0:	863e                	mv	a2,a5
      e2:	02000593          	li	a1,32
      e6:	8526                	mv	a0,s1
      e8:	00000097          	auipc	ra,0x0
      ec:	3ba080e7          	jalr	954(ra) # 4a2 <memset>
  return buf;
      f0:	00002797          	auipc	a5,0x2
      f4:	2f078793          	addi	a5,a5,752 # 23e0 <buf.0>
}
      f8:	853e                	mv	a0,a5
      fa:	70e2                	ld	ra,56(sp)
      fc:	7442                	ld	s0,48(sp)
      fe:	74a2                	ld	s1,40(sp)
     100:	6121                	addi	sp,sp,64
     102:	8082                	ret

0000000000000104 <ls>:

void
ls(char *path)
{
     104:	da010113          	addi	sp,sp,-608
     108:	24113c23          	sd	ra,600(sp)
     10c:	24813823          	sd	s0,592(sp)
     110:	1480                	addi	s0,sp,608
     112:	daa43423          	sd	a0,-600(s0)
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
     116:	4581                	li	a1,0
     118:	da843503          	ld	a0,-600(s0)
     11c:	00000097          	auipc	ra,0x0
     120:	772080e7          	jalr	1906(ra) # 88e <open>
     124:	87aa                	mv	a5,a0
     126:	fef42623          	sw	a5,-20(s0)
     12a:	fec42783          	lw	a5,-20(s0)
     12e:	2781                	sext.w	a5,a5
     130:	0007de63          	bgez	a5,14c <ls+0x48>
    fprintf(2, "ls: cannot open %s\n", path);
     134:	da843603          	ld	a2,-600(s0)
     138:	00001597          	auipc	a1,0x1
     13c:	fa858593          	addi	a1,a1,-88 # 10e0 <malloc+0x140>
     140:	4509                	li	a0,2
     142:	00001097          	auipc	ra,0x1
     146:	c14080e7          	jalr	-1004(ra) # d56 <fprintf>
    return;
     14a:	a2e9                	j	314 <ls+0x210>
  }

  if(fstat(fd, &st) < 0){
     14c:	db840713          	addi	a4,s0,-584
     150:	fec42783          	lw	a5,-20(s0)
     154:	85ba                	mv	a1,a4
     156:	853e                	mv	a0,a5
     158:	00000097          	auipc	ra,0x0
     15c:	74e080e7          	jalr	1870(ra) # 8a6 <fstat>
     160:	87aa                	mv	a5,a0
     162:	0207d563          	bgez	a5,18c <ls+0x88>
    fprintf(2, "ls: cannot stat %s\n", path);
     166:	da843603          	ld	a2,-600(s0)
     16a:	00001597          	auipc	a1,0x1
     16e:	f8e58593          	addi	a1,a1,-114 # 10f8 <malloc+0x158>
     172:	4509                	li	a0,2
     174:	00001097          	auipc	ra,0x1
     178:	be2080e7          	jalr	-1054(ra) # d56 <fprintf>
    close(fd);
     17c:	fec42783          	lw	a5,-20(s0)
     180:	853e                	mv	a0,a5
     182:	00000097          	auipc	ra,0x0
     186:	6f4080e7          	jalr	1780(ra) # 876 <close>
    return;
     18a:	a269                	j	314 <ls+0x210>
  }

  switch(st.type){
     18c:	dc041783          	lh	a5,-576(s0)
     190:	873e                	mv	a4,a5
     192:	86ba                	mv	a3,a4
     194:	4785                	li	a5,1
     196:	04f68563          	beq	a3,a5,1e0 <ls+0xdc>
     19a:	87ba                	mv	a5,a4
     19c:	16f05563          	blez	a5,306 <ls+0x202>
     1a0:	0007079b          	sext.w	a5,a4
     1a4:	37f9                	addiw	a5,a5,-2
     1a6:	2781                	sext.w	a5,a5
     1a8:	873e                	mv	a4,a5
     1aa:	4785                	li	a5,1
     1ac:	14e7ed63          	bltu	a5,a4,306 <ls+0x202>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
     1b0:	da843503          	ld	a0,-600(s0)
     1b4:	00000097          	auipc	ra,0x0
     1b8:	e4c080e7          	jalr	-436(ra) # 0 <fmtname>
     1bc:	85aa                	mv	a1,a0
     1be:	dc041783          	lh	a5,-576(s0)
     1c2:	863e                	mv	a2,a5
     1c4:	dbc42783          	lw	a5,-580(s0)
     1c8:	dc843703          	ld	a4,-568(s0)
     1cc:	86be                	mv	a3,a5
     1ce:	00001517          	auipc	a0,0x1
     1d2:	f4250513          	addi	a0,a0,-190 # 1110 <malloc+0x170>
     1d6:	00001097          	auipc	ra,0x1
     1da:	bd8080e7          	jalr	-1064(ra) # dae <printf>
    break;
     1de:	a225                	j	306 <ls+0x202>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1e0:	da843503          	ld	a0,-600(s0)
     1e4:	00000097          	auipc	ra,0x0
     1e8:	288080e7          	jalr	648(ra) # 46c <strlen>
     1ec:	87aa                	mv	a5,a0
     1ee:	2781                	sext.w	a5,a5
     1f0:	27c1                	addiw	a5,a5,16
     1f2:	2781                	sext.w	a5,a5
     1f4:	873e                	mv	a4,a5
     1f6:	20000793          	li	a5,512
     1fa:	00e7fb63          	bgeu	a5,a4,210 <ls+0x10c>
      printf("ls: path too long\n");
     1fe:	00001517          	auipc	a0,0x1
     202:	f2250513          	addi	a0,a0,-222 # 1120 <malloc+0x180>
     206:	00001097          	auipc	ra,0x1
     20a:	ba8080e7          	jalr	-1112(ra) # dae <printf>
      break;
     20e:	a8e5                	j	306 <ls+0x202>
    }
    strcpy(buf, path);
     210:	de040793          	addi	a5,s0,-544
     214:	da843583          	ld	a1,-600(s0)
     218:	853e                	mv	a0,a5
     21a:	00000097          	auipc	ra,0x0
     21e:	1a2080e7          	jalr	418(ra) # 3bc <strcpy>
    p = buf+strlen(buf);
     222:	de040793          	addi	a5,s0,-544
     226:	853e                	mv	a0,a5
     228:	00000097          	auipc	ra,0x0
     22c:	244080e7          	jalr	580(ra) # 46c <strlen>
     230:	87aa                	mv	a5,a0
     232:	2781                	sext.w	a5,a5
     234:	1782                	slli	a5,a5,0x20
     236:	9381                	srli	a5,a5,0x20
     238:	de040713          	addi	a4,s0,-544
     23c:	97ba                	add	a5,a5,a4
     23e:	fef43023          	sd	a5,-32(s0)
    *p++ = '/';
     242:	fe043783          	ld	a5,-32(s0)
     246:	00178713          	addi	a4,a5,1
     24a:	fee43023          	sd	a4,-32(s0)
     24e:	02f00713          	li	a4,47
     252:	00e78023          	sb	a4,0(a5)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     256:	a079                	j	2e4 <ls+0x1e0>
      if(de.inum == 0)
     258:	dd045783          	lhu	a5,-560(s0)
     25c:	c3d9                	beqz	a5,2e2 <ls+0x1de>
        continue;
      memmove(p, de.name, DIRSIZ);
     25e:	dd040793          	addi	a5,s0,-560
     262:	0789                	addi	a5,a5,2
     264:	4639                	li	a2,14
     266:	85be                	mv	a1,a5
     268:	fe043503          	ld	a0,-32(s0)
     26c:	00000097          	auipc	ra,0x0
     270:	45c080e7          	jalr	1116(ra) # 6c8 <memmove>
      p[DIRSIZ] = 0;
     274:	fe043783          	ld	a5,-32(s0)
     278:	07b9                	addi	a5,a5,14
     27a:	00078023          	sb	zero,0(a5)
      if(stat(buf, &st) < 0){
     27e:	db840713          	addi	a4,s0,-584
     282:	de040793          	addi	a5,s0,-544
     286:	85ba                	mv	a1,a4
     288:	853e                	mv	a0,a5
     28a:	00000097          	auipc	ra,0x0
     28e:	364080e7          	jalr	868(ra) # 5ee <stat>
     292:	87aa                	mv	a5,a0
     294:	0007de63          	bgez	a5,2b0 <ls+0x1ac>
        printf("ls: cannot stat %s\n", buf);
     298:	de040793          	addi	a5,s0,-544
     29c:	85be                	mv	a1,a5
     29e:	00001517          	auipc	a0,0x1
     2a2:	e5a50513          	addi	a0,a0,-422 # 10f8 <malloc+0x158>
     2a6:	00001097          	auipc	ra,0x1
     2aa:	b08080e7          	jalr	-1272(ra) # dae <printf>
        continue;
     2ae:	a81d                	j	2e4 <ls+0x1e0>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     2b0:	de040793          	addi	a5,s0,-544
     2b4:	853e                	mv	a0,a5
     2b6:	00000097          	auipc	ra,0x0
     2ba:	d4a080e7          	jalr	-694(ra) # 0 <fmtname>
     2be:	85aa                	mv	a1,a0
     2c0:	dc041783          	lh	a5,-576(s0)
     2c4:	863e                	mv	a2,a5
     2c6:	dbc42783          	lw	a5,-580(s0)
     2ca:	dc843703          	ld	a4,-568(s0)
     2ce:	86be                	mv	a3,a5
     2d0:	00001517          	auipc	a0,0x1
     2d4:	e6850513          	addi	a0,a0,-408 # 1138 <malloc+0x198>
     2d8:	00001097          	auipc	ra,0x1
     2dc:	ad6080e7          	jalr	-1322(ra) # dae <printf>
     2e0:	a011                	j	2e4 <ls+0x1e0>
        continue;
     2e2:	0001                	nop
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2e4:	dd040713          	addi	a4,s0,-560
     2e8:	fec42783          	lw	a5,-20(s0)
     2ec:	4641                	li	a2,16
     2ee:	85ba                	mv	a1,a4
     2f0:	853e                	mv	a0,a5
     2f2:	00000097          	auipc	ra,0x0
     2f6:	574080e7          	jalr	1396(ra) # 866 <read>
     2fa:	87aa                	mv	a5,a0
     2fc:	873e                	mv	a4,a5
     2fe:	47c1                	li	a5,16
     300:	f4f70ce3          	beq	a4,a5,258 <ls+0x154>
    }
    break;
     304:	0001                	nop
  }
  close(fd);
     306:	fec42783          	lw	a5,-20(s0)
     30a:	853e                	mv	a0,a5
     30c:	00000097          	auipc	ra,0x0
     310:	56a080e7          	jalr	1386(ra) # 876 <close>
}
     314:	25813083          	ld	ra,600(sp)
     318:	25013403          	ld	s0,592(sp)
     31c:	26010113          	addi	sp,sp,608
     320:	8082                	ret

0000000000000322 <main>:

int
main(int argc, char *argv[])
{
     322:	7179                	addi	sp,sp,-48
     324:	f406                	sd	ra,40(sp)
     326:	f022                	sd	s0,32(sp)
     328:	1800                	addi	s0,sp,48
     32a:	87aa                	mv	a5,a0
     32c:	fcb43823          	sd	a1,-48(s0)
     330:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
     334:	fdc42783          	lw	a5,-36(s0)
     338:	0007871b          	sext.w	a4,a5
     33c:	4785                	li	a5,1
     33e:	00e7cf63          	blt	a5,a4,35c <main+0x3a>
    ls(".");
     342:	00001517          	auipc	a0,0x1
     346:	e0650513          	addi	a0,a0,-506 # 1148 <malloc+0x1a8>
     34a:	00000097          	auipc	ra,0x0
     34e:	dba080e7          	jalr	-582(ra) # 104 <ls>
    exit(0);
     352:	4501                	li	a0,0
     354:	00000097          	auipc	ra,0x0
     358:	4fa080e7          	jalr	1274(ra) # 84e <exit>
  }
  for(i=1; i<argc; i++)
     35c:	4785                	li	a5,1
     35e:	fef42623          	sw	a5,-20(s0)
     362:	a015                	j	386 <main+0x64>
    ls(argv[i]);
     364:	fec42783          	lw	a5,-20(s0)
     368:	078e                	slli	a5,a5,0x3
     36a:	fd043703          	ld	a4,-48(s0)
     36e:	97ba                	add	a5,a5,a4
     370:	639c                	ld	a5,0(a5)
     372:	853e                	mv	a0,a5
     374:	00000097          	auipc	ra,0x0
     378:	d90080e7          	jalr	-624(ra) # 104 <ls>
  for(i=1; i<argc; i++)
     37c:	fec42783          	lw	a5,-20(s0)
     380:	2785                	addiw	a5,a5,1
     382:	fef42623          	sw	a5,-20(s0)
     386:	fec42783          	lw	a5,-20(s0)
     38a:	873e                	mv	a4,a5
     38c:	fdc42783          	lw	a5,-36(s0)
     390:	2701                	sext.w	a4,a4
     392:	2781                	sext.w	a5,a5
     394:	fcf748e3          	blt	a4,a5,364 <main+0x42>
  exit(0);
     398:	4501                	li	a0,0
     39a:	00000097          	auipc	ra,0x0
     39e:	4b4080e7          	jalr	1204(ra) # 84e <exit>

00000000000003a2 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     3a2:	1141                	addi	sp,sp,-16
     3a4:	e406                	sd	ra,8(sp)
     3a6:	e022                	sd	s0,0(sp)
     3a8:	0800                	addi	s0,sp,16
  extern int main();
  main();
     3aa:	00000097          	auipc	ra,0x0
     3ae:	f78080e7          	jalr	-136(ra) # 322 <main>
  exit(0);
     3b2:	4501                	li	a0,0
     3b4:	00000097          	auipc	ra,0x0
     3b8:	49a080e7          	jalr	1178(ra) # 84e <exit>

00000000000003bc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     3bc:	7179                	addi	sp,sp,-48
     3be:	f422                	sd	s0,40(sp)
     3c0:	1800                	addi	s0,sp,48
     3c2:	fca43c23          	sd	a0,-40(s0)
     3c6:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     3ca:	fd843783          	ld	a5,-40(s0)
     3ce:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     3d2:	0001                	nop
     3d4:	fd043703          	ld	a4,-48(s0)
     3d8:	00170793          	addi	a5,a4,1
     3dc:	fcf43823          	sd	a5,-48(s0)
     3e0:	fd843783          	ld	a5,-40(s0)
     3e4:	00178693          	addi	a3,a5,1
     3e8:	fcd43c23          	sd	a3,-40(s0)
     3ec:	00074703          	lbu	a4,0(a4)
     3f0:	00e78023          	sb	a4,0(a5)
     3f4:	0007c783          	lbu	a5,0(a5)
     3f8:	fff1                	bnez	a5,3d4 <strcpy+0x18>
    ;
  return os;
     3fa:	fe843783          	ld	a5,-24(s0)
}
     3fe:	853e                	mv	a0,a5
     400:	7422                	ld	s0,40(sp)
     402:	6145                	addi	sp,sp,48
     404:	8082                	ret

0000000000000406 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     406:	1101                	addi	sp,sp,-32
     408:	ec22                	sd	s0,24(sp)
     40a:	1000                	addi	s0,sp,32
     40c:	fea43423          	sd	a0,-24(s0)
     410:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     414:	a819                	j	42a <strcmp+0x24>
    p++, q++;
     416:	fe843783          	ld	a5,-24(s0)
     41a:	0785                	addi	a5,a5,1
     41c:	fef43423          	sd	a5,-24(s0)
     420:	fe043783          	ld	a5,-32(s0)
     424:	0785                	addi	a5,a5,1
     426:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     42a:	fe843783          	ld	a5,-24(s0)
     42e:	0007c783          	lbu	a5,0(a5)
     432:	cb99                	beqz	a5,448 <strcmp+0x42>
     434:	fe843783          	ld	a5,-24(s0)
     438:	0007c703          	lbu	a4,0(a5)
     43c:	fe043783          	ld	a5,-32(s0)
     440:	0007c783          	lbu	a5,0(a5)
     444:	fcf709e3          	beq	a4,a5,416 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     448:	fe843783          	ld	a5,-24(s0)
     44c:	0007c783          	lbu	a5,0(a5)
     450:	0007871b          	sext.w	a4,a5
     454:	fe043783          	ld	a5,-32(s0)
     458:	0007c783          	lbu	a5,0(a5)
     45c:	2781                	sext.w	a5,a5
     45e:	40f707bb          	subw	a5,a4,a5
     462:	2781                	sext.w	a5,a5
}
     464:	853e                	mv	a0,a5
     466:	6462                	ld	s0,24(sp)
     468:	6105                	addi	sp,sp,32
     46a:	8082                	ret

000000000000046c <strlen>:

uint
strlen(const char *s)
{
     46c:	7179                	addi	sp,sp,-48
     46e:	f422                	sd	s0,40(sp)
     470:	1800                	addi	s0,sp,48
     472:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     476:	fe042623          	sw	zero,-20(s0)
     47a:	a031                	j	486 <strlen+0x1a>
     47c:	fec42783          	lw	a5,-20(s0)
     480:	2785                	addiw	a5,a5,1
     482:	fef42623          	sw	a5,-20(s0)
     486:	fec42783          	lw	a5,-20(s0)
     48a:	fd843703          	ld	a4,-40(s0)
     48e:	97ba                	add	a5,a5,a4
     490:	0007c783          	lbu	a5,0(a5)
     494:	f7e5                	bnez	a5,47c <strlen+0x10>
    ;
  return n;
     496:	fec42783          	lw	a5,-20(s0)
}
     49a:	853e                	mv	a0,a5
     49c:	7422                	ld	s0,40(sp)
     49e:	6145                	addi	sp,sp,48
     4a0:	8082                	ret

00000000000004a2 <memset>:

void*
memset(void *dst, int c, uint n)
{
     4a2:	7179                	addi	sp,sp,-48
     4a4:	f422                	sd	s0,40(sp)
     4a6:	1800                	addi	s0,sp,48
     4a8:	fca43c23          	sd	a0,-40(s0)
     4ac:	87ae                	mv	a5,a1
     4ae:	8732                	mv	a4,a2
     4b0:	fcf42a23          	sw	a5,-44(s0)
     4b4:	87ba                	mv	a5,a4
     4b6:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     4ba:	fd843783          	ld	a5,-40(s0)
     4be:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     4c2:	fe042623          	sw	zero,-20(s0)
     4c6:	a00d                	j	4e8 <memset+0x46>
    cdst[i] = c;
     4c8:	fec42783          	lw	a5,-20(s0)
     4cc:	fe043703          	ld	a4,-32(s0)
     4d0:	97ba                	add	a5,a5,a4
     4d2:	fd442703          	lw	a4,-44(s0)
     4d6:	0ff77713          	zext.b	a4,a4
     4da:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     4de:	fec42783          	lw	a5,-20(s0)
     4e2:	2785                	addiw	a5,a5,1
     4e4:	fef42623          	sw	a5,-20(s0)
     4e8:	fec42703          	lw	a4,-20(s0)
     4ec:	fd042783          	lw	a5,-48(s0)
     4f0:	2781                	sext.w	a5,a5
     4f2:	fcf76be3          	bltu	a4,a5,4c8 <memset+0x26>
  }
  return dst;
     4f6:	fd843783          	ld	a5,-40(s0)
}
     4fa:	853e                	mv	a0,a5
     4fc:	7422                	ld	s0,40(sp)
     4fe:	6145                	addi	sp,sp,48
     500:	8082                	ret

0000000000000502 <strchr>:

char*
strchr(const char *s, char c)
{
     502:	1101                	addi	sp,sp,-32
     504:	ec22                	sd	s0,24(sp)
     506:	1000                	addi	s0,sp,32
     508:	fea43423          	sd	a0,-24(s0)
     50c:	87ae                	mv	a5,a1
     50e:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     512:	a01d                	j	538 <strchr+0x36>
    if(*s == c)
     514:	fe843783          	ld	a5,-24(s0)
     518:	0007c703          	lbu	a4,0(a5)
     51c:	fe744783          	lbu	a5,-25(s0)
     520:	0ff7f793          	zext.b	a5,a5
     524:	00e79563          	bne	a5,a4,52e <strchr+0x2c>
      return (char*)s;
     528:	fe843783          	ld	a5,-24(s0)
     52c:	a821                	j	544 <strchr+0x42>
  for(; *s; s++)
     52e:	fe843783          	ld	a5,-24(s0)
     532:	0785                	addi	a5,a5,1
     534:	fef43423          	sd	a5,-24(s0)
     538:	fe843783          	ld	a5,-24(s0)
     53c:	0007c783          	lbu	a5,0(a5)
     540:	fbf1                	bnez	a5,514 <strchr+0x12>
  return 0;
     542:	4781                	li	a5,0
}
     544:	853e                	mv	a0,a5
     546:	6462                	ld	s0,24(sp)
     548:	6105                	addi	sp,sp,32
     54a:	8082                	ret

000000000000054c <gets>:

char*
gets(char *buf, int max)
{
     54c:	7179                	addi	sp,sp,-48
     54e:	f406                	sd	ra,40(sp)
     550:	f022                	sd	s0,32(sp)
     552:	1800                	addi	s0,sp,48
     554:	fca43c23          	sd	a0,-40(s0)
     558:	87ae                	mv	a5,a1
     55a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     55e:	fe042623          	sw	zero,-20(s0)
     562:	a8a1                	j	5ba <gets+0x6e>
    cc = read(0, &c, 1);
     564:	fe740793          	addi	a5,s0,-25
     568:	4605                	li	a2,1
     56a:	85be                	mv	a1,a5
     56c:	4501                	li	a0,0
     56e:	00000097          	auipc	ra,0x0
     572:	2f8080e7          	jalr	760(ra) # 866 <read>
     576:	87aa                	mv	a5,a0
     578:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     57c:	fe842783          	lw	a5,-24(s0)
     580:	2781                	sext.w	a5,a5
     582:	04f05763          	blez	a5,5d0 <gets+0x84>
      break;
    buf[i++] = c;
     586:	fec42783          	lw	a5,-20(s0)
     58a:	0017871b          	addiw	a4,a5,1
     58e:	fee42623          	sw	a4,-20(s0)
     592:	873e                	mv	a4,a5
     594:	fd843783          	ld	a5,-40(s0)
     598:	97ba                	add	a5,a5,a4
     59a:	fe744703          	lbu	a4,-25(s0)
     59e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     5a2:	fe744783          	lbu	a5,-25(s0)
     5a6:	873e                	mv	a4,a5
     5a8:	47a9                	li	a5,10
     5aa:	02f70463          	beq	a4,a5,5d2 <gets+0x86>
     5ae:	fe744783          	lbu	a5,-25(s0)
     5b2:	873e                	mv	a4,a5
     5b4:	47b5                	li	a5,13
     5b6:	00f70e63          	beq	a4,a5,5d2 <gets+0x86>
  for(i=0; i+1 < max; ){
     5ba:	fec42783          	lw	a5,-20(s0)
     5be:	2785                	addiw	a5,a5,1
     5c0:	0007871b          	sext.w	a4,a5
     5c4:	fd442783          	lw	a5,-44(s0)
     5c8:	2781                	sext.w	a5,a5
     5ca:	f8f74de3          	blt	a4,a5,564 <gets+0x18>
     5ce:	a011                	j	5d2 <gets+0x86>
      break;
     5d0:	0001                	nop
      break;
  }
  buf[i] = '\0';
     5d2:	fec42783          	lw	a5,-20(s0)
     5d6:	fd843703          	ld	a4,-40(s0)
     5da:	97ba                	add	a5,a5,a4
     5dc:	00078023          	sb	zero,0(a5)
  return buf;
     5e0:	fd843783          	ld	a5,-40(s0)
}
     5e4:	853e                	mv	a0,a5
     5e6:	70a2                	ld	ra,40(sp)
     5e8:	7402                	ld	s0,32(sp)
     5ea:	6145                	addi	sp,sp,48
     5ec:	8082                	ret

00000000000005ee <stat>:

int
stat(const char *n, struct stat *st)
{
     5ee:	7179                	addi	sp,sp,-48
     5f0:	f406                	sd	ra,40(sp)
     5f2:	f022                	sd	s0,32(sp)
     5f4:	1800                	addi	s0,sp,48
     5f6:	fca43c23          	sd	a0,-40(s0)
     5fa:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     5fe:	4581                	li	a1,0
     600:	fd843503          	ld	a0,-40(s0)
     604:	00000097          	auipc	ra,0x0
     608:	28a080e7          	jalr	650(ra) # 88e <open>
     60c:	87aa                	mv	a5,a0
     60e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     612:	fec42783          	lw	a5,-20(s0)
     616:	2781                	sext.w	a5,a5
     618:	0007d463          	bgez	a5,620 <stat+0x32>
    return -1;
     61c:	57fd                	li	a5,-1
     61e:	a035                	j	64a <stat+0x5c>
  r = fstat(fd, st);
     620:	fec42783          	lw	a5,-20(s0)
     624:	fd043583          	ld	a1,-48(s0)
     628:	853e                	mv	a0,a5
     62a:	00000097          	auipc	ra,0x0
     62e:	27c080e7          	jalr	636(ra) # 8a6 <fstat>
     632:	87aa                	mv	a5,a0
     634:	fef42423          	sw	a5,-24(s0)
  close(fd);
     638:	fec42783          	lw	a5,-20(s0)
     63c:	853e                	mv	a0,a5
     63e:	00000097          	auipc	ra,0x0
     642:	238080e7          	jalr	568(ra) # 876 <close>
  return r;
     646:	fe842783          	lw	a5,-24(s0)
}
     64a:	853e                	mv	a0,a5
     64c:	70a2                	ld	ra,40(sp)
     64e:	7402                	ld	s0,32(sp)
     650:	6145                	addi	sp,sp,48
     652:	8082                	ret

0000000000000654 <atoi>:

int
atoi(const char *s)
{
     654:	7179                	addi	sp,sp,-48
     656:	f422                	sd	s0,40(sp)
     658:	1800                	addi	s0,sp,48
     65a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     65e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     662:	a81d                	j	698 <atoi+0x44>
    n = n*10 + *s++ - '0';
     664:	fec42783          	lw	a5,-20(s0)
     668:	873e                	mv	a4,a5
     66a:	87ba                	mv	a5,a4
     66c:	0027979b          	slliw	a5,a5,0x2
     670:	9fb9                	addw	a5,a5,a4
     672:	0017979b          	slliw	a5,a5,0x1
     676:	0007871b          	sext.w	a4,a5
     67a:	fd843783          	ld	a5,-40(s0)
     67e:	00178693          	addi	a3,a5,1
     682:	fcd43c23          	sd	a3,-40(s0)
     686:	0007c783          	lbu	a5,0(a5)
     68a:	2781                	sext.w	a5,a5
     68c:	9fb9                	addw	a5,a5,a4
     68e:	2781                	sext.w	a5,a5
     690:	fd07879b          	addiw	a5,a5,-48
     694:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     698:	fd843783          	ld	a5,-40(s0)
     69c:	0007c783          	lbu	a5,0(a5)
     6a0:	873e                	mv	a4,a5
     6a2:	02f00793          	li	a5,47
     6a6:	00e7fb63          	bgeu	a5,a4,6bc <atoi+0x68>
     6aa:	fd843783          	ld	a5,-40(s0)
     6ae:	0007c783          	lbu	a5,0(a5)
     6b2:	873e                	mv	a4,a5
     6b4:	03900793          	li	a5,57
     6b8:	fae7f6e3          	bgeu	a5,a4,664 <atoi+0x10>
  return n;
     6bc:	fec42783          	lw	a5,-20(s0)
}
     6c0:	853e                	mv	a0,a5
     6c2:	7422                	ld	s0,40(sp)
     6c4:	6145                	addi	sp,sp,48
     6c6:	8082                	ret

00000000000006c8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     6c8:	7139                	addi	sp,sp,-64
     6ca:	fc22                	sd	s0,56(sp)
     6cc:	0080                	addi	s0,sp,64
     6ce:	fca43c23          	sd	a0,-40(s0)
     6d2:	fcb43823          	sd	a1,-48(s0)
     6d6:	87b2                	mv	a5,a2
     6d8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     6dc:	fd843783          	ld	a5,-40(s0)
     6e0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     6e4:	fd043783          	ld	a5,-48(s0)
     6e8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     6ec:	fe043703          	ld	a4,-32(s0)
     6f0:	fe843783          	ld	a5,-24(s0)
     6f4:	02e7fc63          	bgeu	a5,a4,72c <memmove+0x64>
    while(n-- > 0)
     6f8:	a00d                	j	71a <memmove+0x52>
      *dst++ = *src++;
     6fa:	fe043703          	ld	a4,-32(s0)
     6fe:	00170793          	addi	a5,a4,1
     702:	fef43023          	sd	a5,-32(s0)
     706:	fe843783          	ld	a5,-24(s0)
     70a:	00178693          	addi	a3,a5,1
     70e:	fed43423          	sd	a3,-24(s0)
     712:	00074703          	lbu	a4,0(a4)
     716:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     71a:	fcc42783          	lw	a5,-52(s0)
     71e:	fff7871b          	addiw	a4,a5,-1
     722:	fce42623          	sw	a4,-52(s0)
     726:	fcf04ae3          	bgtz	a5,6fa <memmove+0x32>
     72a:	a891                	j	77e <memmove+0xb6>
  } else {
    dst += n;
     72c:	fcc42783          	lw	a5,-52(s0)
     730:	fe843703          	ld	a4,-24(s0)
     734:	97ba                	add	a5,a5,a4
     736:	fef43423          	sd	a5,-24(s0)
    src += n;
     73a:	fcc42783          	lw	a5,-52(s0)
     73e:	fe043703          	ld	a4,-32(s0)
     742:	97ba                	add	a5,a5,a4
     744:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     748:	a01d                	j	76e <memmove+0xa6>
      *--dst = *--src;
     74a:	fe043783          	ld	a5,-32(s0)
     74e:	17fd                	addi	a5,a5,-1
     750:	fef43023          	sd	a5,-32(s0)
     754:	fe843783          	ld	a5,-24(s0)
     758:	17fd                	addi	a5,a5,-1
     75a:	fef43423          	sd	a5,-24(s0)
     75e:	fe043783          	ld	a5,-32(s0)
     762:	0007c703          	lbu	a4,0(a5)
     766:	fe843783          	ld	a5,-24(s0)
     76a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     76e:	fcc42783          	lw	a5,-52(s0)
     772:	fff7871b          	addiw	a4,a5,-1
     776:	fce42623          	sw	a4,-52(s0)
     77a:	fcf048e3          	bgtz	a5,74a <memmove+0x82>
  }
  return vdst;
     77e:	fd843783          	ld	a5,-40(s0)
}
     782:	853e                	mv	a0,a5
     784:	7462                	ld	s0,56(sp)
     786:	6121                	addi	sp,sp,64
     788:	8082                	ret

000000000000078a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     78a:	7139                	addi	sp,sp,-64
     78c:	fc22                	sd	s0,56(sp)
     78e:	0080                	addi	s0,sp,64
     790:	fca43c23          	sd	a0,-40(s0)
     794:	fcb43823          	sd	a1,-48(s0)
     798:	87b2                	mv	a5,a2
     79a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     79e:	fd843783          	ld	a5,-40(s0)
     7a2:	fef43423          	sd	a5,-24(s0)
     7a6:	fd043783          	ld	a5,-48(s0)
     7aa:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7ae:	a0a1                	j	7f6 <memcmp+0x6c>
    if (*p1 != *p2) {
     7b0:	fe843783          	ld	a5,-24(s0)
     7b4:	0007c703          	lbu	a4,0(a5)
     7b8:	fe043783          	ld	a5,-32(s0)
     7bc:	0007c783          	lbu	a5,0(a5)
     7c0:	02f70163          	beq	a4,a5,7e2 <memcmp+0x58>
      return *p1 - *p2;
     7c4:	fe843783          	ld	a5,-24(s0)
     7c8:	0007c783          	lbu	a5,0(a5)
     7cc:	0007871b          	sext.w	a4,a5
     7d0:	fe043783          	ld	a5,-32(s0)
     7d4:	0007c783          	lbu	a5,0(a5)
     7d8:	2781                	sext.w	a5,a5
     7da:	40f707bb          	subw	a5,a4,a5
     7de:	2781                	sext.w	a5,a5
     7e0:	a01d                	j	806 <memcmp+0x7c>
    }
    p1++;
     7e2:	fe843783          	ld	a5,-24(s0)
     7e6:	0785                	addi	a5,a5,1
     7e8:	fef43423          	sd	a5,-24(s0)
    p2++;
     7ec:	fe043783          	ld	a5,-32(s0)
     7f0:	0785                	addi	a5,a5,1
     7f2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7f6:	fcc42783          	lw	a5,-52(s0)
     7fa:	fff7871b          	addiw	a4,a5,-1
     7fe:	fce42623          	sw	a4,-52(s0)
     802:	f7dd                	bnez	a5,7b0 <memcmp+0x26>
  }
  return 0;
     804:	4781                	li	a5,0
}
     806:	853e                	mv	a0,a5
     808:	7462                	ld	s0,56(sp)
     80a:	6121                	addi	sp,sp,64
     80c:	8082                	ret

000000000000080e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     80e:	7179                	addi	sp,sp,-48
     810:	f406                	sd	ra,40(sp)
     812:	f022                	sd	s0,32(sp)
     814:	1800                	addi	s0,sp,48
     816:	fea43423          	sd	a0,-24(s0)
     81a:	feb43023          	sd	a1,-32(s0)
     81e:	87b2                	mv	a5,a2
     820:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     824:	fdc42783          	lw	a5,-36(s0)
     828:	863e                	mv	a2,a5
     82a:	fe043583          	ld	a1,-32(s0)
     82e:	fe843503          	ld	a0,-24(s0)
     832:	00000097          	auipc	ra,0x0
     836:	e96080e7          	jalr	-362(ra) # 6c8 <memmove>
     83a:	87aa                	mv	a5,a0
}
     83c:	853e                	mv	a0,a5
     83e:	70a2                	ld	ra,40(sp)
     840:	7402                	ld	s0,32(sp)
     842:	6145                	addi	sp,sp,48
     844:	8082                	ret

0000000000000846 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     846:	4885                	li	a7,1
 ecall
     848:	00000073          	ecall
 ret
     84c:	8082                	ret

000000000000084e <exit>:
.global exit
exit:
 li a7, SYS_exit
     84e:	4889                	li	a7,2
 ecall
     850:	00000073          	ecall
 ret
     854:	8082                	ret

0000000000000856 <wait>:
.global wait
wait:
 li a7, SYS_wait
     856:	488d                	li	a7,3
 ecall
     858:	00000073          	ecall
 ret
     85c:	8082                	ret

000000000000085e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     85e:	4891                	li	a7,4
 ecall
     860:	00000073          	ecall
 ret
     864:	8082                	ret

0000000000000866 <read>:
.global read
read:
 li a7, SYS_read
     866:	4895                	li	a7,5
 ecall
     868:	00000073          	ecall
 ret
     86c:	8082                	ret

000000000000086e <write>:
.global write
write:
 li a7, SYS_write
     86e:	48c1                	li	a7,16
 ecall
     870:	00000073          	ecall
 ret
     874:	8082                	ret

0000000000000876 <close>:
.global close
close:
 li a7, SYS_close
     876:	48d5                	li	a7,21
 ecall
     878:	00000073          	ecall
 ret
     87c:	8082                	ret

000000000000087e <kill>:
.global kill
kill:
 li a7, SYS_kill
     87e:	4899                	li	a7,6
 ecall
     880:	00000073          	ecall
 ret
     884:	8082                	ret

0000000000000886 <exec>:
.global exec
exec:
 li a7, SYS_exec
     886:	489d                	li	a7,7
 ecall
     888:	00000073          	ecall
 ret
     88c:	8082                	ret

000000000000088e <open>:
.global open
open:
 li a7, SYS_open
     88e:	48bd                	li	a7,15
 ecall
     890:	00000073          	ecall
 ret
     894:	8082                	ret

0000000000000896 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     896:	48c5                	li	a7,17
 ecall
     898:	00000073          	ecall
 ret
     89c:	8082                	ret

000000000000089e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     89e:	48c9                	li	a7,18
 ecall
     8a0:	00000073          	ecall
 ret
     8a4:	8082                	ret

00000000000008a6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     8a6:	48a1                	li	a7,8
 ecall
     8a8:	00000073          	ecall
 ret
     8ac:	8082                	ret

00000000000008ae <link>:
.global link
link:
 li a7, SYS_link
     8ae:	48cd                	li	a7,19
 ecall
     8b0:	00000073          	ecall
 ret
     8b4:	8082                	ret

00000000000008b6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     8b6:	48d1                	li	a7,20
 ecall
     8b8:	00000073          	ecall
 ret
     8bc:	8082                	ret

00000000000008be <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     8be:	48a5                	li	a7,9
 ecall
     8c0:	00000073          	ecall
 ret
     8c4:	8082                	ret

00000000000008c6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     8c6:	48a9                	li	a7,10
 ecall
     8c8:	00000073          	ecall
 ret
     8cc:	8082                	ret

00000000000008ce <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     8ce:	48ad                	li	a7,11
 ecall
     8d0:	00000073          	ecall
 ret
     8d4:	8082                	ret

00000000000008d6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     8d6:	48b1                	li	a7,12
 ecall
     8d8:	00000073          	ecall
 ret
     8dc:	8082                	ret

00000000000008de <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     8de:	48b5                	li	a7,13
 ecall
     8e0:	00000073          	ecall
 ret
     8e4:	8082                	ret

00000000000008e6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     8e6:	48b9                	li	a7,14
 ecall
     8e8:	00000073          	ecall
 ret
     8ec:	8082                	ret

00000000000008ee <init_raid>:
.global init_raid
init_raid:
 li a7, SYS_init_raid
     8ee:	48d9                	li	a7,22
 ecall
     8f0:	00000073          	ecall
 ret
     8f4:	8082                	ret

00000000000008f6 <read_raid>:
.global read_raid
read_raid:
 li a7, SYS_read_raid
     8f6:	48dd                	li	a7,23
 ecall
     8f8:	00000073          	ecall
 ret
     8fc:	8082                	ret

00000000000008fe <write_raid>:
.global write_raid
write_raid:
 li a7, SYS_write_raid
     8fe:	48e1                	li	a7,24
 ecall
     900:	00000073          	ecall
 ret
     904:	8082                	ret

0000000000000906 <disk_fail_raid>:
.global disk_fail_raid
disk_fail_raid:
 li a7, SYS_disk_fail_raid
     906:	48e5                	li	a7,25
 ecall
     908:	00000073          	ecall
 ret
     90c:	8082                	ret

000000000000090e <disk_repaired_raid>:
.global disk_repaired_raid
disk_repaired_raid:
 li a7, SYS_disk_repaired_raid
     90e:	48e9                	li	a7,26
 ecall
     910:	00000073          	ecall
 ret
     914:	8082                	ret

0000000000000916 <info_raid>:
.global info_raid
info_raid:
 li a7, SYS_info_raid
     916:	48ed                	li	a7,27
 ecall
     918:	00000073          	ecall
 ret
     91c:	8082                	ret

000000000000091e <destroy_raid>:
.global destroy_raid
destroy_raid:
 li a7, SYS_destroy_raid
     91e:	48f1                	li	a7,28
 ecall
     920:	00000073          	ecall
 ret
     924:	8082                	ret

0000000000000926 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     926:	1101                	addi	sp,sp,-32
     928:	ec06                	sd	ra,24(sp)
     92a:	e822                	sd	s0,16(sp)
     92c:	1000                	addi	s0,sp,32
     92e:	87aa                	mv	a5,a0
     930:	872e                	mv	a4,a1
     932:	fef42623          	sw	a5,-20(s0)
     936:	87ba                	mv	a5,a4
     938:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     93c:	feb40713          	addi	a4,s0,-21
     940:	fec42783          	lw	a5,-20(s0)
     944:	4605                	li	a2,1
     946:	85ba                	mv	a1,a4
     948:	853e                	mv	a0,a5
     94a:	00000097          	auipc	ra,0x0
     94e:	f24080e7          	jalr	-220(ra) # 86e <write>
}
     952:	0001                	nop
     954:	60e2                	ld	ra,24(sp)
     956:	6442                	ld	s0,16(sp)
     958:	6105                	addi	sp,sp,32
     95a:	8082                	ret

000000000000095c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     95c:	7139                	addi	sp,sp,-64
     95e:	fc06                	sd	ra,56(sp)
     960:	f822                	sd	s0,48(sp)
     962:	0080                	addi	s0,sp,64
     964:	87aa                	mv	a5,a0
     966:	8736                	mv	a4,a3
     968:	fcf42623          	sw	a5,-52(s0)
     96c:	87ae                	mv	a5,a1
     96e:	fcf42423          	sw	a5,-56(s0)
     972:	87b2                	mv	a5,a2
     974:	fcf42223          	sw	a5,-60(s0)
     978:	87ba                	mv	a5,a4
     97a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     97e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     982:	fc042783          	lw	a5,-64(s0)
     986:	2781                	sext.w	a5,a5
     988:	c38d                	beqz	a5,9aa <printint+0x4e>
     98a:	fc842783          	lw	a5,-56(s0)
     98e:	2781                	sext.w	a5,a5
     990:	0007dd63          	bgez	a5,9aa <printint+0x4e>
    neg = 1;
     994:	4785                	li	a5,1
     996:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     99a:	fc842783          	lw	a5,-56(s0)
     99e:	40f007bb          	negw	a5,a5
     9a2:	2781                	sext.w	a5,a5
     9a4:	fef42223          	sw	a5,-28(s0)
     9a8:	a029                	j	9b2 <printint+0x56>
  } else {
    x = xx;
     9aa:	fc842783          	lw	a5,-56(s0)
     9ae:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     9b2:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     9b6:	fc442783          	lw	a5,-60(s0)
     9ba:	fe442703          	lw	a4,-28(s0)
     9be:	02f777bb          	remuw	a5,a4,a5
     9c2:	0007861b          	sext.w	a2,a5
     9c6:	fec42783          	lw	a5,-20(s0)
     9ca:	0017871b          	addiw	a4,a5,1
     9ce:	fee42623          	sw	a4,-20(s0)
     9d2:	00002697          	auipc	a3,0x2
     9d6:	9ee68693          	addi	a3,a3,-1554 # 23c0 <digits>
     9da:	02061713          	slli	a4,a2,0x20
     9de:	9301                	srli	a4,a4,0x20
     9e0:	9736                	add	a4,a4,a3
     9e2:	00074703          	lbu	a4,0(a4)
     9e6:	17c1                	addi	a5,a5,-16
     9e8:	97a2                	add	a5,a5,s0
     9ea:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     9ee:	fc442783          	lw	a5,-60(s0)
     9f2:	fe442703          	lw	a4,-28(s0)
     9f6:	02f757bb          	divuw	a5,a4,a5
     9fa:	fef42223          	sw	a5,-28(s0)
     9fe:	fe442783          	lw	a5,-28(s0)
     a02:	2781                	sext.w	a5,a5
     a04:	fbcd                	bnez	a5,9b6 <printint+0x5a>
  if(neg)
     a06:	fe842783          	lw	a5,-24(s0)
     a0a:	2781                	sext.w	a5,a5
     a0c:	cf85                	beqz	a5,a44 <printint+0xe8>
    buf[i++] = '-';
     a0e:	fec42783          	lw	a5,-20(s0)
     a12:	0017871b          	addiw	a4,a5,1
     a16:	fee42623          	sw	a4,-20(s0)
     a1a:	17c1                	addi	a5,a5,-16
     a1c:	97a2                	add	a5,a5,s0
     a1e:	02d00713          	li	a4,45
     a22:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     a26:	a839                	j	a44 <printint+0xe8>
    putc(fd, buf[i]);
     a28:	fec42783          	lw	a5,-20(s0)
     a2c:	17c1                	addi	a5,a5,-16
     a2e:	97a2                	add	a5,a5,s0
     a30:	fe07c703          	lbu	a4,-32(a5)
     a34:	fcc42783          	lw	a5,-52(s0)
     a38:	85ba                	mv	a1,a4
     a3a:	853e                	mv	a0,a5
     a3c:	00000097          	auipc	ra,0x0
     a40:	eea080e7          	jalr	-278(ra) # 926 <putc>
  while(--i >= 0)
     a44:	fec42783          	lw	a5,-20(s0)
     a48:	37fd                	addiw	a5,a5,-1
     a4a:	fef42623          	sw	a5,-20(s0)
     a4e:	fec42783          	lw	a5,-20(s0)
     a52:	2781                	sext.w	a5,a5
     a54:	fc07dae3          	bgez	a5,a28 <printint+0xcc>
}
     a58:	0001                	nop
     a5a:	0001                	nop
     a5c:	70e2                	ld	ra,56(sp)
     a5e:	7442                	ld	s0,48(sp)
     a60:	6121                	addi	sp,sp,64
     a62:	8082                	ret

0000000000000a64 <printptr>:

static void
printptr(int fd, uint64 x) {
     a64:	7179                	addi	sp,sp,-48
     a66:	f406                	sd	ra,40(sp)
     a68:	f022                	sd	s0,32(sp)
     a6a:	1800                	addi	s0,sp,48
     a6c:	87aa                	mv	a5,a0
     a6e:	fcb43823          	sd	a1,-48(s0)
     a72:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a76:	fdc42783          	lw	a5,-36(s0)
     a7a:	03000593          	li	a1,48
     a7e:	853e                	mv	a0,a5
     a80:	00000097          	auipc	ra,0x0
     a84:	ea6080e7          	jalr	-346(ra) # 926 <putc>
  putc(fd, 'x');
     a88:	fdc42783          	lw	a5,-36(s0)
     a8c:	07800593          	li	a1,120
     a90:	853e                	mv	a0,a5
     a92:	00000097          	auipc	ra,0x0
     a96:	e94080e7          	jalr	-364(ra) # 926 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a9a:	fe042623          	sw	zero,-20(s0)
     a9e:	a82d                	j	ad8 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     aa0:	fd043783          	ld	a5,-48(s0)
     aa4:	93f1                	srli	a5,a5,0x3c
     aa6:	00002717          	auipc	a4,0x2
     aaa:	91a70713          	addi	a4,a4,-1766 # 23c0 <digits>
     aae:	97ba                	add	a5,a5,a4
     ab0:	0007c703          	lbu	a4,0(a5)
     ab4:	fdc42783          	lw	a5,-36(s0)
     ab8:	85ba                	mv	a1,a4
     aba:	853e                	mv	a0,a5
     abc:	00000097          	auipc	ra,0x0
     ac0:	e6a080e7          	jalr	-406(ra) # 926 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     ac4:	fec42783          	lw	a5,-20(s0)
     ac8:	2785                	addiw	a5,a5,1
     aca:	fef42623          	sw	a5,-20(s0)
     ace:	fd043783          	ld	a5,-48(s0)
     ad2:	0792                	slli	a5,a5,0x4
     ad4:	fcf43823          	sd	a5,-48(s0)
     ad8:	fec42783          	lw	a5,-20(s0)
     adc:	873e                	mv	a4,a5
     ade:	47bd                	li	a5,15
     ae0:	fce7f0e3          	bgeu	a5,a4,aa0 <printptr+0x3c>
}
     ae4:	0001                	nop
     ae6:	0001                	nop
     ae8:	70a2                	ld	ra,40(sp)
     aea:	7402                	ld	s0,32(sp)
     aec:	6145                	addi	sp,sp,48
     aee:	8082                	ret

0000000000000af0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     af0:	715d                	addi	sp,sp,-80
     af2:	e486                	sd	ra,72(sp)
     af4:	e0a2                	sd	s0,64(sp)
     af6:	0880                	addi	s0,sp,80
     af8:	87aa                	mv	a5,a0
     afa:	fcb43023          	sd	a1,-64(s0)
     afe:	fac43c23          	sd	a2,-72(s0)
     b02:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     b06:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b0a:	fe042223          	sw	zero,-28(s0)
     b0e:	a42d                	j	d38 <vprintf+0x248>
    c = fmt[i] & 0xff;
     b10:	fe442783          	lw	a5,-28(s0)
     b14:	fc043703          	ld	a4,-64(s0)
     b18:	97ba                	add	a5,a5,a4
     b1a:	0007c783          	lbu	a5,0(a5)
     b1e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     b22:	fe042783          	lw	a5,-32(s0)
     b26:	2781                	sext.w	a5,a5
     b28:	eb9d                	bnez	a5,b5e <vprintf+0x6e>
      if(c == '%'){
     b2a:	fdc42783          	lw	a5,-36(s0)
     b2e:	0007871b          	sext.w	a4,a5
     b32:	02500793          	li	a5,37
     b36:	00f71763          	bne	a4,a5,b44 <vprintf+0x54>
        state = '%';
     b3a:	02500793          	li	a5,37
     b3e:	fef42023          	sw	a5,-32(s0)
     b42:	a2f5                	j	d2e <vprintf+0x23e>
      } else {
        putc(fd, c);
     b44:	fdc42783          	lw	a5,-36(s0)
     b48:	0ff7f713          	zext.b	a4,a5
     b4c:	fcc42783          	lw	a5,-52(s0)
     b50:	85ba                	mv	a1,a4
     b52:	853e                	mv	a0,a5
     b54:	00000097          	auipc	ra,0x0
     b58:	dd2080e7          	jalr	-558(ra) # 926 <putc>
     b5c:	aac9                	j	d2e <vprintf+0x23e>
      }
    } else if(state == '%'){
     b5e:	fe042783          	lw	a5,-32(s0)
     b62:	0007871b          	sext.w	a4,a5
     b66:	02500793          	li	a5,37
     b6a:	1cf71263          	bne	a4,a5,d2e <vprintf+0x23e>
      if(c == 'd'){
     b6e:	fdc42783          	lw	a5,-36(s0)
     b72:	0007871b          	sext.w	a4,a5
     b76:	06400793          	li	a5,100
     b7a:	02f71463          	bne	a4,a5,ba2 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     b7e:	fb843783          	ld	a5,-72(s0)
     b82:	00878713          	addi	a4,a5,8
     b86:	fae43c23          	sd	a4,-72(s0)
     b8a:	4398                	lw	a4,0(a5)
     b8c:	fcc42783          	lw	a5,-52(s0)
     b90:	4685                	li	a3,1
     b92:	4629                	li	a2,10
     b94:	85ba                	mv	a1,a4
     b96:	853e                	mv	a0,a5
     b98:	00000097          	auipc	ra,0x0
     b9c:	dc4080e7          	jalr	-572(ra) # 95c <printint>
     ba0:	a269                	j	d2a <vprintf+0x23a>
      } else if(c == 'l') {
     ba2:	fdc42783          	lw	a5,-36(s0)
     ba6:	0007871b          	sext.w	a4,a5
     baa:	06c00793          	li	a5,108
     bae:	02f71663          	bne	a4,a5,bda <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     bb2:	fb843783          	ld	a5,-72(s0)
     bb6:	00878713          	addi	a4,a5,8
     bba:	fae43c23          	sd	a4,-72(s0)
     bbe:	639c                	ld	a5,0(a5)
     bc0:	0007871b          	sext.w	a4,a5
     bc4:	fcc42783          	lw	a5,-52(s0)
     bc8:	4681                	li	a3,0
     bca:	4629                	li	a2,10
     bcc:	85ba                	mv	a1,a4
     bce:	853e                	mv	a0,a5
     bd0:	00000097          	auipc	ra,0x0
     bd4:	d8c080e7          	jalr	-628(ra) # 95c <printint>
     bd8:	aa89                	j	d2a <vprintf+0x23a>
      } else if(c == 'x') {
     bda:	fdc42783          	lw	a5,-36(s0)
     bde:	0007871b          	sext.w	a4,a5
     be2:	07800793          	li	a5,120
     be6:	02f71463          	bne	a4,a5,c0e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     bea:	fb843783          	ld	a5,-72(s0)
     bee:	00878713          	addi	a4,a5,8
     bf2:	fae43c23          	sd	a4,-72(s0)
     bf6:	4398                	lw	a4,0(a5)
     bf8:	fcc42783          	lw	a5,-52(s0)
     bfc:	4681                	li	a3,0
     bfe:	4641                	li	a2,16
     c00:	85ba                	mv	a1,a4
     c02:	853e                	mv	a0,a5
     c04:	00000097          	auipc	ra,0x0
     c08:	d58080e7          	jalr	-680(ra) # 95c <printint>
     c0c:	aa39                	j	d2a <vprintf+0x23a>
      } else if(c == 'p') {
     c0e:	fdc42783          	lw	a5,-36(s0)
     c12:	0007871b          	sext.w	a4,a5
     c16:	07000793          	li	a5,112
     c1a:	02f71263          	bne	a4,a5,c3e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     c1e:	fb843783          	ld	a5,-72(s0)
     c22:	00878713          	addi	a4,a5,8
     c26:	fae43c23          	sd	a4,-72(s0)
     c2a:	6398                	ld	a4,0(a5)
     c2c:	fcc42783          	lw	a5,-52(s0)
     c30:	85ba                	mv	a1,a4
     c32:	853e                	mv	a0,a5
     c34:	00000097          	auipc	ra,0x0
     c38:	e30080e7          	jalr	-464(ra) # a64 <printptr>
     c3c:	a0fd                	j	d2a <vprintf+0x23a>
      } else if(c == 's'){
     c3e:	fdc42783          	lw	a5,-36(s0)
     c42:	0007871b          	sext.w	a4,a5
     c46:	07300793          	li	a5,115
     c4a:	04f71c63          	bne	a4,a5,ca2 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     c4e:	fb843783          	ld	a5,-72(s0)
     c52:	00878713          	addi	a4,a5,8
     c56:	fae43c23          	sd	a4,-72(s0)
     c5a:	639c                	ld	a5,0(a5)
     c5c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     c60:	fe843783          	ld	a5,-24(s0)
     c64:	eb8d                	bnez	a5,c96 <vprintf+0x1a6>
          s = "(null)";
     c66:	00000797          	auipc	a5,0x0
     c6a:	4ea78793          	addi	a5,a5,1258 # 1150 <malloc+0x1b0>
     c6e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c72:	a015                	j	c96 <vprintf+0x1a6>
          putc(fd, *s);
     c74:	fe843783          	ld	a5,-24(s0)
     c78:	0007c703          	lbu	a4,0(a5)
     c7c:	fcc42783          	lw	a5,-52(s0)
     c80:	85ba                	mv	a1,a4
     c82:	853e                	mv	a0,a5
     c84:	00000097          	auipc	ra,0x0
     c88:	ca2080e7          	jalr	-862(ra) # 926 <putc>
          s++;
     c8c:	fe843783          	ld	a5,-24(s0)
     c90:	0785                	addi	a5,a5,1
     c92:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c96:	fe843783          	ld	a5,-24(s0)
     c9a:	0007c783          	lbu	a5,0(a5)
     c9e:	fbf9                	bnez	a5,c74 <vprintf+0x184>
     ca0:	a069                	j	d2a <vprintf+0x23a>
        }
      } else if(c == 'c'){
     ca2:	fdc42783          	lw	a5,-36(s0)
     ca6:	0007871b          	sext.w	a4,a5
     caa:	06300793          	li	a5,99
     cae:	02f71463          	bne	a4,a5,cd6 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     cb2:	fb843783          	ld	a5,-72(s0)
     cb6:	00878713          	addi	a4,a5,8
     cba:	fae43c23          	sd	a4,-72(s0)
     cbe:	439c                	lw	a5,0(a5)
     cc0:	0ff7f713          	zext.b	a4,a5
     cc4:	fcc42783          	lw	a5,-52(s0)
     cc8:	85ba                	mv	a1,a4
     cca:	853e                	mv	a0,a5
     ccc:	00000097          	auipc	ra,0x0
     cd0:	c5a080e7          	jalr	-934(ra) # 926 <putc>
     cd4:	a899                	j	d2a <vprintf+0x23a>
      } else if(c == '%'){
     cd6:	fdc42783          	lw	a5,-36(s0)
     cda:	0007871b          	sext.w	a4,a5
     cde:	02500793          	li	a5,37
     ce2:	00f71f63          	bne	a4,a5,d00 <vprintf+0x210>
        putc(fd, c);
     ce6:	fdc42783          	lw	a5,-36(s0)
     cea:	0ff7f713          	zext.b	a4,a5
     cee:	fcc42783          	lw	a5,-52(s0)
     cf2:	85ba                	mv	a1,a4
     cf4:	853e                	mv	a0,a5
     cf6:	00000097          	auipc	ra,0x0
     cfa:	c30080e7          	jalr	-976(ra) # 926 <putc>
     cfe:	a035                	j	d2a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d00:	fcc42783          	lw	a5,-52(s0)
     d04:	02500593          	li	a1,37
     d08:	853e                	mv	a0,a5
     d0a:	00000097          	auipc	ra,0x0
     d0e:	c1c080e7          	jalr	-996(ra) # 926 <putc>
        putc(fd, c);
     d12:	fdc42783          	lw	a5,-36(s0)
     d16:	0ff7f713          	zext.b	a4,a5
     d1a:	fcc42783          	lw	a5,-52(s0)
     d1e:	85ba                	mv	a1,a4
     d20:	853e                	mv	a0,a5
     d22:	00000097          	auipc	ra,0x0
     d26:	c04080e7          	jalr	-1020(ra) # 926 <putc>
      }
      state = 0;
     d2a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     d2e:	fe442783          	lw	a5,-28(s0)
     d32:	2785                	addiw	a5,a5,1
     d34:	fef42223          	sw	a5,-28(s0)
     d38:	fe442783          	lw	a5,-28(s0)
     d3c:	fc043703          	ld	a4,-64(s0)
     d40:	97ba                	add	a5,a5,a4
     d42:	0007c783          	lbu	a5,0(a5)
     d46:	dc0795e3          	bnez	a5,b10 <vprintf+0x20>
    }
  }
}
     d4a:	0001                	nop
     d4c:	0001                	nop
     d4e:	60a6                	ld	ra,72(sp)
     d50:	6406                	ld	s0,64(sp)
     d52:	6161                	addi	sp,sp,80
     d54:	8082                	ret

0000000000000d56 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d56:	7159                	addi	sp,sp,-112
     d58:	fc06                	sd	ra,56(sp)
     d5a:	f822                	sd	s0,48(sp)
     d5c:	0080                	addi	s0,sp,64
     d5e:	fcb43823          	sd	a1,-48(s0)
     d62:	e010                	sd	a2,0(s0)
     d64:	e414                	sd	a3,8(s0)
     d66:	e818                	sd	a4,16(s0)
     d68:	ec1c                	sd	a5,24(s0)
     d6a:	03043023          	sd	a6,32(s0)
     d6e:	03143423          	sd	a7,40(s0)
     d72:	87aa                	mv	a5,a0
     d74:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d78:	03040793          	addi	a5,s0,48
     d7c:	fcf43423          	sd	a5,-56(s0)
     d80:	fc843783          	ld	a5,-56(s0)
     d84:	fd078793          	addi	a5,a5,-48
     d88:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d8c:	fe843703          	ld	a4,-24(s0)
     d90:	fdc42783          	lw	a5,-36(s0)
     d94:	863a                	mv	a2,a4
     d96:	fd043583          	ld	a1,-48(s0)
     d9a:	853e                	mv	a0,a5
     d9c:	00000097          	auipc	ra,0x0
     da0:	d54080e7          	jalr	-684(ra) # af0 <vprintf>
}
     da4:	0001                	nop
     da6:	70e2                	ld	ra,56(sp)
     da8:	7442                	ld	s0,48(sp)
     daa:	6165                	addi	sp,sp,112
     dac:	8082                	ret

0000000000000dae <printf>:

void
printf(const char *fmt, ...)
{
     dae:	7159                	addi	sp,sp,-112
     db0:	f406                	sd	ra,40(sp)
     db2:	f022                	sd	s0,32(sp)
     db4:	1800                	addi	s0,sp,48
     db6:	fca43c23          	sd	a0,-40(s0)
     dba:	e40c                	sd	a1,8(s0)
     dbc:	e810                	sd	a2,16(s0)
     dbe:	ec14                	sd	a3,24(s0)
     dc0:	f018                	sd	a4,32(s0)
     dc2:	f41c                	sd	a5,40(s0)
     dc4:	03043823          	sd	a6,48(s0)
     dc8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     dcc:	04040793          	addi	a5,s0,64
     dd0:	fcf43823          	sd	a5,-48(s0)
     dd4:	fd043783          	ld	a5,-48(s0)
     dd8:	fc878793          	addi	a5,a5,-56
     ddc:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     de0:	fe843783          	ld	a5,-24(s0)
     de4:	863e                	mv	a2,a5
     de6:	fd843583          	ld	a1,-40(s0)
     dea:	4505                	li	a0,1
     dec:	00000097          	auipc	ra,0x0
     df0:	d04080e7          	jalr	-764(ra) # af0 <vprintf>
}
     df4:	0001                	nop
     df6:	70a2                	ld	ra,40(sp)
     df8:	7402                	ld	s0,32(sp)
     dfa:	6165                	addi	sp,sp,112
     dfc:	8082                	ret

0000000000000dfe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     dfe:	7179                	addi	sp,sp,-48
     e00:	f422                	sd	s0,40(sp)
     e02:	1800                	addi	s0,sp,48
     e04:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e08:	fd843783          	ld	a5,-40(s0)
     e0c:	17c1                	addi	a5,a5,-16
     e0e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e12:	00001797          	auipc	a5,0x1
     e16:	5ee78793          	addi	a5,a5,1518 # 2400 <freep>
     e1a:	639c                	ld	a5,0(a5)
     e1c:	fef43423          	sd	a5,-24(s0)
     e20:	a815                	j	e54 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e22:	fe843783          	ld	a5,-24(s0)
     e26:	639c                	ld	a5,0(a5)
     e28:	fe843703          	ld	a4,-24(s0)
     e2c:	00f76f63          	bltu	a4,a5,e4a <free+0x4c>
     e30:	fe043703          	ld	a4,-32(s0)
     e34:	fe843783          	ld	a5,-24(s0)
     e38:	02e7eb63          	bltu	a5,a4,e6e <free+0x70>
     e3c:	fe843783          	ld	a5,-24(s0)
     e40:	639c                	ld	a5,0(a5)
     e42:	fe043703          	ld	a4,-32(s0)
     e46:	02f76463          	bltu	a4,a5,e6e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e4a:	fe843783          	ld	a5,-24(s0)
     e4e:	639c                	ld	a5,0(a5)
     e50:	fef43423          	sd	a5,-24(s0)
     e54:	fe043703          	ld	a4,-32(s0)
     e58:	fe843783          	ld	a5,-24(s0)
     e5c:	fce7f3e3          	bgeu	a5,a4,e22 <free+0x24>
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	639c                	ld	a5,0(a5)
     e66:	fe043703          	ld	a4,-32(s0)
     e6a:	faf77ce3          	bgeu	a4,a5,e22 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e6e:	fe043783          	ld	a5,-32(s0)
     e72:	479c                	lw	a5,8(a5)
     e74:	1782                	slli	a5,a5,0x20
     e76:	9381                	srli	a5,a5,0x20
     e78:	0792                	slli	a5,a5,0x4
     e7a:	fe043703          	ld	a4,-32(s0)
     e7e:	973e                	add	a4,a4,a5
     e80:	fe843783          	ld	a5,-24(s0)
     e84:	639c                	ld	a5,0(a5)
     e86:	02f71763          	bne	a4,a5,eb4 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     e8a:	fe043783          	ld	a5,-32(s0)
     e8e:	4798                	lw	a4,8(a5)
     e90:	fe843783          	ld	a5,-24(s0)
     e94:	639c                	ld	a5,0(a5)
     e96:	479c                	lw	a5,8(a5)
     e98:	9fb9                	addw	a5,a5,a4
     e9a:	0007871b          	sext.w	a4,a5
     e9e:	fe043783          	ld	a5,-32(s0)
     ea2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     ea4:	fe843783          	ld	a5,-24(s0)
     ea8:	639c                	ld	a5,0(a5)
     eaa:	6398                	ld	a4,0(a5)
     eac:	fe043783          	ld	a5,-32(s0)
     eb0:	e398                	sd	a4,0(a5)
     eb2:	a039                	j	ec0 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     eb4:	fe843783          	ld	a5,-24(s0)
     eb8:	6398                	ld	a4,0(a5)
     eba:	fe043783          	ld	a5,-32(s0)
     ebe:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ec0:	fe843783          	ld	a5,-24(s0)
     ec4:	479c                	lw	a5,8(a5)
     ec6:	1782                	slli	a5,a5,0x20
     ec8:	9381                	srli	a5,a5,0x20
     eca:	0792                	slli	a5,a5,0x4
     ecc:	fe843703          	ld	a4,-24(s0)
     ed0:	97ba                	add	a5,a5,a4
     ed2:	fe043703          	ld	a4,-32(s0)
     ed6:	02f71563          	bne	a4,a5,f00 <free+0x102>
    p->s.size += bp->s.size;
     eda:	fe843783          	ld	a5,-24(s0)
     ede:	4798                	lw	a4,8(a5)
     ee0:	fe043783          	ld	a5,-32(s0)
     ee4:	479c                	lw	a5,8(a5)
     ee6:	9fb9                	addw	a5,a5,a4
     ee8:	0007871b          	sext.w	a4,a5
     eec:	fe843783          	ld	a5,-24(s0)
     ef0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ef2:	fe043783          	ld	a5,-32(s0)
     ef6:	6398                	ld	a4,0(a5)
     ef8:	fe843783          	ld	a5,-24(s0)
     efc:	e398                	sd	a4,0(a5)
     efe:	a031                	j	f0a <free+0x10c>
  } else
    p->s.ptr = bp;
     f00:	fe843783          	ld	a5,-24(s0)
     f04:	fe043703          	ld	a4,-32(s0)
     f08:	e398                	sd	a4,0(a5)
  freep = p;
     f0a:	00001797          	auipc	a5,0x1
     f0e:	4f678793          	addi	a5,a5,1270 # 2400 <freep>
     f12:	fe843703          	ld	a4,-24(s0)
     f16:	e398                	sd	a4,0(a5)
}
     f18:	0001                	nop
     f1a:	7422                	ld	s0,40(sp)
     f1c:	6145                	addi	sp,sp,48
     f1e:	8082                	ret

0000000000000f20 <morecore>:

static Header*
morecore(uint nu)
{
     f20:	7179                	addi	sp,sp,-48
     f22:	f406                	sd	ra,40(sp)
     f24:	f022                	sd	s0,32(sp)
     f26:	1800                	addi	s0,sp,48
     f28:	87aa                	mv	a5,a0
     f2a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f2e:	fdc42783          	lw	a5,-36(s0)
     f32:	0007871b          	sext.w	a4,a5
     f36:	6785                	lui	a5,0x1
     f38:	00f77563          	bgeu	a4,a5,f42 <morecore+0x22>
    nu = 4096;
     f3c:	6785                	lui	a5,0x1
     f3e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f42:	fdc42783          	lw	a5,-36(s0)
     f46:	0047979b          	slliw	a5,a5,0x4
     f4a:	2781                	sext.w	a5,a5
     f4c:	2781                	sext.w	a5,a5
     f4e:	853e                	mv	a0,a5
     f50:	00000097          	auipc	ra,0x0
     f54:	986080e7          	jalr	-1658(ra) # 8d6 <sbrk>
     f58:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f5c:	fe843703          	ld	a4,-24(s0)
     f60:	57fd                	li	a5,-1
     f62:	00f71463          	bne	a4,a5,f6a <morecore+0x4a>
    return 0;
     f66:	4781                	li	a5,0
     f68:	a03d                	j	f96 <morecore+0x76>
  hp = (Header*)p;
     f6a:	fe843783          	ld	a5,-24(s0)
     f6e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f72:	fe043783          	ld	a5,-32(s0)
     f76:	fdc42703          	lw	a4,-36(s0)
     f7a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f7c:	fe043783          	ld	a5,-32(s0)
     f80:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x70>
     f82:	853e                	mv	a0,a5
     f84:	00000097          	auipc	ra,0x0
     f88:	e7a080e7          	jalr	-390(ra) # dfe <free>
  return freep;
     f8c:	00001797          	auipc	a5,0x1
     f90:	47478793          	addi	a5,a5,1140 # 2400 <freep>
     f94:	639c                	ld	a5,0(a5)
}
     f96:	853e                	mv	a0,a5
     f98:	70a2                	ld	ra,40(sp)
     f9a:	7402                	ld	s0,32(sp)
     f9c:	6145                	addi	sp,sp,48
     f9e:	8082                	ret

0000000000000fa0 <malloc>:

void*
malloc(uint nbytes)
{
     fa0:	7139                	addi	sp,sp,-64
     fa2:	fc06                	sd	ra,56(sp)
     fa4:	f822                	sd	s0,48(sp)
     fa6:	0080                	addi	s0,sp,64
     fa8:	87aa                	mv	a5,a0
     faa:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fae:	fcc46783          	lwu	a5,-52(s0)
     fb2:	07bd                	addi	a5,a5,15
     fb4:	8391                	srli	a5,a5,0x4
     fb6:	2781                	sext.w	a5,a5
     fb8:	2785                	addiw	a5,a5,1
     fba:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     fbe:	00001797          	auipc	a5,0x1
     fc2:	44278793          	addi	a5,a5,1090 # 2400 <freep>
     fc6:	639c                	ld	a5,0(a5)
     fc8:	fef43023          	sd	a5,-32(s0)
     fcc:	fe043783          	ld	a5,-32(s0)
     fd0:	ef95                	bnez	a5,100c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     fd2:	00001797          	auipc	a5,0x1
     fd6:	41e78793          	addi	a5,a5,1054 # 23f0 <base>
     fda:	fef43023          	sd	a5,-32(s0)
     fde:	00001797          	auipc	a5,0x1
     fe2:	42278793          	addi	a5,a5,1058 # 2400 <freep>
     fe6:	fe043703          	ld	a4,-32(s0)
     fea:	e398                	sd	a4,0(a5)
     fec:	00001797          	auipc	a5,0x1
     ff0:	41478793          	addi	a5,a5,1044 # 2400 <freep>
     ff4:	6398                	ld	a4,0(a5)
     ff6:	00001797          	auipc	a5,0x1
     ffa:	3fa78793          	addi	a5,a5,1018 # 23f0 <base>
     ffe:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1000:	00001797          	auipc	a5,0x1
    1004:	3f078793          	addi	a5,a5,1008 # 23f0 <base>
    1008:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    100c:	fe043783          	ld	a5,-32(s0)
    1010:	639c                	ld	a5,0(a5)
    1012:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1016:	fe843783          	ld	a5,-24(s0)
    101a:	4798                	lw	a4,8(a5)
    101c:	fdc42783          	lw	a5,-36(s0)
    1020:	2781                	sext.w	a5,a5
    1022:	06f76763          	bltu	a4,a5,1090 <malloc+0xf0>
      if(p->s.size == nunits)
    1026:	fe843783          	ld	a5,-24(s0)
    102a:	4798                	lw	a4,8(a5)
    102c:	fdc42783          	lw	a5,-36(s0)
    1030:	2781                	sext.w	a5,a5
    1032:	00e79963          	bne	a5,a4,1044 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1036:	fe843783          	ld	a5,-24(s0)
    103a:	6398                	ld	a4,0(a5)
    103c:	fe043783          	ld	a5,-32(s0)
    1040:	e398                	sd	a4,0(a5)
    1042:	a825                	j	107a <malloc+0xda>
      else {
        p->s.size -= nunits;
    1044:	fe843783          	ld	a5,-24(s0)
    1048:	479c                	lw	a5,8(a5)
    104a:	fdc42703          	lw	a4,-36(s0)
    104e:	9f99                	subw	a5,a5,a4
    1050:	0007871b          	sext.w	a4,a5
    1054:	fe843783          	ld	a5,-24(s0)
    1058:	c798                	sw	a4,8(a5)
        p += p->s.size;
    105a:	fe843783          	ld	a5,-24(s0)
    105e:	479c                	lw	a5,8(a5)
    1060:	1782                	slli	a5,a5,0x20
    1062:	9381                	srli	a5,a5,0x20
    1064:	0792                	slli	a5,a5,0x4
    1066:	fe843703          	ld	a4,-24(s0)
    106a:	97ba                	add	a5,a5,a4
    106c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1070:	fe843783          	ld	a5,-24(s0)
    1074:	fdc42703          	lw	a4,-36(s0)
    1078:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    107a:	00001797          	auipc	a5,0x1
    107e:	38678793          	addi	a5,a5,902 # 2400 <freep>
    1082:	fe043703          	ld	a4,-32(s0)
    1086:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1088:	fe843783          	ld	a5,-24(s0)
    108c:	07c1                	addi	a5,a5,16
    108e:	a091                	j	10d2 <malloc+0x132>
    }
    if(p == freep)
    1090:	00001797          	auipc	a5,0x1
    1094:	37078793          	addi	a5,a5,880 # 2400 <freep>
    1098:	639c                	ld	a5,0(a5)
    109a:	fe843703          	ld	a4,-24(s0)
    109e:	02f71063          	bne	a4,a5,10be <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    10a2:	fdc42783          	lw	a5,-36(s0)
    10a6:	853e                	mv	a0,a5
    10a8:	00000097          	auipc	ra,0x0
    10ac:	e78080e7          	jalr	-392(ra) # f20 <morecore>
    10b0:	fea43423          	sd	a0,-24(s0)
    10b4:	fe843783          	ld	a5,-24(s0)
    10b8:	e399                	bnez	a5,10be <malloc+0x11e>
        return 0;
    10ba:	4781                	li	a5,0
    10bc:	a819                	j	10d2 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10be:	fe843783          	ld	a5,-24(s0)
    10c2:	fef43023          	sd	a5,-32(s0)
    10c6:	fe843783          	ld	a5,-24(s0)
    10ca:	639c                	ld	a5,0(a5)
    10cc:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    10d0:	b799                	j	1016 <malloc+0x76>
  }
}
    10d2:	853e                	mv	a0,a5
    10d4:	70e2                	ld	ra,56(sp)
    10d6:	7442                	ld	s0,48(sp)
    10d8:	6121                	addi	sp,sp,64
    10da:	8082                	ret
