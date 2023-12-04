FC=gfortran
EXT=f90

FFLAGS_g95      = -g -pedantic -Wall -fbounds-check -ftrace=full
FFLAGS_gfortran = -g -pedantic -Wall -Wimplicit-interface -Wunderflow -fbounds-check -fimplicit-none
FFLAGS_ifort    = -g -debug full -implicitnone -check -warn -free -Tf
FFLAGS_nagfor   = -g -gline -u -info -colour


# Select the right flags for the current compiler
FFLAGS=$(FFLAGS_$(FC))

all: matrix

hello_module.o: ./hello_module.$(EXT)
	$(FC) $(FFLAGS) -o $@ -c $^

hello_world.o: ./hello_world.$(EXT) ./hello_module.o
	$(FC) $(FFLAGS) -o $@ -c $<

hello_world: hello_world.o hello_module.o
	$(FC) $(FFLAGS) -o $@ $^ 

matrix.o: ./matrix.$(EXT)
	$(FC) $(FFLAGS) -o $@ -c $^

matrix: matrix.o
	$(FC) $(FFLAGS) -o $@ $^

clean:
	@ rm -f *.o *.mod hello_world matrix