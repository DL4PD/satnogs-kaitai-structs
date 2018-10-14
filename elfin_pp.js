/*
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
*/

/*
 * to use this in kaitai WebIDE remove comments:
 */

//localStorage.setItem("userTypes", `
class ElfinPp {
    constructor(_key) {
        this.key = _key;
    }
    _read() {
        this._io = {};
        this._debug = {};
    }
    decode(bindata)
    {
        var binlen = bindata.length;
        var ch, next_ch, i = 0;
        var out = [];
        
        while (i < binlen) {
            ch = bindata[i];
            if ((ch == 0x27) && ((i + 1) < binlen))
                next_ch = bindata[i + 1];
                if ((next_ch == 0x27) || (next_ch == 0x5e) || (next_ch == 0x9e))
                    i += 1;
            out = out.concat(bindata[i]);
            ch = 0, next_ch = 0;
            i += 1;
        }
        
        var rbuf = new Uint8Array(out.length);
        i = 0;
        while (i < out.length)
        {
            rbuf[i] = out[i];
            i += 1;
        }
        
        return rbuf;
    }
} this.ElfinPp = ElfinPp;
//`); 

