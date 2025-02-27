
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00010117          	auipc	sp,0x10
    80000004:	6a013103          	ld	sp,1696(sp) # 800106a0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	1a4000ef          	jal	800001ba <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <r_mhartid>:
#ifndef __ASSEMBLER__

// which hart (core) is this?
static inline uint64
r_mhartid()
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec22                	sd	s0,24(sp)
    80000020:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
    80000026:	fef43423          	sd	a5,-24(s0)
  return x;
    8000002a:	fe843783          	ld	a5,-24(s0)
}
    8000002e:	853e                	mv	a0,a5
    80000030:	6462                	ld	s0,24(sp)
    80000032:	6105                	addi	sp,sp,32
    80000034:	8082                	ret

0000000080000036 <r_mstatus>:
#define MSTATUS_MPP_U (0L << 11)
#define MSTATUS_MIE (1L << 3)    // machine-mode interrupt enable.

static inline uint64
r_mstatus()
{
    80000036:	1101                	addi	sp,sp,-32
    80000038:	ec22                	sd	s0,24(sp)
    8000003a:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000003c:	300027f3          	csrr	a5,mstatus
    80000040:	fef43423          	sd	a5,-24(s0)
  return x;
    80000044:	fe843783          	ld	a5,-24(s0)
}
    80000048:	853e                	mv	a0,a5
    8000004a:	6462                	ld	s0,24(sp)
    8000004c:	6105                	addi	sp,sp,32
    8000004e:	8082                	ret

0000000080000050 <w_mstatus>:

static inline void 
w_mstatus(uint64 x)
{
    80000050:	1101                	addi	sp,sp,-32
    80000052:	ec22                	sd	s0,24(sp)
    80000054:	1000                	addi	s0,sp,32
    80000056:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000005a:	fe843783          	ld	a5,-24(s0)
    8000005e:	30079073          	csrw	mstatus,a5
}
    80000062:	0001                	nop
    80000064:	6462                	ld	s0,24(sp)
    80000066:	6105                	addi	sp,sp,32
    80000068:	8082                	ret

000000008000006a <w_mepc>:
// machine exception program counter, holds the
// instruction address to which a return from
// exception will go.
static inline void 
w_mepc(uint64 x)
{
    8000006a:	1101                	addi	sp,sp,-32
    8000006c:	ec22                	sd	s0,24(sp)
    8000006e:	1000                	addi	s0,sp,32
    80000070:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mepc, %0" : : "r" (x));
    80000074:	fe843783          	ld	a5,-24(s0)
    80000078:	34179073          	csrw	mepc,a5
}
    8000007c:	0001                	nop
    8000007e:	6462                	ld	s0,24(sp)
    80000080:	6105                	addi	sp,sp,32
    80000082:	8082                	ret

0000000080000084 <r_sie>:
#define SIE_SEIE (1L << 9) // external
#define SIE_STIE (1L << 5) // timer
#define SIE_SSIE (1L << 1) // software
static inline uint64
r_sie()
{
    80000084:	1101                	addi	sp,sp,-32
    80000086:	ec22                	sd	s0,24(sp)
    80000088:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000008a:	104027f3          	csrr	a5,sie
    8000008e:	fef43423          	sd	a5,-24(s0)
  return x;
    80000092:	fe843783          	ld	a5,-24(s0)
}
    80000096:	853e                	mv	a0,a5
    80000098:	6462                	ld	s0,24(sp)
    8000009a:	6105                	addi	sp,sp,32
    8000009c:	8082                	ret

000000008000009e <w_sie>:

static inline void 
w_sie(uint64 x)
{
    8000009e:	1101                	addi	sp,sp,-32
    800000a0:	ec22                	sd	s0,24(sp)
    800000a2:	1000                	addi	s0,sp,32
    800000a4:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sie, %0" : : "r" (x));
    800000a8:	fe843783          	ld	a5,-24(s0)
    800000ac:	10479073          	csrw	sie,a5
}
    800000b0:	0001                	nop
    800000b2:	6462                	ld	s0,24(sp)
    800000b4:	6105                	addi	sp,sp,32
    800000b6:	8082                	ret

00000000800000b8 <r_mie>:
#define MIE_MEIE (1L << 11) // external
#define MIE_MTIE (1L << 7)  // timer
#define MIE_MSIE (1L << 3)  // software
static inline uint64
r_mie()
{
    800000b8:	1101                	addi	sp,sp,-32
    800000ba:	ec22                	sd	s0,24(sp)
    800000bc:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mie" : "=r" (x) );
    800000be:	304027f3          	csrr	a5,mie
    800000c2:	fef43423          	sd	a5,-24(s0)
  return x;
    800000c6:	fe843783          	ld	a5,-24(s0)
}
    800000ca:	853e                	mv	a0,a5
    800000cc:	6462                	ld	s0,24(sp)
    800000ce:	6105                	addi	sp,sp,32
    800000d0:	8082                	ret

00000000800000d2 <w_mie>:

static inline void 
w_mie(uint64 x)
{
    800000d2:	1101                	addi	sp,sp,-32
    800000d4:	ec22                	sd	s0,24(sp)
    800000d6:	1000                	addi	s0,sp,32
    800000d8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mie, %0" : : "r" (x));
    800000dc:	fe843783          	ld	a5,-24(s0)
    800000e0:	30479073          	csrw	mie,a5
}
    800000e4:	0001                	nop
    800000e6:	6462                	ld	s0,24(sp)
    800000e8:	6105                	addi	sp,sp,32
    800000ea:	8082                	ret

00000000800000ec <w_medeleg>:
  return x;
}

static inline void 
w_medeleg(uint64 x)
{
    800000ec:	1101                	addi	sp,sp,-32
    800000ee:	ec22                	sd	s0,24(sp)
    800000f0:	1000                	addi	s0,sp,32
    800000f2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000f6:	fe843783          	ld	a5,-24(s0)
    800000fa:	30279073          	csrw	medeleg,a5
}
    800000fe:	0001                	nop
    80000100:	6462                	ld	s0,24(sp)
    80000102:	6105                	addi	sp,sp,32
    80000104:	8082                	ret

0000000080000106 <w_mideleg>:
  return x;
}

static inline void 
w_mideleg(uint64 x)
{
    80000106:	1101                	addi	sp,sp,-32
    80000108:	ec22                	sd	s0,24(sp)
    8000010a:	1000                	addi	s0,sp,32
    8000010c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80000110:	fe843783          	ld	a5,-24(s0)
    80000114:	30379073          	csrw	mideleg,a5
}
    80000118:	0001                	nop
    8000011a:	6462                	ld	s0,24(sp)
    8000011c:	6105                	addi	sp,sp,32
    8000011e:	8082                	ret

0000000080000120 <w_mtvec>:
}

// Machine-mode interrupt vector
static inline void 
w_mtvec(uint64 x)
{
    80000120:	1101                	addi	sp,sp,-32
    80000122:	ec22                	sd	s0,24(sp)
    80000124:	1000                	addi	s0,sp,32
    80000126:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000012a:	fe843783          	ld	a5,-24(s0)
    8000012e:	30579073          	csrw	mtvec,a5
}
    80000132:	0001                	nop
    80000134:	6462                	ld	s0,24(sp)
    80000136:	6105                	addi	sp,sp,32
    80000138:	8082                	ret

000000008000013a <w_pmpcfg0>:

// Physical Memory Protection
static inline void
w_pmpcfg0(uint64 x)
{
    8000013a:	1101                	addi	sp,sp,-32
    8000013c:	ec22                	sd	s0,24(sp)
    8000013e:	1000                	addi	s0,sp,32
    80000140:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80000144:	fe843783          	ld	a5,-24(s0)
    80000148:	3a079073          	csrw	pmpcfg0,a5
}
    8000014c:	0001                	nop
    8000014e:	6462                	ld	s0,24(sp)
    80000150:	6105                	addi	sp,sp,32
    80000152:	8082                	ret

0000000080000154 <w_pmpaddr0>:

static inline void
w_pmpaddr0(uint64 x)
{
    80000154:	1101                	addi	sp,sp,-32
    80000156:	ec22                	sd	s0,24(sp)
    80000158:	1000                	addi	s0,sp,32
    8000015a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    8000015e:	fe843783          	ld	a5,-24(s0)
    80000162:	3b079073          	csrw	pmpaddr0,a5
}
    80000166:	0001                	nop
    80000168:	6462                	ld	s0,24(sp)
    8000016a:	6105                	addi	sp,sp,32
    8000016c:	8082                	ret

000000008000016e <w_satp>:

// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
    8000016e:	1101                	addi	sp,sp,-32
    80000170:	ec22                	sd	s0,24(sp)
    80000172:	1000                	addi	s0,sp,32
    80000174:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80000178:	fe843783          	ld	a5,-24(s0)
    8000017c:	18079073          	csrw	satp,a5
}
    80000180:	0001                	nop
    80000182:	6462                	ld	s0,24(sp)
    80000184:	6105                	addi	sp,sp,32
    80000186:	8082                	ret

0000000080000188 <w_mscratch>:
  return x;
}

static inline void 
w_mscratch(uint64 x)
{
    80000188:	1101                	addi	sp,sp,-32
    8000018a:	ec22                	sd	s0,24(sp)
    8000018c:	1000                	addi	s0,sp,32
    8000018e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000192:	fe843783          	ld	a5,-24(s0)
    80000196:	34079073          	csrw	mscratch,a5
}
    8000019a:	0001                	nop
    8000019c:	6462                	ld	s0,24(sp)
    8000019e:	6105                	addi	sp,sp,32
    800001a0:	8082                	ret

00000000800001a2 <w_tp>:
  return x;
}

static inline void 
w_tp(uint64 x)
{
    800001a2:	1101                	addi	sp,sp,-32
    800001a4:	ec22                	sd	s0,24(sp)
    800001a6:	1000                	addi	s0,sp,32
    800001a8:	fea43423          	sd	a0,-24(s0)
  asm volatile("mv tp, %0" : : "r" (x));
    800001ac:	fe843783          	ld	a5,-24(s0)
    800001b0:	823e                	mv	tp,a5
}
    800001b2:	0001                	nop
    800001b4:	6462                	ld	s0,24(sp)
    800001b6:	6105                	addi	sp,sp,32
    800001b8:	8082                	ret

00000000800001ba <start>:
extern void timervec();

// entry.S jumps here in machine mode on stack0.
void
start()
{
    800001ba:	1101                	addi	sp,sp,-32
    800001bc:	ec06                	sd	ra,24(sp)
    800001be:	e822                	sd	s0,16(sp)
    800001c0:	1000                	addi	s0,sp,32
  // set M Previous Privilege mode to Supervisor, for mret.
  unsigned long x = r_mstatus();
    800001c2:	00000097          	auipc	ra,0x0
    800001c6:	e74080e7          	jalr	-396(ra) # 80000036 <r_mstatus>
    800001ca:	fea43423          	sd	a0,-24(s0)
  x &= ~MSTATUS_MPP_MASK;
    800001ce:	fe843703          	ld	a4,-24(s0)
    800001d2:	77f9                	lui	a5,0xffffe
    800001d4:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7ffd3aef>
    800001d8:	8ff9                	and	a5,a5,a4
    800001da:	fef43423          	sd	a5,-24(s0)
  x |= MSTATUS_MPP_S;
    800001de:	fe843703          	ld	a4,-24(s0)
    800001e2:	6785                	lui	a5,0x1
    800001e4:	80078793          	addi	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    800001e8:	8fd9                	or	a5,a5,a4
    800001ea:	fef43423          	sd	a5,-24(s0)
  w_mstatus(x);
    800001ee:	fe843503          	ld	a0,-24(s0)
    800001f2:	00000097          	auipc	ra,0x0
    800001f6:	e5e080e7          	jalr	-418(ra) # 80000050 <w_mstatus>

  // set M Exception Program Counter to main, for mret.
  // requires gcc -mcmodel=medany
  w_mepc((uint64)main);
    800001fa:	00001797          	auipc	a5,0x1
    800001fe:	7ee78793          	addi	a5,a5,2030 # 800019e8 <main>
    80000202:	853e                	mv	a0,a5
    80000204:	00000097          	auipc	ra,0x0
    80000208:	e66080e7          	jalr	-410(ra) # 8000006a <w_mepc>

  // disable paging for now.
  w_satp(0);
    8000020c:	4501                	li	a0,0
    8000020e:	00000097          	auipc	ra,0x0
    80000212:	f60080e7          	jalr	-160(ra) # 8000016e <w_satp>

  // delegate all interrupts and exceptions to supervisor mode.
  w_medeleg(0xffff);
    80000216:	67c1                	lui	a5,0x10
    80000218:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    8000021c:	00000097          	auipc	ra,0x0
    80000220:	ed0080e7          	jalr	-304(ra) # 800000ec <w_medeleg>
  w_mideleg(0xffff);
    80000224:	67c1                	lui	a5,0x10
    80000226:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    8000022a:	00000097          	auipc	ra,0x0
    8000022e:	edc080e7          	jalr	-292(ra) # 80000106 <w_mideleg>
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80000232:	00000097          	auipc	ra,0x0
    80000236:	e52080e7          	jalr	-430(ra) # 80000084 <r_sie>
    8000023a:	87aa                	mv	a5,a0
    8000023c:	2227e793          	ori	a5,a5,546
    80000240:	853e                	mv	a0,a5
    80000242:	00000097          	auipc	ra,0x0
    80000246:	e5c080e7          	jalr	-420(ra) # 8000009e <w_sie>

  // configure Physical Memory Protection to give supervisor mode
  // access to all of physical memory.
  w_pmpaddr0(0x3fffffffffffffull);
    8000024a:	57fd                	li	a5,-1
    8000024c:	00a7d513          	srli	a0,a5,0xa
    80000250:	00000097          	auipc	ra,0x0
    80000254:	f04080e7          	jalr	-252(ra) # 80000154 <w_pmpaddr0>
  w_pmpcfg0(0xf);
    80000258:	453d                	li	a0,15
    8000025a:	00000097          	auipc	ra,0x0
    8000025e:	ee0080e7          	jalr	-288(ra) # 8000013a <w_pmpcfg0>

  // ask for clock interrupts.
  timerinit();
    80000262:	00000097          	auipc	ra,0x0
    80000266:	032080e7          	jalr	50(ra) # 80000294 <timerinit>

  // keep each CPU's hartid in its tp register, for cpuid().
  int id = r_mhartid();
    8000026a:	00000097          	auipc	ra,0x0
    8000026e:	db2080e7          	jalr	-590(ra) # 8000001c <r_mhartid>
    80000272:	87aa                	mv	a5,a0
    80000274:	fef42223          	sw	a5,-28(s0)
  w_tp(id);
    80000278:	fe442783          	lw	a5,-28(s0)
    8000027c:	853e                	mv	a0,a5
    8000027e:	00000097          	auipc	ra,0x0
    80000282:	f24080e7          	jalr	-220(ra) # 800001a2 <w_tp>

  // switch to supervisor mode and jump to main().
  asm volatile("mret");
    80000286:	30200073          	mret
}
    8000028a:	0001                	nop
    8000028c:	60e2                	ld	ra,24(sp)
    8000028e:	6442                	ld	s0,16(sp)
    80000290:	6105                	addi	sp,sp,32
    80000292:	8082                	ret

0000000080000294 <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80000294:	1101                	addi	sp,sp,-32
    80000296:	ec06                	sd	ra,24(sp)
    80000298:	e822                	sd	s0,16(sp)
    8000029a:	1000                	addi	s0,sp,32
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    8000029c:	00000097          	auipc	ra,0x0
    800002a0:	d80080e7          	jalr	-640(ra) # 8000001c <r_mhartid>
    800002a4:	87aa                	mv	a5,a0
    800002a6:	fef42623          	sw	a5,-20(s0)

  // ask the CLINT for a timer interrupt.
  int interval = 100000; // cycles; about 1/100th second in qemu.
    800002aa:	67e1                	lui	a5,0x18
    800002ac:	6a078793          	addi	a5,a5,1696 # 186a0 <_entry-0x7ffe7960>
    800002b0:	fef42423          	sw	a5,-24(s0)
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800002b4:	0200c7b7          	lui	a5,0x200c
    800002b8:	17e1                	addi	a5,a5,-8 # 200bff8 <_entry-0x7dff4008>
    800002ba:	6398                	ld	a4,0(a5)
    800002bc:	fe842783          	lw	a5,-24(s0)
    800002c0:	fec42683          	lw	a3,-20(s0)
    800002c4:	0036969b          	slliw	a3,a3,0x3
    800002c8:	2681                	sext.w	a3,a3
    800002ca:	8636                	mv	a2,a3
    800002cc:	020046b7          	lui	a3,0x2004
    800002d0:	96b2                	add	a3,a3,a2
    800002d2:	97ba                	add	a5,a5,a4
    800002d4:	e29c                	sd	a5,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800002d6:	fec42703          	lw	a4,-20(s0)
    800002da:	87ba                	mv	a5,a4
    800002dc:	078a                	slli	a5,a5,0x2
    800002de:	97ba                	add	a5,a5,a4
    800002e0:	078e                	slli	a5,a5,0x3
    800002e2:	00018717          	auipc	a4,0x18
    800002e6:	40e70713          	addi	a4,a4,1038 # 800186f0 <timer_scratch>
    800002ea:	97ba                	add	a5,a5,a4
    800002ec:	fef43023          	sd	a5,-32(s0)
  scratch[3] = CLINT_MTIMECMP(id);
    800002f0:	fec42783          	lw	a5,-20(s0)
    800002f4:	0037979b          	slliw	a5,a5,0x3
    800002f8:	2781                	sext.w	a5,a5
    800002fa:	873e                	mv	a4,a5
    800002fc:	020047b7          	lui	a5,0x2004
    80000300:	973e                	add	a4,a4,a5
    80000302:	fe043783          	ld	a5,-32(s0)
    80000306:	07e1                	addi	a5,a5,24 # 2004018 <_entry-0x7dffbfe8>
    80000308:	e398                	sd	a4,0(a5)
  scratch[4] = interval;
    8000030a:	fe043783          	ld	a5,-32(s0)
    8000030e:	02078793          	addi	a5,a5,32
    80000312:	fe842703          	lw	a4,-24(s0)
    80000316:	e398                	sd	a4,0(a5)
  w_mscratch((uint64)scratch);
    80000318:	fe043783          	ld	a5,-32(s0)
    8000031c:	853e                	mv	a0,a5
    8000031e:	00000097          	auipc	ra,0x0
    80000322:	e6a080e7          	jalr	-406(ra) # 80000188 <w_mscratch>

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);
    80000326:	00009797          	auipc	a5,0x9
    8000032a:	80a78793          	addi	a5,a5,-2038 # 80008b30 <timervec>
    8000032e:	853e                	mv	a0,a5
    80000330:	00000097          	auipc	ra,0x0
    80000334:	df0080e7          	jalr	-528(ra) # 80000120 <w_mtvec>

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000338:	00000097          	auipc	ra,0x0
    8000033c:	cfe080e7          	jalr	-770(ra) # 80000036 <r_mstatus>
    80000340:	87aa                	mv	a5,a0
    80000342:	0087e793          	ori	a5,a5,8
    80000346:	853e                	mv	a0,a5
    80000348:	00000097          	auipc	ra,0x0
    8000034c:	d08080e7          	jalr	-760(ra) # 80000050 <w_mstatus>

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000350:	00000097          	auipc	ra,0x0
    80000354:	d68080e7          	jalr	-664(ra) # 800000b8 <r_mie>
    80000358:	87aa                	mv	a5,a0
    8000035a:	0807e793          	ori	a5,a5,128
    8000035e:	853e                	mv	a0,a5
    80000360:	00000097          	auipc	ra,0x0
    80000364:	d72080e7          	jalr	-654(ra) # 800000d2 <w_mie>
}
    80000368:	0001                	nop
    8000036a:	60e2                	ld	ra,24(sp)
    8000036c:	6442                	ld	s0,16(sp)
    8000036e:	6105                	addi	sp,sp,32
    80000370:	8082                	ret

0000000080000372 <consputc>:
// called by printf(), and to echo input characters,
// but not from write().
//
void
consputc(int c)
{
    80000372:	1101                	addi	sp,sp,-32
    80000374:	ec06                	sd	ra,24(sp)
    80000376:	e822                	sd	s0,16(sp)
    80000378:	1000                	addi	s0,sp,32
    8000037a:	87aa                	mv	a5,a0
    8000037c:	fef42623          	sw	a5,-20(s0)
  if(c == BACKSPACE){
    80000380:	fec42783          	lw	a5,-20(s0)
    80000384:	0007871b          	sext.w	a4,a5
    80000388:	10000793          	li	a5,256
    8000038c:	02f71363          	bne	a4,a5,800003b2 <consputc+0x40>
    // if the user typed backspace, overwrite with a space.
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000390:	4521                	li	a0,8
    80000392:	00001097          	auipc	ra,0x1
    80000396:	b6a080e7          	jalr	-1174(ra) # 80000efc <uartputc_sync>
    8000039a:	02000513          	li	a0,32
    8000039e:	00001097          	auipc	ra,0x1
    800003a2:	b5e080e7          	jalr	-1186(ra) # 80000efc <uartputc_sync>
    800003a6:	4521                	li	a0,8
    800003a8:	00001097          	auipc	ra,0x1
    800003ac:	b54080e7          	jalr	-1196(ra) # 80000efc <uartputc_sync>
  } else {
    uartputc_sync(c);
  }
}
    800003b0:	a801                	j	800003c0 <consputc+0x4e>
    uartputc_sync(c);
    800003b2:	fec42783          	lw	a5,-20(s0)
    800003b6:	853e                	mv	a0,a5
    800003b8:	00001097          	auipc	ra,0x1
    800003bc:	b44080e7          	jalr	-1212(ra) # 80000efc <uartputc_sync>
}
    800003c0:	0001                	nop
    800003c2:	60e2                	ld	ra,24(sp)
    800003c4:	6442                	ld	s0,16(sp)
    800003c6:	6105                	addi	sp,sp,32
    800003c8:	8082                	ret

00000000800003ca <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800003ca:	7179                	addi	sp,sp,-48
    800003cc:	f406                	sd	ra,40(sp)
    800003ce:	f022                	sd	s0,32(sp)
    800003d0:	1800                	addi	s0,sp,48
    800003d2:	87aa                	mv	a5,a0
    800003d4:	fcb43823          	sd	a1,-48(s0)
    800003d8:	8732                	mv	a4,a2
    800003da:	fcf42e23          	sw	a5,-36(s0)
    800003de:	87ba                	mv	a5,a4
    800003e0:	fcf42c23          	sw	a5,-40(s0)
  int i;

  for(i = 0; i < n; i++){
    800003e4:	fe042623          	sw	zero,-20(s0)
    800003e8:	a0a1                	j	80000430 <consolewrite+0x66>
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800003ea:	fec42703          	lw	a4,-20(s0)
    800003ee:	fd043783          	ld	a5,-48(s0)
    800003f2:	00f70633          	add	a2,a4,a5
    800003f6:	fdc42703          	lw	a4,-36(s0)
    800003fa:	feb40793          	addi	a5,s0,-21
    800003fe:	4685                	li	a3,1
    80000400:	85ba                	mv	a1,a4
    80000402:	853e                	mv	a0,a5
    80000404:	00003097          	auipc	ra,0x3
    80000408:	586080e7          	jalr	1414(ra) # 8000398a <either_copyin>
    8000040c:	87aa                	mv	a5,a0
    8000040e:	873e                	mv	a4,a5
    80000410:	57fd                	li	a5,-1
    80000412:	02f70963          	beq	a4,a5,80000444 <consolewrite+0x7a>
      break;
    uartputc(c);
    80000416:	feb44783          	lbu	a5,-21(s0)
    8000041a:	2781                	sext.w	a5,a5
    8000041c:	853e                	mv	a0,a5
    8000041e:	00001097          	auipc	ra,0x1
    80000422:	a1e080e7          	jalr	-1506(ra) # 80000e3c <uartputc>
  for(i = 0; i < n; i++){
    80000426:	fec42783          	lw	a5,-20(s0)
    8000042a:	2785                	addiw	a5,a5,1
    8000042c:	fef42623          	sw	a5,-20(s0)
    80000430:	fec42783          	lw	a5,-20(s0)
    80000434:	873e                	mv	a4,a5
    80000436:	fd842783          	lw	a5,-40(s0)
    8000043a:	2701                	sext.w	a4,a4
    8000043c:	2781                	sext.w	a5,a5
    8000043e:	faf746e3          	blt	a4,a5,800003ea <consolewrite+0x20>
    80000442:	a011                	j	80000446 <consolewrite+0x7c>
      break;
    80000444:	0001                	nop
  }

  return i;
    80000446:	fec42783          	lw	a5,-20(s0)
}
    8000044a:	853e                	mv	a0,a5
    8000044c:	70a2                	ld	ra,40(sp)
    8000044e:	7402                	ld	s0,32(sp)
    80000450:	6145                	addi	sp,sp,48
    80000452:	8082                	ret

0000000080000454 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000454:	7179                	addi	sp,sp,-48
    80000456:	f406                	sd	ra,40(sp)
    80000458:	f022                	sd	s0,32(sp)
    8000045a:	1800                	addi	s0,sp,48
    8000045c:	87aa                	mv	a5,a0
    8000045e:	fcb43823          	sd	a1,-48(s0)
    80000462:	8732                	mv	a4,a2
    80000464:	fcf42e23          	sw	a5,-36(s0)
    80000468:	87ba                	mv	a5,a4
    8000046a:	fcf42c23          	sw	a5,-40(s0)
  uint target;
  int c;
  char cbuf;

  target = n;
    8000046e:	fd842783          	lw	a5,-40(s0)
    80000472:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    80000476:	00018517          	auipc	a0,0x18
    8000047a:	3ba50513          	addi	a0,a0,954 # 80018830 <cons>
    8000047e:	00001097          	auipc	ra,0x1
    80000482:	eb2080e7          	jalr	-334(ra) # 80001330 <acquire>
  while(n > 0){
    80000486:	a23d                	j	800005b4 <consoleread+0x160>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(killed(myproc())){
    80000488:	00002097          	auipc	ra,0x2
    8000048c:	676080e7          	jalr	1654(ra) # 80002afe <myproc>
    80000490:	87aa                	mv	a5,a0
    80000492:	853e                	mv	a0,a5
    80000494:	00003097          	auipc	ra,0x3
    80000498:	442080e7          	jalr	1090(ra) # 800038d6 <killed>
    8000049c:	87aa                	mv	a5,a0
    8000049e:	cb99                	beqz	a5,800004b4 <consoleread+0x60>
        release(&cons.lock);
    800004a0:	00018517          	auipc	a0,0x18
    800004a4:	39050513          	addi	a0,a0,912 # 80018830 <cons>
    800004a8:	00001097          	auipc	ra,0x1
    800004ac:	eec080e7          	jalr	-276(ra) # 80001394 <release>
        return -1;
    800004b0:	57fd                	li	a5,-1
    800004b2:	aa25                	j	800005ea <consoleread+0x196>
      }
      sleep(&cons.r, &cons.lock);
    800004b4:	00018597          	auipc	a1,0x18
    800004b8:	37c58593          	addi	a1,a1,892 # 80018830 <cons>
    800004bc:	00018517          	auipc	a0,0x18
    800004c0:	40c50513          	addi	a0,a0,1036 # 800188c8 <cons+0x98>
    800004c4:	00003097          	auipc	ra,0x3
    800004c8:	204080e7          	jalr	516(ra) # 800036c8 <sleep>
    while(cons.r == cons.w){
    800004cc:	00018797          	auipc	a5,0x18
    800004d0:	36478793          	addi	a5,a5,868 # 80018830 <cons>
    800004d4:	0987a703          	lw	a4,152(a5)
    800004d8:	00018797          	auipc	a5,0x18
    800004dc:	35878793          	addi	a5,a5,856 # 80018830 <cons>
    800004e0:	09c7a783          	lw	a5,156(a5)
    800004e4:	faf702e3          	beq	a4,a5,80000488 <consoleread+0x34>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800004e8:	00018797          	auipc	a5,0x18
    800004ec:	34878793          	addi	a5,a5,840 # 80018830 <cons>
    800004f0:	0987a783          	lw	a5,152(a5)
    800004f4:	2781                	sext.w	a5,a5
    800004f6:	0017871b          	addiw	a4,a5,1
    800004fa:	0007069b          	sext.w	a3,a4
    800004fe:	00018717          	auipc	a4,0x18
    80000502:	33270713          	addi	a4,a4,818 # 80018830 <cons>
    80000506:	08d72c23          	sw	a3,152(a4)
    8000050a:	07f7f793          	andi	a5,a5,127
    8000050e:	2781                	sext.w	a5,a5
    80000510:	00018717          	auipc	a4,0x18
    80000514:	32070713          	addi	a4,a4,800 # 80018830 <cons>
    80000518:	1782                	slli	a5,a5,0x20
    8000051a:	9381                	srli	a5,a5,0x20
    8000051c:	97ba                	add	a5,a5,a4
    8000051e:	0187c783          	lbu	a5,24(a5)
    80000522:	fef42423          	sw	a5,-24(s0)

    if(c == C('D')){  // end-of-file
    80000526:	fe842783          	lw	a5,-24(s0)
    8000052a:	0007871b          	sext.w	a4,a5
    8000052e:	4791                	li	a5,4
    80000530:	02f71963          	bne	a4,a5,80000562 <consoleread+0x10e>
      if(n < target){
    80000534:	fd842703          	lw	a4,-40(s0)
    80000538:	fec42783          	lw	a5,-20(s0)
    8000053c:	2781                	sext.w	a5,a5
    8000053e:	08f77163          	bgeu	a4,a5,800005c0 <consoleread+0x16c>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
    80000542:	00018797          	auipc	a5,0x18
    80000546:	2ee78793          	addi	a5,a5,750 # 80018830 <cons>
    8000054a:	0987a783          	lw	a5,152(a5)
    8000054e:	37fd                	addiw	a5,a5,-1
    80000550:	0007871b          	sext.w	a4,a5
    80000554:	00018797          	auipc	a5,0x18
    80000558:	2dc78793          	addi	a5,a5,732 # 80018830 <cons>
    8000055c:	08e7ac23          	sw	a4,152(a5)
      }
      break;
    80000560:	a085                	j	800005c0 <consoleread+0x16c>
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80000562:	fe842783          	lw	a5,-24(s0)
    80000566:	0ff7f793          	zext.b	a5,a5
    8000056a:	fef403a3          	sb	a5,-25(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000056e:	fe740713          	addi	a4,s0,-25
    80000572:	fdc42783          	lw	a5,-36(s0)
    80000576:	4685                	li	a3,1
    80000578:	863a                	mv	a2,a4
    8000057a:	fd043583          	ld	a1,-48(s0)
    8000057e:	853e                	mv	a0,a5
    80000580:	00003097          	auipc	ra,0x3
    80000584:	396080e7          	jalr	918(ra) # 80003916 <either_copyout>
    80000588:	87aa                	mv	a5,a0
    8000058a:	873e                	mv	a4,a5
    8000058c:	57fd                	li	a5,-1
    8000058e:	02f70b63          	beq	a4,a5,800005c4 <consoleread+0x170>
      break;

    dst++;
    80000592:	fd043783          	ld	a5,-48(s0)
    80000596:	0785                	addi	a5,a5,1
    80000598:	fcf43823          	sd	a5,-48(s0)
    --n;
    8000059c:	fd842783          	lw	a5,-40(s0)
    800005a0:	37fd                	addiw	a5,a5,-1
    800005a2:	fcf42c23          	sw	a5,-40(s0)

    if(c == '\n'){
    800005a6:	fe842783          	lw	a5,-24(s0)
    800005aa:	0007871b          	sext.w	a4,a5
    800005ae:	47a9                	li	a5,10
    800005b0:	00f70c63          	beq	a4,a5,800005c8 <consoleread+0x174>
  while(n > 0){
    800005b4:	fd842783          	lw	a5,-40(s0)
    800005b8:	2781                	sext.w	a5,a5
    800005ba:	f0f049e3          	bgtz	a5,800004cc <consoleread+0x78>
    800005be:	a031                	j	800005ca <consoleread+0x176>
      break;
    800005c0:	0001                	nop
    800005c2:	a021                	j	800005ca <consoleread+0x176>
      break;
    800005c4:	0001                	nop
    800005c6:	a011                	j	800005ca <consoleread+0x176>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    800005c8:	0001                	nop
    }
  }
  release(&cons.lock);
    800005ca:	00018517          	auipc	a0,0x18
    800005ce:	26650513          	addi	a0,a0,614 # 80018830 <cons>
    800005d2:	00001097          	auipc	ra,0x1
    800005d6:	dc2080e7          	jalr	-574(ra) # 80001394 <release>

  return target - n;
    800005da:	fd842783          	lw	a5,-40(s0)
    800005de:	fec42703          	lw	a4,-20(s0)
    800005e2:	40f707bb          	subw	a5,a4,a5
    800005e6:	2781                	sext.w	a5,a5
    800005e8:	2781                	sext.w	a5,a5
}
    800005ea:	853e                	mv	a0,a5
    800005ec:	70a2                	ld	ra,40(sp)
    800005ee:	7402                	ld	s0,32(sp)
    800005f0:	6145                	addi	sp,sp,48
    800005f2:	8082                	ret

00000000800005f4 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800005f4:	1101                	addi	sp,sp,-32
    800005f6:	ec06                	sd	ra,24(sp)
    800005f8:	e822                	sd	s0,16(sp)
    800005fa:	1000                	addi	s0,sp,32
    800005fc:	87aa                	mv	a5,a0
    800005fe:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    80000602:	00018517          	auipc	a0,0x18
    80000606:	22e50513          	addi	a0,a0,558 # 80018830 <cons>
    8000060a:	00001097          	auipc	ra,0x1
    8000060e:	d26080e7          	jalr	-730(ra) # 80001330 <acquire>

  switch(c){
    80000612:	fec42783          	lw	a5,-20(s0)
    80000616:	0007871b          	sext.w	a4,a5
    8000061a:	07f00793          	li	a5,127
    8000061e:	0cf70763          	beq	a4,a5,800006ec <consoleintr+0xf8>
    80000622:	fec42783          	lw	a5,-20(s0)
    80000626:	0007871b          	sext.w	a4,a5
    8000062a:	07f00793          	li	a5,127
    8000062e:	10e7c363          	blt	a5,a4,80000734 <consoleintr+0x140>
    80000632:	fec42783          	lw	a5,-20(s0)
    80000636:	0007871b          	sext.w	a4,a5
    8000063a:	47d5                	li	a5,21
    8000063c:	06f70163          	beq	a4,a5,8000069e <consoleintr+0xaa>
    80000640:	fec42783          	lw	a5,-20(s0)
    80000644:	0007871b          	sext.w	a4,a5
    80000648:	47d5                	li	a5,21
    8000064a:	0ee7c563          	blt	a5,a4,80000734 <consoleintr+0x140>
    8000064e:	fec42783          	lw	a5,-20(s0)
    80000652:	0007871b          	sext.w	a4,a5
    80000656:	47a1                	li	a5,8
    80000658:	08f70a63          	beq	a4,a5,800006ec <consoleintr+0xf8>
    8000065c:	fec42783          	lw	a5,-20(s0)
    80000660:	0007871b          	sext.w	a4,a5
    80000664:	47c1                	li	a5,16
    80000666:	0cf71763          	bne	a4,a5,80000734 <consoleintr+0x140>
  case C('P'):  // Print process list.
    procdump();
    8000066a:	00003097          	auipc	ra,0x3
    8000066e:	394080e7          	jalr	916(ra) # 800039fe <procdump>
    break;
    80000672:	aad9                	j	80000848 <consoleintr+0x254>
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
      cons.e--;
    80000674:	00018797          	auipc	a5,0x18
    80000678:	1bc78793          	addi	a5,a5,444 # 80018830 <cons>
    8000067c:	0a07a783          	lw	a5,160(a5)
    80000680:	37fd                	addiw	a5,a5,-1
    80000682:	0007871b          	sext.w	a4,a5
    80000686:	00018797          	auipc	a5,0x18
    8000068a:	1aa78793          	addi	a5,a5,426 # 80018830 <cons>
    8000068e:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80000692:	10000513          	li	a0,256
    80000696:	00000097          	auipc	ra,0x0
    8000069a:	cdc080e7          	jalr	-804(ra) # 80000372 <consputc>
    while(cons.e != cons.w &&
    8000069e:	00018797          	auipc	a5,0x18
    800006a2:	19278793          	addi	a5,a5,402 # 80018830 <cons>
    800006a6:	0a07a703          	lw	a4,160(a5)
    800006aa:	00018797          	auipc	a5,0x18
    800006ae:	18678793          	addi	a5,a5,390 # 80018830 <cons>
    800006b2:	09c7a783          	lw	a5,156(a5)
    800006b6:	18f70463          	beq	a4,a5,8000083e <consoleintr+0x24a>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800006ba:	00018797          	auipc	a5,0x18
    800006be:	17678793          	addi	a5,a5,374 # 80018830 <cons>
    800006c2:	0a07a783          	lw	a5,160(a5)
    800006c6:	37fd                	addiw	a5,a5,-1
    800006c8:	2781                	sext.w	a5,a5
    800006ca:	07f7f793          	andi	a5,a5,127
    800006ce:	2781                	sext.w	a5,a5
    800006d0:	00018717          	auipc	a4,0x18
    800006d4:	16070713          	addi	a4,a4,352 # 80018830 <cons>
    800006d8:	1782                	slli	a5,a5,0x20
    800006da:	9381                	srli	a5,a5,0x20
    800006dc:	97ba                	add	a5,a5,a4
    800006de:	0187c783          	lbu	a5,24(a5)
    while(cons.e != cons.w &&
    800006e2:	873e                	mv	a4,a5
    800006e4:	47a9                	li	a5,10
    800006e6:	f8f717e3          	bne	a4,a5,80000674 <consoleintr+0x80>
    }
    break;
    800006ea:	aa91                	j	8000083e <consoleintr+0x24a>
  case C('H'): // Backspace
  case '\x7f': // Delete key
    if(cons.e != cons.w){
    800006ec:	00018797          	auipc	a5,0x18
    800006f0:	14478793          	addi	a5,a5,324 # 80018830 <cons>
    800006f4:	0a07a703          	lw	a4,160(a5)
    800006f8:	00018797          	auipc	a5,0x18
    800006fc:	13878793          	addi	a5,a5,312 # 80018830 <cons>
    80000700:	09c7a783          	lw	a5,156(a5)
    80000704:	12f70f63          	beq	a4,a5,80000842 <consoleintr+0x24e>
      cons.e--;
    80000708:	00018797          	auipc	a5,0x18
    8000070c:	12878793          	addi	a5,a5,296 # 80018830 <cons>
    80000710:	0a07a783          	lw	a5,160(a5)
    80000714:	37fd                	addiw	a5,a5,-1
    80000716:	0007871b          	sext.w	a4,a5
    8000071a:	00018797          	auipc	a5,0x18
    8000071e:	11678793          	addi	a5,a5,278 # 80018830 <cons>
    80000722:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80000726:	10000513          	li	a0,256
    8000072a:	00000097          	auipc	ra,0x0
    8000072e:	c48080e7          	jalr	-952(ra) # 80000372 <consputc>
    }
    break;
    80000732:	aa01                	j	80000842 <consoleintr+0x24e>
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80000734:	fec42783          	lw	a5,-20(s0)
    80000738:	2781                	sext.w	a5,a5
    8000073a:	10078663          	beqz	a5,80000846 <consoleintr+0x252>
    8000073e:	00018797          	auipc	a5,0x18
    80000742:	0f278793          	addi	a5,a5,242 # 80018830 <cons>
    80000746:	0a07a703          	lw	a4,160(a5)
    8000074a:	00018797          	auipc	a5,0x18
    8000074e:	0e678793          	addi	a5,a5,230 # 80018830 <cons>
    80000752:	0987a783          	lw	a5,152(a5)
    80000756:	40f707bb          	subw	a5,a4,a5
    8000075a:	2781                	sext.w	a5,a5
    8000075c:	873e                	mv	a4,a5
    8000075e:	07f00793          	li	a5,127
    80000762:	0ee7e263          	bltu	a5,a4,80000846 <consoleintr+0x252>
      c = (c == '\r') ? '\n' : c;
    80000766:	fec42783          	lw	a5,-20(s0)
    8000076a:	0007871b          	sext.w	a4,a5
    8000076e:	47b5                	li	a5,13
    80000770:	00f70563          	beq	a4,a5,8000077a <consoleintr+0x186>
    80000774:	fec42783          	lw	a5,-20(s0)
    80000778:	a011                	j	8000077c <consoleintr+0x188>
    8000077a:	47a9                	li	a5,10
    8000077c:	fef42623          	sw	a5,-20(s0)

      // echo back to the user.
      consputc(c);
    80000780:	fec42783          	lw	a5,-20(s0)
    80000784:	853e                	mv	a0,a5
    80000786:	00000097          	auipc	ra,0x0
    8000078a:	bec080e7          	jalr	-1044(ra) # 80000372 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    8000078e:	00018797          	auipc	a5,0x18
    80000792:	0a278793          	addi	a5,a5,162 # 80018830 <cons>
    80000796:	0a07a783          	lw	a5,160(a5)
    8000079a:	2781                	sext.w	a5,a5
    8000079c:	0017871b          	addiw	a4,a5,1
    800007a0:	0007069b          	sext.w	a3,a4
    800007a4:	00018717          	auipc	a4,0x18
    800007a8:	08c70713          	addi	a4,a4,140 # 80018830 <cons>
    800007ac:	0ad72023          	sw	a3,160(a4)
    800007b0:	07f7f793          	andi	a5,a5,127
    800007b4:	2781                	sext.w	a5,a5
    800007b6:	fec42703          	lw	a4,-20(s0)
    800007ba:	0ff77713          	zext.b	a4,a4
    800007be:	00018697          	auipc	a3,0x18
    800007c2:	07268693          	addi	a3,a3,114 # 80018830 <cons>
    800007c6:	1782                	slli	a5,a5,0x20
    800007c8:	9381                	srli	a5,a5,0x20
    800007ca:	97b6                	add	a5,a5,a3
    800007cc:	00e78c23          	sb	a4,24(a5)

      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    800007d0:	fec42783          	lw	a5,-20(s0)
    800007d4:	0007871b          	sext.w	a4,a5
    800007d8:	47a9                	li	a5,10
    800007da:	02f70d63          	beq	a4,a5,80000814 <consoleintr+0x220>
    800007de:	fec42783          	lw	a5,-20(s0)
    800007e2:	0007871b          	sext.w	a4,a5
    800007e6:	4791                	li	a5,4
    800007e8:	02f70663          	beq	a4,a5,80000814 <consoleintr+0x220>
    800007ec:	00018797          	auipc	a5,0x18
    800007f0:	04478793          	addi	a5,a5,68 # 80018830 <cons>
    800007f4:	0a07a703          	lw	a4,160(a5)
    800007f8:	00018797          	auipc	a5,0x18
    800007fc:	03878793          	addi	a5,a5,56 # 80018830 <cons>
    80000800:	0987a783          	lw	a5,152(a5)
    80000804:	40f707bb          	subw	a5,a4,a5
    80000808:	2781                	sext.w	a5,a5
    8000080a:	873e                	mv	a4,a5
    8000080c:	08000793          	li	a5,128
    80000810:	02f71b63          	bne	a4,a5,80000846 <consoleintr+0x252>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80000814:	00018797          	auipc	a5,0x18
    80000818:	01c78793          	addi	a5,a5,28 # 80018830 <cons>
    8000081c:	0a07a703          	lw	a4,160(a5)
    80000820:	00018797          	auipc	a5,0x18
    80000824:	01078793          	addi	a5,a5,16 # 80018830 <cons>
    80000828:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    8000082c:	00018517          	auipc	a0,0x18
    80000830:	09c50513          	addi	a0,a0,156 # 800188c8 <cons+0x98>
    80000834:	00003097          	auipc	ra,0x3
    80000838:	f10080e7          	jalr	-240(ra) # 80003744 <wakeup>
      }
    }
    break;
    8000083c:	a029                	j	80000846 <consoleintr+0x252>
    break;
    8000083e:	0001                	nop
    80000840:	a021                	j	80000848 <consoleintr+0x254>
    break;
    80000842:	0001                	nop
    80000844:	a011                	j	80000848 <consoleintr+0x254>
    break;
    80000846:	0001                	nop
  }
  
  release(&cons.lock);
    80000848:	00018517          	auipc	a0,0x18
    8000084c:	fe850513          	addi	a0,a0,-24 # 80018830 <cons>
    80000850:	00001097          	auipc	ra,0x1
    80000854:	b44080e7          	jalr	-1212(ra) # 80001394 <release>
}
    80000858:	0001                	nop
    8000085a:	60e2                	ld	ra,24(sp)
    8000085c:	6442                	ld	s0,16(sp)
    8000085e:	6105                	addi	sp,sp,32
    80000860:	8082                	ret

0000000080000862 <consoleinit>:

void
consoleinit(void)
{
    80000862:	1141                	addi	sp,sp,-16
    80000864:	e406                	sd	ra,8(sp)
    80000866:	e022                	sd	s0,0(sp)
    80000868:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000086a:	0000c597          	auipc	a1,0xc
    8000086e:	79658593          	addi	a1,a1,1942 # 8000d000 <etext>
    80000872:	00018517          	auipc	a0,0x18
    80000876:	fbe50513          	addi	a0,a0,-66 # 80018830 <cons>
    8000087a:	00001097          	auipc	ra,0x1
    8000087e:	a86080e7          	jalr	-1402(ra) # 80001300 <initlock>

  uartinit();
    80000882:	00000097          	auipc	ra,0x0
    80000886:	540080e7          	jalr	1344(ra) # 80000dc2 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000088a:	00028797          	auipc	a5,0x28
    8000088e:	14678793          	addi	a5,a5,326 # 800289d0 <devsw>
    80000892:	00000717          	auipc	a4,0x0
    80000896:	bc270713          	addi	a4,a4,-1086 # 80000454 <consoleread>
    8000089a:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000089c:	00028797          	auipc	a5,0x28
    800008a0:	13478793          	addi	a5,a5,308 # 800289d0 <devsw>
    800008a4:	00000717          	auipc	a4,0x0
    800008a8:	b2670713          	addi	a4,a4,-1242 # 800003ca <consolewrite>
    800008ac:	ef98                	sd	a4,24(a5)
}
    800008ae:	0001                	nop
    800008b0:	60a2                	ld	ra,8(sp)
    800008b2:	6402                	ld	s0,0(sp)
    800008b4:	0141                	addi	sp,sp,16
    800008b6:	8082                	ret

00000000800008b8 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800008b8:	7139                	addi	sp,sp,-64
    800008ba:	fc06                	sd	ra,56(sp)
    800008bc:	f822                	sd	s0,48(sp)
    800008be:	0080                	addi	s0,sp,64
    800008c0:	87aa                	mv	a5,a0
    800008c2:	86ae                	mv	a3,a1
    800008c4:	8732                	mv	a4,a2
    800008c6:	fcf42623          	sw	a5,-52(s0)
    800008ca:	87b6                	mv	a5,a3
    800008cc:	fcf42423          	sw	a5,-56(s0)
    800008d0:	87ba                	mv	a5,a4
    800008d2:	fcf42223          	sw	a5,-60(s0)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800008d6:	fc442783          	lw	a5,-60(s0)
    800008da:	2781                	sext.w	a5,a5
    800008dc:	c78d                	beqz	a5,80000906 <printint+0x4e>
    800008de:	fcc42783          	lw	a5,-52(s0)
    800008e2:	01f7d79b          	srliw	a5,a5,0x1f
    800008e6:	0ff7f793          	zext.b	a5,a5
    800008ea:	fcf42223          	sw	a5,-60(s0)
    800008ee:	fc442783          	lw	a5,-60(s0)
    800008f2:	2781                	sext.w	a5,a5
    800008f4:	cb89                	beqz	a5,80000906 <printint+0x4e>
    x = -xx;
    800008f6:	fcc42783          	lw	a5,-52(s0)
    800008fa:	40f007bb          	negw	a5,a5
    800008fe:	2781                	sext.w	a5,a5
    80000900:	fef42423          	sw	a5,-24(s0)
    80000904:	a029                	j	8000090e <printint+0x56>
  else
    x = xx;
    80000906:	fcc42783          	lw	a5,-52(s0)
    8000090a:	fef42423          	sw	a5,-24(s0)

  i = 0;
    8000090e:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[x % base];
    80000912:	fc842783          	lw	a5,-56(s0)
    80000916:	fe842703          	lw	a4,-24(s0)
    8000091a:	02f777bb          	remuw	a5,a4,a5
    8000091e:	0007861b          	sext.w	a2,a5
    80000922:	fec42783          	lw	a5,-20(s0)
    80000926:	0017871b          	addiw	a4,a5,1
    8000092a:	fee42623          	sw	a4,-20(s0)
    8000092e:	00010697          	auipc	a3,0x10
    80000932:	bd268693          	addi	a3,a3,-1070 # 80010500 <digits>
    80000936:	02061713          	slli	a4,a2,0x20
    8000093a:	9301                	srli	a4,a4,0x20
    8000093c:	9736                	add	a4,a4,a3
    8000093e:	00074703          	lbu	a4,0(a4)
    80000942:	17c1                	addi	a5,a5,-16
    80000944:	97a2                	add	a5,a5,s0
    80000946:	fee78423          	sb	a4,-24(a5)
  } while((x /= base) != 0);
    8000094a:	fc842783          	lw	a5,-56(s0)
    8000094e:	fe842703          	lw	a4,-24(s0)
    80000952:	02f757bb          	divuw	a5,a4,a5
    80000956:	fef42423          	sw	a5,-24(s0)
    8000095a:	fe842783          	lw	a5,-24(s0)
    8000095e:	2781                	sext.w	a5,a5
    80000960:	fbcd                	bnez	a5,80000912 <printint+0x5a>

  if(sign)
    80000962:	fc442783          	lw	a5,-60(s0)
    80000966:	2781                	sext.w	a5,a5
    80000968:	cb95                	beqz	a5,8000099c <printint+0xe4>
    buf[i++] = '-';
    8000096a:	fec42783          	lw	a5,-20(s0)
    8000096e:	0017871b          	addiw	a4,a5,1
    80000972:	fee42623          	sw	a4,-20(s0)
    80000976:	17c1                	addi	a5,a5,-16
    80000978:	97a2                	add	a5,a5,s0
    8000097a:	02d00713          	li	a4,45
    8000097e:	fee78423          	sb	a4,-24(a5)

  while(--i >= 0)
    80000982:	a829                	j	8000099c <printint+0xe4>
    consputc(buf[i]);
    80000984:	fec42783          	lw	a5,-20(s0)
    80000988:	17c1                	addi	a5,a5,-16
    8000098a:	97a2                	add	a5,a5,s0
    8000098c:	fe87c783          	lbu	a5,-24(a5)
    80000990:	2781                	sext.w	a5,a5
    80000992:	853e                	mv	a0,a5
    80000994:	00000097          	auipc	ra,0x0
    80000998:	9de080e7          	jalr	-1570(ra) # 80000372 <consputc>
  while(--i >= 0)
    8000099c:	fec42783          	lw	a5,-20(s0)
    800009a0:	37fd                	addiw	a5,a5,-1
    800009a2:	fef42623          	sw	a5,-20(s0)
    800009a6:	fec42783          	lw	a5,-20(s0)
    800009aa:	2781                	sext.w	a5,a5
    800009ac:	fc07dce3          	bgez	a5,80000984 <printint+0xcc>
}
    800009b0:	0001                	nop
    800009b2:	0001                	nop
    800009b4:	70e2                	ld	ra,56(sp)
    800009b6:	7442                	ld	s0,48(sp)
    800009b8:	6121                	addi	sp,sp,64
    800009ba:	8082                	ret

00000000800009bc <printptr>:

static void
printptr(uint64 x)
{
    800009bc:	7179                	addi	sp,sp,-48
    800009be:	f406                	sd	ra,40(sp)
    800009c0:	f022                	sd	s0,32(sp)
    800009c2:	1800                	addi	s0,sp,48
    800009c4:	fca43c23          	sd	a0,-40(s0)
  int i;
  consputc('0');
    800009c8:	03000513          	li	a0,48
    800009cc:	00000097          	auipc	ra,0x0
    800009d0:	9a6080e7          	jalr	-1626(ra) # 80000372 <consputc>
  consputc('x');
    800009d4:	07800513          	li	a0,120
    800009d8:	00000097          	auipc	ra,0x0
    800009dc:	99a080e7          	jalr	-1638(ra) # 80000372 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009e0:	fe042623          	sw	zero,-20(s0)
    800009e4:	a81d                	j	80000a1a <printptr+0x5e>
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800009e6:	fd843783          	ld	a5,-40(s0)
    800009ea:	93f1                	srli	a5,a5,0x3c
    800009ec:	00010717          	auipc	a4,0x10
    800009f0:	b1470713          	addi	a4,a4,-1260 # 80010500 <digits>
    800009f4:	97ba                	add	a5,a5,a4
    800009f6:	0007c783          	lbu	a5,0(a5)
    800009fa:	2781                	sext.w	a5,a5
    800009fc:	853e                	mv	a0,a5
    800009fe:	00000097          	auipc	ra,0x0
    80000a02:	974080e7          	jalr	-1676(ra) # 80000372 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80000a06:	fec42783          	lw	a5,-20(s0)
    80000a0a:	2785                	addiw	a5,a5,1
    80000a0c:	fef42623          	sw	a5,-20(s0)
    80000a10:	fd843783          	ld	a5,-40(s0)
    80000a14:	0792                	slli	a5,a5,0x4
    80000a16:	fcf43c23          	sd	a5,-40(s0)
    80000a1a:	fec42783          	lw	a5,-20(s0)
    80000a1e:	873e                	mv	a4,a5
    80000a20:	47bd                	li	a5,15
    80000a22:	fce7f2e3          	bgeu	a5,a4,800009e6 <printptr+0x2a>
}
    80000a26:	0001                	nop
    80000a28:	0001                	nop
    80000a2a:	70a2                	ld	ra,40(sp)
    80000a2c:	7402                	ld	s0,32(sp)
    80000a2e:	6145                	addi	sp,sp,48
    80000a30:	8082                	ret

0000000080000a32 <printf>:

// Print to the console. only understands %d, %x, %p, %s.
void
printf(char *fmt, ...)
{
    80000a32:	7119                	addi	sp,sp,-128
    80000a34:	fc06                	sd	ra,56(sp)
    80000a36:	f822                	sd	s0,48(sp)
    80000a38:	0080                	addi	s0,sp,64
    80000a3a:	fca43423          	sd	a0,-56(s0)
    80000a3e:	e40c                	sd	a1,8(s0)
    80000a40:	e810                	sd	a2,16(s0)
    80000a42:	ec14                	sd	a3,24(s0)
    80000a44:	f018                	sd	a4,32(s0)
    80000a46:	f41c                	sd	a5,40(s0)
    80000a48:	03043823          	sd	a6,48(s0)
    80000a4c:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, c, locking;
  char *s;

  locking = pr.locking;
    80000a50:	00018797          	auipc	a5,0x18
    80000a54:	e8878793          	addi	a5,a5,-376 # 800188d8 <pr>
    80000a58:	4f9c                	lw	a5,24(a5)
    80000a5a:	fcf42e23          	sw	a5,-36(s0)
  if(locking)
    80000a5e:	fdc42783          	lw	a5,-36(s0)
    80000a62:	2781                	sext.w	a5,a5
    80000a64:	cb89                	beqz	a5,80000a76 <printf+0x44>
    acquire(&pr.lock);
    80000a66:	00018517          	auipc	a0,0x18
    80000a6a:	e7250513          	addi	a0,a0,-398 # 800188d8 <pr>
    80000a6e:	00001097          	auipc	ra,0x1
    80000a72:	8c2080e7          	jalr	-1854(ra) # 80001330 <acquire>

  if (fmt == 0)
    80000a76:	fc843783          	ld	a5,-56(s0)
    80000a7a:	eb89                	bnez	a5,80000a8c <printf+0x5a>
    panic("null fmt");
    80000a7c:	0000c517          	auipc	a0,0xc
    80000a80:	58c50513          	addi	a0,a0,1420 # 8000d008 <etext+0x8>
    80000a84:	00000097          	auipc	ra,0x0
    80000a88:	204080e7          	jalr	516(ra) # 80000c88 <panic>

  va_start(ap, fmt);
    80000a8c:	04040793          	addi	a5,s0,64
    80000a90:	fcf43023          	sd	a5,-64(s0)
    80000a94:	fc043783          	ld	a5,-64(s0)
    80000a98:	fc878793          	addi	a5,a5,-56
    80000a9c:	fcf43823          	sd	a5,-48(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000aa0:	fe042623          	sw	zero,-20(s0)
    80000aa4:	a24d                	j	80000c46 <printf+0x214>
    if(c != '%'){
    80000aa6:	fd842783          	lw	a5,-40(s0)
    80000aaa:	0007871b          	sext.w	a4,a5
    80000aae:	02500793          	li	a5,37
    80000ab2:	00f70a63          	beq	a4,a5,80000ac6 <printf+0x94>
      consputc(c);
    80000ab6:	fd842783          	lw	a5,-40(s0)
    80000aba:	853e                	mv	a0,a5
    80000abc:	00000097          	auipc	ra,0x0
    80000ac0:	8b6080e7          	jalr	-1866(ra) # 80000372 <consputc>
      continue;
    80000ac4:	aaa5                	j	80000c3c <printf+0x20a>
    }
    c = fmt[++i] & 0xff;
    80000ac6:	fec42783          	lw	a5,-20(s0)
    80000aca:	2785                	addiw	a5,a5,1
    80000acc:	fef42623          	sw	a5,-20(s0)
    80000ad0:	fec42783          	lw	a5,-20(s0)
    80000ad4:	fc843703          	ld	a4,-56(s0)
    80000ad8:	97ba                	add	a5,a5,a4
    80000ada:	0007c783          	lbu	a5,0(a5)
    80000ade:	fcf42c23          	sw	a5,-40(s0)
    if(c == 0)
    80000ae2:	fd842783          	lw	a5,-40(s0)
    80000ae6:	2781                	sext.w	a5,a5
    80000ae8:	16078e63          	beqz	a5,80000c64 <printf+0x232>
      break;
    switch(c){
    80000aec:	fd842783          	lw	a5,-40(s0)
    80000af0:	0007871b          	sext.w	a4,a5
    80000af4:	07800793          	li	a5,120
    80000af8:	08f70963          	beq	a4,a5,80000b8a <printf+0x158>
    80000afc:	fd842783          	lw	a5,-40(s0)
    80000b00:	0007871b          	sext.w	a4,a5
    80000b04:	07800793          	li	a5,120
    80000b08:	10e7cc63          	blt	a5,a4,80000c20 <printf+0x1ee>
    80000b0c:	fd842783          	lw	a5,-40(s0)
    80000b10:	0007871b          	sext.w	a4,a5
    80000b14:	07300793          	li	a5,115
    80000b18:	0af70563          	beq	a4,a5,80000bc2 <printf+0x190>
    80000b1c:	fd842783          	lw	a5,-40(s0)
    80000b20:	0007871b          	sext.w	a4,a5
    80000b24:	07300793          	li	a5,115
    80000b28:	0ee7cc63          	blt	a5,a4,80000c20 <printf+0x1ee>
    80000b2c:	fd842783          	lw	a5,-40(s0)
    80000b30:	0007871b          	sext.w	a4,a5
    80000b34:	07000793          	li	a5,112
    80000b38:	06f70863          	beq	a4,a5,80000ba8 <printf+0x176>
    80000b3c:	fd842783          	lw	a5,-40(s0)
    80000b40:	0007871b          	sext.w	a4,a5
    80000b44:	07000793          	li	a5,112
    80000b48:	0ce7cc63          	blt	a5,a4,80000c20 <printf+0x1ee>
    80000b4c:	fd842783          	lw	a5,-40(s0)
    80000b50:	0007871b          	sext.w	a4,a5
    80000b54:	02500793          	li	a5,37
    80000b58:	0af70d63          	beq	a4,a5,80000c12 <printf+0x1e0>
    80000b5c:	fd842783          	lw	a5,-40(s0)
    80000b60:	0007871b          	sext.w	a4,a5
    80000b64:	06400793          	li	a5,100
    80000b68:	0af71c63          	bne	a4,a5,80000c20 <printf+0x1ee>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
    80000b6c:	fd043783          	ld	a5,-48(s0)
    80000b70:	00878713          	addi	a4,a5,8
    80000b74:	fce43823          	sd	a4,-48(s0)
    80000b78:	439c                	lw	a5,0(a5)
    80000b7a:	4605                	li	a2,1
    80000b7c:	45a9                	li	a1,10
    80000b7e:	853e                	mv	a0,a5
    80000b80:	00000097          	auipc	ra,0x0
    80000b84:	d38080e7          	jalr	-712(ra) # 800008b8 <printint>
      break;
    80000b88:	a855                	j	80000c3c <printf+0x20a>
    case 'x':
      printint(va_arg(ap, int), 16, 1);
    80000b8a:	fd043783          	ld	a5,-48(s0)
    80000b8e:	00878713          	addi	a4,a5,8
    80000b92:	fce43823          	sd	a4,-48(s0)
    80000b96:	439c                	lw	a5,0(a5)
    80000b98:	4605                	li	a2,1
    80000b9a:	45c1                	li	a1,16
    80000b9c:	853e                	mv	a0,a5
    80000b9e:	00000097          	auipc	ra,0x0
    80000ba2:	d1a080e7          	jalr	-742(ra) # 800008b8 <printint>
      break;
    80000ba6:	a859                	j	80000c3c <printf+0x20a>
    case 'p':
      printptr(va_arg(ap, uint64));
    80000ba8:	fd043783          	ld	a5,-48(s0)
    80000bac:	00878713          	addi	a4,a5,8
    80000bb0:	fce43823          	sd	a4,-48(s0)
    80000bb4:	639c                	ld	a5,0(a5)
    80000bb6:	853e                	mv	a0,a5
    80000bb8:	00000097          	auipc	ra,0x0
    80000bbc:	e04080e7          	jalr	-508(ra) # 800009bc <printptr>
      break;
    80000bc0:	a8b5                	j	80000c3c <printf+0x20a>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80000bc2:	fd043783          	ld	a5,-48(s0)
    80000bc6:	00878713          	addi	a4,a5,8
    80000bca:	fce43823          	sd	a4,-48(s0)
    80000bce:	639c                	ld	a5,0(a5)
    80000bd0:	fef43023          	sd	a5,-32(s0)
    80000bd4:	fe043783          	ld	a5,-32(s0)
    80000bd8:	e79d                	bnez	a5,80000c06 <printf+0x1d4>
        s = "(null)";
    80000bda:	0000c797          	auipc	a5,0xc
    80000bde:	43e78793          	addi	a5,a5,1086 # 8000d018 <etext+0x18>
    80000be2:	fef43023          	sd	a5,-32(s0)
      for(; *s; s++)
    80000be6:	a005                	j	80000c06 <printf+0x1d4>
        consputc(*s);
    80000be8:	fe043783          	ld	a5,-32(s0)
    80000bec:	0007c783          	lbu	a5,0(a5)
    80000bf0:	2781                	sext.w	a5,a5
    80000bf2:	853e                	mv	a0,a5
    80000bf4:	fffff097          	auipc	ra,0xfffff
    80000bf8:	77e080e7          	jalr	1918(ra) # 80000372 <consputc>
      for(; *s; s++)
    80000bfc:	fe043783          	ld	a5,-32(s0)
    80000c00:	0785                	addi	a5,a5,1
    80000c02:	fef43023          	sd	a5,-32(s0)
    80000c06:	fe043783          	ld	a5,-32(s0)
    80000c0a:	0007c783          	lbu	a5,0(a5)
    80000c0e:	ffe9                	bnez	a5,80000be8 <printf+0x1b6>
      break;
    80000c10:	a035                	j	80000c3c <printf+0x20a>
    case '%':
      consputc('%');
    80000c12:	02500513          	li	a0,37
    80000c16:	fffff097          	auipc	ra,0xfffff
    80000c1a:	75c080e7          	jalr	1884(ra) # 80000372 <consputc>
      break;
    80000c1e:	a839                	j	80000c3c <printf+0x20a>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
    80000c20:	02500513          	li	a0,37
    80000c24:	fffff097          	auipc	ra,0xfffff
    80000c28:	74e080e7          	jalr	1870(ra) # 80000372 <consputc>
      consputc(c);
    80000c2c:	fd842783          	lw	a5,-40(s0)
    80000c30:	853e                	mv	a0,a5
    80000c32:	fffff097          	auipc	ra,0xfffff
    80000c36:	740080e7          	jalr	1856(ra) # 80000372 <consputc>
      break;
    80000c3a:	0001                	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000c3c:	fec42783          	lw	a5,-20(s0)
    80000c40:	2785                	addiw	a5,a5,1
    80000c42:	fef42623          	sw	a5,-20(s0)
    80000c46:	fec42783          	lw	a5,-20(s0)
    80000c4a:	fc843703          	ld	a4,-56(s0)
    80000c4e:	97ba                	add	a5,a5,a4
    80000c50:	0007c783          	lbu	a5,0(a5)
    80000c54:	fcf42c23          	sw	a5,-40(s0)
    80000c58:	fd842783          	lw	a5,-40(s0)
    80000c5c:	2781                	sext.w	a5,a5
    80000c5e:	e40794e3          	bnez	a5,80000aa6 <printf+0x74>
    80000c62:	a011                	j	80000c66 <printf+0x234>
      break;
    80000c64:	0001                	nop
    }
  }
  va_end(ap);

  if(locking)
    80000c66:	fdc42783          	lw	a5,-36(s0)
    80000c6a:	2781                	sext.w	a5,a5
    80000c6c:	cb89                	beqz	a5,80000c7e <printf+0x24c>
    release(&pr.lock);
    80000c6e:	00018517          	auipc	a0,0x18
    80000c72:	c6a50513          	addi	a0,a0,-918 # 800188d8 <pr>
    80000c76:	00000097          	auipc	ra,0x0
    80000c7a:	71e080e7          	jalr	1822(ra) # 80001394 <release>
}
    80000c7e:	0001                	nop
    80000c80:	70e2                	ld	ra,56(sp)
    80000c82:	7442                	ld	s0,48(sp)
    80000c84:	6109                	addi	sp,sp,128
    80000c86:	8082                	ret

0000000080000c88 <panic>:

void
panic(char *s)
{
    80000c88:	1101                	addi	sp,sp,-32
    80000c8a:	ec06                	sd	ra,24(sp)
    80000c8c:	e822                	sd	s0,16(sp)
    80000c8e:	1000                	addi	s0,sp,32
    80000c90:	fea43423          	sd	a0,-24(s0)
  pr.locking = 0;
    80000c94:	00018797          	auipc	a5,0x18
    80000c98:	c4478793          	addi	a5,a5,-956 # 800188d8 <pr>
    80000c9c:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80000ca0:	0000c517          	auipc	a0,0xc
    80000ca4:	38050513          	addi	a0,a0,896 # 8000d020 <etext+0x20>
    80000ca8:	00000097          	auipc	ra,0x0
    80000cac:	d8a080e7          	jalr	-630(ra) # 80000a32 <printf>
  printf(s);
    80000cb0:	fe843503          	ld	a0,-24(s0)
    80000cb4:	00000097          	auipc	ra,0x0
    80000cb8:	d7e080e7          	jalr	-642(ra) # 80000a32 <printf>
  printf("\n");
    80000cbc:	0000c517          	auipc	a0,0xc
    80000cc0:	36c50513          	addi	a0,a0,876 # 8000d028 <etext+0x28>
    80000cc4:	00000097          	auipc	ra,0x0
    80000cc8:	d6e080e7          	jalr	-658(ra) # 80000a32 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000ccc:	00010797          	auipc	a5,0x10
    80000cd0:	9f478793          	addi	a5,a5,-1548 # 800106c0 <panicked>
    80000cd4:	4705                	li	a4,1
    80000cd6:	c398                	sw	a4,0(a5)
  for(;;)
    80000cd8:	0001                	nop
    80000cda:	bffd                	j	80000cd8 <panic+0x50>

0000000080000cdc <panic_concat>:
    ;
}

void
panic_concat(int count, ...)
{
    80000cdc:	7119                	addi	sp,sp,-128
    80000cde:	fc06                	sd	ra,56(sp)
    80000ce0:	f822                	sd	s0,48(sp)
    80000ce2:	0080                	addi	s0,sp,64
    80000ce4:	e40c                	sd	a1,8(s0)
    80000ce6:	e810                	sd	a2,16(s0)
    80000ce8:	ec14                	sd	a3,24(s0)
    80000cea:	f018                	sd	a4,32(s0)
    80000cec:	f41c                	sd	a5,40(s0)
    80000cee:	03043823          	sd	a6,48(s0)
    80000cf2:	03143c23          	sd	a7,56(s0)
    80000cf6:	87aa                	mv	a5,a0
    80000cf8:	fcf42623          	sw	a5,-52(s0)
  pr.locking = 0;
    80000cfc:	00018797          	auipc	a5,0x18
    80000d00:	bdc78793          	addi	a5,a5,-1060 # 800188d8 <pr>
    80000d04:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80000d08:	0000c517          	auipc	a0,0xc
    80000d0c:	31850513          	addi	a0,a0,792 # 8000d020 <etext+0x20>
    80000d10:	00000097          	auipc	ra,0x0
    80000d14:	d22080e7          	jalr	-734(ra) # 80000a32 <printf>
  va_list ap;
  va_start(ap, count);
    80000d18:	04040793          	addi	a5,s0,64
    80000d1c:	fcf43023          	sd	a5,-64(s0)
    80000d20:	fc043783          	ld	a5,-64(s0)
    80000d24:	fc878793          	addi	a5,a5,-56
    80000d28:	fcf43c23          	sd	a5,-40(s0)
  for(int i = 0; i < count; i++){
    80000d2c:	fe042623          	sw	zero,-20(s0)
    80000d30:	a02d                	j	80000d5a <panic_concat+0x7e>
    char *s = va_arg(ap, char*);
    80000d32:	fd843783          	ld	a5,-40(s0)
    80000d36:	00878713          	addi	a4,a5,8
    80000d3a:	fce43c23          	sd	a4,-40(s0)
    80000d3e:	639c                	ld	a5,0(a5)
    80000d40:	fef43023          	sd	a5,-32(s0)
    printf(s);
    80000d44:	fe043503          	ld	a0,-32(s0)
    80000d48:	00000097          	auipc	ra,0x0
    80000d4c:	cea080e7          	jalr	-790(ra) # 80000a32 <printf>
  for(int i = 0; i < count; i++){
    80000d50:	fec42783          	lw	a5,-20(s0)
    80000d54:	2785                	addiw	a5,a5,1
    80000d56:	fef42623          	sw	a5,-20(s0)
    80000d5a:	fec42783          	lw	a5,-20(s0)
    80000d5e:	873e                	mv	a4,a5
    80000d60:	fcc42783          	lw	a5,-52(s0)
    80000d64:	2701                	sext.w	a4,a4
    80000d66:	2781                	sext.w	a5,a5
    80000d68:	fcf745e3          	blt	a4,a5,80000d32 <panic_concat+0x56>
  }
  va_end(ap);
  printf("\n");
    80000d6c:	0000c517          	auipc	a0,0xc
    80000d70:	2bc50513          	addi	a0,a0,700 # 8000d028 <etext+0x28>
    80000d74:	00000097          	auipc	ra,0x0
    80000d78:	cbe080e7          	jalr	-834(ra) # 80000a32 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000d7c:	00010797          	auipc	a5,0x10
    80000d80:	94478793          	addi	a5,a5,-1724 # 800106c0 <panicked>
    80000d84:	4705                	li	a4,1
    80000d86:	c398                	sw	a4,0(a5)
  for(;;)
    80000d88:	0001                	nop
    80000d8a:	bffd                	j	80000d88 <panic_concat+0xac>

0000000080000d8c <printfinit>:
    ;
}

void
printfinit(void)
{
    80000d8c:	1141                	addi	sp,sp,-16
    80000d8e:	e406                	sd	ra,8(sp)
    80000d90:	e022                	sd	s0,0(sp)
    80000d92:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80000d94:	0000c597          	auipc	a1,0xc
    80000d98:	29c58593          	addi	a1,a1,668 # 8000d030 <etext+0x30>
    80000d9c:	00018517          	auipc	a0,0x18
    80000da0:	b3c50513          	addi	a0,a0,-1220 # 800188d8 <pr>
    80000da4:	00000097          	auipc	ra,0x0
    80000da8:	55c080e7          	jalr	1372(ra) # 80001300 <initlock>
  pr.locking = 1;
    80000dac:	00018797          	auipc	a5,0x18
    80000db0:	b2c78793          	addi	a5,a5,-1236 # 800188d8 <pr>
    80000db4:	4705                	li	a4,1
    80000db6:	cf98                	sw	a4,24(a5)
}
    80000db8:	0001                	nop
    80000dba:	60a2                	ld	ra,8(sp)
    80000dbc:	6402                	ld	s0,0(sp)
    80000dbe:	0141                	addi	sp,sp,16
    80000dc0:	8082                	ret

0000000080000dc2 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000dc2:	1141                	addi	sp,sp,-16
    80000dc4:	e406                	sd	ra,8(sp)
    80000dc6:	e022                	sd	s0,0(sp)
    80000dc8:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000dca:	100007b7          	lui	a5,0x10000
    80000dce:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80000dd0:	00078023          	sb	zero,0(a5)

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80000dd4:	100007b7          	lui	a5,0x10000
    80000dd8:	078d                	addi	a5,a5,3 # 10000003 <_entry-0x6ffffffd>
    80000dda:	f8000713          	li	a4,-128
    80000dde:	00e78023          	sb	a4,0(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000de2:	100007b7          	lui	a5,0x10000
    80000de6:	470d                	li	a4,3
    80000de8:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000dec:	100007b7          	lui	a5,0x10000
    80000df0:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80000df2:	00078023          	sb	zero,0(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000df6:	100007b7          	lui	a5,0x10000
    80000dfa:	078d                	addi	a5,a5,3 # 10000003 <_entry-0x6ffffffd>
    80000dfc:	470d                	li	a4,3
    80000dfe:	00e78023          	sb	a4,0(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000e02:	100007b7          	lui	a5,0x10000
    80000e06:	0789                	addi	a5,a5,2 # 10000002 <_entry-0x6ffffffe>
    80000e08:	471d                	li	a4,7
    80000e0a:	00e78023          	sb	a4,0(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000e0e:	100007b7          	lui	a5,0x10000
    80000e12:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80000e14:	470d                	li	a4,3
    80000e16:	00e78023          	sb	a4,0(a5)

  initlock(&uart_tx_lock, "uart");
    80000e1a:	0000c597          	auipc	a1,0xc
    80000e1e:	21e58593          	addi	a1,a1,542 # 8000d038 <etext+0x38>
    80000e22:	00018517          	auipc	a0,0x18
    80000e26:	ad650513          	addi	a0,a0,-1322 # 800188f8 <uart_tx_lock>
    80000e2a:	00000097          	auipc	ra,0x0
    80000e2e:	4d6080e7          	jalr	1238(ra) # 80001300 <initlock>
}
    80000e32:	0001                	nop
    80000e34:	60a2                	ld	ra,8(sp)
    80000e36:	6402                	ld	s0,0(sp)
    80000e38:	0141                	addi	sp,sp,16
    80000e3a:	8082                	ret

0000000080000e3c <uartputc>:
// because it may block, it can't be called
// from interrupts; it's only suitable for use
// by write().
void
uartputc(int c)
{
    80000e3c:	1101                	addi	sp,sp,-32
    80000e3e:	ec06                	sd	ra,24(sp)
    80000e40:	e822                	sd	s0,16(sp)
    80000e42:	1000                	addi	s0,sp,32
    80000e44:	87aa                	mv	a5,a0
    80000e46:	fef42623          	sw	a5,-20(s0)
  acquire(&uart_tx_lock);
    80000e4a:	00018517          	auipc	a0,0x18
    80000e4e:	aae50513          	addi	a0,a0,-1362 # 800188f8 <uart_tx_lock>
    80000e52:	00000097          	auipc	ra,0x0
    80000e56:	4de080e7          	jalr	1246(ra) # 80001330 <acquire>

  if(panicked){
    80000e5a:	00010797          	auipc	a5,0x10
    80000e5e:	86678793          	addi	a5,a5,-1946 # 800106c0 <panicked>
    80000e62:	439c                	lw	a5,0(a5)
    80000e64:	2781                	sext.w	a5,a5
    80000e66:	cf99                	beqz	a5,80000e84 <uartputc+0x48>
    for(;;)
    80000e68:	0001                	nop
    80000e6a:	bffd                	j	80000e68 <uartputc+0x2c>
      ;
  }
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    // buffer is full.
    // wait for uartstart() to open up space in the buffer.
    sleep(&uart_tx_r, &uart_tx_lock);
    80000e6c:	00018597          	auipc	a1,0x18
    80000e70:	a8c58593          	addi	a1,a1,-1396 # 800188f8 <uart_tx_lock>
    80000e74:	00010517          	auipc	a0,0x10
    80000e78:	85c50513          	addi	a0,a0,-1956 # 800106d0 <uart_tx_r>
    80000e7c:	00003097          	auipc	ra,0x3
    80000e80:	84c080e7          	jalr	-1972(ra) # 800036c8 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000e84:	00010797          	auipc	a5,0x10
    80000e88:	84c78793          	addi	a5,a5,-1972 # 800106d0 <uart_tx_r>
    80000e8c:	639c                	ld	a5,0(a5)
    80000e8e:	02078713          	addi	a4,a5,32
    80000e92:	00010797          	auipc	a5,0x10
    80000e96:	83678793          	addi	a5,a5,-1994 # 800106c8 <uart_tx_w>
    80000e9a:	639c                	ld	a5,0(a5)
    80000e9c:	fcf708e3          	beq	a4,a5,80000e6c <uartputc+0x30>
  }
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000ea0:	00010797          	auipc	a5,0x10
    80000ea4:	82878793          	addi	a5,a5,-2008 # 800106c8 <uart_tx_w>
    80000ea8:	639c                	ld	a5,0(a5)
    80000eaa:	8bfd                	andi	a5,a5,31
    80000eac:	fec42703          	lw	a4,-20(s0)
    80000eb0:	0ff77713          	zext.b	a4,a4
    80000eb4:	00018697          	auipc	a3,0x18
    80000eb8:	a5c68693          	addi	a3,a3,-1444 # 80018910 <uart_tx_buf>
    80000ebc:	97b6                	add	a5,a5,a3
    80000ebe:	00e78023          	sb	a4,0(a5)
  uart_tx_w += 1;
    80000ec2:	00010797          	auipc	a5,0x10
    80000ec6:	80678793          	addi	a5,a5,-2042 # 800106c8 <uart_tx_w>
    80000eca:	639c                	ld	a5,0(a5)
    80000ecc:	00178713          	addi	a4,a5,1
    80000ed0:	0000f797          	auipc	a5,0xf
    80000ed4:	7f878793          	addi	a5,a5,2040 # 800106c8 <uart_tx_w>
    80000ed8:	e398                	sd	a4,0(a5)
  uartstart();
    80000eda:	00000097          	auipc	ra,0x0
    80000ede:	086080e7          	jalr	134(ra) # 80000f60 <uartstart>
  release(&uart_tx_lock);
    80000ee2:	00018517          	auipc	a0,0x18
    80000ee6:	a1650513          	addi	a0,a0,-1514 # 800188f8 <uart_tx_lock>
    80000eea:	00000097          	auipc	ra,0x0
    80000eee:	4aa080e7          	jalr	1194(ra) # 80001394 <release>
}
    80000ef2:	0001                	nop
    80000ef4:	60e2                	ld	ra,24(sp)
    80000ef6:	6442                	ld	s0,16(sp)
    80000ef8:	6105                	addi	sp,sp,32
    80000efa:	8082                	ret

0000000080000efc <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000efc:	1101                	addi	sp,sp,-32
    80000efe:	ec06                	sd	ra,24(sp)
    80000f00:	e822                	sd	s0,16(sp)
    80000f02:	1000                	addi	s0,sp,32
    80000f04:	87aa                	mv	a5,a0
    80000f06:	fef42623          	sw	a5,-20(s0)
  push_off();
    80000f0a:	00000097          	auipc	ra,0x0
    80000f0e:	524080e7          	jalr	1316(ra) # 8000142e <push_off>

  if(panicked){
    80000f12:	0000f797          	auipc	a5,0xf
    80000f16:	7ae78793          	addi	a5,a5,1966 # 800106c0 <panicked>
    80000f1a:	439c                	lw	a5,0(a5)
    80000f1c:	2781                	sext.w	a5,a5
    80000f1e:	c399                	beqz	a5,80000f24 <uartputc_sync+0x28>
    for(;;)
    80000f20:	0001                	nop
    80000f22:	bffd                	j	80000f20 <uartputc_sync+0x24>
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000f24:	0001                	nop
    80000f26:	100007b7          	lui	a5,0x10000
    80000f2a:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80000f2c:	0007c783          	lbu	a5,0(a5)
    80000f30:	0ff7f793          	zext.b	a5,a5
    80000f34:	2781                	sext.w	a5,a5
    80000f36:	0207f793          	andi	a5,a5,32
    80000f3a:	2781                	sext.w	a5,a5
    80000f3c:	d7ed                	beqz	a5,80000f26 <uartputc_sync+0x2a>
    ;
  WriteReg(THR, c);
    80000f3e:	100007b7          	lui	a5,0x10000
    80000f42:	fec42703          	lw	a4,-20(s0)
    80000f46:	0ff77713          	zext.b	a4,a4
    80000f4a:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000f4e:	00000097          	auipc	ra,0x0
    80000f52:	538080e7          	jalr	1336(ra) # 80001486 <pop_off>
}
    80000f56:	0001                	nop
    80000f58:	60e2                	ld	ra,24(sp)
    80000f5a:	6442                	ld	s0,16(sp)
    80000f5c:	6105                	addi	sp,sp,32
    80000f5e:	8082                	ret

0000000080000f60 <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void
uartstart()
{
    80000f60:	1101                	addi	sp,sp,-32
    80000f62:	ec06                	sd	ra,24(sp)
    80000f64:	e822                	sd	s0,16(sp)
    80000f66:	1000                	addi	s0,sp,32
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000f68:	0000f797          	auipc	a5,0xf
    80000f6c:	76078793          	addi	a5,a5,1888 # 800106c8 <uart_tx_w>
    80000f70:	6398                	ld	a4,0(a5)
    80000f72:	0000f797          	auipc	a5,0xf
    80000f76:	75e78793          	addi	a5,a5,1886 # 800106d0 <uart_tx_r>
    80000f7a:	639c                	ld	a5,0(a5)
    80000f7c:	06f70a63          	beq	a4,a5,80000ff0 <uartstart+0x90>
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000f80:	100007b7          	lui	a5,0x10000
    80000f84:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80000f86:	0007c783          	lbu	a5,0(a5)
    80000f8a:	0ff7f793          	zext.b	a5,a5
    80000f8e:	2781                	sext.w	a5,a5
    80000f90:	0207f793          	andi	a5,a5,32
    80000f94:	2781                	sext.w	a5,a5
    80000f96:	cfb9                	beqz	a5,80000ff4 <uartstart+0x94>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000f98:	0000f797          	auipc	a5,0xf
    80000f9c:	73878793          	addi	a5,a5,1848 # 800106d0 <uart_tx_r>
    80000fa0:	639c                	ld	a5,0(a5)
    80000fa2:	8bfd                	andi	a5,a5,31
    80000fa4:	00018717          	auipc	a4,0x18
    80000fa8:	96c70713          	addi	a4,a4,-1684 # 80018910 <uart_tx_buf>
    80000fac:	97ba                	add	a5,a5,a4
    80000fae:	0007c783          	lbu	a5,0(a5)
    80000fb2:	fef42623          	sw	a5,-20(s0)
    uart_tx_r += 1;
    80000fb6:	0000f797          	auipc	a5,0xf
    80000fba:	71a78793          	addi	a5,a5,1818 # 800106d0 <uart_tx_r>
    80000fbe:	639c                	ld	a5,0(a5)
    80000fc0:	00178713          	addi	a4,a5,1
    80000fc4:	0000f797          	auipc	a5,0xf
    80000fc8:	70c78793          	addi	a5,a5,1804 # 800106d0 <uart_tx_r>
    80000fcc:	e398                	sd	a4,0(a5)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000fce:	0000f517          	auipc	a0,0xf
    80000fd2:	70250513          	addi	a0,a0,1794 # 800106d0 <uart_tx_r>
    80000fd6:	00002097          	auipc	ra,0x2
    80000fda:	76e080e7          	jalr	1902(ra) # 80003744 <wakeup>
    
    WriteReg(THR, c);
    80000fde:	100007b7          	lui	a5,0x10000
    80000fe2:	fec42703          	lw	a4,-20(s0)
    80000fe6:	0ff77713          	zext.b	a4,a4
    80000fea:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>
  while(1){
    80000fee:	bfad                	j	80000f68 <uartstart+0x8>
      return;
    80000ff0:	0001                	nop
    80000ff2:	a011                	j	80000ff6 <uartstart+0x96>
      return;
    80000ff4:	0001                	nop
  }
}
    80000ff6:	60e2                	ld	ra,24(sp)
    80000ff8:	6442                	ld	s0,16(sp)
    80000ffa:	6105                	addi	sp,sp,32
    80000ffc:	8082                	ret

0000000080000ffe <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000ffe:	1141                	addi	sp,sp,-16
    80001000:	e422                	sd	s0,8(sp)
    80001002:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80001004:	100007b7          	lui	a5,0x10000
    80001008:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    8000100a:	0007c783          	lbu	a5,0(a5)
    8000100e:	0ff7f793          	zext.b	a5,a5
    80001012:	2781                	sext.w	a5,a5
    80001014:	8b85                	andi	a5,a5,1
    80001016:	2781                	sext.w	a5,a5
    80001018:	cb89                	beqz	a5,8000102a <uartgetc+0x2c>
    // input data is ready.
    return ReadReg(RHR);
    8000101a:	100007b7          	lui	a5,0x10000
    8000101e:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80001022:	0ff7f793          	zext.b	a5,a5
    80001026:	2781                	sext.w	a5,a5
    80001028:	a011                	j	8000102c <uartgetc+0x2e>
  } else {
    return -1;
    8000102a:	57fd                	li	a5,-1
  }
}
    8000102c:	853e                	mv	a0,a5
    8000102e:	6422                	ld	s0,8(sp)
    80001030:	0141                	addi	sp,sp,16
    80001032:	8082                	ret

0000000080001034 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80001034:	1101                	addi	sp,sp,-32
    80001036:	ec06                	sd	ra,24(sp)
    80001038:	e822                	sd	s0,16(sp)
    8000103a:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    8000103c:	00000097          	auipc	ra,0x0
    80001040:	fc2080e7          	jalr	-62(ra) # 80000ffe <uartgetc>
    80001044:	87aa                	mv	a5,a0
    80001046:	fef42623          	sw	a5,-20(s0)
    if(c == -1)
    8000104a:	fec42783          	lw	a5,-20(s0)
    8000104e:	0007871b          	sext.w	a4,a5
    80001052:	57fd                	li	a5,-1
    80001054:	00f70a63          	beq	a4,a5,80001068 <uartintr+0x34>
      break;
    consoleintr(c);
    80001058:	fec42783          	lw	a5,-20(s0)
    8000105c:	853e                	mv	a0,a5
    8000105e:	fffff097          	auipc	ra,0xfffff
    80001062:	596080e7          	jalr	1430(ra) # 800005f4 <consoleintr>
  while(1){
    80001066:	bfd9                	j	8000103c <uartintr+0x8>
      break;
    80001068:	0001                	nop
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    8000106a:	00018517          	auipc	a0,0x18
    8000106e:	88e50513          	addi	a0,a0,-1906 # 800188f8 <uart_tx_lock>
    80001072:	00000097          	auipc	ra,0x0
    80001076:	2be080e7          	jalr	702(ra) # 80001330 <acquire>
  uartstart();
    8000107a:	00000097          	auipc	ra,0x0
    8000107e:	ee6080e7          	jalr	-282(ra) # 80000f60 <uartstart>
  release(&uart_tx_lock);
    80001082:	00018517          	auipc	a0,0x18
    80001086:	87650513          	addi	a0,a0,-1930 # 800188f8 <uart_tx_lock>
    8000108a:	00000097          	auipc	ra,0x0
    8000108e:	30a080e7          	jalr	778(ra) # 80001394 <release>
}
    80001092:	0001                	nop
    80001094:	60e2                	ld	ra,24(sp)
    80001096:	6442                	ld	s0,16(sp)
    80001098:	6105                	addi	sp,sp,32
    8000109a:	8082                	ret

000000008000109c <kinit>:
  struct run *freelist;
} kmem;

void
kinit()
{
    8000109c:	1141                	addi	sp,sp,-16
    8000109e:	e406                	sd	ra,8(sp)
    800010a0:	e022                	sd	s0,0(sp)
    800010a2:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800010a4:	0000c597          	auipc	a1,0xc
    800010a8:	f9c58593          	addi	a1,a1,-100 # 8000d040 <etext+0x40>
    800010ac:	00018517          	auipc	a0,0x18
    800010b0:	88450513          	addi	a0,a0,-1916 # 80018930 <kmem>
    800010b4:	00000097          	auipc	ra,0x0
    800010b8:	24c080e7          	jalr	588(ra) # 80001300 <initlock>
  freerange(end, (void*)PHYSTOP);
    800010bc:	08100793          	li	a5,129
    800010c0:	01879593          	slli	a1,a5,0x18
    800010c4:	0002a517          	auipc	a0,0x2a
    800010c8:	c4c50513          	addi	a0,a0,-948 # 8002ad10 <end>
    800010cc:	00000097          	auipc	ra,0x0
    800010d0:	012080e7          	jalr	18(ra) # 800010de <freerange>
}
    800010d4:	0001                	nop
    800010d6:	60a2                	ld	ra,8(sp)
    800010d8:	6402                	ld	s0,0(sp)
    800010da:	0141                	addi	sp,sp,16
    800010dc:	8082                	ret

00000000800010de <freerange>:

void
freerange(void *pa_start, void *pa_end)
{
    800010de:	7179                	addi	sp,sp,-48
    800010e0:	f406                	sd	ra,40(sp)
    800010e2:	f022                	sd	s0,32(sp)
    800010e4:	1800                	addi	s0,sp,48
    800010e6:	fca43c23          	sd	a0,-40(s0)
    800010ea:	fcb43823          	sd	a1,-48(s0)
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
    800010ee:	fd843703          	ld	a4,-40(s0)
    800010f2:	6785                	lui	a5,0x1
    800010f4:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800010f6:	973e                	add	a4,a4,a5
    800010f8:	77fd                	lui	a5,0xfffff
    800010fa:	8ff9                	and	a5,a5,a4
    800010fc:	fef43423          	sd	a5,-24(s0)
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80001100:	a829                	j	8000111a <freerange+0x3c>
    kfree(p);
    80001102:	fe843503          	ld	a0,-24(s0)
    80001106:	00000097          	auipc	ra,0x0
    8000110a:	030080e7          	jalr	48(ra) # 80001136 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000110e:	fe843703          	ld	a4,-24(s0)
    80001112:	6785                	lui	a5,0x1
    80001114:	97ba                	add	a5,a5,a4
    80001116:	fef43423          	sd	a5,-24(s0)
    8000111a:	fe843703          	ld	a4,-24(s0)
    8000111e:	6785                	lui	a5,0x1
    80001120:	97ba                	add	a5,a5,a4
    80001122:	fd043703          	ld	a4,-48(s0)
    80001126:	fcf77ee3          	bgeu	a4,a5,80001102 <freerange+0x24>
}
    8000112a:	0001                	nop
    8000112c:	0001                	nop
    8000112e:	70a2                	ld	ra,40(sp)
    80001130:	7402                	ld	s0,32(sp)
    80001132:	6145                	addi	sp,sp,48
    80001134:	8082                	ret

0000000080001136 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80001136:	7179                	addi	sp,sp,-48
    80001138:	f406                	sd	ra,40(sp)
    8000113a:	f022                	sd	s0,32(sp)
    8000113c:	1800                	addi	s0,sp,48
    8000113e:	fca43c23          	sd	a0,-40(s0)
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80001142:	fd843703          	ld	a4,-40(s0)
    80001146:	6785                	lui	a5,0x1
    80001148:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000114a:	8ff9                	and	a5,a5,a4
    8000114c:	e385                	bnez	a5,8000116c <kfree+0x36>
    8000114e:	fd843703          	ld	a4,-40(s0)
    80001152:	0002a797          	auipc	a5,0x2a
    80001156:	bbe78793          	addi	a5,a5,-1090 # 8002ad10 <end>
    8000115a:	00f76963          	bltu	a4,a5,8000116c <kfree+0x36>
    8000115e:	fd843703          	ld	a4,-40(s0)
    80001162:	08100793          	li	a5,129
    80001166:	07e2                	slli	a5,a5,0x18
    80001168:	00f76a63          	bltu	a4,a5,8000117c <kfree+0x46>
    panic("kfree");
    8000116c:	0000c517          	auipc	a0,0xc
    80001170:	edc50513          	addi	a0,a0,-292 # 8000d048 <etext+0x48>
    80001174:	00000097          	auipc	ra,0x0
    80001178:	b14080e7          	jalr	-1260(ra) # 80000c88 <panic>

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    8000117c:	6605                	lui	a2,0x1
    8000117e:	4585                	li	a1,1
    80001180:	fd843503          	ld	a0,-40(s0)
    80001184:	00000097          	auipc	ra,0x0
    80001188:	380080e7          	jalr	896(ra) # 80001504 <memset>

  r = (struct run*)pa;
    8000118c:	fd843783          	ld	a5,-40(s0)
    80001190:	fef43423          	sd	a5,-24(s0)

  acquire(&kmem.lock);
    80001194:	00017517          	auipc	a0,0x17
    80001198:	79c50513          	addi	a0,a0,1948 # 80018930 <kmem>
    8000119c:	00000097          	auipc	ra,0x0
    800011a0:	194080e7          	jalr	404(ra) # 80001330 <acquire>
  r->next = kmem.freelist;
    800011a4:	00017797          	auipc	a5,0x17
    800011a8:	78c78793          	addi	a5,a5,1932 # 80018930 <kmem>
    800011ac:	6f98                	ld	a4,24(a5)
    800011ae:	fe843783          	ld	a5,-24(s0)
    800011b2:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    800011b4:	00017797          	auipc	a5,0x17
    800011b8:	77c78793          	addi	a5,a5,1916 # 80018930 <kmem>
    800011bc:	fe843703          	ld	a4,-24(s0)
    800011c0:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    800011c2:	00017517          	auipc	a0,0x17
    800011c6:	76e50513          	addi	a0,a0,1902 # 80018930 <kmem>
    800011ca:	00000097          	auipc	ra,0x0
    800011ce:	1ca080e7          	jalr	458(ra) # 80001394 <release>
}
    800011d2:	0001                	nop
    800011d4:	70a2                	ld	ra,40(sp)
    800011d6:	7402                	ld	s0,32(sp)
    800011d8:	6145                	addi	sp,sp,48
    800011da:	8082                	ret

00000000800011dc <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    800011dc:	1101                	addi	sp,sp,-32
    800011de:	ec06                	sd	ra,24(sp)
    800011e0:	e822                	sd	s0,16(sp)
    800011e2:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    800011e4:	00017517          	auipc	a0,0x17
    800011e8:	74c50513          	addi	a0,a0,1868 # 80018930 <kmem>
    800011ec:	00000097          	auipc	ra,0x0
    800011f0:	144080e7          	jalr	324(ra) # 80001330 <acquire>
  r = kmem.freelist;
    800011f4:	00017797          	auipc	a5,0x17
    800011f8:	73c78793          	addi	a5,a5,1852 # 80018930 <kmem>
    800011fc:	6f9c                	ld	a5,24(a5)
    800011fe:	fef43423          	sd	a5,-24(s0)
  if(r)
    80001202:	fe843783          	ld	a5,-24(s0)
    80001206:	cb89                	beqz	a5,80001218 <kalloc+0x3c>
    kmem.freelist = r->next;
    80001208:	fe843783          	ld	a5,-24(s0)
    8000120c:	6398                	ld	a4,0(a5)
    8000120e:	00017797          	auipc	a5,0x17
    80001212:	72278793          	addi	a5,a5,1826 # 80018930 <kmem>
    80001216:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001218:	00017517          	auipc	a0,0x17
    8000121c:	71850513          	addi	a0,a0,1816 # 80018930 <kmem>
    80001220:	00000097          	auipc	ra,0x0
    80001224:	174080e7          	jalr	372(ra) # 80001394 <release>

  if(r)
    80001228:	fe843783          	ld	a5,-24(s0)
    8000122c:	cb89                	beqz	a5,8000123e <kalloc+0x62>
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000122e:	6605                	lui	a2,0x1
    80001230:	4595                	li	a1,5
    80001232:	fe843503          	ld	a0,-24(s0)
    80001236:	00000097          	auipc	ra,0x0
    8000123a:	2ce080e7          	jalr	718(ra) # 80001504 <memset>
  return (void*)r;
    8000123e:	fe843783          	ld	a5,-24(s0)
}
    80001242:	853e                	mv	a0,a5
    80001244:	60e2                	ld	ra,24(sp)
    80001246:	6442                	ld	s0,16(sp)
    80001248:	6105                	addi	sp,sp,32
    8000124a:	8082                	ret

000000008000124c <r_sstatus>:
{
    8000124c:	1101                	addi	sp,sp,-32
    8000124e:	ec22                	sd	s0,24(sp)
    80001250:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001252:	100027f3          	csrr	a5,sstatus
    80001256:	fef43423          	sd	a5,-24(s0)
  return x;
    8000125a:	fe843783          	ld	a5,-24(s0)
}
    8000125e:	853e                	mv	a0,a5
    80001260:	6462                	ld	s0,24(sp)
    80001262:	6105                	addi	sp,sp,32
    80001264:	8082                	ret

0000000080001266 <w_sstatus>:
{
    80001266:	1101                	addi	sp,sp,-32
    80001268:	ec22                	sd	s0,24(sp)
    8000126a:	1000                	addi	s0,sp,32
    8000126c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001270:	fe843783          	ld	a5,-24(s0)
    80001274:	10079073          	csrw	sstatus,a5
}
    80001278:	0001                	nop
    8000127a:	6462                	ld	s0,24(sp)
    8000127c:	6105                	addi	sp,sp,32
    8000127e:	8082                	ret

0000000080001280 <intr_on>:
{
    80001280:	1141                	addi	sp,sp,-16
    80001282:	e406                	sd	ra,8(sp)
    80001284:	e022                	sd	s0,0(sp)
    80001286:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001288:	00000097          	auipc	ra,0x0
    8000128c:	fc4080e7          	jalr	-60(ra) # 8000124c <r_sstatus>
    80001290:	87aa                	mv	a5,a0
    80001292:	0027e793          	ori	a5,a5,2
    80001296:	853e                	mv	a0,a5
    80001298:	00000097          	auipc	ra,0x0
    8000129c:	fce080e7          	jalr	-50(ra) # 80001266 <w_sstatus>
}
    800012a0:	0001                	nop
    800012a2:	60a2                	ld	ra,8(sp)
    800012a4:	6402                	ld	s0,0(sp)
    800012a6:	0141                	addi	sp,sp,16
    800012a8:	8082                	ret

00000000800012aa <intr_off>:
{
    800012aa:	1141                	addi	sp,sp,-16
    800012ac:	e406                	sd	ra,8(sp)
    800012ae:	e022                	sd	s0,0(sp)
    800012b0:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800012b2:	00000097          	auipc	ra,0x0
    800012b6:	f9a080e7          	jalr	-102(ra) # 8000124c <r_sstatus>
    800012ba:	87aa                	mv	a5,a0
    800012bc:	9bf5                	andi	a5,a5,-3
    800012be:	853e                	mv	a0,a5
    800012c0:	00000097          	auipc	ra,0x0
    800012c4:	fa6080e7          	jalr	-90(ra) # 80001266 <w_sstatus>
}
    800012c8:	0001                	nop
    800012ca:	60a2                	ld	ra,8(sp)
    800012cc:	6402                	ld	s0,0(sp)
    800012ce:	0141                	addi	sp,sp,16
    800012d0:	8082                	ret

00000000800012d2 <intr_get>:
{
    800012d2:	1101                	addi	sp,sp,-32
    800012d4:	ec06                	sd	ra,24(sp)
    800012d6:	e822                	sd	s0,16(sp)
    800012d8:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800012da:	00000097          	auipc	ra,0x0
    800012de:	f72080e7          	jalr	-142(ra) # 8000124c <r_sstatus>
    800012e2:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800012e6:	fe843783          	ld	a5,-24(s0)
    800012ea:	8b89                	andi	a5,a5,2
    800012ec:	00f037b3          	snez	a5,a5
    800012f0:	0ff7f793          	zext.b	a5,a5
    800012f4:	2781                	sext.w	a5,a5
}
    800012f6:	853e                	mv	a0,a5
    800012f8:	60e2                	ld	ra,24(sp)
    800012fa:	6442                	ld	s0,16(sp)
    800012fc:	6105                	addi	sp,sp,32
    800012fe:	8082                	ret

0000000080001300 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80001300:	1101                	addi	sp,sp,-32
    80001302:	ec22                	sd	s0,24(sp)
    80001304:	1000                	addi	s0,sp,32
    80001306:	fea43423          	sd	a0,-24(s0)
    8000130a:	feb43023          	sd	a1,-32(s0)
  lk->name = name;
    8000130e:	fe843783          	ld	a5,-24(s0)
    80001312:	fe043703          	ld	a4,-32(s0)
    80001316:	e798                	sd	a4,8(a5)
  lk->locked = 0;
    80001318:	fe843783          	ld	a5,-24(s0)
    8000131c:	0007a023          	sw	zero,0(a5)
  lk->cpu = 0;
    80001320:	fe843783          	ld	a5,-24(s0)
    80001324:	0007b823          	sd	zero,16(a5)
}
    80001328:	0001                	nop
    8000132a:	6462                	ld	s0,24(sp)
    8000132c:	6105                	addi	sp,sp,32
    8000132e:	8082                	ret

0000000080001330 <acquire>:

// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
    80001330:	1101                	addi	sp,sp,-32
    80001332:	ec06                	sd	ra,24(sp)
    80001334:	e822                	sd	s0,16(sp)
    80001336:	1000                	addi	s0,sp,32
    80001338:	fea43423          	sd	a0,-24(s0)
  push_off(); // disable interrupts to avoid deadlock.
    8000133c:	00000097          	auipc	ra,0x0
    80001340:	0f2080e7          	jalr	242(ra) # 8000142e <push_off>
  if(holding(lk))
    80001344:	fe843503          	ld	a0,-24(s0)
    80001348:	00000097          	auipc	ra,0x0
    8000134c:	0a2080e7          	jalr	162(ra) # 800013ea <holding>
    80001350:	87aa                	mv	a5,a0
    80001352:	cb89                	beqz	a5,80001364 <acquire+0x34>
    panic("acquire");
    80001354:	0000c517          	auipc	a0,0xc
    80001358:	cfc50513          	addi	a0,a0,-772 # 8000d050 <etext+0x50>
    8000135c:	00000097          	auipc	ra,0x0
    80001360:	92c080e7          	jalr	-1748(ra) # 80000c88 <panic>

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80001364:	0001                	nop
    80001366:	fe843783          	ld	a5,-24(s0)
    8000136a:	4705                	li	a4,1
    8000136c:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    80001370:	0007079b          	sext.w	a5,a4
    80001374:	fbed                	bnez	a5,80001366 <acquire+0x36>

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    80001376:	0330000f          	fence	rw,rw

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
    8000137a:	00001097          	auipc	ra,0x1
    8000137e:	74a080e7          	jalr	1866(ra) # 80002ac4 <mycpu>
    80001382:	872a                	mv	a4,a0
    80001384:	fe843783          	ld	a5,-24(s0)
    80001388:	eb98                	sd	a4,16(a5)
}
    8000138a:	0001                	nop
    8000138c:	60e2                	ld	ra,24(sp)
    8000138e:	6442                	ld	s0,16(sp)
    80001390:	6105                	addi	sp,sp,32
    80001392:	8082                	ret

0000000080001394 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
    80001394:	1101                	addi	sp,sp,-32
    80001396:	ec06                	sd	ra,24(sp)
    80001398:	e822                	sd	s0,16(sp)
    8000139a:	1000                	addi	s0,sp,32
    8000139c:	fea43423          	sd	a0,-24(s0)
  if(!holding(lk))
    800013a0:	fe843503          	ld	a0,-24(s0)
    800013a4:	00000097          	auipc	ra,0x0
    800013a8:	046080e7          	jalr	70(ra) # 800013ea <holding>
    800013ac:	87aa                	mv	a5,a0
    800013ae:	eb89                	bnez	a5,800013c0 <release+0x2c>
    panic("release");
    800013b0:	0000c517          	auipc	a0,0xc
    800013b4:	ca850513          	addi	a0,a0,-856 # 8000d058 <etext+0x58>
    800013b8:	00000097          	auipc	ra,0x0
    800013bc:	8d0080e7          	jalr	-1840(ra) # 80000c88 <panic>

  lk->cpu = 0;
    800013c0:	fe843783          	ld	a5,-24(s0)
    800013c4:	0007b823          	sd	zero,16(a5)
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    800013c8:	0330000f          	fence	rw,rw
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);
    800013cc:	fe843783          	ld	a5,-24(s0)
    800013d0:	0310000f          	fence	rw,w
    800013d4:	0007a023          	sw	zero,0(a5)

  pop_off();
    800013d8:	00000097          	auipc	ra,0x0
    800013dc:	0ae080e7          	jalr	174(ra) # 80001486 <pop_off>
}
    800013e0:	0001                	nop
    800013e2:	60e2                	ld	ra,24(sp)
    800013e4:	6442                	ld	s0,16(sp)
    800013e6:	6105                	addi	sp,sp,32
    800013e8:	8082                	ret

00000000800013ea <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
    800013ea:	7139                	addi	sp,sp,-64
    800013ec:	fc06                	sd	ra,56(sp)
    800013ee:	f822                	sd	s0,48(sp)
    800013f0:	f426                	sd	s1,40(sp)
    800013f2:	0080                	addi	s0,sp,64
    800013f4:	fca43423          	sd	a0,-56(s0)
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800013f8:	fc843783          	ld	a5,-56(s0)
    800013fc:	439c                	lw	a5,0(a5)
    800013fe:	cf89                	beqz	a5,80001418 <holding+0x2e>
    80001400:	fc843783          	ld	a5,-56(s0)
    80001404:	6b84                	ld	s1,16(a5)
    80001406:	00001097          	auipc	ra,0x1
    8000140a:	6be080e7          	jalr	1726(ra) # 80002ac4 <mycpu>
    8000140e:	87aa                	mv	a5,a0
    80001410:	00f49463          	bne	s1,a5,80001418 <holding+0x2e>
    80001414:	4785                	li	a5,1
    80001416:	a011                	j	8000141a <holding+0x30>
    80001418:	4781                	li	a5,0
    8000141a:	fcf42e23          	sw	a5,-36(s0)
  return r;
    8000141e:	fdc42783          	lw	a5,-36(s0)
}
    80001422:	853e                	mv	a0,a5
    80001424:	70e2                	ld	ra,56(sp)
    80001426:	7442                	ld	s0,48(sp)
    80001428:	74a2                	ld	s1,40(sp)
    8000142a:	6121                	addi	sp,sp,64
    8000142c:	8082                	ret

000000008000142e <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000142e:	1101                	addi	sp,sp,-32
    80001430:	ec06                	sd	ra,24(sp)
    80001432:	e822                	sd	s0,16(sp)
    80001434:	1000                	addi	s0,sp,32
  int old = intr_get();
    80001436:	00000097          	auipc	ra,0x0
    8000143a:	e9c080e7          	jalr	-356(ra) # 800012d2 <intr_get>
    8000143e:	87aa                	mv	a5,a0
    80001440:	fef42623          	sw	a5,-20(s0)

  intr_off();
    80001444:	00000097          	auipc	ra,0x0
    80001448:	e66080e7          	jalr	-410(ra) # 800012aa <intr_off>
  if(mycpu()->noff == 0)
    8000144c:	00001097          	auipc	ra,0x1
    80001450:	678080e7          	jalr	1656(ra) # 80002ac4 <mycpu>
    80001454:	87aa                	mv	a5,a0
    80001456:	5fbc                	lw	a5,120(a5)
    80001458:	eb89                	bnez	a5,8000146a <push_off+0x3c>
    mycpu()->intena = old;
    8000145a:	00001097          	auipc	ra,0x1
    8000145e:	66a080e7          	jalr	1642(ra) # 80002ac4 <mycpu>
    80001462:	872a                	mv	a4,a0
    80001464:	fec42783          	lw	a5,-20(s0)
    80001468:	df7c                	sw	a5,124(a4)
  mycpu()->noff += 1;
    8000146a:	00001097          	auipc	ra,0x1
    8000146e:	65a080e7          	jalr	1626(ra) # 80002ac4 <mycpu>
    80001472:	87aa                	mv	a5,a0
    80001474:	5fb8                	lw	a4,120(a5)
    80001476:	2705                	addiw	a4,a4,1
    80001478:	2701                	sext.w	a4,a4
    8000147a:	dfb8                	sw	a4,120(a5)
}
    8000147c:	0001                	nop
    8000147e:	60e2                	ld	ra,24(sp)
    80001480:	6442                	ld	s0,16(sp)
    80001482:	6105                	addi	sp,sp,32
    80001484:	8082                	ret

0000000080001486 <pop_off>:

void
pop_off(void)
{
    80001486:	1101                	addi	sp,sp,-32
    80001488:	ec06                	sd	ra,24(sp)
    8000148a:	e822                	sd	s0,16(sp)
    8000148c:	1000                	addi	s0,sp,32
  struct cpu *c = mycpu();
    8000148e:	00001097          	auipc	ra,0x1
    80001492:	636080e7          	jalr	1590(ra) # 80002ac4 <mycpu>
    80001496:	fea43423          	sd	a0,-24(s0)
  if(intr_get())
    8000149a:	00000097          	auipc	ra,0x0
    8000149e:	e38080e7          	jalr	-456(ra) # 800012d2 <intr_get>
    800014a2:	87aa                	mv	a5,a0
    800014a4:	cb89                	beqz	a5,800014b6 <pop_off+0x30>
    panic("pop_off - interruptible");
    800014a6:	0000c517          	auipc	a0,0xc
    800014aa:	bba50513          	addi	a0,a0,-1094 # 8000d060 <etext+0x60>
    800014ae:	fffff097          	auipc	ra,0xfffff
    800014b2:	7da080e7          	jalr	2010(ra) # 80000c88 <panic>
  if(c->noff < 1)
    800014b6:	fe843783          	ld	a5,-24(s0)
    800014ba:	5fbc                	lw	a5,120(a5)
    800014bc:	00f04a63          	bgtz	a5,800014d0 <pop_off+0x4a>
    panic("pop_off");
    800014c0:	0000c517          	auipc	a0,0xc
    800014c4:	bb850513          	addi	a0,a0,-1096 # 8000d078 <etext+0x78>
    800014c8:	fffff097          	auipc	ra,0xfffff
    800014cc:	7c0080e7          	jalr	1984(ra) # 80000c88 <panic>
  c->noff -= 1;
    800014d0:	fe843783          	ld	a5,-24(s0)
    800014d4:	5fbc                	lw	a5,120(a5)
    800014d6:	37fd                	addiw	a5,a5,-1
    800014d8:	0007871b          	sext.w	a4,a5
    800014dc:	fe843783          	ld	a5,-24(s0)
    800014e0:	dfb8                	sw	a4,120(a5)
  if(c->noff == 0 && c->intena)
    800014e2:	fe843783          	ld	a5,-24(s0)
    800014e6:	5fbc                	lw	a5,120(a5)
    800014e8:	eb89                	bnez	a5,800014fa <pop_off+0x74>
    800014ea:	fe843783          	ld	a5,-24(s0)
    800014ee:	5ffc                	lw	a5,124(a5)
    800014f0:	c789                	beqz	a5,800014fa <pop_off+0x74>
    intr_on();
    800014f2:	00000097          	auipc	ra,0x0
    800014f6:	d8e080e7          	jalr	-626(ra) # 80001280 <intr_on>
}
    800014fa:	0001                	nop
    800014fc:	60e2                	ld	ra,24(sp)
    800014fe:	6442                	ld	s0,16(sp)
    80001500:	6105                	addi	sp,sp,32
    80001502:	8082                	ret

0000000080001504 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80001504:	7179                	addi	sp,sp,-48
    80001506:	f422                	sd	s0,40(sp)
    80001508:	1800                	addi	s0,sp,48
    8000150a:	fca43c23          	sd	a0,-40(s0)
    8000150e:	87ae                	mv	a5,a1
    80001510:	8732                	mv	a4,a2
    80001512:	fcf42a23          	sw	a5,-44(s0)
    80001516:	87ba                	mv	a5,a4
    80001518:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    8000151c:	fd843783          	ld	a5,-40(s0)
    80001520:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    80001524:	fe042623          	sw	zero,-20(s0)
    80001528:	a00d                	j	8000154a <memset+0x46>
    cdst[i] = c;
    8000152a:	fec42783          	lw	a5,-20(s0)
    8000152e:	fe043703          	ld	a4,-32(s0)
    80001532:	97ba                	add	a5,a5,a4
    80001534:	fd442703          	lw	a4,-44(s0)
    80001538:	0ff77713          	zext.b	a4,a4
    8000153c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    80001540:	fec42783          	lw	a5,-20(s0)
    80001544:	2785                	addiw	a5,a5,1
    80001546:	fef42623          	sw	a5,-20(s0)
    8000154a:	fec42703          	lw	a4,-20(s0)
    8000154e:	fd042783          	lw	a5,-48(s0)
    80001552:	2781                	sext.w	a5,a5
    80001554:	fcf76be3          	bltu	a4,a5,8000152a <memset+0x26>
  }
  return dst;
    80001558:	fd843783          	ld	a5,-40(s0)
}
    8000155c:	853e                	mv	a0,a5
    8000155e:	7422                	ld	s0,40(sp)
    80001560:	6145                	addi	sp,sp,48
    80001562:	8082                	ret

0000000080001564 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80001564:	7139                	addi	sp,sp,-64
    80001566:	fc22                	sd	s0,56(sp)
    80001568:	0080                	addi	s0,sp,64
    8000156a:	fca43c23          	sd	a0,-40(s0)
    8000156e:	fcb43823          	sd	a1,-48(s0)
    80001572:	87b2                	mv	a5,a2
    80001574:	fcf42623          	sw	a5,-52(s0)
  const uchar *s1, *s2;

  s1 = v1;
    80001578:	fd843783          	ld	a5,-40(s0)
    8000157c:	fef43423          	sd	a5,-24(s0)
  s2 = v2;
    80001580:	fd043783          	ld	a5,-48(s0)
    80001584:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    80001588:	a0a1                	j	800015d0 <memcmp+0x6c>
    if(*s1 != *s2)
    8000158a:	fe843783          	ld	a5,-24(s0)
    8000158e:	0007c703          	lbu	a4,0(a5)
    80001592:	fe043783          	ld	a5,-32(s0)
    80001596:	0007c783          	lbu	a5,0(a5)
    8000159a:	02f70163          	beq	a4,a5,800015bc <memcmp+0x58>
      return *s1 - *s2;
    8000159e:	fe843783          	ld	a5,-24(s0)
    800015a2:	0007c783          	lbu	a5,0(a5)
    800015a6:	0007871b          	sext.w	a4,a5
    800015aa:	fe043783          	ld	a5,-32(s0)
    800015ae:	0007c783          	lbu	a5,0(a5)
    800015b2:	2781                	sext.w	a5,a5
    800015b4:	40f707bb          	subw	a5,a4,a5
    800015b8:	2781                	sext.w	a5,a5
    800015ba:	a01d                	j	800015e0 <memcmp+0x7c>
    s1++, s2++;
    800015bc:	fe843783          	ld	a5,-24(s0)
    800015c0:	0785                	addi	a5,a5,1
    800015c2:	fef43423          	sd	a5,-24(s0)
    800015c6:	fe043783          	ld	a5,-32(s0)
    800015ca:	0785                	addi	a5,a5,1
    800015cc:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    800015d0:	fcc42783          	lw	a5,-52(s0)
    800015d4:	fff7871b          	addiw	a4,a5,-1
    800015d8:	fce42623          	sw	a4,-52(s0)
    800015dc:	f7dd                	bnez	a5,8000158a <memcmp+0x26>
  }

  return 0;
    800015de:	4781                	li	a5,0
}
    800015e0:	853e                	mv	a0,a5
    800015e2:	7462                	ld	s0,56(sp)
    800015e4:	6121                	addi	sp,sp,64
    800015e6:	8082                	ret

00000000800015e8 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800015e8:	7139                	addi	sp,sp,-64
    800015ea:	fc22                	sd	s0,56(sp)
    800015ec:	0080                	addi	s0,sp,64
    800015ee:	fca43c23          	sd	a0,-40(s0)
    800015f2:	fcb43823          	sd	a1,-48(s0)
    800015f6:	87b2                	mv	a5,a2
    800015f8:	fcf42623          	sw	a5,-52(s0)
  const char *s;
  char *d;

  if(n == 0)
    800015fc:	fcc42783          	lw	a5,-52(s0)
    80001600:	2781                	sext.w	a5,a5
    80001602:	e781                	bnez	a5,8000160a <memmove+0x22>
    return dst;
    80001604:	fd843783          	ld	a5,-40(s0)
    80001608:	a855                	j	800016bc <memmove+0xd4>
  
  s = src;
    8000160a:	fd043783          	ld	a5,-48(s0)
    8000160e:	fef43423          	sd	a5,-24(s0)
  d = dst;
    80001612:	fd843783          	ld	a5,-40(s0)
    80001616:	fef43023          	sd	a5,-32(s0)
  if(s < d && s + n > d){
    8000161a:	fe843703          	ld	a4,-24(s0)
    8000161e:	fe043783          	ld	a5,-32(s0)
    80001622:	08f77463          	bgeu	a4,a5,800016aa <memmove+0xc2>
    80001626:	fcc46783          	lwu	a5,-52(s0)
    8000162a:	fe843703          	ld	a4,-24(s0)
    8000162e:	97ba                	add	a5,a5,a4
    80001630:	fe043703          	ld	a4,-32(s0)
    80001634:	06f77b63          	bgeu	a4,a5,800016aa <memmove+0xc2>
    s += n;
    80001638:	fcc46783          	lwu	a5,-52(s0)
    8000163c:	fe843703          	ld	a4,-24(s0)
    80001640:	97ba                	add	a5,a5,a4
    80001642:	fef43423          	sd	a5,-24(s0)
    d += n;
    80001646:	fcc46783          	lwu	a5,-52(s0)
    8000164a:	fe043703          	ld	a4,-32(s0)
    8000164e:	97ba                	add	a5,a5,a4
    80001650:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    80001654:	a01d                	j	8000167a <memmove+0x92>
      *--d = *--s;
    80001656:	fe843783          	ld	a5,-24(s0)
    8000165a:	17fd                	addi	a5,a5,-1
    8000165c:	fef43423          	sd	a5,-24(s0)
    80001660:	fe043783          	ld	a5,-32(s0)
    80001664:	17fd                	addi	a5,a5,-1
    80001666:	fef43023          	sd	a5,-32(s0)
    8000166a:	fe843783          	ld	a5,-24(s0)
    8000166e:	0007c703          	lbu	a4,0(a5)
    80001672:	fe043783          	ld	a5,-32(s0)
    80001676:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    8000167a:	fcc42783          	lw	a5,-52(s0)
    8000167e:	fff7871b          	addiw	a4,a5,-1
    80001682:	fce42623          	sw	a4,-52(s0)
    80001686:	fbe1                	bnez	a5,80001656 <memmove+0x6e>
  if(s < d && s + n > d){
    80001688:	a805                	j	800016b8 <memmove+0xd0>
  } else
    while(n-- > 0)
      *d++ = *s++;
    8000168a:	fe843703          	ld	a4,-24(s0)
    8000168e:	00170793          	addi	a5,a4,1
    80001692:	fef43423          	sd	a5,-24(s0)
    80001696:	fe043783          	ld	a5,-32(s0)
    8000169a:	00178693          	addi	a3,a5,1
    8000169e:	fed43023          	sd	a3,-32(s0)
    800016a2:	00074703          	lbu	a4,0(a4)
    800016a6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800016aa:	fcc42783          	lw	a5,-52(s0)
    800016ae:	fff7871b          	addiw	a4,a5,-1
    800016b2:	fce42623          	sw	a4,-52(s0)
    800016b6:	fbf1                	bnez	a5,8000168a <memmove+0xa2>

  return dst;
    800016b8:	fd843783          	ld	a5,-40(s0)
}
    800016bc:	853e                	mv	a0,a5
    800016be:	7462                	ld	s0,56(sp)
    800016c0:	6121                	addi	sp,sp,64
    800016c2:	8082                	ret

00000000800016c4 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    800016c4:	7179                	addi	sp,sp,-48
    800016c6:	f406                	sd	ra,40(sp)
    800016c8:	f022                	sd	s0,32(sp)
    800016ca:	1800                	addi	s0,sp,48
    800016cc:	fea43423          	sd	a0,-24(s0)
    800016d0:	feb43023          	sd	a1,-32(s0)
    800016d4:	87b2                	mv	a5,a2
    800016d6:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    800016da:	fdc42783          	lw	a5,-36(s0)
    800016de:	863e                	mv	a2,a5
    800016e0:	fe043583          	ld	a1,-32(s0)
    800016e4:	fe843503          	ld	a0,-24(s0)
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	f00080e7          	jalr	-256(ra) # 800015e8 <memmove>
    800016f0:	87aa                	mv	a5,a0
}
    800016f2:	853e                	mv	a0,a5
    800016f4:	70a2                	ld	ra,40(sp)
    800016f6:	7402                	ld	s0,32(sp)
    800016f8:	6145                	addi	sp,sp,48
    800016fa:	8082                	ret

00000000800016fc <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    800016fc:	7179                	addi	sp,sp,-48
    800016fe:	f422                	sd	s0,40(sp)
    80001700:	1800                	addi	s0,sp,48
    80001702:	fea43423          	sd	a0,-24(s0)
    80001706:	feb43023          	sd	a1,-32(s0)
    8000170a:	87b2                	mv	a5,a2
    8000170c:	fcf42e23          	sw	a5,-36(s0)
  while(n > 0 && *p && *p == *q)
    80001710:	a005                	j	80001730 <strncmp+0x34>
    n--, p++, q++;
    80001712:	fdc42783          	lw	a5,-36(s0)
    80001716:	37fd                	addiw	a5,a5,-1
    80001718:	fcf42e23          	sw	a5,-36(s0)
    8000171c:	fe843783          	ld	a5,-24(s0)
    80001720:	0785                	addi	a5,a5,1
    80001722:	fef43423          	sd	a5,-24(s0)
    80001726:	fe043783          	ld	a5,-32(s0)
    8000172a:	0785                	addi	a5,a5,1
    8000172c:	fef43023          	sd	a5,-32(s0)
  while(n > 0 && *p && *p == *q)
    80001730:	fdc42783          	lw	a5,-36(s0)
    80001734:	2781                	sext.w	a5,a5
    80001736:	c385                	beqz	a5,80001756 <strncmp+0x5a>
    80001738:	fe843783          	ld	a5,-24(s0)
    8000173c:	0007c783          	lbu	a5,0(a5)
    80001740:	cb99                	beqz	a5,80001756 <strncmp+0x5a>
    80001742:	fe843783          	ld	a5,-24(s0)
    80001746:	0007c703          	lbu	a4,0(a5)
    8000174a:	fe043783          	ld	a5,-32(s0)
    8000174e:	0007c783          	lbu	a5,0(a5)
    80001752:	fcf700e3          	beq	a4,a5,80001712 <strncmp+0x16>
  if(n == 0)
    80001756:	fdc42783          	lw	a5,-36(s0)
    8000175a:	2781                	sext.w	a5,a5
    8000175c:	e399                	bnez	a5,80001762 <strncmp+0x66>
    return 0;
    8000175e:	4781                	li	a5,0
    80001760:	a839                	j	8000177e <strncmp+0x82>
  return (uchar)*p - (uchar)*q;
    80001762:	fe843783          	ld	a5,-24(s0)
    80001766:	0007c783          	lbu	a5,0(a5)
    8000176a:	0007871b          	sext.w	a4,a5
    8000176e:	fe043783          	ld	a5,-32(s0)
    80001772:	0007c783          	lbu	a5,0(a5)
    80001776:	2781                	sext.w	a5,a5
    80001778:	40f707bb          	subw	a5,a4,a5
    8000177c:	2781                	sext.w	a5,a5
}
    8000177e:	853e                	mv	a0,a5
    80001780:	7422                	ld	s0,40(sp)
    80001782:	6145                	addi	sp,sp,48
    80001784:	8082                	ret

0000000080001786 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80001786:	7139                	addi	sp,sp,-64
    80001788:	fc22                	sd	s0,56(sp)
    8000178a:	0080                	addi	s0,sp,64
    8000178c:	fca43c23          	sd	a0,-40(s0)
    80001790:	fcb43823          	sd	a1,-48(s0)
    80001794:	87b2                	mv	a5,a2
    80001796:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    8000179a:	fd843783          	ld	a5,-40(s0)
    8000179e:	fef43423          	sd	a5,-24(s0)
  while(n-- > 0 && (*s++ = *t++) != 0)
    800017a2:	0001                	nop
    800017a4:	fcc42783          	lw	a5,-52(s0)
    800017a8:	fff7871b          	addiw	a4,a5,-1
    800017ac:	fce42623          	sw	a4,-52(s0)
    800017b0:	02f05e63          	blez	a5,800017ec <strncpy+0x66>
    800017b4:	fd043703          	ld	a4,-48(s0)
    800017b8:	00170793          	addi	a5,a4,1
    800017bc:	fcf43823          	sd	a5,-48(s0)
    800017c0:	fd843783          	ld	a5,-40(s0)
    800017c4:	00178693          	addi	a3,a5,1
    800017c8:	fcd43c23          	sd	a3,-40(s0)
    800017cc:	00074703          	lbu	a4,0(a4)
    800017d0:	00e78023          	sb	a4,0(a5)
    800017d4:	0007c783          	lbu	a5,0(a5)
    800017d8:	f7f1                	bnez	a5,800017a4 <strncpy+0x1e>
    ;
  while(n-- > 0)
    800017da:	a809                	j	800017ec <strncpy+0x66>
    *s++ = 0;
    800017dc:	fd843783          	ld	a5,-40(s0)
    800017e0:	00178713          	addi	a4,a5,1
    800017e4:	fce43c23          	sd	a4,-40(s0)
    800017e8:	00078023          	sb	zero,0(a5)
  while(n-- > 0)
    800017ec:	fcc42783          	lw	a5,-52(s0)
    800017f0:	fff7871b          	addiw	a4,a5,-1
    800017f4:	fce42623          	sw	a4,-52(s0)
    800017f8:	fef042e3          	bgtz	a5,800017dc <strncpy+0x56>
  return os;
    800017fc:	fe843783          	ld	a5,-24(s0)
}
    80001800:	853e                	mv	a0,a5
    80001802:	7462                	ld	s0,56(sp)
    80001804:	6121                	addi	sp,sp,64
    80001806:	8082                	ret

0000000080001808 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80001808:	7139                	addi	sp,sp,-64
    8000180a:	fc22                	sd	s0,56(sp)
    8000180c:	0080                	addi	s0,sp,64
    8000180e:	fca43c23          	sd	a0,-40(s0)
    80001812:	fcb43823          	sd	a1,-48(s0)
    80001816:	87b2                	mv	a5,a2
    80001818:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    8000181c:	fd843783          	ld	a5,-40(s0)
    80001820:	fef43423          	sd	a5,-24(s0)
  if(n <= 0)
    80001824:	fcc42783          	lw	a5,-52(s0)
    80001828:	2781                	sext.w	a5,a5
    8000182a:	00f04563          	bgtz	a5,80001834 <safestrcpy+0x2c>
    return os;
    8000182e:	fe843783          	ld	a5,-24(s0)
    80001832:	a0a9                	j	8000187c <safestrcpy+0x74>
  while(--n > 0 && (*s++ = *t++) != 0)
    80001834:	0001                	nop
    80001836:	fcc42783          	lw	a5,-52(s0)
    8000183a:	37fd                	addiw	a5,a5,-1
    8000183c:	fcf42623          	sw	a5,-52(s0)
    80001840:	fcc42783          	lw	a5,-52(s0)
    80001844:	2781                	sext.w	a5,a5
    80001846:	02f05563          	blez	a5,80001870 <safestrcpy+0x68>
    8000184a:	fd043703          	ld	a4,-48(s0)
    8000184e:	00170793          	addi	a5,a4,1
    80001852:	fcf43823          	sd	a5,-48(s0)
    80001856:	fd843783          	ld	a5,-40(s0)
    8000185a:	00178693          	addi	a3,a5,1
    8000185e:	fcd43c23          	sd	a3,-40(s0)
    80001862:	00074703          	lbu	a4,0(a4)
    80001866:	00e78023          	sb	a4,0(a5)
    8000186a:	0007c783          	lbu	a5,0(a5)
    8000186e:	f7e1                	bnez	a5,80001836 <safestrcpy+0x2e>
    ;
  *s = 0;
    80001870:	fd843783          	ld	a5,-40(s0)
    80001874:	00078023          	sb	zero,0(a5)
  return os;
    80001878:	fe843783          	ld	a5,-24(s0)
}
    8000187c:	853e                	mv	a0,a5
    8000187e:	7462                	ld	s0,56(sp)
    80001880:	6121                	addi	sp,sp,64
    80001882:	8082                	ret

0000000080001884 <strcat>:

char* strcat(char *s1, const char *s2) {
    80001884:	7179                	addi	sp,sp,-48
    80001886:	f422                	sd	s0,40(sp)
    80001888:	1800                	addi	s0,sp,48
    8000188a:	fca43c23          	sd	a0,-40(s0)
    8000188e:	fcb43823          	sd	a1,-48(s0)
  char *os = s1;
    80001892:	fd843783          	ld	a5,-40(s0)
    80001896:	fef43423          	sd	a5,-24(s0)
  while(*os) { os++; }
    8000189a:	a031                	j	800018a6 <strcat+0x22>
    8000189c:	fe843783          	ld	a5,-24(s0)
    800018a0:	0785                	addi	a5,a5,1
    800018a2:	fef43423          	sd	a5,-24(s0)
    800018a6:	fe843783          	ld	a5,-24(s0)
    800018aa:	0007c783          	lbu	a5,0(a5)
    800018ae:	f7fd                	bnez	a5,8000189c <strcat+0x18>
  while(*s2) {
    800018b0:	a00d                	j	800018d2 <strcat+0x4e>
    *os++ = *s2++;
    800018b2:	fd043703          	ld	a4,-48(s0)
    800018b6:	00170793          	addi	a5,a4,1
    800018ba:	fcf43823          	sd	a5,-48(s0)
    800018be:	fe843783          	ld	a5,-24(s0)
    800018c2:	00178693          	addi	a3,a5,1
    800018c6:	fed43423          	sd	a3,-24(s0)
    800018ca:	00074703          	lbu	a4,0(a4)
    800018ce:	00e78023          	sb	a4,0(a5)
  while(*s2) {
    800018d2:	fd043783          	ld	a5,-48(s0)
    800018d6:	0007c783          	lbu	a5,0(a5)
    800018da:	ffe1                	bnez	a5,800018b2 <strcat+0x2e>
  }
  *os = 0;
    800018dc:	fe843783          	ld	a5,-24(s0)
    800018e0:	00078023          	sb	zero,0(a5)
  return s1;
    800018e4:	fd843783          	ld	a5,-40(s0)
}
    800018e8:	853e                	mv	a0,a5
    800018ea:	7422                	ld	s0,40(sp)
    800018ec:	6145                	addi	sp,sp,48
    800018ee:	8082                	ret

00000000800018f0 <itoa>:

static char digits[] = "0123456789abcdef";
void
itoa(int xx, int base, char* result)
{
    800018f0:	7139                	addi	sp,sp,-64
    800018f2:	fc22                	sd	s0,56(sp)
    800018f4:	0080                	addi	s0,sp,64
    800018f6:	87aa                	mv	a5,a0
    800018f8:	872e                	mv	a4,a1
    800018fa:	fcc43023          	sd	a2,-64(s0)
    800018fe:	fcf42623          	sw	a5,-52(s0)
    80001902:	87ba                	mv	a5,a4
    80001904:	fcf42423          	sw	a5,-56(s0)
  char buf[16];
  int i;

  i = 0;
    80001908:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[xx % base];
    8000190c:	fcc42783          	lw	a5,-52(s0)
    80001910:	873e                	mv	a4,a5
    80001912:	fc842783          	lw	a5,-56(s0)
    80001916:	02f767bb          	remw	a5,a4,a5
    8000191a:	0007871b          	sext.w	a4,a5
    8000191e:	fec42783          	lw	a5,-20(s0)
    80001922:	0017869b          	addiw	a3,a5,1
    80001926:	fed42623          	sw	a3,-20(s0)
    8000192a:	0000f697          	auipc	a3,0xf
    8000192e:	bee68693          	addi	a3,a3,-1042 # 80010518 <digits>
    80001932:	9736                	add	a4,a4,a3
    80001934:	00074703          	lbu	a4,0(a4)
    80001938:	17c1                	addi	a5,a5,-16
    8000193a:	97a2                	add	a5,a5,s0
    8000193c:	fee78423          	sb	a4,-24(a5)
  } while((xx /= base) != 0);
    80001940:	fcc42783          	lw	a5,-52(s0)
    80001944:	873e                	mv	a4,a5
    80001946:	fc842783          	lw	a5,-56(s0)
    8000194a:	02f747bb          	divw	a5,a4,a5
    8000194e:	fcf42623          	sw	a5,-52(s0)
    80001952:	fcc42783          	lw	a5,-52(s0)
    80001956:	2781                	sext.w	a5,a5
    80001958:	fbd5                	bnez	a5,8000190c <itoa+0x1c>

  while(*result) {result++;}
    8000195a:	a031                	j	80001966 <itoa+0x76>
    8000195c:	fc043783          	ld	a5,-64(s0)
    80001960:	0785                	addi	a5,a5,1
    80001962:	fcf43023          	sd	a5,-64(s0)
    80001966:	fc043783          	ld	a5,-64(s0)
    8000196a:	0007c783          	lbu	a5,0(a5)
    8000196e:	f7fd                	bnez	a5,8000195c <itoa+0x6c>
  while(--i >= 0) {
    80001970:	a839                	j	8000198e <itoa+0x9e>
    *result++ = buf[i];
    80001972:	fc043783          	ld	a5,-64(s0)
    80001976:	00178713          	addi	a4,a5,1
    8000197a:	fce43023          	sd	a4,-64(s0)
    8000197e:	fec42703          	lw	a4,-20(s0)
    80001982:	1741                	addi	a4,a4,-16
    80001984:	9722                	add	a4,a4,s0
    80001986:	fe874703          	lbu	a4,-24(a4)
    8000198a:	00e78023          	sb	a4,0(a5)
  while(--i >= 0) {
    8000198e:	fec42783          	lw	a5,-20(s0)
    80001992:	37fd                	addiw	a5,a5,-1
    80001994:	fef42623          	sw	a5,-20(s0)
    80001998:	fec42783          	lw	a5,-20(s0)
    8000199c:	2781                	sext.w	a5,a5
    8000199e:	fc07dae3          	bgez	a5,80001972 <itoa+0x82>
  }
  *result = 0;
    800019a2:	fc043783          	ld	a5,-64(s0)
    800019a6:	00078023          	sb	zero,0(a5)
}
    800019aa:	0001                	nop
    800019ac:	7462                	ld	s0,56(sp)
    800019ae:	6121                	addi	sp,sp,64
    800019b0:	8082                	ret

00000000800019b2 <strlen>:

int
strlen(const char *s)
{
    800019b2:	7179                	addi	sp,sp,-48
    800019b4:	f422                	sd	s0,40(sp)
    800019b6:	1800                	addi	s0,sp,48
    800019b8:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    800019bc:	fe042623          	sw	zero,-20(s0)
    800019c0:	a031                	j	800019cc <strlen+0x1a>
    800019c2:	fec42783          	lw	a5,-20(s0)
    800019c6:	2785                	addiw	a5,a5,1
    800019c8:	fef42623          	sw	a5,-20(s0)
    800019cc:	fec42783          	lw	a5,-20(s0)
    800019d0:	fd843703          	ld	a4,-40(s0)
    800019d4:	97ba                	add	a5,a5,a4
    800019d6:	0007c783          	lbu	a5,0(a5)
    800019da:	f7e5                	bnez	a5,800019c2 <strlen+0x10>
    ;
  return n;
    800019dc:	fec42783          	lw	a5,-20(s0)
}
    800019e0:	853e                	mv	a0,a5
    800019e2:	7422                	ld	s0,40(sp)
    800019e4:	6145                	addi	sp,sp,48
    800019e6:	8082                	ret

00000000800019e8 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800019e8:	7139                	addi	sp,sp,-64
    800019ea:	fc06                	sd	ra,56(sp)
    800019ec:	f822                	sd	s0,48(sp)
    800019ee:	0080                	addi	s0,sp,64
  if(cpuid() == 0){
    800019f0:	00001097          	auipc	ra,0x1
    800019f4:	0b0080e7          	jalr	176(ra) # 80002aa0 <cpuid>
    800019f8:	87aa                	mv	a5,a0
    800019fa:	14079963          	bnez	a5,80001b4c <main+0x164>
    consoleinit();
    800019fe:	fffff097          	auipc	ra,0xfffff
    80001a02:	e64080e7          	jalr	-412(ra) # 80000862 <consoleinit>
    printfinit();
    80001a06:	fffff097          	auipc	ra,0xfffff
    80001a0a:	386080e7          	jalr	902(ra) # 80000d8c <printfinit>
    printf("\n");
    80001a0e:	0000b517          	auipc	a0,0xb
    80001a12:	67250513          	addi	a0,a0,1650 # 8000d080 <etext+0x80>
    80001a16:	fffff097          	auipc	ra,0xfffff
    80001a1a:	01c080e7          	jalr	28(ra) # 80000a32 <printf>
    printf("xv6 kernel is booting\n");
    80001a1e:	0000b517          	auipc	a0,0xb
    80001a22:	66a50513          	addi	a0,a0,1642 # 8000d088 <etext+0x88>
    80001a26:	fffff097          	auipc	ra,0xfffff
    80001a2a:	00c080e7          	jalr	12(ra) # 80000a32 <printf>
    printf("\n");
    80001a2e:	0000b517          	auipc	a0,0xb
    80001a32:	65250513          	addi	a0,a0,1618 # 8000d080 <etext+0x80>
    80001a36:	fffff097          	auipc	ra,0xfffff
    80001a3a:	ffc080e7          	jalr	-4(ra) # 80000a32 <printf>
    kinit();         // physical page allocator
    80001a3e:	fffff097          	auipc	ra,0xfffff
    80001a42:	65e080e7          	jalr	1630(ra) # 8000109c <kinit>
    kvminit();       // create kernel page table
    80001a46:	00000097          	auipc	ra,0x0
    80001a4a:	2d6080e7          	jalr	726(ra) # 80001d1c <kvminit>
    kvminithart();   // turn on paging
    80001a4e:	00000097          	auipc	ra,0x0
    80001a52:	2f4080e7          	jalr	756(ra) # 80001d42 <kvminithart>
    procinit();      // process table
    80001a56:	00001097          	auipc	ra,0x1
    80001a5a:	f7c080e7          	jalr	-132(ra) # 800029d2 <procinit>
    trapinit();      // trap vectors
    80001a5e:	00002097          	auipc	ra,0x2
    80001a62:	288080e7          	jalr	648(ra) # 80003ce6 <trapinit>
    trapinithart();  // install kernel trap vector
    80001a66:	00002097          	auipc	ra,0x2
    80001a6a:	2aa080e7          	jalr	682(ra) # 80003d10 <trapinithart>
    plicinit();      // set up interrupt controller
    80001a6e:	00007097          	auipc	ra,0x7
    80001a72:	0ec080e7          	jalr	236(ra) # 80008b5a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80001a76:	00007097          	auipc	ra,0x7
    80001a7a:	146080e7          	jalr	326(ra) # 80008bbc <plicinithart>
    binit();         // buffer cache
    80001a7e:	00003097          	auipc	ra,0x3
    80001a82:	cb8080e7          	jalr	-840(ra) # 80004736 <binit>
    iinit();         // inode table
    80001a86:	00003097          	auipc	ra,0x3
    80001a8a:	4f2080e7          	jalr	1266(ra) # 80004f78 <iinit>
    fileinit();      // file table
    80001a8e:	00005097          	auipc	ra,0x5
    80001a92:	ed0080e7          	jalr	-304(ra) # 8000695e <fileinit>
    virtio_disk_init(VIRTIO0_ID, "program_disk"); // emulated hard disk 0, with programs
    80001a96:	0000b597          	auipc	a1,0xb
    80001a9a:	60a58593          	addi	a1,a1,1546 # 8000d0a0 <etext+0xa0>
    80001a9e:	4501                	li	a0,0
    80001aa0:	00007097          	auipc	ra,0x7
    80001aa4:	234080e7          	jalr	564(ra) # 80008cd4 <virtio_disk_init>

    for (int i = VIRTIO_RAID_DISK_START; i <= VIRTIO_RAID_DISK_END; i++) {
    80001aa8:	4785                	li	a5,1
    80001aaa:	fef42623          	sw	a5,-20(s0)
    80001aae:	a89d                	j	80001b24 <main+0x13c>
      char name[30] = {0};
    80001ab0:	fc043423          	sd	zero,-56(s0)
    80001ab4:	fc043823          	sd	zero,-48(s0)
    80001ab8:	fc043c23          	sd	zero,-40(s0)
    80001abc:	fe042023          	sw	zero,-32(s0)
    80001ac0:	fe041223          	sh	zero,-28(s0)
      strcat(name, "disk_");
    80001ac4:	fc840793          	addi	a5,s0,-56
    80001ac8:	0000b597          	auipc	a1,0xb
    80001acc:	5e858593          	addi	a1,a1,1512 # 8000d0b0 <etext+0xb0>
    80001ad0:	853e                	mv	a0,a5
    80001ad2:	00000097          	auipc	ra,0x0
    80001ad6:	db2080e7          	jalr	-590(ra) # 80001884 <strcat>
      itoa(i, 10, name);
    80001ada:	fc840713          	addi	a4,s0,-56
    80001ade:	fec42783          	lw	a5,-20(s0)
    80001ae2:	863a                	mv	a2,a4
    80001ae4:	45a9                	li	a1,10
    80001ae6:	853e                	mv	a0,a5
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	e08080e7          	jalr	-504(ra) # 800018f0 <itoa>
      printf("%s\n", name);
    80001af0:	fc840793          	addi	a5,s0,-56
    80001af4:	85be                	mv	a1,a5
    80001af6:	0000b517          	auipc	a0,0xb
    80001afa:	5c250513          	addi	a0,a0,1474 # 8000d0b8 <etext+0xb8>
    80001afe:	fffff097          	auipc	ra,0xfffff
    80001b02:	f34080e7          	jalr	-204(ra) # 80000a32 <printf>
      virtio_disk_init(i, name);
    80001b06:	fc840713          	addi	a4,s0,-56
    80001b0a:	fec42783          	lw	a5,-20(s0)
    80001b0e:	85ba                	mv	a1,a4
    80001b10:	853e                	mv	a0,a5
    80001b12:	00007097          	auipc	ra,0x7
    80001b16:	1c2080e7          	jalr	450(ra) # 80008cd4 <virtio_disk_init>
    for (int i = VIRTIO_RAID_DISK_START; i <= VIRTIO_RAID_DISK_END; i++) {
    80001b1a:	fec42783          	lw	a5,-20(s0)
    80001b1e:	2785                	addiw	a5,a5,1
    80001b20:	fef42623          	sw	a5,-20(s0)
    80001b24:	fec42783          	lw	a5,-20(s0)
    80001b28:	0007871b          	sext.w	a4,a5
    80001b2c:	4799                	li	a5,6
    80001b2e:	f8e7d1e3          	bge	a5,a4,80001ab0 <main+0xc8>
    }

    userinit();      // first user process
    80001b32:	00001097          	auipc	ra,0x1
    80001b36:	34c080e7          	jalr	844(ra) # 80002e7e <userinit>
    __sync_synchronize();
    80001b3a:	0330000f          	fence	rw,rw
    started = 1;
    80001b3e:	00017797          	auipc	a5,0x17
    80001b42:	e1278793          	addi	a5,a5,-494 # 80018950 <started>
    80001b46:	4705                	li	a4,1
    80001b48:	c398                	sw	a4,0(a5)
    80001b4a:	a0a9                	j	80001b94 <main+0x1ac>
  } else {
    while(started == 0)
    80001b4c:	0001                	nop
    80001b4e:	00017797          	auipc	a5,0x17
    80001b52:	e0278793          	addi	a5,a5,-510 # 80018950 <started>
    80001b56:	439c                	lw	a5,0(a5)
    80001b58:	2781                	sext.w	a5,a5
    80001b5a:	dbf5                	beqz	a5,80001b4e <main+0x166>
      ;
    __sync_synchronize();
    80001b5c:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80001b60:	00001097          	auipc	ra,0x1
    80001b64:	f40080e7          	jalr	-192(ra) # 80002aa0 <cpuid>
    80001b68:	87aa                	mv	a5,a0
    80001b6a:	85be                	mv	a1,a5
    80001b6c:	0000b517          	auipc	a0,0xb
    80001b70:	55450513          	addi	a0,a0,1364 # 8000d0c0 <etext+0xc0>
    80001b74:	fffff097          	auipc	ra,0xfffff
    80001b78:	ebe080e7          	jalr	-322(ra) # 80000a32 <printf>
    kvminithart();    // turn on paging
    80001b7c:	00000097          	auipc	ra,0x0
    80001b80:	1c6080e7          	jalr	454(ra) # 80001d42 <kvminithart>
    trapinithart();   // install kernel trap vector
    80001b84:	00002097          	auipc	ra,0x2
    80001b88:	18c080e7          	jalr	396(ra) # 80003d10 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80001b8c:	00007097          	auipc	ra,0x7
    80001b90:	030080e7          	jalr	48(ra) # 80008bbc <plicinithart>
  }

  scheduler();        
    80001b94:	00002097          	auipc	ra,0x2
    80001b98:	900080e7          	jalr	-1792(ra) # 80003494 <scheduler>

0000000080001b9c <w_satp>:
{
    80001b9c:	1101                	addi	sp,sp,-32
    80001b9e:	ec22                	sd	s0,24(sp)
    80001ba0:	1000                	addi	s0,sp,32
    80001ba2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80001ba6:	fe843783          	ld	a5,-24(s0)
    80001baa:	18079073          	csrw	satp,a5
}
    80001bae:	0001                	nop
    80001bb0:	6462                	ld	s0,24(sp)
    80001bb2:	6105                	addi	sp,sp,32
    80001bb4:	8082                	ret

0000000080001bb6 <sfence_vma>:
}

// flush the TLB.
static inline void
sfence_vma()
{
    80001bb6:	1141                	addi	sp,sp,-16
    80001bb8:	e422                	sd	s0,8(sp)
    80001bba:	0800                	addi	s0,sp,16
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80001bbc:	12000073          	sfence.vma
}
    80001bc0:	0001                	nop
    80001bc2:	6422                	ld	s0,8(sp)
    80001bc4:	0141                	addi	sp,sp,16
    80001bc6:	8082                	ret

0000000080001bc8 <kvmmake>:
extern char trampoline[]; // trampoline.S

// Make a direct-map page table for the kernel.
pagetable_t
kvmmake(void)
{
    80001bc8:	1101                	addi	sp,sp,-32
    80001bca:	ec06                	sd	ra,24(sp)
    80001bcc:	e822                	sd	s0,16(sp)
    80001bce:	1000                	addi	s0,sp,32
  pagetable_t kpgtbl;

  kpgtbl = (pagetable_t) kalloc();
    80001bd0:	fffff097          	auipc	ra,0xfffff
    80001bd4:	60c080e7          	jalr	1548(ra) # 800011dc <kalloc>
    80001bd8:	fea43023          	sd	a0,-32(s0)
  memset(kpgtbl, 0, PGSIZE);
    80001bdc:	6605                	lui	a2,0x1
    80001bde:	4581                	li	a1,0
    80001be0:	fe043503          	ld	a0,-32(s0)
    80001be4:	00000097          	auipc	ra,0x0
    80001be8:	920080e7          	jalr	-1760(ra) # 80001504 <memset>

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001bec:	4719                	li	a4,6
    80001bee:	6685                	lui	a3,0x1
    80001bf0:	10000637          	lui	a2,0x10000
    80001bf4:	100005b7          	lui	a1,0x10000
    80001bf8:	fe043503          	ld	a0,-32(s0)
    80001bfc:	00000097          	auipc	ra,0x0
    80001c00:	2e4080e7          	jalr	740(ra) # 80001ee0 <kvmmap>

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80001c04:	4719                	li	a4,6
    80001c06:	6685                	lui	a3,0x1
    80001c08:	10001637          	lui	a2,0x10001
    80001c0c:	100015b7          	lui	a1,0x10001
    80001c10:	fe043503          	ld	a0,-32(s0)
    80001c14:	00000097          	auipc	ra,0x0
    80001c18:	2cc080e7          	jalr	716(ra) # 80001ee0 <kvmmap>

  for (int i = VIRTIO_RAID_DISK_START; i <= VIRTIO_RAID_DISK_END; i++) {
    80001c1c:	4785                	li	a5,1
    80001c1e:	fef42623          	sw	a5,-20(s0)
    80001c22:	a825                	j	80001c5a <kvmmake+0x92>
    kvmmap(kpgtbl, VIRTIOX(i), VIRTIOX(i), PGSIZE, PTE_R | PTE_W);
    80001c24:	fec42703          	lw	a4,-20(s0)
    80001c28:	67c1                	lui	a5,0x10
    80001c2a:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80001c2c:	97ba                	add	a5,a5,a4
    80001c2e:	07b2                	slli	a5,a5,0xc
    80001c30:	85be                	mv	a1,a5
    80001c32:	fec42703          	lw	a4,-20(s0)
    80001c36:	67c1                	lui	a5,0x10
    80001c38:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80001c3a:	97ba                	add	a5,a5,a4
    80001c3c:	07b2                	slli	a5,a5,0xc
    80001c3e:	4719                	li	a4,6
    80001c40:	6685                	lui	a3,0x1
    80001c42:	863e                	mv	a2,a5
    80001c44:	fe043503          	ld	a0,-32(s0)
    80001c48:	00000097          	auipc	ra,0x0
    80001c4c:	298080e7          	jalr	664(ra) # 80001ee0 <kvmmap>
  for (int i = VIRTIO_RAID_DISK_START; i <= VIRTIO_RAID_DISK_END; i++) {
    80001c50:	fec42783          	lw	a5,-20(s0)
    80001c54:	2785                	addiw	a5,a5,1
    80001c56:	fef42623          	sw	a5,-20(s0)
    80001c5a:	fec42783          	lw	a5,-20(s0)
    80001c5e:	0007871b          	sext.w	a4,a5
    80001c62:	4799                	li	a5,6
    80001c64:	fce7d0e3          	bge	a5,a4,80001c24 <kvmmake+0x5c>
  }

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001c68:	4719                	li	a4,6
    80001c6a:	004006b7          	lui	a3,0x400
    80001c6e:	0c000637          	lui	a2,0xc000
    80001c72:	0c0005b7          	lui	a1,0xc000
    80001c76:	fe043503          	ld	a0,-32(s0)
    80001c7a:	00000097          	auipc	ra,0x0
    80001c7e:	266080e7          	jalr	614(ra) # 80001ee0 <kvmmap>

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80001c82:	0000b717          	auipc	a4,0xb
    80001c86:	37e70713          	addi	a4,a4,894 # 8000d000 <etext>
    80001c8a:	800007b7          	lui	a5,0x80000
    80001c8e:	97ba                	add	a5,a5,a4
    80001c90:	4729                	li	a4,10
    80001c92:	86be                	mv	a3,a5
    80001c94:	4785                	li	a5,1
    80001c96:	01f79613          	slli	a2,a5,0x1f
    80001c9a:	4785                	li	a5,1
    80001c9c:	01f79593          	slli	a1,a5,0x1f
    80001ca0:	fe043503          	ld	a0,-32(s0)
    80001ca4:	00000097          	auipc	ra,0x0
    80001ca8:	23c080e7          	jalr	572(ra) # 80001ee0 <kvmmap>

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80001cac:	0000b597          	auipc	a1,0xb
    80001cb0:	35458593          	addi	a1,a1,852 # 8000d000 <etext>
    80001cb4:	0000b617          	auipc	a2,0xb
    80001cb8:	34c60613          	addi	a2,a2,844 # 8000d000 <etext>
    80001cbc:	0000b797          	auipc	a5,0xb
    80001cc0:	34478793          	addi	a5,a5,836 # 8000d000 <etext>
    80001cc4:	08100713          	li	a4,129
    80001cc8:	0762                	slli	a4,a4,0x18
    80001cca:	40f707b3          	sub	a5,a4,a5
    80001cce:	4719                	li	a4,6
    80001cd0:	86be                	mv	a3,a5
    80001cd2:	fe043503          	ld	a0,-32(s0)
    80001cd6:	00000097          	auipc	ra,0x0
    80001cda:	20a080e7          	jalr	522(ra) # 80001ee0 <kvmmap>

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001cde:	0000a797          	auipc	a5,0xa
    80001ce2:	32278793          	addi	a5,a5,802 # 8000c000 <_trampoline>
    80001ce6:	4729                	li	a4,10
    80001ce8:	6685                	lui	a3,0x1
    80001cea:	863e                	mv	a2,a5
    80001cec:	040007b7          	lui	a5,0x4000
    80001cf0:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001cf2:	00c79593          	slli	a1,a5,0xc
    80001cf6:	fe043503          	ld	a0,-32(s0)
    80001cfa:	00000097          	auipc	ra,0x0
    80001cfe:	1e6080e7          	jalr	486(ra) # 80001ee0 <kvmmap>

  // allocate and map a kernel stack for each process.
  proc_mapstacks(kpgtbl);
    80001d02:	fe043503          	ld	a0,-32(s0)
    80001d06:	00001097          	auipc	ra,0x1
    80001d0a:	c10080e7          	jalr	-1008(ra) # 80002916 <proc_mapstacks>
  
  return kpgtbl;
    80001d0e:	fe043783          	ld	a5,-32(s0)
}
    80001d12:	853e                	mv	a0,a5
    80001d14:	60e2                	ld	ra,24(sp)
    80001d16:	6442                	ld	s0,16(sp)
    80001d18:	6105                	addi	sp,sp,32
    80001d1a:	8082                	ret

0000000080001d1c <kvminit>:

// Initialize the one kernel_pagetable
void
kvminit(void)
{
    80001d1c:	1141                	addi	sp,sp,-16
    80001d1e:	e406                	sd	ra,8(sp)
    80001d20:	e022                	sd	s0,0(sp)
    80001d22:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001d24:	00000097          	auipc	ra,0x0
    80001d28:	ea4080e7          	jalr	-348(ra) # 80001bc8 <kvmmake>
    80001d2c:	872a                	mv	a4,a0
    80001d2e:	0000f797          	auipc	a5,0xf
    80001d32:	9aa78793          	addi	a5,a5,-1622 # 800106d8 <kernel_pagetable>
    80001d36:	e398                	sd	a4,0(a5)
}
    80001d38:	0001                	nop
    80001d3a:	60a2                	ld	ra,8(sp)
    80001d3c:	6402                	ld	s0,0(sp)
    80001d3e:	0141                	addi	sp,sp,16
    80001d40:	8082                	ret

0000000080001d42 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80001d42:	1141                	addi	sp,sp,-16
    80001d44:	e406                	sd	ra,8(sp)
    80001d46:	e022                	sd	s0,0(sp)
    80001d48:	0800                	addi	s0,sp,16
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();
    80001d4a:	00000097          	auipc	ra,0x0
    80001d4e:	e6c080e7          	jalr	-404(ra) # 80001bb6 <sfence_vma>

  w_satp(MAKE_SATP(kernel_pagetable));
    80001d52:	0000f797          	auipc	a5,0xf
    80001d56:	98678793          	addi	a5,a5,-1658 # 800106d8 <kernel_pagetable>
    80001d5a:	639c                	ld	a5,0(a5)
    80001d5c:	00c7d713          	srli	a4,a5,0xc
    80001d60:	57fd                	li	a5,-1
    80001d62:	17fe                	slli	a5,a5,0x3f
    80001d64:	8fd9                	or	a5,a5,a4
    80001d66:	853e                	mv	a0,a5
    80001d68:	00000097          	auipc	ra,0x0
    80001d6c:	e34080e7          	jalr	-460(ra) # 80001b9c <w_satp>

  // flush stale entries from the TLB.
  sfence_vma();
    80001d70:	00000097          	auipc	ra,0x0
    80001d74:	e46080e7          	jalr	-442(ra) # 80001bb6 <sfence_vma>
}
    80001d78:	0001                	nop
    80001d7a:	60a2                	ld	ra,8(sp)
    80001d7c:	6402                	ld	s0,0(sp)
    80001d7e:	0141                	addi	sp,sp,16
    80001d80:	8082                	ret

0000000080001d82 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80001d82:	7139                	addi	sp,sp,-64
    80001d84:	fc06                	sd	ra,56(sp)
    80001d86:	f822                	sd	s0,48(sp)
    80001d88:	0080                	addi	s0,sp,64
    80001d8a:	fca43c23          	sd	a0,-40(s0)
    80001d8e:	fcb43823          	sd	a1,-48(s0)
    80001d92:	87b2                	mv	a5,a2
    80001d94:	fcf42623          	sw	a5,-52(s0)
  if(va >= MAXVA)
    80001d98:	fd043703          	ld	a4,-48(s0)
    80001d9c:	57fd                	li	a5,-1
    80001d9e:	83e9                	srli	a5,a5,0x1a
    80001da0:	00e7f463          	bgeu	a5,a4,80001da8 <walk+0x26>
    return 0;
    80001da4:	4781                	li	a5,0
    80001da6:	a865                	j	80001e5e <walk+0xdc>

  for(int level = 2; level > 0; level--) {
    80001da8:	4789                	li	a5,2
    80001daa:	fef42623          	sw	a5,-20(s0)
    80001dae:	a851                	j	80001e42 <walk+0xc0>
    pte_t *pte = &pagetable[PX(level, va)];
    80001db0:	fec42783          	lw	a5,-20(s0)
    80001db4:	873e                	mv	a4,a5
    80001db6:	87ba                	mv	a5,a4
    80001db8:	0037979b          	slliw	a5,a5,0x3
    80001dbc:	9fb9                	addw	a5,a5,a4
    80001dbe:	2781                	sext.w	a5,a5
    80001dc0:	27b1                	addiw	a5,a5,12
    80001dc2:	2781                	sext.w	a5,a5
    80001dc4:	873e                	mv	a4,a5
    80001dc6:	fd043783          	ld	a5,-48(s0)
    80001dca:	00e7d7b3          	srl	a5,a5,a4
    80001dce:	1ff7f793          	andi	a5,a5,511
    80001dd2:	078e                	slli	a5,a5,0x3
    80001dd4:	fd843703          	ld	a4,-40(s0)
    80001dd8:	97ba                	add	a5,a5,a4
    80001dda:	fef43023          	sd	a5,-32(s0)
    if(*pte & PTE_V) {
    80001dde:	fe043783          	ld	a5,-32(s0)
    80001de2:	639c                	ld	a5,0(a5)
    80001de4:	8b85                	andi	a5,a5,1
    80001de6:	cb89                	beqz	a5,80001df8 <walk+0x76>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001de8:	fe043783          	ld	a5,-32(s0)
    80001dec:	639c                	ld	a5,0(a5)
    80001dee:	83a9                	srli	a5,a5,0xa
    80001df0:	07b2                	slli	a5,a5,0xc
    80001df2:	fcf43c23          	sd	a5,-40(s0)
    80001df6:	a089                	j	80001e38 <walk+0xb6>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001df8:	fcc42783          	lw	a5,-52(s0)
    80001dfc:	2781                	sext.w	a5,a5
    80001dfe:	cb91                	beqz	a5,80001e12 <walk+0x90>
    80001e00:	fffff097          	auipc	ra,0xfffff
    80001e04:	3dc080e7          	jalr	988(ra) # 800011dc <kalloc>
    80001e08:	fca43c23          	sd	a0,-40(s0)
    80001e0c:	fd843783          	ld	a5,-40(s0)
    80001e10:	e399                	bnez	a5,80001e16 <walk+0x94>
        return 0;
    80001e12:	4781                	li	a5,0
    80001e14:	a0a9                	j	80001e5e <walk+0xdc>
      memset(pagetable, 0, PGSIZE);
    80001e16:	6605                	lui	a2,0x1
    80001e18:	4581                	li	a1,0
    80001e1a:	fd843503          	ld	a0,-40(s0)
    80001e1e:	fffff097          	auipc	ra,0xfffff
    80001e22:	6e6080e7          	jalr	1766(ra) # 80001504 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001e26:	fd843783          	ld	a5,-40(s0)
    80001e2a:	83b1                	srli	a5,a5,0xc
    80001e2c:	07aa                	slli	a5,a5,0xa
    80001e2e:	0017e713          	ori	a4,a5,1
    80001e32:	fe043783          	ld	a5,-32(s0)
    80001e36:	e398                	sd	a4,0(a5)
  for(int level = 2; level > 0; level--) {
    80001e38:	fec42783          	lw	a5,-20(s0)
    80001e3c:	37fd                	addiw	a5,a5,-1
    80001e3e:	fef42623          	sw	a5,-20(s0)
    80001e42:	fec42783          	lw	a5,-20(s0)
    80001e46:	2781                	sext.w	a5,a5
    80001e48:	f6f044e3          	bgtz	a5,80001db0 <walk+0x2e>
    }
  }
  return &pagetable[PX(0, va)];
    80001e4c:	fd043783          	ld	a5,-48(s0)
    80001e50:	83b1                	srli	a5,a5,0xc
    80001e52:	1ff7f793          	andi	a5,a5,511
    80001e56:	078e                	slli	a5,a5,0x3
    80001e58:	fd843703          	ld	a4,-40(s0)
    80001e5c:	97ba                	add	a5,a5,a4
}
    80001e5e:	853e                	mv	a0,a5
    80001e60:	70e2                	ld	ra,56(sp)
    80001e62:	7442                	ld	s0,48(sp)
    80001e64:	6121                	addi	sp,sp,64
    80001e66:	8082                	ret

0000000080001e68 <walkaddr>:
// Look up a virtual address, return the physical address,
// or 0 if not mapped.
// Can only be used to look up user pages.
uint64
walkaddr(pagetable_t pagetable, uint64 va)
{
    80001e68:	7179                	addi	sp,sp,-48
    80001e6a:	f406                	sd	ra,40(sp)
    80001e6c:	f022                	sd	s0,32(sp)
    80001e6e:	1800                	addi	s0,sp,48
    80001e70:	fca43c23          	sd	a0,-40(s0)
    80001e74:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001e78:	fd043703          	ld	a4,-48(s0)
    80001e7c:	57fd                	li	a5,-1
    80001e7e:	83e9                	srli	a5,a5,0x1a
    80001e80:	00e7f463          	bgeu	a5,a4,80001e88 <walkaddr+0x20>
    return 0;
    80001e84:	4781                	li	a5,0
    80001e86:	a881                	j	80001ed6 <walkaddr+0x6e>

  pte = walk(pagetable, va, 0);
    80001e88:	4601                	li	a2,0
    80001e8a:	fd043583          	ld	a1,-48(s0)
    80001e8e:	fd843503          	ld	a0,-40(s0)
    80001e92:	00000097          	auipc	ra,0x0
    80001e96:	ef0080e7          	jalr	-272(ra) # 80001d82 <walk>
    80001e9a:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    80001e9e:	fe843783          	ld	a5,-24(s0)
    80001ea2:	e399                	bnez	a5,80001ea8 <walkaddr+0x40>
    return 0;
    80001ea4:	4781                	li	a5,0
    80001ea6:	a805                	j	80001ed6 <walkaddr+0x6e>
  if((*pte & PTE_V) == 0)
    80001ea8:	fe843783          	ld	a5,-24(s0)
    80001eac:	639c                	ld	a5,0(a5)
    80001eae:	8b85                	andi	a5,a5,1
    80001eb0:	e399                	bnez	a5,80001eb6 <walkaddr+0x4e>
    return 0;
    80001eb2:	4781                	li	a5,0
    80001eb4:	a00d                	j	80001ed6 <walkaddr+0x6e>
  if((*pte & PTE_U) == 0)
    80001eb6:	fe843783          	ld	a5,-24(s0)
    80001eba:	639c                	ld	a5,0(a5)
    80001ebc:	8bc1                	andi	a5,a5,16
    80001ebe:	e399                	bnez	a5,80001ec4 <walkaddr+0x5c>
    return 0;
    80001ec0:	4781                	li	a5,0
    80001ec2:	a811                	j	80001ed6 <walkaddr+0x6e>
  pa = PTE2PA(*pte);
    80001ec4:	fe843783          	ld	a5,-24(s0)
    80001ec8:	639c                	ld	a5,0(a5)
    80001eca:	83a9                	srli	a5,a5,0xa
    80001ecc:	07b2                	slli	a5,a5,0xc
    80001ece:	fef43023          	sd	a5,-32(s0)
  return pa;
    80001ed2:	fe043783          	ld	a5,-32(s0)
}
    80001ed6:	853e                	mv	a0,a5
    80001ed8:	70a2                	ld	ra,40(sp)
    80001eda:	7402                	ld	s0,32(sp)
    80001edc:	6145                	addi	sp,sp,48
    80001ede:	8082                	ret

0000000080001ee0 <kvmmap>:
// add a mapping to the kernel page table.
// only used when booting.
// does not flush TLB or enable paging.
void
kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm)
{
    80001ee0:	7139                	addi	sp,sp,-64
    80001ee2:	fc06                	sd	ra,56(sp)
    80001ee4:	f822                	sd	s0,48(sp)
    80001ee6:	0080                	addi	s0,sp,64
    80001ee8:	fea43423          	sd	a0,-24(s0)
    80001eec:	feb43023          	sd	a1,-32(s0)
    80001ef0:	fcc43c23          	sd	a2,-40(s0)
    80001ef4:	fcd43823          	sd	a3,-48(s0)
    80001ef8:	87ba                	mv	a5,a4
    80001efa:	fcf42623          	sw	a5,-52(s0)
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001efe:	fcc42783          	lw	a5,-52(s0)
    80001f02:	873e                	mv	a4,a5
    80001f04:	fd843683          	ld	a3,-40(s0)
    80001f08:	fd043603          	ld	a2,-48(s0)
    80001f0c:	fe043583          	ld	a1,-32(s0)
    80001f10:	fe843503          	ld	a0,-24(s0)
    80001f14:	00000097          	auipc	ra,0x0
    80001f18:	026080e7          	jalr	38(ra) # 80001f3a <mappages>
    80001f1c:	87aa                	mv	a5,a0
    80001f1e:	cb89                	beqz	a5,80001f30 <kvmmap+0x50>
    panic("kvmmap");
    80001f20:	0000b517          	auipc	a0,0xb
    80001f24:	1b850513          	addi	a0,a0,440 # 8000d0d8 <etext+0xd8>
    80001f28:	fffff097          	auipc	ra,0xfffff
    80001f2c:	d60080e7          	jalr	-672(ra) # 80000c88 <panic>
}
    80001f30:	0001                	nop
    80001f32:	70e2                	ld	ra,56(sp)
    80001f34:	7442                	ld	s0,48(sp)
    80001f36:	6121                	addi	sp,sp,64
    80001f38:	8082                	ret

0000000080001f3a <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001f3a:	711d                	addi	sp,sp,-96
    80001f3c:	ec86                	sd	ra,88(sp)
    80001f3e:	e8a2                	sd	s0,80(sp)
    80001f40:	1080                	addi	s0,sp,96
    80001f42:	fca43423          	sd	a0,-56(s0)
    80001f46:	fcb43023          	sd	a1,-64(s0)
    80001f4a:	fac43c23          	sd	a2,-72(s0)
    80001f4e:	fad43823          	sd	a3,-80(s0)
    80001f52:	87ba                	mv	a5,a4
    80001f54:	faf42623          	sw	a5,-84(s0)
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80001f58:	fb843783          	ld	a5,-72(s0)
    80001f5c:	eb89                	bnez	a5,80001f6e <mappages+0x34>
    panic("mappages: size");
    80001f5e:	0000b517          	auipc	a0,0xb
    80001f62:	18250513          	addi	a0,a0,386 # 8000d0e0 <etext+0xe0>
    80001f66:	fffff097          	auipc	ra,0xfffff
    80001f6a:	d22080e7          	jalr	-734(ra) # 80000c88 <panic>
  
  a = PGROUNDDOWN(va);
    80001f6e:	fc043703          	ld	a4,-64(s0)
    80001f72:	77fd                	lui	a5,0xfffff
    80001f74:	8ff9                	and	a5,a5,a4
    80001f76:	fef43423          	sd	a5,-24(s0)
  last = PGROUNDDOWN(va + size - 1);
    80001f7a:	fc043703          	ld	a4,-64(s0)
    80001f7e:	fb843783          	ld	a5,-72(s0)
    80001f82:	97ba                	add	a5,a5,a4
    80001f84:	fff78713          	addi	a4,a5,-1 # ffffffffffffefff <end+0xffffffff7ffd42ef>
    80001f88:	77fd                	lui	a5,0xfffff
    80001f8a:	8ff9                	and	a5,a5,a4
    80001f8c:	fef43023          	sd	a5,-32(s0)
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80001f90:	4605                	li	a2,1
    80001f92:	fe843583          	ld	a1,-24(s0)
    80001f96:	fc843503          	ld	a0,-56(s0)
    80001f9a:	00000097          	auipc	ra,0x0
    80001f9e:	de8080e7          	jalr	-536(ra) # 80001d82 <walk>
    80001fa2:	fca43c23          	sd	a0,-40(s0)
    80001fa6:	fd843783          	ld	a5,-40(s0)
    80001faa:	e399                	bnez	a5,80001fb0 <mappages+0x76>
      return -1;
    80001fac:	57fd                	li	a5,-1
    80001fae:	a085                	j	8000200e <mappages+0xd4>
    if(*pte & PTE_V)
    80001fb0:	fd843783          	ld	a5,-40(s0)
    80001fb4:	639c                	ld	a5,0(a5)
    80001fb6:	8b85                	andi	a5,a5,1
    80001fb8:	cb89                	beqz	a5,80001fca <mappages+0x90>
      panic("mappages: remap");
    80001fba:	0000b517          	auipc	a0,0xb
    80001fbe:	13650513          	addi	a0,a0,310 # 8000d0f0 <etext+0xf0>
    80001fc2:	fffff097          	auipc	ra,0xfffff
    80001fc6:	cc6080e7          	jalr	-826(ra) # 80000c88 <panic>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001fca:	fb043783          	ld	a5,-80(s0)
    80001fce:	83b1                	srli	a5,a5,0xc
    80001fd0:	00a79713          	slli	a4,a5,0xa
    80001fd4:	fac42783          	lw	a5,-84(s0)
    80001fd8:	8fd9                	or	a5,a5,a4
    80001fda:	0017e713          	ori	a4,a5,1
    80001fde:	fd843783          	ld	a5,-40(s0)
    80001fe2:	e398                	sd	a4,0(a5)
    if(a == last)
    80001fe4:	fe843703          	ld	a4,-24(s0)
    80001fe8:	fe043783          	ld	a5,-32(s0)
    80001fec:	00f70f63          	beq	a4,a5,8000200a <mappages+0xd0>
      break;
    a += PGSIZE;
    80001ff0:	fe843703          	ld	a4,-24(s0)
    80001ff4:	6785                	lui	a5,0x1
    80001ff6:	97ba                	add	a5,a5,a4
    80001ff8:	fef43423          	sd	a5,-24(s0)
    pa += PGSIZE;
    80001ffc:	fb043703          	ld	a4,-80(s0)
    80002000:	6785                	lui	a5,0x1
    80002002:	97ba                	add	a5,a5,a4
    80002004:	faf43823          	sd	a5,-80(s0)
    if((pte = walk(pagetable, a, 1)) == 0)
    80002008:	b761                	j	80001f90 <mappages+0x56>
      break;
    8000200a:	0001                	nop
  }
  return 0;
    8000200c:	4781                	li	a5,0
}
    8000200e:	853e                	mv	a0,a5
    80002010:	60e6                	ld	ra,88(sp)
    80002012:	6446                	ld	s0,80(sp)
    80002014:	6125                	addi	sp,sp,96
    80002016:	8082                	ret

0000000080002018 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80002018:	715d                	addi	sp,sp,-80
    8000201a:	e486                	sd	ra,72(sp)
    8000201c:	e0a2                	sd	s0,64(sp)
    8000201e:	0880                	addi	s0,sp,80
    80002020:	fca43423          	sd	a0,-56(s0)
    80002024:	fcb43023          	sd	a1,-64(s0)
    80002028:	fac43c23          	sd	a2,-72(s0)
    8000202c:	87b6                	mv	a5,a3
    8000202e:	faf42a23          	sw	a5,-76(s0)
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80002032:	fc043703          	ld	a4,-64(s0)
    80002036:	6785                	lui	a5,0x1
    80002038:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000203a:	8ff9                	and	a5,a5,a4
    8000203c:	cb89                	beqz	a5,8000204e <uvmunmap+0x36>
    panic("uvmunmap: not aligned");
    8000203e:	0000b517          	auipc	a0,0xb
    80002042:	0c250513          	addi	a0,a0,194 # 8000d100 <etext+0x100>
    80002046:	fffff097          	auipc	ra,0xfffff
    8000204a:	c42080e7          	jalr	-958(ra) # 80000c88 <panic>

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000204e:	fc043783          	ld	a5,-64(s0)
    80002052:	fef43423          	sd	a5,-24(s0)
    80002056:	a045                	j	800020f6 <uvmunmap+0xde>
    if((pte = walk(pagetable, a, 0)) == 0)
    80002058:	4601                	li	a2,0
    8000205a:	fe843583          	ld	a1,-24(s0)
    8000205e:	fc843503          	ld	a0,-56(s0)
    80002062:	00000097          	auipc	ra,0x0
    80002066:	d20080e7          	jalr	-736(ra) # 80001d82 <walk>
    8000206a:	fea43023          	sd	a0,-32(s0)
    8000206e:	fe043783          	ld	a5,-32(s0)
    80002072:	eb89                	bnez	a5,80002084 <uvmunmap+0x6c>
      panic("uvmunmap: walk");
    80002074:	0000b517          	auipc	a0,0xb
    80002078:	0a450513          	addi	a0,a0,164 # 8000d118 <etext+0x118>
    8000207c:	fffff097          	auipc	ra,0xfffff
    80002080:	c0c080e7          	jalr	-1012(ra) # 80000c88 <panic>
    if((*pte & PTE_V) == 0)
    80002084:	fe043783          	ld	a5,-32(s0)
    80002088:	639c                	ld	a5,0(a5)
    8000208a:	8b85                	andi	a5,a5,1
    8000208c:	eb89                	bnez	a5,8000209e <uvmunmap+0x86>
      panic("uvmunmap: not mapped");
    8000208e:	0000b517          	auipc	a0,0xb
    80002092:	09a50513          	addi	a0,a0,154 # 8000d128 <etext+0x128>
    80002096:	fffff097          	auipc	ra,0xfffff
    8000209a:	bf2080e7          	jalr	-1038(ra) # 80000c88 <panic>
    if(PTE_FLAGS(*pte) == PTE_V)
    8000209e:	fe043783          	ld	a5,-32(s0)
    800020a2:	639c                	ld	a5,0(a5)
    800020a4:	3ff7f713          	andi	a4,a5,1023
    800020a8:	4785                	li	a5,1
    800020aa:	00f71a63          	bne	a4,a5,800020be <uvmunmap+0xa6>
      panic("uvmunmap: not a leaf");
    800020ae:	0000b517          	auipc	a0,0xb
    800020b2:	09250513          	addi	a0,a0,146 # 8000d140 <etext+0x140>
    800020b6:	fffff097          	auipc	ra,0xfffff
    800020ba:	bd2080e7          	jalr	-1070(ra) # 80000c88 <panic>
    if(do_free){
    800020be:	fb442783          	lw	a5,-76(s0)
    800020c2:	2781                	sext.w	a5,a5
    800020c4:	cf99                	beqz	a5,800020e2 <uvmunmap+0xca>
      uint64 pa = PTE2PA(*pte);
    800020c6:	fe043783          	ld	a5,-32(s0)
    800020ca:	639c                	ld	a5,0(a5)
    800020cc:	83a9                	srli	a5,a5,0xa
    800020ce:	07b2                	slli	a5,a5,0xc
    800020d0:	fcf43c23          	sd	a5,-40(s0)
      kfree((void*)pa);
    800020d4:	fd843783          	ld	a5,-40(s0)
    800020d8:	853e                	mv	a0,a5
    800020da:	fffff097          	auipc	ra,0xfffff
    800020de:	05c080e7          	jalr	92(ra) # 80001136 <kfree>
    }
    *pte = 0;
    800020e2:	fe043783          	ld	a5,-32(s0)
    800020e6:	0007b023          	sd	zero,0(a5)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800020ea:	fe843703          	ld	a4,-24(s0)
    800020ee:	6785                	lui	a5,0x1
    800020f0:	97ba                	add	a5,a5,a4
    800020f2:	fef43423          	sd	a5,-24(s0)
    800020f6:	fb843783          	ld	a5,-72(s0)
    800020fa:	00c79713          	slli	a4,a5,0xc
    800020fe:	fc043783          	ld	a5,-64(s0)
    80002102:	97ba                	add	a5,a5,a4
    80002104:	fe843703          	ld	a4,-24(s0)
    80002108:	f4f768e3          	bltu	a4,a5,80002058 <uvmunmap+0x40>
  }
}
    8000210c:	0001                	nop
    8000210e:	0001                	nop
    80002110:	60a6                	ld	ra,72(sp)
    80002112:	6406                	ld	s0,64(sp)
    80002114:	6161                	addi	sp,sp,80
    80002116:	8082                	ret

0000000080002118 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80002118:	1101                	addi	sp,sp,-32
    8000211a:	ec06                	sd	ra,24(sp)
    8000211c:	e822                	sd	s0,16(sp)
    8000211e:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80002120:	fffff097          	auipc	ra,0xfffff
    80002124:	0bc080e7          	jalr	188(ra) # 800011dc <kalloc>
    80002128:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    8000212c:	fe843783          	ld	a5,-24(s0)
    80002130:	e399                	bnez	a5,80002136 <uvmcreate+0x1e>
    return 0;
    80002132:	4781                	li	a5,0
    80002134:	a819                	j	8000214a <uvmcreate+0x32>
  memset(pagetable, 0, PGSIZE);
    80002136:	6605                	lui	a2,0x1
    80002138:	4581                	li	a1,0
    8000213a:	fe843503          	ld	a0,-24(s0)
    8000213e:	fffff097          	auipc	ra,0xfffff
    80002142:	3c6080e7          	jalr	966(ra) # 80001504 <memset>
  return pagetable;
    80002146:	fe843783          	ld	a5,-24(s0)
}
    8000214a:	853e                	mv	a0,a5
    8000214c:	60e2                	ld	ra,24(sp)
    8000214e:	6442                	ld	s0,16(sp)
    80002150:	6105                	addi	sp,sp,32
    80002152:	8082                	ret

0000000080002154 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80002154:	7139                	addi	sp,sp,-64
    80002156:	fc06                	sd	ra,56(sp)
    80002158:	f822                	sd	s0,48(sp)
    8000215a:	0080                	addi	s0,sp,64
    8000215c:	fca43c23          	sd	a0,-40(s0)
    80002160:	fcb43823          	sd	a1,-48(s0)
    80002164:	87b2                	mv	a5,a2
    80002166:	fcf42623          	sw	a5,-52(s0)
  char *mem;

  if(sz >= PGSIZE)
    8000216a:	fcc42783          	lw	a5,-52(s0)
    8000216e:	0007871b          	sext.w	a4,a5
    80002172:	6785                	lui	a5,0x1
    80002174:	00f76a63          	bltu	a4,a5,80002188 <uvmfirst+0x34>
    panic("uvmfirst: more than a page");
    80002178:	0000b517          	auipc	a0,0xb
    8000217c:	fe050513          	addi	a0,a0,-32 # 8000d158 <etext+0x158>
    80002180:	fffff097          	auipc	ra,0xfffff
    80002184:	b08080e7          	jalr	-1272(ra) # 80000c88 <panic>
  mem = kalloc();
    80002188:	fffff097          	auipc	ra,0xfffff
    8000218c:	054080e7          	jalr	84(ra) # 800011dc <kalloc>
    80002190:	fea43423          	sd	a0,-24(s0)
  memset(mem, 0, PGSIZE);
    80002194:	6605                	lui	a2,0x1
    80002196:	4581                	li	a1,0
    80002198:	fe843503          	ld	a0,-24(s0)
    8000219c:	fffff097          	auipc	ra,0xfffff
    800021a0:	368080e7          	jalr	872(ra) # 80001504 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    800021a4:	fe843783          	ld	a5,-24(s0)
    800021a8:	4779                	li	a4,30
    800021aa:	86be                	mv	a3,a5
    800021ac:	6605                	lui	a2,0x1
    800021ae:	4581                	li	a1,0
    800021b0:	fd843503          	ld	a0,-40(s0)
    800021b4:	00000097          	auipc	ra,0x0
    800021b8:	d86080e7          	jalr	-634(ra) # 80001f3a <mappages>
  memmove(mem, src, sz);
    800021bc:	fcc42783          	lw	a5,-52(s0)
    800021c0:	863e                	mv	a2,a5
    800021c2:	fd043583          	ld	a1,-48(s0)
    800021c6:	fe843503          	ld	a0,-24(s0)
    800021ca:	fffff097          	auipc	ra,0xfffff
    800021ce:	41e080e7          	jalr	1054(ra) # 800015e8 <memmove>
}
    800021d2:	0001                	nop
    800021d4:	70e2                	ld	ra,56(sp)
    800021d6:	7442                	ld	s0,48(sp)
    800021d8:	6121                	addi	sp,sp,64
    800021da:	8082                	ret

00000000800021dc <uvmalloc>:

// Allocate PTEs and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz, int xperm)
{
    800021dc:	7139                	addi	sp,sp,-64
    800021de:	fc06                	sd	ra,56(sp)
    800021e0:	f822                	sd	s0,48(sp)
    800021e2:	0080                	addi	s0,sp,64
    800021e4:	fca43c23          	sd	a0,-40(s0)
    800021e8:	fcb43823          	sd	a1,-48(s0)
    800021ec:	fcc43423          	sd	a2,-56(s0)
    800021f0:	87b6                	mv	a5,a3
    800021f2:	fcf42223          	sw	a5,-60(s0)
  char *mem;
  uint64 a;

  if(newsz < oldsz)
    800021f6:	fc843703          	ld	a4,-56(s0)
    800021fa:	fd043783          	ld	a5,-48(s0)
    800021fe:	00f77563          	bgeu	a4,a5,80002208 <uvmalloc+0x2c>
    return oldsz;
    80002202:	fd043783          	ld	a5,-48(s0)
    80002206:	a87d                	j	800022c4 <uvmalloc+0xe8>

  oldsz = PGROUNDUP(oldsz);
    80002208:	fd043703          	ld	a4,-48(s0)
    8000220c:	6785                	lui	a5,0x1
    8000220e:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80002210:	973e                	add	a4,a4,a5
    80002212:	77fd                	lui	a5,0xfffff
    80002214:	8ff9                	and	a5,a5,a4
    80002216:	fcf43823          	sd	a5,-48(s0)
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000221a:	fd043783          	ld	a5,-48(s0)
    8000221e:	fef43423          	sd	a5,-24(s0)
    80002222:	a849                	j	800022b4 <uvmalloc+0xd8>
    mem = kalloc();
    80002224:	fffff097          	auipc	ra,0xfffff
    80002228:	fb8080e7          	jalr	-72(ra) # 800011dc <kalloc>
    8000222c:	fea43023          	sd	a0,-32(s0)
    if(mem == 0){
    80002230:	fe043783          	ld	a5,-32(s0)
    80002234:	ef89                	bnez	a5,8000224e <uvmalloc+0x72>
      uvmdealloc(pagetable, a, oldsz);
    80002236:	fd043603          	ld	a2,-48(s0)
    8000223a:	fe843583          	ld	a1,-24(s0)
    8000223e:	fd843503          	ld	a0,-40(s0)
    80002242:	00000097          	auipc	ra,0x0
    80002246:	08c080e7          	jalr	140(ra) # 800022ce <uvmdealloc>
      return 0;
    8000224a:	4781                	li	a5,0
    8000224c:	a8a5                	j	800022c4 <uvmalloc+0xe8>
    }
    memset(mem, 0, PGSIZE);
    8000224e:	6605                	lui	a2,0x1
    80002250:	4581                	li	a1,0
    80002252:	fe043503          	ld	a0,-32(s0)
    80002256:	fffff097          	auipc	ra,0xfffff
    8000225a:	2ae080e7          	jalr	686(ra) # 80001504 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000225e:	fe043783          	ld	a5,-32(s0)
    80002262:	fc442703          	lw	a4,-60(s0)
    80002266:	01276713          	ori	a4,a4,18
    8000226a:	2701                	sext.w	a4,a4
    8000226c:	86be                	mv	a3,a5
    8000226e:	6605                	lui	a2,0x1
    80002270:	fe843583          	ld	a1,-24(s0)
    80002274:	fd843503          	ld	a0,-40(s0)
    80002278:	00000097          	auipc	ra,0x0
    8000227c:	cc2080e7          	jalr	-830(ra) # 80001f3a <mappages>
    80002280:	87aa                	mv	a5,a0
    80002282:	c39d                	beqz	a5,800022a8 <uvmalloc+0xcc>
      kfree(mem);
    80002284:	fe043503          	ld	a0,-32(s0)
    80002288:	fffff097          	auipc	ra,0xfffff
    8000228c:	eae080e7          	jalr	-338(ra) # 80001136 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80002290:	fd043603          	ld	a2,-48(s0)
    80002294:	fe843583          	ld	a1,-24(s0)
    80002298:	fd843503          	ld	a0,-40(s0)
    8000229c:	00000097          	auipc	ra,0x0
    800022a0:	032080e7          	jalr	50(ra) # 800022ce <uvmdealloc>
      return 0;
    800022a4:	4781                	li	a5,0
    800022a6:	a839                	j	800022c4 <uvmalloc+0xe8>
  for(a = oldsz; a < newsz; a += PGSIZE){
    800022a8:	fe843703          	ld	a4,-24(s0)
    800022ac:	6785                	lui	a5,0x1
    800022ae:	97ba                	add	a5,a5,a4
    800022b0:	fef43423          	sd	a5,-24(s0)
    800022b4:	fe843703          	ld	a4,-24(s0)
    800022b8:	fc843783          	ld	a5,-56(s0)
    800022bc:	f6f764e3          	bltu	a4,a5,80002224 <uvmalloc+0x48>
    }
  }
  return newsz;
    800022c0:	fc843783          	ld	a5,-56(s0)
}
    800022c4:	853e                	mv	a0,a5
    800022c6:	70e2                	ld	ra,56(sp)
    800022c8:	7442                	ld	s0,48(sp)
    800022ca:	6121                	addi	sp,sp,64
    800022cc:	8082                	ret

00000000800022ce <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800022ce:	7139                	addi	sp,sp,-64
    800022d0:	fc06                	sd	ra,56(sp)
    800022d2:	f822                	sd	s0,48(sp)
    800022d4:	0080                	addi	s0,sp,64
    800022d6:	fca43c23          	sd	a0,-40(s0)
    800022da:	fcb43823          	sd	a1,-48(s0)
    800022de:	fcc43423          	sd	a2,-56(s0)
  if(newsz >= oldsz)
    800022e2:	fc843703          	ld	a4,-56(s0)
    800022e6:	fd043783          	ld	a5,-48(s0)
    800022ea:	00f76563          	bltu	a4,a5,800022f4 <uvmdealloc+0x26>
    return oldsz;
    800022ee:	fd043783          	ld	a5,-48(s0)
    800022f2:	a885                	j	80002362 <uvmdealloc+0x94>

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800022f4:	fc843703          	ld	a4,-56(s0)
    800022f8:	6785                	lui	a5,0x1
    800022fa:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800022fc:	973e                	add	a4,a4,a5
    800022fe:	77fd                	lui	a5,0xfffff
    80002300:	8f7d                	and	a4,a4,a5
    80002302:	fd043683          	ld	a3,-48(s0)
    80002306:	6785                	lui	a5,0x1
    80002308:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000230a:	96be                	add	a3,a3,a5
    8000230c:	77fd                	lui	a5,0xfffff
    8000230e:	8ff5                	and	a5,a5,a3
    80002310:	04f77763          	bgeu	a4,a5,8000235e <uvmdealloc+0x90>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80002314:	fd043703          	ld	a4,-48(s0)
    80002318:	6785                	lui	a5,0x1
    8000231a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000231c:	973e                	add	a4,a4,a5
    8000231e:	77fd                	lui	a5,0xfffff
    80002320:	8f7d                	and	a4,a4,a5
    80002322:	fc843683          	ld	a3,-56(s0)
    80002326:	6785                	lui	a5,0x1
    80002328:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000232a:	96be                	add	a3,a3,a5
    8000232c:	77fd                	lui	a5,0xfffff
    8000232e:	8ff5                	and	a5,a5,a3
    80002330:	40f707b3          	sub	a5,a4,a5
    80002334:	83b1                	srli	a5,a5,0xc
    80002336:	fef42623          	sw	a5,-20(s0)
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    8000233a:	fc843703          	ld	a4,-56(s0)
    8000233e:	6785                	lui	a5,0x1
    80002340:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80002342:	973e                	add	a4,a4,a5
    80002344:	77fd                	lui	a5,0xfffff
    80002346:	8ff9                	and	a5,a5,a4
    80002348:	fec42703          	lw	a4,-20(s0)
    8000234c:	4685                	li	a3,1
    8000234e:	863a                	mv	a2,a4
    80002350:	85be                	mv	a1,a5
    80002352:	fd843503          	ld	a0,-40(s0)
    80002356:	00000097          	auipc	ra,0x0
    8000235a:	cc2080e7          	jalr	-830(ra) # 80002018 <uvmunmap>
  }

  return newsz;
    8000235e:	fc843783          	ld	a5,-56(s0)
}
    80002362:	853e                	mv	a0,a5
    80002364:	70e2                	ld	ra,56(sp)
    80002366:	7442                	ld	s0,48(sp)
    80002368:	6121                	addi	sp,sp,64
    8000236a:	8082                	ret

000000008000236c <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000236c:	7139                	addi	sp,sp,-64
    8000236e:	fc06                	sd	ra,56(sp)
    80002370:	f822                	sd	s0,48(sp)
    80002372:	0080                	addi	s0,sp,64
    80002374:	fca43423          	sd	a0,-56(s0)
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80002378:	fe042623          	sw	zero,-20(s0)
    8000237c:	a88d                	j	800023ee <freewalk+0x82>
    pte_t pte = pagetable[i];
    8000237e:	fec42783          	lw	a5,-20(s0)
    80002382:	078e                	slli	a5,a5,0x3
    80002384:	fc843703          	ld	a4,-56(s0)
    80002388:	97ba                	add	a5,a5,a4
    8000238a:	639c                	ld	a5,0(a5)
    8000238c:	fef43023          	sd	a5,-32(s0)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80002390:	fe043783          	ld	a5,-32(s0)
    80002394:	8b85                	andi	a5,a5,1
    80002396:	cb9d                	beqz	a5,800023cc <freewalk+0x60>
    80002398:	fe043783          	ld	a5,-32(s0)
    8000239c:	8bb9                	andi	a5,a5,14
    8000239e:	e79d                	bnez	a5,800023cc <freewalk+0x60>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800023a0:	fe043783          	ld	a5,-32(s0)
    800023a4:	83a9                	srli	a5,a5,0xa
    800023a6:	07b2                	slli	a5,a5,0xc
    800023a8:	fcf43c23          	sd	a5,-40(s0)
      freewalk((pagetable_t)child);
    800023ac:	fd843783          	ld	a5,-40(s0)
    800023b0:	853e                	mv	a0,a5
    800023b2:	00000097          	auipc	ra,0x0
    800023b6:	fba080e7          	jalr	-70(ra) # 8000236c <freewalk>
      pagetable[i] = 0;
    800023ba:	fec42783          	lw	a5,-20(s0)
    800023be:	078e                	slli	a5,a5,0x3
    800023c0:	fc843703          	ld	a4,-56(s0)
    800023c4:	97ba                	add	a5,a5,a4
    800023c6:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ffd42f0>
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800023ca:	a829                	j	800023e4 <freewalk+0x78>
    } else if(pte & PTE_V){
    800023cc:	fe043783          	ld	a5,-32(s0)
    800023d0:	8b85                	andi	a5,a5,1
    800023d2:	cb89                	beqz	a5,800023e4 <freewalk+0x78>
      panic("freewalk: leaf");
    800023d4:	0000b517          	auipc	a0,0xb
    800023d8:	da450513          	addi	a0,a0,-604 # 8000d178 <etext+0x178>
    800023dc:	fffff097          	auipc	ra,0xfffff
    800023e0:	8ac080e7          	jalr	-1876(ra) # 80000c88 <panic>
  for(int i = 0; i < 512; i++){
    800023e4:	fec42783          	lw	a5,-20(s0)
    800023e8:	2785                	addiw	a5,a5,1
    800023ea:	fef42623          	sw	a5,-20(s0)
    800023ee:	fec42783          	lw	a5,-20(s0)
    800023f2:	0007871b          	sext.w	a4,a5
    800023f6:	1ff00793          	li	a5,511
    800023fa:	f8e7d2e3          	bge	a5,a4,8000237e <freewalk+0x12>
    }
  }
  kfree((void*)pagetable);
    800023fe:	fc843503          	ld	a0,-56(s0)
    80002402:	fffff097          	auipc	ra,0xfffff
    80002406:	d34080e7          	jalr	-716(ra) # 80001136 <kfree>
}
    8000240a:	0001                	nop
    8000240c:	70e2                	ld	ra,56(sp)
    8000240e:	7442                	ld	s0,48(sp)
    80002410:	6121                	addi	sp,sp,64
    80002412:	8082                	ret

0000000080002414 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80002414:	1101                	addi	sp,sp,-32
    80002416:	ec06                	sd	ra,24(sp)
    80002418:	e822                	sd	s0,16(sp)
    8000241a:	1000                	addi	s0,sp,32
    8000241c:	fea43423          	sd	a0,-24(s0)
    80002420:	feb43023          	sd	a1,-32(s0)
  if(sz > 0)
    80002424:	fe043783          	ld	a5,-32(s0)
    80002428:	c385                	beqz	a5,80002448 <uvmfree+0x34>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    8000242a:	fe043703          	ld	a4,-32(s0)
    8000242e:	6785                	lui	a5,0x1
    80002430:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80002432:	97ba                	add	a5,a5,a4
    80002434:	83b1                	srli	a5,a5,0xc
    80002436:	4685                	li	a3,1
    80002438:	863e                	mv	a2,a5
    8000243a:	4581                	li	a1,0
    8000243c:	fe843503          	ld	a0,-24(s0)
    80002440:	00000097          	auipc	ra,0x0
    80002444:	bd8080e7          	jalr	-1064(ra) # 80002018 <uvmunmap>
  freewalk(pagetable);
    80002448:	fe843503          	ld	a0,-24(s0)
    8000244c:	00000097          	auipc	ra,0x0
    80002450:	f20080e7          	jalr	-224(ra) # 8000236c <freewalk>
}
    80002454:	0001                	nop
    80002456:	60e2                	ld	ra,24(sp)
    80002458:	6442                	ld	s0,16(sp)
    8000245a:	6105                	addi	sp,sp,32
    8000245c:	8082                	ret

000000008000245e <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    8000245e:	711d                	addi	sp,sp,-96
    80002460:	ec86                	sd	ra,88(sp)
    80002462:	e8a2                	sd	s0,80(sp)
    80002464:	1080                	addi	s0,sp,96
    80002466:	faa43c23          	sd	a0,-72(s0)
    8000246a:	fab43823          	sd	a1,-80(s0)
    8000246e:	fac43423          	sd	a2,-88(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80002472:	fe043423          	sd	zero,-24(s0)
    80002476:	a0d9                	j	8000253c <uvmcopy+0xde>
    if((pte = walk(old, i, 0)) == 0)
    80002478:	4601                	li	a2,0
    8000247a:	fe843583          	ld	a1,-24(s0)
    8000247e:	fb843503          	ld	a0,-72(s0)
    80002482:	00000097          	auipc	ra,0x0
    80002486:	900080e7          	jalr	-1792(ra) # 80001d82 <walk>
    8000248a:	fea43023          	sd	a0,-32(s0)
    8000248e:	fe043783          	ld	a5,-32(s0)
    80002492:	eb89                	bnez	a5,800024a4 <uvmcopy+0x46>
      panic("uvmcopy: pte should exist");
    80002494:	0000b517          	auipc	a0,0xb
    80002498:	cf450513          	addi	a0,a0,-780 # 8000d188 <etext+0x188>
    8000249c:	ffffe097          	auipc	ra,0xffffe
    800024a0:	7ec080e7          	jalr	2028(ra) # 80000c88 <panic>
    if((*pte & PTE_V) == 0)
    800024a4:	fe043783          	ld	a5,-32(s0)
    800024a8:	639c                	ld	a5,0(a5)
    800024aa:	8b85                	andi	a5,a5,1
    800024ac:	eb89                	bnez	a5,800024be <uvmcopy+0x60>
      panic("uvmcopy: page not present");
    800024ae:	0000b517          	auipc	a0,0xb
    800024b2:	cfa50513          	addi	a0,a0,-774 # 8000d1a8 <etext+0x1a8>
    800024b6:	ffffe097          	auipc	ra,0xffffe
    800024ba:	7d2080e7          	jalr	2002(ra) # 80000c88 <panic>
    pa = PTE2PA(*pte);
    800024be:	fe043783          	ld	a5,-32(s0)
    800024c2:	639c                	ld	a5,0(a5)
    800024c4:	83a9                	srli	a5,a5,0xa
    800024c6:	07b2                	slli	a5,a5,0xc
    800024c8:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    800024cc:	fe043783          	ld	a5,-32(s0)
    800024d0:	639c                	ld	a5,0(a5)
    800024d2:	2781                	sext.w	a5,a5
    800024d4:	3ff7f793          	andi	a5,a5,1023
    800024d8:	fcf42a23          	sw	a5,-44(s0)
    if((mem = kalloc()) == 0)
    800024dc:	fffff097          	auipc	ra,0xfffff
    800024e0:	d00080e7          	jalr	-768(ra) # 800011dc <kalloc>
    800024e4:	fca43423          	sd	a0,-56(s0)
    800024e8:	fc843783          	ld	a5,-56(s0)
    800024ec:	c3a5                	beqz	a5,8000254c <uvmcopy+0xee>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800024ee:	fd843783          	ld	a5,-40(s0)
    800024f2:	6605                	lui	a2,0x1
    800024f4:	85be                	mv	a1,a5
    800024f6:	fc843503          	ld	a0,-56(s0)
    800024fa:	fffff097          	auipc	ra,0xfffff
    800024fe:	0ee080e7          	jalr	238(ra) # 800015e8 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80002502:	fc843783          	ld	a5,-56(s0)
    80002506:	fd442703          	lw	a4,-44(s0)
    8000250a:	86be                	mv	a3,a5
    8000250c:	6605                	lui	a2,0x1
    8000250e:	fe843583          	ld	a1,-24(s0)
    80002512:	fb043503          	ld	a0,-80(s0)
    80002516:	00000097          	auipc	ra,0x0
    8000251a:	a24080e7          	jalr	-1500(ra) # 80001f3a <mappages>
    8000251e:	87aa                	mv	a5,a0
    80002520:	cb81                	beqz	a5,80002530 <uvmcopy+0xd2>
      kfree(mem);
    80002522:	fc843503          	ld	a0,-56(s0)
    80002526:	fffff097          	auipc	ra,0xfffff
    8000252a:	c10080e7          	jalr	-1008(ra) # 80001136 <kfree>
      goto err;
    8000252e:	a005                	j	8000254e <uvmcopy+0xf0>
  for(i = 0; i < sz; i += PGSIZE){
    80002530:	fe843703          	ld	a4,-24(s0)
    80002534:	6785                	lui	a5,0x1
    80002536:	97ba                	add	a5,a5,a4
    80002538:	fef43423          	sd	a5,-24(s0)
    8000253c:	fe843703          	ld	a4,-24(s0)
    80002540:	fa843783          	ld	a5,-88(s0)
    80002544:	f2f76ae3          	bltu	a4,a5,80002478 <uvmcopy+0x1a>
    }
  }
  return 0;
    80002548:	4781                	li	a5,0
    8000254a:	a839                	j	80002568 <uvmcopy+0x10a>
      goto err;
    8000254c:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    8000254e:	fe843783          	ld	a5,-24(s0)
    80002552:	83b1                	srli	a5,a5,0xc
    80002554:	4685                	li	a3,1
    80002556:	863e                	mv	a2,a5
    80002558:	4581                	li	a1,0
    8000255a:	fb043503          	ld	a0,-80(s0)
    8000255e:	00000097          	auipc	ra,0x0
    80002562:	aba080e7          	jalr	-1350(ra) # 80002018 <uvmunmap>
  return -1;
    80002566:	57fd                	li	a5,-1
}
    80002568:	853e                	mv	a0,a5
    8000256a:	60e6                	ld	ra,88(sp)
    8000256c:	6446                	ld	s0,80(sp)
    8000256e:	6125                	addi	sp,sp,96
    80002570:	8082                	ret

0000000080002572 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80002572:	7179                	addi	sp,sp,-48
    80002574:	f406                	sd	ra,40(sp)
    80002576:	f022                	sd	s0,32(sp)
    80002578:	1800                	addi	s0,sp,48
    8000257a:	fca43c23          	sd	a0,-40(s0)
    8000257e:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80002582:	4601                	li	a2,0
    80002584:	fd043583          	ld	a1,-48(s0)
    80002588:	fd843503          	ld	a0,-40(s0)
    8000258c:	fffff097          	auipc	ra,0xfffff
    80002590:	7f6080e7          	jalr	2038(ra) # 80001d82 <walk>
    80002594:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    80002598:	fe843783          	ld	a5,-24(s0)
    8000259c:	eb89                	bnez	a5,800025ae <uvmclear+0x3c>
    panic("uvmclear");
    8000259e:	0000b517          	auipc	a0,0xb
    800025a2:	c2a50513          	addi	a0,a0,-982 # 8000d1c8 <etext+0x1c8>
    800025a6:	ffffe097          	auipc	ra,0xffffe
    800025aa:	6e2080e7          	jalr	1762(ra) # 80000c88 <panic>
  *pte &= ~PTE_U;
    800025ae:	fe843783          	ld	a5,-24(s0)
    800025b2:	639c                	ld	a5,0(a5)
    800025b4:	fef7f713          	andi	a4,a5,-17
    800025b8:	fe843783          	ld	a5,-24(s0)
    800025bc:	e398                	sd	a4,0(a5)
}
    800025be:	0001                	nop
    800025c0:	70a2                	ld	ra,40(sp)
    800025c2:	7402                	ld	s0,32(sp)
    800025c4:	6145                	addi	sp,sp,48
    800025c6:	8082                	ret

00000000800025c8 <copyout>:
// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
    800025c8:	715d                	addi	sp,sp,-80
    800025ca:	e486                	sd	ra,72(sp)
    800025cc:	e0a2                	sd	s0,64(sp)
    800025ce:	0880                	addi	s0,sp,80
    800025d0:	fca43423          	sd	a0,-56(s0)
    800025d4:	fcb43023          	sd	a1,-64(s0)
    800025d8:	fac43c23          	sd	a2,-72(s0)
    800025dc:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800025e0:	a055                	j	80002684 <copyout+0xbc>
    va0 = PGROUNDDOWN(dstva);
    800025e2:	fc043703          	ld	a4,-64(s0)
    800025e6:	77fd                	lui	a5,0xfffff
    800025e8:	8ff9                	and	a5,a5,a4
    800025ea:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800025ee:	fe043583          	ld	a1,-32(s0)
    800025f2:	fc843503          	ld	a0,-56(s0)
    800025f6:	00000097          	auipc	ra,0x0
    800025fa:	872080e7          	jalr	-1934(ra) # 80001e68 <walkaddr>
    800025fe:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    80002602:	fd843783          	ld	a5,-40(s0)
    80002606:	e399                	bnez	a5,8000260c <copyout+0x44>
      return -1;
    80002608:	57fd                	li	a5,-1
    8000260a:	a049                	j	8000268c <copyout+0xc4>
    n = PGSIZE - (dstva - va0);
    8000260c:	fe043703          	ld	a4,-32(s0)
    80002610:	fc043783          	ld	a5,-64(s0)
    80002614:	8f1d                	sub	a4,a4,a5
    80002616:	6785                	lui	a5,0x1
    80002618:	97ba                	add	a5,a5,a4
    8000261a:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    8000261e:	fe843703          	ld	a4,-24(s0)
    80002622:	fb043783          	ld	a5,-80(s0)
    80002626:	00e7f663          	bgeu	a5,a4,80002632 <copyout+0x6a>
      n = len;
    8000262a:	fb043783          	ld	a5,-80(s0)
    8000262e:	fef43423          	sd	a5,-24(s0)
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80002632:	fc043703          	ld	a4,-64(s0)
    80002636:	fe043783          	ld	a5,-32(s0)
    8000263a:	8f1d                	sub	a4,a4,a5
    8000263c:	fd843783          	ld	a5,-40(s0)
    80002640:	97ba                	add	a5,a5,a4
    80002642:	873e                	mv	a4,a5
    80002644:	fe843783          	ld	a5,-24(s0)
    80002648:	2781                	sext.w	a5,a5
    8000264a:	863e                	mv	a2,a5
    8000264c:	fb843583          	ld	a1,-72(s0)
    80002650:	853a                	mv	a0,a4
    80002652:	fffff097          	auipc	ra,0xfffff
    80002656:	f96080e7          	jalr	-106(ra) # 800015e8 <memmove>

    len -= n;
    8000265a:	fb043703          	ld	a4,-80(s0)
    8000265e:	fe843783          	ld	a5,-24(s0)
    80002662:	40f707b3          	sub	a5,a4,a5
    80002666:	faf43823          	sd	a5,-80(s0)
    src += n;
    8000266a:	fb843703          	ld	a4,-72(s0)
    8000266e:	fe843783          	ld	a5,-24(s0)
    80002672:	97ba                	add	a5,a5,a4
    80002674:	faf43c23          	sd	a5,-72(s0)
    dstva = va0 + PGSIZE;
    80002678:	fe043703          	ld	a4,-32(s0)
    8000267c:	6785                	lui	a5,0x1
    8000267e:	97ba                	add	a5,a5,a4
    80002680:	fcf43023          	sd	a5,-64(s0)
  while(len > 0){
    80002684:	fb043783          	ld	a5,-80(s0)
    80002688:	ffa9                	bnez	a5,800025e2 <copyout+0x1a>
  }
  return 0;
    8000268a:	4781                	li	a5,0
}
    8000268c:	853e                	mv	a0,a5
    8000268e:	60a6                	ld	ra,72(sp)
    80002690:	6406                	ld	s0,64(sp)
    80002692:	6161                	addi	sp,sp,80
    80002694:	8082                	ret

0000000080002696 <copyin>:
// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
    80002696:	715d                	addi	sp,sp,-80
    80002698:	e486                	sd	ra,72(sp)
    8000269a:	e0a2                	sd	s0,64(sp)
    8000269c:	0880                	addi	s0,sp,80
    8000269e:	fca43423          	sd	a0,-56(s0)
    800026a2:	fcb43023          	sd	a1,-64(s0)
    800026a6:	fac43c23          	sd	a2,-72(s0)
    800026aa:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800026ae:	a055                	j	80002752 <copyin+0xbc>
    va0 = PGROUNDDOWN(srcva);
    800026b0:	fb843703          	ld	a4,-72(s0)
    800026b4:	77fd                	lui	a5,0xfffff
    800026b6:	8ff9                	and	a5,a5,a4
    800026b8:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800026bc:	fe043583          	ld	a1,-32(s0)
    800026c0:	fc843503          	ld	a0,-56(s0)
    800026c4:	fffff097          	auipc	ra,0xfffff
    800026c8:	7a4080e7          	jalr	1956(ra) # 80001e68 <walkaddr>
    800026cc:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    800026d0:	fd843783          	ld	a5,-40(s0)
    800026d4:	e399                	bnez	a5,800026da <copyin+0x44>
      return -1;
    800026d6:	57fd                	li	a5,-1
    800026d8:	a049                	j	8000275a <copyin+0xc4>
    n = PGSIZE - (srcva - va0);
    800026da:	fe043703          	ld	a4,-32(s0)
    800026de:	fb843783          	ld	a5,-72(s0)
    800026e2:	8f1d                	sub	a4,a4,a5
    800026e4:	6785                	lui	a5,0x1
    800026e6:	97ba                	add	a5,a5,a4
    800026e8:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    800026ec:	fe843703          	ld	a4,-24(s0)
    800026f0:	fb043783          	ld	a5,-80(s0)
    800026f4:	00e7f663          	bgeu	a5,a4,80002700 <copyin+0x6a>
      n = len;
    800026f8:	fb043783          	ld	a5,-80(s0)
    800026fc:	fef43423          	sd	a5,-24(s0)
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80002700:	fb843703          	ld	a4,-72(s0)
    80002704:	fe043783          	ld	a5,-32(s0)
    80002708:	8f1d                	sub	a4,a4,a5
    8000270a:	fd843783          	ld	a5,-40(s0)
    8000270e:	97ba                	add	a5,a5,a4
    80002710:	873e                	mv	a4,a5
    80002712:	fe843783          	ld	a5,-24(s0)
    80002716:	2781                	sext.w	a5,a5
    80002718:	863e                	mv	a2,a5
    8000271a:	85ba                	mv	a1,a4
    8000271c:	fc043503          	ld	a0,-64(s0)
    80002720:	fffff097          	auipc	ra,0xfffff
    80002724:	ec8080e7          	jalr	-312(ra) # 800015e8 <memmove>

    len -= n;
    80002728:	fb043703          	ld	a4,-80(s0)
    8000272c:	fe843783          	ld	a5,-24(s0)
    80002730:	40f707b3          	sub	a5,a4,a5
    80002734:	faf43823          	sd	a5,-80(s0)
    dst += n;
    80002738:	fc043703          	ld	a4,-64(s0)
    8000273c:	fe843783          	ld	a5,-24(s0)
    80002740:	97ba                	add	a5,a5,a4
    80002742:	fcf43023          	sd	a5,-64(s0)
    srcva = va0 + PGSIZE;
    80002746:	fe043703          	ld	a4,-32(s0)
    8000274a:	6785                	lui	a5,0x1
    8000274c:	97ba                	add	a5,a5,a4
    8000274e:	faf43c23          	sd	a5,-72(s0)
  while(len > 0){
    80002752:	fb043783          	ld	a5,-80(s0)
    80002756:	ffa9                	bnez	a5,800026b0 <copyin+0x1a>
  }
  return 0;
    80002758:	4781                	li	a5,0
}
    8000275a:	853e                	mv	a0,a5
    8000275c:	60a6                	ld	ra,72(sp)
    8000275e:	6406                	ld	s0,64(sp)
    80002760:	6161                	addi	sp,sp,80
    80002762:	8082                	ret

0000000080002764 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80002764:	711d                	addi	sp,sp,-96
    80002766:	ec86                	sd	ra,88(sp)
    80002768:	e8a2                	sd	s0,80(sp)
    8000276a:	1080                	addi	s0,sp,96
    8000276c:	faa43c23          	sd	a0,-72(s0)
    80002770:	fab43823          	sd	a1,-80(s0)
    80002774:	fac43423          	sd	a2,-88(s0)
    80002778:	fad43023          	sd	a3,-96(s0)
  uint64 n, va0, pa0;
  int got_null = 0;
    8000277c:	fe042223          	sw	zero,-28(s0)

  while(got_null == 0 && max > 0){
    80002780:	a0f1                	j	8000284c <copyinstr+0xe8>
    va0 = PGROUNDDOWN(srcva);
    80002782:	fa843703          	ld	a4,-88(s0)
    80002786:	77fd                	lui	a5,0xfffff
    80002788:	8ff9                	and	a5,a5,a4
    8000278a:	fcf43823          	sd	a5,-48(s0)
    pa0 = walkaddr(pagetable, va0);
    8000278e:	fd043583          	ld	a1,-48(s0)
    80002792:	fb843503          	ld	a0,-72(s0)
    80002796:	fffff097          	auipc	ra,0xfffff
    8000279a:	6d2080e7          	jalr	1746(ra) # 80001e68 <walkaddr>
    8000279e:	fca43423          	sd	a0,-56(s0)
    if(pa0 == 0)
    800027a2:	fc843783          	ld	a5,-56(s0)
    800027a6:	e399                	bnez	a5,800027ac <copyinstr+0x48>
      return -1;
    800027a8:	57fd                	li	a5,-1
    800027aa:	a87d                	j	80002868 <copyinstr+0x104>
    n = PGSIZE - (srcva - va0);
    800027ac:	fd043703          	ld	a4,-48(s0)
    800027b0:	fa843783          	ld	a5,-88(s0)
    800027b4:	8f1d                	sub	a4,a4,a5
    800027b6:	6785                	lui	a5,0x1
    800027b8:	97ba                	add	a5,a5,a4
    800027ba:	fef43423          	sd	a5,-24(s0)
    if(n > max)
    800027be:	fe843703          	ld	a4,-24(s0)
    800027c2:	fa043783          	ld	a5,-96(s0)
    800027c6:	00e7f663          	bgeu	a5,a4,800027d2 <copyinstr+0x6e>
      n = max;
    800027ca:	fa043783          	ld	a5,-96(s0)
    800027ce:	fef43423          	sd	a5,-24(s0)

    char *p = (char *) (pa0 + (srcva - va0));
    800027d2:	fa843703          	ld	a4,-88(s0)
    800027d6:	fd043783          	ld	a5,-48(s0)
    800027da:	8f1d                	sub	a4,a4,a5
    800027dc:	fc843783          	ld	a5,-56(s0)
    800027e0:	97ba                	add	a5,a5,a4
    800027e2:	fcf43c23          	sd	a5,-40(s0)
    while(n > 0){
    800027e6:	a891                	j	8000283a <copyinstr+0xd6>
      if(*p == '\0'){
    800027e8:	fd843783          	ld	a5,-40(s0)
    800027ec:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    800027f0:	eb89                	bnez	a5,80002802 <copyinstr+0x9e>
        *dst = '\0';
    800027f2:	fb043783          	ld	a5,-80(s0)
    800027f6:	00078023          	sb	zero,0(a5)
        got_null = 1;
    800027fa:	4785                	li	a5,1
    800027fc:	fef42223          	sw	a5,-28(s0)
        break;
    80002800:	a081                	j	80002840 <copyinstr+0xdc>
      } else {
        *dst = *p;
    80002802:	fd843783          	ld	a5,-40(s0)
    80002806:	0007c703          	lbu	a4,0(a5)
    8000280a:	fb043783          	ld	a5,-80(s0)
    8000280e:	00e78023          	sb	a4,0(a5)
      }
      --n;
    80002812:	fe843783          	ld	a5,-24(s0)
    80002816:	17fd                	addi	a5,a5,-1
    80002818:	fef43423          	sd	a5,-24(s0)
      --max;
    8000281c:	fa043783          	ld	a5,-96(s0)
    80002820:	17fd                	addi	a5,a5,-1
    80002822:	faf43023          	sd	a5,-96(s0)
      p++;
    80002826:	fd843783          	ld	a5,-40(s0)
    8000282a:	0785                	addi	a5,a5,1
    8000282c:	fcf43c23          	sd	a5,-40(s0)
      dst++;
    80002830:	fb043783          	ld	a5,-80(s0)
    80002834:	0785                	addi	a5,a5,1
    80002836:	faf43823          	sd	a5,-80(s0)
    while(n > 0){
    8000283a:	fe843783          	ld	a5,-24(s0)
    8000283e:	f7cd                	bnez	a5,800027e8 <copyinstr+0x84>
    }

    srcva = va0 + PGSIZE;
    80002840:	fd043703          	ld	a4,-48(s0)
    80002844:	6785                	lui	a5,0x1
    80002846:	97ba                	add	a5,a5,a4
    80002848:	faf43423          	sd	a5,-88(s0)
  while(got_null == 0 && max > 0){
    8000284c:	fe442783          	lw	a5,-28(s0)
    80002850:	2781                	sext.w	a5,a5
    80002852:	e781                	bnez	a5,8000285a <copyinstr+0xf6>
    80002854:	fa043783          	ld	a5,-96(s0)
    80002858:	f78d                	bnez	a5,80002782 <copyinstr+0x1e>
  }
  if(got_null){
    8000285a:	fe442783          	lw	a5,-28(s0)
    8000285e:	2781                	sext.w	a5,a5
    80002860:	c399                	beqz	a5,80002866 <copyinstr+0x102>
    return 0;
    80002862:	4781                	li	a5,0
    80002864:	a011                	j	80002868 <copyinstr+0x104>
  } else {
    return -1;
    80002866:	57fd                	li	a5,-1
  }
}
    80002868:	853e                	mv	a0,a5
    8000286a:	60e6                	ld	ra,88(sp)
    8000286c:	6446                	ld	s0,80(sp)
    8000286e:	6125                	addi	sp,sp,96
    80002870:	8082                	ret

0000000080002872 <r_sstatus>:
{
    80002872:	1101                	addi	sp,sp,-32
    80002874:	ec22                	sd	s0,24(sp)
    80002876:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002878:	100027f3          	csrr	a5,sstatus
    8000287c:	fef43423          	sd	a5,-24(s0)
  return x;
    80002880:	fe843783          	ld	a5,-24(s0)
}
    80002884:	853e                	mv	a0,a5
    80002886:	6462                	ld	s0,24(sp)
    80002888:	6105                	addi	sp,sp,32
    8000288a:	8082                	ret

000000008000288c <w_sstatus>:
{
    8000288c:	1101                	addi	sp,sp,-32
    8000288e:	ec22                	sd	s0,24(sp)
    80002890:	1000                	addi	s0,sp,32
    80002892:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002896:	fe843783          	ld	a5,-24(s0)
    8000289a:	10079073          	csrw	sstatus,a5
}
    8000289e:	0001                	nop
    800028a0:	6462                	ld	s0,24(sp)
    800028a2:	6105                	addi	sp,sp,32
    800028a4:	8082                	ret

00000000800028a6 <intr_on>:
{
    800028a6:	1141                	addi	sp,sp,-16
    800028a8:	e406                	sd	ra,8(sp)
    800028aa:	e022                	sd	s0,0(sp)
    800028ac:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800028ae:	00000097          	auipc	ra,0x0
    800028b2:	fc4080e7          	jalr	-60(ra) # 80002872 <r_sstatus>
    800028b6:	87aa                	mv	a5,a0
    800028b8:	0027e793          	ori	a5,a5,2
    800028bc:	853e                	mv	a0,a5
    800028be:	00000097          	auipc	ra,0x0
    800028c2:	fce080e7          	jalr	-50(ra) # 8000288c <w_sstatus>
}
    800028c6:	0001                	nop
    800028c8:	60a2                	ld	ra,8(sp)
    800028ca:	6402                	ld	s0,0(sp)
    800028cc:	0141                	addi	sp,sp,16
    800028ce:	8082                	ret

00000000800028d0 <intr_get>:
{
    800028d0:	1101                	addi	sp,sp,-32
    800028d2:	ec06                	sd	ra,24(sp)
    800028d4:	e822                	sd	s0,16(sp)
    800028d6:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800028d8:	00000097          	auipc	ra,0x0
    800028dc:	f9a080e7          	jalr	-102(ra) # 80002872 <r_sstatus>
    800028e0:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800028e4:	fe843783          	ld	a5,-24(s0)
    800028e8:	8b89                	andi	a5,a5,2
    800028ea:	00f037b3          	snez	a5,a5
    800028ee:	0ff7f793          	zext.b	a5,a5
    800028f2:	2781                	sext.w	a5,a5
}
    800028f4:	853e                	mv	a0,a5
    800028f6:	60e2                	ld	ra,24(sp)
    800028f8:	6442                	ld	s0,16(sp)
    800028fa:	6105                	addi	sp,sp,32
    800028fc:	8082                	ret

00000000800028fe <r_tp>:
{
    800028fe:	1101                	addi	sp,sp,-32
    80002900:	ec22                	sd	s0,24(sp)
    80002902:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80002904:	8792                	mv	a5,tp
    80002906:	fef43423          	sd	a5,-24(s0)
  return x;
    8000290a:	fe843783          	ld	a5,-24(s0)
}
    8000290e:	853e                	mv	a0,a5
    80002910:	6462                	ld	s0,24(sp)
    80002912:	6105                	addi	sp,sp,32
    80002914:	8082                	ret

0000000080002916 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80002916:	7139                	addi	sp,sp,-64
    80002918:	fc06                	sd	ra,56(sp)
    8000291a:	f822                	sd	s0,48(sp)
    8000291c:	0080                	addi	s0,sp,64
    8000291e:	fca43423          	sd	a0,-56(s0)
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80002922:	00016797          	auipc	a5,0x16
    80002926:	43678793          	addi	a5,a5,1078 # 80018d58 <proc>
    8000292a:	fef43423          	sd	a5,-24(s0)
    8000292e:	a061                	j	800029b6 <proc_mapstacks+0xa0>
    char *pa = kalloc();
    80002930:	fffff097          	auipc	ra,0xfffff
    80002934:	8ac080e7          	jalr	-1876(ra) # 800011dc <kalloc>
    80002938:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    8000293c:	fe043783          	ld	a5,-32(s0)
    80002940:	eb89                	bnez	a5,80002952 <proc_mapstacks+0x3c>
      panic("kalloc");
    80002942:	0000b517          	auipc	a0,0xb
    80002946:	89650513          	addi	a0,a0,-1898 # 8000d1d8 <etext+0x1d8>
    8000294a:	ffffe097          	auipc	ra,0xffffe
    8000294e:	33e080e7          	jalr	830(ra) # 80000c88 <panic>
    uint64 va = KSTACK((int) (p - proc));
    80002952:	fe843703          	ld	a4,-24(s0)
    80002956:	00016797          	auipc	a5,0x16
    8000295a:	40278793          	addi	a5,a5,1026 # 80018d58 <proc>
    8000295e:	40f707b3          	sub	a5,a4,a5
    80002962:	4037d713          	srai	a4,a5,0x3
    80002966:	0000b797          	auipc	a5,0xb
    8000296a:	96a78793          	addi	a5,a5,-1686 # 8000d2d0 <etext+0x2d0>
    8000296e:	639c                	ld	a5,0(a5)
    80002970:	02f707b3          	mul	a5,a4,a5
    80002974:	2781                	sext.w	a5,a5
    80002976:	2785                	addiw	a5,a5,1
    80002978:	2781                	sext.w	a5,a5
    8000297a:	00d7979b          	slliw	a5,a5,0xd
    8000297e:	2781                	sext.w	a5,a5
    80002980:	873e                	mv	a4,a5
    80002982:	040007b7          	lui	a5,0x4000
    80002986:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002988:	07b2                	slli	a5,a5,0xc
    8000298a:	8f99                	sub	a5,a5,a4
    8000298c:	fcf43c23          	sd	a5,-40(s0)
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80002990:	fe043783          	ld	a5,-32(s0)
    80002994:	4719                	li	a4,6
    80002996:	6685                	lui	a3,0x1
    80002998:	863e                	mv	a2,a5
    8000299a:	fd843583          	ld	a1,-40(s0)
    8000299e:	fc843503          	ld	a0,-56(s0)
    800029a2:	fffff097          	auipc	ra,0xfffff
    800029a6:	53e080e7          	jalr	1342(ra) # 80001ee0 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800029aa:	fe843783          	ld	a5,-24(s0)
    800029ae:	16878793          	addi	a5,a5,360
    800029b2:	fef43423          	sd	a5,-24(s0)
    800029b6:	fe843703          	ld	a4,-24(s0)
    800029ba:	0001c797          	auipc	a5,0x1c
    800029be:	d9e78793          	addi	a5,a5,-610 # 8001e758 <pid_lock>
    800029c2:	f6f767e3          	bltu	a4,a5,80002930 <proc_mapstacks+0x1a>
  }
}
    800029c6:	0001                	nop
    800029c8:	0001                	nop
    800029ca:	70e2                	ld	ra,56(sp)
    800029cc:	7442                	ld	s0,48(sp)
    800029ce:	6121                	addi	sp,sp,64
    800029d0:	8082                	ret

00000000800029d2 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    800029d2:	1101                	addi	sp,sp,-32
    800029d4:	ec06                	sd	ra,24(sp)
    800029d6:	e822                	sd	s0,16(sp)
    800029d8:	1000                	addi	s0,sp,32
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800029da:	0000b597          	auipc	a1,0xb
    800029de:	80658593          	addi	a1,a1,-2042 # 8000d1e0 <etext+0x1e0>
    800029e2:	0001c517          	auipc	a0,0x1c
    800029e6:	d7650513          	addi	a0,a0,-650 # 8001e758 <pid_lock>
    800029ea:	fffff097          	auipc	ra,0xfffff
    800029ee:	916080e7          	jalr	-1770(ra) # 80001300 <initlock>
  initlock(&wait_lock, "wait_lock");
    800029f2:	0000a597          	auipc	a1,0xa
    800029f6:	7f658593          	addi	a1,a1,2038 # 8000d1e8 <etext+0x1e8>
    800029fa:	0001c517          	auipc	a0,0x1c
    800029fe:	d7650513          	addi	a0,a0,-650 # 8001e770 <wait_lock>
    80002a02:	fffff097          	auipc	ra,0xfffff
    80002a06:	8fe080e7          	jalr	-1794(ra) # 80001300 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002a0a:	00016797          	auipc	a5,0x16
    80002a0e:	34e78793          	addi	a5,a5,846 # 80018d58 <proc>
    80002a12:	fef43423          	sd	a5,-24(s0)
    80002a16:	a0bd                	j	80002a84 <procinit+0xb2>
      initlock(&p->lock, "proc");
    80002a18:	fe843783          	ld	a5,-24(s0)
    80002a1c:	0000a597          	auipc	a1,0xa
    80002a20:	7dc58593          	addi	a1,a1,2012 # 8000d1f8 <etext+0x1f8>
    80002a24:	853e                	mv	a0,a5
    80002a26:	fffff097          	auipc	ra,0xfffff
    80002a2a:	8da080e7          	jalr	-1830(ra) # 80001300 <initlock>
      p->state = UNUSED;
    80002a2e:	fe843783          	ld	a5,-24(s0)
    80002a32:	0007ac23          	sw	zero,24(a5)
      p->kstack = KSTACK((int) (p - proc));
    80002a36:	fe843703          	ld	a4,-24(s0)
    80002a3a:	00016797          	auipc	a5,0x16
    80002a3e:	31e78793          	addi	a5,a5,798 # 80018d58 <proc>
    80002a42:	40f707b3          	sub	a5,a4,a5
    80002a46:	4037d713          	srai	a4,a5,0x3
    80002a4a:	0000b797          	auipc	a5,0xb
    80002a4e:	88678793          	addi	a5,a5,-1914 # 8000d2d0 <etext+0x2d0>
    80002a52:	639c                	ld	a5,0(a5)
    80002a54:	02f707b3          	mul	a5,a4,a5
    80002a58:	2781                	sext.w	a5,a5
    80002a5a:	2785                	addiw	a5,a5,1
    80002a5c:	2781                	sext.w	a5,a5
    80002a5e:	00d7979b          	slliw	a5,a5,0xd
    80002a62:	2781                	sext.w	a5,a5
    80002a64:	873e                	mv	a4,a5
    80002a66:	040007b7          	lui	a5,0x4000
    80002a6a:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002a6c:	07b2                	slli	a5,a5,0xc
    80002a6e:	8f99                	sub	a5,a5,a4
    80002a70:	873e                	mv	a4,a5
    80002a72:	fe843783          	ld	a5,-24(s0)
    80002a76:	e3b8                	sd	a4,64(a5)
  for(p = proc; p < &proc[NPROC]; p++) {
    80002a78:	fe843783          	ld	a5,-24(s0)
    80002a7c:	16878793          	addi	a5,a5,360
    80002a80:	fef43423          	sd	a5,-24(s0)
    80002a84:	fe843703          	ld	a4,-24(s0)
    80002a88:	0001c797          	auipc	a5,0x1c
    80002a8c:	cd078793          	addi	a5,a5,-816 # 8001e758 <pid_lock>
    80002a90:	f8f764e3          	bltu	a4,a5,80002a18 <procinit+0x46>
  }
}
    80002a94:	0001                	nop
    80002a96:	0001                	nop
    80002a98:	60e2                	ld	ra,24(sp)
    80002a9a:	6442                	ld	s0,16(sp)
    80002a9c:	6105                	addi	sp,sp,32
    80002a9e:	8082                	ret

0000000080002aa0 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80002aa0:	1101                	addi	sp,sp,-32
    80002aa2:	ec06                	sd	ra,24(sp)
    80002aa4:	e822                	sd	s0,16(sp)
    80002aa6:	1000                	addi	s0,sp,32
  int id = r_tp();
    80002aa8:	00000097          	auipc	ra,0x0
    80002aac:	e56080e7          	jalr	-426(ra) # 800028fe <r_tp>
    80002ab0:	87aa                	mv	a5,a0
    80002ab2:	fef42623          	sw	a5,-20(s0)
  return id;
    80002ab6:	fec42783          	lw	a5,-20(s0)
}
    80002aba:	853e                	mv	a0,a5
    80002abc:	60e2                	ld	ra,24(sp)
    80002abe:	6442                	ld	s0,16(sp)
    80002ac0:	6105                	addi	sp,sp,32
    80002ac2:	8082                	ret

0000000080002ac4 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80002ac4:	1101                	addi	sp,sp,-32
    80002ac6:	ec06                	sd	ra,24(sp)
    80002ac8:	e822                	sd	s0,16(sp)
    80002aca:	1000                	addi	s0,sp,32
  int id = cpuid();
    80002acc:	00000097          	auipc	ra,0x0
    80002ad0:	fd4080e7          	jalr	-44(ra) # 80002aa0 <cpuid>
    80002ad4:	87aa                	mv	a5,a0
    80002ad6:	fef42623          	sw	a5,-20(s0)
  struct cpu *c = &cpus[id];
    80002ada:	fec42783          	lw	a5,-20(s0)
    80002ade:	00779713          	slli	a4,a5,0x7
    80002ae2:	00016797          	auipc	a5,0x16
    80002ae6:	e7678793          	addi	a5,a5,-394 # 80018958 <cpus>
    80002aea:	97ba                	add	a5,a5,a4
    80002aec:	fef43023          	sd	a5,-32(s0)
  return c;
    80002af0:	fe043783          	ld	a5,-32(s0)
}
    80002af4:	853e                	mv	a0,a5
    80002af6:	60e2                	ld	ra,24(sp)
    80002af8:	6442                	ld	s0,16(sp)
    80002afa:	6105                	addi	sp,sp,32
    80002afc:	8082                	ret

0000000080002afe <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80002afe:	1101                	addi	sp,sp,-32
    80002b00:	ec06                	sd	ra,24(sp)
    80002b02:	e822                	sd	s0,16(sp)
    80002b04:	1000                	addi	s0,sp,32
  push_off();
    80002b06:	fffff097          	auipc	ra,0xfffff
    80002b0a:	928080e7          	jalr	-1752(ra) # 8000142e <push_off>
  struct cpu *c = mycpu();
    80002b0e:	00000097          	auipc	ra,0x0
    80002b12:	fb6080e7          	jalr	-74(ra) # 80002ac4 <mycpu>
    80002b16:	fea43423          	sd	a0,-24(s0)
  struct proc *p = c->proc;
    80002b1a:	fe843783          	ld	a5,-24(s0)
    80002b1e:	639c                	ld	a5,0(a5)
    80002b20:	fef43023          	sd	a5,-32(s0)
  pop_off();
    80002b24:	fffff097          	auipc	ra,0xfffff
    80002b28:	962080e7          	jalr	-1694(ra) # 80001486 <pop_off>
  return p;
    80002b2c:	fe043783          	ld	a5,-32(s0)
}
    80002b30:	853e                	mv	a0,a5
    80002b32:	60e2                	ld	ra,24(sp)
    80002b34:	6442                	ld	s0,16(sp)
    80002b36:	6105                	addi	sp,sp,32
    80002b38:	8082                	ret

0000000080002b3a <allocpid>:

int
allocpid()
{
    80002b3a:	1101                	addi	sp,sp,-32
    80002b3c:	ec06                	sd	ra,24(sp)
    80002b3e:	e822                	sd	s0,16(sp)
    80002b40:	1000                	addi	s0,sp,32
  int pid;
  
  acquire(&pid_lock);
    80002b42:	0001c517          	auipc	a0,0x1c
    80002b46:	c1650513          	addi	a0,a0,-1002 # 8001e758 <pid_lock>
    80002b4a:	ffffe097          	auipc	ra,0xffffe
    80002b4e:	7e6080e7          	jalr	2022(ra) # 80001330 <acquire>
  pid = nextpid;
    80002b52:	0000e797          	auipc	a5,0xe
    80002b56:	99e78793          	addi	a5,a5,-1634 # 800104f0 <nextpid>
    80002b5a:	439c                	lw	a5,0(a5)
    80002b5c:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    80002b60:	0000e797          	auipc	a5,0xe
    80002b64:	99078793          	addi	a5,a5,-1648 # 800104f0 <nextpid>
    80002b68:	439c                	lw	a5,0(a5)
    80002b6a:	2785                	addiw	a5,a5,1
    80002b6c:	0007871b          	sext.w	a4,a5
    80002b70:	0000e797          	auipc	a5,0xe
    80002b74:	98078793          	addi	a5,a5,-1664 # 800104f0 <nextpid>
    80002b78:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80002b7a:	0001c517          	auipc	a0,0x1c
    80002b7e:	bde50513          	addi	a0,a0,-1058 # 8001e758 <pid_lock>
    80002b82:	fffff097          	auipc	ra,0xfffff
    80002b86:	812080e7          	jalr	-2030(ra) # 80001394 <release>

  return pid;
    80002b8a:	fec42783          	lw	a5,-20(s0)
}
    80002b8e:	853e                	mv	a0,a5
    80002b90:	60e2                	ld	ra,24(sp)
    80002b92:	6442                	ld	s0,16(sp)
    80002b94:	6105                	addi	sp,sp,32
    80002b96:	8082                	ret

0000000080002b98 <allocproc>:
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
    80002b98:	1101                	addi	sp,sp,-32
    80002b9a:	ec06                	sd	ra,24(sp)
    80002b9c:	e822                	sd	s0,16(sp)
    80002b9e:	1000                	addi	s0,sp,32
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80002ba0:	00016797          	auipc	a5,0x16
    80002ba4:	1b878793          	addi	a5,a5,440 # 80018d58 <proc>
    80002ba8:	fef43423          	sd	a5,-24(s0)
    80002bac:	a80d                	j	80002bde <allocproc+0x46>
    acquire(&p->lock);
    80002bae:	fe843783          	ld	a5,-24(s0)
    80002bb2:	853e                	mv	a0,a5
    80002bb4:	ffffe097          	auipc	ra,0xffffe
    80002bb8:	77c080e7          	jalr	1916(ra) # 80001330 <acquire>
    if(p->state == UNUSED) {
    80002bbc:	fe843783          	ld	a5,-24(s0)
    80002bc0:	4f9c                	lw	a5,24(a5)
    80002bc2:	cb85                	beqz	a5,80002bf2 <allocproc+0x5a>
      goto found;
    } else {
      release(&p->lock);
    80002bc4:	fe843783          	ld	a5,-24(s0)
    80002bc8:	853e                	mv	a0,a5
    80002bca:	ffffe097          	auipc	ra,0xffffe
    80002bce:	7ca080e7          	jalr	1994(ra) # 80001394 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002bd2:	fe843783          	ld	a5,-24(s0)
    80002bd6:	16878793          	addi	a5,a5,360
    80002bda:	fef43423          	sd	a5,-24(s0)
    80002bde:	fe843703          	ld	a4,-24(s0)
    80002be2:	0001c797          	auipc	a5,0x1c
    80002be6:	b7678793          	addi	a5,a5,-1162 # 8001e758 <pid_lock>
    80002bea:	fcf762e3          	bltu	a4,a5,80002bae <allocproc+0x16>
    }
  }
  return 0;
    80002bee:	4781                	li	a5,0
    80002bf0:	a0e1                	j	80002cb8 <allocproc+0x120>
      goto found;
    80002bf2:	0001                	nop

found:
  p->pid = allocpid();
    80002bf4:	00000097          	auipc	ra,0x0
    80002bf8:	f46080e7          	jalr	-186(ra) # 80002b3a <allocpid>
    80002bfc:	87aa                	mv	a5,a0
    80002bfe:	873e                	mv	a4,a5
    80002c00:	fe843783          	ld	a5,-24(s0)
    80002c04:	db98                	sw	a4,48(a5)
  p->state = USED;
    80002c06:	fe843783          	ld	a5,-24(s0)
    80002c0a:	4705                	li	a4,1
    80002c0c:	cf98                	sw	a4,24(a5)

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80002c0e:	ffffe097          	auipc	ra,0xffffe
    80002c12:	5ce080e7          	jalr	1486(ra) # 800011dc <kalloc>
    80002c16:	872a                	mv	a4,a0
    80002c18:	fe843783          	ld	a5,-24(s0)
    80002c1c:	efb8                	sd	a4,88(a5)
    80002c1e:	fe843783          	ld	a5,-24(s0)
    80002c22:	6fbc                	ld	a5,88(a5)
    80002c24:	e385                	bnez	a5,80002c44 <allocproc+0xac>
    freeproc(p);
    80002c26:	fe843503          	ld	a0,-24(s0)
    80002c2a:	00000097          	auipc	ra,0x0
    80002c2e:	098080e7          	jalr	152(ra) # 80002cc2 <freeproc>
    release(&p->lock);
    80002c32:	fe843783          	ld	a5,-24(s0)
    80002c36:	853e                	mv	a0,a5
    80002c38:	ffffe097          	auipc	ra,0xffffe
    80002c3c:	75c080e7          	jalr	1884(ra) # 80001394 <release>
    return 0;
    80002c40:	4781                	li	a5,0
    80002c42:	a89d                	j	80002cb8 <allocproc+0x120>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    80002c44:	fe843503          	ld	a0,-24(s0)
    80002c48:	00000097          	auipc	ra,0x0
    80002c4c:	118080e7          	jalr	280(ra) # 80002d60 <proc_pagetable>
    80002c50:	872a                	mv	a4,a0
    80002c52:	fe843783          	ld	a5,-24(s0)
    80002c56:	ebb8                	sd	a4,80(a5)
  if(p->pagetable == 0){
    80002c58:	fe843783          	ld	a5,-24(s0)
    80002c5c:	6bbc                	ld	a5,80(a5)
    80002c5e:	e385                	bnez	a5,80002c7e <allocproc+0xe6>
    freeproc(p);
    80002c60:	fe843503          	ld	a0,-24(s0)
    80002c64:	00000097          	auipc	ra,0x0
    80002c68:	05e080e7          	jalr	94(ra) # 80002cc2 <freeproc>
    release(&p->lock);
    80002c6c:	fe843783          	ld	a5,-24(s0)
    80002c70:	853e                	mv	a0,a5
    80002c72:	ffffe097          	auipc	ra,0xffffe
    80002c76:	722080e7          	jalr	1826(ra) # 80001394 <release>
    return 0;
    80002c7a:	4781                	li	a5,0
    80002c7c:	a835                	j	80002cb8 <allocproc+0x120>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    80002c7e:	fe843783          	ld	a5,-24(s0)
    80002c82:	06078793          	addi	a5,a5,96
    80002c86:	07000613          	li	a2,112
    80002c8a:	4581                	li	a1,0
    80002c8c:	853e                	mv	a0,a5
    80002c8e:	fffff097          	auipc	ra,0xfffff
    80002c92:	876080e7          	jalr	-1930(ra) # 80001504 <memset>
  p->context.ra = (uint64)forkret;
    80002c96:	00001717          	auipc	a4,0x1
    80002c9a:	9da70713          	addi	a4,a4,-1574 # 80003670 <forkret>
    80002c9e:	fe843783          	ld	a5,-24(s0)
    80002ca2:	f3b8                	sd	a4,96(a5)
  p->context.sp = p->kstack + PGSIZE;
    80002ca4:	fe843783          	ld	a5,-24(s0)
    80002ca8:	63b8                	ld	a4,64(a5)
    80002caa:	6785                	lui	a5,0x1
    80002cac:	973e                	add	a4,a4,a5
    80002cae:	fe843783          	ld	a5,-24(s0)
    80002cb2:	f7b8                	sd	a4,104(a5)

  return p;
    80002cb4:	fe843783          	ld	a5,-24(s0)
}
    80002cb8:	853e                	mv	a0,a5
    80002cba:	60e2                	ld	ra,24(sp)
    80002cbc:	6442                	ld	s0,16(sp)
    80002cbe:	6105                	addi	sp,sp,32
    80002cc0:	8082                	ret

0000000080002cc2 <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    80002cc2:	1101                	addi	sp,sp,-32
    80002cc4:	ec06                	sd	ra,24(sp)
    80002cc6:	e822                	sd	s0,16(sp)
    80002cc8:	1000                	addi	s0,sp,32
    80002cca:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    80002cce:	fe843783          	ld	a5,-24(s0)
    80002cd2:	6fbc                	ld	a5,88(a5)
    80002cd4:	cb89                	beqz	a5,80002ce6 <freeproc+0x24>
    kfree((void*)p->trapframe);
    80002cd6:	fe843783          	ld	a5,-24(s0)
    80002cda:	6fbc                	ld	a5,88(a5)
    80002cdc:	853e                	mv	a0,a5
    80002cde:	ffffe097          	auipc	ra,0xffffe
    80002ce2:	458080e7          	jalr	1112(ra) # 80001136 <kfree>
  p->trapframe = 0;
    80002ce6:	fe843783          	ld	a5,-24(s0)
    80002cea:	0407bc23          	sd	zero,88(a5) # 1058 <_entry-0x7fffefa8>
  if(p->pagetable)
    80002cee:	fe843783          	ld	a5,-24(s0)
    80002cf2:	6bbc                	ld	a5,80(a5)
    80002cf4:	cf89                	beqz	a5,80002d0e <freeproc+0x4c>
    proc_freepagetable(p->pagetable, p->sz);
    80002cf6:	fe843783          	ld	a5,-24(s0)
    80002cfa:	6bb8                	ld	a4,80(a5)
    80002cfc:	fe843783          	ld	a5,-24(s0)
    80002d00:	67bc                	ld	a5,72(a5)
    80002d02:	85be                	mv	a1,a5
    80002d04:	853a                	mv	a0,a4
    80002d06:	00000097          	auipc	ra,0x0
    80002d0a:	11a080e7          	jalr	282(ra) # 80002e20 <proc_freepagetable>
  p->pagetable = 0;
    80002d0e:	fe843783          	ld	a5,-24(s0)
    80002d12:	0407b823          	sd	zero,80(a5)
  p->sz = 0;
    80002d16:	fe843783          	ld	a5,-24(s0)
    80002d1a:	0407b423          	sd	zero,72(a5)
  p->pid = 0;
    80002d1e:	fe843783          	ld	a5,-24(s0)
    80002d22:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80002d26:	fe843783          	ld	a5,-24(s0)
    80002d2a:	0207bc23          	sd	zero,56(a5)
  p->name[0] = 0;
    80002d2e:	fe843783          	ld	a5,-24(s0)
    80002d32:	14078c23          	sb	zero,344(a5)
  p->chan = 0;
    80002d36:	fe843783          	ld	a5,-24(s0)
    80002d3a:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80002d3e:	fe843783          	ld	a5,-24(s0)
    80002d42:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80002d46:	fe843783          	ld	a5,-24(s0)
    80002d4a:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80002d4e:	fe843783          	ld	a5,-24(s0)
    80002d52:	0007ac23          	sw	zero,24(a5)
}
    80002d56:	0001                	nop
    80002d58:	60e2                	ld	ra,24(sp)
    80002d5a:	6442                	ld	s0,16(sp)
    80002d5c:	6105                	addi	sp,sp,32
    80002d5e:	8082                	ret

0000000080002d60 <proc_pagetable>:

// Create a user page table for a given process, with no user memory,
// but with trampoline and trapframe pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002d60:	7179                	addi	sp,sp,-48
    80002d62:	f406                	sd	ra,40(sp)
    80002d64:	f022                	sd	s0,32(sp)
    80002d66:	1800                	addi	s0,sp,48
    80002d68:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002d6c:	fffff097          	auipc	ra,0xfffff
    80002d70:	3ac080e7          	jalr	940(ra) # 80002118 <uvmcreate>
    80002d74:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002d78:	fe843783          	ld	a5,-24(s0)
    80002d7c:	e399                	bnez	a5,80002d82 <proc_pagetable+0x22>
    return 0;
    80002d7e:	4781                	li	a5,0
    80002d80:	a859                	j	80002e16 <proc_pagetable+0xb6>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002d82:	00009797          	auipc	a5,0x9
    80002d86:	27e78793          	addi	a5,a5,638 # 8000c000 <_trampoline>
    80002d8a:	4729                	li	a4,10
    80002d8c:	86be                	mv	a3,a5
    80002d8e:	6605                	lui	a2,0x1
    80002d90:	040007b7          	lui	a5,0x4000
    80002d94:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002d96:	00c79593          	slli	a1,a5,0xc
    80002d9a:	fe843503          	ld	a0,-24(s0)
    80002d9e:	fffff097          	auipc	ra,0xfffff
    80002da2:	19c080e7          	jalr	412(ra) # 80001f3a <mappages>
    80002da6:	87aa                	mv	a5,a0
    80002da8:	0007db63          	bgez	a5,80002dbe <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002dac:	4581                	li	a1,0
    80002dae:	fe843503          	ld	a0,-24(s0)
    80002db2:	fffff097          	auipc	ra,0xfffff
    80002db6:	662080e7          	jalr	1634(ra) # 80002414 <uvmfree>
    return 0;
    80002dba:	4781                	li	a5,0
    80002dbc:	a8a9                	j	80002e16 <proc_pagetable+0xb6>
  }

  // map the trapframe page just below the trampoline page, for
  // trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002dbe:	fd843783          	ld	a5,-40(s0)
    80002dc2:	6fbc                	ld	a5,88(a5)
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002dc4:	4719                	li	a4,6
    80002dc6:	86be                	mv	a3,a5
    80002dc8:	6605                	lui	a2,0x1
    80002dca:	020007b7          	lui	a5,0x2000
    80002dce:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80002dd0:	00d79593          	slli	a1,a5,0xd
    80002dd4:	fe843503          	ld	a0,-24(s0)
    80002dd8:	fffff097          	auipc	ra,0xfffff
    80002ddc:	162080e7          	jalr	354(ra) # 80001f3a <mappages>
    80002de0:	87aa                	mv	a5,a0
    80002de2:	0207d863          	bgez	a5,80002e12 <proc_pagetable+0xb2>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002de6:	4681                	li	a3,0
    80002de8:	4605                	li	a2,1
    80002dea:	040007b7          	lui	a5,0x4000
    80002dee:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002df0:	00c79593          	slli	a1,a5,0xc
    80002df4:	fe843503          	ld	a0,-24(s0)
    80002df8:	fffff097          	auipc	ra,0xfffff
    80002dfc:	220080e7          	jalr	544(ra) # 80002018 <uvmunmap>
    uvmfree(pagetable, 0);
    80002e00:	4581                	li	a1,0
    80002e02:	fe843503          	ld	a0,-24(s0)
    80002e06:	fffff097          	auipc	ra,0xfffff
    80002e0a:	60e080e7          	jalr	1550(ra) # 80002414 <uvmfree>
    return 0;
    80002e0e:	4781                	li	a5,0
    80002e10:	a019                	j	80002e16 <proc_pagetable+0xb6>
  }

  return pagetable;
    80002e12:	fe843783          	ld	a5,-24(s0)
}
    80002e16:	853e                	mv	a0,a5
    80002e18:	70a2                	ld	ra,40(sp)
    80002e1a:	7402                	ld	s0,32(sp)
    80002e1c:	6145                	addi	sp,sp,48
    80002e1e:	8082                	ret

0000000080002e20 <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002e20:	1101                	addi	sp,sp,-32
    80002e22:	ec06                	sd	ra,24(sp)
    80002e24:	e822                	sd	s0,16(sp)
    80002e26:	1000                	addi	s0,sp,32
    80002e28:	fea43423          	sd	a0,-24(s0)
    80002e2c:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002e30:	4681                	li	a3,0
    80002e32:	4605                	li	a2,1
    80002e34:	040007b7          	lui	a5,0x4000
    80002e38:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002e3a:	00c79593          	slli	a1,a5,0xc
    80002e3e:	fe843503          	ld	a0,-24(s0)
    80002e42:	fffff097          	auipc	ra,0xfffff
    80002e46:	1d6080e7          	jalr	470(ra) # 80002018 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002e4a:	4681                	li	a3,0
    80002e4c:	4605                	li	a2,1
    80002e4e:	020007b7          	lui	a5,0x2000
    80002e52:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80002e54:	00d79593          	slli	a1,a5,0xd
    80002e58:	fe843503          	ld	a0,-24(s0)
    80002e5c:	fffff097          	auipc	ra,0xfffff
    80002e60:	1bc080e7          	jalr	444(ra) # 80002018 <uvmunmap>
  uvmfree(pagetable, sz);
    80002e64:	fe043583          	ld	a1,-32(s0)
    80002e68:	fe843503          	ld	a0,-24(s0)
    80002e6c:	fffff097          	auipc	ra,0xfffff
    80002e70:	5a8080e7          	jalr	1448(ra) # 80002414 <uvmfree>
}
    80002e74:	0001                	nop
    80002e76:	60e2                	ld	ra,24(sp)
    80002e78:	6442                	ld	s0,16(sp)
    80002e7a:	6105                	addi	sp,sp,32
    80002e7c:	8082                	ret

0000000080002e7e <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80002e7e:	1101                	addi	sp,sp,-32
    80002e80:	ec06                	sd	ra,24(sp)
    80002e82:	e822                	sd	s0,16(sp)
    80002e84:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002e86:	00000097          	auipc	ra,0x0
    80002e8a:	d12080e7          	jalr	-750(ra) # 80002b98 <allocproc>
    80002e8e:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002e92:	0000e797          	auipc	a5,0xe
    80002e96:	84e78793          	addi	a5,a5,-1970 # 800106e0 <initproc>
    80002e9a:	fe843703          	ld	a4,-24(s0)
    80002e9e:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy initcode's instructions
  // and data into it.
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    80002ea0:	fe843783          	ld	a5,-24(s0)
    80002ea4:	6bbc                	ld	a5,80(a5)
    80002ea6:	03400613          	li	a2,52
    80002eaa:	0000d597          	auipc	a1,0xd
    80002eae:	68658593          	addi	a1,a1,1670 # 80010530 <initcode>
    80002eb2:	853e                	mv	a0,a5
    80002eb4:	fffff097          	auipc	ra,0xfffff
    80002eb8:	2a0080e7          	jalr	672(ra) # 80002154 <uvmfirst>
  p->sz = PGSIZE;
    80002ebc:	fe843783          	ld	a5,-24(s0)
    80002ec0:	6705                	lui	a4,0x1
    80002ec2:	e7b8                	sd	a4,72(a5)

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    80002ec4:	fe843783          	ld	a5,-24(s0)
    80002ec8:	6fbc                	ld	a5,88(a5)
    80002eca:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80002ece:	fe843783          	ld	a5,-24(s0)
    80002ed2:	6fbc                	ld	a5,88(a5)
    80002ed4:	6705                	lui	a4,0x1
    80002ed6:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    80002ed8:	fe843783          	ld	a5,-24(s0)
    80002edc:	15878793          	addi	a5,a5,344
    80002ee0:	4641                	li	a2,16
    80002ee2:	0000a597          	auipc	a1,0xa
    80002ee6:	31e58593          	addi	a1,a1,798 # 8000d200 <etext+0x200>
    80002eea:	853e                	mv	a0,a5
    80002eec:	fffff097          	auipc	ra,0xfffff
    80002ef0:	91c080e7          	jalr	-1764(ra) # 80001808 <safestrcpy>
  p->cwd = namei("/");
    80002ef4:	0000a517          	auipc	a0,0xa
    80002ef8:	31c50513          	addi	a0,a0,796 # 8000d210 <etext+0x210>
    80002efc:	00003097          	auipc	ra,0x3
    80002f00:	178080e7          	jalr	376(ra) # 80006074 <namei>
    80002f04:	872a                	mv	a4,a0
    80002f06:	fe843783          	ld	a5,-24(s0)
    80002f0a:	14e7b823          	sd	a4,336(a5)

  p->state = RUNNABLE;
    80002f0e:	fe843783          	ld	a5,-24(s0)
    80002f12:	470d                	li	a4,3
    80002f14:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002f16:	fe843783          	ld	a5,-24(s0)
    80002f1a:	853e                	mv	a0,a5
    80002f1c:	ffffe097          	auipc	ra,0xffffe
    80002f20:	478080e7          	jalr	1144(ra) # 80001394 <release>
}
    80002f24:	0001                	nop
    80002f26:	60e2                	ld	ra,24(sp)
    80002f28:	6442                	ld	s0,16(sp)
    80002f2a:	6105                	addi	sp,sp,32
    80002f2c:	8082                	ret

0000000080002f2e <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002f2e:	7179                	addi	sp,sp,-48
    80002f30:	f406                	sd	ra,40(sp)
    80002f32:	f022                	sd	s0,32(sp)
    80002f34:	1800                	addi	s0,sp,48
    80002f36:	87aa                	mv	a5,a0
    80002f38:	fcf42e23          	sw	a5,-36(s0)
  uint64 sz;
  struct proc *p = myproc();
    80002f3c:	00000097          	auipc	ra,0x0
    80002f40:	bc2080e7          	jalr	-1086(ra) # 80002afe <myproc>
    80002f44:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002f48:	fe043783          	ld	a5,-32(s0)
    80002f4c:	67bc                	ld	a5,72(a5)
    80002f4e:	fef43423          	sd	a5,-24(s0)
  if(n > 0){
    80002f52:	fdc42783          	lw	a5,-36(s0)
    80002f56:	2781                	sext.w	a5,a5
    80002f58:	02f05963          	blez	a5,80002f8a <growproc+0x5c>
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80002f5c:	fe043783          	ld	a5,-32(s0)
    80002f60:	6ba8                	ld	a0,80(a5)
    80002f62:	fdc42703          	lw	a4,-36(s0)
    80002f66:	fe843783          	ld	a5,-24(s0)
    80002f6a:	97ba                	add	a5,a5,a4
    80002f6c:	4691                	li	a3,4
    80002f6e:	863e                	mv	a2,a5
    80002f70:	fe843583          	ld	a1,-24(s0)
    80002f74:	fffff097          	auipc	ra,0xfffff
    80002f78:	268080e7          	jalr	616(ra) # 800021dc <uvmalloc>
    80002f7c:	fea43423          	sd	a0,-24(s0)
    80002f80:	fe843783          	ld	a5,-24(s0)
    80002f84:	eb95                	bnez	a5,80002fb8 <growproc+0x8a>
      return -1;
    80002f86:	57fd                	li	a5,-1
    80002f88:	a835                	j	80002fc4 <growproc+0x96>
    }
  } else if(n < 0){
    80002f8a:	fdc42783          	lw	a5,-36(s0)
    80002f8e:	2781                	sext.w	a5,a5
    80002f90:	0207d463          	bgez	a5,80002fb8 <growproc+0x8a>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002f94:	fe043783          	ld	a5,-32(s0)
    80002f98:	6bb4                	ld	a3,80(a5)
    80002f9a:	fdc42703          	lw	a4,-36(s0)
    80002f9e:	fe843783          	ld	a5,-24(s0)
    80002fa2:	97ba                	add	a5,a5,a4
    80002fa4:	863e                	mv	a2,a5
    80002fa6:	fe843583          	ld	a1,-24(s0)
    80002faa:	8536                	mv	a0,a3
    80002fac:	fffff097          	auipc	ra,0xfffff
    80002fb0:	322080e7          	jalr	802(ra) # 800022ce <uvmdealloc>
    80002fb4:	fea43423          	sd	a0,-24(s0)
  }
  p->sz = sz;
    80002fb8:	fe043783          	ld	a5,-32(s0)
    80002fbc:	fe843703          	ld	a4,-24(s0)
    80002fc0:	e7b8                	sd	a4,72(a5)
  return 0;
    80002fc2:	4781                	li	a5,0
}
    80002fc4:	853e                	mv	a0,a5
    80002fc6:	70a2                	ld	ra,40(sp)
    80002fc8:	7402                	ld	s0,32(sp)
    80002fca:	6145                	addi	sp,sp,48
    80002fcc:	8082                	ret

0000000080002fce <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    80002fce:	7179                	addi	sp,sp,-48
    80002fd0:	f406                	sd	ra,40(sp)
    80002fd2:	f022                	sd	s0,32(sp)
    80002fd4:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80002fd6:	00000097          	auipc	ra,0x0
    80002fda:	b28080e7          	jalr	-1240(ra) # 80002afe <myproc>
    80002fde:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80002fe2:	00000097          	auipc	ra,0x0
    80002fe6:	bb6080e7          	jalr	-1098(ra) # 80002b98 <allocproc>
    80002fea:	fca43c23          	sd	a0,-40(s0)
    80002fee:	fd843783          	ld	a5,-40(s0)
    80002ff2:	e399                	bnez	a5,80002ff8 <fork+0x2a>
    return -1;
    80002ff4:	57fd                	li	a5,-1
    80002ff6:	aab5                	j	80003172 <fork+0x1a4>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80002ff8:	fe043783          	ld	a5,-32(s0)
    80002ffc:	6bb8                	ld	a4,80(a5)
    80002ffe:	fd843783          	ld	a5,-40(s0)
    80003002:	6bb4                	ld	a3,80(a5)
    80003004:	fe043783          	ld	a5,-32(s0)
    80003008:	67bc                	ld	a5,72(a5)
    8000300a:	863e                	mv	a2,a5
    8000300c:	85b6                	mv	a1,a3
    8000300e:	853a                	mv	a0,a4
    80003010:	fffff097          	auipc	ra,0xfffff
    80003014:	44e080e7          	jalr	1102(ra) # 8000245e <uvmcopy>
    80003018:	87aa                	mv	a5,a0
    8000301a:	0207d163          	bgez	a5,8000303c <fork+0x6e>
    freeproc(np);
    8000301e:	fd843503          	ld	a0,-40(s0)
    80003022:	00000097          	auipc	ra,0x0
    80003026:	ca0080e7          	jalr	-864(ra) # 80002cc2 <freeproc>
    release(&np->lock);
    8000302a:	fd843783          	ld	a5,-40(s0)
    8000302e:	853e                	mv	a0,a5
    80003030:	ffffe097          	auipc	ra,0xffffe
    80003034:	364080e7          	jalr	868(ra) # 80001394 <release>
    return -1;
    80003038:	57fd                	li	a5,-1
    8000303a:	aa25                	j	80003172 <fork+0x1a4>
  }
  np->sz = p->sz;
    8000303c:	fe043783          	ld	a5,-32(s0)
    80003040:	67b8                	ld	a4,72(a5)
    80003042:	fd843783          	ld	a5,-40(s0)
    80003046:	e7b8                	sd	a4,72(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80003048:	fe043783          	ld	a5,-32(s0)
    8000304c:	6fb8                	ld	a4,88(a5)
    8000304e:	fd843783          	ld	a5,-40(s0)
    80003052:	6fbc                	ld	a5,88(a5)
    80003054:	86be                	mv	a3,a5
    80003056:	12000793          	li	a5,288
    8000305a:	863e                	mv	a2,a5
    8000305c:	85ba                	mv	a1,a4
    8000305e:	8536                	mv	a0,a3
    80003060:	ffffe097          	auipc	ra,0xffffe
    80003064:	664080e7          	jalr	1636(ra) # 800016c4 <memcpy>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80003068:	fd843783          	ld	a5,-40(s0)
    8000306c:	6fbc                	ld	a5,88(a5)
    8000306e:	0607b823          	sd	zero,112(a5)

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80003072:	fe042623          	sw	zero,-20(s0)
    80003076:	a0a9                	j	800030c0 <fork+0xf2>
    if(p->ofile[i])
    80003078:	fe043703          	ld	a4,-32(s0)
    8000307c:	fec42783          	lw	a5,-20(s0)
    80003080:	07e9                	addi	a5,a5,26
    80003082:	078e                	slli	a5,a5,0x3
    80003084:	97ba                	add	a5,a5,a4
    80003086:	639c                	ld	a5,0(a5)
    80003088:	c79d                	beqz	a5,800030b6 <fork+0xe8>
      np->ofile[i] = filedup(p->ofile[i]);
    8000308a:	fe043703          	ld	a4,-32(s0)
    8000308e:	fec42783          	lw	a5,-20(s0)
    80003092:	07e9                	addi	a5,a5,26
    80003094:	078e                	slli	a5,a5,0x3
    80003096:	97ba                	add	a5,a5,a4
    80003098:	639c                	ld	a5,0(a5)
    8000309a:	853e                	mv	a0,a5
    8000309c:	00004097          	auipc	ra,0x4
    800030a0:	970080e7          	jalr	-1680(ra) # 80006a0c <filedup>
    800030a4:	86aa                	mv	a3,a0
    800030a6:	fd843703          	ld	a4,-40(s0)
    800030aa:	fec42783          	lw	a5,-20(s0)
    800030ae:	07e9                	addi	a5,a5,26
    800030b0:	078e                	slli	a5,a5,0x3
    800030b2:	97ba                	add	a5,a5,a4
    800030b4:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    800030b6:	fec42783          	lw	a5,-20(s0)
    800030ba:	2785                	addiw	a5,a5,1
    800030bc:	fef42623          	sw	a5,-20(s0)
    800030c0:	fec42783          	lw	a5,-20(s0)
    800030c4:	0007871b          	sext.w	a4,a5
    800030c8:	47bd                	li	a5,15
    800030ca:	fae7d7e3          	bge	a5,a4,80003078 <fork+0xaa>
  np->cwd = idup(p->cwd);
    800030ce:	fe043783          	ld	a5,-32(s0)
    800030d2:	1507b783          	ld	a5,336(a5)
    800030d6:	853e                	mv	a0,a5
    800030d8:	00002097          	auipc	ra,0x2
    800030dc:	220080e7          	jalr	544(ra) # 800052f8 <idup>
    800030e0:	872a                	mv	a4,a0
    800030e2:	fd843783          	ld	a5,-40(s0)
    800030e6:	14e7b823          	sd	a4,336(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    800030ea:	fd843783          	ld	a5,-40(s0)
    800030ee:	15878713          	addi	a4,a5,344
    800030f2:	fe043783          	ld	a5,-32(s0)
    800030f6:	15878793          	addi	a5,a5,344
    800030fa:	4641                	li	a2,16
    800030fc:	85be                	mv	a1,a5
    800030fe:	853a                	mv	a0,a4
    80003100:	ffffe097          	auipc	ra,0xffffe
    80003104:	708080e7          	jalr	1800(ra) # 80001808 <safestrcpy>

  pid = np->pid;
    80003108:	fd843783          	ld	a5,-40(s0)
    8000310c:	5b9c                	lw	a5,48(a5)
    8000310e:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80003112:	fd843783          	ld	a5,-40(s0)
    80003116:	853e                	mv	a0,a5
    80003118:	ffffe097          	auipc	ra,0xffffe
    8000311c:	27c080e7          	jalr	636(ra) # 80001394 <release>

  acquire(&wait_lock);
    80003120:	0001b517          	auipc	a0,0x1b
    80003124:	65050513          	addi	a0,a0,1616 # 8001e770 <wait_lock>
    80003128:	ffffe097          	auipc	ra,0xffffe
    8000312c:	208080e7          	jalr	520(ra) # 80001330 <acquire>
  np->parent = p;
    80003130:	fd843783          	ld	a5,-40(s0)
    80003134:	fe043703          	ld	a4,-32(s0)
    80003138:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    8000313a:	0001b517          	auipc	a0,0x1b
    8000313e:	63650513          	addi	a0,a0,1590 # 8001e770 <wait_lock>
    80003142:	ffffe097          	auipc	ra,0xffffe
    80003146:	252080e7          	jalr	594(ra) # 80001394 <release>

  acquire(&np->lock);
    8000314a:	fd843783          	ld	a5,-40(s0)
    8000314e:	853e                	mv	a0,a5
    80003150:	ffffe097          	auipc	ra,0xffffe
    80003154:	1e0080e7          	jalr	480(ra) # 80001330 <acquire>
  np->state = RUNNABLE;
    80003158:	fd843783          	ld	a5,-40(s0)
    8000315c:	470d                	li	a4,3
    8000315e:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80003160:	fd843783          	ld	a5,-40(s0)
    80003164:	853e                	mv	a0,a5
    80003166:	ffffe097          	auipc	ra,0xffffe
    8000316a:	22e080e7          	jalr	558(ra) # 80001394 <release>

  return pid;
    8000316e:	fd442783          	lw	a5,-44(s0)
}
    80003172:	853e                	mv	a0,a5
    80003174:	70a2                	ld	ra,40(sp)
    80003176:	7402                	ld	s0,32(sp)
    80003178:	6145                	addi	sp,sp,48
    8000317a:	8082                	ret

000000008000317c <reparent>:

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void
reparent(struct proc *p)
{
    8000317c:	7179                	addi	sp,sp,-48
    8000317e:	f406                	sd	ra,40(sp)
    80003180:	f022                	sd	s0,32(sp)
    80003182:	1800                	addi	s0,sp,48
    80003184:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80003188:	00016797          	auipc	a5,0x16
    8000318c:	bd078793          	addi	a5,a5,-1072 # 80018d58 <proc>
    80003190:	fef43423          	sd	a5,-24(s0)
    80003194:	a081                	j	800031d4 <reparent+0x58>
    if(pp->parent == p){
    80003196:	fe843783          	ld	a5,-24(s0)
    8000319a:	7f9c                	ld	a5,56(a5)
    8000319c:	fd843703          	ld	a4,-40(s0)
    800031a0:	02f71463          	bne	a4,a5,800031c8 <reparent+0x4c>
      pp->parent = initproc;
    800031a4:	0000d797          	auipc	a5,0xd
    800031a8:	53c78793          	addi	a5,a5,1340 # 800106e0 <initproc>
    800031ac:	6398                	ld	a4,0(a5)
    800031ae:	fe843783          	ld	a5,-24(s0)
    800031b2:	ff98                	sd	a4,56(a5)
      wakeup(initproc);
    800031b4:	0000d797          	auipc	a5,0xd
    800031b8:	52c78793          	addi	a5,a5,1324 # 800106e0 <initproc>
    800031bc:	639c                	ld	a5,0(a5)
    800031be:	853e                	mv	a0,a5
    800031c0:	00000097          	auipc	ra,0x0
    800031c4:	584080e7          	jalr	1412(ra) # 80003744 <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800031c8:	fe843783          	ld	a5,-24(s0)
    800031cc:	16878793          	addi	a5,a5,360
    800031d0:	fef43423          	sd	a5,-24(s0)
    800031d4:	fe843703          	ld	a4,-24(s0)
    800031d8:	0001b797          	auipc	a5,0x1b
    800031dc:	58078793          	addi	a5,a5,1408 # 8001e758 <pid_lock>
    800031e0:	faf76be3          	bltu	a4,a5,80003196 <reparent+0x1a>
    }
  }
}
    800031e4:	0001                	nop
    800031e6:	0001                	nop
    800031e8:	70a2                	ld	ra,40(sp)
    800031ea:	7402                	ld	s0,32(sp)
    800031ec:	6145                	addi	sp,sp,48
    800031ee:	8082                	ret

00000000800031f0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    800031f0:	7139                	addi	sp,sp,-64
    800031f2:	fc06                	sd	ra,56(sp)
    800031f4:	f822                	sd	s0,48(sp)
    800031f6:	0080                	addi	s0,sp,64
    800031f8:	87aa                	mv	a5,a0
    800031fa:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    800031fe:	00000097          	auipc	ra,0x0
    80003202:	900080e7          	jalr	-1792(ra) # 80002afe <myproc>
    80003206:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    8000320a:	0000d797          	auipc	a5,0xd
    8000320e:	4d678793          	addi	a5,a5,1238 # 800106e0 <initproc>
    80003212:	639c                	ld	a5,0(a5)
    80003214:	fe043703          	ld	a4,-32(s0)
    80003218:	00f71a63          	bne	a4,a5,8000322c <exit+0x3c>
    panic("init exiting");
    8000321c:	0000a517          	auipc	a0,0xa
    80003220:	ffc50513          	addi	a0,a0,-4 # 8000d218 <etext+0x218>
    80003224:	ffffe097          	auipc	ra,0xffffe
    80003228:	a64080e7          	jalr	-1436(ra) # 80000c88 <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    8000322c:	fe042623          	sw	zero,-20(s0)
    80003230:	a881                	j	80003280 <exit+0x90>
    if(p->ofile[fd]){
    80003232:	fe043703          	ld	a4,-32(s0)
    80003236:	fec42783          	lw	a5,-20(s0)
    8000323a:	07e9                	addi	a5,a5,26
    8000323c:	078e                	slli	a5,a5,0x3
    8000323e:	97ba                	add	a5,a5,a4
    80003240:	639c                	ld	a5,0(a5)
    80003242:	cb95                	beqz	a5,80003276 <exit+0x86>
      struct file *f = p->ofile[fd];
    80003244:	fe043703          	ld	a4,-32(s0)
    80003248:	fec42783          	lw	a5,-20(s0)
    8000324c:	07e9                	addi	a5,a5,26
    8000324e:	078e                	slli	a5,a5,0x3
    80003250:	97ba                	add	a5,a5,a4
    80003252:	639c                	ld	a5,0(a5)
    80003254:	fcf43c23          	sd	a5,-40(s0)
      fileclose(f);
    80003258:	fd843503          	ld	a0,-40(s0)
    8000325c:	00004097          	auipc	ra,0x4
    80003260:	816080e7          	jalr	-2026(ra) # 80006a72 <fileclose>
      p->ofile[fd] = 0;
    80003264:	fe043703          	ld	a4,-32(s0)
    80003268:	fec42783          	lw	a5,-20(s0)
    8000326c:	07e9                	addi	a5,a5,26
    8000326e:	078e                	slli	a5,a5,0x3
    80003270:	97ba                	add	a5,a5,a4
    80003272:	0007b023          	sd	zero,0(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    80003276:	fec42783          	lw	a5,-20(s0)
    8000327a:	2785                	addiw	a5,a5,1
    8000327c:	fef42623          	sw	a5,-20(s0)
    80003280:	fec42783          	lw	a5,-20(s0)
    80003284:	0007871b          	sext.w	a4,a5
    80003288:	47bd                	li	a5,15
    8000328a:	fae7d4e3          	bge	a5,a4,80003232 <exit+0x42>
    }
  }

  begin_op();
    8000328e:	00003097          	auipc	ra,0x3
    80003292:	14a080e7          	jalr	330(ra) # 800063d8 <begin_op>
  iput(p->cwd);
    80003296:	fe043783          	ld	a5,-32(s0)
    8000329a:	1507b783          	ld	a5,336(a5)
    8000329e:	853e                	mv	a0,a5
    800032a0:	00002097          	auipc	ra,0x2
    800032a4:	232080e7          	jalr	562(ra) # 800054d2 <iput>
  end_op();
    800032a8:	00003097          	auipc	ra,0x3
    800032ac:	1f2080e7          	jalr	498(ra) # 8000649a <end_op>
  p->cwd = 0;
    800032b0:	fe043783          	ld	a5,-32(s0)
    800032b4:	1407b823          	sd	zero,336(a5)

  acquire(&wait_lock);
    800032b8:	0001b517          	auipc	a0,0x1b
    800032bc:	4b850513          	addi	a0,a0,1208 # 8001e770 <wait_lock>
    800032c0:	ffffe097          	auipc	ra,0xffffe
    800032c4:	070080e7          	jalr	112(ra) # 80001330 <acquire>

  // Give any children to init.
  reparent(p);
    800032c8:	fe043503          	ld	a0,-32(s0)
    800032cc:	00000097          	auipc	ra,0x0
    800032d0:	eb0080e7          	jalr	-336(ra) # 8000317c <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    800032d4:	fe043783          	ld	a5,-32(s0)
    800032d8:	7f9c                	ld	a5,56(a5)
    800032da:	853e                	mv	a0,a5
    800032dc:	00000097          	auipc	ra,0x0
    800032e0:	468080e7          	jalr	1128(ra) # 80003744 <wakeup>
  
  acquire(&p->lock);
    800032e4:	fe043783          	ld	a5,-32(s0)
    800032e8:	853e                	mv	a0,a5
    800032ea:	ffffe097          	auipc	ra,0xffffe
    800032ee:	046080e7          	jalr	70(ra) # 80001330 <acquire>

  p->xstate = status;
    800032f2:	fe043783          	ld	a5,-32(s0)
    800032f6:	fcc42703          	lw	a4,-52(s0)
    800032fa:	d7d8                	sw	a4,44(a5)
  p->state = ZOMBIE;
    800032fc:	fe043783          	ld	a5,-32(s0)
    80003300:	4715                	li	a4,5
    80003302:	cf98                	sw	a4,24(a5)

  release(&wait_lock);
    80003304:	0001b517          	auipc	a0,0x1b
    80003308:	46c50513          	addi	a0,a0,1132 # 8001e770 <wait_lock>
    8000330c:	ffffe097          	auipc	ra,0xffffe
    80003310:	088080e7          	jalr	136(ra) # 80001394 <release>

  // Jump into the scheduler, never to return.
  sched();
    80003314:	00000097          	auipc	ra,0x0
    80003318:	230080e7          	jalr	560(ra) # 80003544 <sched>
  panic("zombie exit");
    8000331c:	0000a517          	auipc	a0,0xa
    80003320:	f0c50513          	addi	a0,a0,-244 # 8000d228 <etext+0x228>
    80003324:	ffffe097          	auipc	ra,0xffffe
    80003328:	964080e7          	jalr	-1692(ra) # 80000c88 <panic>

000000008000332c <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    8000332c:	7139                	addi	sp,sp,-64
    8000332e:	fc06                	sd	ra,56(sp)
    80003330:	f822                	sd	s0,48(sp)
    80003332:	0080                	addi	s0,sp,64
    80003334:	fca43423          	sd	a0,-56(s0)
  struct proc *pp;
  int havekids, pid;
  struct proc *p = myproc();
    80003338:	fffff097          	auipc	ra,0xfffff
    8000333c:	7c6080e7          	jalr	1990(ra) # 80002afe <myproc>
    80003340:	fca43c23          	sd	a0,-40(s0)

  acquire(&wait_lock);
    80003344:	0001b517          	auipc	a0,0x1b
    80003348:	42c50513          	addi	a0,a0,1068 # 8001e770 <wait_lock>
    8000334c:	ffffe097          	auipc	ra,0xffffe
    80003350:	fe4080e7          	jalr	-28(ra) # 80001330 <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80003354:	fe042223          	sw	zero,-28(s0)
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80003358:	00016797          	auipc	a5,0x16
    8000335c:	a0078793          	addi	a5,a5,-1536 # 80018d58 <proc>
    80003360:	fef43423          	sd	a5,-24(s0)
    80003364:	a8d1                	j	80003438 <wait+0x10c>
      if(pp->parent == p){
    80003366:	fe843783          	ld	a5,-24(s0)
    8000336a:	7f9c                	ld	a5,56(a5)
    8000336c:	fd843703          	ld	a4,-40(s0)
    80003370:	0af71e63          	bne	a4,a5,8000342c <wait+0x100>
        // make sure the child isn't still in exit() or swtch().
        acquire(&pp->lock);
    80003374:	fe843783          	ld	a5,-24(s0)
    80003378:	853e                	mv	a0,a5
    8000337a:	ffffe097          	auipc	ra,0xffffe
    8000337e:	fb6080e7          	jalr	-74(ra) # 80001330 <acquire>

        havekids = 1;
    80003382:	4785                	li	a5,1
    80003384:	fef42223          	sw	a5,-28(s0)
        if(pp->state == ZOMBIE){
    80003388:	fe843783          	ld	a5,-24(s0)
    8000338c:	4f9c                	lw	a5,24(a5)
    8000338e:	873e                	mv	a4,a5
    80003390:	4795                	li	a5,5
    80003392:	08f71663          	bne	a4,a5,8000341e <wait+0xf2>
          // Found one.
          pid = pp->pid;
    80003396:	fe843783          	ld	a5,-24(s0)
    8000339a:	5b9c                	lw	a5,48(a5)
    8000339c:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800033a0:	fc843783          	ld	a5,-56(s0)
    800033a4:	c7a9                	beqz	a5,800033ee <wait+0xc2>
    800033a6:	fd843783          	ld	a5,-40(s0)
    800033aa:	6bb8                	ld	a4,80(a5)
    800033ac:	fe843783          	ld	a5,-24(s0)
    800033b0:	02c78793          	addi	a5,a5,44
    800033b4:	4691                	li	a3,4
    800033b6:	863e                	mv	a2,a5
    800033b8:	fc843583          	ld	a1,-56(s0)
    800033bc:	853a                	mv	a0,a4
    800033be:	fffff097          	auipc	ra,0xfffff
    800033c2:	20a080e7          	jalr	522(ra) # 800025c8 <copyout>
    800033c6:	87aa                	mv	a5,a0
    800033c8:	0207d363          	bgez	a5,800033ee <wait+0xc2>
                                  sizeof(pp->xstate)) < 0) {
            release(&pp->lock);
    800033cc:	fe843783          	ld	a5,-24(s0)
    800033d0:	853e                	mv	a0,a5
    800033d2:	ffffe097          	auipc	ra,0xffffe
    800033d6:	fc2080e7          	jalr	-62(ra) # 80001394 <release>
            release(&wait_lock);
    800033da:	0001b517          	auipc	a0,0x1b
    800033de:	39650513          	addi	a0,a0,918 # 8001e770 <wait_lock>
    800033e2:	ffffe097          	auipc	ra,0xffffe
    800033e6:	fb2080e7          	jalr	-78(ra) # 80001394 <release>
            return -1;
    800033ea:	57fd                	li	a5,-1
    800033ec:	a879                	j	8000348a <wait+0x15e>
          }
          freeproc(pp);
    800033ee:	fe843503          	ld	a0,-24(s0)
    800033f2:	00000097          	auipc	ra,0x0
    800033f6:	8d0080e7          	jalr	-1840(ra) # 80002cc2 <freeproc>
          release(&pp->lock);
    800033fa:	fe843783          	ld	a5,-24(s0)
    800033fe:	853e                	mv	a0,a5
    80003400:	ffffe097          	auipc	ra,0xffffe
    80003404:	f94080e7          	jalr	-108(ra) # 80001394 <release>
          release(&wait_lock);
    80003408:	0001b517          	auipc	a0,0x1b
    8000340c:	36850513          	addi	a0,a0,872 # 8001e770 <wait_lock>
    80003410:	ffffe097          	auipc	ra,0xffffe
    80003414:	f84080e7          	jalr	-124(ra) # 80001394 <release>
          return pid;
    80003418:	fd442783          	lw	a5,-44(s0)
    8000341c:	a0bd                	j	8000348a <wait+0x15e>
        }
        release(&pp->lock);
    8000341e:	fe843783          	ld	a5,-24(s0)
    80003422:	853e                	mv	a0,a5
    80003424:	ffffe097          	auipc	ra,0xffffe
    80003428:	f70080e7          	jalr	-144(ra) # 80001394 <release>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000342c:	fe843783          	ld	a5,-24(s0)
    80003430:	16878793          	addi	a5,a5,360
    80003434:	fef43423          	sd	a5,-24(s0)
    80003438:	fe843703          	ld	a4,-24(s0)
    8000343c:	0001b797          	auipc	a5,0x1b
    80003440:	31c78793          	addi	a5,a5,796 # 8001e758 <pid_lock>
    80003444:	f2f761e3          	bltu	a4,a5,80003366 <wait+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || killed(p)){
    80003448:	fe442783          	lw	a5,-28(s0)
    8000344c:	2781                	sext.w	a5,a5
    8000344e:	cb89                	beqz	a5,80003460 <wait+0x134>
    80003450:	fd843503          	ld	a0,-40(s0)
    80003454:	00000097          	auipc	ra,0x0
    80003458:	482080e7          	jalr	1154(ra) # 800038d6 <killed>
    8000345c:	87aa                	mv	a5,a0
    8000345e:	cb99                	beqz	a5,80003474 <wait+0x148>
      release(&wait_lock);
    80003460:	0001b517          	auipc	a0,0x1b
    80003464:	31050513          	addi	a0,a0,784 # 8001e770 <wait_lock>
    80003468:	ffffe097          	auipc	ra,0xffffe
    8000346c:	f2c080e7          	jalr	-212(ra) # 80001394 <release>
      return -1;
    80003470:	57fd                	li	a5,-1
    80003472:	a821                	j	8000348a <wait+0x15e>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80003474:	0001b597          	auipc	a1,0x1b
    80003478:	2fc58593          	addi	a1,a1,764 # 8001e770 <wait_lock>
    8000347c:	fd843503          	ld	a0,-40(s0)
    80003480:	00000097          	auipc	ra,0x0
    80003484:	248080e7          	jalr	584(ra) # 800036c8 <sleep>
    havekids = 0;
    80003488:	b5f1                	j	80003354 <wait+0x28>
  }
}
    8000348a:	853e                	mv	a0,a5
    8000348c:	70e2                	ld	ra,56(sp)
    8000348e:	7442                	ld	s0,48(sp)
    80003490:	6121                	addi	sp,sp,64
    80003492:	8082                	ret

0000000080003494 <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    80003494:	1101                	addi	sp,sp,-32
    80003496:	ec06                	sd	ra,24(sp)
    80003498:	e822                	sd	s0,16(sp)
    8000349a:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    8000349c:	fffff097          	auipc	ra,0xfffff
    800034a0:	628080e7          	jalr	1576(ra) # 80002ac4 <mycpu>
    800034a4:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    800034a8:	fe043783          	ld	a5,-32(s0)
    800034ac:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    800034b0:	fffff097          	auipc	ra,0xfffff
    800034b4:	3f6080e7          	jalr	1014(ra) # 800028a6 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    800034b8:	00016797          	auipc	a5,0x16
    800034bc:	8a078793          	addi	a5,a5,-1888 # 80018d58 <proc>
    800034c0:	fef43423          	sd	a5,-24(s0)
    800034c4:	a0bd                	j	80003532 <scheduler+0x9e>
      acquire(&p->lock);
    800034c6:	fe843783          	ld	a5,-24(s0)
    800034ca:	853e                	mv	a0,a5
    800034cc:	ffffe097          	auipc	ra,0xffffe
    800034d0:	e64080e7          	jalr	-412(ra) # 80001330 <acquire>
      if(p->state == RUNNABLE) {
    800034d4:	fe843783          	ld	a5,-24(s0)
    800034d8:	4f9c                	lw	a5,24(a5)
    800034da:	873e                	mv	a4,a5
    800034dc:	478d                	li	a5,3
    800034de:	02f71d63          	bne	a4,a5,80003518 <scheduler+0x84>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    800034e2:	fe843783          	ld	a5,-24(s0)
    800034e6:	4711                	li	a4,4
    800034e8:	cf98                	sw	a4,24(a5)
        c->proc = p;
    800034ea:	fe043783          	ld	a5,-32(s0)
    800034ee:	fe843703          	ld	a4,-24(s0)
    800034f2:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    800034f4:	fe043783          	ld	a5,-32(s0)
    800034f8:	00878713          	addi	a4,a5,8
    800034fc:	fe843783          	ld	a5,-24(s0)
    80003500:	06078793          	addi	a5,a5,96
    80003504:	85be                	mv	a1,a5
    80003506:	853a                	mv	a0,a4
    80003508:	00000097          	auipc	ra,0x0
    8000350c:	5d8080e7          	jalr	1496(ra) # 80003ae0 <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    80003510:	fe043783          	ld	a5,-32(s0)
    80003514:	0007b023          	sd	zero,0(a5)
      }
      release(&p->lock);
    80003518:	fe843783          	ld	a5,-24(s0)
    8000351c:	853e                	mv	a0,a5
    8000351e:	ffffe097          	auipc	ra,0xffffe
    80003522:	e76080e7          	jalr	-394(ra) # 80001394 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80003526:	fe843783          	ld	a5,-24(s0)
    8000352a:	16878793          	addi	a5,a5,360
    8000352e:	fef43423          	sd	a5,-24(s0)
    80003532:	fe843703          	ld	a4,-24(s0)
    80003536:	0001b797          	auipc	a5,0x1b
    8000353a:	22278793          	addi	a5,a5,546 # 8001e758 <pid_lock>
    8000353e:	f8f764e3          	bltu	a4,a5,800034c6 <scheduler+0x32>
    intr_on();
    80003542:	b7bd                	j	800034b0 <scheduler+0x1c>

0000000080003544 <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    80003544:	7179                	addi	sp,sp,-48
    80003546:	f406                	sd	ra,40(sp)
    80003548:	f022                	sd	s0,32(sp)
    8000354a:	ec26                	sd	s1,24(sp)
    8000354c:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    8000354e:	fffff097          	auipc	ra,0xfffff
    80003552:	5b0080e7          	jalr	1456(ra) # 80002afe <myproc>
    80003556:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    8000355a:	fd843783          	ld	a5,-40(s0)
    8000355e:	853e                	mv	a0,a5
    80003560:	ffffe097          	auipc	ra,0xffffe
    80003564:	e8a080e7          	jalr	-374(ra) # 800013ea <holding>
    80003568:	87aa                	mv	a5,a0
    8000356a:	eb89                	bnez	a5,8000357c <sched+0x38>
    panic("sched p->lock");
    8000356c:	0000a517          	auipc	a0,0xa
    80003570:	ccc50513          	addi	a0,a0,-820 # 8000d238 <etext+0x238>
    80003574:	ffffd097          	auipc	ra,0xffffd
    80003578:	714080e7          	jalr	1812(ra) # 80000c88 <panic>
  if(mycpu()->noff != 1)
    8000357c:	fffff097          	auipc	ra,0xfffff
    80003580:	548080e7          	jalr	1352(ra) # 80002ac4 <mycpu>
    80003584:	87aa                	mv	a5,a0
    80003586:	5fbc                	lw	a5,120(a5)
    80003588:	873e                	mv	a4,a5
    8000358a:	4785                	li	a5,1
    8000358c:	00f70a63          	beq	a4,a5,800035a0 <sched+0x5c>
    panic("sched locks");
    80003590:	0000a517          	auipc	a0,0xa
    80003594:	cb850513          	addi	a0,a0,-840 # 8000d248 <etext+0x248>
    80003598:	ffffd097          	auipc	ra,0xffffd
    8000359c:	6f0080e7          	jalr	1776(ra) # 80000c88 <panic>
  if(p->state == RUNNING)
    800035a0:	fd843783          	ld	a5,-40(s0)
    800035a4:	4f9c                	lw	a5,24(a5)
    800035a6:	873e                	mv	a4,a5
    800035a8:	4791                	li	a5,4
    800035aa:	00f71a63          	bne	a4,a5,800035be <sched+0x7a>
    panic("sched running");
    800035ae:	0000a517          	auipc	a0,0xa
    800035b2:	caa50513          	addi	a0,a0,-854 # 8000d258 <etext+0x258>
    800035b6:	ffffd097          	auipc	ra,0xffffd
    800035ba:	6d2080e7          	jalr	1746(ra) # 80000c88 <panic>
  if(intr_get())
    800035be:	fffff097          	auipc	ra,0xfffff
    800035c2:	312080e7          	jalr	786(ra) # 800028d0 <intr_get>
    800035c6:	87aa                	mv	a5,a0
    800035c8:	cb89                	beqz	a5,800035da <sched+0x96>
    panic("sched interruptible");
    800035ca:	0000a517          	auipc	a0,0xa
    800035ce:	c9e50513          	addi	a0,a0,-866 # 8000d268 <etext+0x268>
    800035d2:	ffffd097          	auipc	ra,0xffffd
    800035d6:	6b6080e7          	jalr	1718(ra) # 80000c88 <panic>

  intena = mycpu()->intena;
    800035da:	fffff097          	auipc	ra,0xfffff
    800035de:	4ea080e7          	jalr	1258(ra) # 80002ac4 <mycpu>
    800035e2:	87aa                	mv	a5,a0
    800035e4:	5ffc                	lw	a5,124(a5)
    800035e6:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    800035ea:	fd843783          	ld	a5,-40(s0)
    800035ee:	06078493          	addi	s1,a5,96
    800035f2:	fffff097          	auipc	ra,0xfffff
    800035f6:	4d2080e7          	jalr	1234(ra) # 80002ac4 <mycpu>
    800035fa:	87aa                	mv	a5,a0
    800035fc:	07a1                	addi	a5,a5,8
    800035fe:	85be                	mv	a1,a5
    80003600:	8526                	mv	a0,s1
    80003602:	00000097          	auipc	ra,0x0
    80003606:	4de080e7          	jalr	1246(ra) # 80003ae0 <swtch>
  mycpu()->intena = intena;
    8000360a:	fffff097          	auipc	ra,0xfffff
    8000360e:	4ba080e7          	jalr	1210(ra) # 80002ac4 <mycpu>
    80003612:	872a                	mv	a4,a0
    80003614:	fd442783          	lw	a5,-44(s0)
    80003618:	df7c                	sw	a5,124(a4)
}
    8000361a:	0001                	nop
    8000361c:	70a2                	ld	ra,40(sp)
    8000361e:	7402                	ld	s0,32(sp)
    80003620:	64e2                	ld	s1,24(sp)
    80003622:	6145                	addi	sp,sp,48
    80003624:	8082                	ret

0000000080003626 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    80003626:	1101                	addi	sp,sp,-32
    80003628:	ec06                	sd	ra,24(sp)
    8000362a:	e822                	sd	s0,16(sp)
    8000362c:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    8000362e:	fffff097          	auipc	ra,0xfffff
    80003632:	4d0080e7          	jalr	1232(ra) # 80002afe <myproc>
    80003636:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    8000363a:	fe843783          	ld	a5,-24(s0)
    8000363e:	853e                	mv	a0,a5
    80003640:	ffffe097          	auipc	ra,0xffffe
    80003644:	cf0080e7          	jalr	-784(ra) # 80001330 <acquire>
  p->state = RUNNABLE;
    80003648:	fe843783          	ld	a5,-24(s0)
    8000364c:	470d                	li	a4,3
    8000364e:	cf98                	sw	a4,24(a5)
  sched();
    80003650:	00000097          	auipc	ra,0x0
    80003654:	ef4080e7          	jalr	-268(ra) # 80003544 <sched>
  release(&p->lock);
    80003658:	fe843783          	ld	a5,-24(s0)
    8000365c:	853e                	mv	a0,a5
    8000365e:	ffffe097          	auipc	ra,0xffffe
    80003662:	d36080e7          	jalr	-714(ra) # 80001394 <release>
}
    80003666:	0001                	nop
    80003668:	60e2                	ld	ra,24(sp)
    8000366a:	6442                	ld	s0,16(sp)
    8000366c:	6105                	addi	sp,sp,32
    8000366e:	8082                	ret

0000000080003670 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80003670:	1141                	addi	sp,sp,-16
    80003672:	e406                	sd	ra,8(sp)
    80003674:	e022                	sd	s0,0(sp)
    80003676:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80003678:	fffff097          	auipc	ra,0xfffff
    8000367c:	486080e7          	jalr	1158(ra) # 80002afe <myproc>
    80003680:	87aa                	mv	a5,a0
    80003682:	853e                	mv	a0,a5
    80003684:	ffffe097          	auipc	ra,0xffffe
    80003688:	d10080e7          	jalr	-752(ra) # 80001394 <release>

  if (first) {
    8000368c:	0000d797          	auipc	a5,0xd
    80003690:	e6878793          	addi	a5,a5,-408 # 800104f4 <first.1>
    80003694:	439c                	lw	a5,0(a5)
    80003696:	c385                	beqz	a5,800036b6 <forkret+0x46>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    80003698:	0000d797          	auipc	a5,0xd
    8000369c:	e5c78793          	addi	a5,a5,-420 # 800104f4 <first.1>
    800036a0:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    800036a4:	4505                	li	a0,1
    800036a6:	00001097          	auipc	ra,0x1
    800036aa:	540080e7          	jalr	1344(ra) # 80004be6 <fsinit>
    loadraid();
    800036ae:	00007097          	auipc	ra,0x7
    800036b2:	92c080e7          	jalr	-1748(ra) # 80009fda <loadraid>
  }

  usertrapret();
    800036b6:	00000097          	auipc	ra,0x0
    800036ba:	7dc080e7          	jalr	2012(ra) # 80003e92 <usertrapret>
}
    800036be:	0001                	nop
    800036c0:	60a2                	ld	ra,8(sp)
    800036c2:	6402                	ld	s0,0(sp)
    800036c4:	0141                	addi	sp,sp,16
    800036c6:	8082                	ret

00000000800036c8 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800036c8:	7179                	addi	sp,sp,-48
    800036ca:	f406                	sd	ra,40(sp)
    800036cc:	f022                	sd	s0,32(sp)
    800036ce:	1800                	addi	s0,sp,48
    800036d0:	fca43c23          	sd	a0,-40(s0)
    800036d4:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    800036d8:	fffff097          	auipc	ra,0xfffff
    800036dc:	426080e7          	jalr	1062(ra) # 80002afe <myproc>
    800036e0:	fea43423          	sd	a0,-24(s0)
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800036e4:	fe843783          	ld	a5,-24(s0)
    800036e8:	853e                	mv	a0,a5
    800036ea:	ffffe097          	auipc	ra,0xffffe
    800036ee:	c46080e7          	jalr	-954(ra) # 80001330 <acquire>
  release(lk);
    800036f2:	fd043503          	ld	a0,-48(s0)
    800036f6:	ffffe097          	auipc	ra,0xffffe
    800036fa:	c9e080e7          	jalr	-866(ra) # 80001394 <release>

  // Go to sleep.
  p->chan = chan;
    800036fe:	fe843783          	ld	a5,-24(s0)
    80003702:	fd843703          	ld	a4,-40(s0)
    80003706:	f398                	sd	a4,32(a5)
  p->state = SLEEPING;
    80003708:	fe843783          	ld	a5,-24(s0)
    8000370c:	4709                	li	a4,2
    8000370e:	cf98                	sw	a4,24(a5)

  sched();
    80003710:	00000097          	auipc	ra,0x0
    80003714:	e34080e7          	jalr	-460(ra) # 80003544 <sched>

  // Tidy up.
  p->chan = 0;
    80003718:	fe843783          	ld	a5,-24(s0)
    8000371c:	0207b023          	sd	zero,32(a5)

  // Reacquire original lock.
  release(&p->lock);
    80003720:	fe843783          	ld	a5,-24(s0)
    80003724:	853e                	mv	a0,a5
    80003726:	ffffe097          	auipc	ra,0xffffe
    8000372a:	c6e080e7          	jalr	-914(ra) # 80001394 <release>
  acquire(lk);
    8000372e:	fd043503          	ld	a0,-48(s0)
    80003732:	ffffe097          	auipc	ra,0xffffe
    80003736:	bfe080e7          	jalr	-1026(ra) # 80001330 <acquire>
}
    8000373a:	0001                	nop
    8000373c:	70a2                	ld	ra,40(sp)
    8000373e:	7402                	ld	s0,32(sp)
    80003740:	6145                	addi	sp,sp,48
    80003742:	8082                	ret

0000000080003744 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80003744:	7179                	addi	sp,sp,-48
    80003746:	f406                	sd	ra,40(sp)
    80003748:	f022                	sd	s0,32(sp)
    8000374a:	1800                	addi	s0,sp,48
    8000374c:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80003750:	00015797          	auipc	a5,0x15
    80003754:	60878793          	addi	a5,a5,1544 # 80018d58 <proc>
    80003758:	fef43423          	sd	a5,-24(s0)
    8000375c:	a051                	j	800037e0 <wakeup+0x9c>
    if(p != myproc()){
    8000375e:	fffff097          	auipc	ra,0xfffff
    80003762:	3a0080e7          	jalr	928(ra) # 80002afe <myproc>
    80003766:	872a                	mv	a4,a0
    80003768:	fe843783          	ld	a5,-24(s0)
    8000376c:	06e78463          	beq	a5,a4,800037d4 <wakeup+0x90>
      if (holding(&p->lock) && p->state == USED ) {
    80003770:	fe843783          	ld	a5,-24(s0)
    80003774:	853e                	mv	a0,a5
    80003776:	ffffe097          	auipc	ra,0xffffe
    8000377a:	c74080e7          	jalr	-908(ra) # 800013ea <holding>
    8000377e:	87aa                	mv	a5,a0
    80003780:	cb81                	beqz	a5,80003790 <wakeup+0x4c>
    80003782:	fe843783          	ld	a5,-24(s0)
    80003786:	4f9c                	lw	a5,24(a5)
    80003788:	873e                	mv	a4,a5
    8000378a:	4785                	li	a5,1
    8000378c:	04f70363          	beq	a4,a5,800037d2 <wakeup+0x8e>
        // Process is being created.
        continue;
      }
      acquire(&p->lock);
    80003790:	fe843783          	ld	a5,-24(s0)
    80003794:	853e                	mv	a0,a5
    80003796:	ffffe097          	auipc	ra,0xffffe
    8000379a:	b9a080e7          	jalr	-1126(ra) # 80001330 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    8000379e:	fe843783          	ld	a5,-24(s0)
    800037a2:	4f9c                	lw	a5,24(a5)
    800037a4:	873e                	mv	a4,a5
    800037a6:	4789                	li	a5,2
    800037a8:	00f71d63          	bne	a4,a5,800037c2 <wakeup+0x7e>
    800037ac:	fe843783          	ld	a5,-24(s0)
    800037b0:	739c                	ld	a5,32(a5)
    800037b2:	fd843703          	ld	a4,-40(s0)
    800037b6:	00f71663          	bne	a4,a5,800037c2 <wakeup+0x7e>
        p->state = RUNNABLE;
    800037ba:	fe843783          	ld	a5,-24(s0)
    800037be:	470d                	li	a4,3
    800037c0:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    800037c2:	fe843783          	ld	a5,-24(s0)
    800037c6:	853e                	mv	a0,a5
    800037c8:	ffffe097          	auipc	ra,0xffffe
    800037cc:	bcc080e7          	jalr	-1076(ra) # 80001394 <release>
    800037d0:	a011                	j	800037d4 <wakeup+0x90>
        continue;
    800037d2:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++) {
    800037d4:	fe843783          	ld	a5,-24(s0)
    800037d8:	16878793          	addi	a5,a5,360
    800037dc:	fef43423          	sd	a5,-24(s0)
    800037e0:	fe843703          	ld	a4,-24(s0)
    800037e4:	0001b797          	auipc	a5,0x1b
    800037e8:	f7478793          	addi	a5,a5,-140 # 8001e758 <pid_lock>
    800037ec:	f6f769e3          	bltu	a4,a5,8000375e <wakeup+0x1a>
    }
  }
}
    800037f0:	0001                	nop
    800037f2:	0001                	nop
    800037f4:	70a2                	ld	ra,40(sp)
    800037f6:	7402                	ld	s0,32(sp)
    800037f8:	6145                	addi	sp,sp,48
    800037fa:	8082                	ret

00000000800037fc <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800037fc:	7179                	addi	sp,sp,-48
    800037fe:	f406                	sd	ra,40(sp)
    80003800:	f022                	sd	s0,32(sp)
    80003802:	1800                	addi	s0,sp,48
    80003804:	87aa                	mv	a5,a0
    80003806:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    8000380a:	00015797          	auipc	a5,0x15
    8000380e:	54e78793          	addi	a5,a5,1358 # 80018d58 <proc>
    80003812:	fef43423          	sd	a5,-24(s0)
    80003816:	a0ad                	j	80003880 <kill+0x84>
    acquire(&p->lock);
    80003818:	fe843783          	ld	a5,-24(s0)
    8000381c:	853e                	mv	a0,a5
    8000381e:	ffffe097          	auipc	ra,0xffffe
    80003822:	b12080e7          	jalr	-1262(ra) # 80001330 <acquire>
    if(p->pid == pid){
    80003826:	fe843783          	ld	a5,-24(s0)
    8000382a:	5b98                	lw	a4,48(a5)
    8000382c:	fdc42783          	lw	a5,-36(s0)
    80003830:	2781                	sext.w	a5,a5
    80003832:	02e79a63          	bne	a5,a4,80003866 <kill+0x6a>
      p->killed = 1;
    80003836:	fe843783          	ld	a5,-24(s0)
    8000383a:	4705                	li	a4,1
    8000383c:	d798                	sw	a4,40(a5)
      if(p->state == SLEEPING){
    8000383e:	fe843783          	ld	a5,-24(s0)
    80003842:	4f9c                	lw	a5,24(a5)
    80003844:	873e                	mv	a4,a5
    80003846:	4789                	li	a5,2
    80003848:	00f71663          	bne	a4,a5,80003854 <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    8000384c:	fe843783          	ld	a5,-24(s0)
    80003850:	470d                	li	a4,3
    80003852:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80003854:	fe843783          	ld	a5,-24(s0)
    80003858:	853e                	mv	a0,a5
    8000385a:	ffffe097          	auipc	ra,0xffffe
    8000385e:	b3a080e7          	jalr	-1222(ra) # 80001394 <release>
      return 0;
    80003862:	4781                	li	a5,0
    80003864:	a03d                	j	80003892 <kill+0x96>
    }
    release(&p->lock);
    80003866:	fe843783          	ld	a5,-24(s0)
    8000386a:	853e                	mv	a0,a5
    8000386c:	ffffe097          	auipc	ra,0xffffe
    80003870:	b28080e7          	jalr	-1240(ra) # 80001394 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80003874:	fe843783          	ld	a5,-24(s0)
    80003878:	16878793          	addi	a5,a5,360
    8000387c:	fef43423          	sd	a5,-24(s0)
    80003880:	fe843703          	ld	a4,-24(s0)
    80003884:	0001b797          	auipc	a5,0x1b
    80003888:	ed478793          	addi	a5,a5,-300 # 8001e758 <pid_lock>
    8000388c:	f8f766e3          	bltu	a4,a5,80003818 <kill+0x1c>
  }
  return -1;
    80003890:	57fd                	li	a5,-1
}
    80003892:	853e                	mv	a0,a5
    80003894:	70a2                	ld	ra,40(sp)
    80003896:	7402                	ld	s0,32(sp)
    80003898:	6145                	addi	sp,sp,48
    8000389a:	8082                	ret

000000008000389c <setkilled>:

void
setkilled(struct proc *p)
{
    8000389c:	1101                	addi	sp,sp,-32
    8000389e:	ec06                	sd	ra,24(sp)
    800038a0:	e822                	sd	s0,16(sp)
    800038a2:	1000                	addi	s0,sp,32
    800038a4:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    800038a8:	fe843783          	ld	a5,-24(s0)
    800038ac:	853e                	mv	a0,a5
    800038ae:	ffffe097          	auipc	ra,0xffffe
    800038b2:	a82080e7          	jalr	-1406(ra) # 80001330 <acquire>
  p->killed = 1;
    800038b6:	fe843783          	ld	a5,-24(s0)
    800038ba:	4705                	li	a4,1
    800038bc:	d798                	sw	a4,40(a5)
  release(&p->lock);
    800038be:	fe843783          	ld	a5,-24(s0)
    800038c2:	853e                	mv	a0,a5
    800038c4:	ffffe097          	auipc	ra,0xffffe
    800038c8:	ad0080e7          	jalr	-1328(ra) # 80001394 <release>
}
    800038cc:	0001                	nop
    800038ce:	60e2                	ld	ra,24(sp)
    800038d0:	6442                	ld	s0,16(sp)
    800038d2:	6105                	addi	sp,sp,32
    800038d4:	8082                	ret

00000000800038d6 <killed>:

int
killed(struct proc *p)
{
    800038d6:	7179                	addi	sp,sp,-48
    800038d8:	f406                	sd	ra,40(sp)
    800038da:	f022                	sd	s0,32(sp)
    800038dc:	1800                	addi	s0,sp,48
    800038de:	fca43c23          	sd	a0,-40(s0)
  int k;
  
  acquire(&p->lock);
    800038e2:	fd843783          	ld	a5,-40(s0)
    800038e6:	853e                	mv	a0,a5
    800038e8:	ffffe097          	auipc	ra,0xffffe
    800038ec:	a48080e7          	jalr	-1464(ra) # 80001330 <acquire>
  k = p->killed;
    800038f0:	fd843783          	ld	a5,-40(s0)
    800038f4:	579c                	lw	a5,40(a5)
    800038f6:	fef42623          	sw	a5,-20(s0)
  release(&p->lock);
    800038fa:	fd843783          	ld	a5,-40(s0)
    800038fe:	853e                	mv	a0,a5
    80003900:	ffffe097          	auipc	ra,0xffffe
    80003904:	a94080e7          	jalr	-1388(ra) # 80001394 <release>
  return k;
    80003908:	fec42783          	lw	a5,-20(s0)
}
    8000390c:	853e                	mv	a0,a5
    8000390e:	70a2                	ld	ra,40(sp)
    80003910:	7402                	ld	s0,32(sp)
    80003912:	6145                	addi	sp,sp,48
    80003914:	8082                	ret

0000000080003916 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80003916:	7139                	addi	sp,sp,-64
    80003918:	fc06                	sd	ra,56(sp)
    8000391a:	f822                	sd	s0,48(sp)
    8000391c:	0080                	addi	s0,sp,64
    8000391e:	87aa                	mv	a5,a0
    80003920:	fcb43823          	sd	a1,-48(s0)
    80003924:	fcc43423          	sd	a2,-56(s0)
    80003928:	fcd43023          	sd	a3,-64(s0)
    8000392c:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003930:	fffff097          	auipc	ra,0xfffff
    80003934:	1ce080e7          	jalr	462(ra) # 80002afe <myproc>
    80003938:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    8000393c:	fdc42783          	lw	a5,-36(s0)
    80003940:	2781                	sext.w	a5,a5
    80003942:	c38d                	beqz	a5,80003964 <either_copyout+0x4e>
    return copyout(p->pagetable, dst, src, len);
    80003944:	fe843783          	ld	a5,-24(s0)
    80003948:	6bbc                	ld	a5,80(a5)
    8000394a:	fc043683          	ld	a3,-64(s0)
    8000394e:	fc843603          	ld	a2,-56(s0)
    80003952:	fd043583          	ld	a1,-48(s0)
    80003956:	853e                	mv	a0,a5
    80003958:	fffff097          	auipc	ra,0xfffff
    8000395c:	c70080e7          	jalr	-912(ra) # 800025c8 <copyout>
    80003960:	87aa                	mv	a5,a0
    80003962:	a839                	j	80003980 <either_copyout+0x6a>
  } else {
    memmove((char *)dst, src, len);
    80003964:	fd043783          	ld	a5,-48(s0)
    80003968:	fc043703          	ld	a4,-64(s0)
    8000396c:	2701                	sext.w	a4,a4
    8000396e:	863a                	mv	a2,a4
    80003970:	fc843583          	ld	a1,-56(s0)
    80003974:	853e                	mv	a0,a5
    80003976:	ffffe097          	auipc	ra,0xffffe
    8000397a:	c72080e7          	jalr	-910(ra) # 800015e8 <memmove>
    return 0;
    8000397e:	4781                	li	a5,0
  }
}
    80003980:	853e                	mv	a0,a5
    80003982:	70e2                	ld	ra,56(sp)
    80003984:	7442                	ld	s0,48(sp)
    80003986:	6121                	addi	sp,sp,64
    80003988:	8082                	ret

000000008000398a <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000398a:	7139                	addi	sp,sp,-64
    8000398c:	fc06                	sd	ra,56(sp)
    8000398e:	f822                	sd	s0,48(sp)
    80003990:	0080                	addi	s0,sp,64
    80003992:	fca43c23          	sd	a0,-40(s0)
    80003996:	87ae                	mv	a5,a1
    80003998:	fcc43423          	sd	a2,-56(s0)
    8000399c:	fcd43023          	sd	a3,-64(s0)
    800039a0:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    800039a4:	fffff097          	auipc	ra,0xfffff
    800039a8:	15a080e7          	jalr	346(ra) # 80002afe <myproc>
    800039ac:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    800039b0:	fd442783          	lw	a5,-44(s0)
    800039b4:	2781                	sext.w	a5,a5
    800039b6:	c38d                	beqz	a5,800039d8 <either_copyin+0x4e>
    return copyin(p->pagetable, dst, src, len);
    800039b8:	fe843783          	ld	a5,-24(s0)
    800039bc:	6bbc                	ld	a5,80(a5)
    800039be:	fc043683          	ld	a3,-64(s0)
    800039c2:	fc843603          	ld	a2,-56(s0)
    800039c6:	fd843583          	ld	a1,-40(s0)
    800039ca:	853e                	mv	a0,a5
    800039cc:	fffff097          	auipc	ra,0xfffff
    800039d0:	cca080e7          	jalr	-822(ra) # 80002696 <copyin>
    800039d4:	87aa                	mv	a5,a0
    800039d6:	a839                	j	800039f4 <either_copyin+0x6a>
  } else {
    memmove(dst, (char*)src, len);
    800039d8:	fc843783          	ld	a5,-56(s0)
    800039dc:	fc043703          	ld	a4,-64(s0)
    800039e0:	2701                	sext.w	a4,a4
    800039e2:	863a                	mv	a2,a4
    800039e4:	85be                	mv	a1,a5
    800039e6:	fd843503          	ld	a0,-40(s0)
    800039ea:	ffffe097          	auipc	ra,0xffffe
    800039ee:	bfe080e7          	jalr	-1026(ra) # 800015e8 <memmove>
    return 0;
    800039f2:	4781                	li	a5,0
  }
}
    800039f4:	853e                	mv	a0,a5
    800039f6:	70e2                	ld	ra,56(sp)
    800039f8:	7442                	ld	s0,48(sp)
    800039fa:	6121                	addi	sp,sp,64
    800039fc:	8082                	ret

00000000800039fe <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800039fe:	1101                	addi	sp,sp,-32
    80003a00:	ec06                	sd	ra,24(sp)
    80003a02:	e822                	sd	s0,16(sp)
    80003a04:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80003a06:	0000a517          	auipc	a0,0xa
    80003a0a:	87a50513          	addi	a0,a0,-1926 # 8000d280 <etext+0x280>
    80003a0e:	ffffd097          	auipc	ra,0xffffd
    80003a12:	024080e7          	jalr	36(ra) # 80000a32 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80003a16:	00015797          	auipc	a5,0x15
    80003a1a:	34278793          	addi	a5,a5,834 # 80018d58 <proc>
    80003a1e:	fef43423          	sd	a5,-24(s0)
    80003a22:	a04d                	j	80003ac4 <procdump+0xc6>
    if(p->state == UNUSED)
    80003a24:	fe843783          	ld	a5,-24(s0)
    80003a28:	4f9c                	lw	a5,24(a5)
    80003a2a:	c7d1                	beqz	a5,80003ab6 <procdump+0xb8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80003a2c:	fe843783          	ld	a5,-24(s0)
    80003a30:	4f9c                	lw	a5,24(a5)
    80003a32:	873e                	mv	a4,a5
    80003a34:	4795                	li	a5,5
    80003a36:	02e7ee63          	bltu	a5,a4,80003a72 <procdump+0x74>
    80003a3a:	fe843783          	ld	a5,-24(s0)
    80003a3e:	4f9c                	lw	a5,24(a5)
    80003a40:	0000d717          	auipc	a4,0xd
    80003a44:	b2870713          	addi	a4,a4,-1240 # 80010568 <states.0>
    80003a48:	1782                	slli	a5,a5,0x20
    80003a4a:	9381                	srli	a5,a5,0x20
    80003a4c:	078e                	slli	a5,a5,0x3
    80003a4e:	97ba                	add	a5,a5,a4
    80003a50:	639c                	ld	a5,0(a5)
    80003a52:	c385                	beqz	a5,80003a72 <procdump+0x74>
      state = states[p->state];
    80003a54:	fe843783          	ld	a5,-24(s0)
    80003a58:	4f9c                	lw	a5,24(a5)
    80003a5a:	0000d717          	auipc	a4,0xd
    80003a5e:	b0e70713          	addi	a4,a4,-1266 # 80010568 <states.0>
    80003a62:	1782                	slli	a5,a5,0x20
    80003a64:	9381                	srli	a5,a5,0x20
    80003a66:	078e                	slli	a5,a5,0x3
    80003a68:	97ba                	add	a5,a5,a4
    80003a6a:	639c                	ld	a5,0(a5)
    80003a6c:	fef43023          	sd	a5,-32(s0)
    80003a70:	a039                	j	80003a7e <procdump+0x80>
    else
      state = "???";
    80003a72:	0000a797          	auipc	a5,0xa
    80003a76:	81678793          	addi	a5,a5,-2026 # 8000d288 <etext+0x288>
    80003a7a:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    80003a7e:	fe843783          	ld	a5,-24(s0)
    80003a82:	5b98                	lw	a4,48(a5)
    80003a84:	fe843783          	ld	a5,-24(s0)
    80003a88:	15878793          	addi	a5,a5,344
    80003a8c:	86be                	mv	a3,a5
    80003a8e:	fe043603          	ld	a2,-32(s0)
    80003a92:	85ba                	mv	a1,a4
    80003a94:	00009517          	auipc	a0,0x9
    80003a98:	7fc50513          	addi	a0,a0,2044 # 8000d290 <etext+0x290>
    80003a9c:	ffffd097          	auipc	ra,0xffffd
    80003aa0:	f96080e7          	jalr	-106(ra) # 80000a32 <printf>
    printf("\n");
    80003aa4:	00009517          	auipc	a0,0x9
    80003aa8:	7dc50513          	addi	a0,a0,2012 # 8000d280 <etext+0x280>
    80003aac:	ffffd097          	auipc	ra,0xffffd
    80003ab0:	f86080e7          	jalr	-122(ra) # 80000a32 <printf>
    80003ab4:	a011                	j	80003ab8 <procdump+0xba>
      continue;
    80003ab6:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    80003ab8:	fe843783          	ld	a5,-24(s0)
    80003abc:	16878793          	addi	a5,a5,360
    80003ac0:	fef43423          	sd	a5,-24(s0)
    80003ac4:	fe843703          	ld	a4,-24(s0)
    80003ac8:	0001b797          	auipc	a5,0x1b
    80003acc:	c9078793          	addi	a5,a5,-880 # 8001e758 <pid_lock>
    80003ad0:	f4f76ae3          	bltu	a4,a5,80003a24 <procdump+0x26>
  }
}
    80003ad4:	0001                	nop
    80003ad6:	0001                	nop
    80003ad8:	60e2                	ld	ra,24(sp)
    80003ada:	6442                	ld	s0,16(sp)
    80003adc:	6105                	addi	sp,sp,32
    80003ade:	8082                	ret

0000000080003ae0 <swtch>:
    80003ae0:	00153023          	sd	ra,0(a0)
    80003ae4:	00253423          	sd	sp,8(a0)
    80003ae8:	e900                	sd	s0,16(a0)
    80003aea:	ed04                	sd	s1,24(a0)
    80003aec:	03253023          	sd	s2,32(a0)
    80003af0:	03353423          	sd	s3,40(a0)
    80003af4:	03453823          	sd	s4,48(a0)
    80003af8:	03553c23          	sd	s5,56(a0)
    80003afc:	05653023          	sd	s6,64(a0)
    80003b00:	05753423          	sd	s7,72(a0)
    80003b04:	05853823          	sd	s8,80(a0)
    80003b08:	05953c23          	sd	s9,88(a0)
    80003b0c:	07a53023          	sd	s10,96(a0)
    80003b10:	07b53423          	sd	s11,104(a0)
    80003b14:	0005b083          	ld	ra,0(a1)
    80003b18:	0085b103          	ld	sp,8(a1)
    80003b1c:	6980                	ld	s0,16(a1)
    80003b1e:	6d84                	ld	s1,24(a1)
    80003b20:	0205b903          	ld	s2,32(a1)
    80003b24:	0285b983          	ld	s3,40(a1)
    80003b28:	0305ba03          	ld	s4,48(a1)
    80003b2c:	0385ba83          	ld	s5,56(a1)
    80003b30:	0405bb03          	ld	s6,64(a1)
    80003b34:	0485bb83          	ld	s7,72(a1)
    80003b38:	0505bc03          	ld	s8,80(a1)
    80003b3c:	0585bc83          	ld	s9,88(a1)
    80003b40:	0605bd03          	ld	s10,96(a1)
    80003b44:	0685bd83          	ld	s11,104(a1)
    80003b48:	8082                	ret

0000000080003b4a <r_sstatus>:
{
    80003b4a:	1101                	addi	sp,sp,-32
    80003b4c:	ec22                	sd	s0,24(sp)
    80003b4e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80003b50:	100027f3          	csrr	a5,sstatus
    80003b54:	fef43423          	sd	a5,-24(s0)
  return x;
    80003b58:	fe843783          	ld	a5,-24(s0)
}
    80003b5c:	853e                	mv	a0,a5
    80003b5e:	6462                	ld	s0,24(sp)
    80003b60:	6105                	addi	sp,sp,32
    80003b62:	8082                	ret

0000000080003b64 <w_sstatus>:
{
    80003b64:	1101                	addi	sp,sp,-32
    80003b66:	ec22                	sd	s0,24(sp)
    80003b68:	1000                	addi	s0,sp,32
    80003b6a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80003b6e:	fe843783          	ld	a5,-24(s0)
    80003b72:	10079073          	csrw	sstatus,a5
}
    80003b76:	0001                	nop
    80003b78:	6462                	ld	s0,24(sp)
    80003b7a:	6105                	addi	sp,sp,32
    80003b7c:	8082                	ret

0000000080003b7e <r_sip>:
{
    80003b7e:	1101                	addi	sp,sp,-32
    80003b80:	ec22                	sd	s0,24(sp)
    80003b82:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    80003b84:	144027f3          	csrr	a5,sip
    80003b88:	fef43423          	sd	a5,-24(s0)
  return x;
    80003b8c:	fe843783          	ld	a5,-24(s0)
}
    80003b90:	853e                	mv	a0,a5
    80003b92:	6462                	ld	s0,24(sp)
    80003b94:	6105                	addi	sp,sp,32
    80003b96:	8082                	ret

0000000080003b98 <w_sip>:
{
    80003b98:	1101                	addi	sp,sp,-32
    80003b9a:	ec22                	sd	s0,24(sp)
    80003b9c:	1000                	addi	s0,sp,32
    80003b9e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    80003ba2:	fe843783          	ld	a5,-24(s0)
    80003ba6:	14479073          	csrw	sip,a5
}
    80003baa:	0001                	nop
    80003bac:	6462                	ld	s0,24(sp)
    80003bae:	6105                	addi	sp,sp,32
    80003bb0:	8082                	ret

0000000080003bb2 <w_sepc>:
{
    80003bb2:	1101                	addi	sp,sp,-32
    80003bb4:	ec22                	sd	s0,24(sp)
    80003bb6:	1000                	addi	s0,sp,32
    80003bb8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80003bbc:	fe843783          	ld	a5,-24(s0)
    80003bc0:	14179073          	csrw	sepc,a5
}
    80003bc4:	0001                	nop
    80003bc6:	6462                	ld	s0,24(sp)
    80003bc8:	6105                	addi	sp,sp,32
    80003bca:	8082                	ret

0000000080003bcc <r_sepc>:
{
    80003bcc:	1101                	addi	sp,sp,-32
    80003bce:	ec22                	sd	s0,24(sp)
    80003bd0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003bd2:	141027f3          	csrr	a5,sepc
    80003bd6:	fef43423          	sd	a5,-24(s0)
  return x;
    80003bda:	fe843783          	ld	a5,-24(s0)
}
    80003bde:	853e                	mv	a0,a5
    80003be0:	6462                	ld	s0,24(sp)
    80003be2:	6105                	addi	sp,sp,32
    80003be4:	8082                	ret

0000000080003be6 <w_stvec>:
{
    80003be6:	1101                	addi	sp,sp,-32
    80003be8:	ec22                	sd	s0,24(sp)
    80003bea:	1000                	addi	s0,sp,32
    80003bec:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    80003bf0:	fe843783          	ld	a5,-24(s0)
    80003bf4:	10579073          	csrw	stvec,a5
}
    80003bf8:	0001                	nop
    80003bfa:	6462                	ld	s0,24(sp)
    80003bfc:	6105                	addi	sp,sp,32
    80003bfe:	8082                	ret

0000000080003c00 <r_satp>:
{
    80003c00:	1101                	addi	sp,sp,-32
    80003c02:	ec22                	sd	s0,24(sp)
    80003c04:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    80003c06:	180027f3          	csrr	a5,satp
    80003c0a:	fef43423          	sd	a5,-24(s0)
  return x;
    80003c0e:	fe843783          	ld	a5,-24(s0)
}
    80003c12:	853e                	mv	a0,a5
    80003c14:	6462                	ld	s0,24(sp)
    80003c16:	6105                	addi	sp,sp,32
    80003c18:	8082                	ret

0000000080003c1a <r_scause>:
{
    80003c1a:	1101                	addi	sp,sp,-32
    80003c1c:	ec22                	sd	s0,24(sp)
    80003c1e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80003c20:	142027f3          	csrr	a5,scause
    80003c24:	fef43423          	sd	a5,-24(s0)
  return x;
    80003c28:	fe843783          	ld	a5,-24(s0)
}
    80003c2c:	853e                	mv	a0,a5
    80003c2e:	6462                	ld	s0,24(sp)
    80003c30:	6105                	addi	sp,sp,32
    80003c32:	8082                	ret

0000000080003c34 <r_stval>:
{
    80003c34:	1101                	addi	sp,sp,-32
    80003c36:	ec22                	sd	s0,24(sp)
    80003c38:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003c3a:	143027f3          	csrr	a5,stval
    80003c3e:	fef43423          	sd	a5,-24(s0)
  return x;
    80003c42:	fe843783          	ld	a5,-24(s0)
}
    80003c46:	853e                	mv	a0,a5
    80003c48:	6462                	ld	s0,24(sp)
    80003c4a:	6105                	addi	sp,sp,32
    80003c4c:	8082                	ret

0000000080003c4e <intr_on>:
{
    80003c4e:	1141                	addi	sp,sp,-16
    80003c50:	e406                	sd	ra,8(sp)
    80003c52:	e022                	sd	s0,0(sp)
    80003c54:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80003c56:	00000097          	auipc	ra,0x0
    80003c5a:	ef4080e7          	jalr	-268(ra) # 80003b4a <r_sstatus>
    80003c5e:	87aa                	mv	a5,a0
    80003c60:	0027e793          	ori	a5,a5,2
    80003c64:	853e                	mv	a0,a5
    80003c66:	00000097          	auipc	ra,0x0
    80003c6a:	efe080e7          	jalr	-258(ra) # 80003b64 <w_sstatus>
}
    80003c6e:	0001                	nop
    80003c70:	60a2                	ld	ra,8(sp)
    80003c72:	6402                	ld	s0,0(sp)
    80003c74:	0141                	addi	sp,sp,16
    80003c76:	8082                	ret

0000000080003c78 <intr_off>:
{
    80003c78:	1141                	addi	sp,sp,-16
    80003c7a:	e406                	sd	ra,8(sp)
    80003c7c:	e022                	sd	s0,0(sp)
    80003c7e:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80003c80:	00000097          	auipc	ra,0x0
    80003c84:	eca080e7          	jalr	-310(ra) # 80003b4a <r_sstatus>
    80003c88:	87aa                	mv	a5,a0
    80003c8a:	9bf5                	andi	a5,a5,-3
    80003c8c:	853e                	mv	a0,a5
    80003c8e:	00000097          	auipc	ra,0x0
    80003c92:	ed6080e7          	jalr	-298(ra) # 80003b64 <w_sstatus>
}
    80003c96:	0001                	nop
    80003c98:	60a2                	ld	ra,8(sp)
    80003c9a:	6402                	ld	s0,0(sp)
    80003c9c:	0141                	addi	sp,sp,16
    80003c9e:	8082                	ret

0000000080003ca0 <intr_get>:
{
    80003ca0:	1101                	addi	sp,sp,-32
    80003ca2:	ec06                	sd	ra,24(sp)
    80003ca4:	e822                	sd	s0,16(sp)
    80003ca6:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80003ca8:	00000097          	auipc	ra,0x0
    80003cac:	ea2080e7          	jalr	-350(ra) # 80003b4a <r_sstatus>
    80003cb0:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80003cb4:	fe843783          	ld	a5,-24(s0)
    80003cb8:	8b89                	andi	a5,a5,2
    80003cba:	00f037b3          	snez	a5,a5
    80003cbe:	0ff7f793          	zext.b	a5,a5
    80003cc2:	2781                	sext.w	a5,a5
}
    80003cc4:	853e                	mv	a0,a5
    80003cc6:	60e2                	ld	ra,24(sp)
    80003cc8:	6442                	ld	s0,16(sp)
    80003cca:	6105                	addi	sp,sp,32
    80003ccc:	8082                	ret

0000000080003cce <r_tp>:
{
    80003cce:	1101                	addi	sp,sp,-32
    80003cd0:	ec22                	sd	s0,24(sp)
    80003cd2:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80003cd4:	8792                	mv	a5,tp
    80003cd6:	fef43423          	sd	a5,-24(s0)
  return x;
    80003cda:	fe843783          	ld	a5,-24(s0)
}
    80003cde:	853e                	mv	a0,a5
    80003ce0:	6462                	ld	s0,24(sp)
    80003ce2:	6105                	addi	sp,sp,32
    80003ce4:	8082                	ret

0000000080003ce6 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80003ce6:	1141                	addi	sp,sp,-16
    80003ce8:	e406                	sd	ra,8(sp)
    80003cea:	e022                	sd	s0,0(sp)
    80003cec:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80003cee:	00009597          	auipc	a1,0x9
    80003cf2:	5ea58593          	addi	a1,a1,1514 # 8000d2d8 <etext+0x2d8>
    80003cf6:	0001b517          	auipc	a0,0x1b
    80003cfa:	a9250513          	addi	a0,a0,-1390 # 8001e788 <tickslock>
    80003cfe:	ffffd097          	auipc	ra,0xffffd
    80003d02:	602080e7          	jalr	1538(ra) # 80001300 <initlock>
}
    80003d06:	0001                	nop
    80003d08:	60a2                	ld	ra,8(sp)
    80003d0a:	6402                	ld	s0,0(sp)
    80003d0c:	0141                	addi	sp,sp,16
    80003d0e:	8082                	ret

0000000080003d10 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80003d10:	1141                	addi	sp,sp,-16
    80003d12:	e406                	sd	ra,8(sp)
    80003d14:	e022                	sd	s0,0(sp)
    80003d16:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    80003d18:	00005797          	auipc	a5,0x5
    80003d1c:	d8878793          	addi	a5,a5,-632 # 80008aa0 <kernelvec>
    80003d20:	853e                	mv	a0,a5
    80003d22:	00000097          	auipc	ra,0x0
    80003d26:	ec4080e7          	jalr	-316(ra) # 80003be6 <w_stvec>
}
    80003d2a:	0001                	nop
    80003d2c:	60a2                	ld	ra,8(sp)
    80003d2e:	6402                	ld	s0,0(sp)
    80003d30:	0141                	addi	sp,sp,16
    80003d32:	8082                	ret

0000000080003d34 <usertrap>:
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
    80003d34:	7179                	addi	sp,sp,-48
    80003d36:	f406                	sd	ra,40(sp)
    80003d38:	f022                	sd	s0,32(sp)
    80003d3a:	ec26                	sd	s1,24(sp)
    80003d3c:	1800                	addi	s0,sp,48
  int which_dev = 0;
    80003d3e:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    80003d42:	00000097          	auipc	ra,0x0
    80003d46:	e08080e7          	jalr	-504(ra) # 80003b4a <r_sstatus>
    80003d4a:	87aa                	mv	a5,a0
    80003d4c:	1007f793          	andi	a5,a5,256
    80003d50:	cb89                	beqz	a5,80003d62 <usertrap+0x2e>
    panic("usertrap: not from user mode");
    80003d52:	00009517          	auipc	a0,0x9
    80003d56:	58e50513          	addi	a0,a0,1422 # 8000d2e0 <etext+0x2e0>
    80003d5a:	ffffd097          	auipc	ra,0xffffd
    80003d5e:	f2e080e7          	jalr	-210(ra) # 80000c88 <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    80003d62:	00005797          	auipc	a5,0x5
    80003d66:	d3e78793          	addi	a5,a5,-706 # 80008aa0 <kernelvec>
    80003d6a:	853e                	mv	a0,a5
    80003d6c:	00000097          	auipc	ra,0x0
    80003d70:	e7a080e7          	jalr	-390(ra) # 80003be6 <w_stvec>

  struct proc *p = myproc();
    80003d74:	fffff097          	auipc	ra,0xfffff
    80003d78:	d8a080e7          	jalr	-630(ra) # 80002afe <myproc>
    80003d7c:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    80003d80:	fd043783          	ld	a5,-48(s0)
    80003d84:	6fa4                	ld	s1,88(a5)
    80003d86:	00000097          	auipc	ra,0x0
    80003d8a:	e46080e7          	jalr	-442(ra) # 80003bcc <r_sepc>
    80003d8e:	87aa                	mv	a5,a0
    80003d90:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    80003d92:	00000097          	auipc	ra,0x0
    80003d96:	e88080e7          	jalr	-376(ra) # 80003c1a <r_scause>
    80003d9a:	872a                	mv	a4,a0
    80003d9c:	47a1                	li	a5,8
    80003d9e:	04f71163          	bne	a4,a5,80003de0 <usertrap+0xac>
    // system call

    if(killed(p))
    80003da2:	fd043503          	ld	a0,-48(s0)
    80003da6:	00000097          	auipc	ra,0x0
    80003daa:	b30080e7          	jalr	-1232(ra) # 800038d6 <killed>
    80003dae:	87aa                	mv	a5,a0
    80003db0:	c791                	beqz	a5,80003dbc <usertrap+0x88>
      exit(-1);
    80003db2:	557d                	li	a0,-1
    80003db4:	fffff097          	auipc	ra,0xfffff
    80003db8:	43c080e7          	jalr	1084(ra) # 800031f0 <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    80003dbc:	fd043783          	ld	a5,-48(s0)
    80003dc0:	6fbc                	ld	a5,88(a5)
    80003dc2:	6f98                	ld	a4,24(a5)
    80003dc4:	fd043783          	ld	a5,-48(s0)
    80003dc8:	6fbc                	ld	a5,88(a5)
    80003dca:	0711                	addi	a4,a4,4
    80003dcc:	ef98                	sd	a4,24(a5)

    // an interrupt will change sepc, scause, and sstatus,
    // so enable only now that we're done with those registers.
    intr_on();
    80003dce:	00000097          	auipc	ra,0x0
    80003dd2:	e80080e7          	jalr	-384(ra) # 80003c4e <intr_on>

    syscall();
    80003dd6:	00000097          	auipc	ra,0x0
    80003dda:	69e080e7          	jalr	1694(ra) # 80004474 <syscall>
    80003dde:	a885                	j	80003e4e <usertrap+0x11a>
  } else if((which_dev = devintr()) != 0){
    80003de0:	00000097          	auipc	ra,0x0
    80003de4:	34e080e7          	jalr	846(ra) # 8000412e <devintr>
    80003de8:	87aa                	mv	a5,a0
    80003dea:	fcf42e23          	sw	a5,-36(s0)
    80003dee:	fdc42783          	lw	a5,-36(s0)
    80003df2:	2781                	sext.w	a5,a5
    80003df4:	efa9                	bnez	a5,80003e4e <usertrap+0x11a>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80003df6:	00000097          	auipc	ra,0x0
    80003dfa:	e24080e7          	jalr	-476(ra) # 80003c1a <r_scause>
    80003dfe:	872a                	mv	a4,a0
    80003e00:	fd043783          	ld	a5,-48(s0)
    80003e04:	5b9c                	lw	a5,48(a5)
    80003e06:	863e                	mv	a2,a5
    80003e08:	85ba                	mv	a1,a4
    80003e0a:	00009517          	auipc	a0,0x9
    80003e0e:	4f650513          	addi	a0,a0,1270 # 8000d300 <etext+0x300>
    80003e12:	ffffd097          	auipc	ra,0xffffd
    80003e16:	c20080e7          	jalr	-992(ra) # 80000a32 <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80003e1a:	00000097          	auipc	ra,0x0
    80003e1e:	db2080e7          	jalr	-590(ra) # 80003bcc <r_sepc>
    80003e22:	84aa                	mv	s1,a0
    80003e24:	00000097          	auipc	ra,0x0
    80003e28:	e10080e7          	jalr	-496(ra) # 80003c34 <r_stval>
    80003e2c:	87aa                	mv	a5,a0
    80003e2e:	863e                	mv	a2,a5
    80003e30:	85a6                	mv	a1,s1
    80003e32:	00009517          	auipc	a0,0x9
    80003e36:	4fe50513          	addi	a0,a0,1278 # 8000d330 <etext+0x330>
    80003e3a:	ffffd097          	auipc	ra,0xffffd
    80003e3e:	bf8080e7          	jalr	-1032(ra) # 80000a32 <printf>
    setkilled(p);
    80003e42:	fd043503          	ld	a0,-48(s0)
    80003e46:	00000097          	auipc	ra,0x0
    80003e4a:	a56080e7          	jalr	-1450(ra) # 8000389c <setkilled>
  }

  if(killed(p))
    80003e4e:	fd043503          	ld	a0,-48(s0)
    80003e52:	00000097          	auipc	ra,0x0
    80003e56:	a84080e7          	jalr	-1404(ra) # 800038d6 <killed>
    80003e5a:	87aa                	mv	a5,a0
    80003e5c:	c791                	beqz	a5,80003e68 <usertrap+0x134>
    exit(-1);
    80003e5e:	557d                	li	a0,-1
    80003e60:	fffff097          	auipc	ra,0xfffff
    80003e64:	390080e7          	jalr	912(ra) # 800031f0 <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    80003e68:	fdc42783          	lw	a5,-36(s0)
    80003e6c:	0007871b          	sext.w	a4,a5
    80003e70:	4789                	li	a5,2
    80003e72:	00f71663          	bne	a4,a5,80003e7e <usertrap+0x14a>
    yield();
    80003e76:	fffff097          	auipc	ra,0xfffff
    80003e7a:	7b0080e7          	jalr	1968(ra) # 80003626 <yield>

  usertrapret();
    80003e7e:	00000097          	auipc	ra,0x0
    80003e82:	014080e7          	jalr	20(ra) # 80003e92 <usertrapret>
}
    80003e86:	0001                	nop
    80003e88:	70a2                	ld	ra,40(sp)
    80003e8a:	7402                	ld	s0,32(sp)
    80003e8c:	64e2                	ld	s1,24(sp)
    80003e8e:	6145                	addi	sp,sp,48
    80003e90:	8082                	ret

0000000080003e92 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80003e92:	715d                	addi	sp,sp,-80
    80003e94:	e486                	sd	ra,72(sp)
    80003e96:	e0a2                	sd	s0,64(sp)
    80003e98:	fc26                	sd	s1,56(sp)
    80003e9a:	0880                	addi	s0,sp,80
  struct proc *p = myproc();
    80003e9c:	fffff097          	auipc	ra,0xfffff
    80003ea0:	c62080e7          	jalr	-926(ra) # 80002afe <myproc>
    80003ea4:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    80003ea8:	00000097          	auipc	ra,0x0
    80003eac:	dd0080e7          	jalr	-560(ra) # 80003c78 <intr_off>

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80003eb0:	00008717          	auipc	a4,0x8
    80003eb4:	15070713          	addi	a4,a4,336 # 8000c000 <_trampoline>
    80003eb8:	00008797          	auipc	a5,0x8
    80003ebc:	14878793          	addi	a5,a5,328 # 8000c000 <_trampoline>
    80003ec0:	8f1d                	sub	a4,a4,a5
    80003ec2:	040007b7          	lui	a5,0x4000
    80003ec6:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80003ec8:	07b2                	slli	a5,a5,0xc
    80003eca:	97ba                	add	a5,a5,a4
    80003ecc:	fcf43823          	sd	a5,-48(s0)
  w_stvec(trampoline_uservec);
    80003ed0:	fd043503          	ld	a0,-48(s0)
    80003ed4:	00000097          	auipc	ra,0x0
    80003ed8:	d12080e7          	jalr	-750(ra) # 80003be6 <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80003edc:	fd843783          	ld	a5,-40(s0)
    80003ee0:	6fa4                	ld	s1,88(a5)
    80003ee2:	00000097          	auipc	ra,0x0
    80003ee6:	d1e080e7          	jalr	-738(ra) # 80003c00 <r_satp>
    80003eea:	87aa                	mv	a5,a0
    80003eec:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80003eee:	fd843783          	ld	a5,-40(s0)
    80003ef2:	63b4                	ld	a3,64(a5)
    80003ef4:	fd843783          	ld	a5,-40(s0)
    80003ef8:	6fbc                	ld	a5,88(a5)
    80003efa:	6705                	lui	a4,0x1
    80003efc:	9736                	add	a4,a4,a3
    80003efe:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80003f00:	fd843783          	ld	a5,-40(s0)
    80003f04:	6fbc                	ld	a5,88(a5)
    80003f06:	00000717          	auipc	a4,0x0
    80003f0a:	e2e70713          	addi	a4,a4,-466 # 80003d34 <usertrap>
    80003f0e:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80003f10:	fd843783          	ld	a5,-40(s0)
    80003f14:	6fa4                	ld	s1,88(a5)
    80003f16:	00000097          	auipc	ra,0x0
    80003f1a:	db8080e7          	jalr	-584(ra) # 80003cce <r_tp>
    80003f1e:	87aa                	mv	a5,a0
    80003f20:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    80003f22:	00000097          	auipc	ra,0x0
    80003f26:	c28080e7          	jalr	-984(ra) # 80003b4a <r_sstatus>
    80003f2a:	fca43423          	sd	a0,-56(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80003f2e:	fc843783          	ld	a5,-56(s0)
    80003f32:	eff7f793          	andi	a5,a5,-257
    80003f36:	fcf43423          	sd	a5,-56(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80003f3a:	fc843783          	ld	a5,-56(s0)
    80003f3e:	0207e793          	ori	a5,a5,32
    80003f42:	fcf43423          	sd	a5,-56(s0)
  w_sstatus(x);
    80003f46:	fc843503          	ld	a0,-56(s0)
    80003f4a:	00000097          	auipc	ra,0x0
    80003f4e:	c1a080e7          	jalr	-998(ra) # 80003b64 <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80003f52:	fd843783          	ld	a5,-40(s0)
    80003f56:	6fbc                	ld	a5,88(a5)
    80003f58:	6f9c                	ld	a5,24(a5)
    80003f5a:	853e                	mv	a0,a5
    80003f5c:	00000097          	auipc	ra,0x0
    80003f60:	c56080e7          	jalr	-938(ra) # 80003bb2 <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80003f64:	fd843783          	ld	a5,-40(s0)
    80003f68:	6bbc                	ld	a5,80(a5)
    80003f6a:	00c7d713          	srli	a4,a5,0xc
    80003f6e:	57fd                	li	a5,-1
    80003f70:	17fe                	slli	a5,a5,0x3f
    80003f72:	8fd9                	or	a5,a5,a4
    80003f74:	fcf43023          	sd	a5,-64(s0)

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80003f78:	00008717          	auipc	a4,0x8
    80003f7c:	12470713          	addi	a4,a4,292 # 8000c09c <userret>
    80003f80:	00008797          	auipc	a5,0x8
    80003f84:	08078793          	addi	a5,a5,128 # 8000c000 <_trampoline>
    80003f88:	8f1d                	sub	a4,a4,a5
    80003f8a:	040007b7          	lui	a5,0x4000
    80003f8e:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80003f90:	07b2                	slli	a5,a5,0xc
    80003f92:	97ba                	add	a5,a5,a4
    80003f94:	faf43c23          	sd	a5,-72(s0)
  ((void (*)(uint64))trampoline_userret)(satp);
    80003f98:	fb843783          	ld	a5,-72(s0)
    80003f9c:	fc043503          	ld	a0,-64(s0)
    80003fa0:	9782                	jalr	a5
}
    80003fa2:	0001                	nop
    80003fa4:	60a6                	ld	ra,72(sp)
    80003fa6:	6406                	ld	s0,64(sp)
    80003fa8:	74e2                	ld	s1,56(sp)
    80003faa:	6161                	addi	sp,sp,80
    80003fac:	8082                	ret

0000000080003fae <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80003fae:	7139                	addi	sp,sp,-64
    80003fb0:	fc06                	sd	ra,56(sp)
    80003fb2:	f822                	sd	s0,48(sp)
    80003fb4:	f426                	sd	s1,40(sp)
    80003fb6:	0080                	addi	s0,sp,64
  int which_dev = 0;
    80003fb8:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80003fbc:	00000097          	auipc	ra,0x0
    80003fc0:	c10080e7          	jalr	-1008(ra) # 80003bcc <r_sepc>
    80003fc4:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    80003fc8:	00000097          	auipc	ra,0x0
    80003fcc:	b82080e7          	jalr	-1150(ra) # 80003b4a <r_sstatus>
    80003fd0:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    80003fd4:	00000097          	auipc	ra,0x0
    80003fd8:	c46080e7          	jalr	-954(ra) # 80003c1a <r_scause>
    80003fdc:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    80003fe0:	fc843783          	ld	a5,-56(s0)
    80003fe4:	1007f793          	andi	a5,a5,256
    80003fe8:	eb89                	bnez	a5,80003ffa <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    80003fea:	00009517          	auipc	a0,0x9
    80003fee:	36650513          	addi	a0,a0,870 # 8000d350 <etext+0x350>
    80003ff2:	ffffd097          	auipc	ra,0xffffd
    80003ff6:	c96080e7          	jalr	-874(ra) # 80000c88 <panic>
  if(intr_get() != 0)
    80003ffa:	00000097          	auipc	ra,0x0
    80003ffe:	ca6080e7          	jalr	-858(ra) # 80003ca0 <intr_get>
    80004002:	87aa                	mv	a5,a0
    80004004:	cb89                	beqz	a5,80004016 <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    80004006:	00009517          	auipc	a0,0x9
    8000400a:	37250513          	addi	a0,a0,882 # 8000d378 <etext+0x378>
    8000400e:	ffffd097          	auipc	ra,0xffffd
    80004012:	c7a080e7          	jalr	-902(ra) # 80000c88 <panic>

  if((which_dev = devintr()) == 0){
    80004016:	00000097          	auipc	ra,0x0
    8000401a:	118080e7          	jalr	280(ra) # 8000412e <devintr>
    8000401e:	87aa                	mv	a5,a0
    80004020:	fcf42e23          	sw	a5,-36(s0)
    80004024:	fdc42783          	lw	a5,-36(s0)
    80004028:	2781                	sext.w	a5,a5
    8000402a:	e7b9                	bnez	a5,80004078 <kerneltrap+0xca>
    printf("scause %p\n", scause);
    8000402c:	fc043583          	ld	a1,-64(s0)
    80004030:	00009517          	auipc	a0,0x9
    80004034:	36850513          	addi	a0,a0,872 # 8000d398 <etext+0x398>
    80004038:	ffffd097          	auipc	ra,0xffffd
    8000403c:	9fa080e7          	jalr	-1542(ra) # 80000a32 <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80004040:	00000097          	auipc	ra,0x0
    80004044:	b8c080e7          	jalr	-1140(ra) # 80003bcc <r_sepc>
    80004048:	84aa                	mv	s1,a0
    8000404a:	00000097          	auipc	ra,0x0
    8000404e:	bea080e7          	jalr	-1046(ra) # 80003c34 <r_stval>
    80004052:	87aa                	mv	a5,a0
    80004054:	863e                	mv	a2,a5
    80004056:	85a6                	mv	a1,s1
    80004058:	00009517          	auipc	a0,0x9
    8000405c:	35050513          	addi	a0,a0,848 # 8000d3a8 <etext+0x3a8>
    80004060:	ffffd097          	auipc	ra,0xffffd
    80004064:	9d2080e7          	jalr	-1582(ra) # 80000a32 <printf>
    panic("kerneltrap");
    80004068:	00009517          	auipc	a0,0x9
    8000406c:	35850513          	addi	a0,a0,856 # 8000d3c0 <etext+0x3c0>
    80004070:	ffffd097          	auipc	ra,0xffffd
    80004074:	c18080e7          	jalr	-1000(ra) # 80000c88 <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80004078:	fdc42783          	lw	a5,-36(s0)
    8000407c:	0007871b          	sext.w	a4,a5
    80004080:	4789                	li	a5,2
    80004082:	02f71663          	bne	a4,a5,800040ae <kerneltrap+0x100>
    80004086:	fffff097          	auipc	ra,0xfffff
    8000408a:	a78080e7          	jalr	-1416(ra) # 80002afe <myproc>
    8000408e:	87aa                	mv	a5,a0
    80004090:	cf99                	beqz	a5,800040ae <kerneltrap+0x100>
    80004092:	fffff097          	auipc	ra,0xfffff
    80004096:	a6c080e7          	jalr	-1428(ra) # 80002afe <myproc>
    8000409a:	87aa                	mv	a5,a0
    8000409c:	4f9c                	lw	a5,24(a5)
    8000409e:	873e                	mv	a4,a5
    800040a0:	4791                	li	a5,4
    800040a2:	00f71663          	bne	a4,a5,800040ae <kerneltrap+0x100>
    yield();
    800040a6:	fffff097          	auipc	ra,0xfffff
    800040aa:	580080e7          	jalr	1408(ra) # 80003626 <yield>

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    800040ae:	fd043503          	ld	a0,-48(s0)
    800040b2:	00000097          	auipc	ra,0x0
    800040b6:	b00080e7          	jalr	-1280(ra) # 80003bb2 <w_sepc>
  w_sstatus(sstatus);
    800040ba:	fc843503          	ld	a0,-56(s0)
    800040be:	00000097          	auipc	ra,0x0
    800040c2:	aa6080e7          	jalr	-1370(ra) # 80003b64 <w_sstatus>
}
    800040c6:	0001                	nop
    800040c8:	70e2                	ld	ra,56(sp)
    800040ca:	7442                	ld	s0,48(sp)
    800040cc:	74a2                	ld	s1,40(sp)
    800040ce:	6121                	addi	sp,sp,64
    800040d0:	8082                	ret

00000000800040d2 <clockintr>:

void
clockintr()
{
    800040d2:	1141                	addi	sp,sp,-16
    800040d4:	e406                	sd	ra,8(sp)
    800040d6:	e022                	sd	s0,0(sp)
    800040d8:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    800040da:	0001a517          	auipc	a0,0x1a
    800040de:	6ae50513          	addi	a0,a0,1710 # 8001e788 <tickslock>
    800040e2:	ffffd097          	auipc	ra,0xffffd
    800040e6:	24e080e7          	jalr	590(ra) # 80001330 <acquire>
  ticks++;
    800040ea:	0000c797          	auipc	a5,0xc
    800040ee:	5fe78793          	addi	a5,a5,1534 # 800106e8 <ticks>
    800040f2:	439c                	lw	a5,0(a5)
    800040f4:	2785                	addiw	a5,a5,1
    800040f6:	0007871b          	sext.w	a4,a5
    800040fa:	0000c797          	auipc	a5,0xc
    800040fe:	5ee78793          	addi	a5,a5,1518 # 800106e8 <ticks>
    80004102:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    80004104:	0000c517          	auipc	a0,0xc
    80004108:	5e450513          	addi	a0,a0,1508 # 800106e8 <ticks>
    8000410c:	fffff097          	auipc	ra,0xfffff
    80004110:	638080e7          	jalr	1592(ra) # 80003744 <wakeup>
  release(&tickslock);
    80004114:	0001a517          	auipc	a0,0x1a
    80004118:	67450513          	addi	a0,a0,1652 # 8001e788 <tickslock>
    8000411c:	ffffd097          	auipc	ra,0xffffd
    80004120:	278080e7          	jalr	632(ra) # 80001394 <release>
}
    80004124:	0001                	nop
    80004126:	60a2                	ld	ra,8(sp)
    80004128:	6402                	ld	s0,0(sp)
    8000412a:	0141                	addi	sp,sp,16
    8000412c:	8082                	ret

000000008000412e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    8000412e:	1101                	addi	sp,sp,-32
    80004130:	ec06                	sd	ra,24(sp)
    80004132:	e822                	sd	s0,16(sp)
    80004134:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    80004136:	00000097          	auipc	ra,0x0
    8000413a:	ae4080e7          	jalr	-1308(ra) # 80003c1a <r_scause>
    8000413e:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    80004142:	fe843783          	ld	a5,-24(s0)
    80004146:	0a07dd63          	bgez	a5,80004200 <devintr+0xd2>
     (scause & 0xff) == 9){
    8000414a:	fe843783          	ld	a5,-24(s0)
    8000414e:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80004152:	47a5                	li	a5,9
    80004154:	0af71663          	bne	a4,a5,80004200 <devintr+0xd2>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    80004158:	00005097          	auipc	ra,0x5
    8000415c:	afc080e7          	jalr	-1284(ra) # 80008c54 <plic_claim>
    80004160:	87aa                	mv	a5,a0
    80004162:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    80004166:	fe442783          	lw	a5,-28(s0)
    8000416a:	0007871b          	sext.w	a4,a5
    8000416e:	47a9                	li	a5,10
    80004170:	00f71763          	bne	a4,a5,8000417e <devintr+0x50>
      uartintr();
    80004174:	ffffd097          	auipc	ra,0xffffd
    80004178:	ec0080e7          	jalr	-320(ra) # 80001034 <uartintr>
    8000417c:	a0ad                	j	800041e6 <devintr+0xb8>
    } else if(irq == VIRTIO0_IRQ){
    8000417e:	fe442783          	lw	a5,-28(s0)
    80004182:	0007871b          	sext.w	a4,a5
    80004186:	4785                	li	a5,1
    80004188:	00f71863          	bne	a4,a5,80004198 <devintr+0x6a>
      virtio_disk_intr(VIRTIO0_ID);
    8000418c:	4501                	li	a0,0
    8000418e:	00006097          	auipc	ra,0x6
    80004192:	b58080e7          	jalr	-1192(ra) # 80009ce6 <virtio_disk_intr>
    80004196:	a881                	j	800041e6 <devintr+0xb8>
    } else if (irq >= VIRTIOX_IRQ(VIRTIO_RAID_DISK_START) && irq <= VIRTIOX_IRQ(VIRTIO_RAID_DISK_END)) {
    80004198:	fe442783          	lw	a5,-28(s0)
    8000419c:	0007871b          	sext.w	a4,a5
    800041a0:	4785                	li	a5,1
    800041a2:	02e7d363          	bge	a5,a4,800041c8 <devintr+0x9a>
    800041a6:	fe442783          	lw	a5,-28(s0)
    800041aa:	0007871b          	sext.w	a4,a5
    800041ae:	479d                	li	a5,7
    800041b0:	00e7cc63          	blt	a5,a4,800041c8 <devintr+0x9a>
      virtio_disk_intr(VIRTIOX_ID(irq));
    800041b4:	fe442783          	lw	a5,-28(s0)
    800041b8:	37fd                	addiw	a5,a5,-1
    800041ba:	2781                	sext.w	a5,a5
    800041bc:	853e                	mv	a0,a5
    800041be:	00006097          	auipc	ra,0x6
    800041c2:	b28080e7          	jalr	-1240(ra) # 80009ce6 <virtio_disk_intr>
    800041c6:	a005                	j	800041e6 <devintr+0xb8>
    } else if(irq){
    800041c8:	fe442783          	lw	a5,-28(s0)
    800041cc:	2781                	sext.w	a5,a5
    800041ce:	cf81                	beqz	a5,800041e6 <devintr+0xb8>
      printf("unexpected interrupt irq=%d\n", irq);
    800041d0:	fe442783          	lw	a5,-28(s0)
    800041d4:	85be                	mv	a1,a5
    800041d6:	00009517          	auipc	a0,0x9
    800041da:	1fa50513          	addi	a0,a0,506 # 8000d3d0 <etext+0x3d0>
    800041de:	ffffd097          	auipc	ra,0xffffd
    800041e2:	854080e7          	jalr	-1964(ra) # 80000a32 <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    800041e6:	fe442783          	lw	a5,-28(s0)
    800041ea:	2781                	sext.w	a5,a5
    800041ec:	cb81                	beqz	a5,800041fc <devintr+0xce>
      plic_complete(irq);
    800041ee:	fe442783          	lw	a5,-28(s0)
    800041f2:	853e                	mv	a0,a5
    800041f4:	00005097          	auipc	ra,0x5
    800041f8:	a9e080e7          	jalr	-1378(ra) # 80008c92 <plic_complete>

    return 1;
    800041fc:	4785                	li	a5,1
    800041fe:	a081                	j	8000423e <devintr+0x110>
  } else if(scause == 0x8000000000000001L){
    80004200:	fe843703          	ld	a4,-24(s0)
    80004204:	57fd                	li	a5,-1
    80004206:	17fe                	slli	a5,a5,0x3f
    80004208:	0785                	addi	a5,a5,1
    8000420a:	02f71963          	bne	a4,a5,8000423c <devintr+0x10e>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    8000420e:	fffff097          	auipc	ra,0xfffff
    80004212:	892080e7          	jalr	-1902(ra) # 80002aa0 <cpuid>
    80004216:	87aa                	mv	a5,a0
    80004218:	e789                	bnez	a5,80004222 <devintr+0xf4>
      clockintr();
    8000421a:	00000097          	auipc	ra,0x0
    8000421e:	eb8080e7          	jalr	-328(ra) # 800040d2 <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    80004222:	00000097          	auipc	ra,0x0
    80004226:	95c080e7          	jalr	-1700(ra) # 80003b7e <r_sip>
    8000422a:	87aa                	mv	a5,a0
    8000422c:	9bf5                	andi	a5,a5,-3
    8000422e:	853e                	mv	a0,a5
    80004230:	00000097          	auipc	ra,0x0
    80004234:	968080e7          	jalr	-1688(ra) # 80003b98 <w_sip>

    return 2;
    80004238:	4789                	li	a5,2
    8000423a:	a011                	j	8000423e <devintr+0x110>
  } else {
    return 0;
    8000423c:	4781                	li	a5,0
  }
}
    8000423e:	853e                	mv	a0,a5
    80004240:	60e2                	ld	ra,24(sp)
    80004242:	6442                	ld	s0,16(sp)
    80004244:	6105                	addi	sp,sp,32
    80004246:	8082                	ret

0000000080004248 <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    80004248:	7179                	addi	sp,sp,-48
    8000424a:	f406                	sd	ra,40(sp)
    8000424c:	f022                	sd	s0,32(sp)
    8000424e:	1800                	addi	s0,sp,48
    80004250:	fca43c23          	sd	a0,-40(s0)
    80004254:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80004258:	fffff097          	auipc	ra,0xfffff
    8000425c:	8a6080e7          	jalr	-1882(ra) # 80002afe <myproc>
    80004260:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80004264:	fe843783          	ld	a5,-24(s0)
    80004268:	67bc                	ld	a5,72(a5)
    8000426a:	fd843703          	ld	a4,-40(s0)
    8000426e:	00f77b63          	bgeu	a4,a5,80004284 <fetchaddr+0x3c>
    80004272:	fd843783          	ld	a5,-40(s0)
    80004276:	00878713          	addi	a4,a5,8
    8000427a:	fe843783          	ld	a5,-24(s0)
    8000427e:	67bc                	ld	a5,72(a5)
    80004280:	00e7f463          	bgeu	a5,a4,80004288 <fetchaddr+0x40>
    return -1;
    80004284:	57fd                	li	a5,-1
    80004286:	a01d                	j	800042ac <fetchaddr+0x64>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80004288:	fe843783          	ld	a5,-24(s0)
    8000428c:	6bbc                	ld	a5,80(a5)
    8000428e:	46a1                	li	a3,8
    80004290:	fd843603          	ld	a2,-40(s0)
    80004294:	fd043583          	ld	a1,-48(s0)
    80004298:	853e                	mv	a0,a5
    8000429a:	ffffe097          	auipc	ra,0xffffe
    8000429e:	3fc080e7          	jalr	1020(ra) # 80002696 <copyin>
    800042a2:	87aa                	mv	a5,a0
    800042a4:	c399                	beqz	a5,800042aa <fetchaddr+0x62>
    return -1;
    800042a6:	57fd                	li	a5,-1
    800042a8:	a011                	j	800042ac <fetchaddr+0x64>
  return 0;
    800042aa:	4781                	li	a5,0
}
    800042ac:	853e                	mv	a0,a5
    800042ae:	70a2                	ld	ra,40(sp)
    800042b0:	7402                	ld	s0,32(sp)
    800042b2:	6145                	addi	sp,sp,48
    800042b4:	8082                	ret

00000000800042b6 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    800042b6:	7139                	addi	sp,sp,-64
    800042b8:	fc06                	sd	ra,56(sp)
    800042ba:	f822                	sd	s0,48(sp)
    800042bc:	0080                	addi	s0,sp,64
    800042be:	fca43c23          	sd	a0,-40(s0)
    800042c2:	fcb43823          	sd	a1,-48(s0)
    800042c6:	87b2                	mv	a5,a2
    800042c8:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    800042cc:	fffff097          	auipc	ra,0xfffff
    800042d0:	832080e7          	jalr	-1998(ra) # 80002afe <myproc>
    800042d4:	fea43423          	sd	a0,-24(s0)
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    800042d8:	fe843783          	ld	a5,-24(s0)
    800042dc:	6bbc                	ld	a5,80(a5)
    800042de:	fcc42703          	lw	a4,-52(s0)
    800042e2:	86ba                	mv	a3,a4
    800042e4:	fd843603          	ld	a2,-40(s0)
    800042e8:	fd043583          	ld	a1,-48(s0)
    800042ec:	853e                	mv	a0,a5
    800042ee:	ffffe097          	auipc	ra,0xffffe
    800042f2:	476080e7          	jalr	1142(ra) # 80002764 <copyinstr>
    800042f6:	87aa                	mv	a5,a0
    800042f8:	0007d463          	bgez	a5,80004300 <fetchstr+0x4a>
    return -1;
    800042fc:	57fd                	li	a5,-1
    800042fe:	a801                	j	8000430e <fetchstr+0x58>
  return strlen(buf);
    80004300:	fd043503          	ld	a0,-48(s0)
    80004304:	ffffd097          	auipc	ra,0xffffd
    80004308:	6ae080e7          	jalr	1710(ra) # 800019b2 <strlen>
    8000430c:	87aa                	mv	a5,a0
}
    8000430e:	853e                	mv	a0,a5
    80004310:	70e2                	ld	ra,56(sp)
    80004312:	7442                	ld	s0,48(sp)
    80004314:	6121                	addi	sp,sp,64
    80004316:	8082                	ret

0000000080004318 <argraw>:

static uint64
argraw(int n)
{
    80004318:	7179                	addi	sp,sp,-48
    8000431a:	f406                	sd	ra,40(sp)
    8000431c:	f022                	sd	s0,32(sp)
    8000431e:	1800                	addi	s0,sp,48
    80004320:	87aa                	mv	a5,a0
    80004322:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80004326:	ffffe097          	auipc	ra,0xffffe
    8000432a:	7d8080e7          	jalr	2008(ra) # 80002afe <myproc>
    8000432e:	fea43423          	sd	a0,-24(s0)
  switch (n) {
    80004332:	fdc42783          	lw	a5,-36(s0)
    80004336:	0007871b          	sext.w	a4,a5
    8000433a:	4795                	li	a5,5
    8000433c:	06e7e263          	bltu	a5,a4,800043a0 <argraw+0x88>
    80004340:	fdc46783          	lwu	a5,-36(s0)
    80004344:	00279713          	slli	a4,a5,0x2
    80004348:	00009797          	auipc	a5,0x9
    8000434c:	0b078793          	addi	a5,a5,176 # 8000d3f8 <etext+0x3f8>
    80004350:	97ba                	add	a5,a5,a4
    80004352:	439c                	lw	a5,0(a5)
    80004354:	0007871b          	sext.w	a4,a5
    80004358:	00009797          	auipc	a5,0x9
    8000435c:	0a078793          	addi	a5,a5,160 # 8000d3f8 <etext+0x3f8>
    80004360:	97ba                	add	a5,a5,a4
    80004362:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80004364:	fe843783          	ld	a5,-24(s0)
    80004368:	6fbc                	ld	a5,88(a5)
    8000436a:	7bbc                	ld	a5,112(a5)
    8000436c:	a091                	j	800043b0 <argraw+0x98>
  case 1:
    return p->trapframe->a1;
    8000436e:	fe843783          	ld	a5,-24(s0)
    80004372:	6fbc                	ld	a5,88(a5)
    80004374:	7fbc                	ld	a5,120(a5)
    80004376:	a82d                	j	800043b0 <argraw+0x98>
  case 2:
    return p->trapframe->a2;
    80004378:	fe843783          	ld	a5,-24(s0)
    8000437c:	6fbc                	ld	a5,88(a5)
    8000437e:	63dc                	ld	a5,128(a5)
    80004380:	a805                	j	800043b0 <argraw+0x98>
  case 3:
    return p->trapframe->a3;
    80004382:	fe843783          	ld	a5,-24(s0)
    80004386:	6fbc                	ld	a5,88(a5)
    80004388:	67dc                	ld	a5,136(a5)
    8000438a:	a01d                	j	800043b0 <argraw+0x98>
  case 4:
    return p->trapframe->a4;
    8000438c:	fe843783          	ld	a5,-24(s0)
    80004390:	6fbc                	ld	a5,88(a5)
    80004392:	6bdc                	ld	a5,144(a5)
    80004394:	a831                	j	800043b0 <argraw+0x98>
  case 5:
    return p->trapframe->a5;
    80004396:	fe843783          	ld	a5,-24(s0)
    8000439a:	6fbc                	ld	a5,88(a5)
    8000439c:	6fdc                	ld	a5,152(a5)
    8000439e:	a809                	j	800043b0 <argraw+0x98>
  }
  panic("argraw");
    800043a0:	00009517          	auipc	a0,0x9
    800043a4:	05050513          	addi	a0,a0,80 # 8000d3f0 <etext+0x3f0>
    800043a8:	ffffd097          	auipc	ra,0xffffd
    800043ac:	8e0080e7          	jalr	-1824(ra) # 80000c88 <panic>
  return -1;
}
    800043b0:	853e                	mv	a0,a5
    800043b2:	70a2                	ld	ra,40(sp)
    800043b4:	7402                	ld	s0,32(sp)
    800043b6:	6145                	addi	sp,sp,48
    800043b8:	8082                	ret

00000000800043ba <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    800043ba:	1101                	addi	sp,sp,-32
    800043bc:	ec06                	sd	ra,24(sp)
    800043be:	e822                	sd	s0,16(sp)
    800043c0:	1000                	addi	s0,sp,32
    800043c2:	87aa                	mv	a5,a0
    800043c4:	feb43023          	sd	a1,-32(s0)
    800043c8:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    800043cc:	fec42783          	lw	a5,-20(s0)
    800043d0:	853e                	mv	a0,a5
    800043d2:	00000097          	auipc	ra,0x0
    800043d6:	f46080e7          	jalr	-186(ra) # 80004318 <argraw>
    800043da:	87aa                	mv	a5,a0
    800043dc:	0007871b          	sext.w	a4,a5
    800043e0:	fe043783          	ld	a5,-32(s0)
    800043e4:	c398                	sw	a4,0(a5)
}
    800043e6:	0001                	nop
    800043e8:	60e2                	ld	ra,24(sp)
    800043ea:	6442                	ld	s0,16(sp)
    800043ec:	6105                	addi	sp,sp,32
    800043ee:	8082                	ret

00000000800043f0 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    800043f0:	1101                	addi	sp,sp,-32
    800043f2:	ec06                	sd	ra,24(sp)
    800043f4:	e822                	sd	s0,16(sp)
    800043f6:	1000                	addi	s0,sp,32
    800043f8:	87aa                	mv	a5,a0
    800043fa:	feb43023          	sd	a1,-32(s0)
    800043fe:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004402:	fec42783          	lw	a5,-20(s0)
    80004406:	853e                	mv	a0,a5
    80004408:	00000097          	auipc	ra,0x0
    8000440c:	f10080e7          	jalr	-240(ra) # 80004318 <argraw>
    80004410:	872a                	mv	a4,a0
    80004412:	fe043783          	ld	a5,-32(s0)
    80004416:	e398                	sd	a4,0(a5)
}
    80004418:	0001                	nop
    8000441a:	60e2                	ld	ra,24(sp)
    8000441c:	6442                	ld	s0,16(sp)
    8000441e:	6105                	addi	sp,sp,32
    80004420:	8082                	ret

0000000080004422 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80004422:	7179                	addi	sp,sp,-48
    80004424:	f406                	sd	ra,40(sp)
    80004426:	f022                	sd	s0,32(sp)
    80004428:	1800                	addi	s0,sp,48
    8000442a:	87aa                	mv	a5,a0
    8000442c:	fcb43823          	sd	a1,-48(s0)
    80004430:	8732                	mv	a4,a2
    80004432:	fcf42e23          	sw	a5,-36(s0)
    80004436:	87ba                	mv	a5,a4
    80004438:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  argaddr(n, &addr);
    8000443c:	fe840713          	addi	a4,s0,-24
    80004440:	fdc42783          	lw	a5,-36(s0)
    80004444:	85ba                	mv	a1,a4
    80004446:	853e                	mv	a0,a5
    80004448:	00000097          	auipc	ra,0x0
    8000444c:	fa8080e7          	jalr	-88(ra) # 800043f0 <argaddr>
  return fetchstr(addr, buf, max);
    80004450:	fe843783          	ld	a5,-24(s0)
    80004454:	fd842703          	lw	a4,-40(s0)
    80004458:	863a                	mv	a2,a4
    8000445a:	fd043583          	ld	a1,-48(s0)
    8000445e:	853e                	mv	a0,a5
    80004460:	00000097          	auipc	ra,0x0
    80004464:	e56080e7          	jalr	-426(ra) # 800042b6 <fetchstr>
    80004468:	87aa                	mv	a5,a0
}
    8000446a:	853e                	mv	a0,a5
    8000446c:	70a2                	ld	ra,40(sp)
    8000446e:	7402                	ld	s0,32(sp)
    80004470:	6145                	addi	sp,sp,48
    80004472:	8082                	ret

0000000080004474 <syscall>:
[SYS_info_raid]  sys_info_raid,
};

void
syscall(void)
{
    80004474:	7179                	addi	sp,sp,-48
    80004476:	f406                	sd	ra,40(sp)
    80004478:	f022                	sd	s0,32(sp)
    8000447a:	ec26                	sd	s1,24(sp)
    8000447c:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    8000447e:	ffffe097          	auipc	ra,0xffffe
    80004482:	680080e7          	jalr	1664(ra) # 80002afe <myproc>
    80004486:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    8000448a:	fd843783          	ld	a5,-40(s0)
    8000448e:	6fbc                	ld	a5,88(a5)
    80004490:	77dc                	ld	a5,168(a5)
    80004492:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80004496:	fd442783          	lw	a5,-44(s0)
    8000449a:	2781                	sext.w	a5,a5
    8000449c:	04f05263          	blez	a5,800044e0 <syscall+0x6c>
    800044a0:	fd442783          	lw	a5,-44(s0)
    800044a4:	873e                	mv	a4,a5
    800044a6:	47ed                	li	a5,27
    800044a8:	02e7ec63          	bltu	a5,a4,800044e0 <syscall+0x6c>
    800044ac:	0000c717          	auipc	a4,0xc
    800044b0:	0ec70713          	addi	a4,a4,236 # 80010598 <syscalls>
    800044b4:	fd442783          	lw	a5,-44(s0)
    800044b8:	078e                	slli	a5,a5,0x3
    800044ba:	97ba                	add	a5,a5,a4
    800044bc:	639c                	ld	a5,0(a5)
    800044be:	c38d                	beqz	a5,800044e0 <syscall+0x6c>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    800044c0:	0000c717          	auipc	a4,0xc
    800044c4:	0d870713          	addi	a4,a4,216 # 80010598 <syscalls>
    800044c8:	fd442783          	lw	a5,-44(s0)
    800044cc:	078e                	slli	a5,a5,0x3
    800044ce:	97ba                	add	a5,a5,a4
    800044d0:	639c                	ld	a5,0(a5)
    800044d2:	fd843703          	ld	a4,-40(s0)
    800044d6:	6f24                	ld	s1,88(a4)
    800044d8:	9782                	jalr	a5
    800044da:	87aa                	mv	a5,a0
    800044dc:	f8bc                	sd	a5,112(s1)
    800044de:	a815                	j	80004512 <syscall+0x9e>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800044e0:	fd843783          	ld	a5,-40(s0)
    800044e4:	5b98                	lw	a4,48(a5)
            p->pid, p->name, num);
    800044e6:	fd843783          	ld	a5,-40(s0)
    800044ea:	15878793          	addi	a5,a5,344
    printf("%d %s: unknown sys call %d\n",
    800044ee:	fd442683          	lw	a3,-44(s0)
    800044f2:	863e                	mv	a2,a5
    800044f4:	85ba                	mv	a1,a4
    800044f6:	00009517          	auipc	a0,0x9
    800044fa:	f1a50513          	addi	a0,a0,-230 # 8000d410 <etext+0x410>
    800044fe:	ffffc097          	auipc	ra,0xffffc
    80004502:	534080e7          	jalr	1332(ra) # 80000a32 <printf>
    p->trapframe->a0 = -1;
    80004506:	fd843783          	ld	a5,-40(s0)
    8000450a:	6fbc                	ld	a5,88(a5)
    8000450c:	577d                	li	a4,-1
    8000450e:	fbb8                	sd	a4,112(a5)
  }
}
    80004510:	0001                	nop
    80004512:	0001                	nop
    80004514:	70a2                	ld	ra,40(sp)
    80004516:	7402                	ld	s0,32(sp)
    80004518:	64e2                	ld	s1,24(sp)
    8000451a:	6145                	addi	sp,sp,48
    8000451c:	8082                	ret

000000008000451e <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000451e:	1101                	addi	sp,sp,-32
    80004520:	ec06                	sd	ra,24(sp)
    80004522:	e822                	sd	s0,16(sp)
    80004524:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80004526:	fec40793          	addi	a5,s0,-20
    8000452a:	85be                	mv	a1,a5
    8000452c:	4501                	li	a0,0
    8000452e:	00000097          	auipc	ra,0x0
    80004532:	e8c080e7          	jalr	-372(ra) # 800043ba <argint>
  exit(n);
    80004536:	fec42783          	lw	a5,-20(s0)
    8000453a:	853e                	mv	a0,a5
    8000453c:	fffff097          	auipc	ra,0xfffff
    80004540:	cb4080e7          	jalr	-844(ra) # 800031f0 <exit>
  return 0;  // not reached
    80004544:	4781                	li	a5,0
}
    80004546:	853e                	mv	a0,a5
    80004548:	60e2                	ld	ra,24(sp)
    8000454a:	6442                	ld	s0,16(sp)
    8000454c:	6105                	addi	sp,sp,32
    8000454e:	8082                	ret

0000000080004550 <sys_getpid>:

uint64
sys_getpid(void)
{
    80004550:	1141                	addi	sp,sp,-16
    80004552:	e406                	sd	ra,8(sp)
    80004554:	e022                	sd	s0,0(sp)
    80004556:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80004558:	ffffe097          	auipc	ra,0xffffe
    8000455c:	5a6080e7          	jalr	1446(ra) # 80002afe <myproc>
    80004560:	87aa                	mv	a5,a0
    80004562:	5b9c                	lw	a5,48(a5)
}
    80004564:	853e                	mv	a0,a5
    80004566:	60a2                	ld	ra,8(sp)
    80004568:	6402                	ld	s0,0(sp)
    8000456a:	0141                	addi	sp,sp,16
    8000456c:	8082                	ret

000000008000456e <sys_fork>:

uint64
sys_fork(void)
{
    8000456e:	1141                	addi	sp,sp,-16
    80004570:	e406                	sd	ra,8(sp)
    80004572:	e022                	sd	s0,0(sp)
    80004574:	0800                	addi	s0,sp,16
  return fork();
    80004576:	fffff097          	auipc	ra,0xfffff
    8000457a:	a58080e7          	jalr	-1448(ra) # 80002fce <fork>
    8000457e:	87aa                	mv	a5,a0
}
    80004580:	853e                	mv	a0,a5
    80004582:	60a2                	ld	ra,8(sp)
    80004584:	6402                	ld	s0,0(sp)
    80004586:	0141                	addi	sp,sp,16
    80004588:	8082                	ret

000000008000458a <sys_wait>:

uint64
sys_wait(void)
{
    8000458a:	1101                	addi	sp,sp,-32
    8000458c:	ec06                	sd	ra,24(sp)
    8000458e:	e822                	sd	s0,16(sp)
    80004590:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80004592:	fe840793          	addi	a5,s0,-24
    80004596:	85be                	mv	a1,a5
    80004598:	4501                	li	a0,0
    8000459a:	00000097          	auipc	ra,0x0
    8000459e:	e56080e7          	jalr	-426(ra) # 800043f0 <argaddr>
  return wait(p);
    800045a2:	fe843783          	ld	a5,-24(s0)
    800045a6:	853e                	mv	a0,a5
    800045a8:	fffff097          	auipc	ra,0xfffff
    800045ac:	d84080e7          	jalr	-636(ra) # 8000332c <wait>
    800045b0:	87aa                	mv	a5,a0
}
    800045b2:	853e                	mv	a0,a5
    800045b4:	60e2                	ld	ra,24(sp)
    800045b6:	6442                	ld	s0,16(sp)
    800045b8:	6105                	addi	sp,sp,32
    800045ba:	8082                	ret

00000000800045bc <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800045bc:	1101                	addi	sp,sp,-32
    800045be:	ec06                	sd	ra,24(sp)
    800045c0:	e822                	sd	s0,16(sp)
    800045c2:	1000                	addi	s0,sp,32
  uint64 addr;
  int n;

  argint(0, &n);
    800045c4:	fe440793          	addi	a5,s0,-28
    800045c8:	85be                	mv	a1,a5
    800045ca:	4501                	li	a0,0
    800045cc:	00000097          	auipc	ra,0x0
    800045d0:	dee080e7          	jalr	-530(ra) # 800043ba <argint>
  addr = myproc()->sz;
    800045d4:	ffffe097          	auipc	ra,0xffffe
    800045d8:	52a080e7          	jalr	1322(ra) # 80002afe <myproc>
    800045dc:	87aa                	mv	a5,a0
    800045de:	67bc                	ld	a5,72(a5)
    800045e0:	fef43423          	sd	a5,-24(s0)
  if(growproc(n) < 0)
    800045e4:	fe442783          	lw	a5,-28(s0)
    800045e8:	853e                	mv	a0,a5
    800045ea:	fffff097          	auipc	ra,0xfffff
    800045ee:	944080e7          	jalr	-1724(ra) # 80002f2e <growproc>
    800045f2:	87aa                	mv	a5,a0
    800045f4:	0007d463          	bgez	a5,800045fc <sys_sbrk+0x40>
    return -1;
    800045f8:	57fd                	li	a5,-1
    800045fa:	a019                	j	80004600 <sys_sbrk+0x44>
  return addr;
    800045fc:	fe843783          	ld	a5,-24(s0)
}
    80004600:	853e                	mv	a0,a5
    80004602:	60e2                	ld	ra,24(sp)
    80004604:	6442                	ld	s0,16(sp)
    80004606:	6105                	addi	sp,sp,32
    80004608:	8082                	ret

000000008000460a <sys_sleep>:

uint64
sys_sleep(void)
{
    8000460a:	1101                	addi	sp,sp,-32
    8000460c:	ec06                	sd	ra,24(sp)
    8000460e:	e822                	sd	s0,16(sp)
    80004610:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  argint(0, &n);
    80004612:	fe840793          	addi	a5,s0,-24
    80004616:	85be                	mv	a1,a5
    80004618:	4501                	li	a0,0
    8000461a:	00000097          	auipc	ra,0x0
    8000461e:	da0080e7          	jalr	-608(ra) # 800043ba <argint>
  acquire(&tickslock);
    80004622:	0001a517          	auipc	a0,0x1a
    80004626:	16650513          	addi	a0,a0,358 # 8001e788 <tickslock>
    8000462a:	ffffd097          	auipc	ra,0xffffd
    8000462e:	d06080e7          	jalr	-762(ra) # 80001330 <acquire>
  ticks0 = ticks;
    80004632:	0000c797          	auipc	a5,0xc
    80004636:	0b678793          	addi	a5,a5,182 # 800106e8 <ticks>
    8000463a:	439c                	lw	a5,0(a5)
    8000463c:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    80004640:	a099                	j	80004686 <sys_sleep+0x7c>
    if(killed(myproc())){
    80004642:	ffffe097          	auipc	ra,0xffffe
    80004646:	4bc080e7          	jalr	1212(ra) # 80002afe <myproc>
    8000464a:	87aa                	mv	a5,a0
    8000464c:	853e                	mv	a0,a5
    8000464e:	fffff097          	auipc	ra,0xfffff
    80004652:	288080e7          	jalr	648(ra) # 800038d6 <killed>
    80004656:	87aa                	mv	a5,a0
    80004658:	cb99                	beqz	a5,8000466e <sys_sleep+0x64>
      release(&tickslock);
    8000465a:	0001a517          	auipc	a0,0x1a
    8000465e:	12e50513          	addi	a0,a0,302 # 8001e788 <tickslock>
    80004662:	ffffd097          	auipc	ra,0xffffd
    80004666:	d32080e7          	jalr	-718(ra) # 80001394 <release>
      return -1;
    8000466a:	57fd                	li	a5,-1
    8000466c:	a0a9                	j	800046b6 <sys_sleep+0xac>
    }
    sleep(&ticks, &tickslock);
    8000466e:	0001a597          	auipc	a1,0x1a
    80004672:	11a58593          	addi	a1,a1,282 # 8001e788 <tickslock>
    80004676:	0000c517          	auipc	a0,0xc
    8000467a:	07250513          	addi	a0,a0,114 # 800106e8 <ticks>
    8000467e:	fffff097          	auipc	ra,0xfffff
    80004682:	04a080e7          	jalr	74(ra) # 800036c8 <sleep>
  while(ticks - ticks0 < n){
    80004686:	0000c797          	auipc	a5,0xc
    8000468a:	06278793          	addi	a5,a5,98 # 800106e8 <ticks>
    8000468e:	439c                	lw	a5,0(a5)
    80004690:	fec42703          	lw	a4,-20(s0)
    80004694:	9f99                	subw	a5,a5,a4
    80004696:	0007871b          	sext.w	a4,a5
    8000469a:	fe842783          	lw	a5,-24(s0)
    8000469e:	2781                	sext.w	a5,a5
    800046a0:	faf761e3          	bltu	a4,a5,80004642 <sys_sleep+0x38>
  }
  release(&tickslock);
    800046a4:	0001a517          	auipc	a0,0x1a
    800046a8:	0e450513          	addi	a0,a0,228 # 8001e788 <tickslock>
    800046ac:	ffffd097          	auipc	ra,0xffffd
    800046b0:	ce8080e7          	jalr	-792(ra) # 80001394 <release>
  return 0;
    800046b4:	4781                	li	a5,0
}
    800046b6:	853e                	mv	a0,a5
    800046b8:	60e2                	ld	ra,24(sp)
    800046ba:	6442                	ld	s0,16(sp)
    800046bc:	6105                	addi	sp,sp,32
    800046be:	8082                	ret

00000000800046c0 <sys_kill>:

uint64
sys_kill(void)
{
    800046c0:	1101                	addi	sp,sp,-32
    800046c2:	ec06                	sd	ra,24(sp)
    800046c4:	e822                	sd	s0,16(sp)
    800046c6:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    800046c8:	fec40793          	addi	a5,s0,-20
    800046cc:	85be                	mv	a1,a5
    800046ce:	4501                	li	a0,0
    800046d0:	00000097          	auipc	ra,0x0
    800046d4:	cea080e7          	jalr	-790(ra) # 800043ba <argint>
  return kill(pid);
    800046d8:	fec42783          	lw	a5,-20(s0)
    800046dc:	853e                	mv	a0,a5
    800046de:	fffff097          	auipc	ra,0xfffff
    800046e2:	11e080e7          	jalr	286(ra) # 800037fc <kill>
    800046e6:	87aa                	mv	a5,a0
}
    800046e8:	853e                	mv	a0,a5
    800046ea:	60e2                	ld	ra,24(sp)
    800046ec:	6442                	ld	s0,16(sp)
    800046ee:	6105                	addi	sp,sp,32
    800046f0:	8082                	ret

00000000800046f2 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800046f2:	1101                	addi	sp,sp,-32
    800046f4:	ec06                	sd	ra,24(sp)
    800046f6:	e822                	sd	s0,16(sp)
    800046f8:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800046fa:	0001a517          	auipc	a0,0x1a
    800046fe:	08e50513          	addi	a0,a0,142 # 8001e788 <tickslock>
    80004702:	ffffd097          	auipc	ra,0xffffd
    80004706:	c2e080e7          	jalr	-978(ra) # 80001330 <acquire>
  xticks = ticks;
    8000470a:	0000c797          	auipc	a5,0xc
    8000470e:	fde78793          	addi	a5,a5,-34 # 800106e8 <ticks>
    80004712:	439c                	lw	a5,0(a5)
    80004714:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    80004718:	0001a517          	auipc	a0,0x1a
    8000471c:	07050513          	addi	a0,a0,112 # 8001e788 <tickslock>
    80004720:	ffffd097          	auipc	ra,0xffffd
    80004724:	c74080e7          	jalr	-908(ra) # 80001394 <release>
  return xticks;
    80004728:	fec46783          	lwu	a5,-20(s0)
}
    8000472c:	853e                	mv	a0,a5
    8000472e:	60e2                	ld	ra,24(sp)
    80004730:	6442                	ld	s0,16(sp)
    80004732:	6105                	addi	sp,sp,32
    80004734:	8082                	ret

0000000080004736 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80004736:	1101                	addi	sp,sp,-32
    80004738:	ec06                	sd	ra,24(sp)
    8000473a:	e822                	sd	s0,16(sp)
    8000473c:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000473e:	00009597          	auipc	a1,0x9
    80004742:	cf258593          	addi	a1,a1,-782 # 8000d430 <etext+0x430>
    80004746:	0001a517          	auipc	a0,0x1a
    8000474a:	05a50513          	addi	a0,a0,90 # 8001e7a0 <bcache>
    8000474e:	ffffd097          	auipc	ra,0xffffd
    80004752:	bb2080e7          	jalr	-1102(ra) # 80001300 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80004756:	0001a717          	auipc	a4,0x1a
    8000475a:	04a70713          	addi	a4,a4,74 # 8001e7a0 <bcache>
    8000475e:	67a1                	lui	a5,0x8
    80004760:	97ba                	add	a5,a5,a4
    80004762:	00022717          	auipc	a4,0x22
    80004766:	2a670713          	addi	a4,a4,678 # 80026a08 <bcache+0x8268>
    8000476a:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    8000476e:	0001a717          	auipc	a4,0x1a
    80004772:	03270713          	addi	a4,a4,50 # 8001e7a0 <bcache>
    80004776:	67a1                	lui	a5,0x8
    80004778:	97ba                	add	a5,a5,a4
    8000477a:	00022717          	auipc	a4,0x22
    8000477e:	28e70713          	addi	a4,a4,654 # 80026a08 <bcache+0x8268>
    80004782:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80004786:	0001a797          	auipc	a5,0x1a
    8000478a:	03278793          	addi	a5,a5,50 # 8001e7b8 <bcache+0x18>
    8000478e:	fef43423          	sd	a5,-24(s0)
    80004792:	a895                	j	80004806 <binit+0xd0>
    b->next = bcache.head.next;
    80004794:	0001a717          	auipc	a4,0x1a
    80004798:	00c70713          	addi	a4,a4,12 # 8001e7a0 <bcache>
    8000479c:	67a1                	lui	a5,0x8
    8000479e:	97ba                	add	a5,a5,a4
    800047a0:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    800047a4:	fe843783          	ld	a5,-24(s0)
    800047a8:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    800047aa:	fe843783          	ld	a5,-24(s0)
    800047ae:	00022717          	auipc	a4,0x22
    800047b2:	25a70713          	addi	a4,a4,602 # 80026a08 <bcache+0x8268>
    800047b6:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    800047b8:	fe843783          	ld	a5,-24(s0)
    800047bc:	07c1                	addi	a5,a5,16
    800047be:	00009597          	auipc	a1,0x9
    800047c2:	c7a58593          	addi	a1,a1,-902 # 8000d438 <etext+0x438>
    800047c6:	853e                	mv	a0,a5
    800047c8:	00002097          	auipc	ra,0x2
    800047cc:	022080e7          	jalr	34(ra) # 800067ea <initsleeplock>
    bcache.head.next->prev = b;
    800047d0:	0001a717          	auipc	a4,0x1a
    800047d4:	fd070713          	addi	a4,a4,-48 # 8001e7a0 <bcache>
    800047d8:	67a1                	lui	a5,0x8
    800047da:	97ba                	add	a5,a5,a4
    800047dc:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800047e0:	fe843703          	ld	a4,-24(s0)
    800047e4:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800047e6:	0001a717          	auipc	a4,0x1a
    800047ea:	fba70713          	addi	a4,a4,-70 # 8001e7a0 <bcache>
    800047ee:	67a1                	lui	a5,0x8
    800047f0:	97ba                	add	a5,a5,a4
    800047f2:	fe843703          	ld	a4,-24(s0)
    800047f6:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800047fa:	fe843783          	ld	a5,-24(s0)
    800047fe:	45878793          	addi	a5,a5,1112
    80004802:	fef43423          	sd	a5,-24(s0)
    80004806:	00022797          	auipc	a5,0x22
    8000480a:	20278793          	addi	a5,a5,514 # 80026a08 <bcache+0x8268>
    8000480e:	fe843703          	ld	a4,-24(s0)
    80004812:	f8f761e3          	bltu	a4,a5,80004794 <binit+0x5e>
  }
}
    80004816:	0001                	nop
    80004818:	0001                	nop
    8000481a:	60e2                	ld	ra,24(sp)
    8000481c:	6442                	ld	s0,16(sp)
    8000481e:	6105                	addi	sp,sp,32
    80004820:	8082                	ret

0000000080004822 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    80004822:	7179                	addi	sp,sp,-48
    80004824:	f406                	sd	ra,40(sp)
    80004826:	f022                	sd	s0,32(sp)
    80004828:	1800                	addi	s0,sp,48
    8000482a:	87aa                	mv	a5,a0
    8000482c:	872e                	mv	a4,a1
    8000482e:	fcf42e23          	sw	a5,-36(s0)
    80004832:	87ba                	mv	a5,a4
    80004834:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    80004838:	0001a517          	auipc	a0,0x1a
    8000483c:	f6850513          	addi	a0,a0,-152 # 8001e7a0 <bcache>
    80004840:	ffffd097          	auipc	ra,0xffffd
    80004844:	af0080e7          	jalr	-1296(ra) # 80001330 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004848:	0001a717          	auipc	a4,0x1a
    8000484c:	f5870713          	addi	a4,a4,-168 # 8001e7a0 <bcache>
    80004850:	67a1                	lui	a5,0x8
    80004852:	97ba                	add	a5,a5,a4
    80004854:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004858:	fef43423          	sd	a5,-24(s0)
    8000485c:	a095                	j	800048c0 <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    8000485e:	fe843783          	ld	a5,-24(s0)
    80004862:	4798                	lw	a4,8(a5)
    80004864:	fdc42783          	lw	a5,-36(s0)
    80004868:	2781                	sext.w	a5,a5
    8000486a:	04e79663          	bne	a5,a4,800048b6 <bget+0x94>
    8000486e:	fe843783          	ld	a5,-24(s0)
    80004872:	47d8                	lw	a4,12(a5)
    80004874:	fd842783          	lw	a5,-40(s0)
    80004878:	2781                	sext.w	a5,a5
    8000487a:	02e79e63          	bne	a5,a4,800048b6 <bget+0x94>
      b->refcnt++;
    8000487e:	fe843783          	ld	a5,-24(s0)
    80004882:	43bc                	lw	a5,64(a5)
    80004884:	2785                	addiw	a5,a5,1
    80004886:	0007871b          	sext.w	a4,a5
    8000488a:	fe843783          	ld	a5,-24(s0)
    8000488e:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80004890:	0001a517          	auipc	a0,0x1a
    80004894:	f1050513          	addi	a0,a0,-240 # 8001e7a0 <bcache>
    80004898:	ffffd097          	auipc	ra,0xffffd
    8000489c:	afc080e7          	jalr	-1284(ra) # 80001394 <release>
      acquiresleep(&b->lock);
    800048a0:	fe843783          	ld	a5,-24(s0)
    800048a4:	07c1                	addi	a5,a5,16
    800048a6:	853e                	mv	a0,a5
    800048a8:	00002097          	auipc	ra,0x2
    800048ac:	f8e080e7          	jalr	-114(ra) # 80006836 <acquiresleep>
      return b;
    800048b0:	fe843783          	ld	a5,-24(s0)
    800048b4:	a07d                	j	80004962 <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800048b6:	fe843783          	ld	a5,-24(s0)
    800048ba:	6bbc                	ld	a5,80(a5)
    800048bc:	fef43423          	sd	a5,-24(s0)
    800048c0:	fe843703          	ld	a4,-24(s0)
    800048c4:	00022797          	auipc	a5,0x22
    800048c8:	14478793          	addi	a5,a5,324 # 80026a08 <bcache+0x8268>
    800048cc:	f8f719e3          	bne	a4,a5,8000485e <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800048d0:	0001a717          	auipc	a4,0x1a
    800048d4:	ed070713          	addi	a4,a4,-304 # 8001e7a0 <bcache>
    800048d8:	67a1                	lui	a5,0x8
    800048da:	97ba                	add	a5,a5,a4
    800048dc:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    800048e0:	fef43423          	sd	a5,-24(s0)
    800048e4:	a8b9                	j	80004942 <bget+0x120>
    if(b->refcnt == 0) {
    800048e6:	fe843783          	ld	a5,-24(s0)
    800048ea:	43bc                	lw	a5,64(a5)
    800048ec:	e7b1                	bnez	a5,80004938 <bget+0x116>
      b->dev = dev;
    800048ee:	fe843783          	ld	a5,-24(s0)
    800048f2:	fdc42703          	lw	a4,-36(s0)
    800048f6:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    800048f8:	fe843783          	ld	a5,-24(s0)
    800048fc:	fd842703          	lw	a4,-40(s0)
    80004900:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    80004902:	fe843783          	ld	a5,-24(s0)
    80004906:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    8000490a:	fe843783          	ld	a5,-24(s0)
    8000490e:	4705                	li	a4,1
    80004910:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80004912:	0001a517          	auipc	a0,0x1a
    80004916:	e8e50513          	addi	a0,a0,-370 # 8001e7a0 <bcache>
    8000491a:	ffffd097          	auipc	ra,0xffffd
    8000491e:	a7a080e7          	jalr	-1414(ra) # 80001394 <release>
      acquiresleep(&b->lock);
    80004922:	fe843783          	ld	a5,-24(s0)
    80004926:	07c1                	addi	a5,a5,16
    80004928:	853e                	mv	a0,a5
    8000492a:	00002097          	auipc	ra,0x2
    8000492e:	f0c080e7          	jalr	-244(ra) # 80006836 <acquiresleep>
      return b;
    80004932:	fe843783          	ld	a5,-24(s0)
    80004936:	a035                	j	80004962 <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004938:	fe843783          	ld	a5,-24(s0)
    8000493c:	67bc                	ld	a5,72(a5)
    8000493e:	fef43423          	sd	a5,-24(s0)
    80004942:	fe843703          	ld	a4,-24(s0)
    80004946:	00022797          	auipc	a5,0x22
    8000494a:	0c278793          	addi	a5,a5,194 # 80026a08 <bcache+0x8268>
    8000494e:	f8f71ce3          	bne	a4,a5,800048e6 <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    80004952:	00009517          	auipc	a0,0x9
    80004956:	aee50513          	addi	a0,a0,-1298 # 8000d440 <etext+0x440>
    8000495a:	ffffc097          	auipc	ra,0xffffc
    8000495e:	32e080e7          	jalr	814(ra) # 80000c88 <panic>
}
    80004962:	853e                	mv	a0,a5
    80004964:	70a2                	ld	ra,40(sp)
    80004966:	7402                	ld	s0,32(sp)
    80004968:	6145                	addi	sp,sp,48
    8000496a:	8082                	ret

000000008000496c <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000496c:	7179                	addi	sp,sp,-48
    8000496e:	f406                	sd	ra,40(sp)
    80004970:	f022                	sd	s0,32(sp)
    80004972:	1800                	addi	s0,sp,48
    80004974:	87aa                	mv	a5,a0
    80004976:	872e                	mv	a4,a1
    80004978:	fcf42e23          	sw	a5,-36(s0)
    8000497c:	87ba                	mv	a5,a4
    8000497e:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    80004982:	fd842703          	lw	a4,-40(s0)
    80004986:	fdc42783          	lw	a5,-36(s0)
    8000498a:	85ba                	mv	a1,a4
    8000498c:	853e                	mv	a0,a5
    8000498e:	00000097          	auipc	ra,0x0
    80004992:	e94080e7          	jalr	-364(ra) # 80004822 <bget>
    80004996:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    8000499a:	fe843783          	ld	a5,-24(s0)
    8000499e:	439c                	lw	a5,0(a5)
    800049a0:	ef89                	bnez	a5,800049ba <bread+0x4e>
    virtio_disk_rw(VIRTIO0_ID, b, 0);
    800049a2:	4601                	li	a2,0
    800049a4:	fe843583          	ld	a1,-24(s0)
    800049a8:	4501                	li	a0,0
    800049aa:	00005097          	auipc	ra,0x5
    800049ae:	cde080e7          	jalr	-802(ra) # 80009688 <virtio_disk_rw>
    b->valid = 1;
    800049b2:	fe843783          	ld	a5,-24(s0)
    800049b6:	4705                	li	a4,1
    800049b8:	c398                	sw	a4,0(a5)
  }
  return b;
    800049ba:	fe843783          	ld	a5,-24(s0)
}
    800049be:	853e                	mv	a0,a5
    800049c0:	70a2                	ld	ra,40(sp)
    800049c2:	7402                	ld	s0,32(sp)
    800049c4:	6145                	addi	sp,sp,48
    800049c6:	8082                	ret

00000000800049c8 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800049c8:	1101                	addi	sp,sp,-32
    800049ca:	ec06                	sd	ra,24(sp)
    800049cc:	e822                	sd	s0,16(sp)
    800049ce:	1000                	addi	s0,sp,32
    800049d0:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800049d4:	fe843783          	ld	a5,-24(s0)
    800049d8:	07c1                	addi	a5,a5,16
    800049da:	853e                	mv	a0,a5
    800049dc:	00002097          	auipc	ra,0x2
    800049e0:	f1a080e7          	jalr	-230(ra) # 800068f6 <holdingsleep>
    800049e4:	87aa                	mv	a5,a0
    800049e6:	eb89                	bnez	a5,800049f8 <bwrite+0x30>
    panic("bwrite");
    800049e8:	00009517          	auipc	a0,0x9
    800049ec:	a7050513          	addi	a0,a0,-1424 # 8000d458 <etext+0x458>
    800049f0:	ffffc097          	auipc	ra,0xffffc
    800049f4:	298080e7          	jalr	664(ra) # 80000c88 <panic>
  virtio_disk_rw(VIRTIO0_ID, b, 1);
    800049f8:	4605                	li	a2,1
    800049fa:	fe843583          	ld	a1,-24(s0)
    800049fe:	4501                	li	a0,0
    80004a00:	00005097          	auipc	ra,0x5
    80004a04:	c88080e7          	jalr	-888(ra) # 80009688 <virtio_disk_rw>
}
    80004a08:	0001                	nop
    80004a0a:	60e2                	ld	ra,24(sp)
    80004a0c:	6442                	ld	s0,16(sp)
    80004a0e:	6105                	addi	sp,sp,32
    80004a10:	8082                	ret

0000000080004a12 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80004a12:	1101                	addi	sp,sp,-32
    80004a14:	ec06                	sd	ra,24(sp)
    80004a16:	e822                	sd	s0,16(sp)
    80004a18:	1000                	addi	s0,sp,32
    80004a1a:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004a1e:	fe843783          	ld	a5,-24(s0)
    80004a22:	07c1                	addi	a5,a5,16
    80004a24:	853e                	mv	a0,a5
    80004a26:	00002097          	auipc	ra,0x2
    80004a2a:	ed0080e7          	jalr	-304(ra) # 800068f6 <holdingsleep>
    80004a2e:	87aa                	mv	a5,a0
    80004a30:	eb89                	bnez	a5,80004a42 <brelse+0x30>
    panic("brelse");
    80004a32:	00009517          	auipc	a0,0x9
    80004a36:	a2e50513          	addi	a0,a0,-1490 # 8000d460 <etext+0x460>
    80004a3a:	ffffc097          	auipc	ra,0xffffc
    80004a3e:	24e080e7          	jalr	590(ra) # 80000c88 <panic>

  releasesleep(&b->lock);
    80004a42:	fe843783          	ld	a5,-24(s0)
    80004a46:	07c1                	addi	a5,a5,16
    80004a48:	853e                	mv	a0,a5
    80004a4a:	00002097          	auipc	ra,0x2
    80004a4e:	e5a080e7          	jalr	-422(ra) # 800068a4 <releasesleep>

  acquire(&bcache.lock);
    80004a52:	0001a517          	auipc	a0,0x1a
    80004a56:	d4e50513          	addi	a0,a0,-690 # 8001e7a0 <bcache>
    80004a5a:	ffffd097          	auipc	ra,0xffffd
    80004a5e:	8d6080e7          	jalr	-1834(ra) # 80001330 <acquire>
  b->refcnt--;
    80004a62:	fe843783          	ld	a5,-24(s0)
    80004a66:	43bc                	lw	a5,64(a5)
    80004a68:	37fd                	addiw	a5,a5,-1
    80004a6a:	0007871b          	sext.w	a4,a5
    80004a6e:	fe843783          	ld	a5,-24(s0)
    80004a72:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80004a74:	fe843783          	ld	a5,-24(s0)
    80004a78:	43bc                	lw	a5,64(a5)
    80004a7a:	e7b5                	bnez	a5,80004ae6 <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80004a7c:	fe843783          	ld	a5,-24(s0)
    80004a80:	6bbc                	ld	a5,80(a5)
    80004a82:	fe843703          	ld	a4,-24(s0)
    80004a86:	6738                	ld	a4,72(a4)
    80004a88:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80004a8a:	fe843783          	ld	a5,-24(s0)
    80004a8e:	67bc                	ld	a5,72(a5)
    80004a90:	fe843703          	ld	a4,-24(s0)
    80004a94:	6b38                	ld	a4,80(a4)
    80004a96:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80004a98:	0001a717          	auipc	a4,0x1a
    80004a9c:	d0870713          	addi	a4,a4,-760 # 8001e7a0 <bcache>
    80004aa0:	67a1                	lui	a5,0x8
    80004aa2:	97ba                	add	a5,a5,a4
    80004aa4:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004aa8:	fe843783          	ld	a5,-24(s0)
    80004aac:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004aae:	fe843783          	ld	a5,-24(s0)
    80004ab2:	00022717          	auipc	a4,0x22
    80004ab6:	f5670713          	addi	a4,a4,-170 # 80026a08 <bcache+0x8268>
    80004aba:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    80004abc:	0001a717          	auipc	a4,0x1a
    80004ac0:	ce470713          	addi	a4,a4,-796 # 8001e7a0 <bcache>
    80004ac4:	67a1                	lui	a5,0x8
    80004ac6:	97ba                	add	a5,a5,a4
    80004ac8:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004acc:	fe843703          	ld	a4,-24(s0)
    80004ad0:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80004ad2:	0001a717          	auipc	a4,0x1a
    80004ad6:	cce70713          	addi	a4,a4,-818 # 8001e7a0 <bcache>
    80004ada:	67a1                	lui	a5,0x8
    80004adc:	97ba                	add	a5,a5,a4
    80004ade:	fe843703          	ld	a4,-24(s0)
    80004ae2:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    80004ae6:	0001a517          	auipc	a0,0x1a
    80004aea:	cba50513          	addi	a0,a0,-838 # 8001e7a0 <bcache>
    80004aee:	ffffd097          	auipc	ra,0xffffd
    80004af2:	8a6080e7          	jalr	-1882(ra) # 80001394 <release>
}
    80004af6:	0001                	nop
    80004af8:	60e2                	ld	ra,24(sp)
    80004afa:	6442                	ld	s0,16(sp)
    80004afc:	6105                	addi	sp,sp,32
    80004afe:	8082                	ret

0000000080004b00 <bpin>:

void
bpin(struct buf *b) {
    80004b00:	1101                	addi	sp,sp,-32
    80004b02:	ec06                	sd	ra,24(sp)
    80004b04:	e822                	sd	s0,16(sp)
    80004b06:	1000                	addi	s0,sp,32
    80004b08:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004b0c:	0001a517          	auipc	a0,0x1a
    80004b10:	c9450513          	addi	a0,a0,-876 # 8001e7a0 <bcache>
    80004b14:	ffffd097          	auipc	ra,0xffffd
    80004b18:	81c080e7          	jalr	-2020(ra) # 80001330 <acquire>
  b->refcnt++;
    80004b1c:	fe843783          	ld	a5,-24(s0)
    80004b20:	43bc                	lw	a5,64(a5)
    80004b22:	2785                	addiw	a5,a5,1
    80004b24:	0007871b          	sext.w	a4,a5
    80004b28:	fe843783          	ld	a5,-24(s0)
    80004b2c:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004b2e:	0001a517          	auipc	a0,0x1a
    80004b32:	c7250513          	addi	a0,a0,-910 # 8001e7a0 <bcache>
    80004b36:	ffffd097          	auipc	ra,0xffffd
    80004b3a:	85e080e7          	jalr	-1954(ra) # 80001394 <release>
}
    80004b3e:	0001                	nop
    80004b40:	60e2                	ld	ra,24(sp)
    80004b42:	6442                	ld	s0,16(sp)
    80004b44:	6105                	addi	sp,sp,32
    80004b46:	8082                	ret

0000000080004b48 <bunpin>:

void
bunpin(struct buf *b) {
    80004b48:	1101                	addi	sp,sp,-32
    80004b4a:	ec06                	sd	ra,24(sp)
    80004b4c:	e822                	sd	s0,16(sp)
    80004b4e:	1000                	addi	s0,sp,32
    80004b50:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004b54:	0001a517          	auipc	a0,0x1a
    80004b58:	c4c50513          	addi	a0,a0,-948 # 8001e7a0 <bcache>
    80004b5c:	ffffc097          	auipc	ra,0xffffc
    80004b60:	7d4080e7          	jalr	2004(ra) # 80001330 <acquire>
  b->refcnt--;
    80004b64:	fe843783          	ld	a5,-24(s0)
    80004b68:	43bc                	lw	a5,64(a5)
    80004b6a:	37fd                	addiw	a5,a5,-1
    80004b6c:	0007871b          	sext.w	a4,a5
    80004b70:	fe843783          	ld	a5,-24(s0)
    80004b74:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004b76:	0001a517          	auipc	a0,0x1a
    80004b7a:	c2a50513          	addi	a0,a0,-982 # 8001e7a0 <bcache>
    80004b7e:	ffffd097          	auipc	ra,0xffffd
    80004b82:	816080e7          	jalr	-2026(ra) # 80001394 <release>
}
    80004b86:	0001                	nop
    80004b88:	60e2                	ld	ra,24(sp)
    80004b8a:	6442                	ld	s0,16(sp)
    80004b8c:	6105                	addi	sp,sp,32
    80004b8e:	8082                	ret

0000000080004b90 <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    80004b90:	7179                	addi	sp,sp,-48
    80004b92:	f406                	sd	ra,40(sp)
    80004b94:	f022                	sd	s0,32(sp)
    80004b96:	1800                	addi	s0,sp,48
    80004b98:	87aa                	mv	a5,a0
    80004b9a:	fcb43823          	sd	a1,-48(s0)
    80004b9e:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    80004ba2:	fdc42783          	lw	a5,-36(s0)
    80004ba6:	4585                	li	a1,1
    80004ba8:	853e                	mv	a0,a5
    80004baa:	00000097          	auipc	ra,0x0
    80004bae:	dc2080e7          	jalr	-574(ra) # 8000496c <bread>
    80004bb2:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    80004bb6:	fe843783          	ld	a5,-24(s0)
    80004bba:	05878793          	addi	a5,a5,88
    80004bbe:	02000613          	li	a2,32
    80004bc2:	85be                	mv	a1,a5
    80004bc4:	fd043503          	ld	a0,-48(s0)
    80004bc8:	ffffd097          	auipc	ra,0xffffd
    80004bcc:	a20080e7          	jalr	-1504(ra) # 800015e8 <memmove>
  brelse(bp);
    80004bd0:	fe843503          	ld	a0,-24(s0)
    80004bd4:	00000097          	auipc	ra,0x0
    80004bd8:	e3e080e7          	jalr	-450(ra) # 80004a12 <brelse>
}
    80004bdc:	0001                	nop
    80004bde:	70a2                	ld	ra,40(sp)
    80004be0:	7402                	ld	s0,32(sp)
    80004be2:	6145                	addi	sp,sp,48
    80004be4:	8082                	ret

0000000080004be6 <fsinit>:

// Init fs
void
fsinit(int dev) {
    80004be6:	1101                	addi	sp,sp,-32
    80004be8:	ec06                	sd	ra,24(sp)
    80004bea:	e822                	sd	s0,16(sp)
    80004bec:	1000                	addi	s0,sp,32
    80004bee:	87aa                	mv	a5,a0
    80004bf0:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    80004bf4:	fec42783          	lw	a5,-20(s0)
    80004bf8:	00022597          	auipc	a1,0x22
    80004bfc:	26858593          	addi	a1,a1,616 # 80026e60 <sb>
    80004c00:	853e                	mv	a0,a5
    80004c02:	00000097          	auipc	ra,0x0
    80004c06:	f8e080e7          	jalr	-114(ra) # 80004b90 <readsb>
  if(sb.magic != FSMAGIC)
    80004c0a:	00022797          	auipc	a5,0x22
    80004c0e:	25678793          	addi	a5,a5,598 # 80026e60 <sb>
    80004c12:	439c                	lw	a5,0(a5)
    80004c14:	873e                	mv	a4,a5
    80004c16:	102037b7          	lui	a5,0x10203
    80004c1a:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80004c1e:	00f70a63          	beq	a4,a5,80004c32 <fsinit+0x4c>
    panic("invalid file system");
    80004c22:	00009517          	auipc	a0,0x9
    80004c26:	84650513          	addi	a0,a0,-1978 # 8000d468 <etext+0x468>
    80004c2a:	ffffc097          	auipc	ra,0xffffc
    80004c2e:	05e080e7          	jalr	94(ra) # 80000c88 <panic>
  initlog(dev, &sb);
    80004c32:	fec42783          	lw	a5,-20(s0)
    80004c36:	00022597          	auipc	a1,0x22
    80004c3a:	22a58593          	addi	a1,a1,554 # 80026e60 <sb>
    80004c3e:	853e                	mv	a0,a5
    80004c40:	00001097          	auipc	ra,0x1
    80004c44:	48e080e7          	jalr	1166(ra) # 800060ce <initlog>
}
    80004c48:	0001                	nop
    80004c4a:	60e2                	ld	ra,24(sp)
    80004c4c:	6442                	ld	s0,16(sp)
    80004c4e:	6105                	addi	sp,sp,32
    80004c50:	8082                	ret

0000000080004c52 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    80004c52:	7179                	addi	sp,sp,-48
    80004c54:	f406                	sd	ra,40(sp)
    80004c56:	f022                	sd	s0,32(sp)
    80004c58:	1800                	addi	s0,sp,48
    80004c5a:	87aa                	mv	a5,a0
    80004c5c:	872e                	mv	a4,a1
    80004c5e:	fcf42e23          	sw	a5,-36(s0)
    80004c62:	87ba                	mv	a5,a4
    80004c64:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    80004c68:	fdc42783          	lw	a5,-36(s0)
    80004c6c:	fd842703          	lw	a4,-40(s0)
    80004c70:	85ba                	mv	a1,a4
    80004c72:	853e                	mv	a0,a5
    80004c74:	00000097          	auipc	ra,0x0
    80004c78:	cf8080e7          	jalr	-776(ra) # 8000496c <bread>
    80004c7c:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    80004c80:	fe843783          	ld	a5,-24(s0)
    80004c84:	05878793          	addi	a5,a5,88
    80004c88:	40000613          	li	a2,1024
    80004c8c:	4581                	li	a1,0
    80004c8e:	853e                	mv	a0,a5
    80004c90:	ffffd097          	auipc	ra,0xffffd
    80004c94:	874080e7          	jalr	-1932(ra) # 80001504 <memset>
  log_write(bp);
    80004c98:	fe843503          	ld	a0,-24(s0)
    80004c9c:	00002097          	auipc	ra,0x2
    80004ca0:	a1a080e7          	jalr	-1510(ra) # 800066b6 <log_write>
  brelse(bp);
    80004ca4:	fe843503          	ld	a0,-24(s0)
    80004ca8:	00000097          	auipc	ra,0x0
    80004cac:	d6a080e7          	jalr	-662(ra) # 80004a12 <brelse>
}
    80004cb0:	0001                	nop
    80004cb2:	70a2                	ld	ra,40(sp)
    80004cb4:	7402                	ld	s0,32(sp)
    80004cb6:	6145                	addi	sp,sp,48
    80004cb8:	8082                	ret

0000000080004cba <balloc>:

// Allocate a zeroed disk block.
// returns 0 if out of disk space.
static uint
balloc(uint dev)
{
    80004cba:	7139                	addi	sp,sp,-64
    80004cbc:	fc06                	sd	ra,56(sp)
    80004cbe:	f822                	sd	s0,48(sp)
    80004cc0:	0080                	addi	s0,sp,64
    80004cc2:	87aa                	mv	a5,a0
    80004cc4:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80004cc8:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    80004ccc:	fe042623          	sw	zero,-20(s0)
    80004cd0:	a295                	j	80004e34 <balloc+0x17a>
    bp = bread(dev, BBLOCK(b, sb));
    80004cd2:	fec42783          	lw	a5,-20(s0)
    80004cd6:	41f7d71b          	sraiw	a4,a5,0x1f
    80004cda:	0137571b          	srliw	a4,a4,0x13
    80004cde:	9fb9                	addw	a5,a5,a4
    80004ce0:	40d7d79b          	sraiw	a5,a5,0xd
    80004ce4:	2781                	sext.w	a5,a5
    80004ce6:	0007871b          	sext.w	a4,a5
    80004cea:	00022797          	auipc	a5,0x22
    80004cee:	17678793          	addi	a5,a5,374 # 80026e60 <sb>
    80004cf2:	4fdc                	lw	a5,28(a5)
    80004cf4:	9fb9                	addw	a5,a5,a4
    80004cf6:	0007871b          	sext.w	a4,a5
    80004cfa:	fcc42783          	lw	a5,-52(s0)
    80004cfe:	85ba                	mv	a1,a4
    80004d00:	853e                	mv	a0,a5
    80004d02:	00000097          	auipc	ra,0x0
    80004d06:	c6a080e7          	jalr	-918(ra) # 8000496c <bread>
    80004d0a:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004d0e:	fe042423          	sw	zero,-24(s0)
    80004d12:	a8e9                	j	80004dec <balloc+0x132>
      m = 1 << (bi % 8);
    80004d14:	fe842783          	lw	a5,-24(s0)
    80004d18:	8b9d                	andi	a5,a5,7
    80004d1a:	2781                	sext.w	a5,a5
    80004d1c:	4705                	li	a4,1
    80004d1e:	00f717bb          	sllw	a5,a4,a5
    80004d22:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80004d26:	fe842783          	lw	a5,-24(s0)
    80004d2a:	41f7d71b          	sraiw	a4,a5,0x1f
    80004d2e:	01d7571b          	srliw	a4,a4,0x1d
    80004d32:	9fb9                	addw	a5,a5,a4
    80004d34:	4037d79b          	sraiw	a5,a5,0x3
    80004d38:	2781                	sext.w	a5,a5
    80004d3a:	fe043703          	ld	a4,-32(s0)
    80004d3e:	97ba                	add	a5,a5,a4
    80004d40:	0587c783          	lbu	a5,88(a5)
    80004d44:	2781                	sext.w	a5,a5
    80004d46:	fdc42703          	lw	a4,-36(s0)
    80004d4a:	8ff9                	and	a5,a5,a4
    80004d4c:	2781                	sext.w	a5,a5
    80004d4e:	ebd1                	bnez	a5,80004de2 <balloc+0x128>
        bp->data[bi/8] |= m;  // Mark block in use.
    80004d50:	fe842783          	lw	a5,-24(s0)
    80004d54:	41f7d71b          	sraiw	a4,a5,0x1f
    80004d58:	01d7571b          	srliw	a4,a4,0x1d
    80004d5c:	9fb9                	addw	a5,a5,a4
    80004d5e:	4037d79b          	sraiw	a5,a5,0x3
    80004d62:	2781                	sext.w	a5,a5
    80004d64:	fe043703          	ld	a4,-32(s0)
    80004d68:	973e                	add	a4,a4,a5
    80004d6a:	05874703          	lbu	a4,88(a4)
    80004d6e:	0187169b          	slliw	a3,a4,0x18
    80004d72:	4186d69b          	sraiw	a3,a3,0x18
    80004d76:	fdc42703          	lw	a4,-36(s0)
    80004d7a:	0187171b          	slliw	a4,a4,0x18
    80004d7e:	4187571b          	sraiw	a4,a4,0x18
    80004d82:	8f55                	or	a4,a4,a3
    80004d84:	0187171b          	slliw	a4,a4,0x18
    80004d88:	4187571b          	sraiw	a4,a4,0x18
    80004d8c:	0ff77713          	zext.b	a4,a4
    80004d90:	fe043683          	ld	a3,-32(s0)
    80004d94:	97b6                	add	a5,a5,a3
    80004d96:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    80004d9a:	fe043503          	ld	a0,-32(s0)
    80004d9e:	00002097          	auipc	ra,0x2
    80004da2:	918080e7          	jalr	-1768(ra) # 800066b6 <log_write>
        brelse(bp);
    80004da6:	fe043503          	ld	a0,-32(s0)
    80004daa:	00000097          	auipc	ra,0x0
    80004dae:	c68080e7          	jalr	-920(ra) # 80004a12 <brelse>
        bzero(dev, b + bi);
    80004db2:	fcc42783          	lw	a5,-52(s0)
    80004db6:	fec42703          	lw	a4,-20(s0)
    80004dba:	86ba                	mv	a3,a4
    80004dbc:	fe842703          	lw	a4,-24(s0)
    80004dc0:	9f35                	addw	a4,a4,a3
    80004dc2:	2701                	sext.w	a4,a4
    80004dc4:	85ba                	mv	a1,a4
    80004dc6:	853e                	mv	a0,a5
    80004dc8:	00000097          	auipc	ra,0x0
    80004dcc:	e8a080e7          	jalr	-374(ra) # 80004c52 <bzero>
        return b + bi;
    80004dd0:	fec42783          	lw	a5,-20(s0)
    80004dd4:	873e                	mv	a4,a5
    80004dd6:	fe842783          	lw	a5,-24(s0)
    80004dda:	9fb9                	addw	a5,a5,a4
    80004ddc:	2781                	sext.w	a5,a5
    80004dde:	2781                	sext.w	a5,a5
    80004de0:	a8a5                	j	80004e58 <balloc+0x19e>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004de2:	fe842783          	lw	a5,-24(s0)
    80004de6:	2785                	addiw	a5,a5,1
    80004de8:	fef42423          	sw	a5,-24(s0)
    80004dec:	fe842783          	lw	a5,-24(s0)
    80004df0:	0007871b          	sext.w	a4,a5
    80004df4:	6789                	lui	a5,0x2
    80004df6:	02f75263          	bge	a4,a5,80004e1a <balloc+0x160>
    80004dfa:	fec42783          	lw	a5,-20(s0)
    80004dfe:	873e                	mv	a4,a5
    80004e00:	fe842783          	lw	a5,-24(s0)
    80004e04:	9fb9                	addw	a5,a5,a4
    80004e06:	2781                	sext.w	a5,a5
    80004e08:	0007871b          	sext.w	a4,a5
    80004e0c:	00022797          	auipc	a5,0x22
    80004e10:	05478793          	addi	a5,a5,84 # 80026e60 <sb>
    80004e14:	43dc                	lw	a5,4(a5)
    80004e16:	eef76fe3          	bltu	a4,a5,80004d14 <balloc+0x5a>
      }
    }
    brelse(bp);
    80004e1a:	fe043503          	ld	a0,-32(s0)
    80004e1e:	00000097          	auipc	ra,0x0
    80004e22:	bf4080e7          	jalr	-1036(ra) # 80004a12 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80004e26:	fec42783          	lw	a5,-20(s0)
    80004e2a:	873e                	mv	a4,a5
    80004e2c:	6789                	lui	a5,0x2
    80004e2e:	9fb9                	addw	a5,a5,a4
    80004e30:	fef42623          	sw	a5,-20(s0)
    80004e34:	00022797          	auipc	a5,0x22
    80004e38:	02c78793          	addi	a5,a5,44 # 80026e60 <sb>
    80004e3c:	43d8                	lw	a4,4(a5)
    80004e3e:	fec42783          	lw	a5,-20(s0)
    80004e42:	e8e7e8e3          	bltu	a5,a4,80004cd2 <balloc+0x18>
  }
  printf("balloc: out of blocks\n");
    80004e46:	00008517          	auipc	a0,0x8
    80004e4a:	63a50513          	addi	a0,a0,1594 # 8000d480 <etext+0x480>
    80004e4e:	ffffc097          	auipc	ra,0xffffc
    80004e52:	be4080e7          	jalr	-1052(ra) # 80000a32 <printf>
  return 0;
    80004e56:	4781                	li	a5,0
}
    80004e58:	853e                	mv	a0,a5
    80004e5a:	70e2                	ld	ra,56(sp)
    80004e5c:	7442                	ld	s0,48(sp)
    80004e5e:	6121                	addi	sp,sp,64
    80004e60:	8082                	ret

0000000080004e62 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80004e62:	7179                	addi	sp,sp,-48
    80004e64:	f406                	sd	ra,40(sp)
    80004e66:	f022                	sd	s0,32(sp)
    80004e68:	1800                	addi	s0,sp,48
    80004e6a:	87aa                	mv	a5,a0
    80004e6c:	872e                	mv	a4,a1
    80004e6e:	fcf42e23          	sw	a5,-36(s0)
    80004e72:	87ba                	mv	a5,a4
    80004e74:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80004e78:	fdc42683          	lw	a3,-36(s0)
    80004e7c:	fd842783          	lw	a5,-40(s0)
    80004e80:	00d7d79b          	srliw	a5,a5,0xd
    80004e84:	0007871b          	sext.w	a4,a5
    80004e88:	00022797          	auipc	a5,0x22
    80004e8c:	fd878793          	addi	a5,a5,-40 # 80026e60 <sb>
    80004e90:	4fdc                	lw	a5,28(a5)
    80004e92:	9fb9                	addw	a5,a5,a4
    80004e94:	2781                	sext.w	a5,a5
    80004e96:	85be                	mv	a1,a5
    80004e98:	8536                	mv	a0,a3
    80004e9a:	00000097          	auipc	ra,0x0
    80004e9e:	ad2080e7          	jalr	-1326(ra) # 8000496c <bread>
    80004ea2:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80004ea6:	fd842703          	lw	a4,-40(s0)
    80004eaa:	6789                	lui	a5,0x2
    80004eac:	17fd                	addi	a5,a5,-1 # 1fff <_entry-0x7fffe001>
    80004eae:	8ff9                	and	a5,a5,a4
    80004eb0:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80004eb4:	fe442783          	lw	a5,-28(s0)
    80004eb8:	8b9d                	andi	a5,a5,7
    80004eba:	2781                	sext.w	a5,a5
    80004ebc:	4705                	li	a4,1
    80004ebe:	00f717bb          	sllw	a5,a4,a5
    80004ec2:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80004ec6:	fe442783          	lw	a5,-28(s0)
    80004eca:	41f7d71b          	sraiw	a4,a5,0x1f
    80004ece:	01d7571b          	srliw	a4,a4,0x1d
    80004ed2:	9fb9                	addw	a5,a5,a4
    80004ed4:	4037d79b          	sraiw	a5,a5,0x3
    80004ed8:	2781                	sext.w	a5,a5
    80004eda:	fe843703          	ld	a4,-24(s0)
    80004ede:	97ba                	add	a5,a5,a4
    80004ee0:	0587c783          	lbu	a5,88(a5)
    80004ee4:	2781                	sext.w	a5,a5
    80004ee6:	fe042703          	lw	a4,-32(s0)
    80004eea:	8ff9                	and	a5,a5,a4
    80004eec:	2781                	sext.w	a5,a5
    80004eee:	eb89                	bnez	a5,80004f00 <bfree+0x9e>
    panic("freeing free block");
    80004ef0:	00008517          	auipc	a0,0x8
    80004ef4:	5a850513          	addi	a0,a0,1448 # 8000d498 <etext+0x498>
    80004ef8:	ffffc097          	auipc	ra,0xffffc
    80004efc:	d90080e7          	jalr	-624(ra) # 80000c88 <panic>
  bp->data[bi/8] &= ~m;
    80004f00:	fe442783          	lw	a5,-28(s0)
    80004f04:	41f7d71b          	sraiw	a4,a5,0x1f
    80004f08:	01d7571b          	srliw	a4,a4,0x1d
    80004f0c:	9fb9                	addw	a5,a5,a4
    80004f0e:	4037d79b          	sraiw	a5,a5,0x3
    80004f12:	2781                	sext.w	a5,a5
    80004f14:	fe843703          	ld	a4,-24(s0)
    80004f18:	973e                	add	a4,a4,a5
    80004f1a:	05874703          	lbu	a4,88(a4)
    80004f1e:	0187169b          	slliw	a3,a4,0x18
    80004f22:	4186d69b          	sraiw	a3,a3,0x18
    80004f26:	fe042703          	lw	a4,-32(s0)
    80004f2a:	0187171b          	slliw	a4,a4,0x18
    80004f2e:	4187571b          	sraiw	a4,a4,0x18
    80004f32:	fff74713          	not	a4,a4
    80004f36:	0187171b          	slliw	a4,a4,0x18
    80004f3a:	4187571b          	sraiw	a4,a4,0x18
    80004f3e:	8f75                	and	a4,a4,a3
    80004f40:	0187171b          	slliw	a4,a4,0x18
    80004f44:	4187571b          	sraiw	a4,a4,0x18
    80004f48:	0ff77713          	zext.b	a4,a4
    80004f4c:	fe843683          	ld	a3,-24(s0)
    80004f50:	97b6                	add	a5,a5,a3
    80004f52:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80004f56:	fe843503          	ld	a0,-24(s0)
    80004f5a:	00001097          	auipc	ra,0x1
    80004f5e:	75c080e7          	jalr	1884(ra) # 800066b6 <log_write>
  brelse(bp);
    80004f62:	fe843503          	ld	a0,-24(s0)
    80004f66:	00000097          	auipc	ra,0x0
    80004f6a:	aac080e7          	jalr	-1364(ra) # 80004a12 <brelse>
}
    80004f6e:	0001                	nop
    80004f70:	70a2                	ld	ra,40(sp)
    80004f72:	7402                	ld	s0,32(sp)
    80004f74:	6145                	addi	sp,sp,48
    80004f76:	8082                	ret

0000000080004f78 <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    80004f78:	1101                	addi	sp,sp,-32
    80004f7a:	ec06                	sd	ra,24(sp)
    80004f7c:	e822                	sd	s0,16(sp)
    80004f7e:	1000                	addi	s0,sp,32
  int i = 0;
    80004f80:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80004f84:	00008597          	auipc	a1,0x8
    80004f88:	52c58593          	addi	a1,a1,1324 # 8000d4b0 <etext+0x4b0>
    80004f8c:	00022517          	auipc	a0,0x22
    80004f90:	ef450513          	addi	a0,a0,-268 # 80026e80 <itable>
    80004f94:	ffffc097          	auipc	ra,0xffffc
    80004f98:	36c080e7          	jalr	876(ra) # 80001300 <initlock>
  for(i = 0; i < NINODE; i++) {
    80004f9c:	fe042623          	sw	zero,-20(s0)
    80004fa0:	a82d                	j	80004fda <iinit+0x62>
    initsleeplock(&itable.inode[i].lock, "inode");
    80004fa2:	fec42703          	lw	a4,-20(s0)
    80004fa6:	87ba                	mv	a5,a4
    80004fa8:	0792                	slli	a5,a5,0x4
    80004faa:	97ba                	add	a5,a5,a4
    80004fac:	078e                	slli	a5,a5,0x3
    80004fae:	02078713          	addi	a4,a5,32
    80004fb2:	00022797          	auipc	a5,0x22
    80004fb6:	ece78793          	addi	a5,a5,-306 # 80026e80 <itable>
    80004fba:	97ba                	add	a5,a5,a4
    80004fbc:	07a1                	addi	a5,a5,8
    80004fbe:	00008597          	auipc	a1,0x8
    80004fc2:	4fa58593          	addi	a1,a1,1274 # 8000d4b8 <etext+0x4b8>
    80004fc6:	853e                	mv	a0,a5
    80004fc8:	00002097          	auipc	ra,0x2
    80004fcc:	822080e7          	jalr	-2014(ra) # 800067ea <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80004fd0:	fec42783          	lw	a5,-20(s0)
    80004fd4:	2785                	addiw	a5,a5,1
    80004fd6:	fef42623          	sw	a5,-20(s0)
    80004fda:	fec42783          	lw	a5,-20(s0)
    80004fde:	0007871b          	sext.w	a4,a5
    80004fe2:	03100793          	li	a5,49
    80004fe6:	fae7dee3          	bge	a5,a4,80004fa2 <iinit+0x2a>
  }
}
    80004fea:	0001                	nop
    80004fec:	0001                	nop
    80004fee:	60e2                	ld	ra,24(sp)
    80004ff0:	6442                	ld	s0,16(sp)
    80004ff2:	6105                	addi	sp,sp,32
    80004ff4:	8082                	ret

0000000080004ff6 <ialloc>:
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode,
// or NULL if there is no free inode.
struct inode*
ialloc(uint dev, short type)
{
    80004ff6:	7139                	addi	sp,sp,-64
    80004ff8:	fc06                	sd	ra,56(sp)
    80004ffa:	f822                	sd	s0,48(sp)
    80004ffc:	0080                	addi	s0,sp,64
    80004ffe:	87aa                	mv	a5,a0
    80005000:	872e                	mv	a4,a1
    80005002:	fcf42623          	sw	a5,-52(s0)
    80005006:	87ba                	mv	a5,a4
    80005008:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    8000500c:	4785                	li	a5,1
    8000500e:	fef42623          	sw	a5,-20(s0)
    80005012:	a855                	j	800050c6 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    80005014:	fec42783          	lw	a5,-20(s0)
    80005018:	8391                	srli	a5,a5,0x4
    8000501a:	0007871b          	sext.w	a4,a5
    8000501e:	00022797          	auipc	a5,0x22
    80005022:	e4278793          	addi	a5,a5,-446 # 80026e60 <sb>
    80005026:	4f9c                	lw	a5,24(a5)
    80005028:	9fb9                	addw	a5,a5,a4
    8000502a:	0007871b          	sext.w	a4,a5
    8000502e:	fcc42783          	lw	a5,-52(s0)
    80005032:	85ba                	mv	a1,a4
    80005034:	853e                	mv	a0,a5
    80005036:	00000097          	auipc	ra,0x0
    8000503a:	936080e7          	jalr	-1738(ra) # 8000496c <bread>
    8000503e:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80005042:	fe043783          	ld	a5,-32(s0)
    80005046:	05878713          	addi	a4,a5,88
    8000504a:	fec42783          	lw	a5,-20(s0)
    8000504e:	8bbd                	andi	a5,a5,15
    80005050:	079a                	slli	a5,a5,0x6
    80005052:	97ba                	add	a5,a5,a4
    80005054:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    80005058:	fd843783          	ld	a5,-40(s0)
    8000505c:	00079783          	lh	a5,0(a5)
    80005060:	eba1                	bnez	a5,800050b0 <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    80005062:	04000613          	li	a2,64
    80005066:	4581                	li	a1,0
    80005068:	fd843503          	ld	a0,-40(s0)
    8000506c:	ffffc097          	auipc	ra,0xffffc
    80005070:	498080e7          	jalr	1176(ra) # 80001504 <memset>
      dip->type = type;
    80005074:	fd843783          	ld	a5,-40(s0)
    80005078:	fca45703          	lhu	a4,-54(s0)
    8000507c:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80005080:	fe043503          	ld	a0,-32(s0)
    80005084:	00001097          	auipc	ra,0x1
    80005088:	632080e7          	jalr	1586(ra) # 800066b6 <log_write>
      brelse(bp);
    8000508c:	fe043503          	ld	a0,-32(s0)
    80005090:	00000097          	auipc	ra,0x0
    80005094:	982080e7          	jalr	-1662(ra) # 80004a12 <brelse>
      return iget(dev, inum);
    80005098:	fec42703          	lw	a4,-20(s0)
    8000509c:	fcc42783          	lw	a5,-52(s0)
    800050a0:	85ba                	mv	a1,a4
    800050a2:	853e                	mv	a0,a5
    800050a4:	00000097          	auipc	ra,0x0
    800050a8:	138080e7          	jalr	312(ra) # 800051dc <iget>
    800050ac:	87aa                	mv	a5,a0
    800050ae:	a835                	j	800050ea <ialloc+0xf4>
    }
    brelse(bp);
    800050b0:	fe043503          	ld	a0,-32(s0)
    800050b4:	00000097          	auipc	ra,0x0
    800050b8:	95e080e7          	jalr	-1698(ra) # 80004a12 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800050bc:	fec42783          	lw	a5,-20(s0)
    800050c0:	2785                	addiw	a5,a5,1
    800050c2:	fef42623          	sw	a5,-20(s0)
    800050c6:	00022797          	auipc	a5,0x22
    800050ca:	d9a78793          	addi	a5,a5,-614 # 80026e60 <sb>
    800050ce:	47d8                	lw	a4,12(a5)
    800050d0:	fec42783          	lw	a5,-20(s0)
    800050d4:	f4e7e0e3          	bltu	a5,a4,80005014 <ialloc+0x1e>
  }
  printf("ialloc: no inodes\n");
    800050d8:	00008517          	auipc	a0,0x8
    800050dc:	3e850513          	addi	a0,a0,1000 # 8000d4c0 <etext+0x4c0>
    800050e0:	ffffc097          	auipc	ra,0xffffc
    800050e4:	952080e7          	jalr	-1710(ra) # 80000a32 <printf>
  return 0;
    800050e8:	4781                	li	a5,0
}
    800050ea:	853e                	mv	a0,a5
    800050ec:	70e2                	ld	ra,56(sp)
    800050ee:	7442                	ld	s0,48(sp)
    800050f0:	6121                	addi	sp,sp,64
    800050f2:	8082                	ret

00000000800050f4 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    800050f4:	7179                	addi	sp,sp,-48
    800050f6:	f406                	sd	ra,40(sp)
    800050f8:	f022                	sd	s0,32(sp)
    800050fa:	1800                	addi	s0,sp,48
    800050fc:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005100:	fd843783          	ld	a5,-40(s0)
    80005104:	4394                	lw	a3,0(a5)
    80005106:	fd843783          	ld	a5,-40(s0)
    8000510a:	43dc                	lw	a5,4(a5)
    8000510c:	0047d79b          	srliw	a5,a5,0x4
    80005110:	0007871b          	sext.w	a4,a5
    80005114:	00022797          	auipc	a5,0x22
    80005118:	d4c78793          	addi	a5,a5,-692 # 80026e60 <sb>
    8000511c:	4f9c                	lw	a5,24(a5)
    8000511e:	9fb9                	addw	a5,a5,a4
    80005120:	2781                	sext.w	a5,a5
    80005122:	85be                	mv	a1,a5
    80005124:	8536                	mv	a0,a3
    80005126:	00000097          	auipc	ra,0x0
    8000512a:	846080e7          	jalr	-1978(ra) # 8000496c <bread>
    8000512e:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005132:	fe843783          	ld	a5,-24(s0)
    80005136:	05878713          	addi	a4,a5,88
    8000513a:	fd843783          	ld	a5,-40(s0)
    8000513e:	43dc                	lw	a5,4(a5)
    80005140:	1782                	slli	a5,a5,0x20
    80005142:	9381                	srli	a5,a5,0x20
    80005144:	8bbd                	andi	a5,a5,15
    80005146:	079a                	slli	a5,a5,0x6
    80005148:	97ba                	add	a5,a5,a4
    8000514a:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    8000514e:	fd843783          	ld	a5,-40(s0)
    80005152:	04479703          	lh	a4,68(a5)
    80005156:	fe043783          	ld	a5,-32(s0)
    8000515a:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    8000515e:	fd843783          	ld	a5,-40(s0)
    80005162:	04679703          	lh	a4,70(a5)
    80005166:	fe043783          	ld	a5,-32(s0)
    8000516a:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    8000516e:	fd843783          	ld	a5,-40(s0)
    80005172:	04879703          	lh	a4,72(a5)
    80005176:	fe043783          	ld	a5,-32(s0)
    8000517a:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    8000517e:	fd843783          	ld	a5,-40(s0)
    80005182:	04a79703          	lh	a4,74(a5)
    80005186:	fe043783          	ld	a5,-32(s0)
    8000518a:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    8000518e:	fd843783          	ld	a5,-40(s0)
    80005192:	47f8                	lw	a4,76(a5)
    80005194:	fe043783          	ld	a5,-32(s0)
    80005198:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    8000519a:	fe043783          	ld	a5,-32(s0)
    8000519e:	00c78713          	addi	a4,a5,12
    800051a2:	fd843783          	ld	a5,-40(s0)
    800051a6:	05078793          	addi	a5,a5,80
    800051aa:	03400613          	li	a2,52
    800051ae:	85be                	mv	a1,a5
    800051b0:	853a                	mv	a0,a4
    800051b2:	ffffc097          	auipc	ra,0xffffc
    800051b6:	436080e7          	jalr	1078(ra) # 800015e8 <memmove>
  log_write(bp);
    800051ba:	fe843503          	ld	a0,-24(s0)
    800051be:	00001097          	auipc	ra,0x1
    800051c2:	4f8080e7          	jalr	1272(ra) # 800066b6 <log_write>
  brelse(bp);
    800051c6:	fe843503          	ld	a0,-24(s0)
    800051ca:	00000097          	auipc	ra,0x0
    800051ce:	848080e7          	jalr	-1976(ra) # 80004a12 <brelse>
}
    800051d2:	0001                	nop
    800051d4:	70a2                	ld	ra,40(sp)
    800051d6:	7402                	ld	s0,32(sp)
    800051d8:	6145                	addi	sp,sp,48
    800051da:	8082                	ret

00000000800051dc <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    800051dc:	7179                	addi	sp,sp,-48
    800051de:	f406                	sd	ra,40(sp)
    800051e0:	f022                	sd	s0,32(sp)
    800051e2:	1800                	addi	s0,sp,48
    800051e4:	87aa                	mv	a5,a0
    800051e6:	872e                	mv	a4,a1
    800051e8:	fcf42e23          	sw	a5,-36(s0)
    800051ec:	87ba                	mv	a5,a4
    800051ee:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    800051f2:	00022517          	auipc	a0,0x22
    800051f6:	c8e50513          	addi	a0,a0,-882 # 80026e80 <itable>
    800051fa:	ffffc097          	auipc	ra,0xffffc
    800051fe:	136080e7          	jalr	310(ra) # 80001330 <acquire>

  // Is the inode already in the table?
  empty = 0;
    80005202:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005206:	00022797          	auipc	a5,0x22
    8000520a:	c9278793          	addi	a5,a5,-878 # 80026e98 <itable+0x18>
    8000520e:	fef43423          	sd	a5,-24(s0)
    80005212:	a89d                	j	80005288 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80005214:	fe843783          	ld	a5,-24(s0)
    80005218:	479c                	lw	a5,8(a5)
    8000521a:	04f05663          	blez	a5,80005266 <iget+0x8a>
    8000521e:	fe843783          	ld	a5,-24(s0)
    80005222:	4398                	lw	a4,0(a5)
    80005224:	fdc42783          	lw	a5,-36(s0)
    80005228:	2781                	sext.w	a5,a5
    8000522a:	02e79e63          	bne	a5,a4,80005266 <iget+0x8a>
    8000522e:	fe843783          	ld	a5,-24(s0)
    80005232:	43d8                	lw	a4,4(a5)
    80005234:	fd842783          	lw	a5,-40(s0)
    80005238:	2781                	sext.w	a5,a5
    8000523a:	02e79663          	bne	a5,a4,80005266 <iget+0x8a>
      ip->ref++;
    8000523e:	fe843783          	ld	a5,-24(s0)
    80005242:	479c                	lw	a5,8(a5)
    80005244:	2785                	addiw	a5,a5,1
    80005246:	0007871b          	sext.w	a4,a5
    8000524a:	fe843783          	ld	a5,-24(s0)
    8000524e:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    80005250:	00022517          	auipc	a0,0x22
    80005254:	c3050513          	addi	a0,a0,-976 # 80026e80 <itable>
    80005258:	ffffc097          	auipc	ra,0xffffc
    8000525c:	13c080e7          	jalr	316(ra) # 80001394 <release>
      return ip;
    80005260:	fe843783          	ld	a5,-24(s0)
    80005264:	a069                	j	800052ee <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80005266:	fe043783          	ld	a5,-32(s0)
    8000526a:	eb89                	bnez	a5,8000527c <iget+0xa0>
    8000526c:	fe843783          	ld	a5,-24(s0)
    80005270:	479c                	lw	a5,8(a5)
    80005272:	e789                	bnez	a5,8000527c <iget+0xa0>
      empty = ip;
    80005274:	fe843783          	ld	a5,-24(s0)
    80005278:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000527c:	fe843783          	ld	a5,-24(s0)
    80005280:	08878793          	addi	a5,a5,136
    80005284:	fef43423          	sd	a5,-24(s0)
    80005288:	fe843703          	ld	a4,-24(s0)
    8000528c:	00023797          	auipc	a5,0x23
    80005290:	69c78793          	addi	a5,a5,1692 # 80028928 <log>
    80005294:	f8f760e3          	bltu	a4,a5,80005214 <iget+0x38>
  }

  // Recycle an inode entry.
  if(empty == 0)
    80005298:	fe043783          	ld	a5,-32(s0)
    8000529c:	eb89                	bnez	a5,800052ae <iget+0xd2>
    panic("iget: no inodes");
    8000529e:	00008517          	auipc	a0,0x8
    800052a2:	23a50513          	addi	a0,a0,570 # 8000d4d8 <etext+0x4d8>
    800052a6:	ffffc097          	auipc	ra,0xffffc
    800052aa:	9e2080e7          	jalr	-1566(ra) # 80000c88 <panic>

  ip = empty;
    800052ae:	fe043783          	ld	a5,-32(s0)
    800052b2:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    800052b6:	fe843783          	ld	a5,-24(s0)
    800052ba:	fdc42703          	lw	a4,-36(s0)
    800052be:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    800052c0:	fe843783          	ld	a5,-24(s0)
    800052c4:	fd842703          	lw	a4,-40(s0)
    800052c8:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    800052ca:	fe843783          	ld	a5,-24(s0)
    800052ce:	4705                	li	a4,1
    800052d0:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    800052d2:	fe843783          	ld	a5,-24(s0)
    800052d6:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    800052da:	00022517          	auipc	a0,0x22
    800052de:	ba650513          	addi	a0,a0,-1114 # 80026e80 <itable>
    800052e2:	ffffc097          	auipc	ra,0xffffc
    800052e6:	0b2080e7          	jalr	178(ra) # 80001394 <release>

  return ip;
    800052ea:	fe843783          	ld	a5,-24(s0)
}
    800052ee:	853e                	mv	a0,a5
    800052f0:	70a2                	ld	ra,40(sp)
    800052f2:	7402                	ld	s0,32(sp)
    800052f4:	6145                	addi	sp,sp,48
    800052f6:	8082                	ret

00000000800052f8 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    800052f8:	1101                	addi	sp,sp,-32
    800052fa:	ec06                	sd	ra,24(sp)
    800052fc:	e822                	sd	s0,16(sp)
    800052fe:	1000                	addi	s0,sp,32
    80005300:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80005304:	00022517          	auipc	a0,0x22
    80005308:	b7c50513          	addi	a0,a0,-1156 # 80026e80 <itable>
    8000530c:	ffffc097          	auipc	ra,0xffffc
    80005310:	024080e7          	jalr	36(ra) # 80001330 <acquire>
  ip->ref++;
    80005314:	fe843783          	ld	a5,-24(s0)
    80005318:	479c                	lw	a5,8(a5)
    8000531a:	2785                	addiw	a5,a5,1
    8000531c:	0007871b          	sext.w	a4,a5
    80005320:	fe843783          	ld	a5,-24(s0)
    80005324:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005326:	00022517          	auipc	a0,0x22
    8000532a:	b5a50513          	addi	a0,a0,-1190 # 80026e80 <itable>
    8000532e:	ffffc097          	auipc	ra,0xffffc
    80005332:	066080e7          	jalr	102(ra) # 80001394 <release>
  return ip;
    80005336:	fe843783          	ld	a5,-24(s0)
}
    8000533a:	853e                	mv	a0,a5
    8000533c:	60e2                	ld	ra,24(sp)
    8000533e:	6442                	ld	s0,16(sp)
    80005340:	6105                	addi	sp,sp,32
    80005342:	8082                	ret

0000000080005344 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80005344:	7179                	addi	sp,sp,-48
    80005346:	f406                	sd	ra,40(sp)
    80005348:	f022                	sd	s0,32(sp)
    8000534a:	1800                	addi	s0,sp,48
    8000534c:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    80005350:	fd843783          	ld	a5,-40(s0)
    80005354:	c791                	beqz	a5,80005360 <ilock+0x1c>
    80005356:	fd843783          	ld	a5,-40(s0)
    8000535a:	479c                	lw	a5,8(a5)
    8000535c:	00f04a63          	bgtz	a5,80005370 <ilock+0x2c>
    panic("ilock");
    80005360:	00008517          	auipc	a0,0x8
    80005364:	18850513          	addi	a0,a0,392 # 8000d4e8 <etext+0x4e8>
    80005368:	ffffc097          	auipc	ra,0xffffc
    8000536c:	920080e7          	jalr	-1760(ra) # 80000c88 <panic>

  acquiresleep(&ip->lock);
    80005370:	fd843783          	ld	a5,-40(s0)
    80005374:	07c1                	addi	a5,a5,16
    80005376:	853e                	mv	a0,a5
    80005378:	00001097          	auipc	ra,0x1
    8000537c:	4be080e7          	jalr	1214(ra) # 80006836 <acquiresleep>

  if(ip->valid == 0){
    80005380:	fd843783          	ld	a5,-40(s0)
    80005384:	43bc                	lw	a5,64(a5)
    80005386:	e7e5                	bnez	a5,8000546e <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005388:	fd843783          	ld	a5,-40(s0)
    8000538c:	4394                	lw	a3,0(a5)
    8000538e:	fd843783          	ld	a5,-40(s0)
    80005392:	43dc                	lw	a5,4(a5)
    80005394:	0047d79b          	srliw	a5,a5,0x4
    80005398:	0007871b          	sext.w	a4,a5
    8000539c:	00022797          	auipc	a5,0x22
    800053a0:	ac478793          	addi	a5,a5,-1340 # 80026e60 <sb>
    800053a4:	4f9c                	lw	a5,24(a5)
    800053a6:	9fb9                	addw	a5,a5,a4
    800053a8:	2781                	sext.w	a5,a5
    800053aa:	85be                	mv	a1,a5
    800053ac:	8536                	mv	a0,a3
    800053ae:	fffff097          	auipc	ra,0xfffff
    800053b2:	5be080e7          	jalr	1470(ra) # 8000496c <bread>
    800053b6:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    800053ba:	fe843783          	ld	a5,-24(s0)
    800053be:	05878713          	addi	a4,a5,88
    800053c2:	fd843783          	ld	a5,-40(s0)
    800053c6:	43dc                	lw	a5,4(a5)
    800053c8:	1782                	slli	a5,a5,0x20
    800053ca:	9381                	srli	a5,a5,0x20
    800053cc:	8bbd                	andi	a5,a5,15
    800053ce:	079a                	slli	a5,a5,0x6
    800053d0:	97ba                	add	a5,a5,a4
    800053d2:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    800053d6:	fe043783          	ld	a5,-32(s0)
    800053da:	00079703          	lh	a4,0(a5)
    800053de:	fd843783          	ld	a5,-40(s0)
    800053e2:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    800053e6:	fe043783          	ld	a5,-32(s0)
    800053ea:	00279703          	lh	a4,2(a5)
    800053ee:	fd843783          	ld	a5,-40(s0)
    800053f2:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    800053f6:	fe043783          	ld	a5,-32(s0)
    800053fa:	00479703          	lh	a4,4(a5)
    800053fe:	fd843783          	ld	a5,-40(s0)
    80005402:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80005406:	fe043783          	ld	a5,-32(s0)
    8000540a:	00679703          	lh	a4,6(a5)
    8000540e:	fd843783          	ld	a5,-40(s0)
    80005412:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80005416:	fe043783          	ld	a5,-32(s0)
    8000541a:	4798                	lw	a4,8(a5)
    8000541c:	fd843783          	ld	a5,-40(s0)
    80005420:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80005422:	fd843783          	ld	a5,-40(s0)
    80005426:	05078713          	addi	a4,a5,80
    8000542a:	fe043783          	ld	a5,-32(s0)
    8000542e:	07b1                	addi	a5,a5,12
    80005430:	03400613          	li	a2,52
    80005434:	85be                	mv	a1,a5
    80005436:	853a                	mv	a0,a4
    80005438:	ffffc097          	auipc	ra,0xffffc
    8000543c:	1b0080e7          	jalr	432(ra) # 800015e8 <memmove>
    brelse(bp);
    80005440:	fe843503          	ld	a0,-24(s0)
    80005444:	fffff097          	auipc	ra,0xfffff
    80005448:	5ce080e7          	jalr	1486(ra) # 80004a12 <brelse>
    ip->valid = 1;
    8000544c:	fd843783          	ld	a5,-40(s0)
    80005450:	4705                	li	a4,1
    80005452:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80005454:	fd843783          	ld	a5,-40(s0)
    80005458:	04479783          	lh	a5,68(a5)
    8000545c:	eb89                	bnez	a5,8000546e <ilock+0x12a>
      panic("ilock: no type");
    8000545e:	00008517          	auipc	a0,0x8
    80005462:	09250513          	addi	a0,a0,146 # 8000d4f0 <etext+0x4f0>
    80005466:	ffffc097          	auipc	ra,0xffffc
    8000546a:	822080e7          	jalr	-2014(ra) # 80000c88 <panic>
  }
}
    8000546e:	0001                	nop
    80005470:	70a2                	ld	ra,40(sp)
    80005472:	7402                	ld	s0,32(sp)
    80005474:	6145                	addi	sp,sp,48
    80005476:	8082                	ret

0000000080005478 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80005478:	1101                	addi	sp,sp,-32
    8000547a:	ec06                	sd	ra,24(sp)
    8000547c:	e822                	sd	s0,16(sp)
    8000547e:	1000                	addi	s0,sp,32
    80005480:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80005484:	fe843783          	ld	a5,-24(s0)
    80005488:	c385                	beqz	a5,800054a8 <iunlock+0x30>
    8000548a:	fe843783          	ld	a5,-24(s0)
    8000548e:	07c1                	addi	a5,a5,16
    80005490:	853e                	mv	a0,a5
    80005492:	00001097          	auipc	ra,0x1
    80005496:	464080e7          	jalr	1124(ra) # 800068f6 <holdingsleep>
    8000549a:	87aa                	mv	a5,a0
    8000549c:	c791                	beqz	a5,800054a8 <iunlock+0x30>
    8000549e:	fe843783          	ld	a5,-24(s0)
    800054a2:	479c                	lw	a5,8(a5)
    800054a4:	00f04a63          	bgtz	a5,800054b8 <iunlock+0x40>
    panic("iunlock");
    800054a8:	00008517          	auipc	a0,0x8
    800054ac:	05850513          	addi	a0,a0,88 # 8000d500 <etext+0x500>
    800054b0:	ffffb097          	auipc	ra,0xffffb
    800054b4:	7d8080e7          	jalr	2008(ra) # 80000c88 <panic>

  releasesleep(&ip->lock);
    800054b8:	fe843783          	ld	a5,-24(s0)
    800054bc:	07c1                	addi	a5,a5,16
    800054be:	853e                	mv	a0,a5
    800054c0:	00001097          	auipc	ra,0x1
    800054c4:	3e4080e7          	jalr	996(ra) # 800068a4 <releasesleep>
}
    800054c8:	0001                	nop
    800054ca:	60e2                	ld	ra,24(sp)
    800054cc:	6442                	ld	s0,16(sp)
    800054ce:	6105                	addi	sp,sp,32
    800054d0:	8082                	ret

00000000800054d2 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    800054d2:	1101                	addi	sp,sp,-32
    800054d4:	ec06                	sd	ra,24(sp)
    800054d6:	e822                	sd	s0,16(sp)
    800054d8:	1000                	addi	s0,sp,32
    800054da:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    800054de:	00022517          	auipc	a0,0x22
    800054e2:	9a250513          	addi	a0,a0,-1630 # 80026e80 <itable>
    800054e6:	ffffc097          	auipc	ra,0xffffc
    800054ea:	e4a080e7          	jalr	-438(ra) # 80001330 <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800054ee:	fe843783          	ld	a5,-24(s0)
    800054f2:	479c                	lw	a5,8(a5)
    800054f4:	873e                	mv	a4,a5
    800054f6:	4785                	li	a5,1
    800054f8:	06f71f63          	bne	a4,a5,80005576 <iput+0xa4>
    800054fc:	fe843783          	ld	a5,-24(s0)
    80005500:	43bc                	lw	a5,64(a5)
    80005502:	cbb5                	beqz	a5,80005576 <iput+0xa4>
    80005504:	fe843783          	ld	a5,-24(s0)
    80005508:	04a79783          	lh	a5,74(a5)
    8000550c:	e7ad                	bnez	a5,80005576 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    8000550e:	fe843783          	ld	a5,-24(s0)
    80005512:	07c1                	addi	a5,a5,16
    80005514:	853e                	mv	a0,a5
    80005516:	00001097          	auipc	ra,0x1
    8000551a:	320080e7          	jalr	800(ra) # 80006836 <acquiresleep>

    release(&itable.lock);
    8000551e:	00022517          	auipc	a0,0x22
    80005522:	96250513          	addi	a0,a0,-1694 # 80026e80 <itable>
    80005526:	ffffc097          	auipc	ra,0xffffc
    8000552a:	e6e080e7          	jalr	-402(ra) # 80001394 <release>

    itrunc(ip);
    8000552e:	fe843503          	ld	a0,-24(s0)
    80005532:	00000097          	auipc	ra,0x0
    80005536:	21a080e7          	jalr	538(ra) # 8000574c <itrunc>
    ip->type = 0;
    8000553a:	fe843783          	ld	a5,-24(s0)
    8000553e:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    80005542:	fe843503          	ld	a0,-24(s0)
    80005546:	00000097          	auipc	ra,0x0
    8000554a:	bae080e7          	jalr	-1106(ra) # 800050f4 <iupdate>
    ip->valid = 0;
    8000554e:	fe843783          	ld	a5,-24(s0)
    80005552:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80005556:	fe843783          	ld	a5,-24(s0)
    8000555a:	07c1                	addi	a5,a5,16
    8000555c:	853e                	mv	a0,a5
    8000555e:	00001097          	auipc	ra,0x1
    80005562:	346080e7          	jalr	838(ra) # 800068a4 <releasesleep>

    acquire(&itable.lock);
    80005566:	00022517          	auipc	a0,0x22
    8000556a:	91a50513          	addi	a0,a0,-1766 # 80026e80 <itable>
    8000556e:	ffffc097          	auipc	ra,0xffffc
    80005572:	dc2080e7          	jalr	-574(ra) # 80001330 <acquire>
  }

  ip->ref--;
    80005576:	fe843783          	ld	a5,-24(s0)
    8000557a:	479c                	lw	a5,8(a5)
    8000557c:	37fd                	addiw	a5,a5,-1
    8000557e:	0007871b          	sext.w	a4,a5
    80005582:	fe843783          	ld	a5,-24(s0)
    80005586:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005588:	00022517          	auipc	a0,0x22
    8000558c:	8f850513          	addi	a0,a0,-1800 # 80026e80 <itable>
    80005590:	ffffc097          	auipc	ra,0xffffc
    80005594:	e04080e7          	jalr	-508(ra) # 80001394 <release>
}
    80005598:	0001                	nop
    8000559a:	60e2                	ld	ra,24(sp)
    8000559c:	6442                	ld	s0,16(sp)
    8000559e:	6105                	addi	sp,sp,32
    800055a0:	8082                	ret

00000000800055a2 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    800055a2:	1101                	addi	sp,sp,-32
    800055a4:	ec06                	sd	ra,24(sp)
    800055a6:	e822                	sd	s0,16(sp)
    800055a8:	1000                	addi	s0,sp,32
    800055aa:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    800055ae:	fe843503          	ld	a0,-24(s0)
    800055b2:	00000097          	auipc	ra,0x0
    800055b6:	ec6080e7          	jalr	-314(ra) # 80005478 <iunlock>
  iput(ip);
    800055ba:	fe843503          	ld	a0,-24(s0)
    800055be:	00000097          	auipc	ra,0x0
    800055c2:	f14080e7          	jalr	-236(ra) # 800054d2 <iput>
}
    800055c6:	0001                	nop
    800055c8:	60e2                	ld	ra,24(sp)
    800055ca:	6442                	ld	s0,16(sp)
    800055cc:	6105                	addi	sp,sp,32
    800055ce:	8082                	ret

00000000800055d0 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800055d0:	7139                	addi	sp,sp,-64
    800055d2:	fc06                	sd	ra,56(sp)
    800055d4:	f822                	sd	s0,48(sp)
    800055d6:	0080                	addi	s0,sp,64
    800055d8:	fca43423          	sd	a0,-56(s0)
    800055dc:	87ae                	mv	a5,a1
    800055de:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800055e2:	fc442783          	lw	a5,-60(s0)
    800055e6:	0007871b          	sext.w	a4,a5
    800055ea:	47ad                	li	a5,11
    800055ec:	04e7ee63          	bltu	a5,a4,80005648 <bmap+0x78>
    if((addr = ip->addrs[bn]) == 0){
    800055f0:	fc843703          	ld	a4,-56(s0)
    800055f4:	fc446783          	lwu	a5,-60(s0)
    800055f8:	07d1                	addi	a5,a5,20
    800055fa:	078a                	slli	a5,a5,0x2
    800055fc:	97ba                	add	a5,a5,a4
    800055fe:	439c                	lw	a5,0(a5)
    80005600:	fef42623          	sw	a5,-20(s0)
    80005604:	fec42783          	lw	a5,-20(s0)
    80005608:	2781                	sext.w	a5,a5
    8000560a:	ef85                	bnez	a5,80005642 <bmap+0x72>
      addr = balloc(ip->dev);
    8000560c:	fc843783          	ld	a5,-56(s0)
    80005610:	439c                	lw	a5,0(a5)
    80005612:	853e                	mv	a0,a5
    80005614:	fffff097          	auipc	ra,0xfffff
    80005618:	6a6080e7          	jalr	1702(ra) # 80004cba <balloc>
    8000561c:	87aa                	mv	a5,a0
    8000561e:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    80005622:	fec42783          	lw	a5,-20(s0)
    80005626:	2781                	sext.w	a5,a5
    80005628:	e399                	bnez	a5,8000562e <bmap+0x5e>
        return 0;
    8000562a:	4781                	li	a5,0
    8000562c:	aa19                	j	80005742 <bmap+0x172>
      ip->addrs[bn] = addr;
    8000562e:	fc843703          	ld	a4,-56(s0)
    80005632:	fc446783          	lwu	a5,-60(s0)
    80005636:	07d1                	addi	a5,a5,20
    80005638:	078a                	slli	a5,a5,0x2
    8000563a:	97ba                	add	a5,a5,a4
    8000563c:	fec42703          	lw	a4,-20(s0)
    80005640:	c398                	sw	a4,0(a5)
    }
    return addr;
    80005642:	fec42783          	lw	a5,-20(s0)
    80005646:	a8f5                	j	80005742 <bmap+0x172>
  }
  bn -= NDIRECT;
    80005648:	fc442783          	lw	a5,-60(s0)
    8000564c:	37d1                	addiw	a5,a5,-12
    8000564e:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    80005652:	fc442783          	lw	a5,-60(s0)
    80005656:	0007871b          	sext.w	a4,a5
    8000565a:	0ff00793          	li	a5,255
    8000565e:	0ce7ea63          	bltu	a5,a4,80005732 <bmap+0x162>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80005662:	fc843783          	ld	a5,-56(s0)
    80005666:	0807a783          	lw	a5,128(a5)
    8000566a:	fef42623          	sw	a5,-20(s0)
    8000566e:	fec42783          	lw	a5,-20(s0)
    80005672:	2781                	sext.w	a5,a5
    80005674:	eb85                	bnez	a5,800056a4 <bmap+0xd4>
      addr = balloc(ip->dev);
    80005676:	fc843783          	ld	a5,-56(s0)
    8000567a:	439c                	lw	a5,0(a5)
    8000567c:	853e                	mv	a0,a5
    8000567e:	fffff097          	auipc	ra,0xfffff
    80005682:	63c080e7          	jalr	1596(ra) # 80004cba <balloc>
    80005686:	87aa                	mv	a5,a0
    80005688:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    8000568c:	fec42783          	lw	a5,-20(s0)
    80005690:	2781                	sext.w	a5,a5
    80005692:	e399                	bnez	a5,80005698 <bmap+0xc8>
        return 0;
    80005694:	4781                	li	a5,0
    80005696:	a075                	j	80005742 <bmap+0x172>
      ip->addrs[NDIRECT] = addr;
    80005698:	fc843783          	ld	a5,-56(s0)
    8000569c:	fec42703          	lw	a4,-20(s0)
    800056a0:	08e7a023          	sw	a4,128(a5)
    }
    bp = bread(ip->dev, addr);
    800056a4:	fc843783          	ld	a5,-56(s0)
    800056a8:	439c                	lw	a5,0(a5)
    800056aa:	fec42703          	lw	a4,-20(s0)
    800056ae:	85ba                	mv	a1,a4
    800056b0:	853e                	mv	a0,a5
    800056b2:	fffff097          	auipc	ra,0xfffff
    800056b6:	2ba080e7          	jalr	698(ra) # 8000496c <bread>
    800056ba:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    800056be:	fe043783          	ld	a5,-32(s0)
    800056c2:	05878793          	addi	a5,a5,88
    800056c6:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    800056ca:	fc446783          	lwu	a5,-60(s0)
    800056ce:	078a                	slli	a5,a5,0x2
    800056d0:	fd843703          	ld	a4,-40(s0)
    800056d4:	97ba                	add	a5,a5,a4
    800056d6:	439c                	lw	a5,0(a5)
    800056d8:	fef42623          	sw	a5,-20(s0)
    800056dc:	fec42783          	lw	a5,-20(s0)
    800056e0:	2781                	sext.w	a5,a5
    800056e2:	ef9d                	bnez	a5,80005720 <bmap+0x150>
      addr = balloc(ip->dev);
    800056e4:	fc843783          	ld	a5,-56(s0)
    800056e8:	439c                	lw	a5,0(a5)
    800056ea:	853e                	mv	a0,a5
    800056ec:	fffff097          	auipc	ra,0xfffff
    800056f0:	5ce080e7          	jalr	1486(ra) # 80004cba <balloc>
    800056f4:	87aa                	mv	a5,a0
    800056f6:	fef42623          	sw	a5,-20(s0)
      if(addr){
    800056fa:	fec42783          	lw	a5,-20(s0)
    800056fe:	2781                	sext.w	a5,a5
    80005700:	c385                	beqz	a5,80005720 <bmap+0x150>
        a[bn] = addr;
    80005702:	fc446783          	lwu	a5,-60(s0)
    80005706:	078a                	slli	a5,a5,0x2
    80005708:	fd843703          	ld	a4,-40(s0)
    8000570c:	97ba                	add	a5,a5,a4
    8000570e:	fec42703          	lw	a4,-20(s0)
    80005712:	c398                	sw	a4,0(a5)
        log_write(bp);
    80005714:	fe043503          	ld	a0,-32(s0)
    80005718:	00001097          	auipc	ra,0x1
    8000571c:	f9e080e7          	jalr	-98(ra) # 800066b6 <log_write>
      }
    }
    brelse(bp);
    80005720:	fe043503          	ld	a0,-32(s0)
    80005724:	fffff097          	auipc	ra,0xfffff
    80005728:	2ee080e7          	jalr	750(ra) # 80004a12 <brelse>
    return addr;
    8000572c:	fec42783          	lw	a5,-20(s0)
    80005730:	a809                	j	80005742 <bmap+0x172>
  }

  panic("bmap: out of range");
    80005732:	00008517          	auipc	a0,0x8
    80005736:	dd650513          	addi	a0,a0,-554 # 8000d508 <etext+0x508>
    8000573a:	ffffb097          	auipc	ra,0xffffb
    8000573e:	54e080e7          	jalr	1358(ra) # 80000c88 <panic>
}
    80005742:	853e                	mv	a0,a5
    80005744:	70e2                	ld	ra,56(sp)
    80005746:	7442                	ld	s0,48(sp)
    80005748:	6121                	addi	sp,sp,64
    8000574a:	8082                	ret

000000008000574c <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    8000574c:	7139                	addi	sp,sp,-64
    8000574e:	fc06                	sd	ra,56(sp)
    80005750:	f822                	sd	s0,48(sp)
    80005752:	0080                	addi	s0,sp,64
    80005754:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80005758:	fe042623          	sw	zero,-20(s0)
    8000575c:	a899                	j	800057b2 <itrunc+0x66>
    if(ip->addrs[i]){
    8000575e:	fc843703          	ld	a4,-56(s0)
    80005762:	fec42783          	lw	a5,-20(s0)
    80005766:	07d1                	addi	a5,a5,20
    80005768:	078a                	slli	a5,a5,0x2
    8000576a:	97ba                	add	a5,a5,a4
    8000576c:	439c                	lw	a5,0(a5)
    8000576e:	cf8d                	beqz	a5,800057a8 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    80005770:	fc843783          	ld	a5,-56(s0)
    80005774:	439c                	lw	a5,0(a5)
    80005776:	0007869b          	sext.w	a3,a5
    8000577a:	fc843703          	ld	a4,-56(s0)
    8000577e:	fec42783          	lw	a5,-20(s0)
    80005782:	07d1                	addi	a5,a5,20
    80005784:	078a                	slli	a5,a5,0x2
    80005786:	97ba                	add	a5,a5,a4
    80005788:	439c                	lw	a5,0(a5)
    8000578a:	85be                	mv	a1,a5
    8000578c:	8536                	mv	a0,a3
    8000578e:	fffff097          	auipc	ra,0xfffff
    80005792:	6d4080e7          	jalr	1748(ra) # 80004e62 <bfree>
      ip->addrs[i] = 0;
    80005796:	fc843703          	ld	a4,-56(s0)
    8000579a:	fec42783          	lw	a5,-20(s0)
    8000579e:	07d1                	addi	a5,a5,20
    800057a0:	078a                	slli	a5,a5,0x2
    800057a2:	97ba                	add	a5,a5,a4
    800057a4:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    800057a8:	fec42783          	lw	a5,-20(s0)
    800057ac:	2785                	addiw	a5,a5,1
    800057ae:	fef42623          	sw	a5,-20(s0)
    800057b2:	fec42783          	lw	a5,-20(s0)
    800057b6:	0007871b          	sext.w	a4,a5
    800057ba:	47ad                	li	a5,11
    800057bc:	fae7d1e3          	bge	a5,a4,8000575e <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    800057c0:	fc843783          	ld	a5,-56(s0)
    800057c4:	0807a783          	lw	a5,128(a5)
    800057c8:	cbc5                	beqz	a5,80005878 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800057ca:	fc843783          	ld	a5,-56(s0)
    800057ce:	4398                	lw	a4,0(a5)
    800057d0:	fc843783          	ld	a5,-56(s0)
    800057d4:	0807a783          	lw	a5,128(a5)
    800057d8:	85be                	mv	a1,a5
    800057da:	853a                	mv	a0,a4
    800057dc:	fffff097          	auipc	ra,0xfffff
    800057e0:	190080e7          	jalr	400(ra) # 8000496c <bread>
    800057e4:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    800057e8:	fe043783          	ld	a5,-32(s0)
    800057ec:	05878793          	addi	a5,a5,88
    800057f0:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    800057f4:	fe042423          	sw	zero,-24(s0)
    800057f8:	a081                	j	80005838 <itrunc+0xec>
      if(a[j])
    800057fa:	fe842783          	lw	a5,-24(s0)
    800057fe:	078a                	slli	a5,a5,0x2
    80005800:	fd843703          	ld	a4,-40(s0)
    80005804:	97ba                	add	a5,a5,a4
    80005806:	439c                	lw	a5,0(a5)
    80005808:	c39d                	beqz	a5,8000582e <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    8000580a:	fc843783          	ld	a5,-56(s0)
    8000580e:	439c                	lw	a5,0(a5)
    80005810:	0007869b          	sext.w	a3,a5
    80005814:	fe842783          	lw	a5,-24(s0)
    80005818:	078a                	slli	a5,a5,0x2
    8000581a:	fd843703          	ld	a4,-40(s0)
    8000581e:	97ba                	add	a5,a5,a4
    80005820:	439c                	lw	a5,0(a5)
    80005822:	85be                	mv	a1,a5
    80005824:	8536                	mv	a0,a3
    80005826:	fffff097          	auipc	ra,0xfffff
    8000582a:	63c080e7          	jalr	1596(ra) # 80004e62 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    8000582e:	fe842783          	lw	a5,-24(s0)
    80005832:	2785                	addiw	a5,a5,1
    80005834:	fef42423          	sw	a5,-24(s0)
    80005838:	fe842783          	lw	a5,-24(s0)
    8000583c:	873e                	mv	a4,a5
    8000583e:	0ff00793          	li	a5,255
    80005842:	fae7fce3          	bgeu	a5,a4,800057fa <itrunc+0xae>
    }
    brelse(bp);
    80005846:	fe043503          	ld	a0,-32(s0)
    8000584a:	fffff097          	auipc	ra,0xfffff
    8000584e:	1c8080e7          	jalr	456(ra) # 80004a12 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80005852:	fc843783          	ld	a5,-56(s0)
    80005856:	439c                	lw	a5,0(a5)
    80005858:	0007871b          	sext.w	a4,a5
    8000585c:	fc843783          	ld	a5,-56(s0)
    80005860:	0807a783          	lw	a5,128(a5)
    80005864:	85be                	mv	a1,a5
    80005866:	853a                	mv	a0,a4
    80005868:	fffff097          	auipc	ra,0xfffff
    8000586c:	5fa080e7          	jalr	1530(ra) # 80004e62 <bfree>
    ip->addrs[NDIRECT] = 0;
    80005870:	fc843783          	ld	a5,-56(s0)
    80005874:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80005878:	fc843783          	ld	a5,-56(s0)
    8000587c:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    80005880:	fc843503          	ld	a0,-56(s0)
    80005884:	00000097          	auipc	ra,0x0
    80005888:	870080e7          	jalr	-1936(ra) # 800050f4 <iupdate>
}
    8000588c:	0001                	nop
    8000588e:	70e2                	ld	ra,56(sp)
    80005890:	7442                	ld	s0,48(sp)
    80005892:	6121                	addi	sp,sp,64
    80005894:	8082                	ret

0000000080005896 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80005896:	1101                	addi	sp,sp,-32
    80005898:	ec22                	sd	s0,24(sp)
    8000589a:	1000                	addi	s0,sp,32
    8000589c:	fea43423          	sd	a0,-24(s0)
    800058a0:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    800058a4:	fe843783          	ld	a5,-24(s0)
    800058a8:	439c                	lw	a5,0(a5)
    800058aa:	0007871b          	sext.w	a4,a5
    800058ae:	fe043783          	ld	a5,-32(s0)
    800058b2:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    800058b4:	fe843783          	ld	a5,-24(s0)
    800058b8:	43d8                	lw	a4,4(a5)
    800058ba:	fe043783          	ld	a5,-32(s0)
    800058be:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    800058c0:	fe843783          	ld	a5,-24(s0)
    800058c4:	04479703          	lh	a4,68(a5)
    800058c8:	fe043783          	ld	a5,-32(s0)
    800058cc:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    800058d0:	fe843783          	ld	a5,-24(s0)
    800058d4:	04a79703          	lh	a4,74(a5)
    800058d8:	fe043783          	ld	a5,-32(s0)
    800058dc:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    800058e0:	fe843783          	ld	a5,-24(s0)
    800058e4:	47fc                	lw	a5,76(a5)
    800058e6:	02079713          	slli	a4,a5,0x20
    800058ea:	9301                	srli	a4,a4,0x20
    800058ec:	fe043783          	ld	a5,-32(s0)
    800058f0:	eb98                	sd	a4,16(a5)
}
    800058f2:	0001                	nop
    800058f4:	6462                	ld	s0,24(sp)
    800058f6:	6105                	addi	sp,sp,32
    800058f8:	8082                	ret

00000000800058fa <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    800058fa:	715d                	addi	sp,sp,-80
    800058fc:	e486                	sd	ra,72(sp)
    800058fe:	e0a2                	sd	s0,64(sp)
    80005900:	0880                	addi	s0,sp,80
    80005902:	fca43423          	sd	a0,-56(s0)
    80005906:	87ae                	mv	a5,a1
    80005908:	fac43c23          	sd	a2,-72(s0)
    8000590c:	fcf42223          	sw	a5,-60(s0)
    80005910:	87b6                	mv	a5,a3
    80005912:	fcf42023          	sw	a5,-64(s0)
    80005916:	87ba                	mv	a5,a4
    80005918:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000591c:	fc843783          	ld	a5,-56(s0)
    80005920:	47f8                	lw	a4,76(a5)
    80005922:	fc042783          	lw	a5,-64(s0)
    80005926:	2781                	sext.w	a5,a5
    80005928:	00f76f63          	bltu	a4,a5,80005946 <readi+0x4c>
    8000592c:	fc042783          	lw	a5,-64(s0)
    80005930:	873e                	mv	a4,a5
    80005932:	fb442783          	lw	a5,-76(s0)
    80005936:	9fb9                	addw	a5,a5,a4
    80005938:	0007871b          	sext.w	a4,a5
    8000593c:	fc042783          	lw	a5,-64(s0)
    80005940:	2781                	sext.w	a5,a5
    80005942:	00f77463          	bgeu	a4,a5,8000594a <readi+0x50>
    return 0;
    80005946:	4781                	li	a5,0
    80005948:	a299                	j	80005a8e <readi+0x194>
  if(off + n > ip->size)
    8000594a:	fc042783          	lw	a5,-64(s0)
    8000594e:	873e                	mv	a4,a5
    80005950:	fb442783          	lw	a5,-76(s0)
    80005954:	9fb9                	addw	a5,a5,a4
    80005956:	0007871b          	sext.w	a4,a5
    8000595a:	fc843783          	ld	a5,-56(s0)
    8000595e:	47fc                	lw	a5,76(a5)
    80005960:	00e7fa63          	bgeu	a5,a4,80005974 <readi+0x7a>
    n = ip->size - off;
    80005964:	fc843783          	ld	a5,-56(s0)
    80005968:	47fc                	lw	a5,76(a5)
    8000596a:	fc042703          	lw	a4,-64(s0)
    8000596e:	9f99                	subw	a5,a5,a4
    80005970:	faf42a23          	sw	a5,-76(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005974:	fe042623          	sw	zero,-20(s0)
    80005978:	a8f5                	j	80005a74 <readi+0x17a>
    uint addr = bmap(ip, off/BSIZE);
    8000597a:	fc042783          	lw	a5,-64(s0)
    8000597e:	00a7d79b          	srliw	a5,a5,0xa
    80005982:	2781                	sext.w	a5,a5
    80005984:	85be                	mv	a1,a5
    80005986:	fc843503          	ld	a0,-56(s0)
    8000598a:	00000097          	auipc	ra,0x0
    8000598e:	c46080e7          	jalr	-954(ra) # 800055d0 <bmap>
    80005992:	87aa                	mv	a5,a0
    80005994:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    80005998:	fe842783          	lw	a5,-24(s0)
    8000599c:	2781                	sext.w	a5,a5
    8000599e:	c7ed                	beqz	a5,80005a88 <readi+0x18e>
      break;
    bp = bread(ip->dev, addr);
    800059a0:	fc843783          	ld	a5,-56(s0)
    800059a4:	439c                	lw	a5,0(a5)
    800059a6:	fe842703          	lw	a4,-24(s0)
    800059aa:	85ba                	mv	a1,a4
    800059ac:	853e                	mv	a0,a5
    800059ae:	fffff097          	auipc	ra,0xfffff
    800059b2:	fbe080e7          	jalr	-66(ra) # 8000496c <bread>
    800059b6:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    800059ba:	fc042783          	lw	a5,-64(s0)
    800059be:	3ff7f793          	andi	a5,a5,1023
    800059c2:	2781                	sext.w	a5,a5
    800059c4:	40000713          	li	a4,1024
    800059c8:	40f707bb          	subw	a5,a4,a5
    800059cc:	2781                	sext.w	a5,a5
    800059ce:	fb442703          	lw	a4,-76(s0)
    800059d2:	86ba                	mv	a3,a4
    800059d4:	fec42703          	lw	a4,-20(s0)
    800059d8:	40e6873b          	subw	a4,a3,a4
    800059dc:	2701                	sext.w	a4,a4
    800059de:	863a                	mv	a2,a4
    800059e0:	0007869b          	sext.w	a3,a5
    800059e4:	0006071b          	sext.w	a4,a2
    800059e8:	00d77363          	bgeu	a4,a3,800059ee <readi+0xf4>
    800059ec:	87b2                	mv	a5,a2
    800059ee:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800059f2:	fe043783          	ld	a5,-32(s0)
    800059f6:	05878713          	addi	a4,a5,88
    800059fa:	fc046783          	lwu	a5,-64(s0)
    800059fe:	3ff7f793          	andi	a5,a5,1023
    80005a02:	973e                	add	a4,a4,a5
    80005a04:	fdc46683          	lwu	a3,-36(s0)
    80005a08:	fc442783          	lw	a5,-60(s0)
    80005a0c:	863a                	mv	a2,a4
    80005a0e:	fb843583          	ld	a1,-72(s0)
    80005a12:	853e                	mv	a0,a5
    80005a14:	ffffe097          	auipc	ra,0xffffe
    80005a18:	f02080e7          	jalr	-254(ra) # 80003916 <either_copyout>
    80005a1c:	87aa                	mv	a5,a0
    80005a1e:	873e                	mv	a4,a5
    80005a20:	57fd                	li	a5,-1
    80005a22:	00f71c63          	bne	a4,a5,80005a3a <readi+0x140>
      brelse(bp);
    80005a26:	fe043503          	ld	a0,-32(s0)
    80005a2a:	fffff097          	auipc	ra,0xfffff
    80005a2e:	fe8080e7          	jalr	-24(ra) # 80004a12 <brelse>
      tot = -1;
    80005a32:	57fd                	li	a5,-1
    80005a34:	fef42623          	sw	a5,-20(s0)
      break;
    80005a38:	a889                	j	80005a8a <readi+0x190>
    }
    brelse(bp);
    80005a3a:	fe043503          	ld	a0,-32(s0)
    80005a3e:	fffff097          	auipc	ra,0xfffff
    80005a42:	fd4080e7          	jalr	-44(ra) # 80004a12 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005a46:	fec42783          	lw	a5,-20(s0)
    80005a4a:	873e                	mv	a4,a5
    80005a4c:	fdc42783          	lw	a5,-36(s0)
    80005a50:	9fb9                	addw	a5,a5,a4
    80005a52:	fef42623          	sw	a5,-20(s0)
    80005a56:	fc042783          	lw	a5,-64(s0)
    80005a5a:	873e                	mv	a4,a5
    80005a5c:	fdc42783          	lw	a5,-36(s0)
    80005a60:	9fb9                	addw	a5,a5,a4
    80005a62:	fcf42023          	sw	a5,-64(s0)
    80005a66:	fdc46783          	lwu	a5,-36(s0)
    80005a6a:	fb843703          	ld	a4,-72(s0)
    80005a6e:	97ba                	add	a5,a5,a4
    80005a70:	faf43c23          	sd	a5,-72(s0)
    80005a74:	fec42783          	lw	a5,-20(s0)
    80005a78:	873e                	mv	a4,a5
    80005a7a:	fb442783          	lw	a5,-76(s0)
    80005a7e:	2701                	sext.w	a4,a4
    80005a80:	2781                	sext.w	a5,a5
    80005a82:	eef76ce3          	bltu	a4,a5,8000597a <readi+0x80>
    80005a86:	a011                	j	80005a8a <readi+0x190>
      break;
    80005a88:	0001                	nop
  }
  return tot;
    80005a8a:	fec42783          	lw	a5,-20(s0)
}
    80005a8e:	853e                	mv	a0,a5
    80005a90:	60a6                	ld	ra,72(sp)
    80005a92:	6406                	ld	s0,64(sp)
    80005a94:	6161                	addi	sp,sp,80
    80005a96:	8082                	ret

0000000080005a98 <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80005a98:	715d                	addi	sp,sp,-80
    80005a9a:	e486                	sd	ra,72(sp)
    80005a9c:	e0a2                	sd	s0,64(sp)
    80005a9e:	0880                	addi	s0,sp,80
    80005aa0:	fca43423          	sd	a0,-56(s0)
    80005aa4:	87ae                	mv	a5,a1
    80005aa6:	fac43c23          	sd	a2,-72(s0)
    80005aaa:	fcf42223          	sw	a5,-60(s0)
    80005aae:	87b6                	mv	a5,a3
    80005ab0:	fcf42023          	sw	a5,-64(s0)
    80005ab4:	87ba                	mv	a5,a4
    80005ab6:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80005aba:	fc843783          	ld	a5,-56(s0)
    80005abe:	47f8                	lw	a4,76(a5)
    80005ac0:	fc042783          	lw	a5,-64(s0)
    80005ac4:	2781                	sext.w	a5,a5
    80005ac6:	00f76f63          	bltu	a4,a5,80005ae4 <writei+0x4c>
    80005aca:	fc042783          	lw	a5,-64(s0)
    80005ace:	873e                	mv	a4,a5
    80005ad0:	fb442783          	lw	a5,-76(s0)
    80005ad4:	9fb9                	addw	a5,a5,a4
    80005ad6:	0007871b          	sext.w	a4,a5
    80005ada:	fc042783          	lw	a5,-64(s0)
    80005ade:	2781                	sext.w	a5,a5
    80005ae0:	00f77463          	bgeu	a4,a5,80005ae8 <writei+0x50>
    return -1;
    80005ae4:	57fd                	li	a5,-1
    80005ae6:	a295                	j	80005c4a <writei+0x1b2>
  if(off + n > MAXFILE*BSIZE)
    80005ae8:	fc042783          	lw	a5,-64(s0)
    80005aec:	873e                	mv	a4,a5
    80005aee:	fb442783          	lw	a5,-76(s0)
    80005af2:	9fb9                	addw	a5,a5,a4
    80005af4:	2781                	sext.w	a5,a5
    80005af6:	873e                	mv	a4,a5
    80005af8:	000437b7          	lui	a5,0x43
    80005afc:	00e7f463          	bgeu	a5,a4,80005b04 <writei+0x6c>
    return -1;
    80005b00:	57fd                	li	a5,-1
    80005b02:	a2a1                	j	80005c4a <writei+0x1b2>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005b04:	fe042623          	sw	zero,-20(s0)
    80005b08:	a209                	j	80005c0a <writei+0x172>
    uint addr = bmap(ip, off/BSIZE);
    80005b0a:	fc042783          	lw	a5,-64(s0)
    80005b0e:	00a7d79b          	srliw	a5,a5,0xa
    80005b12:	2781                	sext.w	a5,a5
    80005b14:	85be                	mv	a1,a5
    80005b16:	fc843503          	ld	a0,-56(s0)
    80005b1a:	00000097          	auipc	ra,0x0
    80005b1e:	ab6080e7          	jalr	-1354(ra) # 800055d0 <bmap>
    80005b22:	87aa                	mv	a5,a0
    80005b24:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    80005b28:	fe842783          	lw	a5,-24(s0)
    80005b2c:	2781                	sext.w	a5,a5
    80005b2e:	cbe5                	beqz	a5,80005c1e <writei+0x186>
      break;
    bp = bread(ip->dev, addr);
    80005b30:	fc843783          	ld	a5,-56(s0)
    80005b34:	439c                	lw	a5,0(a5)
    80005b36:	fe842703          	lw	a4,-24(s0)
    80005b3a:	85ba                	mv	a1,a4
    80005b3c:	853e                	mv	a0,a5
    80005b3e:	fffff097          	auipc	ra,0xfffff
    80005b42:	e2e080e7          	jalr	-466(ra) # 8000496c <bread>
    80005b46:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005b4a:	fc042783          	lw	a5,-64(s0)
    80005b4e:	3ff7f793          	andi	a5,a5,1023
    80005b52:	2781                	sext.w	a5,a5
    80005b54:	40000713          	li	a4,1024
    80005b58:	40f707bb          	subw	a5,a4,a5
    80005b5c:	2781                	sext.w	a5,a5
    80005b5e:	fb442703          	lw	a4,-76(s0)
    80005b62:	86ba                	mv	a3,a4
    80005b64:	fec42703          	lw	a4,-20(s0)
    80005b68:	40e6873b          	subw	a4,a3,a4
    80005b6c:	2701                	sext.w	a4,a4
    80005b6e:	863a                	mv	a2,a4
    80005b70:	0007869b          	sext.w	a3,a5
    80005b74:	0006071b          	sext.w	a4,a2
    80005b78:	00d77363          	bgeu	a4,a3,80005b7e <writei+0xe6>
    80005b7c:	87b2                	mv	a5,a2
    80005b7e:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80005b82:	fe043783          	ld	a5,-32(s0)
    80005b86:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    80005b8a:	fc046783          	lwu	a5,-64(s0)
    80005b8e:	3ff7f793          	andi	a5,a5,1023
    80005b92:	97ba                	add	a5,a5,a4
    80005b94:	fdc46683          	lwu	a3,-36(s0)
    80005b98:	fc442703          	lw	a4,-60(s0)
    80005b9c:	fb843603          	ld	a2,-72(s0)
    80005ba0:	85ba                	mv	a1,a4
    80005ba2:	853e                	mv	a0,a5
    80005ba4:	ffffe097          	auipc	ra,0xffffe
    80005ba8:	de6080e7          	jalr	-538(ra) # 8000398a <either_copyin>
    80005bac:	87aa                	mv	a5,a0
    80005bae:	873e                	mv	a4,a5
    80005bb0:	57fd                	li	a5,-1
    80005bb2:	00f71963          	bne	a4,a5,80005bc4 <writei+0x12c>
      brelse(bp);
    80005bb6:	fe043503          	ld	a0,-32(s0)
    80005bba:	fffff097          	auipc	ra,0xfffff
    80005bbe:	e58080e7          	jalr	-424(ra) # 80004a12 <brelse>
      break;
    80005bc2:	a8b9                	j	80005c20 <writei+0x188>
    }
    log_write(bp);
    80005bc4:	fe043503          	ld	a0,-32(s0)
    80005bc8:	00001097          	auipc	ra,0x1
    80005bcc:	aee080e7          	jalr	-1298(ra) # 800066b6 <log_write>
    brelse(bp);
    80005bd0:	fe043503          	ld	a0,-32(s0)
    80005bd4:	fffff097          	auipc	ra,0xfffff
    80005bd8:	e3e080e7          	jalr	-450(ra) # 80004a12 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005bdc:	fec42783          	lw	a5,-20(s0)
    80005be0:	873e                	mv	a4,a5
    80005be2:	fdc42783          	lw	a5,-36(s0)
    80005be6:	9fb9                	addw	a5,a5,a4
    80005be8:	fef42623          	sw	a5,-20(s0)
    80005bec:	fc042783          	lw	a5,-64(s0)
    80005bf0:	873e                	mv	a4,a5
    80005bf2:	fdc42783          	lw	a5,-36(s0)
    80005bf6:	9fb9                	addw	a5,a5,a4
    80005bf8:	fcf42023          	sw	a5,-64(s0)
    80005bfc:	fdc46783          	lwu	a5,-36(s0)
    80005c00:	fb843703          	ld	a4,-72(s0)
    80005c04:	97ba                	add	a5,a5,a4
    80005c06:	faf43c23          	sd	a5,-72(s0)
    80005c0a:	fec42783          	lw	a5,-20(s0)
    80005c0e:	873e                	mv	a4,a5
    80005c10:	fb442783          	lw	a5,-76(s0)
    80005c14:	2701                	sext.w	a4,a4
    80005c16:	2781                	sext.w	a5,a5
    80005c18:	eef769e3          	bltu	a4,a5,80005b0a <writei+0x72>
    80005c1c:	a011                	j	80005c20 <writei+0x188>
      break;
    80005c1e:	0001                	nop
  }

  if(off > ip->size)
    80005c20:	fc843783          	ld	a5,-56(s0)
    80005c24:	47f8                	lw	a4,76(a5)
    80005c26:	fc042783          	lw	a5,-64(s0)
    80005c2a:	2781                	sext.w	a5,a5
    80005c2c:	00f77763          	bgeu	a4,a5,80005c3a <writei+0x1a2>
    ip->size = off;
    80005c30:	fc843783          	ld	a5,-56(s0)
    80005c34:	fc042703          	lw	a4,-64(s0)
    80005c38:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80005c3a:	fc843503          	ld	a0,-56(s0)
    80005c3e:	fffff097          	auipc	ra,0xfffff
    80005c42:	4b6080e7          	jalr	1206(ra) # 800050f4 <iupdate>

  return tot;
    80005c46:	fec42783          	lw	a5,-20(s0)
}
    80005c4a:	853e                	mv	a0,a5
    80005c4c:	60a6                	ld	ra,72(sp)
    80005c4e:	6406                	ld	s0,64(sp)
    80005c50:	6161                	addi	sp,sp,80
    80005c52:	8082                	ret

0000000080005c54 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80005c54:	1101                	addi	sp,sp,-32
    80005c56:	ec06                	sd	ra,24(sp)
    80005c58:	e822                	sd	s0,16(sp)
    80005c5a:	1000                	addi	s0,sp,32
    80005c5c:	fea43423          	sd	a0,-24(s0)
    80005c60:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    80005c64:	4639                	li	a2,14
    80005c66:	fe043583          	ld	a1,-32(s0)
    80005c6a:	fe843503          	ld	a0,-24(s0)
    80005c6e:	ffffc097          	auipc	ra,0xffffc
    80005c72:	a8e080e7          	jalr	-1394(ra) # 800016fc <strncmp>
    80005c76:	87aa                	mv	a5,a0
}
    80005c78:	853e                	mv	a0,a5
    80005c7a:	60e2                	ld	ra,24(sp)
    80005c7c:	6442                	ld	s0,16(sp)
    80005c7e:	6105                	addi	sp,sp,32
    80005c80:	8082                	ret

0000000080005c82 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80005c82:	715d                	addi	sp,sp,-80
    80005c84:	e486                	sd	ra,72(sp)
    80005c86:	e0a2                	sd	s0,64(sp)
    80005c88:	0880                	addi	s0,sp,80
    80005c8a:	fca43423          	sd	a0,-56(s0)
    80005c8e:	fcb43023          	sd	a1,-64(s0)
    80005c92:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80005c96:	fc843783          	ld	a5,-56(s0)
    80005c9a:	04479783          	lh	a5,68(a5)
    80005c9e:	873e                	mv	a4,a5
    80005ca0:	4785                	li	a5,1
    80005ca2:	00f70a63          	beq	a4,a5,80005cb6 <dirlookup+0x34>
    panic("dirlookup not DIR");
    80005ca6:	00008517          	auipc	a0,0x8
    80005caa:	87a50513          	addi	a0,a0,-1926 # 8000d520 <etext+0x520>
    80005cae:	ffffb097          	auipc	ra,0xffffb
    80005cb2:	fda080e7          	jalr	-38(ra) # 80000c88 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    80005cb6:	fe042623          	sw	zero,-20(s0)
    80005cba:	a849                	j	80005d4c <dirlookup+0xca>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005cbc:	fd840793          	addi	a5,s0,-40
    80005cc0:	fec42683          	lw	a3,-20(s0)
    80005cc4:	4741                	li	a4,16
    80005cc6:	863e                	mv	a2,a5
    80005cc8:	4581                	li	a1,0
    80005cca:	fc843503          	ld	a0,-56(s0)
    80005cce:	00000097          	auipc	ra,0x0
    80005cd2:	c2c080e7          	jalr	-980(ra) # 800058fa <readi>
    80005cd6:	87aa                	mv	a5,a0
    80005cd8:	873e                	mv	a4,a5
    80005cda:	47c1                	li	a5,16
    80005cdc:	00f70a63          	beq	a4,a5,80005cf0 <dirlookup+0x6e>
      panic("dirlookup read");
    80005ce0:	00008517          	auipc	a0,0x8
    80005ce4:	85850513          	addi	a0,a0,-1960 # 8000d538 <etext+0x538>
    80005ce8:	ffffb097          	auipc	ra,0xffffb
    80005cec:	fa0080e7          	jalr	-96(ra) # 80000c88 <panic>
    if(de.inum == 0)
    80005cf0:	fd845783          	lhu	a5,-40(s0)
    80005cf4:	c7b1                	beqz	a5,80005d40 <dirlookup+0xbe>
      continue;
    if(namecmp(name, de.name) == 0){
    80005cf6:	fd840793          	addi	a5,s0,-40
    80005cfa:	0789                	addi	a5,a5,2
    80005cfc:	85be                	mv	a1,a5
    80005cfe:	fc043503          	ld	a0,-64(s0)
    80005d02:	00000097          	auipc	ra,0x0
    80005d06:	f52080e7          	jalr	-174(ra) # 80005c54 <namecmp>
    80005d0a:	87aa                	mv	a5,a0
    80005d0c:	eb9d                	bnez	a5,80005d42 <dirlookup+0xc0>
      // entry matches path element
      if(poff)
    80005d0e:	fb843783          	ld	a5,-72(s0)
    80005d12:	c791                	beqz	a5,80005d1e <dirlookup+0x9c>
        *poff = off;
    80005d14:	fb843783          	ld	a5,-72(s0)
    80005d18:	fec42703          	lw	a4,-20(s0)
    80005d1c:	c398                	sw	a4,0(a5)
      inum = de.inum;
    80005d1e:	fd845783          	lhu	a5,-40(s0)
    80005d22:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    80005d26:	fc843783          	ld	a5,-56(s0)
    80005d2a:	439c                	lw	a5,0(a5)
    80005d2c:	fe842703          	lw	a4,-24(s0)
    80005d30:	85ba                	mv	a1,a4
    80005d32:	853e                	mv	a0,a5
    80005d34:	fffff097          	auipc	ra,0xfffff
    80005d38:	4a8080e7          	jalr	1192(ra) # 800051dc <iget>
    80005d3c:	87aa                	mv	a5,a0
    80005d3e:	a005                	j	80005d5e <dirlookup+0xdc>
      continue;
    80005d40:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005d42:	fec42783          	lw	a5,-20(s0)
    80005d46:	27c1                	addiw	a5,a5,16
    80005d48:	fef42623          	sw	a5,-20(s0)
    80005d4c:	fc843783          	ld	a5,-56(s0)
    80005d50:	47f8                	lw	a4,76(a5)
    80005d52:	fec42783          	lw	a5,-20(s0)
    80005d56:	2781                	sext.w	a5,a5
    80005d58:	f6e7e2e3          	bltu	a5,a4,80005cbc <dirlookup+0x3a>
    }
  }

  return 0;
    80005d5c:	4781                	li	a5,0
}
    80005d5e:	853e                	mv	a0,a5
    80005d60:	60a6                	ld	ra,72(sp)
    80005d62:	6406                	ld	s0,64(sp)
    80005d64:	6161                	addi	sp,sp,80
    80005d66:	8082                	ret

0000000080005d68 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
// Returns 0 on success, -1 on failure (e.g. out of disk blocks).
int
dirlink(struct inode *dp, char *name, uint inum)
{
    80005d68:	715d                	addi	sp,sp,-80
    80005d6a:	e486                	sd	ra,72(sp)
    80005d6c:	e0a2                	sd	s0,64(sp)
    80005d6e:	0880                	addi	s0,sp,80
    80005d70:	fca43423          	sd	a0,-56(s0)
    80005d74:	fcb43023          	sd	a1,-64(s0)
    80005d78:	87b2                	mv	a5,a2
    80005d7a:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    80005d7e:	4601                	li	a2,0
    80005d80:	fc043583          	ld	a1,-64(s0)
    80005d84:	fc843503          	ld	a0,-56(s0)
    80005d88:	00000097          	auipc	ra,0x0
    80005d8c:	efa080e7          	jalr	-262(ra) # 80005c82 <dirlookup>
    80005d90:	fea43023          	sd	a0,-32(s0)
    80005d94:	fe043783          	ld	a5,-32(s0)
    80005d98:	cb89                	beqz	a5,80005daa <dirlink+0x42>
    iput(ip);
    80005d9a:	fe043503          	ld	a0,-32(s0)
    80005d9e:	fffff097          	auipc	ra,0xfffff
    80005da2:	734080e7          	jalr	1844(ra) # 800054d2 <iput>
    return -1;
    80005da6:	57fd                	li	a5,-1
    80005da8:	a075                	j	80005e54 <dirlink+0xec>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005daa:	fe042623          	sw	zero,-20(s0)
    80005dae:	a0a1                	j	80005df6 <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005db0:	fd040793          	addi	a5,s0,-48
    80005db4:	fec42683          	lw	a3,-20(s0)
    80005db8:	4741                	li	a4,16
    80005dba:	863e                	mv	a2,a5
    80005dbc:	4581                	li	a1,0
    80005dbe:	fc843503          	ld	a0,-56(s0)
    80005dc2:	00000097          	auipc	ra,0x0
    80005dc6:	b38080e7          	jalr	-1224(ra) # 800058fa <readi>
    80005dca:	87aa                	mv	a5,a0
    80005dcc:	873e                	mv	a4,a5
    80005dce:	47c1                	li	a5,16
    80005dd0:	00f70a63          	beq	a4,a5,80005de4 <dirlink+0x7c>
      panic("dirlink read");
    80005dd4:	00007517          	auipc	a0,0x7
    80005dd8:	77450513          	addi	a0,a0,1908 # 8000d548 <etext+0x548>
    80005ddc:	ffffb097          	auipc	ra,0xffffb
    80005de0:	eac080e7          	jalr	-340(ra) # 80000c88 <panic>
    if(de.inum == 0)
    80005de4:	fd045783          	lhu	a5,-48(s0)
    80005de8:	cf99                	beqz	a5,80005e06 <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005dea:	fec42783          	lw	a5,-20(s0)
    80005dee:	27c1                	addiw	a5,a5,16
    80005df0:	2781                	sext.w	a5,a5
    80005df2:	fef42623          	sw	a5,-20(s0)
    80005df6:	fc843783          	ld	a5,-56(s0)
    80005dfa:	47f8                	lw	a4,76(a5)
    80005dfc:	fec42783          	lw	a5,-20(s0)
    80005e00:	fae7e8e3          	bltu	a5,a4,80005db0 <dirlink+0x48>
    80005e04:	a011                	j	80005e08 <dirlink+0xa0>
      break;
    80005e06:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    80005e08:	fd040793          	addi	a5,s0,-48
    80005e0c:	0789                	addi	a5,a5,2
    80005e0e:	4639                	li	a2,14
    80005e10:	fc043583          	ld	a1,-64(s0)
    80005e14:	853e                	mv	a0,a5
    80005e16:	ffffc097          	auipc	ra,0xffffc
    80005e1a:	970080e7          	jalr	-1680(ra) # 80001786 <strncpy>
  de.inum = inum;
    80005e1e:	fbc42783          	lw	a5,-68(s0)
    80005e22:	17c2                	slli	a5,a5,0x30
    80005e24:	93c1                	srli	a5,a5,0x30
    80005e26:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005e2a:	fd040793          	addi	a5,s0,-48
    80005e2e:	fec42683          	lw	a3,-20(s0)
    80005e32:	4741                	li	a4,16
    80005e34:	863e                	mv	a2,a5
    80005e36:	4581                	li	a1,0
    80005e38:	fc843503          	ld	a0,-56(s0)
    80005e3c:	00000097          	auipc	ra,0x0
    80005e40:	c5c080e7          	jalr	-932(ra) # 80005a98 <writei>
    80005e44:	87aa                	mv	a5,a0
    80005e46:	873e                	mv	a4,a5
    80005e48:	47c1                	li	a5,16
    80005e4a:	00f70463          	beq	a4,a5,80005e52 <dirlink+0xea>
    return -1;
    80005e4e:	57fd                	li	a5,-1
    80005e50:	a011                	j	80005e54 <dirlink+0xec>

  return 0;
    80005e52:	4781                	li	a5,0
}
    80005e54:	853e                	mv	a0,a5
    80005e56:	60a6                	ld	ra,72(sp)
    80005e58:	6406                	ld	s0,64(sp)
    80005e5a:	6161                	addi	sp,sp,80
    80005e5c:	8082                	ret

0000000080005e5e <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    80005e5e:	7179                	addi	sp,sp,-48
    80005e60:	f406                	sd	ra,40(sp)
    80005e62:	f022                	sd	s0,32(sp)
    80005e64:	1800                	addi	s0,sp,48
    80005e66:	fca43c23          	sd	a0,-40(s0)
    80005e6a:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    80005e6e:	a031                	j	80005e7a <skipelem+0x1c>
    path++;
    80005e70:	fd843783          	ld	a5,-40(s0)
    80005e74:	0785                	addi	a5,a5,1
    80005e76:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005e7a:	fd843783          	ld	a5,-40(s0)
    80005e7e:	0007c783          	lbu	a5,0(a5)
    80005e82:	873e                	mv	a4,a5
    80005e84:	02f00793          	li	a5,47
    80005e88:	fef704e3          	beq	a4,a5,80005e70 <skipelem+0x12>
  if(*path == 0)
    80005e8c:	fd843783          	ld	a5,-40(s0)
    80005e90:	0007c783          	lbu	a5,0(a5)
    80005e94:	e399                	bnez	a5,80005e9a <skipelem+0x3c>
    return 0;
    80005e96:	4781                	li	a5,0
    80005e98:	a06d                	j	80005f42 <skipelem+0xe4>
  s = path;
    80005e9a:	fd843783          	ld	a5,-40(s0)
    80005e9e:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    80005ea2:	a031                	j	80005eae <skipelem+0x50>
    path++;
    80005ea4:	fd843783          	ld	a5,-40(s0)
    80005ea8:	0785                	addi	a5,a5,1
    80005eaa:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    80005eae:	fd843783          	ld	a5,-40(s0)
    80005eb2:	0007c783          	lbu	a5,0(a5)
    80005eb6:	873e                	mv	a4,a5
    80005eb8:	02f00793          	li	a5,47
    80005ebc:	00f70763          	beq	a4,a5,80005eca <skipelem+0x6c>
    80005ec0:	fd843783          	ld	a5,-40(s0)
    80005ec4:	0007c783          	lbu	a5,0(a5)
    80005ec8:	fff1                	bnez	a5,80005ea4 <skipelem+0x46>
  len = path - s;
    80005eca:	fd843703          	ld	a4,-40(s0)
    80005ece:	fe843783          	ld	a5,-24(s0)
    80005ed2:	40f707b3          	sub	a5,a4,a5
    80005ed6:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80005eda:	fe442783          	lw	a5,-28(s0)
    80005ede:	0007871b          	sext.w	a4,a5
    80005ee2:	47b5                	li	a5,13
    80005ee4:	00e7dc63          	bge	a5,a4,80005efc <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    80005ee8:	4639                	li	a2,14
    80005eea:	fe843583          	ld	a1,-24(s0)
    80005eee:	fd043503          	ld	a0,-48(s0)
    80005ef2:	ffffb097          	auipc	ra,0xffffb
    80005ef6:	6f6080e7          	jalr	1782(ra) # 800015e8 <memmove>
    80005efa:	a80d                	j	80005f2c <skipelem+0xce>
  else {
    memmove(name, s, len);
    80005efc:	fe442783          	lw	a5,-28(s0)
    80005f00:	863e                	mv	a2,a5
    80005f02:	fe843583          	ld	a1,-24(s0)
    80005f06:	fd043503          	ld	a0,-48(s0)
    80005f0a:	ffffb097          	auipc	ra,0xffffb
    80005f0e:	6de080e7          	jalr	1758(ra) # 800015e8 <memmove>
    name[len] = 0;
    80005f12:	fe442783          	lw	a5,-28(s0)
    80005f16:	fd043703          	ld	a4,-48(s0)
    80005f1a:	97ba                	add	a5,a5,a4
    80005f1c:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    80005f20:	a031                	j	80005f2c <skipelem+0xce>
    path++;
    80005f22:	fd843783          	ld	a5,-40(s0)
    80005f26:	0785                	addi	a5,a5,1
    80005f28:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005f2c:	fd843783          	ld	a5,-40(s0)
    80005f30:	0007c783          	lbu	a5,0(a5)
    80005f34:	873e                	mv	a4,a5
    80005f36:	02f00793          	li	a5,47
    80005f3a:	fef704e3          	beq	a4,a5,80005f22 <skipelem+0xc4>
  return path;
    80005f3e:	fd843783          	ld	a5,-40(s0)
}
    80005f42:	853e                	mv	a0,a5
    80005f44:	70a2                	ld	ra,40(sp)
    80005f46:	7402                	ld	s0,32(sp)
    80005f48:	6145                	addi	sp,sp,48
    80005f4a:	8082                	ret

0000000080005f4c <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80005f4c:	7139                	addi	sp,sp,-64
    80005f4e:	fc06                	sd	ra,56(sp)
    80005f50:	f822                	sd	s0,48(sp)
    80005f52:	0080                	addi	s0,sp,64
    80005f54:	fca43c23          	sd	a0,-40(s0)
    80005f58:	87ae                	mv	a5,a1
    80005f5a:	fcc43423          	sd	a2,-56(s0)
    80005f5e:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80005f62:	fd843783          	ld	a5,-40(s0)
    80005f66:	0007c783          	lbu	a5,0(a5)
    80005f6a:	873e                	mv	a4,a5
    80005f6c:	02f00793          	li	a5,47
    80005f70:	00f71b63          	bne	a4,a5,80005f86 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    80005f74:	4585                	li	a1,1
    80005f76:	4505                	li	a0,1
    80005f78:	fffff097          	auipc	ra,0xfffff
    80005f7c:	264080e7          	jalr	612(ra) # 800051dc <iget>
    80005f80:	fea43423          	sd	a0,-24(s0)
    80005f84:	a845                	j	80006034 <namex+0xe8>
  else
    ip = idup(myproc()->cwd);
    80005f86:	ffffd097          	auipc	ra,0xffffd
    80005f8a:	b78080e7          	jalr	-1160(ra) # 80002afe <myproc>
    80005f8e:	87aa                	mv	a5,a0
    80005f90:	1507b783          	ld	a5,336(a5)
    80005f94:	853e                	mv	a0,a5
    80005f96:	fffff097          	auipc	ra,0xfffff
    80005f9a:	362080e7          	jalr	866(ra) # 800052f8 <idup>
    80005f9e:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    80005fa2:	a849                	j	80006034 <namex+0xe8>
    ilock(ip);
    80005fa4:	fe843503          	ld	a0,-24(s0)
    80005fa8:	fffff097          	auipc	ra,0xfffff
    80005fac:	39c080e7          	jalr	924(ra) # 80005344 <ilock>
    if(ip->type != T_DIR){
    80005fb0:	fe843783          	ld	a5,-24(s0)
    80005fb4:	04479783          	lh	a5,68(a5)
    80005fb8:	873e                	mv	a4,a5
    80005fba:	4785                	li	a5,1
    80005fbc:	00f70a63          	beq	a4,a5,80005fd0 <namex+0x84>
      iunlockput(ip);
    80005fc0:	fe843503          	ld	a0,-24(s0)
    80005fc4:	fffff097          	auipc	ra,0xfffff
    80005fc8:	5de080e7          	jalr	1502(ra) # 800055a2 <iunlockput>
      return 0;
    80005fcc:	4781                	li	a5,0
    80005fce:	a871                	j	8000606a <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
    80005fd0:	fd442783          	lw	a5,-44(s0)
    80005fd4:	2781                	sext.w	a5,a5
    80005fd6:	cf99                	beqz	a5,80005ff4 <namex+0xa8>
    80005fd8:	fd843783          	ld	a5,-40(s0)
    80005fdc:	0007c783          	lbu	a5,0(a5)
    80005fe0:	eb91                	bnez	a5,80005ff4 <namex+0xa8>
      // Stop one level early.
      iunlock(ip);
    80005fe2:	fe843503          	ld	a0,-24(s0)
    80005fe6:	fffff097          	auipc	ra,0xfffff
    80005fea:	492080e7          	jalr	1170(ra) # 80005478 <iunlock>
      return ip;
    80005fee:	fe843783          	ld	a5,-24(s0)
    80005ff2:	a8a5                	j	8000606a <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80005ff4:	4601                	li	a2,0
    80005ff6:	fc843583          	ld	a1,-56(s0)
    80005ffa:	fe843503          	ld	a0,-24(s0)
    80005ffe:	00000097          	auipc	ra,0x0
    80006002:	c84080e7          	jalr	-892(ra) # 80005c82 <dirlookup>
    80006006:	fea43023          	sd	a0,-32(s0)
    8000600a:	fe043783          	ld	a5,-32(s0)
    8000600e:	eb89                	bnez	a5,80006020 <namex+0xd4>
      iunlockput(ip);
    80006010:	fe843503          	ld	a0,-24(s0)
    80006014:	fffff097          	auipc	ra,0xfffff
    80006018:	58e080e7          	jalr	1422(ra) # 800055a2 <iunlockput>
      return 0;
    8000601c:	4781                	li	a5,0
    8000601e:	a0b1                	j	8000606a <namex+0x11e>
    }
    iunlockput(ip);
    80006020:	fe843503          	ld	a0,-24(s0)
    80006024:	fffff097          	auipc	ra,0xfffff
    80006028:	57e080e7          	jalr	1406(ra) # 800055a2 <iunlockput>
    ip = next;
    8000602c:	fe043783          	ld	a5,-32(s0)
    80006030:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    80006034:	fc843583          	ld	a1,-56(s0)
    80006038:	fd843503          	ld	a0,-40(s0)
    8000603c:	00000097          	auipc	ra,0x0
    80006040:	e22080e7          	jalr	-478(ra) # 80005e5e <skipelem>
    80006044:	fca43c23          	sd	a0,-40(s0)
    80006048:	fd843783          	ld	a5,-40(s0)
    8000604c:	ffa1                	bnez	a5,80005fa4 <namex+0x58>
  }
  if(nameiparent){
    8000604e:	fd442783          	lw	a5,-44(s0)
    80006052:	2781                	sext.w	a5,a5
    80006054:	cb89                	beqz	a5,80006066 <namex+0x11a>
    iput(ip);
    80006056:	fe843503          	ld	a0,-24(s0)
    8000605a:	fffff097          	auipc	ra,0xfffff
    8000605e:	478080e7          	jalr	1144(ra) # 800054d2 <iput>
    return 0;
    80006062:	4781                	li	a5,0
    80006064:	a019                	j	8000606a <namex+0x11e>
  }
  return ip;
    80006066:	fe843783          	ld	a5,-24(s0)
}
    8000606a:	853e                	mv	a0,a5
    8000606c:	70e2                	ld	ra,56(sp)
    8000606e:	7442                	ld	s0,48(sp)
    80006070:	6121                	addi	sp,sp,64
    80006072:	8082                	ret

0000000080006074 <namei>:

struct inode*
namei(char *path)
{
    80006074:	7179                	addi	sp,sp,-48
    80006076:	f406                	sd	ra,40(sp)
    80006078:	f022                	sd	s0,32(sp)
    8000607a:	1800                	addi	s0,sp,48
    8000607c:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80006080:	fe040793          	addi	a5,s0,-32
    80006084:	863e                	mv	a2,a5
    80006086:	4581                	li	a1,0
    80006088:	fd843503          	ld	a0,-40(s0)
    8000608c:	00000097          	auipc	ra,0x0
    80006090:	ec0080e7          	jalr	-320(ra) # 80005f4c <namex>
    80006094:	87aa                	mv	a5,a0
}
    80006096:	853e                	mv	a0,a5
    80006098:	70a2                	ld	ra,40(sp)
    8000609a:	7402                	ld	s0,32(sp)
    8000609c:	6145                	addi	sp,sp,48
    8000609e:	8082                	ret

00000000800060a0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    800060a0:	1101                	addi	sp,sp,-32
    800060a2:	ec06                	sd	ra,24(sp)
    800060a4:	e822                	sd	s0,16(sp)
    800060a6:	1000                	addi	s0,sp,32
    800060a8:	fea43423          	sd	a0,-24(s0)
    800060ac:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    800060b0:	fe043603          	ld	a2,-32(s0)
    800060b4:	4585                	li	a1,1
    800060b6:	fe843503          	ld	a0,-24(s0)
    800060ba:	00000097          	auipc	ra,0x0
    800060be:	e92080e7          	jalr	-366(ra) # 80005f4c <namex>
    800060c2:	87aa                	mv	a5,a0
}
    800060c4:	853e                	mv	a0,a5
    800060c6:	60e2                	ld	ra,24(sp)
    800060c8:	6442                	ld	s0,16(sp)
    800060ca:	6105                	addi	sp,sp,32
    800060cc:	8082                	ret

00000000800060ce <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    800060ce:	1101                	addi	sp,sp,-32
    800060d0:	ec06                	sd	ra,24(sp)
    800060d2:	e822                	sd	s0,16(sp)
    800060d4:	1000                	addi	s0,sp,32
    800060d6:	87aa                	mv	a5,a0
    800060d8:	feb43023          	sd	a1,-32(s0)
    800060dc:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    800060e0:	00007597          	auipc	a1,0x7
    800060e4:	47858593          	addi	a1,a1,1144 # 8000d558 <etext+0x558>
    800060e8:	00023517          	auipc	a0,0x23
    800060ec:	84050513          	addi	a0,a0,-1984 # 80028928 <log>
    800060f0:	ffffb097          	auipc	ra,0xffffb
    800060f4:	210080e7          	jalr	528(ra) # 80001300 <initlock>
  log.start = sb->logstart;
    800060f8:	fe043783          	ld	a5,-32(s0)
    800060fc:	4bdc                	lw	a5,20(a5)
    800060fe:	0007871b          	sext.w	a4,a5
    80006102:	00023797          	auipc	a5,0x23
    80006106:	82678793          	addi	a5,a5,-2010 # 80028928 <log>
    8000610a:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    8000610c:	fe043783          	ld	a5,-32(s0)
    80006110:	4b9c                	lw	a5,16(a5)
    80006112:	0007871b          	sext.w	a4,a5
    80006116:	00023797          	auipc	a5,0x23
    8000611a:	81278793          	addi	a5,a5,-2030 # 80028928 <log>
    8000611e:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    80006120:	00023797          	auipc	a5,0x23
    80006124:	80878793          	addi	a5,a5,-2040 # 80028928 <log>
    80006128:	fec42703          	lw	a4,-20(s0)
    8000612c:	d798                	sw	a4,40(a5)
  recover_from_log();
    8000612e:	00000097          	auipc	ra,0x0
    80006132:	272080e7          	jalr	626(ra) # 800063a0 <recover_from_log>
}
    80006136:	0001                	nop
    80006138:	60e2                	ld	ra,24(sp)
    8000613a:	6442                	ld	s0,16(sp)
    8000613c:	6105                	addi	sp,sp,32
    8000613e:	8082                	ret

0000000080006140 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80006140:	7139                	addi	sp,sp,-64
    80006142:	fc06                	sd	ra,56(sp)
    80006144:	f822                	sd	s0,48(sp)
    80006146:	0080                	addi	s0,sp,64
    80006148:	87aa                	mv	a5,a0
    8000614a:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    8000614e:	fe042623          	sw	zero,-20(s0)
    80006152:	a0f9                	j	80006220 <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80006154:	00022797          	auipc	a5,0x22
    80006158:	7d478793          	addi	a5,a5,2004 # 80028928 <log>
    8000615c:	579c                	lw	a5,40(a5)
    8000615e:	0007871b          	sext.w	a4,a5
    80006162:	00022797          	auipc	a5,0x22
    80006166:	7c678793          	addi	a5,a5,1990 # 80028928 <log>
    8000616a:	4f9c                	lw	a5,24(a5)
    8000616c:	fec42683          	lw	a3,-20(s0)
    80006170:	9fb5                	addw	a5,a5,a3
    80006172:	2781                	sext.w	a5,a5
    80006174:	2785                	addiw	a5,a5,1
    80006176:	2781                	sext.w	a5,a5
    80006178:	2781                	sext.w	a5,a5
    8000617a:	85be                	mv	a1,a5
    8000617c:	853a                	mv	a0,a4
    8000617e:	ffffe097          	auipc	ra,0xffffe
    80006182:	7ee080e7          	jalr	2030(ra) # 8000496c <bread>
    80006186:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000618a:	00022797          	auipc	a5,0x22
    8000618e:	79e78793          	addi	a5,a5,1950 # 80028928 <log>
    80006192:	579c                	lw	a5,40(a5)
    80006194:	0007869b          	sext.w	a3,a5
    80006198:	00022717          	auipc	a4,0x22
    8000619c:	79070713          	addi	a4,a4,1936 # 80028928 <log>
    800061a0:	fec42783          	lw	a5,-20(s0)
    800061a4:	07a1                	addi	a5,a5,8
    800061a6:	078a                	slli	a5,a5,0x2
    800061a8:	97ba                	add	a5,a5,a4
    800061aa:	4b9c                	lw	a5,16(a5)
    800061ac:	2781                	sext.w	a5,a5
    800061ae:	85be                	mv	a1,a5
    800061b0:	8536                	mv	a0,a3
    800061b2:	ffffe097          	auipc	ra,0xffffe
    800061b6:	7ba080e7          	jalr	1978(ra) # 8000496c <bread>
    800061ba:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800061be:	fd843783          	ld	a5,-40(s0)
    800061c2:	05878713          	addi	a4,a5,88
    800061c6:	fe043783          	ld	a5,-32(s0)
    800061ca:	05878793          	addi	a5,a5,88
    800061ce:	40000613          	li	a2,1024
    800061d2:	85be                	mv	a1,a5
    800061d4:	853a                	mv	a0,a4
    800061d6:	ffffb097          	auipc	ra,0xffffb
    800061da:	412080e7          	jalr	1042(ra) # 800015e8 <memmove>
    bwrite(dbuf);  // write dst to disk
    800061de:	fd843503          	ld	a0,-40(s0)
    800061e2:	ffffe097          	auipc	ra,0xffffe
    800061e6:	7e6080e7          	jalr	2022(ra) # 800049c8 <bwrite>
    if(recovering == 0)
    800061ea:	fcc42783          	lw	a5,-52(s0)
    800061ee:	2781                	sext.w	a5,a5
    800061f0:	e799                	bnez	a5,800061fe <install_trans+0xbe>
      bunpin(dbuf);
    800061f2:	fd843503          	ld	a0,-40(s0)
    800061f6:	fffff097          	auipc	ra,0xfffff
    800061fa:	952080e7          	jalr	-1710(ra) # 80004b48 <bunpin>
    brelse(lbuf);
    800061fe:	fe043503          	ld	a0,-32(s0)
    80006202:	fffff097          	auipc	ra,0xfffff
    80006206:	810080e7          	jalr	-2032(ra) # 80004a12 <brelse>
    brelse(dbuf);
    8000620a:	fd843503          	ld	a0,-40(s0)
    8000620e:	fffff097          	auipc	ra,0xfffff
    80006212:	804080e7          	jalr	-2044(ra) # 80004a12 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006216:	fec42783          	lw	a5,-20(s0)
    8000621a:	2785                	addiw	a5,a5,1
    8000621c:	fef42623          	sw	a5,-20(s0)
    80006220:	00022797          	auipc	a5,0x22
    80006224:	70878793          	addi	a5,a5,1800 # 80028928 <log>
    80006228:	57d8                	lw	a4,44(a5)
    8000622a:	fec42783          	lw	a5,-20(s0)
    8000622e:	2781                	sext.w	a5,a5
    80006230:	f2e7c2e3          	blt	a5,a4,80006154 <install_trans+0x14>
  }
}
    80006234:	0001                	nop
    80006236:	0001                	nop
    80006238:	70e2                	ld	ra,56(sp)
    8000623a:	7442                	ld	s0,48(sp)
    8000623c:	6121                	addi	sp,sp,64
    8000623e:	8082                	ret

0000000080006240 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80006240:	7179                	addi	sp,sp,-48
    80006242:	f406                	sd	ra,40(sp)
    80006244:	f022                	sd	s0,32(sp)
    80006246:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006248:	00022797          	auipc	a5,0x22
    8000624c:	6e078793          	addi	a5,a5,1760 # 80028928 <log>
    80006250:	579c                	lw	a5,40(a5)
    80006252:	0007871b          	sext.w	a4,a5
    80006256:	00022797          	auipc	a5,0x22
    8000625a:	6d278793          	addi	a5,a5,1746 # 80028928 <log>
    8000625e:	4f9c                	lw	a5,24(a5)
    80006260:	2781                	sext.w	a5,a5
    80006262:	85be                	mv	a1,a5
    80006264:	853a                	mv	a0,a4
    80006266:	ffffe097          	auipc	ra,0xffffe
    8000626a:	706080e7          	jalr	1798(ra) # 8000496c <bread>
    8000626e:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80006272:	fe043783          	ld	a5,-32(s0)
    80006276:	05878793          	addi	a5,a5,88
    8000627a:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    8000627e:	fd843783          	ld	a5,-40(s0)
    80006282:	4398                	lw	a4,0(a5)
    80006284:	00022797          	auipc	a5,0x22
    80006288:	6a478793          	addi	a5,a5,1700 # 80028928 <log>
    8000628c:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    8000628e:	fe042623          	sw	zero,-20(s0)
    80006292:	a03d                	j	800062c0 <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    80006294:	fd843703          	ld	a4,-40(s0)
    80006298:	fec42783          	lw	a5,-20(s0)
    8000629c:	078a                	slli	a5,a5,0x2
    8000629e:	97ba                	add	a5,a5,a4
    800062a0:	43d8                	lw	a4,4(a5)
    800062a2:	00022697          	auipc	a3,0x22
    800062a6:	68668693          	addi	a3,a3,1670 # 80028928 <log>
    800062aa:	fec42783          	lw	a5,-20(s0)
    800062ae:	07a1                	addi	a5,a5,8
    800062b0:	078a                	slli	a5,a5,0x2
    800062b2:	97b6                	add	a5,a5,a3
    800062b4:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    800062b6:	fec42783          	lw	a5,-20(s0)
    800062ba:	2785                	addiw	a5,a5,1
    800062bc:	fef42623          	sw	a5,-20(s0)
    800062c0:	00022797          	auipc	a5,0x22
    800062c4:	66878793          	addi	a5,a5,1640 # 80028928 <log>
    800062c8:	57d8                	lw	a4,44(a5)
    800062ca:	fec42783          	lw	a5,-20(s0)
    800062ce:	2781                	sext.w	a5,a5
    800062d0:	fce7c2e3          	blt	a5,a4,80006294 <read_head+0x54>
  }
  brelse(buf);
    800062d4:	fe043503          	ld	a0,-32(s0)
    800062d8:	ffffe097          	auipc	ra,0xffffe
    800062dc:	73a080e7          	jalr	1850(ra) # 80004a12 <brelse>
}
    800062e0:	0001                	nop
    800062e2:	70a2                	ld	ra,40(sp)
    800062e4:	7402                	ld	s0,32(sp)
    800062e6:	6145                	addi	sp,sp,48
    800062e8:	8082                	ret

00000000800062ea <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800062ea:	7179                	addi	sp,sp,-48
    800062ec:	f406                	sd	ra,40(sp)
    800062ee:	f022                	sd	s0,32(sp)
    800062f0:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    800062f2:	00022797          	auipc	a5,0x22
    800062f6:	63678793          	addi	a5,a5,1590 # 80028928 <log>
    800062fa:	579c                	lw	a5,40(a5)
    800062fc:	0007871b          	sext.w	a4,a5
    80006300:	00022797          	auipc	a5,0x22
    80006304:	62878793          	addi	a5,a5,1576 # 80028928 <log>
    80006308:	4f9c                	lw	a5,24(a5)
    8000630a:	2781                	sext.w	a5,a5
    8000630c:	85be                	mv	a1,a5
    8000630e:	853a                	mv	a0,a4
    80006310:	ffffe097          	auipc	ra,0xffffe
    80006314:	65c080e7          	jalr	1628(ra) # 8000496c <bread>
    80006318:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    8000631c:	fe043783          	ld	a5,-32(s0)
    80006320:	05878793          	addi	a5,a5,88
    80006324:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    80006328:	00022797          	auipc	a5,0x22
    8000632c:	60078793          	addi	a5,a5,1536 # 80028928 <log>
    80006330:	57d8                	lw	a4,44(a5)
    80006332:	fd843783          	ld	a5,-40(s0)
    80006336:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006338:	fe042623          	sw	zero,-20(s0)
    8000633c:	a03d                	j	8000636a <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    8000633e:	00022717          	auipc	a4,0x22
    80006342:	5ea70713          	addi	a4,a4,1514 # 80028928 <log>
    80006346:	fec42783          	lw	a5,-20(s0)
    8000634a:	07a1                	addi	a5,a5,8
    8000634c:	078a                	slli	a5,a5,0x2
    8000634e:	97ba                	add	a5,a5,a4
    80006350:	4b98                	lw	a4,16(a5)
    80006352:	fd843683          	ld	a3,-40(s0)
    80006356:	fec42783          	lw	a5,-20(s0)
    8000635a:	078a                	slli	a5,a5,0x2
    8000635c:	97b6                	add	a5,a5,a3
    8000635e:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006360:	fec42783          	lw	a5,-20(s0)
    80006364:	2785                	addiw	a5,a5,1
    80006366:	fef42623          	sw	a5,-20(s0)
    8000636a:	00022797          	auipc	a5,0x22
    8000636e:	5be78793          	addi	a5,a5,1470 # 80028928 <log>
    80006372:	57d8                	lw	a4,44(a5)
    80006374:	fec42783          	lw	a5,-20(s0)
    80006378:	2781                	sext.w	a5,a5
    8000637a:	fce7c2e3          	blt	a5,a4,8000633e <write_head+0x54>
  }
  bwrite(buf);
    8000637e:	fe043503          	ld	a0,-32(s0)
    80006382:	ffffe097          	auipc	ra,0xffffe
    80006386:	646080e7          	jalr	1606(ra) # 800049c8 <bwrite>
  brelse(buf);
    8000638a:	fe043503          	ld	a0,-32(s0)
    8000638e:	ffffe097          	auipc	ra,0xffffe
    80006392:	684080e7          	jalr	1668(ra) # 80004a12 <brelse>
}
    80006396:	0001                	nop
    80006398:	70a2                	ld	ra,40(sp)
    8000639a:	7402                	ld	s0,32(sp)
    8000639c:	6145                	addi	sp,sp,48
    8000639e:	8082                	ret

00000000800063a0 <recover_from_log>:

static void
recover_from_log(void)
{
    800063a0:	1141                	addi	sp,sp,-16
    800063a2:	e406                	sd	ra,8(sp)
    800063a4:	e022                	sd	s0,0(sp)
    800063a6:	0800                	addi	s0,sp,16
  read_head();
    800063a8:	00000097          	auipc	ra,0x0
    800063ac:	e98080e7          	jalr	-360(ra) # 80006240 <read_head>
  install_trans(1); // if committed, copy from log to disk
    800063b0:	4505                	li	a0,1
    800063b2:	00000097          	auipc	ra,0x0
    800063b6:	d8e080e7          	jalr	-626(ra) # 80006140 <install_trans>
  log.lh.n = 0;
    800063ba:	00022797          	auipc	a5,0x22
    800063be:	56e78793          	addi	a5,a5,1390 # 80028928 <log>
    800063c2:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    800063c6:	00000097          	auipc	ra,0x0
    800063ca:	f24080e7          	jalr	-220(ra) # 800062ea <write_head>
}
    800063ce:	0001                	nop
    800063d0:	60a2                	ld	ra,8(sp)
    800063d2:	6402                	ld	s0,0(sp)
    800063d4:	0141                	addi	sp,sp,16
    800063d6:	8082                	ret

00000000800063d8 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    800063d8:	1141                	addi	sp,sp,-16
    800063da:	e406                	sd	ra,8(sp)
    800063dc:	e022                	sd	s0,0(sp)
    800063de:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    800063e0:	00022517          	auipc	a0,0x22
    800063e4:	54850513          	addi	a0,a0,1352 # 80028928 <log>
    800063e8:	ffffb097          	auipc	ra,0xffffb
    800063ec:	f48080e7          	jalr	-184(ra) # 80001330 <acquire>
  while(1){
    if(log.committing){
    800063f0:	00022797          	auipc	a5,0x22
    800063f4:	53878793          	addi	a5,a5,1336 # 80028928 <log>
    800063f8:	53dc                	lw	a5,36(a5)
    800063fa:	cf91                	beqz	a5,80006416 <begin_op+0x3e>
      sleep(&log, &log.lock);
    800063fc:	00022597          	auipc	a1,0x22
    80006400:	52c58593          	addi	a1,a1,1324 # 80028928 <log>
    80006404:	00022517          	auipc	a0,0x22
    80006408:	52450513          	addi	a0,a0,1316 # 80028928 <log>
    8000640c:	ffffd097          	auipc	ra,0xffffd
    80006410:	2bc080e7          	jalr	700(ra) # 800036c8 <sleep>
    80006414:	bff1                	j	800063f0 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80006416:	00022797          	auipc	a5,0x22
    8000641a:	51278793          	addi	a5,a5,1298 # 80028928 <log>
    8000641e:	57d8                	lw	a4,44(a5)
    80006420:	00022797          	auipc	a5,0x22
    80006424:	50878793          	addi	a5,a5,1288 # 80028928 <log>
    80006428:	539c                	lw	a5,32(a5)
    8000642a:	2785                	addiw	a5,a5,1
    8000642c:	2781                	sext.w	a5,a5
    8000642e:	86be                	mv	a3,a5
    80006430:	87b6                	mv	a5,a3
    80006432:	0027979b          	slliw	a5,a5,0x2
    80006436:	9fb5                	addw	a5,a5,a3
    80006438:	0017979b          	slliw	a5,a5,0x1
    8000643c:	2781                	sext.w	a5,a5
    8000643e:	9fb9                	addw	a5,a5,a4
    80006440:	2781                	sext.w	a5,a5
    80006442:	873e                	mv	a4,a5
    80006444:	47f9                	li	a5,30
    80006446:	00e7df63          	bge	a5,a4,80006464 <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000644a:	00022597          	auipc	a1,0x22
    8000644e:	4de58593          	addi	a1,a1,1246 # 80028928 <log>
    80006452:	00022517          	auipc	a0,0x22
    80006456:	4d650513          	addi	a0,a0,1238 # 80028928 <log>
    8000645a:	ffffd097          	auipc	ra,0xffffd
    8000645e:	26e080e7          	jalr	622(ra) # 800036c8 <sleep>
    80006462:	b779                	j	800063f0 <begin_op+0x18>
    } else {
      log.outstanding += 1;
    80006464:	00022797          	auipc	a5,0x22
    80006468:	4c478793          	addi	a5,a5,1220 # 80028928 <log>
    8000646c:	539c                	lw	a5,32(a5)
    8000646e:	2785                	addiw	a5,a5,1
    80006470:	0007871b          	sext.w	a4,a5
    80006474:	00022797          	auipc	a5,0x22
    80006478:	4b478793          	addi	a5,a5,1204 # 80028928 <log>
    8000647c:	d398                	sw	a4,32(a5)
      release(&log.lock);
    8000647e:	00022517          	auipc	a0,0x22
    80006482:	4aa50513          	addi	a0,a0,1194 # 80028928 <log>
    80006486:	ffffb097          	auipc	ra,0xffffb
    8000648a:	f0e080e7          	jalr	-242(ra) # 80001394 <release>
      break;
    8000648e:	0001                	nop
    }
  }
}
    80006490:	0001                	nop
    80006492:	60a2                	ld	ra,8(sp)
    80006494:	6402                	ld	s0,0(sp)
    80006496:	0141                	addi	sp,sp,16
    80006498:	8082                	ret

000000008000649a <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    8000649a:	1101                	addi	sp,sp,-32
    8000649c:	ec06                	sd	ra,24(sp)
    8000649e:	e822                	sd	s0,16(sp)
    800064a0:	1000                	addi	s0,sp,32
  int do_commit = 0;
    800064a2:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    800064a6:	00022517          	auipc	a0,0x22
    800064aa:	48250513          	addi	a0,a0,1154 # 80028928 <log>
    800064ae:	ffffb097          	auipc	ra,0xffffb
    800064b2:	e82080e7          	jalr	-382(ra) # 80001330 <acquire>
  log.outstanding -= 1;
    800064b6:	00022797          	auipc	a5,0x22
    800064ba:	47278793          	addi	a5,a5,1138 # 80028928 <log>
    800064be:	539c                	lw	a5,32(a5)
    800064c0:	37fd                	addiw	a5,a5,-1
    800064c2:	0007871b          	sext.w	a4,a5
    800064c6:	00022797          	auipc	a5,0x22
    800064ca:	46278793          	addi	a5,a5,1122 # 80028928 <log>
    800064ce:	d398                	sw	a4,32(a5)
  if(log.committing)
    800064d0:	00022797          	auipc	a5,0x22
    800064d4:	45878793          	addi	a5,a5,1112 # 80028928 <log>
    800064d8:	53dc                	lw	a5,36(a5)
    800064da:	cb89                	beqz	a5,800064ec <end_op+0x52>
    panic("log.committing");
    800064dc:	00007517          	auipc	a0,0x7
    800064e0:	08450513          	addi	a0,a0,132 # 8000d560 <etext+0x560>
    800064e4:	ffffa097          	auipc	ra,0xffffa
    800064e8:	7a4080e7          	jalr	1956(ra) # 80000c88 <panic>
  if(log.outstanding == 0){
    800064ec:	00022797          	auipc	a5,0x22
    800064f0:	43c78793          	addi	a5,a5,1084 # 80028928 <log>
    800064f4:	539c                	lw	a5,32(a5)
    800064f6:	eb99                	bnez	a5,8000650c <end_op+0x72>
    do_commit = 1;
    800064f8:	4785                	li	a5,1
    800064fa:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    800064fe:	00022797          	auipc	a5,0x22
    80006502:	42a78793          	addi	a5,a5,1066 # 80028928 <log>
    80006506:	4705                	li	a4,1
    80006508:	d3d8                	sw	a4,36(a5)
    8000650a:	a809                	j	8000651c <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    8000650c:	00022517          	auipc	a0,0x22
    80006510:	41c50513          	addi	a0,a0,1052 # 80028928 <log>
    80006514:	ffffd097          	auipc	ra,0xffffd
    80006518:	230080e7          	jalr	560(ra) # 80003744 <wakeup>
  }
  release(&log.lock);
    8000651c:	00022517          	auipc	a0,0x22
    80006520:	40c50513          	addi	a0,a0,1036 # 80028928 <log>
    80006524:	ffffb097          	auipc	ra,0xffffb
    80006528:	e70080e7          	jalr	-400(ra) # 80001394 <release>

  if(do_commit){
    8000652c:	fec42783          	lw	a5,-20(s0)
    80006530:	2781                	sext.w	a5,a5
    80006532:	c3b9                	beqz	a5,80006578 <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    80006534:	00000097          	auipc	ra,0x0
    80006538:	134080e7          	jalr	308(ra) # 80006668 <commit>
    acquire(&log.lock);
    8000653c:	00022517          	auipc	a0,0x22
    80006540:	3ec50513          	addi	a0,a0,1004 # 80028928 <log>
    80006544:	ffffb097          	auipc	ra,0xffffb
    80006548:	dec080e7          	jalr	-532(ra) # 80001330 <acquire>
    log.committing = 0;
    8000654c:	00022797          	auipc	a5,0x22
    80006550:	3dc78793          	addi	a5,a5,988 # 80028928 <log>
    80006554:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    80006558:	00022517          	auipc	a0,0x22
    8000655c:	3d050513          	addi	a0,a0,976 # 80028928 <log>
    80006560:	ffffd097          	auipc	ra,0xffffd
    80006564:	1e4080e7          	jalr	484(ra) # 80003744 <wakeup>
    release(&log.lock);
    80006568:	00022517          	auipc	a0,0x22
    8000656c:	3c050513          	addi	a0,a0,960 # 80028928 <log>
    80006570:	ffffb097          	auipc	ra,0xffffb
    80006574:	e24080e7          	jalr	-476(ra) # 80001394 <release>
  }
}
    80006578:	0001                	nop
    8000657a:	60e2                	ld	ra,24(sp)
    8000657c:	6442                	ld	s0,16(sp)
    8000657e:	6105                	addi	sp,sp,32
    80006580:	8082                	ret

0000000080006582 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    80006582:	7179                	addi	sp,sp,-48
    80006584:	f406                	sd	ra,40(sp)
    80006586:	f022                	sd	s0,32(sp)
    80006588:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    8000658a:	fe042623          	sw	zero,-20(s0)
    8000658e:	a86d                	j	80006648 <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80006590:	00022797          	auipc	a5,0x22
    80006594:	39878793          	addi	a5,a5,920 # 80028928 <log>
    80006598:	579c                	lw	a5,40(a5)
    8000659a:	0007871b          	sext.w	a4,a5
    8000659e:	00022797          	auipc	a5,0x22
    800065a2:	38a78793          	addi	a5,a5,906 # 80028928 <log>
    800065a6:	4f9c                	lw	a5,24(a5)
    800065a8:	fec42683          	lw	a3,-20(s0)
    800065ac:	9fb5                	addw	a5,a5,a3
    800065ae:	2781                	sext.w	a5,a5
    800065b0:	2785                	addiw	a5,a5,1
    800065b2:	2781                	sext.w	a5,a5
    800065b4:	2781                	sext.w	a5,a5
    800065b6:	85be                	mv	a1,a5
    800065b8:	853a                	mv	a0,a4
    800065ba:	ffffe097          	auipc	ra,0xffffe
    800065be:	3b2080e7          	jalr	946(ra) # 8000496c <bread>
    800065c2:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800065c6:	00022797          	auipc	a5,0x22
    800065ca:	36278793          	addi	a5,a5,866 # 80028928 <log>
    800065ce:	579c                	lw	a5,40(a5)
    800065d0:	0007869b          	sext.w	a3,a5
    800065d4:	00022717          	auipc	a4,0x22
    800065d8:	35470713          	addi	a4,a4,852 # 80028928 <log>
    800065dc:	fec42783          	lw	a5,-20(s0)
    800065e0:	07a1                	addi	a5,a5,8
    800065e2:	078a                	slli	a5,a5,0x2
    800065e4:	97ba                	add	a5,a5,a4
    800065e6:	4b9c                	lw	a5,16(a5)
    800065e8:	2781                	sext.w	a5,a5
    800065ea:	85be                	mv	a1,a5
    800065ec:	8536                	mv	a0,a3
    800065ee:	ffffe097          	auipc	ra,0xffffe
    800065f2:	37e080e7          	jalr	894(ra) # 8000496c <bread>
    800065f6:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    800065fa:	fe043783          	ld	a5,-32(s0)
    800065fe:	05878713          	addi	a4,a5,88
    80006602:	fd843783          	ld	a5,-40(s0)
    80006606:	05878793          	addi	a5,a5,88
    8000660a:	40000613          	li	a2,1024
    8000660e:	85be                	mv	a1,a5
    80006610:	853a                	mv	a0,a4
    80006612:	ffffb097          	auipc	ra,0xffffb
    80006616:	fd6080e7          	jalr	-42(ra) # 800015e8 <memmove>
    bwrite(to);  // write the log
    8000661a:	fe043503          	ld	a0,-32(s0)
    8000661e:	ffffe097          	auipc	ra,0xffffe
    80006622:	3aa080e7          	jalr	938(ra) # 800049c8 <bwrite>
    brelse(from);
    80006626:	fd843503          	ld	a0,-40(s0)
    8000662a:	ffffe097          	auipc	ra,0xffffe
    8000662e:	3e8080e7          	jalr	1000(ra) # 80004a12 <brelse>
    brelse(to);
    80006632:	fe043503          	ld	a0,-32(s0)
    80006636:	ffffe097          	auipc	ra,0xffffe
    8000663a:	3dc080e7          	jalr	988(ra) # 80004a12 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000663e:	fec42783          	lw	a5,-20(s0)
    80006642:	2785                	addiw	a5,a5,1
    80006644:	fef42623          	sw	a5,-20(s0)
    80006648:	00022797          	auipc	a5,0x22
    8000664c:	2e078793          	addi	a5,a5,736 # 80028928 <log>
    80006650:	57d8                	lw	a4,44(a5)
    80006652:	fec42783          	lw	a5,-20(s0)
    80006656:	2781                	sext.w	a5,a5
    80006658:	f2e7cce3          	blt	a5,a4,80006590 <write_log+0xe>
  }
}
    8000665c:	0001                	nop
    8000665e:	0001                	nop
    80006660:	70a2                	ld	ra,40(sp)
    80006662:	7402                	ld	s0,32(sp)
    80006664:	6145                	addi	sp,sp,48
    80006666:	8082                	ret

0000000080006668 <commit>:

static void
commit()
{
    80006668:	1141                	addi	sp,sp,-16
    8000666a:	e406                	sd	ra,8(sp)
    8000666c:	e022                	sd	s0,0(sp)
    8000666e:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80006670:	00022797          	auipc	a5,0x22
    80006674:	2b878793          	addi	a5,a5,696 # 80028928 <log>
    80006678:	57dc                	lw	a5,44(a5)
    8000667a:	02f05963          	blez	a5,800066ac <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    8000667e:	00000097          	auipc	ra,0x0
    80006682:	f04080e7          	jalr	-252(ra) # 80006582 <write_log>
    write_head();    // Write header to disk -- the real commit
    80006686:	00000097          	auipc	ra,0x0
    8000668a:	c64080e7          	jalr	-924(ra) # 800062ea <write_head>
    install_trans(0); // Now install writes to home locations
    8000668e:	4501                	li	a0,0
    80006690:	00000097          	auipc	ra,0x0
    80006694:	ab0080e7          	jalr	-1360(ra) # 80006140 <install_trans>
    log.lh.n = 0;
    80006698:	00022797          	auipc	a5,0x22
    8000669c:	29078793          	addi	a5,a5,656 # 80028928 <log>
    800066a0:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    800066a4:	00000097          	auipc	ra,0x0
    800066a8:	c46080e7          	jalr	-954(ra) # 800062ea <write_head>
  }
}
    800066ac:	0001                	nop
    800066ae:	60a2                	ld	ra,8(sp)
    800066b0:	6402                	ld	s0,0(sp)
    800066b2:	0141                	addi	sp,sp,16
    800066b4:	8082                	ret

00000000800066b6 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800066b6:	7179                	addi	sp,sp,-48
    800066b8:	f406                	sd	ra,40(sp)
    800066ba:	f022                	sd	s0,32(sp)
    800066bc:	1800                	addi	s0,sp,48
    800066be:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    800066c2:	00022517          	auipc	a0,0x22
    800066c6:	26650513          	addi	a0,a0,614 # 80028928 <log>
    800066ca:	ffffb097          	auipc	ra,0xffffb
    800066ce:	c66080e7          	jalr	-922(ra) # 80001330 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800066d2:	00022797          	auipc	a5,0x22
    800066d6:	25678793          	addi	a5,a5,598 # 80028928 <log>
    800066da:	57dc                	lw	a5,44(a5)
    800066dc:	873e                	mv	a4,a5
    800066de:	47f5                	li	a5,29
    800066e0:	02e7c063          	blt	a5,a4,80006700 <log_write+0x4a>
    800066e4:	00022797          	auipc	a5,0x22
    800066e8:	24478793          	addi	a5,a5,580 # 80028928 <log>
    800066ec:	57d8                	lw	a4,44(a5)
    800066ee:	00022797          	auipc	a5,0x22
    800066f2:	23a78793          	addi	a5,a5,570 # 80028928 <log>
    800066f6:	4fdc                	lw	a5,28(a5)
    800066f8:	37fd                	addiw	a5,a5,-1
    800066fa:	2781                	sext.w	a5,a5
    800066fc:	00f74a63          	blt	a4,a5,80006710 <log_write+0x5a>
    panic("too big a transaction");
    80006700:	00007517          	auipc	a0,0x7
    80006704:	e7050513          	addi	a0,a0,-400 # 8000d570 <etext+0x570>
    80006708:	ffffa097          	auipc	ra,0xffffa
    8000670c:	580080e7          	jalr	1408(ra) # 80000c88 <panic>
  if (log.outstanding < 1)
    80006710:	00022797          	auipc	a5,0x22
    80006714:	21878793          	addi	a5,a5,536 # 80028928 <log>
    80006718:	539c                	lw	a5,32(a5)
    8000671a:	00f04a63          	bgtz	a5,8000672e <log_write+0x78>
    panic("log_write outside of trans");
    8000671e:	00007517          	auipc	a0,0x7
    80006722:	e6a50513          	addi	a0,a0,-406 # 8000d588 <etext+0x588>
    80006726:	ffffa097          	auipc	ra,0xffffa
    8000672a:	562080e7          	jalr	1378(ra) # 80000c88 <panic>

  for (i = 0; i < log.lh.n; i++) {
    8000672e:	fe042623          	sw	zero,-20(s0)
    80006732:	a03d                	j	80006760 <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80006734:	00022717          	auipc	a4,0x22
    80006738:	1f470713          	addi	a4,a4,500 # 80028928 <log>
    8000673c:	fec42783          	lw	a5,-20(s0)
    80006740:	07a1                	addi	a5,a5,8
    80006742:	078a                	slli	a5,a5,0x2
    80006744:	97ba                	add	a5,a5,a4
    80006746:	4b9c                	lw	a5,16(a5)
    80006748:	0007871b          	sext.w	a4,a5
    8000674c:	fd843783          	ld	a5,-40(s0)
    80006750:	47dc                	lw	a5,12(a5)
    80006752:	02f70263          	beq	a4,a5,80006776 <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    80006756:	fec42783          	lw	a5,-20(s0)
    8000675a:	2785                	addiw	a5,a5,1
    8000675c:	fef42623          	sw	a5,-20(s0)
    80006760:	00022797          	auipc	a5,0x22
    80006764:	1c878793          	addi	a5,a5,456 # 80028928 <log>
    80006768:	57d8                	lw	a4,44(a5)
    8000676a:	fec42783          	lw	a5,-20(s0)
    8000676e:	2781                	sext.w	a5,a5
    80006770:	fce7c2e3          	blt	a5,a4,80006734 <log_write+0x7e>
    80006774:	a011                	j	80006778 <log_write+0xc2>
      break;
    80006776:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80006778:	fd843783          	ld	a5,-40(s0)
    8000677c:	47dc                	lw	a5,12(a5)
    8000677e:	0007871b          	sext.w	a4,a5
    80006782:	00022697          	auipc	a3,0x22
    80006786:	1a668693          	addi	a3,a3,422 # 80028928 <log>
    8000678a:	fec42783          	lw	a5,-20(s0)
    8000678e:	07a1                	addi	a5,a5,8
    80006790:	078a                	slli	a5,a5,0x2
    80006792:	97b6                	add	a5,a5,a3
    80006794:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    80006796:	00022797          	auipc	a5,0x22
    8000679a:	19278793          	addi	a5,a5,402 # 80028928 <log>
    8000679e:	57d8                	lw	a4,44(a5)
    800067a0:	fec42783          	lw	a5,-20(s0)
    800067a4:	2781                	sext.w	a5,a5
    800067a6:	02e79563          	bne	a5,a4,800067d0 <log_write+0x11a>
    bpin(b);
    800067aa:	fd843503          	ld	a0,-40(s0)
    800067ae:	ffffe097          	auipc	ra,0xffffe
    800067b2:	352080e7          	jalr	850(ra) # 80004b00 <bpin>
    log.lh.n++;
    800067b6:	00022797          	auipc	a5,0x22
    800067ba:	17278793          	addi	a5,a5,370 # 80028928 <log>
    800067be:	57dc                	lw	a5,44(a5)
    800067c0:	2785                	addiw	a5,a5,1
    800067c2:	0007871b          	sext.w	a4,a5
    800067c6:	00022797          	auipc	a5,0x22
    800067ca:	16278793          	addi	a5,a5,354 # 80028928 <log>
    800067ce:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    800067d0:	00022517          	auipc	a0,0x22
    800067d4:	15850513          	addi	a0,a0,344 # 80028928 <log>
    800067d8:	ffffb097          	auipc	ra,0xffffb
    800067dc:	bbc080e7          	jalr	-1092(ra) # 80001394 <release>
}
    800067e0:	0001                	nop
    800067e2:	70a2                	ld	ra,40(sp)
    800067e4:	7402                	ld	s0,32(sp)
    800067e6:	6145                	addi	sp,sp,48
    800067e8:	8082                	ret

00000000800067ea <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800067ea:	1101                	addi	sp,sp,-32
    800067ec:	ec06                	sd	ra,24(sp)
    800067ee:	e822                	sd	s0,16(sp)
    800067f0:	1000                	addi	s0,sp,32
    800067f2:	fea43423          	sd	a0,-24(s0)
    800067f6:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    800067fa:	fe843783          	ld	a5,-24(s0)
    800067fe:	07a1                	addi	a5,a5,8
    80006800:	00007597          	auipc	a1,0x7
    80006804:	da858593          	addi	a1,a1,-600 # 8000d5a8 <etext+0x5a8>
    80006808:	853e                	mv	a0,a5
    8000680a:	ffffb097          	auipc	ra,0xffffb
    8000680e:	af6080e7          	jalr	-1290(ra) # 80001300 <initlock>
  lk->name = name;
    80006812:	fe843783          	ld	a5,-24(s0)
    80006816:	fe043703          	ld	a4,-32(s0)
    8000681a:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    8000681c:	fe843783          	ld	a5,-24(s0)
    80006820:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006824:	fe843783          	ld	a5,-24(s0)
    80006828:	0207a423          	sw	zero,40(a5)
}
    8000682c:	0001                	nop
    8000682e:	60e2                	ld	ra,24(sp)
    80006830:	6442                	ld	s0,16(sp)
    80006832:	6105                	addi	sp,sp,32
    80006834:	8082                	ret

0000000080006836 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80006836:	1101                	addi	sp,sp,-32
    80006838:	ec06                	sd	ra,24(sp)
    8000683a:	e822                	sd	s0,16(sp)
    8000683c:	1000                	addi	s0,sp,32
    8000683e:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80006842:	fe843783          	ld	a5,-24(s0)
    80006846:	07a1                	addi	a5,a5,8
    80006848:	853e                	mv	a0,a5
    8000684a:	ffffb097          	auipc	ra,0xffffb
    8000684e:	ae6080e7          	jalr	-1306(ra) # 80001330 <acquire>
  while (lk->locked) {
    80006852:	a819                	j	80006868 <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    80006854:	fe843783          	ld	a5,-24(s0)
    80006858:	07a1                	addi	a5,a5,8
    8000685a:	85be                	mv	a1,a5
    8000685c:	fe843503          	ld	a0,-24(s0)
    80006860:	ffffd097          	auipc	ra,0xffffd
    80006864:	e68080e7          	jalr	-408(ra) # 800036c8 <sleep>
  while (lk->locked) {
    80006868:	fe843783          	ld	a5,-24(s0)
    8000686c:	439c                	lw	a5,0(a5)
    8000686e:	f3fd                	bnez	a5,80006854 <acquiresleep+0x1e>
  }
  lk->locked = 1;
    80006870:	fe843783          	ld	a5,-24(s0)
    80006874:	4705                	li	a4,1
    80006876:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    80006878:	ffffc097          	auipc	ra,0xffffc
    8000687c:	286080e7          	jalr	646(ra) # 80002afe <myproc>
    80006880:	87aa                	mv	a5,a0
    80006882:	5b98                	lw	a4,48(a5)
    80006884:	fe843783          	ld	a5,-24(s0)
    80006888:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    8000688a:	fe843783          	ld	a5,-24(s0)
    8000688e:	07a1                	addi	a5,a5,8
    80006890:	853e                	mv	a0,a5
    80006892:	ffffb097          	auipc	ra,0xffffb
    80006896:	b02080e7          	jalr	-1278(ra) # 80001394 <release>
}
    8000689a:	0001                	nop
    8000689c:	60e2                	ld	ra,24(sp)
    8000689e:	6442                	ld	s0,16(sp)
    800068a0:	6105                	addi	sp,sp,32
    800068a2:	8082                	ret

00000000800068a4 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800068a4:	1101                	addi	sp,sp,-32
    800068a6:	ec06                	sd	ra,24(sp)
    800068a8:	e822                	sd	s0,16(sp)
    800068aa:	1000                	addi	s0,sp,32
    800068ac:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    800068b0:	fe843783          	ld	a5,-24(s0)
    800068b4:	07a1                	addi	a5,a5,8
    800068b6:	853e                	mv	a0,a5
    800068b8:	ffffb097          	auipc	ra,0xffffb
    800068bc:	a78080e7          	jalr	-1416(ra) # 80001330 <acquire>
  lk->locked = 0;
    800068c0:	fe843783          	ld	a5,-24(s0)
    800068c4:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    800068c8:	fe843783          	ld	a5,-24(s0)
    800068cc:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    800068d0:	fe843503          	ld	a0,-24(s0)
    800068d4:	ffffd097          	auipc	ra,0xffffd
    800068d8:	e70080e7          	jalr	-400(ra) # 80003744 <wakeup>
  release(&lk->lk);
    800068dc:	fe843783          	ld	a5,-24(s0)
    800068e0:	07a1                	addi	a5,a5,8
    800068e2:	853e                	mv	a0,a5
    800068e4:	ffffb097          	auipc	ra,0xffffb
    800068e8:	ab0080e7          	jalr	-1360(ra) # 80001394 <release>
}
    800068ec:	0001                	nop
    800068ee:	60e2                	ld	ra,24(sp)
    800068f0:	6442                	ld	s0,16(sp)
    800068f2:	6105                	addi	sp,sp,32
    800068f4:	8082                	ret

00000000800068f6 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800068f6:	7139                	addi	sp,sp,-64
    800068f8:	fc06                	sd	ra,56(sp)
    800068fa:	f822                	sd	s0,48(sp)
    800068fc:	f426                	sd	s1,40(sp)
    800068fe:	0080                	addi	s0,sp,64
    80006900:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    80006904:	fc843783          	ld	a5,-56(s0)
    80006908:	07a1                	addi	a5,a5,8
    8000690a:	853e                	mv	a0,a5
    8000690c:	ffffb097          	auipc	ra,0xffffb
    80006910:	a24080e7          	jalr	-1500(ra) # 80001330 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80006914:	fc843783          	ld	a5,-56(s0)
    80006918:	439c                	lw	a5,0(a5)
    8000691a:	cf99                	beqz	a5,80006938 <holdingsleep+0x42>
    8000691c:	fc843783          	ld	a5,-56(s0)
    80006920:	5784                	lw	s1,40(a5)
    80006922:	ffffc097          	auipc	ra,0xffffc
    80006926:	1dc080e7          	jalr	476(ra) # 80002afe <myproc>
    8000692a:	87aa                	mv	a5,a0
    8000692c:	5b9c                	lw	a5,48(a5)
    8000692e:	8726                	mv	a4,s1
    80006930:	00f71463          	bne	a4,a5,80006938 <holdingsleep+0x42>
    80006934:	4785                	li	a5,1
    80006936:	a011                	j	8000693a <holdingsleep+0x44>
    80006938:	4781                	li	a5,0
    8000693a:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    8000693e:	fc843783          	ld	a5,-56(s0)
    80006942:	07a1                	addi	a5,a5,8
    80006944:	853e                	mv	a0,a5
    80006946:	ffffb097          	auipc	ra,0xffffb
    8000694a:	a4e080e7          	jalr	-1458(ra) # 80001394 <release>
  return r;
    8000694e:	fdc42783          	lw	a5,-36(s0)
}
    80006952:	853e                	mv	a0,a5
    80006954:	70e2                	ld	ra,56(sp)
    80006956:	7442                	ld	s0,48(sp)
    80006958:	74a2                	ld	s1,40(sp)
    8000695a:	6121                	addi	sp,sp,64
    8000695c:	8082                	ret

000000008000695e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000695e:	1141                	addi	sp,sp,-16
    80006960:	e406                	sd	ra,8(sp)
    80006962:	e022                	sd	s0,0(sp)
    80006964:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80006966:	00007597          	auipc	a1,0x7
    8000696a:	c5258593          	addi	a1,a1,-942 # 8000d5b8 <etext+0x5b8>
    8000696e:	00022517          	auipc	a0,0x22
    80006972:	10250513          	addi	a0,a0,258 # 80028a70 <ftable>
    80006976:	ffffb097          	auipc	ra,0xffffb
    8000697a:	98a080e7          	jalr	-1654(ra) # 80001300 <initlock>
}
    8000697e:	0001                	nop
    80006980:	60a2                	ld	ra,8(sp)
    80006982:	6402                	ld	s0,0(sp)
    80006984:	0141                	addi	sp,sp,16
    80006986:	8082                	ret

0000000080006988 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80006988:	1101                	addi	sp,sp,-32
    8000698a:	ec06                	sd	ra,24(sp)
    8000698c:	e822                	sd	s0,16(sp)
    8000698e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80006990:	00022517          	auipc	a0,0x22
    80006994:	0e050513          	addi	a0,a0,224 # 80028a70 <ftable>
    80006998:	ffffb097          	auipc	ra,0xffffb
    8000699c:	998080e7          	jalr	-1640(ra) # 80001330 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800069a0:	00022797          	auipc	a5,0x22
    800069a4:	0e878793          	addi	a5,a5,232 # 80028a88 <ftable+0x18>
    800069a8:	fef43423          	sd	a5,-24(s0)
    800069ac:	a815                	j	800069e0 <filealloc+0x58>
    if(f->ref == 0){
    800069ae:	fe843783          	ld	a5,-24(s0)
    800069b2:	43dc                	lw	a5,4(a5)
    800069b4:	e385                	bnez	a5,800069d4 <filealloc+0x4c>
      f->ref = 1;
    800069b6:	fe843783          	ld	a5,-24(s0)
    800069ba:	4705                	li	a4,1
    800069bc:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    800069be:	00022517          	auipc	a0,0x22
    800069c2:	0b250513          	addi	a0,a0,178 # 80028a70 <ftable>
    800069c6:	ffffb097          	auipc	ra,0xffffb
    800069ca:	9ce080e7          	jalr	-1586(ra) # 80001394 <release>
      return f;
    800069ce:	fe843783          	ld	a5,-24(s0)
    800069d2:	a805                	j	80006a02 <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800069d4:	fe843783          	ld	a5,-24(s0)
    800069d8:	02878793          	addi	a5,a5,40
    800069dc:	fef43423          	sd	a5,-24(s0)
    800069e0:	00023797          	auipc	a5,0x23
    800069e4:	04878793          	addi	a5,a5,72 # 80029a28 <disk>
    800069e8:	fe843703          	ld	a4,-24(s0)
    800069ec:	fcf761e3          	bltu	a4,a5,800069ae <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    800069f0:	00022517          	auipc	a0,0x22
    800069f4:	08050513          	addi	a0,a0,128 # 80028a70 <ftable>
    800069f8:	ffffb097          	auipc	ra,0xffffb
    800069fc:	99c080e7          	jalr	-1636(ra) # 80001394 <release>
  return 0;
    80006a00:	4781                	li	a5,0
}
    80006a02:	853e                	mv	a0,a5
    80006a04:	60e2                	ld	ra,24(sp)
    80006a06:	6442                	ld	s0,16(sp)
    80006a08:	6105                	addi	sp,sp,32
    80006a0a:	8082                	ret

0000000080006a0c <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80006a0c:	1101                	addi	sp,sp,-32
    80006a0e:	ec06                	sd	ra,24(sp)
    80006a10:	e822                	sd	s0,16(sp)
    80006a12:	1000                	addi	s0,sp,32
    80006a14:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    80006a18:	00022517          	auipc	a0,0x22
    80006a1c:	05850513          	addi	a0,a0,88 # 80028a70 <ftable>
    80006a20:	ffffb097          	auipc	ra,0xffffb
    80006a24:	910080e7          	jalr	-1776(ra) # 80001330 <acquire>
  if(f->ref < 1)
    80006a28:	fe843783          	ld	a5,-24(s0)
    80006a2c:	43dc                	lw	a5,4(a5)
    80006a2e:	00f04a63          	bgtz	a5,80006a42 <filedup+0x36>
    panic("filedup");
    80006a32:	00007517          	auipc	a0,0x7
    80006a36:	b8e50513          	addi	a0,a0,-1138 # 8000d5c0 <etext+0x5c0>
    80006a3a:	ffffa097          	auipc	ra,0xffffa
    80006a3e:	24e080e7          	jalr	590(ra) # 80000c88 <panic>
  f->ref++;
    80006a42:	fe843783          	ld	a5,-24(s0)
    80006a46:	43dc                	lw	a5,4(a5)
    80006a48:	2785                	addiw	a5,a5,1
    80006a4a:	0007871b          	sext.w	a4,a5
    80006a4e:	fe843783          	ld	a5,-24(s0)
    80006a52:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    80006a54:	00022517          	auipc	a0,0x22
    80006a58:	01c50513          	addi	a0,a0,28 # 80028a70 <ftable>
    80006a5c:	ffffb097          	auipc	ra,0xffffb
    80006a60:	938080e7          	jalr	-1736(ra) # 80001394 <release>
  return f;
    80006a64:	fe843783          	ld	a5,-24(s0)
}
    80006a68:	853e                	mv	a0,a5
    80006a6a:	60e2                	ld	ra,24(sp)
    80006a6c:	6442                	ld	s0,16(sp)
    80006a6e:	6105                	addi	sp,sp,32
    80006a70:	8082                	ret

0000000080006a72 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80006a72:	715d                	addi	sp,sp,-80
    80006a74:	e486                	sd	ra,72(sp)
    80006a76:	e0a2                	sd	s0,64(sp)
    80006a78:	0880                	addi	s0,sp,80
    80006a7a:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    80006a7e:	00022517          	auipc	a0,0x22
    80006a82:	ff250513          	addi	a0,a0,-14 # 80028a70 <ftable>
    80006a86:	ffffb097          	auipc	ra,0xffffb
    80006a8a:	8aa080e7          	jalr	-1878(ra) # 80001330 <acquire>
  if(f->ref < 1)
    80006a8e:	fb843783          	ld	a5,-72(s0)
    80006a92:	43dc                	lw	a5,4(a5)
    80006a94:	00f04a63          	bgtz	a5,80006aa8 <fileclose+0x36>
    panic("fileclose");
    80006a98:	00007517          	auipc	a0,0x7
    80006a9c:	b3050513          	addi	a0,a0,-1232 # 8000d5c8 <etext+0x5c8>
    80006aa0:	ffffa097          	auipc	ra,0xffffa
    80006aa4:	1e8080e7          	jalr	488(ra) # 80000c88 <panic>
  if(--f->ref > 0){
    80006aa8:	fb843783          	ld	a5,-72(s0)
    80006aac:	43dc                	lw	a5,4(a5)
    80006aae:	37fd                	addiw	a5,a5,-1
    80006ab0:	0007871b          	sext.w	a4,a5
    80006ab4:	fb843783          	ld	a5,-72(s0)
    80006ab8:	c3d8                	sw	a4,4(a5)
    80006aba:	fb843783          	ld	a5,-72(s0)
    80006abe:	43dc                	lw	a5,4(a5)
    80006ac0:	00f05b63          	blez	a5,80006ad6 <fileclose+0x64>
    release(&ftable.lock);
    80006ac4:	00022517          	auipc	a0,0x22
    80006ac8:	fac50513          	addi	a0,a0,-84 # 80028a70 <ftable>
    80006acc:	ffffb097          	auipc	ra,0xffffb
    80006ad0:	8c8080e7          	jalr	-1848(ra) # 80001394 <release>
    80006ad4:	a879                	j	80006b72 <fileclose+0x100>
    return;
  }
  ff = *f;
    80006ad6:	fb843783          	ld	a5,-72(s0)
    80006ada:	638c                	ld	a1,0(a5)
    80006adc:	6790                	ld	a2,8(a5)
    80006ade:	6b94                	ld	a3,16(a5)
    80006ae0:	6f98                	ld	a4,24(a5)
    80006ae2:	739c                	ld	a5,32(a5)
    80006ae4:	fcb43423          	sd	a1,-56(s0)
    80006ae8:	fcc43823          	sd	a2,-48(s0)
    80006aec:	fcd43c23          	sd	a3,-40(s0)
    80006af0:	fee43023          	sd	a4,-32(s0)
    80006af4:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80006af8:	fb843783          	ld	a5,-72(s0)
    80006afc:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    80006b00:	fb843783          	ld	a5,-72(s0)
    80006b04:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    80006b08:	00022517          	auipc	a0,0x22
    80006b0c:	f6850513          	addi	a0,a0,-152 # 80028a70 <ftable>
    80006b10:	ffffb097          	auipc	ra,0xffffb
    80006b14:	884080e7          	jalr	-1916(ra) # 80001394 <release>

  if(ff.type == FD_PIPE){
    80006b18:	fc842783          	lw	a5,-56(s0)
    80006b1c:	873e                	mv	a4,a5
    80006b1e:	4785                	li	a5,1
    80006b20:	00f71e63          	bne	a4,a5,80006b3c <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    80006b24:	fd843783          	ld	a5,-40(s0)
    80006b28:	fd144703          	lbu	a4,-47(s0)
    80006b2c:	2701                	sext.w	a4,a4
    80006b2e:	85ba                	mv	a1,a4
    80006b30:	853e                	mv	a0,a5
    80006b32:	00000097          	auipc	ra,0x0
    80006b36:	5a6080e7          	jalr	1446(ra) # 800070d8 <pipeclose>
    80006b3a:	a825                	j	80006b72 <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80006b3c:	fc842783          	lw	a5,-56(s0)
    80006b40:	873e                	mv	a4,a5
    80006b42:	4789                	li	a5,2
    80006b44:	00f70863          	beq	a4,a5,80006b54 <fileclose+0xe2>
    80006b48:	fc842783          	lw	a5,-56(s0)
    80006b4c:	873e                	mv	a4,a5
    80006b4e:	478d                	li	a5,3
    80006b50:	02f71163          	bne	a4,a5,80006b72 <fileclose+0x100>
    begin_op();
    80006b54:	00000097          	auipc	ra,0x0
    80006b58:	884080e7          	jalr	-1916(ra) # 800063d8 <begin_op>
    iput(ff.ip);
    80006b5c:	fe043783          	ld	a5,-32(s0)
    80006b60:	853e                	mv	a0,a5
    80006b62:	fffff097          	auipc	ra,0xfffff
    80006b66:	970080e7          	jalr	-1680(ra) # 800054d2 <iput>
    end_op();
    80006b6a:	00000097          	auipc	ra,0x0
    80006b6e:	930080e7          	jalr	-1744(ra) # 8000649a <end_op>
  }
}
    80006b72:	60a6                	ld	ra,72(sp)
    80006b74:	6406                	ld	s0,64(sp)
    80006b76:	6161                	addi	sp,sp,80
    80006b78:	8082                	ret

0000000080006b7a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80006b7a:	7139                	addi	sp,sp,-64
    80006b7c:	fc06                	sd	ra,56(sp)
    80006b7e:	f822                	sd	s0,48(sp)
    80006b80:	0080                	addi	s0,sp,64
    80006b82:	fca43423          	sd	a0,-56(s0)
    80006b86:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    80006b8a:	ffffc097          	auipc	ra,0xffffc
    80006b8e:	f74080e7          	jalr	-140(ra) # 80002afe <myproc>
    80006b92:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80006b96:	fc843783          	ld	a5,-56(s0)
    80006b9a:	439c                	lw	a5,0(a5)
    80006b9c:	873e                	mv	a4,a5
    80006b9e:	4789                	li	a5,2
    80006ba0:	00f70963          	beq	a4,a5,80006bb2 <filestat+0x38>
    80006ba4:	fc843783          	ld	a5,-56(s0)
    80006ba8:	439c                	lw	a5,0(a5)
    80006baa:	873e                	mv	a4,a5
    80006bac:	478d                	li	a5,3
    80006bae:	06f71263          	bne	a4,a5,80006c12 <filestat+0x98>
    ilock(f->ip);
    80006bb2:	fc843783          	ld	a5,-56(s0)
    80006bb6:	6f9c                	ld	a5,24(a5)
    80006bb8:	853e                	mv	a0,a5
    80006bba:	ffffe097          	auipc	ra,0xffffe
    80006bbe:	78a080e7          	jalr	1930(ra) # 80005344 <ilock>
    stati(f->ip, &st);
    80006bc2:	fc843783          	ld	a5,-56(s0)
    80006bc6:	6f9c                	ld	a5,24(a5)
    80006bc8:	fd040713          	addi	a4,s0,-48
    80006bcc:	85ba                	mv	a1,a4
    80006bce:	853e                	mv	a0,a5
    80006bd0:	fffff097          	auipc	ra,0xfffff
    80006bd4:	cc6080e7          	jalr	-826(ra) # 80005896 <stati>
    iunlock(f->ip);
    80006bd8:	fc843783          	ld	a5,-56(s0)
    80006bdc:	6f9c                	ld	a5,24(a5)
    80006bde:	853e                	mv	a0,a5
    80006be0:	fffff097          	auipc	ra,0xfffff
    80006be4:	898080e7          	jalr	-1896(ra) # 80005478 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80006be8:	fe843783          	ld	a5,-24(s0)
    80006bec:	6bbc                	ld	a5,80(a5)
    80006bee:	fd040713          	addi	a4,s0,-48
    80006bf2:	46e1                	li	a3,24
    80006bf4:	863a                	mv	a2,a4
    80006bf6:	fc043583          	ld	a1,-64(s0)
    80006bfa:	853e                	mv	a0,a5
    80006bfc:	ffffc097          	auipc	ra,0xffffc
    80006c00:	9cc080e7          	jalr	-1588(ra) # 800025c8 <copyout>
    80006c04:	87aa                	mv	a5,a0
    80006c06:	0007d463          	bgez	a5,80006c0e <filestat+0x94>
      return -1;
    80006c0a:	57fd                	li	a5,-1
    80006c0c:	a021                	j	80006c14 <filestat+0x9a>
    return 0;
    80006c0e:	4781                	li	a5,0
    80006c10:	a011                	j	80006c14 <filestat+0x9a>
  }
  return -1;
    80006c12:	57fd                	li	a5,-1
}
    80006c14:	853e                	mv	a0,a5
    80006c16:	70e2                	ld	ra,56(sp)
    80006c18:	7442                	ld	s0,48(sp)
    80006c1a:	6121                	addi	sp,sp,64
    80006c1c:	8082                	ret

0000000080006c1e <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80006c1e:	7139                	addi	sp,sp,-64
    80006c20:	fc06                	sd	ra,56(sp)
    80006c22:	f822                	sd	s0,48(sp)
    80006c24:	0080                	addi	s0,sp,64
    80006c26:	fca43c23          	sd	a0,-40(s0)
    80006c2a:	fcb43823          	sd	a1,-48(s0)
    80006c2e:	87b2                	mv	a5,a2
    80006c30:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    80006c34:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    80006c38:	fd843783          	ld	a5,-40(s0)
    80006c3c:	0087c783          	lbu	a5,8(a5)
    80006c40:	e399                	bnez	a5,80006c46 <fileread+0x28>
    return -1;
    80006c42:	57fd                	li	a5,-1
    80006c44:	a23d                	j	80006d72 <fileread+0x154>

  if(f->type == FD_PIPE){
    80006c46:	fd843783          	ld	a5,-40(s0)
    80006c4a:	439c                	lw	a5,0(a5)
    80006c4c:	873e                	mv	a4,a5
    80006c4e:	4785                	li	a5,1
    80006c50:	02f71363          	bne	a4,a5,80006c76 <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    80006c54:	fd843783          	ld	a5,-40(s0)
    80006c58:	6b9c                	ld	a5,16(a5)
    80006c5a:	fcc42703          	lw	a4,-52(s0)
    80006c5e:	863a                	mv	a2,a4
    80006c60:	fd043583          	ld	a1,-48(s0)
    80006c64:	853e                	mv	a0,a5
    80006c66:	00000097          	auipc	ra,0x0
    80006c6a:	66e080e7          	jalr	1646(ra) # 800072d4 <piperead>
    80006c6e:	87aa                	mv	a5,a0
    80006c70:	fef42623          	sw	a5,-20(s0)
    80006c74:	a8ed                	j	80006d6e <fileread+0x150>
  } else if(f->type == FD_DEVICE){
    80006c76:	fd843783          	ld	a5,-40(s0)
    80006c7a:	439c                	lw	a5,0(a5)
    80006c7c:	873e                	mv	a4,a5
    80006c7e:	478d                	li	a5,3
    80006c80:	06f71463          	bne	a4,a5,80006ce8 <fileread+0xca>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80006c84:	fd843783          	ld	a5,-40(s0)
    80006c88:	02479783          	lh	a5,36(a5)
    80006c8c:	0207c663          	bltz	a5,80006cb8 <fileread+0x9a>
    80006c90:	fd843783          	ld	a5,-40(s0)
    80006c94:	02479783          	lh	a5,36(a5)
    80006c98:	873e                	mv	a4,a5
    80006c9a:	47a5                	li	a5,9
    80006c9c:	00e7ce63          	blt	a5,a4,80006cb8 <fileread+0x9a>
    80006ca0:	fd843783          	ld	a5,-40(s0)
    80006ca4:	02479783          	lh	a5,36(a5)
    80006ca8:	00022717          	auipc	a4,0x22
    80006cac:	d2870713          	addi	a4,a4,-728 # 800289d0 <devsw>
    80006cb0:	0792                	slli	a5,a5,0x4
    80006cb2:	97ba                	add	a5,a5,a4
    80006cb4:	639c                	ld	a5,0(a5)
    80006cb6:	e399                	bnez	a5,80006cbc <fileread+0x9e>
      return -1;
    80006cb8:	57fd                	li	a5,-1
    80006cba:	a865                	j	80006d72 <fileread+0x154>
    r = devsw[f->major].read(1, addr, n);
    80006cbc:	fd843783          	ld	a5,-40(s0)
    80006cc0:	02479783          	lh	a5,36(a5)
    80006cc4:	00022717          	auipc	a4,0x22
    80006cc8:	d0c70713          	addi	a4,a4,-756 # 800289d0 <devsw>
    80006ccc:	0792                	slli	a5,a5,0x4
    80006cce:	97ba                	add	a5,a5,a4
    80006cd0:	639c                	ld	a5,0(a5)
    80006cd2:	fcc42703          	lw	a4,-52(s0)
    80006cd6:	863a                	mv	a2,a4
    80006cd8:	fd043583          	ld	a1,-48(s0)
    80006cdc:	4505                	li	a0,1
    80006cde:	9782                	jalr	a5
    80006ce0:	87aa                	mv	a5,a0
    80006ce2:	fef42623          	sw	a5,-20(s0)
    80006ce6:	a061                	j	80006d6e <fileread+0x150>
  } else if(f->type == FD_INODE){
    80006ce8:	fd843783          	ld	a5,-40(s0)
    80006cec:	439c                	lw	a5,0(a5)
    80006cee:	873e                	mv	a4,a5
    80006cf0:	4789                	li	a5,2
    80006cf2:	06f71663          	bne	a4,a5,80006d5e <fileread+0x140>
    ilock(f->ip);
    80006cf6:	fd843783          	ld	a5,-40(s0)
    80006cfa:	6f9c                	ld	a5,24(a5)
    80006cfc:	853e                	mv	a0,a5
    80006cfe:	ffffe097          	auipc	ra,0xffffe
    80006d02:	646080e7          	jalr	1606(ra) # 80005344 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80006d06:	fd843783          	ld	a5,-40(s0)
    80006d0a:	6f88                	ld	a0,24(a5)
    80006d0c:	fd843783          	ld	a5,-40(s0)
    80006d10:	539c                	lw	a5,32(a5)
    80006d12:	fcc42703          	lw	a4,-52(s0)
    80006d16:	86be                	mv	a3,a5
    80006d18:	fd043603          	ld	a2,-48(s0)
    80006d1c:	4585                	li	a1,1
    80006d1e:	fffff097          	auipc	ra,0xfffff
    80006d22:	bdc080e7          	jalr	-1060(ra) # 800058fa <readi>
    80006d26:	87aa                	mv	a5,a0
    80006d28:	fef42623          	sw	a5,-20(s0)
    80006d2c:	fec42783          	lw	a5,-20(s0)
    80006d30:	2781                	sext.w	a5,a5
    80006d32:	00f05d63          	blez	a5,80006d4c <fileread+0x12e>
      f->off += r;
    80006d36:	fd843783          	ld	a5,-40(s0)
    80006d3a:	5398                	lw	a4,32(a5)
    80006d3c:	fec42783          	lw	a5,-20(s0)
    80006d40:	9fb9                	addw	a5,a5,a4
    80006d42:	0007871b          	sext.w	a4,a5
    80006d46:	fd843783          	ld	a5,-40(s0)
    80006d4a:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    80006d4c:	fd843783          	ld	a5,-40(s0)
    80006d50:	6f9c                	ld	a5,24(a5)
    80006d52:	853e                	mv	a0,a5
    80006d54:	ffffe097          	auipc	ra,0xffffe
    80006d58:	724080e7          	jalr	1828(ra) # 80005478 <iunlock>
    80006d5c:	a809                	j	80006d6e <fileread+0x150>
  } else {
    panic("fileread");
    80006d5e:	00007517          	auipc	a0,0x7
    80006d62:	87a50513          	addi	a0,a0,-1926 # 8000d5d8 <etext+0x5d8>
    80006d66:	ffffa097          	auipc	ra,0xffffa
    80006d6a:	f22080e7          	jalr	-222(ra) # 80000c88 <panic>
  }

  return r;
    80006d6e:	fec42783          	lw	a5,-20(s0)
}
    80006d72:	853e                	mv	a0,a5
    80006d74:	70e2                	ld	ra,56(sp)
    80006d76:	7442                	ld	s0,48(sp)
    80006d78:	6121                	addi	sp,sp,64
    80006d7a:	8082                	ret

0000000080006d7c <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80006d7c:	715d                	addi	sp,sp,-80
    80006d7e:	e486                	sd	ra,72(sp)
    80006d80:	e0a2                	sd	s0,64(sp)
    80006d82:	0880                	addi	s0,sp,80
    80006d84:	fca43423          	sd	a0,-56(s0)
    80006d88:	fcb43023          	sd	a1,-64(s0)
    80006d8c:	87b2                	mv	a5,a2
    80006d8e:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    80006d92:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    80006d96:	fc843783          	ld	a5,-56(s0)
    80006d9a:	0097c783          	lbu	a5,9(a5)
    80006d9e:	e399                	bnez	a5,80006da4 <filewrite+0x28>
    return -1;
    80006da0:	57fd                	li	a5,-1
    80006da2:	aae1                	j	80006f7a <filewrite+0x1fe>

  if(f->type == FD_PIPE){
    80006da4:	fc843783          	ld	a5,-56(s0)
    80006da8:	439c                	lw	a5,0(a5)
    80006daa:	873e                	mv	a4,a5
    80006dac:	4785                	li	a5,1
    80006dae:	02f71363          	bne	a4,a5,80006dd4 <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    80006db2:	fc843783          	ld	a5,-56(s0)
    80006db6:	6b9c                	ld	a5,16(a5)
    80006db8:	fbc42703          	lw	a4,-68(s0)
    80006dbc:	863a                	mv	a2,a4
    80006dbe:	fc043583          	ld	a1,-64(s0)
    80006dc2:	853e                	mv	a0,a5
    80006dc4:	00000097          	auipc	ra,0x0
    80006dc8:	3bc080e7          	jalr	956(ra) # 80007180 <pipewrite>
    80006dcc:	87aa                	mv	a5,a0
    80006dce:	fef42623          	sw	a5,-20(s0)
    80006dd2:	a255                	j	80006f76 <filewrite+0x1fa>
  } else if(f->type == FD_DEVICE){
    80006dd4:	fc843783          	ld	a5,-56(s0)
    80006dd8:	439c                	lw	a5,0(a5)
    80006dda:	873e                	mv	a4,a5
    80006ddc:	478d                	li	a5,3
    80006dde:	06f71463          	bne	a4,a5,80006e46 <filewrite+0xca>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80006de2:	fc843783          	ld	a5,-56(s0)
    80006de6:	02479783          	lh	a5,36(a5)
    80006dea:	0207c663          	bltz	a5,80006e16 <filewrite+0x9a>
    80006dee:	fc843783          	ld	a5,-56(s0)
    80006df2:	02479783          	lh	a5,36(a5)
    80006df6:	873e                	mv	a4,a5
    80006df8:	47a5                	li	a5,9
    80006dfa:	00e7ce63          	blt	a5,a4,80006e16 <filewrite+0x9a>
    80006dfe:	fc843783          	ld	a5,-56(s0)
    80006e02:	02479783          	lh	a5,36(a5)
    80006e06:	00022717          	auipc	a4,0x22
    80006e0a:	bca70713          	addi	a4,a4,-1078 # 800289d0 <devsw>
    80006e0e:	0792                	slli	a5,a5,0x4
    80006e10:	97ba                	add	a5,a5,a4
    80006e12:	679c                	ld	a5,8(a5)
    80006e14:	e399                	bnez	a5,80006e1a <filewrite+0x9e>
      return -1;
    80006e16:	57fd                	li	a5,-1
    80006e18:	a28d                	j	80006f7a <filewrite+0x1fe>
    ret = devsw[f->major].write(1, addr, n);
    80006e1a:	fc843783          	ld	a5,-56(s0)
    80006e1e:	02479783          	lh	a5,36(a5)
    80006e22:	00022717          	auipc	a4,0x22
    80006e26:	bae70713          	addi	a4,a4,-1106 # 800289d0 <devsw>
    80006e2a:	0792                	slli	a5,a5,0x4
    80006e2c:	97ba                	add	a5,a5,a4
    80006e2e:	679c                	ld	a5,8(a5)
    80006e30:	fbc42703          	lw	a4,-68(s0)
    80006e34:	863a                	mv	a2,a4
    80006e36:	fc043583          	ld	a1,-64(s0)
    80006e3a:	4505                	li	a0,1
    80006e3c:	9782                	jalr	a5
    80006e3e:	87aa                	mv	a5,a0
    80006e40:	fef42623          	sw	a5,-20(s0)
    80006e44:	aa0d                	j	80006f76 <filewrite+0x1fa>
  } else if(f->type == FD_INODE){
    80006e46:	fc843783          	ld	a5,-56(s0)
    80006e4a:	439c                	lw	a5,0(a5)
    80006e4c:	873e                	mv	a4,a5
    80006e4e:	4789                	li	a5,2
    80006e50:	10f71b63          	bne	a4,a5,80006f66 <filewrite+0x1ea>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    80006e54:	6785                	lui	a5,0x1
    80006e56:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    80006e5a:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    80006e5e:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80006e62:	a0f9                	j	80006f30 <filewrite+0x1b4>
      int n1 = n - i;
    80006e64:	fbc42783          	lw	a5,-68(s0)
    80006e68:	873e                	mv	a4,a5
    80006e6a:	fe842783          	lw	a5,-24(s0)
    80006e6e:	40f707bb          	subw	a5,a4,a5
    80006e72:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    80006e76:	fe442783          	lw	a5,-28(s0)
    80006e7a:	873e                	mv	a4,a5
    80006e7c:	fe042783          	lw	a5,-32(s0)
    80006e80:	2701                	sext.w	a4,a4
    80006e82:	2781                	sext.w	a5,a5
    80006e84:	00e7d663          	bge	a5,a4,80006e90 <filewrite+0x114>
        n1 = max;
    80006e88:	fe042783          	lw	a5,-32(s0)
    80006e8c:	fef42223          	sw	a5,-28(s0)

      begin_op();
    80006e90:	fffff097          	auipc	ra,0xfffff
    80006e94:	548080e7          	jalr	1352(ra) # 800063d8 <begin_op>
      ilock(f->ip);
    80006e98:	fc843783          	ld	a5,-56(s0)
    80006e9c:	6f9c                	ld	a5,24(a5)
    80006e9e:	853e                	mv	a0,a5
    80006ea0:	ffffe097          	auipc	ra,0xffffe
    80006ea4:	4a4080e7          	jalr	1188(ra) # 80005344 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80006ea8:	fc843783          	ld	a5,-56(s0)
    80006eac:	6f88                	ld	a0,24(a5)
    80006eae:	fe842703          	lw	a4,-24(s0)
    80006eb2:	fc043783          	ld	a5,-64(s0)
    80006eb6:	00f70633          	add	a2,a4,a5
    80006eba:	fc843783          	ld	a5,-56(s0)
    80006ebe:	539c                	lw	a5,32(a5)
    80006ec0:	fe442703          	lw	a4,-28(s0)
    80006ec4:	86be                	mv	a3,a5
    80006ec6:	4585                	li	a1,1
    80006ec8:	fffff097          	auipc	ra,0xfffff
    80006ecc:	bd0080e7          	jalr	-1072(ra) # 80005a98 <writei>
    80006ed0:	87aa                	mv	a5,a0
    80006ed2:	fcf42e23          	sw	a5,-36(s0)
    80006ed6:	fdc42783          	lw	a5,-36(s0)
    80006eda:	2781                	sext.w	a5,a5
    80006edc:	00f05d63          	blez	a5,80006ef6 <filewrite+0x17a>
        f->off += r;
    80006ee0:	fc843783          	ld	a5,-56(s0)
    80006ee4:	5398                	lw	a4,32(a5)
    80006ee6:	fdc42783          	lw	a5,-36(s0)
    80006eea:	9fb9                	addw	a5,a5,a4
    80006eec:	0007871b          	sext.w	a4,a5
    80006ef0:	fc843783          	ld	a5,-56(s0)
    80006ef4:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    80006ef6:	fc843783          	ld	a5,-56(s0)
    80006efa:	6f9c                	ld	a5,24(a5)
    80006efc:	853e                	mv	a0,a5
    80006efe:	ffffe097          	auipc	ra,0xffffe
    80006f02:	57a080e7          	jalr	1402(ra) # 80005478 <iunlock>
      end_op();
    80006f06:	fffff097          	auipc	ra,0xfffff
    80006f0a:	594080e7          	jalr	1428(ra) # 8000649a <end_op>

      if(r != n1){
    80006f0e:	fdc42783          	lw	a5,-36(s0)
    80006f12:	873e                	mv	a4,a5
    80006f14:	fe442783          	lw	a5,-28(s0)
    80006f18:	2701                	sext.w	a4,a4
    80006f1a:	2781                	sext.w	a5,a5
    80006f1c:	02f71463          	bne	a4,a5,80006f44 <filewrite+0x1c8>
        // error from writei
        break;
      }
      i += r;
    80006f20:	fe842783          	lw	a5,-24(s0)
    80006f24:	873e                	mv	a4,a5
    80006f26:	fdc42783          	lw	a5,-36(s0)
    80006f2a:	9fb9                	addw	a5,a5,a4
    80006f2c:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    80006f30:	fe842783          	lw	a5,-24(s0)
    80006f34:	873e                	mv	a4,a5
    80006f36:	fbc42783          	lw	a5,-68(s0)
    80006f3a:	2701                	sext.w	a4,a4
    80006f3c:	2781                	sext.w	a5,a5
    80006f3e:	f2f743e3          	blt	a4,a5,80006e64 <filewrite+0xe8>
    80006f42:	a011                	j	80006f46 <filewrite+0x1ca>
        break;
    80006f44:	0001                	nop
    }
    ret = (i == n ? n : -1);
    80006f46:	fe842783          	lw	a5,-24(s0)
    80006f4a:	873e                	mv	a4,a5
    80006f4c:	fbc42783          	lw	a5,-68(s0)
    80006f50:	2701                	sext.w	a4,a4
    80006f52:	2781                	sext.w	a5,a5
    80006f54:	00f71563          	bne	a4,a5,80006f5e <filewrite+0x1e2>
    80006f58:	fbc42783          	lw	a5,-68(s0)
    80006f5c:	a011                	j	80006f60 <filewrite+0x1e4>
    80006f5e:	57fd                	li	a5,-1
    80006f60:	fef42623          	sw	a5,-20(s0)
    80006f64:	a809                	j	80006f76 <filewrite+0x1fa>
  } else {
    panic("filewrite");
    80006f66:	00006517          	auipc	a0,0x6
    80006f6a:	68250513          	addi	a0,a0,1666 # 8000d5e8 <etext+0x5e8>
    80006f6e:	ffffa097          	auipc	ra,0xffffa
    80006f72:	d1a080e7          	jalr	-742(ra) # 80000c88 <panic>
  }

  return ret;
    80006f76:	fec42783          	lw	a5,-20(s0)
}
    80006f7a:	853e                	mv	a0,a5
    80006f7c:	60a6                	ld	ra,72(sp)
    80006f7e:	6406                	ld	s0,64(sp)
    80006f80:	6161                	addi	sp,sp,80
    80006f82:	8082                	ret

0000000080006f84 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80006f84:	7179                	addi	sp,sp,-48
    80006f86:	f406                	sd	ra,40(sp)
    80006f88:	f022                	sd	s0,32(sp)
    80006f8a:	1800                	addi	s0,sp,48
    80006f8c:	fca43c23          	sd	a0,-40(s0)
    80006f90:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    80006f94:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    80006f98:	fd043783          	ld	a5,-48(s0)
    80006f9c:	0007b023          	sd	zero,0(a5)
    80006fa0:	fd043783          	ld	a5,-48(s0)
    80006fa4:	6398                	ld	a4,0(a5)
    80006fa6:	fd843783          	ld	a5,-40(s0)
    80006faa:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80006fac:	00000097          	auipc	ra,0x0
    80006fb0:	9dc080e7          	jalr	-1572(ra) # 80006988 <filealloc>
    80006fb4:	872a                	mv	a4,a0
    80006fb6:	fd843783          	ld	a5,-40(s0)
    80006fba:	e398                	sd	a4,0(a5)
    80006fbc:	fd843783          	ld	a5,-40(s0)
    80006fc0:	639c                	ld	a5,0(a5)
    80006fc2:	c3e9                	beqz	a5,80007084 <pipealloc+0x100>
    80006fc4:	00000097          	auipc	ra,0x0
    80006fc8:	9c4080e7          	jalr	-1596(ra) # 80006988 <filealloc>
    80006fcc:	872a                	mv	a4,a0
    80006fce:	fd043783          	ld	a5,-48(s0)
    80006fd2:	e398                	sd	a4,0(a5)
    80006fd4:	fd043783          	ld	a5,-48(s0)
    80006fd8:	639c                	ld	a5,0(a5)
    80006fda:	c7cd                	beqz	a5,80007084 <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80006fdc:	ffffa097          	auipc	ra,0xffffa
    80006fe0:	200080e7          	jalr	512(ra) # 800011dc <kalloc>
    80006fe4:	fea43423          	sd	a0,-24(s0)
    80006fe8:	fe843783          	ld	a5,-24(s0)
    80006fec:	cfd1                	beqz	a5,80007088 <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    80006fee:	fe843783          	ld	a5,-24(s0)
    80006ff2:	4705                	li	a4,1
    80006ff4:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    80006ff8:	fe843783          	ld	a5,-24(s0)
    80006ffc:	4705                	li	a4,1
    80006ffe:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    80007002:	fe843783          	ld	a5,-24(s0)
    80007006:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    8000700a:	fe843783          	ld	a5,-24(s0)
    8000700e:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    80007012:	fe843783          	ld	a5,-24(s0)
    80007016:	00006597          	auipc	a1,0x6
    8000701a:	5e258593          	addi	a1,a1,1506 # 8000d5f8 <etext+0x5f8>
    8000701e:	853e                	mv	a0,a5
    80007020:	ffffa097          	auipc	ra,0xffffa
    80007024:	2e0080e7          	jalr	736(ra) # 80001300 <initlock>
  (*f0)->type = FD_PIPE;
    80007028:	fd843783          	ld	a5,-40(s0)
    8000702c:	639c                	ld	a5,0(a5)
    8000702e:	4705                	li	a4,1
    80007030:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    80007032:	fd843783          	ld	a5,-40(s0)
    80007036:	639c                	ld	a5,0(a5)
    80007038:	4705                	li	a4,1
    8000703a:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    8000703e:	fd843783          	ld	a5,-40(s0)
    80007042:	639c                	ld	a5,0(a5)
    80007044:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80007048:	fd843783          	ld	a5,-40(s0)
    8000704c:	639c                	ld	a5,0(a5)
    8000704e:	fe843703          	ld	a4,-24(s0)
    80007052:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    80007054:	fd043783          	ld	a5,-48(s0)
    80007058:	639c                	ld	a5,0(a5)
    8000705a:	4705                	li	a4,1
    8000705c:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    8000705e:	fd043783          	ld	a5,-48(s0)
    80007062:	639c                	ld	a5,0(a5)
    80007064:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80007068:	fd043783          	ld	a5,-48(s0)
    8000706c:	639c                	ld	a5,0(a5)
    8000706e:	4705                	li	a4,1
    80007070:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    80007074:	fd043783          	ld	a5,-48(s0)
    80007078:	639c                	ld	a5,0(a5)
    8000707a:	fe843703          	ld	a4,-24(s0)
    8000707e:	eb98                	sd	a4,16(a5)
  return 0;
    80007080:	4781                	li	a5,0
    80007082:	a0b1                	j	800070ce <pipealloc+0x14a>
    goto bad;
    80007084:	0001                	nop
    80007086:	a011                	j	8000708a <pipealloc+0x106>
    goto bad;
    80007088:	0001                	nop

 bad:
  if(pi)
    8000708a:	fe843783          	ld	a5,-24(s0)
    8000708e:	c799                	beqz	a5,8000709c <pipealloc+0x118>
    kfree((char*)pi);
    80007090:	fe843503          	ld	a0,-24(s0)
    80007094:	ffffa097          	auipc	ra,0xffffa
    80007098:	0a2080e7          	jalr	162(ra) # 80001136 <kfree>
  if(*f0)
    8000709c:	fd843783          	ld	a5,-40(s0)
    800070a0:	639c                	ld	a5,0(a5)
    800070a2:	cb89                	beqz	a5,800070b4 <pipealloc+0x130>
    fileclose(*f0);
    800070a4:	fd843783          	ld	a5,-40(s0)
    800070a8:	639c                	ld	a5,0(a5)
    800070aa:	853e                	mv	a0,a5
    800070ac:	00000097          	auipc	ra,0x0
    800070b0:	9c6080e7          	jalr	-1594(ra) # 80006a72 <fileclose>
  if(*f1)
    800070b4:	fd043783          	ld	a5,-48(s0)
    800070b8:	639c                	ld	a5,0(a5)
    800070ba:	cb89                	beqz	a5,800070cc <pipealloc+0x148>
    fileclose(*f1);
    800070bc:	fd043783          	ld	a5,-48(s0)
    800070c0:	639c                	ld	a5,0(a5)
    800070c2:	853e                	mv	a0,a5
    800070c4:	00000097          	auipc	ra,0x0
    800070c8:	9ae080e7          	jalr	-1618(ra) # 80006a72 <fileclose>
  return -1;
    800070cc:	57fd                	li	a5,-1
}
    800070ce:	853e                	mv	a0,a5
    800070d0:	70a2                	ld	ra,40(sp)
    800070d2:	7402                	ld	s0,32(sp)
    800070d4:	6145                	addi	sp,sp,48
    800070d6:	8082                	ret

00000000800070d8 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800070d8:	1101                	addi	sp,sp,-32
    800070da:	ec06                	sd	ra,24(sp)
    800070dc:	e822                	sd	s0,16(sp)
    800070de:	1000                	addi	s0,sp,32
    800070e0:	fea43423          	sd	a0,-24(s0)
    800070e4:	87ae                	mv	a5,a1
    800070e6:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    800070ea:	fe843783          	ld	a5,-24(s0)
    800070ee:	853e                	mv	a0,a5
    800070f0:	ffffa097          	auipc	ra,0xffffa
    800070f4:	240080e7          	jalr	576(ra) # 80001330 <acquire>
  if(writable){
    800070f8:	fe442783          	lw	a5,-28(s0)
    800070fc:	2781                	sext.w	a5,a5
    800070fe:	cf99                	beqz	a5,8000711c <pipeclose+0x44>
    pi->writeopen = 0;
    80007100:	fe843783          	ld	a5,-24(s0)
    80007104:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    80007108:	fe843783          	ld	a5,-24(s0)
    8000710c:	21878793          	addi	a5,a5,536
    80007110:	853e                	mv	a0,a5
    80007112:	ffffc097          	auipc	ra,0xffffc
    80007116:	632080e7          	jalr	1586(ra) # 80003744 <wakeup>
    8000711a:	a831                	j	80007136 <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    8000711c:	fe843783          	ld	a5,-24(s0)
    80007120:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    80007124:	fe843783          	ld	a5,-24(s0)
    80007128:	21c78793          	addi	a5,a5,540
    8000712c:	853e                	mv	a0,a5
    8000712e:	ffffc097          	auipc	ra,0xffffc
    80007132:	616080e7          	jalr	1558(ra) # 80003744 <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80007136:	fe843783          	ld	a5,-24(s0)
    8000713a:	2207a783          	lw	a5,544(a5)
    8000713e:	e785                	bnez	a5,80007166 <pipeclose+0x8e>
    80007140:	fe843783          	ld	a5,-24(s0)
    80007144:	2247a783          	lw	a5,548(a5)
    80007148:	ef99                	bnez	a5,80007166 <pipeclose+0x8e>
    release(&pi->lock);
    8000714a:	fe843783          	ld	a5,-24(s0)
    8000714e:	853e                	mv	a0,a5
    80007150:	ffffa097          	auipc	ra,0xffffa
    80007154:	244080e7          	jalr	580(ra) # 80001394 <release>
    kfree((char*)pi);
    80007158:	fe843503          	ld	a0,-24(s0)
    8000715c:	ffffa097          	auipc	ra,0xffffa
    80007160:	fda080e7          	jalr	-38(ra) # 80001136 <kfree>
    80007164:	a809                	j	80007176 <pipeclose+0x9e>
  } else
    release(&pi->lock);
    80007166:	fe843783          	ld	a5,-24(s0)
    8000716a:	853e                	mv	a0,a5
    8000716c:	ffffa097          	auipc	ra,0xffffa
    80007170:	228080e7          	jalr	552(ra) # 80001394 <release>
}
    80007174:	0001                	nop
    80007176:	0001                	nop
    80007178:	60e2                	ld	ra,24(sp)
    8000717a:	6442                	ld	s0,16(sp)
    8000717c:	6105                	addi	sp,sp,32
    8000717e:	8082                	ret

0000000080007180 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80007180:	715d                	addi	sp,sp,-80
    80007182:	e486                	sd	ra,72(sp)
    80007184:	e0a2                	sd	s0,64(sp)
    80007186:	0880                	addi	s0,sp,80
    80007188:	fca43423          	sd	a0,-56(s0)
    8000718c:	fcb43023          	sd	a1,-64(s0)
    80007190:	87b2                	mv	a5,a2
    80007192:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    80007196:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    8000719a:	ffffc097          	auipc	ra,0xffffc
    8000719e:	964080e7          	jalr	-1692(ra) # 80002afe <myproc>
    800071a2:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    800071a6:	fc843783          	ld	a5,-56(s0)
    800071aa:	853e                	mv	a0,a5
    800071ac:	ffffa097          	auipc	ra,0xffffa
    800071b0:	184080e7          	jalr	388(ra) # 80001330 <acquire>
  while(i < n){
    800071b4:	a8f1                	j	80007290 <pipewrite+0x110>
    if(pi->readopen == 0 || killed(pr)){
    800071b6:	fc843783          	ld	a5,-56(s0)
    800071ba:	2207a783          	lw	a5,544(a5)
    800071be:	cb89                	beqz	a5,800071d0 <pipewrite+0x50>
    800071c0:	fe043503          	ld	a0,-32(s0)
    800071c4:	ffffc097          	auipc	ra,0xffffc
    800071c8:	712080e7          	jalr	1810(ra) # 800038d6 <killed>
    800071cc:	87aa                	mv	a5,a0
    800071ce:	cb91                	beqz	a5,800071e2 <pipewrite+0x62>
      release(&pi->lock);
    800071d0:	fc843783          	ld	a5,-56(s0)
    800071d4:	853e                	mv	a0,a5
    800071d6:	ffffa097          	auipc	ra,0xffffa
    800071da:	1be080e7          	jalr	446(ra) # 80001394 <release>
      return -1;
    800071de:	57fd                	li	a5,-1
    800071e0:	a0ed                	j	800072ca <pipewrite+0x14a>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800071e2:	fc843783          	ld	a5,-56(s0)
    800071e6:	21c7a703          	lw	a4,540(a5)
    800071ea:	fc843783          	ld	a5,-56(s0)
    800071ee:	2187a783          	lw	a5,536(a5)
    800071f2:	2007879b          	addiw	a5,a5,512
    800071f6:	2781                	sext.w	a5,a5
    800071f8:	02f71863          	bne	a4,a5,80007228 <pipewrite+0xa8>
      wakeup(&pi->nread);
    800071fc:	fc843783          	ld	a5,-56(s0)
    80007200:	21878793          	addi	a5,a5,536
    80007204:	853e                	mv	a0,a5
    80007206:	ffffc097          	auipc	ra,0xffffc
    8000720a:	53e080e7          	jalr	1342(ra) # 80003744 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    8000720e:	fc843783          	ld	a5,-56(s0)
    80007212:	21c78793          	addi	a5,a5,540
    80007216:	fc843703          	ld	a4,-56(s0)
    8000721a:	85ba                	mv	a1,a4
    8000721c:	853e                	mv	a0,a5
    8000721e:	ffffc097          	auipc	ra,0xffffc
    80007222:	4aa080e7          	jalr	1194(ra) # 800036c8 <sleep>
    80007226:	a0ad                	j	80007290 <pipewrite+0x110>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80007228:	fe043783          	ld	a5,-32(s0)
    8000722c:	6ba8                	ld	a0,80(a5)
    8000722e:	fec42703          	lw	a4,-20(s0)
    80007232:	fc043783          	ld	a5,-64(s0)
    80007236:	973e                	add	a4,a4,a5
    80007238:	fdf40793          	addi	a5,s0,-33
    8000723c:	4685                	li	a3,1
    8000723e:	863a                	mv	a2,a4
    80007240:	85be                	mv	a1,a5
    80007242:	ffffb097          	auipc	ra,0xffffb
    80007246:	454080e7          	jalr	1108(ra) # 80002696 <copyin>
    8000724a:	87aa                	mv	a5,a0
    8000724c:	873e                	mv	a4,a5
    8000724e:	57fd                	li	a5,-1
    80007250:	04f70a63          	beq	a4,a5,800072a4 <pipewrite+0x124>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80007254:	fc843783          	ld	a5,-56(s0)
    80007258:	21c7a783          	lw	a5,540(a5)
    8000725c:	2781                	sext.w	a5,a5
    8000725e:	0017871b          	addiw	a4,a5,1
    80007262:	0007069b          	sext.w	a3,a4
    80007266:	fc843703          	ld	a4,-56(s0)
    8000726a:	20d72e23          	sw	a3,540(a4)
    8000726e:	1ff7f793          	andi	a5,a5,511
    80007272:	2781                	sext.w	a5,a5
    80007274:	fdf44703          	lbu	a4,-33(s0)
    80007278:	fc843683          	ld	a3,-56(s0)
    8000727c:	1782                	slli	a5,a5,0x20
    8000727e:	9381                	srli	a5,a5,0x20
    80007280:	97b6                	add	a5,a5,a3
    80007282:	00e78c23          	sb	a4,24(a5)
      i++;
    80007286:	fec42783          	lw	a5,-20(s0)
    8000728a:	2785                	addiw	a5,a5,1
    8000728c:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80007290:	fec42783          	lw	a5,-20(s0)
    80007294:	873e                	mv	a4,a5
    80007296:	fbc42783          	lw	a5,-68(s0)
    8000729a:	2701                	sext.w	a4,a4
    8000729c:	2781                	sext.w	a5,a5
    8000729e:	f0f74ce3          	blt	a4,a5,800071b6 <pipewrite+0x36>
    800072a2:	a011                	j	800072a6 <pipewrite+0x126>
        break;
    800072a4:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    800072a6:	fc843783          	ld	a5,-56(s0)
    800072aa:	21878793          	addi	a5,a5,536
    800072ae:	853e                	mv	a0,a5
    800072b0:	ffffc097          	auipc	ra,0xffffc
    800072b4:	494080e7          	jalr	1172(ra) # 80003744 <wakeup>
  release(&pi->lock);
    800072b8:	fc843783          	ld	a5,-56(s0)
    800072bc:	853e                	mv	a0,a5
    800072be:	ffffa097          	auipc	ra,0xffffa
    800072c2:	0d6080e7          	jalr	214(ra) # 80001394 <release>

  return i;
    800072c6:	fec42783          	lw	a5,-20(s0)
}
    800072ca:	853e                	mv	a0,a5
    800072cc:	60a6                	ld	ra,72(sp)
    800072ce:	6406                	ld	s0,64(sp)
    800072d0:	6161                	addi	sp,sp,80
    800072d2:	8082                	ret

00000000800072d4 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800072d4:	715d                	addi	sp,sp,-80
    800072d6:	e486                	sd	ra,72(sp)
    800072d8:	e0a2                	sd	s0,64(sp)
    800072da:	0880                	addi	s0,sp,80
    800072dc:	fca43423          	sd	a0,-56(s0)
    800072e0:	fcb43023          	sd	a1,-64(s0)
    800072e4:	87b2                	mv	a5,a2
    800072e6:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    800072ea:	ffffc097          	auipc	ra,0xffffc
    800072ee:	814080e7          	jalr	-2028(ra) # 80002afe <myproc>
    800072f2:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    800072f6:	fc843783          	ld	a5,-56(s0)
    800072fa:	853e                	mv	a0,a5
    800072fc:	ffffa097          	auipc	ra,0xffffa
    80007300:	034080e7          	jalr	52(ra) # 80001330 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007304:	a835                	j	80007340 <piperead+0x6c>
    if(killed(pr)){
    80007306:	fe043503          	ld	a0,-32(s0)
    8000730a:	ffffc097          	auipc	ra,0xffffc
    8000730e:	5cc080e7          	jalr	1484(ra) # 800038d6 <killed>
    80007312:	87aa                	mv	a5,a0
    80007314:	cb91                	beqz	a5,80007328 <piperead+0x54>
      release(&pi->lock);
    80007316:	fc843783          	ld	a5,-56(s0)
    8000731a:	853e                	mv	a0,a5
    8000731c:	ffffa097          	auipc	ra,0xffffa
    80007320:	078080e7          	jalr	120(ra) # 80001394 <release>
      return -1;
    80007324:	57fd                	li	a5,-1
    80007326:	a8e5                	j	8000741e <piperead+0x14a>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80007328:	fc843783          	ld	a5,-56(s0)
    8000732c:	21878793          	addi	a5,a5,536
    80007330:	fc843703          	ld	a4,-56(s0)
    80007334:	85ba                	mv	a1,a4
    80007336:	853e                	mv	a0,a5
    80007338:	ffffc097          	auipc	ra,0xffffc
    8000733c:	390080e7          	jalr	912(ra) # 800036c8 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007340:	fc843783          	ld	a5,-56(s0)
    80007344:	2187a703          	lw	a4,536(a5)
    80007348:	fc843783          	ld	a5,-56(s0)
    8000734c:	21c7a783          	lw	a5,540(a5)
    80007350:	00f71763          	bne	a4,a5,8000735e <piperead+0x8a>
    80007354:	fc843783          	ld	a5,-56(s0)
    80007358:	2247a783          	lw	a5,548(a5)
    8000735c:	f7cd                	bnez	a5,80007306 <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000735e:	fe042623          	sw	zero,-20(s0)
    80007362:	a8bd                	j	800073e0 <piperead+0x10c>
    if(pi->nread == pi->nwrite)
    80007364:	fc843783          	ld	a5,-56(s0)
    80007368:	2187a703          	lw	a4,536(a5)
    8000736c:	fc843783          	ld	a5,-56(s0)
    80007370:	21c7a783          	lw	a5,540(a5)
    80007374:	08f70063          	beq	a4,a5,800073f4 <piperead+0x120>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    80007378:	fc843783          	ld	a5,-56(s0)
    8000737c:	2187a783          	lw	a5,536(a5)
    80007380:	2781                	sext.w	a5,a5
    80007382:	0017871b          	addiw	a4,a5,1
    80007386:	0007069b          	sext.w	a3,a4
    8000738a:	fc843703          	ld	a4,-56(s0)
    8000738e:	20d72c23          	sw	a3,536(a4)
    80007392:	1ff7f793          	andi	a5,a5,511
    80007396:	2781                	sext.w	a5,a5
    80007398:	fc843703          	ld	a4,-56(s0)
    8000739c:	1782                	slli	a5,a5,0x20
    8000739e:	9381                	srli	a5,a5,0x20
    800073a0:	97ba                	add	a5,a5,a4
    800073a2:	0187c783          	lbu	a5,24(a5)
    800073a6:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800073aa:	fe043783          	ld	a5,-32(s0)
    800073ae:	6ba8                	ld	a0,80(a5)
    800073b0:	fec42703          	lw	a4,-20(s0)
    800073b4:	fc043783          	ld	a5,-64(s0)
    800073b8:	97ba                	add	a5,a5,a4
    800073ba:	fdf40713          	addi	a4,s0,-33
    800073be:	4685                	li	a3,1
    800073c0:	863a                	mv	a2,a4
    800073c2:	85be                	mv	a1,a5
    800073c4:	ffffb097          	auipc	ra,0xffffb
    800073c8:	204080e7          	jalr	516(ra) # 800025c8 <copyout>
    800073cc:	87aa                	mv	a5,a0
    800073ce:	873e                	mv	a4,a5
    800073d0:	57fd                	li	a5,-1
    800073d2:	02f70363          	beq	a4,a5,800073f8 <piperead+0x124>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800073d6:	fec42783          	lw	a5,-20(s0)
    800073da:	2785                	addiw	a5,a5,1
    800073dc:	fef42623          	sw	a5,-20(s0)
    800073e0:	fec42783          	lw	a5,-20(s0)
    800073e4:	873e                	mv	a4,a5
    800073e6:	fbc42783          	lw	a5,-68(s0)
    800073ea:	2701                	sext.w	a4,a4
    800073ec:	2781                	sext.w	a5,a5
    800073ee:	f6f74be3          	blt	a4,a5,80007364 <piperead+0x90>
    800073f2:	a021                	j	800073fa <piperead+0x126>
      break;
    800073f4:	0001                	nop
    800073f6:	a011                	j	800073fa <piperead+0x126>
      break;
    800073f8:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800073fa:	fc843783          	ld	a5,-56(s0)
    800073fe:	21c78793          	addi	a5,a5,540
    80007402:	853e                	mv	a0,a5
    80007404:	ffffc097          	auipc	ra,0xffffc
    80007408:	340080e7          	jalr	832(ra) # 80003744 <wakeup>
  release(&pi->lock);
    8000740c:	fc843783          	ld	a5,-56(s0)
    80007410:	853e                	mv	a0,a5
    80007412:	ffffa097          	auipc	ra,0xffffa
    80007416:	f82080e7          	jalr	-126(ra) # 80001394 <release>
  return i;
    8000741a:	fec42783          	lw	a5,-20(s0)
}
    8000741e:	853e                	mv	a0,a5
    80007420:	60a6                	ld	ra,72(sp)
    80007422:	6406                	ld	s0,64(sp)
    80007424:	6161                	addi	sp,sp,80
    80007426:	8082                	ret

0000000080007428 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80007428:	7179                	addi	sp,sp,-48
    8000742a:	f422                	sd	s0,40(sp)
    8000742c:	1800                	addi	s0,sp,48
    8000742e:	87aa                	mv	a5,a0
    80007430:	fcf42e23          	sw	a5,-36(s0)
    int perm = 0;
    80007434:	fe042623          	sw	zero,-20(s0)
    if(flags & 0x1)
    80007438:	fdc42783          	lw	a5,-36(s0)
    8000743c:	8b85                	andi	a5,a5,1
    8000743e:	2781                	sext.w	a5,a5
    80007440:	c781                	beqz	a5,80007448 <flags2perm+0x20>
      perm = PTE_X;
    80007442:	47a1                	li	a5,8
    80007444:	fef42623          	sw	a5,-20(s0)
    if(flags & 0x2)
    80007448:	fdc42783          	lw	a5,-36(s0)
    8000744c:	8b89                	andi	a5,a5,2
    8000744e:	2781                	sext.w	a5,a5
    80007450:	c799                	beqz	a5,8000745e <flags2perm+0x36>
      perm |= PTE_W;
    80007452:	fec42783          	lw	a5,-20(s0)
    80007456:	0047e793          	ori	a5,a5,4
    8000745a:	fef42623          	sw	a5,-20(s0)
    return perm;
    8000745e:	fec42783          	lw	a5,-20(s0)
}
    80007462:	853e                	mv	a0,a5
    80007464:	7422                	ld	s0,40(sp)
    80007466:	6145                	addi	sp,sp,48
    80007468:	8082                	ret

000000008000746a <exec>:

int
exec(char *path, char **argv)
{
    8000746a:	de010113          	addi	sp,sp,-544
    8000746e:	20113c23          	sd	ra,536(sp)
    80007472:	20813823          	sd	s0,528(sp)
    80007476:	20913423          	sd	s1,520(sp)
    8000747a:	1400                	addi	s0,sp,544
    8000747c:	dea43423          	sd	a0,-536(s0)
    80007480:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80007484:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80007488:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    8000748c:	ffffb097          	auipc	ra,0xffffb
    80007490:	672080e7          	jalr	1650(ra) # 80002afe <myproc>
    80007494:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    80007498:	fffff097          	auipc	ra,0xfffff
    8000749c:	f40080e7          	jalr	-192(ra) # 800063d8 <begin_op>

  if((ip = namei(path)) == 0){
    800074a0:	de843503          	ld	a0,-536(s0)
    800074a4:	fffff097          	auipc	ra,0xfffff
    800074a8:	bd0080e7          	jalr	-1072(ra) # 80006074 <namei>
    800074ac:	faa43423          	sd	a0,-88(s0)
    800074b0:	fa843783          	ld	a5,-88(s0)
    800074b4:	e799                	bnez	a5,800074c2 <exec+0x58>
    end_op();
    800074b6:	fffff097          	auipc	ra,0xfffff
    800074ba:	fe4080e7          	jalr	-28(ra) # 8000649a <end_op>
    return -1;
    800074be:	57fd                	li	a5,-1
    800074c0:	a199                	j	80007906 <exec+0x49c>
  }
  ilock(ip);
    800074c2:	fa843503          	ld	a0,-88(s0)
    800074c6:	ffffe097          	auipc	ra,0xffffe
    800074ca:	e7e080e7          	jalr	-386(ra) # 80005344 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800074ce:	e3040793          	addi	a5,s0,-464
    800074d2:	04000713          	li	a4,64
    800074d6:	4681                	li	a3,0
    800074d8:	863e                	mv	a2,a5
    800074da:	4581                	li	a1,0
    800074dc:	fa843503          	ld	a0,-88(s0)
    800074e0:	ffffe097          	auipc	ra,0xffffe
    800074e4:	41a080e7          	jalr	1050(ra) # 800058fa <readi>
    800074e8:	87aa                	mv	a5,a0
    800074ea:	873e                	mv	a4,a5
    800074ec:	04000793          	li	a5,64
    800074f0:	3af71563          	bne	a4,a5,8000789a <exec+0x430>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    800074f4:	e3042783          	lw	a5,-464(s0)
    800074f8:	873e                	mv	a4,a5
    800074fa:	464c47b7          	lui	a5,0x464c4
    800074fe:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80007502:	38f71e63          	bne	a4,a5,8000789e <exec+0x434>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80007506:	f9843503          	ld	a0,-104(s0)
    8000750a:	ffffc097          	auipc	ra,0xffffc
    8000750e:	856080e7          	jalr	-1962(ra) # 80002d60 <proc_pagetable>
    80007512:	faa43023          	sd	a0,-96(s0)
    80007516:	fa043783          	ld	a5,-96(s0)
    8000751a:	38078463          	beqz	a5,800078a2 <exec+0x438>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000751e:	fc042623          	sw	zero,-52(s0)
    80007522:	e5043783          	ld	a5,-432(s0)
    80007526:	fcf42423          	sw	a5,-56(s0)
    8000752a:	a0fd                	j	80007618 <exec+0x1ae>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000752c:	df840793          	addi	a5,s0,-520
    80007530:	fc842683          	lw	a3,-56(s0)
    80007534:	03800713          	li	a4,56
    80007538:	863e                	mv	a2,a5
    8000753a:	4581                	li	a1,0
    8000753c:	fa843503          	ld	a0,-88(s0)
    80007540:	ffffe097          	auipc	ra,0xffffe
    80007544:	3ba080e7          	jalr	954(ra) # 800058fa <readi>
    80007548:	87aa                	mv	a5,a0
    8000754a:	873e                	mv	a4,a5
    8000754c:	03800793          	li	a5,56
    80007550:	34f71b63          	bne	a4,a5,800078a6 <exec+0x43c>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80007554:	df842783          	lw	a5,-520(s0)
    80007558:	873e                	mv	a4,a5
    8000755a:	4785                	li	a5,1
    8000755c:	0af71163          	bne	a4,a5,800075fe <exec+0x194>
      continue;
    if(ph.memsz < ph.filesz)
    80007560:	e2043703          	ld	a4,-480(s0)
    80007564:	e1843783          	ld	a5,-488(s0)
    80007568:	34f76163          	bltu	a4,a5,800078aa <exec+0x440>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    8000756c:	e0843703          	ld	a4,-504(s0)
    80007570:	e2043783          	ld	a5,-480(s0)
    80007574:	973e                	add	a4,a4,a5
    80007576:	e0843783          	ld	a5,-504(s0)
    8000757a:	32f76a63          	bltu	a4,a5,800078ae <exec+0x444>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
    8000757e:	e0843703          	ld	a4,-504(s0)
    80007582:	6785                	lui	a5,0x1
    80007584:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80007586:	8ff9                	and	a5,a5,a4
    80007588:	32079563          	bnez	a5,800078b2 <exec+0x448>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000758c:	e0843703          	ld	a4,-504(s0)
    80007590:	e2043783          	ld	a5,-480(s0)
    80007594:	00f704b3          	add	s1,a4,a5
    80007598:	dfc42783          	lw	a5,-516(s0)
    8000759c:	2781                	sext.w	a5,a5
    8000759e:	853e                	mv	a0,a5
    800075a0:	00000097          	auipc	ra,0x0
    800075a4:	e88080e7          	jalr	-376(ra) # 80007428 <flags2perm>
    800075a8:	87aa                	mv	a5,a0
    800075aa:	86be                	mv	a3,a5
    800075ac:	8626                	mv	a2,s1
    800075ae:	fb843583          	ld	a1,-72(s0)
    800075b2:	fa043503          	ld	a0,-96(s0)
    800075b6:	ffffb097          	auipc	ra,0xffffb
    800075ba:	c26080e7          	jalr	-986(ra) # 800021dc <uvmalloc>
    800075be:	f6a43823          	sd	a0,-144(s0)
    800075c2:	f7043783          	ld	a5,-144(s0)
    800075c6:	2e078863          	beqz	a5,800078b6 <exec+0x44c>
      goto bad;
    sz = sz1;
    800075ca:	f7043783          	ld	a5,-144(s0)
    800075ce:	faf43c23          	sd	a5,-72(s0)
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800075d2:	e0843783          	ld	a5,-504(s0)
    800075d6:	e0043703          	ld	a4,-512(s0)
    800075da:	0007069b          	sext.w	a3,a4
    800075de:	e1843703          	ld	a4,-488(s0)
    800075e2:	2701                	sext.w	a4,a4
    800075e4:	fa843603          	ld	a2,-88(s0)
    800075e8:	85be                	mv	a1,a5
    800075ea:	fa043503          	ld	a0,-96(s0)
    800075ee:	00000097          	auipc	ra,0x0
    800075f2:	32c080e7          	jalr	812(ra) # 8000791a <loadseg>
    800075f6:	87aa                	mv	a5,a0
    800075f8:	2c07c163          	bltz	a5,800078ba <exec+0x450>
    800075fc:	a011                	j	80007600 <exec+0x196>
      continue;
    800075fe:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007600:	fcc42783          	lw	a5,-52(s0)
    80007604:	2785                	addiw	a5,a5,1
    80007606:	fcf42623          	sw	a5,-52(s0)
    8000760a:	fc842783          	lw	a5,-56(s0)
    8000760e:	0387879b          	addiw	a5,a5,56
    80007612:	2781                	sext.w	a5,a5
    80007614:	fcf42423          	sw	a5,-56(s0)
    80007618:	e6845783          	lhu	a5,-408(s0)
    8000761c:	0007871b          	sext.w	a4,a5
    80007620:	fcc42783          	lw	a5,-52(s0)
    80007624:	2781                	sext.w	a5,a5
    80007626:	f0e7c3e3          	blt	a5,a4,8000752c <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    8000762a:	fa843503          	ld	a0,-88(s0)
    8000762e:	ffffe097          	auipc	ra,0xffffe
    80007632:	f74080e7          	jalr	-140(ra) # 800055a2 <iunlockput>
  end_op();
    80007636:	fffff097          	auipc	ra,0xfffff
    8000763a:	e64080e7          	jalr	-412(ra) # 8000649a <end_op>
  ip = 0;
    8000763e:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    80007642:	ffffb097          	auipc	ra,0xffffb
    80007646:	4bc080e7          	jalr	1212(ra) # 80002afe <myproc>
    8000764a:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    8000764e:	f9843783          	ld	a5,-104(s0)
    80007652:	67bc                	ld	a5,72(a5)
    80007654:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible as a stack guard.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    80007658:	fb843703          	ld	a4,-72(s0)
    8000765c:	6785                	lui	a5,0x1
    8000765e:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80007660:	973e                	add	a4,a4,a5
    80007662:	77fd                	lui	a5,0xfffff
    80007664:	8ff9                	and	a5,a5,a4
    80007666:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    8000766a:	fb843703          	ld	a4,-72(s0)
    8000766e:	6789                	lui	a5,0x2
    80007670:	97ba                	add	a5,a5,a4
    80007672:	4691                	li	a3,4
    80007674:	863e                	mv	a2,a5
    80007676:	fb843583          	ld	a1,-72(s0)
    8000767a:	fa043503          	ld	a0,-96(s0)
    8000767e:	ffffb097          	auipc	ra,0xffffb
    80007682:	b5e080e7          	jalr	-1186(ra) # 800021dc <uvmalloc>
    80007686:	f8a43423          	sd	a0,-120(s0)
    8000768a:	f8843783          	ld	a5,-120(s0)
    8000768e:	22078863          	beqz	a5,800078be <exec+0x454>
    goto bad;
  sz = sz1;
    80007692:	f8843783          	ld	a5,-120(s0)
    80007696:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    8000769a:	fb843703          	ld	a4,-72(s0)
    8000769e:	77f9                	lui	a5,0xffffe
    800076a0:	97ba                	add	a5,a5,a4
    800076a2:	85be                	mv	a1,a5
    800076a4:	fa043503          	ld	a0,-96(s0)
    800076a8:	ffffb097          	auipc	ra,0xffffb
    800076ac:	eca080e7          	jalr	-310(ra) # 80002572 <uvmclear>
  sp = sz;
    800076b0:	fb843783          	ld	a5,-72(s0)
    800076b4:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    800076b8:	fb043703          	ld	a4,-80(s0)
    800076bc:	77fd                	lui	a5,0xfffff
    800076be:	97ba                	add	a5,a5,a4
    800076c0:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    800076c4:	fc043023          	sd	zero,-64(s0)
    800076c8:	a07d                	j	80007776 <exec+0x30c>
    if(argc >= MAXARG)
    800076ca:	fc043703          	ld	a4,-64(s0)
    800076ce:	47fd                	li	a5,31
    800076d0:	1ee7e963          	bltu	a5,a4,800078c2 <exec+0x458>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    800076d4:	fc043783          	ld	a5,-64(s0)
    800076d8:	078e                	slli	a5,a5,0x3
    800076da:	de043703          	ld	a4,-544(s0)
    800076de:	97ba                	add	a5,a5,a4
    800076e0:	639c                	ld	a5,0(a5)
    800076e2:	853e                	mv	a0,a5
    800076e4:	ffffa097          	auipc	ra,0xffffa
    800076e8:	2ce080e7          	jalr	718(ra) # 800019b2 <strlen>
    800076ec:	87aa                	mv	a5,a0
    800076ee:	2785                	addiw	a5,a5,1 # fffffffffffff001 <end+0xffffffff7ffd42f1>
    800076f0:	2781                	sext.w	a5,a5
    800076f2:	873e                	mv	a4,a5
    800076f4:	fb043783          	ld	a5,-80(s0)
    800076f8:	8f99                	sub	a5,a5,a4
    800076fa:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800076fe:	fb043783          	ld	a5,-80(s0)
    80007702:	9bc1                	andi	a5,a5,-16
    80007704:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80007708:	fb043703          	ld	a4,-80(s0)
    8000770c:	f8043783          	ld	a5,-128(s0)
    80007710:	1af76b63          	bltu	a4,a5,800078c6 <exec+0x45c>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80007714:	fc043783          	ld	a5,-64(s0)
    80007718:	078e                	slli	a5,a5,0x3
    8000771a:	de043703          	ld	a4,-544(s0)
    8000771e:	97ba                	add	a5,a5,a4
    80007720:	6384                	ld	s1,0(a5)
    80007722:	fc043783          	ld	a5,-64(s0)
    80007726:	078e                	slli	a5,a5,0x3
    80007728:	de043703          	ld	a4,-544(s0)
    8000772c:	97ba                	add	a5,a5,a4
    8000772e:	639c                	ld	a5,0(a5)
    80007730:	853e                	mv	a0,a5
    80007732:	ffffa097          	auipc	ra,0xffffa
    80007736:	280080e7          	jalr	640(ra) # 800019b2 <strlen>
    8000773a:	87aa                	mv	a5,a0
    8000773c:	2785                	addiw	a5,a5,1
    8000773e:	2781                	sext.w	a5,a5
    80007740:	86be                	mv	a3,a5
    80007742:	8626                	mv	a2,s1
    80007744:	fb043583          	ld	a1,-80(s0)
    80007748:	fa043503          	ld	a0,-96(s0)
    8000774c:	ffffb097          	auipc	ra,0xffffb
    80007750:	e7c080e7          	jalr	-388(ra) # 800025c8 <copyout>
    80007754:	87aa                	mv	a5,a0
    80007756:	1607ca63          	bltz	a5,800078ca <exec+0x460>
      goto bad;
    ustack[argc] = sp;
    8000775a:	fc043783          	ld	a5,-64(s0)
    8000775e:	078e                	slli	a5,a5,0x3
    80007760:	1781                	addi	a5,a5,-32
    80007762:	97a2                	add	a5,a5,s0
    80007764:	fb043703          	ld	a4,-80(s0)
    80007768:	e8e7b823          	sd	a4,-368(a5)
  for(argc = 0; argv[argc]; argc++) {
    8000776c:	fc043783          	ld	a5,-64(s0)
    80007770:	0785                	addi	a5,a5,1
    80007772:	fcf43023          	sd	a5,-64(s0)
    80007776:	fc043783          	ld	a5,-64(s0)
    8000777a:	078e                	slli	a5,a5,0x3
    8000777c:	de043703          	ld	a4,-544(s0)
    80007780:	97ba                	add	a5,a5,a4
    80007782:	639c                	ld	a5,0(a5)
    80007784:	f3b9                	bnez	a5,800076ca <exec+0x260>
  }
  ustack[argc] = 0;
    80007786:	fc043783          	ld	a5,-64(s0)
    8000778a:	078e                	slli	a5,a5,0x3
    8000778c:	1781                	addi	a5,a5,-32
    8000778e:	97a2                	add	a5,a5,s0
    80007790:	e807b823          	sd	zero,-368(a5)

  // push the array of argv[] pointers.
  sp -= (argc+1) * sizeof(uint64);
    80007794:	fc043783          	ld	a5,-64(s0)
    80007798:	0785                	addi	a5,a5,1
    8000779a:	078e                	slli	a5,a5,0x3
    8000779c:	fb043703          	ld	a4,-80(s0)
    800077a0:	40f707b3          	sub	a5,a4,a5
    800077a4:	faf43823          	sd	a5,-80(s0)
  sp -= sp % 16;
    800077a8:	fb043783          	ld	a5,-80(s0)
    800077ac:	9bc1                	andi	a5,a5,-16
    800077ae:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    800077b2:	fb043703          	ld	a4,-80(s0)
    800077b6:	f8043783          	ld	a5,-128(s0)
    800077ba:	10f76a63          	bltu	a4,a5,800078ce <exec+0x464>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800077be:	fc043783          	ld	a5,-64(s0)
    800077c2:	0785                	addi	a5,a5,1
    800077c4:	00379713          	slli	a4,a5,0x3
    800077c8:	e7040793          	addi	a5,s0,-400
    800077cc:	86ba                	mv	a3,a4
    800077ce:	863e                	mv	a2,a5
    800077d0:	fb043583          	ld	a1,-80(s0)
    800077d4:	fa043503          	ld	a0,-96(s0)
    800077d8:	ffffb097          	auipc	ra,0xffffb
    800077dc:	df0080e7          	jalr	-528(ra) # 800025c8 <copyout>
    800077e0:	87aa                	mv	a5,a0
    800077e2:	0e07c863          	bltz	a5,800078d2 <exec+0x468>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    800077e6:	f9843783          	ld	a5,-104(s0)
    800077ea:	6fbc                	ld	a5,88(a5)
    800077ec:	fb043703          	ld	a4,-80(s0)
    800077f0:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    800077f2:	de843783          	ld	a5,-536(s0)
    800077f6:	fcf43c23          	sd	a5,-40(s0)
    800077fa:	fd843783          	ld	a5,-40(s0)
    800077fe:	fcf43823          	sd	a5,-48(s0)
    80007802:	a025                	j	8000782a <exec+0x3c0>
    if(*s == '/')
    80007804:	fd843783          	ld	a5,-40(s0)
    80007808:	0007c783          	lbu	a5,0(a5)
    8000780c:	873e                	mv	a4,a5
    8000780e:	02f00793          	li	a5,47
    80007812:	00f71763          	bne	a4,a5,80007820 <exec+0x3b6>
      last = s+1;
    80007816:	fd843783          	ld	a5,-40(s0)
    8000781a:	0785                	addi	a5,a5,1
    8000781c:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    80007820:	fd843783          	ld	a5,-40(s0)
    80007824:	0785                	addi	a5,a5,1
    80007826:	fcf43c23          	sd	a5,-40(s0)
    8000782a:	fd843783          	ld	a5,-40(s0)
    8000782e:	0007c783          	lbu	a5,0(a5)
    80007832:	fbe9                	bnez	a5,80007804 <exec+0x39a>
  safestrcpy(p->name, last, sizeof(p->name));
    80007834:	f9843783          	ld	a5,-104(s0)
    80007838:	15878793          	addi	a5,a5,344
    8000783c:	4641                	li	a2,16
    8000783e:	fd043583          	ld	a1,-48(s0)
    80007842:	853e                	mv	a0,a5
    80007844:	ffffa097          	auipc	ra,0xffffa
    80007848:	fc4080e7          	jalr	-60(ra) # 80001808 <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    8000784c:	f9843783          	ld	a5,-104(s0)
    80007850:	6bbc                	ld	a5,80(a5)
    80007852:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    80007856:	f9843783          	ld	a5,-104(s0)
    8000785a:	fa043703          	ld	a4,-96(s0)
    8000785e:	ebb8                	sd	a4,80(a5)
  p->sz = sz;
    80007860:	f9843783          	ld	a5,-104(s0)
    80007864:	fb843703          	ld	a4,-72(s0)
    80007868:	e7b8                	sd	a4,72(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000786a:	f9843783          	ld	a5,-104(s0)
    8000786e:	6fbc                	ld	a5,88(a5)
    80007870:	e4843703          	ld	a4,-440(s0)
    80007874:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80007876:	f9843783          	ld	a5,-104(s0)
    8000787a:	6fbc                	ld	a5,88(a5)
    8000787c:	fb043703          	ld	a4,-80(s0)
    80007880:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80007882:	f9043583          	ld	a1,-112(s0)
    80007886:	f7843503          	ld	a0,-136(s0)
    8000788a:	ffffb097          	auipc	ra,0xffffb
    8000788e:	596080e7          	jalr	1430(ra) # 80002e20 <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80007892:	fc043783          	ld	a5,-64(s0)
    80007896:	2781                	sext.w	a5,a5
    80007898:	a0bd                	j	80007906 <exec+0x49c>
    goto bad;
    8000789a:	0001                	nop
    8000789c:	a825                	j	800078d4 <exec+0x46a>
    goto bad;
    8000789e:	0001                	nop
    800078a0:	a815                	j	800078d4 <exec+0x46a>
    goto bad;
    800078a2:	0001                	nop
    800078a4:	a805                	j	800078d4 <exec+0x46a>
      goto bad;
    800078a6:	0001                	nop
    800078a8:	a035                	j	800078d4 <exec+0x46a>
      goto bad;
    800078aa:	0001                	nop
    800078ac:	a025                	j	800078d4 <exec+0x46a>
      goto bad;
    800078ae:	0001                	nop
    800078b0:	a015                	j	800078d4 <exec+0x46a>
      goto bad;
    800078b2:	0001                	nop
    800078b4:	a005                	j	800078d4 <exec+0x46a>
      goto bad;
    800078b6:	0001                	nop
    800078b8:	a831                	j	800078d4 <exec+0x46a>
      goto bad;
    800078ba:	0001                	nop
    800078bc:	a821                	j	800078d4 <exec+0x46a>
    goto bad;
    800078be:	0001                	nop
    800078c0:	a811                	j	800078d4 <exec+0x46a>
      goto bad;
    800078c2:	0001                	nop
    800078c4:	a801                	j	800078d4 <exec+0x46a>
      goto bad;
    800078c6:	0001                	nop
    800078c8:	a031                	j	800078d4 <exec+0x46a>
      goto bad;
    800078ca:	0001                	nop
    800078cc:	a021                	j	800078d4 <exec+0x46a>
    goto bad;
    800078ce:	0001                	nop
    800078d0:	a011                	j	800078d4 <exec+0x46a>
    goto bad;
    800078d2:	0001                	nop

 bad:
  if(pagetable)
    800078d4:	fa043783          	ld	a5,-96(s0)
    800078d8:	cb89                	beqz	a5,800078ea <exec+0x480>
    proc_freepagetable(pagetable, sz);
    800078da:	fb843583          	ld	a1,-72(s0)
    800078de:	fa043503          	ld	a0,-96(s0)
    800078e2:	ffffb097          	auipc	ra,0xffffb
    800078e6:	53e080e7          	jalr	1342(ra) # 80002e20 <proc_freepagetable>
  if(ip){
    800078ea:	fa843783          	ld	a5,-88(s0)
    800078ee:	cb99                	beqz	a5,80007904 <exec+0x49a>
    iunlockput(ip);
    800078f0:	fa843503          	ld	a0,-88(s0)
    800078f4:	ffffe097          	auipc	ra,0xffffe
    800078f8:	cae080e7          	jalr	-850(ra) # 800055a2 <iunlockput>
    end_op();
    800078fc:	fffff097          	auipc	ra,0xfffff
    80007900:	b9e080e7          	jalr	-1122(ra) # 8000649a <end_op>
  }
  return -1;
    80007904:	57fd                	li	a5,-1
}
    80007906:	853e                	mv	a0,a5
    80007908:	21813083          	ld	ra,536(sp)
    8000790c:	21013403          	ld	s0,528(sp)
    80007910:	20813483          	ld	s1,520(sp)
    80007914:	22010113          	addi	sp,sp,544
    80007918:	8082                	ret

000000008000791a <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    8000791a:	7139                	addi	sp,sp,-64
    8000791c:	fc06                	sd	ra,56(sp)
    8000791e:	f822                	sd	s0,48(sp)
    80007920:	0080                	addi	s0,sp,64
    80007922:	fca43c23          	sd	a0,-40(s0)
    80007926:	fcb43823          	sd	a1,-48(s0)
    8000792a:	fcc43423          	sd	a2,-56(s0)
    8000792e:	87b6                	mv	a5,a3
    80007930:	fcf42223          	sw	a5,-60(s0)
    80007934:	87ba                	mv	a5,a4
    80007936:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    8000793a:	fe042623          	sw	zero,-20(s0)
    8000793e:	a07d                	j	800079ec <loadseg+0xd2>
    pa = walkaddr(pagetable, va + i);
    80007940:	fec46703          	lwu	a4,-20(s0)
    80007944:	fd043783          	ld	a5,-48(s0)
    80007948:	97ba                	add	a5,a5,a4
    8000794a:	85be                	mv	a1,a5
    8000794c:	fd843503          	ld	a0,-40(s0)
    80007950:	ffffa097          	auipc	ra,0xffffa
    80007954:	518080e7          	jalr	1304(ra) # 80001e68 <walkaddr>
    80007958:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    8000795c:	fe043783          	ld	a5,-32(s0)
    80007960:	eb89                	bnez	a5,80007972 <loadseg+0x58>
      panic("loadseg: address should exist");
    80007962:	00006517          	auipc	a0,0x6
    80007966:	c9e50513          	addi	a0,a0,-866 # 8000d600 <etext+0x600>
    8000796a:	ffff9097          	auipc	ra,0xffff9
    8000796e:	31e080e7          	jalr	798(ra) # 80000c88 <panic>
    if(sz - i < PGSIZE)
    80007972:	fc042783          	lw	a5,-64(s0)
    80007976:	873e                	mv	a4,a5
    80007978:	fec42783          	lw	a5,-20(s0)
    8000797c:	40f707bb          	subw	a5,a4,a5
    80007980:	2781                	sext.w	a5,a5
    80007982:	873e                	mv	a4,a5
    80007984:	6785                	lui	a5,0x1
    80007986:	00f77c63          	bgeu	a4,a5,8000799e <loadseg+0x84>
      n = sz - i;
    8000798a:	fc042783          	lw	a5,-64(s0)
    8000798e:	873e                	mv	a4,a5
    80007990:	fec42783          	lw	a5,-20(s0)
    80007994:	40f707bb          	subw	a5,a4,a5
    80007998:	fef42423          	sw	a5,-24(s0)
    8000799c:	a021                	j	800079a4 <loadseg+0x8a>
    else
      n = PGSIZE;
    8000799e:	6785                	lui	a5,0x1
    800079a0:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800079a4:	fc442783          	lw	a5,-60(s0)
    800079a8:	873e                	mv	a4,a5
    800079aa:	fec42783          	lw	a5,-20(s0)
    800079ae:	9fb9                	addw	a5,a5,a4
    800079b0:	2781                	sext.w	a5,a5
    800079b2:	fe842703          	lw	a4,-24(s0)
    800079b6:	86be                	mv	a3,a5
    800079b8:	fe043603          	ld	a2,-32(s0)
    800079bc:	4581                	li	a1,0
    800079be:	fc843503          	ld	a0,-56(s0)
    800079c2:	ffffe097          	auipc	ra,0xffffe
    800079c6:	f38080e7          	jalr	-200(ra) # 800058fa <readi>
    800079ca:	87aa                	mv	a5,a0
    800079cc:	0007871b          	sext.w	a4,a5
    800079d0:	fe842783          	lw	a5,-24(s0)
    800079d4:	2781                	sext.w	a5,a5
    800079d6:	00e78463          	beq	a5,a4,800079de <loadseg+0xc4>
      return -1;
    800079da:	57fd                	li	a5,-1
    800079dc:	a015                	j	80007a00 <loadseg+0xe6>
  for(i = 0; i < sz; i += PGSIZE){
    800079de:	fec42783          	lw	a5,-20(s0)
    800079e2:	873e                	mv	a4,a5
    800079e4:	6785                	lui	a5,0x1
    800079e6:	9fb9                	addw	a5,a5,a4
    800079e8:	fef42623          	sw	a5,-20(s0)
    800079ec:	fec42783          	lw	a5,-20(s0)
    800079f0:	873e                	mv	a4,a5
    800079f2:	fc042783          	lw	a5,-64(s0)
    800079f6:	2701                	sext.w	a4,a4
    800079f8:	2781                	sext.w	a5,a5
    800079fa:	f4f763e3          	bltu	a4,a5,80007940 <loadseg+0x26>
  }
  
  return 0;
    800079fe:	4781                	li	a5,0
}
    80007a00:	853e                	mv	a0,a5
    80007a02:	70e2                	ld	ra,56(sp)
    80007a04:	7442                	ld	s0,48(sp)
    80007a06:	6121                	addi	sp,sp,64
    80007a08:	8082                	ret

0000000080007a0a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80007a0a:	7139                	addi	sp,sp,-64
    80007a0c:	fc06                	sd	ra,56(sp)
    80007a0e:	f822                	sd	s0,48(sp)
    80007a10:	0080                	addi	s0,sp,64
    80007a12:	87aa                	mv	a5,a0
    80007a14:	fcb43823          	sd	a1,-48(s0)
    80007a18:	fcc43423          	sd	a2,-56(s0)
    80007a1c:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  argint(n, &fd);
    80007a20:	fe440713          	addi	a4,s0,-28
    80007a24:	fdc42783          	lw	a5,-36(s0)
    80007a28:	85ba                	mv	a1,a4
    80007a2a:	853e                	mv	a0,a5
    80007a2c:	ffffd097          	auipc	ra,0xffffd
    80007a30:	98e080e7          	jalr	-1650(ra) # 800043ba <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80007a34:	fe442783          	lw	a5,-28(s0)
    80007a38:	0207c863          	bltz	a5,80007a68 <argfd+0x5e>
    80007a3c:	fe442783          	lw	a5,-28(s0)
    80007a40:	873e                	mv	a4,a5
    80007a42:	47bd                	li	a5,15
    80007a44:	02e7c263          	blt	a5,a4,80007a68 <argfd+0x5e>
    80007a48:	ffffb097          	auipc	ra,0xffffb
    80007a4c:	0b6080e7          	jalr	182(ra) # 80002afe <myproc>
    80007a50:	872a                	mv	a4,a0
    80007a52:	fe442783          	lw	a5,-28(s0)
    80007a56:	07e9                	addi	a5,a5,26 # 101a <_entry-0x7fffefe6>
    80007a58:	078e                	slli	a5,a5,0x3
    80007a5a:	97ba                	add	a5,a5,a4
    80007a5c:	639c                	ld	a5,0(a5)
    80007a5e:	fef43423          	sd	a5,-24(s0)
    80007a62:	fe843783          	ld	a5,-24(s0)
    80007a66:	e399                	bnez	a5,80007a6c <argfd+0x62>
    return -1;
    80007a68:	57fd                	li	a5,-1
    80007a6a:	a015                	j	80007a8e <argfd+0x84>
  if(pfd)
    80007a6c:	fd043783          	ld	a5,-48(s0)
    80007a70:	c791                	beqz	a5,80007a7c <argfd+0x72>
    *pfd = fd;
    80007a72:	fe442703          	lw	a4,-28(s0)
    80007a76:	fd043783          	ld	a5,-48(s0)
    80007a7a:	c398                	sw	a4,0(a5)
  if(pf)
    80007a7c:	fc843783          	ld	a5,-56(s0)
    80007a80:	c791                	beqz	a5,80007a8c <argfd+0x82>
    *pf = f;
    80007a82:	fc843783          	ld	a5,-56(s0)
    80007a86:	fe843703          	ld	a4,-24(s0)
    80007a8a:	e398                	sd	a4,0(a5)
  return 0;
    80007a8c:	4781                	li	a5,0
}
    80007a8e:	853e                	mv	a0,a5
    80007a90:	70e2                	ld	ra,56(sp)
    80007a92:	7442                	ld	s0,48(sp)
    80007a94:	6121                	addi	sp,sp,64
    80007a96:	8082                	ret

0000000080007a98 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80007a98:	7179                	addi	sp,sp,-48
    80007a9a:	f406                	sd	ra,40(sp)
    80007a9c:	f022                	sd	s0,32(sp)
    80007a9e:	1800                	addi	s0,sp,48
    80007aa0:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    80007aa4:	ffffb097          	auipc	ra,0xffffb
    80007aa8:	05a080e7          	jalr	90(ra) # 80002afe <myproc>
    80007aac:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    80007ab0:	fe042623          	sw	zero,-20(s0)
    80007ab4:	a825                	j	80007aec <fdalloc+0x54>
    if(p->ofile[fd] == 0){
    80007ab6:	fe043703          	ld	a4,-32(s0)
    80007aba:	fec42783          	lw	a5,-20(s0)
    80007abe:	07e9                	addi	a5,a5,26
    80007ac0:	078e                	slli	a5,a5,0x3
    80007ac2:	97ba                	add	a5,a5,a4
    80007ac4:	639c                	ld	a5,0(a5)
    80007ac6:	ef91                	bnez	a5,80007ae2 <fdalloc+0x4a>
      p->ofile[fd] = f;
    80007ac8:	fe043703          	ld	a4,-32(s0)
    80007acc:	fec42783          	lw	a5,-20(s0)
    80007ad0:	07e9                	addi	a5,a5,26
    80007ad2:	078e                	slli	a5,a5,0x3
    80007ad4:	97ba                	add	a5,a5,a4
    80007ad6:	fd843703          	ld	a4,-40(s0)
    80007ada:	e398                	sd	a4,0(a5)
      return fd;
    80007adc:	fec42783          	lw	a5,-20(s0)
    80007ae0:	a831                	j	80007afc <fdalloc+0x64>
  for(fd = 0; fd < NOFILE; fd++){
    80007ae2:	fec42783          	lw	a5,-20(s0)
    80007ae6:	2785                	addiw	a5,a5,1
    80007ae8:	fef42623          	sw	a5,-20(s0)
    80007aec:	fec42783          	lw	a5,-20(s0)
    80007af0:	0007871b          	sext.w	a4,a5
    80007af4:	47bd                	li	a5,15
    80007af6:	fce7d0e3          	bge	a5,a4,80007ab6 <fdalloc+0x1e>
    }
  }
  return -1;
    80007afa:	57fd                	li	a5,-1
}
    80007afc:	853e                	mv	a0,a5
    80007afe:	70a2                	ld	ra,40(sp)
    80007b00:	7402                	ld	s0,32(sp)
    80007b02:	6145                	addi	sp,sp,48
    80007b04:	8082                	ret

0000000080007b06 <sys_dup>:

uint64
sys_dup(void)
{
    80007b06:	1101                	addi	sp,sp,-32
    80007b08:	ec06                	sd	ra,24(sp)
    80007b0a:	e822                	sd	s0,16(sp)
    80007b0c:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    80007b0e:	fe040793          	addi	a5,s0,-32
    80007b12:	863e                	mv	a2,a5
    80007b14:	4581                	li	a1,0
    80007b16:	4501                	li	a0,0
    80007b18:	00000097          	auipc	ra,0x0
    80007b1c:	ef2080e7          	jalr	-270(ra) # 80007a0a <argfd>
    80007b20:	87aa                	mv	a5,a0
    80007b22:	0007d463          	bgez	a5,80007b2a <sys_dup+0x24>
    return -1;
    80007b26:	57fd                	li	a5,-1
    80007b28:	a81d                	j	80007b5e <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    80007b2a:	fe043783          	ld	a5,-32(s0)
    80007b2e:	853e                	mv	a0,a5
    80007b30:	00000097          	auipc	ra,0x0
    80007b34:	f68080e7          	jalr	-152(ra) # 80007a98 <fdalloc>
    80007b38:	87aa                	mv	a5,a0
    80007b3a:	fef42623          	sw	a5,-20(s0)
    80007b3e:	fec42783          	lw	a5,-20(s0)
    80007b42:	2781                	sext.w	a5,a5
    80007b44:	0007d463          	bgez	a5,80007b4c <sys_dup+0x46>
    return -1;
    80007b48:	57fd                	li	a5,-1
    80007b4a:	a811                	j	80007b5e <sys_dup+0x58>
  filedup(f);
    80007b4c:	fe043783          	ld	a5,-32(s0)
    80007b50:	853e                	mv	a0,a5
    80007b52:	fffff097          	auipc	ra,0xfffff
    80007b56:	eba080e7          	jalr	-326(ra) # 80006a0c <filedup>
  return fd;
    80007b5a:	fec42783          	lw	a5,-20(s0)
}
    80007b5e:	853e                	mv	a0,a5
    80007b60:	60e2                	ld	ra,24(sp)
    80007b62:	6442                	ld	s0,16(sp)
    80007b64:	6105                	addi	sp,sp,32
    80007b66:	8082                	ret

0000000080007b68 <sys_read>:

uint64
sys_read(void)
{
    80007b68:	7179                	addi	sp,sp,-48
    80007b6a:	f406                	sd	ra,40(sp)
    80007b6c:	f022                	sd	s0,32(sp)
    80007b6e:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  argaddr(1, &p);
    80007b70:	fd840793          	addi	a5,s0,-40
    80007b74:	85be                	mv	a1,a5
    80007b76:	4505                	li	a0,1
    80007b78:	ffffd097          	auipc	ra,0xffffd
    80007b7c:	878080e7          	jalr	-1928(ra) # 800043f0 <argaddr>
  argint(2, &n);
    80007b80:	fe440793          	addi	a5,s0,-28
    80007b84:	85be                	mv	a1,a5
    80007b86:	4509                	li	a0,2
    80007b88:	ffffd097          	auipc	ra,0xffffd
    80007b8c:	832080e7          	jalr	-1998(ra) # 800043ba <argint>
  if(argfd(0, 0, &f) < 0)
    80007b90:	fe840793          	addi	a5,s0,-24
    80007b94:	863e                	mv	a2,a5
    80007b96:	4581                	li	a1,0
    80007b98:	4501                	li	a0,0
    80007b9a:	00000097          	auipc	ra,0x0
    80007b9e:	e70080e7          	jalr	-400(ra) # 80007a0a <argfd>
    80007ba2:	87aa                	mv	a5,a0
    80007ba4:	0007d463          	bgez	a5,80007bac <sys_read+0x44>
    return -1;
    80007ba8:	57fd                	li	a5,-1
    80007baa:	a839                	j	80007bc8 <sys_read+0x60>
  return fileread(f, p, n);
    80007bac:	fe843783          	ld	a5,-24(s0)
    80007bb0:	fd843703          	ld	a4,-40(s0)
    80007bb4:	fe442683          	lw	a3,-28(s0)
    80007bb8:	8636                	mv	a2,a3
    80007bba:	85ba                	mv	a1,a4
    80007bbc:	853e                	mv	a0,a5
    80007bbe:	fffff097          	auipc	ra,0xfffff
    80007bc2:	060080e7          	jalr	96(ra) # 80006c1e <fileread>
    80007bc6:	87aa                	mv	a5,a0
}
    80007bc8:	853e                	mv	a0,a5
    80007bca:	70a2                	ld	ra,40(sp)
    80007bcc:	7402                	ld	s0,32(sp)
    80007bce:	6145                	addi	sp,sp,48
    80007bd0:	8082                	ret

0000000080007bd2 <sys_write>:

uint64
sys_write(void)
{
    80007bd2:	7179                	addi	sp,sp,-48
    80007bd4:	f406                	sd	ra,40(sp)
    80007bd6:	f022                	sd	s0,32(sp)
    80007bd8:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;
  
  argaddr(1, &p);
    80007bda:	fd840793          	addi	a5,s0,-40
    80007bde:	85be                	mv	a1,a5
    80007be0:	4505                	li	a0,1
    80007be2:	ffffd097          	auipc	ra,0xffffd
    80007be6:	80e080e7          	jalr	-2034(ra) # 800043f0 <argaddr>
  argint(2, &n);
    80007bea:	fe440793          	addi	a5,s0,-28
    80007bee:	85be                	mv	a1,a5
    80007bf0:	4509                	li	a0,2
    80007bf2:	ffffc097          	auipc	ra,0xffffc
    80007bf6:	7c8080e7          	jalr	1992(ra) # 800043ba <argint>
  if(argfd(0, 0, &f) < 0)
    80007bfa:	fe840793          	addi	a5,s0,-24
    80007bfe:	863e                	mv	a2,a5
    80007c00:	4581                	li	a1,0
    80007c02:	4501                	li	a0,0
    80007c04:	00000097          	auipc	ra,0x0
    80007c08:	e06080e7          	jalr	-506(ra) # 80007a0a <argfd>
    80007c0c:	87aa                	mv	a5,a0
    80007c0e:	0007d463          	bgez	a5,80007c16 <sys_write+0x44>
    return -1;
    80007c12:	57fd                	li	a5,-1
    80007c14:	a839                	j	80007c32 <sys_write+0x60>

  return filewrite(f, p, n);
    80007c16:	fe843783          	ld	a5,-24(s0)
    80007c1a:	fd843703          	ld	a4,-40(s0)
    80007c1e:	fe442683          	lw	a3,-28(s0)
    80007c22:	8636                	mv	a2,a3
    80007c24:	85ba                	mv	a1,a4
    80007c26:	853e                	mv	a0,a5
    80007c28:	fffff097          	auipc	ra,0xfffff
    80007c2c:	154080e7          	jalr	340(ra) # 80006d7c <filewrite>
    80007c30:	87aa                	mv	a5,a0
}
    80007c32:	853e                	mv	a0,a5
    80007c34:	70a2                	ld	ra,40(sp)
    80007c36:	7402                	ld	s0,32(sp)
    80007c38:	6145                	addi	sp,sp,48
    80007c3a:	8082                	ret

0000000080007c3c <sys_close>:

uint64
sys_close(void)
{
    80007c3c:	1101                	addi	sp,sp,-32
    80007c3e:	ec06                	sd	ra,24(sp)
    80007c40:	e822                	sd	s0,16(sp)
    80007c42:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    80007c44:	fe040713          	addi	a4,s0,-32
    80007c48:	fec40793          	addi	a5,s0,-20
    80007c4c:	863a                	mv	a2,a4
    80007c4e:	85be                	mv	a1,a5
    80007c50:	4501                	li	a0,0
    80007c52:	00000097          	auipc	ra,0x0
    80007c56:	db8080e7          	jalr	-584(ra) # 80007a0a <argfd>
    80007c5a:	87aa                	mv	a5,a0
    80007c5c:	0007d463          	bgez	a5,80007c64 <sys_close+0x28>
    return -1;
    80007c60:	57fd                	li	a5,-1
    80007c62:	a02d                	j	80007c8c <sys_close+0x50>
  myproc()->ofile[fd] = 0;
    80007c64:	ffffb097          	auipc	ra,0xffffb
    80007c68:	e9a080e7          	jalr	-358(ra) # 80002afe <myproc>
    80007c6c:	872a                	mv	a4,a0
    80007c6e:	fec42783          	lw	a5,-20(s0)
    80007c72:	07e9                	addi	a5,a5,26
    80007c74:	078e                	slli	a5,a5,0x3
    80007c76:	97ba                	add	a5,a5,a4
    80007c78:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80007c7c:	fe043783          	ld	a5,-32(s0)
    80007c80:	853e                	mv	a0,a5
    80007c82:	fffff097          	auipc	ra,0xfffff
    80007c86:	df0080e7          	jalr	-528(ra) # 80006a72 <fileclose>
  return 0;
    80007c8a:	4781                	li	a5,0
}
    80007c8c:	853e                	mv	a0,a5
    80007c8e:	60e2                	ld	ra,24(sp)
    80007c90:	6442                	ld	s0,16(sp)
    80007c92:	6105                	addi	sp,sp,32
    80007c94:	8082                	ret

0000000080007c96 <sys_fstat>:

uint64
sys_fstat(void)
{
    80007c96:	1101                	addi	sp,sp,-32
    80007c98:	ec06                	sd	ra,24(sp)
    80007c9a:	e822                	sd	s0,16(sp)
    80007c9c:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  argaddr(1, &st);
    80007c9e:	fe040793          	addi	a5,s0,-32
    80007ca2:	85be                	mv	a1,a5
    80007ca4:	4505                	li	a0,1
    80007ca6:	ffffc097          	auipc	ra,0xffffc
    80007caa:	74a080e7          	jalr	1866(ra) # 800043f0 <argaddr>
  if(argfd(0, 0, &f) < 0)
    80007cae:	fe840793          	addi	a5,s0,-24
    80007cb2:	863e                	mv	a2,a5
    80007cb4:	4581                	li	a1,0
    80007cb6:	4501                	li	a0,0
    80007cb8:	00000097          	auipc	ra,0x0
    80007cbc:	d52080e7          	jalr	-686(ra) # 80007a0a <argfd>
    80007cc0:	87aa                	mv	a5,a0
    80007cc2:	0007d463          	bgez	a5,80007cca <sys_fstat+0x34>
    return -1;
    80007cc6:	57fd                	li	a5,-1
    80007cc8:	a821                	j	80007ce0 <sys_fstat+0x4a>
  return filestat(f, st);
    80007cca:	fe843783          	ld	a5,-24(s0)
    80007cce:	fe043703          	ld	a4,-32(s0)
    80007cd2:	85ba                	mv	a1,a4
    80007cd4:	853e                	mv	a0,a5
    80007cd6:	fffff097          	auipc	ra,0xfffff
    80007cda:	ea4080e7          	jalr	-348(ra) # 80006b7a <filestat>
    80007cde:	87aa                	mv	a5,a0
}
    80007ce0:	853e                	mv	a0,a5
    80007ce2:	60e2                	ld	ra,24(sp)
    80007ce4:	6442                	ld	s0,16(sp)
    80007ce6:	6105                	addi	sp,sp,32
    80007ce8:	8082                	ret

0000000080007cea <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80007cea:	7169                	addi	sp,sp,-304
    80007cec:	f606                	sd	ra,296(sp)
    80007cee:	f222                	sd	s0,288(sp)
    80007cf0:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80007cf2:	ed040793          	addi	a5,s0,-304
    80007cf6:	08000613          	li	a2,128
    80007cfa:	85be                	mv	a1,a5
    80007cfc:	4501                	li	a0,0
    80007cfe:	ffffc097          	auipc	ra,0xffffc
    80007d02:	724080e7          	jalr	1828(ra) # 80004422 <argstr>
    80007d06:	87aa                	mv	a5,a0
    80007d08:	0007cf63          	bltz	a5,80007d26 <sys_link+0x3c>
    80007d0c:	f5040793          	addi	a5,s0,-176
    80007d10:	08000613          	li	a2,128
    80007d14:	85be                	mv	a1,a5
    80007d16:	4505                	li	a0,1
    80007d18:	ffffc097          	auipc	ra,0xffffc
    80007d1c:	70a080e7          	jalr	1802(ra) # 80004422 <argstr>
    80007d20:	87aa                	mv	a5,a0
    80007d22:	0007d463          	bgez	a5,80007d2a <sys_link+0x40>
    return -1;
    80007d26:	57fd                	li	a5,-1
    80007d28:	aaad                	j	80007ea2 <sys_link+0x1b8>

  begin_op();
    80007d2a:	ffffe097          	auipc	ra,0xffffe
    80007d2e:	6ae080e7          	jalr	1710(ra) # 800063d8 <begin_op>
  if((ip = namei(old)) == 0){
    80007d32:	ed040793          	addi	a5,s0,-304
    80007d36:	853e                	mv	a0,a5
    80007d38:	ffffe097          	auipc	ra,0xffffe
    80007d3c:	33c080e7          	jalr	828(ra) # 80006074 <namei>
    80007d40:	fea43423          	sd	a0,-24(s0)
    80007d44:	fe843783          	ld	a5,-24(s0)
    80007d48:	e799                	bnez	a5,80007d56 <sys_link+0x6c>
    end_op();
    80007d4a:	ffffe097          	auipc	ra,0xffffe
    80007d4e:	750080e7          	jalr	1872(ra) # 8000649a <end_op>
    return -1;
    80007d52:	57fd                	li	a5,-1
    80007d54:	a2b9                	j	80007ea2 <sys_link+0x1b8>
  }

  ilock(ip);
    80007d56:	fe843503          	ld	a0,-24(s0)
    80007d5a:	ffffd097          	auipc	ra,0xffffd
    80007d5e:	5ea080e7          	jalr	1514(ra) # 80005344 <ilock>
  if(ip->type == T_DIR){
    80007d62:	fe843783          	ld	a5,-24(s0)
    80007d66:	04479783          	lh	a5,68(a5)
    80007d6a:	873e                	mv	a4,a5
    80007d6c:	4785                	li	a5,1
    80007d6e:	00f71e63          	bne	a4,a5,80007d8a <sys_link+0xa0>
    iunlockput(ip);
    80007d72:	fe843503          	ld	a0,-24(s0)
    80007d76:	ffffe097          	auipc	ra,0xffffe
    80007d7a:	82c080e7          	jalr	-2004(ra) # 800055a2 <iunlockput>
    end_op();
    80007d7e:	ffffe097          	auipc	ra,0xffffe
    80007d82:	71c080e7          	jalr	1820(ra) # 8000649a <end_op>
    return -1;
    80007d86:	57fd                	li	a5,-1
    80007d88:	aa29                	j	80007ea2 <sys_link+0x1b8>
  }

  ip->nlink++;
    80007d8a:	fe843783          	ld	a5,-24(s0)
    80007d8e:	04a79783          	lh	a5,74(a5)
    80007d92:	17c2                	slli	a5,a5,0x30
    80007d94:	93c1                	srli	a5,a5,0x30
    80007d96:	2785                	addiw	a5,a5,1
    80007d98:	17c2                	slli	a5,a5,0x30
    80007d9a:	93c1                	srli	a5,a5,0x30
    80007d9c:	0107971b          	slliw	a4,a5,0x10
    80007da0:	4107571b          	sraiw	a4,a4,0x10
    80007da4:	fe843783          	ld	a5,-24(s0)
    80007da8:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007dac:	fe843503          	ld	a0,-24(s0)
    80007db0:	ffffd097          	auipc	ra,0xffffd
    80007db4:	344080e7          	jalr	836(ra) # 800050f4 <iupdate>
  iunlock(ip);
    80007db8:	fe843503          	ld	a0,-24(s0)
    80007dbc:	ffffd097          	auipc	ra,0xffffd
    80007dc0:	6bc080e7          	jalr	1724(ra) # 80005478 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    80007dc4:	fd040713          	addi	a4,s0,-48
    80007dc8:	f5040793          	addi	a5,s0,-176
    80007dcc:	85ba                	mv	a1,a4
    80007dce:	853e                	mv	a0,a5
    80007dd0:	ffffe097          	auipc	ra,0xffffe
    80007dd4:	2d0080e7          	jalr	720(ra) # 800060a0 <nameiparent>
    80007dd8:	fea43023          	sd	a0,-32(s0)
    80007ddc:	fe043783          	ld	a5,-32(s0)
    80007de0:	cba5                	beqz	a5,80007e50 <sys_link+0x166>
    goto bad;
  ilock(dp);
    80007de2:	fe043503          	ld	a0,-32(s0)
    80007de6:	ffffd097          	auipc	ra,0xffffd
    80007dea:	55e080e7          	jalr	1374(ra) # 80005344 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80007dee:	fe043783          	ld	a5,-32(s0)
    80007df2:	4398                	lw	a4,0(a5)
    80007df4:	fe843783          	ld	a5,-24(s0)
    80007df8:	439c                	lw	a5,0(a5)
    80007dfa:	02f71263          	bne	a4,a5,80007e1e <sys_link+0x134>
    80007dfe:	fe843783          	ld	a5,-24(s0)
    80007e02:	43d8                	lw	a4,4(a5)
    80007e04:	fd040793          	addi	a5,s0,-48
    80007e08:	863a                	mv	a2,a4
    80007e0a:	85be                	mv	a1,a5
    80007e0c:	fe043503          	ld	a0,-32(s0)
    80007e10:	ffffe097          	auipc	ra,0xffffe
    80007e14:	f58080e7          	jalr	-168(ra) # 80005d68 <dirlink>
    80007e18:	87aa                	mv	a5,a0
    80007e1a:	0007d963          	bgez	a5,80007e2c <sys_link+0x142>
    iunlockput(dp);
    80007e1e:	fe043503          	ld	a0,-32(s0)
    80007e22:	ffffd097          	auipc	ra,0xffffd
    80007e26:	780080e7          	jalr	1920(ra) # 800055a2 <iunlockput>
    goto bad;
    80007e2a:	a025                	j	80007e52 <sys_link+0x168>
  }
  iunlockput(dp);
    80007e2c:	fe043503          	ld	a0,-32(s0)
    80007e30:	ffffd097          	auipc	ra,0xffffd
    80007e34:	772080e7          	jalr	1906(ra) # 800055a2 <iunlockput>
  iput(ip);
    80007e38:	fe843503          	ld	a0,-24(s0)
    80007e3c:	ffffd097          	auipc	ra,0xffffd
    80007e40:	696080e7          	jalr	1686(ra) # 800054d2 <iput>

  end_op();
    80007e44:	ffffe097          	auipc	ra,0xffffe
    80007e48:	656080e7          	jalr	1622(ra) # 8000649a <end_op>

  return 0;
    80007e4c:	4781                	li	a5,0
    80007e4e:	a891                	j	80007ea2 <sys_link+0x1b8>
    goto bad;
    80007e50:	0001                	nop

bad:
  ilock(ip);
    80007e52:	fe843503          	ld	a0,-24(s0)
    80007e56:	ffffd097          	auipc	ra,0xffffd
    80007e5a:	4ee080e7          	jalr	1262(ra) # 80005344 <ilock>
  ip->nlink--;
    80007e5e:	fe843783          	ld	a5,-24(s0)
    80007e62:	04a79783          	lh	a5,74(a5)
    80007e66:	17c2                	slli	a5,a5,0x30
    80007e68:	93c1                	srli	a5,a5,0x30
    80007e6a:	37fd                	addiw	a5,a5,-1
    80007e6c:	17c2                	slli	a5,a5,0x30
    80007e6e:	93c1                	srli	a5,a5,0x30
    80007e70:	0107971b          	slliw	a4,a5,0x10
    80007e74:	4107571b          	sraiw	a4,a4,0x10
    80007e78:	fe843783          	ld	a5,-24(s0)
    80007e7c:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007e80:	fe843503          	ld	a0,-24(s0)
    80007e84:	ffffd097          	auipc	ra,0xffffd
    80007e88:	270080e7          	jalr	624(ra) # 800050f4 <iupdate>
  iunlockput(ip);
    80007e8c:	fe843503          	ld	a0,-24(s0)
    80007e90:	ffffd097          	auipc	ra,0xffffd
    80007e94:	712080e7          	jalr	1810(ra) # 800055a2 <iunlockput>
  end_op();
    80007e98:	ffffe097          	auipc	ra,0xffffe
    80007e9c:	602080e7          	jalr	1538(ra) # 8000649a <end_op>
  return -1;
    80007ea0:	57fd                	li	a5,-1
}
    80007ea2:	853e                	mv	a0,a5
    80007ea4:	70b2                	ld	ra,296(sp)
    80007ea6:	7412                	ld	s0,288(sp)
    80007ea8:	6155                	addi	sp,sp,304
    80007eaa:	8082                	ret

0000000080007eac <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    80007eac:	7139                	addi	sp,sp,-64
    80007eae:	fc06                	sd	ra,56(sp)
    80007eb0:	f822                	sd	s0,48(sp)
    80007eb2:	0080                	addi	s0,sp,64
    80007eb4:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80007eb8:	02000793          	li	a5,32
    80007ebc:	fef42623          	sw	a5,-20(s0)
    80007ec0:	a0b1                	j	80007f0c <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80007ec2:	fd840793          	addi	a5,s0,-40
    80007ec6:	fec42683          	lw	a3,-20(s0)
    80007eca:	4741                	li	a4,16
    80007ecc:	863e                	mv	a2,a5
    80007ece:	4581                	li	a1,0
    80007ed0:	fc843503          	ld	a0,-56(s0)
    80007ed4:	ffffe097          	auipc	ra,0xffffe
    80007ed8:	a26080e7          	jalr	-1498(ra) # 800058fa <readi>
    80007edc:	87aa                	mv	a5,a0
    80007ede:	873e                	mv	a4,a5
    80007ee0:	47c1                	li	a5,16
    80007ee2:	00f70a63          	beq	a4,a5,80007ef6 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80007ee6:	00005517          	auipc	a0,0x5
    80007eea:	73a50513          	addi	a0,a0,1850 # 8000d620 <etext+0x620>
    80007eee:	ffff9097          	auipc	ra,0xffff9
    80007ef2:	d9a080e7          	jalr	-614(ra) # 80000c88 <panic>
    if(de.inum != 0)
    80007ef6:	fd845783          	lhu	a5,-40(s0)
    80007efa:	c399                	beqz	a5,80007f00 <isdirempty+0x54>
      return 0;
    80007efc:	4781                	li	a5,0
    80007efe:	a839                	j	80007f1c <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80007f00:	fec42783          	lw	a5,-20(s0)
    80007f04:	27c1                	addiw	a5,a5,16
    80007f06:	2781                	sext.w	a5,a5
    80007f08:	fef42623          	sw	a5,-20(s0)
    80007f0c:	fc843783          	ld	a5,-56(s0)
    80007f10:	47f8                	lw	a4,76(a5)
    80007f12:	fec42783          	lw	a5,-20(s0)
    80007f16:	fae7e6e3          	bltu	a5,a4,80007ec2 <isdirempty+0x16>
  }
  return 1;
    80007f1a:	4785                	li	a5,1
}
    80007f1c:	853e                	mv	a0,a5
    80007f1e:	70e2                	ld	ra,56(sp)
    80007f20:	7442                	ld	s0,48(sp)
    80007f22:	6121                	addi	sp,sp,64
    80007f24:	8082                	ret

0000000080007f26 <sys_unlink>:

uint64
sys_unlink(void)
{
    80007f26:	7155                	addi	sp,sp,-208
    80007f28:	e586                	sd	ra,200(sp)
    80007f2a:	e1a2                	sd	s0,192(sp)
    80007f2c:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    80007f2e:	f4040793          	addi	a5,s0,-192
    80007f32:	08000613          	li	a2,128
    80007f36:	85be                	mv	a1,a5
    80007f38:	4501                	li	a0,0
    80007f3a:	ffffc097          	auipc	ra,0xffffc
    80007f3e:	4e8080e7          	jalr	1256(ra) # 80004422 <argstr>
    80007f42:	87aa                	mv	a5,a0
    80007f44:	0007d463          	bgez	a5,80007f4c <sys_unlink+0x26>
    return -1;
    80007f48:	57fd                	li	a5,-1
    80007f4a:	a2d5                	j	8000812e <sys_unlink+0x208>

  begin_op();
    80007f4c:	ffffe097          	auipc	ra,0xffffe
    80007f50:	48c080e7          	jalr	1164(ra) # 800063d8 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80007f54:	fc040713          	addi	a4,s0,-64
    80007f58:	f4040793          	addi	a5,s0,-192
    80007f5c:	85ba                	mv	a1,a4
    80007f5e:	853e                	mv	a0,a5
    80007f60:	ffffe097          	auipc	ra,0xffffe
    80007f64:	140080e7          	jalr	320(ra) # 800060a0 <nameiparent>
    80007f68:	fea43423          	sd	a0,-24(s0)
    80007f6c:	fe843783          	ld	a5,-24(s0)
    80007f70:	e799                	bnez	a5,80007f7e <sys_unlink+0x58>
    end_op();
    80007f72:	ffffe097          	auipc	ra,0xffffe
    80007f76:	528080e7          	jalr	1320(ra) # 8000649a <end_op>
    return -1;
    80007f7a:	57fd                	li	a5,-1
    80007f7c:	aa4d                	j	8000812e <sys_unlink+0x208>
  }

  ilock(dp);
    80007f7e:	fe843503          	ld	a0,-24(s0)
    80007f82:	ffffd097          	auipc	ra,0xffffd
    80007f86:	3c2080e7          	jalr	962(ra) # 80005344 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80007f8a:	fc040793          	addi	a5,s0,-64
    80007f8e:	00005597          	auipc	a1,0x5
    80007f92:	6aa58593          	addi	a1,a1,1706 # 8000d638 <etext+0x638>
    80007f96:	853e                	mv	a0,a5
    80007f98:	ffffe097          	auipc	ra,0xffffe
    80007f9c:	cbc080e7          	jalr	-836(ra) # 80005c54 <namecmp>
    80007fa0:	87aa                	mv	a5,a0
    80007fa2:	16078863          	beqz	a5,80008112 <sys_unlink+0x1ec>
    80007fa6:	fc040793          	addi	a5,s0,-64
    80007faa:	00005597          	auipc	a1,0x5
    80007fae:	69658593          	addi	a1,a1,1686 # 8000d640 <etext+0x640>
    80007fb2:	853e                	mv	a0,a5
    80007fb4:	ffffe097          	auipc	ra,0xffffe
    80007fb8:	ca0080e7          	jalr	-864(ra) # 80005c54 <namecmp>
    80007fbc:	87aa                	mv	a5,a0
    80007fbe:	14078a63          	beqz	a5,80008112 <sys_unlink+0x1ec>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    80007fc2:	f3c40713          	addi	a4,s0,-196
    80007fc6:	fc040793          	addi	a5,s0,-64
    80007fca:	863a                	mv	a2,a4
    80007fcc:	85be                	mv	a1,a5
    80007fce:	fe843503          	ld	a0,-24(s0)
    80007fd2:	ffffe097          	auipc	ra,0xffffe
    80007fd6:	cb0080e7          	jalr	-848(ra) # 80005c82 <dirlookup>
    80007fda:	fea43023          	sd	a0,-32(s0)
    80007fde:	fe043783          	ld	a5,-32(s0)
    80007fe2:	12078a63          	beqz	a5,80008116 <sys_unlink+0x1f0>
    goto bad;
  ilock(ip);
    80007fe6:	fe043503          	ld	a0,-32(s0)
    80007fea:	ffffd097          	auipc	ra,0xffffd
    80007fee:	35a080e7          	jalr	858(ra) # 80005344 <ilock>

  if(ip->nlink < 1)
    80007ff2:	fe043783          	ld	a5,-32(s0)
    80007ff6:	04a79783          	lh	a5,74(a5)
    80007ffa:	00f04a63          	bgtz	a5,8000800e <sys_unlink+0xe8>
    panic("unlink: nlink < 1");
    80007ffe:	00005517          	auipc	a0,0x5
    80008002:	64a50513          	addi	a0,a0,1610 # 8000d648 <etext+0x648>
    80008006:	ffff9097          	auipc	ra,0xffff9
    8000800a:	c82080e7          	jalr	-894(ra) # 80000c88 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    8000800e:	fe043783          	ld	a5,-32(s0)
    80008012:	04479783          	lh	a5,68(a5)
    80008016:	873e                	mv	a4,a5
    80008018:	4785                	li	a5,1
    8000801a:	02f71163          	bne	a4,a5,8000803c <sys_unlink+0x116>
    8000801e:	fe043503          	ld	a0,-32(s0)
    80008022:	00000097          	auipc	ra,0x0
    80008026:	e8a080e7          	jalr	-374(ra) # 80007eac <isdirempty>
    8000802a:	87aa                	mv	a5,a0
    8000802c:	eb81                	bnez	a5,8000803c <sys_unlink+0x116>
    iunlockput(ip);
    8000802e:	fe043503          	ld	a0,-32(s0)
    80008032:	ffffd097          	auipc	ra,0xffffd
    80008036:	570080e7          	jalr	1392(ra) # 800055a2 <iunlockput>
    goto bad;
    8000803a:	a8f9                	j	80008118 <sys_unlink+0x1f2>
  }

  memset(&de, 0, sizeof(de));
    8000803c:	fd040793          	addi	a5,s0,-48
    80008040:	4641                	li	a2,16
    80008042:	4581                	li	a1,0
    80008044:	853e                	mv	a0,a5
    80008046:	ffff9097          	auipc	ra,0xffff9
    8000804a:	4be080e7          	jalr	1214(ra) # 80001504 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000804e:	fd040793          	addi	a5,s0,-48
    80008052:	f3c42683          	lw	a3,-196(s0)
    80008056:	4741                	li	a4,16
    80008058:	863e                	mv	a2,a5
    8000805a:	4581                	li	a1,0
    8000805c:	fe843503          	ld	a0,-24(s0)
    80008060:	ffffe097          	auipc	ra,0xffffe
    80008064:	a38080e7          	jalr	-1480(ra) # 80005a98 <writei>
    80008068:	87aa                	mv	a5,a0
    8000806a:	873e                	mv	a4,a5
    8000806c:	47c1                	li	a5,16
    8000806e:	00f70a63          	beq	a4,a5,80008082 <sys_unlink+0x15c>
    panic("unlink: writei");
    80008072:	00005517          	auipc	a0,0x5
    80008076:	5ee50513          	addi	a0,a0,1518 # 8000d660 <etext+0x660>
    8000807a:	ffff9097          	auipc	ra,0xffff9
    8000807e:	c0e080e7          	jalr	-1010(ra) # 80000c88 <panic>
  if(ip->type == T_DIR){
    80008082:	fe043783          	ld	a5,-32(s0)
    80008086:	04479783          	lh	a5,68(a5)
    8000808a:	873e                	mv	a4,a5
    8000808c:	4785                	li	a5,1
    8000808e:	02f71963          	bne	a4,a5,800080c0 <sys_unlink+0x19a>
    dp->nlink--;
    80008092:	fe843783          	ld	a5,-24(s0)
    80008096:	04a79783          	lh	a5,74(a5)
    8000809a:	17c2                	slli	a5,a5,0x30
    8000809c:	93c1                	srli	a5,a5,0x30
    8000809e:	37fd                	addiw	a5,a5,-1
    800080a0:	17c2                	slli	a5,a5,0x30
    800080a2:	93c1                	srli	a5,a5,0x30
    800080a4:	0107971b          	slliw	a4,a5,0x10
    800080a8:	4107571b          	sraiw	a4,a4,0x10
    800080ac:	fe843783          	ld	a5,-24(s0)
    800080b0:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    800080b4:	fe843503          	ld	a0,-24(s0)
    800080b8:	ffffd097          	auipc	ra,0xffffd
    800080bc:	03c080e7          	jalr	60(ra) # 800050f4 <iupdate>
  }
  iunlockput(dp);
    800080c0:	fe843503          	ld	a0,-24(s0)
    800080c4:	ffffd097          	auipc	ra,0xffffd
    800080c8:	4de080e7          	jalr	1246(ra) # 800055a2 <iunlockput>

  ip->nlink--;
    800080cc:	fe043783          	ld	a5,-32(s0)
    800080d0:	04a79783          	lh	a5,74(a5)
    800080d4:	17c2                	slli	a5,a5,0x30
    800080d6:	93c1                	srli	a5,a5,0x30
    800080d8:	37fd                	addiw	a5,a5,-1
    800080da:	17c2                	slli	a5,a5,0x30
    800080dc:	93c1                	srli	a5,a5,0x30
    800080de:	0107971b          	slliw	a4,a5,0x10
    800080e2:	4107571b          	sraiw	a4,a4,0x10
    800080e6:	fe043783          	ld	a5,-32(s0)
    800080ea:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800080ee:	fe043503          	ld	a0,-32(s0)
    800080f2:	ffffd097          	auipc	ra,0xffffd
    800080f6:	002080e7          	jalr	2(ra) # 800050f4 <iupdate>
  iunlockput(ip);
    800080fa:	fe043503          	ld	a0,-32(s0)
    800080fe:	ffffd097          	auipc	ra,0xffffd
    80008102:	4a4080e7          	jalr	1188(ra) # 800055a2 <iunlockput>

  end_op();
    80008106:	ffffe097          	auipc	ra,0xffffe
    8000810a:	394080e7          	jalr	916(ra) # 8000649a <end_op>

  return 0;
    8000810e:	4781                	li	a5,0
    80008110:	a839                	j	8000812e <sys_unlink+0x208>
    goto bad;
    80008112:	0001                	nop
    80008114:	a011                	j	80008118 <sys_unlink+0x1f2>
    goto bad;
    80008116:	0001                	nop

bad:
  iunlockput(dp);
    80008118:	fe843503          	ld	a0,-24(s0)
    8000811c:	ffffd097          	auipc	ra,0xffffd
    80008120:	486080e7          	jalr	1158(ra) # 800055a2 <iunlockput>
  end_op();
    80008124:	ffffe097          	auipc	ra,0xffffe
    80008128:	376080e7          	jalr	886(ra) # 8000649a <end_op>
  return -1;
    8000812c:	57fd                	li	a5,-1
}
    8000812e:	853e                	mv	a0,a5
    80008130:	60ae                	ld	ra,200(sp)
    80008132:	640e                	ld	s0,192(sp)
    80008134:	6169                	addi	sp,sp,208
    80008136:	8082                	ret

0000000080008138 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    80008138:	7139                	addi	sp,sp,-64
    8000813a:	fc06                	sd	ra,56(sp)
    8000813c:	f822                	sd	s0,48(sp)
    8000813e:	0080                	addi	s0,sp,64
    80008140:	fca43423          	sd	a0,-56(s0)
    80008144:	87ae                	mv	a5,a1
    80008146:	8736                	mv	a4,a3
    80008148:	fcf41323          	sh	a5,-58(s0)
    8000814c:	87b2                	mv	a5,a2
    8000814e:	fcf41223          	sh	a5,-60(s0)
    80008152:	87ba                	mv	a5,a4
    80008154:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80008158:	fd040793          	addi	a5,s0,-48
    8000815c:	85be                	mv	a1,a5
    8000815e:	fc843503          	ld	a0,-56(s0)
    80008162:	ffffe097          	auipc	ra,0xffffe
    80008166:	f3e080e7          	jalr	-194(ra) # 800060a0 <nameiparent>
    8000816a:	fea43423          	sd	a0,-24(s0)
    8000816e:	fe843783          	ld	a5,-24(s0)
    80008172:	e399                	bnez	a5,80008178 <create+0x40>
    return 0;
    80008174:	4781                	li	a5,0
    80008176:	a2dd                	j	8000835c <create+0x224>

  ilock(dp);
    80008178:	fe843503          	ld	a0,-24(s0)
    8000817c:	ffffd097          	auipc	ra,0xffffd
    80008180:	1c8080e7          	jalr	456(ra) # 80005344 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80008184:	fd040793          	addi	a5,s0,-48
    80008188:	4601                	li	a2,0
    8000818a:	85be                	mv	a1,a5
    8000818c:	fe843503          	ld	a0,-24(s0)
    80008190:	ffffe097          	auipc	ra,0xffffe
    80008194:	af2080e7          	jalr	-1294(ra) # 80005c82 <dirlookup>
    80008198:	fea43023          	sd	a0,-32(s0)
    8000819c:	fe043783          	ld	a5,-32(s0)
    800081a0:	cfb9                	beqz	a5,800081fe <create+0xc6>
    iunlockput(dp);
    800081a2:	fe843503          	ld	a0,-24(s0)
    800081a6:	ffffd097          	auipc	ra,0xffffd
    800081aa:	3fc080e7          	jalr	1020(ra) # 800055a2 <iunlockput>
    ilock(ip);
    800081ae:	fe043503          	ld	a0,-32(s0)
    800081b2:	ffffd097          	auipc	ra,0xffffd
    800081b6:	192080e7          	jalr	402(ra) # 80005344 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800081ba:	fc641783          	lh	a5,-58(s0)
    800081be:	0007871b          	sext.w	a4,a5
    800081c2:	4789                	li	a5,2
    800081c4:	02f71563          	bne	a4,a5,800081ee <create+0xb6>
    800081c8:	fe043783          	ld	a5,-32(s0)
    800081cc:	04479783          	lh	a5,68(a5)
    800081d0:	873e                	mv	a4,a5
    800081d2:	4789                	li	a5,2
    800081d4:	00f70a63          	beq	a4,a5,800081e8 <create+0xb0>
    800081d8:	fe043783          	ld	a5,-32(s0)
    800081dc:	04479783          	lh	a5,68(a5)
    800081e0:	873e                	mv	a4,a5
    800081e2:	478d                	li	a5,3
    800081e4:	00f71563          	bne	a4,a5,800081ee <create+0xb6>
      return ip;
    800081e8:	fe043783          	ld	a5,-32(s0)
    800081ec:	aa85                	j	8000835c <create+0x224>
    iunlockput(ip);
    800081ee:	fe043503          	ld	a0,-32(s0)
    800081f2:	ffffd097          	auipc	ra,0xffffd
    800081f6:	3b0080e7          	jalr	944(ra) # 800055a2 <iunlockput>
    return 0;
    800081fa:	4781                	li	a5,0
    800081fc:	a285                	j	8000835c <create+0x224>
  }

  if((ip = ialloc(dp->dev, type)) == 0){
    800081fe:	fe843783          	ld	a5,-24(s0)
    80008202:	439c                	lw	a5,0(a5)
    80008204:	fc641703          	lh	a4,-58(s0)
    80008208:	85ba                	mv	a1,a4
    8000820a:	853e                	mv	a0,a5
    8000820c:	ffffd097          	auipc	ra,0xffffd
    80008210:	dea080e7          	jalr	-534(ra) # 80004ff6 <ialloc>
    80008214:	fea43023          	sd	a0,-32(s0)
    80008218:	fe043783          	ld	a5,-32(s0)
    8000821c:	eb89                	bnez	a5,8000822e <create+0xf6>
    iunlockput(dp);
    8000821e:	fe843503          	ld	a0,-24(s0)
    80008222:	ffffd097          	auipc	ra,0xffffd
    80008226:	380080e7          	jalr	896(ra) # 800055a2 <iunlockput>
    return 0;
    8000822a:	4781                	li	a5,0
    8000822c:	aa05                	j	8000835c <create+0x224>
  }

  ilock(ip);
    8000822e:	fe043503          	ld	a0,-32(s0)
    80008232:	ffffd097          	auipc	ra,0xffffd
    80008236:	112080e7          	jalr	274(ra) # 80005344 <ilock>
  ip->major = major;
    8000823a:	fe043783          	ld	a5,-32(s0)
    8000823e:	fc445703          	lhu	a4,-60(s0)
    80008242:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    80008246:	fe043783          	ld	a5,-32(s0)
    8000824a:	fc245703          	lhu	a4,-62(s0)
    8000824e:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    80008252:	fe043783          	ld	a5,-32(s0)
    80008256:	4705                	li	a4,1
    80008258:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    8000825c:	fe043503          	ld	a0,-32(s0)
    80008260:	ffffd097          	auipc	ra,0xffffd
    80008264:	e94080e7          	jalr	-364(ra) # 800050f4 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    80008268:	fc641783          	lh	a5,-58(s0)
    8000826c:	0007871b          	sext.w	a4,a5
    80008270:	4785                	li	a5,1
    80008272:	04f71463          	bne	a4,a5,800082ba <create+0x182>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80008276:	fe043783          	ld	a5,-32(s0)
    8000827a:	43dc                	lw	a5,4(a5)
    8000827c:	863e                	mv	a2,a5
    8000827e:	00005597          	auipc	a1,0x5
    80008282:	3ba58593          	addi	a1,a1,954 # 8000d638 <etext+0x638>
    80008286:	fe043503          	ld	a0,-32(s0)
    8000828a:	ffffe097          	auipc	ra,0xffffe
    8000828e:	ade080e7          	jalr	-1314(ra) # 80005d68 <dirlink>
    80008292:	87aa                	mv	a5,a0
    80008294:	0807ca63          	bltz	a5,80008328 <create+0x1f0>
    80008298:	fe843783          	ld	a5,-24(s0)
    8000829c:	43dc                	lw	a5,4(a5)
    8000829e:	863e                	mv	a2,a5
    800082a0:	00005597          	auipc	a1,0x5
    800082a4:	3a058593          	addi	a1,a1,928 # 8000d640 <etext+0x640>
    800082a8:	fe043503          	ld	a0,-32(s0)
    800082ac:	ffffe097          	auipc	ra,0xffffe
    800082b0:	abc080e7          	jalr	-1348(ra) # 80005d68 <dirlink>
    800082b4:	87aa                	mv	a5,a0
    800082b6:	0607c963          	bltz	a5,80008328 <create+0x1f0>
      goto fail;
  }

  if(dirlink(dp, name, ip->inum) < 0)
    800082ba:	fe043783          	ld	a5,-32(s0)
    800082be:	43d8                	lw	a4,4(a5)
    800082c0:	fd040793          	addi	a5,s0,-48
    800082c4:	863a                	mv	a2,a4
    800082c6:	85be                	mv	a1,a5
    800082c8:	fe843503          	ld	a0,-24(s0)
    800082cc:	ffffe097          	auipc	ra,0xffffe
    800082d0:	a9c080e7          	jalr	-1380(ra) # 80005d68 <dirlink>
    800082d4:	87aa                	mv	a5,a0
    800082d6:	0407cb63          	bltz	a5,8000832c <create+0x1f4>
    goto fail;

  if(type == T_DIR){
    800082da:	fc641783          	lh	a5,-58(s0)
    800082de:	0007871b          	sext.w	a4,a5
    800082e2:	4785                	li	a5,1
    800082e4:	02f71963          	bne	a4,a5,80008316 <create+0x1de>
    // now that success is guaranteed:
    dp->nlink++;  // for ".."
    800082e8:	fe843783          	ld	a5,-24(s0)
    800082ec:	04a79783          	lh	a5,74(a5)
    800082f0:	17c2                	slli	a5,a5,0x30
    800082f2:	93c1                	srli	a5,a5,0x30
    800082f4:	2785                	addiw	a5,a5,1
    800082f6:	17c2                	slli	a5,a5,0x30
    800082f8:	93c1                	srli	a5,a5,0x30
    800082fa:	0107971b          	slliw	a4,a5,0x10
    800082fe:	4107571b          	sraiw	a4,a4,0x10
    80008302:	fe843783          	ld	a5,-24(s0)
    80008306:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    8000830a:	fe843503          	ld	a0,-24(s0)
    8000830e:	ffffd097          	auipc	ra,0xffffd
    80008312:	de6080e7          	jalr	-538(ra) # 800050f4 <iupdate>
  }

  iunlockput(dp);
    80008316:	fe843503          	ld	a0,-24(s0)
    8000831a:	ffffd097          	auipc	ra,0xffffd
    8000831e:	288080e7          	jalr	648(ra) # 800055a2 <iunlockput>

  return ip;
    80008322:	fe043783          	ld	a5,-32(s0)
    80008326:	a81d                	j	8000835c <create+0x224>
      goto fail;
    80008328:	0001                	nop
    8000832a:	a011                	j	8000832e <create+0x1f6>
    goto fail;
    8000832c:	0001                	nop

 fail:
  // something went wrong. de-allocate ip.
  ip->nlink = 0;
    8000832e:	fe043783          	ld	a5,-32(s0)
    80008332:	04079523          	sh	zero,74(a5)
  iupdate(ip);
    80008336:	fe043503          	ld	a0,-32(s0)
    8000833a:	ffffd097          	auipc	ra,0xffffd
    8000833e:	dba080e7          	jalr	-582(ra) # 800050f4 <iupdate>
  iunlockput(ip);
    80008342:	fe043503          	ld	a0,-32(s0)
    80008346:	ffffd097          	auipc	ra,0xffffd
    8000834a:	25c080e7          	jalr	604(ra) # 800055a2 <iunlockput>
  iunlockput(dp);
    8000834e:	fe843503          	ld	a0,-24(s0)
    80008352:	ffffd097          	auipc	ra,0xffffd
    80008356:	250080e7          	jalr	592(ra) # 800055a2 <iunlockput>
  return 0;
    8000835a:	4781                	li	a5,0
}
    8000835c:	853e                	mv	a0,a5
    8000835e:	70e2                	ld	ra,56(sp)
    80008360:	7442                	ld	s0,48(sp)
    80008362:	6121                	addi	sp,sp,64
    80008364:	8082                	ret

0000000080008366 <sys_open>:

uint64
sys_open(void)
{
    80008366:	7131                	addi	sp,sp,-192
    80008368:	fd06                	sd	ra,184(sp)
    8000836a:	f922                	sd	s0,176(sp)
    8000836c:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    8000836e:	f4c40793          	addi	a5,s0,-180
    80008372:	85be                	mv	a1,a5
    80008374:	4505                	li	a0,1
    80008376:	ffffc097          	auipc	ra,0xffffc
    8000837a:	044080e7          	jalr	68(ra) # 800043ba <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    8000837e:	f5040793          	addi	a5,s0,-176
    80008382:	08000613          	li	a2,128
    80008386:	85be                	mv	a1,a5
    80008388:	4501                	li	a0,0
    8000838a:	ffffc097          	auipc	ra,0xffffc
    8000838e:	098080e7          	jalr	152(ra) # 80004422 <argstr>
    80008392:	87aa                	mv	a5,a0
    80008394:	fef42223          	sw	a5,-28(s0)
    80008398:	fe442783          	lw	a5,-28(s0)
    8000839c:	2781                	sext.w	a5,a5
    8000839e:	0007d463          	bgez	a5,800083a6 <sys_open+0x40>
    return -1;
    800083a2:	57fd                	li	a5,-1
    800083a4:	aafd                	j	800085a2 <sys_open+0x23c>

  begin_op();
    800083a6:	ffffe097          	auipc	ra,0xffffe
    800083aa:	032080e7          	jalr	50(ra) # 800063d8 <begin_op>

  if(omode & O_CREATE){
    800083ae:	f4c42783          	lw	a5,-180(s0)
    800083b2:	2007f793          	andi	a5,a5,512
    800083b6:	2781                	sext.w	a5,a5
    800083b8:	c795                	beqz	a5,800083e4 <sys_open+0x7e>
    ip = create(path, T_FILE, 0, 0);
    800083ba:	f5040793          	addi	a5,s0,-176
    800083be:	4681                	li	a3,0
    800083c0:	4601                	li	a2,0
    800083c2:	4589                	li	a1,2
    800083c4:	853e                	mv	a0,a5
    800083c6:	00000097          	auipc	ra,0x0
    800083ca:	d72080e7          	jalr	-654(ra) # 80008138 <create>
    800083ce:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    800083d2:	fe843783          	ld	a5,-24(s0)
    800083d6:	e7b5                	bnez	a5,80008442 <sys_open+0xdc>
      end_op();
    800083d8:	ffffe097          	auipc	ra,0xffffe
    800083dc:	0c2080e7          	jalr	194(ra) # 8000649a <end_op>
      return -1;
    800083e0:	57fd                	li	a5,-1
    800083e2:	a2c1                	j	800085a2 <sys_open+0x23c>
    }
  } else {
    if((ip = namei(path)) == 0){
    800083e4:	f5040793          	addi	a5,s0,-176
    800083e8:	853e                	mv	a0,a5
    800083ea:	ffffe097          	auipc	ra,0xffffe
    800083ee:	c8a080e7          	jalr	-886(ra) # 80006074 <namei>
    800083f2:	fea43423          	sd	a0,-24(s0)
    800083f6:	fe843783          	ld	a5,-24(s0)
    800083fa:	e799                	bnez	a5,80008408 <sys_open+0xa2>
      end_op();
    800083fc:	ffffe097          	auipc	ra,0xffffe
    80008400:	09e080e7          	jalr	158(ra) # 8000649a <end_op>
      return -1;
    80008404:	57fd                	li	a5,-1
    80008406:	aa71                	j	800085a2 <sys_open+0x23c>
    }
    ilock(ip);
    80008408:	fe843503          	ld	a0,-24(s0)
    8000840c:	ffffd097          	auipc	ra,0xffffd
    80008410:	f38080e7          	jalr	-200(ra) # 80005344 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80008414:	fe843783          	ld	a5,-24(s0)
    80008418:	04479783          	lh	a5,68(a5)
    8000841c:	873e                	mv	a4,a5
    8000841e:	4785                	li	a5,1
    80008420:	02f71163          	bne	a4,a5,80008442 <sys_open+0xdc>
    80008424:	f4c42783          	lw	a5,-180(s0)
    80008428:	cf89                	beqz	a5,80008442 <sys_open+0xdc>
      iunlockput(ip);
    8000842a:	fe843503          	ld	a0,-24(s0)
    8000842e:	ffffd097          	auipc	ra,0xffffd
    80008432:	174080e7          	jalr	372(ra) # 800055a2 <iunlockput>
      end_op();
    80008436:	ffffe097          	auipc	ra,0xffffe
    8000843a:	064080e7          	jalr	100(ra) # 8000649a <end_op>
      return -1;
    8000843e:	57fd                	li	a5,-1
    80008440:	a28d                	j	800085a2 <sys_open+0x23c>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80008442:	fe843783          	ld	a5,-24(s0)
    80008446:	04479783          	lh	a5,68(a5)
    8000844a:	873e                	mv	a4,a5
    8000844c:	478d                	li	a5,3
    8000844e:	02f71c63          	bne	a4,a5,80008486 <sys_open+0x120>
    80008452:	fe843783          	ld	a5,-24(s0)
    80008456:	04679783          	lh	a5,70(a5)
    8000845a:	0007ca63          	bltz	a5,8000846e <sys_open+0x108>
    8000845e:	fe843783          	ld	a5,-24(s0)
    80008462:	04679783          	lh	a5,70(a5)
    80008466:	873e                	mv	a4,a5
    80008468:	47a5                	li	a5,9
    8000846a:	00e7de63          	bge	a5,a4,80008486 <sys_open+0x120>
    iunlockput(ip);
    8000846e:	fe843503          	ld	a0,-24(s0)
    80008472:	ffffd097          	auipc	ra,0xffffd
    80008476:	130080e7          	jalr	304(ra) # 800055a2 <iunlockput>
    end_op();
    8000847a:	ffffe097          	auipc	ra,0xffffe
    8000847e:	020080e7          	jalr	32(ra) # 8000649a <end_op>
    return -1;
    80008482:	57fd                	li	a5,-1
    80008484:	aa39                	j	800085a2 <sys_open+0x23c>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80008486:	ffffe097          	auipc	ra,0xffffe
    8000848a:	502080e7          	jalr	1282(ra) # 80006988 <filealloc>
    8000848e:	fca43c23          	sd	a0,-40(s0)
    80008492:	fd843783          	ld	a5,-40(s0)
    80008496:	cf99                	beqz	a5,800084b4 <sys_open+0x14e>
    80008498:	fd843503          	ld	a0,-40(s0)
    8000849c:	fffff097          	auipc	ra,0xfffff
    800084a0:	5fc080e7          	jalr	1532(ra) # 80007a98 <fdalloc>
    800084a4:	87aa                	mv	a5,a0
    800084a6:	fcf42a23          	sw	a5,-44(s0)
    800084aa:	fd442783          	lw	a5,-44(s0)
    800084ae:	2781                	sext.w	a5,a5
    800084b0:	0207d763          	bgez	a5,800084de <sys_open+0x178>
    if(f)
    800084b4:	fd843783          	ld	a5,-40(s0)
    800084b8:	c799                	beqz	a5,800084c6 <sys_open+0x160>
      fileclose(f);
    800084ba:	fd843503          	ld	a0,-40(s0)
    800084be:	ffffe097          	auipc	ra,0xffffe
    800084c2:	5b4080e7          	jalr	1460(ra) # 80006a72 <fileclose>
    iunlockput(ip);
    800084c6:	fe843503          	ld	a0,-24(s0)
    800084ca:	ffffd097          	auipc	ra,0xffffd
    800084ce:	0d8080e7          	jalr	216(ra) # 800055a2 <iunlockput>
    end_op();
    800084d2:	ffffe097          	auipc	ra,0xffffe
    800084d6:	fc8080e7          	jalr	-56(ra) # 8000649a <end_op>
    return -1;
    800084da:	57fd                	li	a5,-1
    800084dc:	a0d9                	j	800085a2 <sys_open+0x23c>
  }

  if(ip->type == T_DEVICE){
    800084de:	fe843783          	ld	a5,-24(s0)
    800084e2:	04479783          	lh	a5,68(a5)
    800084e6:	873e                	mv	a4,a5
    800084e8:	478d                	li	a5,3
    800084ea:	00f71f63          	bne	a4,a5,80008508 <sys_open+0x1a2>
    f->type = FD_DEVICE;
    800084ee:	fd843783          	ld	a5,-40(s0)
    800084f2:	470d                	li	a4,3
    800084f4:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    800084f6:	fe843783          	ld	a5,-24(s0)
    800084fa:	04679703          	lh	a4,70(a5)
    800084fe:	fd843783          	ld	a5,-40(s0)
    80008502:	02e79223          	sh	a4,36(a5)
    80008506:	a809                	j	80008518 <sys_open+0x1b2>
  } else {
    f->type = FD_INODE;
    80008508:	fd843783          	ld	a5,-40(s0)
    8000850c:	4709                	li	a4,2
    8000850e:	c398                	sw	a4,0(a5)
    f->off = 0;
    80008510:	fd843783          	ld	a5,-40(s0)
    80008514:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80008518:	fd843783          	ld	a5,-40(s0)
    8000851c:	fe843703          	ld	a4,-24(s0)
    80008520:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80008522:	f4c42783          	lw	a5,-180(s0)
    80008526:	8b85                	andi	a5,a5,1
    80008528:	2781                	sext.w	a5,a5
    8000852a:	0017b793          	seqz	a5,a5
    8000852e:	0ff7f793          	zext.b	a5,a5
    80008532:	873e                	mv	a4,a5
    80008534:	fd843783          	ld	a5,-40(s0)
    80008538:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000853c:	f4c42783          	lw	a5,-180(s0)
    80008540:	8b85                	andi	a5,a5,1
    80008542:	2781                	sext.w	a5,a5
    80008544:	e791                	bnez	a5,80008550 <sys_open+0x1ea>
    80008546:	f4c42783          	lw	a5,-180(s0)
    8000854a:	8b89                	andi	a5,a5,2
    8000854c:	2781                	sext.w	a5,a5
    8000854e:	c399                	beqz	a5,80008554 <sys_open+0x1ee>
    80008550:	4785                	li	a5,1
    80008552:	a011                	j	80008556 <sys_open+0x1f0>
    80008554:	4781                	li	a5,0
    80008556:	0ff7f713          	zext.b	a4,a5
    8000855a:	fd843783          	ld	a5,-40(s0)
    8000855e:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80008562:	f4c42783          	lw	a5,-180(s0)
    80008566:	4007f793          	andi	a5,a5,1024
    8000856a:	2781                	sext.w	a5,a5
    8000856c:	cf99                	beqz	a5,8000858a <sys_open+0x224>
    8000856e:	fe843783          	ld	a5,-24(s0)
    80008572:	04479783          	lh	a5,68(a5)
    80008576:	873e                	mv	a4,a5
    80008578:	4789                	li	a5,2
    8000857a:	00f71863          	bne	a4,a5,8000858a <sys_open+0x224>
    itrunc(ip);
    8000857e:	fe843503          	ld	a0,-24(s0)
    80008582:	ffffd097          	auipc	ra,0xffffd
    80008586:	1ca080e7          	jalr	458(ra) # 8000574c <itrunc>
  }

  iunlock(ip);
    8000858a:	fe843503          	ld	a0,-24(s0)
    8000858e:	ffffd097          	auipc	ra,0xffffd
    80008592:	eea080e7          	jalr	-278(ra) # 80005478 <iunlock>
  end_op();
    80008596:	ffffe097          	auipc	ra,0xffffe
    8000859a:	f04080e7          	jalr	-252(ra) # 8000649a <end_op>

  return fd;
    8000859e:	fd442783          	lw	a5,-44(s0)
}
    800085a2:	853e                	mv	a0,a5
    800085a4:	70ea                	ld	ra,184(sp)
    800085a6:	744a                	ld	s0,176(sp)
    800085a8:	6129                	addi	sp,sp,192
    800085aa:	8082                	ret

00000000800085ac <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800085ac:	7135                	addi	sp,sp,-160
    800085ae:	ed06                	sd	ra,152(sp)
    800085b0:	e922                	sd	s0,144(sp)
    800085b2:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800085b4:	ffffe097          	auipc	ra,0xffffe
    800085b8:	e24080e7          	jalr	-476(ra) # 800063d8 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800085bc:	f6840793          	addi	a5,s0,-152
    800085c0:	08000613          	li	a2,128
    800085c4:	85be                	mv	a1,a5
    800085c6:	4501                	li	a0,0
    800085c8:	ffffc097          	auipc	ra,0xffffc
    800085cc:	e5a080e7          	jalr	-422(ra) # 80004422 <argstr>
    800085d0:	87aa                	mv	a5,a0
    800085d2:	0207c163          	bltz	a5,800085f4 <sys_mkdir+0x48>
    800085d6:	f6840793          	addi	a5,s0,-152
    800085da:	4681                	li	a3,0
    800085dc:	4601                	li	a2,0
    800085de:	4585                	li	a1,1
    800085e0:	853e                	mv	a0,a5
    800085e2:	00000097          	auipc	ra,0x0
    800085e6:	b56080e7          	jalr	-1194(ra) # 80008138 <create>
    800085ea:	fea43423          	sd	a0,-24(s0)
    800085ee:	fe843783          	ld	a5,-24(s0)
    800085f2:	e799                	bnez	a5,80008600 <sys_mkdir+0x54>
    end_op();
    800085f4:	ffffe097          	auipc	ra,0xffffe
    800085f8:	ea6080e7          	jalr	-346(ra) # 8000649a <end_op>
    return -1;
    800085fc:	57fd                	li	a5,-1
    800085fe:	a821                	j	80008616 <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    80008600:	fe843503          	ld	a0,-24(s0)
    80008604:	ffffd097          	auipc	ra,0xffffd
    80008608:	f9e080e7          	jalr	-98(ra) # 800055a2 <iunlockput>
  end_op();
    8000860c:	ffffe097          	auipc	ra,0xffffe
    80008610:	e8e080e7          	jalr	-370(ra) # 8000649a <end_op>
  return 0;
    80008614:	4781                	li	a5,0
}
    80008616:	853e                	mv	a0,a5
    80008618:	60ea                	ld	ra,152(sp)
    8000861a:	644a                	ld	s0,144(sp)
    8000861c:	610d                	addi	sp,sp,160
    8000861e:	8082                	ret

0000000080008620 <sys_mknod>:

uint64
sys_mknod(void)
{
    80008620:	7135                	addi	sp,sp,-160
    80008622:	ed06                	sd	ra,152(sp)
    80008624:	e922                	sd	s0,144(sp)
    80008626:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80008628:	ffffe097          	auipc	ra,0xffffe
    8000862c:	db0080e7          	jalr	-592(ra) # 800063d8 <begin_op>
  argint(1, &major);
    80008630:	f6440793          	addi	a5,s0,-156
    80008634:	85be                	mv	a1,a5
    80008636:	4505                	li	a0,1
    80008638:	ffffc097          	auipc	ra,0xffffc
    8000863c:	d82080e7          	jalr	-638(ra) # 800043ba <argint>
  argint(2, &minor);
    80008640:	f6040793          	addi	a5,s0,-160
    80008644:	85be                	mv	a1,a5
    80008646:	4509                	li	a0,2
    80008648:	ffffc097          	auipc	ra,0xffffc
    8000864c:	d72080e7          	jalr	-654(ra) # 800043ba <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008650:	f6840793          	addi	a5,s0,-152
    80008654:	08000613          	li	a2,128
    80008658:	85be                	mv	a1,a5
    8000865a:	4501                	li	a0,0
    8000865c:	ffffc097          	auipc	ra,0xffffc
    80008660:	dc6080e7          	jalr	-570(ra) # 80004422 <argstr>
    80008664:	87aa                	mv	a5,a0
    80008666:	0207cc63          	bltz	a5,8000869e <sys_mknod+0x7e>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    8000866a:	f6442783          	lw	a5,-156(s0)
    8000866e:	0107971b          	slliw	a4,a5,0x10
    80008672:	4107571b          	sraiw	a4,a4,0x10
    80008676:	f6042783          	lw	a5,-160(s0)
    8000867a:	0107969b          	slliw	a3,a5,0x10
    8000867e:	4106d69b          	sraiw	a3,a3,0x10
    80008682:	f6840793          	addi	a5,s0,-152
    80008686:	863a                	mv	a2,a4
    80008688:	458d                	li	a1,3
    8000868a:	853e                	mv	a0,a5
    8000868c:	00000097          	auipc	ra,0x0
    80008690:	aac080e7          	jalr	-1364(ra) # 80008138 <create>
    80008694:	fea43423          	sd	a0,-24(s0)
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008698:	fe843783          	ld	a5,-24(s0)
    8000869c:	e799                	bnez	a5,800086aa <sys_mknod+0x8a>
    end_op();
    8000869e:	ffffe097          	auipc	ra,0xffffe
    800086a2:	dfc080e7          	jalr	-516(ra) # 8000649a <end_op>
    return -1;
    800086a6:	57fd                	li	a5,-1
    800086a8:	a821                	j	800086c0 <sys_mknod+0xa0>
  }
  iunlockput(ip);
    800086aa:	fe843503          	ld	a0,-24(s0)
    800086ae:	ffffd097          	auipc	ra,0xffffd
    800086b2:	ef4080e7          	jalr	-268(ra) # 800055a2 <iunlockput>
  end_op();
    800086b6:	ffffe097          	auipc	ra,0xffffe
    800086ba:	de4080e7          	jalr	-540(ra) # 8000649a <end_op>
  return 0;
    800086be:	4781                	li	a5,0
}
    800086c0:	853e                	mv	a0,a5
    800086c2:	60ea                	ld	ra,152(sp)
    800086c4:	644a                	ld	s0,144(sp)
    800086c6:	610d                	addi	sp,sp,160
    800086c8:	8082                	ret

00000000800086ca <sys_chdir>:

uint64
sys_chdir(void)
{
    800086ca:	7135                	addi	sp,sp,-160
    800086cc:	ed06                	sd	ra,152(sp)
    800086ce:	e922                	sd	s0,144(sp)
    800086d0:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800086d2:	ffffa097          	auipc	ra,0xffffa
    800086d6:	42c080e7          	jalr	1068(ra) # 80002afe <myproc>
    800086da:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    800086de:	ffffe097          	auipc	ra,0xffffe
    800086e2:	cfa080e7          	jalr	-774(ra) # 800063d8 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800086e6:	f6040793          	addi	a5,s0,-160
    800086ea:	08000613          	li	a2,128
    800086ee:	85be                	mv	a1,a5
    800086f0:	4501                	li	a0,0
    800086f2:	ffffc097          	auipc	ra,0xffffc
    800086f6:	d30080e7          	jalr	-720(ra) # 80004422 <argstr>
    800086fa:	87aa                	mv	a5,a0
    800086fc:	0007ce63          	bltz	a5,80008718 <sys_chdir+0x4e>
    80008700:	f6040793          	addi	a5,s0,-160
    80008704:	853e                	mv	a0,a5
    80008706:	ffffe097          	auipc	ra,0xffffe
    8000870a:	96e080e7          	jalr	-1682(ra) # 80006074 <namei>
    8000870e:	fea43023          	sd	a0,-32(s0)
    80008712:	fe043783          	ld	a5,-32(s0)
    80008716:	e799                	bnez	a5,80008724 <sys_chdir+0x5a>
    end_op();
    80008718:	ffffe097          	auipc	ra,0xffffe
    8000871c:	d82080e7          	jalr	-638(ra) # 8000649a <end_op>
    return -1;
    80008720:	57fd                	li	a5,-1
    80008722:	a0ad                	j	8000878c <sys_chdir+0xc2>
  }
  ilock(ip);
    80008724:	fe043503          	ld	a0,-32(s0)
    80008728:	ffffd097          	auipc	ra,0xffffd
    8000872c:	c1c080e7          	jalr	-996(ra) # 80005344 <ilock>
  if(ip->type != T_DIR){
    80008730:	fe043783          	ld	a5,-32(s0)
    80008734:	04479783          	lh	a5,68(a5)
    80008738:	873e                	mv	a4,a5
    8000873a:	4785                	li	a5,1
    8000873c:	00f70e63          	beq	a4,a5,80008758 <sys_chdir+0x8e>
    iunlockput(ip);
    80008740:	fe043503          	ld	a0,-32(s0)
    80008744:	ffffd097          	auipc	ra,0xffffd
    80008748:	e5e080e7          	jalr	-418(ra) # 800055a2 <iunlockput>
    end_op();
    8000874c:	ffffe097          	auipc	ra,0xffffe
    80008750:	d4e080e7          	jalr	-690(ra) # 8000649a <end_op>
    return -1;
    80008754:	57fd                	li	a5,-1
    80008756:	a81d                	j	8000878c <sys_chdir+0xc2>
  }
  iunlock(ip);
    80008758:	fe043503          	ld	a0,-32(s0)
    8000875c:	ffffd097          	auipc	ra,0xffffd
    80008760:	d1c080e7          	jalr	-740(ra) # 80005478 <iunlock>
  iput(p->cwd);
    80008764:	fe843783          	ld	a5,-24(s0)
    80008768:	1507b783          	ld	a5,336(a5)
    8000876c:	853e                	mv	a0,a5
    8000876e:	ffffd097          	auipc	ra,0xffffd
    80008772:	d64080e7          	jalr	-668(ra) # 800054d2 <iput>
  end_op();
    80008776:	ffffe097          	auipc	ra,0xffffe
    8000877a:	d24080e7          	jalr	-732(ra) # 8000649a <end_op>
  p->cwd = ip;
    8000877e:	fe843783          	ld	a5,-24(s0)
    80008782:	fe043703          	ld	a4,-32(s0)
    80008786:	14e7b823          	sd	a4,336(a5)
  return 0;
    8000878a:	4781                	li	a5,0
}
    8000878c:	853e                	mv	a0,a5
    8000878e:	60ea                	ld	ra,152(sp)
    80008790:	644a                	ld	s0,144(sp)
    80008792:	610d                	addi	sp,sp,160
    80008794:	8082                	ret

0000000080008796 <sys_exec>:

uint64
sys_exec(void)
{
    80008796:	7161                	addi	sp,sp,-432
    80008798:	f706                	sd	ra,424(sp)
    8000879a:	f322                	sd	s0,416(sp)
    8000879c:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    8000879e:	e6040793          	addi	a5,s0,-416
    800087a2:	85be                	mv	a1,a5
    800087a4:	4505                	li	a0,1
    800087a6:	ffffc097          	auipc	ra,0xffffc
    800087aa:	c4a080e7          	jalr	-950(ra) # 800043f0 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    800087ae:	f6840793          	addi	a5,s0,-152
    800087b2:	08000613          	li	a2,128
    800087b6:	85be                	mv	a1,a5
    800087b8:	4501                	li	a0,0
    800087ba:	ffffc097          	auipc	ra,0xffffc
    800087be:	c68080e7          	jalr	-920(ra) # 80004422 <argstr>
    800087c2:	87aa                	mv	a5,a0
    800087c4:	0007d463          	bgez	a5,800087cc <sys_exec+0x36>
    return -1;
    800087c8:	57fd                	li	a5,-1
    800087ca:	aa8d                	j	8000893c <sys_exec+0x1a6>
  }
  memset(argv, 0, sizeof(argv));
    800087cc:	e6840793          	addi	a5,s0,-408
    800087d0:	10000613          	li	a2,256
    800087d4:	4581                	li	a1,0
    800087d6:	853e                	mv	a0,a5
    800087d8:	ffff9097          	auipc	ra,0xffff9
    800087dc:	d2c080e7          	jalr	-724(ra) # 80001504 <memset>
  for(i=0;; i++){
    800087e0:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    800087e4:	fec42783          	lw	a5,-20(s0)
    800087e8:	873e                	mv	a4,a5
    800087ea:	47fd                	li	a5,31
    800087ec:	0ee7ee63          	bltu	a5,a4,800088e8 <sys_exec+0x152>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800087f0:	fec42783          	lw	a5,-20(s0)
    800087f4:	00379713          	slli	a4,a5,0x3
    800087f8:	e6043783          	ld	a5,-416(s0)
    800087fc:	97ba                	add	a5,a5,a4
    800087fe:	e5840713          	addi	a4,s0,-424
    80008802:	85ba                	mv	a1,a4
    80008804:	853e                	mv	a0,a5
    80008806:	ffffc097          	auipc	ra,0xffffc
    8000880a:	a42080e7          	jalr	-1470(ra) # 80004248 <fetchaddr>
    8000880e:	87aa                	mv	a5,a0
    80008810:	0c07ce63          	bltz	a5,800088ec <sys_exec+0x156>
      goto bad;
    }
    if(uarg == 0){
    80008814:	e5843783          	ld	a5,-424(s0)
    80008818:	eb8d                	bnez	a5,8000884a <sys_exec+0xb4>
      argv[i] = 0;
    8000881a:	fec42783          	lw	a5,-20(s0)
    8000881e:	078e                	slli	a5,a5,0x3
    80008820:	17c1                	addi	a5,a5,-16
    80008822:	97a2                	add	a5,a5,s0
    80008824:	e607bc23          	sd	zero,-392(a5)
      break;
    80008828:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    8000882a:	e6840713          	addi	a4,s0,-408
    8000882e:	f6840793          	addi	a5,s0,-152
    80008832:	85ba                	mv	a1,a4
    80008834:	853e                	mv	a0,a5
    80008836:	fffff097          	auipc	ra,0xfffff
    8000883a:	c34080e7          	jalr	-972(ra) # 8000746a <exec>
    8000883e:	87aa                	mv	a5,a0
    80008840:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008844:	fe042623          	sw	zero,-20(s0)
    80008848:	a8bd                	j	800088c6 <sys_exec+0x130>
    argv[i] = kalloc();
    8000884a:	ffff9097          	auipc	ra,0xffff9
    8000884e:	992080e7          	jalr	-1646(ra) # 800011dc <kalloc>
    80008852:	872a                	mv	a4,a0
    80008854:	fec42783          	lw	a5,-20(s0)
    80008858:	078e                	slli	a5,a5,0x3
    8000885a:	17c1                	addi	a5,a5,-16
    8000885c:	97a2                	add	a5,a5,s0
    8000885e:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    80008862:	fec42783          	lw	a5,-20(s0)
    80008866:	078e                	slli	a5,a5,0x3
    80008868:	17c1                	addi	a5,a5,-16
    8000886a:	97a2                	add	a5,a5,s0
    8000886c:	e787b783          	ld	a5,-392(a5)
    80008870:	c3c1                	beqz	a5,800088f0 <sys_exec+0x15a>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80008872:	e5843703          	ld	a4,-424(s0)
    80008876:	fec42783          	lw	a5,-20(s0)
    8000887a:	078e                	slli	a5,a5,0x3
    8000887c:	17c1                	addi	a5,a5,-16
    8000887e:	97a2                	add	a5,a5,s0
    80008880:	e787b783          	ld	a5,-392(a5)
    80008884:	6605                	lui	a2,0x1
    80008886:	85be                	mv	a1,a5
    80008888:	853a                	mv	a0,a4
    8000888a:	ffffc097          	auipc	ra,0xffffc
    8000888e:	a2c080e7          	jalr	-1492(ra) # 800042b6 <fetchstr>
    80008892:	87aa                	mv	a5,a0
    80008894:	0607c063          	bltz	a5,800088f4 <sys_exec+0x15e>
  for(i=0;; i++){
    80008898:	fec42783          	lw	a5,-20(s0)
    8000889c:	2785                	addiw	a5,a5,1
    8000889e:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    800088a2:	b789                	j	800087e4 <sys_exec+0x4e>
    kfree(argv[i]);
    800088a4:	fec42783          	lw	a5,-20(s0)
    800088a8:	078e                	slli	a5,a5,0x3
    800088aa:	17c1                	addi	a5,a5,-16
    800088ac:	97a2                	add	a5,a5,s0
    800088ae:	e787b783          	ld	a5,-392(a5)
    800088b2:	853e                	mv	a0,a5
    800088b4:	ffff9097          	auipc	ra,0xffff9
    800088b8:	882080e7          	jalr	-1918(ra) # 80001136 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800088bc:	fec42783          	lw	a5,-20(s0)
    800088c0:	2785                	addiw	a5,a5,1
    800088c2:	fef42623          	sw	a5,-20(s0)
    800088c6:	fec42783          	lw	a5,-20(s0)
    800088ca:	873e                	mv	a4,a5
    800088cc:	47fd                	li	a5,31
    800088ce:	00e7ea63          	bltu	a5,a4,800088e2 <sys_exec+0x14c>
    800088d2:	fec42783          	lw	a5,-20(s0)
    800088d6:	078e                	slli	a5,a5,0x3
    800088d8:	17c1                	addi	a5,a5,-16
    800088da:	97a2                	add	a5,a5,s0
    800088dc:	e787b783          	ld	a5,-392(a5)
    800088e0:	f3f1                	bnez	a5,800088a4 <sys_exec+0x10e>

  return ret;
    800088e2:	fe842783          	lw	a5,-24(s0)
    800088e6:	a899                	j	8000893c <sys_exec+0x1a6>
      goto bad;
    800088e8:	0001                	nop
    800088ea:	a031                	j	800088f6 <sys_exec+0x160>
      goto bad;
    800088ec:	0001                	nop
    800088ee:	a021                	j	800088f6 <sys_exec+0x160>
      goto bad;
    800088f0:	0001                	nop
    800088f2:	a011                	j	800088f6 <sys_exec+0x160>
      goto bad;
    800088f4:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800088f6:	fe042623          	sw	zero,-20(s0)
    800088fa:	a015                	j	8000891e <sys_exec+0x188>
    kfree(argv[i]);
    800088fc:	fec42783          	lw	a5,-20(s0)
    80008900:	078e                	slli	a5,a5,0x3
    80008902:	17c1                	addi	a5,a5,-16
    80008904:	97a2                	add	a5,a5,s0
    80008906:	e787b783          	ld	a5,-392(a5)
    8000890a:	853e                	mv	a0,a5
    8000890c:	ffff9097          	auipc	ra,0xffff9
    80008910:	82a080e7          	jalr	-2006(ra) # 80001136 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008914:	fec42783          	lw	a5,-20(s0)
    80008918:	2785                	addiw	a5,a5,1
    8000891a:	fef42623          	sw	a5,-20(s0)
    8000891e:	fec42783          	lw	a5,-20(s0)
    80008922:	873e                	mv	a4,a5
    80008924:	47fd                	li	a5,31
    80008926:	00e7ea63          	bltu	a5,a4,8000893a <sys_exec+0x1a4>
    8000892a:	fec42783          	lw	a5,-20(s0)
    8000892e:	078e                	slli	a5,a5,0x3
    80008930:	17c1                	addi	a5,a5,-16
    80008932:	97a2                	add	a5,a5,s0
    80008934:	e787b783          	ld	a5,-392(a5)
    80008938:	f3f1                	bnez	a5,800088fc <sys_exec+0x166>
  return -1;
    8000893a:	57fd                	li	a5,-1
}
    8000893c:	853e                	mv	a0,a5
    8000893e:	70ba                	ld	ra,424(sp)
    80008940:	741a                	ld	s0,416(sp)
    80008942:	615d                	addi	sp,sp,432
    80008944:	8082                	ret

0000000080008946 <sys_pipe>:

uint64
sys_pipe(void)
{
    80008946:	7139                	addi	sp,sp,-64
    80008948:	fc06                	sd	ra,56(sp)
    8000894a:	f822                	sd	s0,48(sp)
    8000894c:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000894e:	ffffa097          	auipc	ra,0xffffa
    80008952:	1b0080e7          	jalr	432(ra) # 80002afe <myproc>
    80008956:	fea43423          	sd	a0,-24(s0)

  argaddr(0, &fdarray);
    8000895a:	fe040793          	addi	a5,s0,-32
    8000895e:	85be                	mv	a1,a5
    80008960:	4501                	li	a0,0
    80008962:	ffffc097          	auipc	ra,0xffffc
    80008966:	a8e080e7          	jalr	-1394(ra) # 800043f0 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    8000896a:	fd040713          	addi	a4,s0,-48
    8000896e:	fd840793          	addi	a5,s0,-40
    80008972:	85ba                	mv	a1,a4
    80008974:	853e                	mv	a0,a5
    80008976:	ffffe097          	auipc	ra,0xffffe
    8000897a:	60e080e7          	jalr	1550(ra) # 80006f84 <pipealloc>
    8000897e:	87aa                	mv	a5,a0
    80008980:	0007d463          	bgez	a5,80008988 <sys_pipe+0x42>
    return -1;
    80008984:	57fd                	li	a5,-1
    80008986:	a219                	j	80008a8c <sys_pipe+0x146>
  fd0 = -1;
    80008988:	57fd                	li	a5,-1
    8000898a:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    8000898e:	fd843783          	ld	a5,-40(s0)
    80008992:	853e                	mv	a0,a5
    80008994:	fffff097          	auipc	ra,0xfffff
    80008998:	104080e7          	jalr	260(ra) # 80007a98 <fdalloc>
    8000899c:	87aa                	mv	a5,a0
    8000899e:	fcf42623          	sw	a5,-52(s0)
    800089a2:	fcc42783          	lw	a5,-52(s0)
    800089a6:	0207c063          	bltz	a5,800089c6 <sys_pipe+0x80>
    800089aa:	fd043783          	ld	a5,-48(s0)
    800089ae:	853e                	mv	a0,a5
    800089b0:	fffff097          	auipc	ra,0xfffff
    800089b4:	0e8080e7          	jalr	232(ra) # 80007a98 <fdalloc>
    800089b8:	87aa                	mv	a5,a0
    800089ba:	fcf42423          	sw	a5,-56(s0)
    800089be:	fc842783          	lw	a5,-56(s0)
    800089c2:	0207df63          	bgez	a5,80008a00 <sys_pipe+0xba>
    if(fd0 >= 0)
    800089c6:	fcc42783          	lw	a5,-52(s0)
    800089ca:	0007cb63          	bltz	a5,800089e0 <sys_pipe+0x9a>
      p->ofile[fd0] = 0;
    800089ce:	fcc42783          	lw	a5,-52(s0)
    800089d2:	fe843703          	ld	a4,-24(s0)
    800089d6:	07e9                	addi	a5,a5,26
    800089d8:	078e                	slli	a5,a5,0x3
    800089da:	97ba                	add	a5,a5,a4
    800089dc:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800089e0:	fd843783          	ld	a5,-40(s0)
    800089e4:	853e                	mv	a0,a5
    800089e6:	ffffe097          	auipc	ra,0xffffe
    800089ea:	08c080e7          	jalr	140(ra) # 80006a72 <fileclose>
    fileclose(wf);
    800089ee:	fd043783          	ld	a5,-48(s0)
    800089f2:	853e                	mv	a0,a5
    800089f4:	ffffe097          	auipc	ra,0xffffe
    800089f8:	07e080e7          	jalr	126(ra) # 80006a72 <fileclose>
    return -1;
    800089fc:	57fd                	li	a5,-1
    800089fe:	a079                	j	80008a8c <sys_pipe+0x146>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008a00:	fe843783          	ld	a5,-24(s0)
    80008a04:	6bbc                	ld	a5,80(a5)
    80008a06:	fe043703          	ld	a4,-32(s0)
    80008a0a:	fcc40613          	addi	a2,s0,-52
    80008a0e:	4691                	li	a3,4
    80008a10:	85ba                	mv	a1,a4
    80008a12:	853e                	mv	a0,a5
    80008a14:	ffffa097          	auipc	ra,0xffffa
    80008a18:	bb4080e7          	jalr	-1100(ra) # 800025c8 <copyout>
    80008a1c:	87aa                	mv	a5,a0
    80008a1e:	0207c463          	bltz	a5,80008a46 <sys_pipe+0x100>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80008a22:	fe843783          	ld	a5,-24(s0)
    80008a26:	6bb8                	ld	a4,80(a5)
    80008a28:	fe043783          	ld	a5,-32(s0)
    80008a2c:	0791                	addi	a5,a5,4
    80008a2e:	fc840613          	addi	a2,s0,-56
    80008a32:	4691                	li	a3,4
    80008a34:	85be                	mv	a1,a5
    80008a36:	853a                	mv	a0,a4
    80008a38:	ffffa097          	auipc	ra,0xffffa
    80008a3c:	b90080e7          	jalr	-1136(ra) # 800025c8 <copyout>
    80008a40:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008a42:	0407d463          	bgez	a5,80008a8a <sys_pipe+0x144>
    p->ofile[fd0] = 0;
    80008a46:	fcc42783          	lw	a5,-52(s0)
    80008a4a:	fe843703          	ld	a4,-24(s0)
    80008a4e:	07e9                	addi	a5,a5,26
    80008a50:	078e                	slli	a5,a5,0x3
    80008a52:	97ba                	add	a5,a5,a4
    80008a54:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80008a58:	fc842783          	lw	a5,-56(s0)
    80008a5c:	fe843703          	ld	a4,-24(s0)
    80008a60:	07e9                	addi	a5,a5,26
    80008a62:	078e                	slli	a5,a5,0x3
    80008a64:	97ba                	add	a5,a5,a4
    80008a66:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80008a6a:	fd843783          	ld	a5,-40(s0)
    80008a6e:	853e                	mv	a0,a5
    80008a70:	ffffe097          	auipc	ra,0xffffe
    80008a74:	002080e7          	jalr	2(ra) # 80006a72 <fileclose>
    fileclose(wf);
    80008a78:	fd043783          	ld	a5,-48(s0)
    80008a7c:	853e                	mv	a0,a5
    80008a7e:	ffffe097          	auipc	ra,0xffffe
    80008a82:	ff4080e7          	jalr	-12(ra) # 80006a72 <fileclose>
    return -1;
    80008a86:	57fd                	li	a5,-1
    80008a88:	a011                	j	80008a8c <sys_pipe+0x146>
  }
  return 0;
    80008a8a:	4781                	li	a5,0
}
    80008a8c:	853e                	mv	a0,a5
    80008a8e:	70e2                	ld	ra,56(sp)
    80008a90:	7442                	ld	s0,48(sp)
    80008a92:	6121                	addi	sp,sp,64
    80008a94:	8082                	ret
	...

0000000080008aa0 <kernelvec>:
    80008aa0:	7111                	addi	sp,sp,-256
    80008aa2:	e006                	sd	ra,0(sp)
    80008aa4:	e40a                	sd	sp,8(sp)
    80008aa6:	e80e                	sd	gp,16(sp)
    80008aa8:	ec12                	sd	tp,24(sp)
    80008aaa:	f016                	sd	t0,32(sp)
    80008aac:	f41a                	sd	t1,40(sp)
    80008aae:	f81e                	sd	t2,48(sp)
    80008ab0:	fc22                	sd	s0,56(sp)
    80008ab2:	e0a6                	sd	s1,64(sp)
    80008ab4:	e4aa                	sd	a0,72(sp)
    80008ab6:	e8ae                	sd	a1,80(sp)
    80008ab8:	ecb2                	sd	a2,88(sp)
    80008aba:	f0b6                	sd	a3,96(sp)
    80008abc:	f4ba                	sd	a4,104(sp)
    80008abe:	f8be                	sd	a5,112(sp)
    80008ac0:	fcc2                	sd	a6,120(sp)
    80008ac2:	e146                	sd	a7,128(sp)
    80008ac4:	e54a                	sd	s2,136(sp)
    80008ac6:	e94e                	sd	s3,144(sp)
    80008ac8:	ed52                	sd	s4,152(sp)
    80008aca:	f156                	sd	s5,160(sp)
    80008acc:	f55a                	sd	s6,168(sp)
    80008ace:	f95e                	sd	s7,176(sp)
    80008ad0:	fd62                	sd	s8,184(sp)
    80008ad2:	e1e6                	sd	s9,192(sp)
    80008ad4:	e5ea                	sd	s10,200(sp)
    80008ad6:	e9ee                	sd	s11,208(sp)
    80008ad8:	edf2                	sd	t3,216(sp)
    80008ada:	f1f6                	sd	t4,224(sp)
    80008adc:	f5fa                	sd	t5,232(sp)
    80008ade:	f9fe                	sd	t6,240(sp)
    80008ae0:	ccefb0ef          	jal	80003fae <kerneltrap>
    80008ae4:	6082                	ld	ra,0(sp)
    80008ae6:	6122                	ld	sp,8(sp)
    80008ae8:	61c2                	ld	gp,16(sp)
    80008aea:	7282                	ld	t0,32(sp)
    80008aec:	7322                	ld	t1,40(sp)
    80008aee:	73c2                	ld	t2,48(sp)
    80008af0:	7462                	ld	s0,56(sp)
    80008af2:	6486                	ld	s1,64(sp)
    80008af4:	6526                	ld	a0,72(sp)
    80008af6:	65c6                	ld	a1,80(sp)
    80008af8:	6666                	ld	a2,88(sp)
    80008afa:	7686                	ld	a3,96(sp)
    80008afc:	7726                	ld	a4,104(sp)
    80008afe:	77c6                	ld	a5,112(sp)
    80008b00:	7866                	ld	a6,120(sp)
    80008b02:	688a                	ld	a7,128(sp)
    80008b04:	692a                	ld	s2,136(sp)
    80008b06:	69ca                	ld	s3,144(sp)
    80008b08:	6a6a                	ld	s4,152(sp)
    80008b0a:	7a8a                	ld	s5,160(sp)
    80008b0c:	7b2a                	ld	s6,168(sp)
    80008b0e:	7bca                	ld	s7,176(sp)
    80008b10:	7c6a                	ld	s8,184(sp)
    80008b12:	6c8e                	ld	s9,192(sp)
    80008b14:	6d2e                	ld	s10,200(sp)
    80008b16:	6dce                	ld	s11,208(sp)
    80008b18:	6e6e                	ld	t3,216(sp)
    80008b1a:	7e8e                	ld	t4,224(sp)
    80008b1c:	7f2e                	ld	t5,232(sp)
    80008b1e:	7fce                	ld	t6,240(sp)
    80008b20:	6111                	addi	sp,sp,256
    80008b22:	10200073          	sret
    80008b26:	00000013          	nop
    80008b2a:	00000013          	nop
    80008b2e:	0001                	nop

0000000080008b30 <timervec>:
    80008b30:	34051573          	csrrw	a0,mscratch,a0
    80008b34:	e10c                	sd	a1,0(a0)
    80008b36:	e510                	sd	a2,8(a0)
    80008b38:	e914                	sd	a3,16(a0)
    80008b3a:	6d0c                	ld	a1,24(a0)
    80008b3c:	7110                	ld	a2,32(a0)
    80008b3e:	6194                	ld	a3,0(a1)
    80008b40:	96b2                	add	a3,a3,a2
    80008b42:	e194                	sd	a3,0(a1)
    80008b44:	4589                	li	a1,2
    80008b46:	14459073          	csrw	sip,a1
    80008b4a:	6914                	ld	a3,16(a0)
    80008b4c:	6510                	ld	a2,8(a0)
    80008b4e:	610c                	ld	a1,0(a0)
    80008b50:	34051573          	csrrw	a0,mscratch,a0
    80008b54:	30200073          	mret
	...

0000000080008b5a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80008b5a:	1101                	addi	sp,sp,-32
    80008b5c:	ec22                	sd	s0,24(sp)
    80008b5e:	1000                	addi	s0,sp,32
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80008b60:	0c0007b7          	lui	a5,0xc000
    80008b64:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    80008b68:	4705                	li	a4,1
    80008b6a:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80008b6c:	0c0007b7          	lui	a5,0xc000
    80008b70:	0791                	addi	a5,a5,4 # c000004 <_entry-0x73fffffc>
    80008b72:	4705                	li	a4,1
    80008b74:	c398                	sw	a4,0(a5)

  for (int i = VIRTIO_RAID_DISK_START; i <= VIRTIO_RAID_DISK_END; i++) {
    80008b76:	4785                	li	a5,1
    80008b78:	fef42623          	sw	a5,-20(s0)
    80008b7c:	a025                	j	80008ba4 <plicinit+0x4a>
    *(uint32*)(PLIC + VIRTIOX_IRQ(i)*4) = 1;
    80008b7e:	fec42783          	lw	a5,-20(s0)
    80008b82:	2785                	addiw	a5,a5,1
    80008b84:	2781                	sext.w	a5,a5
    80008b86:	0027979b          	slliw	a5,a5,0x2
    80008b8a:	2781                	sext.w	a5,a5
    80008b8c:	873e                	mv	a4,a5
    80008b8e:	0c0007b7          	lui	a5,0xc000
    80008b92:	97ba                	add	a5,a5,a4
    80008b94:	873e                	mv	a4,a5
    80008b96:	4785                	li	a5,1
    80008b98:	c31c                	sw	a5,0(a4)
  for (int i = VIRTIO_RAID_DISK_START; i <= VIRTIO_RAID_DISK_END; i++) {
    80008b9a:	fec42783          	lw	a5,-20(s0)
    80008b9e:	2785                	addiw	a5,a5,1 # c000001 <_entry-0x73ffffff>
    80008ba0:	fef42623          	sw	a5,-20(s0)
    80008ba4:	fec42783          	lw	a5,-20(s0)
    80008ba8:	0007871b          	sext.w	a4,a5
    80008bac:	4799                	li	a5,6
    80008bae:	fce7d8e3          	bge	a5,a4,80008b7e <plicinit+0x24>
  }
}
    80008bb2:	0001                	nop
    80008bb4:	0001                	nop
    80008bb6:	6462                	ld	s0,24(sp)
    80008bb8:	6105                	addi	sp,sp,32
    80008bba:	8082                	ret

0000000080008bbc <plicinithart>:

void
plicinithart(void)
{
    80008bbc:	1101                	addi	sp,sp,-32
    80008bbe:	ec06                	sd	ra,24(sp)
    80008bc0:	e822                	sd	s0,16(sp)
    80008bc2:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80008bc4:	ffffa097          	auipc	ra,0xffffa
    80008bc8:	edc080e7          	jalr	-292(ra) # 80002aa0 <cpuid>
    80008bcc:	87aa                	mv	a5,a0
    80008bce:	fef42223          	sw	a5,-28(s0)
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  uint32 enable_bits = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80008bd2:	40200793          	li	a5,1026
    80008bd6:	fef42623          	sw	a5,-20(s0)
  for (int i = VIRTIO_RAID_DISK_START; i <= VIRTIO_RAID_DISK_END; i++) {
    80008bda:	4785                	li	a5,1
    80008bdc:	fef42423          	sw	a5,-24(s0)
    80008be0:	a025                	j	80008c08 <plicinithart+0x4c>
    enable_bits |= (1 << VIRTIOX_IRQ(i));
    80008be2:	fe842783          	lw	a5,-24(s0)
    80008be6:	2785                	addiw	a5,a5,1
    80008be8:	2781                	sext.w	a5,a5
    80008bea:	4705                	li	a4,1
    80008bec:	00f717bb          	sllw	a5,a4,a5
    80008bf0:	2781                	sext.w	a5,a5
    80008bf2:	2781                	sext.w	a5,a5
    80008bf4:	fec42703          	lw	a4,-20(s0)
    80008bf8:	8fd9                	or	a5,a5,a4
    80008bfa:	fef42623          	sw	a5,-20(s0)
  for (int i = VIRTIO_RAID_DISK_START; i <= VIRTIO_RAID_DISK_END; i++) {
    80008bfe:	fe842783          	lw	a5,-24(s0)
    80008c02:	2785                	addiw	a5,a5,1
    80008c04:	fef42423          	sw	a5,-24(s0)
    80008c08:	fe842783          	lw	a5,-24(s0)
    80008c0c:	0007871b          	sext.w	a4,a5
    80008c10:	4799                	li	a5,6
    80008c12:	fce7d8e3          	bge	a5,a4,80008be2 <plicinithart+0x26>
  }

  *(uint32*)PLIC_SENABLE(hart) = enable_bits;
    80008c16:	fe442783          	lw	a5,-28(s0)
    80008c1a:	0087979b          	slliw	a5,a5,0x8
    80008c1e:	2781                	sext.w	a5,a5
    80008c20:	873e                	mv	a4,a5
    80008c22:	0c0027b7          	lui	a5,0xc002
    80008c26:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    80008c2a:	97ba                	add	a5,a5,a4
    80008c2c:	873e                	mv	a4,a5
    80008c2e:	fec42783          	lw	a5,-20(s0)
    80008c32:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80008c34:	fe442783          	lw	a5,-28(s0)
    80008c38:	00d7979b          	slliw	a5,a5,0xd
    80008c3c:	2781                	sext.w	a5,a5
    80008c3e:	873e                	mv	a4,a5
    80008c40:	0c2017b7          	lui	a5,0xc201
    80008c44:	97ba                	add	a5,a5,a4
    80008c46:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80008c4a:	0001                	nop
    80008c4c:	60e2                	ld	ra,24(sp)
    80008c4e:	6442                	ld	s0,16(sp)
    80008c50:	6105                	addi	sp,sp,32
    80008c52:	8082                	ret

0000000080008c54 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80008c54:	1101                	addi	sp,sp,-32
    80008c56:	ec06                	sd	ra,24(sp)
    80008c58:	e822                	sd	s0,16(sp)
    80008c5a:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80008c5c:	ffffa097          	auipc	ra,0xffffa
    80008c60:	e44080e7          	jalr	-444(ra) # 80002aa0 <cpuid>
    80008c64:	87aa                	mv	a5,a0
    80008c66:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80008c6a:	fec42783          	lw	a5,-20(s0)
    80008c6e:	00d7979b          	slliw	a5,a5,0xd
    80008c72:	2781                	sext.w	a5,a5
    80008c74:	873e                	mv	a4,a5
    80008c76:	0c2017b7          	lui	a5,0xc201
    80008c7a:	0791                	addi	a5,a5,4 # c201004 <_entry-0x73dfeffc>
    80008c7c:	97ba                	add	a5,a5,a4
    80008c7e:	439c                	lw	a5,0(a5)
    80008c80:	fef42423          	sw	a5,-24(s0)
  return irq;
    80008c84:	fe842783          	lw	a5,-24(s0)
}
    80008c88:	853e                	mv	a0,a5
    80008c8a:	60e2                	ld	ra,24(sp)
    80008c8c:	6442                	ld	s0,16(sp)
    80008c8e:	6105                	addi	sp,sp,32
    80008c90:	8082                	ret

0000000080008c92 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80008c92:	7179                	addi	sp,sp,-48
    80008c94:	f406                	sd	ra,40(sp)
    80008c96:	f022                	sd	s0,32(sp)
    80008c98:	1800                	addi	s0,sp,48
    80008c9a:	87aa                	mv	a5,a0
    80008c9c:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    80008ca0:	ffffa097          	auipc	ra,0xffffa
    80008ca4:	e00080e7          	jalr	-512(ra) # 80002aa0 <cpuid>
    80008ca8:	87aa                	mv	a5,a0
    80008caa:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80008cae:	fec42783          	lw	a5,-20(s0)
    80008cb2:	00d7979b          	slliw	a5,a5,0xd
    80008cb6:	2781                	sext.w	a5,a5
    80008cb8:	873e                	mv	a4,a5
    80008cba:	0c2017b7          	lui	a5,0xc201
    80008cbe:	0791                	addi	a5,a5,4 # c201004 <_entry-0x73dfeffc>
    80008cc0:	97ba                	add	a5,a5,a4
    80008cc2:	873e                	mv	a4,a5
    80008cc4:	fdc42783          	lw	a5,-36(s0)
    80008cc8:	c31c                	sw	a5,0(a4)
}
    80008cca:	0001                	nop
    80008ccc:	70a2                	ld	ra,40(sp)
    80008cce:	7402                	ld	s0,32(sp)
    80008cd0:	6145                	addi	sp,sp,48
    80008cd2:	8082                	ret

0000000080008cd4 <virtio_disk_init>:

static struct buf* transfer_buffer[VIRTIO_RAID_DISK_END + 1];

void
virtio_disk_init(int id, char * name)
{
    80008cd4:	7139                	addi	sp,sp,-64
    80008cd6:	fc06                	sd	ra,56(sp)
    80008cd8:	f822                	sd	s0,48(sp)
    80008cda:	0080                	addi	s0,sp,64
    80008cdc:	87aa                	mv	a5,a0
    80008cde:	fcb43023          	sd	a1,-64(s0)
    80008ce2:	fcf42623          	sw	a5,-52(s0)
  uint32 status = 0;
    80008ce6:	fe042423          	sw	zero,-24(s0)

  initlock(&disk[id].vdisk_lock, name);
    80008cea:	fcc42703          	lw	a4,-52(s0)
    80008cee:	25000793          	li	a5,592
    80008cf2:	02f707b3          	mul	a5,a4,a5
    80008cf6:	23078713          	addi	a4,a5,560
    80008cfa:	00021797          	auipc	a5,0x21
    80008cfe:	d2e78793          	addi	a5,a5,-722 # 80029a28 <disk>
    80008d02:	97ba                	add	a5,a5,a4
    80008d04:	07a1                	addi	a5,a5,8
    80008d06:	fc043583          	ld	a1,-64(s0)
    80008d0a:	853e                	mv	a0,a5
    80008d0c:	ffff8097          	auipc	ra,0xffff8
    80008d10:	5f4080e7          	jalr	1524(ra) # 80001300 <initlock>
  disk[id].name = name;
    80008d14:	00021717          	auipc	a4,0x21
    80008d18:	d1470713          	addi	a4,a4,-748 # 80029a28 <disk>
    80008d1c:	fcc42683          	lw	a3,-52(s0)
    80008d20:	25000793          	li	a5,592
    80008d24:	02f687b3          	mul	a5,a3,a5
    80008d28:	97ba                	add	a5,a5,a4
    80008d2a:	fc043703          	ld	a4,-64(s0)
    80008d2e:	e398                	sd	a4,0(a5)

  if(*R(id, VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008d30:	fcc42703          	lw	a4,-52(s0)
    80008d34:	67c1                	lui	a5,0x10
    80008d36:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008d38:	97ba                	add	a5,a5,a4
    80008d3a:	07b2                	slli	a5,a5,0xc
    80008d3c:	439c                	lw	a5,0(a5)
    80008d3e:	2781                	sext.w	a5,a5
    80008d40:	873e                	mv	a4,a5
    80008d42:	747277b7          	lui	a5,0x74727
    80008d46:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80008d4a:	04f71c63          	bne	a4,a5,80008da2 <virtio_disk_init+0xce>
     *R(id, VIRTIO_MMIO_VERSION) != 2 ||
    80008d4e:	fcc42703          	lw	a4,-52(s0)
    80008d52:	67c1                	lui	a5,0x10
    80008d54:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008d56:	97ba                	add	a5,a5,a4
    80008d58:	07b2                	slli	a5,a5,0xc
    80008d5a:	0791                	addi	a5,a5,4
    80008d5c:	439c                	lw	a5,0(a5)
    80008d5e:	2781                	sext.w	a5,a5
  if(*R(id, VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008d60:	873e                	mv	a4,a5
    80008d62:	4789                	li	a5,2
    80008d64:	02f71f63          	bne	a4,a5,80008da2 <virtio_disk_init+0xce>
     *R(id, VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008d68:	fcc42703          	lw	a4,-52(s0)
    80008d6c:	67c1                	lui	a5,0x10
    80008d6e:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008d70:	97ba                	add	a5,a5,a4
    80008d72:	07b2                	slli	a5,a5,0xc
    80008d74:	07a1                	addi	a5,a5,8
    80008d76:	439c                	lw	a5,0(a5)
    80008d78:	2781                	sext.w	a5,a5
     *R(id, VIRTIO_MMIO_VERSION) != 2 ||
    80008d7a:	873e                	mv	a4,a5
    80008d7c:	4789                	li	a5,2
    80008d7e:	02f71263          	bne	a4,a5,80008da2 <virtio_disk_init+0xce>
     *R(id, VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80008d82:	fcc42703          	lw	a4,-52(s0)
    80008d86:	67c1                	lui	a5,0x10
    80008d88:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008d8a:	97ba                	add	a5,a5,a4
    80008d8c:	07b2                	slli	a5,a5,0xc
    80008d8e:	07b1                	addi	a5,a5,12
    80008d90:	439c                	lw	a5,0(a5)
    80008d92:	2781                	sext.w	a5,a5
     *R(id, VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008d94:	873e                	mv	a4,a5
    80008d96:	554d47b7          	lui	a5,0x554d4
    80008d9a:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80008d9e:	00f70d63          	beq	a4,a5,80008db8 <virtio_disk_init+0xe4>
    panic_concat(2, "could not find virtio disk: ", name);
    80008da2:	fc043603          	ld	a2,-64(s0)
    80008da6:	00005597          	auipc	a1,0x5
    80008daa:	8ca58593          	addi	a1,a1,-1846 # 8000d670 <etext+0x670>
    80008dae:	4509                	li	a0,2
    80008db0:	ffff8097          	auipc	ra,0xffff8
    80008db4:	f2c080e7          	jalr	-212(ra) # 80000cdc <panic_concat>
  }
  
  // reset device
  *R(id, VIRTIO_MMIO_STATUS) = status;
    80008db8:	fcc42703          	lw	a4,-52(s0)
    80008dbc:	67c1                	lui	a5,0x10
    80008dbe:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008dc0:	97ba                	add	a5,a5,a4
    80008dc2:	07b2                	slli	a5,a5,0xc
    80008dc4:	07078793          	addi	a5,a5,112
    80008dc8:	873e                	mv	a4,a5
    80008dca:	fe842783          	lw	a5,-24(s0)
    80008dce:	c31c                	sw	a5,0(a4)

  // set ACKNOWLEDGE status bit
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80008dd0:	fe842783          	lw	a5,-24(s0)
    80008dd4:	0017e793          	ori	a5,a5,1
    80008dd8:	fef42423          	sw	a5,-24(s0)
  *R(id, VIRTIO_MMIO_STATUS) = status;
    80008ddc:	fcc42703          	lw	a4,-52(s0)
    80008de0:	67c1                	lui	a5,0x10
    80008de2:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008de4:	97ba                	add	a5,a5,a4
    80008de6:	07b2                	slli	a5,a5,0xc
    80008de8:	07078793          	addi	a5,a5,112
    80008dec:	873e                	mv	a4,a5
    80008dee:	fe842783          	lw	a5,-24(s0)
    80008df2:	c31c                	sw	a5,0(a4)

  // set DRIVER status bit
  status |= VIRTIO_CONFIG_S_DRIVER;
    80008df4:	fe842783          	lw	a5,-24(s0)
    80008df8:	0027e793          	ori	a5,a5,2
    80008dfc:	fef42423          	sw	a5,-24(s0)
  *R(id, VIRTIO_MMIO_STATUS) = status;
    80008e00:	fcc42703          	lw	a4,-52(s0)
    80008e04:	67c1                	lui	a5,0x10
    80008e06:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008e08:	97ba                	add	a5,a5,a4
    80008e0a:	07b2                	slli	a5,a5,0xc
    80008e0c:	07078793          	addi	a5,a5,112
    80008e10:	873e                	mv	a4,a5
    80008e12:	fe842783          	lw	a5,-24(s0)
    80008e16:	c31c                	sw	a5,0(a4)

  // negotiate features
  uint64 features = *R(id, VIRTIO_MMIO_DEVICE_FEATURES);
    80008e18:	fcc42703          	lw	a4,-52(s0)
    80008e1c:	67c1                	lui	a5,0x10
    80008e1e:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008e20:	97ba                	add	a5,a5,a4
    80008e22:	07b2                	slli	a5,a5,0xc
    80008e24:	07c1                	addi	a5,a5,16
    80008e26:	439c                	lw	a5,0(a5)
    80008e28:	2781                	sext.w	a5,a5
    80008e2a:	1782                	slli	a5,a5,0x20
    80008e2c:	9381                	srli	a5,a5,0x20
    80008e2e:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    80008e32:	fe043783          	ld	a5,-32(s0)
    80008e36:	fdf7f793          	andi	a5,a5,-33
    80008e3a:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    80008e3e:	fe043783          	ld	a5,-32(s0)
    80008e42:	f7f7f793          	andi	a5,a5,-129
    80008e46:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    80008e4a:	fe043703          	ld	a4,-32(s0)
    80008e4e:	77fd                	lui	a5,0xfffff
    80008e50:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7ffd4aef>
    80008e54:	8ff9                	and	a5,a5,a4
    80008e56:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    80008e5a:	fe043703          	ld	a4,-32(s0)
    80008e5e:	77fd                	lui	a5,0xfffff
    80008e60:	17fd                	addi	a5,a5,-1 # ffffffffffffefff <end+0xffffffff7ffd42ef>
    80008e62:	8ff9                	and	a5,a5,a4
    80008e64:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    80008e68:	fe043703          	ld	a4,-32(s0)
    80008e6c:	f80007b7          	lui	a5,0xf8000
    80008e70:	17fd                	addi	a5,a5,-1 # fffffffff7ffffff <end+0xffffffff77fd52ef>
    80008e72:	8ff9                	and	a5,a5,a4
    80008e74:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80008e78:	fe043703          	ld	a4,-32(s0)
    80008e7c:	e00007b7          	lui	a5,0xe0000
    80008e80:	17fd                	addi	a5,a5,-1 # ffffffffdfffffff <end+0xffffffff5ffd52ef>
    80008e82:	8ff9                	and	a5,a5,a4
    80008e84:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80008e88:	fe043703          	ld	a4,-32(s0)
    80008e8c:	f00007b7          	lui	a5,0xf0000
    80008e90:	17fd                	addi	a5,a5,-1 # ffffffffefffffff <end+0xffffffff6ffd52ef>
    80008e92:	8ff9                	and	a5,a5,a4
    80008e94:	fef43023          	sd	a5,-32(s0)
  *R(id, VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80008e98:	fcc42703          	lw	a4,-52(s0)
    80008e9c:	67c1                	lui	a5,0x10
    80008e9e:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008ea0:	97ba                	add	a5,a5,a4
    80008ea2:	07b2                	slli	a5,a5,0xc
    80008ea4:	02078793          	addi	a5,a5,32
    80008ea8:	873e                	mv	a4,a5
    80008eaa:	fe043783          	ld	a5,-32(s0)
    80008eae:	2781                	sext.w	a5,a5
    80008eb0:	c31c                	sw	a5,0(a4)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80008eb2:	fe842783          	lw	a5,-24(s0)
    80008eb6:	0087e793          	ori	a5,a5,8
    80008eba:	fef42423          	sw	a5,-24(s0)
  *R(id, VIRTIO_MMIO_STATUS) = status;
    80008ebe:	fcc42703          	lw	a4,-52(s0)
    80008ec2:	67c1                	lui	a5,0x10
    80008ec4:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008ec6:	97ba                	add	a5,a5,a4
    80008ec8:	07b2                	slli	a5,a5,0xc
    80008eca:	07078793          	addi	a5,a5,112
    80008ece:	873e                	mv	a4,a5
    80008ed0:	fe842783          	lw	a5,-24(s0)
    80008ed4:	c31c                	sw	a5,0(a4)

  // re-read status to ensure FEATURES_OK is set.
  status = *R(id, VIRTIO_MMIO_STATUS);
    80008ed6:	fcc42703          	lw	a4,-52(s0)
    80008eda:	67c1                	lui	a5,0x10
    80008edc:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008ede:	97ba                	add	a5,a5,a4
    80008ee0:	07b2                	slli	a5,a5,0xc
    80008ee2:	07078793          	addi	a5,a5,112
    80008ee6:	439c                	lw	a5,0(a5)
    80008ee8:	fef42423          	sw	a5,-24(s0)
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80008eec:	fe842783          	lw	a5,-24(s0)
    80008ef0:	8ba1                	andi	a5,a5,8
    80008ef2:	2781                	sext.w	a5,a5
    80008ef4:	ef81                	bnez	a5,80008f0c <virtio_disk_init+0x238>
      panic_concat(2, name, ": virtio disk FEATURES_OK unset");
    80008ef6:	00004617          	auipc	a2,0x4
    80008efa:	79a60613          	addi	a2,a2,1946 # 8000d690 <etext+0x690>
    80008efe:	fc043583          	ld	a1,-64(s0)
    80008f02:	4509                	li	a0,2
    80008f04:	ffff8097          	auipc	ra,0xffff8
    80008f08:	dd8080e7          	jalr	-552(ra) # 80000cdc <panic_concat>

  // initialize queue 0.
  *R(id, VIRTIO_MMIO_QUEUE_SEL) = 0;
    80008f0c:	fcc42703          	lw	a4,-52(s0)
    80008f10:	67c1                	lui	a5,0x10
    80008f12:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008f14:	97ba                	add	a5,a5,a4
    80008f16:	07b2                	slli	a5,a5,0xc
    80008f18:	03078793          	addi	a5,a5,48
    80008f1c:	0007a023          	sw	zero,0(a5)

  // ensure queue 0 is not in use.
  if(*R(id, VIRTIO_MMIO_QUEUE_READY))
    80008f20:	fcc42703          	lw	a4,-52(s0)
    80008f24:	67c1                	lui	a5,0x10
    80008f26:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008f28:	97ba                	add	a5,a5,a4
    80008f2a:	07b2                	slli	a5,a5,0xc
    80008f2c:	04478793          	addi	a5,a5,68
    80008f30:	439c                	lw	a5,0(a5)
    80008f32:	2781                	sext.w	a5,a5
    80008f34:	cf81                	beqz	a5,80008f4c <virtio_disk_init+0x278>
      panic_concat(2, name, ": virtio disk should not be ready");
    80008f36:	00004617          	auipc	a2,0x4
    80008f3a:	77a60613          	addi	a2,a2,1914 # 8000d6b0 <etext+0x6b0>
    80008f3e:	fc043583          	ld	a1,-64(s0)
    80008f42:	4509                	li	a0,2
    80008f44:	ffff8097          	auipc	ra,0xffff8
    80008f48:	d98080e7          	jalr	-616(ra) # 80000cdc <panic_concat>

  // check maximum queue size.
  uint32 max = *R(id, VIRTIO_MMIO_QUEUE_NUM_MAX);
    80008f4c:	fcc42703          	lw	a4,-52(s0)
    80008f50:	67c1                	lui	a5,0x10
    80008f52:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80008f54:	97ba                	add	a5,a5,a4
    80008f56:	07b2                	slli	a5,a5,0xc
    80008f58:	03478793          	addi	a5,a5,52
    80008f5c:	439c                	lw	a5,0(a5)
    80008f5e:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    80008f62:	fdc42783          	lw	a5,-36(s0)
    80008f66:	2781                	sext.w	a5,a5
    80008f68:	ef81                	bnez	a5,80008f80 <virtio_disk_init+0x2ac>
      panic_concat(2, name, ": virtio disk has no queue 0");
    80008f6a:	00004617          	auipc	a2,0x4
    80008f6e:	76e60613          	addi	a2,a2,1902 # 8000d6d8 <etext+0x6d8>
    80008f72:	fc043583          	ld	a1,-64(s0)
    80008f76:	4509                	li	a0,2
    80008f78:	ffff8097          	auipc	ra,0xffff8
    80008f7c:	d64080e7          	jalr	-668(ra) # 80000cdc <panic_concat>
  if(max < NUM)
    80008f80:	fdc42783          	lw	a5,-36(s0)
    80008f84:	0007871b          	sext.w	a4,a5
    80008f88:	47bd                	li	a5,15
    80008f8a:	00e7ed63          	bltu	a5,a4,80008fa4 <virtio_disk_init+0x2d0>
      panic_concat(2, name, ": virtio disk max queue too short");
    80008f8e:	00004617          	auipc	a2,0x4
    80008f92:	76a60613          	addi	a2,a2,1898 # 8000d6f8 <etext+0x6f8>
    80008f96:	fc043583          	ld	a1,-64(s0)
    80008f9a:	4509                	li	a0,2
    80008f9c:	ffff8097          	auipc	ra,0xffff8
    80008fa0:	d40080e7          	jalr	-704(ra) # 80000cdc <panic_concat>

  // allocate and zero queue memory.
  disk[id].desc = kalloc();
    80008fa4:	ffff8097          	auipc	ra,0xffff8
    80008fa8:	238080e7          	jalr	568(ra) # 800011dc <kalloc>
    80008fac:	862a                	mv	a2,a0
    80008fae:	00021717          	auipc	a4,0x21
    80008fb2:	a7a70713          	addi	a4,a4,-1414 # 80029a28 <disk>
    80008fb6:	fcc42683          	lw	a3,-52(s0)
    80008fba:	25000793          	li	a5,592
    80008fbe:	02f687b3          	mul	a5,a3,a5
    80008fc2:	97ba                	add	a5,a5,a4
    80008fc4:	e790                	sd	a2,8(a5)
  disk[id].avail = kalloc();
    80008fc6:	ffff8097          	auipc	ra,0xffff8
    80008fca:	216080e7          	jalr	534(ra) # 800011dc <kalloc>
    80008fce:	862a                	mv	a2,a0
    80008fd0:	00021717          	auipc	a4,0x21
    80008fd4:	a5870713          	addi	a4,a4,-1448 # 80029a28 <disk>
    80008fd8:	fcc42683          	lw	a3,-52(s0)
    80008fdc:	25000793          	li	a5,592
    80008fe0:	02f687b3          	mul	a5,a3,a5
    80008fe4:	97ba                	add	a5,a5,a4
    80008fe6:	eb90                	sd	a2,16(a5)
  disk[id].used = kalloc();
    80008fe8:	ffff8097          	auipc	ra,0xffff8
    80008fec:	1f4080e7          	jalr	500(ra) # 800011dc <kalloc>
    80008ff0:	862a                	mv	a2,a0
    80008ff2:	00021717          	auipc	a4,0x21
    80008ff6:	a3670713          	addi	a4,a4,-1482 # 80029a28 <disk>
    80008ffa:	fcc42683          	lw	a3,-52(s0)
    80008ffe:	25000793          	li	a5,592
    80009002:	02f687b3          	mul	a5,a3,a5
    80009006:	97ba                	add	a5,a5,a4
    80009008:	ef90                	sd	a2,24(a5)
  if(!disk[id].desc || !disk[id].avail || !disk[id].used)
    8000900a:	00021717          	auipc	a4,0x21
    8000900e:	a1e70713          	addi	a4,a4,-1506 # 80029a28 <disk>
    80009012:	fcc42683          	lw	a3,-52(s0)
    80009016:	25000793          	li	a5,592
    8000901a:	02f687b3          	mul	a5,a3,a5
    8000901e:	97ba                	add	a5,a5,a4
    80009020:	679c                	ld	a5,8(a5)
    80009022:	cb9d                	beqz	a5,80009058 <virtio_disk_init+0x384>
    80009024:	00021717          	auipc	a4,0x21
    80009028:	a0470713          	addi	a4,a4,-1532 # 80029a28 <disk>
    8000902c:	fcc42683          	lw	a3,-52(s0)
    80009030:	25000793          	li	a5,592
    80009034:	02f687b3          	mul	a5,a3,a5
    80009038:	97ba                	add	a5,a5,a4
    8000903a:	6b9c                	ld	a5,16(a5)
    8000903c:	cf91                	beqz	a5,80009058 <virtio_disk_init+0x384>
    8000903e:	00021717          	auipc	a4,0x21
    80009042:	9ea70713          	addi	a4,a4,-1558 # 80029a28 <disk>
    80009046:	fcc42683          	lw	a3,-52(s0)
    8000904a:	25000793          	li	a5,592
    8000904e:	02f687b3          	mul	a5,a3,a5
    80009052:	97ba                	add	a5,a5,a4
    80009054:	6f9c                	ld	a5,24(a5)
    80009056:	ef81                	bnez	a5,8000906e <virtio_disk_init+0x39a>
      panic_concat(2, name, ": virtio disk kalloc");
    80009058:	00004617          	auipc	a2,0x4
    8000905c:	6c860613          	addi	a2,a2,1736 # 8000d720 <etext+0x720>
    80009060:	fc043583          	ld	a1,-64(s0)
    80009064:	4509                	li	a0,2
    80009066:	ffff8097          	auipc	ra,0xffff8
    8000906a:	c76080e7          	jalr	-906(ra) # 80000cdc <panic_concat>
  memset(disk[id].desc, 0, PGSIZE);
    8000906e:	00021717          	auipc	a4,0x21
    80009072:	9ba70713          	addi	a4,a4,-1606 # 80029a28 <disk>
    80009076:	fcc42683          	lw	a3,-52(s0)
    8000907a:	25000793          	li	a5,592
    8000907e:	02f687b3          	mul	a5,a3,a5
    80009082:	97ba                	add	a5,a5,a4
    80009084:	679c                	ld	a5,8(a5)
    80009086:	6605                	lui	a2,0x1
    80009088:	4581                	li	a1,0
    8000908a:	853e                	mv	a0,a5
    8000908c:	ffff8097          	auipc	ra,0xffff8
    80009090:	478080e7          	jalr	1144(ra) # 80001504 <memset>
  memset(disk[id].avail, 0, PGSIZE);
    80009094:	00021717          	auipc	a4,0x21
    80009098:	99470713          	addi	a4,a4,-1644 # 80029a28 <disk>
    8000909c:	fcc42683          	lw	a3,-52(s0)
    800090a0:	25000793          	li	a5,592
    800090a4:	02f687b3          	mul	a5,a3,a5
    800090a8:	97ba                	add	a5,a5,a4
    800090aa:	6b9c                	ld	a5,16(a5)
    800090ac:	6605                	lui	a2,0x1
    800090ae:	4581                	li	a1,0
    800090b0:	853e                	mv	a0,a5
    800090b2:	ffff8097          	auipc	ra,0xffff8
    800090b6:	452080e7          	jalr	1106(ra) # 80001504 <memset>
  memset(disk[id].used, 0, PGSIZE);
    800090ba:	00021717          	auipc	a4,0x21
    800090be:	96e70713          	addi	a4,a4,-1682 # 80029a28 <disk>
    800090c2:	fcc42683          	lw	a3,-52(s0)
    800090c6:	25000793          	li	a5,592
    800090ca:	02f687b3          	mul	a5,a3,a5
    800090ce:	97ba                	add	a5,a5,a4
    800090d0:	6f9c                	ld	a5,24(a5)
    800090d2:	6605                	lui	a2,0x1
    800090d4:	4581                	li	a1,0
    800090d6:	853e                	mv	a0,a5
    800090d8:	ffff8097          	auipc	ra,0xffff8
    800090dc:	42c080e7          	jalr	1068(ra) # 80001504 <memset>

  // set queue size.
  *R(id, VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800090e0:	fcc42703          	lw	a4,-52(s0)
    800090e4:	67c1                	lui	a5,0x10
    800090e6:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    800090e8:	97ba                	add	a5,a5,a4
    800090ea:	07b2                	slli	a5,a5,0xc
    800090ec:	03878793          	addi	a5,a5,56
    800090f0:	873e                	mv	a4,a5
    800090f2:	47c1                	li	a5,16
    800090f4:	c31c                	sw	a5,0(a4)

  // write physical addresses.
  *R(id, VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk[id].desc;
    800090f6:	00021717          	auipc	a4,0x21
    800090fa:	93270713          	addi	a4,a4,-1742 # 80029a28 <disk>
    800090fe:	fcc42683          	lw	a3,-52(s0)
    80009102:	25000793          	li	a5,592
    80009106:	02f687b3          	mul	a5,a3,a5
    8000910a:	97ba                	add	a5,a5,a4
    8000910c:	679c                	ld	a5,8(a5)
    8000910e:	86be                	mv	a3,a5
    80009110:	fcc42703          	lw	a4,-52(s0)
    80009114:	67c1                	lui	a5,0x10
    80009116:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80009118:	97ba                	add	a5,a5,a4
    8000911a:	07b2                	slli	a5,a5,0xc
    8000911c:	08078793          	addi	a5,a5,128
    80009120:	873e                	mv	a4,a5
    80009122:	0006879b          	sext.w	a5,a3
    80009126:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk[id].desc >> 32;
    80009128:	00021717          	auipc	a4,0x21
    8000912c:	90070713          	addi	a4,a4,-1792 # 80029a28 <disk>
    80009130:	fcc42683          	lw	a3,-52(s0)
    80009134:	25000793          	li	a5,592
    80009138:	02f687b3          	mul	a5,a3,a5
    8000913c:	97ba                	add	a5,a5,a4
    8000913e:	679c                	ld	a5,8(a5)
    80009140:	0207d693          	srli	a3,a5,0x20
    80009144:	fcc42703          	lw	a4,-52(s0)
    80009148:	67c1                	lui	a5,0x10
    8000914a:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    8000914c:	97ba                	add	a5,a5,a4
    8000914e:	07b2                	slli	a5,a5,0xc
    80009150:	08478793          	addi	a5,a5,132
    80009154:	873e                	mv	a4,a5
    80009156:	0006879b          	sext.w	a5,a3
    8000915a:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk[id].avail;
    8000915c:	00021717          	auipc	a4,0x21
    80009160:	8cc70713          	addi	a4,a4,-1844 # 80029a28 <disk>
    80009164:	fcc42683          	lw	a3,-52(s0)
    80009168:	25000793          	li	a5,592
    8000916c:	02f687b3          	mul	a5,a3,a5
    80009170:	97ba                	add	a5,a5,a4
    80009172:	6b9c                	ld	a5,16(a5)
    80009174:	86be                	mv	a3,a5
    80009176:	fcc42703          	lw	a4,-52(s0)
    8000917a:	67c1                	lui	a5,0x10
    8000917c:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    8000917e:	97ba                	add	a5,a5,a4
    80009180:	07b2                	slli	a5,a5,0xc
    80009182:	09078793          	addi	a5,a5,144
    80009186:	873e                	mv	a4,a5
    80009188:	0006879b          	sext.w	a5,a3
    8000918c:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk[id].avail >> 32;
    8000918e:	00021717          	auipc	a4,0x21
    80009192:	89a70713          	addi	a4,a4,-1894 # 80029a28 <disk>
    80009196:	fcc42683          	lw	a3,-52(s0)
    8000919a:	25000793          	li	a5,592
    8000919e:	02f687b3          	mul	a5,a3,a5
    800091a2:	97ba                	add	a5,a5,a4
    800091a4:	6b9c                	ld	a5,16(a5)
    800091a6:	0207d693          	srli	a3,a5,0x20
    800091aa:	fcc42703          	lw	a4,-52(s0)
    800091ae:	67c1                	lui	a5,0x10
    800091b0:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    800091b2:	97ba                	add	a5,a5,a4
    800091b4:	07b2                	slli	a5,a5,0xc
    800091b6:	09478793          	addi	a5,a5,148
    800091ba:	873e                	mv	a4,a5
    800091bc:	0006879b          	sext.w	a5,a3
    800091c0:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk[id].used;
    800091c2:	00021717          	auipc	a4,0x21
    800091c6:	86670713          	addi	a4,a4,-1946 # 80029a28 <disk>
    800091ca:	fcc42683          	lw	a3,-52(s0)
    800091ce:	25000793          	li	a5,592
    800091d2:	02f687b3          	mul	a5,a3,a5
    800091d6:	97ba                	add	a5,a5,a4
    800091d8:	6f9c                	ld	a5,24(a5)
    800091da:	86be                	mv	a3,a5
    800091dc:	fcc42703          	lw	a4,-52(s0)
    800091e0:	67c1                	lui	a5,0x10
    800091e2:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    800091e4:	97ba                	add	a5,a5,a4
    800091e6:	07b2                	slli	a5,a5,0xc
    800091e8:	0a078793          	addi	a5,a5,160
    800091ec:	873e                	mv	a4,a5
    800091ee:	0006879b          	sext.w	a5,a3
    800091f2:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk[id].used >> 32;
    800091f4:	00021717          	auipc	a4,0x21
    800091f8:	83470713          	addi	a4,a4,-1996 # 80029a28 <disk>
    800091fc:	fcc42683          	lw	a3,-52(s0)
    80009200:	25000793          	li	a5,592
    80009204:	02f687b3          	mul	a5,a3,a5
    80009208:	97ba                	add	a5,a5,a4
    8000920a:	6f9c                	ld	a5,24(a5)
    8000920c:	0207d693          	srli	a3,a5,0x20
    80009210:	fcc42703          	lw	a4,-52(s0)
    80009214:	67c1                	lui	a5,0x10
    80009216:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80009218:	97ba                	add	a5,a5,a4
    8000921a:	07b2                	slli	a5,a5,0xc
    8000921c:	0a478793          	addi	a5,a5,164
    80009220:	873e                	mv	a4,a5
    80009222:	0006879b          	sext.w	a5,a3
    80009226:	c31c                	sw	a5,0(a4)

  // queue is ready.
  *R(id, VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80009228:	fcc42703          	lw	a4,-52(s0)
    8000922c:	67c1                	lui	a5,0x10
    8000922e:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80009230:	97ba                	add	a5,a5,a4
    80009232:	07b2                	slli	a5,a5,0xc
    80009234:	04478793          	addi	a5,a5,68
    80009238:	873e                	mv	a4,a5
    8000923a:	4785                	li	a5,1
    8000923c:	c31c                	sw	a5,0(a4)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    8000923e:	fe042623          	sw	zero,-20(s0)
    80009242:	a03d                	j	80009270 <virtio_disk_init+0x59c>
    disk[id].free[i] = 1;
    80009244:	00020697          	auipc	a3,0x20
    80009248:	7e468693          	addi	a3,a3,2020 # 80029a28 <disk>
    8000924c:	fec42703          	lw	a4,-20(s0)
    80009250:	fcc42603          	lw	a2,-52(s0)
    80009254:	25000793          	li	a5,592
    80009258:	02f607b3          	mul	a5,a2,a5
    8000925c:	97b6                	add	a5,a5,a3
    8000925e:	97ba                	add	a5,a5,a4
    80009260:	4705                	li	a4,1
    80009262:	02e78023          	sb	a4,32(a5)
  for(int i = 0; i < NUM; i++)
    80009266:	fec42783          	lw	a5,-20(s0)
    8000926a:	2785                	addiw	a5,a5,1
    8000926c:	fef42623          	sw	a5,-20(s0)
    80009270:	fec42783          	lw	a5,-20(s0)
    80009274:	0007871b          	sext.w	a4,a5
    80009278:	47bd                	li	a5,15
    8000927a:	fce7d5e3          	bge	a5,a4,80009244 <virtio_disk_init+0x570>

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000927e:	fe842783          	lw	a5,-24(s0)
    80009282:	0047e793          	ori	a5,a5,4
    80009286:	fef42423          	sw	a5,-24(s0)
  *R(id, VIRTIO_MMIO_STATUS) = status;
    8000928a:	fcc42703          	lw	a4,-52(s0)
    8000928e:	67c1                	lui	a5,0x10
    80009290:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80009292:	97ba                	add	a5,a5,a4
    80009294:	07b2                	slli	a5,a5,0xc
    80009296:	07078793          	addi	a5,a5,112
    8000929a:	873e                	mv	a4,a5
    8000929c:	fe842783          	lw	a5,-24(s0)
    800092a0:	c31c                	sw	a5,0(a4)

  if (id >= VIRTIO_RAID_DISK_START) {
    800092a2:	fcc42783          	lw	a5,-52(s0)
    800092a6:	2781                	sext.w	a5,a5
    800092a8:	08f05663          	blez	a5,80009334 <virtio_disk_init+0x660>
    transfer_buffer[id] = kalloc();
    800092ac:	ffff8097          	auipc	ra,0xffff8
    800092b0:	f30080e7          	jalr	-208(ra) # 800011dc <kalloc>
    800092b4:	86aa                	mv	a3,a0
    800092b6:	00021717          	auipc	a4,0x21
    800092ba:	7a270713          	addi	a4,a4,1954 # 8002aa58 <transfer_buffer>
    800092be:	fcc42783          	lw	a5,-52(s0)
    800092c2:	078e                	slli	a5,a5,0x3
    800092c4:	97ba                	add	a5,a5,a4
    800092c6:	e394                	sd	a3,0(a5)
    if (!transfer_buffer[id]) {
    800092c8:	00021717          	auipc	a4,0x21
    800092cc:	79070713          	addi	a4,a4,1936 # 8002aa58 <transfer_buffer>
    800092d0:	fcc42783          	lw	a5,-52(s0)
    800092d4:	078e                	slli	a5,a5,0x3
    800092d6:	97ba                	add	a5,a5,a4
    800092d8:	639c                	ld	a5,0(a5)
    800092da:	eb89                	bnez	a5,800092ec <virtio_disk_init+0x618>
      panic("virtio_disk_init: kalloc of transfer_buffer failed");
    800092dc:	00004517          	auipc	a0,0x4
    800092e0:	45c50513          	addi	a0,a0,1116 # 8000d738 <etext+0x738>
    800092e4:	ffff8097          	auipc	ra,0xffff8
    800092e8:	9a4080e7          	jalr	-1628(ra) # 80000c88 <panic>
    }
    memset(transfer_buffer[id], 0, BSIZE);
    800092ec:	00021717          	auipc	a4,0x21
    800092f0:	76c70713          	addi	a4,a4,1900 # 8002aa58 <transfer_buffer>
    800092f4:	fcc42783          	lw	a5,-52(s0)
    800092f8:	078e                	slli	a5,a5,0x3
    800092fa:	97ba                	add	a5,a5,a4
    800092fc:	639c                	ld	a5,0(a5)
    800092fe:	40000613          	li	a2,1024
    80009302:	4581                	li	a1,0
    80009304:	853e                	mv	a0,a5
    80009306:	ffff8097          	auipc	ra,0xffff8
    8000930a:	1fe080e7          	jalr	510(ra) # 80001504 <memset>
    initsleeplock(&transfer_buffer[id]->lock, "transfer_buffer");
    8000930e:	00021717          	auipc	a4,0x21
    80009312:	74a70713          	addi	a4,a4,1866 # 8002aa58 <transfer_buffer>
    80009316:	fcc42783          	lw	a5,-52(s0)
    8000931a:	078e                	slli	a5,a5,0x3
    8000931c:	97ba                	add	a5,a5,a4
    8000931e:	639c                	ld	a5,0(a5)
    80009320:	07c1                	addi	a5,a5,16
    80009322:	00004597          	auipc	a1,0x4
    80009326:	44e58593          	addi	a1,a1,1102 # 8000d770 <etext+0x770>
    8000932a:	853e                	mv	a0,a5
    8000932c:	ffffd097          	auipc	ra,0xffffd
    80009330:	4be080e7          	jalr	1214(ra) # 800067ea <initsleeplock>
  }

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ and VIRTIO1_IRQ.
}
    80009334:	0001                	nop
    80009336:	70e2                	ld	ra,56(sp)
    80009338:	7442                	ld	s0,48(sp)
    8000933a:	6121                	addi	sp,sp,64
    8000933c:	8082                	ret

000000008000933e <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc(int id)
{
    8000933e:	7179                	addi	sp,sp,-48
    80009340:	f422                	sd	s0,40(sp)
    80009342:	1800                	addi	s0,sp,48
    80009344:	87aa                	mv	a5,a0
    80009346:	fcf42e23          	sw	a5,-36(s0)
  for(int i = 0; i < NUM; i++){
    8000934a:	fe042623          	sw	zero,-20(s0)
    8000934e:	a891                	j	800093a2 <alloc_desc+0x64>
    if(disk[id].free[i]){
    80009350:	00020697          	auipc	a3,0x20
    80009354:	6d868693          	addi	a3,a3,1752 # 80029a28 <disk>
    80009358:	fec42703          	lw	a4,-20(s0)
    8000935c:	fdc42603          	lw	a2,-36(s0)
    80009360:	25000793          	li	a5,592
    80009364:	02f607b3          	mul	a5,a2,a5
    80009368:	97b6                	add	a5,a5,a3
    8000936a:	97ba                	add	a5,a5,a4
    8000936c:	0207c783          	lbu	a5,32(a5)
    80009370:	c785                	beqz	a5,80009398 <alloc_desc+0x5a>
      disk[id].free[i] = 0;
    80009372:	00020697          	auipc	a3,0x20
    80009376:	6b668693          	addi	a3,a3,1718 # 80029a28 <disk>
    8000937a:	fec42703          	lw	a4,-20(s0)
    8000937e:	fdc42603          	lw	a2,-36(s0)
    80009382:	25000793          	li	a5,592
    80009386:	02f607b3          	mul	a5,a2,a5
    8000938a:	97b6                	add	a5,a5,a3
    8000938c:	97ba                	add	a5,a5,a4
    8000938e:	02078023          	sb	zero,32(a5)
      return i;
    80009392:	fec42783          	lw	a5,-20(s0)
    80009396:	a831                	j	800093b2 <alloc_desc+0x74>
  for(int i = 0; i < NUM; i++){
    80009398:	fec42783          	lw	a5,-20(s0)
    8000939c:	2785                	addiw	a5,a5,1
    8000939e:	fef42623          	sw	a5,-20(s0)
    800093a2:	fec42783          	lw	a5,-20(s0)
    800093a6:	0007871b          	sext.w	a4,a5
    800093aa:	47bd                	li	a5,15
    800093ac:	fae7d2e3          	bge	a5,a4,80009350 <alloc_desc+0x12>
    }
  }
  return -1;
    800093b0:	57fd                	li	a5,-1
}
    800093b2:	853e                	mv	a0,a5
    800093b4:	7422                	ld	s0,40(sp)
    800093b6:	6145                	addi	sp,sp,48
    800093b8:	8082                	ret

00000000800093ba <free_desc>:

// mark a descriptor as free.
static void
free_desc(int id, int i)
{
    800093ba:	1101                	addi	sp,sp,-32
    800093bc:	ec06                	sd	ra,24(sp)
    800093be:	e822                	sd	s0,16(sp)
    800093c0:	1000                	addi	s0,sp,32
    800093c2:	87aa                	mv	a5,a0
    800093c4:	872e                	mv	a4,a1
    800093c6:	fef42623          	sw	a5,-20(s0)
    800093ca:	87ba                	mv	a5,a4
    800093cc:	fef42423          	sw	a5,-24(s0)
  if(i >= NUM)
    800093d0:	fe842783          	lw	a5,-24(s0)
    800093d4:	0007871b          	sext.w	a4,a5
    800093d8:	47bd                	li	a5,15
    800093da:	02e7d863          	bge	a5,a4,8000940a <free_desc+0x50>
    panic_concat(2, disk[id].name, ": free_desc 1");
    800093de:	00020717          	auipc	a4,0x20
    800093e2:	64a70713          	addi	a4,a4,1610 # 80029a28 <disk>
    800093e6:	fec42683          	lw	a3,-20(s0)
    800093ea:	25000793          	li	a5,592
    800093ee:	02f687b3          	mul	a5,a3,a5
    800093f2:	97ba                	add	a5,a5,a4
    800093f4:	639c                	ld	a5,0(a5)
    800093f6:	00004617          	auipc	a2,0x4
    800093fa:	38a60613          	addi	a2,a2,906 # 8000d780 <etext+0x780>
    800093fe:	85be                	mv	a1,a5
    80009400:	4509                	li	a0,2
    80009402:	ffff8097          	auipc	ra,0xffff8
    80009406:	8da080e7          	jalr	-1830(ra) # 80000cdc <panic_concat>
  if(disk[id].free[i])
    8000940a:	00020697          	auipc	a3,0x20
    8000940e:	61e68693          	addi	a3,a3,1566 # 80029a28 <disk>
    80009412:	fe842703          	lw	a4,-24(s0)
    80009416:	fec42603          	lw	a2,-20(s0)
    8000941a:	25000793          	li	a5,592
    8000941e:	02f607b3          	mul	a5,a2,a5
    80009422:	97b6                	add	a5,a5,a3
    80009424:	97ba                	add	a5,a5,a4
    80009426:	0207c783          	lbu	a5,32(a5)
    8000942a:	c79d                	beqz	a5,80009458 <free_desc+0x9e>
      panic_concat(2, disk[id].name, ": free_desc 2");
    8000942c:	00020717          	auipc	a4,0x20
    80009430:	5fc70713          	addi	a4,a4,1532 # 80029a28 <disk>
    80009434:	fec42683          	lw	a3,-20(s0)
    80009438:	25000793          	li	a5,592
    8000943c:	02f687b3          	mul	a5,a3,a5
    80009440:	97ba                	add	a5,a5,a4
    80009442:	639c                	ld	a5,0(a5)
    80009444:	00004617          	auipc	a2,0x4
    80009448:	34c60613          	addi	a2,a2,844 # 8000d790 <etext+0x790>
    8000944c:	85be                	mv	a1,a5
    8000944e:	4509                	li	a0,2
    80009450:	ffff8097          	auipc	ra,0xffff8
    80009454:	88c080e7          	jalr	-1908(ra) # 80000cdc <panic_concat>
  disk[id].desc[i].addr = 0;
    80009458:	00020717          	auipc	a4,0x20
    8000945c:	5d070713          	addi	a4,a4,1488 # 80029a28 <disk>
    80009460:	fec42683          	lw	a3,-20(s0)
    80009464:	25000793          	li	a5,592
    80009468:	02f687b3          	mul	a5,a3,a5
    8000946c:	97ba                	add	a5,a5,a4
    8000946e:	6798                	ld	a4,8(a5)
    80009470:	fe842783          	lw	a5,-24(s0)
    80009474:	0792                	slli	a5,a5,0x4
    80009476:	97ba                	add	a5,a5,a4
    80009478:	0007b023          	sd	zero,0(a5)
  disk[id].desc[i].len = 0;
    8000947c:	00020717          	auipc	a4,0x20
    80009480:	5ac70713          	addi	a4,a4,1452 # 80029a28 <disk>
    80009484:	fec42683          	lw	a3,-20(s0)
    80009488:	25000793          	li	a5,592
    8000948c:	02f687b3          	mul	a5,a3,a5
    80009490:	97ba                	add	a5,a5,a4
    80009492:	6798                	ld	a4,8(a5)
    80009494:	fe842783          	lw	a5,-24(s0)
    80009498:	0792                	slli	a5,a5,0x4
    8000949a:	97ba                	add	a5,a5,a4
    8000949c:	0007a423          	sw	zero,8(a5)
  disk[id].desc[i].flags = 0;
    800094a0:	00020717          	auipc	a4,0x20
    800094a4:	58870713          	addi	a4,a4,1416 # 80029a28 <disk>
    800094a8:	fec42683          	lw	a3,-20(s0)
    800094ac:	25000793          	li	a5,592
    800094b0:	02f687b3          	mul	a5,a3,a5
    800094b4:	97ba                	add	a5,a5,a4
    800094b6:	6798                	ld	a4,8(a5)
    800094b8:	fe842783          	lw	a5,-24(s0)
    800094bc:	0792                	slli	a5,a5,0x4
    800094be:	97ba                	add	a5,a5,a4
    800094c0:	00079623          	sh	zero,12(a5)
  disk[id].desc[i].next = 0;
    800094c4:	00020717          	auipc	a4,0x20
    800094c8:	56470713          	addi	a4,a4,1380 # 80029a28 <disk>
    800094cc:	fec42683          	lw	a3,-20(s0)
    800094d0:	25000793          	li	a5,592
    800094d4:	02f687b3          	mul	a5,a3,a5
    800094d8:	97ba                	add	a5,a5,a4
    800094da:	6798                	ld	a4,8(a5)
    800094dc:	fe842783          	lw	a5,-24(s0)
    800094e0:	0792                	slli	a5,a5,0x4
    800094e2:	97ba                	add	a5,a5,a4
    800094e4:	00079723          	sh	zero,14(a5)
  disk[id].free[i] = 1;
    800094e8:	00020697          	auipc	a3,0x20
    800094ec:	54068693          	addi	a3,a3,1344 # 80029a28 <disk>
    800094f0:	fe842703          	lw	a4,-24(s0)
    800094f4:	fec42603          	lw	a2,-20(s0)
    800094f8:	25000793          	li	a5,592
    800094fc:	02f607b3          	mul	a5,a2,a5
    80009500:	97b6                	add	a5,a5,a3
    80009502:	97ba                	add	a5,a5,a4
    80009504:	4705                	li	a4,1
    80009506:	02e78023          	sb	a4,32(a5)

  wakeup(&disk[id].free[0]);
    8000950a:	fec42703          	lw	a4,-20(s0)
    8000950e:	25000793          	li	a5,592
    80009512:	02f707b3          	mul	a5,a4,a5
    80009516:	02078713          	addi	a4,a5,32
    8000951a:	00020797          	auipc	a5,0x20
    8000951e:	50e78793          	addi	a5,a5,1294 # 80029a28 <disk>
    80009522:	97ba                	add	a5,a5,a4
    80009524:	853e                	mv	a0,a5
    80009526:	ffffa097          	auipc	ra,0xffffa
    8000952a:	21e080e7          	jalr	542(ra) # 80003744 <wakeup>
}
    8000952e:	0001                	nop
    80009530:	60e2                	ld	ra,24(sp)
    80009532:	6442                	ld	s0,16(sp)
    80009534:	6105                	addi	sp,sp,32
    80009536:	8082                	ret

0000000080009538 <free_chain>:

// free a chain of descriptors.
static void
free_chain(int id, int i)
{
    80009538:	7179                	addi	sp,sp,-48
    8000953a:	f406                	sd	ra,40(sp)
    8000953c:	f022                	sd	s0,32(sp)
    8000953e:	1800                	addi	s0,sp,48
    80009540:	87aa                	mv	a5,a0
    80009542:	872e                	mv	a4,a1
    80009544:	fcf42e23          	sw	a5,-36(s0)
    80009548:	87ba                	mv	a5,a4
    8000954a:	fcf42c23          	sw	a5,-40(s0)
  while(1){
    int flag = disk[id].desc[i].flags;
    8000954e:	00020717          	auipc	a4,0x20
    80009552:	4da70713          	addi	a4,a4,1242 # 80029a28 <disk>
    80009556:	fdc42683          	lw	a3,-36(s0)
    8000955a:	25000793          	li	a5,592
    8000955e:	02f687b3          	mul	a5,a3,a5
    80009562:	97ba                	add	a5,a5,a4
    80009564:	6798                	ld	a4,8(a5)
    80009566:	fd842783          	lw	a5,-40(s0)
    8000956a:	0792                	slli	a5,a5,0x4
    8000956c:	97ba                	add	a5,a5,a4
    8000956e:	00c7d783          	lhu	a5,12(a5)
    80009572:	fef42623          	sw	a5,-20(s0)
    int nxt = disk[id].desc[i].next;
    80009576:	00020717          	auipc	a4,0x20
    8000957a:	4b270713          	addi	a4,a4,1202 # 80029a28 <disk>
    8000957e:	fdc42683          	lw	a3,-36(s0)
    80009582:	25000793          	li	a5,592
    80009586:	02f687b3          	mul	a5,a3,a5
    8000958a:	97ba                	add	a5,a5,a4
    8000958c:	6798                	ld	a4,8(a5)
    8000958e:	fd842783          	lw	a5,-40(s0)
    80009592:	0792                	slli	a5,a5,0x4
    80009594:	97ba                	add	a5,a5,a4
    80009596:	00e7d783          	lhu	a5,14(a5)
    8000959a:	fef42423          	sw	a5,-24(s0)
    free_desc(id, i);
    8000959e:	fd842703          	lw	a4,-40(s0)
    800095a2:	fdc42783          	lw	a5,-36(s0)
    800095a6:	85ba                	mv	a1,a4
    800095a8:	853e                	mv	a0,a5
    800095aa:	00000097          	auipc	ra,0x0
    800095ae:	e10080e7          	jalr	-496(ra) # 800093ba <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800095b2:	fec42783          	lw	a5,-20(s0)
    800095b6:	8b85                	andi	a5,a5,1
    800095b8:	2781                	sext.w	a5,a5
    800095ba:	c791                	beqz	a5,800095c6 <free_chain+0x8e>
      i = nxt;
    800095bc:	fe842783          	lw	a5,-24(s0)
    800095c0:	fcf42c23          	sw	a5,-40(s0)
  while(1){
    800095c4:	b769                	j	8000954e <free_chain+0x16>
    else
      break;
    800095c6:	0001                	nop
  }
}
    800095c8:	0001                	nop
    800095ca:	70a2                	ld	ra,40(sp)
    800095cc:	7402                	ld	s0,32(sp)
    800095ce:	6145                	addi	sp,sp,48
    800095d0:	8082                	ret

00000000800095d2 <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int id, int *idx)
{
    800095d2:	7139                	addi	sp,sp,-64
    800095d4:	fc06                	sd	ra,56(sp)
    800095d6:	f822                	sd	s0,48(sp)
    800095d8:	f426                	sd	s1,40(sp)
    800095da:	0080                	addi	s0,sp,64
    800095dc:	87aa                	mv	a5,a0
    800095de:	fcb43023          	sd	a1,-64(s0)
    800095e2:	fcf42623          	sw	a5,-52(s0)
  for(int i = 0; i < 3; i++){
    800095e6:	fc042e23          	sw	zero,-36(s0)
    800095ea:	a049                	j	8000966c <alloc3_desc+0x9a>
    idx[i] = alloc_desc(id);
    800095ec:	fdc42783          	lw	a5,-36(s0)
    800095f0:	078a                	slli	a5,a5,0x2
    800095f2:	fc043703          	ld	a4,-64(s0)
    800095f6:	00f704b3          	add	s1,a4,a5
    800095fa:	fcc42783          	lw	a5,-52(s0)
    800095fe:	853e                	mv	a0,a5
    80009600:	00000097          	auipc	ra,0x0
    80009604:	d3e080e7          	jalr	-706(ra) # 8000933e <alloc_desc>
    80009608:	87aa                	mv	a5,a0
    8000960a:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    8000960c:	fdc42783          	lw	a5,-36(s0)
    80009610:	078a                	slli	a5,a5,0x2
    80009612:	fc043703          	ld	a4,-64(s0)
    80009616:	97ba                	add	a5,a5,a4
    80009618:	439c                	lw	a5,0(a5)
    8000961a:	0407d463          	bgez	a5,80009662 <alloc3_desc+0x90>
      for(int j = 0; j < i; j++)
    8000961e:	fc042c23          	sw	zero,-40(s0)
    80009622:	a02d                	j	8000964c <alloc3_desc+0x7a>
        free_desc(id, idx[j]);
    80009624:	fd842783          	lw	a5,-40(s0)
    80009628:	078a                	slli	a5,a5,0x2
    8000962a:	fc043703          	ld	a4,-64(s0)
    8000962e:	97ba                	add	a5,a5,a4
    80009630:	4398                	lw	a4,0(a5)
    80009632:	fcc42783          	lw	a5,-52(s0)
    80009636:	85ba                	mv	a1,a4
    80009638:	853e                	mv	a0,a5
    8000963a:	00000097          	auipc	ra,0x0
    8000963e:	d80080e7          	jalr	-640(ra) # 800093ba <free_desc>
      for(int j = 0; j < i; j++)
    80009642:	fd842783          	lw	a5,-40(s0)
    80009646:	2785                	addiw	a5,a5,1
    80009648:	fcf42c23          	sw	a5,-40(s0)
    8000964c:	fd842783          	lw	a5,-40(s0)
    80009650:	873e                	mv	a4,a5
    80009652:	fdc42783          	lw	a5,-36(s0)
    80009656:	2701                	sext.w	a4,a4
    80009658:	2781                	sext.w	a5,a5
    8000965a:	fcf745e3          	blt	a4,a5,80009624 <alloc3_desc+0x52>
      return -1;
    8000965e:	57fd                	li	a5,-1
    80009660:	a831                	j	8000967c <alloc3_desc+0xaa>
  for(int i = 0; i < 3; i++){
    80009662:	fdc42783          	lw	a5,-36(s0)
    80009666:	2785                	addiw	a5,a5,1
    80009668:	fcf42e23          	sw	a5,-36(s0)
    8000966c:	fdc42783          	lw	a5,-36(s0)
    80009670:	0007871b          	sext.w	a4,a5
    80009674:	4789                	li	a5,2
    80009676:	f6e7dbe3          	bge	a5,a4,800095ec <alloc3_desc+0x1a>
    }
  }
  return 0;
    8000967a:	4781                	li	a5,0
}
    8000967c:	853e                	mv	a0,a5
    8000967e:	70e2                	ld	ra,56(sp)
    80009680:	7442                	ld	s0,48(sp)
    80009682:	74a2                	ld	s1,40(sp)
    80009684:	6121                	addi	sp,sp,64
    80009686:	8082                	ret

0000000080009688 <virtio_disk_rw>:

void
virtio_disk_rw(int id, struct buf *b, int write)
{
    80009688:	7139                	addi	sp,sp,-64
    8000968a:	fc06                	sd	ra,56(sp)
    8000968c:	f822                	sd	s0,48(sp)
    8000968e:	0080                	addi	s0,sp,64
    80009690:	87aa                	mv	a5,a0
    80009692:	fcb43023          	sd	a1,-64(s0)
    80009696:	8732                	mv	a4,a2
    80009698:	fcf42623          	sw	a5,-52(s0)
    8000969c:	87ba                	mv	a5,a4
    8000969e:	fcf42423          	sw	a5,-56(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    800096a2:	fc043783          	ld	a5,-64(s0)
    800096a6:	47dc                	lw	a5,12(a5)
    800096a8:	0017979b          	slliw	a5,a5,0x1
    800096ac:	2781                	sext.w	a5,a5
    800096ae:	1782                	slli	a5,a5,0x20
    800096b0:	9381                	srli	a5,a5,0x20
    800096b2:	fef43423          	sd	a5,-24(s0)

  acquire(&disk[id].vdisk_lock);
    800096b6:	fcc42703          	lw	a4,-52(s0)
    800096ba:	25000793          	li	a5,592
    800096be:	02f707b3          	mul	a5,a4,a5
    800096c2:	23078713          	addi	a4,a5,560
    800096c6:	00020797          	auipc	a5,0x20
    800096ca:	36278793          	addi	a5,a5,866 # 80029a28 <disk>
    800096ce:	97ba                	add	a5,a5,a4
    800096d0:	07a1                	addi	a5,a5,8
    800096d2:	853e                	mv	a0,a5
    800096d4:	ffff8097          	auipc	ra,0xffff8
    800096d8:	c5c080e7          	jalr	-932(ra) # 80001330 <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(id, idx) == 0) {
    800096dc:	fd040713          	addi	a4,s0,-48
    800096e0:	fcc42783          	lw	a5,-52(s0)
    800096e4:	85ba                	mv	a1,a4
    800096e6:	853e                	mv	a0,a5
    800096e8:	00000097          	auipc	ra,0x0
    800096ec:	eea080e7          	jalr	-278(ra) # 800095d2 <alloc3_desc>
    800096f0:	87aa                	mv	a5,a0
    800096f2:	c7a1                	beqz	a5,8000973a <virtio_disk_rw+0xb2>
      break;
    }

    sleep(&disk[id].free[0], &disk[id].vdisk_lock);
    800096f4:	fcc42703          	lw	a4,-52(s0)
    800096f8:	25000793          	li	a5,592
    800096fc:	02f707b3          	mul	a5,a4,a5
    80009700:	02078713          	addi	a4,a5,32
    80009704:	00020797          	auipc	a5,0x20
    80009708:	32478793          	addi	a5,a5,804 # 80029a28 <disk>
    8000970c:	00f706b3          	add	a3,a4,a5
    80009710:	fcc42703          	lw	a4,-52(s0)
    80009714:	25000793          	li	a5,592
    80009718:	02f707b3          	mul	a5,a4,a5
    8000971c:	23078713          	addi	a4,a5,560
    80009720:	00020797          	auipc	a5,0x20
    80009724:	30878793          	addi	a5,a5,776 # 80029a28 <disk>
    80009728:	97ba                	add	a5,a5,a4
    8000972a:	07a1                	addi	a5,a5,8
    8000972c:	85be                	mv	a1,a5
    8000972e:	8536                	mv	a0,a3
    80009730:	ffffa097          	auipc	ra,0xffffa
    80009734:	f98080e7          	jalr	-104(ra) # 800036c8 <sleep>
    if(alloc3_desc(id, idx) == 0) {
    80009738:	b755                	j	800096dc <virtio_disk_rw+0x54>
      break;
    8000973a:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk[id].ops[idx[0]];
    8000973c:	fd042683          	lw	a3,-48(s0)
    80009740:	fcc42703          	lw	a4,-52(s0)
    80009744:	87ba                	mv	a5,a4
    80009746:	078e                	slli	a5,a5,0x3
    80009748:	97ba                	add	a5,a5,a4
    8000974a:	078a                	slli	a5,a5,0x2
    8000974c:	97ba                	add	a5,a5,a4
    8000974e:	97b6                	add	a5,a5,a3
    80009750:	07cd                	addi	a5,a5,19
    80009752:	00479713          	slli	a4,a5,0x4
    80009756:	00020797          	auipc	a5,0x20
    8000975a:	2d278793          	addi	a5,a5,722 # 80029a28 <disk>
    8000975e:	97ba                	add	a5,a5,a4
    80009760:	07a1                	addi	a5,a5,8
    80009762:	fef43023          	sd	a5,-32(s0)

  if(write)
    80009766:	fc842783          	lw	a5,-56(s0)
    8000976a:	2781                	sext.w	a5,a5
    8000976c:	c791                	beqz	a5,80009778 <virtio_disk_rw+0xf0>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    8000976e:	fe043783          	ld	a5,-32(s0)
    80009772:	4705                	li	a4,1
    80009774:	c398                	sw	a4,0(a5)
    80009776:	a029                	j	80009780 <virtio_disk_rw+0xf8>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80009778:	fe043783          	ld	a5,-32(s0)
    8000977c:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80009780:	fe043783          	ld	a5,-32(s0)
    80009784:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    80009788:	fe043783          	ld	a5,-32(s0)
    8000978c:	fe843703          	ld	a4,-24(s0)
    80009790:	e798                	sd	a4,8(a5)

  disk[id].desc[idx[0]].addr = (uint64) buf0;
    80009792:	00020717          	auipc	a4,0x20
    80009796:	29670713          	addi	a4,a4,662 # 80029a28 <disk>
    8000979a:	fcc42683          	lw	a3,-52(s0)
    8000979e:	25000793          	li	a5,592
    800097a2:	02f687b3          	mul	a5,a3,a5
    800097a6:	97ba                	add	a5,a5,a4
    800097a8:	6798                	ld	a4,8(a5)
    800097aa:	fd042783          	lw	a5,-48(s0)
    800097ae:	0792                	slli	a5,a5,0x4
    800097b0:	97ba                	add	a5,a5,a4
    800097b2:	fe043703          	ld	a4,-32(s0)
    800097b6:	e398                	sd	a4,0(a5)
  disk[id].desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800097b8:	00020717          	auipc	a4,0x20
    800097bc:	27070713          	addi	a4,a4,624 # 80029a28 <disk>
    800097c0:	fcc42683          	lw	a3,-52(s0)
    800097c4:	25000793          	li	a5,592
    800097c8:	02f687b3          	mul	a5,a3,a5
    800097cc:	97ba                	add	a5,a5,a4
    800097ce:	6798                	ld	a4,8(a5)
    800097d0:	fd042783          	lw	a5,-48(s0)
    800097d4:	0792                	slli	a5,a5,0x4
    800097d6:	97ba                	add	a5,a5,a4
    800097d8:	4741                	li	a4,16
    800097da:	c798                	sw	a4,8(a5)
  disk[id].desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800097dc:	00020717          	auipc	a4,0x20
    800097e0:	24c70713          	addi	a4,a4,588 # 80029a28 <disk>
    800097e4:	fcc42683          	lw	a3,-52(s0)
    800097e8:	25000793          	li	a5,592
    800097ec:	02f687b3          	mul	a5,a3,a5
    800097f0:	97ba                	add	a5,a5,a4
    800097f2:	6798                	ld	a4,8(a5)
    800097f4:	fd042783          	lw	a5,-48(s0)
    800097f8:	0792                	slli	a5,a5,0x4
    800097fa:	97ba                	add	a5,a5,a4
    800097fc:	4705                	li	a4,1
    800097fe:	00e79623          	sh	a4,12(a5)
  disk[id].desc[idx[0]].next = idx[1];
    80009802:	fd442603          	lw	a2,-44(s0)
    80009806:	00020717          	auipc	a4,0x20
    8000980a:	22270713          	addi	a4,a4,546 # 80029a28 <disk>
    8000980e:	fcc42683          	lw	a3,-52(s0)
    80009812:	25000793          	li	a5,592
    80009816:	02f687b3          	mul	a5,a3,a5
    8000981a:	97ba                	add	a5,a5,a4
    8000981c:	6798                	ld	a4,8(a5)
    8000981e:	fd042783          	lw	a5,-48(s0)
    80009822:	0792                	slli	a5,a5,0x4
    80009824:	97ba                	add	a5,a5,a4
    80009826:	03061713          	slli	a4,a2,0x30
    8000982a:	9341                	srli	a4,a4,0x30
    8000982c:	00e79723          	sh	a4,14(a5)

  disk[id].desc[idx[1]].addr = (uint64) b->data;
    80009830:	fc043783          	ld	a5,-64(s0)
    80009834:	05878613          	addi	a2,a5,88
    80009838:	00020717          	auipc	a4,0x20
    8000983c:	1f070713          	addi	a4,a4,496 # 80029a28 <disk>
    80009840:	fcc42683          	lw	a3,-52(s0)
    80009844:	25000793          	li	a5,592
    80009848:	02f687b3          	mul	a5,a3,a5
    8000984c:	97ba                	add	a5,a5,a4
    8000984e:	6798                	ld	a4,8(a5)
    80009850:	fd442783          	lw	a5,-44(s0)
    80009854:	0792                	slli	a5,a5,0x4
    80009856:	97ba                	add	a5,a5,a4
    80009858:	8732                	mv	a4,a2
    8000985a:	e398                	sd	a4,0(a5)
  disk[id].desc[idx[1]].len = BSIZE;
    8000985c:	00020717          	auipc	a4,0x20
    80009860:	1cc70713          	addi	a4,a4,460 # 80029a28 <disk>
    80009864:	fcc42683          	lw	a3,-52(s0)
    80009868:	25000793          	li	a5,592
    8000986c:	02f687b3          	mul	a5,a3,a5
    80009870:	97ba                	add	a5,a5,a4
    80009872:	6798                	ld	a4,8(a5)
    80009874:	fd442783          	lw	a5,-44(s0)
    80009878:	0792                	slli	a5,a5,0x4
    8000987a:	97ba                	add	a5,a5,a4
    8000987c:	40000713          	li	a4,1024
    80009880:	c798                	sw	a4,8(a5)
  if(write)
    80009882:	fc842783          	lw	a5,-56(s0)
    80009886:	2781                	sext.w	a5,a5
    80009888:	c785                	beqz	a5,800098b0 <virtio_disk_rw+0x228>
    disk[id].desc[idx[1]].flags = 0; // device reads b->data
    8000988a:	00020717          	auipc	a4,0x20
    8000988e:	19e70713          	addi	a4,a4,414 # 80029a28 <disk>
    80009892:	fcc42683          	lw	a3,-52(s0)
    80009896:	25000793          	li	a5,592
    8000989a:	02f687b3          	mul	a5,a3,a5
    8000989e:	97ba                	add	a5,a5,a4
    800098a0:	6798                	ld	a4,8(a5)
    800098a2:	fd442783          	lw	a5,-44(s0)
    800098a6:	0792                	slli	a5,a5,0x4
    800098a8:	97ba                	add	a5,a5,a4
    800098aa:	00079623          	sh	zero,12(a5)
    800098ae:	a025                	j	800098d6 <virtio_disk_rw+0x24e>
  else
    disk[id].desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800098b0:	00020717          	auipc	a4,0x20
    800098b4:	17870713          	addi	a4,a4,376 # 80029a28 <disk>
    800098b8:	fcc42683          	lw	a3,-52(s0)
    800098bc:	25000793          	li	a5,592
    800098c0:	02f687b3          	mul	a5,a3,a5
    800098c4:	97ba                	add	a5,a5,a4
    800098c6:	6798                	ld	a4,8(a5)
    800098c8:	fd442783          	lw	a5,-44(s0)
    800098cc:	0792                	slli	a5,a5,0x4
    800098ce:	97ba                	add	a5,a5,a4
    800098d0:	4709                	li	a4,2
    800098d2:	00e79623          	sh	a4,12(a5)
  disk[id].desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800098d6:	00020717          	auipc	a4,0x20
    800098da:	15270713          	addi	a4,a4,338 # 80029a28 <disk>
    800098de:	fcc42683          	lw	a3,-52(s0)
    800098e2:	25000793          	li	a5,592
    800098e6:	02f687b3          	mul	a5,a3,a5
    800098ea:	97ba                	add	a5,a5,a4
    800098ec:	6798                	ld	a4,8(a5)
    800098ee:	fd442783          	lw	a5,-44(s0)
    800098f2:	0792                	slli	a5,a5,0x4
    800098f4:	97ba                	add	a5,a5,a4
    800098f6:	00c7d703          	lhu	a4,12(a5)
    800098fa:	00020697          	auipc	a3,0x20
    800098fe:	12e68693          	addi	a3,a3,302 # 80029a28 <disk>
    80009902:	fcc42603          	lw	a2,-52(s0)
    80009906:	25000793          	li	a5,592
    8000990a:	02f607b3          	mul	a5,a2,a5
    8000990e:	97b6                	add	a5,a5,a3
    80009910:	6794                	ld	a3,8(a5)
    80009912:	fd442783          	lw	a5,-44(s0)
    80009916:	0792                	slli	a5,a5,0x4
    80009918:	97b6                	add	a5,a5,a3
    8000991a:	00176713          	ori	a4,a4,1
    8000991e:	1742                	slli	a4,a4,0x30
    80009920:	9341                	srli	a4,a4,0x30
    80009922:	00e79623          	sh	a4,12(a5)
  disk[id].desc[idx[1]].next = idx[2];
    80009926:	fd842603          	lw	a2,-40(s0)
    8000992a:	00020717          	auipc	a4,0x20
    8000992e:	0fe70713          	addi	a4,a4,254 # 80029a28 <disk>
    80009932:	fcc42683          	lw	a3,-52(s0)
    80009936:	25000793          	li	a5,592
    8000993a:	02f687b3          	mul	a5,a3,a5
    8000993e:	97ba                	add	a5,a5,a4
    80009940:	6798                	ld	a4,8(a5)
    80009942:	fd442783          	lw	a5,-44(s0)
    80009946:	0792                	slli	a5,a5,0x4
    80009948:	97ba                	add	a5,a5,a4
    8000994a:	03061713          	slli	a4,a2,0x30
    8000994e:	9341                	srli	a4,a4,0x30
    80009950:	00e79723          	sh	a4,14(a5)

  disk[id].info[idx[0]].status = 0xff; // device writes 0 on success
    80009954:	fd042603          	lw	a2,-48(s0)
    80009958:	00020697          	auipc	a3,0x20
    8000995c:	0d068693          	addi	a3,a3,208 # 80029a28 <disk>
    80009960:	fcc42703          	lw	a4,-52(s0)
    80009964:	87ba                	mv	a5,a4
    80009966:	078e                	slli	a5,a5,0x3
    80009968:	97ba                	add	a5,a5,a4
    8000996a:	078a                	slli	a5,a5,0x2
    8000996c:	97ba                	add	a5,a5,a4
    8000996e:	97b2                	add	a5,a5,a2
    80009970:	078d                	addi	a5,a5,3
    80009972:	0792                	slli	a5,a5,0x4
    80009974:	97b6                	add	a5,a5,a3
    80009976:	577d                	li	a4,-1
    80009978:	00e78823          	sb	a4,16(a5)
  disk[id].desc[idx[2]].addr = (uint64) &disk[id].info[idx[0]].status;
    8000997c:	fd042683          	lw	a3,-48(s0)
    80009980:	fcc42703          	lw	a4,-52(s0)
    80009984:	87ba                	mv	a5,a4
    80009986:	078e                	slli	a5,a5,0x3
    80009988:	97ba                	add	a5,a5,a4
    8000998a:	078a                	slli	a5,a5,0x2
    8000998c:	97ba                	add	a5,a5,a4
    8000998e:	97b6                	add	a5,a5,a3
    80009990:	078d                	addi	a5,a5,3
    80009992:	00479713          	slli	a4,a5,0x4
    80009996:	00020797          	auipc	a5,0x20
    8000999a:	09278793          	addi	a5,a5,146 # 80029a28 <disk>
    8000999e:	97ba                	add	a5,a5,a4
    800099a0:	01078613          	addi	a2,a5,16
    800099a4:	00020717          	auipc	a4,0x20
    800099a8:	08470713          	addi	a4,a4,132 # 80029a28 <disk>
    800099ac:	fcc42683          	lw	a3,-52(s0)
    800099b0:	25000793          	li	a5,592
    800099b4:	02f687b3          	mul	a5,a3,a5
    800099b8:	97ba                	add	a5,a5,a4
    800099ba:	6798                	ld	a4,8(a5)
    800099bc:	fd842783          	lw	a5,-40(s0)
    800099c0:	0792                	slli	a5,a5,0x4
    800099c2:	97ba                	add	a5,a5,a4
    800099c4:	8732                	mv	a4,a2
    800099c6:	e398                	sd	a4,0(a5)
  disk[id].desc[idx[2]].len = 1;
    800099c8:	00020717          	auipc	a4,0x20
    800099cc:	06070713          	addi	a4,a4,96 # 80029a28 <disk>
    800099d0:	fcc42683          	lw	a3,-52(s0)
    800099d4:	25000793          	li	a5,592
    800099d8:	02f687b3          	mul	a5,a3,a5
    800099dc:	97ba                	add	a5,a5,a4
    800099de:	6798                	ld	a4,8(a5)
    800099e0:	fd842783          	lw	a5,-40(s0)
    800099e4:	0792                	slli	a5,a5,0x4
    800099e6:	97ba                	add	a5,a5,a4
    800099e8:	4705                	li	a4,1
    800099ea:	c798                	sw	a4,8(a5)
  disk[id].desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800099ec:	00020717          	auipc	a4,0x20
    800099f0:	03c70713          	addi	a4,a4,60 # 80029a28 <disk>
    800099f4:	fcc42683          	lw	a3,-52(s0)
    800099f8:	25000793          	li	a5,592
    800099fc:	02f687b3          	mul	a5,a3,a5
    80009a00:	97ba                	add	a5,a5,a4
    80009a02:	6798                	ld	a4,8(a5)
    80009a04:	fd842783          	lw	a5,-40(s0)
    80009a08:	0792                	slli	a5,a5,0x4
    80009a0a:	97ba                	add	a5,a5,a4
    80009a0c:	4709                	li	a4,2
    80009a0e:	00e79623          	sh	a4,12(a5)
  disk[id].desc[idx[2]].next = 0;
    80009a12:	00020717          	auipc	a4,0x20
    80009a16:	01670713          	addi	a4,a4,22 # 80029a28 <disk>
    80009a1a:	fcc42683          	lw	a3,-52(s0)
    80009a1e:	25000793          	li	a5,592
    80009a22:	02f687b3          	mul	a5,a3,a5
    80009a26:	97ba                	add	a5,a5,a4
    80009a28:	6798                	ld	a4,8(a5)
    80009a2a:	fd842783          	lw	a5,-40(s0)
    80009a2e:	0792                	slli	a5,a5,0x4
    80009a30:	97ba                	add	a5,a5,a4
    80009a32:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80009a36:	fc043783          	ld	a5,-64(s0)
    80009a3a:	4705                	li	a4,1
    80009a3c:	c3d8                	sw	a4,4(a5)
  disk[id].info[idx[0]].b = b;
    80009a3e:	fd042603          	lw	a2,-48(s0)
    80009a42:	00020697          	auipc	a3,0x20
    80009a46:	fe668693          	addi	a3,a3,-26 # 80029a28 <disk>
    80009a4a:	fcc42703          	lw	a4,-52(s0)
    80009a4e:	87ba                	mv	a5,a4
    80009a50:	078e                	slli	a5,a5,0x3
    80009a52:	97ba                	add	a5,a5,a4
    80009a54:	078a                	slli	a5,a5,0x2
    80009a56:	97ba                	add	a5,a5,a4
    80009a58:	97b2                	add	a5,a5,a2
    80009a5a:	078d                	addi	a5,a5,3
    80009a5c:	0792                	slli	a5,a5,0x4
    80009a5e:	97b6                	add	a5,a5,a3
    80009a60:	fc043703          	ld	a4,-64(s0)
    80009a64:	e798                	sd	a4,8(a5)

  // tell the device the first index in our chain of descriptors.
  disk[id].avail->ring[disk[id].avail->idx % NUM] = idx[0];
    80009a66:	fd042583          	lw	a1,-48(s0)
    80009a6a:	00020717          	auipc	a4,0x20
    80009a6e:	fbe70713          	addi	a4,a4,-66 # 80029a28 <disk>
    80009a72:	fcc42683          	lw	a3,-52(s0)
    80009a76:	25000793          	li	a5,592
    80009a7a:	02f687b3          	mul	a5,a3,a5
    80009a7e:	97ba                	add	a5,a5,a4
    80009a80:	6b94                	ld	a3,16(a5)
    80009a82:	00020717          	auipc	a4,0x20
    80009a86:	fa670713          	addi	a4,a4,-90 # 80029a28 <disk>
    80009a8a:	fcc42603          	lw	a2,-52(s0)
    80009a8e:	25000793          	li	a5,592
    80009a92:	02f607b3          	mul	a5,a2,a5
    80009a96:	97ba                	add	a5,a5,a4
    80009a98:	6b9c                	ld	a5,16(a5)
    80009a9a:	0027d783          	lhu	a5,2(a5)
    80009a9e:	2781                	sext.w	a5,a5
    80009aa0:	8bbd                	andi	a5,a5,15
    80009aa2:	2781                	sext.w	a5,a5
    80009aa4:	03059713          	slli	a4,a1,0x30
    80009aa8:	9341                	srli	a4,a4,0x30
    80009aaa:	0786                	slli	a5,a5,0x1
    80009aac:	97b6                	add	a5,a5,a3
    80009aae:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    80009ab2:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk[id].avail->idx += 1; // not % NUM ...
    80009ab6:	00020717          	auipc	a4,0x20
    80009aba:	f7270713          	addi	a4,a4,-142 # 80029a28 <disk>
    80009abe:	fcc42683          	lw	a3,-52(s0)
    80009ac2:	25000793          	li	a5,592
    80009ac6:	02f687b3          	mul	a5,a3,a5
    80009aca:	97ba                	add	a5,a5,a4
    80009acc:	6b9c                	ld	a5,16(a5)
    80009ace:	0027d703          	lhu	a4,2(a5)
    80009ad2:	00020697          	auipc	a3,0x20
    80009ad6:	f5668693          	addi	a3,a3,-170 # 80029a28 <disk>
    80009ada:	fcc42603          	lw	a2,-52(s0)
    80009ade:	25000793          	li	a5,592
    80009ae2:	02f607b3          	mul	a5,a2,a5
    80009ae6:	97b6                	add	a5,a5,a3
    80009ae8:	6b9c                	ld	a5,16(a5)
    80009aea:	2705                	addiw	a4,a4,1
    80009aec:	1742                	slli	a4,a4,0x30
    80009aee:	9341                	srli	a4,a4,0x30
    80009af0:	00e79123          	sh	a4,2(a5)

  __sync_synchronize();
    80009af4:	0330000f          	fence	rw,rw

  *R(id, VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80009af8:	fcc42703          	lw	a4,-52(s0)
    80009afc:	67c1                	lui	a5,0x10
    80009afe:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80009b00:	97ba                	add	a5,a5,a4
    80009b02:	07b2                	slli	a5,a5,0xc
    80009b04:	05078793          	addi	a5,a5,80
    80009b08:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  sleep(b, &disk[id].vdisk_lock);
    80009b0c:	fcc42703          	lw	a4,-52(s0)
    80009b10:	25000793          	li	a5,592
    80009b14:	02f707b3          	mul	a5,a4,a5
    80009b18:	23078713          	addi	a4,a5,560
    80009b1c:	00020797          	auipc	a5,0x20
    80009b20:	f0c78793          	addi	a5,a5,-244 # 80029a28 <disk>
    80009b24:	97ba                	add	a5,a5,a4
    80009b26:	07a1                	addi	a5,a5,8
    80009b28:	85be                	mv	a1,a5
    80009b2a:	fc043503          	ld	a0,-64(s0)
    80009b2e:	ffffa097          	auipc	ra,0xffffa
    80009b32:	b9a080e7          	jalr	-1126(ra) # 800036c8 <sleep>

  disk[id].info[idx[0]].b = 0;
    80009b36:	fd042603          	lw	a2,-48(s0)
    80009b3a:	00020697          	auipc	a3,0x20
    80009b3e:	eee68693          	addi	a3,a3,-274 # 80029a28 <disk>
    80009b42:	fcc42703          	lw	a4,-52(s0)
    80009b46:	87ba                	mv	a5,a4
    80009b48:	078e                	slli	a5,a5,0x3
    80009b4a:	97ba                	add	a5,a5,a4
    80009b4c:	078a                	slli	a5,a5,0x2
    80009b4e:	97ba                	add	a5,a5,a4
    80009b50:	97b2                	add	a5,a5,a2
    80009b52:	078d                	addi	a5,a5,3
    80009b54:	0792                	slli	a5,a5,0x4
    80009b56:	97b6                	add	a5,a5,a3
    80009b58:	0007b423          	sd	zero,8(a5)
  free_chain(id, idx[0]);
    80009b5c:	fd042703          	lw	a4,-48(s0)
    80009b60:	fcc42783          	lw	a5,-52(s0)
    80009b64:	85ba                	mv	a1,a4
    80009b66:	853e                	mv	a0,a5
    80009b68:	00000097          	auipc	ra,0x0
    80009b6c:	9d0080e7          	jalr	-1584(ra) # 80009538 <free_chain>

  release(&disk[id].vdisk_lock);
    80009b70:	fcc42703          	lw	a4,-52(s0)
    80009b74:	25000793          	li	a5,592
    80009b78:	02f707b3          	mul	a5,a4,a5
    80009b7c:	23078713          	addi	a4,a5,560
    80009b80:	00020797          	auipc	a5,0x20
    80009b84:	ea878793          	addi	a5,a5,-344 # 80029a28 <disk>
    80009b88:	97ba                	add	a5,a5,a4
    80009b8a:	07a1                	addi	a5,a5,8
    80009b8c:	853e                	mv	a0,a5
    80009b8e:	ffff8097          	auipc	ra,0xffff8
    80009b92:	806080e7          	jalr	-2042(ra) # 80001394 <release>
}
    80009b96:	0001                	nop
    80009b98:	70e2                	ld	ra,56(sp)
    80009b9a:	7442                	ld	s0,48(sp)
    80009b9c:	6121                	addi	sp,sp,64
    80009b9e:	8082                	ret

0000000080009ba0 <write_block>:

void write_block(int diskn, int blockno, uchar* data) {
    80009ba0:	7179                	addi	sp,sp,-48
    80009ba2:	f406                	sd	ra,40(sp)
    80009ba4:	f022                	sd	s0,32(sp)
    80009ba6:	1800                	addi	s0,sp,48
    80009ba8:	87aa                	mv	a5,a0
    80009baa:	872e                	mv	a4,a1
    80009bac:	fcc43823          	sd	a2,-48(s0)
    80009bb0:	fcf42e23          	sw	a5,-36(s0)
    80009bb4:	87ba                	mv	a5,a4
    80009bb6:	fcf42c23          	sw	a5,-40(s0)
    if (diskn > 0 && blockno != diskblockn())
    80009bba:	fdc42783          	lw	a5,-36(s0)
    80009bbe:	2781                	sext.w	a5,a5
    80009bc0:	04f05e63          	blez	a5,80009c1c <write_block+0x7c>
    80009bc4:	00000097          	auipc	ra,0x0
    80009bc8:	30e080e7          	jalr	782(ra) # 80009ed2 <diskblockn>
    80009bcc:	87aa                	mv	a5,a0
    80009bce:	0007871b          	sext.w	a4,a5
    80009bd2:	fd842783          	lw	a5,-40(s0)
    80009bd6:	04f70363          	beq	a4,a5,80009c1c <write_block+0x7c>
    {
      acquire(&raidmeta.dirty);
    80009bda:	00021517          	auipc	a0,0x21
    80009bde:	ebe50513          	addi	a0,a0,-322 # 8002aa98 <raidmeta+0x8>
    80009be2:	ffff7097          	auipc	ra,0xffff7
    80009be6:	74e080e7          	jalr	1870(ra) # 80001330 <acquire>
      if (blockno > raidmeta.maxdirty)
    80009bea:	00021797          	auipc	a5,0x21
    80009bee:	ea678793          	addi	a5,a5,-346 # 8002aa90 <raidmeta>
    80009bf2:	5398                	lw	a4,32(a5)
    80009bf4:	fd842783          	lw	a5,-40(s0)
    80009bf8:	2781                	sext.w	a5,a5
    80009bfa:	00f75963          	bge	a4,a5,80009c0c <write_block+0x6c>
        raidmeta.maxdirty = blockno;
    80009bfe:	00021797          	auipc	a5,0x21
    80009c02:	e9278793          	addi	a5,a5,-366 # 8002aa90 <raidmeta>
    80009c06:	fd842703          	lw	a4,-40(s0)
    80009c0a:	d398                	sw	a4,32(a5)
      release(&raidmeta.dirty);
    80009c0c:	00021517          	auipc	a0,0x21
    80009c10:	e8c50513          	addi	a0,a0,-372 # 8002aa98 <raidmeta+0x8>
    80009c14:	ffff7097          	auipc	ra,0xffff7
    80009c18:	780080e7          	jalr	1920(ra) # 80001394 <release>
    }

    struct buf *b = transfer_buffer[diskn];
    80009c1c:	00021717          	auipc	a4,0x21
    80009c20:	e3c70713          	addi	a4,a4,-452 # 8002aa58 <transfer_buffer>
    80009c24:	fdc42783          	lw	a5,-36(s0)
    80009c28:	078e                	slli	a5,a5,0x3
    80009c2a:	97ba                	add	a5,a5,a4
    80009c2c:	639c                	ld	a5,0(a5)
    80009c2e:	fef43423          	sd	a5,-24(s0)
    b->blockno = blockno;
    80009c32:	fd842703          	lw	a4,-40(s0)
    80009c36:	fe843783          	ld	a5,-24(s0)
    80009c3a:	c7d8                	sw	a4,12(a5)
    memmove(b->data, data, BSIZE);
    80009c3c:	fe843783          	ld	a5,-24(s0)
    80009c40:	05878793          	addi	a5,a5,88
    80009c44:	40000613          	li	a2,1024
    80009c48:	fd043583          	ld	a1,-48(s0)
    80009c4c:	853e                	mv	a0,a5
    80009c4e:	ffff8097          	auipc	ra,0xffff8
    80009c52:	99a080e7          	jalr	-1638(ra) # 800015e8 <memmove>

    virtio_disk_rw(diskn, b, 1);
    80009c56:	fdc42783          	lw	a5,-36(s0)
    80009c5a:	4605                	li	a2,1
    80009c5c:	fe843583          	ld	a1,-24(s0)
    80009c60:	853e                	mv	a0,a5
    80009c62:	00000097          	auipc	ra,0x0
    80009c66:	a26080e7          	jalr	-1498(ra) # 80009688 <virtio_disk_rw>
}
    80009c6a:	0001                	nop
    80009c6c:	70a2                	ld	ra,40(sp)
    80009c6e:	7402                	ld	s0,32(sp)
    80009c70:	6145                	addi	sp,sp,48
    80009c72:	8082                	ret

0000000080009c74 <read_block>:

void read_block(int diskn, int blockno, uchar* data) {
    80009c74:	7179                	addi	sp,sp,-48
    80009c76:	f406                	sd	ra,40(sp)
    80009c78:	f022                	sd	s0,32(sp)
    80009c7a:	1800                	addi	s0,sp,48
    80009c7c:	87aa                	mv	a5,a0
    80009c7e:	872e                	mv	a4,a1
    80009c80:	fcc43823          	sd	a2,-48(s0)
    80009c84:	fcf42e23          	sw	a5,-36(s0)
    80009c88:	87ba                	mv	a5,a4
    80009c8a:	fcf42c23          	sw	a5,-40(s0)
    struct buf *b = transfer_buffer[diskn];
    80009c8e:	00021717          	auipc	a4,0x21
    80009c92:	dca70713          	addi	a4,a4,-566 # 8002aa58 <transfer_buffer>
    80009c96:	fdc42783          	lw	a5,-36(s0)
    80009c9a:	078e                	slli	a5,a5,0x3
    80009c9c:	97ba                	add	a5,a5,a4
    80009c9e:	639c                	ld	a5,0(a5)
    80009ca0:	fef43423          	sd	a5,-24(s0)
    b->blockno = blockno;
    80009ca4:	fd842703          	lw	a4,-40(s0)
    80009ca8:	fe843783          	ld	a5,-24(s0)
    80009cac:	c7d8                	sw	a4,12(a5)

    virtio_disk_rw(diskn, b, 0);
    80009cae:	fdc42783          	lw	a5,-36(s0)
    80009cb2:	4601                	li	a2,0
    80009cb4:	fe843583          	ld	a1,-24(s0)
    80009cb8:	853e                	mv	a0,a5
    80009cba:	00000097          	auipc	ra,0x0
    80009cbe:	9ce080e7          	jalr	-1586(ra) # 80009688 <virtio_disk_rw>
    memmove(data, b->data, BSIZE);
    80009cc2:	fe843783          	ld	a5,-24(s0)
    80009cc6:	05878793          	addi	a5,a5,88
    80009cca:	40000613          	li	a2,1024
    80009cce:	85be                	mv	a1,a5
    80009cd0:	fd043503          	ld	a0,-48(s0)
    80009cd4:	ffff8097          	auipc	ra,0xffff8
    80009cd8:	914080e7          	jalr	-1772(ra) # 800015e8 <memmove>
}
    80009cdc:	0001                	nop
    80009cde:	70a2                	ld	ra,40(sp)
    80009ce0:	7402                	ld	s0,32(sp)
    80009ce2:	6145                	addi	sp,sp,48
    80009ce4:	8082                	ret

0000000080009ce6 <virtio_disk_intr>:

void
virtio_disk_intr(int id)
{
    80009ce6:	7179                	addi	sp,sp,-48
    80009ce8:	f406                	sd	ra,40(sp)
    80009cea:	f022                	sd	s0,32(sp)
    80009cec:	1800                	addi	s0,sp,48
    80009cee:	87aa                	mv	a5,a0
    80009cf0:	fcf42e23          	sw	a5,-36(s0)
  acquire(&disk[id].vdisk_lock);
    80009cf4:	fdc42703          	lw	a4,-36(s0)
    80009cf8:	25000793          	li	a5,592
    80009cfc:	02f707b3          	mul	a5,a4,a5
    80009d00:	23078713          	addi	a4,a5,560
    80009d04:	00020797          	auipc	a5,0x20
    80009d08:	d2478793          	addi	a5,a5,-732 # 80029a28 <disk>
    80009d0c:	97ba                	add	a5,a5,a4
    80009d0e:	07a1                	addi	a5,a5,8
    80009d10:	853e                	mv	a0,a5
    80009d12:	ffff7097          	auipc	ra,0xffff7
    80009d16:	61e080e7          	jalr	1566(ra) # 80001330 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(id, VIRTIO_MMIO_INTERRUPT_ACK) = *R(id, VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80009d1a:	fdc42703          	lw	a4,-36(s0)
    80009d1e:	67c1                	lui	a5,0x10
    80009d20:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80009d22:	97ba                	add	a5,a5,a4
    80009d24:	07b2                	slli	a5,a5,0xc
    80009d26:	06078793          	addi	a5,a5,96
    80009d2a:	439c                	lw	a5,0(a5)
    80009d2c:	0007869b          	sext.w	a3,a5
    80009d30:	fdc42703          	lw	a4,-36(s0)
    80009d34:	67c1                	lui	a5,0x10
    80009d36:	0785                	addi	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80009d38:	97ba                	add	a5,a5,a4
    80009d3a:	07b2                	slli	a5,a5,0xc
    80009d3c:	06478793          	addi	a5,a5,100
    80009d40:	873e                	mv	a4,a5
    80009d42:	87b6                	mv	a5,a3
    80009d44:	8b8d                	andi	a5,a5,3
    80009d46:	2781                	sext.w	a5,a5
    80009d48:	c31c                	sw	a5,0(a4)

  __sync_synchronize();
    80009d4a:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk[id].used_idx != disk[id].used->idx){
    80009d4e:	aa11                	j	80009e62 <virtio_disk_intr+0x17c>
    __sync_synchronize();
    80009d50:	0330000f          	fence	rw,rw
    int idx = disk[id].used->ring[disk[id].used_idx % NUM].id;
    80009d54:	00020717          	auipc	a4,0x20
    80009d58:	cd470713          	addi	a4,a4,-812 # 80029a28 <disk>
    80009d5c:	fdc42683          	lw	a3,-36(s0)
    80009d60:	25000793          	li	a5,592
    80009d64:	02f687b3          	mul	a5,a3,a5
    80009d68:	97ba                	add	a5,a5,a4
    80009d6a:	6f98                	ld	a4,24(a5)
    80009d6c:	00020697          	auipc	a3,0x20
    80009d70:	cbc68693          	addi	a3,a3,-836 # 80029a28 <disk>
    80009d74:	fdc42603          	lw	a2,-36(s0)
    80009d78:	25000793          	li	a5,592
    80009d7c:	02f607b3          	mul	a5,a2,a5
    80009d80:	97b6                	add	a5,a5,a3
    80009d82:	0307d783          	lhu	a5,48(a5)
    80009d86:	2781                	sext.w	a5,a5
    80009d88:	8bbd                	andi	a5,a5,15
    80009d8a:	2781                	sext.w	a5,a5
    80009d8c:	078e                	slli	a5,a5,0x3
    80009d8e:	97ba                	add	a5,a5,a4
    80009d90:	43dc                	lw	a5,4(a5)
    80009d92:	fef42623          	sw	a5,-20(s0)

    if(disk[id].info[idx].status != 0)
    80009d96:	00020697          	auipc	a3,0x20
    80009d9a:	c9268693          	addi	a3,a3,-878 # 80029a28 <disk>
    80009d9e:	fec42603          	lw	a2,-20(s0)
    80009da2:	fdc42703          	lw	a4,-36(s0)
    80009da6:	87ba                	mv	a5,a4
    80009da8:	078e                	slli	a5,a5,0x3
    80009daa:	97ba                	add	a5,a5,a4
    80009dac:	078a                	slli	a5,a5,0x2
    80009dae:	97ba                	add	a5,a5,a4
    80009db0:	97b2                	add	a5,a5,a2
    80009db2:	078d                	addi	a5,a5,3
    80009db4:	0792                	slli	a5,a5,0x4
    80009db6:	97b6                	add	a5,a5,a3
    80009db8:	0107c783          	lbu	a5,16(a5)
    80009dbc:	c79d                	beqz	a5,80009dea <virtio_disk_intr+0x104>
      panic_concat(2, disk[id].name, ": virtio_disk_intr status");
    80009dbe:	00020717          	auipc	a4,0x20
    80009dc2:	c6a70713          	addi	a4,a4,-918 # 80029a28 <disk>
    80009dc6:	fdc42683          	lw	a3,-36(s0)
    80009dca:	25000793          	li	a5,592
    80009dce:	02f687b3          	mul	a5,a3,a5
    80009dd2:	97ba                	add	a5,a5,a4
    80009dd4:	639c                	ld	a5,0(a5)
    80009dd6:	00004617          	auipc	a2,0x4
    80009dda:	9ca60613          	addi	a2,a2,-1590 # 8000d7a0 <etext+0x7a0>
    80009dde:	85be                	mv	a1,a5
    80009de0:	4509                	li	a0,2
    80009de2:	ffff7097          	auipc	ra,0xffff7
    80009de6:	efa080e7          	jalr	-262(ra) # 80000cdc <panic_concat>

    struct buf *b = disk[id].info[idx].b;
    80009dea:	00020697          	auipc	a3,0x20
    80009dee:	c3e68693          	addi	a3,a3,-962 # 80029a28 <disk>
    80009df2:	fec42603          	lw	a2,-20(s0)
    80009df6:	fdc42703          	lw	a4,-36(s0)
    80009dfa:	87ba                	mv	a5,a4
    80009dfc:	078e                	slli	a5,a5,0x3
    80009dfe:	97ba                	add	a5,a5,a4
    80009e00:	078a                	slli	a5,a5,0x2
    80009e02:	97ba                	add	a5,a5,a4
    80009e04:	97b2                	add	a5,a5,a2
    80009e06:	078d                	addi	a5,a5,3
    80009e08:	0792                	slli	a5,a5,0x4
    80009e0a:	97b6                	add	a5,a5,a3
    80009e0c:	679c                	ld	a5,8(a5)
    80009e0e:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80009e12:	fe043783          	ld	a5,-32(s0)
    80009e16:	0007a223          	sw	zero,4(a5)

    wakeup(b);
    80009e1a:	fe043503          	ld	a0,-32(s0)
    80009e1e:	ffffa097          	auipc	ra,0xffffa
    80009e22:	926080e7          	jalr	-1754(ra) # 80003744 <wakeup>

    disk[id].used_idx += 1;
    80009e26:	00020717          	auipc	a4,0x20
    80009e2a:	c0270713          	addi	a4,a4,-1022 # 80029a28 <disk>
    80009e2e:	fdc42683          	lw	a3,-36(s0)
    80009e32:	25000793          	li	a5,592
    80009e36:	02f687b3          	mul	a5,a3,a5
    80009e3a:	97ba                	add	a5,a5,a4
    80009e3c:	0307d783          	lhu	a5,48(a5)
    80009e40:	2785                	addiw	a5,a5,1
    80009e42:	03079713          	slli	a4,a5,0x30
    80009e46:	9341                	srli	a4,a4,0x30
    80009e48:	00020697          	auipc	a3,0x20
    80009e4c:	be068693          	addi	a3,a3,-1056 # 80029a28 <disk>
    80009e50:	fdc42603          	lw	a2,-36(s0)
    80009e54:	25000793          	li	a5,592
    80009e58:	02f607b3          	mul	a5,a2,a5
    80009e5c:	97b6                	add	a5,a5,a3
    80009e5e:	02e79823          	sh	a4,48(a5)
  while(disk[id].used_idx != disk[id].used->idx){
    80009e62:	00020717          	auipc	a4,0x20
    80009e66:	bc670713          	addi	a4,a4,-1082 # 80029a28 <disk>
    80009e6a:	fdc42683          	lw	a3,-36(s0)
    80009e6e:	25000793          	li	a5,592
    80009e72:	02f687b3          	mul	a5,a3,a5
    80009e76:	97ba                	add	a5,a5,a4
    80009e78:	0307d603          	lhu	a2,48(a5)
    80009e7c:	00020717          	auipc	a4,0x20
    80009e80:	bac70713          	addi	a4,a4,-1108 # 80029a28 <disk>
    80009e84:	fdc42683          	lw	a3,-36(s0)
    80009e88:	25000793          	li	a5,592
    80009e8c:	02f687b3          	mul	a5,a3,a5
    80009e90:	97ba                	add	a5,a5,a4
    80009e92:	6f9c                	ld	a5,24(a5)
    80009e94:	0027d783          	lhu	a5,2(a5)
    80009e98:	0006071b          	sext.w	a4,a2
    80009e9c:	2781                	sext.w	a5,a5
    80009e9e:	eaf719e3          	bne	a4,a5,80009d50 <virtio_disk_intr+0x6a>
  }

  release(&disk[id].vdisk_lock);
    80009ea2:	fdc42703          	lw	a4,-36(s0)
    80009ea6:	25000793          	li	a5,592
    80009eaa:	02f707b3          	mul	a5,a4,a5
    80009eae:	23078713          	addi	a4,a5,560
    80009eb2:	00020797          	auipc	a5,0x20
    80009eb6:	b7678793          	addi	a5,a5,-1162 # 80029a28 <disk>
    80009eba:	97ba                	add	a5,a5,a4
    80009ebc:	07a1                	addi	a5,a5,8
    80009ebe:	853e                	mv	a0,a5
    80009ec0:	ffff7097          	auipc	ra,0xffff7
    80009ec4:	4d4080e7          	jalr	1236(ra) # 80001394 <release>
}
    80009ec8:	0001                	nop
    80009eca:	70a2                	ld	ra,40(sp)
    80009ecc:	7402                	ld	s0,32(sp)
    80009ece:	6145                	addi	sp,sp,48
    80009ed0:	8082                	ret

0000000080009ed2 <diskblockn>:

struct RaidMeta raidmeta;

uint
diskblockn(void)
{
    80009ed2:	1141                	addi	sp,sp,-16
    80009ed4:	e422                	sd	s0,8(sp)
    80009ed6:	0800                	addi	s0,sp,16
    return RAID_DISK_SIZE / BSIZE - 1;
    80009ed8:	6785                	lui	a5,0x1
    80009eda:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
}
    80009edc:	853e                	mv	a0,a5
    80009ede:	6422                	ld	s0,8(sp)
    80009ee0:	0141                	addi	sp,sp,16
    80009ee2:	8082                	ret

0000000080009ee4 <raidblockn>:

uint
raidblockn(void)
{
    80009ee4:	1141                	addi	sp,sp,-16
    80009ee6:	e406                	sd	ra,8(sp)
    80009ee8:	e022                	sd	s0,0(sp)
    80009eea:	0800                	addi	s0,sp,16
  if (!raidmeta.valid)
    80009eec:	00021797          	auipc	a5,0x21
    80009ef0:	ba478793          	addi	a5,a5,-1116 # 8002aa90 <raidmeta>
    80009ef4:	0017c783          	lbu	a5,1(a5)
    80009ef8:	e399                	bnez	a5,80009efe <raidblockn+0x1a>
    return -1;
    80009efa:	57fd                	li	a5,-1
    80009efc:	a811                	j	80009f10 <raidblockn+0x2c>
  return raidmeta.blockn();
    80009efe:	00021797          	auipc	a5,0x21
    80009f02:	b9278793          	addi	a5,a5,-1134 # 8002aa90 <raidmeta>
    80009f06:	2707b783          	ld	a5,624(a5)
    80009f0a:	9782                	jalr	a5
    80009f0c:	87aa                	mv	a5,a0
    80009f0e:	2781                	sext.w	a5,a5
}
    80009f10:	853e                	mv	a0,a5
    80009f12:	60a2                	ld	ra,8(sp)
    80009f14:	6402                	ld	s0,0(sp)
    80009f16:	0141                	addi	sp,sp,16
    80009f18:	8082                	ret

0000000080009f1a <writeraidmeta>:

void
writeraidmeta(void)
{
    80009f1a:	bd010113          	addi	sp,sp,-1072
    80009f1e:	42113423          	sd	ra,1064(sp)
    80009f22:	42813023          	sd	s0,1056(sp)
    80009f26:	43010413          	addi	s0,sp,1072
  for (int i = 0; i < DISKS; i++)
    80009f2a:	fe042623          	sw	zero,-20(s0)
    80009f2e:	a071                	j	80009fba <writeraidmeta+0xa0>
  {
    struct DiskInfo* diskinfo = raidmeta.diskinfo + i;
    80009f30:	fec42783          	lw	a5,-20(s0)
    80009f34:	00579713          	slli	a4,a5,0x5
    80009f38:	00021797          	auipc	a5,0x21
    80009f3c:	cd878793          	addi	a5,a5,-808 # 8002ac10 <raidmeta+0x180>
    80009f40:	97ba                	add	a5,a5,a4
    80009f42:	fef43023          	sd	a5,-32(s0)
    if (diskinfo->valid)
    80009f46:	fe043783          	ld	a5,-32(s0)
    80009f4a:	0187c783          	lbu	a5,24(a5)
    80009f4e:	c3ad                	beqz	a5,80009fb0 <writeraidmeta+0x96>
    {
        uchar data[BSIZE] = {0};
    80009f50:	bd840793          	addi	a5,s0,-1064
    80009f54:	40000713          	li	a4,1024
    80009f58:	863a                	mv	a2,a4
    80009f5a:	4581                	li	a1,0
    80009f5c:	853e                	mv	a0,a5
    80009f5e:	ffff7097          	auipc	ra,0xffff7
    80009f62:	5a6080e7          	jalr	1446(ra) # 80001504 <memset>
        memmove(data, &raidmeta, sizeof(raidmeta));
    80009f66:	bd840793          	addi	a5,s0,-1064
    80009f6a:	28000613          	li	a2,640
    80009f6e:	00021597          	auipc	a1,0x21
    80009f72:	b2258593          	addi	a1,a1,-1246 # 8002aa90 <raidmeta>
    80009f76:	853e                	mv	a0,a5
    80009f78:	ffff7097          	auipc	ra,0xffff7
    80009f7c:	670080e7          	jalr	1648(ra) # 800015e8 <memmove>
        int lastblock = diskblockn();
    80009f80:	00000097          	auipc	ra,0x0
    80009f84:	f52080e7          	jalr	-174(ra) # 80009ed2 <diskblockn>
    80009f88:	87aa                	mv	a5,a0
    80009f8a:	2781                	sext.w	a5,a5
    80009f8c:	fcf42e23          	sw	a5,-36(s0)
        write_block(diskinfo->pdiskn, lastblock, data);
    80009f90:	fe043783          	ld	a5,-32(s0)
    80009f94:	0197c783          	lbu	a5,25(a5)
    80009f98:	2781                	sext.w	a5,a5
    80009f9a:	bd840693          	addi	a3,s0,-1064
    80009f9e:	fdc42703          	lw	a4,-36(s0)
    80009fa2:	8636                	mv	a2,a3
    80009fa4:	85ba                	mv	a1,a4
    80009fa6:	853e                	mv	a0,a5
    80009fa8:	00000097          	auipc	ra,0x0
    80009fac:	bf8080e7          	jalr	-1032(ra) # 80009ba0 <write_block>
  for (int i = 0; i < DISKS; i++)
    80009fb0:	fec42783          	lw	a5,-20(s0)
    80009fb4:	2785                	addiw	a5,a5,1
    80009fb6:	fef42623          	sw	a5,-20(s0)
    80009fba:	fec42783          	lw	a5,-20(s0)
    80009fbe:	0007871b          	sext.w	a4,a5
    80009fc2:	4795                	li	a5,5
    80009fc4:	f6e7d6e3          	bge	a5,a4,80009f30 <writeraidmeta+0x16>
    }
  }

}
    80009fc8:	0001                	nop
    80009fca:	0001                	nop
    80009fcc:	42813083          	ld	ra,1064(sp)
    80009fd0:	42013403          	ld	s0,1056(sp)
    80009fd4:	43010113          	addi	sp,sp,1072
    80009fd8:	8082                	ret

0000000080009fda <loadraid>:

void
loadraid(void)
{
    80009fda:	be010113          	addi	sp,sp,-1056
    80009fde:	40113c23          	sd	ra,1048(sp)
    80009fe2:	40813823          	sd	s0,1040(sp)
    80009fe6:	42010413          	addi	s0,sp,1056
    uchar data[BSIZE];
    int lastblock = diskblockn();
    80009fea:	00000097          	auipc	ra,0x0
    80009fee:	ee8080e7          	jalr	-280(ra) # 80009ed2 <diskblockn>
    80009ff2:	87aa                	mv	a5,a0
    80009ff4:	2781                	sext.w	a5,a5
    80009ff6:	fef42423          	sw	a5,-24(s0)
    read_block(1, lastblock, data);
    80009ffa:	be840713          	addi	a4,s0,-1048
    80009ffe:	fe842783          	lw	a5,-24(s0)
    8000a002:	863a                	mv	a2,a4
    8000a004:	85be                	mv	a1,a5
    8000a006:	4505                	li	a0,1
    8000a008:	00000097          	auipc	ra,0x0
    8000a00c:	c6c080e7          	jalr	-916(ra) # 80009c74 <read_block>
    memmove(&raidmeta, data, sizeof(raidmeta));
    8000a010:	be840793          	addi	a5,s0,-1048
    8000a014:	28000613          	li	a2,640
    8000a018:	85be                	mv	a1,a5
    8000a01a:	00021517          	auipc	a0,0x21
    8000a01e:	a7650513          	addi	a0,a0,-1418 # 8002aa90 <raidmeta>
    8000a022:	ffff7097          	auipc	ra,0xffff7
    8000a026:	5c6080e7          	jalr	1478(ra) # 800015e8 <memmove>

    if (!raidmeta.init)
    8000a02a:	00021797          	auipc	a5,0x21
    8000a02e:	a6678793          	addi	a5,a5,-1434 # 8002aa90 <raidmeta>
    8000a032:	0007c783          	lbu	a5,0(a5)
    8000a036:	10079163          	bnez	a5,8000a138 <loadraid+0x15e>
    {
        for (int i = 0; i < DISKS; i++)
    8000a03a:	fe042623          	sw	zero,-20(s0)
    8000a03e:	a0ad                	j	8000a0a8 <loadraid+0xce>
        {
            raidmeta.diskinfo[i].pdiskn = i + 1;
    8000a040:	fec42783          	lw	a5,-20(s0)
    8000a044:	0ff7f793          	zext.b	a5,a5
    8000a048:	2785                	addiw	a5,a5,1
    8000a04a:	0ff7f713          	zext.b	a4,a5
    8000a04e:	00021697          	auipc	a3,0x21
    8000a052:	a4268693          	addi	a3,a3,-1470 # 8002aa90 <raidmeta>
    8000a056:	fec42783          	lw	a5,-20(s0)
    8000a05a:	0796                	slli	a5,a5,0x5
    8000a05c:	97b6                	add	a5,a5,a3
    8000a05e:	18e78ca3          	sb	a4,409(a5)
            raidmeta.diskinfo[i].valid = 1;
    8000a062:	00021717          	auipc	a4,0x21
    8000a066:	a2e70713          	addi	a4,a4,-1490 # 8002aa90 <raidmeta>
    8000a06a:	fec42783          	lw	a5,-20(s0)
    8000a06e:	0796                	slli	a5,a5,0x5
    8000a070:	97ba                	add	a5,a5,a4
    8000a072:	4705                	li	a4,1
    8000a074:	18e78c23          	sb	a4,408(a5)
            initlock(&raidmeta.diskinfo[i].mutex, "diskinfomutex");
    8000a078:	fec42783          	lw	a5,-20(s0)
    8000a07c:	07b1                	addi	a5,a5,12
    8000a07e:	00579713          	slli	a4,a5,0x5
    8000a082:	00021797          	auipc	a5,0x21
    8000a086:	a0e78793          	addi	a5,a5,-1522 # 8002aa90 <raidmeta>
    8000a08a:	97ba                	add	a5,a5,a4
    8000a08c:	00003597          	auipc	a1,0x3
    8000a090:	73458593          	addi	a1,a1,1844 # 8000d7c0 <etext+0x7c0>
    8000a094:	853e                	mv	a0,a5
    8000a096:	ffff7097          	auipc	ra,0xffff7
    8000a09a:	26a080e7          	jalr	618(ra) # 80001300 <initlock>
        for (int i = 0; i < DISKS; i++)
    8000a09e:	fec42783          	lw	a5,-20(s0)
    8000a0a2:	2785                	addiw	a5,a5,1
    8000a0a4:	fef42623          	sw	a5,-20(s0)
    8000a0a8:	fec42783          	lw	a5,-20(s0)
    8000a0ac:	0007871b          	sext.w	a4,a5
    8000a0b0:	4795                	li	a5,5
    8000a0b2:	f8e7d7e3          	bge	a5,a4,8000a040 <loadraid+0x66>
        }
        raidmeta.diskinfo[DISKS].valid = 0;
    8000a0b6:	00021797          	auipc	a5,0x21
    8000a0ba:	9da78793          	addi	a5,a5,-1574 # 8002aa90 <raidmeta>
    8000a0be:	24078c23          	sb	zero,600(a5)

        initlock(&raidmeta.dirty, "raidmetadirty");
    8000a0c2:	00003597          	auipc	a1,0x3
    8000a0c6:	70e58593          	addi	a1,a1,1806 # 8000d7d0 <etext+0x7d0>
    8000a0ca:	00021517          	auipc	a0,0x21
    8000a0ce:	9ce50513          	addi	a0,a0,-1586 # 8002aa98 <raidmeta+0x8>
    8000a0d2:	ffff7097          	auipc	ra,0xffff7
    8000a0d6:	22e080e7          	jalr	558(ra) # 80001300 <initlock>

        raidmeta.init = 1;
    8000a0da:	00021797          	auipc	a5,0x21
    8000a0de:	9b678793          	addi	a5,a5,-1610 # 8002aa90 <raidmeta>
    8000a0e2:	4705                	li	a4,1
    8000a0e4:	00e78023          	sb	a4,0(a5)
        raidmeta.valid = 0;
    8000a0e8:	00021797          	auipc	a5,0x21
    8000a0ec:	9a878793          	addi	a5,a5,-1624 # 8002aa90 <raidmeta>
    8000a0f0:	000780a3          	sb	zero,1(a5)
        raidmeta.maxdirty = 0;
    8000a0f4:	00021797          	auipc	a5,0x21
    8000a0f8:	99c78793          	addi	a5,a5,-1636 # 8002aa90 <raidmeta>
    8000a0fc:	0207a023          	sw	zero,32(a5)
        raidmeta.read = 0;
    8000a100:	00021797          	auipc	a5,0x21
    8000a104:	99078793          	addi	a5,a5,-1648 # 8002aa90 <raidmeta>
    8000a108:	2607b023          	sd	zero,608(a5)
        raidmeta.write = 0;
    8000a10c:	00021797          	auipc	a5,0x21
    8000a110:	98478793          	addi	a5,a5,-1660 # 8002aa90 <raidmeta>
    8000a114:	2607b423          	sd	zero,616(a5)
        raidmeta.blockn = 0;
    8000a118:	00021797          	auipc	a5,0x21
    8000a11c:	97878793          	addi	a5,a5,-1672 # 8002aa90 <raidmeta>
    8000a120:	2607b823          	sd	zero,624(a5)
        raidmeta.maxdirty = -1;
    8000a124:	00021797          	auipc	a5,0x21
    8000a128:	96c78793          	addi	a5,a5,-1684 # 8002aa90 <raidmeta>
    8000a12c:	577d                	li	a4,-1
    8000a12e:	d398                	sw	a4,32(a5)

        writeraidmeta();
    8000a130:	00000097          	auipc	ra,0x0
    8000a134:	dea080e7          	jalr	-534(ra) # 80009f1a <writeraidmeta>
        return;
    }

}
    8000a138:	41813083          	ld	ra,1048(sp)
    8000a13c:	41013403          	ld	s0,1040(sp)
    8000a140:	42010113          	addi	sp,sp,1056
    8000a144:	8082                	ret

000000008000a146 <setraidtype>:

int
setraidtype(int type)
{
    8000a146:	1101                	addi	sp,sp,-32
    8000a148:	ec06                	sd	ra,24(sp)
    8000a14a:	e822                	sd	s0,16(sp)
    8000a14c:	1000                	addi	s0,sp,32
    8000a14e:	87aa                	mv	a5,a0
    8000a150:	fef42623          	sw	a5,-20(s0)
  if (type < 0 || type >= NELEM(initTable))
    8000a154:	fec42783          	lw	a5,-20(s0)
    8000a158:	2781                	sext.w	a5,a5
    8000a15a:	0007c863          	bltz	a5,8000a16a <setraidtype+0x24>
    8000a15e:	fec42783          	lw	a5,-20(s0)
    8000a162:	873e                	mv	a4,a5
    8000a164:	478d                	li	a5,3
    8000a166:	00e7f463          	bgeu	a5,a4,8000a16e <setraidtype+0x28>
    return -1;
    8000a16a:	57fd                	li	a5,-1
    8000a16c:	a821                	j	8000a184 <setraidtype+0x3e>

  return (*initTable[type])();
    8000a16e:	00006717          	auipc	a4,0x6
    8000a172:	50a70713          	addi	a4,a4,1290 # 80010678 <initTable>
    8000a176:	fec42783          	lw	a5,-20(s0)
    8000a17a:	078e                	slli	a5,a5,0x3
    8000a17c:	97ba                	add	a5,a5,a4
    8000a17e:	639c                	ld	a5,0(a5)
    8000a180:	9782                	jalr	a5
    8000a182:	87aa                	mv	a5,a0
}
    8000a184:	853e                	mv	a0,a5
    8000a186:	60e2                	ld	ra,24(sp)
    8000a188:	6442                	ld	s0,16(sp)
    8000a18a:	6105                	addi	sp,sp,32
    8000a18c:	8082                	ret

000000008000a18e <readraid>:

int
readraid(int vblkn, uchar* data)
{
    8000a18e:	1101                	addi	sp,sp,-32
    8000a190:	ec06                	sd	ra,24(sp)
    8000a192:	e822                	sd	s0,16(sp)
    8000a194:	1000                	addi	s0,sp,32
    8000a196:	87aa                	mv	a5,a0
    8000a198:	feb43023          	sd	a1,-32(s0)
    8000a19c:	fef42623          	sw	a5,-20(s0)
  if (!raidmeta.valid)
    8000a1a0:	00021797          	auipc	a5,0x21
    8000a1a4:	8f078793          	addi	a5,a5,-1808 # 8002aa90 <raidmeta>
    8000a1a8:	0017c783          	lbu	a5,1(a5)
    8000a1ac:	e399                	bnez	a5,8000a1b2 <readraid+0x24>
    return -1;
    8000a1ae:	57fd                	li	a5,-1
    8000a1b0:	a099                	j	8000a1f6 <readraid+0x68>

  if (vblkn < 0 || vblkn >= raidmeta.blockn())
    8000a1b2:	fec42783          	lw	a5,-20(s0)
    8000a1b6:	2781                	sext.w	a5,a5
    8000a1b8:	0207c063          	bltz	a5,8000a1d8 <readraid+0x4a>
    8000a1bc:	00021797          	auipc	a5,0x21
    8000a1c0:	8d478793          	addi	a5,a5,-1836 # 8002aa90 <raidmeta>
    8000a1c4:	2707b783          	ld	a5,624(a5)
    8000a1c8:	9782                	jalr	a5
    8000a1ca:	87aa                	mv	a5,a0
    8000a1cc:	0007871b          	sext.w	a4,a5
    8000a1d0:	fec42783          	lw	a5,-20(s0)
    8000a1d4:	00e7e463          	bltu	a5,a4,8000a1dc <readraid+0x4e>
     return -2;
    8000a1d8:	57f9                	li	a5,-2
    8000a1da:	a831                	j	8000a1f6 <readraid+0x68>

  return raidmeta.read(vblkn, data);
    8000a1dc:	00021797          	auipc	a5,0x21
    8000a1e0:	8b478793          	addi	a5,a5,-1868 # 8002aa90 <raidmeta>
    8000a1e4:	2607b783          	ld	a5,608(a5)
    8000a1e8:	fec42703          	lw	a4,-20(s0)
    8000a1ec:	fe043583          	ld	a1,-32(s0)
    8000a1f0:	853a                	mv	a0,a4
    8000a1f2:	9782                	jalr	a5
    8000a1f4:	87aa                	mv	a5,a0
}
    8000a1f6:	853e                	mv	a0,a5
    8000a1f8:	60e2                	ld	ra,24(sp)
    8000a1fa:	6442                	ld	s0,16(sp)
    8000a1fc:	6105                	addi	sp,sp,32
    8000a1fe:	8082                	ret

000000008000a200 <writeraid>:

int
writeraid(int vblkn, uchar* data)
{
    8000a200:	1101                	addi	sp,sp,-32
    8000a202:	ec06                	sd	ra,24(sp)
    8000a204:	e822                	sd	s0,16(sp)
    8000a206:	1000                	addi	s0,sp,32
    8000a208:	87aa                	mv	a5,a0
    8000a20a:	feb43023          	sd	a1,-32(s0)
    8000a20e:	fef42623          	sw	a5,-20(s0)
    if (!raidmeta.valid)
    8000a212:	00021797          	auipc	a5,0x21
    8000a216:	87e78793          	addi	a5,a5,-1922 # 8002aa90 <raidmeta>
    8000a21a:	0017c783          	lbu	a5,1(a5)
    8000a21e:	e399                	bnez	a5,8000a224 <writeraid+0x24>
        return -1;
    8000a220:	57fd                	li	a5,-1
    8000a222:	a099                	j	8000a268 <writeraid+0x68>

    if (vblkn < 0 || vblkn >= raidmeta.blockn())
    8000a224:	fec42783          	lw	a5,-20(s0)
    8000a228:	2781                	sext.w	a5,a5
    8000a22a:	0207c063          	bltz	a5,8000a24a <writeraid+0x4a>
    8000a22e:	00021797          	auipc	a5,0x21
    8000a232:	86278793          	addi	a5,a5,-1950 # 8002aa90 <raidmeta>
    8000a236:	2707b783          	ld	a5,624(a5)
    8000a23a:	9782                	jalr	a5
    8000a23c:	87aa                	mv	a5,a0
    8000a23e:	0007871b          	sext.w	a4,a5
    8000a242:	fec42783          	lw	a5,-20(s0)
    8000a246:	00e7e463          	bltu	a5,a4,8000a24e <writeraid+0x4e>
        return -2;
    8000a24a:	57f9                	li	a5,-2
    8000a24c:	a831                	j	8000a268 <writeraid+0x68>

    return raidmeta.write(vblkn, data);
    8000a24e:	00021797          	auipc	a5,0x21
    8000a252:	84278793          	addi	a5,a5,-1982 # 8002aa90 <raidmeta>
    8000a256:	2687b783          	ld	a5,616(a5)
    8000a25a:	fec42703          	lw	a4,-20(s0)
    8000a25e:	fe043583          	ld	a1,-32(s0)
    8000a262:	853a                	mv	a0,a4
    8000a264:	9782                	jalr	a5
    8000a266:	87aa                	mv	a5,a0
}
    8000a268:	853e                	mv	a0,a5
    8000a26a:	60e2                	ld	ra,24(sp)
    8000a26c:	6442                	ld	s0,16(sp)
    8000a26e:	6105                	addi	sp,sp,32
    8000a270:	8082                	ret

000000008000a272 <readdiskpair>:

uint64
readdiskpair(struct DiskPair* diskpair, int pblkn, uchar* data)
{
    8000a272:	7139                	addi	sp,sp,-64
    8000a274:	fc06                	sd	ra,56(sp)
    8000a276:	f822                	sd	s0,48(sp)
    8000a278:	0080                	addi	s0,sp,64
    8000a27a:	fca43c23          	sd	a0,-40(s0)
    8000a27e:	87ae                	mv	a5,a1
    8000a280:	fcc43423          	sd	a2,-56(s0)
    8000a284:	fcf42a23          	sw	a5,-44(s0)
    int diskn = -1, readfrom = -1;
    8000a288:	57fd                	li	a5,-1
    8000a28a:	fef42423          	sw	a5,-24(s0)
    8000a28e:	57fd                	li	a5,-1
    8000a290:	fef42223          	sw	a5,-28(s0)

    acquire(&diskpair->mutex);
    8000a294:	fd843783          	ld	a5,-40(s0)
    8000a298:	853e                	mv	a0,a5
    8000a29a:	ffff7097          	auipc	ra,0xffff7
    8000a29e:	096080e7          	jalr	150(ra) # 80001330 <acquire>
    while (1)
    {

        if (diskpair->diskinfo[0]->valid == 0 && diskpair->diskinfo[1]->valid == 0)
    8000a2a2:	fd843783          	ld	a5,-40(s0)
    8000a2a6:	6f9c                	ld	a5,24(a5)
    8000a2a8:	0187c783          	lbu	a5,24(a5)
    8000a2ac:	e385                	bnez	a5,8000a2cc <readdiskpair+0x5a>
    8000a2ae:	fd843783          	ld	a5,-40(s0)
    8000a2b2:	739c                	ld	a5,32(a5)
    8000a2b4:	0187c783          	lbu	a5,24(a5)
    8000a2b8:	eb91                	bnez	a5,8000a2cc <readdiskpair+0x5a>
        {
            release(&diskpair->mutex);
    8000a2ba:	fd843783          	ld	a5,-40(s0)
    8000a2be:	853e                	mv	a0,a5
    8000a2c0:	ffff7097          	auipc	ra,0xffff7
    8000a2c4:	0d4080e7          	jalr	212(ra) # 80001394 <release>
            return -1;
    8000a2c8:	57fd                	li	a5,-1
    8000a2ca:	aa1d                	j	8000a400 <readdiskpair+0x18e>
        }

        if (diskpair->writing)
    8000a2cc:	fd843783          	ld	a5,-40(s0)
    8000a2d0:	0287c783          	lbu	a5,40(a5)
    8000a2d4:	cb99                	beqz	a5,8000a2ea <readdiskpair+0x78>
        {
            sleep(diskpair, &diskpair->mutex);
    8000a2d6:	fd843783          	ld	a5,-40(s0)
    8000a2da:	85be                	mv	a1,a5
    8000a2dc:	fd843503          	ld	a0,-40(s0)
    8000a2e0:	ffff9097          	auipc	ra,0xffff9
    8000a2e4:	3e8080e7          	jalr	1000(ra) # 800036c8 <sleep>
            continue;
    8000a2e8:	a065                	j	8000a390 <readdiskpair+0x11e>
        }

        for (int i = 0; i < 2; i++)
    8000a2ea:	fe042623          	sw	zero,-20(s0)
    8000a2ee:	a049                	j	8000a370 <readdiskpair+0xfe>
            if ((!diskpair->reading[i]) && diskpair->diskinfo[i]->valid)
    8000a2f0:	fd843703          	ld	a4,-40(s0)
    8000a2f4:	fec42783          	lw	a5,-20(s0)
    8000a2f8:	97ba                	add	a5,a5,a4
    8000a2fa:	0297c783          	lbu	a5,41(a5)
    8000a2fe:	e7a5                	bnez	a5,8000a366 <readdiskpair+0xf4>
    8000a300:	fd843703          	ld	a4,-40(s0)
    8000a304:	fec42783          	lw	a5,-20(s0)
    8000a308:	0789                	addi	a5,a5,2
    8000a30a:	078e                	slli	a5,a5,0x3
    8000a30c:	97ba                	add	a5,a5,a4
    8000a30e:	679c                	ld	a5,8(a5)
    8000a310:	0187c783          	lbu	a5,24(a5)
    8000a314:	cba9                	beqz	a5,8000a366 <readdiskpair+0xf4>
            {
                diskpair->reading[i] = 1;
    8000a316:	fd843703          	ld	a4,-40(s0)
    8000a31a:	fec42783          	lw	a5,-20(s0)
    8000a31e:	97ba                	add	a5,a5,a4
    8000a320:	4705                	li	a4,1
    8000a322:	02e784a3          	sb	a4,41(a5)
                release(&diskpair->mutex);
    8000a326:	fd843783          	ld	a5,-40(s0)
    8000a32a:	853e                	mv	a0,a5
    8000a32c:	ffff7097          	auipc	ra,0xffff7
    8000a330:	068080e7          	jalr	104(ra) # 80001394 <release>
                diskn = diskpair->diskinfo[i]->pdiskn;
    8000a334:	fd843703          	ld	a4,-40(s0)
    8000a338:	fec42783          	lw	a5,-20(s0)
    8000a33c:	0789                	addi	a5,a5,2
    8000a33e:	078e                	slli	a5,a5,0x3
    8000a340:	97ba                	add	a5,a5,a4
    8000a342:	679c                	ld	a5,8(a5)
    8000a344:	0197c783          	lbu	a5,25(a5)
    8000a348:	fef42423          	sw	a5,-24(s0)
                readfrom = i;
    8000a34c:	fec42783          	lw	a5,-20(s0)
    8000a350:	fef42223          	sw	a5,-28(s0)
                goto readdiskpairloopend;
    8000a354:	0001                	nop


       sleep(diskpair, &diskpair->mutex);
    }
readdiskpairloopend:
    if (diskn == -1 || readfrom == -1)
    8000a356:	fe842783          	lw	a5,-24(s0)
    8000a35a:	0007871b          	sext.w	a4,a5
    8000a35e:	57fd                	li	a5,-1
    8000a360:	04f70063          	beq	a4,a5,8000a3a0 <readdiskpair+0x12e>
    8000a364:	a03d                	j	8000a392 <readdiskpair+0x120>
        for (int i = 0; i < 2; i++)
    8000a366:	fec42783          	lw	a5,-20(s0)
    8000a36a:	2785                	addiw	a5,a5,1
    8000a36c:	fef42623          	sw	a5,-20(s0)
    8000a370:	fec42783          	lw	a5,-20(s0)
    8000a374:	0007871b          	sext.w	a4,a5
    8000a378:	4785                	li	a5,1
    8000a37a:	f6e7dbe3          	bge	a5,a4,8000a2f0 <readdiskpair+0x7e>
       sleep(diskpair, &diskpair->mutex);
    8000a37e:	fd843783          	ld	a5,-40(s0)
    8000a382:	85be                	mv	a1,a5
    8000a384:	fd843503          	ld	a0,-40(s0)
    8000a388:	ffff9097          	auipc	ra,0xffff9
    8000a38c:	340080e7          	jalr	832(ra) # 800036c8 <sleep>
        if (diskpair->diskinfo[0]->valid == 0 && diskpair->diskinfo[1]->valid == 0)
    8000a390:	bf09                	j	8000a2a2 <readdiskpair+0x30>
    if (diskn == -1 || readfrom == -1)
    8000a392:	fe442783          	lw	a5,-28(s0)
    8000a396:	0007871b          	sext.w	a4,a5
    8000a39a:	57fd                	li	a5,-1
    8000a39c:	00f71a63          	bne	a4,a5,8000a3b0 <readdiskpair+0x13e>
        panic("readdiskpair");
    8000a3a0:	00003517          	auipc	a0,0x3
    8000a3a4:	44050513          	addi	a0,a0,1088 # 8000d7e0 <etext+0x7e0>
    8000a3a8:	ffff7097          	auipc	ra,0xffff7
    8000a3ac:	8e0080e7          	jalr	-1824(ra) # 80000c88 <panic>

    read_block(diskn, pblkn, data);
    8000a3b0:	fd442703          	lw	a4,-44(s0)
    8000a3b4:	fe842783          	lw	a5,-24(s0)
    8000a3b8:	fc843603          	ld	a2,-56(s0)
    8000a3bc:	85ba                	mv	a1,a4
    8000a3be:	853e                	mv	a0,a5
    8000a3c0:	00000097          	auipc	ra,0x0
    8000a3c4:	8b4080e7          	jalr	-1868(ra) # 80009c74 <read_block>

    acquire(&diskpair->mutex);
    8000a3c8:	fd843783          	ld	a5,-40(s0)
    8000a3cc:	853e                	mv	a0,a5
    8000a3ce:	ffff7097          	auipc	ra,0xffff7
    8000a3d2:	f62080e7          	jalr	-158(ra) # 80001330 <acquire>
    diskpair->reading[readfrom] = 0;
    8000a3d6:	fd843703          	ld	a4,-40(s0)
    8000a3da:	fe442783          	lw	a5,-28(s0)
    8000a3de:	97ba                	add	a5,a5,a4
    8000a3e0:	020784a3          	sb	zero,41(a5)
    release(&diskpair->mutex);
    8000a3e4:	fd843783          	ld	a5,-40(s0)
    8000a3e8:	853e                	mv	a0,a5
    8000a3ea:	ffff7097          	auipc	ra,0xffff7
    8000a3ee:	faa080e7          	jalr	-86(ra) # 80001394 <release>
    wakeup(diskpair);
    8000a3f2:	fd843503          	ld	a0,-40(s0)
    8000a3f6:	ffff9097          	auipc	ra,0xffff9
    8000a3fa:	34e080e7          	jalr	846(ra) # 80003744 <wakeup>

    return 0;
    8000a3fe:	4781                	li	a5,0
}
    8000a400:	853e                	mv	a0,a5
    8000a402:	70e2                	ld	ra,56(sp)
    8000a404:	7442                	ld	s0,48(sp)
    8000a406:	6121                	addi	sp,sp,64
    8000a408:	8082                	ret

000000008000a40a <writediskpair>:

uint64
writediskpair(struct DiskPair* diskpair, int pblkn, uchar* data)
{
    8000a40a:	7139                	addi	sp,sp,-64
    8000a40c:	fc06                	sd	ra,56(sp)
    8000a40e:	f822                	sd	s0,48(sp)
    8000a410:	0080                	addi	s0,sp,64
    8000a412:	fca43c23          	sd	a0,-40(s0)
    8000a416:	87ae                	mv	a5,a1
    8000a418:	fcc43423          	sd	a2,-56(s0)
    8000a41c:	fcf42a23          	sw	a5,-44(s0)
    acquire(&diskpair->mutex);
    8000a420:	fd843783          	ld	a5,-40(s0)
    8000a424:	853e                	mv	a0,a5
    8000a426:	ffff7097          	auipc	ra,0xffff7
    8000a42a:	f0a080e7          	jalr	-246(ra) # 80001330 <acquire>

    while (1)
    {
        if (diskpair->diskinfo[0]->valid == 0 && diskpair->diskinfo[1]->valid == 0)
    8000a42e:	fd843783          	ld	a5,-40(s0)
    8000a432:	6f9c                	ld	a5,24(a5)
    8000a434:	0187c783          	lbu	a5,24(a5)
    8000a438:	e385                	bnez	a5,8000a458 <writediskpair+0x4e>
    8000a43a:	fd843783          	ld	a5,-40(s0)
    8000a43e:	739c                	ld	a5,32(a5)
    8000a440:	0187c783          	lbu	a5,24(a5)
    8000a444:	eb91                	bnez	a5,8000a458 <writediskpair+0x4e>
        {
            release(&diskpair->mutex);
    8000a446:	fd843783          	ld	a5,-40(s0)
    8000a44a:	853e                	mv	a0,a5
    8000a44c:	ffff7097          	auipc	ra,0xffff7
    8000a450:	f48080e7          	jalr	-184(ra) # 80001394 <release>
            return -1;
    8000a454:	57fd                	li	a5,-1
    8000a456:	a8d5                	j	8000a54a <writediskpair+0x140>
        }

        if (diskpair->writing)
    8000a458:	fd843783          	ld	a5,-40(s0)
    8000a45c:	0287c783          	lbu	a5,40(a5)
    8000a460:	cb99                	beqz	a5,8000a476 <writediskpair+0x6c>
        {
            sleep(diskpair, &diskpair->mutex);
    8000a462:	fd843783          	ld	a5,-40(s0)
    8000a466:	85be                	mv	a1,a5
    8000a468:	fd843503          	ld	a0,-40(s0)
    8000a46c:	ffff9097          	auipc	ra,0xffff9
    8000a470:	25c080e7          	jalr	604(ra) # 800036c8 <sleep>
            continue;
    8000a474:	a0a9                	j	8000a4be <writediskpair+0xb4>
        }

        if (diskpair->reading[0] || diskpair->reading[1])
    8000a476:	fd843783          	ld	a5,-40(s0)
    8000a47a:	0297c783          	lbu	a5,41(a5)
    8000a47e:	e791                	bnez	a5,8000a48a <writediskpair+0x80>
    8000a480:	fd843783          	ld	a5,-40(s0)
    8000a484:	02a7c783          	lbu	a5,42(a5)
    8000a488:	cb99                	beqz	a5,8000a49e <writediskpair+0x94>
        {
            sleep(diskpair, &diskpair->mutex);
    8000a48a:	fd843783          	ld	a5,-40(s0)
    8000a48e:	85be                	mv	a1,a5
    8000a490:	fd843503          	ld	a0,-40(s0)
    8000a494:	ffff9097          	auipc	ra,0xffff9
    8000a498:	234080e7          	jalr	564(ra) # 800036c8 <sleep>
            continue;
    8000a49c:	a00d                	j	8000a4be <writediskpair+0xb4>
        }

        diskpair->writing = 1;
    8000a49e:	fd843783          	ld	a5,-40(s0)
    8000a4a2:	4705                	li	a4,1
    8000a4a4:	02e78423          	sb	a4,40(a5)
        release(&diskpair->mutex);
    8000a4a8:	fd843783          	ld	a5,-40(s0)
    8000a4ac:	853e                	mv	a0,a5
    8000a4ae:	ffff7097          	auipc	ra,0xffff7
    8000a4b2:	ee6080e7          	jalr	-282(ra) # 80001394 <release>
        break;
    8000a4b6:	0001                	nop
    }

    for (int i = 0; i < 2; i++)
    8000a4b8:	fe042623          	sw	zero,-20(s0)
    8000a4bc:	a0b9                	j	8000a50a <writediskpair+0x100>
        if (diskpair->diskinfo[0]->valid == 0 && diskpair->diskinfo[1]->valid == 0)
    8000a4be:	bf85                	j	8000a42e <writediskpair+0x24>
        if (diskpair->diskinfo[i]->valid)
    8000a4c0:	fd843703          	ld	a4,-40(s0)
    8000a4c4:	fec42783          	lw	a5,-20(s0)
    8000a4c8:	0789                	addi	a5,a5,2
    8000a4ca:	078e                	slli	a5,a5,0x3
    8000a4cc:	97ba                	add	a5,a5,a4
    8000a4ce:	679c                	ld	a5,8(a5)
    8000a4d0:	0187c783          	lbu	a5,24(a5)
    8000a4d4:	c795                	beqz	a5,8000a500 <writediskpair+0xf6>
            write_block(diskpair->diskinfo[i]->pdiskn, pblkn, (uchar*)data);
    8000a4d6:	fd843703          	ld	a4,-40(s0)
    8000a4da:	fec42783          	lw	a5,-20(s0)
    8000a4de:	0789                	addi	a5,a5,2
    8000a4e0:	078e                	slli	a5,a5,0x3
    8000a4e2:	97ba                	add	a5,a5,a4
    8000a4e4:	679c                	ld	a5,8(a5)
    8000a4e6:	0197c783          	lbu	a5,25(a5)
    8000a4ea:	2781                	sext.w	a5,a5
    8000a4ec:	fd442703          	lw	a4,-44(s0)
    8000a4f0:	fc843603          	ld	a2,-56(s0)
    8000a4f4:	85ba                	mv	a1,a4
    8000a4f6:	853e                	mv	a0,a5
    8000a4f8:	fffff097          	auipc	ra,0xfffff
    8000a4fc:	6a8080e7          	jalr	1704(ra) # 80009ba0 <write_block>
    for (int i = 0; i < 2; i++)
    8000a500:	fec42783          	lw	a5,-20(s0)
    8000a504:	2785                	addiw	a5,a5,1
    8000a506:	fef42623          	sw	a5,-20(s0)
    8000a50a:	fec42783          	lw	a5,-20(s0)
    8000a50e:	0007871b          	sext.w	a4,a5
    8000a512:	4785                	li	a5,1
    8000a514:	fae7d6e3          	bge	a5,a4,8000a4c0 <writediskpair+0xb6>

    acquire(&diskpair->mutex);
    8000a518:	fd843783          	ld	a5,-40(s0)
    8000a51c:	853e                	mv	a0,a5
    8000a51e:	ffff7097          	auipc	ra,0xffff7
    8000a522:	e12080e7          	jalr	-494(ra) # 80001330 <acquire>
    diskpair->writing = 0;
    8000a526:	fd843783          	ld	a5,-40(s0)
    8000a52a:	02078423          	sb	zero,40(a5)
    release(&diskpair->mutex);
    8000a52e:	fd843783          	ld	a5,-40(s0)
    8000a532:	853e                	mv	a0,a5
    8000a534:	ffff7097          	auipc	ra,0xffff7
    8000a538:	e60080e7          	jalr	-416(ra) # 80001394 <release>
    wakeup(diskpair);
    8000a53c:	fd843503          	ld	a0,-40(s0)
    8000a540:	ffff9097          	auipc	ra,0xffff9
    8000a544:	204080e7          	jalr	516(ra) # 80003744 <wakeup>

    return 0;
    8000a548:	4781                	li	a5,0
}
    8000a54a:	853e                	mv	a0,a5
    8000a54c:	70e2                	ld	ra,56(sp)
    8000a54e:	7442                	ld	s0,48(sp)
    8000a550:	6121                	addi	sp,sp,64
    8000a552:	8082                	ret

000000008000a554 <raidfail>:

int
raidfail(int diskn)
{
    8000a554:	1101                	addi	sp,sp,-32
    8000a556:	ec22                	sd	s0,24(sp)
    8000a558:	1000                	addi	s0,sp,32
    8000a55a:	87aa                	mv	a5,a0
    8000a55c:	fef42623          	sw	a5,-20(s0)
  if (diskn >= DISKS)
    8000a560:	fec42783          	lw	a5,-20(s0)
    8000a564:	0007871b          	sext.w	a4,a5
    8000a568:	4795                	li	a5,5
    8000a56a:	00e7d463          	bge	a5,a4,8000a572 <raidfail+0x1e>
    return -1;
    8000a56e:	57fd                	li	a5,-1
    8000a570:	a821                	j	8000a588 <raidfail+0x34>
  raidmeta.diskinfo[diskn].valid = 0;
    8000a572:	00020717          	auipc	a4,0x20
    8000a576:	51e70713          	addi	a4,a4,1310 # 8002aa90 <raidmeta>
    8000a57a:	fec42783          	lw	a5,-20(s0)
    8000a57e:	0796                	slli	a5,a5,0x5
    8000a580:	97ba                	add	a5,a5,a4
    8000a582:	18078c23          	sb	zero,408(a5)
  return 0;
    8000a586:	4781                	li	a5,0
}
    8000a588:	853e                	mv	a0,a5
    8000a58a:	6462                	ld	s0,24(sp)
    8000a58c:	6105                	addi	sp,sp,32
    8000a58e:	8082                	ret

000000008000a590 <raidrepair>:

int
raidrepair(int diskn)
{
    8000a590:	1101                	addi	sp,sp,-32
    8000a592:	ec06                	sd	ra,24(sp)
    8000a594:	e822                	sd	s0,16(sp)
    8000a596:	1000                	addi	s0,sp,32
    8000a598:	87aa                	mv	a5,a0
    8000a59a:	fef42623          	sw	a5,-20(s0)
  if (!raidmeta.valid)
    8000a59e:	00020797          	auipc	a5,0x20
    8000a5a2:	4f278793          	addi	a5,a5,1266 # 8002aa90 <raidmeta>
    8000a5a6:	0017c783          	lbu	a5,1(a5)
    8000a5aa:	e399                	bnez	a5,8000a5b0 <raidrepair+0x20>
    return -1;
    8000a5ac:	57fd                	li	a5,-1
    8000a5ae:	a821                	j	8000a5c6 <raidrepair+0x36>

  return raidmeta.repair(diskn);
    8000a5b0:	00020797          	auipc	a5,0x20
    8000a5b4:	4e078793          	addi	a5,a5,1248 # 8002aa90 <raidmeta>
    8000a5b8:	2787b783          	ld	a5,632(a5)
    8000a5bc:	fec42703          	lw	a4,-20(s0)
    8000a5c0:	853a                	mv	a0,a4
    8000a5c2:	9782                	jalr	a5
    8000a5c4:	87aa                	mv	a5,a0
    8000a5c6:	853e                	mv	a0,a5
    8000a5c8:	60e2                	ld	ra,24(sp)
    8000a5ca:	6442                	ld	s0,16(sp)
    8000a5cc:	6105                	addi	sp,sp,32
    8000a5ce:	8082                	ret

000000008000a5d0 <raid0blockn>:
int raid0write(int vblkn, uchar* data);
int raid0repair(int diskn);

uint
raid0blockn(void)
{
    8000a5d0:	1141                	addi	sp,sp,-16
    8000a5d2:	e406                	sd	ra,8(sp)
    8000a5d4:	e022                	sd	s0,0(sp)
    8000a5d6:	0800                	addi	s0,sp,16
  return diskblockn() * DISKS;
    8000a5d8:	00000097          	auipc	ra,0x0
    8000a5dc:	8fa080e7          	jalr	-1798(ra) # 80009ed2 <diskblockn>
    8000a5e0:	87aa                	mv	a5,a0
    8000a5e2:	2781                	sext.w	a5,a5
    8000a5e4:	873e                	mv	a4,a5
    8000a5e6:	87ba                	mv	a5,a4
    8000a5e8:	0017979b          	slliw	a5,a5,0x1
    8000a5ec:	9fb9                	addw	a5,a5,a4
    8000a5ee:	0017979b          	slliw	a5,a5,0x1
    8000a5f2:	2781                	sext.w	a5,a5
}
    8000a5f4:	853e                	mv	a0,a5
    8000a5f6:	60a2                	ld	ra,8(sp)
    8000a5f8:	6402                	ld	s0,0(sp)
    8000a5fa:	0141                	addi	sp,sp,16
    8000a5fc:	8082                	ret

000000008000a5fe <raid0init>:

int
raid0init(void)
{
    8000a5fe:	1101                	addi	sp,sp,-32
    8000a600:	ec06                	sd	ra,24(sp)
    8000a602:	e822                	sd	s0,16(sp)
    8000a604:	1000                	addi	s0,sp,32
  raidmeta.valid = 1;
    8000a606:	00020797          	auipc	a5,0x20
    8000a60a:	48a78793          	addi	a5,a5,1162 # 8002aa90 <raidmeta>
    8000a60e:	4705                	li	a4,1
    8000a610:	00e780a3          	sb	a4,1(a5)
  raidmeta.type = RAID0;
    8000a614:	00020797          	auipc	a5,0x20
    8000a618:	47c78793          	addi	a5,a5,1148 # 8002aa90 <raidmeta>
    8000a61c:	0007a223          	sw	zero,4(a5)
  raidmeta.read = raid0read;
    8000a620:	00020797          	auipc	a5,0x20
    8000a624:	47078793          	addi	a5,a5,1136 # 8002aa90 <raidmeta>
    8000a628:	00000717          	auipc	a4,0x0
    8000a62c:	0aa70713          	addi	a4,a4,170 # 8000a6d2 <raid0read>
    8000a630:	26e7b023          	sd	a4,608(a5)
  raidmeta.write = raid0write;
    8000a634:	00020797          	auipc	a5,0x20
    8000a638:	45c78793          	addi	a5,a5,1116 # 8002aa90 <raidmeta>
    8000a63c:	00000717          	auipc	a4,0x0
    8000a640:	17a70713          	addi	a4,a4,378 # 8000a7b6 <raid0write>
    8000a644:	26e7b423          	sd	a4,616(a5)
  raidmeta.blockn = raid0blockn;
    8000a648:	00020797          	auipc	a5,0x20
    8000a64c:	44878793          	addi	a5,a5,1096 # 8002aa90 <raidmeta>
    8000a650:	00000717          	auipc	a4,0x0
    8000a654:	f8070713          	addi	a4,a4,-128 # 8000a5d0 <raid0blockn>
    8000a658:	26e7b823          	sd	a4,624(a5)
  raidmeta.repair = raid0repair;
    8000a65c:	00020797          	auipc	a5,0x20
    8000a660:	43478793          	addi	a5,a5,1076 # 8002aa90 <raidmeta>
    8000a664:	00000717          	auipc	a4,0x0
    8000a668:	25a70713          	addi	a4,a4,602 # 8000a8be <raid0repair>
    8000a66c:	26e7bc23          	sd	a4,632(a5)

  struct RAID0Data* raiddata = &raidmeta.data.raid0;
    8000a670:	00020797          	auipc	a5,0x20
    8000a674:	44878793          	addi	a5,a5,1096 # 8002aab8 <raidmeta+0x28>
    8000a678:	fef43023          	sd	a5,-32(s0)
  for (int i = 0; i < DISKS; i++)
    8000a67c:	fe042623          	sw	zero,-20(s0)
    8000a680:	a805                	j	8000a6b0 <raid0init+0xb2>
    initsleeplock(&raiddata->lock[i], "raid0lock");
    8000a682:	fec42703          	lw	a4,-20(s0)
    8000a686:	87ba                	mv	a5,a4
    8000a688:	0786                	slli	a5,a5,0x1
    8000a68a:	97ba                	add	a5,a5,a4
    8000a68c:	0792                	slli	a5,a5,0x4
    8000a68e:	fe043703          	ld	a4,-32(s0)
    8000a692:	97ba                	add	a5,a5,a4
    8000a694:	00003597          	auipc	a1,0x3
    8000a698:	15c58593          	addi	a1,a1,348 # 8000d7f0 <etext+0x7f0>
    8000a69c:	853e                	mv	a0,a5
    8000a69e:	ffffc097          	auipc	ra,0xffffc
    8000a6a2:	14c080e7          	jalr	332(ra) # 800067ea <initsleeplock>
  for (int i = 0; i < DISKS; i++)
    8000a6a6:	fec42783          	lw	a5,-20(s0)
    8000a6aa:	2785                	addiw	a5,a5,1
    8000a6ac:	fef42623          	sw	a5,-20(s0)
    8000a6b0:	fec42783          	lw	a5,-20(s0)
    8000a6b4:	0007871b          	sext.w	a4,a5
    8000a6b8:	4795                	li	a5,5
    8000a6ba:	fce7d4e3          	bge	a5,a4,8000a682 <raid0init+0x84>

  writeraidmeta();
    8000a6be:	00000097          	auipc	ra,0x0
    8000a6c2:	85c080e7          	jalr	-1956(ra) # 80009f1a <writeraidmeta>
  return 0;
    8000a6c6:	4781                	li	a5,0
}
    8000a6c8:	853e                	mv	a0,a5
    8000a6ca:	60e2                	ld	ra,24(sp)
    8000a6cc:	6442                	ld	s0,16(sp)
    8000a6ce:	6105                	addi	sp,sp,32
    8000a6d0:	8082                	ret

000000008000a6d2 <raid0read>:

int
raid0read(int vblkn, uchar* data)
{
    8000a6d2:	7139                	addi	sp,sp,-64
    8000a6d4:	fc06                	sd	ra,56(sp)
    8000a6d6:	f822                	sd	s0,48(sp)
    8000a6d8:	0080                	addi	s0,sp,64
    8000a6da:	87aa                	mv	a5,a0
    8000a6dc:	fcb43023          	sd	a1,-64(s0)
    8000a6e0:	fcf42623          	sw	a5,-52(s0)
  if (raidmeta.type != RAID0)
    8000a6e4:	00020797          	auipc	a5,0x20
    8000a6e8:	3ac78793          	addi	a5,a5,940 # 8002aa90 <raidmeta>
    8000a6ec:	43dc                	lw	a5,4(a5)
    8000a6ee:	cb89                	beqz	a5,8000a700 <raid0read+0x2e>
    panic("raid0read");
    8000a6f0:	00003517          	auipc	a0,0x3
    8000a6f4:	11050513          	addi	a0,a0,272 # 8000d800 <etext+0x800>
    8000a6f8:	ffff6097          	auipc	ra,0xffff6
    8000a6fc:	590080e7          	jalr	1424(ra) # 80000c88 <panic>

  uint diskn = vblkn % DISKS;
    8000a700:	fcc42783          	lw	a5,-52(s0)
    8000a704:	873e                	mv	a4,a5
    8000a706:	4799                	li	a5,6
    8000a708:	02f767bb          	remw	a5,a4,a5
    8000a70c:	2781                	sext.w	a5,a5
    8000a70e:	fef42623          	sw	a5,-20(s0)
  uint pblockn = vblkn / DISKS;
    8000a712:	fcc42783          	lw	a5,-52(s0)
    8000a716:	873e                	mv	a4,a5
    8000a718:	4799                	li	a5,6
    8000a71a:	02f747bb          	divw	a5,a4,a5
    8000a71e:	2781                	sext.w	a5,a5
    8000a720:	fef42423          	sw	a5,-24(s0)

  struct RAID0Data* raiddata = &raidmeta.data.raid0;
    8000a724:	00020797          	auipc	a5,0x20
    8000a728:	39478793          	addi	a5,a5,916 # 8002aab8 <raidmeta+0x28>
    8000a72c:	fef43023          	sd	a5,-32(s0)
  struct DiskInfo* diskinfo = raidmeta.diskinfo + diskn;
    8000a730:	fec46783          	lwu	a5,-20(s0)
    8000a734:	00579713          	slli	a4,a5,0x5
    8000a738:	00020797          	auipc	a5,0x20
    8000a73c:	4d878793          	addi	a5,a5,1240 # 8002ac10 <raidmeta+0x180>
    8000a740:	97ba                	add	a5,a5,a4
    8000a742:	fcf43c23          	sd	a5,-40(s0)

  if (!diskinfo->valid)
    8000a746:	fd843783          	ld	a5,-40(s0)
    8000a74a:	0187c783          	lbu	a5,24(a5)
    8000a74e:	e399                	bnez	a5,8000a754 <raid0read+0x82>
    return -1;
    8000a750:	57fd                	li	a5,-1
    8000a752:	a8a9                	j	8000a7ac <raid0read+0xda>

  acquiresleep(&raiddata->lock[diskn]);
    8000a754:	fec46703          	lwu	a4,-20(s0)
    8000a758:	87ba                	mv	a5,a4
    8000a75a:	0786                	slli	a5,a5,0x1
    8000a75c:	97ba                	add	a5,a5,a4
    8000a75e:	0792                	slli	a5,a5,0x4
    8000a760:	fe043703          	ld	a4,-32(s0)
    8000a764:	97ba                	add	a5,a5,a4
    8000a766:	853e                	mv	a0,a5
    8000a768:	ffffc097          	auipc	ra,0xffffc
    8000a76c:	0ce080e7          	jalr	206(ra) # 80006836 <acquiresleep>
  read_block(diskinfo->pdiskn, pblockn, data);
    8000a770:	fd843783          	ld	a5,-40(s0)
    8000a774:	0197c783          	lbu	a5,25(a5)
    8000a778:	2781                	sext.w	a5,a5
    8000a77a:	fe842703          	lw	a4,-24(s0)
    8000a77e:	fc043603          	ld	a2,-64(s0)
    8000a782:	85ba                	mv	a1,a4
    8000a784:	853e                	mv	a0,a5
    8000a786:	fffff097          	auipc	ra,0xfffff
    8000a78a:	4ee080e7          	jalr	1262(ra) # 80009c74 <read_block>
  releasesleep(&raiddata->lock[diskn]);
    8000a78e:	fec46703          	lwu	a4,-20(s0)
    8000a792:	87ba                	mv	a5,a4
    8000a794:	0786                	slli	a5,a5,0x1
    8000a796:	97ba                	add	a5,a5,a4
    8000a798:	0792                	slli	a5,a5,0x4
    8000a79a:	fe043703          	ld	a4,-32(s0)
    8000a79e:	97ba                	add	a5,a5,a4
    8000a7a0:	853e                	mv	a0,a5
    8000a7a2:	ffffc097          	auipc	ra,0xffffc
    8000a7a6:	102080e7          	jalr	258(ra) # 800068a4 <releasesleep>

  return 0;
    8000a7aa:	4781                	li	a5,0
}
    8000a7ac:	853e                	mv	a0,a5
    8000a7ae:	70e2                	ld	ra,56(sp)
    8000a7b0:	7442                	ld	s0,48(sp)
    8000a7b2:	6121                	addi	sp,sp,64
    8000a7b4:	8082                	ret

000000008000a7b6 <raid0write>:

int
raid0write(int vblkn, uchar* data)
{
    8000a7b6:	7139                	addi	sp,sp,-64
    8000a7b8:	fc06                	sd	ra,56(sp)
    8000a7ba:	f822                	sd	s0,48(sp)
    8000a7bc:	0080                	addi	s0,sp,64
    8000a7be:	87aa                	mv	a5,a0
    8000a7c0:	fcb43023          	sd	a1,-64(s0)
    8000a7c4:	fcf42623          	sw	a5,-52(s0)
  if (raidmeta.type != RAID0)
    8000a7c8:	00020797          	auipc	a5,0x20
    8000a7cc:	2c878793          	addi	a5,a5,712 # 8002aa90 <raidmeta>
    8000a7d0:	43dc                	lw	a5,4(a5)
    8000a7d2:	cb89                	beqz	a5,8000a7e4 <raid0write+0x2e>
    panic("raid0write");
    8000a7d4:	00003517          	auipc	a0,0x3
    8000a7d8:	03c50513          	addi	a0,a0,60 # 8000d810 <etext+0x810>
    8000a7dc:	ffff6097          	auipc	ra,0xffff6
    8000a7e0:	4ac080e7          	jalr	1196(ra) # 80000c88 <panic>

  if (vblkn < 0 || vblkn >= raid0blockn())
    8000a7e4:	fcc42783          	lw	a5,-52(s0)
    8000a7e8:	2781                	sext.w	a5,a5
    8000a7ea:	0007cd63          	bltz	a5,8000a804 <raid0write+0x4e>
    8000a7ee:	00000097          	auipc	ra,0x0
    8000a7f2:	de2080e7          	jalr	-542(ra) # 8000a5d0 <raid0blockn>
    8000a7f6:	87aa                	mv	a5,a0
    8000a7f8:	0007871b          	sext.w	a4,a5
    8000a7fc:	fcc42783          	lw	a5,-52(s0)
    8000a800:	00e7e463          	bltu	a5,a4,8000a808 <raid0write+0x52>
    return -1;
    8000a804:	57fd                	li	a5,-1
    8000a806:	a07d                	j	8000a8b4 <raid0write+0xfe>

  uint diskn = vblkn % DISKS;
    8000a808:	fcc42783          	lw	a5,-52(s0)
    8000a80c:	873e                	mv	a4,a5
    8000a80e:	4799                	li	a5,6
    8000a810:	02f767bb          	remw	a5,a4,a5
    8000a814:	2781                	sext.w	a5,a5
    8000a816:	fef42623          	sw	a5,-20(s0)
  uint pblockn = vblkn / DISKS;
    8000a81a:	fcc42783          	lw	a5,-52(s0)
    8000a81e:	873e                	mv	a4,a5
    8000a820:	4799                	li	a5,6
    8000a822:	02f747bb          	divw	a5,a4,a5
    8000a826:	2781                	sext.w	a5,a5
    8000a828:	fef42423          	sw	a5,-24(s0)

  struct RAID0Data* raiddata = &raidmeta.data.raid0;
    8000a82c:	00020797          	auipc	a5,0x20
    8000a830:	28c78793          	addi	a5,a5,652 # 8002aab8 <raidmeta+0x28>
    8000a834:	fef43023          	sd	a5,-32(s0)
  struct DiskInfo* diskinfo = raidmeta.diskinfo + diskn;
    8000a838:	fec46783          	lwu	a5,-20(s0)
    8000a83c:	00579713          	slli	a4,a5,0x5
    8000a840:	00020797          	auipc	a5,0x20
    8000a844:	3d078793          	addi	a5,a5,976 # 8002ac10 <raidmeta+0x180>
    8000a848:	97ba                	add	a5,a5,a4
    8000a84a:	fcf43c23          	sd	a5,-40(s0)

  if (!diskinfo->valid)
    8000a84e:	fd843783          	ld	a5,-40(s0)
    8000a852:	0187c783          	lbu	a5,24(a5)
    8000a856:	e399                	bnez	a5,8000a85c <raid0write+0xa6>
    return -1;
    8000a858:	57fd                	li	a5,-1
    8000a85a:	a8a9                	j	8000a8b4 <raid0write+0xfe>

  acquiresleep(&raiddata->lock[diskn]);
    8000a85c:	fec46703          	lwu	a4,-20(s0)
    8000a860:	87ba                	mv	a5,a4
    8000a862:	0786                	slli	a5,a5,0x1
    8000a864:	97ba                	add	a5,a5,a4
    8000a866:	0792                	slli	a5,a5,0x4
    8000a868:	fe043703          	ld	a4,-32(s0)
    8000a86c:	97ba                	add	a5,a5,a4
    8000a86e:	853e                	mv	a0,a5
    8000a870:	ffffc097          	auipc	ra,0xffffc
    8000a874:	fc6080e7          	jalr	-58(ra) # 80006836 <acquiresleep>
  write_block(diskinfo->pdiskn, pblockn, data);
    8000a878:	fd843783          	ld	a5,-40(s0)
    8000a87c:	0197c783          	lbu	a5,25(a5)
    8000a880:	2781                	sext.w	a5,a5
    8000a882:	fe842703          	lw	a4,-24(s0)
    8000a886:	fc043603          	ld	a2,-64(s0)
    8000a88a:	85ba                	mv	a1,a4
    8000a88c:	853e                	mv	a0,a5
    8000a88e:	fffff097          	auipc	ra,0xfffff
    8000a892:	312080e7          	jalr	786(ra) # 80009ba0 <write_block>
  releasesleep(&raiddata->lock[diskn]);
    8000a896:	fec46703          	lwu	a4,-20(s0)
    8000a89a:	87ba                	mv	a5,a4
    8000a89c:	0786                	slli	a5,a5,0x1
    8000a89e:	97ba                	add	a5,a5,a4
    8000a8a0:	0792                	slli	a5,a5,0x4
    8000a8a2:	fe043703          	ld	a4,-32(s0)
    8000a8a6:	97ba                	add	a5,a5,a4
    8000a8a8:	853e                	mv	a0,a5
    8000a8aa:	ffffc097          	auipc	ra,0xffffc
    8000a8ae:	ffa080e7          	jalr	-6(ra) # 800068a4 <releasesleep>

  return 0;
    8000a8b2:	4781                	li	a5,0
}
    8000a8b4:	853e                	mv	a0,a5
    8000a8b6:	70e2                	ld	ra,56(sp)
    8000a8b8:	7442                	ld	s0,48(sp)
    8000a8ba:	6121                	addi	sp,sp,64
    8000a8bc:	8082                	ret

000000008000a8be <raid0repair>:

int
raid0repair(int diskn)
{
    8000a8be:	1101                	addi	sp,sp,-32
    8000a8c0:	ec22                	sd	s0,24(sp)
    8000a8c2:	1000                	addi	s0,sp,32
    8000a8c4:	87aa                	mv	a5,a0
    8000a8c6:	fef42623          	sw	a5,-20(s0)
  return -1;
    8000a8ca:	57fd                	li	a5,-1
    8000a8cc:	853e                	mv	a0,a5
    8000a8ce:	6462                	ld	s0,24(sp)
    8000a8d0:	6105                	addi	sp,sp,32
    8000a8d2:	8082                	ret

000000008000a8d4 <sys_init_raid>:
#include "proc.h"
#include "defs.h"

uint64
sys_init_raid(void)
{
    8000a8d4:	1101                	addi	sp,sp,-32
    8000a8d6:	ec06                	sd	ra,24(sp)
    8000a8d8:	e822                	sd	s0,16(sp)
    8000a8da:	1000                	addi	s0,sp,32
  // Fetch argument
  int type;
  argint(0, &type);
    8000a8dc:	fec40793          	addi	a5,s0,-20
    8000a8e0:	85be                	mv	a1,a5
    8000a8e2:	4501                	li	a0,0
    8000a8e4:	ffffa097          	auipc	ra,0xffffa
    8000a8e8:	ad6080e7          	jalr	-1322(ra) # 800043ba <argint>

  return setraidtype(type);
    8000a8ec:	fec42783          	lw	a5,-20(s0)
    8000a8f0:	853e                	mv	a0,a5
    8000a8f2:	00000097          	auipc	ra,0x0
    8000a8f6:	854080e7          	jalr	-1964(ra) # 8000a146 <setraidtype>
    8000a8fa:	87aa                	mv	a5,a0
}
    8000a8fc:	853e                	mv	a0,a5
    8000a8fe:	60e2                	ld	ra,24(sp)
    8000a900:	6442                	ld	s0,16(sp)
    8000a902:	6105                	addi	sp,sp,32
    8000a904:	8082                	ret

000000008000a906 <sys_info_raid>:

uint64
sys_info_raid(void)
{
    8000a906:	7139                	addi	sp,sp,-64
    8000a908:	fc06                	sd	ra,56(sp)
    8000a90a:	f822                	sd	s0,48(sp)
    8000a90c:	0080                	addi	s0,sp,64
  // Fetch arguments and check are they valid
  uint64 blkn_addr, blks_addr, diskn_addr;
  argaddr(0, &blkn_addr);
    8000a90e:	fe040793          	addi	a5,s0,-32
    8000a912:	85be                	mv	a1,a5
    8000a914:	4501                	li	a0,0
    8000a916:	ffffa097          	auipc	ra,0xffffa
    8000a91a:	ada080e7          	jalr	-1318(ra) # 800043f0 <argaddr>
  argaddr(1, &blks_addr);
    8000a91e:	fd840793          	addi	a5,s0,-40
    8000a922:	85be                	mv	a1,a5
    8000a924:	4505                	li	a0,1
    8000a926:	ffffa097          	auipc	ra,0xffffa
    8000a92a:	aca080e7          	jalr	-1334(ra) # 800043f0 <argaddr>
  argaddr(2, &diskn_addr);
    8000a92e:	fd040793          	addi	a5,s0,-48
    8000a932:	85be                	mv	a1,a5
    8000a934:	4509                	li	a0,2
    8000a936:	ffffa097          	auipc	ra,0xffffa
    8000a93a:	aba080e7          	jalr	-1350(ra) # 800043f0 <argaddr>
  if (blkn_addr < 0 || blks_addr < 0 || diskn_addr < 0)
    return -1;

  uint blkn = raidblockn() == -1 ? 0 : raidblockn();
    8000a93e:	fffff097          	auipc	ra,0xfffff
    8000a942:	5a6080e7          	jalr	1446(ra) # 80009ee4 <raidblockn>
    8000a946:	87aa                	mv	a5,a0
    8000a948:	2781                	sext.w	a5,a5
    8000a94a:	873e                	mv	a4,a5
    8000a94c:	57fd                	li	a5,-1
    8000a94e:	00f70963          	beq	a4,a5,8000a960 <sys_info_raid+0x5a>
    8000a952:	fffff097          	auipc	ra,0xfffff
    8000a956:	592080e7          	jalr	1426(ra) # 80009ee4 <raidblockn>
    8000a95a:	87aa                	mv	a5,a0
    8000a95c:	2781                	sext.w	a5,a5
    8000a95e:	a011                	j	8000a962 <sys_info_raid+0x5c>
    8000a960:	4781                	li	a5,0
    8000a962:	fcf42623          	sw	a5,-52(s0)
  uint blks = BSIZE;
    8000a966:	40000793          	li	a5,1024
    8000a96a:	fcf42423          	sw	a5,-56(s0)
  uint diskn = DISKS;
    8000a96e:	4799                	li	a5,6
    8000a970:	fcf42223          	sw	a5,-60(s0)

  // Write result
  struct proc *p = myproc();
    8000a974:	ffff8097          	auipc	ra,0xffff8
    8000a978:	18a080e7          	jalr	394(ra) # 80002afe <myproc>
    8000a97c:	fea43423          	sd	a0,-24(s0)
  if (copyout(p->pagetable, blkn_addr, (char*)(&blkn), sizeof(blkn)) < 0)
    8000a980:	fe843783          	ld	a5,-24(s0)
    8000a984:	6bbc                	ld	a5,80(a5)
    8000a986:	fe043703          	ld	a4,-32(s0)
    8000a98a:	fcc40613          	addi	a2,s0,-52
    8000a98e:	4691                	li	a3,4
    8000a990:	85ba                	mv	a1,a4
    8000a992:	853e                	mv	a0,a5
    8000a994:	ffff8097          	auipc	ra,0xffff8
    8000a998:	c34080e7          	jalr	-972(ra) # 800025c8 <copyout>
    8000a99c:	87aa                	mv	a5,a0
    8000a99e:	0007d463          	bgez	a5,8000a9a6 <sys_info_raid+0xa0>
    return -1;
    8000a9a2:	57fd                	li	a5,-1
    8000a9a4:	a881                	j	8000a9f4 <sys_info_raid+0xee>
  if (copyout(p->pagetable, blks_addr, (char*)(&blks), sizeof(blks)) < 0)
    8000a9a6:	fe843783          	ld	a5,-24(s0)
    8000a9aa:	6bbc                	ld	a5,80(a5)
    8000a9ac:	fd843703          	ld	a4,-40(s0)
    8000a9b0:	fc840613          	addi	a2,s0,-56
    8000a9b4:	4691                	li	a3,4
    8000a9b6:	85ba                	mv	a1,a4
    8000a9b8:	853e                	mv	a0,a5
    8000a9ba:	ffff8097          	auipc	ra,0xffff8
    8000a9be:	c0e080e7          	jalr	-1010(ra) # 800025c8 <copyout>
    8000a9c2:	87aa                	mv	a5,a0
    8000a9c4:	0007d463          	bgez	a5,8000a9cc <sys_info_raid+0xc6>
    return -1;
    8000a9c8:	57fd                	li	a5,-1
    8000a9ca:	a02d                	j	8000a9f4 <sys_info_raid+0xee>
  if (copyout(p->pagetable, diskn_addr, (char*)(&diskn), sizeof(diskn)) < 0)
    8000a9cc:	fe843783          	ld	a5,-24(s0)
    8000a9d0:	6bbc                	ld	a5,80(a5)
    8000a9d2:	fd043703          	ld	a4,-48(s0)
    8000a9d6:	fc440613          	addi	a2,s0,-60
    8000a9da:	4691                	li	a3,4
    8000a9dc:	85ba                	mv	a1,a4
    8000a9de:	853e                	mv	a0,a5
    8000a9e0:	ffff8097          	auipc	ra,0xffff8
    8000a9e4:	be8080e7          	jalr	-1048(ra) # 800025c8 <copyout>
    8000a9e8:	87aa                	mv	a5,a0
    8000a9ea:	0007d463          	bgez	a5,8000a9f2 <sys_info_raid+0xec>
    return -1;
    8000a9ee:	57fd                	li	a5,-1
    8000a9f0:	a011                	j	8000a9f4 <sys_info_raid+0xee>

  return 0;
    8000a9f2:	4781                	li	a5,0
}
    8000a9f4:	853e                	mv	a0,a5
    8000a9f6:	70e2                	ld	ra,56(sp)
    8000a9f8:	7442                	ld	s0,48(sp)
    8000a9fa:	6121                	addi	sp,sp,64
    8000a9fc:	8082                	ret

000000008000a9fe <sys_read_raid>:

uint64
sys_read_raid(void)
{
    8000a9fe:	bd010113          	addi	sp,sp,-1072
    8000aa02:	42113423          	sd	ra,1064(sp)
    8000aa06:	42813023          	sd	s0,1056(sp)
    8000aa0a:	43010413          	addi	s0,sp,1072
  // Fetch arguments and check are they valid
  int vblkn;
  argint(0, &vblkn);
    8000aa0e:	fe440793          	addi	a5,s0,-28
    8000aa12:	85be                	mv	a1,a5
    8000aa14:	4501                	li	a0,0
    8000aa16:	ffffa097          	auipc	ra,0xffffa
    8000aa1a:	9a4080e7          	jalr	-1628(ra) # 800043ba <argint>

  uint64 data_addr;
  argaddr(1, &data_addr);
    8000aa1e:	fd840793          	addi	a5,s0,-40
    8000aa22:	85be                	mv	a1,a5
    8000aa24:	4505                	li	a0,1
    8000aa26:	ffffa097          	auipc	ra,0xffffa
    8000aa2a:	9ca080e7          	jalr	-1590(ra) # 800043f0 <argaddr>

  if (data_addr < 0)
    return -1;

  char data[BSIZE];
  if (readraid(vblkn, (uchar*)data) < 0)
    8000aa2e:	fe442783          	lw	a5,-28(s0)
    8000aa32:	bd840713          	addi	a4,s0,-1064
    8000aa36:	85ba                	mv	a1,a4
    8000aa38:	853e                	mv	a0,a5
    8000aa3a:	fffff097          	auipc	ra,0xfffff
    8000aa3e:	754080e7          	jalr	1876(ra) # 8000a18e <readraid>
    8000aa42:	87aa                	mv	a5,a0
    8000aa44:	0007d463          	bgez	a5,8000aa4c <sys_read_raid+0x4e>
    return -2;
    8000aa48:	57f9                	li	a5,-2
    8000aa4a:	a825                	j	8000aa82 <sys_read_raid+0x84>

  struct proc *p = myproc();
    8000aa4c:	ffff8097          	auipc	ra,0xffff8
    8000aa50:	0b2080e7          	jalr	178(ra) # 80002afe <myproc>
    8000aa54:	fea43423          	sd	a0,-24(s0)
  if (copyout(p->pagetable, data_addr, data, BSIZE) < 0)
    8000aa58:	fe843783          	ld	a5,-24(s0)
    8000aa5c:	6bbc                	ld	a5,80(a5)
    8000aa5e:	fd843703          	ld	a4,-40(s0)
    8000aa62:	bd840613          	addi	a2,s0,-1064
    8000aa66:	40000693          	li	a3,1024
    8000aa6a:	85ba                	mv	a1,a4
    8000aa6c:	853e                	mv	a0,a5
    8000aa6e:	ffff8097          	auipc	ra,0xffff8
    8000aa72:	b5a080e7          	jalr	-1190(ra) # 800025c8 <copyout>
    8000aa76:	87aa                	mv	a5,a0
    8000aa78:	0007d463          	bgez	a5,8000aa80 <sys_read_raid+0x82>
    return -3;
    8000aa7c:	57f5                	li	a5,-3
    8000aa7e:	a011                	j	8000aa82 <sys_read_raid+0x84>

  return 0;
    8000aa80:	4781                	li	a5,0
}
    8000aa82:	853e                	mv	a0,a5
    8000aa84:	42813083          	ld	ra,1064(sp)
    8000aa88:	42013403          	ld	s0,1056(sp)
    8000aa8c:	43010113          	addi	sp,sp,1072
    8000aa90:	8082                	ret

000000008000aa92 <sys_write_raid>:

uint64
sys_write_raid(void)
{
    8000aa92:	bd010113          	addi	sp,sp,-1072
    8000aa96:	42113423          	sd	ra,1064(sp)
    8000aa9a:	42813023          	sd	s0,1056(sp)
    8000aa9e:	43010413          	addi	s0,sp,1072
  // Fetch arguments and check are they valid
  int vblkn;
  argint(0, &vblkn);
    8000aaa2:	fe440793          	addi	a5,s0,-28
    8000aaa6:	85be                	mv	a1,a5
    8000aaa8:	4501                	li	a0,0
    8000aaaa:	ffffa097          	auipc	ra,0xffffa
    8000aaae:	910080e7          	jalr	-1776(ra) # 800043ba <argint>

  uint64 data_addr;
  argaddr(1, &data_addr);
    8000aab2:	fd840793          	addi	a5,s0,-40
    8000aab6:	85be                	mv	a1,a5
    8000aab8:	4505                	li	a0,1
    8000aaba:	ffffa097          	auipc	ra,0xffffa
    8000aabe:	936080e7          	jalr	-1738(ra) # 800043f0 <argaddr>

  if (data_addr < 0)
    return -1;

  struct proc *p = myproc();
    8000aac2:	ffff8097          	auipc	ra,0xffff8
    8000aac6:	03c080e7          	jalr	60(ra) # 80002afe <myproc>
    8000aaca:	fea43423          	sd	a0,-24(s0)
  char data[BSIZE];
  if (copyin(p->pagetable, data, data_addr, BSIZE) < 0)
    8000aace:	fe843783          	ld	a5,-24(s0)
    8000aad2:	6bbc                	ld	a5,80(a5)
    8000aad4:	fd843603          	ld	a2,-40(s0)
    8000aad8:	bd840713          	addi	a4,s0,-1064
    8000aadc:	40000693          	li	a3,1024
    8000aae0:	85ba                	mv	a1,a4
    8000aae2:	853e                	mv	a0,a5
    8000aae4:	ffff8097          	auipc	ra,0xffff8
    8000aae8:	bb2080e7          	jalr	-1102(ra) # 80002696 <copyin>
    8000aaec:	87aa                	mv	a5,a0
    8000aaee:	0007d463          	bgez	a5,8000aaf6 <sys_write_raid+0x64>
    return -2;
    8000aaf2:	57f9                	li	a5,-2
    8000aaf4:	a00d                	j	8000ab16 <sys_write_raid+0x84>

  if (writeraid(vblkn, (uchar*)data) < 0)
    8000aaf6:	fe442783          	lw	a5,-28(s0)
    8000aafa:	bd840713          	addi	a4,s0,-1064
    8000aafe:	85ba                	mv	a1,a4
    8000ab00:	853e                	mv	a0,a5
    8000ab02:	fffff097          	auipc	ra,0xfffff
    8000ab06:	6fe080e7          	jalr	1790(ra) # 8000a200 <writeraid>
    8000ab0a:	87aa                	mv	a5,a0
    8000ab0c:	0007d463          	bgez	a5,8000ab14 <sys_write_raid+0x82>
    return -3;
    8000ab10:	57f5                	li	a5,-3
    8000ab12:	a011                	j	8000ab16 <sys_write_raid+0x84>

  return 0;
    8000ab14:	4781                	li	a5,0
}
    8000ab16:	853e                	mv	a0,a5
    8000ab18:	42813083          	ld	ra,1064(sp)
    8000ab1c:	42013403          	ld	s0,1056(sp)
    8000ab20:	43010113          	addi	sp,sp,1072
    8000ab24:	8082                	ret

000000008000ab26 <sys_disk_fail_raid>:

uint64
sys_disk_fail_raid(void)
{
    8000ab26:	1101                	addi	sp,sp,-32
    8000ab28:	ec06                	sd	ra,24(sp)
    8000ab2a:	e822                	sd	s0,16(sp)
    8000ab2c:	1000                	addi	s0,sp,32
  int diskn;
  argint(0, &diskn);
    8000ab2e:	fec40793          	addi	a5,s0,-20
    8000ab32:	85be                	mv	a1,a5
    8000ab34:	4501                	li	a0,0
    8000ab36:	ffffa097          	auipc	ra,0xffffa
    8000ab3a:	884080e7          	jalr	-1916(ra) # 800043ba <argint>
  diskn--;
    8000ab3e:	fec42783          	lw	a5,-20(s0)
    8000ab42:	37fd                	addiw	a5,a5,-1
    8000ab44:	2781                	sext.w	a5,a5
    8000ab46:	fef42623          	sw	a5,-20(s0)
  if (diskn < 0)
    8000ab4a:	fec42783          	lw	a5,-20(s0)
    8000ab4e:	0007d463          	bgez	a5,8000ab56 <sys_disk_fail_raid+0x30>
    return -1;
    8000ab52:	57fd                	li	a5,-1
    8000ab54:	a809                	j	8000ab66 <sys_disk_fail_raid+0x40>

  return raidfail(diskn);
    8000ab56:	fec42783          	lw	a5,-20(s0)
    8000ab5a:	853e                	mv	a0,a5
    8000ab5c:	00000097          	auipc	ra,0x0
    8000ab60:	9f8080e7          	jalr	-1544(ra) # 8000a554 <raidfail>
    8000ab64:	87aa                	mv	a5,a0
}
    8000ab66:	853e                	mv	a0,a5
    8000ab68:	60e2                	ld	ra,24(sp)
    8000ab6a:	6442                	ld	s0,16(sp)
    8000ab6c:	6105                	addi	sp,sp,32
    8000ab6e:	8082                	ret

000000008000ab70 <sys_disk_repaired_raid>:

uint64
sys_disk_repaired_raid(void)
{
    8000ab70:	1101                	addi	sp,sp,-32
    8000ab72:	ec06                	sd	ra,24(sp)
    8000ab74:	e822                	sd	s0,16(sp)
    8000ab76:	1000                	addi	s0,sp,32
  int diskn;
  argint(0, &diskn);
    8000ab78:	fec40793          	addi	a5,s0,-20
    8000ab7c:	85be                	mv	a1,a5
    8000ab7e:	4501                	li	a0,0
    8000ab80:	ffffa097          	auipc	ra,0xffffa
    8000ab84:	83a080e7          	jalr	-1990(ra) # 800043ba <argint>
  diskn--;
    8000ab88:	fec42783          	lw	a5,-20(s0)
    8000ab8c:	37fd                	addiw	a5,a5,-1
    8000ab8e:	2781                	sext.w	a5,a5
    8000ab90:	fef42623          	sw	a5,-20(s0)
  if (diskn < 0)
    8000ab94:	fec42783          	lw	a5,-20(s0)
    8000ab98:	0007d463          	bgez	a5,8000aba0 <sys_disk_repaired_raid+0x30>
    return -1;
    8000ab9c:	57fd                	li	a5,-1
    8000ab9e:	a809                	j	8000abb0 <sys_disk_repaired_raid+0x40>

  return raidrepair(diskn);
    8000aba0:	fec42783          	lw	a5,-20(s0)
    8000aba4:	853e                	mv	a0,a5
    8000aba6:	00000097          	auipc	ra,0x0
    8000abaa:	9ea080e7          	jalr	-1558(ra) # 8000a590 <raidrepair>
    8000abae:	87aa                	mv	a5,a0
    8000abb0:	853e                	mv	a0,a5
    8000abb2:	60e2                	ld	ra,24(sp)
    8000abb4:	6442                	ld	s0,16(sp)
    8000abb6:	6105                	addi	sp,sp,32
    8000abb8:	8082                	ret

000000008000abba <raid1blockn>:
int raid1write(int vblkn, uchar* data);
int raid1repair(int diskn);

uint
raid1blockn(void)
{
    8000abba:	1141                	addi	sp,sp,-16
    8000abbc:	e406                	sd	ra,8(sp)
    8000abbe:	e022                	sd	s0,0(sp)
    8000abc0:	0800                	addi	s0,sp,16
    return diskblockn() * ((DISKS+1) / 2);;
    8000abc2:	fffff097          	auipc	ra,0xfffff
    8000abc6:	310080e7          	jalr	784(ra) # 80009ed2 <diskblockn>
    8000abca:	87aa                	mv	a5,a0
    8000abcc:	2781                	sext.w	a5,a5
    8000abce:	873e                	mv	a4,a5
    8000abd0:	87ba                	mv	a5,a4
    8000abd2:	0017979b          	slliw	a5,a5,0x1
    8000abd6:	9fb9                	addw	a5,a5,a4
    8000abd8:	2781                	sext.w	a5,a5
}
    8000abda:	853e                	mv	a0,a5
    8000abdc:	60a2                	ld	ra,8(sp)
    8000abde:	6402                	ld	s0,0(sp)
    8000abe0:	0141                	addi	sp,sp,16
    8000abe2:	8082                	ret

000000008000abe4 <raid1init>:

int
raid1init(void)
{
    8000abe4:	1101                	addi	sp,sp,-32
    8000abe6:	ec06                	sd	ra,24(sp)
    8000abe8:	e822                	sd	s0,16(sp)
    8000abea:	1000                	addi	s0,sp,32
    raidmeta.valid = 1;
    8000abec:	00020797          	auipc	a5,0x20
    8000abf0:	ea478793          	addi	a5,a5,-348 # 8002aa90 <raidmeta>
    8000abf4:	4705                	li	a4,1
    8000abf6:	00e780a3          	sb	a4,1(a5)
    raidmeta.type = RAID1;
    8000abfa:	00020797          	auipc	a5,0x20
    8000abfe:	e9678793          	addi	a5,a5,-362 # 8002aa90 <raidmeta>
    8000ac02:	4705                	li	a4,1
    8000ac04:	c3d8                	sw	a4,4(a5)
    raidmeta.read = raid1read;
    8000ac06:	00020797          	auipc	a5,0x20
    8000ac0a:	e8a78793          	addi	a5,a5,-374 # 8002aa90 <raidmeta>
    8000ac0e:	00000717          	auipc	a4,0x0
    8000ac12:	15870713          	addi	a4,a4,344 # 8000ad66 <raid1read>
    8000ac16:	26e7b023          	sd	a4,608(a5)
    raidmeta.write = raid1write;
    8000ac1a:	00020797          	auipc	a5,0x20
    8000ac1e:	e7678793          	addi	a5,a5,-394 # 8002aa90 <raidmeta>
    8000ac22:	00000717          	auipc	a4,0x0
    8000ac26:	1f870713          	addi	a4,a4,504 # 8000ae1a <raid1write>
    8000ac2a:	26e7b423          	sd	a4,616(a5)
    raidmeta.blockn = raid1blockn;
    8000ac2e:	00020797          	auipc	a5,0x20
    8000ac32:	e6278793          	addi	a5,a5,-414 # 8002aa90 <raidmeta>
    8000ac36:	00000717          	auipc	a4,0x0
    8000ac3a:	f8470713          	addi	a4,a4,-124 # 8000abba <raid1blockn>
    8000ac3e:	26e7b823          	sd	a4,624(a5)
    raidmeta.repair = raid1repair;
    8000ac42:	00020797          	auipc	a5,0x20
    8000ac46:	e4e78793          	addi	a5,a5,-434 # 8002aa90 <raidmeta>
    8000ac4a:	00000717          	auipc	a4,0x0
    8000ac4e:	28470713          	addi	a4,a4,644 # 8000aece <raid1repair>
    8000ac52:	26e7bc23          	sd	a4,632(a5)

    struct RAID1Data* raiddata = &raidmeta.data.raid1;
    8000ac56:	00020797          	auipc	a5,0x20
    8000ac5a:	e6278793          	addi	a5,a5,-414 # 8002aab8 <raidmeta+0x28>
    8000ac5e:	fef43023          	sd	a5,-32(s0)

    for (int i = 0; i < (DISKS + 1) / 2; i++)
    8000ac62:	fe042623          	sw	zero,-20(s0)
    8000ac66:	a8f9                	j	8000ad44 <raid1init+0x160>
    {
        raiddata->diskpair[i].diskinfo[0] = raidmeta.diskinfo + i * 2;
    8000ac68:	fec42783          	lw	a5,-20(s0)
    8000ac6c:	0017979b          	slliw	a5,a5,0x1
    8000ac70:	2781                	sext.w	a5,a5
    8000ac72:	00579713          	slli	a4,a5,0x5
    8000ac76:	00020797          	auipc	a5,0x20
    8000ac7a:	f9a78793          	addi	a5,a5,-102 # 8002ac10 <raidmeta+0x180>
    8000ac7e:	00f706b3          	add	a3,a4,a5
    8000ac82:	fe043603          	ld	a2,-32(s0)
    8000ac86:	fec42703          	lw	a4,-20(s0)
    8000ac8a:	87ba                	mv	a5,a4
    8000ac8c:	0786                	slli	a5,a5,0x1
    8000ac8e:	97ba                	add	a5,a5,a4
    8000ac90:	0792                	slli	a5,a5,0x4
    8000ac92:	97b2                	add	a5,a5,a2
    8000ac94:	ef94                	sd	a3,24(a5)
        raiddata->diskpair[i].diskinfo[1] = raidmeta.diskinfo + i * 2 + 1;
    8000ac96:	fec42783          	lw	a5,-20(s0)
    8000ac9a:	0017979b          	slliw	a5,a5,0x1
    8000ac9e:	2781                	sext.w	a5,a5
    8000aca0:	0785                	addi	a5,a5,1
    8000aca2:	00579713          	slli	a4,a5,0x5
    8000aca6:	00020797          	auipc	a5,0x20
    8000acaa:	f6a78793          	addi	a5,a5,-150 # 8002ac10 <raidmeta+0x180>
    8000acae:	00f706b3          	add	a3,a4,a5
    8000acb2:	fe043603          	ld	a2,-32(s0)
    8000acb6:	fec42703          	lw	a4,-20(s0)
    8000acba:	87ba                	mv	a5,a4
    8000acbc:	0786                	slli	a5,a5,0x1
    8000acbe:	97ba                	add	a5,a5,a4
    8000acc0:	0792                	slli	a5,a5,0x4
    8000acc2:	97b2                	add	a5,a5,a2
    8000acc4:	f394                	sd	a3,32(a5)
        initlock(&raiddata->diskpair[i].mutex, "raidlock");
    8000acc6:	fec42703          	lw	a4,-20(s0)
    8000acca:	87ba                	mv	a5,a4
    8000accc:	0786                	slli	a5,a5,0x1
    8000acce:	97ba                	add	a5,a5,a4
    8000acd0:	0792                	slli	a5,a5,0x4
    8000acd2:	fe043703          	ld	a4,-32(s0)
    8000acd6:	97ba                	add	a5,a5,a4
    8000acd8:	00003597          	auipc	a1,0x3
    8000acdc:	b4858593          	addi	a1,a1,-1208 # 8000d820 <etext+0x820>
    8000ace0:	853e                	mv	a0,a5
    8000ace2:	ffff6097          	auipc	ra,0xffff6
    8000ace6:	61e080e7          	jalr	1566(ra) # 80001300 <initlock>
        raiddata->diskpair[i].writing = 0;
    8000acea:	fe043683          	ld	a3,-32(s0)
    8000acee:	fec42703          	lw	a4,-20(s0)
    8000acf2:	87ba                	mv	a5,a4
    8000acf4:	0786                	slli	a5,a5,0x1
    8000acf6:	97ba                	add	a5,a5,a4
    8000acf8:	0792                	slli	a5,a5,0x4
    8000acfa:	97b6                	add	a5,a5,a3
    8000acfc:	02078423          	sb	zero,40(a5)
        for (int j = 0; j < 2; j++)
    8000ad00:	fe042423          	sw	zero,-24(s0)
    8000ad04:	a025                	j	8000ad2c <raid1init+0x148>
            raiddata->diskpair[i].reading[j] = 0;
    8000ad06:	fe043603          	ld	a2,-32(s0)
    8000ad0a:	fe842683          	lw	a3,-24(s0)
    8000ad0e:	fec42703          	lw	a4,-20(s0)
    8000ad12:	87ba                	mv	a5,a4
    8000ad14:	0786                	slli	a5,a5,0x1
    8000ad16:	97ba                	add	a5,a5,a4
    8000ad18:	0792                	slli	a5,a5,0x4
    8000ad1a:	97b2                	add	a5,a5,a2
    8000ad1c:	97b6                	add	a5,a5,a3
    8000ad1e:	020784a3          	sb	zero,41(a5)
        for (int j = 0; j < 2; j++)
    8000ad22:	fe842783          	lw	a5,-24(s0)
    8000ad26:	2785                	addiw	a5,a5,1
    8000ad28:	fef42423          	sw	a5,-24(s0)
    8000ad2c:	fe842783          	lw	a5,-24(s0)
    8000ad30:	0007871b          	sext.w	a4,a5
    8000ad34:	4785                	li	a5,1
    8000ad36:	fce7d8e3          	bge	a5,a4,8000ad06 <raid1init+0x122>
    for (int i = 0; i < (DISKS + 1) / 2; i++)
    8000ad3a:	fec42783          	lw	a5,-20(s0)
    8000ad3e:	2785                	addiw	a5,a5,1
    8000ad40:	fef42623          	sw	a5,-20(s0)
    8000ad44:	fec42783          	lw	a5,-20(s0)
    8000ad48:	0007871b          	sext.w	a4,a5
    8000ad4c:	4789                	li	a5,2
    8000ad4e:	f0e7dde3          	bge	a5,a4,8000ac68 <raid1init+0x84>
    }

    writeraidmeta();
    8000ad52:	fffff097          	auipc	ra,0xfffff
    8000ad56:	1c8080e7          	jalr	456(ra) # 80009f1a <writeraidmeta>
    return 0;
    8000ad5a:	4781                	li	a5,0
}
    8000ad5c:	853e                	mv	a0,a5
    8000ad5e:	60e2                	ld	ra,24(sp)
    8000ad60:	6442                	ld	s0,16(sp)
    8000ad62:	6105                	addi	sp,sp,32
    8000ad64:	8082                	ret

000000008000ad66 <raid1read>:

int
raid1read(int vblkn, uchar* data)
{
    8000ad66:	715d                	addi	sp,sp,-80
    8000ad68:	e486                	sd	ra,72(sp)
    8000ad6a:	e0a2                	sd	s0,64(sp)
    8000ad6c:	fc26                	sd	s1,56(sp)
    8000ad6e:	0880                	addi	s0,sp,80
    8000ad70:	87aa                	mv	a5,a0
    8000ad72:	fab43823          	sd	a1,-80(s0)
    8000ad76:	faf42e23          	sw	a5,-68(s0)
    if (raidmeta.type != RAID1)
    8000ad7a:	00020797          	auipc	a5,0x20
    8000ad7e:	d1678793          	addi	a5,a5,-746 # 8002aa90 <raidmeta>
    8000ad82:	43dc                	lw	a5,4(a5)
    8000ad84:	873e                	mv	a4,a5
    8000ad86:	4785                	li	a5,1
    8000ad88:	00f70a63          	beq	a4,a5,8000ad9c <raid1read+0x36>
      panic("raid1read");
    8000ad8c:	00003517          	auipc	a0,0x3
    8000ad90:	aa450513          	addi	a0,a0,-1372 # 8000d830 <etext+0x830>
    8000ad94:	ffff6097          	auipc	ra,0xffff6
    8000ad98:	ef4080e7          	jalr	-268(ra) # 80000c88 <panic>

    int pairNum = vblkn / diskblockn();
    8000ad9c:	fbc42483          	lw	s1,-68(s0)
    8000ada0:	fffff097          	auipc	ra,0xfffff
    8000ada4:	132080e7          	jalr	306(ra) # 80009ed2 <diskblockn>
    8000ada8:	87aa                	mv	a5,a0
    8000adaa:	2781                	sext.w	a5,a5
    8000adac:	02f4d7bb          	divuw	a5,s1,a5
    8000adb0:	2781                	sext.w	a5,a5
    8000adb2:	fcf42e23          	sw	a5,-36(s0)
    int pblkn = vblkn % diskblockn();
    8000adb6:	fbc42483          	lw	s1,-68(s0)
    8000adba:	fffff097          	auipc	ra,0xfffff
    8000adbe:	118080e7          	jalr	280(ra) # 80009ed2 <diskblockn>
    8000adc2:	87aa                	mv	a5,a0
    8000adc4:	2781                	sext.w	a5,a5
    8000adc6:	8726                	mv	a4,s1
    8000adc8:	02f777bb          	remuw	a5,a4,a5
    8000adcc:	2781                	sext.w	a5,a5
    8000adce:	fcf42c23          	sw	a5,-40(s0)

    struct RAID1Data* raiddata = &raidmeta.data.raid1;
    8000add2:	00020797          	auipc	a5,0x20
    8000add6:	ce678793          	addi	a5,a5,-794 # 8002aab8 <raidmeta+0x28>
    8000adda:	fcf43823          	sd	a5,-48(s0)
    struct DiskPair* diskpair = raiddata->diskpair + pairNum;
    8000adde:	fd043683          	ld	a3,-48(s0)
    8000ade2:	fdc42703          	lw	a4,-36(s0)
    8000ade6:	87ba                	mv	a5,a4
    8000ade8:	0786                	slli	a5,a5,0x1
    8000adea:	97ba                	add	a5,a5,a4
    8000adec:	0792                	slli	a5,a5,0x4
    8000adee:	97b6                	add	a5,a5,a3
    8000adf0:	fcf43423          	sd	a5,-56(s0)

    return readdiskpair(diskpair, pblkn, data);
    8000adf4:	fd842783          	lw	a5,-40(s0)
    8000adf8:	fb043603          	ld	a2,-80(s0)
    8000adfc:	85be                	mv	a1,a5
    8000adfe:	fc843503          	ld	a0,-56(s0)
    8000ae02:	fffff097          	auipc	ra,0xfffff
    8000ae06:	470080e7          	jalr	1136(ra) # 8000a272 <readdiskpair>
    8000ae0a:	87aa                	mv	a5,a0
    8000ae0c:	2781                	sext.w	a5,a5
}
    8000ae0e:	853e                	mv	a0,a5
    8000ae10:	60a6                	ld	ra,72(sp)
    8000ae12:	6406                	ld	s0,64(sp)
    8000ae14:	74e2                	ld	s1,56(sp)
    8000ae16:	6161                	addi	sp,sp,80
    8000ae18:	8082                	ret

000000008000ae1a <raid1write>:

int
raid1write(int vblkn, uchar* data)
{
    8000ae1a:	715d                	addi	sp,sp,-80
    8000ae1c:	e486                	sd	ra,72(sp)
    8000ae1e:	e0a2                	sd	s0,64(sp)
    8000ae20:	fc26                	sd	s1,56(sp)
    8000ae22:	0880                	addi	s0,sp,80
    8000ae24:	87aa                	mv	a5,a0
    8000ae26:	fab43823          	sd	a1,-80(s0)
    8000ae2a:	faf42e23          	sw	a5,-68(s0)
    if (raidmeta.type != RAID1)
    8000ae2e:	00020797          	auipc	a5,0x20
    8000ae32:	c6278793          	addi	a5,a5,-926 # 8002aa90 <raidmeta>
    8000ae36:	43dc                	lw	a5,4(a5)
    8000ae38:	873e                	mv	a4,a5
    8000ae3a:	4785                	li	a5,1
    8000ae3c:	00f70a63          	beq	a4,a5,8000ae50 <raid1write+0x36>
      panic("raid1write");
    8000ae40:	00003517          	auipc	a0,0x3
    8000ae44:	a0050513          	addi	a0,a0,-1536 # 8000d840 <etext+0x840>
    8000ae48:	ffff6097          	auipc	ra,0xffff6
    8000ae4c:	e40080e7          	jalr	-448(ra) # 80000c88 <panic>

    int pairNum = vblkn / diskblockn();
    8000ae50:	fbc42483          	lw	s1,-68(s0)
    8000ae54:	fffff097          	auipc	ra,0xfffff
    8000ae58:	07e080e7          	jalr	126(ra) # 80009ed2 <diskblockn>
    8000ae5c:	87aa                	mv	a5,a0
    8000ae5e:	2781                	sext.w	a5,a5
    8000ae60:	02f4d7bb          	divuw	a5,s1,a5
    8000ae64:	2781                	sext.w	a5,a5
    8000ae66:	fcf42e23          	sw	a5,-36(s0)
    int pblkn = vblkn % diskblockn();
    8000ae6a:	fbc42483          	lw	s1,-68(s0)
    8000ae6e:	fffff097          	auipc	ra,0xfffff
    8000ae72:	064080e7          	jalr	100(ra) # 80009ed2 <diskblockn>
    8000ae76:	87aa                	mv	a5,a0
    8000ae78:	2781                	sext.w	a5,a5
    8000ae7a:	8726                	mv	a4,s1
    8000ae7c:	02f777bb          	remuw	a5,a4,a5
    8000ae80:	2781                	sext.w	a5,a5
    8000ae82:	fcf42c23          	sw	a5,-40(s0)

    struct RAID1Data* raiddata = &raidmeta.data.raid1;
    8000ae86:	00020797          	auipc	a5,0x20
    8000ae8a:	c3278793          	addi	a5,a5,-974 # 8002aab8 <raidmeta+0x28>
    8000ae8e:	fcf43823          	sd	a5,-48(s0)
    struct DiskPair* diskpair = raiddata->diskpair + pairNum;
    8000ae92:	fd043683          	ld	a3,-48(s0)
    8000ae96:	fdc42703          	lw	a4,-36(s0)
    8000ae9a:	87ba                	mv	a5,a4
    8000ae9c:	0786                	slli	a5,a5,0x1
    8000ae9e:	97ba                	add	a5,a5,a4
    8000aea0:	0792                	slli	a5,a5,0x4
    8000aea2:	97b6                	add	a5,a5,a3
    8000aea4:	fcf43423          	sd	a5,-56(s0)

    return writediskpair(diskpair, pblkn, data);
    8000aea8:	fd842783          	lw	a5,-40(s0)
    8000aeac:	fb043603          	ld	a2,-80(s0)
    8000aeb0:	85be                	mv	a1,a5
    8000aeb2:	fc843503          	ld	a0,-56(s0)
    8000aeb6:	fffff097          	auipc	ra,0xfffff
    8000aeba:	554080e7          	jalr	1364(ra) # 8000a40a <writediskpair>
    8000aebe:	87aa                	mv	a5,a0
    8000aec0:	2781                	sext.w	a5,a5
}
    8000aec2:	853e                	mv	a0,a5
    8000aec4:	60a6                	ld	ra,72(sp)
    8000aec6:	6406                	ld	s0,64(sp)
    8000aec8:	74e2                	ld	s1,56(sp)
    8000aeca:	6161                	addi	sp,sp,80
    8000aecc:	8082                	ret

000000008000aece <raid1repair>:

int
raid1repair(int diskn)
{
    8000aece:	711d                	addi	sp,sp,-96
    8000aed0:	ec86                	sd	ra,88(sp)
    8000aed2:	e8a2                	sd	s0,80(sp)
    8000aed4:	e4a6                	sd	s1,72(sp)
    8000aed6:	1080                	addi	s0,sp,96
    8000aed8:	81010113          	addi	sp,sp,-2032
    8000aedc:	872a                	mv	a4,a0
    8000aede:	77fd                	lui	a5,0xfffff
    8000aee0:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000aee2:	97a2                	add	a5,a5,s0
    8000aee4:	7ce7ae23          	sw	a4,2012(a5)
  struct RAID1Data* raiddata = &raidmeta.data.raid1;
    8000aee8:	00020797          	auipc	a5,0x20
    8000aeec:	bd078793          	addi	a5,a5,-1072 # 8002aab8 <raidmeta+0x28>
    8000aef0:	fcf43823          	sd	a5,-48(s0)
  struct DiskPair* diskpair = raiddata->diskpair + diskn / 2;
    8000aef4:	fd043703          	ld	a4,-48(s0)
    8000aef8:	77fd                	lui	a5,0xfffff
    8000aefa:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000aefc:	97a2                	add	a5,a5,s0
    8000aefe:	7dc7a783          	lw	a5,2012(a5)
    8000af02:	01f7d69b          	srliw	a3,a5,0x1f
    8000af06:	9fb5                	addw	a5,a5,a3
    8000af08:	4017d79b          	sraiw	a5,a5,0x1
    8000af0c:	2781                	sext.w	a5,a5
    8000af0e:	86be                	mv	a3,a5
    8000af10:	87b6                	mv	a5,a3
    8000af12:	0786                	slli	a5,a5,0x1
    8000af14:	97b6                	add	a5,a5,a3
    8000af16:	0792                	slli	a5,a5,0x4
    8000af18:	97ba                	add	a5,a5,a4
    8000af1a:	fcf43423          	sd	a5,-56(s0)
  struct DiskInfo* pair = diskpair->diskinfo[1 - diskn % 2];
    8000af1e:	77fd                	lui	a5,0xfffff
    8000af20:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000af22:	97a2                	add	a5,a5,s0
    8000af24:	7dc7a783          	lw	a5,2012(a5)
    8000af28:	873e                	mv	a4,a5
    8000af2a:	41f7579b          	sraiw	a5,a4,0x1f
    8000af2e:	01f7d79b          	srliw	a5,a5,0x1f
    8000af32:	9f3d                	addw	a4,a4,a5
    8000af34:	8b05                	andi	a4,a4,1
    8000af36:	40f707bb          	subw	a5,a4,a5
    8000af3a:	2781                	sext.w	a5,a5
    8000af3c:	4705                	li	a4,1
    8000af3e:	40f707bb          	subw	a5,a4,a5
    8000af42:	2781                	sext.w	a5,a5
    8000af44:	fc843703          	ld	a4,-56(s0)
    8000af48:	0789                	addi	a5,a5,2
    8000af4a:	078e                	slli	a5,a5,0x3
    8000af4c:	97ba                	add	a5,a5,a4
    8000af4e:	679c                	ld	a5,8(a5)
    8000af50:	fcf43023          	sd	a5,-64(s0)

   if (!pair->valid)
    8000af54:	fc043783          	ld	a5,-64(s0)
    8000af58:	0187c783          	lbu	a5,24(a5)
    8000af5c:	e399                	bnez	a5,8000af62 <raid1repair+0x94>
      return -1;
    8000af5e:	57fd                	li	a5,-1
    8000af60:	aa5d                	j	8000b116 <raid1repair+0x248>

  acquire(&diskpair->mutex);
    8000af62:	fc843783          	ld	a5,-56(s0)
    8000af66:	853e                	mv	a0,a5
    8000af68:	ffff6097          	auipc	ra,0xffff6
    8000af6c:	3c8080e7          	jalr	968(ra) # 80001330 <acquire>
  while (1)
  {
    if (diskpair->writing || diskpair->reading[0] || diskpair->reading[1])
    8000af70:	fc843783          	ld	a5,-56(s0)
    8000af74:	0287c783          	lbu	a5,40(a5)
    8000af78:	eb99                	bnez	a5,8000af8e <raid1repair+0xc0>
    8000af7a:	fc843783          	ld	a5,-56(s0)
    8000af7e:	0297c783          	lbu	a5,41(a5)
    8000af82:	e791                	bnez	a5,8000af8e <raid1repair+0xc0>
    8000af84:	fc843783          	ld	a5,-56(s0)
    8000af88:	02a7c783          	lbu	a5,42(a5)
    8000af8c:	cb99                	beqz	a5,8000afa2 <raid1repair+0xd4>
    {
      sleep(diskpair, &diskpair->mutex);
    8000af8e:	fc843783          	ld	a5,-56(s0)
    8000af92:	85be                	mv	a1,a5
    8000af94:	fc843503          	ld	a0,-56(s0)
    8000af98:	ffff8097          	auipc	ra,0xffff8
    8000af9c:	730080e7          	jalr	1840(ra) # 800036c8 <sleep>
      continue;
    8000afa0:	a00d                	j	8000afc2 <raid1repair+0xf4>
    }

    diskpair->writing = 1;
    8000afa2:	fc843783          	ld	a5,-56(s0)
    8000afa6:	4705                	li	a4,1
    8000afa8:	02e78423          	sb	a4,40(a5)
    release(&diskpair->mutex);
    8000afac:	fc843783          	ld	a5,-56(s0)
    8000afb0:	853e                	mv	a0,a5
    8000afb2:	ffff6097          	auipc	ra,0xffff6
    8000afb6:	3e2080e7          	jalr	994(ra) # 80001394 <release>
    break;
    8000afba:	0001                	nop
  }

  for (int i = 0; i <= diskblockn(); i++)
    8000afbc:	fc042e23          	sw	zero,-36(s0)
    8000afc0:	a895                	j	8000b034 <raid1repair+0x166>
    if (diskpair->writing || diskpair->reading[0] || diskpair->reading[1])
    8000afc2:	b77d                	j	8000af70 <raid1repair+0xa2>
  {
      uchar data[BSIZE];
      read_block(pair->pdiskn, i, data);
    8000afc4:	fc043783          	ld	a5,-64(s0)
    8000afc8:	0197c783          	lbu	a5,25(a5)
    8000afcc:	0007871b          	sext.w	a4,a5
    8000afd0:	77fd                	lui	a5,0xfffff
    8000afd2:	7e078793          	addi	a5,a5,2016 # fffffffffffff7e0 <end+0xffffffff7ffd4ad0>
    8000afd6:	1781                	addi	a5,a5,-32
    8000afd8:	008786b3          	add	a3,a5,s0
    8000afdc:	fdc42783          	lw	a5,-36(s0)
    8000afe0:	8636                	mv	a2,a3
    8000afe2:	85be                	mv	a1,a5
    8000afe4:	853a                	mv	a0,a4
    8000afe6:	fffff097          	auipc	ra,0xfffff
    8000afea:	c8e080e7          	jalr	-882(ra) # 80009c74 <read_block>
      write_block(raidmeta.diskinfo[diskn].pdiskn, i, data);
    8000afee:	00020717          	auipc	a4,0x20
    8000aff2:	aa270713          	addi	a4,a4,-1374 # 8002aa90 <raidmeta>
    8000aff6:	77fd                	lui	a5,0xfffff
    8000aff8:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000affa:	97a2                	add	a5,a5,s0
    8000affc:	7dc7a783          	lw	a5,2012(a5)
    8000b000:	0796                	slli	a5,a5,0x5
    8000b002:	97ba                	add	a5,a5,a4
    8000b004:	1997c783          	lbu	a5,409(a5)
    8000b008:	0007871b          	sext.w	a4,a5
    8000b00c:	77fd                	lui	a5,0xfffff
    8000b00e:	7e078793          	addi	a5,a5,2016 # fffffffffffff7e0 <end+0xffffffff7ffd4ad0>
    8000b012:	1781                	addi	a5,a5,-32
    8000b014:	008786b3          	add	a3,a5,s0
    8000b018:	fdc42783          	lw	a5,-36(s0)
    8000b01c:	8636                	mv	a2,a3
    8000b01e:	85be                	mv	a1,a5
    8000b020:	853a                	mv	a0,a4
    8000b022:	fffff097          	auipc	ra,0xfffff
    8000b026:	b7e080e7          	jalr	-1154(ra) # 80009ba0 <write_block>
  for (int i = 0; i <= diskblockn(); i++)
    8000b02a:	fdc42783          	lw	a5,-36(s0)
    8000b02e:	2785                	addiw	a5,a5,1
    8000b030:	fcf42e23          	sw	a5,-36(s0)
    8000b034:	fffff097          	auipc	ra,0xfffff
    8000b038:	e9e080e7          	jalr	-354(ra) # 80009ed2 <diskblockn>
    8000b03c:	87aa                	mv	a5,a0
    8000b03e:	0007871b          	sext.w	a4,a5
    8000b042:	fdc42783          	lw	a5,-36(s0)
    8000b046:	f6f77fe3          	bgeu	a4,a5,8000afc4 <raid1repair+0xf6>
  }

  raidmeta.diskinfo[diskn].valid = 1;
    8000b04a:	00020717          	auipc	a4,0x20
    8000b04e:	a4670713          	addi	a4,a4,-1466 # 8002aa90 <raidmeta>
    8000b052:	77fd                	lui	a5,0xfffff
    8000b054:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000b056:	97a2                	add	a5,a5,s0
    8000b058:	7dc7a783          	lw	a5,2012(a5)
    8000b05c:	0796                	slli	a5,a5,0x5
    8000b05e:	97ba                	add	a5,a5,a4
    8000b060:	4705                	li	a4,1
    8000b062:	18e78c23          	sb	a4,408(a5)
  acquire(&diskpair->mutex);
    8000b066:	fc843783          	ld	a5,-56(s0)
    8000b06a:	853e                	mv	a0,a5
    8000b06c:	ffff6097          	auipc	ra,0xffff6
    8000b070:	2c4080e7          	jalr	708(ra) # 80001330 <acquire>
  diskpair->writing = 0;
    8000b074:	fc843783          	ld	a5,-56(s0)
    8000b078:	02078423          	sb	zero,40(a5)
  release(&diskpair->mutex);
    8000b07c:	fc843783          	ld	a5,-56(s0)
    8000b080:	853e                	mv	a0,a5
    8000b082:	ffff6097          	auipc	ra,0xffff6
    8000b086:	312080e7          	jalr	786(ra) # 80001394 <release>
  wakeup(diskpair);
    8000b08a:	fc843503          	ld	a0,-56(s0)
    8000b08e:	ffff8097          	auipc	ra,0xffff8
    8000b092:	6b6080e7          	jalr	1718(ra) # 80003744 <wakeup>

  uchar data[BSIZE] = {0};
    8000b096:	bc040793          	addi	a5,s0,-1088
    8000b09a:	40000713          	li	a4,1024
    8000b09e:	863a                	mv	a2,a4
    8000b0a0:	4581                	li	a1,0
    8000b0a2:	853e                	mv	a0,a5
    8000b0a4:	ffff6097          	auipc	ra,0xffff6
    8000b0a8:	460080e7          	jalr	1120(ra) # 80001504 <memset>
  memmove(data, &raidmeta, sizeof(raidmeta));
    8000b0ac:	bc040793          	addi	a5,s0,-1088
    8000b0b0:	28000613          	li	a2,640
    8000b0b4:	00020597          	auipc	a1,0x20
    8000b0b8:	9dc58593          	addi	a1,a1,-1572 # 8002aa90 <raidmeta>
    8000b0bc:	853e                	mv	a0,a5
    8000b0be:	ffff6097          	auipc	ra,0xffff6
    8000b0c2:	52a080e7          	jalr	1322(ra) # 800015e8 <memmove>
  for (int i = 0; i < 1; i++)
    8000b0c6:	fc042c23          	sw	zero,-40(s0)
    8000b0ca:	a081                	j	8000b10a <raid1repair+0x23c>
    writediskpair(raiddata->diskpair + i, diskblockn(), data);
    8000b0cc:	fd043683          	ld	a3,-48(s0)
    8000b0d0:	fd842703          	lw	a4,-40(s0)
    8000b0d4:	87ba                	mv	a5,a4
    8000b0d6:	0786                	slli	a5,a5,0x1
    8000b0d8:	97ba                	add	a5,a5,a4
    8000b0da:	0792                	slli	a5,a5,0x4
    8000b0dc:	00f684b3          	add	s1,a3,a5
    8000b0e0:	fffff097          	auipc	ra,0xfffff
    8000b0e4:	df2080e7          	jalr	-526(ra) # 80009ed2 <diskblockn>
    8000b0e8:	87aa                	mv	a5,a0
    8000b0ea:	2781                	sext.w	a5,a5
    8000b0ec:	2781                	sext.w	a5,a5
    8000b0ee:	bc040713          	addi	a4,s0,-1088
    8000b0f2:	863a                	mv	a2,a4
    8000b0f4:	85be                	mv	a1,a5
    8000b0f6:	8526                	mv	a0,s1
    8000b0f8:	fffff097          	auipc	ra,0xfffff
    8000b0fc:	312080e7          	jalr	786(ra) # 8000a40a <writediskpair>
  for (int i = 0; i < 1; i++)
    8000b100:	fd842783          	lw	a5,-40(s0)
    8000b104:	2785                	addiw	a5,a5,1
    8000b106:	fcf42c23          	sw	a5,-40(s0)
    8000b10a:	fd842783          	lw	a5,-40(s0)
    8000b10e:	2781                	sext.w	a5,a5
    8000b110:	faf05ee3          	blez	a5,8000b0cc <raid1repair+0x1fe>

  return 0;
    8000b114:	4781                	li	a5,0
    8000b116:	853e                	mv	a0,a5
    8000b118:	7f010113          	addi	sp,sp,2032
    8000b11c:	60e6                	ld	ra,88(sp)
    8000b11e:	6446                	ld	s0,80(sp)
    8000b120:	64a6                	ld	s1,72(sp)
    8000b122:	6125                	addi	sp,sp,96
    8000b124:	8082                	ret

000000008000b126 <raid0_1blockn>:
int raid0_1write(int vblkn, uchar* data);
int raid0_1repair(int diskn);

uint
raid0_1blockn(void)
{
    8000b126:	1141                	addi	sp,sp,-16
    8000b128:	e406                	sd	ra,8(sp)
    8000b12a:	e022                	sd	s0,0(sp)
    8000b12c:	0800                	addi	s0,sp,16
    return diskblockn() * (DISKS / 2);
    8000b12e:	fffff097          	auipc	ra,0xfffff
    8000b132:	da4080e7          	jalr	-604(ra) # 80009ed2 <diskblockn>
    8000b136:	87aa                	mv	a5,a0
    8000b138:	2781                	sext.w	a5,a5
    8000b13a:	873e                	mv	a4,a5
    8000b13c:	87ba                	mv	a5,a4
    8000b13e:	0017979b          	slliw	a5,a5,0x1
    8000b142:	9fb9                	addw	a5,a5,a4
    8000b144:	2781                	sext.w	a5,a5
}
    8000b146:	853e                	mv	a0,a5
    8000b148:	60a2                	ld	ra,8(sp)
    8000b14a:	6402                	ld	s0,0(sp)
    8000b14c:	0141                	addi	sp,sp,16
    8000b14e:	8082                	ret

000000008000b150 <raid0_1init>:

int
raid0_1init(void)
{
    8000b150:	1101                	addi	sp,sp,-32
    8000b152:	ec06                	sd	ra,24(sp)
    8000b154:	e822                	sd	s0,16(sp)
    8000b156:	1000                	addi	s0,sp,32
    raidmeta.valid = 1;
    8000b158:	00020797          	auipc	a5,0x20
    8000b15c:	93878793          	addi	a5,a5,-1736 # 8002aa90 <raidmeta>
    8000b160:	4705                	li	a4,1
    8000b162:	00e780a3          	sb	a4,1(a5)
    raidmeta.type = RAID0_1;
    8000b166:	00020797          	auipc	a5,0x20
    8000b16a:	92a78793          	addi	a5,a5,-1750 # 8002aa90 <raidmeta>
    8000b16e:	4709                	li	a4,2
    8000b170:	c3d8                	sw	a4,4(a5)
    raidmeta.read = raid0_1read;
    8000b172:	00020797          	auipc	a5,0x20
    8000b176:	91e78793          	addi	a5,a5,-1762 # 8002aa90 <raidmeta>
    8000b17a:	00000717          	auipc	a4,0x0
    8000b17e:	14c70713          	addi	a4,a4,332 # 8000b2c6 <raid0_1read>
    8000b182:	26e7b023          	sd	a4,608(a5)
    raidmeta.write = raid0_1write;
    8000b186:	00020797          	auipc	a5,0x20
    8000b18a:	90a78793          	addi	a5,a5,-1782 # 8002aa90 <raidmeta>
    8000b18e:	00000717          	auipc	a4,0x0
    8000b192:	1d670713          	addi	a4,a4,470 # 8000b364 <raid0_1write>
    8000b196:	26e7b423          	sd	a4,616(a5)
    raidmeta.blockn = raid0_1blockn;
    8000b19a:	00020797          	auipc	a5,0x20
    8000b19e:	8f678793          	addi	a5,a5,-1802 # 8002aa90 <raidmeta>
    8000b1a2:	00000717          	auipc	a4,0x0
    8000b1a6:	f8470713          	addi	a4,a4,-124 # 8000b126 <raid0_1blockn>
    8000b1aa:	26e7b823          	sd	a4,624(a5)
    raidmeta.repair = raid0_1repair;
    8000b1ae:	00020797          	auipc	a5,0x20
    8000b1b2:	8e278793          	addi	a5,a5,-1822 # 8002aa90 <raidmeta>
    8000b1b6:	00000717          	auipc	a4,0x0
    8000b1ba:	24c70713          	addi	a4,a4,588 # 8000b402 <raid0_1repair>
    8000b1be:	26e7bc23          	sd	a4,632(a5)

    struct RAID0_1Data* raiddata = &raidmeta.data.raid0_1;
    8000b1c2:	00020797          	auipc	a5,0x20
    8000b1c6:	8f678793          	addi	a5,a5,-1802 # 8002aab8 <raidmeta+0x28>
    8000b1ca:	fef43023          	sd	a5,-32(s0)
    for (int i = 0; i < DISKS / 2; i++)
    8000b1ce:	fe042623          	sw	zero,-20(s0)
    8000b1d2:	a8c9                	j	8000b2a4 <raid0_1init+0x154>
    {
        raiddata->diskpair[i].diskinfo[0] = raidmeta.diskinfo + i;
    8000b1d4:	fec42783          	lw	a5,-20(s0)
    8000b1d8:	00579713          	slli	a4,a5,0x5
    8000b1dc:	00020797          	auipc	a5,0x20
    8000b1e0:	a3478793          	addi	a5,a5,-1484 # 8002ac10 <raidmeta+0x180>
    8000b1e4:	00f706b3          	add	a3,a4,a5
    8000b1e8:	fe043603          	ld	a2,-32(s0)
    8000b1ec:	fec42703          	lw	a4,-20(s0)
    8000b1f0:	87ba                	mv	a5,a4
    8000b1f2:	0786                	slli	a5,a5,0x1
    8000b1f4:	97ba                	add	a5,a5,a4
    8000b1f6:	0792                	slli	a5,a5,0x4
    8000b1f8:	97b2                	add	a5,a5,a2
    8000b1fa:	ef94                	sd	a3,24(a5)
        raiddata->diskpair[i].diskinfo[1] = raidmeta.diskinfo + i + DISKS / 2;
    8000b1fc:	fec42783          	lw	a5,-20(s0)
    8000b200:	078d                	addi	a5,a5,3
    8000b202:	00579713          	slli	a4,a5,0x5
    8000b206:	00020797          	auipc	a5,0x20
    8000b20a:	a0a78793          	addi	a5,a5,-1526 # 8002ac10 <raidmeta+0x180>
    8000b20e:	00f706b3          	add	a3,a4,a5
    8000b212:	fe043603          	ld	a2,-32(s0)
    8000b216:	fec42703          	lw	a4,-20(s0)
    8000b21a:	87ba                	mv	a5,a4
    8000b21c:	0786                	slli	a5,a5,0x1
    8000b21e:	97ba                	add	a5,a5,a4
    8000b220:	0792                	slli	a5,a5,0x4
    8000b222:	97b2                	add	a5,a5,a2
    8000b224:	f394                	sd	a3,32(a5)

        initlock(&raiddata->diskpair[i].mutex, "raidlock");
    8000b226:	fec42703          	lw	a4,-20(s0)
    8000b22a:	87ba                	mv	a5,a4
    8000b22c:	0786                	slli	a5,a5,0x1
    8000b22e:	97ba                	add	a5,a5,a4
    8000b230:	0792                	slli	a5,a5,0x4
    8000b232:	fe043703          	ld	a4,-32(s0)
    8000b236:	97ba                	add	a5,a5,a4
    8000b238:	00002597          	auipc	a1,0x2
    8000b23c:	61858593          	addi	a1,a1,1560 # 8000d850 <etext+0x850>
    8000b240:	853e                	mv	a0,a5
    8000b242:	ffff6097          	auipc	ra,0xffff6
    8000b246:	0be080e7          	jalr	190(ra) # 80001300 <initlock>
        raiddata->diskpair[i].writing = 0;
    8000b24a:	fe043683          	ld	a3,-32(s0)
    8000b24e:	fec42703          	lw	a4,-20(s0)
    8000b252:	87ba                	mv	a5,a4
    8000b254:	0786                	slli	a5,a5,0x1
    8000b256:	97ba                	add	a5,a5,a4
    8000b258:	0792                	slli	a5,a5,0x4
    8000b25a:	97b6                	add	a5,a5,a3
    8000b25c:	02078423          	sb	zero,40(a5)
        for (int j = 0; j < 2; j++)
    8000b260:	fe042423          	sw	zero,-24(s0)
    8000b264:	a025                	j	8000b28c <raid0_1init+0x13c>
            raiddata->diskpair[i].reading[j] = 0;
    8000b266:	fe043603          	ld	a2,-32(s0)
    8000b26a:	fe842683          	lw	a3,-24(s0)
    8000b26e:	fec42703          	lw	a4,-20(s0)
    8000b272:	87ba                	mv	a5,a4
    8000b274:	0786                	slli	a5,a5,0x1
    8000b276:	97ba                	add	a5,a5,a4
    8000b278:	0792                	slli	a5,a5,0x4
    8000b27a:	97b2                	add	a5,a5,a2
    8000b27c:	97b6                	add	a5,a5,a3
    8000b27e:	020784a3          	sb	zero,41(a5)
        for (int j = 0; j < 2; j++)
    8000b282:	fe842783          	lw	a5,-24(s0)
    8000b286:	2785                	addiw	a5,a5,1
    8000b288:	fef42423          	sw	a5,-24(s0)
    8000b28c:	fe842783          	lw	a5,-24(s0)
    8000b290:	0007871b          	sext.w	a4,a5
    8000b294:	4785                	li	a5,1
    8000b296:	fce7d8e3          	bge	a5,a4,8000b266 <raid0_1init+0x116>
    for (int i = 0; i < DISKS / 2; i++)
    8000b29a:	fec42783          	lw	a5,-20(s0)
    8000b29e:	2785                	addiw	a5,a5,1
    8000b2a0:	fef42623          	sw	a5,-20(s0)
    8000b2a4:	fec42783          	lw	a5,-20(s0)
    8000b2a8:	0007871b          	sext.w	a4,a5
    8000b2ac:	4789                	li	a5,2
    8000b2ae:	f2e7d3e3          	bge	a5,a4,8000b1d4 <raid0_1init+0x84>
    }

	writeraidmeta();
    8000b2b2:	fffff097          	auipc	ra,0xfffff
    8000b2b6:	c68080e7          	jalr	-920(ra) # 80009f1a <writeraidmeta>
    return 0;
    8000b2ba:	4781                	li	a5,0
}
    8000b2bc:	853e                	mv	a0,a5
    8000b2be:	60e2                	ld	ra,24(sp)
    8000b2c0:	6442                	ld	s0,16(sp)
    8000b2c2:	6105                	addi	sp,sp,32
    8000b2c4:	8082                	ret

000000008000b2c6 <raid0_1read>:

int
raid0_1read(int vblkn, uchar* data)
{
    8000b2c6:	7139                	addi	sp,sp,-64
    8000b2c8:	fc06                	sd	ra,56(sp)
    8000b2ca:	f822                	sd	s0,48(sp)
    8000b2cc:	0080                	addi	s0,sp,64
    8000b2ce:	87aa                	mv	a5,a0
    8000b2d0:	fcb43023          	sd	a1,-64(s0)
    8000b2d4:	fcf42623          	sw	a5,-52(s0)
    if (raidmeta.type != RAID0_1)
    8000b2d8:	0001f797          	auipc	a5,0x1f
    8000b2dc:	7b878793          	addi	a5,a5,1976 # 8002aa90 <raidmeta>
    8000b2e0:	43dc                	lw	a5,4(a5)
    8000b2e2:	873e                	mv	a4,a5
    8000b2e4:	4789                	li	a5,2
    8000b2e6:	00f70a63          	beq	a4,a5,8000b2fa <raid0_1read+0x34>
      panic("raid0_1read");
    8000b2ea:	00002517          	auipc	a0,0x2
    8000b2ee:	57650513          	addi	a0,a0,1398 # 8000d860 <etext+0x860>
    8000b2f2:	ffff6097          	auipc	ra,0xffff6
    8000b2f6:	996080e7          	jalr	-1642(ra) # 80000c88 <panic>

    uint pairn = vblkn % (DISKS / 2);
    8000b2fa:	fcc42783          	lw	a5,-52(s0)
    8000b2fe:	873e                	mv	a4,a5
    8000b300:	478d                	li	a5,3
    8000b302:	02f767bb          	remw	a5,a4,a5
    8000b306:	2781                	sext.w	a5,a5
    8000b308:	fef42623          	sw	a5,-20(s0)
    uint pblkn = vblkn / (DISKS / 2);
    8000b30c:	fcc42783          	lw	a5,-52(s0)
    8000b310:	873e                	mv	a4,a5
    8000b312:	478d                	li	a5,3
    8000b314:	02f747bb          	divw	a5,a4,a5
    8000b318:	2781                	sext.w	a5,a5
    8000b31a:	fef42423          	sw	a5,-24(s0)

    struct RAID0_1Data* raiddata = &raidmeta.data.raid0_1;
    8000b31e:	0001f797          	auipc	a5,0x1f
    8000b322:	79a78793          	addi	a5,a5,1946 # 8002aab8 <raidmeta+0x28>
    8000b326:	fef43023          	sd	a5,-32(s0)
    struct DiskPair* diskpair = raiddata->diskpair + pairn;
    8000b32a:	fe043683          	ld	a3,-32(s0)
    8000b32e:	fec46703          	lwu	a4,-20(s0)
    8000b332:	87ba                	mv	a5,a4
    8000b334:	0786                	slli	a5,a5,0x1
    8000b336:	97ba                	add	a5,a5,a4
    8000b338:	0792                	slli	a5,a5,0x4
    8000b33a:	97b6                	add	a5,a5,a3
    8000b33c:	fcf43c23          	sd	a5,-40(s0)

    return readdiskpair(diskpair, pblkn, data);
    8000b340:	fe842783          	lw	a5,-24(s0)
    8000b344:	fc043603          	ld	a2,-64(s0)
    8000b348:	85be                	mv	a1,a5
    8000b34a:	fd843503          	ld	a0,-40(s0)
    8000b34e:	fffff097          	auipc	ra,0xfffff
    8000b352:	f24080e7          	jalr	-220(ra) # 8000a272 <readdiskpair>
    8000b356:	87aa                	mv	a5,a0
    8000b358:	2781                	sext.w	a5,a5
}
    8000b35a:	853e                	mv	a0,a5
    8000b35c:	70e2                	ld	ra,56(sp)
    8000b35e:	7442                	ld	s0,48(sp)
    8000b360:	6121                	addi	sp,sp,64
    8000b362:	8082                	ret

000000008000b364 <raid0_1write>:

int
raid0_1write(int vblkn, uchar* data)
{
    8000b364:	7139                	addi	sp,sp,-64
    8000b366:	fc06                	sd	ra,56(sp)
    8000b368:	f822                	sd	s0,48(sp)
    8000b36a:	0080                	addi	s0,sp,64
    8000b36c:	87aa                	mv	a5,a0
    8000b36e:	fcb43023          	sd	a1,-64(s0)
    8000b372:	fcf42623          	sw	a5,-52(s0)
    if (raidmeta.type != RAID0_1)
    8000b376:	0001f797          	auipc	a5,0x1f
    8000b37a:	71a78793          	addi	a5,a5,1818 # 8002aa90 <raidmeta>
    8000b37e:	43dc                	lw	a5,4(a5)
    8000b380:	873e                	mv	a4,a5
    8000b382:	4789                	li	a5,2
    8000b384:	00f70a63          	beq	a4,a5,8000b398 <raid0_1write+0x34>
        panic("raid0_1read");
    8000b388:	00002517          	auipc	a0,0x2
    8000b38c:	4d850513          	addi	a0,a0,1240 # 8000d860 <etext+0x860>
    8000b390:	ffff6097          	auipc	ra,0xffff6
    8000b394:	8f8080e7          	jalr	-1800(ra) # 80000c88 <panic>

    uint pairn = vblkn % (DISKS / 2);
    8000b398:	fcc42783          	lw	a5,-52(s0)
    8000b39c:	873e                	mv	a4,a5
    8000b39e:	478d                	li	a5,3
    8000b3a0:	02f767bb          	remw	a5,a4,a5
    8000b3a4:	2781                	sext.w	a5,a5
    8000b3a6:	fef42623          	sw	a5,-20(s0)
    uint pblkn = vblkn / (DISKS / 2);
    8000b3aa:	fcc42783          	lw	a5,-52(s0)
    8000b3ae:	873e                	mv	a4,a5
    8000b3b0:	478d                	li	a5,3
    8000b3b2:	02f747bb          	divw	a5,a4,a5
    8000b3b6:	2781                	sext.w	a5,a5
    8000b3b8:	fef42423          	sw	a5,-24(s0)

    struct RAID0_1Data* raiddata = &raidmeta.data.raid0_1;
    8000b3bc:	0001f797          	auipc	a5,0x1f
    8000b3c0:	6fc78793          	addi	a5,a5,1788 # 8002aab8 <raidmeta+0x28>
    8000b3c4:	fef43023          	sd	a5,-32(s0)
    struct DiskPair* diskpair = raiddata->diskpair + pairn;
    8000b3c8:	fe043683          	ld	a3,-32(s0)
    8000b3cc:	fec46703          	lwu	a4,-20(s0)
    8000b3d0:	87ba                	mv	a5,a4
    8000b3d2:	0786                	slli	a5,a5,0x1
    8000b3d4:	97ba                	add	a5,a5,a4
    8000b3d6:	0792                	slli	a5,a5,0x4
    8000b3d8:	97b6                	add	a5,a5,a3
    8000b3da:	fcf43c23          	sd	a5,-40(s0)

    return writediskpair(diskpair, pblkn, data);
    8000b3de:	fe842783          	lw	a5,-24(s0)
    8000b3e2:	fc043603          	ld	a2,-64(s0)
    8000b3e6:	85be                	mv	a1,a5
    8000b3e8:	fd843503          	ld	a0,-40(s0)
    8000b3ec:	fffff097          	auipc	ra,0xfffff
    8000b3f0:	01e080e7          	jalr	30(ra) # 8000a40a <writediskpair>
    8000b3f4:	87aa                	mv	a5,a0
    8000b3f6:	2781                	sext.w	a5,a5
}
    8000b3f8:	853e                	mv	a0,a5
    8000b3fa:	70e2                	ld	ra,56(sp)
    8000b3fc:	7442                	ld	s0,48(sp)
    8000b3fe:	6121                	addi	sp,sp,64
    8000b400:	8082                	ret

000000008000b402 <raid0_1repair>:

int
raid0_1repair(int diskn)
{
    8000b402:	711d                	addi	sp,sp,-96
    8000b404:	ec86                	sd	ra,88(sp)
    8000b406:	e8a2                	sd	s0,80(sp)
    8000b408:	e4a6                	sd	s1,72(sp)
    8000b40a:	1080                	addi	s0,sp,96
    8000b40c:	81010113          	addi	sp,sp,-2032
    8000b410:	872a                	mv	a4,a0
    8000b412:	77fd                	lui	a5,0xfffff
    8000b414:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000b416:	97a2                	add	a5,a5,s0
    8000b418:	7ce7ae23          	sw	a4,2012(a5)
    struct RAID0_1Data* raiddata = &raidmeta.data.raid0_1;
    8000b41c:	0001f797          	auipc	a5,0x1f
    8000b420:	69c78793          	addi	a5,a5,1692 # 8002aab8 <raidmeta+0x28>
    8000b424:	fcf43823          	sd	a5,-48(s0)
    struct DiskPair* diskpair = raiddata->diskpair + diskn / 2;
    8000b428:	fd043703          	ld	a4,-48(s0)
    8000b42c:	77fd                	lui	a5,0xfffff
    8000b42e:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000b430:	97a2                	add	a5,a5,s0
    8000b432:	7dc7a783          	lw	a5,2012(a5)
    8000b436:	01f7d69b          	srliw	a3,a5,0x1f
    8000b43a:	9fb5                	addw	a5,a5,a3
    8000b43c:	4017d79b          	sraiw	a5,a5,0x1
    8000b440:	2781                	sext.w	a5,a5
    8000b442:	86be                	mv	a3,a5
    8000b444:	87b6                	mv	a5,a3
    8000b446:	0786                	slli	a5,a5,0x1
    8000b448:	97b6                	add	a5,a5,a3
    8000b44a:	0792                	slli	a5,a5,0x4
    8000b44c:	97ba                	add	a5,a5,a4
    8000b44e:	fcf43423          	sd	a5,-56(s0)
    struct DiskInfo* pair = diskpair->diskinfo[1 - diskn % 2];
    8000b452:	77fd                	lui	a5,0xfffff
    8000b454:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000b456:	97a2                	add	a5,a5,s0
    8000b458:	7dc7a783          	lw	a5,2012(a5)
    8000b45c:	873e                	mv	a4,a5
    8000b45e:	41f7579b          	sraiw	a5,a4,0x1f
    8000b462:	01f7d79b          	srliw	a5,a5,0x1f
    8000b466:	9f3d                	addw	a4,a4,a5
    8000b468:	8b05                	andi	a4,a4,1
    8000b46a:	40f707bb          	subw	a5,a4,a5
    8000b46e:	2781                	sext.w	a5,a5
    8000b470:	4705                	li	a4,1
    8000b472:	40f707bb          	subw	a5,a4,a5
    8000b476:	2781                	sext.w	a5,a5
    8000b478:	fc843703          	ld	a4,-56(s0)
    8000b47c:	0789                	addi	a5,a5,2
    8000b47e:	078e                	slli	a5,a5,0x3
    8000b480:	97ba                	add	a5,a5,a4
    8000b482:	679c                	ld	a5,8(a5)
    8000b484:	fcf43023          	sd	a5,-64(s0)

    if (!pair->valid)
    8000b488:	fc043783          	ld	a5,-64(s0)
    8000b48c:	0187c783          	lbu	a5,24(a5)
    8000b490:	e399                	bnez	a5,8000b496 <raid0_1repair+0x94>
        return -1;
    8000b492:	57fd                	li	a5,-1
    8000b494:	aa5d                	j	8000b64a <raid0_1repair+0x248>

    acquire(&diskpair->mutex);
    8000b496:	fc843783          	ld	a5,-56(s0)
    8000b49a:	853e                	mv	a0,a5
    8000b49c:	ffff6097          	auipc	ra,0xffff6
    8000b4a0:	e94080e7          	jalr	-364(ra) # 80001330 <acquire>
    while (1)
    {
        if (diskpair->writing || diskpair->reading[0] || diskpair->reading[1])
    8000b4a4:	fc843783          	ld	a5,-56(s0)
    8000b4a8:	0287c783          	lbu	a5,40(a5)
    8000b4ac:	eb99                	bnez	a5,8000b4c2 <raid0_1repair+0xc0>
    8000b4ae:	fc843783          	ld	a5,-56(s0)
    8000b4b2:	0297c783          	lbu	a5,41(a5)
    8000b4b6:	e791                	bnez	a5,8000b4c2 <raid0_1repair+0xc0>
    8000b4b8:	fc843783          	ld	a5,-56(s0)
    8000b4bc:	02a7c783          	lbu	a5,42(a5)
    8000b4c0:	cb99                	beqz	a5,8000b4d6 <raid0_1repair+0xd4>
        {
            sleep(diskpair, &diskpair->mutex);
    8000b4c2:	fc843783          	ld	a5,-56(s0)
    8000b4c6:	85be                	mv	a1,a5
    8000b4c8:	fc843503          	ld	a0,-56(s0)
    8000b4cc:	ffff8097          	auipc	ra,0xffff8
    8000b4d0:	1fc080e7          	jalr	508(ra) # 800036c8 <sleep>
            continue;
    8000b4d4:	a00d                	j	8000b4f6 <raid0_1repair+0xf4>
        }

        diskpair->writing = 1;
    8000b4d6:	fc843783          	ld	a5,-56(s0)
    8000b4da:	4705                	li	a4,1
    8000b4dc:	02e78423          	sb	a4,40(a5)
        release(&diskpair->mutex);
    8000b4e0:	fc843783          	ld	a5,-56(s0)
    8000b4e4:	853e                	mv	a0,a5
    8000b4e6:	ffff6097          	auipc	ra,0xffff6
    8000b4ea:	eae080e7          	jalr	-338(ra) # 80001394 <release>
        break;
    8000b4ee:	0001                	nop
    }

    for (int i = 0; i <= diskblockn(); i++)
    8000b4f0:	fc042e23          	sw	zero,-36(s0)
    8000b4f4:	a895                	j	8000b568 <raid0_1repair+0x166>
        if (diskpair->writing || diskpair->reading[0] || diskpair->reading[1])
    8000b4f6:	b77d                	j	8000b4a4 <raid0_1repair+0xa2>
    {
        uchar data[BSIZE];
        read_block(pair->pdiskn, i, data);
    8000b4f8:	fc043783          	ld	a5,-64(s0)
    8000b4fc:	0197c783          	lbu	a5,25(a5)
    8000b500:	0007871b          	sext.w	a4,a5
    8000b504:	77fd                	lui	a5,0xfffff
    8000b506:	7e078793          	addi	a5,a5,2016 # fffffffffffff7e0 <end+0xffffffff7ffd4ad0>
    8000b50a:	1781                	addi	a5,a5,-32
    8000b50c:	008786b3          	add	a3,a5,s0
    8000b510:	fdc42783          	lw	a5,-36(s0)
    8000b514:	8636                	mv	a2,a3
    8000b516:	85be                	mv	a1,a5
    8000b518:	853a                	mv	a0,a4
    8000b51a:	ffffe097          	auipc	ra,0xffffe
    8000b51e:	75a080e7          	jalr	1882(ra) # 80009c74 <read_block>
        write_block(raidmeta.diskinfo[diskn].pdiskn, i, data);
    8000b522:	0001f717          	auipc	a4,0x1f
    8000b526:	56e70713          	addi	a4,a4,1390 # 8002aa90 <raidmeta>
    8000b52a:	77fd                	lui	a5,0xfffff
    8000b52c:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000b52e:	97a2                	add	a5,a5,s0
    8000b530:	7dc7a783          	lw	a5,2012(a5)
    8000b534:	0796                	slli	a5,a5,0x5
    8000b536:	97ba                	add	a5,a5,a4
    8000b538:	1997c783          	lbu	a5,409(a5)
    8000b53c:	0007871b          	sext.w	a4,a5
    8000b540:	77fd                	lui	a5,0xfffff
    8000b542:	7e078793          	addi	a5,a5,2016 # fffffffffffff7e0 <end+0xffffffff7ffd4ad0>
    8000b546:	1781                	addi	a5,a5,-32
    8000b548:	008786b3          	add	a3,a5,s0
    8000b54c:	fdc42783          	lw	a5,-36(s0)
    8000b550:	8636                	mv	a2,a3
    8000b552:	85be                	mv	a1,a5
    8000b554:	853a                	mv	a0,a4
    8000b556:	ffffe097          	auipc	ra,0xffffe
    8000b55a:	64a080e7          	jalr	1610(ra) # 80009ba0 <write_block>
    for (int i = 0; i <= diskblockn(); i++)
    8000b55e:	fdc42783          	lw	a5,-36(s0)
    8000b562:	2785                	addiw	a5,a5,1
    8000b564:	fcf42e23          	sw	a5,-36(s0)
    8000b568:	fffff097          	auipc	ra,0xfffff
    8000b56c:	96a080e7          	jalr	-1686(ra) # 80009ed2 <diskblockn>
    8000b570:	87aa                	mv	a5,a0
    8000b572:	0007871b          	sext.w	a4,a5
    8000b576:	fdc42783          	lw	a5,-36(s0)
    8000b57a:	f6f77fe3          	bgeu	a4,a5,8000b4f8 <raid0_1repair+0xf6>
    }

    raidmeta.diskinfo[diskn].valid = 1;
    8000b57e:	0001f717          	auipc	a4,0x1f
    8000b582:	51270713          	addi	a4,a4,1298 # 8002aa90 <raidmeta>
    8000b586:	77fd                	lui	a5,0xfffff
    8000b588:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <end+0xffffffff7ffd42d0>
    8000b58a:	97a2                	add	a5,a5,s0
    8000b58c:	7dc7a783          	lw	a5,2012(a5)
    8000b590:	0796                	slli	a5,a5,0x5
    8000b592:	97ba                	add	a5,a5,a4
    8000b594:	4705                	li	a4,1
    8000b596:	18e78c23          	sb	a4,408(a5)
    acquire(&diskpair->mutex);
    8000b59a:	fc843783          	ld	a5,-56(s0)
    8000b59e:	853e                	mv	a0,a5
    8000b5a0:	ffff6097          	auipc	ra,0xffff6
    8000b5a4:	d90080e7          	jalr	-624(ra) # 80001330 <acquire>
    diskpair->writing = 0;
    8000b5a8:	fc843783          	ld	a5,-56(s0)
    8000b5ac:	02078423          	sb	zero,40(a5)
    release(&diskpair->mutex);
    8000b5b0:	fc843783          	ld	a5,-56(s0)
    8000b5b4:	853e                	mv	a0,a5
    8000b5b6:	ffff6097          	auipc	ra,0xffff6
    8000b5ba:	dde080e7          	jalr	-546(ra) # 80001394 <release>
    wakeup(diskpair);
    8000b5be:	fc843503          	ld	a0,-56(s0)
    8000b5c2:	ffff8097          	auipc	ra,0xffff8
    8000b5c6:	182080e7          	jalr	386(ra) # 80003744 <wakeup>

    uchar data[BSIZE] = {0};
    8000b5ca:	bc040793          	addi	a5,s0,-1088
    8000b5ce:	40000713          	li	a4,1024
    8000b5d2:	863a                	mv	a2,a4
    8000b5d4:	4581                	li	a1,0
    8000b5d6:	853e                	mv	a0,a5
    8000b5d8:	ffff6097          	auipc	ra,0xffff6
    8000b5dc:	f2c080e7          	jalr	-212(ra) # 80001504 <memset>
    memmove(data, &raidmeta, sizeof(raidmeta));
    8000b5e0:	bc040793          	addi	a5,s0,-1088
    8000b5e4:	28000613          	li	a2,640
    8000b5e8:	0001f597          	auipc	a1,0x1f
    8000b5ec:	4a858593          	addi	a1,a1,1192 # 8002aa90 <raidmeta>
    8000b5f0:	853e                	mv	a0,a5
    8000b5f2:	ffff6097          	auipc	ra,0xffff6
    8000b5f6:	ff6080e7          	jalr	-10(ra) # 800015e8 <memmove>
    for (int i = 0; i < 1; i++)
    8000b5fa:	fc042c23          	sw	zero,-40(s0)
    8000b5fe:	a081                	j	8000b63e <raid0_1repair+0x23c>
        writediskpair(raiddata->diskpair + i, diskblockn(), data);
    8000b600:	fd043683          	ld	a3,-48(s0)
    8000b604:	fd842703          	lw	a4,-40(s0)
    8000b608:	87ba                	mv	a5,a4
    8000b60a:	0786                	slli	a5,a5,0x1
    8000b60c:	97ba                	add	a5,a5,a4
    8000b60e:	0792                	slli	a5,a5,0x4
    8000b610:	00f684b3          	add	s1,a3,a5
    8000b614:	fffff097          	auipc	ra,0xfffff
    8000b618:	8be080e7          	jalr	-1858(ra) # 80009ed2 <diskblockn>
    8000b61c:	87aa                	mv	a5,a0
    8000b61e:	2781                	sext.w	a5,a5
    8000b620:	2781                	sext.w	a5,a5
    8000b622:	bc040713          	addi	a4,s0,-1088
    8000b626:	863a                	mv	a2,a4
    8000b628:	85be                	mv	a1,a5
    8000b62a:	8526                	mv	a0,s1
    8000b62c:	fffff097          	auipc	ra,0xfffff
    8000b630:	dde080e7          	jalr	-546(ra) # 8000a40a <writediskpair>
    for (int i = 0; i < 1; i++)
    8000b634:	fd842783          	lw	a5,-40(s0)
    8000b638:	2785                	addiw	a5,a5,1
    8000b63a:	fcf42c23          	sw	a5,-40(s0)
    8000b63e:	fd842783          	lw	a5,-40(s0)
    8000b642:	2781                	sext.w	a5,a5
    8000b644:	faf05ee3          	blez	a5,8000b600 <raid0_1repair+0x1fe>

    return 0;
    8000b648:	4781                	li	a5,0
    8000b64a:	853e                	mv	a0,a5
    8000b64c:	7f010113          	addi	sp,sp,2032
    8000b650:	60e6                	ld	ra,88(sp)
    8000b652:	6446                	ld	s0,80(sp)
    8000b654:	64a6                	ld	s1,72(sp)
    8000b656:	6125                	addi	sp,sp,96
    8000b658:	8082                	ret

000000008000b65a <raid4blockn>:
int raid4read(int vblkn, uchar* data);
int raid4write(int vblkn, uchar* data);

uint
raid4blockn(void)
{
    8000b65a:	1141                	addi	sp,sp,-16
    8000b65c:	e406                	sd	ra,8(sp)
    8000b65e:	e022                	sd	s0,0(sp)
    8000b660:	0800                	addi	s0,sp,16
    return diskblockn() * (DISKS - 1);
    8000b662:	fffff097          	auipc	ra,0xfffff
    8000b666:	870080e7          	jalr	-1936(ra) # 80009ed2 <diskblockn>
    8000b66a:	87aa                	mv	a5,a0
    8000b66c:	2781                	sext.w	a5,a5
    8000b66e:	873e                	mv	a4,a5
    8000b670:	87ba                	mv	a5,a4
    8000b672:	0027979b          	slliw	a5,a5,0x2
    8000b676:	9fb9                	addw	a5,a5,a4
    8000b678:	2781                	sext.w	a5,a5
}
    8000b67a:	853e                	mv	a0,a5
    8000b67c:	60a2                	ld	ra,8(sp)
    8000b67e:	6402                	ld	s0,0(sp)
    8000b680:	0141                	addi	sp,sp,16
    8000b682:	8082                	ret

000000008000b684 <raid4init>:

int
raid4init(void)
{
    8000b684:	1101                	addi	sp,sp,-32
    8000b686:	ec06                	sd	ra,24(sp)
    8000b688:	e822                	sd	s0,16(sp)
    8000b68a:	1000                	addi	s0,sp,32
    if (!raidmeta.diskinfo[DISKS - 1].valid)
    8000b68c:	0001f797          	auipc	a5,0x1f
    8000b690:	40478793          	addi	a5,a5,1028 # 8002aa90 <raidmeta>
    8000b694:	2387c783          	lbu	a5,568(a5)
    8000b698:	e399                	bnez	a5,8000b69e <raid4init+0x1a>
      return -1;
    8000b69a:	57fd                	li	a5,-1
    8000b69c:	a8dd                	j	8000b792 <raid4init+0x10e>

    raidmeta.valid = 1;
    8000b69e:	0001f797          	auipc	a5,0x1f
    8000b6a2:	3f278793          	addi	a5,a5,1010 # 8002aa90 <raidmeta>
    8000b6a6:	4705                	li	a4,1
    8000b6a8:	00e780a3          	sb	a4,1(a5)
    raidmeta.type = RAID4;
    8000b6ac:	0001f797          	auipc	a5,0x1f
    8000b6b0:	3e478793          	addi	a5,a5,996 # 8002aa90 <raidmeta>
    8000b6b4:	470d                	li	a4,3
    8000b6b6:	c3d8                	sw	a4,4(a5)
    raidmeta.read = raid4read;
    8000b6b8:	0001f797          	auipc	a5,0x1f
    8000b6bc:	3d878793          	addi	a5,a5,984 # 8002aa90 <raidmeta>
    8000b6c0:	00000717          	auipc	a4,0x0
    8000b6c4:	53470713          	addi	a4,a4,1332 # 8000bbf4 <raid4read>
    8000b6c8:	26e7b023          	sd	a4,608(a5)
    raidmeta.write = raid4write;
    8000b6cc:	0001f797          	auipc	a5,0x1f
    8000b6d0:	3c478793          	addi	a5,a5,964 # 8002aa90 <raidmeta>
    8000b6d4:	00000717          	auipc	a4,0x0
    8000b6d8:	66e70713          	addi	a4,a4,1646 # 8000bd42 <raid4write>
    8000b6dc:	26e7b423          	sd	a4,616(a5)
    raidmeta.blockn = raid4blockn;
    8000b6e0:	0001f797          	auipc	a5,0x1f
    8000b6e4:	3b078793          	addi	a5,a5,944 # 8002aa90 <raidmeta>
    8000b6e8:	00000717          	auipc	a4,0x0
    8000b6ec:	f7270713          	addi	a4,a4,-142 # 8000b65a <raid4blockn>
    8000b6f0:	26e7b823          	sd	a4,624(a5)

    struct RAID4Data* raiddata = &raidmeta.data.raid4;
    8000b6f4:	0001f797          	auipc	a5,0x1f
    8000b6f8:	3c478793          	addi	a5,a5,964 # 8002aab8 <raidmeta+0x28>
    8000b6fc:	fef43023          	sd	a5,-32(s0)
    for (int i = 0; i < DISKS; i++)
    8000b700:	fe042623          	sw	zero,-20(s0)
    8000b704:	a80d                	j	8000b736 <raid4init+0xb2>
        initsleeplock(&raiddata->lock[i], "raid4lock");
    8000b706:	fec42703          	lw	a4,-20(s0)
    8000b70a:	87ba                	mv	a5,a4
    8000b70c:	0786                	slli	a5,a5,0x1
    8000b70e:	97ba                	add	a5,a5,a4
    8000b710:	0792                	slli	a5,a5,0x4
    8000b712:	fe043703          	ld	a4,-32(s0)
    8000b716:	97ba                	add	a5,a5,a4
    8000b718:	07a1                	addi	a5,a5,8
    8000b71a:	00002597          	auipc	a1,0x2
    8000b71e:	15658593          	addi	a1,a1,342 # 8000d870 <etext+0x870>
    8000b722:	853e                	mv	a0,a5
    8000b724:	ffffb097          	auipc	ra,0xffffb
    8000b728:	0c6080e7          	jalr	198(ra) # 800067ea <initsleeplock>
    for (int i = 0; i < DISKS; i++)
    8000b72c:	fec42783          	lw	a5,-20(s0)
    8000b730:	2785                	addiw	a5,a5,1
    8000b732:	fef42623          	sw	a5,-20(s0)
    8000b736:	fec42783          	lw	a5,-20(s0)
    8000b73a:	0007871b          	sext.w	a4,a5
    8000b73e:	4795                	li	a5,5
    8000b740:	fce7d3e3          	bge	a5,a4,8000b706 <raid4init+0x82>
    initsleeplock(&raiddata->grouplock, "raid4grouplock");
    8000b744:	fe043783          	ld	a5,-32(s0)
    8000b748:	12878793          	addi	a5,a5,296
    8000b74c:	00002597          	auipc	a1,0x2
    8000b750:	13458593          	addi	a1,a1,308 # 8000d880 <etext+0x880>
    8000b754:	853e                	mv	a0,a5
    8000b756:	ffffb097          	auipc	ra,0xffffb
    8000b75a:	094080e7          	jalr	148(ra) # 800067ea <initsleeplock>
//    for (int i = 0; i <= maxdirtygroup; i++)
//      raiddata->groupvalid[i] = 0;
//    for (int i = maxdirtygroup + 1; i < NELEM(raiddata->groupvalid); i++)
//      raiddata->groupvalid[i] = 1;

    for (int i = 0; i < NELEM(raiddata->groupvalid); i++)
    8000b75e:	fe042423          	sw	zero,-24(s0)
    8000b762:	a829                	j	8000b77c <raid4init+0xf8>
      raiddata->groupvalid[i] = 0;
    8000b764:	fe043703          	ld	a4,-32(s0)
    8000b768:	fe842783          	lw	a5,-24(s0)
    8000b76c:	97ba                	add	a5,a5,a4
    8000b76e:	00078023          	sb	zero,0(a5)
    for (int i = 0; i < NELEM(raiddata->groupvalid); i++)
    8000b772:	fe842783          	lw	a5,-24(s0)
    8000b776:	2785                	addiw	a5,a5,1
    8000b778:	fef42423          	sw	a5,-24(s0)
    8000b77c:	fe842783          	lw	a5,-24(s0)
    8000b780:	873e                	mv	a4,a5
    8000b782:	478d                	li	a5,3
    8000b784:	fee7f0e3          	bgeu	a5,a4,8000b764 <raid4init+0xe0>

    writeraidmeta();
    8000b788:	ffffe097          	auipc	ra,0xffffe
    8000b78c:	792080e7          	jalr	1938(ra) # 80009f1a <writeraidmeta>
    return 0;
    8000b790:	4781                	li	a5,0
}
    8000b792:	853e                	mv	a0,a5
    8000b794:	60e2                	ld	ra,24(sp)
    8000b796:	6442                	ld	s0,16(sp)
    8000b798:	6105                	addi	sp,sp,32
    8000b79a:	8082                	ret

000000008000b79c <initgroup>:
// group lock must be held when calling
int
initgroup(int grpn)
{
    8000b79c:	7159                	addi	sp,sp,-112
    8000b79e:	f486                	sd	ra,104(sp)
    8000b7a0:	f0a2                	sd	s0,96(sp)
    8000b7a2:	1880                	addi	s0,sp,112
    8000b7a4:	87aa                	mv	a5,a0
    8000b7a6:	f8f42e23          	sw	a5,-100(s0)
    if (!raidmeta.diskinfo[DISKS - 1].valid)
    8000b7aa:	0001f797          	auipc	a5,0x1f
    8000b7ae:	2e678793          	addi	a5,a5,742 # 8002aa90 <raidmeta>
    8000b7b2:	2387c783          	lbu	a5,568(a5)
    8000b7b6:	e399                	bnez	a5,8000b7bc <initgroup+0x20>
        return -1;
    8000b7b8:	57fd                	li	a5,-1
    8000b7ba:	ac3d                	j	8000b9f8 <initgroup+0x25c>

    uchar* newpg = (uchar*)kalloc();
    8000b7bc:	ffff6097          	auipc	ra,0xffff6
    8000b7c0:	a20080e7          	jalr	-1504(ra) # 800011dc <kalloc>
    8000b7c4:	fca43823          	sd	a0,-48(s0)
    uchar* buff = newpg;
    8000b7c8:	fd043783          	ld	a5,-48(s0)
    8000b7cc:	fcf43423          	sd	a5,-56(s0)
    uchar* parity = newpg + BSIZE;
    8000b7d0:	fd043783          	ld	a5,-48(s0)
    8000b7d4:	40078793          	addi	a5,a5,1024
    8000b7d8:	fcf43023          	sd	a5,-64(s0)

    struct RAID4Data* raiddata = &raidmeta.data.raid4;
    8000b7dc:	0001f797          	auipc	a5,0x1f
    8000b7e0:	2dc78793          	addi	a5,a5,732 # 8002aab8 <raidmeta+0x28>
    8000b7e4:	faf43c23          	sd	a5,-72(s0)
    for (int i = 0; i < DISKS; i++)
    8000b7e8:	fe042623          	sw	zero,-20(s0)
    8000b7ec:	a02d                	j	8000b816 <initgroup+0x7a>
      acquiresleep(&raiddata->lock[i]);
    8000b7ee:	fec42703          	lw	a4,-20(s0)
    8000b7f2:	87ba                	mv	a5,a4
    8000b7f4:	0786                	slli	a5,a5,0x1
    8000b7f6:	97ba                	add	a5,a5,a4
    8000b7f8:	0792                	slli	a5,a5,0x4
    8000b7fa:	fb843703          	ld	a4,-72(s0)
    8000b7fe:	97ba                	add	a5,a5,a4
    8000b800:	07a1                	addi	a5,a5,8
    8000b802:	853e                	mv	a0,a5
    8000b804:	ffffb097          	auipc	ra,0xffffb
    8000b808:	032080e7          	jalr	50(ra) # 80006836 <acquiresleep>
    for (int i = 0; i < DISKS; i++)
    8000b80c:	fec42783          	lw	a5,-20(s0)
    8000b810:	2785                	addiw	a5,a5,1
    8000b812:	fef42623          	sw	a5,-20(s0)
    8000b816:	fec42783          	lw	a5,-20(s0)
    8000b81a:	0007871b          	sext.w	a4,a5
    8000b81e:	4795                	li	a5,5
    8000b820:	fce7d7e3          	bge	a5,a4,8000b7ee <initgroup+0x52>

    uint start = grpn * GRPSIZE;
    8000b824:	f9c42783          	lw	a5,-100(s0)
    8000b828:	0077979b          	slliw	a5,a5,0x7
    8000b82c:	2781                	sext.w	a5,a5
    8000b82e:	faf42a23          	sw	a5,-76(s0)
    for (uint blockn = start; blockn < start + GRPSIZE; blockn++)
    8000b832:	fb442783          	lw	a5,-76(s0)
    8000b836:	fef42423          	sw	a5,-24(s0)
    8000b83a:	a201                	j	8000b93a <initgroup+0x19e>
    {
      for (int i = 0; i < BSIZE; i++)
    8000b83c:	fe042223          	sw	zero,-28(s0)
    8000b840:	a829                	j	8000b85a <initgroup+0xbe>
        parity[i] = 0;
    8000b842:	fe442783          	lw	a5,-28(s0)
    8000b846:	fc043703          	ld	a4,-64(s0)
    8000b84a:	97ba                	add	a5,a5,a4
    8000b84c:	00078023          	sb	zero,0(a5)
      for (int i = 0; i < BSIZE; i++)
    8000b850:	fe442783          	lw	a5,-28(s0)
    8000b854:	2785                	addiw	a5,a5,1
    8000b856:	fef42223          	sw	a5,-28(s0)
    8000b85a:	fe442783          	lw	a5,-28(s0)
    8000b85e:	0007871b          	sext.w	a4,a5
    8000b862:	3ff00793          	li	a5,1023
    8000b866:	fce7dee3          	bge	a5,a4,8000b842 <initgroup+0xa6>

      struct DiskInfo* diskinfo = raidmeta.diskinfo;
    8000b86a:	0001f797          	auipc	a5,0x1f
    8000b86e:	3a678793          	addi	a5,a5,934 # 8002ac10 <raidmeta+0x180>
    8000b872:	faf43423          	sd	a5,-88(s0)

      for (int diskn = 0; diskn < DISKS - 1; diskn++)
    8000b876:	fe042023          	sw	zero,-32(s0)
    8000b87a:	a851                	j	8000b90e <initgroup+0x172>
        if (diskinfo[diskn].valid)
    8000b87c:	fe042783          	lw	a5,-32(s0)
    8000b880:	0796                	slli	a5,a5,0x5
    8000b882:	fa843703          	ld	a4,-88(s0)
    8000b886:	97ba                	add	a5,a5,a4
    8000b888:	0187c783          	lbu	a5,24(a5)
    8000b88c:	cfa5                	beqz	a5,8000b904 <initgroup+0x168>
        {
            read_block(diskinfo[diskn].pdiskn, blockn, buff);
    8000b88e:	fe042783          	lw	a5,-32(s0)
    8000b892:	0796                	slli	a5,a5,0x5
    8000b894:	fa843703          	ld	a4,-88(s0)
    8000b898:	97ba                	add	a5,a5,a4
    8000b89a:	0197c783          	lbu	a5,25(a5)
    8000b89e:	2781                	sext.w	a5,a5
    8000b8a0:	fe842703          	lw	a4,-24(s0)
    8000b8a4:	fc843603          	ld	a2,-56(s0)
    8000b8a8:	85ba                	mv	a1,a4
    8000b8aa:	853e                	mv	a0,a5
    8000b8ac:	ffffe097          	auipc	ra,0xffffe
    8000b8b0:	3c8080e7          	jalr	968(ra) # 80009c74 <read_block>
            for (int i = 0; i < BSIZE; i++)
    8000b8b4:	fc042e23          	sw	zero,-36(s0)
    8000b8b8:	a835                	j	8000b8f4 <initgroup+0x158>
              parity[i] ^= buff[i];
    8000b8ba:	fdc42783          	lw	a5,-36(s0)
    8000b8be:	fc043703          	ld	a4,-64(s0)
    8000b8c2:	97ba                	add	a5,a5,a4
    8000b8c4:	0007c683          	lbu	a3,0(a5)
    8000b8c8:	fdc42783          	lw	a5,-36(s0)
    8000b8cc:	fc843703          	ld	a4,-56(s0)
    8000b8d0:	97ba                	add	a5,a5,a4
    8000b8d2:	0007c703          	lbu	a4,0(a5)
    8000b8d6:	fdc42783          	lw	a5,-36(s0)
    8000b8da:	fc043603          	ld	a2,-64(s0)
    8000b8de:	97b2                	add	a5,a5,a2
    8000b8e0:	8f35                	xor	a4,a4,a3
    8000b8e2:	0ff77713          	zext.b	a4,a4
    8000b8e6:	00e78023          	sb	a4,0(a5)
            for (int i = 0; i < BSIZE; i++)
    8000b8ea:	fdc42783          	lw	a5,-36(s0)
    8000b8ee:	2785                	addiw	a5,a5,1
    8000b8f0:	fcf42e23          	sw	a5,-36(s0)
    8000b8f4:	fdc42783          	lw	a5,-36(s0)
    8000b8f8:	0007871b          	sext.w	a4,a5
    8000b8fc:	3ff00793          	li	a5,1023
    8000b900:	fae7dde3          	bge	a5,a4,8000b8ba <initgroup+0x11e>
      for (int diskn = 0; diskn < DISKS - 1; diskn++)
    8000b904:	fe042783          	lw	a5,-32(s0)
    8000b908:	2785                	addiw	a5,a5,1
    8000b90a:	fef42023          	sw	a5,-32(s0)
    8000b90e:	fe042783          	lw	a5,-32(s0)
    8000b912:	0007871b          	sext.w	a4,a5
    8000b916:	4791                	li	a5,4
    8000b918:	f6e7d2e3          	bge	a5,a4,8000b87c <initgroup+0xe0>
        }

      write_block(DISKS, blockn, parity);
    8000b91c:	fe842783          	lw	a5,-24(s0)
    8000b920:	fc043603          	ld	a2,-64(s0)
    8000b924:	85be                	mv	a1,a5
    8000b926:	4519                	li	a0,6
    8000b928:	ffffe097          	auipc	ra,0xffffe
    8000b92c:	278080e7          	jalr	632(ra) # 80009ba0 <write_block>
    for (uint blockn = start; blockn < start + GRPSIZE; blockn++)
    8000b930:	fe842783          	lw	a5,-24(s0)
    8000b934:	2785                	addiw	a5,a5,1
    8000b936:	fef42423          	sw	a5,-24(s0)
    8000b93a:	fb442783          	lw	a5,-76(s0)
    8000b93e:	0807879b          	addiw	a5,a5,128
    8000b942:	0007871b          	sext.w	a4,a5
    8000b946:	fe842783          	lw	a5,-24(s0)
    8000b94a:	2781                	sext.w	a5,a5
    8000b94c:	eee7e8e3          	bltu	a5,a4,8000b83c <initgroup+0xa0>
    }

    raiddata->groupvalid[grpn / 8] |= 1 << (grpn % 8);
    8000b950:	f9c42783          	lw	a5,-100(s0)
    8000b954:	41f7d71b          	sraiw	a4,a5,0x1f
    8000b958:	01d7571b          	srliw	a4,a4,0x1d
    8000b95c:	9fb9                	addw	a5,a5,a4
    8000b95e:	4037d79b          	sraiw	a5,a5,0x3
    8000b962:	2781                	sext.w	a5,a5
    8000b964:	fb843703          	ld	a4,-72(s0)
    8000b968:	973e                	add	a4,a4,a5
    8000b96a:	00074703          	lbu	a4,0(a4)
    8000b96e:	0187169b          	slliw	a3,a4,0x18
    8000b972:	4186d69b          	sraiw	a3,a3,0x18
    8000b976:	f9c42703          	lw	a4,-100(s0)
    8000b97a:	8b1d                	andi	a4,a4,7
    8000b97c:	2701                	sext.w	a4,a4
    8000b97e:	4605                	li	a2,1
    8000b980:	00e6173b          	sllw	a4,a2,a4
    8000b984:	2701                	sext.w	a4,a4
    8000b986:	0187171b          	slliw	a4,a4,0x18
    8000b98a:	4187571b          	sraiw	a4,a4,0x18
    8000b98e:	8f55                	or	a4,a4,a3
    8000b990:	0187171b          	slliw	a4,a4,0x18
    8000b994:	4187571b          	sraiw	a4,a4,0x18
    8000b998:	0ff77713          	zext.b	a4,a4
    8000b99c:	fb843683          	ld	a3,-72(s0)
    8000b9a0:	97b6                	add	a5,a5,a3
    8000b9a2:	00e78023          	sb	a4,0(a5)

    writeraidmeta();
    8000b9a6:	ffffe097          	auipc	ra,0xffffe
    8000b9aa:	574080e7          	jalr	1396(ra) # 80009f1a <writeraidmeta>

    for (int i = 0; i < DISKS; i++)
    8000b9ae:	fc042c23          	sw	zero,-40(s0)
    8000b9b2:	a02d                	j	8000b9dc <initgroup+0x240>
      releasesleep(&raiddata->lock[i]);
    8000b9b4:	fd842703          	lw	a4,-40(s0)
    8000b9b8:	87ba                	mv	a5,a4
    8000b9ba:	0786                	slli	a5,a5,0x1
    8000b9bc:	97ba                	add	a5,a5,a4
    8000b9be:	0792                	slli	a5,a5,0x4
    8000b9c0:	fb843703          	ld	a4,-72(s0)
    8000b9c4:	97ba                	add	a5,a5,a4
    8000b9c6:	07a1                	addi	a5,a5,8
    8000b9c8:	853e                	mv	a0,a5
    8000b9ca:	ffffb097          	auipc	ra,0xffffb
    8000b9ce:	eda080e7          	jalr	-294(ra) # 800068a4 <releasesleep>
    for (int i = 0; i < DISKS; i++)
    8000b9d2:	fd842783          	lw	a5,-40(s0)
    8000b9d6:	2785                	addiw	a5,a5,1
    8000b9d8:	fcf42c23          	sw	a5,-40(s0)
    8000b9dc:	fd842783          	lw	a5,-40(s0)
    8000b9e0:	0007871b          	sext.w	a4,a5
    8000b9e4:	4795                	li	a5,5
    8000b9e6:	fce7d7e3          	bge	a5,a4,8000b9b4 <initgroup+0x218>

    kfree(newpg);
    8000b9ea:	fd043503          	ld	a0,-48(s0)
    8000b9ee:	ffff5097          	auipc	ra,0xffff5
    8000b9f2:	748080e7          	jalr	1864(ra) # 80001136 <kfree>
    return 0;
    8000b9f6:	4781                	li	a5,0
}
    8000b9f8:	853e                	mv	a0,a5
    8000b9fa:	70a6                	ld	ra,104(sp)
    8000b9fc:	7406                	ld	s0,96(sp)
    8000b9fe:	6165                	addi	sp,sp,112
    8000ba00:	8082                	ret

000000008000ba02 <readinvalid>:

int
readinvalid(int diskn, int blockn, uchar* data)
{
    8000ba02:	711d                	addi	sp,sp,-96
    8000ba04:	ec86                	sd	ra,88(sp)
    8000ba06:	e8a2                	sd	s0,80(sp)
    8000ba08:	1080                	addi	s0,sp,96
    8000ba0a:	87aa                	mv	a5,a0
    8000ba0c:	872e                	mv	a4,a1
    8000ba0e:	fac43023          	sd	a2,-96(s0)
    8000ba12:	faf42623          	sw	a5,-84(s0)
    8000ba16:	87ba                	mv	a5,a4
    8000ba18:	faf42423          	sw	a5,-88(s0)
  uchar* newpg = (uchar*)kalloc();
    8000ba1c:	ffff5097          	auipc	ra,0xffff5
    8000ba20:	7c0080e7          	jalr	1984(ra) # 800011dc <kalloc>
    8000ba24:	fca43823          	sd	a0,-48(s0)
  uchar* buff = newpg;
    8000ba28:	fd043783          	ld	a5,-48(s0)
    8000ba2c:	fcf43423          	sd	a5,-56(s0)
  uchar* parity = newpg + BSIZE;
    8000ba30:	fd043783          	ld	a5,-48(s0)
    8000ba34:	40078793          	addi	a5,a5,1024
    8000ba38:	fcf43023          	sd	a5,-64(s0)

  for (int i = 0; i < BSIZE; i++)
    8000ba3c:	fe042623          	sw	zero,-20(s0)
    8000ba40:	a829                	j	8000ba5a <readinvalid+0x58>
    parity[i] = 0;
    8000ba42:	fec42783          	lw	a5,-20(s0)
    8000ba46:	fc043703          	ld	a4,-64(s0)
    8000ba4a:	97ba                	add	a5,a5,a4
    8000ba4c:	00078023          	sb	zero,0(a5)
  for (int i = 0; i < BSIZE; i++)
    8000ba50:	fec42783          	lw	a5,-20(s0)
    8000ba54:	2785                	addiw	a5,a5,1
    8000ba56:	fef42623          	sw	a5,-20(s0)
    8000ba5a:	fec42783          	lw	a5,-20(s0)
    8000ba5e:	0007871b          	sext.w	a4,a5
    8000ba62:	3ff00793          	li	a5,1023
    8000ba66:	fce7dee3          	bge	a5,a4,8000ba42 <readinvalid+0x40>


  struct RAID4Data* raiddata = &raidmeta.data.raid4;
    8000ba6a:	0001f797          	auipc	a5,0x1f
    8000ba6e:	04e78793          	addi	a5,a5,78 # 8002aab8 <raidmeta+0x28>
    8000ba72:	faf43c23          	sd	a5,-72(s0)
  for (int i = 0; i < DISKS; i++)
    8000ba76:	fe042423          	sw	zero,-24(s0)
    8000ba7a:	a02d                	j	8000baa4 <readinvalid+0xa2>
    acquiresleep(&raiddata->lock[i]);
    8000ba7c:	fe842703          	lw	a4,-24(s0)
    8000ba80:	87ba                	mv	a5,a4
    8000ba82:	0786                	slli	a5,a5,0x1
    8000ba84:	97ba                	add	a5,a5,a4
    8000ba86:	0792                	slli	a5,a5,0x4
    8000ba88:	fb843703          	ld	a4,-72(s0)
    8000ba8c:	97ba                	add	a5,a5,a4
    8000ba8e:	07a1                	addi	a5,a5,8
    8000ba90:	853e                	mv	a0,a5
    8000ba92:	ffffb097          	auipc	ra,0xffffb
    8000ba96:	da4080e7          	jalr	-604(ra) # 80006836 <acquiresleep>
  for (int i = 0; i < DISKS; i++)
    8000ba9a:	fe842783          	lw	a5,-24(s0)
    8000ba9e:	2785                	addiw	a5,a5,1
    8000baa0:	fef42423          	sw	a5,-24(s0)
    8000baa4:	fe842783          	lw	a5,-24(s0)
    8000baa8:	0007871b          	sext.w	a4,a5
    8000baac:	4795                	li	a5,5
    8000baae:	fce7d7e3          	bge	a5,a4,8000ba7c <readinvalid+0x7a>

  struct DiskInfo* diskinfo = raidmeta.diskinfo;
    8000bab2:	0001f797          	auipc	a5,0x1f
    8000bab6:	15e78793          	addi	a5,a5,350 # 8002ac10 <raidmeta+0x180>
    8000baba:	faf43823          	sd	a5,-80(s0)
  for (int i = 0; i < DISKS; i++)
    8000babe:	fe042223          	sw	zero,-28(s0)
    8000bac2:	a851                	j	8000bb56 <readinvalid+0x154>
    if (i != diskn)
    8000bac4:	fe442783          	lw	a5,-28(s0)
    8000bac8:	873e                	mv	a4,a5
    8000baca:	fac42783          	lw	a5,-84(s0)
    8000bace:	2701                	sext.w	a4,a4
    8000bad0:	2781                	sext.w	a5,a5
    8000bad2:	06f70d63          	beq	a4,a5,8000bb4c <readinvalid+0x14a>
    {
      read_block(diskinfo[i].pdiskn, blockn, buff);
    8000bad6:	fe442783          	lw	a5,-28(s0)
    8000bada:	0796                	slli	a5,a5,0x5
    8000badc:	fb043703          	ld	a4,-80(s0)
    8000bae0:	97ba                	add	a5,a5,a4
    8000bae2:	0197c783          	lbu	a5,25(a5)
    8000bae6:	2781                	sext.w	a5,a5
    8000bae8:	fa842703          	lw	a4,-88(s0)
    8000baec:	fc843603          	ld	a2,-56(s0)
    8000baf0:	85ba                	mv	a1,a4
    8000baf2:	853e                	mv	a0,a5
    8000baf4:	ffffe097          	auipc	ra,0xffffe
    8000baf8:	180080e7          	jalr	384(ra) # 80009c74 <read_block>
      for (int j = 0; j < BSIZE; j++)
    8000bafc:	fe042023          	sw	zero,-32(s0)
    8000bb00:	a835                	j	8000bb3c <readinvalid+0x13a>
        parity[j] ^= buff[j];
    8000bb02:	fe042783          	lw	a5,-32(s0)
    8000bb06:	fc043703          	ld	a4,-64(s0)
    8000bb0a:	97ba                	add	a5,a5,a4
    8000bb0c:	0007c683          	lbu	a3,0(a5)
    8000bb10:	fe042783          	lw	a5,-32(s0)
    8000bb14:	fc843703          	ld	a4,-56(s0)
    8000bb18:	97ba                	add	a5,a5,a4
    8000bb1a:	0007c703          	lbu	a4,0(a5)
    8000bb1e:	fe042783          	lw	a5,-32(s0)
    8000bb22:	fc043603          	ld	a2,-64(s0)
    8000bb26:	97b2                	add	a5,a5,a2
    8000bb28:	8f35                	xor	a4,a4,a3
    8000bb2a:	0ff77713          	zext.b	a4,a4
    8000bb2e:	00e78023          	sb	a4,0(a5)
      for (int j = 0; j < BSIZE; j++)
    8000bb32:	fe042783          	lw	a5,-32(s0)
    8000bb36:	2785                	addiw	a5,a5,1
    8000bb38:	fef42023          	sw	a5,-32(s0)
    8000bb3c:	fe042783          	lw	a5,-32(s0)
    8000bb40:	0007871b          	sext.w	a4,a5
    8000bb44:	3ff00793          	li	a5,1023
    8000bb48:	fae7dde3          	bge	a5,a4,8000bb02 <readinvalid+0x100>
  for (int i = 0; i < DISKS; i++)
    8000bb4c:	fe442783          	lw	a5,-28(s0)
    8000bb50:	2785                	addiw	a5,a5,1
    8000bb52:	fef42223          	sw	a5,-28(s0)
    8000bb56:	fe442783          	lw	a5,-28(s0)
    8000bb5a:	0007871b          	sext.w	a4,a5
    8000bb5e:	4795                	li	a5,5
    8000bb60:	f6e7d2e3          	bge	a5,a4,8000bac4 <readinvalid+0xc2>
    }

  for (int i = 0; i < DISKS; i++)
    8000bb64:	fc042e23          	sw	zero,-36(s0)
    8000bb68:	a02d                	j	8000bb92 <readinvalid+0x190>
    releasesleep(&raiddata->lock[i]);
    8000bb6a:	fdc42703          	lw	a4,-36(s0)
    8000bb6e:	87ba                	mv	a5,a4
    8000bb70:	0786                	slli	a5,a5,0x1
    8000bb72:	97ba                	add	a5,a5,a4
    8000bb74:	0792                	slli	a5,a5,0x4
    8000bb76:	fb843703          	ld	a4,-72(s0)
    8000bb7a:	97ba                	add	a5,a5,a4
    8000bb7c:	07a1                	addi	a5,a5,8
    8000bb7e:	853e                	mv	a0,a5
    8000bb80:	ffffb097          	auipc	ra,0xffffb
    8000bb84:	d24080e7          	jalr	-732(ra) # 800068a4 <releasesleep>
  for (int i = 0; i < DISKS; i++)
    8000bb88:	fdc42783          	lw	a5,-36(s0)
    8000bb8c:	2785                	addiw	a5,a5,1
    8000bb8e:	fcf42e23          	sw	a5,-36(s0)
    8000bb92:	fdc42783          	lw	a5,-36(s0)
    8000bb96:	0007871b          	sext.w	a4,a5
    8000bb9a:	4795                	li	a5,5
    8000bb9c:	fce7d7e3          	bge	a5,a4,8000bb6a <readinvalid+0x168>

  for (int i = 0; i < BSIZE; i++)
    8000bba0:	fc042c23          	sw	zero,-40(s0)
    8000bba4:	a025                	j	8000bbcc <readinvalid+0x1ca>
    data[i] = parity[i];
    8000bba6:	fd842783          	lw	a5,-40(s0)
    8000bbaa:	fc043703          	ld	a4,-64(s0)
    8000bbae:	973e                	add	a4,a4,a5
    8000bbb0:	fd842783          	lw	a5,-40(s0)
    8000bbb4:	fa043683          	ld	a3,-96(s0)
    8000bbb8:	97b6                	add	a5,a5,a3
    8000bbba:	00074703          	lbu	a4,0(a4)
    8000bbbe:	00e78023          	sb	a4,0(a5)
  for (int i = 0; i < BSIZE; i++)
    8000bbc2:	fd842783          	lw	a5,-40(s0)
    8000bbc6:	2785                	addiw	a5,a5,1
    8000bbc8:	fcf42c23          	sw	a5,-40(s0)
    8000bbcc:	fd842783          	lw	a5,-40(s0)
    8000bbd0:	0007871b          	sext.w	a4,a5
    8000bbd4:	3ff00793          	li	a5,1023
    8000bbd8:	fce7d7e3          	bge	a5,a4,8000bba6 <readinvalid+0x1a4>

  kfree(newpg);
    8000bbdc:	fd043503          	ld	a0,-48(s0)
    8000bbe0:	ffff5097          	auipc	ra,0xffff5
    8000bbe4:	556080e7          	jalr	1366(ra) # 80001136 <kfree>
  return 0;
    8000bbe8:	4781                	li	a5,0
}
    8000bbea:	853e                	mv	a0,a5
    8000bbec:	60e6                	ld	ra,88(sp)
    8000bbee:	6446                	ld	s0,80(sp)
    8000bbf0:	6125                	addi	sp,sp,96
    8000bbf2:	8082                	ret

000000008000bbf4 <raid4read>:

int
raid4read(int vblkn, uchar* data)
{
    8000bbf4:	7139                	addi	sp,sp,-64
    8000bbf6:	fc06                	sd	ra,56(sp)
    8000bbf8:	f822                	sd	s0,48(sp)
    8000bbfa:	0080                	addi	s0,sp,64
    8000bbfc:	87aa                	mv	a5,a0
    8000bbfe:	fcb43023          	sd	a1,-64(s0)
    8000bc02:	fcf42623          	sw	a5,-52(s0)
    if (raidmeta.type != RAID4)
    8000bc06:	0001f797          	auipc	a5,0x1f
    8000bc0a:	e8a78793          	addi	a5,a5,-374 # 8002aa90 <raidmeta>
    8000bc0e:	43dc                	lw	a5,4(a5)
    8000bc10:	873e                	mv	a4,a5
    8000bc12:	478d                	li	a5,3
    8000bc14:	00f70a63          	beq	a4,a5,8000bc28 <raid4read+0x34>
      panic("raid4read");
    8000bc18:	00002517          	auipc	a0,0x2
    8000bc1c:	c7850513          	addi	a0,a0,-904 # 8000d890 <etext+0x890>
    8000bc20:	ffff5097          	auipc	ra,0xffff5
    8000bc24:	068080e7          	jalr	104(ra) # 80000c88 <panic>

    uint diskn = vblkn % (DISKS - 1);
    8000bc28:	fcc42783          	lw	a5,-52(s0)
    8000bc2c:	873e                	mv	a4,a5
    8000bc2e:	4795                	li	a5,5
    8000bc30:	02f767bb          	remw	a5,a4,a5
    8000bc34:	2781                	sext.w	a5,a5
    8000bc36:	fef42423          	sw	a5,-24(s0)
    uint pblkn = vblkn / (DISKS - 1);
    8000bc3a:	fcc42783          	lw	a5,-52(s0)
    8000bc3e:	873e                	mv	a4,a5
    8000bc40:	4795                	li	a5,5
    8000bc42:	02f747bb          	divw	a5,a4,a5
    8000bc46:	2781                	sext.w	a5,a5
    8000bc48:	fef42223          	sw	a5,-28(s0)

    struct RAID4Data* raiddata = &raidmeta.data.raid4;
    8000bc4c:	0001f797          	auipc	a5,0x1f
    8000bc50:	e6c78793          	addi	a5,a5,-404 # 8002aab8 <raidmeta+0x28>
    8000bc54:	fcf43c23          	sd	a5,-40(s0)
    struct DiskInfo* diskinfo = raidmeta.diskinfo;
    8000bc58:	0001f797          	auipc	a5,0x1f
    8000bc5c:	fb878793          	addi	a5,a5,-72 # 8002ac10 <raidmeta+0x180>
    8000bc60:	fcf43823          	sd	a5,-48(s0)
    if (!diskinfo[diskn].valid)
    8000bc64:	fe846783          	lwu	a5,-24(s0)
    8000bc68:	0796                	slli	a5,a5,0x5
    8000bc6a:	fd043703          	ld	a4,-48(s0)
    8000bc6e:	97ba                	add	a5,a5,a4
    8000bc70:	0187c783          	lbu	a5,24(a5)
    8000bc74:	e3a5                	bnez	a5,8000bcd4 <raid4read+0xe0>
    {
      for (int i = 0; i < DISKS; i++)
    8000bc76:	fe042623          	sw	zero,-20(s0)
    8000bc7a:	a805                	j	8000bcaa <raid4read+0xb6>
        if (i != diskn && !diskinfo[i].valid)
    8000bc7c:	fec42703          	lw	a4,-20(s0)
    8000bc80:	fe842783          	lw	a5,-24(s0)
    8000bc84:	2781                	sext.w	a5,a5
    8000bc86:	00e78d63          	beq	a5,a4,8000bca0 <raid4read+0xac>
    8000bc8a:	fec42783          	lw	a5,-20(s0)
    8000bc8e:	0796                	slli	a5,a5,0x5
    8000bc90:	fd043703          	ld	a4,-48(s0)
    8000bc94:	97ba                	add	a5,a5,a4
    8000bc96:	0187c783          	lbu	a5,24(a5)
    8000bc9a:	e399                	bnez	a5,8000bca0 <raid4read+0xac>
          return -1;
    8000bc9c:	57fd                	li	a5,-1
    8000bc9e:	a869                	j	8000bd38 <raid4read+0x144>
      for (int i = 0; i < DISKS; i++)
    8000bca0:	fec42783          	lw	a5,-20(s0)
    8000bca4:	2785                	addiw	a5,a5,1
    8000bca6:	fef42623          	sw	a5,-20(s0)
    8000bcaa:	fec42783          	lw	a5,-20(s0)
    8000bcae:	0007871b          	sext.w	a4,a5
    8000bcb2:	4795                	li	a5,5
    8000bcb4:	fce7d4e3          	bge	a5,a4,8000bc7c <raid4read+0x88>
      return readinvalid(diskn, pblkn, data);
    8000bcb8:	fe842783          	lw	a5,-24(s0)
    8000bcbc:	fe442703          	lw	a4,-28(s0)
    8000bcc0:	fc043603          	ld	a2,-64(s0)
    8000bcc4:	85ba                	mv	a1,a4
    8000bcc6:	853e                	mv	a0,a5
    8000bcc8:	00000097          	auipc	ra,0x0
    8000bccc:	d3a080e7          	jalr	-710(ra) # 8000ba02 <readinvalid>
    8000bcd0:	87aa                	mv	a5,a0
    8000bcd2:	a09d                	j	8000bd38 <raid4read+0x144>
    }

    acquiresleep(&raiddata->lock[diskn]);
    8000bcd4:	fe846703          	lwu	a4,-24(s0)
    8000bcd8:	87ba                	mv	a5,a4
    8000bcda:	0786                	slli	a5,a5,0x1
    8000bcdc:	97ba                	add	a5,a5,a4
    8000bcde:	0792                	slli	a5,a5,0x4
    8000bce0:	fd843703          	ld	a4,-40(s0)
    8000bce4:	97ba                	add	a5,a5,a4
    8000bce6:	07a1                	addi	a5,a5,8
    8000bce8:	853e                	mv	a0,a5
    8000bcea:	ffffb097          	auipc	ra,0xffffb
    8000bcee:	b4c080e7          	jalr	-1204(ra) # 80006836 <acquiresleep>
    read_block(diskinfo[diskn].pdiskn, pblkn, data);
    8000bcf2:	fe846783          	lwu	a5,-24(s0)
    8000bcf6:	0796                	slli	a5,a5,0x5
    8000bcf8:	fd043703          	ld	a4,-48(s0)
    8000bcfc:	97ba                	add	a5,a5,a4
    8000bcfe:	0197c783          	lbu	a5,25(a5)
    8000bd02:	2781                	sext.w	a5,a5
    8000bd04:	fe442703          	lw	a4,-28(s0)
    8000bd08:	fc043603          	ld	a2,-64(s0)
    8000bd0c:	85ba                	mv	a1,a4
    8000bd0e:	853e                	mv	a0,a5
    8000bd10:	ffffe097          	auipc	ra,0xffffe
    8000bd14:	f64080e7          	jalr	-156(ra) # 80009c74 <read_block>
    releasesleep(&raiddata->lock[diskn]);
    8000bd18:	fe846703          	lwu	a4,-24(s0)
    8000bd1c:	87ba                	mv	a5,a4
    8000bd1e:	0786                	slli	a5,a5,0x1
    8000bd20:	97ba                	add	a5,a5,a4
    8000bd22:	0792                	slli	a5,a5,0x4
    8000bd24:	fd843703          	ld	a4,-40(s0)
    8000bd28:	97ba                	add	a5,a5,a4
    8000bd2a:	07a1                	addi	a5,a5,8
    8000bd2c:	853e                	mv	a0,a5
    8000bd2e:	ffffb097          	auipc	ra,0xffffb
    8000bd32:	b76080e7          	jalr	-1162(ra) # 800068a4 <releasesleep>

    return 0;
    8000bd36:	4781                	li	a5,0
}
    8000bd38:	853e                	mv	a0,a5
    8000bd3a:	70e2                	ld	ra,56(sp)
    8000bd3c:	7442                	ld	s0,48(sp)
    8000bd3e:	6121                	addi	sp,sp,64
    8000bd40:	8082                	ret

000000008000bd42 <raid4write>:

int
raid4write(int vblkn, uchar* data)
{
    8000bd42:	711d                	addi	sp,sp,-96
    8000bd44:	ec86                	sd	ra,88(sp)
    8000bd46:	e8a2                	sd	s0,80(sp)
    8000bd48:	1080                	addi	s0,sp,96
    8000bd4a:	87aa                	mv	a5,a0
    8000bd4c:	fab43023          	sd	a1,-96(s0)
    8000bd50:	faf42623          	sw	a5,-84(s0)
    if (raidmeta.type != RAID4)
    8000bd54:	0001f797          	auipc	a5,0x1f
    8000bd58:	d3c78793          	addi	a5,a5,-708 # 8002aa90 <raidmeta>
    8000bd5c:	43dc                	lw	a5,4(a5)
    8000bd5e:	873e                	mv	a4,a5
    8000bd60:	478d                	li	a5,3
    8000bd62:	00f70a63          	beq	a4,a5,8000bd76 <raid4write+0x34>
      panic("raid4write");
    8000bd66:	00002517          	auipc	a0,0x2
    8000bd6a:	b3a50513          	addi	a0,a0,-1222 # 8000d8a0 <etext+0x8a0>
    8000bd6e:	ffff5097          	auipc	ra,0xffff5
    8000bd72:	f1a080e7          	jalr	-230(ra) # 80000c88 <panic>

    uint diskn = vblkn % (DISKS - 1);
    8000bd76:	fac42783          	lw	a5,-84(s0)
    8000bd7a:	873e                	mv	a4,a5
    8000bd7c:	4795                	li	a5,5
    8000bd7e:	02f767bb          	remw	a5,a4,a5
    8000bd82:	2781                	sext.w	a5,a5
    8000bd84:	fef42423          	sw	a5,-24(s0)
    uint pblkn = vblkn / (DISKS - 1);
    8000bd88:	fac42783          	lw	a5,-84(s0)
    8000bd8c:	873e                	mv	a4,a5
    8000bd8e:	4795                	li	a5,5
    8000bd90:	02f747bb          	divw	a5,a4,a5
    8000bd94:	2781                	sext.w	a5,a5
    8000bd96:	fef42223          	sw	a5,-28(s0)

    struct DiskInfo* diskinfo = raidmeta.diskinfo;
    8000bd9a:	0001f797          	auipc	a5,0x1f
    8000bd9e:	e7678793          	addi	a5,a5,-394 # 8002ac10 <raidmeta+0x180>
    8000bda2:	fcf43c23          	sd	a5,-40(s0)
    if (!diskinfo[diskn].valid || !diskinfo[DISKS - 1].valid)
    8000bda6:	fe846783          	lwu	a5,-24(s0)
    8000bdaa:	0796                	slli	a5,a5,0x5
    8000bdac:	fd843703          	ld	a4,-40(s0)
    8000bdb0:	97ba                	add	a5,a5,a4
    8000bdb2:	0187c783          	lbu	a5,24(a5)
    8000bdb6:	cb81                	beqz	a5,8000bdc6 <raid4write+0x84>
    8000bdb8:	fd843783          	ld	a5,-40(s0)
    8000bdbc:	0a078793          	addi	a5,a5,160
    8000bdc0:	0187c783          	lbu	a5,24(a5)
    8000bdc4:	e399                	bnez	a5,8000bdca <raid4write+0x88>
      return -1;
    8000bdc6:	57fd                	li	a5,-1
    8000bdc8:	aac5                	j	8000bfb8 <raid4write+0x276>

    struct RAID4Data* raiddata = &raidmeta.data.raid4;
    8000bdca:	0001f797          	auipc	a5,0x1f
    8000bdce:	cee78793          	addi	a5,a5,-786 # 8002aab8 <raidmeta+0x28>
    8000bdd2:	fcf43823          	sd	a5,-48(s0)
    int grpn = pblkn / GRPSIZE;
    8000bdd6:	fe442783          	lw	a5,-28(s0)
    8000bdda:	0077d79b          	srliw	a5,a5,0x7
    8000bdde:	2781                	sext.w	a5,a5
    8000bde0:	fcf42623          	sw	a5,-52(s0)
    int grpi = (grpn / 8);
    8000bde4:	fcc42783          	lw	a5,-52(s0)
    8000bde8:	41f7d71b          	sraiw	a4,a5,0x1f
    8000bdec:	01d7571b          	srliw	a4,a4,0x1d
    8000bdf0:	9fb9                	addw	a5,a5,a4
    8000bdf2:	4037d79b          	sraiw	a5,a5,0x3
    8000bdf6:	fcf42423          	sw	a5,-56(s0)

    acquiresleep(&raiddata->grouplock);
    8000bdfa:	fd043783          	ld	a5,-48(s0)
    8000bdfe:	12878793          	addi	a5,a5,296
    8000be02:	853e                	mv	a0,a5
    8000be04:	ffffb097          	auipc	ra,0xffffb
    8000be08:	a32080e7          	jalr	-1486(ra) # 80006836 <acquiresleep>
    if (!(raiddata->groupvalid[grpi] & (1 << grpn % 8)))
    8000be0c:	fd043703          	ld	a4,-48(s0)
    8000be10:	fc842783          	lw	a5,-56(s0)
    8000be14:	97ba                	add	a5,a5,a4
    8000be16:	0007c783          	lbu	a5,0(a5)
    8000be1a:	0007871b          	sext.w	a4,a5
    8000be1e:	fcc42783          	lw	a5,-52(s0)
    8000be22:	8b9d                	andi	a5,a5,7
    8000be24:	2781                	sext.w	a5,a5
    8000be26:	40f757bb          	sraw	a5,a4,a5
    8000be2a:	2781                	sext.w	a5,a5
    8000be2c:	8b85                	andi	a5,a5,1
    8000be2e:	2781                	sext.w	a5,a5
    8000be30:	eb81                	bnez	a5,8000be40 <raid4write+0xfe>
      initgroup(grpn);
    8000be32:	fcc42783          	lw	a5,-52(s0)
    8000be36:	853e                	mv	a0,a5
    8000be38:	00000097          	auipc	ra,0x0
    8000be3c:	964080e7          	jalr	-1692(ra) # 8000b79c <initgroup>
    releasesleep(&raiddata->grouplock);
    8000be40:	fd043783          	ld	a5,-48(s0)
    8000be44:	12878793          	addi	a5,a5,296
    8000be48:	853e                	mv	a0,a5
    8000be4a:	ffffb097          	auipc	ra,0xffffb
    8000be4e:	a5a080e7          	jalr	-1446(ra) # 800068a4 <releasesleep>

    uchar* newpg = (uchar*)kalloc();
    8000be52:	ffff5097          	auipc	ra,0xffff5
    8000be56:	38a080e7          	jalr	906(ra) # 800011dc <kalloc>
    8000be5a:	fca43023          	sd	a0,-64(s0)
    uchar* olddata = (uchar*)newpg;
    8000be5e:	fc043783          	ld	a5,-64(s0)
    8000be62:	faf43c23          	sd	a5,-72(s0)
    uchar* parity = (uchar*)newpg + BSIZE;
    8000be66:	fc043783          	ld	a5,-64(s0)
    8000be6a:	40078793          	addi	a5,a5,1024
    8000be6e:	faf43823          	sd	a5,-80(s0)

    acquiresleep(&raiddata->lock[diskn]);
    8000be72:	fe846703          	lwu	a4,-24(s0)
    8000be76:	87ba                	mv	a5,a4
    8000be78:	0786                	slli	a5,a5,0x1
    8000be7a:	97ba                	add	a5,a5,a4
    8000be7c:	0792                	slli	a5,a5,0x4
    8000be7e:	fd043703          	ld	a4,-48(s0)
    8000be82:	97ba                	add	a5,a5,a4
    8000be84:	07a1                	addi	a5,a5,8
    8000be86:	853e                	mv	a0,a5
    8000be88:	ffffb097          	auipc	ra,0xffffb
    8000be8c:	9ae080e7          	jalr	-1618(ra) # 80006836 <acquiresleep>
    acquiresleep(&raiddata->lock[DISKS - 1]);
    8000be90:	fd043783          	ld	a5,-48(s0)
    8000be94:	0f878793          	addi	a5,a5,248
    8000be98:	853e                	mv	a0,a5
    8000be9a:	ffffb097          	auipc	ra,0xffffb
    8000be9e:	99c080e7          	jalr	-1636(ra) # 80006836 <acquiresleep>

    read_block(diskinfo[diskn].pdiskn, pblkn, olddata);
    8000bea2:	fe846783          	lwu	a5,-24(s0)
    8000bea6:	0796                	slli	a5,a5,0x5
    8000bea8:	fd843703          	ld	a4,-40(s0)
    8000beac:	97ba                	add	a5,a5,a4
    8000beae:	0197c783          	lbu	a5,25(a5)
    8000beb2:	2781                	sext.w	a5,a5
    8000beb4:	fe442703          	lw	a4,-28(s0)
    8000beb8:	fb843603          	ld	a2,-72(s0)
    8000bebc:	85ba                	mv	a1,a4
    8000bebe:	853e                	mv	a0,a5
    8000bec0:	ffffe097          	auipc	ra,0xffffe
    8000bec4:	db4080e7          	jalr	-588(ra) # 80009c74 <read_block>
    read_block(DISKS, pblkn, parity);
    8000bec8:	fe442783          	lw	a5,-28(s0)
    8000becc:	fb043603          	ld	a2,-80(s0)
    8000bed0:	85be                	mv	a1,a5
    8000bed2:	4519                	li	a0,6
    8000bed4:	ffffe097          	auipc	ra,0xffffe
    8000bed8:	da0080e7          	jalr	-608(ra) # 80009c74 <read_block>
    for (int i = 0; i < BSIZE; i++)
    8000bedc:	fe042623          	sw	zero,-20(s0)
    8000bee0:	a881                	j	8000bf30 <raid4write+0x1ee>
      parity[i] ^= olddata[i] ^ data[i];
    8000bee2:	fec42783          	lw	a5,-20(s0)
    8000bee6:	fb043703          	ld	a4,-80(s0)
    8000beea:	97ba                	add	a5,a5,a4
    8000beec:	0007c683          	lbu	a3,0(a5)
    8000bef0:	fec42783          	lw	a5,-20(s0)
    8000bef4:	fb843703          	ld	a4,-72(s0)
    8000bef8:	97ba                	add	a5,a5,a4
    8000befa:	0007c703          	lbu	a4,0(a5)
    8000befe:	fec42783          	lw	a5,-20(s0)
    8000bf02:	fa043603          	ld	a2,-96(s0)
    8000bf06:	97b2                	add	a5,a5,a2
    8000bf08:	0007c783          	lbu	a5,0(a5)
    8000bf0c:	8fb9                	xor	a5,a5,a4
    8000bf0e:	0ff7f713          	zext.b	a4,a5
    8000bf12:	fec42783          	lw	a5,-20(s0)
    8000bf16:	fb043603          	ld	a2,-80(s0)
    8000bf1a:	97b2                	add	a5,a5,a2
    8000bf1c:	8f35                	xor	a4,a4,a3
    8000bf1e:	0ff77713          	zext.b	a4,a4
    8000bf22:	00e78023          	sb	a4,0(a5)
    for (int i = 0; i < BSIZE; i++)
    8000bf26:	fec42783          	lw	a5,-20(s0)
    8000bf2a:	2785                	addiw	a5,a5,1
    8000bf2c:	fef42623          	sw	a5,-20(s0)
    8000bf30:	fec42783          	lw	a5,-20(s0)
    8000bf34:	0007871b          	sext.w	a4,a5
    8000bf38:	3ff00793          	li	a5,1023
    8000bf3c:	fae7d3e3          	bge	a5,a4,8000bee2 <raid4write+0x1a0>

    write_block(diskinfo[diskn].pdiskn, pblkn, data);
    8000bf40:	fe846783          	lwu	a5,-24(s0)
    8000bf44:	0796                	slli	a5,a5,0x5
    8000bf46:	fd843703          	ld	a4,-40(s0)
    8000bf4a:	97ba                	add	a5,a5,a4
    8000bf4c:	0197c783          	lbu	a5,25(a5)
    8000bf50:	2781                	sext.w	a5,a5
    8000bf52:	fe442703          	lw	a4,-28(s0)
    8000bf56:	fa043603          	ld	a2,-96(s0)
    8000bf5a:	85ba                	mv	a1,a4
    8000bf5c:	853e                	mv	a0,a5
    8000bf5e:	ffffe097          	auipc	ra,0xffffe
    8000bf62:	c42080e7          	jalr	-958(ra) # 80009ba0 <write_block>
    write_block(DISKS, pblkn, parity);
    8000bf66:	fe442783          	lw	a5,-28(s0)
    8000bf6a:	fb043603          	ld	a2,-80(s0)
    8000bf6e:	85be                	mv	a1,a5
    8000bf70:	4519                	li	a0,6
    8000bf72:	ffffe097          	auipc	ra,0xffffe
    8000bf76:	c2e080e7          	jalr	-978(ra) # 80009ba0 <write_block>

    releasesleep(&raiddata->lock[diskn]);
    8000bf7a:	fe846703          	lwu	a4,-24(s0)
    8000bf7e:	87ba                	mv	a5,a4
    8000bf80:	0786                	slli	a5,a5,0x1
    8000bf82:	97ba                	add	a5,a5,a4
    8000bf84:	0792                	slli	a5,a5,0x4
    8000bf86:	fd043703          	ld	a4,-48(s0)
    8000bf8a:	97ba                	add	a5,a5,a4
    8000bf8c:	07a1                	addi	a5,a5,8
    8000bf8e:	853e                	mv	a0,a5
    8000bf90:	ffffb097          	auipc	ra,0xffffb
    8000bf94:	914080e7          	jalr	-1772(ra) # 800068a4 <releasesleep>
    releasesleep(&raiddata->lock[DISKS - 1]);
    8000bf98:	fd043783          	ld	a5,-48(s0)
    8000bf9c:	0f878793          	addi	a5,a5,248
    8000bfa0:	853e                	mv	a0,a5
    8000bfa2:	ffffb097          	auipc	ra,0xffffb
    8000bfa6:	902080e7          	jalr	-1790(ra) # 800068a4 <releasesleep>

    kfree(newpg);
    8000bfaa:	fc043503          	ld	a0,-64(s0)
    8000bfae:	ffff5097          	auipc	ra,0xffff5
    8000bfb2:	188080e7          	jalr	392(ra) # 80001136 <kfree>
    return 0;
    8000bfb6:	4781                	li	a5,0
}
    8000bfb8:	853e                	mv	a0,a5
    8000bfba:	60e6                	ld	ra,88(sp)
    8000bfbc:	6446                	ld	s0,80(sp)
    8000bfbe:	6125                	addi	sp,sp,96
    8000bfc0:	8082                	ret
	...

000000008000c000 <_trampoline>:
    8000c000:	14051073          	csrw	sscratch,a0
    8000c004:	02000537          	lui	a0,0x2000
    8000c008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000c00a:	0536                	slli	a0,a0,0xd
    8000c00c:	02153423          	sd	ra,40(a0)
    8000c010:	02253823          	sd	sp,48(a0)
    8000c014:	02353c23          	sd	gp,56(a0)
    8000c018:	04453023          	sd	tp,64(a0)
    8000c01c:	04553423          	sd	t0,72(a0)
    8000c020:	04653823          	sd	t1,80(a0)
    8000c024:	04753c23          	sd	t2,88(a0)
    8000c028:	f120                	sd	s0,96(a0)
    8000c02a:	f524                	sd	s1,104(a0)
    8000c02c:	fd2c                	sd	a1,120(a0)
    8000c02e:	e150                	sd	a2,128(a0)
    8000c030:	e554                	sd	a3,136(a0)
    8000c032:	e958                	sd	a4,144(a0)
    8000c034:	ed5c                	sd	a5,152(a0)
    8000c036:	0b053023          	sd	a6,160(a0)
    8000c03a:	0b153423          	sd	a7,168(a0)
    8000c03e:	0b253823          	sd	s2,176(a0)
    8000c042:	0b353c23          	sd	s3,184(a0)
    8000c046:	0d453023          	sd	s4,192(a0)
    8000c04a:	0d553423          	sd	s5,200(a0)
    8000c04e:	0d653823          	sd	s6,208(a0)
    8000c052:	0d753c23          	sd	s7,216(a0)
    8000c056:	0f853023          	sd	s8,224(a0)
    8000c05a:	0f953423          	sd	s9,232(a0)
    8000c05e:	0fa53823          	sd	s10,240(a0)
    8000c062:	0fb53c23          	sd	s11,248(a0)
    8000c066:	11c53023          	sd	t3,256(a0)
    8000c06a:	11d53423          	sd	t4,264(a0)
    8000c06e:	11e53823          	sd	t5,272(a0)
    8000c072:	11f53c23          	sd	t6,280(a0)
    8000c076:	140022f3          	csrr	t0,sscratch
    8000c07a:	06553823          	sd	t0,112(a0)
    8000c07e:	00853103          	ld	sp,8(a0)
    8000c082:	02053203          	ld	tp,32(a0)
    8000c086:	01053283          	ld	t0,16(a0)
    8000c08a:	00053303          	ld	t1,0(a0)
    8000c08e:	12000073          	sfence.vma
    8000c092:	18031073          	csrw	satp,t1
    8000c096:	12000073          	sfence.vma
    8000c09a:	8282                	jr	t0

000000008000c09c <userret>:
    8000c09c:	12000073          	sfence.vma
    8000c0a0:	18051073          	csrw	satp,a0
    8000c0a4:	12000073          	sfence.vma
    8000c0a8:	02000537          	lui	a0,0x2000
    8000c0ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000c0ae:	0536                	slli	a0,a0,0xd
    8000c0b0:	02853083          	ld	ra,40(a0)
    8000c0b4:	03053103          	ld	sp,48(a0)
    8000c0b8:	03853183          	ld	gp,56(a0)
    8000c0bc:	04053203          	ld	tp,64(a0)
    8000c0c0:	04853283          	ld	t0,72(a0)
    8000c0c4:	05053303          	ld	t1,80(a0)
    8000c0c8:	05853383          	ld	t2,88(a0)
    8000c0cc:	7120                	ld	s0,96(a0)
    8000c0ce:	7524                	ld	s1,104(a0)
    8000c0d0:	7d2c                	ld	a1,120(a0)
    8000c0d2:	6150                	ld	a2,128(a0)
    8000c0d4:	6554                	ld	a3,136(a0)
    8000c0d6:	6958                	ld	a4,144(a0)
    8000c0d8:	6d5c                	ld	a5,152(a0)
    8000c0da:	0a053803          	ld	a6,160(a0)
    8000c0de:	0a853883          	ld	a7,168(a0)
    8000c0e2:	0b053903          	ld	s2,176(a0)
    8000c0e6:	0b853983          	ld	s3,184(a0)
    8000c0ea:	0c053a03          	ld	s4,192(a0)
    8000c0ee:	0c853a83          	ld	s5,200(a0)
    8000c0f2:	0d053b03          	ld	s6,208(a0)
    8000c0f6:	0d853b83          	ld	s7,216(a0)
    8000c0fa:	0e053c03          	ld	s8,224(a0)
    8000c0fe:	0e853c83          	ld	s9,232(a0)
    8000c102:	0f053d03          	ld	s10,240(a0)
    8000c106:	0f853d83          	ld	s11,248(a0)
    8000c10a:	10053e03          	ld	t3,256(a0)
    8000c10e:	10853e83          	ld	t4,264(a0)
    8000c112:	11053f03          	ld	t5,272(a0)
    8000c116:	11853f83          	ld	t6,280(a0)
    8000c11a:	7928                	ld	a0,112(a0)
    8000c11c:	10200073          	sret
	...
