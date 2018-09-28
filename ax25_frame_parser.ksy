meta:
  id: ax25_frame_parser
  endian: be
  doc: 'Current implementation only supports AX.25 I frames'
seq:
  - id: ax25_header
    type: ax25_hdr
    size: 16
  - id: ax25_info
    type: str
    encoding: ASCII
    size-eos: true
types:
  ax25_hdr:
    seq:
      - id: dest_callsign
        type: str
        encoding: ASCII
        size: 6
      - id: dest_ssid
        type: u1
      - id: src_callsign
        type: str
        encoding: ASCII
        size: 6
      - id: src_ssid
        type: u1
      - id: ctl
        type: u1
      - id: pid
        type: u1
