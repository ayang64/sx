CFLAGS	:=	-MMD -std=gnu99 -Wall -W -ggdb
os			:=	$(shell uname)
target	:=	sx
bison_output	:=	parser.tab.c parser.tab.h
flex_output		:=	lexer.c lexer.h
sources	:=	parser.tab.c lexer.c
objects	:=	$(sources:.c=.o)

ifeq ($(os), FreeBSD)
	# make sure we use flex and bison from ports -- not the system versions which tend to be old.
	flex		:=	/usr/local/bin/flex
	bison		:=	/usr/local/bin/bison
else
	# otherwise we use whichever flex and bison we have in our $PATH
	flex		:=	flex
	bison		:=	bison
endif

.PHONY : clean

%.tab.h %.tab.c : %.y
	$(bison) -d $<  

%.c : %.l
	$(flex) $<

$(target): $(bison_output) $(flex_output) $(objects)
	$(CC) $(objects) -o $@ -ll -ly

$(bison_output) : parser.y

$(flex_output) : lexer.l

clean:
	rm -f $(sources) $(target) $(bison_output) $(flex_output) *.o *.d 

-include *.d
