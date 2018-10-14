#
# Preprocessor used in kaitai struct to remove the escape sequences of
# an ELFIN STAR telemetry frame
#
# Patrick Dohmen, DL4PD (dl4pd@darc.de)
# With the kind help of Mikhail Yakshin
#
# Usage in 'kaitai struct':
#
# types:
#   preprocessor:
#     seq:
#       - id: databuf
#         process: elfin_pp
#         size-eos: true
#

import binascii

class ElfinPp:
    def decode(self, bindata):
        i = 0
        binlen = len(bindata)
        out = b''
        while i < binlen:
            ch = ord(bindata[i])
            if ch == 0x27 and i + 1 < binlen:
                next_ch = ord(bindata[i + 1])
                if next_ch == 0x27 or next_ch == 0x5e or next_ch == 0x9e:
                    i += 1
            out += bindata[i]
            i += 1
        return out

if __name__ == "__main__":

    # some examples
    dec = ElfinPp()
    print binascii.hexlify(binascii.unhexlify('0011272722'))
    print binascii.hexlify(dec.decode(binascii.unhexlify('0011272722')))

    print binascii.hexlify(binascii.unhexlify('0011a2727220'))
    print binascii.hexlify(dec.decode(binascii.unhexlify('0011a2727220')))

    print binascii.hexlify(binascii.unhexlify('930027005e0027932727275e'))
    print binascii.hexlify(dec.decode(binascii.unhexlify('930027005e0027932727275e')))
