
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;

  if(argc <= 1){
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 f6 03 00 00       	call   432 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 26                	js     6b <main+0x6b>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  4a:	83 c6 01             	add    $0x1,%esi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  4d:	50                   	push   %eax
  4e:	83 c3 04             	add    $0x4,%ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
    close(fd);
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 bc 03 00 00       	call   41a <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
  66:	e8 87 03 00 00       	call   3f2 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 a3 08 00 00       	push   $0x8a3
  73:	6a 01                	push   $0x1
  75:	e8 e6 04 00 00       	call   560 <printf>
      exit();
  7a:	e8 73 03 00 00       	call   3f2 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 95 08 00 00       	push   $0x895
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 60 03 00 00       	call   3f2 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  a6:	31 f6                	xor    %esi,%esi
wc(int fd, char *name)
{
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  a8:	31 db                	xor    %ebx,%ebx

char buf[512];

void
wc(int fd, char *name)
{
  aa:	83 ec 1c             	sub    $0x1c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 c0 0b 00 00       	push   $0xbc0
  cd:	ff 75 08             	pushl  0x8(%ebp)
  d0:	e8 35 03 00 00       	call   40a <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	83 f8 00             	cmp    $0x0,%eax
  db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  de:	7e 5f                	jle    13f <wc+0x9f>
  e0:	31 ff                	xor    %edi,%edi
  e2:	eb 0e                	jmp    f2 <wc+0x52>
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  f0:	74 3a                	je     12c <wc+0x8c>
      c++;
      if(buf[i] == '\n')
  f2:	0f be 87 c0 0b 00 00 	movsbl 0xbc0(%edi),%eax
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
  fb:	3c 0a                	cmp    $0xa,%al
  fd:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 100:	83 ec 08             	sub    $0x8,%esp
 103:	50                   	push   %eax
 104:	68 80 08 00 00       	push   $0x880
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
 109:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10b:	e8 40 01 00 00       	call   250 <strchr>
 110:	83 c4 10             	add    $0x10,%esp
 113:	85 c0                	test   %eax,%eax
 115:	75 d1                	jne    e8 <wc+0x48>
        inword = 0;
      else if(!inword){
 117:	85 f6                	test   %esi,%esi
 119:	75 1d                	jne    138 <wc+0x98>
        w++;
 11b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 11f:	83 c7 01             	add    $0x1,%edi
 122:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
        inword = 1;
 125:	be 01 00 00 00       	mov    $0x1,%esi
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 12a:	75 c6                	jne    f2 <wc+0x52>
 12c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 12f:	01 55 dc             	add    %edx,-0x24(%ebp)
 132:	eb 8c                	jmp    c0 <wc+0x20>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	be 01 00 00 00       	mov    $0x1,%esi
 13d:	eb ab                	jmp    ea <wc+0x4a>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
 13f:	75 24                	jne    165 <wc+0xc5>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
 141:	83 ec 08             	sub    $0x8,%esp
 144:	ff 75 0c             	pushl  0xc(%ebp)
 147:	ff 75 dc             	pushl  -0x24(%ebp)
 14a:	ff 75 e0             	pushl  -0x20(%ebp)
 14d:	53                   	push   %ebx
 14e:	68 96 08 00 00       	push   $0x896
 153:	6a 01                	push   $0x1
 155:	e8 06 04 00 00       	call   560 <printf>
}
 15a:	83 c4 20             	add    $0x20,%esp
 15d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 160:	5b                   	pop    %ebx
 161:	5e                   	pop    %esi
 162:	5f                   	pop    %edi
 163:	5d                   	pop    %ebp
 164:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
 165:	83 ec 08             	sub    $0x8,%esp
 168:	68 86 08 00 00       	push   $0x886
 16d:	6a 01                	push   $0x1
 16f:	e8 ec 03 00 00       	call   560 <printf>
    exit();
 174:	e8 79 02 00 00       	call   3f2 <exit>
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 c2                	mov    %eax,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
 1b5:	8b 55 08             	mov    0x8(%ebp),%edx
 1b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1bb:	0f b6 02             	movzbl (%edx),%eax
 1be:	0f b6 19             	movzbl (%ecx),%ebx
 1c1:	84 c0                	test   %al,%al
 1c3:	75 1e                	jne    1e3 <strcmp+0x33>
 1c5:	eb 29                	jmp    1f0 <strcmp+0x40>
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1dd:	84 c0                	test   %al,%al
 1df:	74 0f                	je     1f0 <strcmp+0x40>
 1e1:	89 f1                	mov    %esi,%ecx
 1e3:	38 d8                	cmp    %bl,%al
 1e5:	74 e9                	je     1d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1e7:	29 d8                	sub    %ebx,%eax
}
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1f2:	29 d8                	sub    %ebx,%eax
}
 1f4:	5b                   	pop    %ebx
 1f5:	5e                   	pop    %esi
 1f6:	5d                   	pop    %ebp
 1f7:	c3                   	ret    
 1f8:	90                   	nop
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <strlen>:

uint
strlen(char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 12                	je     21d <strlen+0x1d>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 21d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
 221:	eb 0d                	jmp    230 <memset>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	74 1d                	je     27e <strchr+0x2e>
    if(*s == c)
 261:	38 d3                	cmp    %dl,%bl
 263:	89 d9                	mov    %ebx,%ecx
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 27e:	31 c0                	xor    %eax,%eax
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 296:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 298:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 29b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 29e:	eb 29                	jmp    2c9 <gets+0x39>
    cc = read(0, &c, 1);
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	6a 01                	push   $0x1
 2a5:	57                   	push   %edi
 2a6:	6a 00                	push   $0x0
 2a8:	e8 5d 01 00 00       	call   40a <read>
    if(cc < 1)
 2ad:	83 c4 10             	add    $0x10,%esp
 2b0:	85 c0                	test   %eax,%eax
 2b2:	7e 1d                	jle    2d1 <gets+0x41>
      break;
    buf[i++] = c;
 2b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2b8:	8b 55 08             	mov    0x8(%ebp),%edx
 2bb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 2bd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2bf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2c3:	74 1b                	je     2e0 <gets+0x50>
 2c5:	3c 0d                	cmp    $0xd,%al
 2c7:	74 17                	je     2e0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c9:	8d 5e 01             	lea    0x1(%esi),%ebx
 2cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2cf:	7c cf                	jl     2a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2d1:	8b 45 08             	mov    0x8(%ebp),%eax
 2d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2db:	5b                   	pop    %ebx
 2dc:	5e                   	pop    %esi
 2dd:	5f                   	pop    %edi
 2de:	5d                   	pop    %ebp
 2df:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ec:	5b                   	pop    %ebx
 2ed:	5e                   	pop    %esi
 2ee:	5f                   	pop    %edi
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret    
 2f1:	eb 0d                	jmp    300 <stat>
 2f3:	90                   	nop
 2f4:	90                   	nop
 2f5:	90                   	nop
 2f6:	90                   	nop
 2f7:	90                   	nop
 2f8:	90                   	nop
 2f9:	90                   	nop
 2fa:	90                   	nop
 2fb:	90                   	nop
 2fc:	90                   	nop
 2fd:	90                   	nop
 2fe:	90                   	nop
 2ff:	90                   	nop

00000300 <stat>:

int
stat(char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 305:	83 ec 08             	sub    $0x8,%esp
 308:	6a 00                	push   $0x0
 30a:	ff 75 08             	pushl  0x8(%ebp)
 30d:	e8 20 01 00 00       	call   432 <open>
  if(fd < 0)
 312:	83 c4 10             	add    $0x10,%esp
 315:	85 c0                	test   %eax,%eax
 317:	78 27                	js     340 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	ff 75 0c             	pushl  0xc(%ebp)
 31f:	89 c3                	mov    %eax,%ebx
 321:	50                   	push   %eax
 322:	e8 23 01 00 00       	call   44a <fstat>
 327:	89 c6                	mov    %eax,%esi
  close(fd);
 329:	89 1c 24             	mov    %ebx,(%esp)
 32c:	e8 e9 00 00 00       	call   41a <close>
  return r;
 331:	83 c4 10             	add    $0x10,%esp
 334:	89 f0                	mov    %esi,%eax
}
 336:	8d 65 f8             	lea    -0x8(%ebp),%esp
 339:	5b                   	pop    %ebx
 33a:	5e                   	pop    %esi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret    
 33d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 345:	eb ef                	jmp    336 <stat+0x36>
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
 358:	0f be 13             	movsbl (%ebx),%edx
 35b:	80 fa 2d             	cmp    $0x2d,%dl
 35e:	74 38                	je     398 <atoi+0x48>
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 360:	8d 42 d0             	lea    -0x30(%edx),%eax

int
atoi(const char *s)
{
  int n;
	int sign=0;	// let positive as 0, negative as 1
 363:	31 f6                	xor    %esi,%esi
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 365:	3c 09                	cmp    $0x9,%al
 367:	77 47                	ja     3b0 <atoi+0x60>
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
		sign=1;
 369:	31 c0                	xor    %eax,%eax
 36b:	90                   	nop
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		s++;
	}

  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
 370:	8d 04 80             	lea    (%eax,%eax,4),%eax
 373:	83 c3 01             	add    $0x1,%ebx
 376:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 37a:	0f be 13             	movsbl (%ebx),%edx
 37d:	8d 4a d0             	lea    -0x30(%edx),%ecx
 380:	80 f9 09             	cmp    $0x9,%cl
 383:	76 eb                	jbe    370 <atoi+0x20>
 385:	89 c2                	mov    %eax,%edx
 387:	f7 da                	neg    %edx
 389:	83 fe 01             	cmp    $0x1,%esi
 38c:	0f 44 c2             	cmove  %edx,%eax
  if(sign==1){
		return n*(-1);
	}

	return n;
}
 38f:	5b                   	pop    %ebx
 390:	5e                   	pop    %esi
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
 393:	90                   	nop
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 398:	0f be 53 01          	movsbl 0x1(%ebx),%edx

  n = 0;

	if(*s=='-'){
		sign=1;
		s++;
 39c:	8d 43 01             	lea    0x1(%ebx),%eax
	}

  while('0' <= *s && *s <= '9')
 39f:	8d 4a d0             	lea    -0x30(%edx),%ecx
 3a2:	80 f9 09             	cmp    $0x9,%cl
 3a5:	77 09                	ja     3b0 <atoi+0x60>

  n = 0;

	if(*s=='-'){
		sign=1;
		s++;
 3a7:	89 c3                	mov    %eax,%ebx
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
		sign=1;
 3a9:	be 01 00 00 00       	mov    $0x1,%esi
 3ae:	eb b9                	jmp    369 <atoi+0x19>
		s++;
	}

  while('0' <= *s && *s <= '9')
 3b0:	31 c0                	xor    %eax,%eax
 3b2:	eb db                	jmp    38f <atoi+0x3f>
 3b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003c0 <memmove>:
	return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	56                   	push   %esi
 3c4:	53                   	push   %ebx
 3c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3c8:	8b 45 08             	mov    0x8(%ebp),%eax
 3cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ce:	85 db                	test   %ebx,%ebx
 3d0:	7e 14                	jle    3e6 <memmove+0x26>
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3df:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3e2:	39 da                	cmp    %ebx,%edx
 3e4:	75 f2                	jne    3d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3e6:	5b                   	pop    %ebx
 3e7:	5e                   	pop    %esi
 3e8:	5d                   	pop    %ebp
 3e9:	c3                   	ret    

000003ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ea:	b8 01 00 00 00       	mov    $0x1,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <exit>:
SYSCALL(exit)
 3f2:	b8 02 00 00 00       	mov    $0x2,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <wait>:
SYSCALL(wait)
 3fa:	b8 03 00 00 00       	mov    $0x3,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <pipe>:
SYSCALL(pipe)
 402:	b8 04 00 00 00       	mov    $0x4,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <read>:
SYSCALL(read)
 40a:	b8 05 00 00 00       	mov    $0x5,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <write>:
SYSCALL(write)
 412:	b8 10 00 00 00       	mov    $0x10,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <close>:
SYSCALL(close)
 41a:	b8 15 00 00 00       	mov    $0x15,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <kill>:
SYSCALL(kill)
 422:	b8 06 00 00 00       	mov    $0x6,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <exec>:
SYSCALL(exec)
 42a:	b8 07 00 00 00       	mov    $0x7,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <open>:
SYSCALL(open)
 432:	b8 0f 00 00 00       	mov    $0xf,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <mknod>:
SYSCALL(mknod)
 43a:	b8 11 00 00 00       	mov    $0x11,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <unlink>:
SYSCALL(unlink)
 442:	b8 12 00 00 00       	mov    $0x12,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <fstat>:
SYSCALL(fstat)
 44a:	b8 08 00 00 00       	mov    $0x8,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <link>:
SYSCALL(link)
 452:	b8 13 00 00 00       	mov    $0x13,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <mkdir>:
SYSCALL(mkdir)
 45a:	b8 14 00 00 00       	mov    $0x14,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <chdir>:
SYSCALL(chdir)
 462:	b8 09 00 00 00       	mov    $0x9,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <dup>:
SYSCALL(dup)
 46a:	b8 0a 00 00 00       	mov    $0xa,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <getpid>:
SYSCALL(getpid)
 472:	b8 0b 00 00 00       	mov    $0xb,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <sbrk>:
SYSCALL(sbrk)
 47a:	b8 0c 00 00 00       	mov    $0xc,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <sleep>:
SYSCALL(sleep)
 482:	b8 0d 00 00 00       	mov    $0xd,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <uptime>:
SYSCALL(uptime)
 48a:	b8 0e 00 00 00       	mov    $0xe,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <halt>:
SYSCALL(halt)
 492:	b8 16 00 00 00       	mov    $0x16,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <setnice>:
//////////////////////
SYSCALL(setnice)
 49a:	b8 18 00 00 00       	mov    $0x18,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <getnice>:
SYSCALL(getnice)
 4a2:	b8 17 00 00 00       	mov    $0x17,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <ps>:
SYSCALL(ps)
 4aa:	b8 19 00 00 00       	mov    $0x19,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    
 4b2:	66 90                	xchg   %ax,%ax
 4b4:	66 90                	xchg   %ax,%ax
 4b6:	66 90                	xchg   %ax,%ax
 4b8:	66 90                	xchg   %ax,%ax
 4ba:	66 90                	xchg   %ax,%ax
 4bc:	66 90                	xchg   %ax,%ax
 4be:	66 90                	xchg   %ax,%ax

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	89 c6                	mov    %eax,%esi
 4c8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4ce:	85 db                	test   %ebx,%ebx
 4d0:	74 7e                	je     550 <printint+0x90>
 4d2:	89 d0                	mov    %edx,%eax
 4d4:	c1 e8 1f             	shr    $0x1f,%eax
 4d7:	84 c0                	test   %al,%al
 4d9:	74 75                	je     550 <printint+0x90>
    neg = 1;
    x = -xx;
 4db:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4dd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 4e4:	f7 d8                	neg    %eax
 4e6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4e9:	31 ff                	xor    %edi,%edi
 4eb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ee:	89 ce                	mov    %ecx,%esi
 4f0:	eb 08                	jmp    4fa <printint+0x3a>
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4f8:	89 cf                	mov    %ecx,%edi
 4fa:	31 d2                	xor    %edx,%edx
 4fc:	8d 4f 01             	lea    0x1(%edi),%ecx
 4ff:	f7 f6                	div    %esi
 501:	0f b6 92 c0 08 00 00 	movzbl 0x8c0(%edx),%edx
  }while((x /= base) != 0);
 508:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 50a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 50d:	75 e9                	jne    4f8 <printint+0x38>
  if(neg)
 50f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 512:	8b 75 c0             	mov    -0x40(%ebp),%esi
 515:	85 c0                	test   %eax,%eax
 517:	74 08                	je     521 <printint+0x61>
    buf[i++] = '-';
 519:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 51e:	8d 4f 02             	lea    0x2(%edi),%ecx
 521:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 525:	8d 76 00             	lea    0x0(%esi),%esi
 528:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52b:	83 ec 04             	sub    $0x4,%esp
 52e:	83 ef 01             	sub    $0x1,%edi
 531:	6a 01                	push   $0x1
 533:	53                   	push   %ebx
 534:	56                   	push   %esi
 535:	88 45 d7             	mov    %al,-0x29(%ebp)
 538:	e8 d5 fe ff ff       	call   412 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 53d:	83 c4 10             	add    $0x10,%esp
 540:	39 df                	cmp    %ebx,%edi
 542:	75 e4                	jne    528 <printint+0x68>
    putc(fd, buf[i]);
}
 544:	8d 65 f4             	lea    -0xc(%ebp),%esp
 547:	5b                   	pop    %ebx
 548:	5e                   	pop    %esi
 549:	5f                   	pop    %edi
 54a:	5d                   	pop    %ebp
 54b:	c3                   	ret    
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 550:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 552:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 559:	eb 8b                	jmp    4e6 <printint+0x26>
 55b:	90                   	nop
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000560 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 566:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 569:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 56f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 572:	89 45 d0             	mov    %eax,-0x30(%ebp)
 575:	0f b6 1e             	movzbl (%esi),%ebx
 578:	83 c6 01             	add    $0x1,%esi
 57b:	84 db                	test   %bl,%bl
 57d:	0f 84 b0 00 00 00    	je     633 <printf+0xd3>
 583:	31 d2                	xor    %edx,%edx
 585:	eb 39                	jmp    5c0 <printf+0x60>
 587:	89 f6                	mov    %esi,%esi
 589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 590:	83 f8 25             	cmp    $0x25,%eax
 593:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 596:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 59b:	74 18                	je     5b5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5a6:	6a 01                	push   $0x1
 5a8:	50                   	push   %eax
 5a9:	57                   	push   %edi
 5aa:	e8 63 fe ff ff       	call   412 <write>
 5af:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5b2:	83 c4 10             	add    $0x10,%esp
 5b5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5bc:	84 db                	test   %bl,%bl
 5be:	74 73                	je     633 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 5c0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5c2:	0f be cb             	movsbl %bl,%ecx
 5c5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5c8:	74 c6                	je     590 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ca:	83 fa 25             	cmp    $0x25,%edx
 5cd:	75 e6                	jne    5b5 <printf+0x55>
      if(c == 'd'){
 5cf:	83 f8 64             	cmp    $0x64,%eax
 5d2:	0f 84 f8 00 00 00    	je     6d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5de:	83 f9 70             	cmp    $0x70,%ecx
 5e1:	74 5d                	je     640 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5e3:	83 f8 73             	cmp    $0x73,%eax
 5e6:	0f 84 84 00 00 00    	je     670 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ec:	83 f8 63             	cmp    $0x63,%eax
 5ef:	0f 84 ea 00 00 00    	je     6df <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5f5:	83 f8 25             	cmp    $0x25,%eax
 5f8:	0f 84 c2 00 00 00    	je     6c0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
 601:	83 ec 04             	sub    $0x4,%esp
 604:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 608:	6a 01                	push   $0x1
 60a:	50                   	push   %eax
 60b:	57                   	push   %edi
 60c:	e8 01 fe ff ff       	call   412 <write>
 611:	83 c4 0c             	add    $0xc,%esp
 614:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 617:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 61a:	6a 01                	push   $0x1
 61c:	50                   	push   %eax
 61d:	57                   	push   %edi
 61e:	83 c6 01             	add    $0x1,%esi
 621:	e8 ec fd ff ff       	call   412 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 626:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 62f:	84 db                	test   %bl,%bl
 631:	75 8d                	jne    5c0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 633:	8d 65 f4             	lea    -0xc(%ebp),%esp
 636:	5b                   	pop    %ebx
 637:	5e                   	pop    %esi
 638:	5f                   	pop    %edi
 639:	5d                   	pop    %ebp
 63a:	c3                   	ret    
 63b:	90                   	nop
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	b9 10 00 00 00       	mov    $0x10,%ecx
 648:	6a 00                	push   $0x0
 64a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 64d:	89 f8                	mov    %edi,%eax
 64f:	8b 13                	mov    (%ebx),%edx
 651:	e8 6a fe ff ff       	call   4c0 <printint>
        ap++;
 656:	89 d8                	mov    %ebx,%eax
 658:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 65b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 65d:	83 c0 04             	add    $0x4,%eax
 660:	89 45 d0             	mov    %eax,-0x30(%ebp)
 663:	e9 4d ff ff ff       	jmp    5b5 <printf+0x55>
 668:	90                   	nop
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 670:	8b 45 d0             	mov    -0x30(%ebp),%eax
 673:	8b 18                	mov    (%eax),%ebx
        ap++;
 675:	83 c0 04             	add    $0x4,%eax
 678:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 67b:	b8 b7 08 00 00       	mov    $0x8b7,%eax
 680:	85 db                	test   %ebx,%ebx
 682:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 685:	0f b6 03             	movzbl (%ebx),%eax
 688:	84 c0                	test   %al,%al
 68a:	74 23                	je     6af <printf+0x14f>
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 690:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 693:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 696:	83 ec 04             	sub    $0x4,%esp
 699:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 69b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69e:	50                   	push   %eax
 69f:	57                   	push   %edi
 6a0:	e8 6d fd ff ff       	call   412 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6a5:	0f b6 03             	movzbl (%ebx),%eax
 6a8:	83 c4 10             	add    $0x10,%esp
 6ab:	84 c0                	test   %al,%al
 6ad:	75 e1                	jne    690 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 ff fe ff ff       	jmp    5b5 <printf+0x55>
 6b6:	8d 76 00             	lea    0x0(%esi),%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6c6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6c9:	6a 01                	push   $0x1
 6cb:	e9 4c ff ff ff       	jmp    61c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6d0:	83 ec 0c             	sub    $0xc,%esp
 6d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6d8:	6a 01                	push   $0x1
 6da:	e9 6b ff ff ff       	jmp    64a <printf+0xea>
 6df:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e2:	83 ec 04             	sub    $0x4,%esp
 6e5:	8b 03                	mov    (%ebx),%eax
 6e7:	6a 01                	push   $0x1
 6e9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 6ec:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6ef:	50                   	push   %eax
 6f0:	57                   	push   %edi
 6f1:	e8 1c fd ff ff       	call   412 <write>
 6f6:	e9 5b ff ff ff       	jmp    656 <printf+0xf6>
 6fb:	66 90                	xchg   %ax,%ax
 6fd:	66 90                	xchg   %ax,%ax
 6ff:	90                   	nop

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 a0 0b 00 00       	mov    0xba0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 710:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 713:	39 c8                	cmp    %ecx,%eax
 715:	73 19                	jae    730 <free+0x30>
 717:	89 f6                	mov    %esi,%esi
 719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 720:	39 d1                	cmp    %edx,%ecx
 722:	72 1c                	jb     740 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	39 d0                	cmp    %edx,%eax
 726:	73 18                	jae    740 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 728:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72e:	72 f0                	jb     720 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 730:	39 d0                	cmp    %edx,%eax
 732:	72 f4                	jb     728 <free+0x28>
 734:	39 d1                	cmp    %edx,%ecx
 736:	73 f0                	jae    728 <free+0x28>
 738:	90                   	nop
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 740:	8b 73 fc             	mov    -0x4(%ebx),%esi
 743:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 746:	39 d7                	cmp    %edx,%edi
 748:	74 19                	je     763 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 74a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 74d:	8b 50 04             	mov    0x4(%eax),%edx
 750:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 753:	39 f1                	cmp    %esi,%ecx
 755:	74 23                	je     77a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 757:	89 08                	mov    %ecx,(%eax)
  freep = p;
 759:	a3 a0 0b 00 00       	mov    %eax,0xba0
}
 75e:	5b                   	pop    %ebx
 75f:	5e                   	pop    %esi
 760:	5f                   	pop    %edi
 761:	5d                   	pop    %ebp
 762:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 763:	03 72 04             	add    0x4(%edx),%esi
 766:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 769:	8b 10                	mov    (%eax),%edx
 76b:	8b 12                	mov    (%edx),%edx
 76d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 770:	8b 50 04             	mov    0x4(%eax),%edx
 773:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 776:	39 f1                	cmp    %esi,%ecx
 778:	75 dd                	jne    757 <free+0x57>
    p->s.size += bp->s.size;
 77a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 77d:	a3 a0 0b 00 00       	mov    %eax,0xba0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 782:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 785:	8b 53 f8             	mov    -0x8(%ebx),%edx
 788:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 78a:	5b                   	pop    %ebx
 78b:	5e                   	pop    %esi
 78c:	5f                   	pop    %edi
 78d:	5d                   	pop    %ebp
 78e:	c3                   	ret    
 78f:	90                   	nop

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	8d 78 07             	lea    0x7(%eax),%edi
 7a5:	c1 ef 03             	shr    $0x3,%edi
 7a8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7ab:	85 d2                	test   %edx,%edx
 7ad:	0f 84 a3 00 00 00    	je     856 <malloc+0xc6>
 7b3:	8b 02                	mov    (%edx),%eax
 7b5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b8:	39 cf                	cmp    %ecx,%edi
 7ba:	76 74                	jbe    830 <malloc+0xa0>
 7bc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7c2:	be 00 10 00 00       	mov    $0x1000,%esi
 7c7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 7ce:	0f 43 f7             	cmovae %edi,%esi
 7d1:	ba 00 80 00 00       	mov    $0x8000,%edx
 7d6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 7dc:	0f 46 da             	cmovbe %edx,%ebx
 7df:	eb 10                	jmp    7f1 <malloc+0x61>
 7e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ea:	8b 48 04             	mov    0x4(%eax),%ecx
 7ed:	39 cf                	cmp    %ecx,%edi
 7ef:	76 3f                	jbe    830 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f1:	39 05 a0 0b 00 00    	cmp    %eax,0xba0
 7f7:	89 c2                	mov    %eax,%edx
 7f9:	75 ed                	jne    7e8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7fb:	83 ec 0c             	sub    $0xc,%esp
 7fe:	53                   	push   %ebx
 7ff:	e8 76 fc ff ff       	call   47a <sbrk>
  if(p == (char*)-1)
 804:	83 c4 10             	add    $0x10,%esp
 807:	83 f8 ff             	cmp    $0xffffffff,%eax
 80a:	74 1c                	je     828 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 80c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 80f:	83 ec 0c             	sub    $0xc,%esp
 812:	83 c0 08             	add    $0x8,%eax
 815:	50                   	push   %eax
 816:	e8 e5 fe ff ff       	call   700 <free>
  return freep;
 81b:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 821:	83 c4 10             	add    $0x10,%esp
 824:	85 d2                	test   %edx,%edx
 826:	75 c0                	jne    7e8 <malloc+0x58>
        return 0;
 828:	31 c0                	xor    %eax,%eax
 82a:	eb 1c                	jmp    848 <malloc+0xb8>
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 830:	39 cf                	cmp    %ecx,%edi
 832:	74 1c                	je     850 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 834:	29 f9                	sub    %edi,%ecx
 836:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 839:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 83c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 83f:	89 15 a0 0b 00 00    	mov    %edx,0xba0
      return (void*)(p + 1);
 845:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 848:	8d 65 f4             	lea    -0xc(%ebp),%esp
 84b:	5b                   	pop    %ebx
 84c:	5e                   	pop    %esi
 84d:	5f                   	pop    %edi
 84e:	5d                   	pop    %ebp
 84f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 850:	8b 08                	mov    (%eax),%ecx
 852:	89 0a                	mov    %ecx,(%edx)
 854:	eb e9                	jmp    83f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 856:	c7 05 a0 0b 00 00 a4 	movl   $0xba4,0xba0
 85d:	0b 00 00 
 860:	c7 05 a4 0b 00 00 a4 	movl   $0xba4,0xba4
 867:	0b 00 00 
    base.s.size = 0;
 86a:	b8 a4 0b 00 00       	mov    $0xba4,%eax
 86f:	c7 05 a8 0b 00 00 00 	movl   $0x0,0xba8
 876:	00 00 00 
 879:	e9 3e ff ff ff       	jmp    7bc <malloc+0x2c>
