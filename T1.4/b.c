#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main( void ) {
	int in;
	while( 1 ) {
		in = getchar();
		putchar(in);	
	}
	return 0;
}
