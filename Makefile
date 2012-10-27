AS = nasm
ASFLAGS = -f elf 
LD = gcc
PROGNAME = linkedlist
SOURCE = linkedlist.asm
OBJECT = linkedlist.o

all: $(PROGNAME)

$(PROGNAME):
	$(AS) $(ASFLAGS) $(SOURCE)
	$(LD) -o $(PROGNAME) $(OBJECT)
	rm -rf $(OBJECT)

clean:
	rm -rf $(PROGNAME) $(OBJECT)
