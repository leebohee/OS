
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
  }
}

int
main(int argc, char *argv[])
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;

  if(argc <= 1){
  27:	7e 54                	jle    7d <main+0x7d>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 86 03 00 00       	call   3c2 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 24                	js     69 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 3c 00 00 00       	call   90 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 4e 03 00 00       	call   3aa <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  64:	e8 19 03 00 00       	call   382 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  69:	50                   	push   %eax
  6a:	ff 33                	pushl  (%ebx)
  6c:	68 33 08 00 00       	push   $0x833
  71:	6a 01                	push   $0x1
  73:	e8 78 04 00 00       	call   4f0 <printf>
      exit();
  78:	e8 05 03 00 00       	call   382 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 f6 02 00 00       	call   382 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:

char buf[512];

void
cat(int fd)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  98:	eb 1d                	jmp    b7 <cat+0x27>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 60 0b 00 00       	push   $0xb60
  a9:	6a 01                	push   $0x1
  ab:	e8 f2 02 00 00       	call   3a2 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 c3                	cmp    %eax,%ebx
  b5:	75 26                	jne    dd <cat+0x4d>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 60 0b 00 00       	push   $0xb60
  c4:	56                   	push   %esi
  c5:	e8 d0 02 00 00       	call   39a <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	83 f8 00             	cmp    $0x0,%eax
  d0:	89 c3                	mov    %eax,%ebx
  d2:	7f cc                	jg     a0 <cat+0x10>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit();
    }
  }
  if(n < 0){
  d4:	75 1b                	jne    f1 <cat+0x61>
    printf(1, "cat: read error\n");
    exit();
  }
}
  d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d9:	5b                   	pop    %ebx
  da:	5e                   	pop    %esi
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
  dd:	83 ec 08             	sub    $0x8,%esp
  e0:	68 10 08 00 00       	push   $0x810
  e5:	6a 01                	push   $0x1
  e7:	e8 04 04 00 00       	call   4f0 <printf>
      exit();
  ec:	e8 91 02 00 00       	call   382 <exit>
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
  f1:	83 ec 08             	sub    $0x8,%esp
  f4:	68 22 08 00 00       	push   $0x822
  f9:	6a 01                	push   $0x1
  fb:	e8 f0 03 00 00       	call   4f0 <printf>
    exit();
 100:	e8 7d 02 00 00       	call   382 <exit>
 105:	66 90                	xchg   %ax,%ax
 107:	66 90                	xchg   %ax,%ax
 109:	66 90                	xchg   %ax,%ax
 10b:	66 90                	xchg   %ax,%ax
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	89 c2                	mov    %eax,%edx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 120:	83 c1 01             	add    $0x1,%ecx
 123:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 db                	test   %bl,%bl
 12c:	88 5a ff             	mov    %bl,-0x1(%edx)
 12f:	75 ef                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 131:	5b                   	pop    %ebx
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
 134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 13a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	56                   	push   %esi
 144:	53                   	push   %ebx
 145:	8b 55 08             	mov    0x8(%ebp),%edx
 148:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14b:	0f b6 02             	movzbl (%edx),%eax
 14e:	0f b6 19             	movzbl (%ecx),%ebx
 151:	84 c0                	test   %al,%al
 153:	75 1e                	jne    173 <strcmp+0x33>
 155:	eb 29                	jmp    180 <strcmp+0x40>
 157:	89 f6                	mov    %esi,%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 160:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 163:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 166:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 169:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 16d:	84 c0                	test   %al,%al
 16f:	74 0f                	je     180 <strcmp+0x40>
 171:	89 f1                	mov    %esi,%ecx
 173:	38 d8                	cmp    %bl,%al
 175:	74 e9                	je     160 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 177:	29 d8                	sub    %ebx,%eax
}
 179:	5b                   	pop    %ebx
 17a:	5e                   	pop    %esi
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret    
 17d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 180:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 182:	29 d8                	sub    %ebx,%eax
}
 184:	5b                   	pop    %ebx
 185:	5e                   	pop    %esi
 186:	5d                   	pop    %ebp
 187:	c3                   	ret    
 188:	90                   	nop
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000190 <strlen>:

uint
strlen(char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 196:	80 39 00             	cmpb   $0x0,(%ecx)
 199:	74 12                	je     1ad <strlen+0x1d>
 19b:	31 d2                	xor    %edx,%edx
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1ad:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1af:	5d                   	pop    %ebp
 1b0:	c3                   	ret    
 1b1:	eb 0d                	jmp    1c0 <memset>
 1b3:	90                   	nop
 1b4:	90                   	nop
 1b5:	90                   	nop
 1b6:	90                   	nop
 1b7:	90                   	nop
 1b8:	90                   	nop
 1b9:	90                   	nop
 1ba:	90                   	nop
 1bb:	90                   	nop
 1bc:	90                   	nop
 1bd:	90                   	nop
 1be:	90                   	nop
 1bf:	90                   	nop

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	89 d0                	mov    %edx,%eax
 1d4:	5f                   	pop    %edi
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	74 1d                	je     20e <strchr+0x2e>
    if(*s == c)
 1f1:	38 d3                	cmp    %dl,%bl
 1f3:	89 d9                	mov    %ebx,%ecx
 1f5:	75 0d                	jne    204 <strchr+0x24>
 1f7:	eb 17                	jmp    210 <strchr+0x30>
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 200:	38 ca                	cmp    %cl,%dl
 202:	74 0c                	je     210 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 204:	83 c0 01             	add    $0x1,%eax
 207:	0f b6 10             	movzbl (%eax),%edx
 20a:	84 d2                	test   %dl,%dl
 20c:	75 f2                	jne    200 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 20e:	31 c0                	xor    %eax,%eax
}
 210:	5b                   	pop    %ebx
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 226:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 228:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 22b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22e:	eb 29                	jmp    259 <gets+0x39>
    cc = read(0, &c, 1);
 230:	83 ec 04             	sub    $0x4,%esp
 233:	6a 01                	push   $0x1
 235:	57                   	push   %edi
 236:	6a 00                	push   $0x0
 238:	e8 5d 01 00 00       	call   39a <read>
    if(cc < 1)
 23d:	83 c4 10             	add    $0x10,%esp
 240:	85 c0                	test   %eax,%eax
 242:	7e 1d                	jle    261 <gets+0x41>
      break;
    buf[i++] = c;
 244:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 248:	8b 55 08             	mov    0x8(%ebp),%edx
 24b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 24d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 24f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 253:	74 1b                	je     270 <gets+0x50>
 255:	3c 0d                	cmp    $0xd,%al
 257:	74 17                	je     270 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 259:	8d 5e 01             	lea    0x1(%esi),%ebx
 25c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 25f:	7c cf                	jl     230 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 268:	8d 65 f4             	lea    -0xc(%ebp),%esp
 26b:	5b                   	pop    %ebx
 26c:	5e                   	pop    %esi
 26d:	5f                   	pop    %edi
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 270:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 273:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 275:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 279:	8d 65 f4             	lea    -0xc(%ebp),%esp
 27c:	5b                   	pop    %ebx
 27d:	5e                   	pop    %esi
 27e:	5f                   	pop    %edi
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	eb 0d                	jmp    290 <stat>
 283:	90                   	nop
 284:	90                   	nop
 285:	90                   	nop
 286:	90                   	nop
 287:	90                   	nop
 288:	90                   	nop
 289:	90                   	nop
 28a:	90                   	nop
 28b:	90                   	nop
 28c:	90                   	nop
 28d:	90                   	nop
 28e:	90                   	nop
 28f:	90                   	nop

00000290 <stat>:

int
stat(char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	pushl  0x8(%ebp)
 29d:	e8 20 01 00 00       	call   3c2 <open>
  if(fd < 0)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 27                	js     2d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	pushl  0xc(%ebp)
 2af:	89 c3                	mov    %eax,%ebx
 2b1:	50                   	push   %eax
 2b2:	e8 23 01 00 00       	call   3da <fstat>
 2b7:	89 c6                	mov    %eax,%esi
  close(fd);
 2b9:	89 1c 24             	mov    %ebx,(%esp)
 2bc:	e8 e9 00 00 00       	call   3aa <close>
  return r;
 2c1:	83 c4 10             	add    $0x10,%esp
 2c4:	89 f0                	mov    %esi,%eax
}
 2c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2d5:	eb ef                	jmp    2c6 <stat+0x36>
 2d7:	89 f6                	mov    %esi,%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002e0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	56                   	push   %esi
 2e4:	53                   	push   %ebx
 2e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
 2e8:	0f be 13             	movsbl (%ebx),%edx
 2eb:	80 fa 2d             	cmp    $0x2d,%dl
 2ee:	74 38                	je     328 <atoi+0x48>
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 2f0:	8d 42 d0             	lea    -0x30(%edx),%eax

int
atoi(const char *s)
{
  int n;
	int sign=0;	// let positive as 0, negative as 1
 2f3:	31 f6                	xor    %esi,%esi
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 2f5:	3c 09                	cmp    $0x9,%al
 2f7:	77 47                	ja     340 <atoi+0x60>
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
		sign=1;
 2f9:	31 c0                	xor    %eax,%eax
 2fb:	90                   	nop
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		s++;
	}

  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
 300:	8d 04 80             	lea    (%eax,%eax,4),%eax
 303:	83 c3 01             	add    $0x1,%ebx
 306:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 30a:	0f be 13             	movsbl (%ebx),%edx
 30d:	8d 4a d0             	lea    -0x30(%edx),%ecx
 310:	80 f9 09             	cmp    $0x9,%cl
 313:	76 eb                	jbe    300 <atoi+0x20>
 315:	89 c2                	mov    %eax,%edx
 317:	f7 da                	neg    %edx
 319:	83 fe 01             	cmp    $0x1,%esi
 31c:	0f 44 c2             	cmove  %edx,%eax
  if(sign==1){
		return n*(-1);
	}

	return n;
}
 31f:	5b                   	pop    %ebx
 320:	5e                   	pop    %esi
 321:	5d                   	pop    %ebp
 322:	c3                   	ret    
 323:	90                   	nop
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 328:	0f be 53 01          	movsbl 0x1(%ebx),%edx

  n = 0;

	if(*s=='-'){
		sign=1;
		s++;
 32c:	8d 43 01             	lea    0x1(%ebx),%eax
	}

  while('0' <= *s && *s <= '9')
 32f:	8d 4a d0             	lea    -0x30(%edx),%ecx
 332:	80 f9 09             	cmp    $0x9,%cl
 335:	77 09                	ja     340 <atoi+0x60>

  n = 0;

	if(*s=='-'){
		sign=1;
		s++;
 337:	89 c3                	mov    %eax,%ebx
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
		sign=1;
 339:	be 01 00 00 00       	mov    $0x1,%esi
 33e:	eb b9                	jmp    2f9 <atoi+0x19>
		s++;
	}

  while('0' <= *s && *s <= '9')
 340:	31 c0                	xor    %eax,%eax
 342:	eb db                	jmp    31f <atoi+0x3f>
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000350 <memmove>:
	return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	8b 5d 10             	mov    0x10(%ebp),%ebx
 358:	8b 45 08             	mov    0x8(%ebp),%eax
 35b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35e:	85 db                	test   %ebx,%ebx
 360:	7e 14                	jle    376 <memmove+0x26>
 362:	31 d2                	xor    %edx,%edx
 364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 368:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 36c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 36f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 372:	39 da                	cmp    %ebx,%edx
 374:	75 f2                	jne    368 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 376:	5b                   	pop    %ebx
 377:	5e                   	pop    %esi
 378:	5d                   	pop    %ebp
 379:	c3                   	ret    

0000037a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 37a:	b8 01 00 00 00       	mov    $0x1,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <exit>:
SYSCALL(exit)
 382:	b8 02 00 00 00       	mov    $0x2,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <wait>:
SYSCALL(wait)
 38a:	b8 03 00 00 00       	mov    $0x3,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <pipe>:
SYSCALL(pipe)
 392:	b8 04 00 00 00       	mov    $0x4,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <read>:
SYSCALL(read)
 39a:	b8 05 00 00 00       	mov    $0x5,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <write>:
SYSCALL(write)
 3a2:	b8 10 00 00 00       	mov    $0x10,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <close>:
SYSCALL(close)
 3aa:	b8 15 00 00 00       	mov    $0x15,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <kill>:
SYSCALL(kill)
 3b2:	b8 06 00 00 00       	mov    $0x6,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <exec>:
SYSCALL(exec)
 3ba:	b8 07 00 00 00       	mov    $0x7,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <open>:
SYSCALL(open)
 3c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <mknod>:
SYSCALL(mknod)
 3ca:	b8 11 00 00 00       	mov    $0x11,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <unlink>:
SYSCALL(unlink)
 3d2:	b8 12 00 00 00       	mov    $0x12,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <fstat>:
SYSCALL(fstat)
 3da:	b8 08 00 00 00       	mov    $0x8,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <link>:
SYSCALL(link)
 3e2:	b8 13 00 00 00       	mov    $0x13,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <mkdir>:
SYSCALL(mkdir)
 3ea:	b8 14 00 00 00       	mov    $0x14,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <chdir>:
SYSCALL(chdir)
 3f2:	b8 09 00 00 00       	mov    $0x9,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <dup>:
SYSCALL(dup)
 3fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <getpid>:
SYSCALL(getpid)
 402:	b8 0b 00 00 00       	mov    $0xb,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <sbrk>:
SYSCALL(sbrk)
 40a:	b8 0c 00 00 00       	mov    $0xc,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <sleep>:
SYSCALL(sleep)
 412:	b8 0d 00 00 00       	mov    $0xd,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <uptime>:
SYSCALL(uptime)
 41a:	b8 0e 00 00 00       	mov    $0xe,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <halt>:
SYSCALL(halt)
 422:	b8 16 00 00 00       	mov    $0x16,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <setnice>:
//////////////////////
SYSCALL(setnice)
 42a:	b8 18 00 00 00       	mov    $0x18,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <getnice>:
SYSCALL(getnice)
 432:	b8 17 00 00 00       	mov    $0x17,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <ps>:
SYSCALL(ps)
 43a:	b8 19 00 00 00       	mov    $0x19,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    
 442:	66 90                	xchg   %ax,%ax
 444:	66 90                	xchg   %ax,%ax
 446:	66 90                	xchg   %ax,%ax
 448:	66 90                	xchg   %ax,%ax
 44a:	66 90                	xchg   %ax,%ax
 44c:	66 90                	xchg   %ax,%ax
 44e:	66 90                	xchg   %ax,%ax

00000450 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	89 c6                	mov    %eax,%esi
 458:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 45b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 45e:	85 db                	test   %ebx,%ebx
 460:	74 7e                	je     4e0 <printint+0x90>
 462:	89 d0                	mov    %edx,%eax
 464:	c1 e8 1f             	shr    $0x1f,%eax
 467:	84 c0                	test   %al,%al
 469:	74 75                	je     4e0 <printint+0x90>
    neg = 1;
    x = -xx;
 46b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 46d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 474:	f7 d8                	neg    %eax
 476:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 479:	31 ff                	xor    %edi,%edi
 47b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 47e:	89 ce                	mov    %ecx,%esi
 480:	eb 08                	jmp    48a <printint+0x3a>
 482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 488:	89 cf                	mov    %ecx,%edi
 48a:	31 d2                	xor    %edx,%edx
 48c:	8d 4f 01             	lea    0x1(%edi),%ecx
 48f:	f7 f6                	div    %esi
 491:	0f b6 92 50 08 00 00 	movzbl 0x850(%edx),%edx
  }while((x /= base) != 0);
 498:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 49a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 49d:	75 e9                	jne    488 <printint+0x38>
  if(neg)
 49f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4a2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4a5:	85 c0                	test   %eax,%eax
 4a7:	74 08                	je     4b1 <printint+0x61>
    buf[i++] = '-';
 4a9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 4ae:	8d 4f 02             	lea    0x2(%edi),%ecx
 4b1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 4b5:	8d 76 00             	lea    0x0(%esi),%esi
 4b8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4bb:	83 ec 04             	sub    $0x4,%esp
 4be:	83 ef 01             	sub    $0x1,%edi
 4c1:	6a 01                	push   $0x1
 4c3:	53                   	push   %ebx
 4c4:	56                   	push   %esi
 4c5:	88 45 d7             	mov    %al,-0x29(%ebp)
 4c8:	e8 d5 fe ff ff       	call   3a2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4cd:	83 c4 10             	add    $0x10,%esp
 4d0:	39 df                	cmp    %ebx,%edi
 4d2:	75 e4                	jne    4b8 <printint+0x68>
    putc(fd, buf[i]);
}
 4d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d7:	5b                   	pop    %ebx
 4d8:	5e                   	pop    %esi
 4d9:	5f                   	pop    %edi
 4da:	5d                   	pop    %ebp
 4db:	c3                   	ret    
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4e0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4e2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4e9:	eb 8b                	jmp    476 <printint+0x26>
 4eb:	90                   	nop
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4fc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4ff:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 502:	89 45 d0             	mov    %eax,-0x30(%ebp)
 505:	0f b6 1e             	movzbl (%esi),%ebx
 508:	83 c6 01             	add    $0x1,%esi
 50b:	84 db                	test   %bl,%bl
 50d:	0f 84 b0 00 00 00    	je     5c3 <printf+0xd3>
 513:	31 d2                	xor    %edx,%edx
 515:	eb 39                	jmp    550 <printf+0x60>
 517:	89 f6                	mov    %esi,%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 520:	83 f8 25             	cmp    $0x25,%eax
 523:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 526:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 52b:	74 18                	je     545 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 530:	83 ec 04             	sub    $0x4,%esp
 533:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 536:	6a 01                	push   $0x1
 538:	50                   	push   %eax
 539:	57                   	push   %edi
 53a:	e8 63 fe ff ff       	call   3a2 <write>
 53f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 542:	83 c4 10             	add    $0x10,%esp
 545:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 548:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 54c:	84 db                	test   %bl,%bl
 54e:	74 73                	je     5c3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 550:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 552:	0f be cb             	movsbl %bl,%ecx
 555:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 558:	74 c6                	je     520 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 55a:	83 fa 25             	cmp    $0x25,%edx
 55d:	75 e6                	jne    545 <printf+0x55>
      if(c == 'd'){
 55f:	83 f8 64             	cmp    $0x64,%eax
 562:	0f 84 f8 00 00 00    	je     660 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 568:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 56e:	83 f9 70             	cmp    $0x70,%ecx
 571:	74 5d                	je     5d0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 573:	83 f8 73             	cmp    $0x73,%eax
 576:	0f 84 84 00 00 00    	je     600 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 57c:	83 f8 63             	cmp    $0x63,%eax
 57f:	0f 84 ea 00 00 00    	je     66f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 585:	83 f8 25             	cmp    $0x25,%eax
 588:	0f 84 c2 00 00 00    	je     650 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 58e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 591:	83 ec 04             	sub    $0x4,%esp
 594:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 598:	6a 01                	push   $0x1
 59a:	50                   	push   %eax
 59b:	57                   	push   %edi
 59c:	e8 01 fe ff ff       	call   3a2 <write>
 5a1:	83 c4 0c             	add    $0xc,%esp
 5a4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5a7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5aa:	6a 01                	push   $0x1
 5ac:	50                   	push   %eax
 5ad:	57                   	push   %edi
 5ae:	83 c6 01             	add    $0x1,%esi
 5b1:	e8 ec fd ff ff       	call   3a2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ba:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5bd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5bf:	84 db                	test   %bl,%bl
 5c1:	75 8d                	jne    550 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c6:	5b                   	pop    %ebx
 5c7:	5e                   	pop    %esi
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    
 5cb:	90                   	nop
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5d8:	6a 00                	push   $0x0
 5da:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5dd:	89 f8                	mov    %edi,%eax
 5df:	8b 13                	mov    (%ebx),%edx
 5e1:	e8 6a fe ff ff       	call   450 <printint>
        ap++;
 5e6:	89 d8                	mov    %ebx,%eax
 5e8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5eb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 5ed:	83 c0 04             	add    $0x4,%eax
 5f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f3:	e9 4d ff ff ff       	jmp    545 <printf+0x55>
 5f8:	90                   	nop
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 600:	8b 45 d0             	mov    -0x30(%ebp),%eax
 603:	8b 18                	mov    (%eax),%ebx
        ap++;
 605:	83 c0 04             	add    $0x4,%eax
 608:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 60b:	b8 48 08 00 00       	mov    $0x848,%eax
 610:	85 db                	test   %ebx,%ebx
 612:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 615:	0f b6 03             	movzbl (%ebx),%eax
 618:	84 c0                	test   %al,%al
 61a:	74 23                	je     63f <printf+0x14f>
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 620:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 623:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 626:	83 ec 04             	sub    $0x4,%esp
 629:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 62b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62e:	50                   	push   %eax
 62f:	57                   	push   %edi
 630:	e8 6d fd ff ff       	call   3a2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 635:	0f b6 03             	movzbl (%ebx),%eax
 638:	83 c4 10             	add    $0x10,%esp
 63b:	84 c0                	test   %al,%al
 63d:	75 e1                	jne    620 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 63f:	31 d2                	xor    %edx,%edx
 641:	e9 ff fe ff ff       	jmp    545 <printf+0x55>
 646:	8d 76 00             	lea    0x0(%esi),%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
 653:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 656:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 659:	6a 01                	push   $0x1
 65b:	e9 4c ff ff ff       	jmp    5ac <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 660:	83 ec 0c             	sub    $0xc,%esp
 663:	b9 0a 00 00 00       	mov    $0xa,%ecx
 668:	6a 01                	push   $0x1
 66a:	e9 6b ff ff ff       	jmp    5da <printf+0xea>
 66f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 672:	83 ec 04             	sub    $0x4,%esp
 675:	8b 03                	mov    (%ebx),%eax
 677:	6a 01                	push   $0x1
 679:	88 45 e4             	mov    %al,-0x1c(%ebp)
 67c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 67f:	50                   	push   %eax
 680:	57                   	push   %edi
 681:	e8 1c fd ff ff       	call   3a2 <write>
 686:	e9 5b ff ff ff       	jmp    5e6 <printf+0xf6>
 68b:	66 90                	xchg   %ax,%ax
 68d:	66 90                	xchg   %ax,%ax
 68f:	90                   	nop

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 40 0b 00 00       	mov    0xb40,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 696:	89 e5                	mov    %esp,%ebp
 698:	57                   	push   %edi
 699:	56                   	push   %esi
 69a:	53                   	push   %ebx
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6a0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a3:	39 c8                	cmp    %ecx,%eax
 6a5:	73 19                	jae    6c0 <free+0x30>
 6a7:	89 f6                	mov    %esi,%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6b0:	39 d1                	cmp    %edx,%ecx
 6b2:	72 1c                	jb     6d0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b4:	39 d0                	cmp    %edx,%eax
 6b6:	73 18                	jae    6d0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ba:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6be:	72 f0                	jb     6b0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c0:	39 d0                	cmp    %edx,%eax
 6c2:	72 f4                	jb     6b8 <free+0x28>
 6c4:	39 d1                	cmp    %edx,%ecx
 6c6:	73 f0                	jae    6b8 <free+0x28>
 6c8:	90                   	nop
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6d6:	39 d7                	cmp    %edx,%edi
 6d8:	74 19                	je     6f3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6dd:	8b 50 04             	mov    0x4(%eax),%edx
 6e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6e3:	39 f1                	cmp    %esi,%ecx
 6e5:	74 23                	je     70a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6e7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6e9:	a3 40 0b 00 00       	mov    %eax,0xb40
}
 6ee:	5b                   	pop    %ebx
 6ef:	5e                   	pop    %esi
 6f0:	5f                   	pop    %edi
 6f1:	5d                   	pop    %ebp
 6f2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6f3:	03 72 04             	add    0x4(%edx),%esi
 6f6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f9:	8b 10                	mov    (%eax),%edx
 6fb:	8b 12                	mov    (%edx),%edx
 6fd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 700:	8b 50 04             	mov    0x4(%eax),%edx
 703:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 706:	39 f1                	cmp    %esi,%ecx
 708:	75 dd                	jne    6e7 <free+0x57>
    p->s.size += bp->s.size;
 70a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 70d:	a3 40 0b 00 00       	mov    %eax,0xb40
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 712:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 715:	8b 53 f8             	mov    -0x8(%ebx),%edx
 718:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 71a:	5b                   	pop    %ebx
 71b:	5e                   	pop    %esi
 71c:	5f                   	pop    %edi
 71d:	5d                   	pop    %ebp
 71e:	c3                   	ret    
 71f:	90                   	nop

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 40 0b 00 00    	mov    0xb40,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 78 07             	lea    0x7(%eax),%edi
 735:	c1 ef 03             	shr    $0x3,%edi
 738:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 73b:	85 d2                	test   %edx,%edx
 73d:	0f 84 a3 00 00 00    	je     7e6 <malloc+0xc6>
 743:	8b 02                	mov    (%edx),%eax
 745:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 748:	39 cf                	cmp    %ecx,%edi
 74a:	76 74                	jbe    7c0 <malloc+0xa0>
 74c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 752:	be 00 10 00 00       	mov    $0x1000,%esi
 757:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 75e:	0f 43 f7             	cmovae %edi,%esi
 761:	ba 00 80 00 00       	mov    $0x8000,%edx
 766:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 76c:	0f 46 da             	cmovbe %edx,%ebx
 76f:	eb 10                	jmp    781 <malloc+0x61>
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 778:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 77a:	8b 48 04             	mov    0x4(%eax),%ecx
 77d:	39 cf                	cmp    %ecx,%edi
 77f:	76 3f                	jbe    7c0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 781:	39 05 40 0b 00 00    	cmp    %eax,0xb40
 787:	89 c2                	mov    %eax,%edx
 789:	75 ed                	jne    778 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 78b:	83 ec 0c             	sub    $0xc,%esp
 78e:	53                   	push   %ebx
 78f:	e8 76 fc ff ff       	call   40a <sbrk>
  if(p == (char*)-1)
 794:	83 c4 10             	add    $0x10,%esp
 797:	83 f8 ff             	cmp    $0xffffffff,%eax
 79a:	74 1c                	je     7b8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 79c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 79f:	83 ec 0c             	sub    $0xc,%esp
 7a2:	83 c0 08             	add    $0x8,%eax
 7a5:	50                   	push   %eax
 7a6:	e8 e5 fe ff ff       	call   690 <free>
  return freep;
 7ab:	8b 15 40 0b 00 00    	mov    0xb40,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7b1:	83 c4 10             	add    $0x10,%esp
 7b4:	85 d2                	test   %edx,%edx
 7b6:	75 c0                	jne    778 <malloc+0x58>
        return 0;
 7b8:	31 c0                	xor    %eax,%eax
 7ba:	eb 1c                	jmp    7d8 <malloc+0xb8>
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7c0:	39 cf                	cmp    %ecx,%edi
 7c2:	74 1c                	je     7e0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7c4:	29 f9                	sub    %edi,%ecx
 7c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7cc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 7cf:	89 15 40 0b 00 00    	mov    %edx,0xb40
      return (void*)(p + 1);
 7d5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7db:	5b                   	pop    %ebx
 7dc:	5e                   	pop    %esi
 7dd:	5f                   	pop    %edi
 7de:	5d                   	pop    %ebp
 7df:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 08                	mov    (%eax),%ecx
 7e2:	89 0a                	mov    %ecx,(%edx)
 7e4:	eb e9                	jmp    7cf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7e6:	c7 05 40 0b 00 00 44 	movl   $0xb44,0xb40
 7ed:	0b 00 00 
 7f0:	c7 05 44 0b 00 00 44 	movl   $0xb44,0xb44
 7f7:	0b 00 00 
    base.s.size = 0;
 7fa:	b8 44 0b 00 00       	mov    $0xb44,%eax
 7ff:	c7 05 48 0b 00 00 00 	movl   $0x0,0xb48
 806:	00 00 00 
 809:	e9 3e ff ff ff       	jmp    74c <malloc+0x2c>
