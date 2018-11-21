#include "types.h"
#include "stat.h"
#include "user.h"

int test1(){
	sleep(5);
	printf(1, "Wake up!\n");
	return 0;
}

int main(int argc, char** argv){
  test1();
	exit();
}
