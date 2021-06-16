CC=gcc
LD=gcc
OPT=-O2
DBG=-g
CFLAGS = $(OPT) $(DBG)
LDFLAGS = $(OPT) $(DBG)

ifeq ($(shell uname),Linux)
# GNU/Linux OS
	INTERPN = libInterpn.so
	CFLAGS = $(OPT) $(DBG) -fPIC
else
# Mac OSX
	INTERPN = libInterpn.dylib
	LD = gfortran
endif

.DEFAULT:
	-touch $@
all: $(INTERPN)
interpn.o: ./interpn.c
	$(CC) $(CPPDEFS) $(CPPFLAGS) $(CFLAGS) $(OTHERFLAGS) -c	./interpn.c
isanan.o: ./isanan.c isanan.h machine.h
	$(CC) $(CPPDEFS) $(CPPFLAGS) $(CFLAGS) $(OTHERFLAGS) -c -I.	./isanan.c
returnanan.o: ./returnanan.c returnanan.h machine.h
	$(CC) $(CPPDEFS) $(CPPFLAGS) $(CFLAGS) $(OTHERFLAGS) -c -I.	./returnanan.c
someinterp.o: ./someinterp.c someinterp.h isanan.h machine.h returnanan.h
	$(CC) $(CPPDEFS) $(CPPFLAGS) $(CFLAGS) $(OTHERFLAGS) -c -I.	./someinterp.c
SRC = ./returnanan.c ./someinterp.c ./isanan.c ./interpn.c machine.h returnanan.h isanan.h someinterp.h
OBJ = returnanan.o someinterp.o isanan.o interpn.o
clean: neat
	-rm -f .cppdefs $(OBJ)
	if test -e libInterpn.so ; \
	then \
		(rm -f libInterpn.so) ; \
	fi
neat:
	-rm -f $(TMPFILES)
TAGS: $(SRC)
	etags $(SRC)
tags: $(SRC)
	ctags $(SRC)
libInterpn.so: $(OBJ)
	$(LD) $(OBJ) -shared -o libInterpn.so $(LDFLAGS)
libInterpn.dylib: $(OBJ)
	$(LD) $(OBJ) -dynamiclib -o libInterpn.so $(LDFLAGS)
