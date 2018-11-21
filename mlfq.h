//#include "proc.h"

#define NULL 0

struct proc* MLFQ[11][NPROC];
int qnum[11];

void Init(void);
void Enqueue(int nice, struct proc* p);
struct proc* Dequeue(int nice);
