// #include <stdio.h>
// #include <stdlib.h>
// #include <unistd.h>

// #include <sys/types.h>
// #include <sys/wait.h>

// #define WRITE 1	
// #define READ 0

// int main( int argc, char *argv[] ) {
// 	char *arg[2];
// 	int pipefd[2];
// 	pipe(pipefd);

// 	pid_t pid_a = fork();
// 	if( pid_a == 0 ) {
// 		// dup2(pipefd[WRITE], STDOUT_FILENO);
// 		// close(pipefd[READ]);
// 		execv("./a", arg );
// 	}

// 	// pid_t pid_b = fork();
// 	// if( pid_b == 0 ) {
// 	// 	dup2(pipefd[READ], STDIN_FILENO);
// 	// 	close(pipefd[WRITE]);
// 	// 	execvp("./b", NULL );
// 	// }

// 	printf("Main is finished!");
// 	return 0;
// }

#include <errno.h>
#include <stdio.h>
#include <unistd.h>
int main(int argc, char* argv[]) {
   pid_t pid1, pid2;
   int pipefd[2];
   // The two commands we'll execute.  In this simple example, we will pipe
   // the output of `ls` into `wc`, and count the number of lines present.
   char *argv1[] = {"./a", NULL};
   char *argv2[] = {"./b", NULL};
   // Create a pipe.
   pipe(pipefd);
   // Create our first process.
   pid1 = fork();
   if (pid1 == 0) {
      // Hook stdout up to the write end of the pipe and close the read end of
      // the pipe which is no longer needed by this process.
      dup2(pipefd[1], STDOUT_FILENO);
      close(pipefd[0]);
      // Exec `ls -l -h`.  If the exec fails, notify the user and exit.  Note
      // that the execvp variant first searches the $PATH before calling execve.
      execvp(argv1[0], argv1);
      perror("exec");
      return 1;
   }
   // Create our second process.
   pid2 = fork();
   if (pid2 == 0) {
      // Hook stdin up to the read end of the pipe and close the write end of
      // the pipe which is no longer needed by this process.
      dup2(pipefd[0], STDIN_FILENO);
      close(pipefd[1]);
      // Similarly, exec `wc -l`.
      execvp(argv2[0], argv2);
      perror("exec");
      return 1;
   }
   // Close both ends of the pipe.  The respective read/write ends of the pipe
   // persist in the two processes created above (and happen to be tying stdout
   // of the first processes to stdin of the second).
   close(pipefd[0]);
   close(pipefd[1]);
   // Wait for everything to finish and exit.
   // waitpid(pid1);
   // waitpid(pid2);
   // wait(NULL);
   return 0;
}