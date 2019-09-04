**blog page: https://gulyslae.github.io/**

here i will present my code write to solve assignments for SLAE32.
i try to not write any html, C, python - except for latest assignment
and for foolproofing my encoder one.
this because the course's goal is to teach some ASM basic, not C or
python, and i see this as an interesting extra challenge.

blog posts, if i can call them this way, are just commented assembly.
you're not going to see any image or graph, just comments on top and
before ops.
if you just want the asm, you can easily grep -v ^\; *.asm and skip all
my ELS comments :)
i choose to tab on function name to save some tab/spaces before ops. i'm
not sure i really like it but i thought it was worth trying to do all
statements like this.
plus, i had some minor convention changes during the journey because i
felt free to test.

i actually wrote a very small bash script to compile asm:
    #!/bin/bash
    FILE="${1%.*}"
    # -w-other because jmp short esp gives warn...
    # elf32 and elf_i386 because i'm on a 64bit box, let's force it
    /usr/bin/nasm -w-other -f elf32 -o $FILE.o $FILE.asm
    /usr/bin/ld -m elf_i386 -o $FILE $FILE.o

the script is automatically runt at file write by using vimrc line:
>autocmd BufWritePost *.asm silent! !/path/to/compileasm.sh <afile>

reversing and debugging has been done with GEF, a very useful gdb
extension.

all the code has been published on this github repo, reachable at
https://github.com/gulyslae/SLAE32
license is CC-BY-NC-SA: please don't make commercial use of my code, attribute my mistake to me, and if you want ping me to say something

of course, the code "works on my VM" pretty well.

stop with all this speaking, time to assemble!

*SLAE-1037*
*This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/*
