CC=gcc
CFLAGS="-Wall"

debug:clean
	$(CC) $(CFLAGS) -g -o simpleos main.c
stable:clean
	$(CC) $(CFLAGS) -o simpleos main.c
clean:
	rm -vfr *~ simpleos
