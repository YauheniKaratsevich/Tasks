 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>

 #include <sys/types.h>
 #include <sys/wait.h>

 #define WRITE_END 1	
 #define READ_END 0

 int main( int argc, char *argv[] ) {
 	char *arg[2];
 	int pipefd[2];
 	pipe(pipefd);

 	pid_t pid_a = fork();
 	if( pid_a == 0 ) {
 		execv("./a", (char *)(pipefd) );
 	}

 	pid_t pid_b = fork();
 	if( pid_b == 0 ) {
 	 	execvp("./b", (char *)(pipefd) );
 	 }
	
	//wait( NULL );
 	//printf("Main is finished!");
 	return 0;
 }


