meta:
  id: irvine01
  endian: be

seq:
  - id: ax25_frame
    type: ax25_frame
    doc-ref: 'https://www.tapr.org/pub_ax25.html'

types:
  ax25_frame:
    seq:
    - id: ax25_header
      type: ax25_header
    - id: payload
      type:
        switch-on: ax25_header.ctl & 0x13
        cases:
          0x03: ui_frame
          0x13: ui_frame
          0x00: i_frame
          0x02: i_frame
          0x10: i_frame
          0x12: i_frame
          #0x11: s_frame

  ax25_header:
    seq:
      - id: dest_callsign_raw
        type: dest_callsign_raw
      - id: dest_ssid_raw
        type: u1
      - id: src_callsign_raw
        type: src_callsign_raw
      - id: src_ssid_raw
        type: u1
      - id: ctl
        type: u1
    instances:
      src_ssid:
        value: (src_ssid_raw & 0x0f) >> 1
      dest_ssid:
        value: (dest_ssid_raw & 0x0f) >> 1
  dest_callsign_raw:
    seq:
      - id: dest_callsign_ror
        process: ror(1)
        size: 6
        type: dest_callsign
  src_callsign_raw:
    seq:
      - id: src_callsign_ror
        process: ror(1)
        type: src_callsign
        size: 6
  dest_callsign:
    seq:
      - id: dest_callsign
        type: str
        encoding: ASCII
        size: 6
  src_callsign:
    seq:
      - id: src_callsign
        type: str
        encoding: ASCII
        size: 6

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
        type:
          switch-on: pid
          cases:
            0xCC: ipv4_pkt
            0xF0: none_l3
        size-eos: true

  none_l3:
    seq:
      - id: data
        size-eos: true

  ipv4_pkt:
    seq:
      - id: b1
        type: u1
      - id: b2
        type: u1
      - id: total_length
        type: u2be
      - id: identification
        type: u2be
      - id: b67
        type: u2be
      - id: ttl
        type: u1
      - id: protocol
        type: u1
        enum: protocol_enum
      - id: header_checksum
        type: u2be
      - id: src_ip_addr
        size: 4
      - id: dst_ip_addr
        size: 4
      - id: options
        type: ipv4_options
        size: ihl_bytes - 20
      - id: body
        size: total_length - ihl_bytes
        type:
          switch-on: protocol
          cases:
            'protocol_enum::tcp': tcp_segm
            'protocol_enum::icmp': icmp_pkt
            'protocol_enum::udp': udp_dtgrm
            'protocol_enum::ipv6': ipv6_pkt
    enums:
      protocol_enum:
        # http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml
        0: hopopt
        1: icmp
        2: igmp
        3: ggp
        4: ipv4
        5: st
        6: tcp
        7: cbt
        8: egp
        9: igp
        10: bbn_rcc_mon
        11: nvp_ii
        12: pup
        13: argus
        14: emcon
        15: xnet
        16: chaos
        17: udp
        18: mux
        19: dcn_meas
        20: hmp
        21: prm
        22: xns_idp
        23: trunk_1
        24: trunk_2
        25: leaf_1
        26: leaf_2
        27: rdp
        28: irtp
        29: iso_tp4
        30: netblt
        31: mfe_nsp
        32: merit_inp
        33: dccp
        34: x_3pc
        35: idpr
        36: xtp
        37: ddp
        38: idpr_cmtp
        39: tp_plus_plus
        40: il
        41: ipv6
        42: sdrp
        43: ipv6_route
        44: ipv6_frag
        45: idrp
        46: rsvp
        47: gre
        48: dsr
        49: bna
        50: esp
        51: ah
        52: i_nlsp
        53: swipe
        54: narp
        55: mobile
        56: tlsp
        57: skip
        58: ipv6_icmp
        59: ipv6_nonxt
        60: ipv6_opts
        61: any_host_internal_protocol
        62: cftp
        63: any_local_network
        64: sat_expak
        65: kryptolan
        66: rvd
        67: ippc
        68: any_distributed_file_system
        69: sat_mon
        70: visa
        71: ipcv
        72: cpnx
        73: cphb
        74: wsn
        75: pvp
        76: br_sat_mon
        77: sun_nd
        78: wb_mon
        79: wb_expak
        80: iso_ip
        81: vmtp
        82: secure_vmtp
        83: vines
        84: ttp
        84: iptm
        85: nsfnet_igp
        86: dgp
        87: tcf
        88: eigrp
        89: ospfigp
        90: sprite_rpc
        91: larp
        92: mtp
        93: ax_25
        94: ipip
        95: micp
        96: scc_sp
        97: etherip
        98: encap
        99: any_private_encryption_scheme
        100: gmtp
        101: ifmp
        102: pnni
        103: pim
        104: aris
        105: scps
        106: qnx
        107: a_n
        108: ipcomp
        109: snp
        110: compaq_peer
        111: ipx_in_ip
        112: vrrp
        113: pgm
        114: any_0_hop
        115: l2tp
        116: ddx
        117: iatp
        118: stp
        119: srp
        120: uti
        121: smp
        122: sm
        123: ptp
        124: isis_over_ipv4
        125: fire
        126: crtp
        127: crudp
        128: sscopmce
        129: iplt
        130: sps
        131: pipe
        132: sctp
        133: fc
        134: rsvp_e2e_ignore
        135: mobility_header
        136: udplite
        137: mpls_in_ip
        138: manet
        139: hip
        140: shim6
        141: wesp
        142: rohc
        255: reserved_255
    instances:
      version:
        value: (b1 & 0xf0) >> 4
      ihl:
        value: b1 & 0xf
      ihl_bytes:
        value: ihl * 4

  ipv4_options:
    seq:
      - id: entries
        type: ipv4_option
        repeat: eos
  ipv4_option:
    seq:
      - id: b1
        type: u1
      - id: len
        type: u1
      - id: body
        size: 'len > 2 ? len - 2 : 0'
    instances:
      copy:
        value: (b1 & 0b10000000) >> 7
      opt_class:
        value: (b1 & 0b01100000) >> 5
      number:
        value: (b1 & 0b00011111)

  tcp_segm:
    seq:
      - id: src_port
        type: u2
      - id: dst_port
        type: u2
      - id: seq_num
        type: u4
      - id: ack_num
        type: u4
      - id: b12
        type: u1
      - id: b13
        type: u1
      - id: window_size
        type: u2
      - id: checksum
        type: u2
      - id: urgent_pointer
        type: u2
      - id: body
        size-eos: true

  icmp_pkt:
    seq:
      - id: icmp_type
        type: u1
        enum: icmp_type_enum
      - id: destination_unreachable
        type: destination_unreachable_msg
        if: icmp_type == icmp_type_enum::destination_unreachable
      - id: time_exceeded
        type: time_exceeded_msg
        if: icmp_type == icmp_type_enum::time_exceeded
      - id: echo
        type: echo_msg
        if: icmp_type == icmp_type_enum::echo or icmp_type == icmp_type_enum::echo_reply
    enums:
      icmp_type_enum:
        0: echo_reply
        3: destination_unreachable
        4: source_quench
        5: redirect
        8: echo
        11: time_exceeded

  destination_unreachable_msg:
    seq:
      - id: code
        type: u1
        enum: destination_unreachable_code
      - id: checksum
        type: u2
    enums:
      destination_unreachable_code:
        0: net_unreachable
        1: host_unreachable
        2: protocol_unreachable
        3: port_unreachable
        4: fragmentation_needed_and_df_set
        5: source_route_failed
        6: dst_net_unkown
        7: sdt_host_unkown
        8: src_isolated
        9: net_prohibited_by_admin
        10: host_prohibited_by_admin
        11: net_unreachable_for_tos
        12: host_unreachable_for_tos
        13: communication_prohibited_by_admin
        14: host_precedence_violation
        15: precedence_cuttoff_in_effect
  time_exceeded_msg:
    seq:
      - id: code
        type: u1
        enum: time_exceeded_code
      - id: checksum
        type: u2
    enums:
      time_exceeded_code:
        0: time_to_live_exceeded_in_transit
        1: fragment_reassembly_time_exceeded
  echo_msg:
    seq:
      - id: code
        contents: [0]
      - id: checksum
        type: u2
      - id: identifier
        type: u2
      - id: seq_num
        type: u2
      - id: data
        size-eos: true

  udp_dtgrm:
    seq:
      - id: src_port
        type: u2
      - id: dst_port
        type: u2
      - id: length
        type: u2
      - id: checksum
        type: u2
      - id: body
        type: irvine01_udp_payload
        size-eos: true

  ipv6_pkt:
    seq:
      - id: version
        type: b4
      - id: traffic_class
        type: b8
      - id: flow_label
        type: b20
      - id: payload_length
        type: u2
      - id: next_header_type
        type: u1
      - id: hop_limit
        type: u1
      - id: src_ipv6_addr
        size: 16
      - id: dst_ipv6_addr
        size: 16
      - id: next_header
        type:
          switch-on: next_header_type
          cases:
            0: option_hop_by_hop
            4: ipv4_pkt
            6: tcp_segm
            17: udp_dtgrm
            59: no_next_header
      - id: rest
        size-eos: true

  no_next_header: {}
  option_hop_by_hop:
    seq:
      - id: next_header_type
        type: u1
      - id: hdr_ext_len
        type: u1
      - id: body
        size: hdr_ext_len - 1
      - id: next_header
        type:
          switch-on: next_header_type
          cases:
            0: option_hop_by_hop
            6: tcp_segm
            59: no_next_header

  irvine01_udp_payload:
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
        doc: 'value daughter_a_tmp_sensor / 64.0 [°C]'
      - id: three_v_pl_tmp_sensor
        type: s2
        doc: 'value = three_v_pl_tmp_sensor / 64.0 [°C]'
      - id: temp_nz
        type: s2
        doc: 'value = temp_nz / 64.0 [°C]'
      - id: volt3v
        type: s4
        doc: 'value = volt3v / (256.0 * 256.0)'
      - id: curr3v
        type: s4
        doc: 'value = curr3v / (256.0 * 256.0)'
      - id: volt5vpl
        type: s4
        doc: 'value = volt5vpl / (256.0 * 256.0)'
      - id: curr5vpl
        type: s4
        doc: 'value = curr5vpl / (256.0 * 256.0)'

    instances:
      ldc_secs:
        value: ldc * 256.0
      ldc_mins:
        value: ldc_secs / 60.0
      ldc_hrs:
        value: ldc_mins / 60.0

      mag_x:
        value: mag[0] / (1024.0 * 1024.0)
      mag_y:
        value: mag[1] / (1024.0 * 1024.0)
      mag_z:
        value: mag[2] / (1024.0 * 1024.0)
        doc: 'Magnitudes in [nT]!'

      gyro_x:
        value: gyro[0] / (1024.0 * 1024.0)
      gyro_y:
        value: gyro[1] / (1024.0 * 1024.0)
      gyro_z:
        value: gyro[2] / (1024.0 * 1024.0)
        doc: 'Gyroscope in [deg/s]!'

      daughter_a_tmp_sensor_val_k:
        value: daughter_a_tmp_sensor / 64.0
      three_v_pl_tmp_sensor_val_k:
        value: three_v_pl_tmp_sensor / 64.0
      temp_nz_val_k:
        value: temp_nz / 64.0
        doc: 'Temperatures in [K]!'
      daughter_a_tmp_sensor_val_deg_c:
        value: daughter_a_tmp_sensor_val_k - 273.15
      three_v_pl_tmp_sensor_val_deg_c:
        value: three_v_pl_tmp_sensor_val_k - 273.15
      temp_nz_val_deg_c:
        value: temp_nz_val_k - 273.15
        doc: 'Temperatures in [°C]!'

      volt3v_val:
        value: volt3v / (256.0 * 256.0)
      curr3v_val:
        value: curr3v / (256.0 * 256.0)
      volt5vpl_val:
        value: volt5vpl / (256.0 * 256.0)
      curr5vpl_val:
        value: curr5vpl / (256.0 * 256.0)
        doc: 'Voltages in [V]! Currents in [A]!'

        doc: |
          IRVINE-01 payload inside a UDP datagram multicast packet
          Currently partially reverse-engineered
          Conversion values taken from source-code
