CC=gcc
FC=gfortran
LINKER=$(FC)
executable=cprint

$(executable): main.o cprint.o
	$(LINKER) -o $(executable) *.o

main.o: main.f90 cprint.o
	$(FC) -c main.f90

cprint.o: cprint.c
	$(CC) -c cprint.c

.PHONY:
clean: 
	-rm *.o $(executable)
