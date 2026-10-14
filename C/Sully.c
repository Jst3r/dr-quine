#include <stdio.h>
#include <stdlib.h>
#define COUNT 5
char *data = "#include <stdio.h>%1$c#include <stdlib.h>%1$c#define COUNT %4$d%1$cchar *data = %6$c%7$s%6$c;%1$cint main()%1$c{%1$c    if (COUNT == 0)%1$c        exit(0);%1$c    int next_count = COUNT;%1$c#ifdef CHILD%1$c    next_count--;%1$c#endif%1$c    char src_file[32];%1$c    char bin_file[32];%1$c    sprintf((char *)src_file, %6$cSully_%%d.c%6$c, next_count);%1$c    sprintf((char *)bin_file, %6$cSully_%%d%6$c, next_count);%1$c    FILE *src_fd = fopen(src_file, %6$cw%6$c);%1$c    fprintf(src_fd, data, 10, 10, 10, next_count, 10, 34, data, 34, 10, 10, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 10, 10, 34, 34, 10, 34, 34, 10, 34, 34, 10, 10, 10, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 10, 10);%1$c    if (fclose(src_fd) == EOF)%1$c        return 1;%1$c    char command[1024];%1$c    sprintf((char *)command, %6$cgcc -Wall -Wextra -Werror -D CHILD Sully_%%d.c -o Sully_%%d%6$c, next_count, next_count);%1$c    system(command);%1$c    if (next_count >= 0)%1$c    {%1$c        sprintf(command, %6$c./Sully_%%d%6$c, next_count);%1$c        system(command);%1$c    }%1$c    return 0;%1$c}%1$c";
int main()
{
    if (COUNT == 0)
        exit(0);
    int next_count = COUNT;
#ifdef CHILD
    next_count--;
#endif
    char src_file[32];
    char bin_file[32];
    sprintf((char *)src_file, "Sully_%d.c", next_count);
    sprintf((char *)bin_file, "Sully_%d", next_count);
    FILE *src_fd = fopen(src_file, "w");
    fprintf(src_fd, data, 10, 10, 10, next_count, 10, 34, data, 34, 10, 10, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 10, 10, 34, 34, 10, 34, 34, 10, 34, 34, 10, 10, 10, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 10, 10);
    if (fclose(src_fd) == EOF)
        return 1;
    char command[1024];
    sprintf((char *)command, "gcc -Wall -Wextra -Werror -D CHILD Sully_%d.c -o Sully_%d", next_count, next_count);
    system(command);
    if (next_count >= 0)
    {
        sprintf(command, "./Sully_%d", next_count);
        system(command);
    }
    return 0;
}
