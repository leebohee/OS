
_grep:     file format elf32-i386


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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  19:	83 f8 01             	cmp    $0x1,%eax
  }
}

int
main(int argc, char *argv[])
{
  1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1f:	7e 76                	jle    97 <main+0x97>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  27:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  2b:	be 02 00 00 00       	mov    $0x2,%esi

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  30:	89 45 e0             	mov    %eax,-0x20(%ebp)

  if(argc <= 2){
  33:	74 53                	je     88 <main+0x88>
  35:	8d 76 00             	lea    0x0(%esi),%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  38:	83 ec 08             	sub    $0x8,%esp
  3b:	6a 00                	push   $0x0
  3d:	ff 33                	pushl  (%ebx)
  3f:	e8 8e 05 00 00       	call   5d2 <open>
  44:	83 c4 10             	add    $0x10,%esp
  47:	85 c0                	test   %eax,%eax
  49:	89 c7                	mov    %eax,%edi
  4b:	78 27                	js     74 <main+0x74>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  4d:	83 ec 08             	sub    $0x8,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  50:	83 c6 01             	add    $0x1,%esi
  53:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  56:	50                   	push   %eax
  57:	ff 75 e0             	pushl  -0x20(%ebp)
  5a:	e8 c1 01 00 00       	call   220 <grep>
    close(fd);
  5f:	89 3c 24             	mov    %edi,(%esp)
  62:	e8 53 05 00 00       	call   5ba <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  67:	83 c4 10             	add    $0x10,%esp
  6a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  6d:	7f c9                	jg     38 <main+0x38>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
  6f:	e8 1e 05 00 00       	call   592 <exit>
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
  74:	50                   	push   %eax
  75:	ff 33                	pushl  (%ebx)
  77:	68 40 0a 00 00       	push   $0xa40
  7c:	6a 01                	push   $0x1
  7e:	e8 7d 06 00 00       	call   700 <printf>
      exit();
  83:	e8 0a 05 00 00       	call   592 <exit>
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
  88:	52                   	push   %edx
  89:	52                   	push   %edx
  8a:	6a 00                	push   $0x0
  8c:	50                   	push   %eax
  8d:	e8 8e 01 00 00       	call   220 <grep>
    exit();
  92:	e8 fb 04 00 00       	call   592 <exit>
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
  97:	51                   	push   %ecx
  98:	51                   	push   %ecx
  99:	68 20 0a 00 00       	push   $0xa20
  9e:	6a 02                	push   $0x2
  a0:	e8 5b 06 00 00       	call   700 <printf>
    exit();
  a5:	e8 e8 04 00 00       	call   592 <exit>
  aa:	66 90                	xchg   %ax,%ax
  ac:	66 90                	xchg   %ax,%ax
  ae:	66 90                	xchg   %ax,%ax

000000b0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	83 ec 0c             	sub    $0xc,%esp
  b9:	8b 75 08             	mov    0x8(%ebp),%esi
  bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  bf:	8b 5d 10             	mov    0x10(%ebp),%ebx
  c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  c8:	83 ec 08             	sub    $0x8,%esp
  cb:	53                   	push   %ebx
  cc:	57                   	push   %edi
  cd:	e8 3e 00 00 00       	call   110 <matchhere>
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	85 c0                	test   %eax,%eax
  d7:	75 1f                	jne    f8 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  d9:	0f be 13             	movsbl (%ebx),%edx
  dc:	84 d2                	test   %dl,%dl
  de:	74 0c                	je     ec <matchstar+0x3c>
  e0:	83 c3 01             	add    $0x1,%ebx
  e3:	83 fe 2e             	cmp    $0x2e,%esi
  e6:	74 e0                	je     c8 <matchstar+0x18>
  e8:	39 f2                	cmp    %esi,%edx
  ea:	74 dc                	je     c8 <matchstar+0x18>
  return 0;
}
  ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	5f                   	pop    %edi
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  fb:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
 100:	5b                   	pop    %ebx
 101:	5e                   	pop    %esi
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	83 ec 0c             	sub    $0xc,%esp
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 11f:	0f b6 18             	movzbl (%eax),%ebx
 122:	84 db                	test   %bl,%bl
 124:	74 63                	je     189 <matchhere+0x79>
    return 1;
  if(re[1] == '*')
 126:	0f be 50 01          	movsbl 0x1(%eax),%edx
 12a:	80 fa 2a             	cmp    $0x2a,%dl
 12d:	74 7b                	je     1aa <matchhere+0x9a>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 12f:	80 fb 24             	cmp    $0x24,%bl
 132:	75 08                	jne    13c <matchhere+0x2c>
 134:	84 d2                	test   %dl,%dl
 136:	0f 84 8a 00 00 00    	je     1c6 <matchhere+0xb6>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 13c:	0f b6 37             	movzbl (%edi),%esi
 13f:	89 f1                	mov    %esi,%ecx
 141:	84 c9                	test   %cl,%cl
 143:	74 5b                	je     1a0 <matchhere+0x90>
 145:	38 cb                	cmp    %cl,%bl
 147:	74 05                	je     14e <matchhere+0x3e>
 149:	80 fb 2e             	cmp    $0x2e,%bl
 14c:	75 52                	jne    1a0 <matchhere+0x90>
    return matchhere(re+1, text+1);
 14e:	83 c7 01             	add    $0x1,%edi
 151:	83 c0 01             	add    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 154:	84 d2                	test   %dl,%dl
 156:	74 31                	je     189 <matchhere+0x79>
    return 1;
  if(re[1] == '*')
 158:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
 15c:	80 fb 2a             	cmp    $0x2a,%bl
 15f:	74 4c                	je     1ad <matchhere+0x9d>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 161:	80 fa 24             	cmp    $0x24,%dl
 164:	75 04                	jne    16a <matchhere+0x5a>
 166:	84 db                	test   %bl,%bl
 168:	74 5c                	je     1c6 <matchhere+0xb6>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 16a:	0f b6 37             	movzbl (%edi),%esi
 16d:	89 f1                	mov    %esi,%ecx
 16f:	84 c9                	test   %cl,%cl
 171:	74 2d                	je     1a0 <matchhere+0x90>
 173:	80 fa 2e             	cmp    $0x2e,%dl
 176:	74 04                	je     17c <matchhere+0x6c>
 178:	38 d1                	cmp    %dl,%cl
 17a:	75 24                	jne    1a0 <matchhere+0x90>
 17c:	0f be d3             	movsbl %bl,%edx
    return matchhere(re+1, text+1);
 17f:	83 c7 01             	add    $0x1,%edi
 182:	83 c0 01             	add    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 185:	84 d2                	test   %dl,%dl
 187:	75 cf                	jne    158 <matchhere+0x48>
    return 1;
 189:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 18e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 191:	5b                   	pop    %ebx
 192:	5e                   	pop    %esi
 193:	5f                   	pop    %edi
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    
 196:	8d 76 00             	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
 1a3:	31 c0                	xor    %eax,%eax
}
 1a5:	5b                   	pop    %ebx
 1a6:	5e                   	pop    %esi
 1a7:	5f                   	pop    %edi
 1a8:	5d                   	pop    %ebp
 1a9:	c3                   	ret    
// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
 1aa:	0f be d3             	movsbl %bl,%edx
    return matchstar(re[0], re+2, text);
 1ad:	83 ec 04             	sub    $0x4,%esp
 1b0:	83 c0 02             	add    $0x2,%eax
 1b3:	57                   	push   %edi
 1b4:	50                   	push   %eax
 1b5:	52                   	push   %edx
 1b6:	e8 f5 fe ff ff       	call   b0 <matchstar>
 1bb:	83 c4 10             	add    $0x10,%esp
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 1be:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c1:	5b                   	pop    %ebx
 1c2:	5e                   	pop    %esi
 1c3:	5f                   	pop    %edi
 1c4:	5d                   	pop    %ebp
 1c5:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
 1c6:	31 c0                	xor    %eax,%eax
 1c8:	80 3f 00             	cmpb   $0x0,(%edi)
 1cb:	0f 94 c0             	sete   %al
 1ce:	eb be                	jmp    18e <matchhere+0x7e>

000001d0 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	8b 75 08             	mov    0x8(%ebp),%esi
 1d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1db:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1de:	75 11                	jne    1f1 <match+0x21>
 1e0:	eb 2c                	jmp    20e <match+0x3e>
 1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
 1e8:	83 c3 01             	add    $0x1,%ebx
 1eb:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1ef:	74 16                	je     207 <match+0x37>
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 1f1:	83 ec 08             	sub    $0x8,%esp
 1f4:	53                   	push   %ebx
 1f5:	56                   	push   %esi
 1f6:	e8 15 ff ff ff       	call   110 <matchhere>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	85 c0                	test   %eax,%eax
 200:	74 e6                	je     1e8 <match+0x18>
      return 1;
 202:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 207:	8d 65 f8             	lea    -0x8(%ebp),%esp
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5d                   	pop    %ebp
 20d:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 20e:	83 c6 01             	add    $0x1,%esi
 211:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 214:	8d 65 f8             	lea    -0x8(%ebp),%esp
 217:	5b                   	pop    %ebx
 218:	5e                   	pop    %esi
 219:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 21a:	e9 f1 fe ff ff       	jmp    110 <matchhere>
 21f:	90                   	nop

00000220 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
 226:	83 ec 1c             	sub    $0x1c,%esp
 229:	8b 75 08             	mov    0x8(%ebp),%esi
  int n, m;
  char *p, *q;

  m = 0;
 22c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 233:	90                   	nop
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 238:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 23b:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 240:	83 ec 04             	sub    $0x4,%esp
 243:	29 c8                	sub    %ecx,%eax
 245:	50                   	push   %eax
 246:	8d 81 20 0e 00 00    	lea    0xe20(%ecx),%eax
 24c:	50                   	push   %eax
 24d:	ff 75 0c             	pushl  0xc(%ebp)
 250:	e8 55 03 00 00       	call   5aa <read>
 255:	83 c4 10             	add    $0x10,%esp
 258:	85 c0                	test   %eax,%eax
 25a:	0f 8e ac 00 00 00    	jle    30c <grep+0xec>
    m += n;
 260:	01 45 e4             	add    %eax,-0x1c(%ebp)
    buf[m] = '\0';
    p = buf;
 263:	bb 20 0e 00 00       	mov    $0xe20,%ebx
  int n, m;
  char *p, *q;

  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
 268:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 26b:	c6 82 20 0e 00 00 00 	movb   $0x0,0xe20(%edx)
 272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    p = buf;
    while((q = strchr(p, '\n')) != 0){
 278:	83 ec 08             	sub    $0x8,%esp
 27b:	6a 0a                	push   $0xa
 27d:	53                   	push   %ebx
 27e:	e8 6d 01 00 00       	call   3f0 <strchr>
 283:	83 c4 10             	add    $0x10,%esp
 286:	85 c0                	test   %eax,%eax
 288:	89 c7                	mov    %eax,%edi
 28a:	74 3c                	je     2c8 <grep+0xa8>
      *q = 0;
      if(match(pattern, p)){
 28c:	83 ec 08             	sub    $0x8,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
      *q = 0;
 28f:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 292:	53                   	push   %ebx
 293:	56                   	push   %esi
 294:	e8 37 ff ff ff       	call   1d0 <match>
 299:	83 c4 10             	add    $0x10,%esp
 29c:	85 c0                	test   %eax,%eax
 29e:	75 08                	jne    2a8 <grep+0x88>
 2a0:	8d 5f 01             	lea    0x1(%edi),%ebx
 2a3:	eb d3                	jmp    278 <grep+0x58>
 2a5:	8d 76 00             	lea    0x0(%esi),%esi
        *q = '\n';
 2a8:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 2ab:	83 c7 01             	add    $0x1,%edi
 2ae:	83 ec 04             	sub    $0x4,%esp
 2b1:	89 f8                	mov    %edi,%eax
 2b3:	29 d8                	sub    %ebx,%eax
 2b5:	50                   	push   %eax
 2b6:	53                   	push   %ebx
 2b7:	89 fb                	mov    %edi,%ebx
 2b9:	6a 01                	push   $0x1
 2bb:	e8 f2 02 00 00       	call   5b2 <write>
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	eb b3                	jmp    278 <grep+0x58>
 2c5:	8d 76 00             	lea    0x0(%esi),%esi
      }
      p = q+1;
    }
    if(p == buf)
 2c8:	81 fb 20 0e 00 00    	cmp    $0xe20,%ebx
 2ce:	74 30                	je     300 <grep+0xe0>
      m = 0;
    if(m > 0){
 2d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2d3:	85 c0                	test   %eax,%eax
 2d5:	0f 8e 5d ff ff ff    	jle    238 <grep+0x18>
      m -= p - buf;
 2db:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2dd:	83 ec 04             	sub    $0x4,%esp
      p = q+1;
    }
    if(p == buf)
      m = 0;
    if(m > 0){
      m -= p - buf;
 2e0:	2d 20 0e 00 00       	sub    $0xe20,%eax
 2e5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
 2e8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      memmove(buf, p, m);
 2eb:	51                   	push   %ecx
 2ec:	53                   	push   %ebx
 2ed:	68 20 0e 00 00       	push   $0xe20
 2f2:	e8 69 02 00 00       	call   560 <memmove>
 2f7:	83 c4 10             	add    $0x10,%esp
 2fa:	e9 39 ff ff ff       	jmp    238 <grep+0x18>
 2ff:	90                   	nop
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 300:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 307:	e9 2c ff ff ff       	jmp    238 <grep+0x18>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 30c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30f:	5b                   	pop    %ebx
 310:	5e                   	pop    %esi
 311:	5f                   	pop    %edi
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	66 90                	xchg   %ax,%ax
 316:	66 90                	xchg   %ax,%ax
 318:	66 90                	xchg   %ax,%ax
 31a:	66 90                	xchg   %ax,%ax
 31c:	66 90                	xchg   %ax,%ax
 31e:	66 90                	xchg   %ax,%ax

00000320 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 32a:	89 c2                	mov    %eax,%edx
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 330:	83 c1 01             	add    $0x1,%ecx
 333:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 337:	83 c2 01             	add    $0x1,%edx
 33a:	84 db                	test   %bl,%bl
 33c:	88 5a ff             	mov    %bl,-0x1(%edx)
 33f:	75 ef                	jne    330 <strcpy+0x10>
    ;
  return os;
}
 341:	5b                   	pop    %ebx
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000350 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	8b 55 08             	mov    0x8(%ebp),%edx
 358:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 35b:	0f b6 02             	movzbl (%edx),%eax
 35e:	0f b6 19             	movzbl (%ecx),%ebx
 361:	84 c0                	test   %al,%al
 363:	75 1e                	jne    383 <strcmp+0x33>
 365:	eb 29                	jmp    390 <strcmp+0x40>
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 370:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 373:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 376:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 379:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 37d:	84 c0                	test   %al,%al
 37f:	74 0f                	je     390 <strcmp+0x40>
 381:	89 f1                	mov    %esi,%ecx
 383:	38 d8                	cmp    %bl,%al
 385:	74 e9                	je     370 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 387:	29 d8                	sub    %ebx,%eax
}
 389:	5b                   	pop    %ebx
 38a:	5e                   	pop    %esi
 38b:	5d                   	pop    %ebp
 38c:	c3                   	ret    
 38d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 390:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 392:	29 d8                	sub    %ebx,%eax
}
 394:	5b                   	pop    %ebx
 395:	5e                   	pop    %esi
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <strlen>:

uint
strlen(char *s)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3a6:	80 39 00             	cmpb   $0x0,(%ecx)
 3a9:	74 12                	je     3bd <strlen+0x1d>
 3ab:	31 d2                	xor    %edx,%edx
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	83 c2 01             	add    $0x1,%edx
 3b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3b7:	89 d0                	mov    %edx,%eax
 3b9:	75 f5                	jne    3b0 <strlen+0x10>
    ;
  return n;
}
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 3bd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 3bf:	5d                   	pop    %ebp
 3c0:	c3                   	ret    
 3c1:	eb 0d                	jmp    3d0 <memset>
 3c3:	90                   	nop
 3c4:	90                   	nop
 3c5:	90                   	nop
 3c6:	90                   	nop
 3c7:	90                   	nop
 3c8:	90                   	nop
 3c9:	90                   	nop
 3ca:	90                   	nop
 3cb:	90                   	nop
 3cc:	90                   	nop
 3cd:	90                   	nop
 3ce:	90                   	nop
 3cf:	90                   	nop

000003d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	89 d7                	mov    %edx,%edi
 3df:	fc                   	cld    
 3e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3e2:	89 d0                	mov    %edx,%eax
 3e4:	5f                   	pop    %edi
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <strchr>:

char*
strchr(const char *s, char c)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	53                   	push   %ebx
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 3fa:	0f b6 10             	movzbl (%eax),%edx
 3fd:	84 d2                	test   %dl,%dl
 3ff:	74 1d                	je     41e <strchr+0x2e>
    if(*s == c)
 401:	38 d3                	cmp    %dl,%bl
 403:	89 d9                	mov    %ebx,%ecx
 405:	75 0d                	jne    414 <strchr+0x24>
 407:	eb 17                	jmp    420 <strchr+0x30>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 410:	38 ca                	cmp    %cl,%dl
 412:	74 0c                	je     420 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 414:	83 c0 01             	add    $0x1,%eax
 417:	0f b6 10             	movzbl (%eax),%edx
 41a:	84 d2                	test   %dl,%dl
 41c:	75 f2                	jne    410 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 41e:	31 c0                	xor    %eax,%eax
}
 420:	5b                   	pop    %ebx
 421:	5d                   	pop    %ebp
 422:	c3                   	ret    
 423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <gets>:

char*
gets(char *buf, int max)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 436:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 438:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 43b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43e:	eb 29                	jmp    469 <gets+0x39>
    cc = read(0, &c, 1);
 440:	83 ec 04             	sub    $0x4,%esp
 443:	6a 01                	push   $0x1
 445:	57                   	push   %edi
 446:	6a 00                	push   $0x0
 448:	e8 5d 01 00 00       	call   5aa <read>
    if(cc < 1)
 44d:	83 c4 10             	add    $0x10,%esp
 450:	85 c0                	test   %eax,%eax
 452:	7e 1d                	jle    471 <gets+0x41>
      break;
    buf[i++] = c;
 454:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 458:	8b 55 08             	mov    0x8(%ebp),%edx
 45b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 45d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 45f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 463:	74 1b                	je     480 <gets+0x50>
 465:	3c 0d                	cmp    $0xd,%al
 467:	74 17                	je     480 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 469:	8d 5e 01             	lea    0x1(%esi),%ebx
 46c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 46f:	7c cf                	jl     440 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 471:	8b 45 08             	mov    0x8(%ebp),%eax
 474:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 478:	8d 65 f4             	lea    -0xc(%ebp),%esp
 47b:	5b                   	pop    %ebx
 47c:	5e                   	pop    %esi
 47d:	5f                   	pop    %edi
 47e:	5d                   	pop    %ebp
 47f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 480:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 483:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 485:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 489:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48c:	5b                   	pop    %ebx
 48d:	5e                   	pop    %esi
 48e:	5f                   	pop    %edi
 48f:	5d                   	pop    %ebp
 490:	c3                   	ret    
 491:	eb 0d                	jmp    4a0 <stat>
 493:	90                   	nop
 494:	90                   	nop
 495:	90                   	nop
 496:	90                   	nop
 497:	90                   	nop
 498:	90                   	nop
 499:	90                   	nop
 49a:	90                   	nop
 49b:	90                   	nop
 49c:	90                   	nop
 49d:	90                   	nop
 49e:	90                   	nop
 49f:	90                   	nop

000004a0 <stat>:

int
stat(char *n, struct stat *st)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	56                   	push   %esi
 4a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a5:	83 ec 08             	sub    $0x8,%esp
 4a8:	6a 00                	push   $0x0
 4aa:	ff 75 08             	pushl  0x8(%ebp)
 4ad:	e8 20 01 00 00       	call   5d2 <open>
  if(fd < 0)
 4b2:	83 c4 10             	add    $0x10,%esp
 4b5:	85 c0                	test   %eax,%eax
 4b7:	78 27                	js     4e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4b9:	83 ec 08             	sub    $0x8,%esp
 4bc:	ff 75 0c             	pushl  0xc(%ebp)
 4bf:	89 c3                	mov    %eax,%ebx
 4c1:	50                   	push   %eax
 4c2:	e8 23 01 00 00       	call   5ea <fstat>
 4c7:	89 c6                	mov    %eax,%esi
  close(fd);
 4c9:	89 1c 24             	mov    %ebx,(%esp)
 4cc:	e8 e9 00 00 00       	call   5ba <close>
  return r;
 4d1:	83 c4 10             	add    $0x10,%esp
 4d4:	89 f0                	mov    %esi,%eax
}
 4d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4d9:	5b                   	pop    %ebx
 4da:	5e                   	pop    %esi
 4db:	5d                   	pop    %ebp
 4dc:	c3                   	ret    
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4e5:	eb ef                	jmp    4d6 <stat+0x36>
 4e7:	89 f6                	mov    %esi,%esi
 4e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	56                   	push   %esi
 4f4:	53                   	push   %ebx
 4f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
 4f8:	0f be 13             	movsbl (%ebx),%edx
 4fb:	80 fa 2d             	cmp    $0x2d,%dl
 4fe:	74 38                	je     538 <atoi+0x48>
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 500:	8d 42 d0             	lea    -0x30(%edx),%eax

int
atoi(const char *s)
{
  int n;
	int sign=0;	// let positive as 0, negative as 1
 503:	31 f6                	xor    %esi,%esi
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 505:	3c 09                	cmp    $0x9,%al
 507:	77 47                	ja     550 <atoi+0x60>
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
		sign=1;
 509:	31 c0                	xor    %eax,%eax
 50b:	90                   	nop
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		s++;
	}

  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
 510:	8d 04 80             	lea    (%eax,%eax,4),%eax
 513:	83 c3 01             	add    $0x1,%ebx
 516:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 51a:	0f be 13             	movsbl (%ebx),%edx
 51d:	8d 4a d0             	lea    -0x30(%edx),%ecx
 520:	80 f9 09             	cmp    $0x9,%cl
 523:	76 eb                	jbe    510 <atoi+0x20>
 525:	89 c2                	mov    %eax,%edx
 527:	f7 da                	neg    %edx
 529:	83 fe 01             	cmp    $0x1,%esi
 52c:	0f 44 c2             	cmove  %edx,%eax
  if(sign==1){
		return n*(-1);
	}

	return n;
}
 52f:	5b                   	pop    %ebx
 530:	5e                   	pop    %esi
 531:	5d                   	pop    %ebp
 532:	c3                   	ret    
 533:	90                   	nop
 534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(*s=='-'){
		sign=1;
		s++;
	}

  while('0' <= *s && *s <= '9')
 538:	0f be 53 01          	movsbl 0x1(%ebx),%edx

  n = 0;

	if(*s=='-'){
		sign=1;
		s++;
 53c:	8d 43 01             	lea    0x1(%ebx),%eax
	}

  while('0' <= *s && *s <= '9')
 53f:	8d 4a d0             	lea    -0x30(%edx),%ecx
 542:	80 f9 09             	cmp    $0x9,%cl
 545:	77 09                	ja     550 <atoi+0x60>

  n = 0;

	if(*s=='-'){
		sign=1;
		s++;
 547:	89 c3                	mov    %eax,%ebx
	int sign=0;	// let positive as 0, negative as 1

  n = 0;

	if(*s=='-'){
		sign=1;
 549:	be 01 00 00 00       	mov    $0x1,%esi
 54e:	eb b9                	jmp    509 <atoi+0x19>
		s++;
	}

  while('0' <= *s && *s <= '9')
 550:	31 c0                	xor    %eax,%eax
 552:	eb db                	jmp    52f <atoi+0x3f>
 554:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 55a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000560 <memmove>:
	return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	56                   	push   %esi
 564:	53                   	push   %ebx
 565:	8b 5d 10             	mov    0x10(%ebp),%ebx
 568:	8b 45 08             	mov    0x8(%ebp),%eax
 56b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 56e:	85 db                	test   %ebx,%ebx
 570:	7e 14                	jle    586 <memmove+0x26>
 572:	31 d2                	xor    %edx,%edx
 574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 578:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 57c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 57f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 582:	39 da                	cmp    %ebx,%edx
 584:	75 f2                	jne    578 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 586:	5b                   	pop    %ebx
 587:	5e                   	pop    %esi
 588:	5d                   	pop    %ebp
 589:	c3                   	ret    

0000058a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 58a:	b8 01 00 00 00       	mov    $0x1,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <exit>:
SYSCALL(exit)
 592:	b8 02 00 00 00       	mov    $0x2,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <wait>:
SYSCALL(wait)
 59a:	b8 03 00 00 00       	mov    $0x3,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <pipe>:
SYSCALL(pipe)
 5a2:	b8 04 00 00 00       	mov    $0x4,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <read>:
SYSCALL(read)
 5aa:	b8 05 00 00 00       	mov    $0x5,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <write>:
SYSCALL(write)
 5b2:	b8 10 00 00 00       	mov    $0x10,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <close>:
SYSCALL(close)
 5ba:	b8 15 00 00 00       	mov    $0x15,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <kill>:
SYSCALL(kill)
 5c2:	b8 06 00 00 00       	mov    $0x6,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <exec>:
SYSCALL(exec)
 5ca:	b8 07 00 00 00       	mov    $0x7,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <open>:
SYSCALL(open)
 5d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <mknod>:
SYSCALL(mknod)
 5da:	b8 11 00 00 00       	mov    $0x11,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <unlink>:
SYSCALL(unlink)
 5e2:	b8 12 00 00 00       	mov    $0x12,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <fstat>:
SYSCALL(fstat)
 5ea:	b8 08 00 00 00       	mov    $0x8,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <link>:
SYSCALL(link)
 5f2:	b8 13 00 00 00       	mov    $0x13,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <mkdir>:
SYSCALL(mkdir)
 5fa:	b8 14 00 00 00       	mov    $0x14,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <chdir>:
SYSCALL(chdir)
 602:	b8 09 00 00 00       	mov    $0x9,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <dup>:
SYSCALL(dup)
 60a:	b8 0a 00 00 00       	mov    $0xa,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <getpid>:
SYSCALL(getpid)
 612:	b8 0b 00 00 00       	mov    $0xb,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <sbrk>:
SYSCALL(sbrk)
 61a:	b8 0c 00 00 00       	mov    $0xc,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <sleep>:
SYSCALL(sleep)
 622:	b8 0d 00 00 00       	mov    $0xd,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <uptime>:
SYSCALL(uptime)
 62a:	b8 0e 00 00 00       	mov    $0xe,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <halt>:
SYSCALL(halt)
 632:	b8 16 00 00 00       	mov    $0x16,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <setnice>:
//////////////////////
SYSCALL(setnice)
 63a:	b8 18 00 00 00       	mov    $0x18,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <getnice>:
SYSCALL(getnice)
 642:	b8 17 00 00 00       	mov    $0x17,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <ps>:
SYSCALL(ps)
 64a:	b8 19 00 00 00       	mov    $0x19,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    
 652:	66 90                	xchg   %ax,%ax
 654:	66 90                	xchg   %ax,%ax
 656:	66 90                	xchg   %ax,%ax
 658:	66 90                	xchg   %ax,%ax
 65a:	66 90                	xchg   %ax,%ax
 65c:	66 90                	xchg   %ax,%ax
 65e:	66 90                	xchg   %ax,%ax

00000660 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	89 c6                	mov    %eax,%esi
 668:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 66e:	85 db                	test   %ebx,%ebx
 670:	74 7e                	je     6f0 <printint+0x90>
 672:	89 d0                	mov    %edx,%eax
 674:	c1 e8 1f             	shr    $0x1f,%eax
 677:	84 c0                	test   %al,%al
 679:	74 75                	je     6f0 <printint+0x90>
    neg = 1;
    x = -xx;
 67b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 67d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 684:	f7 d8                	neg    %eax
 686:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 689:	31 ff                	xor    %edi,%edi
 68b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 68e:	89 ce                	mov    %ecx,%esi
 690:	eb 08                	jmp    69a <printint+0x3a>
 692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 698:	89 cf                	mov    %ecx,%edi
 69a:	31 d2                	xor    %edx,%edx
 69c:	8d 4f 01             	lea    0x1(%edi),%ecx
 69f:	f7 f6                	div    %esi
 6a1:	0f b6 92 60 0a 00 00 	movzbl 0xa60(%edx),%edx
  }while((x /= base) != 0);
 6a8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 6aa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 6ad:	75 e9                	jne    698 <printint+0x38>
  if(neg)
 6af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 6b2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 6b5:	85 c0                	test   %eax,%eax
 6b7:	74 08                	je     6c1 <printint+0x61>
    buf[i++] = '-';
 6b9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 6be:	8d 4f 02             	lea    0x2(%edi),%ecx
 6c1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 6c5:	8d 76 00             	lea    0x0(%esi),%esi
 6c8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6cb:	83 ec 04             	sub    $0x4,%esp
 6ce:	83 ef 01             	sub    $0x1,%edi
 6d1:	6a 01                	push   $0x1
 6d3:	53                   	push   %ebx
 6d4:	56                   	push   %esi
 6d5:	88 45 d7             	mov    %al,-0x29(%ebp)
 6d8:	e8 d5 fe ff ff       	call   5b2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6dd:	83 c4 10             	add    $0x10,%esp
 6e0:	39 df                	cmp    %ebx,%edi
 6e2:	75 e4                	jne    6c8 <printint+0x68>
    putc(fd, buf[i]);
}
 6e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6e7:	5b                   	pop    %ebx
 6e8:	5e                   	pop    %esi
 6e9:	5f                   	pop    %edi
 6ea:	5d                   	pop    %ebp
 6eb:	c3                   	ret    
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6f0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6f2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6f9:	eb 8b                	jmp    686 <printint+0x26>
 6fb:	90                   	nop
 6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000700 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 706:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 709:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 70c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 70f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 712:	89 45 d0             	mov    %eax,-0x30(%ebp)
 715:	0f b6 1e             	movzbl (%esi),%ebx
 718:	83 c6 01             	add    $0x1,%esi
 71b:	84 db                	test   %bl,%bl
 71d:	0f 84 b0 00 00 00    	je     7d3 <printf+0xd3>
 723:	31 d2                	xor    %edx,%edx
 725:	eb 39                	jmp    760 <printf+0x60>
 727:	89 f6                	mov    %esi,%esi
 729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 730:	83 f8 25             	cmp    $0x25,%eax
 733:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 736:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 73b:	74 18                	je     755 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 740:	83 ec 04             	sub    $0x4,%esp
 743:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 746:	6a 01                	push   $0x1
 748:	50                   	push   %eax
 749:	57                   	push   %edi
 74a:	e8 63 fe ff ff       	call   5b2 <write>
 74f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 752:	83 c4 10             	add    $0x10,%esp
 755:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 758:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 75c:	84 db                	test   %bl,%bl
 75e:	74 73                	je     7d3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 760:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 762:	0f be cb             	movsbl %bl,%ecx
 765:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 768:	74 c6                	je     730 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 76a:	83 fa 25             	cmp    $0x25,%edx
 76d:	75 e6                	jne    755 <printf+0x55>
      if(c == 'd'){
 76f:	83 f8 64             	cmp    $0x64,%eax
 772:	0f 84 f8 00 00 00    	je     870 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 778:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 77e:	83 f9 70             	cmp    $0x70,%ecx
 781:	74 5d                	je     7e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 783:	83 f8 73             	cmp    $0x73,%eax
 786:	0f 84 84 00 00 00    	je     810 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 78c:	83 f8 63             	cmp    $0x63,%eax
 78f:	0f 84 ea 00 00 00    	je     87f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 795:	83 f8 25             	cmp    $0x25,%eax
 798:	0f 84 c2 00 00 00    	je     860 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 79e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7a1:	83 ec 04             	sub    $0x4,%esp
 7a4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7a8:	6a 01                	push   $0x1
 7aa:	50                   	push   %eax
 7ab:	57                   	push   %edi
 7ac:	e8 01 fe ff ff       	call   5b2 <write>
 7b1:	83 c4 0c             	add    $0xc,%esp
 7b4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 7b7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 7ba:	6a 01                	push   $0x1
 7bc:	50                   	push   %eax
 7bd:	57                   	push   %edi
 7be:	83 c6 01             	add    $0x1,%esi
 7c1:	e8 ec fd ff ff       	call   5b2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7c6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ca:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7cd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7cf:	84 db                	test   %bl,%bl
 7d1:	75 8d                	jne    760 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7d6:	5b                   	pop    %ebx
 7d7:	5e                   	pop    %esi
 7d8:	5f                   	pop    %edi
 7d9:	5d                   	pop    %ebp
 7da:	c3                   	ret    
 7db:	90                   	nop
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7e0:	83 ec 0c             	sub    $0xc,%esp
 7e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 7e8:	6a 00                	push   $0x0
 7ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7ed:	89 f8                	mov    %edi,%eax
 7ef:	8b 13                	mov    (%ebx),%edx
 7f1:	e8 6a fe ff ff       	call   660 <printint>
        ap++;
 7f6:	89 d8                	mov    %ebx,%eax
 7f8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7fb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 7fd:	83 c0 04             	add    $0x4,%eax
 800:	89 45 d0             	mov    %eax,-0x30(%ebp)
 803:	e9 4d ff ff ff       	jmp    755 <printf+0x55>
 808:	90                   	nop
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 810:	8b 45 d0             	mov    -0x30(%ebp),%eax
 813:	8b 18                	mov    (%eax),%ebx
        ap++;
 815:	83 c0 04             	add    $0x4,%eax
 818:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 81b:	b8 56 0a 00 00       	mov    $0xa56,%eax
 820:	85 db                	test   %ebx,%ebx
 822:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 825:	0f b6 03             	movzbl (%ebx),%eax
 828:	84 c0                	test   %al,%al
 82a:	74 23                	je     84f <printf+0x14f>
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 830:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 833:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 836:	83 ec 04             	sub    $0x4,%esp
 839:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 83b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 83e:	50                   	push   %eax
 83f:	57                   	push   %edi
 840:	e8 6d fd ff ff       	call   5b2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 845:	0f b6 03             	movzbl (%ebx),%eax
 848:	83 c4 10             	add    $0x10,%esp
 84b:	84 c0                	test   %al,%al
 84d:	75 e1                	jne    830 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 84f:	31 d2                	xor    %edx,%edx
 851:	e9 ff fe ff ff       	jmp    755 <printf+0x55>
 856:	8d 76 00             	lea    0x0(%esi),%esi
 859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 860:	83 ec 04             	sub    $0x4,%esp
 863:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 866:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 869:	6a 01                	push   $0x1
 86b:	e9 4c ff ff ff       	jmp    7bc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 870:	83 ec 0c             	sub    $0xc,%esp
 873:	b9 0a 00 00 00       	mov    $0xa,%ecx
 878:	6a 01                	push   $0x1
 87a:	e9 6b ff ff ff       	jmp    7ea <printf+0xea>
 87f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 882:	83 ec 04             	sub    $0x4,%esp
 885:	8b 03                	mov    (%ebx),%eax
 887:	6a 01                	push   $0x1
 889:	88 45 e4             	mov    %al,-0x1c(%ebp)
 88c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 88f:	50                   	push   %eax
 890:	57                   	push   %edi
 891:	e8 1c fd ff ff       	call   5b2 <write>
 896:	e9 5b ff ff ff       	jmp    7f6 <printf+0xf6>
 89b:	66 90                	xchg   %ax,%ax
 89d:	66 90                	xchg   %ax,%ax
 89f:	90                   	nop

000008a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a1:	a1 00 0e 00 00       	mov    0xe00,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a6:	89 e5                	mov    %esp,%ebp
 8a8:	57                   	push   %edi
 8a9:	56                   	push   %esi
 8aa:	53                   	push   %ebx
 8ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ae:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8b0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b3:	39 c8                	cmp    %ecx,%eax
 8b5:	73 19                	jae    8d0 <free+0x30>
 8b7:	89 f6                	mov    %esi,%esi
 8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 8c0:	39 d1                	cmp    %edx,%ecx
 8c2:	72 1c                	jb     8e0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c4:	39 d0                	cmp    %edx,%eax
 8c6:	73 18                	jae    8e0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ca:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8cc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ce:	72 f0                	jb     8c0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d0:	39 d0                	cmp    %edx,%eax
 8d2:	72 f4                	jb     8c8 <free+0x28>
 8d4:	39 d1                	cmp    %edx,%ecx
 8d6:	73 f0                	jae    8c8 <free+0x28>
 8d8:	90                   	nop
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 8e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8e6:	39 d7                	cmp    %edx,%edi
 8e8:	74 19                	je     903 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8ed:	8b 50 04             	mov    0x4(%eax),%edx
 8f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8f3:	39 f1                	cmp    %esi,%ecx
 8f5:	74 23                	je     91a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8f7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 8f9:	a3 00 0e 00 00       	mov    %eax,0xe00
}
 8fe:	5b                   	pop    %ebx
 8ff:	5e                   	pop    %esi
 900:	5f                   	pop    %edi
 901:	5d                   	pop    %ebp
 902:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 903:	03 72 04             	add    0x4(%edx),%esi
 906:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 909:	8b 10                	mov    (%eax),%edx
 90b:	8b 12                	mov    (%edx),%edx
 90d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 910:	8b 50 04             	mov    0x4(%eax),%edx
 913:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 916:	39 f1                	cmp    %esi,%ecx
 918:	75 dd                	jne    8f7 <free+0x57>
    p->s.size += bp->s.size;
 91a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 91d:	a3 00 0e 00 00       	mov    %eax,0xe00
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 922:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 925:	8b 53 f8             	mov    -0x8(%ebx),%edx
 928:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 92a:	5b                   	pop    %ebx
 92b:	5e                   	pop    %esi
 92c:	5f                   	pop    %edi
 92d:	5d                   	pop    %ebp
 92e:	c3                   	ret    
 92f:	90                   	nop

00000930 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
 936:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 939:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 93c:	8b 15 00 0e 00 00    	mov    0xe00,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 942:	8d 78 07             	lea    0x7(%eax),%edi
 945:	c1 ef 03             	shr    $0x3,%edi
 948:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 94b:	85 d2                	test   %edx,%edx
 94d:	0f 84 a3 00 00 00    	je     9f6 <malloc+0xc6>
 953:	8b 02                	mov    (%edx),%eax
 955:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 958:	39 cf                	cmp    %ecx,%edi
 95a:	76 74                	jbe    9d0 <malloc+0xa0>
 95c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 962:	be 00 10 00 00       	mov    $0x1000,%esi
 967:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 96e:	0f 43 f7             	cmovae %edi,%esi
 971:	ba 00 80 00 00       	mov    $0x8000,%edx
 976:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 97c:	0f 46 da             	cmovbe %edx,%ebx
 97f:	eb 10                	jmp    991 <malloc+0x61>
 981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 988:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 98a:	8b 48 04             	mov    0x4(%eax),%ecx
 98d:	39 cf                	cmp    %ecx,%edi
 98f:	76 3f                	jbe    9d0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 991:	39 05 00 0e 00 00    	cmp    %eax,0xe00
 997:	89 c2                	mov    %eax,%edx
 999:	75 ed                	jne    988 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 99b:	83 ec 0c             	sub    $0xc,%esp
 99e:	53                   	push   %ebx
 99f:	e8 76 fc ff ff       	call   61a <sbrk>
  if(p == (char*)-1)
 9a4:	83 c4 10             	add    $0x10,%esp
 9a7:	83 f8 ff             	cmp    $0xffffffff,%eax
 9aa:	74 1c                	je     9c8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 9ac:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 9af:	83 ec 0c             	sub    $0xc,%esp
 9b2:	83 c0 08             	add    $0x8,%eax
 9b5:	50                   	push   %eax
 9b6:	e8 e5 fe ff ff       	call   8a0 <free>
  return freep;
 9bb:	8b 15 00 0e 00 00    	mov    0xe00,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 9c1:	83 c4 10             	add    $0x10,%esp
 9c4:	85 d2                	test   %edx,%edx
 9c6:	75 c0                	jne    988 <malloc+0x58>
        return 0;
 9c8:	31 c0                	xor    %eax,%eax
 9ca:	eb 1c                	jmp    9e8 <malloc+0xb8>
 9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 9d0:	39 cf                	cmp    %ecx,%edi
 9d2:	74 1c                	je     9f0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 9d4:	29 f9                	sub    %edi,%ecx
 9d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9dc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 9df:	89 15 00 0e 00 00    	mov    %edx,0xe00
      return (void*)(p + 1);
 9e5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9eb:	5b                   	pop    %ebx
 9ec:	5e                   	pop    %esi
 9ed:	5f                   	pop    %edi
 9ee:	5d                   	pop    %ebp
 9ef:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 9f0:	8b 08                	mov    (%eax),%ecx
 9f2:	89 0a                	mov    %ecx,(%edx)
 9f4:	eb e9                	jmp    9df <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9f6:	c7 05 00 0e 00 00 04 	movl   $0xe04,0xe00
 9fd:	0e 00 00 
 a00:	c7 05 04 0e 00 00 04 	movl   $0xe04,0xe04
 a07:	0e 00 00 
    base.s.size = 0;
 a0a:	b8 04 0e 00 00       	mov    $0xe04,%eax
 a0f:	c7 05 08 0e 00 00 00 	movl   $0x0,0xe08
 a16:	00 00 00 
 a19:	e9 3e ff ff ff       	jmp    95c <malloc+0x2c>
