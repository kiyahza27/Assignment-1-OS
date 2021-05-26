
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "uproc.h"

int 
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 34             	sub    $0x34,%esp
  uint max = 72;
  struct uproc* table = malloc(sizeof(struct uproc) * max);
  18:	68 e0 19 00 00       	push   $0x19e0
  1d:	e8 47 07 00 00       	call   769 <malloc>
  22:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int count = getprocs(max, table);
  25:	83 c4 08             	add    $0x8,%esp
  28:	50                   	push   %eax
  29:	6a 48                	push   $0x48
  2b:	e8 5f 04 00 00       	call   48f <getprocs>
  30:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  uint sec;
  uint cpu;
  uint cpu_sec;
  uint cpu_millsec;

  if(count < 0) {
  33:	83 c4 10             	add    $0x10,%esp
  36:	85 c0                	test   %eax,%eax
  38:	78 1e                	js     58 <main+0x58>
    printf(2, "\nFailure: an error occurred while creating the user process table.\n");
  } else {
    printf(1, "\nPID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
  3a:	83 ec 08             	sub    $0x8,%esp
  3d:	68 3c 08 00 00       	push   $0x83c
  42:	6a 01                	push   $0x1
  44:	e8 ef 04 00 00       	call   538 <printf>

    for(int i = 0; i < count; ++i) {
  49:	83 c4 10             	add    $0x10,%esp
  4c:	bf 00 00 00 00       	mov    $0x0,%edi
  51:	89 fe                	mov    %edi,%esi
  53:	e9 b0 00 00 00       	jmp    108 <main+0x108>
    printf(2, "\nFailure: an error occurred while creating the user process table.\n");
  58:	83 ec 08             	sub    $0x8,%esp
  5b:	68 f8 07 00 00       	push   $0x7f8
  60:	6a 02                	push   $0x2
  62:	e8 d1 04 00 00       	call   538 <printf>
  67:	83 c4 10             	add    $0x10,%esp
  6a:	e9 a2 00 00 00       	jmp    111 <main+0x111>
      // process time
      elapsed = table[i].elapsed_ticks;
  6f:	6b de 5c             	imul   $0x5c,%esi,%ebx
  72:	03 5d d8             	add    -0x28(%ebp),%ebx
  75:	8b 7b 10             	mov    0x10(%ebx),%edi
	  sec = (elapsed / 1000);
  78:	b9 d3 4d 62 10       	mov    $0x10624dd3,%ecx
  7d:	89 f8                	mov    %edi,%eax
  7f:	f7 e1                	mul    %ecx
  81:	c1 ea 06             	shr    $0x6,%edx
      millsec = (elapsed % 1000);
  84:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  87:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
  8d:	29 c7                	sub    %eax,%edi
  8f:	89 7d e0             	mov    %edi,-0x20(%ebp)
      // CPU time
      cpu = table[i].CPU_total_ticks;
  92:	8b 7b 14             	mov    0x14(%ebx),%edi
	  cpu_sec = (cpu/1000);
  95:	89 f8                	mov    %edi,%eax
  97:	f7 e1                	mul    %ecx
  99:	89 d0                	mov    %edx,%eax
  9b:	c1 e8 06             	shr    $0x6,%eax
      cpu_millsec = (cpu % 1000);
  9e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  a1:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
  a7:	29 c7                	sub    %eax,%edi
      
      // Print pid, name
      printf(1, "%d\t%s\t", table[i].pid, table[i].name);
  a9:	8d 43 3c             	lea    0x3c(%ebx),%eax
  ac:	50                   	push   %eax
  ad:	ff 33                	pushl  (%ebx)
  af:	68 6b 08 00 00       	push   $0x86b
  b4:	6a 01                	push   $0x1
  b6:	e8 7d 04 00 00       	call   538 <printf>
      // Print uid, gid, ppid, elapsed (seconds)
      printf(1, "%d\t%d\t%d\t%d.", table[i].uid, table[i].gid, table[i].ppid, sec);
  bb:	83 c4 08             	add    $0x8,%esp
  be:	ff 75 e4             	pushl  -0x1c(%ebp)
  c1:	ff 73 0c             	pushl  0xc(%ebx)
  c4:	ff 73 08             	pushl  0x8(%ebx)
  c7:	ff 73 04             	pushl  0x4(%ebx)
  ca:	68 72 08 00 00       	push   $0x872
  cf:	6a 01                	push   $0x1
  d1:	e8 62 04 00 00       	call   538 <printf>
      // Print elapsed (millsec), cpu (seconds)
      printf(1, "%d\t%d.", millsec, cpu_sec);
  d6:	83 c4 20             	add    $0x20,%esp
  d9:	ff 75 dc             	pushl  -0x24(%ebp)
  dc:	ff 75 e0             	pushl  -0x20(%ebp)
  df:	68 78 08 00 00       	push   $0x878
  e4:	6a 01                	push   $0x1
  e6:	e8 4d 04 00 00       	call   538 <printf>
	  // Print cpu (millsec), state, size
      printf(1, "%d\t%s\t%d\n", cpu_millsec, table[i].state, table[i].size);
  eb:	8d 43 18             	lea    0x18(%ebx),%eax
  ee:	83 c4 04             	add    $0x4,%esp
  f1:	ff 73 38             	pushl  0x38(%ebx)
  f4:	50                   	push   %eax
  f5:	57                   	push   %edi
  f6:	68 7f 08 00 00       	push   $0x87f
  fb:	6a 01                	push   $0x1
  fd:	e8 36 04 00 00       	call   538 <printf>
    for(int i = 0; i < count; ++i) {
 102:	83 c6 01             	add    $0x1,%esi
 105:	83 c4 20             	add    $0x20,%esp
 108:	3b 75 d4             	cmp    -0x2c(%ebp),%esi
 10b:	0f 8c 5e ff ff ff    	jl     6f <main+0x6f>
    }
  }
  free(table);
 111:	83 ec 0c             	sub    $0xc,%esp
 114:	ff 75 d8             	pushl  -0x28(%ebp)
 117:	e8 89 05 00 00       	call   6a5 <free>
  exit();
 11c:	e8 96 02 00 00       	call   3b7 <exit>

00000121 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 121:	f3 0f 1e fb          	endbr32 
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
 128:	56                   	push   %esi
 129:	53                   	push   %ebx
 12a:	8b 75 08             	mov    0x8(%ebp),%esi
 12d:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 130:	89 f0                	mov    %esi,%eax
 132:	89 d1                	mov    %edx,%ecx
 134:	83 c2 01             	add    $0x1,%edx
 137:	89 c3                	mov    %eax,%ebx
 139:	83 c0 01             	add    $0x1,%eax
 13c:	0f b6 09             	movzbl (%ecx),%ecx
 13f:	88 0b                	mov    %cl,(%ebx)
 141:	84 c9                	test   %cl,%cl
 143:	75 ed                	jne    132 <strcpy+0x11>
    ;
  return os;
}
 145:	89 f0                	mov    %esi,%eax
 147:	5b                   	pop    %ebx
 148:	5e                   	pop    %esi
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    

0000014b <strcmp>:

int
strcmp(const char *p, const char *q)
{
 14b:	f3 0f 1e fb          	endbr32 
 14f:	55                   	push   %ebp
 150:	89 e5                	mov    %esp,%ebp
 152:	8b 4d 08             	mov    0x8(%ebp),%ecx
 155:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 158:	0f b6 01             	movzbl (%ecx),%eax
 15b:	84 c0                	test   %al,%al
 15d:	74 0c                	je     16b <strcmp+0x20>
 15f:	3a 02                	cmp    (%edx),%al
 161:	75 08                	jne    16b <strcmp+0x20>
    p++, q++;
 163:	83 c1 01             	add    $0x1,%ecx
 166:	83 c2 01             	add    $0x1,%edx
 169:	eb ed                	jmp    158 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 16b:	0f b6 c0             	movzbl %al,%eax
 16e:	0f b6 12             	movzbl (%edx),%edx
 171:	29 d0                	sub    %edx,%eax
}
 173:	5d                   	pop    %ebp
 174:	c3                   	ret    

00000175 <strlen>:

uint
strlen(char *s)
{
 175:	f3 0f 1e fb          	endbr32 
 179:	55                   	push   %ebp
 17a:	89 e5                	mov    %esp,%ebp
 17c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 17f:	b8 00 00 00 00       	mov    $0x0,%eax
 184:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 188:	74 05                	je     18f <strlen+0x1a>
 18a:	83 c0 01             	add    $0x1,%eax
 18d:	eb f5                	jmp    184 <strlen+0xf>
    ;
  return n;
}
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    

00000191 <memset>:

void*
memset(void *dst, int c, uint n)
{
 191:	f3 0f 1e fb          	endbr32 
 195:	55                   	push   %ebp
 196:	89 e5                	mov    %esp,%ebp
 198:	57                   	push   %edi
 199:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 19c:	89 d7                	mov    %edx,%edi
 19e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a4:	fc                   	cld    
 1a5:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	5f                   	pop    %edi
 1aa:	5d                   	pop    %ebp
 1ab:	c3                   	ret    

000001ac <strchr>:

char*
strchr(const char *s, char c)
{
 1ac:	f3 0f 1e fb          	endbr32 
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ba:	0f b6 10             	movzbl (%eax),%edx
 1bd:	84 d2                	test   %dl,%dl
 1bf:	74 09                	je     1ca <strchr+0x1e>
    if(*s == c)
 1c1:	38 ca                	cmp    %cl,%dl
 1c3:	74 0a                	je     1cf <strchr+0x23>
  for(; *s; s++)
 1c5:	83 c0 01             	add    $0x1,%eax
 1c8:	eb f0                	jmp    1ba <strchr+0xe>
      return (char*)s;
  return 0;
 1ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    

000001d1 <gets>:

char*
gets(char *buf, int max)
{
 1d1:	f3 0f 1e fb          	endbr32 
 1d5:	55                   	push   %ebp
 1d6:	89 e5                	mov    %esp,%ebp
 1d8:	57                   	push   %edi
 1d9:	56                   	push   %esi
 1da:	53                   	push   %ebx
 1db:	83 ec 1c             	sub    $0x1c,%esp
 1de:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e1:	bb 00 00 00 00       	mov    $0x0,%ebx
 1e6:	89 de                	mov    %ebx,%esi
 1e8:	83 c3 01             	add    $0x1,%ebx
 1eb:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ee:	7d 2e                	jge    21e <gets+0x4d>
    cc = read(0, &c, 1);
 1f0:	83 ec 04             	sub    $0x4,%esp
 1f3:	6a 01                	push   $0x1
 1f5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1f8:	50                   	push   %eax
 1f9:	6a 00                	push   $0x0
 1fb:	e8 cf 01 00 00       	call   3cf <read>
    if(cc < 1)
 200:	83 c4 10             	add    $0x10,%esp
 203:	85 c0                	test   %eax,%eax
 205:	7e 17                	jle    21e <gets+0x4d>
      break;
    buf[i++] = c;
 207:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 20b:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 20e:	3c 0a                	cmp    $0xa,%al
 210:	0f 94 c2             	sete   %dl
 213:	3c 0d                	cmp    $0xd,%al
 215:	0f 94 c0             	sete   %al
 218:	08 c2                	or     %al,%dl
 21a:	74 ca                	je     1e6 <gets+0x15>
    buf[i++] = c;
 21c:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 21e:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 222:	89 f8                	mov    %edi,%eax
 224:	8d 65 f4             	lea    -0xc(%ebp),%esp
 227:	5b                   	pop    %ebx
 228:	5e                   	pop    %esi
 229:	5f                   	pop    %edi
 22a:	5d                   	pop    %ebp
 22b:	c3                   	ret    

0000022c <stat>:

int
stat(char *n, struct stat *st)
{
 22c:	f3 0f 1e fb          	endbr32 
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 235:	83 ec 08             	sub    $0x8,%esp
 238:	6a 00                	push   $0x0
 23a:	ff 75 08             	pushl  0x8(%ebp)
 23d:	e8 b5 01 00 00       	call   3f7 <open>
  if(fd < 0)
 242:	83 c4 10             	add    $0x10,%esp
 245:	85 c0                	test   %eax,%eax
 247:	78 24                	js     26d <stat+0x41>
 249:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 24b:	83 ec 08             	sub    $0x8,%esp
 24e:	ff 75 0c             	pushl  0xc(%ebp)
 251:	50                   	push   %eax
 252:	e8 b8 01 00 00       	call   40f <fstat>
 257:	89 c6                	mov    %eax,%esi
  close(fd);
 259:	89 1c 24             	mov    %ebx,(%esp)
 25c:	e8 7e 01 00 00       	call   3df <close>
  return r;
 261:	83 c4 10             	add    $0x10,%esp
}
 264:	89 f0                	mov    %esi,%eax
 266:	8d 65 f8             	lea    -0x8(%ebp),%esp
 269:	5b                   	pop    %ebx
 26a:	5e                   	pop    %esi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
    return -1;
 26d:	be ff ff ff ff       	mov    $0xffffffff,%esi
 272:	eb f0                	jmp    264 <stat+0x38>

00000274 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 274:	f3 0f 1e fb          	endbr32 
 278:	55                   	push   %ebp
 279:	89 e5                	mov    %esp,%ebp
 27b:	57                   	push   %edi
 27c:	56                   	push   %esi
 27d:	53                   	push   %ebx
 27e:	8b 55 08             	mov    0x8(%ebp),%edx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 281:	0f b6 02             	movzbl (%edx),%eax
 284:	3c 20                	cmp    $0x20,%al
 286:	75 05                	jne    28d <atoi+0x19>
 288:	83 c2 01             	add    $0x1,%edx
 28b:	eb f4                	jmp    281 <atoi+0xd>
  sign = (*s == '-') ? -1 : 1;
 28d:	3c 2d                	cmp    $0x2d,%al
 28f:	74 1d                	je     2ae <atoi+0x3a>
 291:	bf 01 00 00 00       	mov    $0x1,%edi
  if (*s == '+'  || *s == '-')
 296:	3c 2b                	cmp    $0x2b,%al
 298:	0f 94 c1             	sete   %cl
 29b:	3c 2d                	cmp    $0x2d,%al
 29d:	0f 94 c0             	sete   %al
 2a0:	08 c1                	or     %al,%cl
 2a2:	74 03                	je     2a7 <atoi+0x33>
    s++;
 2a4:	83 c2 01             	add    $0x1,%edx
  sign = (*s == '-') ? -1 : 1;
 2a7:	b8 00 00 00 00       	mov    $0x0,%eax
 2ac:	eb 17                	jmp    2c5 <atoi+0x51>
 2ae:	bf ff ff ff ff       	mov    $0xffffffff,%edi
 2b3:	eb e1                	jmp    296 <atoi+0x22>
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
 2b5:	8d 34 80             	lea    (%eax,%eax,4),%esi
 2b8:	8d 1c 36             	lea    (%esi,%esi,1),%ebx
 2bb:	83 c2 01             	add    $0x1,%edx
 2be:	0f be c9             	movsbl %cl,%ecx
 2c1:	8d 44 19 d0          	lea    -0x30(%ecx,%ebx,1),%eax
  while('0' <= *s && *s <= '9')
 2c5:	0f b6 0a             	movzbl (%edx),%ecx
 2c8:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 2cb:	80 fb 09             	cmp    $0x9,%bl
 2ce:	76 e5                	jbe    2b5 <atoi+0x41>
  return sign*n;
 2d0:	0f af c7             	imul   %edi,%eax
}
 2d3:	5b                   	pop    %ebx
 2d4:	5e                   	pop    %esi
 2d5:	5f                   	pop    %edi
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret    

000002d8 <atoo>:

int
atoo(const char *s)
{
 2d8:	f3 0f 1e fb          	endbr32 
 2dc:	55                   	push   %ebp
 2dd:	89 e5                	mov    %esp,%ebp
 2df:	57                   	push   %edi
 2e0:	56                   	push   %esi
 2e1:	53                   	push   %ebx
 2e2:	8b 55 08             	mov    0x8(%ebp),%edx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 2e5:	0f b6 0a             	movzbl (%edx),%ecx
 2e8:	80 f9 20             	cmp    $0x20,%cl
 2eb:	75 05                	jne    2f2 <atoo+0x1a>
 2ed:	83 c2 01             	add    $0x1,%edx
 2f0:	eb f3                	jmp    2e5 <atoo+0xd>
  sign = (*s == '-') ? -1 : 1;
 2f2:	80 f9 2d             	cmp    $0x2d,%cl
 2f5:	74 23                	je     31a <atoo+0x42>
 2f7:	bf 01 00 00 00       	mov    $0x1,%edi
  if (*s == '+'  || *s == '-')
 2fc:	80 f9 2b             	cmp    $0x2b,%cl
 2ff:	0f 94 c0             	sete   %al
 302:	89 c6                	mov    %eax,%esi
 304:	80 f9 2d             	cmp    $0x2d,%cl
 307:	0f 94 c0             	sete   %al
 30a:	89 f3                	mov    %esi,%ebx
 30c:	08 c3                	or     %al,%bl
 30e:	74 03                	je     313 <atoo+0x3b>
    s++;
 310:	83 c2 01             	add    $0x1,%edx
  sign = (*s == '-') ? -1 : 1;
 313:	b8 00 00 00 00       	mov    $0x0,%eax
 318:	eb 11                	jmp    32b <atoo+0x53>
 31a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
 31f:	eb db                	jmp    2fc <atoo+0x24>
  while('0' <= *s && *s <= '7')
    n = n*8 + *s++ - '0';
 321:	83 c2 01             	add    $0x1,%edx
 324:	0f be c9             	movsbl %cl,%ecx
 327:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 32b:	0f b6 0a             	movzbl (%edx),%ecx
 32e:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 331:	80 fb 07             	cmp    $0x7,%bl
 334:	76 eb                	jbe    321 <atoo+0x49>
  return sign*n;
 336:	0f af c7             	imul   %edi,%eax
}
 339:	5b                   	pop    %ebx
 33a:	5e                   	pop    %esi
 33b:	5f                   	pop    %edi
 33c:	5d                   	pop    %ebp
 33d:	c3                   	ret    

0000033e <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 33e:	f3 0f 1e fb          	endbr32 
 342:	55                   	push   %ebp
 343:	89 e5                	mov    %esp,%ebp
 345:	53                   	push   %ebx
 346:	8b 55 08             	mov    0x8(%ebp),%edx
 349:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 34c:	8b 45 10             	mov    0x10(%ebp),%eax
    while(n > 0 && *p && *p == *q)
 34f:	eb 09                	jmp    35a <strncmp+0x1c>
      n--, p++, q++;
 351:	83 e8 01             	sub    $0x1,%eax
 354:	83 c2 01             	add    $0x1,%edx
 357:	83 c1 01             	add    $0x1,%ecx
    while(n > 0 && *p && *p == *q)
 35a:	85 c0                	test   %eax,%eax
 35c:	74 0b                	je     369 <strncmp+0x2b>
 35e:	0f b6 1a             	movzbl (%edx),%ebx
 361:	84 db                	test   %bl,%bl
 363:	74 04                	je     369 <strncmp+0x2b>
 365:	3a 19                	cmp    (%ecx),%bl
 367:	74 e8                	je     351 <strncmp+0x13>
    if(n == 0)
 369:	85 c0                	test   %eax,%eax
 36b:	74 0b                	je     378 <strncmp+0x3a>
      return 0;
    return (uchar)*p - (uchar)*q;
 36d:	0f b6 02             	movzbl (%edx),%eax
 370:	0f b6 11             	movzbl (%ecx),%edx
 373:	29 d0                	sub    %edx,%eax
}
 375:	5b                   	pop    %ebx
 376:	5d                   	pop    %ebp
 377:	c3                   	ret    
      return 0;
 378:	b8 00 00 00 00       	mov    $0x0,%eax
 37d:	eb f6                	jmp    375 <strncmp+0x37>

0000037f <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 37f:	f3 0f 1e fb          	endbr32 
 383:	55                   	push   %ebp
 384:	89 e5                	mov    %esp,%ebp
 386:	56                   	push   %esi
 387:	53                   	push   %ebx
 388:	8b 75 08             	mov    0x8(%ebp),%esi
 38b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 38e:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst, *src;

  dst = vdst;
 391:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 393:	8d 58 ff             	lea    -0x1(%eax),%ebx
 396:	85 c0                	test   %eax,%eax
 398:	7e 0f                	jle    3a9 <memmove+0x2a>
    *dst++ = *src++;
 39a:	0f b6 01             	movzbl (%ecx),%eax
 39d:	88 02                	mov    %al,(%edx)
 39f:	8d 49 01             	lea    0x1(%ecx),%ecx
 3a2:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 3a5:	89 d8                	mov    %ebx,%eax
 3a7:	eb ea                	jmp    393 <memmove+0x14>
  return vdst;
}
 3a9:	89 f0                	mov    %esi,%eax
 3ab:	5b                   	pop    %ebx
 3ac:	5e                   	pop    %esi
 3ad:	5d                   	pop    %ebp
 3ae:	c3                   	ret    

000003af <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3af:	b8 01 00 00 00       	mov    $0x1,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <exit>:
SYSCALL(exit)
 3b7:	b8 02 00 00 00       	mov    $0x2,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <wait>:
SYSCALL(wait)
 3bf:	b8 03 00 00 00       	mov    $0x3,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <pipe>:
SYSCALL(pipe)
 3c7:	b8 04 00 00 00       	mov    $0x4,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <read>:
SYSCALL(read)
 3cf:	b8 05 00 00 00       	mov    $0x5,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <write>:
SYSCALL(write)
 3d7:	b8 10 00 00 00       	mov    $0x10,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <close>:
SYSCALL(close)
 3df:	b8 15 00 00 00       	mov    $0x15,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <kill>:
SYSCALL(kill)
 3e7:	b8 06 00 00 00       	mov    $0x6,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <exec>:
SYSCALL(exec)
 3ef:	b8 07 00 00 00       	mov    $0x7,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <open>:
SYSCALL(open)
 3f7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret    

000003ff <mknod>:
SYSCALL(mknod)
 3ff:	b8 11 00 00 00       	mov    $0x11,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret    

00000407 <unlink>:
SYSCALL(unlink)
 407:	b8 12 00 00 00       	mov    $0x12,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret    

0000040f <fstat>:
SYSCALL(fstat)
 40f:	b8 08 00 00 00       	mov    $0x8,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret    

00000417 <link>:
SYSCALL(link)
 417:	b8 13 00 00 00       	mov    $0x13,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret    

0000041f <mkdir>:
SYSCALL(mkdir)
 41f:	b8 14 00 00 00       	mov    $0x14,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret    

00000427 <chdir>:
SYSCALL(chdir)
 427:	b8 09 00 00 00       	mov    $0x9,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret    

0000042f <dup>:
SYSCALL(dup)
 42f:	b8 0a 00 00 00       	mov    $0xa,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret    

00000437 <getpid>:
SYSCALL(getpid)
 437:	b8 0b 00 00 00       	mov    $0xb,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret    

0000043f <sbrk>:
SYSCALL(sbrk)
 43f:	b8 0c 00 00 00       	mov    $0xc,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret    

00000447 <sleep>:
SYSCALL(sleep)
 447:	b8 0d 00 00 00       	mov    $0xd,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret    

0000044f <uptime>:
SYSCALL(uptime)
 44f:	b8 0e 00 00 00       	mov    $0xe,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret    

00000457 <halt>:
SYSCALL(halt)
 457:	b8 16 00 00 00       	mov    $0x16,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret    

0000045f <date>:
SYSCALL(date)
 45f:	b8 17 00 00 00       	mov    $0x17,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret    

00000467 <getuid>:
SYSCALL(getuid)
 467:	b8 18 00 00 00       	mov    $0x18,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <getgid>:
SYSCALL(getgid)
 46f:	b8 19 00 00 00       	mov    $0x19,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <getppid>:
SYSCALL(getppid)
 477:	b8 1a 00 00 00       	mov    $0x1a,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret    

0000047f <setuid>:
SYSCALL(setuid)
 47f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret    

00000487 <setgid>:
SYSCALL(setgid)
 487:	b8 1c 00 00 00       	mov    $0x1c,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret    

0000048f <getprocs>:
 48f:	b8 1d 00 00 00       	mov    $0x1d,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret    

00000497 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 497:	55                   	push   %ebp
 498:	89 e5                	mov    %esp,%ebp
 49a:	83 ec 1c             	sub    $0x1c,%esp
 49d:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 4a0:	6a 01                	push   $0x1
 4a2:	8d 55 f4             	lea    -0xc(%ebp),%edx
 4a5:	52                   	push   %edx
 4a6:	50                   	push   %eax
 4a7:	e8 2b ff ff ff       	call   3d7 <write>
}
 4ac:	83 c4 10             	add    $0x10,%esp
 4af:	c9                   	leave  
 4b0:	c3                   	ret    

000004b1 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b1:	55                   	push   %ebp
 4b2:	89 e5                	mov    %esp,%ebp
 4b4:	57                   	push   %edi
 4b5:	56                   	push   %esi
 4b6:	53                   	push   %ebx
 4b7:	83 ec 2c             	sub    $0x2c,%esp
 4ba:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4bd:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 4c3:	0f 95 c2             	setne  %dl
 4c6:	89 f0                	mov    %esi,%eax
 4c8:	c1 e8 1f             	shr    $0x1f,%eax
 4cb:	84 c2                	test   %al,%dl
 4cd:	74 42                	je     511 <printint+0x60>
    neg = 1;
    x = -xx;
 4cf:	f7 de                	neg    %esi
    neg = 1;
 4d1:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4d8:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 4dd:	89 f0                	mov    %esi,%eax
 4df:	ba 00 00 00 00       	mov    $0x0,%edx
 4e4:	f7 f1                	div    %ecx
 4e6:	89 df                	mov    %ebx,%edi
 4e8:	83 c3 01             	add    $0x1,%ebx
 4eb:	0f b6 92 90 08 00 00 	movzbl 0x890(%edx),%edx
 4f2:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 4f6:	89 f2                	mov    %esi,%edx
 4f8:	89 c6                	mov    %eax,%esi
 4fa:	39 d1                	cmp    %edx,%ecx
 4fc:	76 df                	jbe    4dd <printint+0x2c>
  if(neg)
 4fe:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 502:	74 2f                	je     533 <printint+0x82>
    buf[i++] = '-';
 504:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 509:	8d 5f 02             	lea    0x2(%edi),%ebx
 50c:	8b 75 d0             	mov    -0x30(%ebp),%esi
 50f:	eb 15                	jmp    526 <printint+0x75>
  neg = 0;
 511:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 518:	eb be                	jmp    4d8 <printint+0x27>

  while(--i >= 0)
    putc(fd, buf[i]);
 51a:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 51f:	89 f0                	mov    %esi,%eax
 521:	e8 71 ff ff ff       	call   497 <putc>
  while(--i >= 0)
 526:	83 eb 01             	sub    $0x1,%ebx
 529:	79 ef                	jns    51a <printint+0x69>
}
 52b:	83 c4 2c             	add    $0x2c,%esp
 52e:	5b                   	pop    %ebx
 52f:	5e                   	pop    %esi
 530:	5f                   	pop    %edi
 531:	5d                   	pop    %ebp
 532:	c3                   	ret    
 533:	8b 75 d0             	mov    -0x30(%ebp),%esi
 536:	eb ee                	jmp    526 <printint+0x75>

00000538 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 538:	f3 0f 1e fb          	endbr32 
 53c:	55                   	push   %ebp
 53d:	89 e5                	mov    %esp,%ebp
 53f:	57                   	push   %edi
 540:	56                   	push   %esi
 541:	53                   	push   %ebx
 542:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 545:	8d 45 10             	lea    0x10(%ebp),%eax
 548:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 54b:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 550:	bb 00 00 00 00       	mov    $0x0,%ebx
 555:	eb 14                	jmp    56b <printf+0x33>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 557:	89 fa                	mov    %edi,%edx
 559:	8b 45 08             	mov    0x8(%ebp),%eax
 55c:	e8 36 ff ff ff       	call   497 <putc>
 561:	eb 05                	jmp    568 <printf+0x30>
      }
    } else if(state == '%'){
 563:	83 fe 25             	cmp    $0x25,%esi
 566:	74 25                	je     58d <printf+0x55>
  for(i = 0; fmt[i]; i++){
 568:	83 c3 01             	add    $0x1,%ebx
 56b:	8b 45 0c             	mov    0xc(%ebp),%eax
 56e:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 572:	84 c0                	test   %al,%al
 574:	0f 84 23 01 00 00    	je     69d <printf+0x165>
    c = fmt[i] & 0xff;
 57a:	0f be f8             	movsbl %al,%edi
 57d:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 580:	85 f6                	test   %esi,%esi
 582:	75 df                	jne    563 <printf+0x2b>
      if(c == '%'){
 584:	83 f8 25             	cmp    $0x25,%eax
 587:	75 ce                	jne    557 <printf+0x1f>
        state = '%';
 589:	89 c6                	mov    %eax,%esi
 58b:	eb db                	jmp    568 <printf+0x30>
      if(c == 'd'){
 58d:	83 f8 64             	cmp    $0x64,%eax
 590:	74 49                	je     5db <printf+0xa3>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 592:	83 f8 78             	cmp    $0x78,%eax
 595:	0f 94 c1             	sete   %cl
 598:	83 f8 70             	cmp    $0x70,%eax
 59b:	0f 94 c2             	sete   %dl
 59e:	08 d1                	or     %dl,%cl
 5a0:	75 63                	jne    605 <printf+0xcd>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5a2:	83 f8 73             	cmp    $0x73,%eax
 5a5:	0f 84 84 00 00 00    	je     62f <printf+0xf7>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ab:	83 f8 63             	cmp    $0x63,%eax
 5ae:	0f 84 b7 00 00 00    	je     66b <printf+0x133>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5b4:	83 f8 25             	cmp    $0x25,%eax
 5b7:	0f 84 cc 00 00 00    	je     689 <printf+0x151>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5bd:	ba 25 00 00 00       	mov    $0x25,%edx
 5c2:	8b 45 08             	mov    0x8(%ebp),%eax
 5c5:	e8 cd fe ff ff       	call   497 <putc>
        putc(fd, c);
 5ca:	89 fa                	mov    %edi,%edx
 5cc:	8b 45 08             	mov    0x8(%ebp),%eax
 5cf:	e8 c3 fe ff ff       	call   497 <putc>
      }
      state = 0;
 5d4:	be 00 00 00 00       	mov    $0x0,%esi
 5d9:	eb 8d                	jmp    568 <printf+0x30>
        printint(fd, *ap, 10, 1);
 5db:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 5de:	8b 17                	mov    (%edi),%edx
 5e0:	83 ec 0c             	sub    $0xc,%esp
 5e3:	6a 01                	push   $0x1
 5e5:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5ea:	8b 45 08             	mov    0x8(%ebp),%eax
 5ed:	e8 bf fe ff ff       	call   4b1 <printint>
        ap++;
 5f2:	83 c7 04             	add    $0x4,%edi
 5f5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 5f8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5fb:	be 00 00 00 00       	mov    $0x0,%esi
 600:	e9 63 ff ff ff       	jmp    568 <printf+0x30>
        printint(fd, *ap, 16, 0);
 605:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 608:	8b 17                	mov    (%edi),%edx
 60a:	83 ec 0c             	sub    $0xc,%esp
 60d:	6a 00                	push   $0x0
 60f:	b9 10 00 00 00       	mov    $0x10,%ecx
 614:	8b 45 08             	mov    0x8(%ebp),%eax
 617:	e8 95 fe ff ff       	call   4b1 <printint>
        ap++;
 61c:	83 c7 04             	add    $0x4,%edi
 61f:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 622:	83 c4 10             	add    $0x10,%esp
      state = 0;
 625:	be 00 00 00 00       	mov    $0x0,%esi
 62a:	e9 39 ff ff ff       	jmp    568 <printf+0x30>
        s = (char*)*ap;
 62f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 632:	8b 30                	mov    (%eax),%esi
        ap++;
 634:	83 c0 04             	add    $0x4,%eax
 637:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 63a:	85 f6                	test   %esi,%esi
 63c:	75 28                	jne    666 <printf+0x12e>
          s = "(null)";
 63e:	be 89 08 00 00       	mov    $0x889,%esi
 643:	8b 7d 08             	mov    0x8(%ebp),%edi
 646:	eb 0d                	jmp    655 <printf+0x11d>
          putc(fd, *s);
 648:	0f be d2             	movsbl %dl,%edx
 64b:	89 f8                	mov    %edi,%eax
 64d:	e8 45 fe ff ff       	call   497 <putc>
          s++;
 652:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 655:	0f b6 16             	movzbl (%esi),%edx
 658:	84 d2                	test   %dl,%dl
 65a:	75 ec                	jne    648 <printf+0x110>
      state = 0;
 65c:	be 00 00 00 00       	mov    $0x0,%esi
 661:	e9 02 ff ff ff       	jmp    568 <printf+0x30>
 666:	8b 7d 08             	mov    0x8(%ebp),%edi
 669:	eb ea                	jmp    655 <printf+0x11d>
        putc(fd, *ap);
 66b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 66e:	0f be 17             	movsbl (%edi),%edx
 671:	8b 45 08             	mov    0x8(%ebp),%eax
 674:	e8 1e fe ff ff       	call   497 <putc>
        ap++;
 679:	83 c7 04             	add    $0x4,%edi
 67c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 67f:	be 00 00 00 00       	mov    $0x0,%esi
 684:	e9 df fe ff ff       	jmp    568 <printf+0x30>
        putc(fd, c);
 689:	89 fa                	mov    %edi,%edx
 68b:	8b 45 08             	mov    0x8(%ebp),%eax
 68e:	e8 04 fe ff ff       	call   497 <putc>
      state = 0;
 693:	be 00 00 00 00       	mov    $0x0,%esi
 698:	e9 cb fe ff ff       	jmp    568 <printf+0x30>
    }
  }
}
 69d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6a0:	5b                   	pop    %ebx
 6a1:	5e                   	pop    %esi
 6a2:	5f                   	pop    %edi
 6a3:	5d                   	pop    %ebp
 6a4:	c3                   	ret    

000006a5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a5:	f3 0f 1e fb          	endbr32 
 6a9:	55                   	push   %ebp
 6aa:	89 e5                	mov    %esp,%ebp
 6ac:	57                   	push   %edi
 6ad:	56                   	push   %esi
 6ae:	53                   	push   %ebx
 6af:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6b2:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b5:	a1 98 0b 00 00       	mov    0xb98,%eax
 6ba:	eb 02                	jmp    6be <free+0x19>
 6bc:	89 d0                	mov    %edx,%eax
 6be:	39 c8                	cmp    %ecx,%eax
 6c0:	73 04                	jae    6c6 <free+0x21>
 6c2:	39 08                	cmp    %ecx,(%eax)
 6c4:	77 12                	ja     6d8 <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c6:	8b 10                	mov    (%eax),%edx
 6c8:	39 c2                	cmp    %eax,%edx
 6ca:	77 f0                	ja     6bc <free+0x17>
 6cc:	39 c8                	cmp    %ecx,%eax
 6ce:	72 08                	jb     6d8 <free+0x33>
 6d0:	39 ca                	cmp    %ecx,%edx
 6d2:	77 04                	ja     6d8 <free+0x33>
 6d4:	89 d0                	mov    %edx,%eax
 6d6:	eb e6                	jmp    6be <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6de:	8b 10                	mov    (%eax),%edx
 6e0:	39 d7                	cmp    %edx,%edi
 6e2:	74 19                	je     6fd <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6e4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6e7:	8b 50 04             	mov    0x4(%eax),%edx
 6ea:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6ed:	39 ce                	cmp    %ecx,%esi
 6ef:	74 1b                	je     70c <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6f1:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6f3:	a3 98 0b 00 00       	mov    %eax,0xb98
}
 6f8:	5b                   	pop    %ebx
 6f9:	5e                   	pop    %esi
 6fa:	5f                   	pop    %edi
 6fb:	5d                   	pop    %ebp
 6fc:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 6fd:	03 72 04             	add    0x4(%edx),%esi
 700:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 703:	8b 10                	mov    (%eax),%edx
 705:	8b 12                	mov    (%edx),%edx
 707:	89 53 f8             	mov    %edx,-0x8(%ebx)
 70a:	eb db                	jmp    6e7 <free+0x42>
    p->s.size += bp->s.size;
 70c:	03 53 fc             	add    -0x4(%ebx),%edx
 70f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 712:	8b 53 f8             	mov    -0x8(%ebx),%edx
 715:	89 10                	mov    %edx,(%eax)
 717:	eb da                	jmp    6f3 <free+0x4e>

00000719 <morecore>:

static Header*
morecore(uint nu)
{
 719:	55                   	push   %ebp
 71a:	89 e5                	mov    %esp,%ebp
 71c:	53                   	push   %ebx
 71d:	83 ec 04             	sub    $0x4,%esp
 720:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 722:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 727:	77 05                	ja     72e <morecore+0x15>
    nu = 4096;
 729:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 72e:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 735:	83 ec 0c             	sub    $0xc,%esp
 738:	50                   	push   %eax
 739:	e8 01 fd ff ff       	call   43f <sbrk>
  if(p == (char*)-1)
 73e:	83 c4 10             	add    $0x10,%esp
 741:	83 f8 ff             	cmp    $0xffffffff,%eax
 744:	74 1c                	je     762 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 746:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 749:	83 c0 08             	add    $0x8,%eax
 74c:	83 ec 0c             	sub    $0xc,%esp
 74f:	50                   	push   %eax
 750:	e8 50 ff ff ff       	call   6a5 <free>
  return freep;
 755:	a1 98 0b 00 00       	mov    0xb98,%eax
 75a:	83 c4 10             	add    $0x10,%esp
}
 75d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 760:	c9                   	leave  
 761:	c3                   	ret    
    return 0;
 762:	b8 00 00 00 00       	mov    $0x0,%eax
 767:	eb f4                	jmp    75d <morecore+0x44>

00000769 <malloc>:

void*
malloc(uint nbytes)
{
 769:	f3 0f 1e fb          	endbr32 
 76d:	55                   	push   %ebp
 76e:	89 e5                	mov    %esp,%ebp
 770:	53                   	push   %ebx
 771:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 774:	8b 45 08             	mov    0x8(%ebp),%eax
 777:	8d 58 07             	lea    0x7(%eax),%ebx
 77a:	c1 eb 03             	shr    $0x3,%ebx
 77d:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 780:	8b 0d 98 0b 00 00    	mov    0xb98,%ecx
 786:	85 c9                	test   %ecx,%ecx
 788:	74 04                	je     78e <malloc+0x25>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 78a:	8b 01                	mov    (%ecx),%eax
 78c:	eb 4b                	jmp    7d9 <malloc+0x70>
    base.s.ptr = freep = prevp = &base;
 78e:	c7 05 98 0b 00 00 9c 	movl   $0xb9c,0xb98
 795:	0b 00 00 
 798:	c7 05 9c 0b 00 00 9c 	movl   $0xb9c,0xb9c
 79f:	0b 00 00 
    base.s.size = 0;
 7a2:	c7 05 a0 0b 00 00 00 	movl   $0x0,0xba0
 7a9:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 7ac:	b9 9c 0b 00 00       	mov    $0xb9c,%ecx
 7b1:	eb d7                	jmp    78a <malloc+0x21>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7b3:	74 1a                	je     7cf <malloc+0x66>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7b5:	29 da                	sub    %ebx,%edx
 7b7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7ba:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 7bd:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 7c0:	89 0d 98 0b 00 00    	mov    %ecx,0xb98
      return (void*)(p + 1);
 7c6:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7c9:	83 c4 04             	add    $0x4,%esp
 7cc:	5b                   	pop    %ebx
 7cd:	5d                   	pop    %ebp
 7ce:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 7cf:	8b 10                	mov    (%eax),%edx
 7d1:	89 11                	mov    %edx,(%ecx)
 7d3:	eb eb                	jmp    7c0 <malloc+0x57>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d5:	89 c1                	mov    %eax,%ecx
 7d7:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 7d9:	8b 50 04             	mov    0x4(%eax),%edx
 7dc:	39 da                	cmp    %ebx,%edx
 7de:	73 d3                	jae    7b3 <malloc+0x4a>
    if(p == freep)
 7e0:	39 05 98 0b 00 00    	cmp    %eax,0xb98
 7e6:	75 ed                	jne    7d5 <malloc+0x6c>
      if((p = morecore(nunits)) == 0)
 7e8:	89 d8                	mov    %ebx,%eax
 7ea:	e8 2a ff ff ff       	call   719 <morecore>
 7ef:	85 c0                	test   %eax,%eax
 7f1:	75 e2                	jne    7d5 <malloc+0x6c>
 7f3:	eb d4                	jmp    7c9 <malloc+0x60>
