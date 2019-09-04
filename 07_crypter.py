#!/usr/bin/python2
import base64
import pyDes
import sys
# author     : Sandro "guly" Zaccarini SLAE-1037
# purpose    : this program has been written for SLAE32 assignment 7, create your own crypter
# license    : CC-BY-NC-SA
#
# sample shellcode from my writeHelo:
# 0x4c,0x59,0x4c,0x59,0x4c,0x59,0x4c,0x59,0x31,0xc0,0x31,0xdb,0x31,0xd2,0x50,0x68,0x48,0x65,0x6c,0x6c,0xb0,0x04,0xb3,0x01,0x89,0xe1,0xb2,0x04,0xcd,0x80,0x31,0xc0,0x31,0xdb,0xfe,0xc0,0xb3,0x05,0xcd,0x80
# cut&paste output:
# $ python 07_crypter.py e 4c594c594c594c5931c031db31d2506848656c6cb004b30189e1b204cd8031c031dbfec0b305cd80
#   encrypted: 073e543ab84127b9073e543ab84127b9eeb6189ab96d2d36b739cd54b76ce7c5687bd097ce81c6085475224e548968eeb20a2b0ec28f703e6a7c7703f5e86c907de09ff91fd0dcae41c0807e2866bcf3f5c2c4632db3acdf
#   decrypted: 4c594c594c594c5931c031db31d2506848656c6cb004b30189e1b204cd8031c031dbfec0b305cd80
# $ python 07_crypter.py d 073e543ab84127b9073e543ab84127b9eeb6189ab96d2d36b739cd54b76ce7c5687bd097ce81c6085475224e548968eeb20a2b0ec28f703e6a7c7703f5e86c907de09ff91fd0dcae41c0807e2866bcf3f5c2c4632db3acdf
#   decrypted: 4c594c594c594c5931c031db31d2506848656c6cb004b30189e1b204cd8031c031dbfec0b305cd80

secret = bytes(base64.b64decode("U0xBRXJveCE="))

def help():
    print( "use: python2 %s e|d payload" % sys.argv[0])
    print( "where:")
    print( "  e => encrypt")
    print( "  d => decrypt")
    print( "  payload => shellcode\n")
    print( '  shellcode could be 0x414243 or 0x41,0x42,0x43 or \x41\x42\x43 and must NOT contain spaces')
    sys.exit()

if len(sys.argv) < 3:
    help()

dirtyPayload = sys.argv[2]
# remove '\x', then 0x, then , to have an hex-only shellcode
payload = dirtyPayload.replace('\\x','').replace('0x','').replace(',','')

# encrypt/decrypt object
des = pyDes.des(secret, pyDes.ECB, IV=None, padmode=pyDes.PAD_PKCS5)

if sys.argv[1] == 'e':
    # encrypt and print hex-encoded
    p = des.encrypt(payload)
    print( "encrypted: " + p.encode('hex'))
    # foolproof test
    print( "decrypted: " + des.decrypt(p))

elif sys.argv[1] == 'd':
    # because i'm sending an hex-encoded encrypted shellcode, we need to unhex it before to decrypt
    print( "decrypted: " + des.decrypt(payload.decode('hex')))
else:
    print( "invalid action, is e or d?")
    help()

# This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
