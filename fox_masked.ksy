meta:
  id: fox
seq:
  - id: fox_raw
    size-eos: true
    type: fox_frame
  
types:
  fox_frame:
    seq:
      - id: fox_hdr
        type: fox_hdr
        size: 6
      - id: fox_frame
        type:
          switch-on: fox_hdr.frm_type
          cases:
            0x0: fox_debug_data_t
            0x1: fox_rt_tlm_t
            0x2: fox_max_vals_tlm_t
            0x3: fox_min_vals_tlm_t
            0x4: fox_exp_tlm_t
            0x5: fox_cam_jpeg_data_t
  
  fox_hdr:
    seq:
      - id: b0
        type: u1
      - id: b1
        type: u1
      - id: b2
        type: u1
      - id: b3
        type: u1
      - id: b4
        type: u1
      - id: b5
        type: u1
    instances:
      fox_id:
        value: 'b0 & 0x7'
      reset_count:
        value: '((b2 << 16 | b1 << 8 | b0) >> 3) & 0xffff'
      uptime:
        value: '((b5 << 24 | b4 << 16 | b3 << 8 | b2) >> 3) & 0x1ffffff'
      frm_type:
        value: '(b5 >> 4) & 0xf'

  fox_debug_data_t:
    seq:
      - id: fox_debug_data
        size-eos: true

  fox_rt_tlm_t:
    seq:
      - id: fox_rt_tlm
        type: fox_rt_tlm
        size: 58

  fox_max_vals_tlm_t:
    seq:
      - id: fox_max_vals_tlm
        size: 58

  fox_min_vals_tlm_t:
    seq:
      - id: fox_min_vals_tlm
        size: 58

  fox_cam_jpeg_data_t:
    seq:
      - id: fox_cam_jpeg_data
        size-eos: true

  fox_exp_tlm_t:
    seq:
      - id: fox_exp_tlm
        size: 58

  fox_rt_tlm:
    seq:
      - id: b0
        type: u1
      - id: b1
        type: u1
      - id: b2
        type: u1
      - id: b3
        type: u1
      - id: b4
        type: u1
      - id: b5
        type: u1
      - id: b6
        type: u1
      - id: b7
        type: u1
      - id: b8
        type: u1
      - id: b9
        type: u1
      - id: b10
        type: u1
      - id: b11
        type: u1
      - id: b12
        type: u1
      - id: b13
        type: u1
      - id: b14
        type: u1
      - id: b15
        type: u1
      - id: b16
        type: u1
      - id: b17
        type: u1
      - id: b18
        type: u1
      - id: b19
        type: u1
      - id: b20
        type: u1
      - id: b21
        type: u1
      - id: b22
        type: u1
      - id: b23
        type: u1
      - id: b24
        type: u1
      - id: b25
        type: u1
      - id: b26
        type: u1
      - id: b27
        type: u1
      - id: b28
        type: u1
      - id: b29
        type: u1
      - id: b30
        type: u1
      - id: b31
        type: u1
      - id: b32
        type: u1
      - id: b33
        type: u1
      - id: b34
        type: u1
      - id: b35
        type: u1
      - id: b36
        type: u1
      - id: b37
        type: u1
      - id: b38
        type: u1
      - id: b39
        type: u1
      - id: b40
        type: u1
      - id: b41
        type: u1
      - id: b42
        type: u1
      - id: b43
        type: u1
      - id: b44
        type: u1
      - id: b45
        type: u1
      - id: b46
        type: u1
      - id: b47
        type: u1
      - id: b48
        type: u1
      - id: b49
        type: u1
      - id: b50
        type: u1
      - id: b51
        type: u1
      - id: b52
        type: u1
      - id: b53
        type: u1
      - id: b54
        type: u1
      - id: b55
        type: u1
      - id: b56
        type: u1
      - id: b57
        type: u1
    instances:
      batt_a_v:
        value: '(b1 << 12 | b0 & 0xf) & 0xfff'
      batt_b_v:
        value: '(b2 << 12 | b0 >> 4) & 0xfff'
      batt_c_v:
        value: '(b4 << 12 | b3 & 0xf) & 0xfff'
      batt_a_t:
        value: '(b5 << 12 | b3 >> 4) & 0xfff'
      batt_b_t:
        value: '(b7 << 12 | b6 & 0xf) & 0xfff'
      batt_c_t:
        value: '(b8 << 12 | b6 >> 4) & 0xfff'
      total_batt_i:
        value: '(b10 << 12 | b9 & 0xf) & 0xfff'
      batt_board_temp:
        value: '(b11 << 12 | b9 >> 4) & 0xfff'
      pos_x_panel_v:
        value: '(b13 << 12 | b12 & 0xf) & 0xfff'
      neg_x_panel_v:
        value: '(b14 << 12 | b12 >> 4) & 0xfff'
      pos_y_panel_v:
        value: '(b16 << 12 | b15 & 0xf) & 0xfff'
      neg_y_panel_v:
        value: '(b17 << 12 | b15 >> 4) & 0xfff'
      pos_z_panel_v:
        value: '(b19 << 12 | b18 & 0xf) & 0xfff'
      neg_z_panel_v:
        value: '(b20 << 12 | b18 >> 4) & 0xfff'
      pos_x_panel_t:
        value: '(b22 << 12 | b21 & 0xf) & 0xfff'
      neg_x_panel_t:
        value: '(b23 << 12 | b21 >> 4) & 0xfff'
      pos_y_panel_t:
        value: '(b25 << 12 | b24 & 0xf) & 0xfff'
      neg_y_panel_t:
        value: '(b26 << 12 | b24 >> 4) & 0xfff'
      pos_z_panel_t:
        value: '(b28 << 12 | b27 & 0xf) & 0xfff'
      neg_z_panel_t:
        value: '(b29 << 12 | b27 >> 4) & 0xfff'
      psu_temp:
        value: '(b31 << 12 | b30 & 0xf) & 0xfff'
      spin:
        value: '(b32 << 12 | b30 >> 4) & 0xfff'
      tx_pa_curr:
        value: '(b34 << 12 | b33 & 0xf) & 0xfff'
      tx_temp:
        value: '(b35 << 12 | b33 >> 4) & 0xfff'
      rx_temp:
        value: '(b37 << 12 | b36 & 0xf) & 0xfff'
      rssi:
        value: '(b38 << 12 | b36 >> 4) & 0xfff'
      ihu_cpu_temp:
        value: '(b40 << 12 | b39 & 0xf) & 0xfff'
      sat_x_ang_vcty:
        value: '(b41 << 12 | b39 >> 4) & 0xfff'
      sat_y_ang_vcty:
        value: '(b43 << 12 | b42 & 0xf) & 0xfff'
      sat_z_ang_vcty:
        value: '(b44 << 12 | b42 >> 4) & 0xfff'
      exp_4_temp:
        value: '(b46 << 12 | b45 & 0xf) & 0xfff'
      psu_curr:
        value: '(b47 << 12 | b45 >> 4) & 0xfff'
      ihu_diag_data:
        value: '(b51 << 32 | b50 << 24 | b49 << 16 | b48)'

