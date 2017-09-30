CC ?= gcc
CFLAGS ?= -w -Wall -Wextra -Wpedantic -pedantic-errors -std=c11
FC = gfortran
FCFLAGS ?= -Wall -Wextra -pedantic -fbacktrace -Warray-temporaries -Wsurprising -Wintrinsic-shadow -std=f2008 -fcheck=all

example: example.o str_array.o c_f_string.o
	$(FC) $(FCFLAGS) -o $@ $^

example.o : str_array.o c_f_string.o

%.o : %.f90
	$(FC) $(FCFLAGS) -o $@ -c $<

documentation: ford-prj.md README.md $(wildcard *.c) $(wildcard *.f90) $(wildcard *.h)
	-rm -r doc/*
	ford --warn $<

clean:
	-rm -r *.o *.mod example doc img

.PHONY: clean
