meta:
  id: ax25_frames
  endian: le
seq:
  - id: ax25_header
    doc-ref: 'https://www.tapr.org/pub_ax25.html'
    type: hdr
    size: 15
  - id: frametype
    type:
      switch-on: ax25_header.ctrl
      cases:
        0x03: ui_frame
        0x13: ui_frame
#        0x11: s_frame

types:
  dest_address:
    seq:
      - id: dest_address_str
        type: str
        size: 6
        encoding: ASCII

  src_address:
    seq:
      - id: src_address_str
        type: str
        size: 6
        encoding: ASCII

  hdr:
    seq:
    - id: dest_address
      type: dest_address
      process: ror(1)
      size: 6
    - id: u_dest_ssid
      type: u1
    - id: src_address
      type: src_address
      process: ror(1)
      size: 6
    - id: u_src_ssid
      type: u1
    - id: ctrl
      type: u1
    instances:
      src_ssid:
        value: (u_src_ssid & 0x0f) >> 1
      dest_ssid:
        value: (u_dest_ssid & 0x0f) >> 1

  ui_frame:
    seq:
      - id: pid
        type: u1
      - id: ax25_info
        type: str
        encoding: ASCII
        size-eos: true

