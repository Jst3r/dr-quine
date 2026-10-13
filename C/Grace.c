#include <stdio.h>
//the one and only comment
#define FILENAME "Grace_kid.c"
#define DATA "#include <stdio.h>%c//the one and only comment%c#define FILENAME %cGrace_kid.c%c%c#define DATA %c%s%c%c#define ENTRY int main(void){FILE* file = fopen(FILENAME, %cw%c); fprintf(file, DATA, 10, 10, 34, 34, 10, 34, DATA, 34,10, 34, 34, 10, 10); return 0;}%cENTRY%c"
#define ENTRY int main(void){FILE* file = fopen(FILENAME, "w"); fprintf(file, DATA, 10, 10, 34, 34, 10, 34, DATA, 34,10, 34, 34, 10, 10); return 0;}
ENTRY
