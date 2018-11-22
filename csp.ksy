meta:
  id: csp

seq:
  - id: csp_header
    type: csp_header
  - id: csp_data
    type: csp_data

types:
  csp_header:
    seq:
      - id: crc
        type: b1
      - id: rdp
        type: b1
      - id: xtea
        type: b1
      - id: hmac
        type: b1
      - id: reserved
        type: b4
      - id: src_port
        type: b6
      - id: dst_port
        type: b6
      - id: destination
        type: b5
      - id: source
        type: b5
      - id: priority
        type: b2

  csp_data:
    seq:
      - id: data
        size-eos: true

