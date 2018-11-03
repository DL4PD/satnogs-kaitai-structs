meta:
  id: pwsat2
  endian: le
  
seq:
  - id: delim
    type: u1
  - id: ax25_header
    type: ax25_hdr
    doc-ref: 'https://www.tapr.org/pub_ax25.html'
    size: 16
  - id: ax25_info
    type: pwsat2_data
    size-eos: true #: _io.size - 18

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
        type: asc_str
  src_callsign:
    seq:
      - id: src_callsign
        process: ror(1)
        size: 6
        type: asc_str

  asc_str:
    seq:
      - id: asc_str
        type: str
        encoding: ASCII
        size: 6

  pwsat2_data:
    seq:
      - id: pwsat2_obc
        type: pwsat2_obc
      - id: pwsat2_adcs
        type: pwsat2_adcs
        
  pwsat2_obc:
    seq:
      - id: notparsed_start
        type: u1
        repeat: expr
        repeat-expr: 6
      - id: pwsat2_obc_startup_boot_reason
        type: u2
      - id: pwsat2_obc_fw_crc
        type: u2
      - id: pwsat2_obc_mission_time
        type: u4
      - id: notparsed_1
        type: u1
        repeat: expr
        repeat-expr: 4
      - id: pwsat2_obc_ext_time
        type: u4
      - id: pwsat2_obc_err_cnt_comm
        type: u1
      - id: pwsat2_obc_err_cnt_eps
        type: u1
      - id: pwsat2_obc_err_cnt_rtc
        type: u1
      - id: pwsat2_obc_err_cnt_imtq
        type: u1
      - id: pwsat2_obc_err_cnt_flash1
        type: u1
      - id: pwsat2_obc_err_cnt_flash2
        type: u1
      - id: pwsat2_obc_err_cnt_flash3
        type: u1
      - id: pwsat2_obc_tmr_cnt_flash
        type: u1
      - id: pwsat2_obc_tmr_cnt_fram
        type: u1
      - id: pwsat2_obc_err_cnt_pld
        type: u1
      - id: pwsat2_obc_err_cnt_cam
        type: u1
      - id: pwsat2_obc_err_cnt_suns
        type: u1
      - id: pwsat2_obc_mem_scrubb_prim
        type: u1
      - id: pwsat2_obc_mem_scrubb_sec
        type: u1
      - id: pwsat2_obc_ram_scrubbing
        type: u1

  pwsat2_adcs:
    seq:
      - id: notparsed_start
        type: u1
        repeat: expr
        repeat-expr: 164
      - id: pwsat2_adcs_imtq_tmp_mcu
        type: u2
      - id: notparsed_1
        type: u1
        repeat: expr
        repeat-expr: 4
      - id: pwsat2_adcs_imtq_state_status
        type: u1
      - id: reserved1
        type: u1
      - id: pwsat2_adcs_imtq_tmp_coil_x
        type: u2
      - id: pwsat2_adcs_imtq_tmp_coil_y
        type: u2
      - id: pwsat2_adcs_imtq_tmp_coil_z
        type: u2
      - id: reserved2
        type: u2
      - id: reserved3
        type: u1
      - id: pwsat2_adcs_imtq_state_uptime
        type: u2
      - id: reserved4
        type: u2
      - id: pwsat2_adcs_imtq_slftst_err_initial
        type: u1
      - id: pwsat2_adcs_imtq_slftst_err_pos_x
        type: u1
      - id: pwsat2_adcs_imtq_slftst_err_neg_x
        type: u1
      - id: pwsat2_adcs_imtq_slftst_err_pos_y
        type: u1
      - id: pwsat2_adcs_imtq_slftst_err_neg_y
        type: u1
      - id: pwsat2_adcs_imtq_slftst_err_pos_z
        type: u1
      - id: pwsat2_adcs_imtq_slftst_err_neg_z
        type: u1
      - id: pwsat2_adcs_imtq_slftst_err_final
        type: u1
      - id: notparsed_end
        size-eos: true

