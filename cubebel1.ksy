meta:
  id: cubebel1
  endian: le

seq:
  - id: ax25_frame
    type: ax25_frame
    doc-ref: 'https://www.tapr.org/pub_ax25.html'

types:
  ax25_frame:
    seq:
    - id: ax25_header
      type: ax25_hdr
    - id: ax25_info
      type: ax25_info

  ax25_hdr:
    seq:
      - id: dest_callsign_raw
        type: dest_callsign_raw
      - id: dest_ssid
        type: u1
      - id: src_callsign_raw
        type: src_callsign_raw
      - id: src_ssid
        type: u1
      - id: ctl
        type: u1
      - id: pid
        type: u1
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

  ax25_info:
    seq:
      - id: cubebel1_header
        type: cubebel1_header
      - id: cubebel1_data
        if: cubebel1_header.cubebel1_info_size > 0
        type:
          switch-on: cubebel1_header.cubebel1_data_type
          cases:
            #0x00: rf_beacon
            0x01: rf_response
            #0x02: rf_image
            0x03: rf_message
            #0x04: rf_command_list
            #0x05: rf_current_settings
            #0x06: rf_default_settings
            #0x07: rf_logo
            #0x08: rf_saved_eps_tel
            #0x09: rf_saved_obc_tel
            #0x80: obc_tlm
            0xfe: eps_full_tel
            0xff: eps_short_tel

  cubebel1_header:
    seq:
      - id: cubebel1_rf_id
        type: u1
      - id: cubebel1_opr_time
        type: u2
      - id: cubebel1_reboot_cnt
        type: u1
      - id: cubebel1_mcusr
        type: u1
      - id: cubebel1_pamp_temp
        type: u2
      - id: cubebel1_pamp_voltage
        type: u1
      - id: cubebel1_tx_attenuator
        type: u1
      - id: cubebel1_battery_voltage
        type: u2
      - id: cubebel1_system_voltage
        type: u2
      - id: cubebel1_seq_number
        type: u2
      - id: cubebel1_pwr_save_state
        type: u1
      - id: cubebel1_modem_on_period
        type: u2
      - id: cubebel1_obc_can_status
        type: u1
      - id: cubebel1_eps_can_status
        type: u1
      - id: cubebel1_info_size
        type: u1
      - id: cubebel1_data_type
        type: u1
  
  rf_response:
    seq:
      - id: cubebel1_fec_crc_status
        type: b1
      - id: cubebel1_rx_msg_state
        type: b7
      - id: cubebel1_rssi
        type: u1

  rf_message:
    seq:
      - id: cubebel1_rf_msg
        type: str
        encoding: ASCII
        size: _parent.cubebel1_header.cubebel1_info_size - 1

  eps_full_tel:
    seq:
      - id: eps_short_tel
        type: eps_short_tel
      - id: cubebel1_current_to_gamma
        type: b12
      - id: cubebel1_current_to_irsensor
        type: b12
      - id: cubebel1_current_to_extflash
        type: b12
      - id: cubebel1_current_to_solarsens
        type: b12
      - id: cubebel1_current_to_magnetcoils
        type: b12
      - id: cubebel1_current_to_coil_x
        type: b12
      - id: cubebel1_current_to_coil_y
        type: b12
      - id: cubebel1_current_to_coil_pz
        type: b12
      - id: cubebel1_current_to_coil_nz
        type: b12
      - id: cubebel1_battery1_temp
        type: b12
      - id: cubebel1_battery2_temp
        type: b12
      - id: cubebel1_numb_oc_obc
        type: u1
      - id: cubebel1_numb_oc_out_gamma
        type: u1
      - id: cubebel1_numb_oc_out_rf1
        type: u1
      - id: cubebel1_numb_oc_out_rf2
        type: u1
      - id: cubebel1_numb_oc_out_flash
        type: u1
      - id: cubebel1_numb_oc_out_irsens
        type: u1
      - id: cubebel1_numb_oc_coil_x
        type: u1
      - id: cubebel1_numb_oc_coil_y
        type: u1
      - id: cubebel1_numb_oc_coil_pz
        type: u1
      - id: cubebel1_numb_oc_coil_nz
        type: u1
      - id: cubebel1_numb_oc_magnetcoils
        type: u1
      - id: cubebel1_numb_oc_solarsens
        type: u1
      - id: cubebel1_reset_num
        type: u2
      - id: cubebel1_reset_reason
        type: u1
      - id: cubebel1_pwr_sat
        type: b1
      - id: cubebel1_pwr_rf1
        type: b1
      - id: cubebel1_pwr_rf2
        type: b1
      - id: cubebel1_pwr_sunsensor
        type: b1
      - id: cubebel1_pwr_gamma
        type: b1
      - id: cubebel1_pwr_irsensor
        type: b1
      - id: cubebel1_pwr_flash
        type: b1
      - id: cubebel1_pwr_magnet_x
        type: b1
      - id: cubebel1_pwr_magnet_y
        type: b1
      - id: cubebel1_pwr_magnet_z
        type: b1

  eps_short_tel:
    seq:
      - id: cubebel1_sys_time
        type: u2
      - id: cubebel1_adc_correctness
        type: b2
      - id: cubebel1_t_adc1
        type: b12
      - id: cubebel1_t_adc2
        type: b12
      - id: cubebel1_stepup_current
        type: b12
      - id: cubebel1_stetup_voltage
        type: b12
      - id: cubebel1_afterbq_current
        type: b12
      - id: cubebel1_battery_voltage
        type: b12
      - id: cubebel1_sys_voltage_50
        type: b12
      - id: cubebel1_sys_voltage_33
        type: b12
      - id: cubebel1_eps_uc_current
        type: b12
      - id: cubebel1_obc_uc_current
        type: b10
      - id: cubebel1_rf1_uc_current
        type: b10
      - id: cubebel1_rf2_uc_current
        type: b12
      - id: cubebel1_solar_voltage
        type: b12
      - id: cubebel1_side_x_current
        type: b12
      - id: cubebel1_side_py_current
        type: b12
      - id: cubebel1_side_ny_current
        type: b12
      - id: cubebel1_side_pz_current
        type: b12
      - id: cubebel1_side_nz_current
        type: b12

