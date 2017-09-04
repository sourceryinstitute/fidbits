CC=gcc
FC=gfortran
LINKER=$(FC)
executable=cprint

$(executable): main.o foo_module.o cprint.o
	$(LINKER) -o $(executable) *.o

main.o: main.f90 cprint.o foo_module.o
	$(FC) -c main.f90

foo_module.o: foo_module.f90 
	$(FC) -c foo_module.f90

cprint.o: cprint.c
	$(CC) -c cprint.c

.PHONY:
clean: 
	-rm *.o $(executable) *.mod
