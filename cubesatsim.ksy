meta:
  id: cubesatsim
  endian: be

seq:
  - id: ax25_header
    doc-ref: 'https://www.tapr.org/pub_ax25.html'
    type: hdr
    size: 15
  - id: frametype
    type:
      switch-on: ax25_header.ctrl & 0x13
      cases:
        0x03: ui_frame
        0x13: ui_frame
        0x00: i_frame
        0x02: i_frame
        0x10: i_frame
        0x12: i_frame
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

  i_frame:
    seq:
      - id: pid
        type: u1
      - id: ax25_info
        size-eos: true

  ui_frame:
    seq:
      - id: pid
        type: u1
      - id: ax25_info
        size-eos: true
        type: cubesatsim_data

  cubesatsim_data:
    seq:
      - id: data_type
        type: u2
      - id: payload
        type:
          switch-on: data_type
          cases:
            _:  cubesatsim_ao_7
            0x6869:  cubesatsim_ao_7
            
  cubesatsim_ao_7:
    seq:
      - id: ao_7_magic
        contents: ' hi '
      - id: channel_1a_id
        contents: '1'
      - id: channel_1a_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_1a
        size: 1
      - id: channel_1b_id
        contents: '1'
      - id: channel_1b_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_1b
        size: 1
      - id: channel_1c_id
        contents: '1'
      - id: channel_1c_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_1c
        size: 1
      - id: channel_1d_id
        contents: '1'
      - id: channel_1d_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_1d
        size: 1

      - id: channel_2a_id
        contents: '2'
      - id: channel_2a_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_2a
        size: 1
      - id: channel_2b_id
        contents: '2'
      - id: channel_2b_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_2b
        size: 1
      - id: channel_2c_id
        contents: '2'
      - id: channel_2c_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_2c
        size: 1
      - id: channel_2d_id
        contents: '2'
      - id: channel_2d_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_2d
        size: 1

      - id: channel_3a_id
        contents: '3'
      - id: channel_3a_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_3a
        size: 1
      - id: channel_3b_id
        contents: '3'
      - id: channel_3b_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_3b
        size: 1
      - id: channel_3c_id
        contents: '3'
      - id: channel_3c_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_3c
        size: 1
      - id: channel_3d_id
        contents: '3'
      - id: channel_3d_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_3d
        size: 1

      - id: channel_4a_id
        contents: '4'
      - id: channel_4a_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_4a
        size: 1
      - id: channel_4b_id
        contents: '4'
      - id: channel_4b_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_4b
        size: 1
      - id: channel_4c_id
        contents: '4'
      - id: channel_4c_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_4c
        size: 1
      - id: channel_4d_id
        contents: '4'
      - id: channel_4d_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_4d
        size: 1

      - id: channel_5a_id
        contents: '5'
      - id: channel_5a_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_5a
        size: 1
      - id: channel_5b_id
        contents: '5'
      - id: channel_5b_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_5b
        size: 1
      - id: channel_5c_id
        contents: '5'
      - id: channel_5c_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_5c
        size: 1
      - id: channel_5d_id
        contents: '5'
      - id: channel_5d_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_5d
        size: 1

      - id: channel_6a_id
        contents: '6'
      - id: channel_6a_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_6a
        size: 1
      - id: channel_6b_id
        contents: '6'
      - id: channel_6b_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_6b
        size: 1
      - id: channel_6c_id
        contents: '6'
      - id: channel_6c_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_6c
        size: 1
      - id: channel_6d_id
        contents: '6'
      - id: channel_6d_val_raw
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: delim_6d
        size: 1
        
    instances:
        channel_1a_val:
          value: ((channel_1a_val_raw[0] - 0x30) * 10 + (channel_1a_val_raw[1] - 0x30)) * 29.5
          doc: 'value * 29.5 [mA]'
        channel_1b_val:
          value: 1970 - (20 * ((channel_1b_val_raw[0] - 0x30) * 10 + (channel_1b_val_raw[1] - 0x30)))
          doc: '1970 - (20 * value) [mA]'
        channel_1c_val:
          value: 1970 - (20 * ((channel_1c_val_raw[0] - 0x30) * 10 + (channel_1c_val_raw[1] - 0x30)))
          doc: '1970 - (20 * value) [mA]'
        channel_1d_val:
          value: (channel_1d_val_raw[0] - 0x30) * 10 + (channel_1d_val_raw[1] - 0x30)
          doc: '1970 - (20 * value) [mA]'

        channel_2a_val:
          value: 1970 - (20 * ((channel_2a_val_raw[0] - 0x30) * 10 + (channel_2a_val_raw[1] - 0x30)))
          doc: '1970 - (20 * value) [mA]'
        channel_2b_val:
          value: 8 * ((1 - 0.01 * ((channel_2b_val_raw[0] - 0x30) * 10 + (channel_2b_val_raw[1] - 0x30))) * (1 - 0.01 * ((channel_2b_val_raw[0] - 0x30) * 10 + (channel_2b_val_raw[1] - 0x30))))
          doc: '8 * (1 - 0.01 * value)^2 [W]'
        channel_2c_val:
          value: 15.16 * ((channel_2c_val_raw[0] - 0x30) * 10 + (channel_2c_val_raw[1] - 0x30))
          doc: '15.16 * value [h]'
        channel_2d_val:
          value: 40 * (((channel_2d_val_raw[0] - 0x30) * 10 + (channel_2d_val_raw[1] - 0x30)) - 50)
          doc: '40 * (value - 50) [mA]'

        channel_3a_val:
          value: 0.1 * ((channel_3a_val_raw[0] - 0x30) * 10 + (channel_3a_val_raw[1] - 0x30)) + 6.4
          doc: '0.1 * value + 6.4 [V]'
        channel_3b_val:
          value: 0.1 * ((channel_3b_val_raw[0] - 0x30) * 10 + (channel_3b_val_raw[1] - 0x30))
          doc: '0.1 * value [V]'
        channel_3c_val:
          value: 0.15 * ((channel_3c_val_raw[0] - 0x30) * 10 + (channel_3c_val_raw[1] - 0x30))
          doc: '0.15 * value [V]'
        channel_3d_val:
          value: 95.8 - 1.48 * ((channel_3d_val_raw[0] - 0x30) * 10 + (channel_3d_val_raw[1] - 0x30))
          doc: '95.8 - 1.48 * value [°C]'

        channel_4a_val:
          value: 95.8 - 1.48 * ((channel_4a_val_raw[0] - 0x30) * 10 + (channel_4a_val_raw[1] - 0x30))
          doc: '95.8 - 1.48 * value [°C]'
        channel_4b_val:
          value: 95.8 - 1.48 * ((channel_4b_val_raw[0] - 0x30) * 10 + (channel_4b_val_raw[1] - 0x30))
          doc: '95.8 - 1.48 * value [°C]'
        channel_4c_val:
          value: 95.8 - 1.48 * ((channel_4c_val_raw[0] - 0x30) * 10 + (channel_4c_val_raw[1] - 0x30))
          doc: '95.8 - 1.48 * value [°C]'
        channel_4d_val:
          value: 95.8 - 1.48 * ((channel_4d_val_raw[0] - 0x30) * 10 + (channel_4d_val_raw[1] - 0x30))
          doc: '95.8 - 1.48 * value [°C]'
  
        channel_5a_val:
          value: 95.8 - 1.48 * ((channel_5a_val_raw[0] - 0x30) * 10 + (channel_5a_val_raw[1] - 0x30))
          doc: '95.8 - 1.48 * value [°C]'
        channel_5b_val:
          value: 11.67 * ((channel_5b_val_raw[0] - 0x30) * 10 + (channel_5b_val_raw[1] - 0x30))
          doc: '11.67 * value [mA]'
        channel_5c_val:
          value: 95.8 - 1.48 * ((channel_5c_val_raw[0] - 0x30) * 10 + (channel_5c_val_raw[1] - 0x30))
          doc: '95.8 - 1.48 * value [°C]'
        channel_5d_val:
          value: 11 + 0.82 * ((channel_5d_val_raw[0] - 0x30) * 10 + (channel_5d_val_raw[1] - 0x30))
          doc: '11 + 0.82 * value [mA]'

        channel_6a_val:
          value: (((channel_6a_val_raw[0] - 0x30) * 10 + (channel_6a_val_raw[1] - 0x30)) * ((channel_6a_val_raw[0] - 0x30) * 10 + (channel_6a_val_raw[1] - 0x30))) / 1.56
          doc: 'value^2 / 1.56 [mA]'
        channel_6b_val:
          value: 0.1 * (((channel_6b_val_raw[0] - 0x30) * 10 + (channel_6b_val_raw[1] - 0x30)) * ((channel_6b_val_raw[0] - 0x30) * 10 + (channel_6b_val_raw[1] - 0x30))) + 35
          doc: '0.1 * value^2 + 35 [mA]'
        channel_6c_val:
          value: 0.041 * (((channel_6c_val_raw[0] - 0x30) * 10 + (channel_6c_val_raw[1] - 0x30)) * ((channel_6c_val_raw[0] - 0x30) * 10 + (channel_6c_val_raw[1] - 0x30)))
          doc: '0.041 * value^2 [mA]'
        channel_6d_val:
          value: 0.01 * ((channel_6d_val_raw[0] - 0x30) * 10 + (channel_6d_val_raw[1] - 0x30))
          doc: '0.01 * value'

