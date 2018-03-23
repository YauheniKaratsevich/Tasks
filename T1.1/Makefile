TARGET = hello
.PHONY: all libs clean
BIN_C = hello.c
STAT_LIB_C = libgoodbye.c 
DYN_LIB_C = libhello.c

all: $(TARGET)

clean:
	rm -rf $(TARGET) *.o *.a *.so

libstat.a: $(STAT_LIB_C)
	gcc -c -o libstat.o $(STAT_LIB_C)
	ar rc libstat.a libstat.o
	
libdyn.so: $(DYN_LIB_C)
	gcc -fPIC -c -o libdyn.o $(DYN_LIB_C)
	gcc -shared -o libdyn.so libdyn.o

libs: libdyn.so libstat.a

$(TARGET): libs $(BIN_C)
	gcc -c -o hello.o $(BIN_C)
	gcc hello.o -L. -lstat -ldyn -o $(TARGET) 


