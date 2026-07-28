CC		= cc
CFLAGS	= -Wall -Wextra -Werror
 
NAMES	= Colleen Grace Sully
OBJS	= $(NAMES:=.o)
 
all: $(NAMES)
 
Colleen: Colleen.o
	$(CC) $(CFLAGS) -o $@ $^
 
Grace: Grace.o
	$(CC) $(CFLAGS) -o $@ $^
 
Sully: Sully.o
	$(CC) $(CFLAGS) -o $@ $^
 
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
 
clean:
	rm -f $(OBJS)
 
fclean: clean
	rm -f $(NAMES)
 
re: fclean all
 
