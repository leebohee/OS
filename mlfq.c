#include "proc.h"
#include "mlfq.h"

//struct proc* MLFQ[11][NPROC];

void Init(void){
	int i, j;
	for(i=0; i<11; i++){
		qnum[i]=0;
		for(j=0; j<NPROC; j++){
			MLFQ[i][j]=NULL;
		}
	}
}

void Enqueue(int nice, struct proc* p){
	struct proc** ptr=MLFQ[nice];

	ptr[qnum[nice]]=p;
	qnum[nice]++;
}

struct proc* Dequeue(int nice){
	static struct proc* p;
	struct proc** ptr=MLFQ[nice];
	int i;

	p=ptr[0];
	for(i=1; i<NPROC; i++){
		if(ptr[i]==NULL){
			break;
		}
		ptr[i-1]=ptr[i];
	}
	ptr[i-1]=NULL;
	qnum[nice]--;
	return p;
}

/*
int main(){
	int i;
	struct proc plist[20];
	Init();
	
	for(i=0; i<20; i++){
		plist[i].pid=i;
		plist[i].niceness=i%5;
		Enqueue(plist[i].niceness, &plist[i]);
	}

	printf("Dequeue: %d", Dequeue(0)->pid);
	printf("Dequeue: %d", Dequeue(0)->pid);
	printf("Dequeue: %d", Dequeue(1)->pid);
	
	return 0;
}*/
