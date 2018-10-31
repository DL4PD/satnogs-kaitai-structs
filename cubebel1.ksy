meta:
  id: cubebel1
  endian: le

seq:
  - id: ax25_header
    type: ax25_hdr
    doc-ref: 'https://www.tapr.org/pub_ax25.html'
    size: 16
  - id: ax25_info
    type: cubebel1_data
    size: 256

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

  cubebel1_data:
    seq:
      - id: cubebel1_modem_id
        type: u1
      - id: cubebel1_opr_time
        type: u2
      - id: cubebel1_reboots
        type: u1
      - id: cubebel1_mcucr
        type: u1
      - id: cubebel1_pamp_temp
        type: u2
      - id: cubebel1_pamp_v
        type: u2
      - id: cubebel1_attn
        type: u1
      - id: cubebel1_v_bat
        type: u2
      - id: cubebel1_v_sys
        type: u2
      - id: cubebel1_seq_nr
        type: u1
      - id: cubebel1_pwr_save
        type: u1
      - id: cubebel1_modem_rx_on_time
        type: u1
      - id: cubebel1_obc_can_state
        type: u1
      - id: cubebel1_eps_can_state
        type: u1
      - id: cubebel1_info_size
        type: u1
      - id: cubebel1_data_type
        type: s1
      - id: cubebel1_rf_msg
        type: str
        encoding: ASCII
        terminator: 0

