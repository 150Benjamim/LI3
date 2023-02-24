all: programa-principal programa-testes

IDIR = $/Includes

CC = gcc
CFLAGS = -Wall -I$(IDIR) -g `pkg-config --cflags glib-2.0` -c
LDFLAGS = `pkg-config --libs glib-2.0` -lm

SDIR = Code/SRC
ODIR = Code/SRC/obj

_OBJ = drivers.o rides.o users.o validator.o date.o catalog.o print_outputs.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(ODIR)/%.o: $(SDIR)/%.c
	mkdir -p $(@D)
	mkdir -p Resultados
	$(CC) $(CFLAGS) -o $@ $<


programa-principal: $(OBJ) $(ODIR)/programa_principal.o
	$(CC) $^ $(LDFLAGS) -o $@

programa-testes: $(OBJ) $(ODIR)/programa_testes.o
	$(CC) $^ $(LDFLAGS) -o $@
		

.PHONY: clean

clean:
	rm -r $(ODIR)
	rm -r Resultados
	rm programa-principal
	rm programa-testes
