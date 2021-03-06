################################################################################
#
#   Makefile to compile and link Fortran programs
#
#  "make" compiles and links the specified main programs and modules
#  using the specified libraries (if any), and produces the executables;
#  by default it deletes also object files after producing executables.
# 
#  "make clean" removes all files apart from source codes.
#
################################################################################

all: rmxeq cmpsc mkxeq rmpmk
.PHONY: all

# main programs

MAIN = free_dos

# required modules

ROUTINES = freemod  gaussian  kgen  deallocate_all  input_free  ggen_free  \
		set_hamiltonian

GLOBAL = kind  constants  set_lattice  recips  \
		calculate_radius  hpsort

MODULES = $(GLOBAL)  $(ROUTINES)

# search path for modules

MDIR = ../modules  ../../global

VPATH = $(MDIR)


# additional include directories

INCPATH = # ../include  /usr/include


# additional libraries to be included 

LIBS = lapack  blas

LIBPATH = /usr/local/lib


# Optimization and debugging flags for Fortran compiler

FCFLAGS = -Wall -Wextra -C -g3 -fbacktrace -O2 -fbounds-check

SHELL=/bin/bash

FC = gfortran

PROGRAMS = $(MODULES) $(MAIN)

INCDIRS = $(addprefix -I,$(INCPATH))

OBJECTS = $(addsuffix .o,$(MODULES))

LDFLAGS = $(addprefix -L,$(LIBPATH)) $(addprefix -l,$(LIBS))


############################ definition of rules ###############################

# compile source programs

$(addsuffix .o,$(PROGRAMS)): %.o: %.f90 Makefile
	@ $(FC) $(LDFLAGS) $(FCFLAGS) $(INCDIRS) -c $<


# link object files and produce executables

$(MAIN): %: %.o $(OBJECTS)
	@ $(FC) $(FCFLAGS) $(LDFLAGS) -o $@ $^


# produce executables

cmpsc: $(addsuffix .o,$(PROGRAMS))

mkxeq: $(MAIN)
	@ echo "  linking object files and producing executables"


# remove old executables and old error log file

rmxeq:
	@ -rm -f $(MAIN); \
        echo "  delete old executables"


# clean directory

rmpmk:
	@ -rm -rf *.o .tmp; \
		echo "  delete object and temporary files"


.PHONY: clean

clean: rmpmk
	@ rm -f *.mod *.MOD *~ $(PROGRAMS); \
		echo "  main directory cleaned"


################################################################################
