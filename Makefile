CC = clang

all: cinit

cinit:
	$(CC) main.c -o cinitl -Wall -Werror

clean:
	rm -rf cinitl

.PHONY: all clean