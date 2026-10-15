ASM			= nasm
ASMFLAGS	= -f elf64
CC			= gcc
LDFLAGS		= -nostdlib -no-pie
NAMES		= Colleen Grace Sully
OBJS		= $(NAMES:=.o)

all: $(NAMES)


Colleen: Colleen.o
	$(CC) $(LDFLAGS) -o $@ $^

Grace: Grace.o
	$(CC) $(LDFLAGS) -o $@ $^

Sully: Sully.o
	$(CC) $(LDFLAGS) -o $@ $^

Colleen.o: Colleen.s
	$(ASM) $(ASMFLAGS) $< -o $@

%.o: %.s
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAMES)

re: fclean all

.PHONY: all colleen clean fclean re
