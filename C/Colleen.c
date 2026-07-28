// outside comment
#include <stdio.h>
char *data = "// outside comment%c#include <stdio.h>%cchar *data = %c%s%c;%cvoid print(){printf(data, 10, 10, 34, data, 34, 10, 10, 10, 10, 9, 10, 9, 10);}%cint main()%c{%c%c// this is a comment%c%cprint();%c}";
void print(){printf(data, 10, 10, 34, data, 34, 10, 10, 10, 10, 9, 10, 9, 10);}
int main()
{
	// this is a comment
	print();
}