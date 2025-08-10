INC += -I../3rd/inc
INC += -I../inc
LIB_PATH += -L../3rd/lib
LIB_PATH += -L../output
CC=gcc
test :test.c main.c test2.c
	@$(CC) $(INC) $(LIB_PATH) $(CFLAGS) -o test test.c test2.c main.c -Wno-int-conversion -lcson -ljansson
clean:
	@rm -rf test

.PHONY: debug clean

debug: CFLAGS += -g
debug: clean test
