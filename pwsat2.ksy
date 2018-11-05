meta:
  id: pwsat2
  endian: le
  
seq:
  - id: ax25_flag
    type: u1
    doc: 'only needed with PWSAT-2 data-warehouse frames'
  - id: ax25_header
    type: ax25_hdr
    doc-ref: 'https://www.tapr.org/pub_ax25.html'
  - id: ax25_info
    type: pwsat2_frame
    size: _io.size - 19
  - id: ax25_fcs
    type: u2be
    doc: 'only needed with PWSAT-2 data-warehouse frames'

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

  pwsat2_frame:
    seq:
      - id: pwsat2_hdr
        type: pwsat2_hdr
      - id: pwsat2_payload
        type:
          switch-on: pwsat2_hdr.pwsat2_apid & 0x3f
          cases:
            0x05: pwsat2_periodic_msg
            0x0d: pwsat2_telemetry

  pwsat2_hdr:
    seq:
      - id: pwsat2_apid
        type: u1

  pwsat2_periodic_msg:
    seq:
      - id: pwsat2_periodic_msg_data
        type: str
        encoding: ASCII
        size: _io.size - 1

  pwsat2_telemetry:
    seq:
      - id: pwsat2_obc
        type: pwsat2_obc
      - id: pwsat2_antennas
        type: pwsat2_antennas
      - id: pwsat2_experiments
        type: pwsat2_experiments
      - id: pwsat2_gyroscope
        type: pwsat2_gyroscope
      - id: pwsat2_comm
        type: pwsat2_comm
      - id: pwsat2_hardware_state
        type: pwsat2_hardware_state
      - id: pwsat2_eps_controller_a
        type: pwsat2_eps_controller_a
      - id: pwsat2_eps_controller_b
        type: pwsat2_eps_controller_b
      - id: pwsat2_imtq
        type: pwsat2_imtq
      - id: pwsat2_imtq_coil_active
        type: pwsat2_imtq_coil_active
      - id: pwsat2_imtq_dipole
        type: pwsat2_imtq_dipole
      - id: pwsat2_imtq_bdot
        type: pwsat2_imtq_bdot
      - id: pwsat2_imtq_hskp
        type: pwsat2_imtq_hskp
      - id: pwsat2_imtq_coil
        type: pwsat2_imtq_coil
      - id: pwsat2_imtq_temp
        type: pwsat2_imtq_temp
      - id: pwsat2_imtq_state
        type: pwsat2_imtq_state
      - id: pwsat2_imtq_selftest
        type: pwsat2_imtq_selftest

  pwsat2_obc:
    seq:
      - id: pwsat2_obc_boot_ctr
        type: u4
      - id: pwsat2_obc_boot_idx
        type: u1
      - id: pwsat2_obc_reboot_reason
        type: u2
      - id: pwsat2_obc_code_crc
        type: u2
      - id: pwsat2_obc_mission_time
        type: u8
      - id: pwsat2_obc_ext_time
        type: u4
      - id: pwsat2_obc_comm_err
        type: u1
      - id: pwsat2_obc_eps_err
        type: u1
      - id: pwsat2_obc_rtc_err
        type: u1
      - id: pwsat2_obc_imtq_err
        type: u1
      - id: pwsat2_obc_n25qflash1_err
        type: u1
      - id: pwsat2_obc_n25qflash2_err
        type: u1
      - id: pwsat2_obc_n25qflash3_err
        type: u1
      - id: pwsat2_obc_n25q_tmr_corr
        type: u1
      - id: pwsat2_obc_fram_tmr_corr
        type: u1
      - id: pwsat2_obc_payload_err
        type: u1
      - id: pwsat2_obc_cam_err
        type: u1
      - id: pwsat2_obc_suns_exp_err
        type: u1
      - id: pwsat2_obc_ant_prim_err
        type: u1
      - id: pwsat2_obc_ant_sec_err
        type: u1
      - id: pwsat2_obc_prim_flash_scrbg_ptr
        type: b3
      - id: pwsat2_obc_sec_flash_scrbg_ptr
        type: b3
      - id: pwsat2_obc_ram_scrbg_ptr
        type: u4
      - id: pwsat2_obc_system_uptime
        type: b22
      - id: pwsat2_obc_system_flash_free
        type: u4

  pwsat2_antennas:
    seq:
      - id: pwsat2_antennas_ant1_depl_sw_ch_a
        type: b1
      - id: pwsat2_antennas_ant2_depl_sw_ch_a
        type: b1
      - id: pwsat2_antennas_ant3_depl_sw_ch_a
        type: b1
      - id: pwsat2_antennas_ant4_depl_sw_ch_a
        type: b1
      - id: pwsat2_antennas_ant1_depl_sw_ch_b
        type: b1
      - id: pwsat2_antennas_ant2_depl_sw_ch_b
        type: b1
      - id: pwsat2_antennas_ant3_depl_sw_ch_b
        type: b1
      - id: pwsat2_antennas_ant4_depl_sw_ch_b
        type: b1
      - id: pwsat2_antennas_ant1_last_timed_stop_ch_a
        type: b1
      - id: pwsat2_antennas_ant2_last_timed_stop_ch_a
        type: b1
      - id: pwsat2_antennas_ant3_last_timed_stop_ch_a
        type: b1
      - id: pwsat2_antennas_ant4_last_timed_stop_ch_a
        type: b1
      - id: pwsat2_antennas_ant1_last_timed_stop_ch_b
        type: b1
      - id: pwsat2_antennas_ant2_last_timed_stop_ch_b
        type: b1
      - id: pwsat2_antennas_ant3_last_timed_stop_ch_b
        type: b1
      - id: pwsat2_antennas_ant4_last_timed_stop_ch_b
        type: b1
      - id: pwsat2_antennas_ant1_burn_active_ch_a
        type: b1
      - id: pwsat2_antennas_ant2_burn_active_ch_a
        type: b1
      - id: pwsat2_antennas_ant3_burn_active_ch_a
        type: b1
      - id: pwsat2_antennas_ant4_burn_active_ch_a
        type: b1
      - id: pwsat2_antennas_ant1_burn_active_ch_b
        type: b1
      - id: pwsat2_antennas_ant2_burn_active_ch_b
        type: b1
      - id: pwsat2_antennas_ant3_burn_active_ch_b
        type: b1
      - id: pwsat2_antennas_ant4_burn_active_ch_b
        type: b1
      - id: pwsat2_antennas_sys_indep_burn_ch_a
        type: b1
      - id: pwsat2_antennas_sys_indep_burn_ch_b
        type: b1
      - id: pwsat2_antennas_ant_ignoring_sw_ch_a
        type: b1
      - id: pwsat2_antennas_ant_ignoring_sw_ch_b
        type: b1
      - id: pwsat2_antennas_armed_ch_a
        type: b1
      - id: pwsat2_antennas_armed_ch_b
        type: b1
      - id: pwsat2_antennas_ant1_activation_cnt_ch_a
        type: b3
      - id: pwsat2_antennas_ant2_activation_cnt_ch_a
        type: b3
      - id: pwsat2_antennas_ant3_activation_cnt_ch_a
        type: b3
      - id: pwsat2_antennas_ant4_activation_cnt_ch_a
        type: b3
      - id: pwsat2_antennas_ant1_activation_cnt_ch_b
        type: b3
      - id: pwsat2_antennas_ant2_activation_cnt_ch_b
        type: b3
      - id: pwsat2_antennas_ant3_activation_cnt_ch_b
        type: b3
      - id: pwsat2_antennas_ant4_activation_cnt_ch_b
        type: b3
      - id: pwsat2_antennas_ant1_activation_time_ch_a
        type: b3
      - id: pwsat2_antennas_ant2_activation_time_ch_a
        type: b3
      - id: pwsat2_antennas_ant3_activation_time_ch_a
        type: b3
      - id: pwsat2_antennas_ant4_activation_time_ch_a
        type: b3
      - id: pwsat2_antennas_ant1_activation_time_ch_b
        type: b3
      - id: pwsat2_antennas_ant2_activation_time_ch_b
        type: b3
      - id: pwsat2_antennas_ant3_activation_time_ch_b
        type: b3
      - id: pwsat2_antennas_ant4_activation_time_ch_b
        type: b3

  pwsat2_experiments:
    seq:
      - id: pwsat2_experiments_curr_exp_code
        type: b4
      - id: pwsat2_experiments_exp_startup_res
        type: u1
      - id: pwsat2_experiments_last_exp_iter_stat_status
        type: u1

  pwsat2_gyroscope:
    seq:
      - id: pwsat2_gyroscope_x_meas
        type: u2
      - id: pwsat2_gyroscope_y_meas
        type: u2
      - id: pwsat2_gyroscope_z_meas
        type: u2
      - id: pwsat2_gyroscope_temp
        type: u2

  pwsat2_comm:
    seq:
      - id: pwsat2_comm_tx_trsmtr_uptime
        type: b17
      - id: pwsat2_comm_tx_bitrate
        type: b2
      - id: pwsat2_comm_tx_last_tx_rf_refl_pwr
        type: b12
      - id: pwsat2_comm_tx_last_tx_pamp_temp
        type: b12
      - id: pwsat2_comm_tx_last_tx_last_tx_rf_fwd_pwr
        type: b12
      - id: pwsat2_comm_tx_last_tx_curr_consmpt
        type: b12
      - id: pwsat2_comm_tx_now_tx_fwd_pwr
        type: b12
      - id: pwsat2_comm_tx_now_tx_curr_consmpt
        type: b12
      - id: pwsat2_comm_tx_state_when_idle
        type: b1
      - id: pwsat2_comm_tx_beacon_state
        type: b1
      - id: pwsat2_comm_rx_uptime
        type: b17
      - id: pwsat2_comm_rx_last_rx_doppler_offs
        type: b12
      - id: pwsat2_comm_rx_last_rx_rssi
        type: b12
      - id: pwsat2_comm_rx_now_doppler_offs
        type: b12
      - id: pwsat2_comm_rx_now_rx_curr_consmpt
        type: b12
      - id: pwsat2_comm_rx_supply_voltage
        type: b12
      - id: pwsat2_comm_rx_osc_temp
        type: b12
      - id: pwsat2_comm_rx_now_pamp_temp
        type: b12
      - id: pwsat2_comm_rx_now_rssi
        type: b12

  pwsat2_hardware_state:
    seq:
      - id: pwsat2_hardware_state_gpio_sail_deployed
        type: b1
      - id: pwsat2_hardware_state_mcu_temp
        type: b12

  pwsat2_eps_controller_a:
    seq:
      - id: pwsat2_eps_controller_a_mpptx_sol_volt
        type: b12
      - id: pwsat2_eps_controller_a_mpptx_sol_curr
        type: b12
      - id: pwsat2_eps_controller_a_mpptx_out_volt
        type: b12
      - id: pwsat2_eps_controller_a_mpptx_temp
        type: b12
      - id: pwsat2_eps_controller_a_mpptx_state
        type: b3
      - id: pwsat2_eps_controller_a_mppty_pos_sol_volt
        type: b12
      - id: pwsat2_eps_controller_a_mppty_pos_sol_curr
        type: b12
      - id: pwsat2_eps_controller_a_mppty_pos_out_volt
        type: b12
      - id: pwsat2_eps_controller_a_mppty_pos_temp
        type: b12
      - id: pwsat2_eps_controller_a_mppty_pos_state
        type: b3
      - id: pwsat2_eps_controller_a_mppty_neg_sol_volt
        type: b12
      - id: pwsat2_eps_controller_a_mppty_neg_sol_curr
        type: b12
      - id: pwsat2_eps_controller_a_mppty_neg_out_volt
        type: b12
      - id: pwsat2_eps_controller_a_mppty_neg_temp
        type: b12
      - id: pwsat2_eps_controller_a_mppty_neg_state
        type: b3
      - id: pwsat2_eps_controller_a_distr_volt_3v3
        type: b10
      - id: pwsat2_eps_controller_a_distr_curr_3v3
        type: b10
      - id: pwsat2_eps_controller_a_distr_volt_5v
        type: b10
      - id: pwsat2_eps_controller_a_distr_curr_5v
        type: b10
      - id: pwsat2_eps_controller_a_distr_volt_vbat
        type: b10
      - id: pwsat2_eps_controller_a_distr_curr_vbat
        type: b10
      - id: pwsat2_eps_controller_a_distr_lcl_state
        type: b7
      - id: pwsat2_eps_controller_a_distr_lcl_flagb
        type: b6
      - id: pwsat2_eps_controller_a_batc_volta
        type: b10
      - id: pwsat2_eps_controller_a_batc_chrg_curr
        type: b10
      - id: pwsat2_eps_controller_a_batc_dchrg_curr
        type: b10
      - id: pwsat2_eps_controller_a_batc_temp
        type: b10
      - id: pwsat2_eps_controller_a_batc_state
        type: b3
      - id: pwsat2_eps_controller_a_bp_temp_a
        type: b13
      - id: pwsat2_eps_controller_a_bp_temp_b
        type: b13
      - id: pwsat2_eps_controller_a_safety_ctr
        type: u1
      - id: pwsat2_eps_controller_a_pwr_cycles
        type: u2
      - id: pwsat2_eps_controller_a_uptime
        type: u4
      - id: pwsat2_eps_controller_a_temp
        type: b10
      - id: pwsat2_eps_controller_a_supp_temp
        type: b10
      - id: pwsat2_eps_controller_b_3v3d_volt
        type: b10
      - id: pwsat2_eps_controller_a_dcdc_3v3_temp
        type: b10
      - id: pwsat2_eps_controller_a_dcdc_5v_temp
        type: b10

  pwsat2_eps_controller_b:
    seq:
      - id: pwsat2_eps_controller_b_bptemp_c
        type: b10
      - id: pwsat2_eps_controller_b_battc_volt_b
        type: b10
      - id: pwsat2_eps_controller_b_safety_ctr
        type: u1
      - id: pwsat2_eps_controller_b_pwr_cycles
        type: u2
      - id: pwsat2_eps_controller_b_uptime
        type: u4
      - id: pwsat2_eps_controller_b_temp
        type: b10
      - id: pwsat2_eps_controller_b_supp_temp
        type: b10
      - id: pwsat2_eps_controller_a_3v3d_volt
        type: b10

  pwsat2_imtq:
    seq:
      - id: pwsat2_imtq_mag_meas_1
        type: u4
      - id: pwsat2_imtq_mag_meas_2
        type: u4
      - id: pwsat2_imtq_mag_meas_3
        type: u4

  pwsat2_imtq_coil_active:
    seq:
      - id: pwsat2_imtq_coil_active_in_meas
        type: b1

  pwsat2_imtq_dipole:
    seq:
      - id: pwsat2_imtq_dipole_1
        type: u2
      - id: pwsat2_imtq_dipole_2
        type: u2
      - id: pwsat2_imtq_dipole_3
        type: u2

  pwsat2_imtq_bdot:
    seq:
      - id: pwsat2_imtq_bdot_x
        type: u4
      - id: pwsat2_imtq_bdot_y
        type: u4
      - id: pwsat2_imtq_bdot_z
        type: u4

  pwsat2_imtq_hskp:
    seq:
      - id: pwsat2_imtq_hskp_dig_volt
        type: u2
      - id: pwsat2_imtq_hskp_ana_volt
        type: u2
      - id: pwsat2_imtq_hskp_dig_curr
        type: u2
      - id: pwsat2_imtq_hskp_ana_curr
        type: u2
      - id: pwsat2_imtq_hskp_mcu_temp
        type: u2

  pwsat2_imtq_coil:
    seq:
      - id: pwsat2_imtq_coil_current_x
        type: u2
      - id: pwsat2_imtq_coil_current_y
        type: u2
      - id: pwsat2_imtq_coil_current_z
        type: u2

  pwsat2_imtq_temp:
    seq:
      - id: pwsat2_imtq_temp_coil_x
        type: u2
      - id: pwsat2_imtq_temp_coil_y
        type: u2
      - id: pwsat2_imtq_temp_coil_z
        type: u2

  pwsat2_imtq_state:
    seq:
      - id: pwsat2_imtq_state_status
        type: u1
      - id: pwsat2_imtq_state_mode
        type: b2
      - id: pwsat2_imtq_err_prev_iter
        type: u1
      - id: pwsat2_imtq_conf_changed
        type: b1
      - id: pwsat2_imtq_state_uptime
        type: u4

  pwsat2_imtq_selftest:
    seq:
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

