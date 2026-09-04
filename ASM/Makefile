ASM			= nasm
ASMFLAGS	= -f elf64
CC			= cc
NAMES		= Colleen Grace Sully
OBJS		= $(NAMES:=.o)

all: $(NAMES)

Colleen: Colleen.o
	$(CC) -o $@ $^

Grace: Grace.o
	$(CC) -o $@ $^

Sully: Sully.o
	$(CC) -o $@ $^

%.o: %.s
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAMES)

re: fclean all
