CC = gcc
MPICC = mpicc
NVCC = nvcc
CFLAGS = -O3 -std=gnu11 -Wall
OMPFLAGS = -fopenmp
NVCCFLAGS = -O3 -std=c++11
SFMTDIR = ../misc/SFMT-src-1.5.1
SFMTFLAGS = -I$(SFMTDIR) -D SFMT_MEXP=19937
MISC_OBJS = SFMT.o timer.o
OPENMP = -fopenmp

all: clean run

CC: CC.o $(MISC_OBJS)
	$(NVCC) $(NVCCFLAGS) -o $@ $^ -lm

CC.o: CC.cu
	$(NVCC) $(NVCCFLAGS) -c $<

bcbg: bcbg.o $(MISC_OBJS)
	$(NVCC) $(NVCCFLAGS) $(SFMTFLAGS) -o $@ $^ -lm

bcbg.o: bcbg.cu
	$(NVCC) $(NVCCFLAGS) $(SFMTFLAGS) -c $<

SFMT.o: $(SFMTDIR)/SFMT.c $(SFMTDIR)/SFMT.h
	$(CC) $(CFLAGS) $(SFMTFLAGS) -c $<

timer.o: ../misc/timer.c
	$(CC) $(CFLAGS) -c $<

run: bcbg
	./bcbg

clean:
	rm -f bcbg *.o

distclean: clean
	rm -f *.dat
