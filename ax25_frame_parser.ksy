meta:
  id: ax25_frame_parser
  endian: be
  doc: 'Current implementation only supports AX.25 UI frames'
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
        type: dest_callsign
      - id: dest_ssid
        type: u1
      - id: src_callsign
        type: src_callsign
      - id: src_ssid
        type: u1
      - id: ctl
        type: u1
      - id: pid
        type: u1
  dest_callsign:
    seq:
      - id: dest_callsign
        process: ror(1)
        size: 6
  src_callsign:
    seq:
      - id: src_callsign
        process: ror(1)
        size: 6
