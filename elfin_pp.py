#
# Preprocessor used in katai struct to remove the escape sequences of
# an ELFIN STAR telemetry frame
#
# Patrick Dohmen, DL4PD (dl4pd@darc.de)
#
# Usage in 'kaitai struct':
#
# types:
#   preprocessor:
#     seq:
#       - id: databuf
#         size-eos: true
#         process: elfin_pp
#

import re, binascii

class ElfinPp:
    def decode(self, bindata):
        # convert bin to hex to use regex for substitution
        hexdata = binascii.hexlify(bindata)
        
        # substitute ELFIN STAR payload escape sequence
        hexdata = re.sub('2727', '27', hexdata)
        hexdata = re.sub('275[Ee]', '5E', hexdata)
        hexdata = re.sub('2793', '93', hexdata)
        
        # convert back to binary
        returnbuf = binascii.unhexlify(hexdata)
        
        return returnbuf

