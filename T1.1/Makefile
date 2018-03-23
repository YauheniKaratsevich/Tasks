TARGET = hello
.PHONY: all libs clean
BIN_C = hello.c
STAT_LIB_C = libgoodbye.c libhello.c
STAT_LIB_OBJ = $(patsubst %.c, %.o, $(STAT_LIB_C))

all: $(TARGET)

clean:
	rm -rf $(TARGET) *.o *.a *.so

%.o: %.c
	gcc -c $< -o $@

libs: $(STAT_LIB_OBJ)
	ar rcs libstat.a $(STAT_LIB_OBJ)

$(TARGET): libs $(BIN_C)
	gcc -c $(BIN_C) -o hello.o
	gcc hello.o -L. -lstat -o $(TARGET) 


