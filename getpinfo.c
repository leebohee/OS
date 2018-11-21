#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

int main(int argc, char** argv){
	struct pstat pst;

	if(argc!=1){
		printf(2, "invalid parameters\n");
		exit();
	}
	getpinfo(&pst);
	exit();
}
