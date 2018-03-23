TARGET = hello
.PHONY: all libs clean

all: $(TARGET)

clean:
	rm -rf $(TARGET) *.o *.a *.so

libgoodbye_stat.a: libgoodbye.c
	gcc -c -o libgoodbye.o libgoodbye.c
	ar rc libgoodbye_stat.a libgoodbye.o
	
libhello-dyn.so: libhello.c
	gcc -fPIC -c -o libhello.o libhello.c
	gcc -shared -o libhello-dyn.so libhello.o

libs: libhello-dyn.so libgoodbye_stat.a

$(TARGET): libs hello.c
	gcc -c -o hello.o hello.c
	gcc hello.o -L. -lgoodbye_stat -lhello-dyn -o $(TARGET) 
