#include "types.h"
#include "stat.h"
#include "user.h"

int test1(){
	int pid_arr[5];
	for(int i=0; i<5; i++){
		int pid=fork();
		if(pid==0){
      while(1);
			return 0;
		}
		else{
      pid_arr[i]=pid;
		}
	}
	
	for(int i=0; i<5; i++){
		setnice(pid_arr[i], i);
	}

	for(int i=0; i<5; i++){
		kill(pid_arr[i]);
	}
	return 0;
}

int test2(){
  int pid;
	setnice(getpid(), 5);
	pid=fork();

	if(pid==0){
		printf(1, "child\n");
    while(1);
	}
	else{
		printf(1, "parent\n");
    kill(pid);
	}
	return 0;
}

int test3(){
  sleep(10);
	printf(1, "Wake up\n");
	return 0;

}

int test4(){
  while(1){
	}
	return 0;
}

int main(int argc, char** argv){
	//int pid;
	if(argc!=1){
		printf(1, "usage: ps pid\n");
		exit();
	}
	// test2();
  test1();
	
	exit();
}

