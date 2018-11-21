meta:
  id: irvine01_udp_payload
  endian: be
  
seq:
  - id: spacecraft_response
    type: u1
  - id: spacecraft_id
    type: str
    encoding: ASCII
    terminator: 0
  - id: ldc
    type: u2
    doc: 'value = ldc * 256 [s]'
  - id: gyro
    type: s4
    repeat: expr
    repeat-expr: 3
    doc: 'value = gyro / (1024.0 * 1024.0) [deg/s]'
  - id: mag
    type: s4
    repeat: expr
    repeat-expr: 3
    doc: 'value = mag / (1024.0 * 1024.0) [nT]'
  - id: daughter_a_tmp_sensor
    type: s2
    doc: 'value [°C]'
  - id: three_v_pl_tmp_sensor
    type: s2
    doc: 'value [°C]'
  - id: temp_nz
    type: s2
    doc: 'value [°C]'
  - id: volt3v
    type: s1
  - id: curr3v
    type: s1
  - id: volt5vpl
    type: s1
  - id: curr5vpl
    type: s1
  
  - id: irvine01_unparsed_payload
    size-eos: true
    doc: |
      IRVINE-01 payload inside a UDP datagram multicast packet
      Currently partially reverse-engineered
      Conversion values taken from source-code

