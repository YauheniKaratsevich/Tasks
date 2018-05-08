#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define WRITE_END 1

//this process just get data and transfer to a pipe
int main(int argc, char *argv[] ) {
	char str[20];
	int *pipefd;
//get pipe pointer	
	pipefd = (int *)argv[1];

	while( 1 ) {
		scanf("%s", str);
		write(pipefd[WRITE_END], str, sizeof(str));
	}
	return 0;
}
