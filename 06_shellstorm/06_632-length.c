#include <stdio.h>

char ss_632_my[]   = "\x31\xc0\x50\x5a\x68\x73\x74\x20\x20\x83\xc4\x08\x50\x83\xec\x04\x68\x61\x6c\x68\x6f\x68\x20\x6c\x6f\x63\x68\x70\x69\x6e\x67\xb0\x0b\x31\xe6\x52\x66\x68\x2d\x63\x31\xe1\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x31\xe3\x52\x56\x51\x53\x89\xd1\x31\xe1\xcd\x80";
char ss_632_orig[] = "\x31\xc0\x50\xb0\x0b\x68\x73\x74\x20\x20\x68\x61\x6c\x68\x6f\x68\x20\x6c\x6f\x63\x68\x70\x69\x6e\x67\x89\xe6\x52\x66\x68\x2d\x63\x89\xe1\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x56\x51\x53\x89\xe1\xcd\x80";


int main(int argc, char *argv[])
{
       	fprintf(stdout,"ss_632_my Length: %d\n",strlen(ss_632_my));
       	fprintf(stdout,"ss_632_orig Length: %d\n",strlen(ss_632_orig));
}

