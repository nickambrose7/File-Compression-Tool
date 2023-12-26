CC = gcc
CFLAGS = -Wall -ansi -pedantic -g
LDFLAGS = -Wall -pedantic -g

all: hencode hdecode compression_ratio

hdecode: hdecode.o huffstuff.o
	$(CC) -o hdecode $(LDFLAGS) hdecode.o huffstuff.o

hencode: hencode.o huffstuff.o
	$(CC) -o hencode $(LDFLAGS) hencode.o huffstuff.o

compression_ratio: compression_ratio.o
	$(CC) -o compression_ratio $(LDFLAGS) compression_ratio.o

hencode.o: hencode.c huffmancoding.h
	$(CC) $(CFLAGS) -c hencode.c

hdecode.o: hdecode.c huffmancoding.h huffstuff.c
	$(CC) -c $(CFLAGS) hdecode.c

huff.o: huffstuff.c huffmancoding.h
	$(CC) $(CFLAGS) -c huffstuff.c

compression_ratio.o: compression_ratio.c
	$(CC) $(CFLAGS) -c compression_ratio.c

clean:
	rm -f *.o hencode hdecode compression_ratio

test: hencode
	./$(MAIN) input output
