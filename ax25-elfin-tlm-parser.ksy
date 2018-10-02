meta:
  id: ax25_elfin_tlm_parser
  endian: be
seq:
  - id: ax25_header
    type: ax25_hdr
    size: 16
  - id: ax25_info
    type: elfin_tlm_data
types:
  ax25_hdr:
    seq:
      - id: dest_callsign
        size: 6
      - id: dest_ssid
        type: u1
      - id: src_callsign
        size: 6
      - id: src_ssid
        type: u1
      - id: ctl
        type: u1
      - id: pid
        type: u1
  elfin_tlm_data:
    seq:
      - id: frame_start
        type: u1
        doc: '0x94 normal frame, 0x27 escaped frame'
      - id: beacon_setting
        type: u1
      - id: status_1
        type: u1
        doc: 'Safe mode (first bit), early orbit flags (last 4 bits)'
      - id: status_2
        type: u1
        doc: |
          Bits 7 to 3 (in order):
          Payload Power, 9V Boost, battery heater allow, heater force,
          heater alert
      - id: reserved
        type: u1
      - id: hskp_pwr_1
        type: hskp_pwr
      - id: hskp_pwr_2
        type: hskp_pwr
      - id: acb_pc_data
        type: acb_pc_data
      - id: acb_pc_data_2
        type: acb_pc_data_2
      - id: acb_sense
        type: acb_sense
      - id: fc_counters
        type: fc_counters
      - id: radio_tlm
        type: radio_tlm
      - id: radio_cfg_read
        type: radio_cfg_read
      - id: errors
        type: errors
      - id: fc_salt
        type: str
        size: 4
        encoding: ASCII
      - id: fc_crc
        type: u1
      - id: frame_end
        type: u1
        doc: '0x5e marks the end of a frame'
  bcd_date:
    seq:
      - id: year
        type: u1
      - id: month
        type: u1
      - id: day
        type: u1
      - id: hour
        type: u1
      - id: minute
        type: u1
      - id: second
        type: u1
  bcd_clk:
    seq:
      - id: day
        type: u1
      - id: hour
        type: u1
      - id: minute
        type: u1
      - id: second
        type: u1
  hskp_pwr:
    seq:
      - id: rtcc
        type: bcd_date
      - id: adc_data
        type: adc_data
      - id: bat_mon_1
        type: bat_mon
      - id: bat_mon_2
        type: bat_mon
      - id: bv_mon
        type: bv_mon
      - id: tmps
        type: tmps
      - id: accumulated_curr
        type: acu_curr
  acb_pc_data:
    seq:
      - id: acb_pc_data_rtcc
        type: bcd_date
      - id: acb_pc_data_acb_mrm
        type: mrm_xyz
      - id: acb_pc_data_ipdu_mrm
        type: mrm_xyz
      - id: acb_pc_data_tmps
        type: tmps
  acb_pc_data_2:
    seq:
      - id: rtcc
        type: bcd_date
      - id: mrm_a
        type: mrm_xyz
      - id: mrm_b
        type: mrm_xyz
      - id: tmps
        type: tmps
  mrm_xyz:
    seq:
      - id: mrm_x
        type: u2
      - id: mrm_y
        type: u2
      - id: mrm_z
        type: u2
  tmps:
    seq:
      - id: tmp_1
        type: u2
      - id: tmp_2
        type: u2
      - id: tmp_3
        type: u2
      - id: tmp_4
        type: u2
  acb_sense:
    seq:
      - id: acb_current
        type: u2
      - id: acb_voltage
        type: u2
  fc_counters:
    seq:
      - id: cmds_rxed
        type: u1
      - id: bad_cmds_rxed
        type: u1
      - id: bad_pkts_fm_radio
        type: u1
      - id: fc_pkts_fm_radio
        type: u1
      - id: errors
        type: u1
      - id: reboots
        type: u1
      - id: int_wdt_timeout
        type: u1
      - id: brownouts
        type: u1
      - id: wd_pic_resets
        type: u1
      - id: pwr_on_resets
        type: u1
      - id: uart1_resets
        type: u1
      - id: uart1_parse_errors
        type: u1
      - id: sips_overcur_evts
        type: u1
      - id: vu1_on
        type: u1
      - id: vu1_off
        type: u1
      - id: vu2_on
        type: u1
      - id: vu2_off
        type: u1
  radio_tlm:
    seq:
      - id: rssi
        type: u1
      - id: bytes_rx
        type: u4
      - id: bytes_tx
        type: u4
  radio_cfg_read:
    seq:
      - id: radio_pa_lvl
        type: u1
  errors:
    seq:
      - id: error_1
        type: timestamped_error
      - id: error_2
        type: timestamped_error
      - id: error_3
        type: timestamped_error
      - id: error_4
        type: timestamped_error
      - id: error_5
        type: timestamped_error
      - id: error_6
        type: timestamped_error
      - id: error_7
        type: timestamped_error
  timestamped_error:
    seq:
      - id: e_time
        type: bcd_clk
      - id: errno
        type: u1
  bat_mon:
    seq:
      - id: avg_cur_reg
        type: u2
      - id: temperature_register
        type: u2
      - id: volt_reg
        type: u2
      - id: cur_reg
        type: u2
      - id: acc_curr_reg
        type: u2
  adc_data:
    seq:
      - id: adc_sa_volt_12
        type: sa_volt
      - id: adc_sa_volt_34
        type: sa_volt
      - id: adc_sa_volt_56
        type: sa_volt
      - id: sa_short_circuit_current
        type: sa_current
      - id: bat_2_volt
        type: bat_volt
      - id: bat_1_volt
        type: bat_volt
      - id: reg_sa_volt_1
        type: sa_volt
      - id: reg_sa_volt_2
        type: sa_volt
      - id: reg_sa_volt_3
        type: sa_volt
      - id: power_bus_current_1
        type: pbus_cur
      - id: power_bus_current_2
        type: pbus_cur
  bv_mon:
    seq:
      - id: bus_voltage
        type: bus_voltage
  bus_voltage:
    seq:
      - id: voltage
        type: u2
  acu_curr:
    seq:
      - id: bat_1_rarc
        type: u1
      - id: bat_1_rsrc
        type: u1
      - id: bat_2_rarc
        type: u1
      - id: bat_2_rsrc
        type: u1
  sa_volt:
    seq:
      - id: voltage
        type: u2
  sa_current:
    seq:
      - id: current
        type: u2
  bat_volt:
    seq:
      - id: voltage
        type: u2
  pbus_cur:
    seq:
      - id: current
        type: u2
  avg_cur:
    seq:
      - id: current
        type: u2
  temp:
    seq:
      - id: temperature
        type: u2
  volt:
    seq:
      - id: voltage
        type: u2
  curr:
    seq:
      - id: current
        type: u2
