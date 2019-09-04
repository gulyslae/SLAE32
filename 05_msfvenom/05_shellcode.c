#include <stdio.h>
#include <string.h>

// gcc 05_shellcode.c -o 05_shellcode -fno-stack-protector -z execstack -m32

//#include "exec.c"
//#include "readfile.c"
#include "reverse.c"

main()
{

	printf("Shellcode Length:  %d\n", strlen(buf));
	int (*ret)() = (int(*)())buf;

	ret();

}

