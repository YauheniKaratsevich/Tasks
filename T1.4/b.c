#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

//this process just return data from stdin
int main( void ) {
	char str[20];
//	while( 1 ) {
		scanf("%s", str);
		printf("Received data is %s", str);
//	}
	return 0;
}
