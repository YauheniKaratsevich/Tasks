#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define READ_END 0
//this process just return data from stdin
int main( int argc, char *argv[] ) {
	char str[20];
	int *pipefd;

	pipefd = (int *)argv[1];

	while( 1 ) {
		read(pipefd[READ_END], str, sizeof(str));
		printf("Received data is: %s", str);
	}
	return 0;
}
