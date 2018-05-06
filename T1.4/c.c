#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main( void ) {
	while( 1 ) {
		printf("C: %d \n", (int)getpid());
		sleep(3);
	}
	return 0;
}
