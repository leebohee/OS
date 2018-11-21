
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 84 02 00 00       	call   29a <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 0e 03 00 00       	call   332 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 76 02 00 00       	call   2a2 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  34:	8b 45 08             	mov    0x8(%ebp),%eax
  37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 55 08             	mov    0x8(%ebp),%edx
  68:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6b:	0f b6 02             	movzbl (%edx),%eax
  6e:	0f b6 19             	movzbl (%ecx),%ebx
  71:	84 c0                	test   %al,%al
  73:	75 1e                	jne    93 <strcmp+0x33>
  75:	eb 29                	jmp    a0 <strcmp+0x40>
  77:	89 f6                	mov    %esi,%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  80:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  86:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  89:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  8d:	84 c0                	test   %al,%al
  8f:	74 0f                	je     a0 <strcmp+0x40>
  91:	89 f1                	mov    %esi,%ecx
  93:	38 d8                	cmp    %bl,%al
  95:	74 e9                	je     80 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  97:	29 d8                	sub    %ebx,%eax
}
  99:	5b                   	pop    %ebx
  9a:	5e                   	pop    %esi
  9b:	5d                   	pop    %ebp
  9c:	c3                   	ret    
  9d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  a0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a2:	29 d8                	sub    %ebx,%eax
}
  a4:	5b                   	pop    %ebx
  a5:	5e                   	pop    %esi
  a6:	5d                   	pop    %ebp
  a7:	c3                   	ret    
  a8:	90                   	nop
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 12                	je     cd <strlen+0x1d>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  cd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  cf:	5d                   	pop    %ebp
  d0:	c3                   	ret    
  d1:	eb 0d                	jmp    e0 <memset>
  d3:	90                   	nop
  d4:	90                   	nop
  d5:	90                   	nop
  d6:	90                   	nop
  d7:	90                   	nop
  d8:	90                   	nop
  d9:	90                   	nop
  da:	90                   	nop
  db:	90                   	nop
  dc:	90                   	nop
  dd:	90                   	nop
  de:	90                   	nop
  df:	90                   	nop

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	74 1d                	je     12e <strchr+0x2e>
    if(*s == c)
 111:	38 d3                	cmp    %dl,%bl
 113:	89 d9                	mov    %ebx,%ecx
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 12e:	31 c0                	xor    %eax,%eax
}
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 148:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 14b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14e:	eb 29                	jmp    179 <gets+0x39>
    cc = read(0, &c, 1);
 150:	83 ec 04             	sub    $0x4,%esp
 153:	6a 01                	push   $0x1
 155:	57                   	push   %edi
 156:	6a 00                	push   $0x0
 158:	e8 5d 01 00 00       	call   2ba <read>
    if(cc < 1)
 15d:	83 c4 10             	add    $0x10,%esp
 160:	85 c0                	test   %eax,%eax
 162:	7e 1d                	jle    181 <gets+0x41>
      break;
    buf[i++] = c;
 164:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 168:	8b 55 08             	mov    0x8(%ebp),%edx
 16b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 16d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 16f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 173:	74 1b                	je     190 <gets+0x50>
 175:	3c 0d                	cmp    $0xd,%al
 177:	74 17                	je     190 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 179:	8d 5e 01             	lea    0x1(%esi),%ebx
 17c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 17f:	7c cf                	jl     150 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 181:	8b 45 08             	mov    0x8(%ebp),%eax
 184:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 188:	8d 65 f4             	lea    -0xc(%ebp),%esp
 18b:	5b                   	pop    %ebx
 18c:	5e                   	pop    %esi
 18d:	5f                   	pop    %edi
 18e:	5d                   	pop    %ebp
 18f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 190:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 193:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 195:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 199:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19c:	5b                   	pop    %ebx
 19d:	5e                   	pop    %esi
 19e:	5f                   	pop    %edi
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
 1a1:	eb 0d                	jmp    1b0 <stat>
 1a3:	90                   	nop
 1a4:	90                   	nop
 1a5:	90                   	nop
 1a6:	90                   	nop
 1a7:	90                   	nop
 1a8:	90                   	nop
 1a9:	90                   	nop
 1aa:	90                   	nop
 1ab:	90                   	nop
 1ac:	90                   	nop
 1ad:	90                   	nop
 1ae:	90                   	nop
 1af:	90                   	nop

000001b0 <stat>:

int
stat(char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	6a 00                	push   $0x0
 1ba:	ff 75 08             	pushl  0x8(%ebp)
 1bd:	e8 20 01 00 00       	call   2e2 <open>
  if(fd < 0)
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	85 c0                	test   %eax,%eax
 1c7:	78 27                	js     1f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1c9:	83 ec 08             	sub    $0x8,%esp
 1cc:	ff 75 0c             	pushl  0xc(%ebp)
 1cf:	89 c3                	mov    %eax,%ebx
 1d1:	50                   	push   %eax
 1d2:	e8 23 01 00 00       	call   2fa <fstat>
 1d7:	89 c6                	mov    %eax,%esi
  close(fd);
 1d9:	89 1c 24             	mov    %ebx,(%esp)
 1dc:	e8 e9 00 00 00       	call   2ca <close>
  return r;
 1e1:	83 c4 10             	add    $0x10,%esp
 1e4:	89 f0                	mov    %esi,%eax
}
 1e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1f5:	eb ef                	jmp    1e6 <stat+0x36>
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
 205:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
 208:	0f be 13             	movsbl (%ebx),%edx
 20b:	80 fa 2d             	cmp    $0x2d,%dl
 20e:	74 38                	je     248 <atoi+0x48>
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 210:	8d 42 d0             	lea    -0x30(%edx),%eax

int
atoi(const char *s)
{
  int n;
	int sign=0;	// let positive as 0, negative as 1
 213:	31 f6                	xor    %esi,%esi
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 215:	3c 09                	cmp    $0x9,%al
 217:	77 47                	ja     260 <atoi+0x60>
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
		sign=1;
 219:	31 c0                	xor    %eax,%eax
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		s++;
	}

  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
 220:	8d 04 80             	lea    (%eax,%eax,4),%eax
 223:	83 c3 01             	add    $0x1,%ebx
 226:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 22a:	0f be 13             	movsbl (%ebx),%edx
 22d:	8d 4a d0             	lea    -0x30(%edx),%ecx
 230:	80 f9 09             	cmp    $0x9,%cl
 233:	76 eb                	jbe    220 <atoi+0x20>
 235:	89 c2                	mov    %eax,%edx
 237:	f7 da                	neg    %edx
 239:	83 fe 01             	cmp    $0x1,%esi
 23c:	0f 44 c2             	cmove  %edx,%eax
  if(sign==1){
		return n*(-1);
	}

	return n;
}
 23f:	5b                   	pop    %ebx
 240:	5e                   	pop    %esi
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	90                   	nop
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 248:	0f be 53 01          	movsbl 0x1(%ebx),%edx

  n = 0;

	if(*s=='-'){
		sign=1;
		s++;
 24c:	8d 43 01             	lea    0x1(%ebx),%eax
	}

  while('0' <= *s && *s <= '9')
 24f:	8d 4a d0             	lea    -0x30(%edx),%ecx
 252:	80 f9 09             	cmp    $0x9,%cl
 255:	77 09                	ja     260 <atoi+0x60>

  n = 0;

	if(*s=='-'){
		sign=1;
		s++;
 257:	89 c3                	mov    %eax,%ebx
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
		sign=1;
 259:	be 01 00 00 00       	mov    $0x1,%esi
 25e:	eb b9                	jmp    219 <atoi+0x19>
		s++;
	}

  while('0' <= *s && *s <= '9')
 260:	31 c0                	xor    %eax,%eax
 262:	eb db                	jmp    23f <atoi+0x3f>
 264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 26a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000270 <memmove>:
	return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
 275:	8b 5d 10             	mov    0x10(%ebp),%ebx
 278:	8b 45 08             	mov    0x8(%ebp),%eax
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 db                	test   %ebx,%ebx
 280:	7e 14                	jle    296 <memmove+0x26>
 282:	31 d2                	xor    %edx,%edx
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 288:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 28c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 292:	39 da                	cmp    %ebx,%edx
 294:	75 f2                	jne    288 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    

0000029a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29a:	b8 01 00 00 00       	mov    $0x1,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <exit>:
SYSCALL(exit)
 2a2:	b8 02 00 00 00       	mov    $0x2,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <wait>:
SYSCALL(wait)
 2aa:	b8 03 00 00 00       	mov    $0x3,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <pipe>:
SYSCALL(pipe)
 2b2:	b8 04 00 00 00       	mov    $0x4,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <read>:
SYSCALL(read)
 2ba:	b8 05 00 00 00       	mov    $0x5,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <write>:
SYSCALL(write)
 2c2:	b8 10 00 00 00       	mov    $0x10,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <close>:
SYSCALL(close)
 2ca:	b8 15 00 00 00       	mov    $0x15,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <kill>:
SYSCALL(kill)
 2d2:	b8 06 00 00 00       	mov    $0x6,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <exec>:
SYSCALL(exec)
 2da:	b8 07 00 00 00       	mov    $0x7,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <open>:
SYSCALL(open)
 2e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mknod>:
SYSCALL(mknod)
 2ea:	b8 11 00 00 00       	mov    $0x11,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <unlink>:
SYSCALL(unlink)
 2f2:	b8 12 00 00 00       	mov    $0x12,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <fstat>:
SYSCALL(fstat)
 2fa:	b8 08 00 00 00       	mov    $0x8,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <link>:
SYSCALL(link)
 302:	b8 13 00 00 00       	mov    $0x13,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mkdir>:
SYSCALL(mkdir)
 30a:	b8 14 00 00 00       	mov    $0x14,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <chdir>:
SYSCALL(chdir)
 312:	b8 09 00 00 00       	mov    $0x9,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <dup>:
SYSCALL(dup)
 31a:	b8 0a 00 00 00       	mov    $0xa,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <getpid>:
SYSCALL(getpid)
 322:	b8 0b 00 00 00       	mov    $0xb,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <sbrk>:
SYSCALL(sbrk)
 32a:	b8 0c 00 00 00       	mov    $0xc,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <sleep>:
SYSCALL(sleep)
 332:	b8 0d 00 00 00       	mov    $0xd,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <uptime>:
SYSCALL(uptime)
 33a:	b8 0e 00 00 00       	mov    $0xe,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <halt>:
SYSCALL(halt)
 342:	b8 16 00 00 00       	mov    $0x16,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <setnice>:
//////////////////////
SYSCALL(setnice)
 34a:	b8 18 00 00 00       	mov    $0x18,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <getnice>:
SYSCALL(getnice)
 352:	b8 17 00 00 00       	mov    $0x17,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <ps>:
SYSCALL(ps)
 35a:	b8 19 00 00 00       	mov    $0x19,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    
 362:	66 90                	xchg   %ax,%ax
 364:	66 90                	xchg   %ax,%ax
 366:	66 90                	xchg   %ax,%ax
 368:	66 90                	xchg   %ax,%ax
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	89 c6                	mov    %eax,%esi
 378:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 37e:	85 db                	test   %ebx,%ebx
 380:	74 7e                	je     400 <printint+0x90>
 382:	89 d0                	mov    %edx,%eax
 384:	c1 e8 1f             	shr    $0x1f,%eax
 387:	84 c0                	test   %al,%al
 389:	74 75                	je     400 <printint+0x90>
    neg = 1;
    x = -xx;
 38b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 38d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 394:	f7 d8                	neg    %eax
 396:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 399:	31 ff                	xor    %edi,%edi
 39b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 39e:	89 ce                	mov    %ecx,%esi
 3a0:	eb 08                	jmp    3aa <printint+0x3a>
 3a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3a8:	89 cf                	mov    %ecx,%edi
 3aa:	31 d2                	xor    %edx,%edx
 3ac:	8d 4f 01             	lea    0x1(%edi),%ecx
 3af:	f7 f6                	div    %esi
 3b1:	0f b6 92 38 07 00 00 	movzbl 0x738(%edx),%edx
  }while((x /= base) != 0);
 3b8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3bd:	75 e9                	jne    3a8 <printint+0x38>
  if(neg)
 3bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3c2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3c5:	85 c0                	test   %eax,%eax
 3c7:	74 08                	je     3d1 <printint+0x61>
    buf[i++] = '-';
 3c9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3ce:	8d 4f 02             	lea    0x2(%edi),%ecx
 3d1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3d5:	8d 76 00             	lea    0x0(%esi),%esi
 3d8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3db:	83 ec 04             	sub    $0x4,%esp
 3de:	83 ef 01             	sub    $0x1,%edi
 3e1:	6a 01                	push   $0x1
 3e3:	53                   	push   %ebx
 3e4:	56                   	push   %esi
 3e5:	88 45 d7             	mov    %al,-0x29(%ebp)
 3e8:	e8 d5 fe ff ff       	call   2c2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ed:	83 c4 10             	add    $0x10,%esp
 3f0:	39 df                	cmp    %ebx,%edi
 3f2:	75 e4                	jne    3d8 <printint+0x68>
    putc(fd, buf[i]);
}
 3f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f7:	5b                   	pop    %ebx
 3f8:	5e                   	pop    %esi
 3f9:	5f                   	pop    %edi
 3fa:	5d                   	pop    %ebp
 3fb:	c3                   	ret    
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 400:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 402:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 409:	eb 8b                	jmp    396 <printint+0x26>
 40b:	90                   	nop
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000410 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 416:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 419:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 41c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 41f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 422:	89 45 d0             	mov    %eax,-0x30(%ebp)
 425:	0f b6 1e             	movzbl (%esi),%ebx
 428:	83 c6 01             	add    $0x1,%esi
 42b:	84 db                	test   %bl,%bl
 42d:	0f 84 b0 00 00 00    	je     4e3 <printf+0xd3>
 433:	31 d2                	xor    %edx,%edx
 435:	eb 39                	jmp    470 <printf+0x60>
 437:	89 f6                	mov    %esi,%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 440:	83 f8 25             	cmp    $0x25,%eax
 443:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 446:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 44b:	74 18                	je     465 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 44d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 450:	83 ec 04             	sub    $0x4,%esp
 453:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 456:	6a 01                	push   $0x1
 458:	50                   	push   %eax
 459:	57                   	push   %edi
 45a:	e8 63 fe ff ff       	call   2c2 <write>
 45f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 462:	83 c4 10             	add    $0x10,%esp
 465:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 468:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 46c:	84 db                	test   %bl,%bl
 46e:	74 73                	je     4e3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 470:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 472:	0f be cb             	movsbl %bl,%ecx
 475:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 478:	74 c6                	je     440 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 47a:	83 fa 25             	cmp    $0x25,%edx
 47d:	75 e6                	jne    465 <printf+0x55>
      if(c == 'd'){
 47f:	83 f8 64             	cmp    $0x64,%eax
 482:	0f 84 f8 00 00 00    	je     580 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 488:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 48e:	83 f9 70             	cmp    $0x70,%ecx
 491:	74 5d                	je     4f0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 493:	83 f8 73             	cmp    $0x73,%eax
 496:	0f 84 84 00 00 00    	je     520 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 49c:	83 f8 63             	cmp    $0x63,%eax
 49f:	0f 84 ea 00 00 00    	je     58f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4a5:	83 f8 25             	cmp    $0x25,%eax
 4a8:	0f 84 c2 00 00 00    	je     570 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ae:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b1:	83 ec 04             	sub    $0x4,%esp
 4b4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4b8:	6a 01                	push   $0x1
 4ba:	50                   	push   %eax
 4bb:	57                   	push   %edi
 4bc:	e8 01 fe ff ff       	call   2c2 <write>
 4c1:	83 c4 0c             	add    $0xc,%esp
 4c4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4c7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4ca:	6a 01                	push   $0x1
 4cc:	50                   	push   %eax
 4cd:	57                   	push   %edi
 4ce:	83 c6 01             	add    $0x1,%esi
 4d1:	e8 ec fd ff ff       	call   2c2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4da:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4dd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4df:	84 db                	test   %bl,%bl
 4e1:	75 8d                	jne    470 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e6:	5b                   	pop    %ebx
 4e7:	5e                   	pop    %esi
 4e8:	5f                   	pop    %edi
 4e9:	5d                   	pop    %ebp
 4ea:	c3                   	ret    
 4eb:	90                   	nop
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4f0:	83 ec 0c             	sub    $0xc,%esp
 4f3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4f8:	6a 00                	push   $0x0
 4fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4fd:	89 f8                	mov    %edi,%eax
 4ff:	8b 13                	mov    (%ebx),%edx
 501:	e8 6a fe ff ff       	call   370 <printint>
        ap++;
 506:	89 d8                	mov    %ebx,%eax
 508:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 50b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 50d:	83 c0 04             	add    $0x4,%eax
 510:	89 45 d0             	mov    %eax,-0x30(%ebp)
 513:	e9 4d ff ff ff       	jmp    465 <printf+0x55>
 518:	90                   	nop
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 520:	8b 45 d0             	mov    -0x30(%ebp),%eax
 523:	8b 18                	mov    (%eax),%ebx
        ap++;
 525:	83 c0 04             	add    $0x4,%eax
 528:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 52b:	b8 30 07 00 00       	mov    $0x730,%eax
 530:	85 db                	test   %ebx,%ebx
 532:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 535:	0f b6 03             	movzbl (%ebx),%eax
 538:	84 c0                	test   %al,%al
 53a:	74 23                	je     55f <printf+0x14f>
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 540:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 543:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 546:	83 ec 04             	sub    $0x4,%esp
 549:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 54b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 54e:	50                   	push   %eax
 54f:	57                   	push   %edi
 550:	e8 6d fd ff ff       	call   2c2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 555:	0f b6 03             	movzbl (%ebx),%eax
 558:	83 c4 10             	add    $0x10,%esp
 55b:	84 c0                	test   %al,%al
 55d:	75 e1                	jne    540 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55f:	31 d2                	xor    %edx,%edx
 561:	e9 ff fe ff ff       	jmp    465 <printf+0x55>
 566:	8d 76 00             	lea    0x0(%esi),%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 570:	83 ec 04             	sub    $0x4,%esp
 573:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 576:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 579:	6a 01                	push   $0x1
 57b:	e9 4c ff ff ff       	jmp    4cc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 580:	83 ec 0c             	sub    $0xc,%esp
 583:	b9 0a 00 00 00       	mov    $0xa,%ecx
 588:	6a 01                	push   $0x1
 58a:	e9 6b ff ff ff       	jmp    4fa <printf+0xea>
 58f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 592:	83 ec 04             	sub    $0x4,%esp
 595:	8b 03                	mov    (%ebx),%eax
 597:	6a 01                	push   $0x1
 599:	88 45 e4             	mov    %al,-0x1c(%ebp)
 59c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 59f:	50                   	push   %eax
 5a0:	57                   	push   %edi
 5a1:	e8 1c fd ff ff       	call   2c2 <write>
 5a6:	e9 5b ff ff ff       	jmp    506 <printf+0xf6>
 5ab:	66 90                	xchg   %ax,%ax
 5ad:	66 90                	xchg   %ax,%ax
 5af:	90                   	nop

000005b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b1:	a1 d8 09 00 00       	mov    0x9d8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b6:	89 e5                	mov    %esp,%ebp
 5b8:	57                   	push   %edi
 5b9:	56                   	push   %esi
 5ba:	53                   	push   %ebx
 5bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5be:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5c0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c3:	39 c8                	cmp    %ecx,%eax
 5c5:	73 19                	jae    5e0 <free+0x30>
 5c7:	89 f6                	mov    %esi,%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 5d0:	39 d1                	cmp    %edx,%ecx
 5d2:	72 1c                	jb     5f0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d4:	39 d0                	cmp    %edx,%eax
 5d6:	73 18                	jae    5f0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5da:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5dc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5de:	72 f0                	jb     5d0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e0:	39 d0                	cmp    %edx,%eax
 5e2:	72 f4                	jb     5d8 <free+0x28>
 5e4:	39 d1                	cmp    %edx,%ecx
 5e6:	73 f0                	jae    5d8 <free+0x28>
 5e8:	90                   	nop
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5f6:	39 d7                	cmp    %edx,%edi
 5f8:	74 19                	je     613 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5fd:	8b 50 04             	mov    0x4(%eax),%edx
 600:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 603:	39 f1                	cmp    %esi,%ecx
 605:	74 23                	je     62a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 607:	89 08                	mov    %ecx,(%eax)
  freep = p;
 609:	a3 d8 09 00 00       	mov    %eax,0x9d8
}
 60e:	5b                   	pop    %ebx
 60f:	5e                   	pop    %esi
 610:	5f                   	pop    %edi
 611:	5d                   	pop    %ebp
 612:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 613:	03 72 04             	add    0x4(%edx),%esi
 616:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 619:	8b 10                	mov    (%eax),%edx
 61b:	8b 12                	mov    (%edx),%edx
 61d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 620:	8b 50 04             	mov    0x4(%eax),%edx
 623:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 626:	39 f1                	cmp    %esi,%ecx
 628:	75 dd                	jne    607 <free+0x57>
    p->s.size += bp->s.size;
 62a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 62d:	a3 d8 09 00 00       	mov    %eax,0x9d8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 632:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 635:	8b 53 f8             	mov    -0x8(%ebx),%edx
 638:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 63a:	5b                   	pop    %ebx
 63b:	5e                   	pop    %esi
 63c:	5f                   	pop    %edi
 63d:	5d                   	pop    %ebp
 63e:	c3                   	ret    
 63f:	90                   	nop

00000640 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 649:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 64c:	8b 15 d8 09 00 00    	mov    0x9d8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 652:	8d 78 07             	lea    0x7(%eax),%edi
 655:	c1 ef 03             	shr    $0x3,%edi
 658:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 65b:	85 d2                	test   %edx,%edx
 65d:	0f 84 a3 00 00 00    	je     706 <malloc+0xc6>
 663:	8b 02                	mov    (%edx),%eax
 665:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 668:	39 cf                	cmp    %ecx,%edi
 66a:	76 74                	jbe    6e0 <malloc+0xa0>
 66c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 672:	be 00 10 00 00       	mov    $0x1000,%esi
 677:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 67e:	0f 43 f7             	cmovae %edi,%esi
 681:	ba 00 80 00 00       	mov    $0x8000,%edx
 686:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 68c:	0f 46 da             	cmovbe %edx,%ebx
 68f:	eb 10                	jmp    6a1 <malloc+0x61>
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 698:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 69a:	8b 48 04             	mov    0x4(%eax),%ecx
 69d:	39 cf                	cmp    %ecx,%edi
 69f:	76 3f                	jbe    6e0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6a1:	39 05 d8 09 00 00    	cmp    %eax,0x9d8
 6a7:	89 c2                	mov    %eax,%edx
 6a9:	75 ed                	jne    698 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6ab:	83 ec 0c             	sub    $0xc,%esp
 6ae:	53                   	push   %ebx
 6af:	e8 76 fc ff ff       	call   32a <sbrk>
  if(p == (char*)-1)
 6b4:	83 c4 10             	add    $0x10,%esp
 6b7:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ba:	74 1c                	je     6d8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6bc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6bf:	83 ec 0c             	sub    $0xc,%esp
 6c2:	83 c0 08             	add    $0x8,%eax
 6c5:	50                   	push   %eax
 6c6:	e8 e5 fe ff ff       	call   5b0 <free>
  return freep;
 6cb:	8b 15 d8 09 00 00    	mov    0x9d8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6d1:	83 c4 10             	add    $0x10,%esp
 6d4:	85 d2                	test   %edx,%edx
 6d6:	75 c0                	jne    698 <malloc+0x58>
        return 0;
 6d8:	31 c0                	xor    %eax,%eax
 6da:	eb 1c                	jmp    6f8 <malloc+0xb8>
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6e0:	39 cf                	cmp    %ecx,%edi
 6e2:	74 1c                	je     700 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6e4:	29 f9                	sub    %edi,%ecx
 6e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6ec:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 6ef:	89 15 d8 09 00 00    	mov    %edx,0x9d8
      return (void*)(p + 1);
 6f5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6fb:	5b                   	pop    %ebx
 6fc:	5e                   	pop    %esi
 6fd:	5f                   	pop    %edi
 6fe:	5d                   	pop    %ebp
 6ff:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 700:	8b 08                	mov    (%eax),%ecx
 702:	89 0a                	mov    %ecx,(%edx)
 704:	eb e9                	jmp    6ef <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 706:	c7 05 d8 09 00 00 dc 	movl   $0x9dc,0x9d8
 70d:	09 00 00 
 710:	c7 05 dc 09 00 00 dc 	movl   $0x9dc,0x9dc
 717:	09 00 00 
    base.s.size = 0;
 71a:	b8 dc 09 00 00       	mov    $0x9dc,%eax
 71f:	c7 05 e0 09 00 00 00 	movl   $0x0,0x9e0
 726:	00 00 00 
 729:	e9 3e ff ff ff       	jmp    66c <malloc+0x2c>
