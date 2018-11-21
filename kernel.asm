
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 2e 10 80       	mov    $0x80102e80,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 60 71 10 80       	push   $0x80107160
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 e5 42 00 00       	call   80104340 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 71 10 80       	push   $0x80107167
80100097:	50                   	push   %eax
80100098:	e8 93 41 00 00       	call   80104230 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e4:	e8 77 42 00 00       	call   80104360 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 d9 43 00 00       	call   80104540 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 40 00 00       	call   80104270 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 0d 1f 00 00       	call   80102090 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 6e 71 10 80       	push   $0x8010716e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 5d 41 00 00       	call   80104310 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 c7 1e 00 00       	jmp    80102090 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 71 10 80       	push   $0x8010717f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 1c 41 00 00       	call   80104310 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 40 00 00       	call   801042d0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 50 41 00 00       	call   80104360 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 df 42 00 00       	jmp    80104540 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 71 10 80       	push   $0x80107186
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 7b 14 00 00       	call   80101700 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 cf 40 00 00       	call   80104360 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002a6:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 c0 ff 10 80       	push   $0x8010ffc0
801002bd:	e8 ce 3a 00 00       	call   80103d90 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(proc->killed){
801002d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002d8:	8b 40 24             	mov    0x24(%eax),%eax
801002db:	85 c0                	test   %eax,%eax
801002dd:	74 d1                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002df:	83 ec 0c             	sub    $0xc,%esp
801002e2:	68 20 a5 10 80       	push   $0x8010a520
801002e7:	e8 54 42 00 00       	call   80104540 <release>
        ilock(ip);
801002ec:	89 3c 24             	mov    %edi,(%esp)
801002ef:	e8 2c 13 00 00       	call   80101620 <ilock>
        return -1;
801002f4:	83 c4 10             	add    $0x10,%esp
801002f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002ff:	5b                   	pop    %ebx
80100300:	5e                   	pop    %esi
80100301:	5f                   	pop    %edi
80100302:	5d                   	pop    %ebp
80100303:	c3                   	ret    
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 40 ff 10 80 	movsbl -0x7fef00c0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 f5 41 00 00       	call   80104540 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 cd 12 00 00       	call   80101620 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a1                	jmp    801002fc <consoleread+0x8c>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100379:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
8010037f:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100386:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100389:	8d 5d d0             	lea    -0x30(%ebp),%ebx
8010038c:	8d 75 f8             	lea    -0x8(%ebp),%esi
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010038f:	0f b6 00             	movzbl (%eax),%eax
80100392:	50                   	push   %eax
80100393:	68 8d 71 10 80       	push   $0x8010718d
80100398:	e8 c3 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039d:	58                   	pop    %eax
8010039e:	ff 75 08             	pushl  0x8(%ebp)
801003a1:	e8 ba 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a6:	c7 04 24 6f 7a 10 80 	movl   $0x80107a6f,(%esp)
801003ad:	e8 ae 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b2:	5a                   	pop    %edx
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	59                   	pop    %ecx
801003b7:	53                   	push   %ebx
801003b8:	50                   	push   %eax
801003b9:	e8 72 40 00 00       	call   80104430 <getcallerpcs>
801003be:	83 c4 10             	add    $0x10,%esp
801003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c8:	83 ec 08             	sub    $0x8,%esp
801003cb:	ff 33                	pushl  (%ebx)
801003cd:	83 c3 04             	add    $0x4,%ebx
801003d0:	68 a9 71 10 80       	push   $0x801071a9
801003d5:	e8 86 02 00 00       	call   80100660 <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003da:	83 c4 10             	add    $0x10,%esp
801003dd:	39 f3                	cmp    %esi,%ebx
801003df:	75 e7                	jne    801003c8 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003e1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e8:	00 00 00 
801003eb:	eb fe                	jmp    801003eb <panic+0x7b>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 e1 58 00 00       	call   80105d00 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 28 58 00 00       	call   80105d00 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 1c 58 00 00       	call   80105d00 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 10 58 00 00       	call   80105d00 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 27 41 00 00       	call   80104640 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 62 40 00 00       	call   80104590 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 ad 71 10 80       	push   $0x801071ad
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 d8 71 10 80 	movzbl -0x7fef8e28(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 ec 10 00 00       	call   80101700 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 40 3d 00 00       	call   80104360 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 f4 3e 00 00       	call   80104540 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 cb 0f 00 00       	call   80101620 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 a5 10 80       	push   $0x8010a520
8010070d:	e8 2e 3e 00 00       	call   80104540 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 c0 71 10 80       	mov    $0x801071c0,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 a5 10 80       	push   $0x8010a520
801007c8:	e8 93 3b 00 00       	call   80104360 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 c7 71 10 80       	push   $0x801071c7
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 20 a5 10 80       	push   $0x8010a520
80100803:	e8 58 3b 00 00       	call   80104360 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100836:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 a5 10 80       	push   $0x8010a520
80100868:	e8 d3 3c 00 00       	call   80104540 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 c8 ff 10 80    	cmp    %eax,0x8010ffc8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
801008f1:	68 c0 ff 10 80       	push   $0x8010ffc0
801008f6:	e8 35 36 00 00       	call   80103f30 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010090d:	39 05 c4 ff 10 80    	cmp    %eax,0x8010ffc4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100934:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 a4 36 00 00       	jmp    80104020 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 d0 71 10 80       	push   $0x801071d0
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 8b 39 00 00       	call   80104340 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bc:	c7 05 8c 09 11 80 00 	movl   $0x80100600,0x8011098c
801009c3:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c6:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
801009cd:	02 10 80 
  cons.locking = 1;
801009d0:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009d7:	00 00 00 

  picenable(IRQ_KBD);
801009da:	e8 51 28 00 00       	call   80103230 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009df:	58                   	pop    %eax
801009e0:	5a                   	pop    %edx
801009e1:	6a 00                	push   $0x0
801009e3:	6a 01                	push   $0x1
801009e5:	e8 66 18 00 00       	call   80102250 <ioapicenable>
}
801009ea:	83 c4 10             	add    $0x10,%esp
801009ed:	c9                   	leave  
801009ee:	c3                   	ret    
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
801009fc:	e8 7f 21 00 00       	call   80102b80 <begin_op>

  if((ip = namei(path)) == 0){
80100a01:	83 ec 0c             	sub    $0xc,%esp
80100a04:	ff 75 08             	pushl  0x8(%ebp)
80100a07:	e8 44 14 00 00       	call   80101e50 <namei>
80100a0c:	83 c4 10             	add    $0x10,%esp
80100a0f:	85 c0                	test   %eax,%eax
80100a11:	0f 84 9f 01 00 00    	je     80100bb6 <exec+0x1c6>
    end_op();
    return -1;
  }
  ilock(ip);
80100a17:	83 ec 0c             	sub    $0xc,%esp
80100a1a:	89 c3                	mov    %eax,%ebx
80100a1c:	50                   	push   %eax
80100a1d:	e8 fe 0b 00 00       	call   80101620 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a22:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a28:	6a 34                	push   $0x34
80100a2a:	6a 00                	push   $0x0
80100a2c:	50                   	push   %eax
80100a2d:	53                   	push   %ebx
80100a2e:	e8 ad 0e 00 00       	call   801018e0 <readi>
80100a33:	83 c4 20             	add    $0x20,%esp
80100a36:	83 f8 34             	cmp    $0x34,%eax
80100a39:	74 25                	je     80100a60 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a3b:	83 ec 0c             	sub    $0xc,%esp
80100a3e:	53                   	push   %ebx
80100a3f:	e8 4c 0e 00 00       	call   80101890 <iunlockput>
    end_op();
80100a44:	e8 a7 21 00 00       	call   80102bf0 <end_op>
80100a49:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a54:	5b                   	pop    %ebx
80100a55:	5e                   	pop    %esi
80100a56:	5f                   	pop    %edi
80100a57:	5d                   	pop    %ebp
80100a58:	c3                   	ret    
80100a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a60:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a67:	45 4c 46 
80100a6a:	75 cf                	jne    80100a3b <exec+0x4b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a6c:	e8 6f 60 00 00       	call   80106ae0 <setupkvm>
80100a71:	85 c0                	test   %eax,%eax
80100a73:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a79:	74 c0                	je     80100a3b <exec+0x4b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a7b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a82:	00 
80100a83:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a89:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100a90:	00 00 00 
80100a93:	0f 84 c5 00 00 00    	je     80100b5e <exec+0x16e>
80100a99:	31 ff                	xor    %edi,%edi
80100a9b:	eb 18                	jmp    80100ab5 <exec+0xc5>
80100a9d:	8d 76 00             	lea    0x0(%esi),%esi
80100aa0:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aa7:	83 c7 01             	add    $0x1,%edi
80100aaa:	83 c6 20             	add    $0x20,%esi
80100aad:	39 f8                	cmp    %edi,%eax
80100aaf:	0f 8e a9 00 00 00    	jle    80100b5e <exec+0x16e>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100ab5:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100abb:	6a 20                	push   $0x20
80100abd:	56                   	push   %esi
80100abe:	50                   	push   %eax
80100abf:	53                   	push   %ebx
80100ac0:	e8 1b 0e 00 00       	call   801018e0 <readi>
80100ac5:	83 c4 10             	add    $0x10,%esp
80100ac8:	83 f8 20             	cmp    $0x20,%eax
80100acb:	75 7b                	jne    80100b48 <exec+0x158>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100acd:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ad4:	75 ca                	jne    80100aa0 <exec+0xb0>
      continue;
    if(ph.memsz < ph.filesz)
80100ad6:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100adc:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ae2:	72 64                	jb     80100b48 <exec+0x158>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ae4:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100aea:	72 5c                	jb     80100b48 <exec+0x158>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aec:	83 ec 04             	sub    $0x4,%esp
80100aef:	50                   	push   %eax
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100afc:	e8 9f 62 00 00       	call   80106da0 <allocuvm>
80100b01:	83 c4 10             	add    $0x10,%esp
80100b04:	85 c0                	test   %eax,%eax
80100b06:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b0c:	74 3a                	je     80100b48 <exec+0x158>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b0e:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b14:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b19:	75 2d                	jne    80100b48 <exec+0x158>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b1b:	83 ec 0c             	sub    $0xc,%esp
80100b1e:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b24:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b2a:	53                   	push   %ebx
80100b2b:	50                   	push   %eax
80100b2c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b32:	e8 a9 61 00 00       	call   80106ce0 <loaduvm>
80100b37:	83 c4 20             	add    $0x20,%esp
80100b3a:	85 c0                	test   %eax,%eax
80100b3c:	0f 89 5e ff ff ff    	jns    80100aa0 <exec+0xb0>
80100b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b48:	83 ec 0c             	sub    $0xc,%esp
80100b4b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b51:	e8 7a 63 00 00       	call   80106ed0 <freevm>
80100b56:	83 c4 10             	add    $0x10,%esp
80100b59:	e9 dd fe ff ff       	jmp    80100a3b <exec+0x4b>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b5e:	83 ec 0c             	sub    $0xc,%esp
80100b61:	53                   	push   %ebx
80100b62:	e8 29 0d 00 00       	call   80101890 <iunlockput>
  end_op();
80100b67:	e8 84 20 00 00       	call   80102bf0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b6c:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b72:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b75:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b7a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b7f:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b85:	52                   	push   %edx
80100b86:	50                   	push   %eax
80100b87:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b8d:	e8 0e 62 00 00       	call   80106da0 <allocuvm>
80100b92:	83 c4 10             	add    $0x10,%esp
80100b95:	85 c0                	test   %eax,%eax
80100b97:	89 c6                	mov    %eax,%esi
80100b99:	75 2a                	jne    80100bc5 <exec+0x1d5>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b9b:	83 ec 0c             	sub    $0xc,%esp
80100b9e:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba4:	e8 27 63 00 00       	call   80106ed0 <freevm>
80100ba9:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb1:	e9 9b fe ff ff       	jmp    80100a51 <exec+0x61>
  pde_t *pgdir, *oldpgdir;

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bb6:	e8 35 20 00 00       	call   80102bf0 <end_op>
    return -1;
80100bbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc0:	e9 8c fe ff ff       	jmp    80100a51 <exec+0x61>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bc5:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bcb:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bce:	31 ff                	xor    %edi,%edi
80100bd0:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bd2:	50                   	push   %eax
80100bd3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bd9:	e8 72 63 00 00       	call   80106f50 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bde:	8b 45 0c             	mov    0xc(%ebp),%eax
80100be1:	83 c4 10             	add    $0x10,%esp
80100be4:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bea:	8b 00                	mov    (%eax),%eax
80100bec:	85 c0                	test   %eax,%eax
80100bee:	74 6d                	je     80100c5d <exec+0x26d>
80100bf0:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100bf6:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100bfc:	eb 07                	jmp    80100c05 <exec+0x215>
80100bfe:	66 90                	xchg   %ax,%ax
    if(argc >= MAXARG)
80100c00:	83 ff 20             	cmp    $0x20,%edi
80100c03:	74 96                	je     80100b9b <exec+0x1ab>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c05:	83 ec 0c             	sub    $0xc,%esp
80100c08:	50                   	push   %eax
80100c09:	e8 c2 3b 00 00       	call   801047d0 <strlen>
80100c0e:	f7 d0                	not    %eax
80100c10:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c12:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c15:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c16:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c19:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c1c:	e8 af 3b 00 00       	call   801047d0 <strlen>
80100c21:	83 c0 01             	add    $0x1,%eax
80100c24:	50                   	push   %eax
80100c25:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c28:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c2b:	53                   	push   %ebx
80100c2c:	56                   	push   %esi
80100c2d:	e8 7e 64 00 00       	call   801070b0 <copyout>
80100c32:	83 c4 20             	add    $0x20,%esp
80100c35:	85 c0                	test   %eax,%eax
80100c37:	0f 88 5e ff ff ff    	js     80100b9b <exec+0x1ab>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c40:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c47:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c4a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c50:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c53:	85 c0                	test   %eax,%eax
80100c55:	75 a9                	jne    80100c00 <exec+0x210>
80100c57:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c5d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c64:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c66:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c6d:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c71:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c78:	ff ff ff 
  ustack[1] = argc;
80100c7b:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c83:	83 c0 0c             	add    $0xc,%eax
80100c86:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c88:	50                   	push   %eax
80100c89:	52                   	push   %edx
80100c8a:	53                   	push   %ebx
80100c8b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c91:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c97:	e8 14 64 00 00       	call   801070b0 <copyout>
80100c9c:	83 c4 10             	add    $0x10,%esp
80100c9f:	85 c0                	test   %eax,%eax
80100ca1:	0f 88 f4 fe ff ff    	js     80100b9b <exec+0x1ab>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ca7:	8b 45 08             	mov    0x8(%ebp),%eax
80100caa:	0f b6 10             	movzbl (%eax),%edx
80100cad:	84 d2                	test   %dl,%dl
80100caf:	74 19                	je     80100cca <exec+0x2da>
80100cb1:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cb4:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100cb7:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cba:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100cbd:	0f 44 c8             	cmove  %eax,%ecx
80100cc0:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cc3:	84 d2                	test   %dl,%dl
80100cc5:	75 f0                	jne    80100cb7 <exec+0x2c7>
80100cc7:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100cca:	50                   	push   %eax
80100ccb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cd1:	6a 10                	push   $0x10
80100cd3:	ff 75 08             	pushl  0x8(%ebp)
80100cd6:	83 c0 6c             	add    $0x6c,%eax
80100cd9:	50                   	push   %eax
80100cda:	e8 b1 3a 00 00       	call   80104790 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100cdf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100ce5:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100ceb:	8b 78 04             	mov    0x4(%eax),%edi
  proc->pgdir = pgdir;
  proc->sz = sz;
80100cee:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  proc->pgdir = pgdir;
80100cf0:	89 48 04             	mov    %ecx,0x4(%eax)
  proc->sz = sz;
  proc->tf->eip = elf.entry;  // main
80100cf3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cf9:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100cff:	8b 50 18             	mov    0x18(%eax),%edx
80100d02:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100d05:	8b 50 18             	mov    0x18(%eax),%edx
80100d08:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(proc);
80100d0b:	89 04 24             	mov    %eax,(%esp)
80100d0e:	e8 7d 5e 00 00       	call   80106b90 <switchuvm>
  freevm(oldpgdir);
80100d13:	89 3c 24             	mov    %edi,(%esp)
80100d16:	e8 b5 61 00 00       	call   80106ed0 <freevm>
  return 0;
80100d1b:	83 c4 10             	add    $0x10,%esp
80100d1e:	31 c0                	xor    %eax,%eax
80100d20:	e9 2c fd ff ff       	jmp    80100a51 <exec+0x61>
80100d25:	66 90                	xchg   %ax,%ax
80100d27:	66 90                	xchg   %ax,%ax
80100d29:	66 90                	xchg   %ax,%ax
80100d2b:	66 90                	xchg   %ax,%ax
80100d2d:	66 90                	xchg   %ax,%ax
80100d2f:	90                   	nop

80100d30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d30:	55                   	push   %ebp
80100d31:	89 e5                	mov    %esp,%ebp
80100d33:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d36:	68 e9 71 10 80       	push   $0x801071e9
80100d3b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d40:	e8 fb 35 00 00       	call   80104340 <initlock>
}
80100d45:	83 c4 10             	add    $0x10,%esp
80100d48:	c9                   	leave  
80100d49:	c3                   	ret    
80100d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d50 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d54:	bb 14 00 11 80       	mov    $0x80110014,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d59:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d5c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d61:	e8 fa 35 00 00       	call   80104360 <acquire>
80100d66:	83 c4 10             	add    $0x10,%esp
80100d69:	eb 10                	jmp    80100d7b <filealloc+0x2b>
80100d6b:	90                   	nop
80100d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d70:	83 c3 18             	add    $0x18,%ebx
80100d73:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100d79:	74 25                	je     80100da0 <filealloc+0x50>
    if(f->ref == 0){
80100d7b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d7e:	85 c0                	test   %eax,%eax
80100d80:	75 ee                	jne    80100d70 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100d82:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100d85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d8c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d91:	e8 aa 37 00 00       	call   80104540 <release>
      return f;
80100d96:	89 d8                	mov    %ebx,%eax
80100d98:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100d9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d9e:	c9                   	leave  
80100d9f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100da0:	83 ec 0c             	sub    $0xc,%esp
80100da3:	68 e0 ff 10 80       	push   $0x8010ffe0
80100da8:	e8 93 37 00 00       	call   80104540 <release>
  return 0;
80100dad:	83 c4 10             	add    $0x10,%esp
80100db0:	31 c0                	xor    %eax,%eax
}
80100db2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100db5:	c9                   	leave  
80100db6:	c3                   	ret    
80100db7:	89 f6                	mov    %esi,%esi
80100db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100dc0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	53                   	push   %ebx
80100dc4:	83 ec 10             	sub    $0x10,%esp
80100dc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dca:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dcf:	e8 8c 35 00 00       	call   80104360 <acquire>
  if(f->ref < 1)
80100dd4:	8b 43 04             	mov    0x4(%ebx),%eax
80100dd7:	83 c4 10             	add    $0x10,%esp
80100dda:	85 c0                	test   %eax,%eax
80100ddc:	7e 1a                	jle    80100df8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dde:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100de1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100de4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100de7:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dec:	e8 4f 37 00 00       	call   80104540 <release>
  return f;
}
80100df1:	89 d8                	mov    %ebx,%eax
80100df3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100df6:	c9                   	leave  
80100df7:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100df8:	83 ec 0c             	sub    $0xc,%esp
80100dfb:	68 f0 71 10 80       	push   $0x801071f0
80100e00:	e8 6b f5 ff ff       	call   80100370 <panic>
80100e05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e10 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	57                   	push   %edi
80100e14:	56                   	push   %esi
80100e15:	53                   	push   %ebx
80100e16:	83 ec 28             	sub    $0x28,%esp
80100e19:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e1c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e21:	e8 3a 35 00 00       	call   80104360 <acquire>
  if(f->ref < 1)
80100e26:	8b 47 04             	mov    0x4(%edi),%eax
80100e29:	83 c4 10             	add    $0x10,%esp
80100e2c:	85 c0                	test   %eax,%eax
80100e2e:	0f 8e 9b 00 00 00    	jle    80100ecf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e34:	83 e8 01             	sub    $0x1,%eax
80100e37:	85 c0                	test   %eax,%eax
80100e39:	89 47 04             	mov    %eax,0x4(%edi)
80100e3c:	74 1a                	je     80100e58 <fileclose+0x48>
    release(&ftable.lock);
80100e3e:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e48:	5b                   	pop    %ebx
80100e49:	5e                   	pop    %esi
80100e4a:	5f                   	pop    %edi
80100e4b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e4c:	e9 ef 36 00 00       	jmp    80104540 <release>
80100e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e58:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e5c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e5e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e61:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e64:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e6a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e6d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e70:	68 e0 ff 10 80       	push   $0x8010ffe0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e75:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e78:	e8 c3 36 00 00       	call   80104540 <release>

  if(ff.type == FD_PIPE)
80100e7d:	83 c4 10             	add    $0x10,%esp
80100e80:	83 fb 01             	cmp    $0x1,%ebx
80100e83:	74 13                	je     80100e98 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e85:	83 fb 02             	cmp    $0x2,%ebx
80100e88:	74 26                	je     80100eb0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e8d:	5b                   	pop    %ebx
80100e8e:	5e                   	pop    %esi
80100e8f:	5f                   	pop    %edi
80100e90:	5d                   	pop    %ebp
80100e91:	c3                   	ret    
80100e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100e98:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100e9c:	83 ec 08             	sub    $0x8,%esp
80100e9f:	53                   	push   %ebx
80100ea0:	56                   	push   %esi
80100ea1:	e8 5a 25 00 00       	call   80103400 <pipeclose>
80100ea6:	83 c4 10             	add    $0x10,%esp
80100ea9:	eb df                	jmp    80100e8a <fileclose+0x7a>
80100eab:	90                   	nop
80100eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100eb0:	e8 cb 1c 00 00       	call   80102b80 <begin_op>
    iput(ff.ip);
80100eb5:	83 ec 0c             	sub    $0xc,%esp
80100eb8:	ff 75 e0             	pushl  -0x20(%ebp)
80100ebb:	e8 90 08 00 00       	call   80101750 <iput>
    end_op();
80100ec0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ec3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ec6:	5b                   	pop    %ebx
80100ec7:	5e                   	pop    %esi
80100ec8:	5f                   	pop    %edi
80100ec9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eca:	e9 21 1d 00 00       	jmp    80102bf0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100ecf:	83 ec 0c             	sub    $0xc,%esp
80100ed2:	68 f8 71 10 80       	push   $0x801071f8
80100ed7:	e8 94 f4 ff ff       	call   80100370 <panic>
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ee0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	53                   	push   %ebx
80100ee4:	83 ec 04             	sub    $0x4,%esp
80100ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100eea:	83 3b 02             	cmpl   $0x2,(%ebx)
80100eed:	75 31                	jne    80100f20 <filestat+0x40>
    ilock(f->ip);
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	ff 73 10             	pushl  0x10(%ebx)
80100ef5:	e8 26 07 00 00       	call   80101620 <ilock>
    stati(f->ip, st);
80100efa:	58                   	pop    %eax
80100efb:	5a                   	pop    %edx
80100efc:	ff 75 0c             	pushl  0xc(%ebp)
80100eff:	ff 73 10             	pushl  0x10(%ebx)
80100f02:	e8 a9 09 00 00       	call   801018b0 <stati>
    iunlock(f->ip);
80100f07:	59                   	pop    %ecx
80100f08:	ff 73 10             	pushl  0x10(%ebx)
80100f0b:	e8 f0 07 00 00       	call   80101700 <iunlock>
    return 0;
80100f10:	83 c4 10             	add    $0x10,%esp
80100f13:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f18:	c9                   	leave  
80100f19:	c3                   	ret    
80100f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f28:	c9                   	leave  
80100f29:	c3                   	ret    
80100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f30 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	57                   	push   %edi
80100f34:	56                   	push   %esi
80100f35:	53                   	push   %ebx
80100f36:	83 ec 0c             	sub    $0xc,%esp
80100f39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f3f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f42:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f46:	74 60                	je     80100fa8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f48:	8b 03                	mov    (%ebx),%eax
80100f4a:	83 f8 01             	cmp    $0x1,%eax
80100f4d:	74 41                	je     80100f90 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f4f:	83 f8 02             	cmp    $0x2,%eax
80100f52:	75 5b                	jne    80100faf <fileread+0x7f>
    ilock(f->ip);
80100f54:	83 ec 0c             	sub    $0xc,%esp
80100f57:	ff 73 10             	pushl  0x10(%ebx)
80100f5a:	e8 c1 06 00 00       	call   80101620 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f5f:	57                   	push   %edi
80100f60:	ff 73 14             	pushl  0x14(%ebx)
80100f63:	56                   	push   %esi
80100f64:	ff 73 10             	pushl  0x10(%ebx)
80100f67:	e8 74 09 00 00       	call   801018e0 <readi>
80100f6c:	83 c4 20             	add    $0x20,%esp
80100f6f:	85 c0                	test   %eax,%eax
80100f71:	89 c6                	mov    %eax,%esi
80100f73:	7e 03                	jle    80100f78 <fileread+0x48>
      f->off += r;
80100f75:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f78:	83 ec 0c             	sub    $0xc,%esp
80100f7b:	ff 73 10             	pushl  0x10(%ebx)
80100f7e:	e8 7d 07 00 00       	call   80101700 <iunlock>
    return r;
80100f83:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f86:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8b:	5b                   	pop    %ebx
80100f8c:	5e                   	pop    %esi
80100f8d:	5f                   	pop    %edi
80100f8e:	5d                   	pop    %ebp
80100f8f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f90:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f93:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f99:	5b                   	pop    %ebx
80100f9a:	5e                   	pop    %esi
80100f9b:	5f                   	pop    %edi
80100f9c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f9d:	e9 2e 26 00 00       	jmp    801035d0 <piperead>
80100fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fad:	eb d9                	jmp    80100f88 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100faf:	83 ec 0c             	sub    $0xc,%esp
80100fb2:	68 02 72 10 80       	push   $0x80107202
80100fb7:	e8 b4 f3 ff ff       	call   80100370 <panic>
80100fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fc0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fc0:	55                   	push   %ebp
80100fc1:	89 e5                	mov    %esp,%ebp
80100fc3:	57                   	push   %edi
80100fc4:	56                   	push   %esi
80100fc5:	53                   	push   %ebx
80100fc6:	83 ec 1c             	sub    $0x1c,%esp
80100fc9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fcf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fd3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100fd6:	8b 45 10             	mov    0x10(%ebp),%eax
80100fd9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100fdc:	0f 84 aa 00 00 00    	je     8010108c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80100fe2:	8b 06                	mov    (%esi),%eax
80100fe4:	83 f8 01             	cmp    $0x1,%eax
80100fe7:	0f 84 c2 00 00 00    	je     801010af <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fed:	83 f8 02             	cmp    $0x2,%eax
80100ff0:	0f 85 d8 00 00 00    	jne    801010ce <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100ff6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ff9:	31 ff                	xor    %edi,%edi
80100ffb:	85 c0                	test   %eax,%eax
80100ffd:	7f 34                	jg     80101033 <filewrite+0x73>
80100fff:	e9 9c 00 00 00       	jmp    801010a0 <filewrite+0xe0>
80101004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101008:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010100b:	83 ec 0c             	sub    $0xc,%esp
8010100e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101011:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101014:	e8 e7 06 00 00       	call   80101700 <iunlock>
      end_op();
80101019:	e8 d2 1b 00 00       	call   80102bf0 <end_op>
8010101e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101021:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101024:	39 d8                	cmp    %ebx,%eax
80101026:	0f 85 95 00 00 00    	jne    801010c1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010102c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010102e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101031:	7e 6d                	jle    801010a0 <filewrite+0xe0>
      int n1 = n - i;
80101033:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101036:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010103b:	29 fb                	sub    %edi,%ebx
8010103d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101043:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101046:	e8 35 1b 00 00       	call   80102b80 <begin_op>
      ilock(f->ip);
8010104b:	83 ec 0c             	sub    $0xc,%esp
8010104e:	ff 76 10             	pushl  0x10(%esi)
80101051:	e8 ca 05 00 00       	call   80101620 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101056:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101059:	53                   	push   %ebx
8010105a:	ff 76 14             	pushl  0x14(%esi)
8010105d:	01 f8                	add    %edi,%eax
8010105f:	50                   	push   %eax
80101060:	ff 76 10             	pushl  0x10(%esi)
80101063:	e8 78 09 00 00       	call   801019e0 <writei>
80101068:	83 c4 20             	add    $0x20,%esp
8010106b:	85 c0                	test   %eax,%eax
8010106d:	7f 99                	jg     80101008 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010106f:	83 ec 0c             	sub    $0xc,%esp
80101072:	ff 76 10             	pushl  0x10(%esi)
80101075:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101078:	e8 83 06 00 00       	call   80101700 <iunlock>
      end_op();
8010107d:	e8 6e 1b 00 00       	call   80102bf0 <end_op>

      if(r < 0)
80101082:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101085:	83 c4 10             	add    $0x10,%esp
80101088:	85 c0                	test   %eax,%eax
8010108a:	74 98                	je     80101024 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010108c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010108f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101094:	5b                   	pop    %ebx
80101095:	5e                   	pop    %esi
80101096:	5f                   	pop    %edi
80101097:	5d                   	pop    %ebp
80101098:	c3                   	ret    
80101099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010a0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010a3:	75 e7                	jne    8010108c <filewrite+0xcc>
  }
  panic("filewrite");
}
801010a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a8:	89 f8                	mov    %edi,%eax
801010aa:	5b                   	pop    %ebx
801010ab:	5e                   	pop    %esi
801010ac:	5f                   	pop    %edi
801010ad:	5d                   	pop    %ebp
801010ae:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010af:	8b 46 0c             	mov    0xc(%esi),%eax
801010b2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010b8:	5b                   	pop    %ebx
801010b9:	5e                   	pop    %esi
801010ba:	5f                   	pop    %edi
801010bb:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010bc:	e9 df 23 00 00       	jmp    801034a0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010c1:	83 ec 0c             	sub    $0xc,%esp
801010c4:	68 0b 72 10 80       	push   $0x8010720b
801010c9:	e8 a2 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ce:	83 ec 0c             	sub    $0xc,%esp
801010d1:	68 11 72 10 80       	push   $0x80107211
801010d6:	e8 95 f2 ff ff       	call   80100370 <panic>
801010db:	66 90                	xchg   %ax,%ax
801010dd:	66 90                	xchg   %ax,%ax
801010df:	90                   	nop

801010e0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	57                   	push   %edi
801010e4:	56                   	push   %esi
801010e5:	53                   	push   %ebx
801010e6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010e9:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010ef:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010f2:	85 c9                	test   %ecx,%ecx
801010f4:	0f 84 85 00 00 00    	je     8010117f <balloc+0x9f>
801010fa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101101:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101104:	83 ec 08             	sub    $0x8,%esp
80101107:	89 f0                	mov    %esi,%eax
80101109:	c1 f8 0c             	sar    $0xc,%eax
8010110c:	03 05 f8 09 11 80    	add    0x801109f8,%eax
80101112:	50                   	push   %eax
80101113:	ff 75 d8             	pushl  -0x28(%ebp)
80101116:	e8 b5 ef ff ff       	call   801000d0 <bread>
8010111b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010111e:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101123:	83 c4 10             	add    $0x10,%esp
80101126:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101129:	31 c0                	xor    %eax,%eax
8010112b:	eb 2d                	jmp    8010115a <balloc+0x7a>
8010112d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101130:	89 c1                	mov    %eax,%ecx
80101132:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101137:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010113a:	83 e1 07             	and    $0x7,%ecx
8010113d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010113f:	89 c1                	mov    %eax,%ecx
80101141:	c1 f9 03             	sar    $0x3,%ecx
80101144:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101149:	85 d7                	test   %edx,%edi
8010114b:	74 43                	je     80101190 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114d:	83 c0 01             	add    $0x1,%eax
80101150:	83 c6 01             	add    $0x1,%esi
80101153:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101158:	74 05                	je     8010115f <balloc+0x7f>
8010115a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010115d:	72 d1                	jb     80101130 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010115f:	83 ec 0c             	sub    $0xc,%esp
80101162:	ff 75 e4             	pushl  -0x1c(%ebp)
80101165:	e8 76 f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010116a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101171:	83 c4 10             	add    $0x10,%esp
80101174:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101177:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010117d:	77 82                	ja     80101101 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	68 1b 72 10 80       	push   $0x8010721b
80101187:	e8 e4 f1 ff ff       	call   80100370 <panic>
8010118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101190:	09 fa                	or     %edi,%edx
80101192:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101195:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101198:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010119c:	57                   	push   %edi
8010119d:	e8 be 1b 00 00       	call   80102d60 <log_write>
        brelse(bp);
801011a2:	89 3c 24             	mov    %edi,(%esp)
801011a5:	e8 36 f0 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011aa:	58                   	pop    %eax
801011ab:	5a                   	pop    %edx
801011ac:	56                   	push   %esi
801011ad:	ff 75 d8             	pushl  -0x28(%ebp)
801011b0:	e8 1b ef ff ff       	call   801000d0 <bread>
801011b5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ba:	83 c4 0c             	add    $0xc,%esp
801011bd:	68 00 02 00 00       	push   $0x200
801011c2:	6a 00                	push   $0x0
801011c4:	50                   	push   %eax
801011c5:	e8 c6 33 00 00       	call   80104590 <memset>
  log_write(bp);
801011ca:	89 1c 24             	mov    %ebx,(%esp)
801011cd:	e8 8e 1b 00 00       	call   80102d60 <log_write>
  brelse(bp);
801011d2:	89 1c 24             	mov    %ebx,(%esp)
801011d5:	e8 06 f0 ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801011da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011dd:	89 f0                	mov    %esi,%eax
801011df:	5b                   	pop    %ebx
801011e0:	5e                   	pop    %esi
801011e1:	5f                   	pop    %edi
801011e2:	5d                   	pop    %ebp
801011e3:	c3                   	ret    
801011e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801011ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801011f0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011f0:	55                   	push   %ebp
801011f1:	89 e5                	mov    %esp,%ebp
801011f3:	57                   	push   %edi
801011f4:	56                   	push   %esi
801011f5:	53                   	push   %ebx
801011f6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801011f8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011fa:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011ff:	83 ec 28             	sub    $0x28,%esp
80101202:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101205:	68 00 0a 11 80       	push   $0x80110a00
8010120a:	e8 51 31 00 00       	call   80104360 <acquire>
8010120f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101212:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101215:	eb 1b                	jmp    80101232 <iget+0x42>
80101217:	89 f6                	mov    %esi,%esi
80101219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101220:	85 f6                	test   %esi,%esi
80101222:	74 44                	je     80101268 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101224:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010122a:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101230:	74 4e                	je     80101280 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101232:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101235:	85 c9                	test   %ecx,%ecx
80101237:	7e e7                	jle    80101220 <iget+0x30>
80101239:	39 3b                	cmp    %edi,(%ebx)
8010123b:	75 e3                	jne    80101220 <iget+0x30>
8010123d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101240:	75 de                	jne    80101220 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101242:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101245:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101248:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010124a:	68 00 0a 11 80       	push   $0x80110a00

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010124f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101252:	e8 e9 32 00 00       	call   80104540 <release>
      return ip;
80101257:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
8010125a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010125d:	89 f0                	mov    %esi,%eax
8010125f:	5b                   	pop    %ebx
80101260:	5e                   	pop    %esi
80101261:	5f                   	pop    %edi
80101262:	5d                   	pop    %ebp
80101263:	c3                   	ret    
80101264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101268:	85 c9                	test   %ecx,%ecx
8010126a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010126d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101273:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101279:	75 b7                	jne    80101232 <iget+0x42>
8010127b:	90                   	nop
8010127c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101280:	85 f6                	test   %esi,%esi
80101282:	74 2d                	je     801012b1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
80101284:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101287:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101289:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010128c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101293:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010129a:	68 00 0a 11 80       	push   $0x80110a00
8010129f:	e8 9c 32 00 00       	call   80104540 <release>

  return ip;
801012a4:	83 c4 10             	add    $0x10,%esp
}
801012a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012aa:	89 f0                	mov    %esi,%eax
801012ac:	5b                   	pop    %ebx
801012ad:	5e                   	pop    %esi
801012ae:	5f                   	pop    %edi
801012af:	5d                   	pop    %ebp
801012b0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012b1:	83 ec 0c             	sub    $0xc,%esp
801012b4:	68 31 72 10 80       	push   $0x80107231
801012b9:	e8 b2 f0 ff ff       	call   80100370 <panic>
801012be:	66 90                	xchg   %ax,%ax

801012c0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012c0:	55                   	push   %ebp
801012c1:	89 e5                	mov    %esp,%ebp
801012c3:	57                   	push   %edi
801012c4:	56                   	push   %esi
801012c5:	53                   	push   %ebx
801012c6:	89 c6                	mov    %eax,%esi
801012c8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012cb:	83 fa 0b             	cmp    $0xb,%edx
801012ce:	77 18                	ja     801012e8 <bmap+0x28>
801012d0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801012d3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801012d6:	85 c0                	test   %eax,%eax
801012d8:	74 76                	je     80101350 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012dd:	5b                   	pop    %ebx
801012de:	5e                   	pop    %esi
801012df:	5f                   	pop    %edi
801012e0:	5d                   	pop    %ebp
801012e1:	c3                   	ret    
801012e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801012e8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801012eb:	83 fb 7f             	cmp    $0x7f,%ebx
801012ee:	0f 87 83 00 00 00    	ja     80101377 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801012f4:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801012fa:	85 c0                	test   %eax,%eax
801012fc:	74 6a                	je     80101368 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801012fe:	83 ec 08             	sub    $0x8,%esp
80101301:	50                   	push   %eax
80101302:	ff 36                	pushl  (%esi)
80101304:	e8 c7 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101309:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010130d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101310:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101312:	8b 1a                	mov    (%edx),%ebx
80101314:	85 db                	test   %ebx,%ebx
80101316:	75 1d                	jne    80101335 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101318:	8b 06                	mov    (%esi),%eax
8010131a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010131d:	e8 be fd ff ff       	call   801010e0 <balloc>
80101322:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101325:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101328:	89 c3                	mov    %eax,%ebx
8010132a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010132c:	57                   	push   %edi
8010132d:	e8 2e 1a 00 00       	call   80102d60 <log_write>
80101332:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101335:	83 ec 0c             	sub    $0xc,%esp
80101338:	57                   	push   %edi
80101339:	e8 a2 ee ff ff       	call   801001e0 <brelse>
8010133e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101341:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101344:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101346:	5b                   	pop    %ebx
80101347:	5e                   	pop    %esi
80101348:	5f                   	pop    %edi
80101349:	5d                   	pop    %ebp
8010134a:	c3                   	ret    
8010134b:	90                   	nop
8010134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101350:	8b 06                	mov    (%esi),%eax
80101352:	e8 89 fd ff ff       	call   801010e0 <balloc>
80101357:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010135a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010135d:	5b                   	pop    %ebx
8010135e:	5e                   	pop    %esi
8010135f:	5f                   	pop    %edi
80101360:	5d                   	pop    %ebp
80101361:	c3                   	ret    
80101362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101368:	8b 06                	mov    (%esi),%eax
8010136a:	e8 71 fd ff ff       	call   801010e0 <balloc>
8010136f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101375:	eb 87                	jmp    801012fe <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101377:	83 ec 0c             	sub    $0xc,%esp
8010137a:	68 41 72 10 80       	push   $0x80107241
8010137f:	e8 ec ef ff ff       	call   80100370 <panic>
80101384:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010138a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101390 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	56                   	push   %esi
80101394:	53                   	push   %ebx
80101395:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101398:	83 ec 08             	sub    $0x8,%esp
8010139b:	6a 01                	push   $0x1
8010139d:	ff 75 08             	pushl  0x8(%ebp)
801013a0:	e8 2b ed ff ff       	call   801000d0 <bread>
801013a5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013aa:	83 c4 0c             	add    $0xc,%esp
801013ad:	6a 1c                	push   $0x1c
801013af:	50                   	push   %eax
801013b0:	56                   	push   %esi
801013b1:	e8 8a 32 00 00       	call   80104640 <memmove>
  brelse(bp);
801013b6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013b9:	83 c4 10             	add    $0x10,%esp
}
801013bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013bf:	5b                   	pop    %ebx
801013c0:	5e                   	pop    %esi
801013c1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013c2:	e9 19 ee ff ff       	jmp    801001e0 <brelse>
801013c7:	89 f6                	mov    %esi,%esi
801013c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013d0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	56                   	push   %esi
801013d4:	53                   	push   %ebx
801013d5:	89 d3                	mov    %edx,%ebx
801013d7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013d9:	83 ec 08             	sub    $0x8,%esp
801013dc:	68 e0 09 11 80       	push   $0x801109e0
801013e1:	50                   	push   %eax
801013e2:	e8 a9 ff ff ff       	call   80101390 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801013e7:	58                   	pop    %eax
801013e8:	5a                   	pop    %edx
801013e9:	89 da                	mov    %ebx,%edx
801013eb:	c1 ea 0c             	shr    $0xc,%edx
801013ee:	03 15 f8 09 11 80    	add    0x801109f8,%edx
801013f4:	52                   	push   %edx
801013f5:	56                   	push   %esi
801013f6:	e8 d5 ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801013fb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801013fd:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101403:	ba 01 00 00 00       	mov    $0x1,%edx
80101408:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010140b:	c1 fb 03             	sar    $0x3,%ebx
8010140e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101411:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101413:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101418:	85 d1                	test   %edx,%ecx
8010141a:	74 27                	je     80101443 <bfree+0x73>
8010141c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010141e:	f7 d2                	not    %edx
80101420:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101422:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101425:	21 d0                	and    %edx,%eax
80101427:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010142b:	56                   	push   %esi
8010142c:	e8 2f 19 00 00       	call   80102d60 <log_write>
  brelse(bp);
80101431:	89 34 24             	mov    %esi,(%esp)
80101434:	e8 a7 ed ff ff       	call   801001e0 <brelse>
}
80101439:	83 c4 10             	add    $0x10,%esp
8010143c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010143f:	5b                   	pop    %ebx
80101440:	5e                   	pop    %esi
80101441:	5d                   	pop    %ebp
80101442:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101443:	83 ec 0c             	sub    $0xc,%esp
80101446:	68 54 72 10 80       	push   $0x80107254
8010144b:	e8 20 ef ff ff       	call   80100370 <panic>

80101450 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	53                   	push   %ebx
80101454:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101459:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010145c:	68 67 72 10 80       	push   $0x80107267
80101461:	68 00 0a 11 80       	push   $0x80110a00
80101466:	e8 d5 2e 00 00       	call   80104340 <initlock>
8010146b:	83 c4 10             	add    $0x10,%esp
8010146e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101470:	83 ec 08             	sub    $0x8,%esp
80101473:	68 6e 72 10 80       	push   $0x8010726e
80101478:	53                   	push   %ebx
80101479:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010147f:	e8 ac 2d 00 00       	call   80104230 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101484:	83 c4 10             	add    $0x10,%esp
80101487:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
8010148d:	75 e1                	jne    80101470 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }
  
  readsb(dev, &sb);
8010148f:	83 ec 08             	sub    $0x8,%esp
80101492:	68 e0 09 11 80       	push   $0x801109e0
80101497:	ff 75 08             	pushl  0x8(%ebp)
8010149a:	e8 f1 fe ff ff       	call   80101390 <readsb>
}
8010149f:	83 c4 10             	add    $0x10,%esp
801014a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014a5:	c9                   	leave  
801014a6:	c3                   	ret    
801014a7:	89 f6                	mov    %esi,%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801014b0:	55                   	push   %ebp
801014b1:	89 e5                	mov    %esp,%ebp
801014b3:	57                   	push   %edi
801014b4:	56                   	push   %esi
801014b5:	53                   	push   %ebx
801014b6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014b9:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801014c3:	8b 75 08             	mov    0x8(%ebp),%esi
801014c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014c9:	0f 86 91 00 00 00    	jbe    80101560 <ialloc+0xb0>
801014cf:	bb 01 00 00 00       	mov    $0x1,%ebx
801014d4:	eb 21                	jmp    801014f7 <ialloc+0x47>
801014d6:	8d 76 00             	lea    0x0(%esi),%esi
801014d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801014e0:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014e3:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801014e6:	57                   	push   %edi
801014e7:	e8 f4 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014ec:	83 c4 10             	add    $0x10,%esp
801014ef:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
801014f5:	76 69                	jbe    80101560 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801014f7:	89 d8                	mov    %ebx,%eax
801014f9:	83 ec 08             	sub    $0x8,%esp
801014fc:	c1 e8 03             	shr    $0x3,%eax
801014ff:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101505:	50                   	push   %eax
80101506:	56                   	push   %esi
80101507:	e8 c4 eb ff ff       	call   801000d0 <bread>
8010150c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010150e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101510:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101513:	83 e0 07             	and    $0x7,%eax
80101516:	c1 e0 06             	shl    $0x6,%eax
80101519:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010151d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101521:	75 bd                	jne    801014e0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101523:	83 ec 04             	sub    $0x4,%esp
80101526:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101529:	6a 40                	push   $0x40
8010152b:	6a 00                	push   $0x0
8010152d:	51                   	push   %ecx
8010152e:	e8 5d 30 00 00       	call   80104590 <memset>
      dip->type = type;
80101533:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101537:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010153a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010153d:	89 3c 24             	mov    %edi,(%esp)
80101540:	e8 1b 18 00 00       	call   80102d60 <log_write>
      brelse(bp);
80101545:	89 3c 24             	mov    %edi,(%esp)
80101548:	e8 93 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010154d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101550:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101553:	89 da                	mov    %ebx,%edx
80101555:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101557:	5b                   	pop    %ebx
80101558:	5e                   	pop    %esi
80101559:	5f                   	pop    %edi
8010155a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010155b:	e9 90 fc ff ff       	jmp    801011f0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101560:	83 ec 0c             	sub    $0xc,%esp
80101563:	68 74 72 10 80       	push   $0x80107274
80101568:	e8 03 ee ff ff       	call   80100370 <panic>
8010156d:	8d 76 00             	lea    0x0(%esi),%esi

80101570 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	56                   	push   %esi
80101574:	53                   	push   %ebx
80101575:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101578:	83 ec 08             	sub    $0x8,%esp
8010157b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010157e:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101581:	c1 e8 03             	shr    $0x3,%eax
80101584:	03 05 f4 09 11 80    	add    0x801109f4,%eax
8010158a:	50                   	push   %eax
8010158b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010158e:	e8 3d eb ff ff       	call   801000d0 <bread>
80101593:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101595:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101598:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010159c:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010159f:	83 e0 07             	and    $0x7,%eax
801015a2:	c1 e0 06             	shl    $0x6,%eax
801015a5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015a9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015ac:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015b0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801015b3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801015b7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801015bb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801015bf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801015c3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801015c7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801015ca:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015cd:	6a 34                	push   $0x34
801015cf:	53                   	push   %ebx
801015d0:	50                   	push   %eax
801015d1:	e8 6a 30 00 00       	call   80104640 <memmove>
  log_write(bp);
801015d6:	89 34 24             	mov    %esi,(%esp)
801015d9:	e8 82 17 00 00       	call   80102d60 <log_write>
  brelse(bp);
801015de:	89 75 08             	mov    %esi,0x8(%ebp)
801015e1:	83 c4 10             	add    $0x10,%esp
}
801015e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015e7:	5b                   	pop    %ebx
801015e8:	5e                   	pop    %esi
801015e9:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801015ea:	e9 f1 eb ff ff       	jmp    801001e0 <brelse>
801015ef:	90                   	nop

801015f0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	53                   	push   %ebx
801015f4:	83 ec 10             	sub    $0x10,%esp
801015f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801015fa:	68 00 0a 11 80       	push   $0x80110a00
801015ff:	e8 5c 2d 00 00       	call   80104360 <acquire>
  ip->ref++;
80101604:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101608:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010160f:	e8 2c 2f 00 00       	call   80104540 <release>
  return ip;
}
80101614:	89 d8                	mov    %ebx,%eax
80101616:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101619:	c9                   	leave  
8010161a:	c3                   	ret    
8010161b:	90                   	nop
8010161c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101620 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	56                   	push   %esi
80101624:	53                   	push   %ebx
80101625:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101628:	85 db                	test   %ebx,%ebx
8010162a:	0f 84 b4 00 00 00    	je     801016e4 <ilock+0xc4>
80101630:	8b 43 08             	mov    0x8(%ebx),%eax
80101633:	85 c0                	test   %eax,%eax
80101635:	0f 8e a9 00 00 00    	jle    801016e4 <ilock+0xc4>
    panic("ilock");

  acquiresleep(&ip->lock);
8010163b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010163e:	83 ec 0c             	sub    $0xc,%esp
80101641:	50                   	push   %eax
80101642:	e8 29 2c 00 00       	call   80104270 <acquiresleep>

  if(!(ip->flags & I_VALID)){
80101647:	83 c4 10             	add    $0x10,%esp
8010164a:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
8010164e:	74 10                	je     80101660 <ilock+0x40>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101650:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101653:	5b                   	pop    %ebx
80101654:	5e                   	pop    %esi
80101655:	5d                   	pop    %ebp
80101656:	c3                   	ret    
80101657:	89 f6                	mov    %esi,%esi
80101659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101660:	8b 43 04             	mov    0x4(%ebx),%eax
80101663:	83 ec 08             	sub    $0x8,%esp
80101666:	c1 e8 03             	shr    $0x3,%eax
80101669:	03 05 f4 09 11 80    	add    0x801109f4,%eax
8010166f:	50                   	push   %eax
80101670:	ff 33                	pushl  (%ebx)
80101672:	e8 59 ea ff ff       	call   801000d0 <bread>
80101677:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101679:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010167c:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010167f:	83 e0 07             	and    $0x7,%eax
80101682:	c1 e0 06             	shl    $0x6,%eax
80101685:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101689:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010168c:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
8010168f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101693:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101697:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010169b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010169f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016a3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016a7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016ab:	8b 50 fc             	mov    -0x4(%eax),%edx
801016ae:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016b1:	6a 34                	push   $0x34
801016b3:	50                   	push   %eax
801016b4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801016b7:	50                   	push   %eax
801016b8:	e8 83 2f 00 00       	call   80104640 <memmove>
    brelse(bp);
801016bd:	89 34 24             	mov    %esi,(%esp)
801016c0:	e8 1b eb ff ff       	call   801001e0 <brelse>
    ip->flags |= I_VALID;
801016c5:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
801016c9:	83 c4 10             	add    $0x10,%esp
801016cc:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
801016d1:	0f 85 79 ff ff ff    	jne    80101650 <ilock+0x30>
      panic("ilock: no type");
801016d7:	83 ec 0c             	sub    $0xc,%esp
801016da:	68 8c 72 10 80       	push   $0x8010728c
801016df:	e8 8c ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801016e4:	83 ec 0c             	sub    $0xc,%esp
801016e7:	68 86 72 10 80       	push   $0x80107286
801016ec:	e8 7f ec ff ff       	call   80100370 <panic>
801016f1:	eb 0d                	jmp    80101700 <iunlock>
801016f3:	90                   	nop
801016f4:	90                   	nop
801016f5:	90                   	nop
801016f6:	90                   	nop
801016f7:	90                   	nop
801016f8:	90                   	nop
801016f9:	90                   	nop
801016fa:	90                   	nop
801016fb:	90                   	nop
801016fc:	90                   	nop
801016fd:	90                   	nop
801016fe:	90                   	nop
801016ff:	90                   	nop

80101700 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	56                   	push   %esi
80101704:	53                   	push   %ebx
80101705:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101708:	85 db                	test   %ebx,%ebx
8010170a:	74 28                	je     80101734 <iunlock+0x34>
8010170c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010170f:	83 ec 0c             	sub    $0xc,%esp
80101712:	56                   	push   %esi
80101713:	e8 f8 2b 00 00       	call   80104310 <holdingsleep>
80101718:	83 c4 10             	add    $0x10,%esp
8010171b:	85 c0                	test   %eax,%eax
8010171d:	74 15                	je     80101734 <iunlock+0x34>
8010171f:	8b 43 08             	mov    0x8(%ebx),%eax
80101722:	85 c0                	test   %eax,%eax
80101724:	7e 0e                	jle    80101734 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101726:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101729:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010172c:	5b                   	pop    %ebx
8010172d:	5e                   	pop    %esi
8010172e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010172f:	e9 9c 2b 00 00       	jmp    801042d0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101734:	83 ec 0c             	sub    $0xc,%esp
80101737:	68 9b 72 10 80       	push   $0x8010729b
8010173c:	e8 2f ec ff ff       	call   80100370 <panic>
80101741:	eb 0d                	jmp    80101750 <iput>
80101743:	90                   	nop
80101744:	90                   	nop
80101745:	90                   	nop
80101746:	90                   	nop
80101747:	90                   	nop
80101748:	90                   	nop
80101749:	90                   	nop
8010174a:	90                   	nop
8010174b:	90                   	nop
8010174c:	90                   	nop
8010174d:	90                   	nop
8010174e:	90                   	nop
8010174f:	90                   	nop

80101750 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	57                   	push   %edi
80101754:	56                   	push   %esi
80101755:	53                   	push   %ebx
80101756:	83 ec 28             	sub    $0x28,%esp
80101759:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
8010175c:	68 00 0a 11 80       	push   $0x80110a00
80101761:	e8 fa 2b 00 00       	call   80104360 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101766:	8b 46 08             	mov    0x8(%esi),%eax
80101769:	83 c4 10             	add    $0x10,%esp
8010176c:	83 f8 01             	cmp    $0x1,%eax
8010176f:	74 1f                	je     80101790 <iput+0x40>
    ip->type = 0;
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
80101771:	83 e8 01             	sub    $0x1,%eax
80101774:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
80101777:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
8010177e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101781:	5b                   	pop    %ebx
80101782:	5e                   	pop    %esi
80101783:	5f                   	pop    %edi
80101784:	5d                   	pop    %ebp
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
  release(&icache.lock);
80101785:	e9 b6 2d 00 00       	jmp    80104540 <release>
8010178a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// case it has to free the inode.
void
iput(struct inode *ip)
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101790:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
80101794:	74 db                	je     80101771 <iput+0x21>
80101796:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
8010179b:	75 d4                	jne    80101771 <iput+0x21>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
8010179d:	83 ec 0c             	sub    $0xc,%esp
801017a0:	8d 5e 5c             	lea    0x5c(%esi),%ebx
801017a3:	8d be 8c 00 00 00    	lea    0x8c(%esi),%edi
801017a9:	68 00 0a 11 80       	push   $0x80110a00
801017ae:	e8 8d 2d 00 00       	call   80104540 <release>
801017b3:	83 c4 10             	add    $0x10,%esp
801017b6:	eb 0f                	jmp    801017c7 <iput+0x77>
801017b8:	90                   	nop
801017b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017c0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801017c3:	39 fb                	cmp    %edi,%ebx
801017c5:	74 19                	je     801017e0 <iput+0x90>
    if(ip->addrs[i]){
801017c7:	8b 13                	mov    (%ebx),%edx
801017c9:	85 d2                	test   %edx,%edx
801017cb:	74 f3                	je     801017c0 <iput+0x70>
      bfree(ip->dev, ip->addrs[i]);
801017cd:	8b 06                	mov    (%esi),%eax
801017cf:	e8 fc fb ff ff       	call   801013d0 <bfree>
      ip->addrs[i] = 0;
801017d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801017da:	eb e4                	jmp    801017c0 <iput+0x70>
801017dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801017e0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801017e6:	85 c0                	test   %eax,%eax
801017e8:	75 46                	jne    80101830 <iput+0xe0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801017ea:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801017ed:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801017f4:	56                   	push   %esi
801017f5:	e8 76 fd ff ff       	call   80101570 <iupdate>
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
801017fa:	31 c0                	xor    %eax,%eax
801017fc:	66 89 46 50          	mov    %ax,0x50(%esi)
    iupdate(ip);
80101800:	89 34 24             	mov    %esi,(%esp)
80101803:	e8 68 fd ff ff       	call   80101570 <iupdate>
    acquire(&icache.lock);
80101808:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010180f:	e8 4c 2b 00 00       	call   80104360 <acquire>
    ip->flags = 0;
80101814:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
8010181b:	8b 46 08             	mov    0x8(%esi),%eax
8010181e:	83 c4 10             	add    $0x10,%esp
80101821:	e9 4b ff ff ff       	jmp    80101771 <iput+0x21>
80101826:	8d 76 00             	lea    0x0(%esi),%esi
80101829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101830:	83 ec 08             	sub    $0x8,%esp
80101833:	50                   	push   %eax
80101834:	ff 36                	pushl  (%esi)
80101836:	e8 95 e8 ff ff       	call   801000d0 <bread>
8010183b:	83 c4 10             	add    $0x10,%esp
8010183e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101841:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101844:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x107>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101853:	39 df                	cmp    %ebx,%edi
80101855:	74 0f                	je     80101866 <iput+0x116>
      if(a[j])
80101857:	8b 13                	mov    (%ebx),%edx
80101859:	85 d2                	test   %edx,%edx
8010185b:	74 f3                	je     80101850 <iput+0x100>
        bfree(ip->dev, a[j]);
8010185d:	8b 06                	mov    (%esi),%eax
8010185f:	e8 6c fb ff ff       	call   801013d0 <bfree>
80101864:	eb ea                	jmp    80101850 <iput+0x100>
    }
    brelse(bp);
80101866:	83 ec 0c             	sub    $0xc,%esp
80101869:	ff 75 e4             	pushl  -0x1c(%ebp)
8010186c:	e8 6f e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101871:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101877:	8b 06                	mov    (%esi),%eax
80101879:	e8 52 fb ff ff       	call   801013d0 <bfree>
    ip->addrs[NDIRECT] = 0;
8010187e:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101885:	00 00 00 
80101888:	83 c4 10             	add    $0x10,%esp
8010188b:	e9 5a ff ff ff       	jmp    801017ea <iput+0x9a>

80101890 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	53                   	push   %ebx
80101894:	83 ec 10             	sub    $0x10,%esp
80101897:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010189a:	53                   	push   %ebx
8010189b:	e8 60 fe ff ff       	call   80101700 <iunlock>
  iput(ip);
801018a0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801018a3:	83 c4 10             	add    $0x10,%esp
}
801018a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018a9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801018aa:	e9 a1 fe ff ff       	jmp    80101750 <iput>
801018af:	90                   	nop

801018b0 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
801018b0:	55                   	push   %ebp
801018b1:	89 e5                	mov    %esp,%ebp
801018b3:	8b 55 08             	mov    0x8(%ebp),%edx
801018b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801018b9:	8b 0a                	mov    (%edx),%ecx
801018bb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801018be:	8b 4a 04             	mov    0x4(%edx),%ecx
801018c1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801018c4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801018c8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801018cb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801018cf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801018d3:	8b 52 58             	mov    0x58(%edx),%edx
801018d6:	89 50 10             	mov    %edx,0x10(%eax)
}
801018d9:	5d                   	pop    %ebp
801018da:	c3                   	ret    
801018db:	90                   	nop
801018dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018e0 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	57                   	push   %edi
801018e4:	56                   	push   %esi
801018e5:	53                   	push   %ebx
801018e6:	83 ec 1c             	sub    $0x1c,%esp
801018e9:	8b 45 08             	mov    0x8(%ebp),%eax
801018ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
801018ef:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801018f2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801018f7:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018fa:	8b 7d 14             	mov    0x14(%ebp),%edi
801018fd:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101900:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101903:	0f 84 a7 00 00 00    	je     801019b0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101909:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010190c:	8b 40 58             	mov    0x58(%eax),%eax
8010190f:	39 f0                	cmp    %esi,%eax
80101911:	0f 82 c1 00 00 00    	jb     801019d8 <readi+0xf8>
80101917:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010191a:	89 fa                	mov    %edi,%edx
8010191c:	01 f2                	add    %esi,%edx
8010191e:	0f 82 b4 00 00 00    	jb     801019d8 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101924:	89 c1                	mov    %eax,%ecx
80101926:	29 f1                	sub    %esi,%ecx
80101928:	39 d0                	cmp    %edx,%eax
8010192a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010192d:	31 ff                	xor    %edi,%edi
8010192f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101931:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101934:	74 6d                	je     801019a3 <readi+0xc3>
80101936:	8d 76 00             	lea    0x0(%esi),%esi
80101939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101940:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101943:	89 f2                	mov    %esi,%edx
80101945:	c1 ea 09             	shr    $0x9,%edx
80101948:	89 d8                	mov    %ebx,%eax
8010194a:	e8 71 f9 ff ff       	call   801012c0 <bmap>
8010194f:	83 ec 08             	sub    $0x8,%esp
80101952:	50                   	push   %eax
80101953:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101955:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010195a:	e8 71 e7 ff ff       	call   801000d0 <bread>
8010195f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101961:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101964:	89 f1                	mov    %esi,%ecx
80101966:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
8010196c:	83 c4 0c             	add    $0xc,%esp
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
8010196f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101972:	29 cb                	sub    %ecx,%ebx
80101974:	29 f8                	sub    %edi,%eax
80101976:	39 c3                	cmp    %eax,%ebx
80101978:	0f 47 d8             	cmova  %eax,%ebx
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
8010197b:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
8010197f:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101980:	01 df                	add    %ebx,%edi
80101982:	01 de                	add    %ebx,%esi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101984:	50                   	push   %eax
80101985:	ff 75 e0             	pushl  -0x20(%ebp)
80101988:	e8 b3 2c 00 00       	call   80104640 <memmove>
    brelse(bp);
8010198d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101990:	89 14 24             	mov    %edx,(%esp)
80101993:	e8 48 e8 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101998:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010199b:	83 c4 10             	add    $0x10,%esp
8010199e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801019a1:	77 9d                	ja     80101940 <readi+0x60>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
801019a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
801019a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019a9:	5b                   	pop    %ebx
801019aa:	5e                   	pop    %esi
801019ab:	5f                   	pop    %edi
801019ac:	5d                   	pop    %ebp
801019ad:	c3                   	ret    
801019ae:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801019b0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801019b4:	66 83 f8 09          	cmp    $0x9,%ax
801019b8:	77 1e                	ja     801019d8 <readi+0xf8>
801019ba:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
801019c1:	85 c0                	test   %eax,%eax
801019c3:	74 13                	je     801019d8 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801019c5:	89 7d 10             	mov    %edi,0x10(%ebp)
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
801019c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019cb:	5b                   	pop    %ebx
801019cc:	5e                   	pop    %esi
801019cd:	5f                   	pop    %edi
801019ce:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801019cf:	ff e0                	jmp    *%eax
801019d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
801019d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801019dd:	eb c7                	jmp    801019a6 <readi+0xc6>
801019df:	90                   	nop

801019e0 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	57                   	push   %edi
801019e4:	56                   	push   %esi
801019e5:	53                   	push   %ebx
801019e6:	83 ec 1c             	sub    $0x1c,%esp
801019e9:	8b 45 08             	mov    0x8(%ebp),%eax
801019ec:	8b 75 0c             	mov    0xc(%ebp),%esi
801019ef:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019f2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801019f7:	89 75 dc             	mov    %esi,-0x24(%ebp)
801019fa:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019fd:	8b 75 10             	mov    0x10(%ebp),%esi
80101a00:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a03:	0f 84 b7 00 00 00    	je     80101ac0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a09:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a0c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a0f:	0f 82 eb 00 00 00    	jb     80101b00 <writei+0x120>
80101a15:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a18:	89 f8                	mov    %edi,%eax
80101a1a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a1c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a21:	0f 87 d9 00 00 00    	ja     80101b00 <writei+0x120>
80101a27:	39 c6                	cmp    %eax,%esi
80101a29:	0f 87 d1 00 00 00    	ja     80101b00 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a2f:	85 ff                	test   %edi,%edi
80101a31:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a38:	74 78                	je     80101ab2 <writei+0xd2>
80101a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a40:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101a43:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a45:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a4a:	c1 ea 09             	shr    $0x9,%edx
80101a4d:	89 f8                	mov    %edi,%eax
80101a4f:	e8 6c f8 ff ff       	call   801012c0 <bmap>
80101a54:	83 ec 08             	sub    $0x8,%esp
80101a57:	50                   	push   %eax
80101a58:	ff 37                	pushl  (%edi)
80101a5a:	e8 71 e6 ff ff       	call   801000d0 <bread>
80101a5f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101a61:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a64:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101a67:	89 f1                	mov    %esi,%ecx
80101a69:	83 c4 0c             	add    $0xc,%esp
80101a6c:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101a72:	29 cb                	sub    %ecx,%ebx
80101a74:	39 c3                	cmp    %eax,%ebx
80101a76:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101a79:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101a7d:	53                   	push   %ebx
80101a7e:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a81:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101a83:	50                   	push   %eax
80101a84:	e8 b7 2b 00 00       	call   80104640 <memmove>
    log_write(bp);
80101a89:	89 3c 24             	mov    %edi,(%esp)
80101a8c:	e8 cf 12 00 00       	call   80102d60 <log_write>
    brelse(bp);
80101a91:	89 3c 24             	mov    %edi,(%esp)
80101a94:	e8 47 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a99:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101a9c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101a9f:	83 c4 10             	add    $0x10,%esp
80101aa2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101aa5:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101aa8:	77 96                	ja     80101a40 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101aaa:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101aad:	3b 70 58             	cmp    0x58(%eax),%esi
80101ab0:	77 36                	ja     80101ae8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ab2:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ab5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ab8:	5b                   	pop    %ebx
80101ab9:	5e                   	pop    %esi
80101aba:	5f                   	pop    %edi
80101abb:	5d                   	pop    %ebp
80101abc:	c3                   	ret    
80101abd:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ac0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ac4:	66 83 f8 09          	cmp    $0x9,%ax
80101ac8:	77 36                	ja     80101b00 <writei+0x120>
80101aca:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101ad1:	85 c0                	test   %eax,%eax
80101ad3:	74 2b                	je     80101b00 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101ad5:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101ad8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101adb:	5b                   	pop    %ebx
80101adc:	5e                   	pop    %esi
80101add:	5f                   	pop    %edi
80101ade:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101adf:	ff e0                	jmp    *%eax
80101ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101ae8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101aeb:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101aee:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101af1:	50                   	push   %eax
80101af2:	e8 79 fa ff ff       	call   80101570 <iupdate>
80101af7:	83 c4 10             	add    $0x10,%esp
80101afa:	eb b6                	jmp    80101ab2 <writei+0xd2>
80101afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b05:	eb ae                	jmp    80101ab5 <writei+0xd5>
80101b07:	89 f6                	mov    %esi,%esi
80101b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b10 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b16:	6a 0e                	push   $0xe
80101b18:	ff 75 0c             	pushl  0xc(%ebp)
80101b1b:	ff 75 08             	pushl  0x8(%ebp)
80101b1e:	e8 9d 2b 00 00       	call   801046c0 <strncmp>
}
80101b23:	c9                   	leave  
80101b24:	c3                   	ret    
80101b25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b30 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	57                   	push   %edi
80101b34:	56                   	push   %esi
80101b35:	53                   	push   %ebx
80101b36:	83 ec 1c             	sub    $0x1c,%esp
80101b39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b3c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101b41:	0f 85 80 00 00 00    	jne    80101bc7 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101b47:	8b 53 58             	mov    0x58(%ebx),%edx
80101b4a:	31 ff                	xor    %edi,%edi
80101b4c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101b4f:	85 d2                	test   %edx,%edx
80101b51:	75 0d                	jne    80101b60 <dirlookup+0x30>
80101b53:	eb 5b                	jmp    80101bb0 <dirlookup+0x80>
80101b55:	8d 76 00             	lea    0x0(%esi),%esi
80101b58:	83 c7 10             	add    $0x10,%edi
80101b5b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101b5e:	76 50                	jbe    80101bb0 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101b60:	6a 10                	push   $0x10
80101b62:	57                   	push   %edi
80101b63:	56                   	push   %esi
80101b64:	53                   	push   %ebx
80101b65:	e8 76 fd ff ff       	call   801018e0 <readi>
80101b6a:	83 c4 10             	add    $0x10,%esp
80101b6d:	83 f8 10             	cmp    $0x10,%eax
80101b70:	75 48                	jne    80101bba <dirlookup+0x8a>
      panic("dirlink read");
    if(de.inum == 0)
80101b72:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101b77:	74 df                	je     80101b58 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101b79:	8d 45 da             	lea    -0x26(%ebp),%eax
80101b7c:	83 ec 04             	sub    $0x4,%esp
80101b7f:	6a 0e                	push   $0xe
80101b81:	50                   	push   %eax
80101b82:	ff 75 0c             	pushl  0xc(%ebp)
80101b85:	e8 36 2b 00 00       	call   801046c0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101b8a:	83 c4 10             	add    $0x10,%esp
80101b8d:	85 c0                	test   %eax,%eax
80101b8f:	75 c7                	jne    80101b58 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101b91:	8b 45 10             	mov    0x10(%ebp),%eax
80101b94:	85 c0                	test   %eax,%eax
80101b96:	74 05                	je     80101b9d <dirlookup+0x6d>
        *poff = off;
80101b98:	8b 45 10             	mov    0x10(%ebp),%eax
80101b9b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101b9d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101ba1:	8b 03                	mov    (%ebx),%eax
80101ba3:	e8 48 f6 ff ff       	call   801011f0 <iget>
    }
  }

  return 0;
}
80101ba8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bab:	5b                   	pop    %ebx
80101bac:	5e                   	pop    %esi
80101bad:	5f                   	pop    %edi
80101bae:	5d                   	pop    %ebp
80101baf:	c3                   	ret    
80101bb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101bb3:	31 c0                	xor    %eax,%eax
}
80101bb5:	5b                   	pop    %ebx
80101bb6:	5e                   	pop    %esi
80101bb7:	5f                   	pop    %edi
80101bb8:	5d                   	pop    %ebp
80101bb9:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101bba:	83 ec 0c             	sub    $0xc,%esp
80101bbd:	68 b5 72 10 80       	push   $0x801072b5
80101bc2:	e8 a9 e7 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101bc7:	83 ec 0c             	sub    $0xc,%esp
80101bca:	68 a3 72 10 80       	push   $0x801072a3
80101bcf:	e8 9c e7 ff ff       	call   80100370 <panic>
80101bd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101bda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101be0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101be0:	55                   	push   %ebp
80101be1:	89 e5                	mov    %esp,%ebp
80101be3:	57                   	push   %edi
80101be4:	56                   	push   %esi
80101be5:	53                   	push   %ebx
80101be6:	89 cf                	mov    %ecx,%edi
80101be8:	89 c3                	mov    %eax,%ebx
80101bea:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101bed:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101bf0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101bf3:	0f 84 53 01 00 00    	je     80101d4c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101bf9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101bff:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101c02:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c05:	68 00 0a 11 80       	push   $0x80110a00
80101c0a:	e8 51 27 00 00       	call   80104360 <acquire>
  ip->ref++;
80101c0f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c13:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c1a:	e8 21 29 00 00       	call   80104540 <release>
80101c1f:	83 c4 10             	add    $0x10,%esp
80101c22:	eb 07                	jmp    80101c2b <namex+0x4b>
80101c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101c28:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101c2b:	0f b6 03             	movzbl (%ebx),%eax
80101c2e:	3c 2f                	cmp    $0x2f,%al
80101c30:	74 f6                	je     80101c28 <namex+0x48>
    path++;
  if(*path == 0)
80101c32:	84 c0                	test   %al,%al
80101c34:	0f 84 e3 00 00 00    	je     80101d1d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c3a:	0f b6 03             	movzbl (%ebx),%eax
80101c3d:	89 da                	mov    %ebx,%edx
80101c3f:	84 c0                	test   %al,%al
80101c41:	0f 84 ac 00 00 00    	je     80101cf3 <namex+0x113>
80101c47:	3c 2f                	cmp    $0x2f,%al
80101c49:	75 09                	jne    80101c54 <namex+0x74>
80101c4b:	e9 a3 00 00 00       	jmp    80101cf3 <namex+0x113>
80101c50:	84 c0                	test   %al,%al
80101c52:	74 0a                	je     80101c5e <namex+0x7e>
    path++;
80101c54:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c57:	0f b6 02             	movzbl (%edx),%eax
80101c5a:	3c 2f                	cmp    $0x2f,%al
80101c5c:	75 f2                	jne    80101c50 <namex+0x70>
80101c5e:	89 d1                	mov    %edx,%ecx
80101c60:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101c62:	83 f9 0d             	cmp    $0xd,%ecx
80101c65:	0f 8e 8d 00 00 00    	jle    80101cf8 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101c6b:	83 ec 04             	sub    $0x4,%esp
80101c6e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101c71:	6a 0e                	push   $0xe
80101c73:	53                   	push   %ebx
80101c74:	57                   	push   %edi
80101c75:	e8 c6 29 00 00       	call   80104640 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101c7a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101c7d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101c80:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101c82:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101c85:	75 11                	jne    80101c98 <namex+0xb8>
80101c87:	89 f6                	mov    %esi,%esi
80101c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101c90:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101c93:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101c96:	74 f8                	je     80101c90 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101c98:	83 ec 0c             	sub    $0xc,%esp
80101c9b:	56                   	push   %esi
80101c9c:	e8 7f f9 ff ff       	call   80101620 <ilock>
    if(ip->type != T_DIR){
80101ca1:	83 c4 10             	add    $0x10,%esp
80101ca4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ca9:	0f 85 7f 00 00 00    	jne    80101d2e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101caf:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101cb2:	85 d2                	test   %edx,%edx
80101cb4:	74 09                	je     80101cbf <namex+0xdf>
80101cb6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101cb9:	0f 84 a3 00 00 00    	je     80101d62 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101cbf:	83 ec 04             	sub    $0x4,%esp
80101cc2:	6a 00                	push   $0x0
80101cc4:	57                   	push   %edi
80101cc5:	56                   	push   %esi
80101cc6:	e8 65 fe ff ff       	call   80101b30 <dirlookup>
80101ccb:	83 c4 10             	add    $0x10,%esp
80101cce:	85 c0                	test   %eax,%eax
80101cd0:	74 5c                	je     80101d2e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101cd2:	83 ec 0c             	sub    $0xc,%esp
80101cd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101cd8:	56                   	push   %esi
80101cd9:	e8 22 fa ff ff       	call   80101700 <iunlock>
  iput(ip);
80101cde:	89 34 24             	mov    %esi,(%esp)
80101ce1:	e8 6a fa ff ff       	call   80101750 <iput>
80101ce6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ce9:	83 c4 10             	add    $0x10,%esp
80101cec:	89 c6                	mov    %eax,%esi
80101cee:	e9 38 ff ff ff       	jmp    80101c2b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cf3:	31 c9                	xor    %ecx,%ecx
80101cf5:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101cf8:	83 ec 04             	sub    $0x4,%esp
80101cfb:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101cfe:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d01:	51                   	push   %ecx
80101d02:	53                   	push   %ebx
80101d03:	57                   	push   %edi
80101d04:	e8 37 29 00 00       	call   80104640 <memmove>
    name[len] = 0;
80101d09:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d0f:	83 c4 10             	add    $0x10,%esp
80101d12:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d16:	89 d3                	mov    %edx,%ebx
80101d18:	e9 65 ff ff ff       	jmp    80101c82 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d1d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d20:	85 c0                	test   %eax,%eax
80101d22:	75 54                	jne    80101d78 <namex+0x198>
80101d24:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101d26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d29:	5b                   	pop    %ebx
80101d2a:	5e                   	pop    %esi
80101d2b:	5f                   	pop    %edi
80101d2c:	5d                   	pop    %ebp
80101d2d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d2e:	83 ec 0c             	sub    $0xc,%esp
80101d31:	56                   	push   %esi
80101d32:	e8 c9 f9 ff ff       	call   80101700 <iunlock>
  iput(ip);
80101d37:	89 34 24             	mov    %esi,(%esp)
80101d3a:	e8 11 fa ff ff       	call   80101750 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d3f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d42:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d45:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d47:	5b                   	pop    %ebx
80101d48:	5e                   	pop    %esi
80101d49:	5f                   	pop    %edi
80101d4a:	5d                   	pop    %ebp
80101d4b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101d4c:	ba 01 00 00 00       	mov    $0x1,%edx
80101d51:	b8 01 00 00 00       	mov    $0x1,%eax
80101d56:	e8 95 f4 ff ff       	call   801011f0 <iget>
80101d5b:	89 c6                	mov    %eax,%esi
80101d5d:	e9 c9 fe ff ff       	jmp    80101c2b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101d62:	83 ec 0c             	sub    $0xc,%esp
80101d65:	56                   	push   %esi
80101d66:	e8 95 f9 ff ff       	call   80101700 <iunlock>
      return ip;
80101d6b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101d71:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d73:	5b                   	pop    %ebx
80101d74:	5e                   	pop    %esi
80101d75:	5f                   	pop    %edi
80101d76:	5d                   	pop    %ebp
80101d77:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101d78:	83 ec 0c             	sub    $0xc,%esp
80101d7b:	56                   	push   %esi
80101d7c:	e8 cf f9 ff ff       	call   80101750 <iput>
    return 0;
80101d81:	83 c4 10             	add    $0x10,%esp
80101d84:	31 c0                	xor    %eax,%eax
80101d86:	eb 9e                	jmp    80101d26 <namex+0x146>
80101d88:	90                   	nop
80101d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d90 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	83 ec 20             	sub    $0x20,%esp
80101d99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101d9c:	6a 00                	push   $0x0
80101d9e:	ff 75 0c             	pushl  0xc(%ebp)
80101da1:	53                   	push   %ebx
80101da2:	e8 89 fd ff ff       	call   80101b30 <dirlookup>
80101da7:	83 c4 10             	add    $0x10,%esp
80101daa:	85 c0                	test   %eax,%eax
80101dac:	75 67                	jne    80101e15 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101dae:	8b 7b 58             	mov    0x58(%ebx),%edi
80101db1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101db4:	85 ff                	test   %edi,%edi
80101db6:	74 29                	je     80101de1 <dirlink+0x51>
80101db8:	31 ff                	xor    %edi,%edi
80101dba:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dbd:	eb 09                	jmp    80101dc8 <dirlink+0x38>
80101dbf:	90                   	nop
80101dc0:	83 c7 10             	add    $0x10,%edi
80101dc3:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101dc6:	76 19                	jbe    80101de1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101dc8:	6a 10                	push   $0x10
80101dca:	57                   	push   %edi
80101dcb:	56                   	push   %esi
80101dcc:	53                   	push   %ebx
80101dcd:	e8 0e fb ff ff       	call   801018e0 <readi>
80101dd2:	83 c4 10             	add    $0x10,%esp
80101dd5:	83 f8 10             	cmp    $0x10,%eax
80101dd8:	75 4e                	jne    80101e28 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101dda:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ddf:	75 df                	jne    80101dc0 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101de1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101de4:	83 ec 04             	sub    $0x4,%esp
80101de7:	6a 0e                	push   $0xe
80101de9:	ff 75 0c             	pushl  0xc(%ebp)
80101dec:	50                   	push   %eax
80101ded:	e8 3e 29 00 00       	call   80104730 <strncpy>
  de.inum = inum;
80101df2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101df5:	6a 10                	push   $0x10
80101df7:	57                   	push   %edi
80101df8:	56                   	push   %esi
80101df9:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101dfa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101dfe:	e8 dd fb ff ff       	call   801019e0 <writei>
80101e03:	83 c4 20             	add    $0x20,%esp
80101e06:	83 f8 10             	cmp    $0x10,%eax
80101e09:	75 2a                	jne    80101e35 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e0b:	31 c0                	xor    %eax,%eax
}
80101e0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e10:	5b                   	pop    %ebx
80101e11:	5e                   	pop    %esi
80101e12:	5f                   	pop    %edi
80101e13:	5d                   	pop    %ebp
80101e14:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101e15:	83 ec 0c             	sub    $0xc,%esp
80101e18:	50                   	push   %eax
80101e19:	e8 32 f9 ff ff       	call   80101750 <iput>
    return -1;
80101e1e:	83 c4 10             	add    $0x10,%esp
80101e21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e26:	eb e5                	jmp    80101e0d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101e28:	83 ec 0c             	sub    $0xc,%esp
80101e2b:	68 b5 72 10 80       	push   $0x801072b5
80101e30:	e8 3b e5 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101e35:	83 ec 0c             	sub    $0xc,%esp
80101e38:	68 4e 78 10 80       	push   $0x8010784e
80101e3d:	e8 2e e5 ff ff       	call   80100370 <panic>
80101e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e50 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101e50:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e51:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101e53:	89 e5                	mov    %esp,%ebp
80101e55:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e58:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101e5e:	e8 7d fd ff ff       	call   80101be0 <namex>
}
80101e63:	c9                   	leave  
80101e64:	c3                   	ret    
80101e65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e70 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101e70:	55                   	push   %ebp
  return namex(path, 1, name);
80101e71:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101e76:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101e78:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101e7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101e7e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101e7f:	e9 5c fd ff ff       	jmp    80101be0 <namex>
80101e84:	66 90                	xchg   %ax,%ax
80101e86:	66 90                	xchg   %ax,%ax
80101e88:	66 90                	xchg   %ax,%ax
80101e8a:	66 90                	xchg   %ax,%ax
80101e8c:	66 90                	xchg   %ax,%ax
80101e8e:	66 90                	xchg   %ax,%ax

80101e90 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101e90:	55                   	push   %ebp
  if(b == 0)
80101e91:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101e93:	89 e5                	mov    %esp,%ebp
80101e95:	56                   	push   %esi
80101e96:	53                   	push   %ebx
  if(b == 0)
80101e97:	0f 84 ad 00 00 00    	je     80101f4a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101e9d:	8b 58 08             	mov    0x8(%eax),%ebx
80101ea0:	89 c1                	mov    %eax,%ecx
80101ea2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101ea8:	0f 87 8f 00 00 00    	ja     80101f3d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101eae:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101eb3:	90                   	nop
80101eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101eb8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101eb9:	83 e0 c0             	and    $0xffffffc0,%eax
80101ebc:	3c 40                	cmp    $0x40,%al
80101ebe:	75 f8                	jne    80101eb8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101ec0:	31 f6                	xor    %esi,%esi
80101ec2:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101ec7:	89 f0                	mov    %esi,%eax
80101ec9:	ee                   	out    %al,(%dx)
80101eca:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101ecf:	b8 01 00 00 00       	mov    $0x1,%eax
80101ed4:	ee                   	out    %al,(%dx)
80101ed5:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101eda:	89 d8                	mov    %ebx,%eax
80101edc:	ee                   	out    %al,(%dx)
80101edd:	89 d8                	mov    %ebx,%eax
80101edf:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101ee4:	c1 f8 08             	sar    $0x8,%eax
80101ee7:	ee                   	out    %al,(%dx)
80101ee8:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101eed:	89 f0                	mov    %esi,%eax
80101eef:	ee                   	out    %al,(%dx)
80101ef0:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101ef4:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101ef9:	83 e0 01             	and    $0x1,%eax
80101efc:	c1 e0 04             	shl    $0x4,%eax
80101eff:	83 c8 e0             	or     $0xffffffe0,%eax
80101f02:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101f03:	f6 01 04             	testb  $0x4,(%ecx)
80101f06:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f0b:	75 13                	jne    80101f20 <idestart+0x90>
80101f0d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f12:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f13:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f16:	5b                   	pop    %ebx
80101f17:	5e                   	pop    %esi
80101f18:	5d                   	pop    %ebp
80101f19:	c3                   	ret    
80101f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f20:	b8 30 00 00 00       	mov    $0x30,%eax
80101f25:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101f26:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101f2b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f2e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101f33:	fc                   	cld    
80101f34:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f36:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f39:	5b                   	pop    %ebx
80101f3a:	5e                   	pop    %esi
80101f3b:	5d                   	pop    %ebp
80101f3c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101f3d:	83 ec 0c             	sub    $0xc,%esp
80101f40:	68 cb 72 10 80       	push   $0x801072cb
80101f45:	e8 26 e4 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101f4a:	83 ec 0c             	sub    $0xc,%esp
80101f4d:	68 c2 72 10 80       	push   $0x801072c2
80101f52:	e8 19 e4 ff ff       	call   80100370 <panic>
80101f57:	89 f6                	mov    %esi,%esi
80101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f60 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101f66:	68 dd 72 10 80       	push   $0x801072dd
80101f6b:	68 80 a5 10 80       	push   $0x8010a580
80101f70:	e8 cb 23 00 00       	call   80104340 <initlock>
  picenable(IRQ_IDE);
80101f75:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80101f7c:	e8 af 12 00 00       	call   80103230 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101f81:	58                   	pop    %eax
80101f82:	a1 80 2d 11 80       	mov    0x80112d80,%eax
80101f87:	5a                   	pop    %edx
80101f88:	83 e8 01             	sub    $0x1,%eax
80101f8b:	50                   	push   %eax
80101f8c:	6a 0e                	push   $0xe
80101f8e:	e8 bd 02 00 00       	call   80102250 <ioapicenable>
80101f93:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f96:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f9b:	90                   	nop
80101f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fa0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fa1:	83 e0 c0             	and    $0xffffffc0,%eax
80101fa4:	3c 40                	cmp    $0x40,%al
80101fa6:	75 f8                	jne    80101fa0 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fa8:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fad:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80101fb2:	ee                   	out    %al,(%dx)
80101fb3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fb8:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fbd:	eb 06                	jmp    80101fc5 <ideinit+0x65>
80101fbf:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80101fc0:	83 e9 01             	sub    $0x1,%ecx
80101fc3:	74 0f                	je     80101fd4 <ideinit+0x74>
80101fc5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101fc6:	84 c0                	test   %al,%al
80101fc8:	74 f6                	je     80101fc0 <ideinit+0x60>
      havedisk1 = 1;
80101fca:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80101fd1:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fd4:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fd9:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80101fde:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
80101fdf:	c9                   	leave  
80101fe0:	c3                   	ret    
80101fe1:	eb 0d                	jmp    80101ff0 <ideintr>
80101fe3:	90                   	nop
80101fe4:	90                   	nop
80101fe5:	90                   	nop
80101fe6:	90                   	nop
80101fe7:	90                   	nop
80101fe8:	90                   	nop
80101fe9:	90                   	nop
80101fea:	90                   	nop
80101feb:	90                   	nop
80101fec:	90                   	nop
80101fed:	90                   	nop
80101fee:	90                   	nop
80101fef:	90                   	nop

80101ff0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101ff9:	68 80 a5 10 80       	push   $0x8010a580
80101ffe:	e8 5d 23 00 00       	call   80104360 <acquire>
  if((b = idequeue) == 0){
80102003:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102009:	83 c4 10             	add    $0x10,%esp
8010200c:	85 db                	test   %ebx,%ebx
8010200e:	74 34                	je     80102044 <ideintr+0x54>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
80102010:	8b 43 58             	mov    0x58(%ebx),%eax
80102013:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102018:	8b 33                	mov    (%ebx),%esi
8010201a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102020:	74 3e                	je     80102060 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102022:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102025:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102028:	83 ce 02             	or     $0x2,%esi
8010202b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010202d:	53                   	push   %ebx
8010202e:	e8 fd 1e 00 00       	call   80103f30 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102033:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102038:	83 c4 10             	add    $0x10,%esp
8010203b:	85 c0                	test   %eax,%eax
8010203d:	74 05                	je     80102044 <ideintr+0x54>
    idestart(idequeue);
8010203f:	e8 4c fe ff ff       	call   80101e90 <idestart>
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
80102044:	83 ec 0c             	sub    $0xc,%esp
80102047:	68 80 a5 10 80       	push   $0x8010a580
8010204c:	e8 ef 24 00 00       	call   80104540 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102051:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102054:	5b                   	pop    %ebx
80102055:	5e                   	pop    %esi
80102056:	5f                   	pop    %edi
80102057:	5d                   	pop    %ebp
80102058:	c3                   	ret    
80102059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102060:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102065:	8d 76 00             	lea    0x0(%esi),%esi
80102068:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102069:	89 c1                	mov    %eax,%ecx
8010206b:	83 e1 c0             	and    $0xffffffc0,%ecx
8010206e:	80 f9 40             	cmp    $0x40,%cl
80102071:	75 f5                	jne    80102068 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102073:	a8 21                	test   $0x21,%al
80102075:	75 ab                	jne    80102022 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102077:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010207a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010207f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102084:	fc                   	cld    
80102085:	f3 6d                	rep insl (%dx),%es:(%edi)
80102087:	8b 33                	mov    (%ebx),%esi
80102089:	eb 97                	jmp    80102022 <ideintr+0x32>
8010208b:	90                   	nop
8010208c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102090 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	53                   	push   %ebx
80102094:	83 ec 10             	sub    $0x10,%esp
80102097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010209a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010209d:	50                   	push   %eax
8010209e:	e8 6d 22 00 00       	call   80104310 <holdingsleep>
801020a3:	83 c4 10             	add    $0x10,%esp
801020a6:	85 c0                	test   %eax,%eax
801020a8:	0f 84 ad 00 00 00    	je     8010215b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801020ae:	8b 03                	mov    (%ebx),%eax
801020b0:	83 e0 06             	and    $0x6,%eax
801020b3:	83 f8 02             	cmp    $0x2,%eax
801020b6:	0f 84 b9 00 00 00    	je     80102175 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801020bc:	8b 53 04             	mov    0x4(%ebx),%edx
801020bf:	85 d2                	test   %edx,%edx
801020c1:	74 0d                	je     801020d0 <iderw+0x40>
801020c3:	a1 60 a5 10 80       	mov    0x8010a560,%eax
801020c8:	85 c0                	test   %eax,%eax
801020ca:	0f 84 98 00 00 00    	je     80102168 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801020d0:	83 ec 0c             	sub    $0xc,%esp
801020d3:	68 80 a5 10 80       	push   $0x8010a580
801020d8:	e8 83 22 00 00       	call   80104360 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020dd:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
801020e3:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
801020e6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020ed:	85 d2                	test   %edx,%edx
801020ef:	75 09                	jne    801020fa <iderw+0x6a>
801020f1:	eb 58                	jmp    8010214b <iderw+0xbb>
801020f3:	90                   	nop
801020f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020f8:	89 c2                	mov    %eax,%edx
801020fa:	8b 42 58             	mov    0x58(%edx),%eax
801020fd:	85 c0                	test   %eax,%eax
801020ff:	75 f7                	jne    801020f8 <iderw+0x68>
80102101:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102104:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102106:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010210c:	74 44                	je     80102152 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010210e:	8b 03                	mov    (%ebx),%eax
80102110:	83 e0 06             	and    $0x6,%eax
80102113:	83 f8 02             	cmp    $0x2,%eax
80102116:	74 23                	je     8010213b <iderw+0xab>
80102118:	90                   	nop
80102119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102120:	83 ec 08             	sub    $0x8,%esp
80102123:	68 80 a5 10 80       	push   $0x8010a580
80102128:	53                   	push   %ebx
80102129:	e8 62 1c 00 00       	call   80103d90 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010212e:	8b 03                	mov    (%ebx),%eax
80102130:	83 c4 10             	add    $0x10,%esp
80102133:	83 e0 06             	and    $0x6,%eax
80102136:	83 f8 02             	cmp    $0x2,%eax
80102139:	75 e5                	jne    80102120 <iderw+0x90>
    sleep(b, &idelock);
  }

  release(&idelock);
8010213b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102142:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102145:	c9                   	leave  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
80102146:	e9 f5 23 00 00       	jmp    80104540 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010214b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102150:	eb b2                	jmp    80102104 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102152:	89 d8                	mov    %ebx,%eax
80102154:	e8 37 fd ff ff       	call   80101e90 <idestart>
80102159:	eb b3                	jmp    8010210e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010215b:	83 ec 0c             	sub    $0xc,%esp
8010215e:	68 e1 72 10 80       	push   $0x801072e1
80102163:	e8 08 e2 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102168:	83 ec 0c             	sub    $0xc,%esp
8010216b:	68 0c 73 10 80       	push   $0x8010730c
80102170:	e8 fb e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102175:	83 ec 0c             	sub    $0xc,%esp
80102178:	68 f7 72 10 80       	push   $0x801072f7
8010217d:	e8 ee e1 ff ff       	call   80100370 <panic>
80102182:	66 90                	xchg   %ax,%ax
80102184:	66 90                	xchg   %ax,%ax
80102186:	66 90                	xchg   %ax,%ax
80102188:	66 90                	xchg   %ax,%ax
8010218a:	66 90                	xchg   %ax,%ax
8010218c:	66 90                	xchg   %ax,%ax
8010218e:	66 90                	xchg   %ax,%ax

80102190 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
80102190:	a1 84 27 11 80       	mov    0x80112784,%eax
80102195:	85 c0                	test   %eax,%eax
80102197:	0f 84 a8 00 00 00    	je     80102245 <ioapicinit+0xb5>
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010219d:	55                   	push   %ebp
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
8010219e:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
801021a5:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021a8:	89 e5                	mov    %esp,%ebp
801021aa:	56                   	push   %esi
801021ab:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021ac:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801021b3:	00 00 00 
  return ioapic->data;
801021b6:	8b 15 54 26 11 80    	mov    0x80112654,%edx
801021bc:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021bf:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801021c5:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801021cb:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801021d2:	89 f0                	mov    %esi,%eax
801021d4:	c1 e8 10             	shr    $0x10,%eax
801021d7:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
801021da:	8b 41 10             	mov    0x10(%ecx),%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801021dd:	c1 e8 18             	shr    $0x18,%eax
801021e0:	39 d0                	cmp    %edx,%eax
801021e2:	74 16                	je     801021fa <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801021e4:	83 ec 0c             	sub    $0xc,%esp
801021e7:	68 2c 73 10 80       	push   $0x8010732c
801021ec:	e8 6f e4 ff ff       	call   80100660 <cprintf>
801021f1:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801021f7:	83 c4 10             	add    $0x10,%esp
801021fa:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021fd:	ba 10 00 00 00       	mov    $0x10,%edx
80102202:	b8 20 00 00 00       	mov    $0x20,%eax
80102207:	89 f6                	mov    %esi,%esi
80102209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102210:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102212:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102218:	89 c3                	mov    %eax,%ebx
8010221a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102220:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102223:	89 59 10             	mov    %ebx,0x10(%ecx)
80102226:	8d 5a 01             	lea    0x1(%edx),%ebx
80102229:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010222c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010222e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102230:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102236:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010223d:	75 d1                	jne    80102210 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010223f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102242:	5b                   	pop    %ebx
80102243:	5e                   	pop    %esi
80102244:	5d                   	pop    %ebp
80102245:	f3 c3                	repz ret 
80102247:	89 f6                	mov    %esi,%esi
80102249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102250 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102250:	8b 15 84 27 11 80    	mov    0x80112784,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102256:	55                   	push   %ebp
80102257:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102259:	85 d2                	test   %edx,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
8010225b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010225e:	74 2b                	je     8010228b <ioapicenable+0x3b>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102260:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102266:	8d 50 20             	lea    0x20(%eax),%edx
80102269:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010226d:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010226f:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102275:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102278:	89 51 10             	mov    %edx,0x10(%ecx)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010227b:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010227e:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102280:	a1 54 26 11 80       	mov    0x80112654,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102285:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102288:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
8010228b:	5d                   	pop    %ebp
8010228c:	c3                   	ret    
8010228d:	66 90                	xchg   %ax,%ax
8010228f:	90                   	nop

80102290 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	53                   	push   %ebx
80102294:	83 ec 04             	sub    $0x4,%esp
80102297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010229a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022a0:	75 70                	jne    80102312 <kfree+0x82>
801022a2:	81 fb 28 56 11 80    	cmp    $0x80115628,%ebx
801022a8:	72 68                	jb     80102312 <kfree+0x82>
801022aa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801022b0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801022b5:	77 5b                	ja     80102312 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801022b7:	83 ec 04             	sub    $0x4,%esp
801022ba:	68 00 10 00 00       	push   $0x1000
801022bf:	6a 01                	push   $0x1
801022c1:	53                   	push   %ebx
801022c2:	e8 c9 22 00 00       	call   80104590 <memset>

  if(kmem.use_lock)
801022c7:	8b 15 94 26 11 80    	mov    0x80112694,%edx
801022cd:	83 c4 10             	add    $0x10,%esp
801022d0:	85 d2                	test   %edx,%edx
801022d2:	75 2c                	jne    80102300 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801022d4:	a1 98 26 11 80       	mov    0x80112698,%eax
801022d9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801022db:	a1 94 26 11 80       	mov    0x80112694,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
801022e0:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
801022e6:	85 c0                	test   %eax,%eax
801022e8:	75 06                	jne    801022f0 <kfree+0x60>
    release(&kmem.lock);
}
801022ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022ed:	c9                   	leave  
801022ee:	c3                   	ret    
801022ef:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801022f0:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
801022f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022fa:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801022fb:	e9 40 22 00 00       	jmp    80104540 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102300:	83 ec 0c             	sub    $0xc,%esp
80102303:	68 60 26 11 80       	push   $0x80112660
80102308:	e8 53 20 00 00       	call   80104360 <acquire>
8010230d:	83 c4 10             	add    $0x10,%esp
80102310:	eb c2                	jmp    801022d4 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102312:	83 ec 0c             	sub    $0xc,%esp
80102315:	68 5e 73 10 80       	push   $0x8010735e
8010231a:	e8 51 e0 ff ff       	call   80100370 <panic>
8010231f:	90                   	nop

80102320 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	56                   	push   %esi
80102324:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102325:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102328:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010232b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102331:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102337:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010233d:	39 de                	cmp    %ebx,%esi
8010233f:	72 23                	jb     80102364 <freerange+0x44>
80102341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102348:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010234e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102351:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102357:	50                   	push   %eax
80102358:	e8 33 ff ff ff       	call   80102290 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	39 f3                	cmp    %esi,%ebx
80102362:	76 e4                	jbe    80102348 <freerange+0x28>
    kfree(p);
}
80102364:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102367:	5b                   	pop    %ebx
80102368:	5e                   	pop    %esi
80102369:	5d                   	pop    %ebp
8010236a:	c3                   	ret    
8010236b:	90                   	nop
8010236c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102370 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	56                   	push   %esi
80102374:	53                   	push   %ebx
80102375:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102378:	83 ec 08             	sub    $0x8,%esp
8010237b:	68 64 73 10 80       	push   $0x80107364
80102380:	68 60 26 11 80       	push   $0x80112660
80102385:	e8 b6 1f 00 00       	call   80104340 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010238a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010238d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102390:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102397:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010239a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023a0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023a6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ac:	39 de                	cmp    %ebx,%esi
801023ae:	72 1c                	jb     801023cc <kinit1+0x5c>
    kfree(p);
801023b0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023b6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023b9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023bf:	50                   	push   %eax
801023c0:	e8 cb fe ff ff       	call   80102290 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023c5:	83 c4 10             	add    $0x10,%esp
801023c8:	39 de                	cmp    %ebx,%esi
801023ca:	73 e4                	jae    801023b0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
801023cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023cf:	5b                   	pop    %ebx
801023d0:	5e                   	pop    %esi
801023d1:	5d                   	pop    %ebp
801023d2:	c3                   	ret    
801023d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801023d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023e0 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	56                   	push   %esi
801023e4:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023e5:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801023e8:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023fd:	39 de                	cmp    %ebx,%esi
801023ff:	72 23                	jb     80102424 <kinit2+0x44>
80102401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102408:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010240e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102411:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102417:	50                   	push   %eax
80102418:	e8 73 fe ff ff       	call   80102290 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010241d:	83 c4 10             	add    $0x10,%esp
80102420:	39 de                	cmp    %ebx,%esi
80102422:	73 e4                	jae    80102408 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102424:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
8010242b:	00 00 00 
}
8010242e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102431:	5b                   	pop    %ebx
80102432:	5e                   	pop    %esi
80102433:	5d                   	pop    %ebp
80102434:	c3                   	ret    
80102435:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102440 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102440:	55                   	push   %ebp
80102441:	89 e5                	mov    %esp,%ebp
80102443:	53                   	push   %ebx
80102444:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102447:	a1 94 26 11 80       	mov    0x80112694,%eax
8010244c:	85 c0                	test   %eax,%eax
8010244e:	75 30                	jne    80102480 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102450:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102456:	85 db                	test   %ebx,%ebx
80102458:	74 1c                	je     80102476 <kalloc+0x36>
    kmem.freelist = r->next;
8010245a:	8b 13                	mov    (%ebx),%edx
8010245c:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
80102462:	85 c0                	test   %eax,%eax
80102464:	74 10                	je     80102476 <kalloc+0x36>
    release(&kmem.lock);
80102466:	83 ec 0c             	sub    $0xc,%esp
80102469:	68 60 26 11 80       	push   $0x80112660
8010246e:	e8 cd 20 00 00       	call   80104540 <release>
80102473:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102476:	89 d8                	mov    %ebx,%eax
80102478:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010247b:	c9                   	leave  
8010247c:	c3                   	ret    
8010247d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102480:	83 ec 0c             	sub    $0xc,%esp
80102483:	68 60 26 11 80       	push   $0x80112660
80102488:	e8 d3 1e 00 00       	call   80104360 <acquire>
  r = kmem.freelist;
8010248d:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102493:	83 c4 10             	add    $0x10,%esp
80102496:	a1 94 26 11 80       	mov    0x80112694,%eax
8010249b:	85 db                	test   %ebx,%ebx
8010249d:	75 bb                	jne    8010245a <kalloc+0x1a>
8010249f:	eb c1                	jmp    80102462 <kalloc+0x22>
801024a1:	66 90                	xchg   %ax,%ax
801024a3:	66 90                	xchg   %ax,%ax
801024a5:	66 90                	xchg   %ax,%ax
801024a7:	66 90                	xchg   %ax,%ax
801024a9:	66 90                	xchg   %ax,%ax
801024ab:	66 90                	xchg   %ax,%ax
801024ad:	66 90                	xchg   %ax,%ax
801024af:	90                   	nop

801024b0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801024b0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024b1:	ba 64 00 00 00       	mov    $0x64,%edx
801024b6:	89 e5                	mov    %esp,%ebp
801024b8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801024b9:	a8 01                	test   $0x1,%al
801024bb:	0f 84 af 00 00 00    	je     80102570 <kbdgetc+0xc0>
801024c1:	ba 60 00 00 00       	mov    $0x60,%edx
801024c6:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801024c7:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801024ca:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801024d0:	74 7e                	je     80102550 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801024d2:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801024d4:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801024da:	79 24                	jns    80102500 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801024dc:	f6 c1 40             	test   $0x40,%cl
801024df:	75 05                	jne    801024e6 <kbdgetc+0x36>
801024e1:	89 c2                	mov    %eax,%edx
801024e3:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801024e6:	0f b6 82 a0 74 10 80 	movzbl -0x7fef8b60(%edx),%eax
801024ed:	83 c8 40             	or     $0x40,%eax
801024f0:	0f b6 c0             	movzbl %al,%eax
801024f3:	f7 d0                	not    %eax
801024f5:	21 c8                	and    %ecx,%eax
801024f7:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
801024fc:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801024fe:	5d                   	pop    %ebp
801024ff:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102500:	f6 c1 40             	test   $0x40,%cl
80102503:	74 09                	je     8010250e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102505:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102508:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010250b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010250e:	0f b6 82 a0 74 10 80 	movzbl -0x7fef8b60(%edx),%eax
80102515:	09 c1                	or     %eax,%ecx
80102517:	0f b6 82 a0 73 10 80 	movzbl -0x7fef8c60(%edx),%eax
8010251e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102520:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102522:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102528:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010252b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010252e:	8b 04 85 80 73 10 80 	mov    -0x7fef8c80(,%eax,4),%eax
80102535:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102539:	74 c3                	je     801024fe <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010253b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010253e:	83 fa 19             	cmp    $0x19,%edx
80102541:	77 1d                	ja     80102560 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102543:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102546:	5d                   	pop    %ebp
80102547:	c3                   	ret    
80102548:	90                   	nop
80102549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102550:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102552:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102559:	5d                   	pop    %ebp
8010255a:	c3                   	ret    
8010255b:	90                   	nop
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102560:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102563:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102566:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102567:	83 f9 19             	cmp    $0x19,%ecx
8010256a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010256d:	c3                   	ret    
8010256e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102570:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102575:	5d                   	pop    %ebp
80102576:	c3                   	ret    
80102577:	89 f6                	mov    %esi,%esi
80102579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102580 <kbdintr>:

void
kbdintr(void)
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102586:	68 b0 24 10 80       	push   $0x801024b0
8010258b:	e8 60 e2 ff ff       	call   801007f0 <consoleintr>
}
80102590:	83 c4 10             	add    $0x10,%esp
80102593:	c9                   	leave  
80102594:	c3                   	ret    
80102595:	66 90                	xchg   %ax,%ax
80102597:	66 90                	xchg   %ax,%ax
80102599:	66 90                	xchg   %ax,%ax
8010259b:	66 90                	xchg   %ax,%ax
8010259d:	66 90                	xchg   %ax,%ax
8010259f:	90                   	nop

801025a0 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
801025a0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
801025a5:	55                   	push   %ebp
801025a6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801025a8:	85 c0                	test   %eax,%eax
801025aa:	0f 84 c8 00 00 00    	je     80102678 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025b0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801025b7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025ba:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025bd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801025c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025c7:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025ca:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801025d1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801025d4:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025d7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801025de:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801025e1:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025e4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801025eb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801025ee:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025f1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801025f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801025fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801025fe:	8b 50 30             	mov    0x30(%eax),%edx
80102601:	c1 ea 10             	shr    $0x10,%edx
80102604:	80 fa 03             	cmp    $0x3,%dl
80102607:	77 77                	ja     80102680 <lapicinit+0xe0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102609:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102610:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102613:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102616:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010261d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102620:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102623:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010262a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010262d:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102630:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102637:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010263a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010263d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102644:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102647:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010264a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102651:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102654:	8b 50 20             	mov    0x20(%eax),%edx
80102657:	89 f6                	mov    %esi,%esi
80102659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102660:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102666:	80 e6 10             	and    $0x10,%dh
80102669:	75 f5                	jne    80102660 <lapicinit+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010266b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102672:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102675:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102678:	5d                   	pop    %ebp
80102679:	c3                   	ret    
8010267a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102680:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102687:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
8010268d:	e9 77 ff ff ff       	jmp    80102609 <lapicinit+0x69>
80102692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026a0 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	56                   	push   %esi
801026a4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801026a5:	9c                   	pushf  
801026a6:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
801026a7:	f6 c4 02             	test   $0x2,%ah
801026aa:	74 12                	je     801026be <cpunum+0x1e>
    static int n;
    if(n++ == 0)
801026ac:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
801026b1:	8d 50 01             	lea    0x1(%eax),%edx
801026b4:	85 c0                	test   %eax,%eax
801026b6:	89 15 b8 a5 10 80    	mov    %edx,0x8010a5b8
801026bc:	74 4d                	je     8010270b <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
801026be:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026c3:	85 c0                	test   %eax,%eax
801026c5:	74 60                	je     80102727 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
801026c7:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
801026ca:	8b 35 80 2d 11 80    	mov    0x80112d80,%esi
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
801026d0:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
801026d3:	85 f6                	test   %esi,%esi
801026d5:	7e 59                	jle    80102730 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
801026d7:	0f b6 05 a0 27 11 80 	movzbl 0x801127a0,%eax
801026de:	39 c3                	cmp    %eax,%ebx
801026e0:	74 45                	je     80102727 <cpunum+0x87>
801026e2:	ba 5c 28 11 80       	mov    $0x8011285c,%edx
801026e7:	31 c0                	xor    %eax,%eax
801026e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
801026f0:	83 c0 01             	add    $0x1,%eax
801026f3:	39 f0                	cmp    %esi,%eax
801026f5:	74 39                	je     80102730 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
801026f7:	0f b6 0a             	movzbl (%edx),%ecx
801026fa:	81 c2 bc 00 00 00    	add    $0xbc,%edx
80102700:	39 cb                	cmp    %ecx,%ebx
80102702:	75 ec                	jne    801026f0 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
80102704:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102707:	5b                   	pop    %ebx
80102708:	5e                   	pop    %esi
80102709:	5d                   	pop    %ebp
8010270a:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
8010270b:	83 ec 08             	sub    $0x8,%esp
8010270e:	ff 75 04             	pushl  0x4(%ebp)
80102711:	68 a0 75 10 80       	push   $0x801075a0
80102716:	e8 45 df ff ff       	call   80100660 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
8010271b:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
80102720:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if (!lapic)
80102723:	85 c0                	test   %eax,%eax
80102725:	75 a0                	jne    801026c7 <cpunum+0x27>
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
80102727:	8d 65 f8             	lea    -0x8(%ebp),%esp
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
    return 0;
8010272a:	31 c0                	xor    %eax,%eax
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
8010272c:	5b                   	pop    %ebx
8010272d:	5e                   	pop    %esi
8010272e:	5d                   	pop    %ebp
8010272f:	c3                   	ret    
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80102730:	83 ec 0c             	sub    $0xc,%esp
80102733:	68 cc 75 10 80       	push   $0x801075cc
80102738:	e8 33 dc ff ff       	call   80100370 <panic>
8010273d:	8d 76 00             	lea    0x0(%esi),%esi

80102740 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102740:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102745:	55                   	push   %ebp
80102746:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102748:	85 c0                	test   %eax,%eax
8010274a:	74 0d                	je     80102759 <lapiceoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010274c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102753:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102756:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102759:	5d                   	pop    %ebp
8010275a:	c3                   	ret    
8010275b:	90                   	nop
8010275c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102760 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102760:	55                   	push   %ebp
80102761:	89 e5                	mov    %esp,%ebp
}
80102763:	5d                   	pop    %ebp
80102764:	c3                   	ret    
80102765:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102770 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102770:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102771:	ba 70 00 00 00       	mov    $0x70,%edx
80102776:	b8 0f 00 00 00       	mov    $0xf,%eax
8010277b:	89 e5                	mov    %esp,%ebp
8010277d:	53                   	push   %ebx
8010277e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102781:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102784:	ee                   	out    %al,(%dx)
80102785:	ba 71 00 00 00       	mov    $0x71,%edx
8010278a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010278f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102790:	31 c0                	xor    %eax,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102792:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102795:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010279b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010279d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801027a0:	c1 e8 04             	shr    $0x4,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a3:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027a5:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801027a8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ae:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027b3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027b9:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027bc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027c3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c6:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027d0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d3:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027d6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027dc:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027df:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e5:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027e8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ee:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027f1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801027fa:	5b                   	pop    %ebx
801027fb:	5d                   	pop    %ebp
801027fc:	c3                   	ret    
801027fd:	8d 76 00             	lea    0x0(%esi),%esi

80102800 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102800:	55                   	push   %ebp
80102801:	ba 70 00 00 00       	mov    $0x70,%edx
80102806:	b8 0b 00 00 00       	mov    $0xb,%eax
8010280b:	89 e5                	mov    %esp,%ebp
8010280d:	57                   	push   %edi
8010280e:	56                   	push   %esi
8010280f:	53                   	push   %ebx
80102810:	83 ec 4c             	sub    $0x4c,%esp
80102813:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102814:	ba 71 00 00 00       	mov    $0x71,%edx
80102819:	ec                   	in     (%dx),%al
8010281a:	83 e0 04             	and    $0x4,%eax
8010281d:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102820:	31 db                	xor    %ebx,%ebx
80102822:	88 45 b7             	mov    %al,-0x49(%ebp)
80102825:	bf 70 00 00 00       	mov    $0x70,%edi
8010282a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102830:	89 d8                	mov    %ebx,%eax
80102832:	89 fa                	mov    %edi,%edx
80102834:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102835:	b9 71 00 00 00       	mov    $0x71,%ecx
8010283a:	89 ca                	mov    %ecx,%edx
8010283c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010283d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102840:	89 fa                	mov    %edi,%edx
80102842:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102845:	b8 02 00 00 00       	mov    $0x2,%eax
8010284a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284b:	89 ca                	mov    %ecx,%edx
8010284d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010284e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102851:	89 fa                	mov    %edi,%edx
80102853:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102856:	b8 04 00 00 00       	mov    $0x4,%eax
8010285b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285c:	89 ca                	mov    %ecx,%edx
8010285e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010285f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102862:	89 fa                	mov    %edi,%edx
80102864:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102867:	b8 07 00 00 00       	mov    $0x7,%eax
8010286c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286d:	89 ca                	mov    %ecx,%edx
8010286f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102870:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102873:	89 fa                	mov    %edi,%edx
80102875:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102878:	b8 08 00 00 00       	mov    $0x8,%eax
8010287d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287e:	89 ca                	mov    %ecx,%edx
80102880:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102881:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102884:	89 fa                	mov    %edi,%edx
80102886:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102889:	b8 09 00 00 00       	mov    $0x9,%eax
8010288e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288f:	89 ca                	mov    %ecx,%edx
80102891:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102892:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102895:	89 fa                	mov    %edi,%edx
80102897:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010289a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010289f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a0:	89 ca                	mov    %ecx,%edx
801028a2:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028a3:	84 c0                	test   %al,%al
801028a5:	78 89                	js     80102830 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a7:	89 d8                	mov    %ebx,%eax
801028a9:	89 fa                	mov    %edi,%edx
801028ab:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ac:	89 ca                	mov    %ecx,%edx
801028ae:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801028af:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b2:	89 fa                	mov    %edi,%edx
801028b4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028b7:	b8 02 00 00 00       	mov    $0x2,%eax
801028bc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028bd:	89 ca                	mov    %ecx,%edx
801028bf:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801028c0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c3:	89 fa                	mov    %edi,%edx
801028c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028c8:	b8 04 00 00 00       	mov    $0x4,%eax
801028cd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ce:	89 ca                	mov    %ecx,%edx
801028d0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801028d1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d4:	89 fa                	mov    %edi,%edx
801028d6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028d9:	b8 07 00 00 00       	mov    $0x7,%eax
801028de:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028df:	89 ca                	mov    %ecx,%edx
801028e1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801028e2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e5:	89 fa                	mov    %edi,%edx
801028e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801028ea:	b8 08 00 00 00       	mov    $0x8,%eax
801028ef:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f0:	89 ca                	mov    %ecx,%edx
801028f2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801028f3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f6:	89 fa                	mov    %edi,%edx
801028f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028fb:	b8 09 00 00 00       	mov    $0x9,%eax
80102900:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102901:	89 ca                	mov    %ecx,%edx
80102903:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102904:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102907:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
8010290a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010290d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102910:	6a 18                	push   $0x18
80102912:	56                   	push   %esi
80102913:	50                   	push   %eax
80102914:	e8 c7 1c 00 00       	call   801045e0 <memcmp>
80102919:	83 c4 10             	add    $0x10,%esp
8010291c:	85 c0                	test   %eax,%eax
8010291e:	0f 85 0c ff ff ff    	jne    80102830 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102924:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102928:	75 78                	jne    801029a2 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010292a:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010292d:	89 c2                	mov    %eax,%edx
8010292f:	83 e0 0f             	and    $0xf,%eax
80102932:	c1 ea 04             	shr    $0x4,%edx
80102935:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102938:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010293b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010293e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102941:	89 c2                	mov    %eax,%edx
80102943:	83 e0 0f             	and    $0xf,%eax
80102946:	c1 ea 04             	shr    $0x4,%edx
80102949:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010294c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010294f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102952:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102955:	89 c2                	mov    %eax,%edx
80102957:	83 e0 0f             	and    $0xf,%eax
8010295a:	c1 ea 04             	shr    $0x4,%edx
8010295d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102960:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102963:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102966:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102969:	89 c2                	mov    %eax,%edx
8010296b:	83 e0 0f             	and    $0xf,%eax
8010296e:	c1 ea 04             	shr    $0x4,%edx
80102971:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102974:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102977:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010297a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010297d:	89 c2                	mov    %eax,%edx
8010297f:	83 e0 0f             	and    $0xf,%eax
80102982:	c1 ea 04             	shr    $0x4,%edx
80102985:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102988:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010298b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010298e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102991:	89 c2                	mov    %eax,%edx
80102993:	83 e0 0f             	and    $0xf,%eax
80102996:	c1 ea 04             	shr    $0x4,%edx
80102999:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010299c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010299f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029a2:	8b 75 08             	mov    0x8(%ebp),%esi
801029a5:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029a8:	89 06                	mov    %eax,(%esi)
801029aa:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029ad:	89 46 04             	mov    %eax,0x4(%esi)
801029b0:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029b3:	89 46 08             	mov    %eax,0x8(%esi)
801029b6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029b9:	89 46 0c             	mov    %eax,0xc(%esi)
801029bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029bf:	89 46 10             	mov    %eax,0x10(%esi)
801029c2:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029c5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029c8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029d2:	5b                   	pop    %ebx
801029d3:	5e                   	pop    %esi
801029d4:	5f                   	pop    %edi
801029d5:	5d                   	pop    %ebp
801029d6:	c3                   	ret    
801029d7:	66 90                	xchg   %ax,%ax
801029d9:	66 90                	xchg   %ax,%ax
801029db:	66 90                	xchg   %ax,%ax
801029dd:	66 90                	xchg   %ax,%ax
801029df:	90                   	nop

801029e0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029e0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
801029e6:	85 c9                	test   %ecx,%ecx
801029e8:	0f 8e 85 00 00 00    	jle    80102a73 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029ee:	55                   	push   %ebp
801029ef:	89 e5                	mov    %esp,%ebp
801029f1:	57                   	push   %edi
801029f2:	56                   	push   %esi
801029f3:	53                   	push   %ebx
801029f4:	31 db                	xor    %ebx,%ebx
801029f6:	83 ec 0c             	sub    $0xc,%esp
801029f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a00:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102a05:	83 ec 08             	sub    $0x8,%esp
80102a08:	01 d8                	add    %ebx,%eax
80102a0a:	83 c0 01             	add    $0x1,%eax
80102a0d:	50                   	push   %eax
80102a0e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102a14:	e8 b7 d6 ff ff       	call   801000d0 <bread>
80102a19:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a1b:	58                   	pop    %eax
80102a1c:	5a                   	pop    %edx
80102a1d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102a24:	ff 35 e4 26 11 80    	pushl  0x801126e4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a2a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a2d:	e8 9e d6 ff ff       	call   801000d0 <bread>
80102a32:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a34:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a37:	83 c4 0c             	add    $0xc,%esp
80102a3a:	68 00 02 00 00       	push   $0x200
80102a3f:	50                   	push   %eax
80102a40:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a43:	50                   	push   %eax
80102a44:	e8 f7 1b 00 00       	call   80104640 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a49:	89 34 24             	mov    %esi,(%esp)
80102a4c:	e8 4f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a51:	89 3c 24             	mov    %edi,(%esp)
80102a54:	e8 87 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a59:	89 34 24             	mov    %esi,(%esp)
80102a5c:	e8 7f d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a61:	83 c4 10             	add    $0x10,%esp
80102a64:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102a6a:	7f 94                	jg     80102a00 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a6f:	5b                   	pop    %ebx
80102a70:	5e                   	pop    %esi
80102a71:	5f                   	pop    %edi
80102a72:	5d                   	pop    %ebp
80102a73:	f3 c3                	repz ret 
80102a75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
80102a83:	53                   	push   %ebx
80102a84:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a87:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102a8d:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102a93:	e8 38 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a98:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102a9e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102aa1:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102aa3:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102aa5:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102aa8:	7e 1f                	jle    80102ac9 <write_head+0x49>
80102aaa:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102ab1:	31 d2                	xor    %edx,%edx
80102ab3:	90                   	nop
80102ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102ab8:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102abe:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102ac2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ac5:	39 c2                	cmp    %eax,%edx
80102ac7:	75 ef                	jne    80102ab8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102ac9:	83 ec 0c             	sub    $0xc,%esp
80102acc:	53                   	push   %ebx
80102acd:	e8 ce d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102ad2:	89 1c 24             	mov    %ebx,(%esp)
80102ad5:	e8 06 d7 ff ff       	call   801001e0 <brelse>
}
80102ada:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102add:	c9                   	leave  
80102ade:	c3                   	ret    
80102adf:	90                   	nop

80102ae0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	53                   	push   %ebx
80102ae4:	83 ec 2c             	sub    $0x2c,%esp
80102ae7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102aea:	68 dc 75 10 80       	push   $0x801075dc
80102aef:	68 a0 26 11 80       	push   $0x801126a0
80102af4:	e8 47 18 00 00       	call   80104340 <initlock>
  readsb(dev, &sb);
80102af9:	58                   	pop    %eax
80102afa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102afd:	5a                   	pop    %edx
80102afe:	50                   	push   %eax
80102aff:	53                   	push   %ebx
80102b00:	e8 8b e8 ff ff       	call   80101390 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b05:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b08:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b0b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102b0c:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b12:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b18:	a3 d4 26 11 80       	mov    %eax,0x801126d4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b1d:	5a                   	pop    %edx
80102b1e:	50                   	push   %eax
80102b1f:	53                   	push   %ebx
80102b20:	e8 ab d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b25:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b28:	83 c4 10             	add    $0x10,%esp
80102b2b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b2d:	89 0d e8 26 11 80    	mov    %ecx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102b33:	7e 1c                	jle    80102b51 <initlog+0x71>
80102b35:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b3c:	31 d2                	xor    %edx,%edx
80102b3e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b40:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b44:	83 c2 04             	add    $0x4,%edx
80102b47:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b4d:	39 da                	cmp    %ebx,%edx
80102b4f:	75 ef                	jne    80102b40 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b51:	83 ec 0c             	sub    $0xc,%esp
80102b54:	50                   	push   %eax
80102b55:	e8 86 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b5a:	e8 81 fe ff ff       	call   801029e0 <install_trans>
  log.lh.n = 0;
80102b5f:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102b66:	00 00 00 
  write_head(); // clear the log
80102b69:	e8 12 ff ff ff       	call   80102a80 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b71:	c9                   	leave  
80102b72:	c3                   	ret    
80102b73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102b86:	68 a0 26 11 80       	push   $0x801126a0
80102b8b:	e8 d0 17 00 00       	call   80104360 <acquire>
80102b90:	83 c4 10             	add    $0x10,%esp
80102b93:	eb 18                	jmp    80102bad <begin_op+0x2d>
80102b95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b98:	83 ec 08             	sub    $0x8,%esp
80102b9b:	68 a0 26 11 80       	push   $0x801126a0
80102ba0:	68 a0 26 11 80       	push   $0x801126a0
80102ba5:	e8 e6 11 00 00       	call   80103d90 <sleep>
80102baa:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102bad:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102bb2:	85 c0                	test   %eax,%eax
80102bb4:	75 e2                	jne    80102b98 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bb6:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102bbb:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102bc1:	83 c0 01             	add    $0x1,%eax
80102bc4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102bc7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bca:	83 fa 1e             	cmp    $0x1e,%edx
80102bcd:	7f c9                	jg     80102b98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bcf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102bd2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102bd7:	68 a0 26 11 80       	push   $0x801126a0
80102bdc:	e8 5f 19 00 00       	call   80104540 <release>
      break;
    }
  }
}
80102be1:	83 c4 10             	add    $0x10,%esp
80102be4:	c9                   	leave  
80102be5:	c3                   	ret    
80102be6:	8d 76 00             	lea    0x0(%esi),%esi
80102be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bf0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102bf0:	55                   	push   %ebp
80102bf1:	89 e5                	mov    %esp,%ebp
80102bf3:	57                   	push   %edi
80102bf4:	56                   	push   %esi
80102bf5:	53                   	push   %ebx
80102bf6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102bf9:	68 a0 26 11 80       	push   $0x801126a0
80102bfe:	e8 5d 17 00 00       	call   80104360 <acquire>
  log.outstanding -= 1;
80102c03:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102c08:	8b 1d e0 26 11 80    	mov    0x801126e0,%ebx
80102c0e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c11:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102c14:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c16:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102c1b:	0f 85 23 01 00 00    	jne    80102d44 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102c21:	85 c0                	test   %eax,%eax
80102c23:	0f 85 f7 00 00 00    	jne    80102d20 <end_op+0x130>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c29:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c2c:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102c33:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c36:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c38:	68 a0 26 11 80       	push   $0x801126a0
80102c3d:	e8 fe 18 00 00       	call   80104540 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c42:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102c48:	83 c4 10             	add    $0x10,%esp
80102c4b:	85 c9                	test   %ecx,%ecx
80102c4d:	0f 8e 8a 00 00 00    	jle    80102cdd <end_op+0xed>
80102c53:	90                   	nop
80102c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c58:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102c5d:	83 ec 08             	sub    $0x8,%esp
80102c60:	01 d8                	add    %ebx,%eax
80102c62:	83 c0 01             	add    $0x1,%eax
80102c65:	50                   	push   %eax
80102c66:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102c6c:	e8 5f d4 ff ff       	call   801000d0 <bread>
80102c71:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c73:	58                   	pop    %eax
80102c74:	5a                   	pop    %edx
80102c75:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102c7c:	ff 35 e4 26 11 80    	pushl  0x801126e4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c82:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c85:	e8 46 d4 ff ff       	call   801000d0 <bread>
80102c8a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c8c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c8f:	83 c4 0c             	add    $0xc,%esp
80102c92:	68 00 02 00 00       	push   $0x200
80102c97:	50                   	push   %eax
80102c98:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c9b:	50                   	push   %eax
80102c9c:	e8 9f 19 00 00       	call   80104640 <memmove>
    bwrite(to);  // write the log
80102ca1:	89 34 24             	mov    %esi,(%esp)
80102ca4:	e8 f7 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102ca9:	89 3c 24             	mov    %edi,(%esp)
80102cac:	e8 2f d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102cb1:	89 34 24             	mov    %esi,(%esp)
80102cb4:	e8 27 d5 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102cb9:	83 c4 10             	add    $0x10,%esp
80102cbc:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102cc2:	7c 94                	jl     80102c58 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cc4:	e8 b7 fd ff ff       	call   80102a80 <write_head>
    install_trans(); // Now install writes to home locations
80102cc9:	e8 12 fd ff ff       	call   801029e0 <install_trans>
    log.lh.n = 0;
80102cce:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102cd5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cd8:	e8 a3 fd ff ff       	call   80102a80 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102cdd:	83 ec 0c             	sub    $0xc,%esp
80102ce0:	68 a0 26 11 80       	push   $0x801126a0
80102ce5:	e8 76 16 00 00       	call   80104360 <acquire>
    log.committing = 0;
    wakeup(&log);
80102cea:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102cf1:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102cf8:	00 00 00 
    wakeup(&log);
80102cfb:	e8 30 12 00 00       	call   80103f30 <wakeup>
    release(&log.lock);
80102d00:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d07:	e8 34 18 00 00       	call   80104540 <release>
80102d0c:	83 c4 10             	add    $0x10,%esp
  }
}
80102d0f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d12:	5b                   	pop    %ebx
80102d13:	5e                   	pop    %esi
80102d14:	5f                   	pop    %edi
80102d15:	5d                   	pop    %ebp
80102d16:	c3                   	ret    
80102d17:	89 f6                	mov    %esi,%esi
80102d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80102d20:	83 ec 0c             	sub    $0xc,%esp
80102d23:	68 a0 26 11 80       	push   $0x801126a0
80102d28:	e8 03 12 00 00       	call   80103f30 <wakeup>
  }
  release(&log.lock);
80102d2d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d34:	e8 07 18 00 00       	call   80104540 <release>
80102d39:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102d3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d3f:	5b                   	pop    %ebx
80102d40:	5e                   	pop    %esi
80102d41:	5f                   	pop    %edi
80102d42:	5d                   	pop    %ebp
80102d43:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d44:	83 ec 0c             	sub    $0xc,%esp
80102d47:	68 e0 75 10 80       	push   $0x801075e0
80102d4c:	e8 1f d6 ff ff       	call   80100370 <panic>
80102d51:	eb 0d                	jmp    80102d60 <log_write>
80102d53:	90                   	nop
80102d54:	90                   	nop
80102d55:	90                   	nop
80102d56:	90                   	nop
80102d57:	90                   	nop
80102d58:	90                   	nop
80102d59:	90                   	nop
80102d5a:	90                   	nop
80102d5b:	90                   	nop
80102d5c:	90                   	nop
80102d5d:	90                   	nop
80102d5e:	90                   	nop
80102d5f:	90                   	nop

80102d60 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	53                   	push   %ebx
80102d64:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d67:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d6d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d70:	83 fa 1d             	cmp    $0x1d,%edx
80102d73:	0f 8f 97 00 00 00    	jg     80102e10 <log_write+0xb0>
80102d79:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102d7e:	83 e8 01             	sub    $0x1,%eax
80102d81:	39 c2                	cmp    %eax,%edx
80102d83:	0f 8d 87 00 00 00    	jge    80102e10 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d89:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d8e:	85 c0                	test   %eax,%eax
80102d90:	0f 8e 87 00 00 00    	jle    80102e1d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d96:	83 ec 0c             	sub    $0xc,%esp
80102d99:	68 a0 26 11 80       	push   $0x801126a0
80102d9e:	e8 bd 15 00 00       	call   80104360 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102da3:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102da9:	83 c4 10             	add    $0x10,%esp
80102dac:	83 fa 00             	cmp    $0x0,%edx
80102daf:	7e 50                	jle    80102e01 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102db1:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102db4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102db6:	3b 0d ec 26 11 80    	cmp    0x801126ec,%ecx
80102dbc:	75 0b                	jne    80102dc9 <log_write+0x69>
80102dbe:	eb 38                	jmp    80102df8 <log_write+0x98>
80102dc0:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102dc7:	74 2f                	je     80102df8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102dc9:	83 c0 01             	add    $0x1,%eax
80102dcc:	39 d0                	cmp    %edx,%eax
80102dce:	75 f0                	jne    80102dc0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102dd0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102dd7:	83 c2 01             	add    $0x1,%edx
80102dda:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102de0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102de3:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102dea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ded:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102dee:	e9 4d 17 00 00       	jmp    80104540 <release>
80102df3:	90                   	nop
80102df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102df8:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80102dff:	eb df                	jmp    80102de0 <log_write+0x80>
80102e01:	8b 43 08             	mov    0x8(%ebx),%eax
80102e04:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102e09:	75 d5                	jne    80102de0 <log_write+0x80>
80102e0b:	eb ca                	jmp    80102dd7 <log_write+0x77>
80102e0d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e10:	83 ec 0c             	sub    $0xc,%esp
80102e13:	68 ef 75 10 80       	push   $0x801075ef
80102e18:	e8 53 d5 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e1d:	83 ec 0c             	sub    $0xc,%esp
80102e20:	68 05 76 10 80       	push   $0x80107605
80102e25:	e8 46 d5 ff ff       	call   80100370 <panic>
80102e2a:	66 90                	xchg   %ax,%ax
80102e2c:	66 90                	xchg   %ax,%ax
80102e2e:	66 90                	xchg   %ax,%ax

80102e30 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	83 ec 08             	sub    $0x8,%esp
  idtinit();       // load idt register
80102e36:	e8 85 2b 00 00       	call   801059c0 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102e3b:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e42:	b8 01 00 00 00       	mov    $0x1,%eax
80102e47:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102e4e:	e8 5d 0c 00 00       	call   80103ab0 <scheduler>
80102e53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e60 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e66:	e8 05 3d 00 00       	call   80106b70 <switchkvm>
  seginit();
80102e6b:	e8 20 3b 00 00       	call   80106990 <seginit>
  lapicinit();
80102e70:	e8 2b f7 ff ff       	call   801025a0 <lapicinit>
  mpmain();
80102e75:	e8 b6 ff ff ff       	call   80102e30 <mpmain>
80102e7a:	66 90                	xchg   %ax,%ax
80102e7c:	66 90                	xchg   %ax,%ax
80102e7e:	66 90                	xchg   %ax,%ax

80102e80 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102e80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e84:	83 e4 f0             	and    $0xfffffff0,%esp
80102e87:	ff 71 fc             	pushl  -0x4(%ecx)
80102e8a:	55                   	push   %ebp
80102e8b:	89 e5                	mov    %esp,%ebp
80102e8d:	53                   	push   %ebx
80102e8e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e8f:	83 ec 08             	sub    $0x8,%esp
80102e92:	68 00 00 40 80       	push   $0x80400000
80102e97:	68 28 56 11 80       	push   $0x80115628
80102e9c:	e8 cf f4 ff ff       	call   80102370 <kinit1>
  kvmalloc();      // kernel page table
80102ea1:	e8 aa 3c 00 00       	call   80106b50 <kvmalloc>
  mpinit();        // detect other processors
80102ea6:	e8 a5 01 00 00       	call   80103050 <mpinit>
  lapicinit();     // interrupt controller
80102eab:	e8 f0 f6 ff ff       	call   801025a0 <lapicinit>
  seginit();       // segment descriptors
80102eb0:	e8 db 3a 00 00       	call   80106990 <seginit>
  picinit();       // another interrupt controller
80102eb5:	e8 a6 03 00 00       	call   80103260 <picinit>
  ioapicinit();    // another interrupt controller
80102eba:	e8 d1 f2 ff ff       	call   80102190 <ioapicinit>
  consoleinit();   // console hardware
80102ebf:	e8 dc da ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102ec4:	e8 a7 2d 00 00       	call   80105c70 <uartinit>
  pinit();         // process table
80102ec9:	e8 42 09 00 00       	call   80103810 <pinit>
  tvinit();        // trap vectors
80102ece:	e8 4d 2a 00 00       	call   80105920 <tvinit>
  binit();         // buffer cache
80102ed3:	e8 68 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ed8:	e8 53 de ff ff       	call   80100d30 <fileinit>
  ideinit();       // disk
80102edd:	e8 7e f0 ff ff       	call   80101f60 <ideinit>
  if(!ismp)
80102ee2:	a1 84 27 11 80       	mov    0x80112784,%eax
80102ee7:	83 c4 10             	add    $0x10,%esp
80102eea:	85 c0                	test   %eax,%eax
80102eec:	0f 84 c5 00 00 00    	je     80102fb7 <main+0x137>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102ef2:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80102ef5:	bb a0 27 11 80       	mov    $0x801127a0,%ebx

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102efa:	68 8a 00 00 00       	push   $0x8a
80102eff:	68 8c a4 10 80       	push   $0x8010a48c
80102f04:	68 00 70 00 80       	push   $0x80007000
80102f09:	e8 32 17 00 00       	call   80104640 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f0e:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102f15:	00 00 00 
80102f18:	83 c4 10             	add    $0x10,%esp
80102f1b:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102f20:	39 d8                	cmp    %ebx,%eax
80102f22:	76 77                	jbe    80102f9b <main+0x11b>
80102f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == cpus+cpunum())  // We've started already.
80102f28:	e8 73 f7 ff ff       	call   801026a0 <cpunum>
80102f2d:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80102f33:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102f38:	39 c3                	cmp    %eax,%ebx
80102f3a:	74 46                	je     80102f82 <main+0x102>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f3c:	e8 ff f4 ff ff       	call   80102440 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f41:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80102f46:	c7 05 f8 6f 00 80 60 	movl   $0x80102e60,0x80006ff8
80102f4d:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f50:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f57:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f5a:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f5f:	0f b6 03             	movzbl (%ebx),%eax
80102f62:	83 ec 08             	sub    $0x8,%esp
80102f65:	68 00 70 00 00       	push   $0x7000
80102f6a:	50                   	push   %eax
80102f6b:	e8 00 f8 ff ff       	call   80102770 <lapicstartap>
80102f70:	83 c4 10             	add    $0x10,%esp
80102f73:	90                   	nop
80102f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f78:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80102f7e:	85 c0                	test   %eax,%eax
80102f80:	74 f6                	je     80102f78 <main+0xf8>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f82:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102f89:	00 00 00 
80102f8c:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
80102f92:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102f97:	39 c3                	cmp    %eax,%ebx
80102f99:	72 8d                	jb     80102f28 <main+0xa8>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f9b:	83 ec 08             	sub    $0x8,%esp
80102f9e:	68 00 00 00 8e       	push   $0x8e000000
80102fa3:	68 00 00 40 80       	push   $0x80400000
80102fa8:	e8 33 f4 ff ff       	call   801023e0 <kinit2>
  userinit();      // first user process
80102fad:	e8 7e 08 00 00       	call   80103830 <userinit>
  mpmain();        // finish this processor's setup
80102fb2:	e8 79 fe ff ff       	call   80102e30 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
80102fb7:	e8 04 29 00 00       	call   801058c0 <timerinit>
80102fbc:	e9 31 ff ff ff       	jmp    80102ef2 <main+0x72>
80102fc1:	66 90                	xchg   %ax,%ax
80102fc3:	66 90                	xchg   %ax,%ax
80102fc5:	66 90                	xchg   %ax,%ax
80102fc7:	66 90                	xchg   %ax,%ax
80102fc9:	66 90                	xchg   %ax,%ax
80102fcb:	66 90                	xchg   %ax,%ax
80102fcd:	66 90                	xchg   %ax,%ax
80102fcf:	90                   	nop

80102fd0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	57                   	push   %edi
80102fd4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fd5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fdb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102fdc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fdf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fe2:	39 de                	cmp    %ebx,%esi
80102fe4:	73 48                	jae    8010302e <mpsearch1+0x5e>
80102fe6:	8d 76 00             	lea    0x0(%esi),%esi
80102fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff0:	83 ec 04             	sub    $0x4,%esp
80102ff3:	8d 7e 10             	lea    0x10(%esi),%edi
80102ff6:	6a 04                	push   $0x4
80102ff8:	68 20 76 10 80       	push   $0x80107620
80102ffd:	56                   	push   %esi
80102ffe:	e8 dd 15 00 00       	call   801045e0 <memcmp>
80103003:	83 c4 10             	add    $0x10,%esp
80103006:	85 c0                	test   %eax,%eax
80103008:	75 1e                	jne    80103028 <mpsearch1+0x58>
8010300a:	8d 7e 10             	lea    0x10(%esi),%edi
8010300d:	89 f2                	mov    %esi,%edx
8010300f:	31 c9                	xor    %ecx,%ecx
80103011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103018:	0f b6 02             	movzbl (%edx),%eax
8010301b:	83 c2 01             	add    $0x1,%edx
8010301e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103020:	39 fa                	cmp    %edi,%edx
80103022:	75 f4                	jne    80103018 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103024:	84 c9                	test   %cl,%cl
80103026:	74 10                	je     80103038 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103028:	39 fb                	cmp    %edi,%ebx
8010302a:	89 fe                	mov    %edi,%esi
8010302c:	77 c2                	ja     80102ff0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010302e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103031:	31 c0                	xor    %eax,%eax
}
80103033:	5b                   	pop    %ebx
80103034:	5e                   	pop    %esi
80103035:	5f                   	pop    %edi
80103036:	5d                   	pop    %ebp
80103037:	c3                   	ret    
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303b:	89 f0                	mov    %esi,%eax
8010303d:	5b                   	pop    %ebx
8010303e:	5e                   	pop    %esi
8010303f:	5f                   	pop    %edi
80103040:	5d                   	pop    %ebp
80103041:	c3                   	ret    
80103042:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103050 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
80103055:	53                   	push   %ebx
80103056:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103059:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103060:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103067:	c1 e0 08             	shl    $0x8,%eax
8010306a:	09 d0                	or     %edx,%eax
8010306c:	c1 e0 04             	shl    $0x4,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	75 1b                	jne    8010308e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103073:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010307a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103081:	c1 e0 08             	shl    $0x8,%eax
80103084:	09 d0                	or     %edx,%eax
80103086:	c1 e0 0a             	shl    $0xa,%eax
80103089:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010308e:	ba 00 04 00 00       	mov    $0x400,%edx
80103093:	e8 38 ff ff ff       	call   80102fd0 <mpsearch1>
80103098:	85 c0                	test   %eax,%eax
8010309a:	89 c6                	mov    %eax,%esi
8010309c:	0f 84 66 01 00 00    	je     80103208 <mpinit+0x1b8>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030a2:	8b 5e 04             	mov    0x4(%esi),%ebx
801030a5:	85 db                	test   %ebx,%ebx
801030a7:	0f 84 d6 00 00 00    	je     80103183 <mpinit+0x133>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030ad:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801030b3:	83 ec 04             	sub    $0x4,%esp
801030b6:	6a 04                	push   $0x4
801030b8:	68 25 76 10 80       	push   $0x80107625
801030bd:	50                   	push   %eax
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801030c1:	e8 1a 15 00 00       	call   801045e0 <memcmp>
801030c6:	83 c4 10             	add    $0x10,%esp
801030c9:	85 c0                	test   %eax,%eax
801030cb:	0f 85 b2 00 00 00    	jne    80103183 <mpinit+0x133>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801030d1:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030d8:	3c 01                	cmp    $0x1,%al
801030da:	74 08                	je     801030e4 <mpinit+0x94>
801030dc:	3c 04                	cmp    $0x4,%al
801030de:	0f 85 9f 00 00 00    	jne    80103183 <mpinit+0x133>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030e4:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030eb:	85 ff                	test   %edi,%edi
801030ed:	74 1e                	je     8010310d <mpinit+0xbd>
801030ef:	31 d2                	xor    %edx,%edx
801030f1:	31 c0                	xor    %eax,%eax
801030f3:	90                   	nop
801030f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801030f8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801030ff:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103100:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103103:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103105:	39 c7                	cmp    %eax,%edi
80103107:	75 ef                	jne    801030f8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103109:	84 d2                	test   %dl,%dl
8010310b:	75 76                	jne    80103183 <mpinit+0x133>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
8010310d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103110:	85 ff                	test   %edi,%edi
80103112:	74 6f                	je     80103183 <mpinit+0x133>
    return;
  ismp = 1;
80103114:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
8010311b:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
8010311e:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103124:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103129:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80103130:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103136:	01 f9                	add    %edi,%ecx
80103138:	39 c8                	cmp    %ecx,%eax
8010313a:	0f 83 a0 00 00 00    	jae    801031e0 <mpinit+0x190>
    switch(*p){
80103140:	80 38 04             	cmpb   $0x4,(%eax)
80103143:	0f 87 87 00 00 00    	ja     801031d0 <mpinit+0x180>
80103149:	0f b6 10             	movzbl (%eax),%edx
8010314c:	ff 24 95 2c 76 10 80 	jmp    *-0x7fef89d4(,%edx,4)
80103153:	90                   	nop
80103154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103158:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010315b:	39 c1                	cmp    %eax,%ecx
8010315d:	77 e1                	ja     80103140 <mpinit+0xf0>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010315f:	a1 84 27 11 80       	mov    0x80112784,%eax
80103164:	85 c0                	test   %eax,%eax
80103166:	75 78                	jne    801031e0 <mpinit+0x190>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103168:	c7 05 80 2d 11 80 01 	movl   $0x1,0x80112d80
8010316f:	00 00 00 
    lapic = 0;
80103172:	c7 05 9c 26 11 80 00 	movl   $0x0,0x8011269c
80103179:	00 00 00 
    ioapicid = 0;
8010317c:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103183:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103186:	5b                   	pop    %ebx
80103187:	5e                   	pop    %esi
80103188:	5f                   	pop    %edi
80103189:	5d                   	pop    %ebp
8010318a:	c3                   	ret    
8010318b:	90                   	nop
8010318c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103190:	8b 15 80 2d 11 80    	mov    0x80112d80,%edx
80103196:	83 fa 07             	cmp    $0x7,%edx
80103199:	7f 19                	jg     801031b4 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010319b:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
8010319f:	69 fa bc 00 00 00    	imul   $0xbc,%edx,%edi
        ncpu++;
801031a5:	83 c2 01             	add    $0x1,%edx
801031a8:	89 15 80 2d 11 80    	mov    %edx,0x80112d80
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031ae:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
801031b4:	83 c0 14             	add    $0x14,%eax
      continue;
801031b7:	eb a2                	jmp    8010315b <mpinit+0x10b>
801031b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031c0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031c4:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031c7:	88 15 80 27 11 80    	mov    %dl,0x80112780
      p += sizeof(struct mpioapic);
      continue;
801031cd:	eb 8c                	jmp    8010315b <mpinit+0x10b>
801031cf:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031d0:	c7 05 84 27 11 80 00 	movl   $0x0,0x80112784
801031d7:	00 00 00 
      break;
801031da:	e9 7c ff ff ff       	jmp    8010315b <mpinit+0x10b>
801031df:	90                   	nop
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
801031e0:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801031e4:	74 9d                	je     80103183 <mpinit+0x133>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031e6:	ba 22 00 00 00       	mov    $0x22,%edx
801031eb:	b8 70 00 00 00       	mov    $0x70,%eax
801031f0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031f1:	ba 23 00 00 00       	mov    $0x23,%edx
801031f6:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031f7:	83 c8 01             	or     $0x1,%eax
801031fa:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801031fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031fe:	5b                   	pop    %ebx
801031ff:	5e                   	pop    %esi
80103200:	5f                   	pop    %edi
80103201:	5d                   	pop    %ebp
80103202:	c3                   	ret    
80103203:	90                   	nop
80103204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103208:	ba 00 00 01 00       	mov    $0x10000,%edx
8010320d:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103212:	e8 b9 fd ff ff       	call   80102fd0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103217:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103219:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010321b:	0f 85 81 fe ff ff    	jne    801030a2 <mpinit+0x52>
80103221:	e9 5d ff ff ff       	jmp    80103183 <mpinit+0x133>
80103226:	66 90                	xchg   %ax,%ax
80103228:	66 90                	xchg   %ax,%ax
8010322a:	66 90                	xchg   %ax,%ax
8010322c:	66 90                	xchg   %ax,%ax
8010322e:	66 90                	xchg   %ax,%ax

80103230 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103230:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103231:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103236:	ba 21 00 00 00       	mov    $0x21,%edx
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
8010323b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010323d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103240:	d3 c0                	rol    %cl,%eax
80103242:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
80103249:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
8010324f:	ee                   	out    %al,(%dx)
80103250:	ba a1 00 00 00       	mov    $0xa1,%edx
80103255:	66 c1 e8 08          	shr    $0x8,%ax
80103259:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
8010325a:	5d                   	pop    %ebp
8010325b:	c3                   	ret    
8010325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103260 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103260:	55                   	push   %ebp
80103261:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103266:	89 e5                	mov    %esp,%ebp
80103268:	57                   	push   %edi
80103269:	56                   	push   %esi
8010326a:	53                   	push   %ebx
8010326b:	bb 21 00 00 00       	mov    $0x21,%ebx
80103270:	89 da                	mov    %ebx,%edx
80103272:	ee                   	out    %al,(%dx)
80103273:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80103278:	89 ca                	mov    %ecx,%edx
8010327a:	ee                   	out    %al,(%dx)
8010327b:	bf 11 00 00 00       	mov    $0x11,%edi
80103280:	be 20 00 00 00       	mov    $0x20,%esi
80103285:	89 f8                	mov    %edi,%eax
80103287:	89 f2                	mov    %esi,%edx
80103289:	ee                   	out    %al,(%dx)
8010328a:	b8 20 00 00 00       	mov    $0x20,%eax
8010328f:	89 da                	mov    %ebx,%edx
80103291:	ee                   	out    %al,(%dx)
80103292:	b8 04 00 00 00       	mov    $0x4,%eax
80103297:	ee                   	out    %al,(%dx)
80103298:	b8 03 00 00 00       	mov    $0x3,%eax
8010329d:	ee                   	out    %al,(%dx)
8010329e:	bb a0 00 00 00       	mov    $0xa0,%ebx
801032a3:	89 f8                	mov    %edi,%eax
801032a5:	89 da                	mov    %ebx,%edx
801032a7:	ee                   	out    %al,(%dx)
801032a8:	b8 28 00 00 00       	mov    $0x28,%eax
801032ad:	89 ca                	mov    %ecx,%edx
801032af:	ee                   	out    %al,(%dx)
801032b0:	b8 02 00 00 00       	mov    $0x2,%eax
801032b5:	ee                   	out    %al,(%dx)
801032b6:	b8 03 00 00 00       	mov    $0x3,%eax
801032bb:	ee                   	out    %al,(%dx)
801032bc:	bf 68 00 00 00       	mov    $0x68,%edi
801032c1:	89 f2                	mov    %esi,%edx
801032c3:	89 f8                	mov    %edi,%eax
801032c5:	ee                   	out    %al,(%dx)
801032c6:	b9 0a 00 00 00       	mov    $0xa,%ecx
801032cb:	89 c8                	mov    %ecx,%eax
801032cd:	ee                   	out    %al,(%dx)
801032ce:	89 f8                	mov    %edi,%eax
801032d0:	89 da                	mov    %ebx,%edx
801032d2:	ee                   	out    %al,(%dx)
801032d3:	89 c8                	mov    %ecx,%eax
801032d5:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
801032d6:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
801032dd:	66 83 f8 ff          	cmp    $0xffff,%ax
801032e1:	74 10                	je     801032f3 <picinit+0x93>
801032e3:	ba 21 00 00 00       	mov    $0x21,%edx
801032e8:	ee                   	out    %al,(%dx)
801032e9:	ba a1 00 00 00       	mov    $0xa1,%edx
801032ee:	66 c1 e8 08          	shr    $0x8,%ax
801032f2:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
801032f3:	5b                   	pop    %ebx
801032f4:	5e                   	pop    %esi
801032f5:	5f                   	pop    %edi
801032f6:	5d                   	pop    %ebp
801032f7:	c3                   	ret    
801032f8:	66 90                	xchg   %ax,%ax
801032fa:	66 90                	xchg   %ax,%ax
801032fc:	66 90                	xchg   %ax,%ax
801032fe:	66 90                	xchg   %ax,%ax

80103300 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103300:	55                   	push   %ebp
80103301:	89 e5                	mov    %esp,%ebp
80103303:	57                   	push   %edi
80103304:	56                   	push   %esi
80103305:	53                   	push   %ebx
80103306:	83 ec 0c             	sub    $0xc,%esp
80103309:	8b 75 08             	mov    0x8(%ebp),%esi
8010330c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010330f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103315:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010331b:	e8 30 da ff ff       	call   80100d50 <filealloc>
80103320:	85 c0                	test   %eax,%eax
80103322:	89 06                	mov    %eax,(%esi)
80103324:	0f 84 a8 00 00 00    	je     801033d2 <pipealloc+0xd2>
8010332a:	e8 21 da ff ff       	call   80100d50 <filealloc>
8010332f:	85 c0                	test   %eax,%eax
80103331:	89 03                	mov    %eax,(%ebx)
80103333:	0f 84 87 00 00 00    	je     801033c0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103339:	e8 02 f1 ff ff       	call   80102440 <kalloc>
8010333e:	85 c0                	test   %eax,%eax
80103340:	89 c7                	mov    %eax,%edi
80103342:	0f 84 b0 00 00 00    	je     801033f8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103348:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010334b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103352:	00 00 00 
  p->writeopen = 1;
80103355:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010335c:	00 00 00 
  p->nwrite = 0;
8010335f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103366:	00 00 00 
  p->nread = 0;
80103369:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103370:	00 00 00 
  initlock(&p->lock, "pipe");
80103373:	68 40 76 10 80       	push   $0x80107640
80103378:	50                   	push   %eax
80103379:	e8 c2 0f 00 00       	call   80104340 <initlock>
  (*f0)->type = FD_PIPE;
8010337e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103380:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103383:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103389:	8b 06                	mov    (%esi),%eax
8010338b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010338f:	8b 06                	mov    (%esi),%eax
80103391:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103395:	8b 06                	mov    (%esi),%eax
80103397:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010339a:	8b 03                	mov    (%ebx),%eax
8010339c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033a2:	8b 03                	mov    (%ebx),%eax
801033a4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801033a8:	8b 03                	mov    (%ebx),%eax
801033aa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801033ae:	8b 03                	mov    (%ebx),%eax
801033b0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033b6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033b8:	5b                   	pop    %ebx
801033b9:	5e                   	pop    %esi
801033ba:	5f                   	pop    %edi
801033bb:	5d                   	pop    %ebp
801033bc:	c3                   	ret    
801033bd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033c0:	8b 06                	mov    (%esi),%eax
801033c2:	85 c0                	test   %eax,%eax
801033c4:	74 1e                	je     801033e4 <pipealloc+0xe4>
    fileclose(*f0);
801033c6:	83 ec 0c             	sub    $0xc,%esp
801033c9:	50                   	push   %eax
801033ca:	e8 41 da ff ff       	call   80100e10 <fileclose>
801033cf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801033d2:	8b 03                	mov    (%ebx),%eax
801033d4:	85 c0                	test   %eax,%eax
801033d6:	74 0c                	je     801033e4 <pipealloc+0xe4>
    fileclose(*f1);
801033d8:	83 ec 0c             	sub    $0xc,%esp
801033db:	50                   	push   %eax
801033dc:	e8 2f da ff ff       	call   80100e10 <fileclose>
801033e1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801033e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801033e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801033ec:	5b                   	pop    %ebx
801033ed:	5e                   	pop    %esi
801033ee:	5f                   	pop    %edi
801033ef:	5d                   	pop    %ebp
801033f0:	c3                   	ret    
801033f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033f8:	8b 06                	mov    (%esi),%eax
801033fa:	85 c0                	test   %eax,%eax
801033fc:	75 c8                	jne    801033c6 <pipealloc+0xc6>
801033fe:	eb d2                	jmp    801033d2 <pipealloc+0xd2>

80103400 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103400:	55                   	push   %ebp
80103401:	89 e5                	mov    %esp,%ebp
80103403:	56                   	push   %esi
80103404:	53                   	push   %ebx
80103405:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103408:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010340b:	83 ec 0c             	sub    $0xc,%esp
8010340e:	53                   	push   %ebx
8010340f:	e8 4c 0f 00 00       	call   80104360 <acquire>
  if(writable){
80103414:	83 c4 10             	add    $0x10,%esp
80103417:	85 f6                	test   %esi,%esi
80103419:	74 45                	je     80103460 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010341b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103421:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103424:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010342b:	00 00 00 
    wakeup(&p->nread);
8010342e:	50                   	push   %eax
8010342f:	e8 fc 0a 00 00       	call   80103f30 <wakeup>
80103434:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103437:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010343d:	85 d2                	test   %edx,%edx
8010343f:	75 0a                	jne    8010344b <pipeclose+0x4b>
80103441:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103447:	85 c0                	test   %eax,%eax
80103449:	74 35                	je     80103480 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010344b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010344e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103451:	5b                   	pop    %ebx
80103452:	5e                   	pop    %esi
80103453:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103454:	e9 e7 10 00 00       	jmp    80104540 <release>
80103459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103460:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103466:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103469:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103470:	00 00 00 
    wakeup(&p->nwrite);
80103473:	50                   	push   %eax
80103474:	e8 b7 0a 00 00       	call   80103f30 <wakeup>
80103479:	83 c4 10             	add    $0x10,%esp
8010347c:	eb b9                	jmp    80103437 <pipeclose+0x37>
8010347e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103480:	83 ec 0c             	sub    $0xc,%esp
80103483:	53                   	push   %ebx
80103484:	e8 b7 10 00 00       	call   80104540 <release>
    kfree((char*)p);
80103489:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010348c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010348f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103492:	5b                   	pop    %ebx
80103493:	5e                   	pop    %esi
80103494:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103495:	e9 f6 ed ff ff       	jmp    80102290 <kfree>
8010349a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034a0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	57                   	push   %edi
801034a4:	56                   	push   %esi
801034a5:	53                   	push   %ebx
801034a6:	83 ec 28             	sub    $0x28,%esp
801034a9:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
801034ac:	57                   	push   %edi
801034ad:	e8 ae 0e 00 00       	call   80104360 <acquire>
  for(i = 0; i < n; i++){
801034b2:	8b 45 10             	mov    0x10(%ebp),%eax
801034b5:	83 c4 10             	add    $0x10,%esp
801034b8:	85 c0                	test   %eax,%eax
801034ba:	0f 8e c6 00 00 00    	jle    80103586 <pipewrite+0xe6>
801034c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801034c3:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
801034c9:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
801034cf:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
801034d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801034d8:	03 45 10             	add    0x10(%ebp),%eax
801034db:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034de:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801034e4:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801034ea:	39 d1                	cmp    %edx,%ecx
801034ec:	0f 85 cf 00 00 00    	jne    801035c1 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
801034f2:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
801034f8:	85 d2                	test   %edx,%edx
801034fa:	0f 84 a8 00 00 00    	je     801035a8 <pipewrite+0x108>
80103500:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103507:	8b 42 24             	mov    0x24(%edx),%eax
8010350a:	85 c0                	test   %eax,%eax
8010350c:	74 25                	je     80103533 <pipewrite+0x93>
8010350e:	e9 95 00 00 00       	jmp    801035a8 <pipewrite+0x108>
80103513:	90                   	nop
80103514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103518:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
8010351e:	85 c0                	test   %eax,%eax
80103520:	0f 84 82 00 00 00    	je     801035a8 <pipewrite+0x108>
80103526:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010352c:	8b 40 24             	mov    0x24(%eax),%eax
8010352f:	85 c0                	test   %eax,%eax
80103531:	75 75                	jne    801035a8 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103533:	83 ec 0c             	sub    $0xc,%esp
80103536:	56                   	push   %esi
80103537:	e8 f4 09 00 00       	call   80103f30 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010353c:	59                   	pop    %ecx
8010353d:	58                   	pop    %eax
8010353e:	57                   	push   %edi
8010353f:	53                   	push   %ebx
80103540:	e8 4b 08 00 00       	call   80103d90 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103545:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010354b:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103551:	83 c4 10             	add    $0x10,%esp
80103554:	05 00 02 00 00       	add    $0x200,%eax
80103559:	39 c2                	cmp    %eax,%edx
8010355b:	74 bb                	je     80103518 <pipewrite+0x78>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010355d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103560:	8d 4a 01             	lea    0x1(%edx),%ecx
80103563:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80103567:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010356d:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103573:	0f b6 00             	movzbl (%eax),%eax
80103576:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
8010357a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010357d:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80103580:	0f 85 58 ff ff ff    	jne    801034de <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103586:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
8010358c:	83 ec 0c             	sub    $0xc,%esp
8010358f:	52                   	push   %edx
80103590:	e8 9b 09 00 00       	call   80103f30 <wakeup>
  release(&p->lock);
80103595:	89 3c 24             	mov    %edi,(%esp)
80103598:	e8 a3 0f 00 00       	call   80104540 <release>
  return n;
8010359d:	83 c4 10             	add    $0x10,%esp
801035a0:	8b 45 10             	mov    0x10(%ebp),%eax
801035a3:	eb 14                	jmp    801035b9 <pipewrite+0x119>
801035a5:	8d 76 00             	lea    0x0(%esi),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
801035a8:	83 ec 0c             	sub    $0xc,%esp
801035ab:	57                   	push   %edi
801035ac:	e8 8f 0f 00 00       	call   80104540 <release>
        return -1;
801035b1:	83 c4 10             	add    $0x10,%esp
801035b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801035b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035bc:	5b                   	pop    %ebx
801035bd:	5e                   	pop    %esi
801035be:	5f                   	pop    %edi
801035bf:	5d                   	pop    %ebp
801035c0:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035c1:	89 ca                	mov    %ecx,%edx
801035c3:	eb 98                	jmp    8010355d <pipewrite+0xbd>
801035c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801035d0 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
801035d5:	53                   	push   %ebx
801035d6:	83 ec 18             	sub    $0x18,%esp
801035d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035df:	53                   	push   %ebx
801035e0:	e8 7b 0d 00 00       	call   80104360 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035e5:	83 c4 10             	add    $0x10,%esp
801035e8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035ee:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801035f4:	75 6a                	jne    80103660 <piperead+0x90>
801035f6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801035fc:	85 f6                	test   %esi,%esi
801035fe:	0f 84 cc 00 00 00    	je     801036d0 <piperead+0x100>
80103604:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010360a:	eb 2d                	jmp    80103639 <piperead+0x69>
8010360c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103610:	83 ec 08             	sub    $0x8,%esp
80103613:	53                   	push   %ebx
80103614:	56                   	push   %esi
80103615:	e8 76 07 00 00       	call   80103d90 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010361a:	83 c4 10             	add    $0x10,%esp
8010361d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103623:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103629:	75 35                	jne    80103660 <piperead+0x90>
8010362b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103631:	85 d2                	test   %edx,%edx
80103633:	0f 84 97 00 00 00    	je     801036d0 <piperead+0x100>
    if(proc->killed){
80103639:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103640:	8b 4a 24             	mov    0x24(%edx),%ecx
80103643:	85 c9                	test   %ecx,%ecx
80103645:	74 c9                	je     80103610 <piperead+0x40>
      release(&p->lock);
80103647:	83 ec 0c             	sub    $0xc,%esp
8010364a:	53                   	push   %ebx
8010364b:	e8 f0 0e 00 00       	call   80104540 <release>
      return -1;
80103650:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103653:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
      return -1;
80103656:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010365b:	5b                   	pop    %ebx
8010365c:	5e                   	pop    %esi
8010365d:	5f                   	pop    %edi
8010365e:	5d                   	pop    %ebp
8010365f:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103660:	8b 45 10             	mov    0x10(%ebp),%eax
80103663:	85 c0                	test   %eax,%eax
80103665:	7e 69                	jle    801036d0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103667:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010366d:	31 c9                	xor    %ecx,%ecx
8010366f:	eb 15                	jmp    80103686 <piperead+0xb6>
80103671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103678:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010367e:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
80103684:	74 5a                	je     801036e0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103686:	8d 72 01             	lea    0x1(%edx),%esi
80103689:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010368f:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103695:	0f b6 54 13 34       	movzbl 0x34(%ebx,%edx,1),%edx
8010369a:	88 14 0f             	mov    %dl,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010369d:	83 c1 01             	add    $0x1,%ecx
801036a0:	39 4d 10             	cmp    %ecx,0x10(%ebp)
801036a3:	75 d3                	jne    80103678 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801036a5:	8d 93 38 02 00 00    	lea    0x238(%ebx),%edx
801036ab:	83 ec 0c             	sub    $0xc,%esp
801036ae:	52                   	push   %edx
801036af:	e8 7c 08 00 00       	call   80103f30 <wakeup>
  release(&p->lock);
801036b4:	89 1c 24             	mov    %ebx,(%esp)
801036b7:	e8 84 0e 00 00       	call   80104540 <release>
  return i;
801036bc:	8b 45 10             	mov    0x10(%ebp),%eax
801036bf:	83 c4 10             	add    $0x10,%esp
}
801036c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036c5:	5b                   	pop    %ebx
801036c6:	5e                   	pop    %esi
801036c7:	5f                   	pop    %edi
801036c8:	5d                   	pop    %ebp
801036c9:	c3                   	ret    
801036ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036d0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801036d7:	eb cc                	jmp    801036a5 <piperead+0xd5>
801036d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036e0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801036e3:	eb c0                	jmp    801036a5 <piperead+0xd5>
801036e5:	66 90                	xchg   %ax,%ax
801036e7:	66 90                	xchg   %ax,%ax
801036e9:	66 90                	xchg   %ax,%ax
801036eb:	66 90                	xchg   %ax,%ax
801036ed:	66 90                	xchg   %ax,%ax
801036ef:	90                   	nop

801036f0 <allocproc>:
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

//PAGEBREAK: 32
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	53                   	push   %ebx
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
801036f4:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

//PAGEBREAK: 32
801036f9:	83 ec 10             	sub    $0x10,%esp
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
801036fc:	68 a0 2d 11 80       	push   $0x80112da0
80103701:	e8 5a 0c 00 00       	call   80104360 <acquire>
80103706:	83 c4 10             	add    $0x10,%esp
80103709:	eb 14                	jmp    8010371f <allocproc+0x2f>
8010370b:	90                   	nop
8010370c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static struct proc*
allocproc(void)
80103710:	83 eb 80             	sub    $0xffffff80,%ebx
80103713:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80103719:	0f 84 81 00 00 00    	je     801037a0 <allocproc+0xb0>
{
8010371f:	8b 43 0c             	mov    0xc(%ebx),%eax
80103722:	85 c0                	test   %eax,%eax
80103724:	75 ea                	jne    80103710 <allocproc+0x20>

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80103726:	a1 08 a0 10 80       	mov    0x8010a008,%eax

  release(&ptable.lock);
  return 0;

8010372b:	83 ec 0c             	sub    $0xc,%esp
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
8010372e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
      goto found;

  release(&ptable.lock);
  return 0;

80103735:	68 a0 2d 11 80       	push   $0x80112da0

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
8010373a:	c7 43 7c 14 00 00 00 	movl   $0x14,0x7c(%ebx)

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80103741:	8d 50 01             	lea    0x1(%eax),%edx
80103744:	89 43 10             	mov    %eax,0x10(%ebx)
80103747:	89 15 08 a0 10 80    	mov    %edx,0x8010a008

  release(&ptable.lock);
  return 0;

8010374d:	e8 ee 0d 00 00       	call   80104540 <release>
found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103752:	e8 e9 ec ff ff       	call   80102440 <kalloc>
80103757:	83 c4 10             	add    $0x10,%esp
8010375a:	85 c0                	test   %eax,%eax
8010375c:	89 43 08             	mov    %eax,0x8(%ebx)
8010375f:	74 56                	je     801037b7 <allocproc+0xc7>
  p->accticks=0;
	p->cntshed=0;

  release(&ptable.lock);

  // Allocate kernel stack.
80103761:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

80103767:	83 ec 04             	sub    $0x4,%esp
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010376a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->accticks=0;
	p->cntshed=0;

  release(&ptable.lock);

  // Allocate kernel stack.
8010376f:	89 53 18             	mov    %edx,0x18(%ebx)
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

80103772:	c7 40 14 0e 59 10 80 	movl   $0x8010590e,0x14(%eax)
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

80103779:	6a 14                	push   $0x14
8010377b:	6a 00                	push   $0x0
8010377d:	50                   	push   %eax
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;
8010377e:	89 43 1c             	mov    %eax,0x1c(%ebx)

80103781:	e8 0a 0e 00 00       	call   80104590 <memset>
  // Set up new context to start executing at forkret,
80103786:	8b 43 1c             	mov    0x1c(%ebx),%eax
  // which returns to trapret.
  sp -= 4;
80103789:	83 c4 10             	add    $0x10,%esp

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
8010378c:	c7 40 10 c0 37 10 80 	movl   $0x801037c0,0x10(%eax)
  // which returns to trapret.
  sp -= 4;
80103793:	89 d8                	mov    %ebx,%eax
  *(uint*)sp = (uint)trapret;
80103795:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103798:	c9                   	leave  
80103799:	c3                   	ret    
8010379a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

801037a0:	83 ec 0c             	sub    $0xc,%esp
801037a3:	68 a0 2d 11 80       	push   $0x80112da0
801037a8:	e8 93 0d 00 00       	call   80104540 <release>
  acquire(&ptable.lock);
801037ad:	83 c4 10             	add    $0x10,%esp
801037b0:	31 c0                	xor    %eax,%eax
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801037b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037b5:	c9                   	leave  
801037b6:	c3                   	ret    
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
	p->niceness=0;
801037b7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  p->accticks=0;
801037be:	eb d5                	jmp    80103795 <allocproc+0xa5>

801037c0 <forkret>:
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  proc->state = RUNNABLE;
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	83 ec 14             	sub    $0x14,%esp
  sched();
  release(&ptable.lock);
}
801037c6:	68 a0 2d 11 80       	push   $0x80112da0
801037cb:	e8 70 0d 00 00       	call   80104540 <release>

// A fork child's very first scheduling by scheduler()
801037d0:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801037d5:	83 c4 10             	add    $0x10,%esp
801037d8:	85 c0                	test   %eax,%eax
801037da:	75 04                	jne    801037e0 <forkret+0x20>
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
801037dc:	c9                   	leave  
801037dd:	c3                   	ret    
801037de:	66 90                	xchg   %ax,%ax
// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
801037e0:	83 ec 0c             	sub    $0xc,%esp

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801037e3:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
801037ea:	00 00 00 
  static int first = 1;
801037ed:	6a 01                	push   $0x1
801037ef:	e8 5c dc ff ff       	call   80101450 <iinit>
  // Still holding ptable.lock from scheduler.
801037f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037fb:	e8 e0 f2 ff ff       	call   80102ae0 <initlog>
80103800:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
80103803:	c9                   	leave  
80103804:	c3                   	ret    
80103805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103810 <pinit>:
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	83 ec 10             	sub    $0x10,%esp
extern void trapret(void);
80103816:	68 45 76 10 80       	push   $0x80107645
8010381b:	68 a0 2d 11 80       	push   $0x80112da0
80103820:	e8 1b 0b 00 00       	call   80104340 <initlock>

80103825:	83 c4 10             	add    $0x10,%esp
80103828:	c9                   	leave  
80103829:	c3                   	ret    
8010382a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103830 <userinit>:

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	53                   	push   %ebx
80103834:	83 ec 04             	sub    $0x4,%esp
  return p;
}

//PAGEBREAK: 32
80103837:	e8 b4 fe ff ff       	call   801036f0 <allocproc>
8010383c:	89 c3                	mov    %eax,%ebx
// Set up first user process.
void
8010383e:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
userinit(void)
80103843:	e8 98 32 00 00       	call   80106ae0 <setupkvm>
80103848:	85 c0                	test   %eax,%eax
8010384a:	89 43 04             	mov    %eax,0x4(%ebx)
8010384d:	0f 84 bd 00 00 00    	je     80103910 <userinit+0xe0>
{
  struct proc *p;
80103853:	83 ec 04             	sub    $0x4,%esp
80103856:	68 2c 00 00 00       	push   $0x2c
8010385b:	68 60 a4 10 80       	push   $0x8010a460
80103860:	50                   	push   %eax
80103861:	e8 fa 33 00 00       	call   80106c60 <inituvm>
  extern char _binary_initcode_start[], _binary_initcode_size[];

80103866:	83 c4 0c             	add    $0xc,%esp
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
80103869:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)

8010386f:	6a 4c                	push   $0x4c
80103871:	6a 00                	push   $0x0
80103873:	ff 73 18             	pushl  0x18(%ebx)
80103876:	e8 15 0d 00 00       	call   80104590 <memset>
  p = allocproc();
8010387b:	8b 43 18             	mov    0x18(%ebx),%eax
8010387e:	ba 23 00 00 00       	mov    $0x23,%edx
  
80103883:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103888:	83 c4 0c             	add    $0xc,%esp
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
8010388b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  
8010388f:	8b 43 18             	mov    0x18(%ebx),%eax
80103892:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  initproc = p;
80103896:	8b 43 18             	mov    0x18(%ebx),%eax
80103899:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010389d:	66 89 50 28          	mov    %dx,0x28(%eax)
  if((p->pgdir = setupkvm()) == 0)
801038a1:	8b 43 18             	mov    0x18(%ebx),%eax
801038a4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038a8:	66 89 50 48          	mov    %dx,0x48(%eax)
    panic("userinit: out of memory?");
801038ac:	8b 43 18             	mov    0x18(%ebx),%eax
801038af:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038b6:	8b 43 18             	mov    0x18(%ebx),%eax
801038b9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->sz = PGSIZE;
801038c0:	8b 43 18             	mov    0x18(%ebx),%eax
801038c3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038ca:	8d 43 6c             	lea    0x6c(%ebx),%eax
801038cd:	6a 10                	push   $0x10
801038cf:	68 65 76 10 80       	push   $0x80107665
801038d4:	50                   	push   %eax
801038d5:	e8 b6 0e 00 00       	call   80104790 <safestrcpy>
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038da:	c7 04 24 6e 76 10 80 	movl   $0x8010766e,(%esp)
801038e1:	e8 6a e5 ff ff       	call   80101e50 <namei>
801038e6:	89 43 68             	mov    %eax,0x68(%ebx)
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

801038e9:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801038f0:	e8 6b 0a 00 00       	call   80104360 <acquire>
  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
801038f5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  // this assignment to p->state lets other cores
801038fc:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103903:	e8 38 0c 00 00       	call   80104540 <release>
  // run this process. the acquire forces the above
80103908:	83 c4 10             	add    $0x10,%esp
8010390b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010390e:	c9                   	leave  
8010390f:	c3                   	ret    

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103910:	83 ec 0c             	sub    $0xc,%esp
80103913:	68 4c 76 10 80       	push   $0x8010764c
80103918:	e8 53 ca ff ff       	call   80100370 <panic>
8010391d:	8d 76 00             	lea    0x0(%esi),%esi

80103920 <growproc>:
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 08             	sub    $0x8,%esp
  release(&ptable.lock);
}

80103926:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

8010392d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  release(&ptable.lock);
}

80103930:	8b 02                	mov    (%edx),%eax
// Grow current process's memory by n bytes.
80103932:	83 f9 00             	cmp    $0x0,%ecx
80103935:	7e 39                	jle    80103970 <growproc+0x50>
// Return 0 on success, -1 on failure.
80103937:	83 ec 04             	sub    $0x4,%esp
8010393a:	01 c1                	add    %eax,%ecx
8010393c:	51                   	push   %ecx
8010393d:	50                   	push   %eax
8010393e:	ff 72 04             	pushl  0x4(%edx)
80103941:	e8 5a 34 00 00       	call   80106da0 <allocuvm>
80103946:	83 c4 10             	add    $0x10,%esp
80103949:	85 c0                	test   %eax,%eax
8010394b:	74 3b                	je     80103988 <growproc+0x68>
8010394d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
int
growproc(int n)
{
  uint sz;

  sz = proc->sz;
80103954:	89 02                	mov    %eax,(%edx)
  if(n > 0){
80103956:	83 ec 0c             	sub    $0xc,%esp
80103959:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103960:	e8 2b 32 00 00       	call   80106b90 <switchuvm>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103965:	83 c4 10             	add    $0x10,%esp
80103968:	31 c0                	xor    %eax,%eax
      return -1;
8010396a:	c9                   	leave  
8010396b:	c3                   	ret    
8010396c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
80103970:	74 e2                	je     80103954 <growproc+0x34>
{
80103972:	83 ec 04             	sub    $0x4,%esp
80103975:	01 c1                	add    %eax,%ecx
80103977:	51                   	push   %ecx
80103978:	50                   	push   %eax
80103979:	ff 72 04             	pushl  0x4(%edx)
8010397c:	e8 1f 35 00 00       	call   80106ea0 <deallocuvm>
80103981:	83 c4 10             	add    $0x10,%esp
80103984:	85 c0                	test   %eax,%eax
80103986:	75 c5                	jne    8010394d <growproc+0x2d>
  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
80103988:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
8010398d:	c9                   	leave  
8010398e:	c3                   	ret    
8010398f:	90                   	nop

80103990 <fork>:
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	57                   	push   %edi
80103994:	56                   	push   %esi
80103995:	53                   	push   %ebx
80103996:	83 ec 0c             	sub    $0xc,%esp
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
80103999:	e8 52 fd ff ff       	call   801036f0 <allocproc>
8010399e:	85 c0                	test   %eax,%eax
801039a0:	0f 84 d6 00 00 00    	je     80103a7c <fork+0xec>
801039a6:	89 c3                	mov    %eax,%ebx
int
fork(void)
{
  int i, pid;
  struct proc *np;
801039a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801039ae:	83 ec 08             	sub    $0x8,%esp
801039b1:	ff 30                	pushl  (%eax)
801039b3:	ff 70 04             	pushl  0x4(%eax)
801039b6:	e8 c5 35 00 00       	call   80106f80 <copyuvm>
801039bb:	83 c4 10             	add    $0x10,%esp
801039be:	85 c0                	test   %eax,%eax
801039c0:	89 43 04             	mov    %eax,0x4(%ebx)
801039c3:	0f 84 ba 00 00 00    	je     80103a83 <fork+0xf3>

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

801039c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801039cf:	8b 7b 18             	mov    0x18(%ebx),%edi
801039d2:	b9 13 00 00 00       	mov    $0x13,%ecx

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

801039d7:	8b 00                	mov    (%eax),%eax
801039d9:	89 03                	mov    %eax,(%ebx)
  // Copy process state from p.
801039db:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801039e1:	89 43 14             	mov    %eax,0x14(%ebx)
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801039e4:	8b 70 18             	mov    0x18(%eax),%esi
801039e7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
801039e9:	31 f6                	xor    %esi,%esi

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
801039eb:	8b 43 18             	mov    0x18(%ebx),%eax
801039ee:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801039f5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801039fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  }
  np->sz = proc->sz;
80103a00:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103a04:	85 c0                	test   %eax,%eax
80103a06:	74 17                	je     80103a1f <fork+0x8f>
  np->parent = proc;
80103a08:	83 ec 0c             	sub    $0xc,%esp
80103a0b:	50                   	push   %eax
80103a0c:	e8 af d3 ff ff       	call   80100dc0 <filedup>
80103a11:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103a15:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a1c:	83 c4 10             	add    $0x10,%esp
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
80103a1f:	83 c6 01             	add    $0x1,%esi
80103a22:	83 fe 10             	cmp    $0x10,%esi
80103a25:	75 d9                	jne    80103a00 <fork+0x70>
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;
80103a27:	83 ec 0c             	sub    $0xc,%esp
80103a2a:	ff 72 68             	pushl  0x68(%edx)
80103a2d:	e8 be db ff ff       	call   801015f0 <idup>
80103a32:	89 43 68             	mov    %eax,0x68(%ebx)

  // Clear %eax so that fork returns 0 in the child.
80103a35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a3b:	83 c4 0c             	add    $0xc,%esp
80103a3e:	6a 10                	push   $0x10
80103a40:	83 c0 6c             	add    $0x6c,%eax
80103a43:	50                   	push   %eax
80103a44:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a47:	50                   	push   %eax
80103a48:	e8 43 0d 00 00       	call   80104790 <safestrcpy>
  np->tf->eax = 0;

80103a4d:	8b 73 10             	mov    0x10(%ebx),%esi
  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
80103a50:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a57:	e8 04 09 00 00       	call   80104360 <acquire>
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80103a5c:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103a63:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a6a:	e8 d1 0a 00 00       	call   80104540 <release>

  pid = np->pid;
80103a6f:	83 c4 10             	add    $0x10,%esp
80103a72:	89 f0                	mov    %esi,%eax

80103a74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a77:	5b                   	pop    %ebx
80103a78:	5e                   	pop    %esi
80103a79:	5f                   	pop    %edi
80103a7a:	5d                   	pop    %ebp
80103a7b:	c3                   	ret    
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
80103a7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a81:	eb f1                	jmp    80103a74 <fork+0xe4>
fork(void)
{
  int i, pid;
  struct proc *np;

80103a83:	83 ec 0c             	sub    $0xc,%esp
80103a86:	ff 73 08             	pushl  0x8(%ebx)
80103a89:	e8 02 e8 ff ff       	call   80102290 <kfree>
  // Allocate process.
80103a8e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  if((np = allocproc()) == 0){
80103a95:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103a9c:	83 c4 10             	add    $0x10,%esp
80103a9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103aa4:	eb ce                	jmp    80103a74 <fork+0xe4>
80103aa6:	8d 76 00             	lea    0x0(%esi),%esi
80103aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ab0 <scheduler>:
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	53                   	push   %ebx
80103ab4:	83 ec 04             	sub    $0x4,%esp
80103ab7:	89 f6                	mov    %esi,%esi
80103ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103ac0:	fb                   	sti    
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103ac1:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
80103ac4:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103ac9:	68 a0 2d 11 80       	push   $0x80112da0
80103ace:	e8 8d 08 00 00       	call   80104360 <acquire>
80103ad3:	83 c4 10             	add    $0x10,%esp
80103ad6:	eb 13                	jmp    80103aeb <scheduler+0x3b>
80103ad8:	90                   	nop
80103ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *p;
80103ae0:	83 eb 80             	sub    $0xffffff80,%ebx
80103ae3:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80103ae9:	74 55                	je     80103b40 <scheduler+0x90>

80103aeb:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103aef:	75 ef                	jne    80103ae0 <scheduler+0x30>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103af1:	83 ec 0c             	sub    $0xc,%esp
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103af4:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103afb:	53                   	push   %ebx
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
80103afc:	83 eb 80             	sub    $0xffffff80,%ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103aff:	e8 8c 30 00 00       	call   80106b90 <switchuvm>
      if(p->state != RUNNABLE)
        continue;
80103b04:	58                   	pop    %eax
80103b05:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
80103b0b:	c7 43 8c 04 00 00 00 	movl   $0x4,-0x74(%ebx)
        continue;
80103b12:	5a                   	pop    %edx
80103b13:	ff 73 9c             	pushl  -0x64(%ebx)
80103b16:	83 c0 04             	add    $0x4,%eax
80103b19:	50                   	push   %eax
80103b1a:	e8 cc 0c 00 00       	call   801047eb <swtch>

80103b1f:	e8 4c 30 00 00       	call   80106b70 <switchkvm>
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80103b24:	83 c4 10             	add    $0x10,%esp
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
80103b27:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80103b2d:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103b34:	00 00 00 00 
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
80103b38:	75 b1                	jne    80103aeb <scheduler+0x3b>
80103b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103b40:	83 ec 0c             	sub    $0xc,%esp
80103b43:	68 a0 2d 11 80       	push   $0x80112da0
80103b48:	e8 f3 09 00 00       	call   80104540 <release>
      swtch(&cpu->scheduler, p->context);
80103b4d:	83 c4 10             	add    $0x10,%esp
80103b50:	e9 6b ff ff ff       	jmp    80103ac0 <scheduler+0x10>
80103b55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b60 <sched>:
    release(&ptable.lock);

  }
}

// Enter scheduler.  Must hold only ptable.lock
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	53                   	push   %ebx
80103b64:	83 ec 10             	sub    $0x10,%esp
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
80103b67:	68 a0 2d 11 80       	push   $0x80112da0
80103b6c:	e8 1f 09 00 00       	call   80104490 <holding>
80103b71:	83 c4 10             	add    $0x10,%esp
80103b74:	85 c0                	test   %eax,%eax
80103b76:	74 4c                	je     80103bc4 <sched+0x64>
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
80103b78:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103b7f:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103b86:	75 63                	jne    80103beb <sched+0x8b>
// there's no process.
void
80103b88:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103b8e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103b92:	74 4a                	je     80103bde <sched+0x7e>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b94:	9c                   	pushf  
80103b95:	59                   	pop    %ecx
sched(void)
{
80103b96:	80 e5 02             	and    $0x2,%ch
80103b99:	75 36                	jne    80103bd1 <sched+0x71>
  int intena;

  if(!holding(&ptable.lock))
80103b9b:	83 ec 08             	sub    $0x8,%esp
80103b9e:	83 c0 1c             	add    $0x1c,%eax
// there's no process.
void
sched(void)
{
  int intena;

80103ba1:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  if(!holding(&ptable.lock))
80103ba7:	ff 72 04             	pushl  0x4(%edx)
80103baa:	50                   	push   %eax
80103bab:	e8 3b 0c 00 00       	call   801047eb <swtch>
    panic("sched ptable.lock");
80103bb0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  if(cpu->ncli != 1)
80103bb6:	83 c4 10             	add    $0x10,%esp
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103bb9:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
  if(cpu->ncli != 1)
80103bbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bc2:	c9                   	leave  
80103bc3:	c3                   	ret    

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
80103bc4:	83 ec 0c             	sub    $0xc,%esp
80103bc7:	68 70 76 10 80       	push   $0x80107670
80103bcc:	e8 9f c7 ff ff       	call   80100370 <panic>
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
80103bd1:	83 ec 0c             	sub    $0xc,%esp
80103bd4:	68 9c 76 10 80       	push   $0x8010769c
80103bd9:	e8 92 c7 ff ff       	call   80100370 <panic>
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
80103bde:	83 ec 0c             	sub    $0xc,%esp
80103be1:	68 8e 76 10 80       	push   $0x8010768e
80103be6:	e8 85 c7 ff ff       	call   80100370 <panic>
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
80103beb:	83 ec 0c             	sub    $0xc,%esp
80103bee:	68 82 76 10 80       	push   $0x80107682
80103bf3:	e8 78 c7 ff ff       	call   80100370 <panic>
80103bf8:	90                   	nop
80103bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c00 <exit>:

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
80103c00:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c07:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
80103c0d:	55                   	push   %ebp
80103c0e:	89 e5                	mov    %esp,%ebp
80103c10:	56                   	push   %esi
80103c11:	53                   	push   %ebx
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
80103c12:	0f 84 1f 01 00 00    	je     80103d37 <exit+0x137>
80103c18:	31 db                	xor    %ebx,%ebx
80103c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *p;
80103c20:	8d 73 08             	lea    0x8(%ebx),%esi
80103c23:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103c27:	85 c0                	test   %eax,%eax
80103c29:	74 1b                	je     80103c46 <exit+0x46>
  int fd;
80103c2b:	83 ec 0c             	sub    $0xc,%esp
80103c2e:	50                   	push   %eax
80103c2f:	e8 dc d1 ff ff       	call   80100e10 <fileclose>

80103c34:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c3b:	83 c4 10             	add    $0x10,%esp
80103c3e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103c45:	00 
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c46:	83 c3 01             	add    $0x1,%ebx
80103c49:	83 fb 10             	cmp    $0x10,%ebx
80103c4c:	75 d2                	jne    80103c20 <exit+0x20>
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
80103c4e:	e8 2d ef ff ff       	call   80102b80 <begin_op>
  for(fd = 0; fd < NOFILE; fd++){
80103c53:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c59:	83 ec 0c             	sub    $0xc,%esp
80103c5c:	ff 70 68             	pushl  0x68(%eax)
80103c5f:	e8 ec da ff ff       	call   80101750 <iput>
    if(proc->ofile[fd]){
80103c64:	e8 87 ef ff ff       	call   80102bf0 <end_op>
      fileclose(proc->ofile[fd]);
80103c69:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c6f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
      proc->ofile[fd] = 0;
    }
80103c76:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103c7d:	e8 de 06 00 00       	call   80104360 <acquire>
  }

  begin_op();
80103c82:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103c89:	83 c4 10             	add    $0x10,%esp
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

80103c8c:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80103c91:	8b 51 14             	mov    0x14(%ecx),%edx
80103c94:	eb 14                	jmp    80103caa <exit+0xaa>
80103c96:	8d 76 00             	lea    0x0(%esi),%esi
80103c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

80103ca0:	83 e8 80             	sub    $0xffffff80,%eax
80103ca3:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103ca8:	74 1c                	je     80103cc6 <exit+0xc6>
//PAGEBREAK!
80103caa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103cae:	75 f0                	jne    80103ca0 <exit+0xa0>
80103cb0:	3b 50 20             	cmp    0x20(%eax),%edx
80103cb3:	75 eb                	jne    80103ca0 <exit+0xa0>
// Wake up all processes sleeping on chan.
80103cb5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

80103cbc:	83 e8 80             	sub    $0xffffff80,%eax
80103cbf:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103cc4:	75 e4                	jne    80103caa <exit+0xaa>
  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);
80103cc6:	8b 1d bc a5 10 80    	mov    0x8010a5bc,%ebx
80103ccc:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103cd1:	eb 10                	jmp    80103ce3 <exit+0xe3>
80103cd3:	90                   	nop
80103cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;
80103cd8:	83 ea 80             	sub    $0xffffff80,%edx
80103cdb:	81 fa d4 4d 11 80    	cmp    $0x80114dd4,%edx
80103ce1:	74 3b                	je     80103d1e <exit+0x11e>

80103ce3:	3b 4a 14             	cmp    0x14(%edx),%ecx
80103ce6:	75 f0                	jne    80103cd8 <exit+0xd8>
  acquire(&ptable.lock);

80103ce8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);
80103cec:	89 5a 14             	mov    %ebx,0x14(%edx)

80103cef:	75 e7                	jne    80103cd8 <exit+0xd8>
80103cf1:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103cf6:	eb 12                	jmp    80103d0a <exit+0x10a>
80103cf8:	90                   	nop
80103cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

80103d00:	83 e8 80             	sub    $0xffffff80,%eax
80103d03:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103d08:	74 ce                	je     80103cd8 <exit+0xd8>
//PAGEBREAK!
80103d0a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d0e:	75 f0                	jne    80103d00 <exit+0x100>
80103d10:	3b 58 20             	cmp    0x20(%eax),%ebx
80103d13:	75 eb                	jne    80103d00 <exit+0x100>
// Wake up all processes sleeping on chan.
80103d15:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d1c:	eb e2                	jmp    80103d00 <exit+0x100>
  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
80103d1e:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
      p->parent = initproc;
80103d25:	e8 36 fe ff ff       	call   80103b60 <sched>
      if(p->state == ZOMBIE)
80103d2a:	83 ec 0c             	sub    $0xc,%esp
80103d2d:	68 bd 76 10 80       	push   $0x801076bd
80103d32:	e8 39 c6 ff ff       	call   80100370 <panic>
  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
80103d37:	83 ec 0c             	sub    $0xc,%esp
80103d3a:	68 b0 76 10 80       	push   $0x801076b0
80103d3f:	e8 2c c6 ff ff       	call   80100370 <panic>
80103d44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103d50 <yield>:
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	83 ec 14             	sub    $0x14,%esp
  intena = cpu->intena;
80103d56:	68 a0 2d 11 80       	push   $0x80112da0
80103d5b:	e8 00 06 00 00       	call   80104360 <acquire>
  swtch(&proc->context, cpu->scheduler);
80103d60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d66:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  cpu->intena = intena;
80103d6d:	e8 ee fd ff ff       	call   80103b60 <sched>
}
80103d72:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d79:	e8 c2 07 00 00       	call   80104540 <release>

80103d7e:	83 c4 10             	add    $0x10,%esp
80103d81:	c9                   	leave  
80103d82:	c3                   	ret    
80103d83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d90 <sleep>:
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

80103d90:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }
80103d96:	55                   	push   %ebp
80103d97:	89 e5                	mov    %esp,%ebp
80103d99:	56                   	push   %esi
80103d9a:	53                   	push   %ebx

80103d9b:	85 c0                	test   %eax,%eax
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }
80103d9d:	8b 75 08             	mov    0x8(%ebp),%esi
80103da0:	8b 5d 0c             	mov    0xc(%ebp),%ebx

80103da3:	0f 84 97 00 00 00    	je     80103e40 <sleep+0xb0>
  // Return to "caller", actually trapret (see allocproc).
}

80103da9:	85 db                	test   %ebx,%ebx
80103dab:	0f 84 82 00 00 00    	je     80103e33 <sleep+0xa3>
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
80103db1:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103db7:	74 57                	je     80103e10 <sleep+0x80>
    panic("sleep without lk");
80103db9:	83 ec 0c             	sub    $0xc,%esp
80103dbc:	68 a0 2d 11 80       	push   $0x80112da0
80103dc1:	e8 9a 05 00 00       	call   80104360 <acquire>

80103dc6:	89 1c 24             	mov    %ebx,(%esp)
80103dc9:	e8 72 07 00 00       	call   80104540 <release>
  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
80103dce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103dd4:	89 70 20             	mov    %esi,0x20(%eax)
  // (wakeup runs with ptable.lock locked),
80103dd7:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  // so it's okay to release lk.
80103dde:	e8 7d fd ff ff       	call   80103b60 <sched>
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
80103de3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103de9:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  }

  // Go to sleep.
  proc->chan = chan;
80103df0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103df7:	e8 44 07 00 00       	call   80104540 <release>
  proc->state = SLEEPING;
80103dfc:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103dff:	83 c4 10             	add    $0x10,%esp
  sched();

80103e02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e05:	5b                   	pop    %ebx
80103e06:	5e                   	pop    %esi
80103e07:	5d                   	pop    %ebp
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  proc->state = SLEEPING;
80103e08:	e9 53 05 00 00       	jmp    80104360 <acquire>
80103e0d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
80103e10:	89 70 20             	mov    %esi,0x20(%eax)
  // (wakeup runs with ptable.lock locked),
80103e13:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  // so it's okay to release lk.
80103e1a:	e8 41 fd ff ff       	call   80103b60 <sched>
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
80103e1f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e25:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Go to sleep.
  proc->chan = chan;
  proc->state = SLEEPING;
  sched();

80103e2c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e2f:	5b                   	pop    %ebx
80103e30:	5e                   	pop    %esi
80103e31:	5d                   	pop    %ebp
80103e32:	c3                   	ret    
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
80103e33:	83 ec 0c             	sub    $0xc,%esp
80103e36:	68 cf 76 10 80       	push   $0x801076cf
80103e3b:	e8 30 c5 ff ff       	call   80100370 <panic>
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
80103e40:	83 ec 0c             	sub    $0xc,%esp
80103e43:	68 c9 76 10 80       	push   $0x801076c9
80103e48:	e8 23 c5 ff ff       	call   80100370 <panic>
80103e4d:	8d 76 00             	lea    0x0(%esi),%esi

80103e50 <wait>:
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	56                   	push   %esi
80103e54:	53                   	push   %ebx
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
80103e55:	83 ec 0c             	sub    $0xc,%esp
80103e58:	68 a0 2d 11 80       	push   $0x80112da0
80103e5d:	e8 fe 04 00 00       	call   80104360 <acquire>
80103e62:	83 c4 10             	add    $0x10,%esp
80103e65:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Return -1 if this process has no children.
int
wait(void)
80103e6b:	31 d2                	xor    %edx,%edx
{
80103e6d:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103e72:	eb 0f                	jmp    80103e83 <wait+0x33>
80103e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e78:	83 eb 80             	sub    $0xffffff80,%ebx
80103e7b:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80103e81:	74 1d                	je     80103ea0 <wait+0x50>
  struct proc *p;
80103e83:	3b 43 14             	cmp    0x14(%ebx),%eax
80103e86:	75 f0                	jne    80103e78 <wait+0x28>
  int havekids, pid;

  acquire(&ptable.lock);
80103e88:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e8c:	74 30                	je     80103ebe <wait+0x6e>

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103e8e:	83 eb 80             	sub    $0xffffff80,%ebx
  struct proc *p;
  int havekids, pid;

80103e91:	ba 01 00 00 00       	mov    $0x1,%edx

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103e96:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80103e9c:	75 e5                	jne    80103e83 <wait+0x33>
80103e9e:	66 90                	xchg   %ax,%ax
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
80103ea0:	85 d2                	test   %edx,%edx
80103ea2:	74 70                	je     80103f14 <wait+0xc4>
80103ea4:	8b 50 24             	mov    0x24(%eax),%edx
80103ea7:	85 d2                	test   %edx,%edx
80103ea9:	75 69                	jne    80103f14 <wait+0xc4>
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

80103eab:	83 ec 08             	sub    $0x8,%esp
80103eae:	68 a0 2d 11 80       	push   $0x80112da0
80103eb3:	50                   	push   %eax
80103eb4:	e8 d7 fe ff ff       	call   80103d90 <sleep>
    // No point waiting if we don't have any children.
80103eb9:	83 c4 10             	add    $0x10,%esp
80103ebc:	eb a7                	jmp    80103e65 <wait+0x15>
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103ebe:	83 ec 0c             	sub    $0xc,%esp
80103ec1:	ff 73 08             	pushl  0x8(%ebx)
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
80103ec4:	8b 73 10             	mov    0x10(%ebx),%esi
    havekids = 0;
80103ec7:	e8 c4 e3 ff ff       	call   80102290 <kfree>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
80103ecc:	59                   	pop    %ecx
80103ecd:	ff 73 04             	pushl  0x4(%ebx)

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ed0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
      if(p->parent != proc)
80103ed7:	e8 f4 2f 00 00       	call   80106ed0 <freevm>
        continue;
80103edc:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
      havekids = 1;
80103ee3:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
      if(p->state == ZOMBIE){
80103eea:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        // Found one.
80103eee:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        pid = p->pid;
80103ef5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        kfree(p->kstack);
80103efc:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103f03:	e8 38 06 00 00       	call   80104540 <release>
        p->kstack = 0;
80103f08:	83 c4 10             	add    $0x10,%esp
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103f0b:	8d 65 f8             	lea    -0x8(%ebp),%esp
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103f0e:	89 f0                	mov    %esi,%eax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103f10:	5b                   	pop    %ebx
80103f11:	5e                   	pop    %esi
80103f12:	5d                   	pop    %ebp
80103f13:	c3                   	ret    
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
80103f14:	83 ec 0c             	sub    $0xc,%esp
80103f17:	68 a0 2d 11 80       	push   $0x80112da0
80103f1c:	e8 1f 06 00 00       	call   80104540 <release>
        release(&ptable.lock);
80103f21:	83 c4 10             	add    $0x10,%esp
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103f24:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
80103f27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103f2c:	5b                   	pop    %ebx
80103f2d:	5e                   	pop    %esi
80103f2e:	5d                   	pop    %ebp
80103f2f:	c3                   	ret    

80103f30 <wakeup>:
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	53                   	push   %ebx
80103f34:	83 ec 10             	sub    $0x10,%esp
80103f37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f3a:	68 a0 2d 11 80       	push   $0x80112da0
80103f3f:	e8 1c 04 00 00       	call   80104360 <acquire>
80103f44:	83 c4 10             	add    $0x10,%esp
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

80103f47:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103f4c:	eb 0c                	jmp    80103f5a <wakeup+0x2a>
80103f4e:	66 90                	xchg   %ax,%ax
80103f50:	83 e8 80             	sub    $0xffffff80,%eax
80103f53:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103f58:	74 1c                	je     80103f76 <wakeup+0x46>
//PAGEBREAK!
80103f5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f5e:	75 f0                	jne    80103f50 <wakeup+0x20>
80103f60:	3b 58 20             	cmp    0x20(%eax),%ebx
80103f63:	75 eb                	jne    80103f50 <wakeup+0x20>
// Wake up all processes sleeping on chan.
80103f65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

80103f6c:	83 e8 80             	sub    $0xffffff80,%eax
80103f6f:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103f74:	75 e4                	jne    80103f5a <wakeup+0x2a>
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
80103f76:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
80103f7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f80:	c9                   	leave  
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
80103f81:	e9 ba 05 00 00       	jmp    80104540 <release>
80103f86:	8d 76 00             	lea    0x0(%esi),%esi
80103f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f90 <kill>:
// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	53                   	push   %ebx
80103f94:	83 ec 10             	sub    $0x10,%esp
80103f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  release(&ptable.lock);
}

80103f9a:	68 a0 2d 11 80       	push   $0x80112da0
80103f9f:	e8 bc 03 00 00       	call   80104360 <acquire>
80103fa4:	83 c4 10             	add    $0x10,%esp
// Kill the process with the given pid.
80103fa7:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103fac:	eb 0c                	jmp    80103fba <kill+0x2a>
80103fae:	66 90                	xchg   %ax,%ax
80103fb0:	83 e8 80             	sub    $0xffffff80,%eax
80103fb3:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103fb8:	74 3e                	je     80103ff8 <kill+0x68>
// Process won't exit until it returns
80103fba:	39 58 10             	cmp    %ebx,0x10(%eax)
80103fbd:	75 f1                	jne    80103fb0 <kill+0x20>
// to user space (see trap in trap.c).
int
kill(int pid)
80103fbf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
80103fc3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
int
kill(int pid)
80103fca:	74 1c                	je     80103fe8 <kill+0x58>
{
  struct proc *p;
80103fcc:	83 ec 0c             	sub    $0xc,%esp
80103fcf:	68 a0 2d 11 80       	push   $0x80112da0
80103fd4:	e8 67 05 00 00       	call   80104540 <release>

80103fd9:	83 c4 10             	add    $0x10,%esp
80103fdc:	31 c0                	xor    %eax,%eax
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
80103fde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fe1:	c9                   	leave  
80103fe2:	c3                   	ret    
80103fe3:	90                   	nop
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103fe8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103fef:	eb db                	jmp    80103fcc <kill+0x3c>
80103ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
80103ff8:	83 ec 0c             	sub    $0xc,%esp
80103ffb:	68 a0 2d 11 80       	push   $0x80112da0
80104000:	e8 3b 05 00 00       	call   80104540 <release>
      p->killed = 1;
80104005:	83 c4 10             	add    $0x10,%esp
80104008:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      // Wake process from sleep if necessary.
8010400d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104010:	c9                   	leave  
80104011:	c3                   	ret    
80104012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104020 <procdump>:
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	57                   	push   %edi
80104024:	56                   	push   %esi
80104025:	53                   	push   %ebx
80104026:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104029:	bb 40 2e 11 80       	mov    $0x80112e40,%ebx
8010402e:	83 ec 3c             	sub    $0x3c,%esp
80104031:	eb 24                	jmp    80104057 <procdump+0x37>
80104033:	90                   	nop
80104034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
80104038:	83 ec 0c             	sub    $0xc,%esp
8010403b:	68 6f 7a 10 80       	push   $0x80107a6f
80104040:	e8 1b c6 ff ff       	call   80100660 <cprintf>
80104045:	83 c4 10             	add    $0x10,%esp
80104048:	83 eb 80             	sub    $0xffffff80,%ebx
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
8010404b:	81 fb 40 4e 11 80    	cmp    $0x80114e40,%ebx
80104051:	0f 84 81 00 00 00    	je     801040d8 <procdump+0xb8>
  [RUNNING]   "run   ",
80104057:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010405a:	85 c0                	test   %eax,%eax
8010405c:	74 ea                	je     80104048 <procdump+0x28>
  [ZOMBIE]    "zombie"
  };
8010405e:	83 f8 05             	cmp    $0x5,%eax
  int i;
  struct proc *p;
  char *state;
80104061:	ba e0 76 10 80       	mov    $0x801076e0,%edx
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
80104066:	77 11                	ja     80104079 <procdump+0x59>
80104068:	8b 14 85 48 77 10 80 	mov    -0x7fef88b8(,%eax,4),%edx
  int i;
  struct proc *p;
  char *state;
8010406f:	b8 e0 76 10 80       	mov    $0x801076e0,%eax
80104074:	85 d2                	test   %edx,%edx
80104076:	0f 44 d0             	cmove  %eax,%edx
  uint pc[10];
80104079:	53                   	push   %ebx
8010407a:	52                   	push   %edx
8010407b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010407e:	68 e4 76 10 80       	push   $0x801076e4
80104083:	e8 d8 c5 ff ff       	call   80100660 <cprintf>

80104088:	83 c4 10             	add    $0x10,%esp
8010408b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010408f:	75 a7                	jne    80104038 <procdump+0x18>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104091:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104094:	83 ec 08             	sub    $0x8,%esp
80104097:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010409a:	50                   	push   %eax
8010409b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010409e:	8b 40 0c             	mov    0xc(%eax),%eax
801040a1:	83 c0 08             	add    $0x8,%eax
801040a4:	50                   	push   %eax
801040a5:	e8 86 03 00 00       	call   80104430 <getcallerpcs>
801040aa:	83 c4 10             	add    $0x10,%esp
801040ad:	8d 76 00             	lea    0x0(%esi),%esi
    if(p->state == UNUSED)
801040b0:	8b 17                	mov    (%edi),%edx
801040b2:	85 d2                	test   %edx,%edx
801040b4:	74 82                	je     80104038 <procdump+0x18>
      continue;
801040b6:	83 ec 08             	sub    $0x8,%esp
801040b9:	83 c7 04             	add    $0x4,%edi
801040bc:	52                   	push   %edx
801040bd:	68 a9 71 10 80       	push   $0x801071a9
801040c2:	e8 99 c5 ff ff       	call   80100660 <cprintf>
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
801040c7:	83 c4 10             	add    $0x10,%esp
801040ca:	39 f7                	cmp    %esi,%edi
801040cc:	75 e2                	jne    801040b0 <procdump+0x90>
801040ce:	e9 65 ff ff ff       	jmp    80104038 <procdump+0x18>
801040d3:	90                   	nop
801040d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
801040d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040db:	5b                   	pop    %ebx
801040dc:	5e                   	pop    %esi
801040dd:	5f                   	pop    %edi
801040de:	5d                   	pop    %ebp
801040df:	c3                   	ret    

801040e0 <getnice>:
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
801040e0:	55                   	push   %ebp
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
801040e1:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
801040e6:	89 e5                	mov    %esp,%ebp
801040e8:	8b 55 08             	mov    0x8(%ebp),%edx
801040eb:	eb 0d                	jmp    801040fa <getnice+0x1a>
801040ed:	8d 76 00             	lea    0x0(%esi),%esi
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
801040f0:	83 e8 80             	sub    $0xffffff80,%eax
801040f3:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
801040f8:	74 16                	je     80104110 <getnice+0x30>
    }
801040fa:	39 50 10             	cmp    %edx,0x10(%eax)
801040fd:	75 f1                	jne    801040f0 <getnice+0x10>
801040ff:	8b 48 0c             	mov    0xc(%eax),%ecx
80104102:	85 c9                	test   %ecx,%ecx
80104104:	74 ea                	je     801040f0 <getnice+0x10>
    cprintf("\n");
80104106:	8b 40 7c             	mov    0x7c(%eax),%eax
  }
}

int 
80104109:	5d                   	pop    %ebp
8010410a:	c3                   	ret    
8010410b:	90                   	nop
8010410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

80104110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
int 
80104115:	5d                   	pop    %ebp
80104116:	c3                   	ret    
80104117:	89 f6                	mov    %esi,%esi
80104119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104120 <setnice>:
getnice(int pid){
	struct proc* p;
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104126:	8b 55 08             	mov    0x8(%ebp),%edx

	for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
		if(p->pid==pid && p->state!=UNUSED){
			return p->niceness;
80104129:	83 f9 28             	cmp    $0x28,%ecx
8010412c:	77 2a                	ja     80104158 <setnice+0x38>
8010412e:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80104133:	eb 0d                	jmp    80104142 <setnice+0x22>
80104135:	8d 76 00             	lea    0x0(%esi),%esi
		}
	}
	return -1;
}
80104138:	83 e8 80             	sub    $0xffffff80,%eax
8010413b:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80104140:	74 16                	je     80104158 <setnice+0x38>

80104142:	39 50 10             	cmp    %edx,0x10(%eax)
80104145:	75 f1                	jne    80104138 <setnice+0x18>
80104147:	83 78 0c 00          	cmpl   $0x0,0xc(%eax)
8010414b:	74 eb                	je     80104138 <setnice+0x18>
int 
8010414d:	89 48 7c             	mov    %ecx,0x7c(%eax)
setnice(int pid, int value){
80104150:	31 c0                	xor    %eax,%eax
	struct proc* p;
	
	if(value<0 || value>10){
		return -1;
80104152:	5d                   	pop    %ebp
80104153:	c3                   	ret    
80104154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	struct proc* p;

	for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
		if(p->pid==pid && p->state!=UNUSED){
			return p->niceness;
		}
80104158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
int 
setnice(int pid, int value){
	struct proc* p;
	
	if(value<0 || value>10){
		return -1;
8010415d:	5d                   	pop    %ebp
8010415e:	c3                   	ret    
8010415f:	90                   	nop

80104160 <ps>:
	}

80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	53                   	push   %ebx
80104164:	83 ec 14             	sub    $0x14,%esp
80104167:	8b 55 08             	mov    0x8(%ebp),%edx
	for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
		if(p->pid==pid && p->state!=UNUSED){
8010416a:	c7 45 e8 ed 76 10 80 	movl   $0x801076ed,-0x18(%ebp)
80104171:	c7 45 ec f6 76 10 80 	movl   $0x801076f6,-0x14(%ebp)
80104178:	c7 45 f0 ff 76 10 80 	movl   $0x801076ff,-0x10(%ebp)
8010417f:	c7 45 f4 07 77 10 80 	movl   $0x80107707,-0xc(%ebp)
			p->niceness=value;
			return 0;
		}
80104186:	85 d2                	test   %edx,%edx
80104188:	75 56                	jne    801041e0 <ps+0x80>
8010418a:	bb 40 2e 11 80       	mov    $0x80112e40,%ebx
8010418f:	eb 12                	jmp    801041a3 <ps+0x43>
80104191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104198:	83 eb 80             	sub    $0xffffff80,%ebx
	}
8010419b:	81 fb 40 4e 11 80    	cmp    $0x80114e40,%ebx
801041a1:	74 30                	je     801041d3 <ps+0x73>
	return -1;
801041a3:	8b 43 a0             	mov    -0x60(%ebx),%eax
801041a6:	85 c0                	test   %eax,%eax
801041a8:	74 ee                	je     80104198 <ps+0x38>
}
801041aa:	83 ec 0c             	sub    $0xc,%esp
801041ad:	53                   	push   %ebx
801041ae:	ff 74 85 e0          	pushl  -0x20(%ebp,%eax,4)
801041b2:	83 eb 80             	sub    $0xffffff80,%ebx
801041b5:	ff 73 90             	pushl  -0x70(%ebx)
801041b8:	ff b3 24 ff ff ff    	pushl  -0xdc(%ebx)
801041be:	68 0e 77 10 80       	push   $0x8010770e
801041c3:	e8 98 c4 ff ff       	call   80100660 <cprintf>
801041c8:	83 c4 20             	add    $0x20,%esp
	for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
		if(p->pid==pid && p->state!=UNUSED){
			p->niceness=value;
			return 0;
		}
	}
801041cb:	81 fb 40 4e 11 80    	cmp    $0x80114e40,%ebx
801041d1:	75 d0                	jne    801041a3 <ps+0x43>

	if(pid==0){
		for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
			if(p->state!=UNUSED){
				cprintf("%d %d %s %s\n", p->pid, p->niceness, p_state[p->state-2], p->name);
			}
801041d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041d6:	c9                   	leave  
801041d7:	c3                   	ret    
801041d8:	90                   	nop
801041d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041e0:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
801041e5:	eb 13                	jmp    801041fa <ps+0x9a>
801041e7:	89 f6                	mov    %esi,%esi
801041e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

void 
ps(int pid){
	struct proc* p;
	char* p_state[4]={"SLEEPING", "RUNNABLE", "RUNNING", "ZOMBIE"};
801041f0:	83 e8 80             	sub    $0xffffff80,%eax
801041f3:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
801041f8:	74 d9                	je     801041d3 <ps+0x73>
	struct pstat pst;
801041fa:	3b 50 10             	cmp    0x10(%eax),%edx
801041fd:	75 f1                	jne    801041f0 <ps+0x90>

801041ff:	8d 48 6c             	lea    0x6c(%eax),%ecx
80104202:	83 ec 0c             	sub    $0xc,%esp
80104205:	51                   	push   %ecx
80104206:	8b 48 0c             	mov    0xc(%eax),%ecx
80104209:	ff 74 8d e0          	pushl  -0x20(%ebp,%ecx,4)
8010420d:	ff 70 7c             	pushl  0x7c(%eax)
80104210:	52                   	push   %edx
80104211:	68 0e 77 10 80       	push   $0x8010770e
80104216:	e8 45 c4 ff ff       	call   80100660 <cprintf>
	if(pid==0){
8010421b:	83 c4 20             	add    $0x20,%esp
		for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
			if(p->state!=UNUSED){
				cprintf("%d %d %s %s\n", p->pid, p->niceness, p_state[p->state-2], p->name);
			}
8010421e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104221:	c9                   	leave  
80104222:	c3                   	ret    
80104223:	66 90                	xchg   %ax,%ax
80104225:	66 90                	xchg   %ax,%ax
80104227:	66 90                	xchg   %ax,%ax
80104229:	66 90                	xchg   %ax,%ax
8010422b:	66 90                	xchg   %ax,%ax
8010422d:	66 90                	xchg   %ax,%ax
8010422f:	90                   	nop

80104230 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	53                   	push   %ebx
80104234:	83 ec 0c             	sub    $0xc,%esp
80104237:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010423a:	68 60 77 10 80       	push   $0x80107760
8010423f:	8d 43 04             	lea    0x4(%ebx),%eax
80104242:	50                   	push   %eax
80104243:	e8 f8 00 00 00       	call   80104340 <initlock>
  lk->name = name;
80104248:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010424b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104251:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104254:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010425b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010425e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104261:	c9                   	leave  
80104262:	c3                   	ret    
80104263:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104270 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	56                   	push   %esi
80104274:	53                   	push   %ebx
80104275:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104278:	83 ec 0c             	sub    $0xc,%esp
8010427b:	8d 73 04             	lea    0x4(%ebx),%esi
8010427e:	56                   	push   %esi
8010427f:	e8 dc 00 00 00       	call   80104360 <acquire>
  while (lk->locked) {
80104284:	8b 13                	mov    (%ebx),%edx
80104286:	83 c4 10             	add    $0x10,%esp
80104289:	85 d2                	test   %edx,%edx
8010428b:	74 16                	je     801042a3 <acquiresleep+0x33>
8010428d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104290:	83 ec 08             	sub    $0x8,%esp
80104293:	56                   	push   %esi
80104294:	53                   	push   %ebx
80104295:	e8 f6 fa ff ff       	call   80103d90 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010429a:	8b 03                	mov    (%ebx),%eax
8010429c:	83 c4 10             	add    $0x10,%esp
8010429f:	85 c0                	test   %eax,%eax
801042a1:	75 ed                	jne    80104290 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
801042a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
801042a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042af:	8b 40 10             	mov    0x10(%eax),%eax
801042b2:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801042b5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042bb:	5b                   	pop    %ebx
801042bc:	5e                   	pop    %esi
801042bd:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = proc->pid;
  release(&lk->lk);
801042be:	e9 7d 02 00 00       	jmp    80104540 <release>
801042c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042d0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	56                   	push   %esi
801042d4:	53                   	push   %ebx
801042d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042d8:	83 ec 0c             	sub    $0xc,%esp
801042db:	8d 73 04             	lea    0x4(%ebx),%esi
801042de:	56                   	push   %esi
801042df:	e8 7c 00 00 00       	call   80104360 <acquire>
  lk->locked = 0;
801042e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801042ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801042f1:	89 1c 24             	mov    %ebx,(%esp)
801042f4:	e8 37 fc ff ff       	call   80103f30 <wakeup>
  release(&lk->lk);
801042f9:	89 75 08             	mov    %esi,0x8(%ebp)
801042fc:	83 c4 10             	add    $0x10,%esp
}
801042ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104302:	5b                   	pop    %ebx
80104303:	5e                   	pop    %esi
80104304:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104305:	e9 36 02 00 00       	jmp    80104540 <release>
8010430a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104310 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	56                   	push   %esi
80104314:	53                   	push   %ebx
80104315:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104318:	83 ec 0c             	sub    $0xc,%esp
8010431b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010431e:	53                   	push   %ebx
8010431f:	e8 3c 00 00 00       	call   80104360 <acquire>
  r = lk->locked;
80104324:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104326:	89 1c 24             	mov    %ebx,(%esp)
80104329:	e8 12 02 00 00       	call   80104540 <release>
  return r;
}
8010432e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104331:	89 f0                	mov    %esi,%eax
80104333:	5b                   	pop    %ebx
80104334:	5e                   	pop    %esi
80104335:	5d                   	pop    %ebp
80104336:	c3                   	ret    
80104337:	66 90                	xchg   %ax,%ax
80104339:	66 90                	xchg   %ax,%ax
8010433b:	66 90                	xchg   %ax,%ax
8010433d:	66 90                	xchg   %ax,%ax
8010433f:	90                   	nop

80104340 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104346:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104349:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010434f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104352:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104359:	5d                   	pop    %ebp
8010435a:	c3                   	ret    
8010435b:	90                   	nop
8010435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104360 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
80104364:	83 ec 04             	sub    $0x4,%esp
80104367:	9c                   	pushf  
80104368:	5a                   	pop    %edx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104369:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
8010436a:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104371:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104377:	85 c0                	test   %eax,%eax
80104379:	75 0c                	jne    80104387 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
8010437b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104381:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
80104387:	8b 55 08             	mov    0x8(%ebp),%edx

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
    cpu->intena = eflags & FL_IF;
  cpu->ncli += 1;
8010438a:	83 c0 01             	add    $0x1,%eax
8010438d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104393:	8b 02                	mov    (%edx),%eax
80104395:	85 c0                	test   %eax,%eax
80104397:	74 05                	je     8010439e <acquire+0x3e>
80104399:	39 4a 08             	cmp    %ecx,0x8(%edx)
8010439c:	74 7a                	je     80104418 <acquire+0xb8>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010439e:	b9 01 00 00 00       	mov    $0x1,%ecx
801043a3:	90                   	nop
801043a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043a8:	89 c8                	mov    %ecx,%eax
801043aa:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801043ad:	85 c0                	test   %eax,%eax
801043af:	75 f7                	jne    801043a8 <acquire+0x48>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801043b1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801043b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801043b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043bf:	89 ea                	mov    %ebp,%edx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801043c1:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
801043c4:	83 c1 0c             	add    $0xc,%ecx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043c7:	31 c0                	xor    %eax,%eax
801043c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043d0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801043d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043dc:	77 1a                	ja     801043f8 <acquire+0x98>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043de:	8b 5a 04             	mov    0x4(%edx),%ebx
801043e1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043e4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801043e7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043e9:	83 f8 0a             	cmp    $0xa,%eax
801043ec:	75 e2                	jne    801043d0 <acquire+0x70>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  getcallerpcs(&lk, lk->pcs);
}
801043ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043f1:	c9                   	leave  
801043f2:	c3                   	ret    
801043f3:	90                   	nop
801043f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801043f8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801043ff:	83 c0 01             	add    $0x1,%eax
80104402:	83 f8 0a             	cmp    $0xa,%eax
80104405:	74 e7                	je     801043ee <acquire+0x8e>
    pcs[i] = 0;
80104407:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010440e:	83 c0 01             	add    $0x1,%eax
80104411:	83 f8 0a             	cmp    $0xa,%eax
80104414:	75 e2                	jne    801043f8 <acquire+0x98>
80104416:	eb d6                	jmp    801043ee <acquire+0x8e>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104418:	83 ec 0c             	sub    $0xc,%esp
8010441b:	68 6b 77 10 80       	push   $0x8010776b
80104420:	e8 4b bf ff ff       	call   80100370 <panic>
80104425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104430 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104434:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104437:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010443a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010443d:	31 c0                	xor    %eax,%eax
8010443f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104440:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104446:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010444c:	77 1a                	ja     80104468 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010444e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104451:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104454:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104457:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104459:	83 f8 0a             	cmp    $0xa,%eax
8010445c:	75 e2                	jne    80104440 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010445e:	5b                   	pop    %ebx
8010445f:	5d                   	pop    %ebp
80104460:	c3                   	ret    
80104461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104468:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010446f:	83 c0 01             	add    $0x1,%eax
80104472:	83 f8 0a             	cmp    $0xa,%eax
80104475:	74 e7                	je     8010445e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104477:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010447e:	83 c0 01             	add    $0x1,%eax
80104481:	83 f8 0a             	cmp    $0xa,%eax
80104484:	75 e2                	jne    80104468 <getcallerpcs+0x38>
80104486:	eb d6                	jmp    8010445e <getcallerpcs+0x2e>
80104488:	90                   	nop
80104489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104490 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104496:	8b 02                	mov    (%edx),%eax
80104498:	85 c0                	test   %eax,%eax
8010449a:	74 14                	je     801044b0 <holding+0x20>
8010449c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801044a2:	39 42 08             	cmp    %eax,0x8(%edx)
}
801044a5:	5d                   	pop    %ebp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801044a6:	0f 94 c0             	sete   %al
801044a9:	0f b6 c0             	movzbl %al,%eax
}
801044ac:	c3                   	ret    
801044ad:	8d 76 00             	lea    0x0(%esi),%esi
801044b0:	31 c0                	xor    %eax,%eax
801044b2:	5d                   	pop    %ebp
801044b3:	c3                   	ret    
801044b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801044c0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044c3:	9c                   	pushf  
801044c4:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
801044c5:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801044c6:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801044cd:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801044d3:	85 c0                	test   %eax,%eax
801044d5:	75 0c                	jne    801044e3 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
801044d7:	81 e1 00 02 00 00    	and    $0x200,%ecx
801044dd:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
801044e3:	83 c0 01             	add    $0x1,%eax
801044e6:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
801044ec:	5d                   	pop    %ebp
801044ed:	c3                   	ret    
801044ee:	66 90                	xchg   %ax,%ax

801044f0 <popcli>:

void
popcli(void)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044f6:	9c                   	pushf  
801044f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044f8:	f6 c4 02             	test   $0x2,%ah
801044fb:	75 2c                	jne    80104529 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801044fd:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104504:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
8010450b:	78 0f                	js     8010451c <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
8010450d:	75 0b                	jne    8010451a <popcli+0x2a>
8010450f:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104515:	85 c0                	test   %eax,%eax
80104517:	74 01                	je     8010451a <popcli+0x2a>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104519:	fb                   	sti    
    sti();
}
8010451a:	c9                   	leave  
8010451b:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
8010451c:	83 ec 0c             	sub    $0xc,%esp
8010451f:	68 8a 77 10 80       	push   $0x8010778a
80104524:	e8 47 be ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104529:	83 ec 0c             	sub    $0xc,%esp
8010452c:	68 73 77 10 80       	push   $0x80107773
80104531:	e8 3a be ff ff       	call   80100370 <panic>
80104536:	8d 76 00             	lea    0x0(%esi),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104540 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	83 ec 08             	sub    $0x8,%esp
80104546:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104549:	8b 10                	mov    (%eax),%edx
8010454b:	85 d2                	test   %edx,%edx
8010454d:	74 0c                	je     8010455b <release+0x1b>
8010454f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104556:	39 50 08             	cmp    %edx,0x8(%eax)
80104559:	74 15                	je     80104570 <release+0x30>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010455b:	83 ec 0c             	sub    $0xc,%esp
8010455e:	68 91 77 10 80       	push   $0x80107791
80104563:	e8 08 be ff ff       	call   80100370 <panic>
80104568:	90                   	nop
80104569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  lk->pcs[0] = 0;
80104570:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104577:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010457e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104583:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
80104589:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010458a:	e9 61 ff ff ff       	jmp    801044f0 <popcli>
8010458f:	90                   	nop

80104590 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	57                   	push   %edi
80104594:	53                   	push   %ebx
80104595:	8b 55 08             	mov    0x8(%ebp),%edx
80104598:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010459b:	f6 c2 03             	test   $0x3,%dl
8010459e:	75 05                	jne    801045a5 <memset+0x15>
801045a0:	f6 c1 03             	test   $0x3,%cl
801045a3:	74 13                	je     801045b8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801045a5:	89 d7                	mov    %edx,%edi
801045a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801045aa:	fc                   	cld    
801045ab:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801045ad:	5b                   	pop    %ebx
801045ae:	89 d0                	mov    %edx,%eax
801045b0:	5f                   	pop    %edi
801045b1:	5d                   	pop    %ebp
801045b2:	c3                   	ret    
801045b3:	90                   	nop
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801045b8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801045bc:	c1 e9 02             	shr    $0x2,%ecx
801045bf:	89 fb                	mov    %edi,%ebx
801045c1:	89 f8                	mov    %edi,%eax
801045c3:	c1 e3 18             	shl    $0x18,%ebx
801045c6:	c1 e0 10             	shl    $0x10,%eax
801045c9:	09 d8                	or     %ebx,%eax
801045cb:	09 f8                	or     %edi,%eax
801045cd:	c1 e7 08             	shl    $0x8,%edi
801045d0:	09 f8                	or     %edi,%eax
801045d2:	89 d7                	mov    %edx,%edi
801045d4:	fc                   	cld    
801045d5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801045d7:	5b                   	pop    %ebx
801045d8:	89 d0                	mov    %edx,%eax
801045da:	5f                   	pop    %edi
801045db:	5d                   	pop    %ebp
801045dc:	c3                   	ret    
801045dd:	8d 76 00             	lea    0x0(%esi),%esi

801045e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	57                   	push   %edi
801045e4:	56                   	push   %esi
801045e5:	8b 45 10             	mov    0x10(%ebp),%eax
801045e8:	53                   	push   %ebx
801045e9:	8b 75 0c             	mov    0xc(%ebp),%esi
801045ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801045ef:	85 c0                	test   %eax,%eax
801045f1:	74 29                	je     8010461c <memcmp+0x3c>
    if(*s1 != *s2)
801045f3:	0f b6 13             	movzbl (%ebx),%edx
801045f6:	0f b6 0e             	movzbl (%esi),%ecx
801045f9:	38 d1                	cmp    %dl,%cl
801045fb:	75 2b                	jne    80104628 <memcmp+0x48>
801045fd:	8d 78 ff             	lea    -0x1(%eax),%edi
80104600:	31 c0                	xor    %eax,%eax
80104602:	eb 14                	jmp    80104618 <memcmp+0x38>
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104608:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010460d:	83 c0 01             	add    $0x1,%eax
80104610:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104614:	38 ca                	cmp    %cl,%dl
80104616:	75 10                	jne    80104628 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104618:	39 f8                	cmp    %edi,%eax
8010461a:	75 ec                	jne    80104608 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010461c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010461d:	31 c0                	xor    %eax,%eax
}
8010461f:	5e                   	pop    %esi
80104620:	5f                   	pop    %edi
80104621:	5d                   	pop    %ebp
80104622:	c3                   	ret    
80104623:	90                   	nop
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104628:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010462b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010462c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010462e:	5e                   	pop    %esi
8010462f:	5f                   	pop    %edi
80104630:	5d                   	pop    %ebp
80104631:	c3                   	ret    
80104632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104640 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	56                   	push   %esi
80104644:	53                   	push   %ebx
80104645:	8b 45 08             	mov    0x8(%ebp),%eax
80104648:	8b 75 0c             	mov    0xc(%ebp),%esi
8010464b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010464e:	39 c6                	cmp    %eax,%esi
80104650:	73 2e                	jae    80104680 <memmove+0x40>
80104652:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104655:	39 c8                	cmp    %ecx,%eax
80104657:	73 27                	jae    80104680 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104659:	85 db                	test   %ebx,%ebx
8010465b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010465e:	74 17                	je     80104677 <memmove+0x37>
      *--d = *--s;
80104660:	29 d9                	sub    %ebx,%ecx
80104662:	89 cb                	mov    %ecx,%ebx
80104664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104668:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010466c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010466f:	83 ea 01             	sub    $0x1,%edx
80104672:	83 fa ff             	cmp    $0xffffffff,%edx
80104675:	75 f1                	jne    80104668 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104677:	5b                   	pop    %ebx
80104678:	5e                   	pop    %esi
80104679:	5d                   	pop    %ebp
8010467a:	c3                   	ret    
8010467b:	90                   	nop
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104680:	31 d2                	xor    %edx,%edx
80104682:	85 db                	test   %ebx,%ebx
80104684:	74 f1                	je     80104677 <memmove+0x37>
80104686:	8d 76 00             	lea    0x0(%esi),%esi
80104689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104690:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104694:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104697:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010469a:	39 d3                	cmp    %edx,%ebx
8010469c:	75 f2                	jne    80104690 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010469e:	5b                   	pop    %ebx
8010469f:	5e                   	pop    %esi
801046a0:	5d                   	pop    %ebp
801046a1:	c3                   	ret    
801046a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046b0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801046b3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801046b4:	eb 8a                	jmp    80104640 <memmove>
801046b6:	8d 76 00             	lea    0x0(%esi),%esi
801046b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046c0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	56                   	push   %esi
801046c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046c8:	53                   	push   %ebx
801046c9:	8b 7d 08             	mov    0x8(%ebp),%edi
801046cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801046cf:	85 c9                	test   %ecx,%ecx
801046d1:	74 37                	je     8010470a <strncmp+0x4a>
801046d3:	0f b6 17             	movzbl (%edi),%edx
801046d6:	0f b6 1e             	movzbl (%esi),%ebx
801046d9:	84 d2                	test   %dl,%dl
801046db:	74 3f                	je     8010471c <strncmp+0x5c>
801046dd:	38 d3                	cmp    %dl,%bl
801046df:	75 3b                	jne    8010471c <strncmp+0x5c>
801046e1:	8d 47 01             	lea    0x1(%edi),%eax
801046e4:	01 cf                	add    %ecx,%edi
801046e6:	eb 1b                	jmp    80104703 <strncmp+0x43>
801046e8:	90                   	nop
801046e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046f0:	0f b6 10             	movzbl (%eax),%edx
801046f3:	84 d2                	test   %dl,%dl
801046f5:	74 21                	je     80104718 <strncmp+0x58>
801046f7:	0f b6 19             	movzbl (%ecx),%ebx
801046fa:	83 c0 01             	add    $0x1,%eax
801046fd:	89 ce                	mov    %ecx,%esi
801046ff:	38 da                	cmp    %bl,%dl
80104701:	75 19                	jne    8010471c <strncmp+0x5c>
80104703:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104705:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104708:	75 e6                	jne    801046f0 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010470a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010470b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010470d:	5e                   	pop    %esi
8010470e:	5f                   	pop    %edi
8010470f:	5d                   	pop    %ebp
80104710:	c3                   	ret    
80104711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104718:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010471c:	0f b6 c2             	movzbl %dl,%eax
8010471f:	29 d8                	sub    %ebx,%eax
}
80104721:	5b                   	pop    %ebx
80104722:	5e                   	pop    %esi
80104723:	5f                   	pop    %edi
80104724:	5d                   	pop    %ebp
80104725:	c3                   	ret    
80104726:	8d 76 00             	lea    0x0(%esi),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104730 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	56                   	push   %esi
80104734:	53                   	push   %ebx
80104735:	8b 45 08             	mov    0x8(%ebp),%eax
80104738:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010473b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010473e:	89 c2                	mov    %eax,%edx
80104740:	eb 19                	jmp    8010475b <strncpy+0x2b>
80104742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104748:	83 c3 01             	add    $0x1,%ebx
8010474b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010474f:	83 c2 01             	add    $0x1,%edx
80104752:	84 c9                	test   %cl,%cl
80104754:	88 4a ff             	mov    %cl,-0x1(%edx)
80104757:	74 09                	je     80104762 <strncpy+0x32>
80104759:	89 f1                	mov    %esi,%ecx
8010475b:	85 c9                	test   %ecx,%ecx
8010475d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104760:	7f e6                	jg     80104748 <strncpy+0x18>
    ;
  while(n-- > 0)
80104762:	31 c9                	xor    %ecx,%ecx
80104764:	85 f6                	test   %esi,%esi
80104766:	7e 17                	jle    8010477f <strncpy+0x4f>
80104768:	90                   	nop
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104770:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104774:	89 f3                	mov    %esi,%ebx
80104776:	83 c1 01             	add    $0x1,%ecx
80104779:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010477b:	85 db                	test   %ebx,%ebx
8010477d:	7f f1                	jg     80104770 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010477f:	5b                   	pop    %ebx
80104780:	5e                   	pop    %esi
80104781:	5d                   	pop    %ebp
80104782:	c3                   	ret    
80104783:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104790 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	56                   	push   %esi
80104794:	53                   	push   %ebx
80104795:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104798:	8b 45 08             	mov    0x8(%ebp),%eax
8010479b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010479e:	85 c9                	test   %ecx,%ecx
801047a0:	7e 26                	jle    801047c8 <safestrcpy+0x38>
801047a2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801047a6:	89 c1                	mov    %eax,%ecx
801047a8:	eb 17                	jmp    801047c1 <safestrcpy+0x31>
801047aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801047b0:	83 c2 01             	add    $0x1,%edx
801047b3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801047b7:	83 c1 01             	add    $0x1,%ecx
801047ba:	84 db                	test   %bl,%bl
801047bc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801047bf:	74 04                	je     801047c5 <safestrcpy+0x35>
801047c1:	39 f2                	cmp    %esi,%edx
801047c3:	75 eb                	jne    801047b0 <safestrcpy+0x20>
    ;
  *s = 0;
801047c5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801047c8:	5b                   	pop    %ebx
801047c9:	5e                   	pop    %esi
801047ca:	5d                   	pop    %ebp
801047cb:	c3                   	ret    
801047cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047d0 <strlen>:

int
strlen(const char *s)
{
801047d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801047d1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801047d3:	89 e5                	mov    %esp,%ebp
801047d5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801047d8:	80 3a 00             	cmpb   $0x0,(%edx)
801047db:	74 0c                	je     801047e9 <strlen+0x19>
801047dd:	8d 76 00             	lea    0x0(%esi),%esi
801047e0:	83 c0 01             	add    $0x1,%eax
801047e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801047e7:	75 f7                	jne    801047e0 <strlen+0x10>
    ;
  return n;
}
801047e9:	5d                   	pop    %ebp
801047ea:	c3                   	ret    

801047eb <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801047eb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801047ef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801047f3:	55                   	push   %ebp
  pushl %ebx
801047f4:	53                   	push   %ebx
  pushl %esi
801047f5:	56                   	push   %esi
  pushl %edi
801047f6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801047f7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801047f9:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801047fb:	5f                   	pop    %edi
  popl %esi
801047fc:	5e                   	pop    %esi
  popl %ebx
801047fd:	5b                   	pop    %ebx
  popl %ebp
801047fe:	5d                   	pop    %ebp
  ret
801047ff:	c3                   	ret    

80104800 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104800:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104801:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104808:	89 e5                	mov    %esp,%ebp
8010480a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
8010480d:	8b 12                	mov    (%edx),%edx
8010480f:	39 c2                	cmp    %eax,%edx
80104811:	76 15                	jbe    80104828 <fetchint+0x28>
80104813:	8d 48 04             	lea    0x4(%eax),%ecx
80104816:	39 ca                	cmp    %ecx,%edx
80104818:	72 0e                	jb     80104828 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010481a:	8b 10                	mov    (%eax),%edx
8010481c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010481f:	89 10                	mov    %edx,(%eax)
  return 0;
80104821:	31 c0                	xor    %eax,%eax
}
80104823:	5d                   	pop    %ebp
80104824:	c3                   	ret    
80104825:	8d 76 00             	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104828:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  *ip = *(int*)(addr);
  return 0;
}
8010482d:	5d                   	pop    %ebp
8010482e:	c3                   	ret    
8010482f:	90                   	nop

80104830 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104830:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104831:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104837:	89 e5                	mov    %esp,%ebp
80104839:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *s, *ep;

  if(addr >= proc->sz)
8010483c:	39 08                	cmp    %ecx,(%eax)
8010483e:	76 2c                	jbe    8010486c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104840:	8b 55 0c             	mov    0xc(%ebp),%edx
80104843:	89 c8                	mov    %ecx,%eax
80104845:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104847:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010484e:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104850:	39 d1                	cmp    %edx,%ecx
80104852:	73 18                	jae    8010486c <fetchstr+0x3c>
    if(*s == 0)
80104854:	80 39 00             	cmpb   $0x0,(%ecx)
80104857:	75 0c                	jne    80104865 <fetchstr+0x35>
80104859:	eb 1d                	jmp    80104878 <fetchstr+0x48>
8010485b:	90                   	nop
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104860:	80 38 00             	cmpb   $0x0,(%eax)
80104863:	74 13                	je     80104878 <fetchstr+0x48>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104865:	83 c0 01             	add    $0x1,%eax
80104868:	39 c2                	cmp    %eax,%edx
8010486a:	77 f4                	ja     80104860 <fetchstr+0x30>
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
8010486c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
80104871:	5d                   	pop    %ebp
80104872:	c3                   	ret    
80104873:	90                   	nop
80104874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
80104878:	29 c8                	sub    %ecx,%eax
  return -1;
}
8010487a:	5d                   	pop    %ebp
8010487b:	c3                   	ret    
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104880 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104880:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104887:	55                   	push   %ebp
80104888:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010488a:	8b 42 18             	mov    0x18(%edx),%eax
8010488d:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104890:	8b 12                	mov    (%edx),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104892:	8b 40 44             	mov    0x44(%eax),%eax
80104895:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104898:	8d 48 04             	lea    0x4(%eax),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010489b:	39 d1                	cmp    %edx,%ecx
8010489d:	73 19                	jae    801048b8 <argint+0x38>
8010489f:	8d 48 08             	lea    0x8(%eax),%ecx
801048a2:	39 ca                	cmp    %ecx,%edx
801048a4:	72 12                	jb     801048b8 <argint+0x38>
    return -1;
  *ip = *(int*)(addr);
801048a6:	8b 50 04             	mov    0x4(%eax),%edx
801048a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ac:	89 10                	mov    %edx,(%eax)
  return 0;
801048ae:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
801048b0:	5d                   	pop    %ebp
801048b1:	c3                   	ret    
801048b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
801048b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
801048bd:	5d                   	pop    %ebp
801048be:	c3                   	ret    
801048bf:	90                   	nop

801048c0 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801048c6:	55                   	push   %ebp
801048c7:	89 e5                	mov    %esp,%ebp
801048c9:	56                   	push   %esi
801048ca:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048cb:	8b 48 18             	mov    0x18(%eax),%ecx
801048ce:	8b 5d 08             	mov    0x8(%ebp),%ebx
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801048d1:	8b 55 10             	mov    0x10(%ebp),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048d4:	8b 49 44             	mov    0x44(%ecx),%ecx
801048d7:	8d 1c 99             	lea    (%ecx,%ebx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801048da:	8b 08                	mov    (%eax),%ecx
argptr(int n, char **pp, int size)
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
801048dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048e1:	8d 73 04             	lea    0x4(%ebx),%esi

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801048e4:	39 ce                	cmp    %ecx,%esi
801048e6:	73 1f                	jae    80104907 <argptr+0x47>
801048e8:	8d 73 08             	lea    0x8(%ebx),%esi
801048eb:	39 f1                	cmp    %esi,%ecx
801048ed:	72 18                	jb     80104907 <argptr+0x47>
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
801048ef:	85 d2                	test   %edx,%edx
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
801048f1:	8b 5b 04             	mov    0x4(%ebx),%ebx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
801048f4:	78 11                	js     80104907 <argptr+0x47>
801048f6:	39 cb                	cmp    %ecx,%ebx
801048f8:	73 0d                	jae    80104907 <argptr+0x47>
801048fa:	01 da                	add    %ebx,%edx
801048fc:	39 ca                	cmp    %ecx,%edx
801048fe:	77 07                	ja     80104907 <argptr+0x47>
    return -1;
  *pp = (char*)i;
80104900:	8b 45 0c             	mov    0xc(%ebp),%eax
80104903:	89 18                	mov    %ebx,(%eax)
  return 0;
80104905:	31 c0                	xor    %eax,%eax
}
80104907:	5b                   	pop    %ebx
80104908:	5e                   	pop    %esi
80104909:	5d                   	pop    %ebp
8010490a:	c3                   	ret    
8010490b:	90                   	nop
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104910:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104916:	55                   	push   %ebp
80104917:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104919:	8b 50 18             	mov    0x18(%eax),%edx
8010491c:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010491f:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104921:	8b 52 44             	mov    0x44(%edx),%edx
80104924:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104927:	8d 4a 04             	lea    0x4(%edx),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010492a:	39 c1                	cmp    %eax,%ecx
8010492c:	73 07                	jae    80104935 <argstr+0x25>
8010492e:	8d 4a 08             	lea    0x8(%edx),%ecx
80104931:	39 c8                	cmp    %ecx,%eax
80104933:	73 0b                	jae    80104940 <argstr+0x30>
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104935:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
8010493a:	5d                   	pop    %ebp
8010493b:	c3                   	ret    
8010493c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
80104940:	8b 4a 04             	mov    0x4(%edx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
80104943:	39 c1                	cmp    %eax,%ecx
80104945:	73 ee                	jae    80104935 <argstr+0x25>
    return -1;
  *pp = (char*)addr;
80104947:	8b 55 0c             	mov    0xc(%ebp),%edx
8010494a:	89 c8                	mov    %ecx,%eax
8010494c:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
8010494e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104955:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104957:	39 d1                	cmp    %edx,%ecx
80104959:	73 da                	jae    80104935 <argstr+0x25>
    if(*s == 0)
8010495b:	80 39 00             	cmpb   $0x0,(%ecx)
8010495e:	75 0d                	jne    8010496d <argstr+0x5d>
80104960:	eb 1e                	jmp    80104980 <argstr+0x70>
80104962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104968:	80 38 00             	cmpb   $0x0,(%eax)
8010496b:	74 13                	je     80104980 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010496d:	83 c0 01             	add    $0x1,%eax
80104970:	39 c2                	cmp    %eax,%edx
80104972:	77 f4                	ja     80104968 <argstr+0x58>
80104974:	eb bf                	jmp    80104935 <argstr+0x25>
80104976:	8d 76 00             	lea    0x0(%esi),%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(*s == 0)
      return s - *pp;
80104980:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104982:	5d                   	pop    %ebp
80104983:	c3                   	ret    
80104984:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010498a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104990 <syscall>:
[SYS_getpinfo]	sys_getpinfo
};

void
syscall(void)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	53                   	push   %ebx
80104994:	83 ec 04             	sub    $0x4,%esp
  int num;

  num = proc->tf->eax;
80104997:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010499e:	8b 5a 18             	mov    0x18(%edx),%ebx
801049a1:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801049a4:	8d 48 ff             	lea    -0x1(%eax),%ecx
801049a7:	83 f9 18             	cmp    $0x18,%ecx
801049aa:	77 1c                	ja     801049c8 <syscall+0x38>
801049ac:	8b 0c 85 c0 77 10 80 	mov    -0x7fef8840(,%eax,4),%ecx
801049b3:	85 c9                	test   %ecx,%ecx
801049b5:	74 11                	je     801049c8 <syscall+0x38>
    proc->tf->eax = syscalls[num]();
801049b7:	ff d1                	call   *%ecx
801049b9:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
801049bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049bf:	c9                   	leave  
801049c0:	c3                   	ret    
801049c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801049c8:	50                   	push   %eax
            proc->pid, proc->name, num);
801049c9:	8d 42 6c             	lea    0x6c(%edx),%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801049cc:	50                   	push   %eax
801049cd:	ff 72 10             	pushl  0x10(%edx)
801049d0:	68 99 77 10 80       	push   $0x80107799
801049d5:	e8 86 bc ff ff       	call   80100660 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801049da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049e0:	83 c4 10             	add    $0x10,%esp
801049e3:	8b 40 18             	mov    0x18(%eax),%eax
801049e6:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801049ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049f0:	c9                   	leave  
801049f1:	c3                   	ret    
801049f2:	66 90                	xchg   %ax,%ax
801049f4:	66 90                	xchg   %ax,%ax
801049f6:	66 90                	xchg   %ax,%ax
801049f8:	66 90                	xchg   %ax,%ax
801049fa:	66 90                	xchg   %ax,%ax
801049fc:	66 90                	xchg   %ax,%ax
801049fe:	66 90                	xchg   %ax,%ax

80104a00 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	57                   	push   %edi
80104a04:	56                   	push   %esi
80104a05:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a06:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a09:	83 ec 44             	sub    $0x44,%esp
80104a0c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a0f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a12:	56                   	push   %esi
80104a13:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a14:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a17:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a1a:	e8 51 d4 ff ff       	call   80101e70 <nameiparent>
80104a1f:	83 c4 10             	add    $0x10,%esp
80104a22:	85 c0                	test   %eax,%eax
80104a24:	0f 84 f6 00 00 00    	je     80104b20 <create+0x120>
    return 0;
  ilock(dp);
80104a2a:	83 ec 0c             	sub    $0xc,%esp
80104a2d:	89 c7                	mov    %eax,%edi
80104a2f:	50                   	push   %eax
80104a30:	e8 eb cb ff ff       	call   80101620 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104a35:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104a38:	83 c4 0c             	add    $0xc,%esp
80104a3b:	50                   	push   %eax
80104a3c:	56                   	push   %esi
80104a3d:	57                   	push   %edi
80104a3e:	e8 ed d0 ff ff       	call   80101b30 <dirlookup>
80104a43:	83 c4 10             	add    $0x10,%esp
80104a46:	85 c0                	test   %eax,%eax
80104a48:	89 c3                	mov    %eax,%ebx
80104a4a:	74 54                	je     80104aa0 <create+0xa0>
    iunlockput(dp);
80104a4c:	83 ec 0c             	sub    $0xc,%esp
80104a4f:	57                   	push   %edi
80104a50:	e8 3b ce ff ff       	call   80101890 <iunlockput>
    ilock(ip);
80104a55:	89 1c 24             	mov    %ebx,(%esp)
80104a58:	e8 c3 cb ff ff       	call   80101620 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a5d:	83 c4 10             	add    $0x10,%esp
80104a60:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104a65:	75 19                	jne    80104a80 <create+0x80>
80104a67:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104a6c:	89 d8                	mov    %ebx,%eax
80104a6e:	75 10                	jne    80104a80 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a73:	5b                   	pop    %ebx
80104a74:	5e                   	pop    %esi
80104a75:	5f                   	pop    %edi
80104a76:	5d                   	pop    %ebp
80104a77:	c3                   	ret    
80104a78:	90                   	nop
80104a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104a80:	83 ec 0c             	sub    $0xc,%esp
80104a83:	53                   	push   %ebx
80104a84:	e8 07 ce ff ff       	call   80101890 <iunlockput>
    return 0;
80104a89:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104a8f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a91:	5b                   	pop    %ebx
80104a92:	5e                   	pop    %esi
80104a93:	5f                   	pop    %edi
80104a94:	5d                   	pop    %ebp
80104a95:	c3                   	ret    
80104a96:	8d 76 00             	lea    0x0(%esi),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104aa0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104aa4:	83 ec 08             	sub    $0x8,%esp
80104aa7:	50                   	push   %eax
80104aa8:	ff 37                	pushl  (%edi)
80104aaa:	e8 01 ca ff ff       	call   801014b0 <ialloc>
80104aaf:	83 c4 10             	add    $0x10,%esp
80104ab2:	85 c0                	test   %eax,%eax
80104ab4:	89 c3                	mov    %eax,%ebx
80104ab6:	0f 84 cc 00 00 00    	je     80104b88 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104abc:	83 ec 0c             	sub    $0xc,%esp
80104abf:	50                   	push   %eax
80104ac0:	e8 5b cb ff ff       	call   80101620 <ilock>
  ip->major = major;
80104ac5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104ac9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104acd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104ad1:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104ad5:	b8 01 00 00 00       	mov    $0x1,%eax
80104ada:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104ade:	89 1c 24             	mov    %ebx,(%esp)
80104ae1:	e8 8a ca ff ff       	call   80101570 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104ae6:	83 c4 10             	add    $0x10,%esp
80104ae9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104aee:	74 40                	je     80104b30 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104af0:	83 ec 04             	sub    $0x4,%esp
80104af3:	ff 73 04             	pushl  0x4(%ebx)
80104af6:	56                   	push   %esi
80104af7:	57                   	push   %edi
80104af8:	e8 93 d2 ff ff       	call   80101d90 <dirlink>
80104afd:	83 c4 10             	add    $0x10,%esp
80104b00:	85 c0                	test   %eax,%eax
80104b02:	78 77                	js     80104b7b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104b04:	83 ec 0c             	sub    $0xc,%esp
80104b07:	57                   	push   %edi
80104b08:	e8 83 cd ff ff       	call   80101890 <iunlockput>

  return ip;
80104b0d:	83 c4 10             	add    $0x10,%esp
}
80104b10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104b13:	89 d8                	mov    %ebx,%eax
}
80104b15:	5b                   	pop    %ebx
80104b16:	5e                   	pop    %esi
80104b17:	5f                   	pop    %edi
80104b18:	5d                   	pop    %ebp
80104b19:	c3                   	ret    
80104b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104b20:	31 c0                	xor    %eax,%eax
80104b22:	e9 49 ff ff ff       	jmp    80104a70 <create+0x70>
80104b27:	89 f6                	mov    %esi,%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104b30:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104b35:	83 ec 0c             	sub    $0xc,%esp
80104b38:	57                   	push   %edi
80104b39:	e8 32 ca ff ff       	call   80101570 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b3e:	83 c4 0c             	add    $0xc,%esp
80104b41:	ff 73 04             	pushl  0x4(%ebx)
80104b44:	68 44 78 10 80       	push   $0x80107844
80104b49:	53                   	push   %ebx
80104b4a:	e8 41 d2 ff ff       	call   80101d90 <dirlink>
80104b4f:	83 c4 10             	add    $0x10,%esp
80104b52:	85 c0                	test   %eax,%eax
80104b54:	78 18                	js     80104b6e <create+0x16e>
80104b56:	83 ec 04             	sub    $0x4,%esp
80104b59:	ff 77 04             	pushl  0x4(%edi)
80104b5c:	68 43 78 10 80       	push   $0x80107843
80104b61:	53                   	push   %ebx
80104b62:	e8 29 d2 ff ff       	call   80101d90 <dirlink>
80104b67:	83 c4 10             	add    $0x10,%esp
80104b6a:	85 c0                	test   %eax,%eax
80104b6c:	79 82                	jns    80104af0 <create+0xf0>
      panic("create dots");
80104b6e:	83 ec 0c             	sub    $0xc,%esp
80104b71:	68 37 78 10 80       	push   $0x80107837
80104b76:	e8 f5 b7 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104b7b:	83 ec 0c             	sub    $0xc,%esp
80104b7e:	68 46 78 10 80       	push   $0x80107846
80104b83:	e8 e8 b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104b88:	83 ec 0c             	sub    $0xc,%esp
80104b8b:	68 28 78 10 80       	push   $0x80107828
80104b90:	e8 db b7 ff ff       	call   80100370 <panic>
80104b95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ba0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	56                   	push   %esi
80104ba4:	53                   	push   %ebx
80104ba5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104ba7:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104baa:	89 d3                	mov    %edx,%ebx
80104bac:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104baf:	50                   	push   %eax
80104bb0:	6a 00                	push   $0x0
80104bb2:	e8 c9 fc ff ff       	call   80104880 <argint>
80104bb7:	83 c4 10             	add    $0x10,%esp
80104bba:	85 c0                	test   %eax,%eax
80104bbc:	78 3a                	js     80104bf8 <argfd.constprop.0+0x58>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104bbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc1:	83 f8 0f             	cmp    $0xf,%eax
80104bc4:	77 32                	ja     80104bf8 <argfd.constprop.0+0x58>
80104bc6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104bcd:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
80104bd1:	85 d2                	test   %edx,%edx
80104bd3:	74 23                	je     80104bf8 <argfd.constprop.0+0x58>
    return -1;
  if(pfd)
80104bd5:	85 f6                	test   %esi,%esi
80104bd7:	74 02                	je     80104bdb <argfd.constprop.0+0x3b>
    *pfd = fd;
80104bd9:	89 06                	mov    %eax,(%esi)
  if(pf)
80104bdb:	85 db                	test   %ebx,%ebx
80104bdd:	74 11                	je     80104bf0 <argfd.constprop.0+0x50>
    *pf = f;
80104bdf:	89 13                	mov    %edx,(%ebx)
  return 0;
80104be1:	31 c0                	xor    %eax,%eax
}
80104be3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104be6:	5b                   	pop    %ebx
80104be7:	5e                   	pop    %esi
80104be8:	5d                   	pop    %ebp
80104be9:	c3                   	ret    
80104bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104bf0:	31 c0                	xor    %eax,%eax
80104bf2:	eb ef                	jmp    80104be3 <argfd.constprop.0+0x43>
80104bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104bf8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bfd:	eb e4                	jmp    80104be3 <argfd.constprop.0+0x43>
80104bff:	90                   	nop

80104c00 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104c00:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c01:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104c03:	89 e5                	mov    %esp,%ebp
80104c05:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c06:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104c09:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c0c:	e8 8f ff ff ff       	call   80104ba0 <argfd.constprop.0>
80104c11:	85 c0                	test   %eax,%eax
80104c13:	78 1b                	js     80104c30 <sys_dup+0x30>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104c15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104c1e:	31 db                	xor    %ebx,%ebx
    if(proc->ofile[fd] == 0){
80104c20:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104c24:	85 c9                	test   %ecx,%ecx
80104c26:	74 18                	je     80104c40 <sys_dup+0x40>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104c28:	83 c3 01             	add    $0x1,%ebx
80104c2b:	83 fb 10             	cmp    $0x10,%ebx
80104c2e:	75 f0                	jne    80104c20 <sys_dup+0x20>
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104c35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c38:	c9                   	leave  
80104c39:	c3                   	ret    
80104c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104c40:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104c43:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104c47:	52                   	push   %edx
80104c48:	e8 73 c1 ff ff       	call   80100dc0 <filedup>
  return fd;
80104c4d:	89 d8                	mov    %ebx,%eax
80104c4f:	83 c4 10             	add    $0x10,%esp
}
80104c52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c55:	c9                   	leave  
80104c56:	c3                   	ret    
80104c57:	89 f6                	mov    %esi,%esi
80104c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c60 <sys_read>:

int
sys_read(void)
{
80104c60:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c61:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104c63:	89 e5                	mov    %esp,%ebp
80104c65:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c68:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c6b:	e8 30 ff ff ff       	call   80104ba0 <argfd.constprop.0>
80104c70:	85 c0                	test   %eax,%eax
80104c72:	78 4c                	js     80104cc0 <sys_read+0x60>
80104c74:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c77:	83 ec 08             	sub    $0x8,%esp
80104c7a:	50                   	push   %eax
80104c7b:	6a 02                	push   $0x2
80104c7d:	e8 fe fb ff ff       	call   80104880 <argint>
80104c82:	83 c4 10             	add    $0x10,%esp
80104c85:	85 c0                	test   %eax,%eax
80104c87:	78 37                	js     80104cc0 <sys_read+0x60>
80104c89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c8c:	83 ec 04             	sub    $0x4,%esp
80104c8f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c92:	50                   	push   %eax
80104c93:	6a 01                	push   $0x1
80104c95:	e8 26 fc ff ff       	call   801048c0 <argptr>
80104c9a:	83 c4 10             	add    $0x10,%esp
80104c9d:	85 c0                	test   %eax,%eax
80104c9f:	78 1f                	js     80104cc0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104ca1:	83 ec 04             	sub    $0x4,%esp
80104ca4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ca7:	ff 75 f4             	pushl  -0xc(%ebp)
80104caa:	ff 75 ec             	pushl  -0x14(%ebp)
80104cad:	e8 7e c2 ff ff       	call   80100f30 <fileread>
80104cb2:	83 c4 10             	add    $0x10,%esp
}
80104cb5:	c9                   	leave  
80104cb6:	c3                   	ret    
80104cb7:	89 f6                	mov    %esi,%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104cc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104cc5:	c9                   	leave  
80104cc6:	c3                   	ret    
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cd0 <sys_write>:

int
sys_write(void)
{
80104cd0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cd1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104cd3:	89 e5                	mov    %esp,%ebp
80104cd5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cd8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cdb:	e8 c0 fe ff ff       	call   80104ba0 <argfd.constprop.0>
80104ce0:	85 c0                	test   %eax,%eax
80104ce2:	78 4c                	js     80104d30 <sys_write+0x60>
80104ce4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ce7:	83 ec 08             	sub    $0x8,%esp
80104cea:	50                   	push   %eax
80104ceb:	6a 02                	push   $0x2
80104ced:	e8 8e fb ff ff       	call   80104880 <argint>
80104cf2:	83 c4 10             	add    $0x10,%esp
80104cf5:	85 c0                	test   %eax,%eax
80104cf7:	78 37                	js     80104d30 <sys_write+0x60>
80104cf9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cfc:	83 ec 04             	sub    $0x4,%esp
80104cff:	ff 75 f0             	pushl  -0x10(%ebp)
80104d02:	50                   	push   %eax
80104d03:	6a 01                	push   $0x1
80104d05:	e8 b6 fb ff ff       	call   801048c0 <argptr>
80104d0a:	83 c4 10             	add    $0x10,%esp
80104d0d:	85 c0                	test   %eax,%eax
80104d0f:	78 1f                	js     80104d30 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104d11:	83 ec 04             	sub    $0x4,%esp
80104d14:	ff 75 f0             	pushl  -0x10(%ebp)
80104d17:	ff 75 f4             	pushl  -0xc(%ebp)
80104d1a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d1d:	e8 9e c2 ff ff       	call   80100fc0 <filewrite>
80104d22:	83 c4 10             	add    $0x10,%esp
}
80104d25:	c9                   	leave  
80104d26:	c3                   	ret    
80104d27:	89 f6                	mov    %esi,%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104d35:	c9                   	leave  
80104d36:	c3                   	ret    
80104d37:	89 f6                	mov    %esi,%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d40 <sys_close>:

int
sys_close(void)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104d46:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d49:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d4c:	e8 4f fe ff ff       	call   80104ba0 <argfd.constprop.0>
80104d51:	85 c0                	test   %eax,%eax
80104d53:	78 2b                	js     80104d80 <sys_close+0x40>
    return -1;
  proc->ofile[fd] = 0;
80104d55:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104d58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
80104d5e:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  proc->ofile[fd] = 0;
80104d61:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104d68:	00 
  fileclose(f);
80104d69:	ff 75 f4             	pushl  -0xc(%ebp)
80104d6c:	e8 9f c0 ff ff       	call   80100e10 <fileclose>
  return 0;
80104d71:	83 c4 10             	add    $0x10,%esp
80104d74:	31 c0                	xor    %eax,%eax
}
80104d76:	c9                   	leave  
80104d77:	c3                   	ret    
80104d78:	90                   	nop
80104d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104d85:	c9                   	leave  
80104d86:	c3                   	ret    
80104d87:	89 f6                	mov    %esi,%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d90 <sys_fstat>:

int
sys_fstat(void)
{
80104d90:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d91:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104d93:	89 e5                	mov    %esp,%ebp
80104d95:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d98:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d9b:	e8 00 fe ff ff       	call   80104ba0 <argfd.constprop.0>
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 2c                	js     80104dd0 <sys_fstat+0x40>
80104da4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104da7:	83 ec 04             	sub    $0x4,%esp
80104daa:	6a 14                	push   $0x14
80104dac:	50                   	push   %eax
80104dad:	6a 01                	push   $0x1
80104daf:	e8 0c fb ff ff       	call   801048c0 <argptr>
80104db4:	83 c4 10             	add    $0x10,%esp
80104db7:	85 c0                	test   %eax,%eax
80104db9:	78 15                	js     80104dd0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104dbb:	83 ec 08             	sub    $0x8,%esp
80104dbe:	ff 75 f4             	pushl  -0xc(%ebp)
80104dc1:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc4:	e8 17 c1 ff ff       	call   80100ee0 <filestat>
80104dc9:	83 c4 10             	add    $0x10,%esp
}
80104dcc:	c9                   	leave  
80104dcd:	c3                   	ret    
80104dce:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104dd5:	c9                   	leave  
80104dd6:	c3                   	ret    
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104de0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	57                   	push   %edi
80104de4:	56                   	push   %esi
80104de5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104de6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104de9:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104dec:	50                   	push   %eax
80104ded:	6a 00                	push   $0x0
80104def:	e8 1c fb ff ff       	call   80104910 <argstr>
80104df4:	83 c4 10             	add    $0x10,%esp
80104df7:	85 c0                	test   %eax,%eax
80104df9:	0f 88 fb 00 00 00    	js     80104efa <sys_link+0x11a>
80104dff:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e02:	83 ec 08             	sub    $0x8,%esp
80104e05:	50                   	push   %eax
80104e06:	6a 01                	push   $0x1
80104e08:	e8 03 fb ff ff       	call   80104910 <argstr>
80104e0d:	83 c4 10             	add    $0x10,%esp
80104e10:	85 c0                	test   %eax,%eax
80104e12:	0f 88 e2 00 00 00    	js     80104efa <sys_link+0x11a>
    return -1;

  begin_op();
80104e18:	e8 63 dd ff ff       	call   80102b80 <begin_op>
  if((ip = namei(old)) == 0){
80104e1d:	83 ec 0c             	sub    $0xc,%esp
80104e20:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e23:	e8 28 d0 ff ff       	call   80101e50 <namei>
80104e28:	83 c4 10             	add    $0x10,%esp
80104e2b:	85 c0                	test   %eax,%eax
80104e2d:	89 c3                	mov    %eax,%ebx
80104e2f:	0f 84 f3 00 00 00    	je     80104f28 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104e35:	83 ec 0c             	sub    $0xc,%esp
80104e38:	50                   	push   %eax
80104e39:	e8 e2 c7 ff ff       	call   80101620 <ilock>
  if(ip->type == T_DIR){
80104e3e:	83 c4 10             	add    $0x10,%esp
80104e41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e46:	0f 84 c4 00 00 00    	je     80104f10 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104e4c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e51:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104e54:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104e57:	53                   	push   %ebx
80104e58:	e8 13 c7 ff ff       	call   80101570 <iupdate>
  iunlock(ip);
80104e5d:	89 1c 24             	mov    %ebx,(%esp)
80104e60:	e8 9b c8 ff ff       	call   80101700 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104e65:	58                   	pop    %eax
80104e66:	5a                   	pop    %edx
80104e67:	57                   	push   %edi
80104e68:	ff 75 d0             	pushl  -0x30(%ebp)
80104e6b:	e8 00 d0 ff ff       	call   80101e70 <nameiparent>
80104e70:	83 c4 10             	add    $0x10,%esp
80104e73:	85 c0                	test   %eax,%eax
80104e75:	89 c6                	mov    %eax,%esi
80104e77:	74 5b                	je     80104ed4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104e79:	83 ec 0c             	sub    $0xc,%esp
80104e7c:	50                   	push   %eax
80104e7d:	e8 9e c7 ff ff       	call   80101620 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104e82:	83 c4 10             	add    $0x10,%esp
80104e85:	8b 03                	mov    (%ebx),%eax
80104e87:	39 06                	cmp    %eax,(%esi)
80104e89:	75 3d                	jne    80104ec8 <sys_link+0xe8>
80104e8b:	83 ec 04             	sub    $0x4,%esp
80104e8e:	ff 73 04             	pushl  0x4(%ebx)
80104e91:	57                   	push   %edi
80104e92:	56                   	push   %esi
80104e93:	e8 f8 ce ff ff       	call   80101d90 <dirlink>
80104e98:	83 c4 10             	add    $0x10,%esp
80104e9b:	85 c0                	test   %eax,%eax
80104e9d:	78 29                	js     80104ec8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104e9f:	83 ec 0c             	sub    $0xc,%esp
80104ea2:	56                   	push   %esi
80104ea3:	e8 e8 c9 ff ff       	call   80101890 <iunlockput>
  iput(ip);
80104ea8:	89 1c 24             	mov    %ebx,(%esp)
80104eab:	e8 a0 c8 ff ff       	call   80101750 <iput>

  end_op();
80104eb0:	e8 3b dd ff ff       	call   80102bf0 <end_op>

  return 0;
80104eb5:	83 c4 10             	add    $0x10,%esp
80104eb8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ebd:	5b                   	pop    %ebx
80104ebe:	5e                   	pop    %esi
80104ebf:	5f                   	pop    %edi
80104ec0:	5d                   	pop    %ebp
80104ec1:	c3                   	ret    
80104ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104ec8:	83 ec 0c             	sub    $0xc,%esp
80104ecb:	56                   	push   %esi
80104ecc:	e8 bf c9 ff ff       	call   80101890 <iunlockput>
    goto bad;
80104ed1:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104ed4:	83 ec 0c             	sub    $0xc,%esp
80104ed7:	53                   	push   %ebx
80104ed8:	e8 43 c7 ff ff       	call   80101620 <ilock>
  ip->nlink--;
80104edd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ee2:	89 1c 24             	mov    %ebx,(%esp)
80104ee5:	e8 86 c6 ff ff       	call   80101570 <iupdate>
  iunlockput(ip);
80104eea:	89 1c 24             	mov    %ebx,(%esp)
80104eed:	e8 9e c9 ff ff       	call   80101890 <iunlockput>
  end_op();
80104ef2:	e8 f9 dc ff ff       	call   80102bf0 <end_op>
  return -1;
80104ef7:	83 c4 10             	add    $0x10,%esp
}
80104efa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104efd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f02:	5b                   	pop    %ebx
80104f03:	5e                   	pop    %esi
80104f04:	5f                   	pop    %edi
80104f05:	5d                   	pop    %ebp
80104f06:	c3                   	ret    
80104f07:	89 f6                	mov    %esi,%esi
80104f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104f10:	83 ec 0c             	sub    $0xc,%esp
80104f13:	53                   	push   %ebx
80104f14:	e8 77 c9 ff ff       	call   80101890 <iunlockput>
    end_op();
80104f19:	e8 d2 dc ff ff       	call   80102bf0 <end_op>
    return -1;
80104f1e:	83 c4 10             	add    $0x10,%esp
80104f21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f26:	eb 92                	jmp    80104eba <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104f28:	e8 c3 dc ff ff       	call   80102bf0 <end_op>
    return -1;
80104f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f32:	eb 86                	jmp    80104eba <sys_link+0xda>
80104f34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f40 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
80104f45:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104f46:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104f49:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104f4c:	50                   	push   %eax
80104f4d:	6a 00                	push   $0x0
80104f4f:	e8 bc f9 ff ff       	call   80104910 <argstr>
80104f54:	83 c4 10             	add    $0x10,%esp
80104f57:	85 c0                	test   %eax,%eax
80104f59:	0f 88 82 01 00 00    	js     801050e1 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104f5f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104f62:	e8 19 dc ff ff       	call   80102b80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104f67:	83 ec 08             	sub    $0x8,%esp
80104f6a:	53                   	push   %ebx
80104f6b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f6e:	e8 fd ce ff ff       	call   80101e70 <nameiparent>
80104f73:	83 c4 10             	add    $0x10,%esp
80104f76:	85 c0                	test   %eax,%eax
80104f78:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104f7b:	0f 84 6a 01 00 00    	je     801050eb <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80104f81:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104f84:	83 ec 0c             	sub    $0xc,%esp
80104f87:	56                   	push   %esi
80104f88:	e8 93 c6 ff ff       	call   80101620 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104f8d:	58                   	pop    %eax
80104f8e:	5a                   	pop    %edx
80104f8f:	68 44 78 10 80       	push   $0x80107844
80104f94:	53                   	push   %ebx
80104f95:	e8 76 cb ff ff       	call   80101b10 <namecmp>
80104f9a:	83 c4 10             	add    $0x10,%esp
80104f9d:	85 c0                	test   %eax,%eax
80104f9f:	0f 84 fc 00 00 00    	je     801050a1 <sys_unlink+0x161>
80104fa5:	83 ec 08             	sub    $0x8,%esp
80104fa8:	68 43 78 10 80       	push   $0x80107843
80104fad:	53                   	push   %ebx
80104fae:	e8 5d cb ff ff       	call   80101b10 <namecmp>
80104fb3:	83 c4 10             	add    $0x10,%esp
80104fb6:	85 c0                	test   %eax,%eax
80104fb8:	0f 84 e3 00 00 00    	je     801050a1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104fbe:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104fc1:	83 ec 04             	sub    $0x4,%esp
80104fc4:	50                   	push   %eax
80104fc5:	53                   	push   %ebx
80104fc6:	56                   	push   %esi
80104fc7:	e8 64 cb ff ff       	call   80101b30 <dirlookup>
80104fcc:	83 c4 10             	add    $0x10,%esp
80104fcf:	85 c0                	test   %eax,%eax
80104fd1:	89 c3                	mov    %eax,%ebx
80104fd3:	0f 84 c8 00 00 00    	je     801050a1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80104fd9:	83 ec 0c             	sub    $0xc,%esp
80104fdc:	50                   	push   %eax
80104fdd:	e8 3e c6 ff ff       	call   80101620 <ilock>

  if(ip->nlink < 1)
80104fe2:	83 c4 10             	add    $0x10,%esp
80104fe5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104fea:	0f 8e 24 01 00 00    	jle    80105114 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104ff0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ff5:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104ff8:	74 66                	je     80105060 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104ffa:	83 ec 04             	sub    $0x4,%esp
80104ffd:	6a 10                	push   $0x10
80104fff:	6a 00                	push   $0x0
80105001:	56                   	push   %esi
80105002:	e8 89 f5 ff ff       	call   80104590 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105007:	6a 10                	push   $0x10
80105009:	ff 75 c4             	pushl  -0x3c(%ebp)
8010500c:	56                   	push   %esi
8010500d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105010:	e8 cb c9 ff ff       	call   801019e0 <writei>
80105015:	83 c4 20             	add    $0x20,%esp
80105018:	83 f8 10             	cmp    $0x10,%eax
8010501b:	0f 85 e6 00 00 00    	jne    80105107 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105021:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105026:	0f 84 9c 00 00 00    	je     801050c8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010502c:	83 ec 0c             	sub    $0xc,%esp
8010502f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105032:	e8 59 c8 ff ff       	call   80101890 <iunlockput>

  ip->nlink--;
80105037:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010503c:	89 1c 24             	mov    %ebx,(%esp)
8010503f:	e8 2c c5 ff ff       	call   80101570 <iupdate>
  iunlockput(ip);
80105044:	89 1c 24             	mov    %ebx,(%esp)
80105047:	e8 44 c8 ff ff       	call   80101890 <iunlockput>

  end_op();
8010504c:	e8 9f db ff ff       	call   80102bf0 <end_op>

  return 0;
80105051:	83 c4 10             	add    $0x10,%esp
80105054:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105056:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105059:	5b                   	pop    %ebx
8010505a:	5e                   	pop    %esi
8010505b:	5f                   	pop    %edi
8010505c:	5d                   	pop    %ebp
8010505d:	c3                   	ret    
8010505e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105060:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105064:	76 94                	jbe    80104ffa <sys_unlink+0xba>
80105066:	bf 20 00 00 00       	mov    $0x20,%edi
8010506b:	eb 0f                	jmp    8010507c <sys_unlink+0x13c>
8010506d:	8d 76 00             	lea    0x0(%esi),%esi
80105070:	83 c7 10             	add    $0x10,%edi
80105073:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105076:	0f 83 7e ff ff ff    	jae    80104ffa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010507c:	6a 10                	push   $0x10
8010507e:	57                   	push   %edi
8010507f:	56                   	push   %esi
80105080:	53                   	push   %ebx
80105081:	e8 5a c8 ff ff       	call   801018e0 <readi>
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	83 f8 10             	cmp    $0x10,%eax
8010508c:	75 6c                	jne    801050fa <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010508e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105093:	74 db                	je     80105070 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105095:	83 ec 0c             	sub    $0xc,%esp
80105098:	53                   	push   %ebx
80105099:	e8 f2 c7 ff ff       	call   80101890 <iunlockput>
    goto bad;
8010509e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801050a1:	83 ec 0c             	sub    $0xc,%esp
801050a4:	ff 75 b4             	pushl  -0x4c(%ebp)
801050a7:	e8 e4 c7 ff ff       	call   80101890 <iunlockput>
  end_op();
801050ac:	e8 3f db ff ff       	call   80102bf0 <end_op>
  return -1;
801050b1:	83 c4 10             	add    $0x10,%esp
}
801050b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801050b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050bc:	5b                   	pop    %ebx
801050bd:	5e                   	pop    %esi
801050be:	5f                   	pop    %edi
801050bf:	5d                   	pop    %ebp
801050c0:	c3                   	ret    
801050c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801050c8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801050cb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801050ce:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801050d3:	50                   	push   %eax
801050d4:	e8 97 c4 ff ff       	call   80101570 <iupdate>
801050d9:	83 c4 10             	add    $0x10,%esp
801050dc:	e9 4b ff ff ff       	jmp    8010502c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
801050e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050e6:	e9 6b ff ff ff       	jmp    80105056 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
801050eb:	e8 00 db ff ff       	call   80102bf0 <end_op>
    return -1;
801050f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050f5:	e9 5c ff ff ff       	jmp    80105056 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801050fa:	83 ec 0c             	sub    $0xc,%esp
801050fd:	68 68 78 10 80       	push   $0x80107868
80105102:	e8 69 b2 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105107:	83 ec 0c             	sub    $0xc,%esp
8010510a:	68 7a 78 10 80       	push   $0x8010787a
8010510f:	e8 5c b2 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105114:	83 ec 0c             	sub    $0xc,%esp
80105117:	68 56 78 10 80       	push   $0x80107856
8010511c:	e8 4f b2 ff ff       	call   80100370 <panic>
80105121:	eb 0d                	jmp    80105130 <sys_open>
80105123:	90                   	nop
80105124:	90                   	nop
80105125:	90                   	nop
80105126:	90                   	nop
80105127:	90                   	nop
80105128:	90                   	nop
80105129:	90                   	nop
8010512a:	90                   	nop
8010512b:	90                   	nop
8010512c:	90                   	nop
8010512d:	90                   	nop
8010512e:	90                   	nop
8010512f:	90                   	nop

80105130 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	57                   	push   %edi
80105134:	56                   	push   %esi
80105135:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105136:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105139:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010513c:	50                   	push   %eax
8010513d:	6a 00                	push   $0x0
8010513f:	e8 cc f7 ff ff       	call   80104910 <argstr>
80105144:	83 c4 10             	add    $0x10,%esp
80105147:	85 c0                	test   %eax,%eax
80105149:	0f 88 9e 00 00 00    	js     801051ed <sys_open+0xbd>
8010514f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105152:	83 ec 08             	sub    $0x8,%esp
80105155:	50                   	push   %eax
80105156:	6a 01                	push   $0x1
80105158:	e8 23 f7 ff ff       	call   80104880 <argint>
8010515d:	83 c4 10             	add    $0x10,%esp
80105160:	85 c0                	test   %eax,%eax
80105162:	0f 88 85 00 00 00    	js     801051ed <sys_open+0xbd>
    return -1;

  begin_op();
80105168:	e8 13 da ff ff       	call   80102b80 <begin_op>

  if(omode & O_CREATE){
8010516d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105171:	0f 85 89 00 00 00    	jne    80105200 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105177:	83 ec 0c             	sub    $0xc,%esp
8010517a:	ff 75 e0             	pushl  -0x20(%ebp)
8010517d:	e8 ce cc ff ff       	call   80101e50 <namei>
80105182:	83 c4 10             	add    $0x10,%esp
80105185:	85 c0                	test   %eax,%eax
80105187:	89 c7                	mov    %eax,%edi
80105189:	0f 84 8e 00 00 00    	je     8010521d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010518f:	83 ec 0c             	sub    $0xc,%esp
80105192:	50                   	push   %eax
80105193:	e8 88 c4 ff ff       	call   80101620 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105198:	83 c4 10             	add    $0x10,%esp
8010519b:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
801051a0:	0f 84 d2 00 00 00    	je     80105278 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051a6:	e8 a5 bb ff ff       	call   80100d50 <filealloc>
801051ab:	85 c0                	test   %eax,%eax
801051ad:	89 c6                	mov    %eax,%esi
801051af:	74 2b                	je     801051dc <sys_open+0xac>
801051b1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801051b8:	31 db                	xor    %ebx,%ebx
801051ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
801051c0:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
801051c4:	85 c0                	test   %eax,%eax
801051c6:	74 68                	je     80105230 <sys_open+0x100>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801051c8:	83 c3 01             	add    $0x1,%ebx
801051cb:	83 fb 10             	cmp    $0x10,%ebx
801051ce:	75 f0                	jne    801051c0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801051d0:	83 ec 0c             	sub    $0xc,%esp
801051d3:	56                   	push   %esi
801051d4:	e8 37 bc ff ff       	call   80100e10 <fileclose>
801051d9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801051dc:	83 ec 0c             	sub    $0xc,%esp
801051df:	57                   	push   %edi
801051e0:	e8 ab c6 ff ff       	call   80101890 <iunlockput>
    end_op();
801051e5:	e8 06 da ff ff       	call   80102bf0 <end_op>
    return -1;
801051ea:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801051ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801051f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801051f5:	5b                   	pop    %ebx
801051f6:	5e                   	pop    %esi
801051f7:	5f                   	pop    %edi
801051f8:	5d                   	pop    %ebp
801051f9:	c3                   	ret    
801051fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105200:	83 ec 0c             	sub    $0xc,%esp
80105203:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105206:	31 c9                	xor    %ecx,%ecx
80105208:	6a 00                	push   $0x0
8010520a:	ba 02 00 00 00       	mov    $0x2,%edx
8010520f:	e8 ec f7 ff ff       	call   80104a00 <create>
    if(ip == 0){
80105214:	83 c4 10             	add    $0x10,%esp
80105217:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105219:	89 c7                	mov    %eax,%edi
    if(ip == 0){
8010521b:	75 89                	jne    801051a6 <sys_open+0x76>
      end_op();
8010521d:	e8 ce d9 ff ff       	call   80102bf0 <end_op>
      return -1;
80105222:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105227:	eb 43                	jmp    8010526c <sys_open+0x13c>
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105230:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105233:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105237:	57                   	push   %edi
80105238:	e8 c3 c4 ff ff       	call   80101700 <iunlock>
  end_op();
8010523d:	e8 ae d9 ff ff       	call   80102bf0 <end_op>

  f->type = FD_INODE;
80105242:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105248:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010524b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010524e:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
80105251:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105258:	89 d0                	mov    %edx,%eax
8010525a:	83 e0 01             	and    $0x1,%eax
8010525d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105260:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105263:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105266:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
8010526a:	89 d8                	mov    %ebx,%eax
}
8010526c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010526f:	5b                   	pop    %ebx
80105270:	5e                   	pop    %esi
80105271:	5f                   	pop    %edi
80105272:	5d                   	pop    %ebp
80105273:	c3                   	ret    
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105278:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010527b:	85 d2                	test   %edx,%edx
8010527d:	0f 84 23 ff ff ff    	je     801051a6 <sys_open+0x76>
80105283:	e9 54 ff ff ff       	jmp    801051dc <sys_open+0xac>
80105288:	90                   	nop
80105289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105290 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105296:	e8 e5 d8 ff ff       	call   80102b80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010529b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010529e:	83 ec 08             	sub    $0x8,%esp
801052a1:	50                   	push   %eax
801052a2:	6a 00                	push   $0x0
801052a4:	e8 67 f6 ff ff       	call   80104910 <argstr>
801052a9:	83 c4 10             	add    $0x10,%esp
801052ac:	85 c0                	test   %eax,%eax
801052ae:	78 30                	js     801052e0 <sys_mkdir+0x50>
801052b0:	83 ec 0c             	sub    $0xc,%esp
801052b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052b6:	31 c9                	xor    %ecx,%ecx
801052b8:	6a 00                	push   $0x0
801052ba:	ba 01 00 00 00       	mov    $0x1,%edx
801052bf:	e8 3c f7 ff ff       	call   80104a00 <create>
801052c4:	83 c4 10             	add    $0x10,%esp
801052c7:	85 c0                	test   %eax,%eax
801052c9:	74 15                	je     801052e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052cb:	83 ec 0c             	sub    $0xc,%esp
801052ce:	50                   	push   %eax
801052cf:	e8 bc c5 ff ff       	call   80101890 <iunlockput>
  end_op();
801052d4:	e8 17 d9 ff ff       	call   80102bf0 <end_op>
  return 0;
801052d9:	83 c4 10             	add    $0x10,%esp
801052dc:	31 c0                	xor    %eax,%eax
}
801052de:	c9                   	leave  
801052df:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801052e0:	e8 0b d9 ff ff       	call   80102bf0 <end_op>
    return -1;
801052e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801052ea:	c9                   	leave  
801052eb:	c3                   	ret    
801052ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052f0 <sys_mknod>:

int
sys_mknod(void)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801052f6:	e8 85 d8 ff ff       	call   80102b80 <begin_op>
  if((argstr(0, &path)) < 0 ||
801052fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801052fe:	83 ec 08             	sub    $0x8,%esp
80105301:	50                   	push   %eax
80105302:	6a 00                	push   $0x0
80105304:	e8 07 f6 ff ff       	call   80104910 <argstr>
80105309:	83 c4 10             	add    $0x10,%esp
8010530c:	85 c0                	test   %eax,%eax
8010530e:	78 60                	js     80105370 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105310:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105313:	83 ec 08             	sub    $0x8,%esp
80105316:	50                   	push   %eax
80105317:	6a 01                	push   $0x1
80105319:	e8 62 f5 ff ff       	call   80104880 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010531e:	83 c4 10             	add    $0x10,%esp
80105321:	85 c0                	test   %eax,%eax
80105323:	78 4b                	js     80105370 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105325:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105328:	83 ec 08             	sub    $0x8,%esp
8010532b:	50                   	push   %eax
8010532c:	6a 02                	push   $0x2
8010532e:	e8 4d f5 ff ff       	call   80104880 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	85 c0                	test   %eax,%eax
80105338:	78 36                	js     80105370 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010533a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010533e:	83 ec 0c             	sub    $0xc,%esp
80105341:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105345:	ba 03 00 00 00       	mov    $0x3,%edx
8010534a:	50                   	push   %eax
8010534b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010534e:	e8 ad f6 ff ff       	call   80104a00 <create>
80105353:	83 c4 10             	add    $0x10,%esp
80105356:	85 c0                	test   %eax,%eax
80105358:	74 16                	je     80105370 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010535a:	83 ec 0c             	sub    $0xc,%esp
8010535d:	50                   	push   %eax
8010535e:	e8 2d c5 ff ff       	call   80101890 <iunlockput>
  end_op();
80105363:	e8 88 d8 ff ff       	call   80102bf0 <end_op>
  return 0;
80105368:	83 c4 10             	add    $0x10,%esp
8010536b:	31 c0                	xor    %eax,%eax
}
8010536d:	c9                   	leave  
8010536e:	c3                   	ret    
8010536f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105370:	e8 7b d8 ff ff       	call   80102bf0 <end_op>
    return -1;
80105375:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010537a:	c9                   	leave  
8010537b:	c3                   	ret    
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_chdir>:

int
sys_chdir(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	53                   	push   %ebx
80105384:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105387:	e8 f4 d7 ff ff       	call   80102b80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010538c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010538f:	83 ec 08             	sub    $0x8,%esp
80105392:	50                   	push   %eax
80105393:	6a 00                	push   $0x0
80105395:	e8 76 f5 ff ff       	call   80104910 <argstr>
8010539a:	83 c4 10             	add    $0x10,%esp
8010539d:	85 c0                	test   %eax,%eax
8010539f:	78 7f                	js     80105420 <sys_chdir+0xa0>
801053a1:	83 ec 0c             	sub    $0xc,%esp
801053a4:	ff 75 f4             	pushl  -0xc(%ebp)
801053a7:	e8 a4 ca ff ff       	call   80101e50 <namei>
801053ac:	83 c4 10             	add    $0x10,%esp
801053af:	85 c0                	test   %eax,%eax
801053b1:	89 c3                	mov    %eax,%ebx
801053b3:	74 6b                	je     80105420 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801053b5:	83 ec 0c             	sub    $0xc,%esp
801053b8:	50                   	push   %eax
801053b9:	e8 62 c2 ff ff       	call   80101620 <ilock>
  if(ip->type != T_DIR){
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053c6:	75 38                	jne    80105400 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801053c8:	83 ec 0c             	sub    $0xc,%esp
801053cb:	53                   	push   %ebx
801053cc:	e8 2f c3 ff ff       	call   80101700 <iunlock>
  iput(proc->cwd);
801053d1:	58                   	pop    %eax
801053d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053d8:	ff 70 68             	pushl  0x68(%eax)
801053db:	e8 70 c3 ff ff       	call   80101750 <iput>
  end_op();
801053e0:	e8 0b d8 ff ff       	call   80102bf0 <end_op>
  proc->cwd = ip;
801053e5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
801053eb:	83 c4 10             	add    $0x10,%esp
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
801053ee:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
801053f1:	31 c0                	xor    %eax,%eax
}
801053f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053f6:	c9                   	leave  
801053f7:	c3                   	ret    
801053f8:	90                   	nop
801053f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	53                   	push   %ebx
80105404:	e8 87 c4 ff ff       	call   80101890 <iunlockput>
    end_op();
80105409:	e8 e2 d7 ff ff       	call   80102bf0 <end_op>
    return -1;
8010540e:	83 c4 10             	add    $0x10,%esp
80105411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105416:	eb db                	jmp    801053f3 <sys_chdir+0x73>
80105418:	90                   	nop
80105419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105420:	e8 cb d7 ff ff       	call   80102bf0 <end_op>
    return -1;
80105425:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010542a:	eb c7                	jmp    801053f3 <sys_chdir+0x73>
8010542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105430 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105436:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010543c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105442:	50                   	push   %eax
80105443:	6a 00                	push   $0x0
80105445:	e8 c6 f4 ff ff       	call   80104910 <argstr>
8010544a:	83 c4 10             	add    $0x10,%esp
8010544d:	85 c0                	test   %eax,%eax
8010544f:	78 7f                	js     801054d0 <sys_exec+0xa0>
80105451:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105457:	83 ec 08             	sub    $0x8,%esp
8010545a:	50                   	push   %eax
8010545b:	6a 01                	push   $0x1
8010545d:	e8 1e f4 ff ff       	call   80104880 <argint>
80105462:	83 c4 10             	add    $0x10,%esp
80105465:	85 c0                	test   %eax,%eax
80105467:	78 67                	js     801054d0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105469:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010546f:	83 ec 04             	sub    $0x4,%esp
80105472:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105478:	68 80 00 00 00       	push   $0x80
8010547d:	6a 00                	push   $0x0
8010547f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105485:	50                   	push   %eax
80105486:	31 db                	xor    %ebx,%ebx
80105488:	e8 03 f1 ff ff       	call   80104590 <memset>
8010548d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105490:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105496:	83 ec 08             	sub    $0x8,%esp
80105499:	57                   	push   %edi
8010549a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010549d:	50                   	push   %eax
8010549e:	e8 5d f3 ff ff       	call   80104800 <fetchint>
801054a3:	83 c4 10             	add    $0x10,%esp
801054a6:	85 c0                	test   %eax,%eax
801054a8:	78 26                	js     801054d0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801054aa:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054b0:	85 c0                	test   %eax,%eax
801054b2:	74 2c                	je     801054e0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801054b4:	83 ec 08             	sub    $0x8,%esp
801054b7:	56                   	push   %esi
801054b8:	50                   	push   %eax
801054b9:	e8 72 f3 ff ff       	call   80104830 <fetchstr>
801054be:	83 c4 10             	add    $0x10,%esp
801054c1:	85 c0                	test   %eax,%eax
801054c3:	78 0b                	js     801054d0 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801054c5:	83 c3 01             	add    $0x1,%ebx
801054c8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801054cb:	83 fb 20             	cmp    $0x20,%ebx
801054ce:	75 c0                	jne    80105490 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801054d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801054d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801054d8:	5b                   	pop    %ebx
801054d9:	5e                   	pop    %esi
801054da:	5f                   	pop    %edi
801054db:	5d                   	pop    %ebp
801054dc:	c3                   	ret    
801054dd:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801054e0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054e6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801054e9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801054f0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801054f4:	50                   	push   %eax
801054f5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801054fb:	e8 f0 b4 ff ff       	call   801009f0 <exec>
80105500:	83 c4 10             	add    $0x10,%esp
}
80105503:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105506:	5b                   	pop    %ebx
80105507:	5e                   	pop    %esi
80105508:	5f                   	pop    %edi
80105509:	5d                   	pop    %ebp
8010550a:	c3                   	ret    
8010550b:	90                   	nop
8010550c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105510 <sys_pipe>:

int
sys_pipe(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	57                   	push   %edi
80105514:	56                   	push   %esi
80105515:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105516:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105519:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010551c:	6a 08                	push   $0x8
8010551e:	50                   	push   %eax
8010551f:	6a 00                	push   $0x0
80105521:	e8 9a f3 ff ff       	call   801048c0 <argptr>
80105526:	83 c4 10             	add    $0x10,%esp
80105529:	85 c0                	test   %eax,%eax
8010552b:	78 48                	js     80105575 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010552d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105530:	83 ec 08             	sub    $0x8,%esp
80105533:	50                   	push   %eax
80105534:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105537:	50                   	push   %eax
80105538:	e8 c3 dd ff ff       	call   80103300 <pipealloc>
8010553d:	83 c4 10             	add    $0x10,%esp
80105540:	85 c0                	test   %eax,%eax
80105542:	78 31                	js     80105575 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105544:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105547:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010554e:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
80105550:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
80105554:	85 d2                	test   %edx,%edx
80105556:	74 28                	je     80105580 <sys_pipe+0x70>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105558:	83 c0 01             	add    $0x1,%eax
8010555b:	83 f8 10             	cmp    $0x10,%eax
8010555e:	75 f0                	jne    80105550 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80105560:	83 ec 0c             	sub    $0xc,%esp
80105563:	53                   	push   %ebx
80105564:	e8 a7 b8 ff ff       	call   80100e10 <fileclose>
    fileclose(wf);
80105569:	58                   	pop    %eax
8010556a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010556d:	e8 9e b8 ff ff       	call   80100e10 <fileclose>
    return -1;
80105572:	83 c4 10             	add    $0x10,%esp
80105575:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010557a:	eb 45                	jmp    801055c1 <sys_pipe+0xb1>
8010557c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105580:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105583:	8b 7d e4             	mov    -0x1c(%ebp),%edi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105586:	31 d2                	xor    %edx,%edx
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105588:	89 5e 28             	mov    %ebx,0x28(%esi)
8010558b:	90                   	nop
8010558c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105590:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
80105595:	74 19                	je     801055b0 <sys_pipe+0xa0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105597:	83 c2 01             	add    $0x1,%edx
8010559a:	83 fa 10             	cmp    $0x10,%edx
8010559d:	75 f1                	jne    80105590 <sys_pipe+0x80>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
8010559f:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
801055a6:	eb b8                	jmp    80105560 <sys_pipe+0x50>
801055a8:	90                   	nop
801055a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801055b0:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801055b4:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801055b7:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
801055b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055bc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801055bf:	31 c0                	xor    %eax,%eax
}
801055c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055c4:	5b                   	pop    %ebx
801055c5:	5e                   	pop    %esi
801055c6:	5f                   	pop    %edi
801055c7:	5d                   	pop    %ebp
801055c8:	c3                   	ret    
801055c9:	66 90                	xchg   %ax,%ax
801055cb:	66 90                	xchg   %ax,%ax
801055cd:	66 90                	xchg   %ax,%ax
801055cf:	90                   	nop

801055d0 <sys_fork>:
ID:	2016311477	

*******************/
int
sys_fork(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801055d3:	5d                   	pop    %ebp

*******************/
int
sys_fork(void)
{
  return fork();
801055d4:	e9 b7 e3 ff ff       	jmp    80103990 <fork>
801055d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801055e0 <sys_exit>:
}

int
sys_exit(void)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	83 ec 08             	sub    $0x8,%esp
  exit();
801055e6:	e8 15 e6 ff ff       	call   80103c00 <exit>
  return 0;  // not reached
}
801055eb:	31 c0                	xor    %eax,%eax
801055ed:	c9                   	leave  
801055ee:	c3                   	ret    
801055ef:	90                   	nop

801055f0 <sys_wait>:

int
sys_wait(void)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801055f3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801055f4:	e9 57 e8 ff ff       	jmp    80103e50 <wait>
801055f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105600 <sys_kill>:
}

int
sys_kill(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105606:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105609:	50                   	push   %eax
8010560a:	6a 00                	push   $0x0
8010560c:	e8 6f f2 ff ff       	call   80104880 <argint>
80105611:	83 c4 10             	add    $0x10,%esp
80105614:	85 c0                	test   %eax,%eax
80105616:	78 18                	js     80105630 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105618:	83 ec 0c             	sub    $0xc,%esp
8010561b:	ff 75 f4             	pushl  -0xc(%ebp)
8010561e:	e8 6d e9 ff ff       	call   80103f90 <kill>
80105623:	83 c4 10             	add    $0x10,%esp
}
80105626:	c9                   	leave  
80105627:	c3                   	ret    
80105628:	90                   	nop
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105630:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105635:	c9                   	leave  
80105636:	c3                   	ret    
80105637:	89 f6                	mov    %esi,%esi
80105639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105640 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105640:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
80105646:	55                   	push   %ebp
80105647:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105649:	8b 40 10             	mov    0x10(%eax),%eax
}
8010564c:	5d                   	pop    %ebp
8010564d:	c3                   	ret    
8010564e:	66 90                	xchg   %ax,%ax

80105650 <sys_sbrk>:

int
sys_sbrk(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105654:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return proc->pid;
}

int
sys_sbrk(void)
{
80105657:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010565a:	50                   	push   %eax
8010565b:	6a 00                	push   $0x0
8010565d:	e8 1e f2 ff ff       	call   80104880 <argint>
80105662:	83 c4 10             	add    $0x10,%esp
80105665:	85 c0                	test   %eax,%eax
80105667:	78 27                	js     80105690 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105669:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
8010566f:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
80105672:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105674:	ff 75 f4             	pushl  -0xc(%ebp)
80105677:	e8 a4 e2 ff ff       	call   80103920 <growproc>
8010567c:	83 c4 10             	add    $0x10,%esp
8010567f:	85 c0                	test   %eax,%eax
80105681:	78 0d                	js     80105690 <sys_sbrk+0x40>
    return -1;
  return addr;
80105683:	89 d8                	mov    %ebx,%eax
}
80105685:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105688:	c9                   	leave  
80105689:	c3                   	ret    
8010568a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105690:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105695:	eb ee                	jmp    80105685 <sys_sbrk+0x35>
80105697:	89 f6                	mov    %esi,%esi
80105699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056a0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	83 ec 18             	sub    $0x18,%esp
  int n;
  static uint ticks0;
  static int first=0;

	if(!first){
801056a6:	a1 c4 a5 10 80       	mov    0x8010a5c4,%eax
801056ab:	85 c0                	test   %eax,%eax
801056ad:	0f 84 ad 00 00 00    	je     80105760 <sys_sleep+0xc0>
    acquire(&tickslock);
    ticks0=ticks;
		release(&tickslock);
		first=1;
	}
  if(argint(0, &n) < 0)
801056b3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056b6:	83 ec 08             	sub    $0x8,%esp
801056b9:	50                   	push   %eax
801056ba:	6a 00                	push   $0x0
801056bc:	e8 bf f1 ff ff       	call   80104880 <argint>
801056c1:	83 c4 10             	add    $0x10,%esp
801056c4:	85 c0                	test   %eax,%eax
801056c6:	0f 88 c9 00 00 00    	js     80105795 <sys_sleep+0xf5>
    return -1;
  acquire(&tickslock);
801056cc:	83 ec 0c             	sub    $0xc,%esp
801056cf:	68 e0 4d 11 80       	push   $0x80114de0
801056d4:	e8 87 ec ff ff       	call   80104360 <acquire>
	cprintf("difference: %d\n", ticks-ticks0);
801056d9:	a1 20 56 11 80       	mov    0x80115620,%eax
801056de:	2b 05 c0 a5 10 80    	sub    0x8010a5c0,%eax
801056e4:	5a                   	pop    %edx
801056e5:	59                   	pop    %ecx
801056e6:	50                   	push   %eax
801056e7:	68 89 78 10 80       	push   $0x80107889
801056ec:	e8 6f af ff ff       	call   80100660 <cprintf>
801056f1:	eb 24                	jmp    80105717 <sys_sleep+0x77>
801056f3:	90                   	nop
801056f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  //ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
801056f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056fe:	8b 40 24             	mov    0x24(%eax),%eax
80105701:	85 c0                	test   %eax,%eax
80105703:	75 3b                	jne    80105740 <sys_sleep+0xa0>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105705:	83 ec 08             	sub    $0x8,%esp
80105708:	68 e0 4d 11 80       	push   $0x80114de0
8010570d:	68 20 56 11 80       	push   $0x80115620
80105712:	e8 79 e6 ff ff       	call   80103d90 <sleep>
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
	cprintf("difference: %d\n", ticks-ticks0);
  //ticks0 = ticks;
  while(ticks - ticks0 < n){
80105717:	a1 20 56 11 80       	mov    0x80115620,%eax
8010571c:	2b 05 c0 a5 10 80    	sub    0x8010a5c0,%eax
80105722:	83 c4 10             	add    $0x10,%esp
80105725:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105728:	72 ce                	jb     801056f8 <sys_sleep+0x58>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
8010572a:	83 ec 0c             	sub    $0xc,%esp
8010572d:	68 e0 4d 11 80       	push   $0x80114de0
80105732:	e8 09 ee ff ff       	call   80104540 <release>
  return 0;
80105737:	83 c4 10             	add    $0x10,%esp
8010573a:	31 c0                	xor    %eax,%eax
}
8010573c:	c9                   	leave  
8010573d:	c3                   	ret    
8010573e:	66 90                	xchg   %ax,%ax
  acquire(&tickslock);
	cprintf("difference: %d\n", ticks-ticks0);
  //ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
80105740:	83 ec 0c             	sub    $0xc,%esp
80105743:	68 e0 4d 11 80       	push   $0x80114de0
80105748:	e8 f3 ed ff ff       	call   80104540 <release>
      return -1;
8010574d:	83 c4 10             	add    $0x10,%esp
80105750:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105755:	c9                   	leave  
80105756:	c3                   	ret    
80105757:	89 f6                	mov    %esi,%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int n;
  static uint ticks0;
  static int first=0;

	if(!first){
    acquire(&tickslock);
80105760:	83 ec 0c             	sub    $0xc,%esp
80105763:	68 e0 4d 11 80       	push   $0x80114de0
80105768:	e8 f3 eb ff ff       	call   80104360 <acquire>
    ticks0=ticks;
8010576d:	a1 20 56 11 80       	mov    0x80115620,%eax
		release(&tickslock);
80105772:	c7 04 24 e0 4d 11 80 	movl   $0x80114de0,(%esp)
  static uint ticks0;
  static int first=0;

	if(!first){
    acquire(&tickslock);
    ticks0=ticks;
80105779:	a3 c0 a5 10 80       	mov    %eax,0x8010a5c0
		release(&tickslock);
8010577e:	e8 bd ed ff ff       	call   80104540 <release>
		first=1;
80105783:	c7 05 c4 a5 10 80 01 	movl   $0x1,0x8010a5c4
8010578a:	00 00 00 
8010578d:	83 c4 10             	add    $0x10,%esp
80105790:	e9 1e ff ff ff       	jmp    801056b3 <sys_sleep+0x13>
	}
  if(argint(0, &n) < 0)
    return -1;
80105795:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
8010579a:	c9                   	leave  
8010579b:	c3                   	ret    
8010579c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057a0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	53                   	push   %ebx
801057a4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057a7:	68 e0 4d 11 80       	push   $0x80114de0
801057ac:	e8 af eb ff ff       	call   80104360 <acquire>
  xticks = ticks;
801057b1:	8b 1d 20 56 11 80    	mov    0x80115620,%ebx
  release(&tickslock);
801057b7:	c7 04 24 e0 4d 11 80 	movl   $0x80114de0,(%esp)
801057be:	e8 7d ed ff ff       	call   80104540 <release>
  return xticks;
}
801057c3:	89 d8                	mov    %ebx,%eax
801057c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057c8:	c9                   	leave  
801057c9:	c3                   	ret    
801057ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057d0 <sys_halt>:

int
sys_halt(void)
{
801057d0:	55                   	push   %ebp
}

static inline void
outw(ushort port, ushort data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801057d1:	ba 04 b0 ff ff       	mov    $0xffffb004,%edx
801057d6:	b8 00 20 00 00       	mov    $0x2000,%eax
801057db:	89 e5                	mov    %esp,%ebp
801057dd:	66 ef                	out    %ax,(%dx)
	outw(0xB004, 0x0|0x2000);
  return 0;
}
801057df:	31 c0                	xor    %eax,%eax
801057e1:	5d                   	pop    %ebp
801057e2:	c3                   	ret    
801057e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057f0 <sys_getnice>:
//////////////////////////
int sys_getnice(void){
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	83 ec 20             	sub    $0x20,%esp
  int pid;
  
	if(argint(0, &pid) < 0){
801057f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057f9:	50                   	push   %eax
801057fa:	6a 00                	push   $0x0
801057fc:	e8 7f f0 ff ff       	call   80104880 <argint>
80105801:	83 c4 10             	add    $0x10,%esp
80105804:	85 c0                	test   %eax,%eax
80105806:	78 18                	js     80105820 <sys_getnice+0x30>
		return -1;
	}
	
	return getnice(pid);
80105808:	83 ec 0c             	sub    $0xc,%esp
8010580b:	ff 75 f4             	pushl  -0xc(%ebp)
8010580e:	e8 cd e8 ff ff       	call   801040e0 <getnice>
80105813:	83 c4 10             	add    $0x10,%esp
}
80105816:	c9                   	leave  
80105817:	c3                   	ret    
80105818:	90                   	nop
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
//////////////////////////
int sys_getnice(void){
  int pid;
  
	if(argint(0, &pid) < 0){
		return -1;
80105820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
	}
	
	return getnice(pid);
}
80105825:	c9                   	leave  
80105826:	c3                   	ret    
80105827:	89 f6                	mov    %esi,%esi
80105829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105830 <sys_setnice>:

int sys_setnice(void){
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	83 ec 20             	sub    $0x20,%esp
  int pid, value;
	
	if(argint(0, &pid) < 0 || argint(1, &value) < 0 ){
80105836:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105839:	50                   	push   %eax
8010583a:	6a 00                	push   $0x0
8010583c:	e8 3f f0 ff ff       	call   80104880 <argint>
80105841:	83 c4 10             	add    $0x10,%esp
80105844:	85 c0                	test   %eax,%eax
80105846:	78 28                	js     80105870 <sys_setnice+0x40>
80105848:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010584b:	83 ec 08             	sub    $0x8,%esp
8010584e:	50                   	push   %eax
8010584f:	6a 01                	push   $0x1
80105851:	e8 2a f0 ff ff       	call   80104880 <argint>
80105856:	83 c4 10             	add    $0x10,%esp
80105859:	85 c0                	test   %eax,%eax
8010585b:	78 13                	js     80105870 <sys_setnice+0x40>
		return -1;
	}
	
	return setnice(pid, value);
8010585d:	83 ec 08             	sub    $0x8,%esp
80105860:	ff 75 f4             	pushl  -0xc(%ebp)
80105863:	ff 75 f0             	pushl  -0x10(%ebp)
80105866:	e8 b5 e8 ff ff       	call   80104120 <setnice>
8010586b:	83 c4 10             	add    $0x10,%esp
}
8010586e:	c9                   	leave  
8010586f:	c3                   	ret    

int sys_setnice(void){
  int pid, value;
	
	if(argint(0, &pid) < 0 || argint(1, &value) < 0 ){
		return -1;
80105870:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
	}
	
	return setnice(pid, value);
}
80105875:	c9                   	leave  
80105876:	c3                   	ret    
80105877:	89 f6                	mov    %esi,%esi
80105879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105880 <sys_ps>:

int sys_ps(void){
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	83 ec 20             	sub    $0x20,%esp
  int pid;
	
	if(argint(0, &pid) < 0){
80105886:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105889:	50                   	push   %eax
8010588a:	6a 00                	push   $0x0
8010588c:	e8 ef ef ff ff       	call   80104880 <argint>
80105891:	83 c4 10             	add    $0x10,%esp
80105894:	85 c0                	test   %eax,%eax
80105896:	78 18                	js     801058b0 <sys_ps+0x30>
		return -1;
	}

	ps(pid);
80105898:	83 ec 0c             	sub    $0xc,%esp
8010589b:	ff 75 f4             	pushl  -0xc(%ebp)
8010589e:	e8 bd e8 ff ff       	call   80104160 <ps>
	return 0;
801058a3:	83 c4 10             	add    $0x10,%esp
801058a6:	31 c0                	xor    %eax,%eax
}
801058a8:	c9                   	leave  
801058a9:	c3                   	ret    
801058aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

int sys_ps(void){
  int pid;
	
	if(argint(0, &pid) < 0){
		return -1;
801058b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
	}

	ps(pid);
	return 0;
}
801058b5:	c9                   	leave  
801058b6:	c3                   	ret    
801058b7:	66 90                	xchg   %ax,%ax
801058b9:	66 90                	xchg   %ax,%ax
801058bb:	66 90                	xchg   %ax,%ax
801058bd:	66 90                	xchg   %ax,%ax
801058bf:	90                   	nop

801058c0 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801058c0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801058c1:	ba 43 00 00 00       	mov    $0x43,%edx
801058c6:	b8 34 00 00 00       	mov    $0x34,%eax
801058cb:	89 e5                	mov    %esp,%ebp
801058cd:	83 ec 14             	sub    $0x14,%esp
801058d0:	ee                   	out    %al,(%dx)
801058d1:	ba 40 00 00 00       	mov    $0x40,%edx
801058d6:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
801058db:	ee                   	out    %al,(%dx)
801058dc:	b8 2e 00 00 00       	mov    $0x2e,%eax
801058e1:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
801058e2:	6a 00                	push   $0x0
801058e4:	e8 47 d9 ff ff       	call   80103230 <picenable>
}
801058e9:	83 c4 10             	add    $0x10,%esp
801058ec:	c9                   	leave  
801058ed:	c3                   	ret    

801058ee <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801058ee:	1e                   	push   %ds
  pushl %es
801058ef:	06                   	push   %es
  pushl %fs
801058f0:	0f a0                	push   %fs
  pushl %gs
801058f2:	0f a8                	push   %gs
  pushal
801058f4:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
801058f5:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801058f9:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801058fb:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
801058fd:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105901:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105903:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105905:	54                   	push   %esp
  call trap
80105906:	e8 e5 00 00 00       	call   801059f0 <trap>
  addl $4, %esp
8010590b:	83 c4 04             	add    $0x4,%esp

8010590e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010590e:	61                   	popa   
  popl %gs
8010590f:	0f a9                	pop    %gs
  popl %fs
80105911:	0f a1                	pop    %fs
  popl %es
80105913:	07                   	pop    %es
  popl %ds
80105914:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105915:	83 c4 08             	add    $0x8,%esp
  iret
80105918:	cf                   	iret   
80105919:	66 90                	xchg   %ax,%ax
8010591b:	66 90                	xchg   %ax,%ax
8010591d:	66 90                	xchg   %ax,%ax
8010591f:	90                   	nop

80105920 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105920:	31 c0                	xor    %eax,%eax
80105922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105928:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
8010592f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105934:	c6 04 c5 24 4e 11 80 	movb   $0x0,-0x7feeb1dc(,%eax,8)
8010593b:	00 
8010593c:	66 89 0c c5 22 4e 11 	mov    %cx,-0x7feeb1de(,%eax,8)
80105943:	80 
80105944:	c6 04 c5 25 4e 11 80 	movb   $0x8e,-0x7feeb1db(,%eax,8)
8010594b:	8e 
8010594c:	66 89 14 c5 20 4e 11 	mov    %dx,-0x7feeb1e0(,%eax,8)
80105953:	80 
80105954:	c1 ea 10             	shr    $0x10,%edx
80105957:	66 89 14 c5 26 4e 11 	mov    %dx,-0x7feeb1da(,%eax,8)
8010595e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010595f:	83 c0 01             	add    $0x1,%eax
80105962:	3d 00 01 00 00       	cmp    $0x100,%eax
80105967:	75 bf                	jne    80105928 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105969:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010596a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010596f:	89 e5                	mov    %esp,%ebp
80105971:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105974:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105979:	68 99 78 10 80       	push   $0x80107899
8010597e:	68 e0 4d 11 80       	push   $0x80114de0
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105983:	66 89 15 22 50 11 80 	mov    %dx,0x80115022
8010598a:	c6 05 24 50 11 80 00 	movb   $0x0,0x80115024
80105991:	66 a3 20 50 11 80    	mov    %ax,0x80115020
80105997:	c1 e8 10             	shr    $0x10,%eax
8010599a:	c6 05 25 50 11 80 ef 	movb   $0xef,0x80115025
801059a1:	66 a3 26 50 11 80    	mov    %ax,0x80115026

  initlock(&tickslock, "time");
801059a7:	e8 94 e9 ff ff       	call   80104340 <initlock>
}
801059ac:	83 c4 10             	add    $0x10,%esp
801059af:	c9                   	leave  
801059b0:	c3                   	ret    
801059b1:	eb 0d                	jmp    801059c0 <idtinit>
801059b3:	90                   	nop
801059b4:	90                   	nop
801059b5:	90                   	nop
801059b6:	90                   	nop
801059b7:	90                   	nop
801059b8:	90                   	nop
801059b9:	90                   	nop
801059ba:	90                   	nop
801059bb:	90                   	nop
801059bc:	90                   	nop
801059bd:	90                   	nop
801059be:	90                   	nop
801059bf:	90                   	nop

801059c0 <idtinit>:

void
idtinit(void)
{
801059c0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801059c1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801059c6:	89 e5                	mov    %esp,%ebp
801059c8:	83 ec 10             	sub    $0x10,%esp
801059cb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801059cf:	b8 20 4e 11 80       	mov    $0x80114e20,%eax
801059d4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801059d8:	c1 e8 10             	shr    $0x10,%eax
801059db:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801059df:	8d 45 fa             	lea    -0x6(%ebp),%eax
801059e2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059e5:	c9                   	leave  
801059e6:	c3                   	ret    
801059e7:	89 f6                	mov    %esi,%esi
801059e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059f0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	57                   	push   %edi
801059f4:	56                   	push   %esi
801059f5:	53                   	push   %ebx
801059f6:	83 ec 0c             	sub    $0xc,%esp
801059f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  //int num;

  if(tf->trapno == T_SYSCALL){
801059fc:	8b 43 30             	mov    0x30(%ebx),%eax
801059ff:	83 f8 40             	cmp    $0x40,%eax
80105a02:	0f 84 f8 00 00 00    	je     80105b00 <trap+0x110>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a08:	83 e8 20             	sub    $0x20,%eax
80105a0b:	83 f8 1f             	cmp    $0x1f,%eax
80105a0e:	77 68                	ja     80105a78 <trap+0x88>
80105a10:	ff 24 85 40 79 10 80 	jmp    *-0x7fef86c0(,%eax,4)
80105a17:	89 f6                	mov    %esi,%esi
80105a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105a20:	e8 7b cc ff ff       	call   801026a0 <cpunum>
80105a25:	85 c0                	test   %eax,%eax
80105a27:	0f 84 b3 01 00 00    	je     80105be0 <trap+0x1f0>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105a2d:	e8 0e cd ff ff       	call   80102740 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105a32:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a38:	85 c0                	test   %eax,%eax
80105a3a:	74 2d                	je     80105a69 <trap+0x79>
80105a3c:	8b 50 24             	mov    0x24(%eax),%edx
80105a3f:	85 d2                	test   %edx,%edx
80105a41:	0f 85 86 00 00 00    	jne    80105acd <trap+0xdd>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105a47:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a4b:	0f 84 ef 00 00 00    	je     80105b40 <trap+0x150>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105a51:	8b 40 24             	mov    0x24(%eax),%eax
80105a54:	85 c0                	test   %eax,%eax
80105a56:	74 11                	je     80105a69 <trap+0x79>
80105a58:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a5c:	83 e0 03             	and    $0x3,%eax
80105a5f:	66 83 f8 03          	cmp    $0x3,%ax
80105a63:	0f 84 c1 00 00 00    	je     80105b2a <trap+0x13a>
    exit();
}
80105a69:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a6c:	5b                   	pop    %ebx
80105a6d:	5e                   	pop    %esi
80105a6e:	5f                   	pop    %edi
80105a6f:	5d                   	pop    %ebp
80105a70:	c3                   	ret    
80105a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80105a78:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105a7f:	85 c9                	test   %ecx,%ecx
80105a81:	0f 84 8d 01 00 00    	je     80105c14 <trap+0x224>
80105a87:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105a8b:	0f 84 83 01 00 00    	je     80105c14 <trap+0x224>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a91:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a94:	8b 73 38             	mov    0x38(%ebx),%esi
80105a97:	e8 04 cc ff ff       	call   801026a0 <cpunum>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105a9c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105aa3:	57                   	push   %edi
80105aa4:	56                   	push   %esi
80105aa5:	50                   	push   %eax
80105aa6:	ff 73 34             	pushl  0x34(%ebx)
80105aa9:	ff 73 30             	pushl  0x30(%ebx)
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105aac:	8d 42 6c             	lea    0x6c(%edx),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105aaf:	50                   	push   %eax
80105ab0:	ff 72 10             	pushl  0x10(%edx)
80105ab3:	68 fc 78 10 80       	push   $0x801078fc
80105ab8:	e8 a3 ab ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80105abd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ac3:	83 c4 20             	add    $0x20,%esp
80105ac6:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105acd:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105ad1:	83 e2 03             	and    $0x3,%edx
80105ad4:	66 83 fa 03          	cmp    $0x3,%dx
80105ad8:	0f 85 69 ff ff ff    	jne    80105a47 <trap+0x57>
    exit();
80105ade:	e8 1d e1 ff ff       	call   80103c00 <exit>
80105ae3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105ae9:	85 c0                	test   %eax,%eax
80105aeb:	0f 85 56 ff ff ff    	jne    80105a47 <trap+0x57>
80105af1:	e9 73 ff ff ff       	jmp    80105a69 <trap+0x79>
80105af6:	8d 76 00             	lea    0x0(%esi),%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
trap(struct trapframe *tf)
{
  //int num;

  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
80105b00:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b06:	8b 70 24             	mov    0x24(%eax),%esi
80105b09:	85 f6                	test   %esi,%esi
80105b0b:	0f 85 bf 00 00 00    	jne    80105bd0 <trap+0x1e0>
      exit();
    proc->tf = tf;
80105b11:	89 58 18             	mov    %ebx,0x18(%eax)
		//num=proc->tf->eax;
    syscall();
80105b14:	e8 77 ee ff ff       	call   80104990 <syscall>
		//cprintf("syscall num: %d\n", num);
    if(proc->killed)
80105b19:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b1f:	8b 58 24             	mov    0x24(%eax),%ebx
80105b22:	85 db                	test   %ebx,%ebx
80105b24:	0f 84 3f ff ff ff    	je     80105a69 <trap+0x79>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105b2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b2d:	5b                   	pop    %ebx
80105b2e:	5e                   	pop    %esi
80105b2f:	5f                   	pop    %edi
80105b30:	5d                   	pop    %ebp
    proc->tf = tf;
		//num=proc->tf->eax;
    syscall();
		//cprintf("syscall num: %d\n", num);
    if(proc->killed)
      exit();
80105b31:	e9 ca e0 ff ff       	jmp    80103c00 <exit>
80105b36:	8d 76 00             	lea    0x0(%esi),%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105b40:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105b44:	0f 85 07 ff ff ff    	jne    80105a51 <trap+0x61>
    yield();
80105b4a:	e8 01 e2 ff ff       	call   80103d50 <yield>
80105b4f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b55:	85 c0                	test   %eax,%eax
80105b57:	0f 85 f4 fe ff ff    	jne    80105a51 <trap+0x61>
80105b5d:	e9 07 ff ff ff       	jmp    80105a69 <trap+0x79>
80105b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105b68:	e8 13 ca ff ff       	call   80102580 <kbdintr>
    lapiceoi();
80105b6d:	e8 ce cb ff ff       	call   80102740 <lapiceoi>
    break;
80105b72:	e9 bb fe ff ff       	jmp    80105a32 <trap+0x42>
80105b77:	89 f6                	mov    %esi,%esi
80105b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105b80:	e8 cb 01 00 00       	call   80105d50 <uartintr>
80105b85:	e9 a3 fe ff ff       	jmp    80105a2d <trap+0x3d>
80105b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b90:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b94:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b97:	e8 04 cb ff ff       	call   801026a0 <cpunum>
80105b9c:	57                   	push   %edi
80105b9d:	56                   	push   %esi
80105b9e:	50                   	push   %eax
80105b9f:	68 a4 78 10 80       	push   $0x801078a4
80105ba4:	e8 b7 aa ff ff       	call   80100660 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80105ba9:	e8 92 cb ff ff       	call   80102740 <lapiceoi>
    break;
80105bae:	83 c4 10             	add    $0x10,%esp
80105bb1:	e9 7c fe ff ff       	jmp    80105a32 <trap+0x42>
80105bb6:	8d 76 00             	lea    0x0(%esi),%esi
80105bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105bc0:	e8 2b c4 ff ff       	call   80101ff0 <ideintr>
    lapiceoi();
80105bc5:	e8 76 cb ff ff       	call   80102740 <lapiceoi>
    break;
80105bca:	e9 63 fe ff ff       	jmp    80105a32 <trap+0x42>
80105bcf:	90                   	nop
{
  //int num;

  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
80105bd0:	e8 2b e0 ff ff       	call   80103c00 <exit>
80105bd5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bdb:	e9 31 ff ff ff       	jmp    80105b11 <trap+0x121>
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
80105be0:	83 ec 0c             	sub    $0xc,%esp
80105be3:	68 e0 4d 11 80       	push   $0x80114de0
80105be8:	e8 73 e7 ff ff       	call   80104360 <acquire>
      ticks++;
      wakeup(&ticks);
80105bed:	c7 04 24 20 56 11 80 	movl   $0x80115620,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
      ticks++;
80105bf4:	83 05 20 56 11 80 01 	addl   $0x1,0x80115620
      wakeup(&ticks);
80105bfb:	e8 30 e3 ff ff       	call   80103f30 <wakeup>
      release(&tickslock);
80105c00:	c7 04 24 e0 4d 11 80 	movl   $0x80114de0,(%esp)
80105c07:	e8 34 e9 ff ff       	call   80104540 <release>
80105c0c:	83 c4 10             	add    $0x10,%esp
80105c0f:	e9 19 fe ff ff       	jmp    80105a2d <trap+0x3d>
80105c14:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c17:	8b 73 38             	mov    0x38(%ebx),%esi
80105c1a:	e8 81 ca ff ff       	call   801026a0 <cpunum>
80105c1f:	83 ec 0c             	sub    $0xc,%esp
80105c22:	57                   	push   %edi
80105c23:	56                   	push   %esi
80105c24:	50                   	push   %eax
80105c25:	ff 73 30             	pushl  0x30(%ebx)
80105c28:	68 c8 78 10 80       	push   $0x801078c8
80105c2d:	e8 2e aa ff ff       	call   80100660 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80105c32:	83 c4 14             	add    $0x14,%esp
80105c35:	68 9e 78 10 80       	push   $0x8010789e
80105c3a:	e8 31 a7 ff ff       	call   80100370 <panic>
80105c3f:	90                   	nop

80105c40 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c40:	a1 c8 a5 10 80       	mov    0x8010a5c8,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105c45:	55                   	push   %ebp
80105c46:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c48:	85 c0                	test   %eax,%eax
80105c4a:	74 1c                	je     80105c68 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c4c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c51:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c52:	a8 01                	test   $0x1,%al
80105c54:	74 12                	je     80105c68 <uartgetc+0x28>
80105c56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c5b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c5c:	0f b6 c0             	movzbl %al,%eax
}
80105c5f:	5d                   	pop    %ebp
80105c60:	c3                   	ret    
80105c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105c68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105c6d:	5d                   	pop    %ebp
80105c6e:	c3                   	ret    
80105c6f:	90                   	nop

80105c70 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105c70:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105c71:	31 c9                	xor    %ecx,%ecx
80105c73:	89 c8                	mov    %ecx,%eax
80105c75:	89 e5                	mov    %esp,%ebp
80105c77:	57                   	push   %edi
80105c78:	56                   	push   %esi
80105c79:	53                   	push   %ebx
80105c7a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105c7f:	89 da                	mov    %ebx,%edx
80105c81:	83 ec 0c             	sub    $0xc,%esp
80105c84:	ee                   	out    %al,(%dx)
80105c85:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105c8a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105c8f:	89 fa                	mov    %edi,%edx
80105c91:	ee                   	out    %al,(%dx)
80105c92:	b8 0c 00 00 00       	mov    $0xc,%eax
80105c97:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c9c:	ee                   	out    %al,(%dx)
80105c9d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105ca2:	89 c8                	mov    %ecx,%eax
80105ca4:	89 f2                	mov    %esi,%edx
80105ca6:	ee                   	out    %al,(%dx)
80105ca7:	b8 03 00 00 00       	mov    $0x3,%eax
80105cac:	89 fa                	mov    %edi,%edx
80105cae:	ee                   	out    %al,(%dx)
80105caf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105cb4:	89 c8                	mov    %ecx,%eax
80105cb6:	ee                   	out    %al,(%dx)
80105cb7:	b8 01 00 00 00       	mov    $0x1,%eax
80105cbc:	89 f2                	mov    %esi,%edx
80105cbe:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cbf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cc4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105cc5:	3c ff                	cmp    $0xff,%al
80105cc7:	74 2b                	je     80105cf4 <uartinit+0x84>
    return;
  uart = 1;
80105cc9:	c7 05 c8 a5 10 80 01 	movl   $0x1,0x8010a5c8
80105cd0:	00 00 00 
80105cd3:	89 da                	mov    %ebx,%edx
80105cd5:	ec                   	in     (%dx),%al
80105cd6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cdb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
80105cdc:	83 ec 0c             	sub    $0xc,%esp
80105cdf:	6a 04                	push   $0x4
80105ce1:	e8 4a d5 ff ff       	call   80103230 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105ce6:	58                   	pop    %eax
80105ce7:	5a                   	pop    %edx
80105ce8:	6a 00                	push   $0x0
80105cea:	6a 04                	push   $0x4
80105cec:	e8 5f c5 ff ff       	call   80102250 <ioapicenable>
80105cf1:	83 c4 10             	add    $0x10,%esp
}
80105cf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cf7:	5b                   	pop    %ebx
80105cf8:	5e                   	pop    %esi
80105cf9:	5f                   	pop    %edi
80105cfa:	5d                   	pop    %ebp
80105cfb:	c3                   	ret    
80105cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d00 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105d00:	a1 c8 a5 10 80       	mov    0x8010a5c8,%eax
80105d05:	85 c0                	test   %eax,%eax
80105d07:	74 3f                	je     80105d48 <uartputc+0x48>
  ioapicenable(IRQ_COM1, 0);
}

void
uartputc(int c)
{
80105d09:	55                   	push   %ebp
80105d0a:	89 e5                	mov    %esp,%ebp
80105d0c:	56                   	push   %esi
80105d0d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d12:	53                   	push   %ebx
80105d13:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d18:	eb 18                	jmp    80105d32 <uartputc+0x32>
80105d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105d20:	83 ec 0c             	sub    $0xc,%esp
80105d23:	6a 0a                	push   $0xa
80105d25:	e8 36 ca ff ff       	call   80102760 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d2a:	83 c4 10             	add    $0x10,%esp
80105d2d:	83 eb 01             	sub    $0x1,%ebx
80105d30:	74 07                	je     80105d39 <uartputc+0x39>
80105d32:	89 f2                	mov    %esi,%edx
80105d34:	ec                   	in     (%dx),%al
80105d35:	a8 20                	test   $0x20,%al
80105d37:	74 e7                	je     80105d20 <uartputc+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d39:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d3e:	8b 45 08             	mov    0x8(%ebp),%eax
80105d41:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105d42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d45:	5b                   	pop    %ebx
80105d46:	5e                   	pop    %esi
80105d47:	5d                   	pop    %ebp
80105d48:	f3 c3                	repz ret 
80105d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105d50 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105d56:	68 40 5c 10 80       	push   $0x80105c40
80105d5b:	e8 90 aa ff ff       	call   801007f0 <consoleintr>
}
80105d60:	83 c4 10             	add    $0x10,%esp
80105d63:	c9                   	leave  
80105d64:	c3                   	ret    

80105d65 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105d65:	6a 00                	push   $0x0
  pushl $0
80105d67:	6a 00                	push   $0x0
  jmp alltraps
80105d69:	e9 80 fb ff ff       	jmp    801058ee <alltraps>

80105d6e <vector1>:
.globl vector1
vector1:
  pushl $0
80105d6e:	6a 00                	push   $0x0
  pushl $1
80105d70:	6a 01                	push   $0x1
  jmp alltraps
80105d72:	e9 77 fb ff ff       	jmp    801058ee <alltraps>

80105d77 <vector2>:
.globl vector2
vector2:
  pushl $0
80105d77:	6a 00                	push   $0x0
  pushl $2
80105d79:	6a 02                	push   $0x2
  jmp alltraps
80105d7b:	e9 6e fb ff ff       	jmp    801058ee <alltraps>

80105d80 <vector3>:
.globl vector3
vector3:
  pushl $0
80105d80:	6a 00                	push   $0x0
  pushl $3
80105d82:	6a 03                	push   $0x3
  jmp alltraps
80105d84:	e9 65 fb ff ff       	jmp    801058ee <alltraps>

80105d89 <vector4>:
.globl vector4
vector4:
  pushl $0
80105d89:	6a 00                	push   $0x0
  pushl $4
80105d8b:	6a 04                	push   $0x4
  jmp alltraps
80105d8d:	e9 5c fb ff ff       	jmp    801058ee <alltraps>

80105d92 <vector5>:
.globl vector5
vector5:
  pushl $0
80105d92:	6a 00                	push   $0x0
  pushl $5
80105d94:	6a 05                	push   $0x5
  jmp alltraps
80105d96:	e9 53 fb ff ff       	jmp    801058ee <alltraps>

80105d9b <vector6>:
.globl vector6
vector6:
  pushl $0
80105d9b:	6a 00                	push   $0x0
  pushl $6
80105d9d:	6a 06                	push   $0x6
  jmp alltraps
80105d9f:	e9 4a fb ff ff       	jmp    801058ee <alltraps>

80105da4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105da4:	6a 00                	push   $0x0
  pushl $7
80105da6:	6a 07                	push   $0x7
  jmp alltraps
80105da8:	e9 41 fb ff ff       	jmp    801058ee <alltraps>

80105dad <vector8>:
.globl vector8
vector8:
  pushl $8
80105dad:	6a 08                	push   $0x8
  jmp alltraps
80105daf:	e9 3a fb ff ff       	jmp    801058ee <alltraps>

80105db4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105db4:	6a 00                	push   $0x0
  pushl $9
80105db6:	6a 09                	push   $0x9
  jmp alltraps
80105db8:	e9 31 fb ff ff       	jmp    801058ee <alltraps>

80105dbd <vector10>:
.globl vector10
vector10:
  pushl $10
80105dbd:	6a 0a                	push   $0xa
  jmp alltraps
80105dbf:	e9 2a fb ff ff       	jmp    801058ee <alltraps>

80105dc4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105dc4:	6a 0b                	push   $0xb
  jmp alltraps
80105dc6:	e9 23 fb ff ff       	jmp    801058ee <alltraps>

80105dcb <vector12>:
.globl vector12
vector12:
  pushl $12
80105dcb:	6a 0c                	push   $0xc
  jmp alltraps
80105dcd:	e9 1c fb ff ff       	jmp    801058ee <alltraps>

80105dd2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105dd2:	6a 0d                	push   $0xd
  jmp alltraps
80105dd4:	e9 15 fb ff ff       	jmp    801058ee <alltraps>

80105dd9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105dd9:	6a 0e                	push   $0xe
  jmp alltraps
80105ddb:	e9 0e fb ff ff       	jmp    801058ee <alltraps>

80105de0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105de0:	6a 00                	push   $0x0
  pushl $15
80105de2:	6a 0f                	push   $0xf
  jmp alltraps
80105de4:	e9 05 fb ff ff       	jmp    801058ee <alltraps>

80105de9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105de9:	6a 00                	push   $0x0
  pushl $16
80105deb:	6a 10                	push   $0x10
  jmp alltraps
80105ded:	e9 fc fa ff ff       	jmp    801058ee <alltraps>

80105df2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105df2:	6a 11                	push   $0x11
  jmp alltraps
80105df4:	e9 f5 fa ff ff       	jmp    801058ee <alltraps>

80105df9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105df9:	6a 00                	push   $0x0
  pushl $18
80105dfb:	6a 12                	push   $0x12
  jmp alltraps
80105dfd:	e9 ec fa ff ff       	jmp    801058ee <alltraps>

80105e02 <vector19>:
.globl vector19
vector19:
  pushl $0
80105e02:	6a 00                	push   $0x0
  pushl $19
80105e04:	6a 13                	push   $0x13
  jmp alltraps
80105e06:	e9 e3 fa ff ff       	jmp    801058ee <alltraps>

80105e0b <vector20>:
.globl vector20
vector20:
  pushl $0
80105e0b:	6a 00                	push   $0x0
  pushl $20
80105e0d:	6a 14                	push   $0x14
  jmp alltraps
80105e0f:	e9 da fa ff ff       	jmp    801058ee <alltraps>

80105e14 <vector21>:
.globl vector21
vector21:
  pushl $0
80105e14:	6a 00                	push   $0x0
  pushl $21
80105e16:	6a 15                	push   $0x15
  jmp alltraps
80105e18:	e9 d1 fa ff ff       	jmp    801058ee <alltraps>

80105e1d <vector22>:
.globl vector22
vector22:
  pushl $0
80105e1d:	6a 00                	push   $0x0
  pushl $22
80105e1f:	6a 16                	push   $0x16
  jmp alltraps
80105e21:	e9 c8 fa ff ff       	jmp    801058ee <alltraps>

80105e26 <vector23>:
.globl vector23
vector23:
  pushl $0
80105e26:	6a 00                	push   $0x0
  pushl $23
80105e28:	6a 17                	push   $0x17
  jmp alltraps
80105e2a:	e9 bf fa ff ff       	jmp    801058ee <alltraps>

80105e2f <vector24>:
.globl vector24
vector24:
  pushl $0
80105e2f:	6a 00                	push   $0x0
  pushl $24
80105e31:	6a 18                	push   $0x18
  jmp alltraps
80105e33:	e9 b6 fa ff ff       	jmp    801058ee <alltraps>

80105e38 <vector25>:
.globl vector25
vector25:
  pushl $0
80105e38:	6a 00                	push   $0x0
  pushl $25
80105e3a:	6a 19                	push   $0x19
  jmp alltraps
80105e3c:	e9 ad fa ff ff       	jmp    801058ee <alltraps>

80105e41 <vector26>:
.globl vector26
vector26:
  pushl $0
80105e41:	6a 00                	push   $0x0
  pushl $26
80105e43:	6a 1a                	push   $0x1a
  jmp alltraps
80105e45:	e9 a4 fa ff ff       	jmp    801058ee <alltraps>

80105e4a <vector27>:
.globl vector27
vector27:
  pushl $0
80105e4a:	6a 00                	push   $0x0
  pushl $27
80105e4c:	6a 1b                	push   $0x1b
  jmp alltraps
80105e4e:	e9 9b fa ff ff       	jmp    801058ee <alltraps>

80105e53 <vector28>:
.globl vector28
vector28:
  pushl $0
80105e53:	6a 00                	push   $0x0
  pushl $28
80105e55:	6a 1c                	push   $0x1c
  jmp alltraps
80105e57:	e9 92 fa ff ff       	jmp    801058ee <alltraps>

80105e5c <vector29>:
.globl vector29
vector29:
  pushl $0
80105e5c:	6a 00                	push   $0x0
  pushl $29
80105e5e:	6a 1d                	push   $0x1d
  jmp alltraps
80105e60:	e9 89 fa ff ff       	jmp    801058ee <alltraps>

80105e65 <vector30>:
.globl vector30
vector30:
  pushl $0
80105e65:	6a 00                	push   $0x0
  pushl $30
80105e67:	6a 1e                	push   $0x1e
  jmp alltraps
80105e69:	e9 80 fa ff ff       	jmp    801058ee <alltraps>

80105e6e <vector31>:
.globl vector31
vector31:
  pushl $0
80105e6e:	6a 00                	push   $0x0
  pushl $31
80105e70:	6a 1f                	push   $0x1f
  jmp alltraps
80105e72:	e9 77 fa ff ff       	jmp    801058ee <alltraps>

80105e77 <vector32>:
.globl vector32
vector32:
  pushl $0
80105e77:	6a 00                	push   $0x0
  pushl $32
80105e79:	6a 20                	push   $0x20
  jmp alltraps
80105e7b:	e9 6e fa ff ff       	jmp    801058ee <alltraps>

80105e80 <vector33>:
.globl vector33
vector33:
  pushl $0
80105e80:	6a 00                	push   $0x0
  pushl $33
80105e82:	6a 21                	push   $0x21
  jmp alltraps
80105e84:	e9 65 fa ff ff       	jmp    801058ee <alltraps>

80105e89 <vector34>:
.globl vector34
vector34:
  pushl $0
80105e89:	6a 00                	push   $0x0
  pushl $34
80105e8b:	6a 22                	push   $0x22
  jmp alltraps
80105e8d:	e9 5c fa ff ff       	jmp    801058ee <alltraps>

80105e92 <vector35>:
.globl vector35
vector35:
  pushl $0
80105e92:	6a 00                	push   $0x0
  pushl $35
80105e94:	6a 23                	push   $0x23
  jmp alltraps
80105e96:	e9 53 fa ff ff       	jmp    801058ee <alltraps>

80105e9b <vector36>:
.globl vector36
vector36:
  pushl $0
80105e9b:	6a 00                	push   $0x0
  pushl $36
80105e9d:	6a 24                	push   $0x24
  jmp alltraps
80105e9f:	e9 4a fa ff ff       	jmp    801058ee <alltraps>

80105ea4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105ea4:	6a 00                	push   $0x0
  pushl $37
80105ea6:	6a 25                	push   $0x25
  jmp alltraps
80105ea8:	e9 41 fa ff ff       	jmp    801058ee <alltraps>

80105ead <vector38>:
.globl vector38
vector38:
  pushl $0
80105ead:	6a 00                	push   $0x0
  pushl $38
80105eaf:	6a 26                	push   $0x26
  jmp alltraps
80105eb1:	e9 38 fa ff ff       	jmp    801058ee <alltraps>

80105eb6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105eb6:	6a 00                	push   $0x0
  pushl $39
80105eb8:	6a 27                	push   $0x27
  jmp alltraps
80105eba:	e9 2f fa ff ff       	jmp    801058ee <alltraps>

80105ebf <vector40>:
.globl vector40
vector40:
  pushl $0
80105ebf:	6a 00                	push   $0x0
  pushl $40
80105ec1:	6a 28                	push   $0x28
  jmp alltraps
80105ec3:	e9 26 fa ff ff       	jmp    801058ee <alltraps>

80105ec8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105ec8:	6a 00                	push   $0x0
  pushl $41
80105eca:	6a 29                	push   $0x29
  jmp alltraps
80105ecc:	e9 1d fa ff ff       	jmp    801058ee <alltraps>

80105ed1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105ed1:	6a 00                	push   $0x0
  pushl $42
80105ed3:	6a 2a                	push   $0x2a
  jmp alltraps
80105ed5:	e9 14 fa ff ff       	jmp    801058ee <alltraps>

80105eda <vector43>:
.globl vector43
vector43:
  pushl $0
80105eda:	6a 00                	push   $0x0
  pushl $43
80105edc:	6a 2b                	push   $0x2b
  jmp alltraps
80105ede:	e9 0b fa ff ff       	jmp    801058ee <alltraps>

80105ee3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105ee3:	6a 00                	push   $0x0
  pushl $44
80105ee5:	6a 2c                	push   $0x2c
  jmp alltraps
80105ee7:	e9 02 fa ff ff       	jmp    801058ee <alltraps>

80105eec <vector45>:
.globl vector45
vector45:
  pushl $0
80105eec:	6a 00                	push   $0x0
  pushl $45
80105eee:	6a 2d                	push   $0x2d
  jmp alltraps
80105ef0:	e9 f9 f9 ff ff       	jmp    801058ee <alltraps>

80105ef5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105ef5:	6a 00                	push   $0x0
  pushl $46
80105ef7:	6a 2e                	push   $0x2e
  jmp alltraps
80105ef9:	e9 f0 f9 ff ff       	jmp    801058ee <alltraps>

80105efe <vector47>:
.globl vector47
vector47:
  pushl $0
80105efe:	6a 00                	push   $0x0
  pushl $47
80105f00:	6a 2f                	push   $0x2f
  jmp alltraps
80105f02:	e9 e7 f9 ff ff       	jmp    801058ee <alltraps>

80105f07 <vector48>:
.globl vector48
vector48:
  pushl $0
80105f07:	6a 00                	push   $0x0
  pushl $48
80105f09:	6a 30                	push   $0x30
  jmp alltraps
80105f0b:	e9 de f9 ff ff       	jmp    801058ee <alltraps>

80105f10 <vector49>:
.globl vector49
vector49:
  pushl $0
80105f10:	6a 00                	push   $0x0
  pushl $49
80105f12:	6a 31                	push   $0x31
  jmp alltraps
80105f14:	e9 d5 f9 ff ff       	jmp    801058ee <alltraps>

80105f19 <vector50>:
.globl vector50
vector50:
  pushl $0
80105f19:	6a 00                	push   $0x0
  pushl $50
80105f1b:	6a 32                	push   $0x32
  jmp alltraps
80105f1d:	e9 cc f9 ff ff       	jmp    801058ee <alltraps>

80105f22 <vector51>:
.globl vector51
vector51:
  pushl $0
80105f22:	6a 00                	push   $0x0
  pushl $51
80105f24:	6a 33                	push   $0x33
  jmp alltraps
80105f26:	e9 c3 f9 ff ff       	jmp    801058ee <alltraps>

80105f2b <vector52>:
.globl vector52
vector52:
  pushl $0
80105f2b:	6a 00                	push   $0x0
  pushl $52
80105f2d:	6a 34                	push   $0x34
  jmp alltraps
80105f2f:	e9 ba f9 ff ff       	jmp    801058ee <alltraps>

80105f34 <vector53>:
.globl vector53
vector53:
  pushl $0
80105f34:	6a 00                	push   $0x0
  pushl $53
80105f36:	6a 35                	push   $0x35
  jmp alltraps
80105f38:	e9 b1 f9 ff ff       	jmp    801058ee <alltraps>

80105f3d <vector54>:
.globl vector54
vector54:
  pushl $0
80105f3d:	6a 00                	push   $0x0
  pushl $54
80105f3f:	6a 36                	push   $0x36
  jmp alltraps
80105f41:	e9 a8 f9 ff ff       	jmp    801058ee <alltraps>

80105f46 <vector55>:
.globl vector55
vector55:
  pushl $0
80105f46:	6a 00                	push   $0x0
  pushl $55
80105f48:	6a 37                	push   $0x37
  jmp alltraps
80105f4a:	e9 9f f9 ff ff       	jmp    801058ee <alltraps>

80105f4f <vector56>:
.globl vector56
vector56:
  pushl $0
80105f4f:	6a 00                	push   $0x0
  pushl $56
80105f51:	6a 38                	push   $0x38
  jmp alltraps
80105f53:	e9 96 f9 ff ff       	jmp    801058ee <alltraps>

80105f58 <vector57>:
.globl vector57
vector57:
  pushl $0
80105f58:	6a 00                	push   $0x0
  pushl $57
80105f5a:	6a 39                	push   $0x39
  jmp alltraps
80105f5c:	e9 8d f9 ff ff       	jmp    801058ee <alltraps>

80105f61 <vector58>:
.globl vector58
vector58:
  pushl $0
80105f61:	6a 00                	push   $0x0
  pushl $58
80105f63:	6a 3a                	push   $0x3a
  jmp alltraps
80105f65:	e9 84 f9 ff ff       	jmp    801058ee <alltraps>

80105f6a <vector59>:
.globl vector59
vector59:
  pushl $0
80105f6a:	6a 00                	push   $0x0
  pushl $59
80105f6c:	6a 3b                	push   $0x3b
  jmp alltraps
80105f6e:	e9 7b f9 ff ff       	jmp    801058ee <alltraps>

80105f73 <vector60>:
.globl vector60
vector60:
  pushl $0
80105f73:	6a 00                	push   $0x0
  pushl $60
80105f75:	6a 3c                	push   $0x3c
  jmp alltraps
80105f77:	e9 72 f9 ff ff       	jmp    801058ee <alltraps>

80105f7c <vector61>:
.globl vector61
vector61:
  pushl $0
80105f7c:	6a 00                	push   $0x0
  pushl $61
80105f7e:	6a 3d                	push   $0x3d
  jmp alltraps
80105f80:	e9 69 f9 ff ff       	jmp    801058ee <alltraps>

80105f85 <vector62>:
.globl vector62
vector62:
  pushl $0
80105f85:	6a 00                	push   $0x0
  pushl $62
80105f87:	6a 3e                	push   $0x3e
  jmp alltraps
80105f89:	e9 60 f9 ff ff       	jmp    801058ee <alltraps>

80105f8e <vector63>:
.globl vector63
vector63:
  pushl $0
80105f8e:	6a 00                	push   $0x0
  pushl $63
80105f90:	6a 3f                	push   $0x3f
  jmp alltraps
80105f92:	e9 57 f9 ff ff       	jmp    801058ee <alltraps>

80105f97 <vector64>:
.globl vector64
vector64:
  pushl $0
80105f97:	6a 00                	push   $0x0
  pushl $64
80105f99:	6a 40                	push   $0x40
  jmp alltraps
80105f9b:	e9 4e f9 ff ff       	jmp    801058ee <alltraps>

80105fa0 <vector65>:
.globl vector65
vector65:
  pushl $0
80105fa0:	6a 00                	push   $0x0
  pushl $65
80105fa2:	6a 41                	push   $0x41
  jmp alltraps
80105fa4:	e9 45 f9 ff ff       	jmp    801058ee <alltraps>

80105fa9 <vector66>:
.globl vector66
vector66:
  pushl $0
80105fa9:	6a 00                	push   $0x0
  pushl $66
80105fab:	6a 42                	push   $0x42
  jmp alltraps
80105fad:	e9 3c f9 ff ff       	jmp    801058ee <alltraps>

80105fb2 <vector67>:
.globl vector67
vector67:
  pushl $0
80105fb2:	6a 00                	push   $0x0
  pushl $67
80105fb4:	6a 43                	push   $0x43
  jmp alltraps
80105fb6:	e9 33 f9 ff ff       	jmp    801058ee <alltraps>

80105fbb <vector68>:
.globl vector68
vector68:
  pushl $0
80105fbb:	6a 00                	push   $0x0
  pushl $68
80105fbd:	6a 44                	push   $0x44
  jmp alltraps
80105fbf:	e9 2a f9 ff ff       	jmp    801058ee <alltraps>

80105fc4 <vector69>:
.globl vector69
vector69:
  pushl $0
80105fc4:	6a 00                	push   $0x0
  pushl $69
80105fc6:	6a 45                	push   $0x45
  jmp alltraps
80105fc8:	e9 21 f9 ff ff       	jmp    801058ee <alltraps>

80105fcd <vector70>:
.globl vector70
vector70:
  pushl $0
80105fcd:	6a 00                	push   $0x0
  pushl $70
80105fcf:	6a 46                	push   $0x46
  jmp alltraps
80105fd1:	e9 18 f9 ff ff       	jmp    801058ee <alltraps>

80105fd6 <vector71>:
.globl vector71
vector71:
  pushl $0
80105fd6:	6a 00                	push   $0x0
  pushl $71
80105fd8:	6a 47                	push   $0x47
  jmp alltraps
80105fda:	e9 0f f9 ff ff       	jmp    801058ee <alltraps>

80105fdf <vector72>:
.globl vector72
vector72:
  pushl $0
80105fdf:	6a 00                	push   $0x0
  pushl $72
80105fe1:	6a 48                	push   $0x48
  jmp alltraps
80105fe3:	e9 06 f9 ff ff       	jmp    801058ee <alltraps>

80105fe8 <vector73>:
.globl vector73
vector73:
  pushl $0
80105fe8:	6a 00                	push   $0x0
  pushl $73
80105fea:	6a 49                	push   $0x49
  jmp alltraps
80105fec:	e9 fd f8 ff ff       	jmp    801058ee <alltraps>

80105ff1 <vector74>:
.globl vector74
vector74:
  pushl $0
80105ff1:	6a 00                	push   $0x0
  pushl $74
80105ff3:	6a 4a                	push   $0x4a
  jmp alltraps
80105ff5:	e9 f4 f8 ff ff       	jmp    801058ee <alltraps>

80105ffa <vector75>:
.globl vector75
vector75:
  pushl $0
80105ffa:	6a 00                	push   $0x0
  pushl $75
80105ffc:	6a 4b                	push   $0x4b
  jmp alltraps
80105ffe:	e9 eb f8 ff ff       	jmp    801058ee <alltraps>

80106003 <vector76>:
.globl vector76
vector76:
  pushl $0
80106003:	6a 00                	push   $0x0
  pushl $76
80106005:	6a 4c                	push   $0x4c
  jmp alltraps
80106007:	e9 e2 f8 ff ff       	jmp    801058ee <alltraps>

8010600c <vector77>:
.globl vector77
vector77:
  pushl $0
8010600c:	6a 00                	push   $0x0
  pushl $77
8010600e:	6a 4d                	push   $0x4d
  jmp alltraps
80106010:	e9 d9 f8 ff ff       	jmp    801058ee <alltraps>

80106015 <vector78>:
.globl vector78
vector78:
  pushl $0
80106015:	6a 00                	push   $0x0
  pushl $78
80106017:	6a 4e                	push   $0x4e
  jmp alltraps
80106019:	e9 d0 f8 ff ff       	jmp    801058ee <alltraps>

8010601e <vector79>:
.globl vector79
vector79:
  pushl $0
8010601e:	6a 00                	push   $0x0
  pushl $79
80106020:	6a 4f                	push   $0x4f
  jmp alltraps
80106022:	e9 c7 f8 ff ff       	jmp    801058ee <alltraps>

80106027 <vector80>:
.globl vector80
vector80:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $80
80106029:	6a 50                	push   $0x50
  jmp alltraps
8010602b:	e9 be f8 ff ff       	jmp    801058ee <alltraps>

80106030 <vector81>:
.globl vector81
vector81:
  pushl $0
80106030:	6a 00                	push   $0x0
  pushl $81
80106032:	6a 51                	push   $0x51
  jmp alltraps
80106034:	e9 b5 f8 ff ff       	jmp    801058ee <alltraps>

80106039 <vector82>:
.globl vector82
vector82:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $82
8010603b:	6a 52                	push   $0x52
  jmp alltraps
8010603d:	e9 ac f8 ff ff       	jmp    801058ee <alltraps>

80106042 <vector83>:
.globl vector83
vector83:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $83
80106044:	6a 53                	push   $0x53
  jmp alltraps
80106046:	e9 a3 f8 ff ff       	jmp    801058ee <alltraps>

8010604b <vector84>:
.globl vector84
vector84:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $84
8010604d:	6a 54                	push   $0x54
  jmp alltraps
8010604f:	e9 9a f8 ff ff       	jmp    801058ee <alltraps>

80106054 <vector85>:
.globl vector85
vector85:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $85
80106056:	6a 55                	push   $0x55
  jmp alltraps
80106058:	e9 91 f8 ff ff       	jmp    801058ee <alltraps>

8010605d <vector86>:
.globl vector86
vector86:
  pushl $0
8010605d:	6a 00                	push   $0x0
  pushl $86
8010605f:	6a 56                	push   $0x56
  jmp alltraps
80106061:	e9 88 f8 ff ff       	jmp    801058ee <alltraps>

80106066 <vector87>:
.globl vector87
vector87:
  pushl $0
80106066:	6a 00                	push   $0x0
  pushl $87
80106068:	6a 57                	push   $0x57
  jmp alltraps
8010606a:	e9 7f f8 ff ff       	jmp    801058ee <alltraps>

8010606f <vector88>:
.globl vector88
vector88:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $88
80106071:	6a 58                	push   $0x58
  jmp alltraps
80106073:	e9 76 f8 ff ff       	jmp    801058ee <alltraps>

80106078 <vector89>:
.globl vector89
vector89:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $89
8010607a:	6a 59                	push   $0x59
  jmp alltraps
8010607c:	e9 6d f8 ff ff       	jmp    801058ee <alltraps>

80106081 <vector90>:
.globl vector90
vector90:
  pushl $0
80106081:	6a 00                	push   $0x0
  pushl $90
80106083:	6a 5a                	push   $0x5a
  jmp alltraps
80106085:	e9 64 f8 ff ff       	jmp    801058ee <alltraps>

8010608a <vector91>:
.globl vector91
vector91:
  pushl $0
8010608a:	6a 00                	push   $0x0
  pushl $91
8010608c:	6a 5b                	push   $0x5b
  jmp alltraps
8010608e:	e9 5b f8 ff ff       	jmp    801058ee <alltraps>

80106093 <vector92>:
.globl vector92
vector92:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $92
80106095:	6a 5c                	push   $0x5c
  jmp alltraps
80106097:	e9 52 f8 ff ff       	jmp    801058ee <alltraps>

8010609c <vector93>:
.globl vector93
vector93:
  pushl $0
8010609c:	6a 00                	push   $0x0
  pushl $93
8010609e:	6a 5d                	push   $0x5d
  jmp alltraps
801060a0:	e9 49 f8 ff ff       	jmp    801058ee <alltraps>

801060a5 <vector94>:
.globl vector94
vector94:
  pushl $0
801060a5:	6a 00                	push   $0x0
  pushl $94
801060a7:	6a 5e                	push   $0x5e
  jmp alltraps
801060a9:	e9 40 f8 ff ff       	jmp    801058ee <alltraps>

801060ae <vector95>:
.globl vector95
vector95:
  pushl $0
801060ae:	6a 00                	push   $0x0
  pushl $95
801060b0:	6a 5f                	push   $0x5f
  jmp alltraps
801060b2:	e9 37 f8 ff ff       	jmp    801058ee <alltraps>

801060b7 <vector96>:
.globl vector96
vector96:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $96
801060b9:	6a 60                	push   $0x60
  jmp alltraps
801060bb:	e9 2e f8 ff ff       	jmp    801058ee <alltraps>

801060c0 <vector97>:
.globl vector97
vector97:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $97
801060c2:	6a 61                	push   $0x61
  jmp alltraps
801060c4:	e9 25 f8 ff ff       	jmp    801058ee <alltraps>

801060c9 <vector98>:
.globl vector98
vector98:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $98
801060cb:	6a 62                	push   $0x62
  jmp alltraps
801060cd:	e9 1c f8 ff ff       	jmp    801058ee <alltraps>

801060d2 <vector99>:
.globl vector99
vector99:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $99
801060d4:	6a 63                	push   $0x63
  jmp alltraps
801060d6:	e9 13 f8 ff ff       	jmp    801058ee <alltraps>

801060db <vector100>:
.globl vector100
vector100:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $100
801060dd:	6a 64                	push   $0x64
  jmp alltraps
801060df:	e9 0a f8 ff ff       	jmp    801058ee <alltraps>

801060e4 <vector101>:
.globl vector101
vector101:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $101
801060e6:	6a 65                	push   $0x65
  jmp alltraps
801060e8:	e9 01 f8 ff ff       	jmp    801058ee <alltraps>

801060ed <vector102>:
.globl vector102
vector102:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $102
801060ef:	6a 66                	push   $0x66
  jmp alltraps
801060f1:	e9 f8 f7 ff ff       	jmp    801058ee <alltraps>

801060f6 <vector103>:
.globl vector103
vector103:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $103
801060f8:	6a 67                	push   $0x67
  jmp alltraps
801060fa:	e9 ef f7 ff ff       	jmp    801058ee <alltraps>

801060ff <vector104>:
.globl vector104
vector104:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $104
80106101:	6a 68                	push   $0x68
  jmp alltraps
80106103:	e9 e6 f7 ff ff       	jmp    801058ee <alltraps>

80106108 <vector105>:
.globl vector105
vector105:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $105
8010610a:	6a 69                	push   $0x69
  jmp alltraps
8010610c:	e9 dd f7 ff ff       	jmp    801058ee <alltraps>

80106111 <vector106>:
.globl vector106
vector106:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $106
80106113:	6a 6a                	push   $0x6a
  jmp alltraps
80106115:	e9 d4 f7 ff ff       	jmp    801058ee <alltraps>

8010611a <vector107>:
.globl vector107
vector107:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $107
8010611c:	6a 6b                	push   $0x6b
  jmp alltraps
8010611e:	e9 cb f7 ff ff       	jmp    801058ee <alltraps>

80106123 <vector108>:
.globl vector108
vector108:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $108
80106125:	6a 6c                	push   $0x6c
  jmp alltraps
80106127:	e9 c2 f7 ff ff       	jmp    801058ee <alltraps>

8010612c <vector109>:
.globl vector109
vector109:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $109
8010612e:	6a 6d                	push   $0x6d
  jmp alltraps
80106130:	e9 b9 f7 ff ff       	jmp    801058ee <alltraps>

80106135 <vector110>:
.globl vector110
vector110:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $110
80106137:	6a 6e                	push   $0x6e
  jmp alltraps
80106139:	e9 b0 f7 ff ff       	jmp    801058ee <alltraps>

8010613e <vector111>:
.globl vector111
vector111:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $111
80106140:	6a 6f                	push   $0x6f
  jmp alltraps
80106142:	e9 a7 f7 ff ff       	jmp    801058ee <alltraps>

80106147 <vector112>:
.globl vector112
vector112:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $112
80106149:	6a 70                	push   $0x70
  jmp alltraps
8010614b:	e9 9e f7 ff ff       	jmp    801058ee <alltraps>

80106150 <vector113>:
.globl vector113
vector113:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $113
80106152:	6a 71                	push   $0x71
  jmp alltraps
80106154:	e9 95 f7 ff ff       	jmp    801058ee <alltraps>

80106159 <vector114>:
.globl vector114
vector114:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $114
8010615b:	6a 72                	push   $0x72
  jmp alltraps
8010615d:	e9 8c f7 ff ff       	jmp    801058ee <alltraps>

80106162 <vector115>:
.globl vector115
vector115:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $115
80106164:	6a 73                	push   $0x73
  jmp alltraps
80106166:	e9 83 f7 ff ff       	jmp    801058ee <alltraps>

8010616b <vector116>:
.globl vector116
vector116:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $116
8010616d:	6a 74                	push   $0x74
  jmp alltraps
8010616f:	e9 7a f7 ff ff       	jmp    801058ee <alltraps>

80106174 <vector117>:
.globl vector117
vector117:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $117
80106176:	6a 75                	push   $0x75
  jmp alltraps
80106178:	e9 71 f7 ff ff       	jmp    801058ee <alltraps>

8010617d <vector118>:
.globl vector118
vector118:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $118
8010617f:	6a 76                	push   $0x76
  jmp alltraps
80106181:	e9 68 f7 ff ff       	jmp    801058ee <alltraps>

80106186 <vector119>:
.globl vector119
vector119:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $119
80106188:	6a 77                	push   $0x77
  jmp alltraps
8010618a:	e9 5f f7 ff ff       	jmp    801058ee <alltraps>

8010618f <vector120>:
.globl vector120
vector120:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $120
80106191:	6a 78                	push   $0x78
  jmp alltraps
80106193:	e9 56 f7 ff ff       	jmp    801058ee <alltraps>

80106198 <vector121>:
.globl vector121
vector121:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $121
8010619a:	6a 79                	push   $0x79
  jmp alltraps
8010619c:	e9 4d f7 ff ff       	jmp    801058ee <alltraps>

801061a1 <vector122>:
.globl vector122
vector122:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $122
801061a3:	6a 7a                	push   $0x7a
  jmp alltraps
801061a5:	e9 44 f7 ff ff       	jmp    801058ee <alltraps>

801061aa <vector123>:
.globl vector123
vector123:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $123
801061ac:	6a 7b                	push   $0x7b
  jmp alltraps
801061ae:	e9 3b f7 ff ff       	jmp    801058ee <alltraps>

801061b3 <vector124>:
.globl vector124
vector124:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $124
801061b5:	6a 7c                	push   $0x7c
  jmp alltraps
801061b7:	e9 32 f7 ff ff       	jmp    801058ee <alltraps>

801061bc <vector125>:
.globl vector125
vector125:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $125
801061be:	6a 7d                	push   $0x7d
  jmp alltraps
801061c0:	e9 29 f7 ff ff       	jmp    801058ee <alltraps>

801061c5 <vector126>:
.globl vector126
vector126:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $126
801061c7:	6a 7e                	push   $0x7e
  jmp alltraps
801061c9:	e9 20 f7 ff ff       	jmp    801058ee <alltraps>

801061ce <vector127>:
.globl vector127
vector127:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $127
801061d0:	6a 7f                	push   $0x7f
  jmp alltraps
801061d2:	e9 17 f7 ff ff       	jmp    801058ee <alltraps>

801061d7 <vector128>:
.globl vector128
vector128:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $128
801061d9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801061de:	e9 0b f7 ff ff       	jmp    801058ee <alltraps>

801061e3 <vector129>:
.globl vector129
vector129:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $129
801061e5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801061ea:	e9 ff f6 ff ff       	jmp    801058ee <alltraps>

801061ef <vector130>:
.globl vector130
vector130:
  pushl $0
801061ef:	6a 00                	push   $0x0
  pushl $130
801061f1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801061f6:	e9 f3 f6 ff ff       	jmp    801058ee <alltraps>

801061fb <vector131>:
.globl vector131
vector131:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $131
801061fd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106202:	e9 e7 f6 ff ff       	jmp    801058ee <alltraps>

80106207 <vector132>:
.globl vector132
vector132:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $132
80106209:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010620e:	e9 db f6 ff ff       	jmp    801058ee <alltraps>

80106213 <vector133>:
.globl vector133
vector133:
  pushl $0
80106213:	6a 00                	push   $0x0
  pushl $133
80106215:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010621a:	e9 cf f6 ff ff       	jmp    801058ee <alltraps>

8010621f <vector134>:
.globl vector134
vector134:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $134
80106221:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106226:	e9 c3 f6 ff ff       	jmp    801058ee <alltraps>

8010622b <vector135>:
.globl vector135
vector135:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $135
8010622d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106232:	e9 b7 f6 ff ff       	jmp    801058ee <alltraps>

80106237 <vector136>:
.globl vector136
vector136:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $136
80106239:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010623e:	e9 ab f6 ff ff       	jmp    801058ee <alltraps>

80106243 <vector137>:
.globl vector137
vector137:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $137
80106245:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010624a:	e9 9f f6 ff ff       	jmp    801058ee <alltraps>

8010624f <vector138>:
.globl vector138
vector138:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $138
80106251:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106256:	e9 93 f6 ff ff       	jmp    801058ee <alltraps>

8010625b <vector139>:
.globl vector139
vector139:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $139
8010625d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106262:	e9 87 f6 ff ff       	jmp    801058ee <alltraps>

80106267 <vector140>:
.globl vector140
vector140:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $140
80106269:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010626e:	e9 7b f6 ff ff       	jmp    801058ee <alltraps>

80106273 <vector141>:
.globl vector141
vector141:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $141
80106275:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010627a:	e9 6f f6 ff ff       	jmp    801058ee <alltraps>

8010627f <vector142>:
.globl vector142
vector142:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $142
80106281:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106286:	e9 63 f6 ff ff       	jmp    801058ee <alltraps>

8010628b <vector143>:
.globl vector143
vector143:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $143
8010628d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106292:	e9 57 f6 ff ff       	jmp    801058ee <alltraps>

80106297 <vector144>:
.globl vector144
vector144:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $144
80106299:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010629e:	e9 4b f6 ff ff       	jmp    801058ee <alltraps>

801062a3 <vector145>:
.globl vector145
vector145:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $145
801062a5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801062aa:	e9 3f f6 ff ff       	jmp    801058ee <alltraps>

801062af <vector146>:
.globl vector146
vector146:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $146
801062b1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801062b6:	e9 33 f6 ff ff       	jmp    801058ee <alltraps>

801062bb <vector147>:
.globl vector147
vector147:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $147
801062bd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801062c2:	e9 27 f6 ff ff       	jmp    801058ee <alltraps>

801062c7 <vector148>:
.globl vector148
vector148:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $148
801062c9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801062ce:	e9 1b f6 ff ff       	jmp    801058ee <alltraps>

801062d3 <vector149>:
.globl vector149
vector149:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $149
801062d5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801062da:	e9 0f f6 ff ff       	jmp    801058ee <alltraps>

801062df <vector150>:
.globl vector150
vector150:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $150
801062e1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801062e6:	e9 03 f6 ff ff       	jmp    801058ee <alltraps>

801062eb <vector151>:
.globl vector151
vector151:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $151
801062ed:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801062f2:	e9 f7 f5 ff ff       	jmp    801058ee <alltraps>

801062f7 <vector152>:
.globl vector152
vector152:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $152
801062f9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801062fe:	e9 eb f5 ff ff       	jmp    801058ee <alltraps>

80106303 <vector153>:
.globl vector153
vector153:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $153
80106305:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010630a:	e9 df f5 ff ff       	jmp    801058ee <alltraps>

8010630f <vector154>:
.globl vector154
vector154:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $154
80106311:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106316:	e9 d3 f5 ff ff       	jmp    801058ee <alltraps>

8010631b <vector155>:
.globl vector155
vector155:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $155
8010631d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106322:	e9 c7 f5 ff ff       	jmp    801058ee <alltraps>

80106327 <vector156>:
.globl vector156
vector156:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $156
80106329:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010632e:	e9 bb f5 ff ff       	jmp    801058ee <alltraps>

80106333 <vector157>:
.globl vector157
vector157:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $157
80106335:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010633a:	e9 af f5 ff ff       	jmp    801058ee <alltraps>

8010633f <vector158>:
.globl vector158
vector158:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $158
80106341:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106346:	e9 a3 f5 ff ff       	jmp    801058ee <alltraps>

8010634b <vector159>:
.globl vector159
vector159:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $159
8010634d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106352:	e9 97 f5 ff ff       	jmp    801058ee <alltraps>

80106357 <vector160>:
.globl vector160
vector160:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $160
80106359:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010635e:	e9 8b f5 ff ff       	jmp    801058ee <alltraps>

80106363 <vector161>:
.globl vector161
vector161:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $161
80106365:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010636a:	e9 7f f5 ff ff       	jmp    801058ee <alltraps>

8010636f <vector162>:
.globl vector162
vector162:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $162
80106371:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106376:	e9 73 f5 ff ff       	jmp    801058ee <alltraps>

8010637b <vector163>:
.globl vector163
vector163:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $163
8010637d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106382:	e9 67 f5 ff ff       	jmp    801058ee <alltraps>

80106387 <vector164>:
.globl vector164
vector164:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $164
80106389:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010638e:	e9 5b f5 ff ff       	jmp    801058ee <alltraps>

80106393 <vector165>:
.globl vector165
vector165:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $165
80106395:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010639a:	e9 4f f5 ff ff       	jmp    801058ee <alltraps>

8010639f <vector166>:
.globl vector166
vector166:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $166
801063a1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801063a6:	e9 43 f5 ff ff       	jmp    801058ee <alltraps>

801063ab <vector167>:
.globl vector167
vector167:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $167
801063ad:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801063b2:	e9 37 f5 ff ff       	jmp    801058ee <alltraps>

801063b7 <vector168>:
.globl vector168
vector168:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $168
801063b9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801063be:	e9 2b f5 ff ff       	jmp    801058ee <alltraps>

801063c3 <vector169>:
.globl vector169
vector169:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $169
801063c5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801063ca:	e9 1f f5 ff ff       	jmp    801058ee <alltraps>

801063cf <vector170>:
.globl vector170
vector170:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $170
801063d1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801063d6:	e9 13 f5 ff ff       	jmp    801058ee <alltraps>

801063db <vector171>:
.globl vector171
vector171:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $171
801063dd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801063e2:	e9 07 f5 ff ff       	jmp    801058ee <alltraps>

801063e7 <vector172>:
.globl vector172
vector172:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $172
801063e9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801063ee:	e9 fb f4 ff ff       	jmp    801058ee <alltraps>

801063f3 <vector173>:
.globl vector173
vector173:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $173
801063f5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801063fa:	e9 ef f4 ff ff       	jmp    801058ee <alltraps>

801063ff <vector174>:
.globl vector174
vector174:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $174
80106401:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106406:	e9 e3 f4 ff ff       	jmp    801058ee <alltraps>

8010640b <vector175>:
.globl vector175
vector175:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $175
8010640d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106412:	e9 d7 f4 ff ff       	jmp    801058ee <alltraps>

80106417 <vector176>:
.globl vector176
vector176:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $176
80106419:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010641e:	e9 cb f4 ff ff       	jmp    801058ee <alltraps>

80106423 <vector177>:
.globl vector177
vector177:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $177
80106425:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010642a:	e9 bf f4 ff ff       	jmp    801058ee <alltraps>

8010642f <vector178>:
.globl vector178
vector178:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $178
80106431:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106436:	e9 b3 f4 ff ff       	jmp    801058ee <alltraps>

8010643b <vector179>:
.globl vector179
vector179:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $179
8010643d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106442:	e9 a7 f4 ff ff       	jmp    801058ee <alltraps>

80106447 <vector180>:
.globl vector180
vector180:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $180
80106449:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010644e:	e9 9b f4 ff ff       	jmp    801058ee <alltraps>

80106453 <vector181>:
.globl vector181
vector181:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $181
80106455:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010645a:	e9 8f f4 ff ff       	jmp    801058ee <alltraps>

8010645f <vector182>:
.globl vector182
vector182:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $182
80106461:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106466:	e9 83 f4 ff ff       	jmp    801058ee <alltraps>

8010646b <vector183>:
.globl vector183
vector183:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $183
8010646d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106472:	e9 77 f4 ff ff       	jmp    801058ee <alltraps>

80106477 <vector184>:
.globl vector184
vector184:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $184
80106479:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010647e:	e9 6b f4 ff ff       	jmp    801058ee <alltraps>

80106483 <vector185>:
.globl vector185
vector185:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $185
80106485:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010648a:	e9 5f f4 ff ff       	jmp    801058ee <alltraps>

8010648f <vector186>:
.globl vector186
vector186:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $186
80106491:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106496:	e9 53 f4 ff ff       	jmp    801058ee <alltraps>

8010649b <vector187>:
.globl vector187
vector187:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $187
8010649d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801064a2:	e9 47 f4 ff ff       	jmp    801058ee <alltraps>

801064a7 <vector188>:
.globl vector188
vector188:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $188
801064a9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801064ae:	e9 3b f4 ff ff       	jmp    801058ee <alltraps>

801064b3 <vector189>:
.globl vector189
vector189:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $189
801064b5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801064ba:	e9 2f f4 ff ff       	jmp    801058ee <alltraps>

801064bf <vector190>:
.globl vector190
vector190:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $190
801064c1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801064c6:	e9 23 f4 ff ff       	jmp    801058ee <alltraps>

801064cb <vector191>:
.globl vector191
vector191:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $191
801064cd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801064d2:	e9 17 f4 ff ff       	jmp    801058ee <alltraps>

801064d7 <vector192>:
.globl vector192
vector192:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $192
801064d9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801064de:	e9 0b f4 ff ff       	jmp    801058ee <alltraps>

801064e3 <vector193>:
.globl vector193
vector193:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $193
801064e5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801064ea:	e9 ff f3 ff ff       	jmp    801058ee <alltraps>

801064ef <vector194>:
.globl vector194
vector194:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $194
801064f1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801064f6:	e9 f3 f3 ff ff       	jmp    801058ee <alltraps>

801064fb <vector195>:
.globl vector195
vector195:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $195
801064fd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106502:	e9 e7 f3 ff ff       	jmp    801058ee <alltraps>

80106507 <vector196>:
.globl vector196
vector196:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $196
80106509:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010650e:	e9 db f3 ff ff       	jmp    801058ee <alltraps>

80106513 <vector197>:
.globl vector197
vector197:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $197
80106515:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010651a:	e9 cf f3 ff ff       	jmp    801058ee <alltraps>

8010651f <vector198>:
.globl vector198
vector198:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $198
80106521:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106526:	e9 c3 f3 ff ff       	jmp    801058ee <alltraps>

8010652b <vector199>:
.globl vector199
vector199:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $199
8010652d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106532:	e9 b7 f3 ff ff       	jmp    801058ee <alltraps>

80106537 <vector200>:
.globl vector200
vector200:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $200
80106539:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010653e:	e9 ab f3 ff ff       	jmp    801058ee <alltraps>

80106543 <vector201>:
.globl vector201
vector201:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $201
80106545:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010654a:	e9 9f f3 ff ff       	jmp    801058ee <alltraps>

8010654f <vector202>:
.globl vector202
vector202:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $202
80106551:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106556:	e9 93 f3 ff ff       	jmp    801058ee <alltraps>

8010655b <vector203>:
.globl vector203
vector203:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $203
8010655d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106562:	e9 87 f3 ff ff       	jmp    801058ee <alltraps>

80106567 <vector204>:
.globl vector204
vector204:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $204
80106569:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010656e:	e9 7b f3 ff ff       	jmp    801058ee <alltraps>

80106573 <vector205>:
.globl vector205
vector205:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $205
80106575:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010657a:	e9 6f f3 ff ff       	jmp    801058ee <alltraps>

8010657f <vector206>:
.globl vector206
vector206:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $206
80106581:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106586:	e9 63 f3 ff ff       	jmp    801058ee <alltraps>

8010658b <vector207>:
.globl vector207
vector207:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $207
8010658d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106592:	e9 57 f3 ff ff       	jmp    801058ee <alltraps>

80106597 <vector208>:
.globl vector208
vector208:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $208
80106599:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010659e:	e9 4b f3 ff ff       	jmp    801058ee <alltraps>

801065a3 <vector209>:
.globl vector209
vector209:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $209
801065a5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801065aa:	e9 3f f3 ff ff       	jmp    801058ee <alltraps>

801065af <vector210>:
.globl vector210
vector210:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $210
801065b1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801065b6:	e9 33 f3 ff ff       	jmp    801058ee <alltraps>

801065bb <vector211>:
.globl vector211
vector211:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $211
801065bd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801065c2:	e9 27 f3 ff ff       	jmp    801058ee <alltraps>

801065c7 <vector212>:
.globl vector212
vector212:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $212
801065c9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801065ce:	e9 1b f3 ff ff       	jmp    801058ee <alltraps>

801065d3 <vector213>:
.globl vector213
vector213:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $213
801065d5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801065da:	e9 0f f3 ff ff       	jmp    801058ee <alltraps>

801065df <vector214>:
.globl vector214
vector214:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $214
801065e1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801065e6:	e9 03 f3 ff ff       	jmp    801058ee <alltraps>

801065eb <vector215>:
.globl vector215
vector215:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $215
801065ed:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801065f2:	e9 f7 f2 ff ff       	jmp    801058ee <alltraps>

801065f7 <vector216>:
.globl vector216
vector216:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $216
801065f9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801065fe:	e9 eb f2 ff ff       	jmp    801058ee <alltraps>

80106603 <vector217>:
.globl vector217
vector217:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $217
80106605:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010660a:	e9 df f2 ff ff       	jmp    801058ee <alltraps>

8010660f <vector218>:
.globl vector218
vector218:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $218
80106611:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106616:	e9 d3 f2 ff ff       	jmp    801058ee <alltraps>

8010661b <vector219>:
.globl vector219
vector219:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $219
8010661d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106622:	e9 c7 f2 ff ff       	jmp    801058ee <alltraps>

80106627 <vector220>:
.globl vector220
vector220:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $220
80106629:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010662e:	e9 bb f2 ff ff       	jmp    801058ee <alltraps>

80106633 <vector221>:
.globl vector221
vector221:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $221
80106635:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010663a:	e9 af f2 ff ff       	jmp    801058ee <alltraps>

8010663f <vector222>:
.globl vector222
vector222:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $222
80106641:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106646:	e9 a3 f2 ff ff       	jmp    801058ee <alltraps>

8010664b <vector223>:
.globl vector223
vector223:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $223
8010664d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106652:	e9 97 f2 ff ff       	jmp    801058ee <alltraps>

80106657 <vector224>:
.globl vector224
vector224:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $224
80106659:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010665e:	e9 8b f2 ff ff       	jmp    801058ee <alltraps>

80106663 <vector225>:
.globl vector225
vector225:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $225
80106665:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010666a:	e9 7f f2 ff ff       	jmp    801058ee <alltraps>

8010666f <vector226>:
.globl vector226
vector226:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $226
80106671:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106676:	e9 73 f2 ff ff       	jmp    801058ee <alltraps>

8010667b <vector227>:
.globl vector227
vector227:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $227
8010667d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106682:	e9 67 f2 ff ff       	jmp    801058ee <alltraps>

80106687 <vector228>:
.globl vector228
vector228:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $228
80106689:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010668e:	e9 5b f2 ff ff       	jmp    801058ee <alltraps>

80106693 <vector229>:
.globl vector229
vector229:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $229
80106695:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010669a:	e9 4f f2 ff ff       	jmp    801058ee <alltraps>

8010669f <vector230>:
.globl vector230
vector230:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $230
801066a1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801066a6:	e9 43 f2 ff ff       	jmp    801058ee <alltraps>

801066ab <vector231>:
.globl vector231
vector231:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $231
801066ad:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801066b2:	e9 37 f2 ff ff       	jmp    801058ee <alltraps>

801066b7 <vector232>:
.globl vector232
vector232:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $232
801066b9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801066be:	e9 2b f2 ff ff       	jmp    801058ee <alltraps>

801066c3 <vector233>:
.globl vector233
vector233:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $233
801066c5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801066ca:	e9 1f f2 ff ff       	jmp    801058ee <alltraps>

801066cf <vector234>:
.globl vector234
vector234:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $234
801066d1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801066d6:	e9 13 f2 ff ff       	jmp    801058ee <alltraps>

801066db <vector235>:
.globl vector235
vector235:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $235
801066dd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801066e2:	e9 07 f2 ff ff       	jmp    801058ee <alltraps>

801066e7 <vector236>:
.globl vector236
vector236:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $236
801066e9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801066ee:	e9 fb f1 ff ff       	jmp    801058ee <alltraps>

801066f3 <vector237>:
.globl vector237
vector237:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $237
801066f5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801066fa:	e9 ef f1 ff ff       	jmp    801058ee <alltraps>

801066ff <vector238>:
.globl vector238
vector238:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $238
80106701:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106706:	e9 e3 f1 ff ff       	jmp    801058ee <alltraps>

8010670b <vector239>:
.globl vector239
vector239:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $239
8010670d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106712:	e9 d7 f1 ff ff       	jmp    801058ee <alltraps>

80106717 <vector240>:
.globl vector240
vector240:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $240
80106719:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010671e:	e9 cb f1 ff ff       	jmp    801058ee <alltraps>

80106723 <vector241>:
.globl vector241
vector241:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $241
80106725:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010672a:	e9 bf f1 ff ff       	jmp    801058ee <alltraps>

8010672f <vector242>:
.globl vector242
vector242:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $242
80106731:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106736:	e9 b3 f1 ff ff       	jmp    801058ee <alltraps>

8010673b <vector243>:
.globl vector243
vector243:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $243
8010673d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106742:	e9 a7 f1 ff ff       	jmp    801058ee <alltraps>

80106747 <vector244>:
.globl vector244
vector244:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $244
80106749:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010674e:	e9 9b f1 ff ff       	jmp    801058ee <alltraps>

80106753 <vector245>:
.globl vector245
vector245:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $245
80106755:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010675a:	e9 8f f1 ff ff       	jmp    801058ee <alltraps>

8010675f <vector246>:
.globl vector246
vector246:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $246
80106761:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106766:	e9 83 f1 ff ff       	jmp    801058ee <alltraps>

8010676b <vector247>:
.globl vector247
vector247:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $247
8010676d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106772:	e9 77 f1 ff ff       	jmp    801058ee <alltraps>

80106777 <vector248>:
.globl vector248
vector248:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $248
80106779:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010677e:	e9 6b f1 ff ff       	jmp    801058ee <alltraps>

80106783 <vector249>:
.globl vector249
vector249:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $249
80106785:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010678a:	e9 5f f1 ff ff       	jmp    801058ee <alltraps>

8010678f <vector250>:
.globl vector250
vector250:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $250
80106791:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106796:	e9 53 f1 ff ff       	jmp    801058ee <alltraps>

8010679b <vector251>:
.globl vector251
vector251:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $251
8010679d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801067a2:	e9 47 f1 ff ff       	jmp    801058ee <alltraps>

801067a7 <vector252>:
.globl vector252
vector252:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $252
801067a9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801067ae:	e9 3b f1 ff ff       	jmp    801058ee <alltraps>

801067b3 <vector253>:
.globl vector253
vector253:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $253
801067b5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801067ba:	e9 2f f1 ff ff       	jmp    801058ee <alltraps>

801067bf <vector254>:
.globl vector254
vector254:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $254
801067c1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801067c6:	e9 23 f1 ff ff       	jmp    801058ee <alltraps>

801067cb <vector255>:
.globl vector255
vector255:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $255
801067cd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801067d2:	e9 17 f1 ff ff       	jmp    801058ee <alltraps>
801067d7:	66 90                	xchg   %ax,%ax
801067d9:	66 90                	xchg   %ax,%ax
801067db:	66 90                	xchg   %ax,%ax
801067dd:	66 90                	xchg   %ax,%ax
801067df:	90                   	nop

801067e0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801067e0:	55                   	push   %ebp
801067e1:	89 e5                	mov    %esp,%ebp
801067e3:	57                   	push   %edi
801067e4:	56                   	push   %esi
801067e5:	53                   	push   %ebx
801067e6:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801067e8:	c1 ea 16             	shr    $0x16,%edx
801067eb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801067ee:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801067f1:	8b 07                	mov    (%edi),%eax
801067f3:	a8 01                	test   $0x1,%al
801067f5:	74 29                	je     80106820 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801067f7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067fc:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106802:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106805:	c1 eb 0a             	shr    $0xa,%ebx
80106808:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010680e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106811:	5b                   	pop    %ebx
80106812:	5e                   	pop    %esi
80106813:	5f                   	pop    %edi
80106814:	5d                   	pop    %ebp
80106815:	c3                   	ret    
80106816:	8d 76 00             	lea    0x0(%esi),%esi
80106819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106820:	85 c9                	test   %ecx,%ecx
80106822:	74 2c                	je     80106850 <walkpgdir+0x70>
80106824:	e8 17 bc ff ff       	call   80102440 <kalloc>
80106829:	85 c0                	test   %eax,%eax
8010682b:	89 c6                	mov    %eax,%esi
8010682d:	74 21                	je     80106850 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010682f:	83 ec 04             	sub    $0x4,%esp
80106832:	68 00 10 00 00       	push   $0x1000
80106837:	6a 00                	push   $0x0
80106839:	50                   	push   %eax
8010683a:	e8 51 dd ff ff       	call   80104590 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010683f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106845:	83 c4 10             	add    $0x10,%esp
80106848:	83 c8 07             	or     $0x7,%eax
8010684b:	89 07                	mov    %eax,(%edi)
8010684d:	eb b3                	jmp    80106802 <walkpgdir+0x22>
8010684f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106850:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106853:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106855:	5b                   	pop    %ebx
80106856:	5e                   	pop    %esi
80106857:	5f                   	pop    %edi
80106858:	5d                   	pop    %ebp
80106859:	c3                   	ret    
8010685a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106860 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106860:	55                   	push   %ebp
80106861:	89 e5                	mov    %esp,%ebp
80106863:	57                   	push   %edi
80106864:	56                   	push   %esi
80106865:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106866:	89 d3                	mov    %edx,%ebx
80106868:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010686e:	83 ec 1c             	sub    $0x1c,%esp
80106871:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106874:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106878:	8b 7d 08             	mov    0x8(%ebp),%edi
8010687b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106880:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106883:	8b 45 0c             	mov    0xc(%ebp),%eax
80106886:	29 df                	sub    %ebx,%edi
80106888:	83 c8 01             	or     $0x1,%eax
8010688b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010688e:	eb 15                	jmp    801068a5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106890:	f6 00 01             	testb  $0x1,(%eax)
80106893:	75 45                	jne    801068da <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106895:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106898:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010689b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010689d:	74 31                	je     801068d0 <mappages+0x70>
      break;
    a += PGSIZE;
8010689f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801068a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068a8:	b9 01 00 00 00       	mov    $0x1,%ecx
801068ad:	89 da                	mov    %ebx,%edx
801068af:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801068b2:	e8 29 ff ff ff       	call   801067e0 <walkpgdir>
801068b7:	85 c0                	test   %eax,%eax
801068b9:	75 d5                	jne    80106890 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801068bb:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801068be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801068c3:	5b                   	pop    %ebx
801068c4:	5e                   	pop    %esi
801068c5:	5f                   	pop    %edi
801068c6:	5d                   	pop    %ebp
801068c7:	c3                   	ret    
801068c8:	90                   	nop
801068c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801068d3:	31 c0                	xor    %eax,%eax
}
801068d5:	5b                   	pop    %ebx
801068d6:	5e                   	pop    %esi
801068d7:	5f                   	pop    %edi
801068d8:	5d                   	pop    %ebp
801068d9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801068da:	83 ec 0c             	sub    $0xc,%esp
801068dd:	68 c0 79 10 80       	push   $0x801079c0
801068e2:	e8 89 9a ff ff       	call   80100370 <panic>
801068e7:	89 f6                	mov    %esi,%esi
801068e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068f0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068f0:	55                   	push   %ebp
801068f1:	89 e5                	mov    %esp,%ebp
801068f3:	57                   	push   %edi
801068f4:	56                   	push   %esi
801068f5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801068f6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068fc:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801068fe:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106904:	83 ec 1c             	sub    $0x1c,%esp
80106907:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010690a:	39 d3                	cmp    %edx,%ebx
8010690c:	73 66                	jae    80106974 <deallocuvm.part.0+0x84>
8010690e:	89 d6                	mov    %edx,%esi
80106910:	eb 3d                	jmp    8010694f <deallocuvm.part.0+0x5f>
80106912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106918:	8b 10                	mov    (%eax),%edx
8010691a:	f6 c2 01             	test   $0x1,%dl
8010691d:	74 26                	je     80106945 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010691f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106925:	74 58                	je     8010697f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106927:	83 ec 0c             	sub    $0xc,%esp
8010692a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106930:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106933:	52                   	push   %edx
80106934:	e8 57 b9 ff ff       	call   80102290 <kfree>
      *pte = 0;
80106939:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010693c:	83 c4 10             	add    $0x10,%esp
8010693f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106945:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010694b:	39 f3                	cmp    %esi,%ebx
8010694d:	73 25                	jae    80106974 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010694f:	31 c9                	xor    %ecx,%ecx
80106951:	89 da                	mov    %ebx,%edx
80106953:	89 f8                	mov    %edi,%eax
80106955:	e8 86 fe ff ff       	call   801067e0 <walkpgdir>
    if(!pte)
8010695a:	85 c0                	test   %eax,%eax
8010695c:	75 ba                	jne    80106918 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010695e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106964:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010696a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106970:	39 f3                	cmp    %esi,%ebx
80106972:	72 db                	jb     8010694f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106974:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106977:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010697a:	5b                   	pop    %ebx
8010697b:	5e                   	pop    %esi
8010697c:	5f                   	pop    %edi
8010697d:	5d                   	pop    %ebp
8010697e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
8010697f:	83 ec 0c             	sub    $0xc,%esp
80106982:	68 5e 73 10 80       	push   $0x8010735e
80106987:	e8 e4 99 ff ff       	call   80100370 <panic>
8010698c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106990 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	53                   	push   %ebx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106994:	31 db                	xor    %ebx,%ebx

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106996:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80106999:	e8 02 bd ff ff       	call   801026a0 <cpunum>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010699e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801069a4:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
801069a9:	8d 90 a0 27 11 80    	lea    -0x7feed860(%eax),%edx
801069af:	c6 80 1d 28 11 80 9a 	movb   $0x9a,-0x7feed7e3(%eax)
801069b6:	c6 80 1e 28 11 80 cf 	movb   $0xcf,-0x7feed7e2(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069bd:	c6 80 25 28 11 80 92 	movb   $0x92,-0x7feed7db(%eax)
801069c4:	c6 80 26 28 11 80 cf 	movb   $0xcf,-0x7feed7da(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801069cb:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069cf:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801069d4:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069d8:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
801069df:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801069e1:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069e6:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801069ed:	66 89 8a 90 00 00 00 	mov    %cx,0x90(%edx)
801069f4:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801069f6:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801069fb:	66 89 9a 92 00 00 00 	mov    %bx,0x92(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a02:	31 db                	xor    %ebx,%ebx
80106a04:	66 89 8a 98 00 00 00 	mov    %cx,0x98(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106a0b:	8d 88 54 28 11 80    	lea    -0x7feed7ac(%eax),%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a11:	66 89 9a 9a 00 00 00 	mov    %bx,0x9a(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106a18:	31 db                	xor    %ebx,%ebx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a1a:	c6 80 35 28 11 80 fa 	movb   $0xfa,-0x7feed7cb(%eax)
80106a21:	c6 80 36 28 11 80 cf 	movb   $0xcf,-0x7feed7ca(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106a28:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106a2f:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106a36:	89 cb                	mov    %ecx,%ebx
80106a38:	c1 e9 18             	shr    $0x18,%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a3b:	c6 80 3d 28 11 80 f2 	movb   $0xf2,-0x7feed7c3(%eax)
80106a42:	c6 80 3e 28 11 80 cf 	movb   $0xcf,-0x7feed7c2(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106a49:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
80106a4f:	c6 80 2d 28 11 80 92 	movb   $0x92,-0x7feed7d3(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106a56:	b9 37 00 00 00       	mov    $0x37,%ecx
80106a5b:	c6 80 2e 28 11 80 c0 	movb   $0xc0,-0x7feed7d2(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80106a62:	05 10 28 11 80       	add    $0x80112810,%eax
80106a67:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106a6b:	c1 eb 10             	shr    $0x10,%ebx
  pd[1] = (uint)p;
80106a6e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106a72:	c1 e8 10             	shr    $0x10,%eax
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a75:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
80106a79:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a7d:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
80106a84:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a8b:	c6 82 94 00 00 00 00 	movb   $0x0,0x94(%edx)
80106a92:	c6 82 97 00 00 00 00 	movb   $0x0,0x97(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a99:	c6 82 9c 00 00 00 00 	movb   $0x0,0x9c(%edx)
80106aa0:	c6 82 9f 00 00 00 00 	movb   $0x0,0x9f(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106aa7:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106aad:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106ab1:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ab4:	0f 01 10             	lgdtl  (%eax)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
80106ab7:	b8 18 00 00 00       	mov    $0x18,%eax
80106abc:	8e e8                	mov    %eax,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
80106abe:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106ac5:	00 00 00 00 

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80106ac9:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
}
80106ad0:	83 c4 14             	add    $0x14,%esp
80106ad3:	5b                   	pop    %ebx
80106ad4:	5d                   	pop    %ebp
80106ad5:	c3                   	ret    
80106ad6:	8d 76 00             	lea    0x0(%esi),%esi
80106ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ae0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	56                   	push   %esi
80106ae4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106ae5:	e8 56 b9 ff ff       	call   80102440 <kalloc>
80106aea:	85 c0                	test   %eax,%eax
80106aec:	74 52                	je     80106b40 <setupkvm+0x60>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106aee:	83 ec 04             	sub    $0x4,%esp
80106af1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106af3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106af8:	68 00 10 00 00       	push   $0x1000
80106afd:	6a 00                	push   $0x0
80106aff:	50                   	push   %eax
80106b00:	e8 8b da ff ff       	call   80104590 <memset>
80106b05:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106b08:	8b 43 04             	mov    0x4(%ebx),%eax
80106b0b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106b0e:	83 ec 08             	sub    $0x8,%esp
80106b11:	8b 13                	mov    (%ebx),%edx
80106b13:	ff 73 0c             	pushl  0xc(%ebx)
80106b16:	50                   	push   %eax
80106b17:	29 c1                	sub    %eax,%ecx
80106b19:	89 f0                	mov    %esi,%eax
80106b1b:	e8 40 fd ff ff       	call   80106860 <mappages>
80106b20:	83 c4 10             	add    $0x10,%esp
80106b23:	85 c0                	test   %eax,%eax
80106b25:	78 19                	js     80106b40 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106b27:	83 c3 10             	add    $0x10,%ebx
80106b2a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106b30:	75 d6                	jne    80106b08 <setupkvm+0x28>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106b32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106b35:	89 f0                	mov    %esi,%eax
80106b37:	5b                   	pop    %ebx
80106b38:	5e                   	pop    %esi
80106b39:	5d                   	pop    %ebp
80106b3a:	c3                   	ret    
80106b3b:	90                   	nop
80106b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106b40:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106b43:	31 c0                	xor    %eax,%eax
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106b45:	5b                   	pop    %ebx
80106b46:	5e                   	pop    %esi
80106b47:	5d                   	pop    %ebp
80106b48:	c3                   	ret    
80106b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b50 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106b56:	e8 85 ff ff ff       	call   80106ae0 <setupkvm>
80106b5b:	a3 24 56 11 80       	mov    %eax,0x80115624
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b60:	05 00 00 00 80       	add    $0x80000000,%eax
80106b65:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106b68:	c9                   	leave  
80106b69:	c3                   	ret    
80106b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b70 <switchkvm>:
80106b70:	a1 24 56 11 80       	mov    0x80115624,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106b75:	55                   	push   %ebp
80106b76:	89 e5                	mov    %esp,%ebp
80106b78:	05 00 00 00 80       	add    $0x80000000,%eax
80106b7d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106b80:	5d                   	pop    %ebp
80106b81:	c3                   	ret    
80106b82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b90 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	53                   	push   %ebx
80106b94:	83 ec 04             	sub    $0x4,%esp
80106b97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106b9a:	85 db                	test   %ebx,%ebx
80106b9c:	0f 84 93 00 00 00    	je     80106c35 <switchuvm+0xa5>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106ba2:	8b 43 08             	mov    0x8(%ebx),%eax
80106ba5:	85 c0                	test   %eax,%eax
80106ba7:	0f 84 a2 00 00 00    	je     80106c4f <switchuvm+0xbf>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106bad:	8b 43 04             	mov    0x4(%ebx),%eax
80106bb0:	85 c0                	test   %eax,%eax
80106bb2:	0f 84 8a 00 00 00    	je     80106c42 <switchuvm+0xb2>
    panic("switchuvm: no pgdir");

  pushcli();
80106bb8:	e8 03 d9 ff ff       	call   801044c0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106bbd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106bc3:	b9 67 00 00 00       	mov    $0x67,%ecx
80106bc8:	8d 50 08             	lea    0x8(%eax),%edx
80106bcb:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106bd2:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80106bd9:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106be0:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106be7:	89 d1                	mov    %edx,%ecx
80106be9:	c1 ea 18             	shr    $0x18,%edx
80106bec:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80106bf2:	c1 e9 10             	shr    $0x10,%ecx
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
80106bf5:	ba 10 00 00 00       	mov    $0x10,%edx
80106bfa:	66 89 50 10          	mov    %dx,0x10(%eax)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106bfe:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c04:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106c07:	8d 91 00 10 00 00    	lea    0x1000(%ecx),%edx
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
80106c0d:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106c12:	66 89 48 6e          	mov    %cx,0x6e(%eax)

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c16:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106c19:	b8 30 00 00 00       	mov    $0x30,%eax
80106c1e:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c21:	8b 43 04             	mov    0x4(%ebx),%eax
80106c24:	05 00 00 00 80       	add    $0x80000000,%eax
80106c29:	0f 22 d8             	mov    %eax,%cr3
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106c2c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106c2f:	c9                   	leave  
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106c30:	e9 bb d8 ff ff       	jmp    801044f0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106c35:	83 ec 0c             	sub    $0xc,%esp
80106c38:	68 c6 79 10 80       	push   $0x801079c6
80106c3d:	e8 2e 97 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106c42:	83 ec 0c             	sub    $0xc,%esp
80106c45:	68 f1 79 10 80       	push   $0x801079f1
80106c4a:	e8 21 97 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106c4f:	83 ec 0c             	sub    $0xc,%esp
80106c52:	68 dc 79 10 80       	push   $0x801079dc
80106c57:	e8 14 97 ff ff       	call   80100370 <panic>
80106c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c60 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 1c             	sub    $0x1c,%esp
80106c69:	8b 75 10             	mov    0x10(%ebp),%esi
80106c6c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c6f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106c72:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c78:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106c7b:	77 49                	ja     80106cc6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106c7d:	e8 be b7 ff ff       	call   80102440 <kalloc>
  memset(mem, 0, PGSIZE);
80106c82:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106c85:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c87:	68 00 10 00 00       	push   $0x1000
80106c8c:	6a 00                	push   $0x0
80106c8e:	50                   	push   %eax
80106c8f:	e8 fc d8 ff ff       	call   80104590 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c94:	58                   	pop    %eax
80106c95:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c9b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ca0:	5a                   	pop    %edx
80106ca1:	6a 06                	push   $0x6
80106ca3:	50                   	push   %eax
80106ca4:	31 d2                	xor    %edx,%edx
80106ca6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ca9:	e8 b2 fb ff ff       	call   80106860 <mappages>
  memmove(mem, init, sz);
80106cae:	89 75 10             	mov    %esi,0x10(%ebp)
80106cb1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106cb4:	83 c4 10             	add    $0x10,%esp
80106cb7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106cba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cbd:	5b                   	pop    %ebx
80106cbe:	5e                   	pop    %esi
80106cbf:	5f                   	pop    %edi
80106cc0:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106cc1:	e9 7a d9 ff ff       	jmp    80104640 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106cc6:	83 ec 0c             	sub    $0xc,%esp
80106cc9:	68 05 7a 10 80       	push   $0x80107a05
80106cce:	e8 9d 96 ff ff       	call   80100370 <panic>
80106cd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ce0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	57                   	push   %edi
80106ce4:	56                   	push   %esi
80106ce5:	53                   	push   %ebx
80106ce6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106ce9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106cf0:	0f 85 91 00 00 00    	jne    80106d87 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106cf6:	8b 75 18             	mov    0x18(%ebp),%esi
80106cf9:	31 db                	xor    %ebx,%ebx
80106cfb:	85 f6                	test   %esi,%esi
80106cfd:	75 1a                	jne    80106d19 <loaduvm+0x39>
80106cff:	eb 6f                	jmp    80106d70 <loaduvm+0x90>
80106d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d08:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d0e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d14:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d17:	76 57                	jbe    80106d70 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d19:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d1c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d1f:	31 c9                	xor    %ecx,%ecx
80106d21:	01 da                	add    %ebx,%edx
80106d23:	e8 b8 fa ff ff       	call   801067e0 <walkpgdir>
80106d28:	85 c0                	test   %eax,%eax
80106d2a:	74 4e                	je     80106d7a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d2c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d2e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106d31:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d36:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d3b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d41:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d44:	01 d9                	add    %ebx,%ecx
80106d46:	05 00 00 00 80       	add    $0x80000000,%eax
80106d4b:	57                   	push   %edi
80106d4c:	51                   	push   %ecx
80106d4d:	50                   	push   %eax
80106d4e:	ff 75 10             	pushl  0x10(%ebp)
80106d51:	e8 8a ab ff ff       	call   801018e0 <readi>
80106d56:	83 c4 10             	add    $0x10,%esp
80106d59:	39 c7                	cmp    %eax,%edi
80106d5b:	74 ab                	je     80106d08 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106d5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106d65:	5b                   	pop    %ebx
80106d66:	5e                   	pop    %esi
80106d67:	5f                   	pop    %edi
80106d68:	5d                   	pop    %ebp
80106d69:	c3                   	ret    
80106d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d70:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106d73:	31 c0                	xor    %eax,%eax
}
80106d75:	5b                   	pop    %ebx
80106d76:	5e                   	pop    %esi
80106d77:	5f                   	pop    %edi
80106d78:	5d                   	pop    %ebp
80106d79:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106d7a:	83 ec 0c             	sub    $0xc,%esp
80106d7d:	68 1f 7a 10 80       	push   $0x80107a1f
80106d82:	e8 e9 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106d87:	83 ec 0c             	sub    $0xc,%esp
80106d8a:	68 c0 7a 10 80       	push   $0x80107ac0
80106d8f:	e8 dc 95 ff ff       	call   80100370 <panic>
80106d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106da0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106da0:	55                   	push   %ebp
80106da1:	89 e5                	mov    %esp,%ebp
80106da3:	57                   	push   %edi
80106da4:	56                   	push   %esi
80106da5:	53                   	push   %ebx
80106da6:	83 ec 0c             	sub    $0xc,%esp
80106da9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106dac:	85 ff                	test   %edi,%edi
80106dae:	0f 88 ca 00 00 00    	js     80106e7e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106db4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106db7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106dba:	0f 82 82 00 00 00    	jb     80106e42 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106dc0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106dc6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106dcc:	39 df                	cmp    %ebx,%edi
80106dce:	77 43                	ja     80106e13 <allocuvm+0x73>
80106dd0:	e9 bb 00 00 00       	jmp    80106e90 <allocuvm+0xf0>
80106dd5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106dd8:	83 ec 04             	sub    $0x4,%esp
80106ddb:	68 00 10 00 00       	push   $0x1000
80106de0:	6a 00                	push   $0x0
80106de2:	50                   	push   %eax
80106de3:	e8 a8 d7 ff ff       	call   80104590 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106de8:	58                   	pop    %eax
80106de9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106def:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106df4:	5a                   	pop    %edx
80106df5:	6a 06                	push   $0x6
80106df7:	50                   	push   %eax
80106df8:	89 da                	mov    %ebx,%edx
80106dfa:	8b 45 08             	mov    0x8(%ebp),%eax
80106dfd:	e8 5e fa ff ff       	call   80106860 <mappages>
80106e02:	83 c4 10             	add    $0x10,%esp
80106e05:	85 c0                	test   %eax,%eax
80106e07:	78 47                	js     80106e50 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e09:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e0f:	39 df                	cmp    %ebx,%edi
80106e11:	76 7d                	jbe    80106e90 <allocuvm+0xf0>
    mem = kalloc();
80106e13:	e8 28 b6 ff ff       	call   80102440 <kalloc>
    if(mem == 0){
80106e18:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e1a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e1c:	75 ba                	jne    80106dd8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106e1e:	83 ec 0c             	sub    $0xc,%esp
80106e21:	68 3d 7a 10 80       	push   $0x80107a3d
80106e26:	e8 35 98 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e2b:	83 c4 10             	add    $0x10,%esp
80106e2e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e31:	76 4b                	jbe    80106e7e <allocuvm+0xde>
80106e33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e36:	8b 45 08             	mov    0x8(%ebp),%eax
80106e39:	89 fa                	mov    %edi,%edx
80106e3b:	e8 b0 fa ff ff       	call   801068f0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106e40:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e45:	5b                   	pop    %ebx
80106e46:	5e                   	pop    %esi
80106e47:	5f                   	pop    %edi
80106e48:	5d                   	pop    %ebp
80106e49:	c3                   	ret    
80106e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106e50:	83 ec 0c             	sub    $0xc,%esp
80106e53:	68 55 7a 10 80       	push   $0x80107a55
80106e58:	e8 03 98 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e5d:	83 c4 10             	add    $0x10,%esp
80106e60:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e63:	76 0d                	jbe    80106e72 <allocuvm+0xd2>
80106e65:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e68:	8b 45 08             	mov    0x8(%ebp),%eax
80106e6b:	89 fa                	mov    %edi,%edx
80106e6d:	e8 7e fa ff ff       	call   801068f0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106e72:	83 ec 0c             	sub    $0xc,%esp
80106e75:	56                   	push   %esi
80106e76:	e8 15 b4 ff ff       	call   80102290 <kfree>
      return 0;
80106e7b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106e7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106e81:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106e83:	5b                   	pop    %ebx
80106e84:	5e                   	pop    %esi
80106e85:	5f                   	pop    %edi
80106e86:	5d                   	pop    %ebp
80106e87:	c3                   	ret    
80106e88:	90                   	nop
80106e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e90:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e93:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e95:	5b                   	pop    %ebx
80106e96:	5e                   	pop    %esi
80106e97:	5f                   	pop    %edi
80106e98:	5d                   	pop    %ebp
80106e99:	c3                   	ret    
80106e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ea0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ea6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106eac:	39 d1                	cmp    %edx,%ecx
80106eae:	73 10                	jae    80106ec0 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106eb0:	5d                   	pop    %ebp
80106eb1:	e9 3a fa ff ff       	jmp    801068f0 <deallocuvm.part.0>
80106eb6:	8d 76 00             	lea    0x0(%esi),%esi
80106eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106ec0:	89 d0                	mov    %edx,%eax
80106ec2:	5d                   	pop    %ebp
80106ec3:	c3                   	ret    
80106ec4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ed0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	57                   	push   %edi
80106ed4:	56                   	push   %esi
80106ed5:	53                   	push   %ebx
80106ed6:	83 ec 0c             	sub    $0xc,%esp
80106ed9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106edc:	85 f6                	test   %esi,%esi
80106ede:	74 59                	je     80106f39 <freevm+0x69>
80106ee0:	31 c9                	xor    %ecx,%ecx
80106ee2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106ee7:	89 f0                	mov    %esi,%eax
80106ee9:	e8 02 fa ff ff       	call   801068f0 <deallocuvm.part.0>
80106eee:	89 f3                	mov    %esi,%ebx
80106ef0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ef6:	eb 0f                	jmp    80106f07 <freevm+0x37>
80106ef8:	90                   	nop
80106ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f00:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f03:	39 fb                	cmp    %edi,%ebx
80106f05:	74 23                	je     80106f2a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f07:	8b 03                	mov    (%ebx),%eax
80106f09:	a8 01                	test   $0x1,%al
80106f0b:	74 f3                	je     80106f00 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106f0d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f12:	83 ec 0c             	sub    $0xc,%esp
80106f15:	83 c3 04             	add    $0x4,%ebx
80106f18:	05 00 00 00 80       	add    $0x80000000,%eax
80106f1d:	50                   	push   %eax
80106f1e:	e8 6d b3 ff ff       	call   80102290 <kfree>
80106f23:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f26:	39 fb                	cmp    %edi,%ebx
80106f28:	75 dd                	jne    80106f07 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f2a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f30:	5b                   	pop    %ebx
80106f31:	5e                   	pop    %esi
80106f32:	5f                   	pop    %edi
80106f33:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f34:	e9 57 b3 ff ff       	jmp    80102290 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106f39:	83 ec 0c             	sub    $0xc,%esp
80106f3c:	68 71 7a 10 80       	push   $0x80107a71
80106f41:	e8 2a 94 ff ff       	call   80100370 <panic>
80106f46:	8d 76 00             	lea    0x0(%esi),%esi
80106f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f50 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f50:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f51:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f53:	89 e5                	mov    %esp,%ebp
80106f55:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f58:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f5b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f5e:	e8 7d f8 ff ff       	call   801067e0 <walkpgdir>
  if(pte == 0)
80106f63:	85 c0                	test   %eax,%eax
80106f65:	74 05                	je     80106f6c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106f67:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106f6a:	c9                   	leave  
80106f6b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106f6c:	83 ec 0c             	sub    $0xc,%esp
80106f6f:	68 82 7a 10 80       	push   $0x80107a82
80106f74:	e8 f7 93 ff ff       	call   80100370 <panic>
80106f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f80 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	57                   	push   %edi
80106f84:	56                   	push   %esi
80106f85:	53                   	push   %ebx
80106f86:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106f89:	e8 52 fb ff ff       	call   80106ae0 <setupkvm>
80106f8e:	85 c0                	test   %eax,%eax
80106f90:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f93:	0f 84 b2 00 00 00    	je     8010704b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106f99:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f9c:	85 c9                	test   %ecx,%ecx
80106f9e:	0f 84 9c 00 00 00    	je     80107040 <copyuvm+0xc0>
80106fa4:	31 f6                	xor    %esi,%esi
80106fa6:	eb 4a                	jmp    80106ff2 <copyuvm+0x72>
80106fa8:	90                   	nop
80106fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106fb0:	83 ec 04             	sub    $0x4,%esp
80106fb3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106fb9:	68 00 10 00 00       	push   $0x1000
80106fbe:	57                   	push   %edi
80106fbf:	50                   	push   %eax
80106fc0:	e8 7b d6 ff ff       	call   80104640 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106fc5:	58                   	pop    %eax
80106fc6:	5a                   	pop    %edx
80106fc7:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80106fcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106fd0:	ff 75 e4             	pushl  -0x1c(%ebp)
80106fd3:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fd8:	52                   	push   %edx
80106fd9:	89 f2                	mov    %esi,%edx
80106fdb:	e8 80 f8 ff ff       	call   80106860 <mappages>
80106fe0:	83 c4 10             	add    $0x10,%esp
80106fe3:	85 c0                	test   %eax,%eax
80106fe5:	78 3e                	js     80107025 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fe7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106fed:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106ff0:	76 4e                	jbe    80107040 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106ff2:	8b 45 08             	mov    0x8(%ebp),%eax
80106ff5:	31 c9                	xor    %ecx,%ecx
80106ff7:	89 f2                	mov    %esi,%edx
80106ff9:	e8 e2 f7 ff ff       	call   801067e0 <walkpgdir>
80106ffe:	85 c0                	test   %eax,%eax
80107000:	74 5a                	je     8010705c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107002:	8b 18                	mov    (%eax),%ebx
80107004:	f6 c3 01             	test   $0x1,%bl
80107007:	74 46                	je     8010704f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107009:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010700b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80107011:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107014:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
8010701a:	e8 21 b4 ff ff       	call   80102440 <kalloc>
8010701f:	85 c0                	test   %eax,%eax
80107021:	89 c3                	mov    %eax,%ebx
80107023:	75 8b                	jne    80106fb0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107025:	83 ec 0c             	sub    $0xc,%esp
80107028:	ff 75 e0             	pushl  -0x20(%ebp)
8010702b:	e8 a0 fe ff ff       	call   80106ed0 <freevm>
  return 0;
80107030:	83 c4 10             	add    $0x10,%esp
80107033:	31 c0                	xor    %eax,%eax
}
80107035:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107038:	5b                   	pop    %ebx
80107039:	5e                   	pop    %esi
8010703a:	5f                   	pop    %edi
8010703b:	5d                   	pop    %ebp
8010703c:	c3                   	ret    
8010703d:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107040:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107043:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107046:	5b                   	pop    %ebx
80107047:	5e                   	pop    %esi
80107048:	5f                   	pop    %edi
80107049:	5d                   	pop    %ebp
8010704a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010704b:	31 c0                	xor    %eax,%eax
8010704d:	eb e6                	jmp    80107035 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010704f:	83 ec 0c             	sub    $0xc,%esp
80107052:	68 a6 7a 10 80       	push   $0x80107aa6
80107057:	e8 14 93 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010705c:	83 ec 0c             	sub    $0xc,%esp
8010705f:	68 8c 7a 10 80       	push   $0x80107a8c
80107064:	e8 07 93 ff ff       	call   80100370 <panic>
80107069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107070 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107070:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107071:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107073:	89 e5                	mov    %esp,%ebp
80107075:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107078:	8b 55 0c             	mov    0xc(%ebp),%edx
8010707b:	8b 45 08             	mov    0x8(%ebp),%eax
8010707e:	e8 5d f7 ff ff       	call   801067e0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107083:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107085:	89 c2                	mov    %eax,%edx
80107087:	83 e2 05             	and    $0x5,%edx
8010708a:	83 fa 05             	cmp    $0x5,%edx
8010708d:	75 11                	jne    801070a0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010708f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107094:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107095:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010709a:	c3                   	ret    
8010709b:	90                   	nop
8010709c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801070a0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801070a2:	c9                   	leave  
801070a3:	c3                   	ret    
801070a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801070b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	57                   	push   %edi
801070b4:	56                   	push   %esi
801070b5:	53                   	push   %ebx
801070b6:	83 ec 1c             	sub    $0x1c,%esp
801070b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801070bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801070bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801070c2:	85 db                	test   %ebx,%ebx
801070c4:	75 40                	jne    80107106 <copyout+0x56>
801070c6:	eb 70                	jmp    80107138 <copyout+0x88>
801070c8:	90                   	nop
801070c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801070d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801070d3:	89 f1                	mov    %esi,%ecx
801070d5:	29 d1                	sub    %edx,%ecx
801070d7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801070dd:	39 d9                	cmp    %ebx,%ecx
801070df:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801070e2:	29 f2                	sub    %esi,%edx
801070e4:	83 ec 04             	sub    $0x4,%esp
801070e7:	01 d0                	add    %edx,%eax
801070e9:	51                   	push   %ecx
801070ea:	57                   	push   %edi
801070eb:	50                   	push   %eax
801070ec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801070ef:	e8 4c d5 ff ff       	call   80104640 <memmove>
    len -= n;
    buf += n;
801070f4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801070f7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801070fa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107100:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107102:	29 cb                	sub    %ecx,%ebx
80107104:	74 32                	je     80107138 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107106:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107108:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010710b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010710e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107114:	56                   	push   %esi
80107115:	ff 75 08             	pushl  0x8(%ebp)
80107118:	e8 53 ff ff ff       	call   80107070 <uva2ka>
    if(pa0 == 0)
8010711d:	83 c4 10             	add    $0x10,%esp
80107120:	85 c0                	test   %eax,%eax
80107122:	75 ac                	jne    801070d0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107124:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107127:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010712c:	5b                   	pop    %ebx
8010712d:	5e                   	pop    %esi
8010712e:	5f                   	pop    %edi
8010712f:	5d                   	pop    %ebp
80107130:	c3                   	ret    
80107131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107138:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010713b:	31 c0                	xor    %eax,%eax
}
8010713d:	5b                   	pop    %ebx
8010713e:	5e                   	pop    %esi
8010713f:	5f                   	pop    %edi
80107140:	5d                   	pop    %ebp
80107141:	c3                   	ret    
