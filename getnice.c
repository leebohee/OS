#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char** argv){
	if(argc!=2){
		printf(2, "invalid parameters\n");
	  exit();
	}
	getnice(atoi(argv[1]));
	exit();
}
