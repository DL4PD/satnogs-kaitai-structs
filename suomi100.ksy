meta:
  id: suomi100
  endian: be

seq:
  - id: payload
    type: suomi100_data

types:
  suomi100_data:
    seq:
      - id: suomi100_data
        type:
          switch-on: _io.size
          cases:
            #_: suomi100_beacon0
            _: suomi100_beacon1
            84: suomi100_beacon0
            124: suomi100_beacon1

  suomi100_beacon0:
    seq:
      - id: suomi100_beacon_type
        type: u4
      - id: suomi100_eps_timestamp
        type: u4
        doc: 'value [s]'
      - id: suomi100_eps_pv_v
        type: u2
        repeat: expr
        repeat-expr: 3
        doc: 'value [mV]'
      - id: suomi100_eps_batt_v
        type: u2
        doc: 'value [mV]'
      - id: suomi100_eps_output_cur
        type: u2
        repeat: expr
        repeat-expr: 7
        doc: 'value [mA]'
      - id: suomi100_eps_pv_cur
        type: u2
        repeat: expr
        repeat-expr: 3
        doc: 'value [mA]'
      - id: suomi100_eps_batt_in_cur
        type: u2
        doc: 'value [mA]'
      - id: suomi100_eps_batt_out_cur
        type: u2
        doc: 'value [mA]'
      - id: suomi100_eps_temp
        type: s2
        repeat: expr
        repeat-expr: 6
        doc: 'value [°C]'
      - id: suomi100_eps_batt_mode
        type: u1
        doc: 'modes: ?'
      - id: suomi100_com_timestamp
        type: u4
        doc: 'value [s]'
      - id: suomi100_com_temp
        type: s2
        repeat: expr
        repeat-expr: 2
        doc: 'value [°C]'
      - id: suomi100_com_rssi
        type: s2
        doc: 'value [dBm]'
      - id: suomi100_com_rferr
        type: s2
        doc: 'RF errors: ?'
      - id: suomi100_com_rssi_bgnd
        type: s2
        doc: 'value [dBm]'
      - id: suomi100_obc_timestamp
        type: u4
        doc: 'value [s]'
      - id: suomi100_obc_cur
        type: u2
        repeat: expr
        repeat-expr: 6
        doc: 'value [mA]'
      - id: suomi100_obc_temp
        type: s2
        repeat: expr
        repeat-expr: 2

  suomi100_beacon1:
    seq:
      - id: suomi100_beacon_type
        type: u4
      - id: suomi100_eps_timestamp
        type: u4
        doc: 'value [s]'
      - id: suomi100_eps_wdt_i2c
        type: u4
        doc: 'value [s]'
      - id: suomi100_eps_wdt_gnd
        type: u4
        doc: 'value [s]'
      - id: suomi100_eps_boot_count
        type: u4
        doc: 'value [n]'
      - id: suomi100_eps_wdt_i2c_count
        type: u4
        doc: 'value [n]'
      - id: suomi100_eps_wdt_gnd_count
        type: u4
        doc: 'value [n]'
      - id: suomi100_eps_wdt_csp_count
        type: u4
        repeat: expr
        repeat-expr: 2
        doc: 'value [n]'
      - id: suomi100_eps_wdt_csp
        type: u1
        repeat: expr
        repeat-expr: 2
      - id: suomi100_eps_boot_cause
        type: u1
        doc: 'causes: ?'
      - id: suomi100_eps_latchup
        type: u2
        repeat: expr
        repeat-expr: 6
      - id: suomi100_eps_out_val
        type: u1
        repeat: expr
        repeat-expr: 8
      - id: suomi100_eps_ppt_mode
        type: u1
      - id: suomi100_com_timestamp
        type: u4
        doc: 'value [s]'
      - id: suomi100_com_tx_duty
        type: u1
      - id: suomi100_com_total_tx_count
        type: u4
        doc: 'value [n]'
      - id: suomi100_com_total_rx_count
        type: u4
        doc: 'value [n]'
      - id: suomi100_com_total_tx_bytes
        type: u4
        doc: 'value [n]'
      - id: suomi100_com_total_rx_bytes
        type: u4
        doc: 'value [n]'
      - id: suomi100_com_boot_count
        type: u2
        doc: 'value [n]'
      - id: suomi100_com_boot_cause
        type: u4
      - id: suomi100_com_tx_bytes
        type: u4
        doc: 'value [n]'
      - id: suomi100_com_rx_bytes
        type: u4
        doc: 'value [n]'
      - id: suomi100_com_config
        type: u1
      - id: suomi100_com_tx_count
        type: u4
        doc: 'value [n]'
      - id: suomi100_com_rx_count
        type: u4
        doc: 'value [n]'
      - id: suomi100_obc_timestamp
        type: u4
        doc: 'value [s]'
      - id: suomi100_obc_pwr
        type: u4
        repeat: expr
        repeat-expr: 5
      - id: suomi100_obc_sw_count
        type: u2
      - id: suomi100_obc_filesystem
        type: u1
      - id: suomi100_obc_boot_count
        type: u2
      - id: suomi100_obc_boot_cause
        type: u4
      - id: suomi100_obc_clock
        type: u4
        doc: 'value [s]'

