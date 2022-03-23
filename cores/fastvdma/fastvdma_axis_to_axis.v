/*
 * Copyright (c) 2021-2022 Antmicro
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

module AXIS_to_AXIS_WishboneCSR( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input  [31:0] io_ctl_dat_i, // @[:@6.4]
  output [31:0] io_ctl_dat_o, // @[:@6.4]
  input         io_ctl_cyc_i, // @[:@6.4]
  input         io_ctl_stb_i, // @[:@6.4]
  input         io_ctl_we_i, // @[:@6.4]
  input  [29:0] io_ctl_adr_i, // @[:@6.4]
  output        io_ctl_ack_o, // @[:@6.4]
  output [3:0]  io_bus_addr, // @[:@6.4]
  output [31:0] io_bus_dataOut, // @[:@6.4]
  input  [31:0] io_bus_dataIn, // @[:@6.4]
  output        io_bus_write, // @[:@6.4]
  output        io_bus_read // @[:@6.4]
);
  reg  state; // @[WishboneCSR.scala 32:22:@8.4]
  reg [31:0] _RAND_0;
  reg  ack; // @[WishboneCSR.scala 34:21:@9.4]
  reg [31:0] _RAND_1;
  wire  valid; // @[WishboneCSR.scala 36:37:@10.4]
  wire  _T_40; // @[Conditional.scala 37:30:@13.4]
  wire  _GEN_0; // @[WishboneCSR.scala 41:40:@17.6]
  wire  _GEN_2; // @[Conditional.scala 39:67:@24.6]
  wire  _GEN_3; // @[Conditional.scala 39:67:@24.6]
  wire  _GEN_4; // @[Conditional.scala 40:58:@14.4]
  wire  _GEN_5; // @[Conditional.scala 40:58:@14.4]
  wire  _T_50; // @[WishboneCSR.scala 57:24:@33.4]
  assign valid = io_ctl_stb_i & io_ctl_cyc_i; // @[WishboneCSR.scala 36:37:@10.4]
  assign _T_40 = 1'h0 == state; // @[Conditional.scala 37:30:@13.4]
  assign _GEN_0 = valid ? 1'h1 : state; // @[WishboneCSR.scala 41:40:@17.6]
  assign _GEN_2 = state ? 1'h0 : ack; // @[Conditional.scala 39:67:@24.6]
  assign _GEN_3 = state ? 1'h0 : state; // @[Conditional.scala 39:67:@24.6]
  assign _GEN_4 = _T_40 ? valid : _GEN_2; // @[Conditional.scala 40:58:@14.4]
  assign _GEN_5 = _T_40 ? _GEN_0 : _GEN_3; // @[Conditional.scala 40:58:@14.4]
  assign _T_50 = io_ctl_we_i == 1'h0; // @[WishboneCSR.scala 57:24:@33.4]
  assign io_ctl_dat_o = io_bus_dataIn; // @[WishboneCSR.scala 60:16:@37.4]
  assign io_ctl_ack_o = ack; // @[WishboneCSR.scala 55:16:@30.4]
  assign io_bus_addr = io_ctl_adr_i[3:0]; // @[WishboneCSR.scala 61:15:@38.4]
  assign io_bus_dataOut = io_ctl_dat_i; // @[WishboneCSR.scala 59:18:@36.4]
  assign io_bus_write = ack & io_ctl_we_i; // @[WishboneCSR.scala 56:16:@32.4]
  assign io_bus_read = ack & _T_50; // @[WishboneCSR.scala 57:15:@35.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  ack = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      state <= 1'h0;
    end else begin
      if (_T_40) begin
        if (valid) begin
          state <= 1'h1;
        end
      end else begin
        if (state) begin
          state <= 1'h0;
        end
      end
    end
    if (reset) begin
      ack <= 1'h0;
    end else begin
      if (_T_40) begin
        ack <= valid;
      end else begin
        if (state) begin
          ack <= 1'h0;
        end
      end
    end
  end
endmodule
module AXIS_to_AXIS_AXIStreamSlave( // @[:@40.2]
  input         clock, // @[:@41.4]
  input         reset, // @[:@42.4]
  input  [31:0] io_bus_tdata, // @[:@43.4]
  input         io_bus_tvalid, // @[:@43.4]
  output        io_bus_tready, // @[:@43.4]
  input         io_dataIO_ready, // @[:@43.4]
  output        io_dataIO_valid, // @[:@43.4]
  output [31:0] io_dataIO_bits, // @[:@43.4]
  output        io_xfer_done, // @[:@43.4]
  input  [31:0] io_xfer_length, // @[:@43.4]
  input         io_xfer_valid // @[:@43.4]
);
  reg [1:0] state; // @[AXIStreamSlave.scala 34:22:@45.4]
  reg [31:0] _RAND_0;
  reg  done; // @[AXIStreamSlave.scala 36:21:@46.4]
  reg [31:0] _RAND_1;
  reg  enable; // @[AXIStreamSlave.scala 38:23:@47.4]
  reg [31:0] _RAND_2;
  reg [31:0] length; // @[AXIStreamSlave.scala 40:23:@48.4]
  reg [31:0] _RAND_3;
  wire  ready; // @[AXIStreamSlave.scala 42:40:@49.4]
  wire  valid; // @[AXIStreamSlave.scala 43:38:@52.4]
  wire  _T_66; // @[Conditional.scala 37:30:@59.4]
  wire [1:0] _GEN_0; // @[AXIStreamSlave.scala 57:26:@63.6]
  wire [31:0] _GEN_1; // @[AXIStreamSlave.scala 57:26:@63.6]
  wire  _T_70; // @[Conditional.scala 37:30:@70.6]
  wire  _T_71; // @[AXIStreamSlave.scala 64:18:@72.8]
  wire [32:0] _T_73; // @[AXIStreamSlave.scala 65:26:@74.10]
  wire [32:0] _T_74; // @[AXIStreamSlave.scala 65:26:@75.10]
  wire [31:0] _T_75; // @[AXIStreamSlave.scala 65:26:@76.10]
  wire  _T_77; // @[AXIStreamSlave.scala 66:21:@78.10]
  wire [1:0] _GEN_3; // @[AXIStreamSlave.scala 66:29:@79.10]
  wire  _GEN_4; // @[AXIStreamSlave.scala 66:29:@79.10]
  wire [31:0] _GEN_5; // @[AXIStreamSlave.scala 64:27:@73.8]
  wire [1:0] _GEN_6; // @[AXIStreamSlave.scala 64:27:@73.8]
  wire  _GEN_7; // @[AXIStreamSlave.scala 64:27:@73.8]
  wire  _T_79; // @[Conditional.scala 37:30:@86.8]
  wire [1:0] _GEN_8; // @[Conditional.scala 39:67:@87.8]
  wire  _GEN_9; // @[Conditional.scala 39:67:@87.8]
  wire [31:0] _GEN_10; // @[Conditional.scala 39:67:@71.6]
  wire [1:0] _GEN_11; // @[Conditional.scala 39:67:@71.6]
  wire  _GEN_12; // @[Conditional.scala 39:67:@71.6]
  wire  _GEN_13; // @[Conditional.scala 39:67:@71.6]
  wire  _GEN_14; // @[Conditional.scala 40:58:@60.4]
  wire  _GEN_15; // @[Conditional.scala 40:58:@60.4]
  wire [1:0] _GEN_16; // @[Conditional.scala 40:58:@60.4]
  wire [31:0] _GEN_17; // @[Conditional.scala 40:58:@60.4]
  assign ready = io_dataIO_ready & enable; // @[AXIStreamSlave.scala 42:40:@49.4]
  assign valid = io_bus_tvalid & enable; // @[AXIStreamSlave.scala 43:38:@52.4]
  assign _T_66 = 2'h0 == state; // @[Conditional.scala 37:30:@59.4]
  assign _GEN_0 = io_xfer_valid ? 2'h1 : state; // @[AXIStreamSlave.scala 57:26:@63.6]
  assign _GEN_1 = io_xfer_valid ? io_xfer_length : length; // @[AXIStreamSlave.scala 57:26:@63.6]
  assign _T_70 = 2'h1 == state; // @[Conditional.scala 37:30:@70.6]
  assign _T_71 = ready & valid; // @[AXIStreamSlave.scala 64:18:@72.8]
  assign _T_73 = length - 32'h1; // @[AXIStreamSlave.scala 65:26:@74.10]
  assign _T_74 = $unsigned(_T_73); // @[AXIStreamSlave.scala 65:26:@75.10]
  assign _T_75 = _T_74[31:0]; // @[AXIStreamSlave.scala 65:26:@76.10]
  assign _T_77 = length == 32'h1; // @[AXIStreamSlave.scala 66:21:@78.10]
  assign _GEN_3 = _T_77 ? 2'h2 : state; // @[AXIStreamSlave.scala 66:29:@79.10]
  assign _GEN_4 = _T_77 ? 1'h0 : enable; // @[AXIStreamSlave.scala 66:29:@79.10]
  assign _GEN_5 = _T_71 ? _T_75 : length; // @[AXIStreamSlave.scala 64:27:@73.8]
  assign _GEN_6 = _T_71 ? _GEN_3 : state; // @[AXIStreamSlave.scala 64:27:@73.8]
  assign _GEN_7 = _T_71 ? _GEN_4 : enable; // @[AXIStreamSlave.scala 64:27:@73.8]
  assign _T_79 = 2'h2 == state; // @[Conditional.scala 37:30:@86.8]
  assign _GEN_8 = _T_79 ? 2'h0 : state; // @[Conditional.scala 39:67:@87.8]
  assign _GEN_9 = _T_79 ? 1'h1 : done; // @[Conditional.scala 39:67:@87.8]
  assign _GEN_10 = _T_70 ? _GEN_5 : length; // @[Conditional.scala 39:67:@71.6]
  assign _GEN_11 = _T_70 ? _GEN_6 : _GEN_8; // @[Conditional.scala 39:67:@71.6]
  assign _GEN_12 = _T_70 ? _GEN_7 : enable; // @[Conditional.scala 39:67:@71.6]
  assign _GEN_13 = _T_70 ? done : _GEN_9; // @[Conditional.scala 39:67:@71.6]
  assign _GEN_14 = _T_66 ? 1'h0 : _GEN_13; // @[Conditional.scala 40:58:@60.4]
  assign _GEN_15 = _T_66 ? io_xfer_valid : _GEN_12; // @[Conditional.scala 40:58:@60.4]
  assign _GEN_16 = _T_66 ? _GEN_0 : _GEN_11; // @[Conditional.scala 40:58:@60.4]
  assign _GEN_17 = _T_66 ? _GEN_1 : _GEN_10; // @[Conditional.scala 40:58:@60.4]
  assign io_bus_tready = io_dataIO_ready & enable; // @[AXIStreamSlave.scala 46:17:@56.4]
  assign io_dataIO_valid = io_bus_tvalid & enable; // @[AXIStreamSlave.scala 45:19:@55.4]
  assign io_dataIO_bits = io_bus_tdata; // @[AXIStreamSlave.scala 48:18:@57.4]
  assign io_xfer_done = done; // @[AXIStreamSlave.scala 50:16:@58.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  done = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  enable = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  length = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
    end else begin
      if (_T_66) begin
        if (io_xfer_valid) begin
          state <= 2'h1;
        end
      end else begin
        if (_T_70) begin
          if (_T_71) begin
            if (_T_77) begin
              state <= 2'h2;
            end
          end
        end else begin
          if (_T_79) begin
            state <= 2'h0;
          end
        end
      end
    end
    if (reset) begin
      done <= 1'h0;
    end else begin
      if (_T_66) begin
        done <= 1'h0;
      end else begin
        if (!(_T_70)) begin
          if (_T_79) begin
            done <= 1'h1;
          end
        end
      end
    end
    if (reset) begin
      enable <= 1'h0;
    end else begin
      if (_T_66) begin
        enable <= io_xfer_valid;
      end else begin
        if (_T_70) begin
          if (_T_71) begin
            if (_T_77) begin
              enable <= 1'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      length <= 32'h0;
    end else begin
      if (_T_66) begin
        if (io_xfer_valid) begin
          length <= io_xfer_length;
        end
      end else begin
        if (_T_70) begin
          if (_T_71) begin
            length <= _T_75;
          end
        end
      end
    end
  end
endmodule
module AXIS_to_AXIS_AXIStreamMaster( // @[:@92.2]
  input         clock, // @[:@93.4]
  input         reset, // @[:@94.4]
  output [31:0] io_bus_tdata, // @[:@95.4]
  output        io_bus_tvalid, // @[:@95.4]
  input         io_bus_tready, // @[:@95.4]
  output        io_bus_tuser, // @[:@95.4]
  output        io_bus_tlast, // @[:@95.4]
  output        io_dataIO_ready, // @[:@95.4]
  input         io_dataIO_valid, // @[:@95.4]
  input  [31:0] io_dataIO_bits, // @[:@95.4]
  output        io_xfer_done, // @[:@95.4]
  input  [31:0] io_xfer_length, // @[:@95.4]
  input         io_xfer_valid, // @[:@95.4]
  input         io_xfer_first // @[:@95.4]
);
  reg [1:0] state; // @[AXIStreamMaster.scala 34:22:@97.4]
  reg [31:0] _RAND_0;
  reg  done; // @[AXIStreamMaster.scala 36:21:@98.4]
  reg [31:0] _RAND_1;
  reg  enable; // @[AXIStreamMaster.scala 38:23:@99.4]
  reg [31:0] _RAND_2;
  reg  user; // @[AXIStreamMaster.scala 40:21:@102.4]
  reg [31:0] _RAND_3;
  reg [31:0] length; // @[AXIStreamMaster.scala 42:23:@103.4]
  reg [31:0] _RAND_4;
  wire  ready; // @[AXIStreamMaster.scala 44:38:@104.4]
  wire  valid; // @[AXIStreamMaster.scala 45:40:@107.4]
  wire  last; // @[AXIStreamMaster.scala 56:18:@116.4]
  wire  _T_66; // @[Conditional.scala 37:30:@118.4]
  wire  _GEN_0; // @[AXIStreamMaster.scala 63:26:@122.6]
  wire [1:0] _GEN_1; // @[AXIStreamMaster.scala 63:26:@122.6]
  wire [31:0] _GEN_2; // @[AXIStreamMaster.scala 63:26:@122.6]
  wire  _T_70; // @[Conditional.scala 37:30:@130.6]
  wire  _T_71; // @[AXIStreamMaster.scala 71:18:@132.8]
  wire [32:0] _T_74; // @[AXIStreamMaster.scala 73:26:@135.10]
  wire [32:0] _T_75; // @[AXIStreamMaster.scala 73:26:@136.10]
  wire [31:0] _T_76; // @[AXIStreamMaster.scala 73:26:@137.10]
  wire [1:0] _GEN_4; // @[AXIStreamMaster.scala 74:29:@140.10]
  wire  _GEN_5; // @[AXIStreamMaster.scala 74:29:@140.10]
  wire  _GEN_6; // @[AXIStreamMaster.scala 71:27:@133.8]
  wire [31:0] _GEN_7; // @[AXIStreamMaster.scala 71:27:@133.8]
  wire [1:0] _GEN_8; // @[AXIStreamMaster.scala 71:27:@133.8]
  wire  _GEN_9; // @[AXIStreamMaster.scala 71:27:@133.8]
  wire  _T_80; // @[Conditional.scala 37:30:@147.8]
  wire [1:0] _GEN_10; // @[Conditional.scala 39:67:@148.8]
  wire  _GEN_11; // @[Conditional.scala 39:67:@148.8]
  wire  _GEN_12; // @[Conditional.scala 39:67:@131.6]
  wire [31:0] _GEN_13; // @[Conditional.scala 39:67:@131.6]
  wire [1:0] _GEN_14; // @[Conditional.scala 39:67:@131.6]
  wire  _GEN_15; // @[Conditional.scala 39:67:@131.6]
  wire  _GEN_16; // @[Conditional.scala 39:67:@131.6]
  wire  _GEN_17; // @[Conditional.scala 40:58:@119.4]
  wire  _GEN_18; // @[Conditional.scala 40:58:@119.4]
  wire  _GEN_19; // @[Conditional.scala 40:58:@119.4]
  wire [1:0] _GEN_20; // @[Conditional.scala 40:58:@119.4]
  wire [31:0] _GEN_21; // @[Conditional.scala 40:58:@119.4]
  assign ready = io_bus_tready & enable; // @[AXIStreamMaster.scala 44:38:@104.4]
  assign valid = io_dataIO_valid & enable; // @[AXIStreamMaster.scala 45:40:@107.4]
  assign last = length == 32'h1; // @[AXIStreamMaster.scala 56:18:@116.4]
  assign _T_66 = 2'h0 == state; // @[Conditional.scala 37:30:@118.4]
  assign _GEN_0 = io_xfer_valid ? io_xfer_first : user; // @[AXIStreamMaster.scala 63:26:@122.6]
  assign _GEN_1 = io_xfer_valid ? 2'h1 : state; // @[AXIStreamMaster.scala 63:26:@122.6]
  assign _GEN_2 = io_xfer_valid ? io_xfer_length : length; // @[AXIStreamMaster.scala 63:26:@122.6]
  assign _T_70 = 2'h1 == state; // @[Conditional.scala 37:30:@130.6]
  assign _T_71 = ready & valid; // @[AXIStreamMaster.scala 71:18:@132.8]
  assign _T_74 = length - 32'h1; // @[AXIStreamMaster.scala 73:26:@135.10]
  assign _T_75 = $unsigned(_T_74); // @[AXIStreamMaster.scala 73:26:@136.10]
  assign _T_76 = _T_75[31:0]; // @[AXIStreamMaster.scala 73:26:@137.10]
  assign _GEN_4 = last ? 2'h2 : state; // @[AXIStreamMaster.scala 74:29:@140.10]
  assign _GEN_5 = last ? 1'h0 : enable; // @[AXIStreamMaster.scala 74:29:@140.10]
  assign _GEN_6 = _T_71 ? 1'h0 : user; // @[AXIStreamMaster.scala 71:27:@133.8]
  assign _GEN_7 = _T_71 ? _T_76 : length; // @[AXIStreamMaster.scala 71:27:@133.8]
  assign _GEN_8 = _T_71 ? _GEN_4 : state; // @[AXIStreamMaster.scala 71:27:@133.8]
  assign _GEN_9 = _T_71 ? _GEN_5 : enable; // @[AXIStreamMaster.scala 71:27:@133.8]
  assign _T_80 = 2'h2 == state; // @[Conditional.scala 37:30:@147.8]
  assign _GEN_10 = _T_80 ? 2'h0 : state; // @[Conditional.scala 39:67:@148.8]
  assign _GEN_11 = _T_80 ? 1'h1 : done; // @[Conditional.scala 39:67:@148.8]
  assign _GEN_12 = _T_70 ? _GEN_6 : user; // @[Conditional.scala 39:67:@131.6]
  assign _GEN_13 = _T_70 ? _GEN_7 : length; // @[Conditional.scala 39:67:@131.6]
  assign _GEN_14 = _T_70 ? _GEN_8 : _GEN_10; // @[Conditional.scala 39:67:@131.6]
  assign _GEN_15 = _T_70 ? _GEN_9 : enable; // @[Conditional.scala 39:67:@131.6]
  assign _GEN_16 = _T_70 ? done : _GEN_11; // @[Conditional.scala 39:67:@131.6]
  assign _GEN_17 = _T_66 ? 1'h0 : _GEN_16; // @[Conditional.scala 40:58:@119.4]
  assign _GEN_18 = _T_66 ? io_xfer_valid : _GEN_15; // @[Conditional.scala 40:58:@119.4]
  assign _GEN_19 = _T_66 ? _GEN_0 : _GEN_12; // @[Conditional.scala 40:58:@119.4]
  assign _GEN_20 = _T_66 ? _GEN_1 : _GEN_14; // @[Conditional.scala 40:58:@119.4]
  assign _GEN_21 = _T_66 ? _GEN_2 : _GEN_13; // @[Conditional.scala 40:58:@119.4]
  assign io_bus_tdata = io_dataIO_bits; // @[AXIStreamMaster.scala 50:16:@112.4]
  assign io_bus_tvalid = io_dataIO_valid & enable; // @[AXIStreamMaster.scala 47:17:@110.4]
  assign io_bus_tuser = user; // @[AXIStreamMaster.scala 52:16:@114.4]
  assign io_bus_tlast = length == 32'h1; // @[AXIStreamMaster.scala 51:16:@113.4]
  assign io_dataIO_ready = io_bus_tready & enable; // @[AXIStreamMaster.scala 48:19:@111.4]
  assign io_xfer_done = done; // @[AXIStreamMaster.scala 54:16:@115.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  done = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  enable = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  user = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  length = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
    end else begin
      if (_T_66) begin
        if (io_xfer_valid) begin
          state <= 2'h1;
        end
      end else begin
        if (_T_70) begin
          if (_T_71) begin
            if (last) begin
              state <= 2'h2;
            end
          end
        end else begin
          if (_T_80) begin
            state <= 2'h0;
          end
        end
      end
    end
    if (reset) begin
      done <= 1'h0;
    end else begin
      if (_T_66) begin
        done <= 1'h0;
      end else begin
        if (!(_T_70)) begin
          if (_T_80) begin
            done <= 1'h1;
          end
        end
      end
    end
    if (reset) begin
      enable <= 1'h0;
    end else begin
      if (_T_66) begin
        enable <= io_xfer_valid;
      end else begin
        if (_T_70) begin
          if (_T_71) begin
            if (last) begin
              enable <= 1'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      user <= 1'h0;
    end else begin
      if (_T_66) begin
        if (io_xfer_valid) begin
          user <= io_xfer_first;
        end
      end else begin
        if (_T_70) begin
          if (_T_71) begin
            user <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      length <= 32'h0;
    end else begin
      if (_T_66) begin
        if (io_xfer_valid) begin
          length <= io_xfer_length;
        end
      end else begin
        if (_T_70) begin
          if (_T_71) begin
            length <= _T_76;
          end
        end
      end
    end
  end
endmodule
module AXIS_to_AXIS_CSR( // @[:@153.2]
  output [31:0] io_csr_0_dataOut, // @[:@156.4]
  output        io_csr_0_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_0_dataIn, // @[:@156.4]
  input  [31:0] io_csr_1_dataIn, // @[:@156.4]
  output [31:0] io_csr_2_dataOut, // @[:@156.4]
  output        io_csr_2_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_2_dataIn, // @[:@156.4]
  output [31:0] io_csr_3_dataOut, // @[:@156.4]
  output        io_csr_3_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_3_dataIn, // @[:@156.4]
  output [31:0] io_csr_4_dataOut, // @[:@156.4]
  output        io_csr_4_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_4_dataIn, // @[:@156.4]
  output [31:0] io_csr_5_dataOut, // @[:@156.4]
  output        io_csr_5_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_5_dataIn, // @[:@156.4]
  output [31:0] io_csr_6_dataOut, // @[:@156.4]
  output        io_csr_6_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_6_dataIn, // @[:@156.4]
  output [31:0] io_csr_7_dataOut, // @[:@156.4]
  output        io_csr_7_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_7_dataIn, // @[:@156.4]
  output [31:0] io_csr_8_dataOut, // @[:@156.4]
  output        io_csr_8_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_8_dataIn, // @[:@156.4]
  output [31:0] io_csr_9_dataOut, // @[:@156.4]
  output        io_csr_9_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_9_dataIn, // @[:@156.4]
  output [31:0] io_csr_10_dataOut, // @[:@156.4]
  output        io_csr_10_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_10_dataIn, // @[:@156.4]
  output [31:0] io_csr_11_dataOut, // @[:@156.4]
  output        io_csr_11_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_11_dataIn, // @[:@156.4]
  input  [31:0] io_csr_12_dataIn, // @[:@156.4]
  input  [31:0] io_csr_13_dataIn, // @[:@156.4]
  output [31:0] io_csr_14_dataOut, // @[:@156.4]
  output        io_csr_14_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_14_dataIn, // @[:@156.4]
  output [31:0] io_csr_15_dataOut, // @[:@156.4]
  output        io_csr_15_dataWrite, // @[:@156.4]
  input  [31:0] io_csr_15_dataIn, // @[:@156.4]
  input  [3:0]  io_bus_addr, // @[:@156.4]
  input  [31:0] io_bus_dataOut, // @[:@156.4]
  output [31:0] io_bus_dataIn, // @[:@156.4]
  input         io_bus_write, // @[:@156.4]
  input         io_bus_read // @[:@156.4]
);
  wire  _T_178; // @[CSR.scala 31:22:@161.4]
  wire  _T_179; // @[CSR.scala 31:30:@162.4]
  wire [31:0] _GEN_0; // @[CSR.scala 31:45:@163.4]
  wire  _T_184; // @[CSR.scala 38:30:@171.4]
  wire  _T_189; // @[CSR.scala 31:22:@180.4]
  wire  _T_190; // @[CSR.scala 31:30:@181.4]
  wire [31:0] _GEN_4; // @[CSR.scala 31:45:@182.4]
  wire  _T_200; // @[CSR.scala 31:22:@199.4]
  wire  _T_201; // @[CSR.scala 31:30:@200.4]
  wire [31:0] _GEN_8; // @[CSR.scala 31:45:@201.4]
  wire  _T_206; // @[CSR.scala 38:30:@209.4]
  wire  _T_211; // @[CSR.scala 31:22:@218.4]
  wire  _T_212; // @[CSR.scala 31:30:@219.4]
  wire [31:0] _GEN_12; // @[CSR.scala 31:45:@220.4]
  wire  _T_217; // @[CSR.scala 38:30:@228.4]
  wire  _T_222; // @[CSR.scala 31:22:@237.4]
  wire  _T_223; // @[CSR.scala 31:30:@238.4]
  wire [31:0] _GEN_16; // @[CSR.scala 31:45:@239.4]
  wire  _T_228; // @[CSR.scala 38:30:@247.4]
  wire  _T_233; // @[CSR.scala 31:22:@256.4]
  wire  _T_234; // @[CSR.scala 31:30:@257.4]
  wire [31:0] _GEN_20; // @[CSR.scala 31:45:@258.4]
  wire  _T_239; // @[CSR.scala 38:30:@266.4]
  wire  _T_244; // @[CSR.scala 31:22:@275.4]
  wire  _T_245; // @[CSR.scala 31:30:@276.4]
  wire [31:0] _GEN_24; // @[CSR.scala 31:45:@277.4]
  wire  _T_250; // @[CSR.scala 38:30:@285.4]
  wire  _T_255; // @[CSR.scala 31:22:@294.4]
  wire  _T_256; // @[CSR.scala 31:30:@295.4]
  wire [31:0] _GEN_28; // @[CSR.scala 31:45:@296.4]
  wire  _T_261; // @[CSR.scala 38:30:@304.4]
  wire  _T_266; // @[CSR.scala 31:22:@313.4]
  wire  _T_267; // @[CSR.scala 31:30:@314.4]
  wire [31:0] _GEN_32; // @[CSR.scala 31:45:@315.4]
  wire  _T_272; // @[CSR.scala 38:30:@323.4]
  wire  _T_277; // @[CSR.scala 31:22:@332.4]
  wire  _T_278; // @[CSR.scala 31:30:@333.4]
  wire [31:0] _GEN_36; // @[CSR.scala 31:45:@334.4]
  wire  _T_283; // @[CSR.scala 38:30:@342.4]
  wire  _T_288; // @[CSR.scala 31:22:@351.4]
  wire  _T_289; // @[CSR.scala 31:30:@352.4]
  wire [31:0] _GEN_40; // @[CSR.scala 31:45:@353.4]
  wire  _T_294; // @[CSR.scala 38:30:@361.4]
  wire  _T_299; // @[CSR.scala 31:22:@370.4]
  wire  _T_300; // @[CSR.scala 31:30:@371.4]
  wire [31:0] _GEN_44; // @[CSR.scala 31:45:@372.4]
  wire  _T_305; // @[CSR.scala 38:30:@380.4]
  wire  _T_310; // @[CSR.scala 31:22:@389.4]
  wire  _T_311; // @[CSR.scala 31:30:@390.4]
  wire [31:0] _GEN_48; // @[CSR.scala 31:45:@391.4]
  wire  _T_321; // @[CSR.scala 31:22:@408.4]
  wire  _T_322; // @[CSR.scala 31:30:@409.4]
  wire [31:0] _GEN_52; // @[CSR.scala 31:45:@410.4]
  wire  _T_332; // @[CSR.scala 31:22:@427.4]
  wire  _T_333; // @[CSR.scala 31:30:@428.4]
  wire [31:0] _GEN_56; // @[CSR.scala 31:45:@429.4]
  wire  _T_338; // @[CSR.scala 38:30:@437.4]
  wire  _T_343; // @[CSR.scala 31:22:@446.4]
  wire  _T_344; // @[CSR.scala 31:30:@447.4]
  wire  _T_349; // @[CSR.scala 38:30:@456.4]
  assign _T_178 = io_bus_addr == 4'h0; // @[CSR.scala 31:22:@161.4]
  assign _T_179 = _T_178 & io_bus_read; // @[CSR.scala 31:30:@162.4]
  assign _GEN_0 = _T_179 ? io_csr_0_dataIn : 32'h0; // @[CSR.scala 31:45:@163.4]
  assign _T_184 = _T_178 & io_bus_write; // @[CSR.scala 38:30:@171.4]
  assign _T_189 = io_bus_addr == 4'h1; // @[CSR.scala 31:22:@180.4]
  assign _T_190 = _T_189 & io_bus_read; // @[CSR.scala 31:30:@181.4]
  assign _GEN_4 = _T_190 ? io_csr_1_dataIn : _GEN_0; // @[CSR.scala 31:45:@182.4]
  assign _T_200 = io_bus_addr == 4'h2; // @[CSR.scala 31:22:@199.4]
  assign _T_201 = _T_200 & io_bus_read; // @[CSR.scala 31:30:@200.4]
  assign _GEN_8 = _T_201 ? io_csr_2_dataIn : _GEN_4; // @[CSR.scala 31:45:@201.4]
  assign _T_206 = _T_200 & io_bus_write; // @[CSR.scala 38:30:@209.4]
  assign _T_211 = io_bus_addr == 4'h3; // @[CSR.scala 31:22:@218.4]
  assign _T_212 = _T_211 & io_bus_read; // @[CSR.scala 31:30:@219.4]
  assign _GEN_12 = _T_212 ? io_csr_3_dataIn : _GEN_8; // @[CSR.scala 31:45:@220.4]
  assign _T_217 = _T_211 & io_bus_write; // @[CSR.scala 38:30:@228.4]
  assign _T_222 = io_bus_addr == 4'h4; // @[CSR.scala 31:22:@237.4]
  assign _T_223 = _T_222 & io_bus_read; // @[CSR.scala 31:30:@238.4]
  assign _GEN_16 = _T_223 ? io_csr_4_dataIn : _GEN_12; // @[CSR.scala 31:45:@239.4]
  assign _T_228 = _T_222 & io_bus_write; // @[CSR.scala 38:30:@247.4]
  assign _T_233 = io_bus_addr == 4'h5; // @[CSR.scala 31:22:@256.4]
  assign _T_234 = _T_233 & io_bus_read; // @[CSR.scala 31:30:@257.4]
  assign _GEN_20 = _T_234 ? io_csr_5_dataIn : _GEN_16; // @[CSR.scala 31:45:@258.4]
  assign _T_239 = _T_233 & io_bus_write; // @[CSR.scala 38:30:@266.4]
  assign _T_244 = io_bus_addr == 4'h6; // @[CSR.scala 31:22:@275.4]
  assign _T_245 = _T_244 & io_bus_read; // @[CSR.scala 31:30:@276.4]
  assign _GEN_24 = _T_245 ? io_csr_6_dataIn : _GEN_20; // @[CSR.scala 31:45:@277.4]
  assign _T_250 = _T_244 & io_bus_write; // @[CSR.scala 38:30:@285.4]
  assign _T_255 = io_bus_addr == 4'h7; // @[CSR.scala 31:22:@294.4]
  assign _T_256 = _T_255 & io_bus_read; // @[CSR.scala 31:30:@295.4]
  assign _GEN_28 = _T_256 ? io_csr_7_dataIn : _GEN_24; // @[CSR.scala 31:45:@296.4]
  assign _T_261 = _T_255 & io_bus_write; // @[CSR.scala 38:30:@304.4]
  assign _T_266 = io_bus_addr == 4'h8; // @[CSR.scala 31:22:@313.4]
  assign _T_267 = _T_266 & io_bus_read; // @[CSR.scala 31:30:@314.4]
  assign _GEN_32 = _T_267 ? io_csr_8_dataIn : _GEN_28; // @[CSR.scala 31:45:@315.4]
  assign _T_272 = _T_266 & io_bus_write; // @[CSR.scala 38:30:@323.4]
  assign _T_277 = io_bus_addr == 4'h9; // @[CSR.scala 31:22:@332.4]
  assign _T_278 = _T_277 & io_bus_read; // @[CSR.scala 31:30:@333.4]
  assign _GEN_36 = _T_278 ? io_csr_9_dataIn : _GEN_32; // @[CSR.scala 31:45:@334.4]
  assign _T_283 = _T_277 & io_bus_write; // @[CSR.scala 38:30:@342.4]
  assign _T_288 = io_bus_addr == 4'ha; // @[CSR.scala 31:22:@351.4]
  assign _T_289 = _T_288 & io_bus_read; // @[CSR.scala 31:30:@352.4]
  assign _GEN_40 = _T_289 ? io_csr_10_dataIn : _GEN_36; // @[CSR.scala 31:45:@353.4]
  assign _T_294 = _T_288 & io_bus_write; // @[CSR.scala 38:30:@361.4]
  assign _T_299 = io_bus_addr == 4'hb; // @[CSR.scala 31:22:@370.4]
  assign _T_300 = _T_299 & io_bus_read; // @[CSR.scala 31:30:@371.4]
  assign _GEN_44 = _T_300 ? io_csr_11_dataIn : _GEN_40; // @[CSR.scala 31:45:@372.4]
  assign _T_305 = _T_299 & io_bus_write; // @[CSR.scala 38:30:@380.4]
  assign _T_310 = io_bus_addr == 4'hc; // @[CSR.scala 31:22:@389.4]
  assign _T_311 = _T_310 & io_bus_read; // @[CSR.scala 31:30:@390.4]
  assign _GEN_48 = _T_311 ? io_csr_12_dataIn : _GEN_44; // @[CSR.scala 31:45:@391.4]
  assign _T_321 = io_bus_addr == 4'hd; // @[CSR.scala 31:22:@408.4]
  assign _T_322 = _T_321 & io_bus_read; // @[CSR.scala 31:30:@409.4]
  assign _GEN_52 = _T_322 ? io_csr_13_dataIn : _GEN_48; // @[CSR.scala 31:45:@410.4]
  assign _T_332 = io_bus_addr == 4'he; // @[CSR.scala 31:22:@427.4]
  assign _T_333 = _T_332 & io_bus_read; // @[CSR.scala 31:30:@428.4]
  assign _GEN_56 = _T_333 ? io_csr_14_dataIn : _GEN_52; // @[CSR.scala 31:45:@429.4]
  assign _T_338 = _T_332 & io_bus_write; // @[CSR.scala 38:30:@437.4]
  assign _T_343 = io_bus_addr == 4'hf; // @[CSR.scala 31:22:@446.4]
  assign _T_344 = _T_343 & io_bus_read; // @[CSR.scala 31:30:@447.4]
  assign _T_349 = _T_343 & io_bus_write; // @[CSR.scala 38:30:@456.4]
  assign io_csr_0_dataOut = _T_184 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@173.6 CSR.scala 43:25:@178.6]
  assign io_csr_0_dataWrite = _T_178 & io_bus_write; // @[CSR.scala 40:27:@174.6 CSR.scala 42:27:@177.6]
  assign io_csr_2_dataOut = _T_206 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@211.6 CSR.scala 43:25:@216.6]
  assign io_csr_2_dataWrite = _T_200 & io_bus_write; // @[CSR.scala 40:27:@212.6 CSR.scala 42:27:@215.6]
  assign io_csr_3_dataOut = _T_217 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@230.6 CSR.scala 43:25:@235.6]
  assign io_csr_3_dataWrite = _T_211 & io_bus_write; // @[CSR.scala 40:27:@231.6 CSR.scala 42:27:@234.6]
  assign io_csr_4_dataOut = _T_228 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@249.6 CSR.scala 43:25:@254.6]
  assign io_csr_4_dataWrite = _T_222 & io_bus_write; // @[CSR.scala 40:27:@250.6 CSR.scala 42:27:@253.6]
  assign io_csr_5_dataOut = _T_239 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@268.6 CSR.scala 43:25:@273.6]
  assign io_csr_5_dataWrite = _T_233 & io_bus_write; // @[CSR.scala 40:27:@269.6 CSR.scala 42:27:@272.6]
  assign io_csr_6_dataOut = _T_250 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@287.6 CSR.scala 43:25:@292.6]
  assign io_csr_6_dataWrite = _T_244 & io_bus_write; // @[CSR.scala 40:27:@288.6 CSR.scala 42:27:@291.6]
  assign io_csr_7_dataOut = _T_261 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@306.6 CSR.scala 43:25:@311.6]
  assign io_csr_7_dataWrite = _T_255 & io_bus_write; // @[CSR.scala 40:27:@307.6 CSR.scala 42:27:@310.6]
  assign io_csr_8_dataOut = _T_272 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@325.6 CSR.scala 43:25:@330.6]
  assign io_csr_8_dataWrite = _T_266 & io_bus_write; // @[CSR.scala 40:27:@326.6 CSR.scala 42:27:@329.6]
  assign io_csr_9_dataOut = _T_283 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@344.6 CSR.scala 43:25:@349.6]
  assign io_csr_9_dataWrite = _T_277 & io_bus_write; // @[CSR.scala 40:27:@345.6 CSR.scala 42:27:@348.6]
  assign io_csr_10_dataOut = _T_294 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@363.6 CSR.scala 43:25:@368.6]
  assign io_csr_10_dataWrite = _T_288 & io_bus_write; // @[CSR.scala 40:27:@364.6 CSR.scala 42:27:@367.6]
  assign io_csr_11_dataOut = _T_305 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@382.6 CSR.scala 43:25:@387.6]
  assign io_csr_11_dataWrite = _T_299 & io_bus_write; // @[CSR.scala 40:27:@383.6 CSR.scala 42:27:@386.6]
  assign io_csr_14_dataOut = _T_338 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@439.6 CSR.scala 43:25:@444.6]
  assign io_csr_14_dataWrite = _T_332 & io_bus_write; // @[CSR.scala 40:27:@440.6 CSR.scala 42:27:@443.6]
  assign io_csr_15_dataOut = _T_349 ? io_bus_dataOut : 32'h0; // @[CSR.scala 39:25:@458.6 CSR.scala 43:25:@463.6]
  assign io_csr_15_dataWrite = _T_343 & io_bus_write; // @[CSR.scala 40:27:@459.6 CSR.scala 42:27:@462.6]
  assign io_bus_dataIn = _T_344 ? io_csr_15_dataIn : _GEN_56; // @[CSR.scala 28:17:@160.4]
endmodule
module AXIS_to_AXIS_AddressGenerator( // @[:@466.2]
  input         clock, // @[:@467.4]
  input         reset, // @[:@468.4]
  input         io_ctl_start, // @[:@469.4]
  output        io_ctl_busy, // @[:@469.4]
  input  [31:0] io_ctl_lineLength, // @[:@469.4]
  input  [31:0] io_ctl_lineCount, // @[:@469.4]
  input         io_xfer_done, // @[:@469.4]
  output [31:0] io_xfer_length, // @[:@469.4]
  output        io_xfer_valid, // @[:@469.4]
  output        io_xfer_first // @[:@469.4]
);
  reg [1:0] state; // @[AddressGenerator.scala 28:22:@471.4]
  reg [31:0] _RAND_0;
  reg [31:0] lineCount; // @[AddressGenerator.scala 30:26:@472.4]
  reg [31:0] _RAND_1;
  reg [31:0] length_o; // @[AddressGenerator.scala 35:25:@476.4]
  reg [31:0] _RAND_2;
  reg [31:0] length_i; // @[AddressGenerator.scala 36:25:@477.4]
  reg [31:0] _RAND_3;
  reg  valid; // @[AddressGenerator.scala 37:22:@478.4]
  reg [31:0] _RAND_4;
  reg  first; // @[AddressGenerator.scala 38:22:@479.4]
  reg [31:0] _RAND_5;
  reg  busy; // @[AddressGenerator.scala 39:21:@480.4]
  reg [31:0] _RAND_6;
  wire  _T_46; // @[AddressGenerator.scala 47:14:@486.4]
  wire  _GEN_0; // @[AddressGenerator.scala 47:24:@487.4]
  wire  _T_49; // @[Conditional.scala 37:30:@493.4]
  wire [1:0] _GEN_1; // @[AddressGenerator.scala 55:25:@495.6]
  wire [31:0] _GEN_3; // @[AddressGenerator.scala 55:25:@495.6]
  wire [31:0] _GEN_4; // @[AddressGenerator.scala 55:25:@495.6]
  wire  _GEN_6; // @[AddressGenerator.scala 55:25:@495.6]
  wire  _T_51; // @[Conditional.scala 37:30:@505.6]
  wire [32:0] _T_62; // @[AddressGenerator.scala 72:30:@517.8]
  wire [32:0] _T_63; // @[AddressGenerator.scala 72:30:@518.8]
  wire [31:0] _T_64; // @[AddressGenerator.scala 72:30:@519.8]
  wire  _T_65; // @[Conditional.scala 37:30:@524.8]
  wire  _T_69; // @[AddressGenerator.scala 79:24:@529.12]
  wire [1:0] _GEN_7; // @[AddressGenerator.scala 79:30:@530.12]
  wire [1:0] _GEN_8; // @[AddressGenerator.scala 78:25:@528.10]
  wire  _GEN_9; // @[Conditional.scala 39:67:@525.8]
  wire  _GEN_10; // @[Conditional.scala 39:67:@525.8]
  wire [1:0] _GEN_11; // @[Conditional.scala 39:67:@525.8]
  wire  _GEN_12; // @[Conditional.scala 39:67:@506.6]
  wire [31:0] _GEN_14; // @[Conditional.scala 39:67:@506.6]
  wire [31:0] _GEN_16; // @[Conditional.scala 39:67:@506.6]
  wire [1:0] _GEN_17; // @[Conditional.scala 39:67:@506.6]
  wire  _GEN_18; // @[Conditional.scala 39:67:@506.6]
  wire [1:0] _GEN_19; // @[Conditional.scala 40:58:@494.4]
  wire [31:0] _GEN_21; // @[Conditional.scala 40:58:@494.4]
  wire [31:0] _GEN_22; // @[Conditional.scala 40:58:@494.4]
  wire  _GEN_24; // @[Conditional.scala 40:58:@494.4]
  wire  _GEN_25; // @[Conditional.scala 40:58:@494.4]
  wire [31:0] _GEN_27; // @[Conditional.scala 40:58:@494.4]
  assign _T_46 = state == 2'h0; // @[AddressGenerator.scala 47:14:@486.4]
  assign _GEN_0 = _T_46 ? 1'h0 : 1'h1; // @[AddressGenerator.scala 47:24:@487.4]
  assign _T_49 = 2'h0 == state; // @[Conditional.scala 37:30:@493.4]
  assign _GEN_1 = io_ctl_start ? 2'h1 : state; // @[AddressGenerator.scala 55:25:@495.6]
  assign _GEN_3 = io_ctl_start ? io_ctl_lineLength : length_i; // @[AddressGenerator.scala 55:25:@495.6]
  assign _GEN_4 = io_ctl_start ? io_ctl_lineCount : lineCount; // @[AddressGenerator.scala 55:25:@495.6]
  assign _GEN_6 = io_ctl_start ? 1'h1 : first; // @[AddressGenerator.scala 55:25:@495.6]
  assign _T_51 = 2'h1 == state; // @[Conditional.scala 37:30:@505.6]
  assign _T_62 = lineCount - 32'h1; // @[AddressGenerator.scala 72:30:@517.8]
  assign _T_63 = $unsigned(_T_62); // @[AddressGenerator.scala 72:30:@518.8]
  assign _T_64 = _T_63[31:0]; // @[AddressGenerator.scala 72:30:@519.8]
  assign _T_65 = 2'h2 == state; // @[Conditional.scala 37:30:@524.8]
  assign _T_69 = lineCount > 32'h0; // @[AddressGenerator.scala 79:24:@529.12]
  assign _GEN_7 = _T_69 ? 2'h1 : 2'h0; // @[AddressGenerator.scala 79:30:@530.12]
  assign _GEN_8 = io_xfer_done ? _GEN_7 : state; // @[AddressGenerator.scala 78:25:@528.10]
  assign _GEN_9 = _T_65 ? 1'h0 : valid; // @[Conditional.scala 39:67:@525.8]
  assign _GEN_10 = _T_65 ? 1'h0 : first; // @[Conditional.scala 39:67:@525.8]
  assign _GEN_11 = _T_65 ? _GEN_8 : state; // @[Conditional.scala 39:67:@525.8]
  assign _GEN_12 = _T_51 ? 1'h1 : _GEN_9; // @[Conditional.scala 39:67:@506.6]
  assign _GEN_14 = _T_51 ? length_i : length_o; // @[Conditional.scala 39:67:@506.6]
  assign _GEN_16 = _T_51 ? _T_64 : lineCount; // @[Conditional.scala 39:67:@506.6]
  assign _GEN_17 = _T_51 ? 2'h2 : _GEN_11; // @[Conditional.scala 39:67:@506.6]
  assign _GEN_18 = _T_51 ? first : _GEN_10; // @[Conditional.scala 39:67:@506.6]
  assign _GEN_19 = _T_49 ? _GEN_1 : _GEN_17; // @[Conditional.scala 40:58:@494.4]
  assign _GEN_21 = _T_49 ? _GEN_3 : length_i; // @[Conditional.scala 40:58:@494.4]
  assign _GEN_22 = _T_49 ? _GEN_4 : _GEN_16; // @[Conditional.scala 40:58:@494.4]
  assign _GEN_24 = _T_49 ? _GEN_6 : _GEN_18; // @[Conditional.scala 40:58:@494.4]
  assign _GEN_25 = _T_49 ? valid : _GEN_12; // @[Conditional.scala 40:58:@494.4]
  assign _GEN_27 = _T_49 ? length_o : _GEN_14; // @[Conditional.scala 40:58:@494.4]
  assign io_ctl_busy = busy; // @[AddressGenerator.scala 45:15:@485.4]
  assign io_xfer_length = length_o; // @[AddressGenerator.scala 42:18:@482.4]
  assign io_xfer_valid = valid; // @[AddressGenerator.scala 43:17:@483.4]
  assign io_xfer_first = first; // @[AddressGenerator.scala 44:17:@484.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  lineCount = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  length_o = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  length_i = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  valid = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  first = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  busy = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
    end else begin
      if (_T_49) begin
        if (io_ctl_start) begin
          state <= 2'h1;
        end
      end else begin
        if (_T_51) begin
          state <= 2'h2;
        end else begin
          if (_T_65) begin
            if (io_xfer_done) begin
              if (_T_69) begin
                state <= 2'h1;
              end else begin
                state <= 2'h0;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      lineCount <= 32'h0;
    end else begin
      if (_T_49) begin
        if (io_ctl_start) begin
          lineCount <= io_ctl_lineCount;
        end
      end else begin
        if (_T_51) begin
          lineCount <= _T_64;
        end
      end
    end
    if (reset) begin
      length_o <= 32'h0;
    end else begin
      if (!(_T_49)) begin
        if (_T_51) begin
          length_o <= length_i;
        end
      end
    end
    if (reset) begin
      length_i <= 32'h0;
    end else begin
      if (_T_49) begin
        if (io_ctl_start) begin
          length_i <= io_ctl_lineLength;
        end
      end
    end
    if (reset) begin
      valid <= 1'h0;
    end else begin
      if (!(_T_49)) begin
        if (_T_51) begin
          valid <= 1'h1;
        end else begin
          if (_T_65) begin
            valid <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      first <= 1'h0;
    end else begin
      if (_T_49) begin
        if (io_ctl_start) begin
          first <= 1'h1;
        end
      end else begin
        if (!(_T_51)) begin
          if (_T_65) begin
            first <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      busy <= 1'h0;
    end else begin
      if (_T_46) begin
        busy <= 1'h0;
      end else begin
        busy <= 1'h1;
      end
    end
  end
endmodule
module AXIS_to_AXIS_TransferSplitter( // @[:@539.2]
  output        io_xferIn_done, // @[:@542.4]
  input  [31:0] io_xferIn_length, // @[:@542.4]
  input         io_xferIn_valid, // @[:@542.4]
  input         io_xferOut_done, // @[:@542.4]
  output [31:0] io_xferOut_length, // @[:@542.4]
  output        io_xferOut_valid // @[:@542.4]
);
  assign io_xferIn_done = io_xferOut_done; // @[TransferSplitter.scala 123:16:@548.4]
  assign io_xferOut_length = io_xferIn_length; // @[TransferSplitter.scala 123:16:@546.4]
  assign io_xferOut_valid = io_xferIn_valid; // @[TransferSplitter.scala 123:16:@545.4]
endmodule
module AXIS_to_AXIS_TransferSplitter_1( // @[:@623.2]
  input         clock, // @[:@624.4]
  input         reset, // @[:@625.4]
  output        io_xferIn_done, // @[:@626.4]
  input  [31:0] io_xferIn_length, // @[:@626.4]
  input         io_xferIn_valid, // @[:@626.4]
  input         io_xferIn_first, // @[:@626.4]
  input         io_xferOut_done, // @[:@626.4]
  output [31:0] io_xferOut_length, // @[:@626.4]
  output        io_xferOut_valid, // @[:@626.4]
  output        io_xferOut_first // @[:@626.4]
);
  reg [31:0] _T_45; // @[TransferSplitter.scala 35:27:@629.4]
  reg [31:0] _RAND_0;
  reg [31:0] _T_51; // @[TransferSplitter.scala 38:27:@631.4]
  reg [31:0] _RAND_1;
  reg  _T_54; // @[TransferSplitter.scala 40:26:@632.4]
  reg [31:0] _RAND_2;
  reg  _T_57; // @[TransferSplitter.scala 41:26:@633.4]
  reg [31:0] _RAND_3;
  reg  _T_60; // @[TransferSplitter.scala 43:23:@634.4]
  reg [31:0] _RAND_4;
  reg  _T_63; // @[TransferSplitter.scala 44:24:@635.4]
  reg [31:0] _RAND_5;
  reg [1:0] _T_65; // @[TransferSplitter.scala 46:24:@636.4]
  reg [31:0] _RAND_6;
  wire  _T_66; // @[Conditional.scala 37:30:@642.4]
  wire [31:0] _GEN_1; // @[TransferSplitter.scala 59:31:@645.6]
  wire  _GEN_2; // @[TransferSplitter.scala 59:31:@645.6]
  wire [1:0] _GEN_3; // @[TransferSplitter.scala 59:31:@645.6]
  wire  _T_68; // @[Conditional.scala 37:30:@653.6]
  wire  _T_71; // @[TransferSplitter.scala 72:23:@659.8]
  wire [32:0] _T_74; // @[TransferSplitter.scala 75:34:@662.10]
  wire [32:0] _T_75; // @[TransferSplitter.scala 75:34:@663.10]
  wire [31:0] _T_76; // @[TransferSplitter.scala 75:34:@664.10]
  wire [31:0] _GEN_4; // @[TransferSplitter.scala 72:38:@660.8]
  wire [31:0] _GEN_5; // @[TransferSplitter.scala 72:38:@660.8]
  wire  _T_87; // @[Conditional.scala 37:30:@681.8]
  wire  _T_91; // @[TransferSplitter.scala 113:25:@686.12]
  wire [1:0] _GEN_7; // @[TransferSplitter.scala 113:32:@687.12]
  wire  _GEN_8; // @[TransferSplitter.scala 113:32:@687.12]
  wire [1:0] _GEN_9; // @[TransferSplitter.scala 112:31:@685.10]
  wire  _GEN_10; // @[TransferSplitter.scala 112:31:@685.10]
  wire  _GEN_11; // @[Conditional.scala 39:67:@682.8]
  wire  _GEN_12; // @[Conditional.scala 39:67:@682.8]
  wire [1:0] _GEN_13; // @[Conditional.scala 39:67:@682.8]
  wire  _GEN_14; // @[Conditional.scala 39:67:@682.8]
  wire  _GEN_16; // @[Conditional.scala 39:67:@654.6]
  wire  _GEN_17; // @[Conditional.scala 39:67:@654.6]
  wire [1:0] _GEN_18; // @[Conditional.scala 39:67:@654.6]
  wire [31:0] _GEN_19; // @[Conditional.scala 39:67:@654.6]
  wire [31:0] _GEN_20; // @[Conditional.scala 39:67:@654.6]
  wire  _GEN_22; // @[Conditional.scala 39:67:@654.6]
  wire  _GEN_23; // @[Conditional.scala 39:67:@654.6]
  wire  _GEN_24; // @[Conditional.scala 40:58:@643.4]
  wire [31:0] _GEN_26; // @[Conditional.scala 40:58:@643.4]
  wire  _GEN_27; // @[Conditional.scala 40:58:@643.4]
  wire [1:0] _GEN_28; // @[Conditional.scala 40:58:@643.4]
  wire  _GEN_30; // @[Conditional.scala 40:58:@643.4]
  wire  _GEN_31; // @[Conditional.scala 40:58:@643.4]
  wire [31:0] _GEN_32; // @[Conditional.scala 40:58:@643.4]
  assign _T_66 = 2'h0 == _T_65; // @[Conditional.scala 37:30:@642.4]
  assign _GEN_1 = io_xferIn_valid ? io_xferIn_length : _T_45; // @[TransferSplitter.scala 59:31:@645.6]
  assign _GEN_2 = io_xferIn_valid ? io_xferIn_first : _T_54; // @[TransferSplitter.scala 59:31:@645.6]
  assign _GEN_3 = io_xferIn_valid ? 2'h1 : _T_65; // @[TransferSplitter.scala 59:31:@645.6]
  assign _T_68 = 2'h1 == _T_65; // @[Conditional.scala 37:30:@653.6]
  assign _T_71 = _T_45 > 32'h100; // @[TransferSplitter.scala 72:23:@659.8]
  assign _T_74 = _T_45 - 32'h100; // @[TransferSplitter.scala 75:34:@662.10]
  assign _T_75 = $unsigned(_T_74); // @[TransferSplitter.scala 75:34:@663.10]
  assign _T_76 = _T_75[31:0]; // @[TransferSplitter.scala 75:34:@664.10]
  assign _GEN_4 = _T_71 ? 32'h100 : _T_45; // @[TransferSplitter.scala 72:38:@660.8]
  assign _GEN_5 = _T_71 ? _T_76 : 32'h0; // @[TransferSplitter.scala 72:38:@660.8]
  assign _T_87 = 2'h2 == _T_65; // @[Conditional.scala 37:30:@681.8]
  assign _T_91 = _T_45 > 32'h0; // @[TransferSplitter.scala 113:25:@686.12]
  assign _GEN_7 = _T_91 ? 2'h1 : 2'h0; // @[TransferSplitter.scala 113:32:@687.12]
  assign _GEN_8 = _T_91 ? _T_60 : 1'h1; // @[TransferSplitter.scala 113:32:@687.12]
  assign _GEN_9 = io_xferOut_done ? _GEN_7 : _T_65; // @[TransferSplitter.scala 112:31:@685.10]
  assign _GEN_10 = io_xferOut_done ? _GEN_8 : _T_60; // @[TransferSplitter.scala 112:31:@685.10]
  assign _GEN_11 = _T_87 ? 1'h0 : _T_63; // @[Conditional.scala 39:67:@682.8]
  assign _GEN_12 = _T_87 ? 1'h0 : _T_54; // @[Conditional.scala 39:67:@682.8]
  assign _GEN_13 = _T_87 ? _GEN_9 : _T_65; // @[Conditional.scala 39:67:@682.8]
  assign _GEN_14 = _T_87 ? _GEN_10 : _T_60; // @[Conditional.scala 39:67:@682.8]
  assign _GEN_16 = _T_68 ? _T_54 : _T_57; // @[Conditional.scala 39:67:@654.6]
  assign _GEN_17 = _T_68 ? 1'h1 : _GEN_11; // @[Conditional.scala 39:67:@654.6]
  assign _GEN_18 = _T_68 ? 2'h2 : _GEN_13; // @[Conditional.scala 39:67:@654.6]
  assign _GEN_19 = _T_68 ? _GEN_4 : _T_51; // @[Conditional.scala 39:67:@654.6]
  assign _GEN_20 = _T_68 ? _GEN_5 : _T_45; // @[Conditional.scala 39:67:@654.6]
  assign _GEN_22 = _T_68 ? _T_54 : _GEN_12; // @[Conditional.scala 39:67:@654.6]
  assign _GEN_23 = _T_68 ? _T_60 : _GEN_14; // @[Conditional.scala 39:67:@654.6]
  assign _GEN_24 = _T_66 ? 1'h0 : _GEN_23; // @[Conditional.scala 40:58:@643.4]
  assign _GEN_26 = _T_66 ? _GEN_1 : _GEN_20; // @[Conditional.scala 40:58:@643.4]
  assign _GEN_27 = _T_66 ? _GEN_2 : _GEN_22; // @[Conditional.scala 40:58:@643.4]
  assign _GEN_28 = _T_66 ? _GEN_3 : _GEN_18; // @[Conditional.scala 40:58:@643.4]
  assign _GEN_30 = _T_66 ? _T_57 : _GEN_16; // @[Conditional.scala 40:58:@643.4]
  assign _GEN_31 = _T_66 ? _T_63 : _GEN_17; // @[Conditional.scala 40:58:@643.4]
  assign _GEN_32 = _T_66 ? _T_51 : _GEN_19; // @[Conditional.scala 40:58:@643.4]
  assign io_xferIn_done = _T_60; // @[TransferSplitter.scala 48:20:@637.4]
  assign io_xferOut_length = _T_51; // @[TransferSplitter.scala 53:23:@641.4]
  assign io_xferOut_valid = _T_63; // @[TransferSplitter.scala 49:22:@638.4]
  assign io_xferOut_first = _T_57; // @[TransferSplitter.scala 51:22:@639.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T_45 = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  _T_51 = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_54 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  _T_57 = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  _T_60 = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_63 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  _T_65 = _RAND_6[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      _T_45 <= 32'h0;
    end else begin
      if (_T_66) begin
        if (io_xferIn_valid) begin
          _T_45 <= io_xferIn_length;
        end
      end else begin
        if (_T_68) begin
          if (_T_71) begin
            _T_45 <= _T_76;
          end else begin
            _T_45 <= 32'h0;
          end
        end
      end
    end
    if (reset) begin
      _T_51 <= 32'h0;
    end else begin
      if (!(_T_66)) begin
        if (_T_68) begin
          if (_T_71) begin
            _T_51 <= 32'h100;
          end else begin
            _T_51 <= _T_45;
          end
        end
      end
    end
    if (reset) begin
      _T_54 <= 1'h0;
    end else begin
      if (_T_66) begin
        if (io_xferIn_valid) begin
          _T_54 <= io_xferIn_first;
        end
      end else begin
        if (!(_T_68)) begin
          if (_T_87) begin
            _T_54 <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      _T_57 <= 1'h0;
    end else begin
      if (!(_T_66)) begin
        if (_T_68) begin
          _T_57 <= _T_54;
        end
      end
    end
    if (reset) begin
      _T_60 <= 1'h0;
    end else begin
      if (_T_66) begin
        _T_60 <= 1'h0;
      end else begin
        if (!(_T_68)) begin
          if (_T_87) begin
            if (io_xferOut_done) begin
              if (!(_T_91)) begin
                _T_60 <= 1'h1;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      _T_63 <= 1'h0;
    end else begin
      if (!(_T_66)) begin
        if (_T_68) begin
          _T_63 <= 1'h1;
        end else begin
          if (_T_87) begin
            _T_63 <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      _T_65 <= 2'h0;
    end else begin
      if (_T_66) begin
        if (io_xferIn_valid) begin
          _T_65 <= 2'h1;
        end
      end else begin
        if (_T_68) begin
          _T_65 <= 2'h2;
        end else begin
          if (_T_87) begin
            if (io_xferOut_done) begin
              if (_T_91) begin
                _T_65 <= 2'h1;
              end else begin
                _T_65 <= 2'h0;
              end
            end
          end
        end
      end
    end
  end
endmodule
module AXIS_to_AXIS_ClearCSR( // @[:@697.2]
  input         clock, // @[:@698.4]
  input         reset, // @[:@699.4]
  input  [31:0] io_csr_dataOut, // @[:@700.4]
  input         io_csr_dataWrite, // @[:@700.4]
  output [31:0] io_csr_dataIn, // @[:@700.4]
  output [31:0] io_value, // @[:@700.4]
  input  [31:0] io_clear // @[:@700.4]
);
  reg [31:0] reg$; // @[ClearCSR.scala 27:20:@702.4]
  reg [31:0] _RAND_0;
  wire [31:0] _T_29; // @[ClearCSR.scala 35:19:@709.6]
  wire [31:0] _T_30; // @[ClearCSR.scala 35:16:@710.6]
  wire [31:0] _GEN_0; // @[ClearCSR.scala 32:25:@705.4]
  assign _T_29 = ~ io_clear; // @[ClearCSR.scala 35:19:@709.6]
  assign _T_30 = reg$ & _T_29; // @[ClearCSR.scala 35:16:@710.6]
  assign _GEN_0 = io_csr_dataWrite ? io_csr_dataOut : _T_30; // @[ClearCSR.scala 32:25:@705.4]
  assign io_csr_dataIn = reg$; // @[ClearCSR.scala 29:17:@703.4]
  assign io_value = reg$; // @[ClearCSR.scala 30:12:@704.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reg$ <= 32'h0;
    end else begin
      if (io_csr_dataWrite) begin
        reg$ <= io_csr_dataOut;
      end else begin
        reg$ <= _T_30;
      end
    end
  end
endmodule
module AXIS_to_AXIS_StatusCSR( // @[:@714.2]
  input         clock, // @[:@715.4]
  output [31:0] io_csr_dataIn, // @[:@717.4]
  input  [31:0] io_value // @[:@717.4]
);
  reg [31:0] reg$; // @[StatusCSR.scala 26:20:@719.4]
  reg [31:0] _RAND_0;
  assign io_csr_dataIn = reg$; // @[StatusCSR.scala 28:17:@721.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    reg$ <= io_value;
  end
endmodule
module AXIS_to_AXIS_SimpleCSR( // @[:@723.2]
  input         clock, // @[:@724.4]
  input         reset, // @[:@725.4]
  input  [31:0] io_csr_dataOut, // @[:@726.4]
  input         io_csr_dataWrite, // @[:@726.4]
  output [31:0] io_csr_dataIn, // @[:@726.4]
  output [31:0] io_value // @[:@726.4]
);
  reg [31:0] reg$; // @[SimpleCSR.scala 26:20:@728.4]
  reg [31:0] _RAND_0;
  wire [31:0] _GEN_0; // @[SimpleCSR.scala 31:25:@731.4]
  assign _GEN_0 = io_csr_dataWrite ? io_csr_dataOut : reg$; // @[SimpleCSR.scala 31:25:@731.4]
  assign io_csr_dataIn = reg$; // @[SimpleCSR.scala 28:17:@729.4]
  assign io_value = reg$; // @[SimpleCSR.scala 29:12:@730.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reg$ <= 32'h0;
    end else begin
      if (io_csr_dataWrite) begin
        reg$ <= io_csr_dataOut;
      end
    end
  end
endmodule
module AXIS_to_AXIS_SetCSR( // @[:@735.2]
  input         clock, // @[:@736.4]
  input         reset, // @[:@737.4]
  input  [31:0] io_csr_dataOut, // @[:@738.4]
  input         io_csr_dataWrite, // @[:@738.4]
  output [31:0] io_csr_dataIn, // @[:@738.4]
  output [31:0] io_value, // @[:@738.4]
  input  [31:0] io_set // @[:@738.4]
);
  reg [31:0] reg$; // @[SetCSR.scala 27:20:@740.4]
  reg [31:0] _RAND_0;
  wire [31:0] _T_29; // @[SetCSR.scala 33:20:@744.6]
  wire [31:0] _T_30; // @[SetCSR.scala 33:17:@745.6]
  wire [31:0] _T_31; // @[SetCSR.scala 33:45:@746.6]
  wire [31:0] _T_32; // @[SetCSR.scala 35:16:@750.6]
  wire [31:0] _GEN_0; // @[SetCSR.scala 32:25:@743.4]
  assign _T_29 = ~ io_csr_dataOut; // @[SetCSR.scala 33:20:@744.6]
  assign _T_30 = reg$ & _T_29; // @[SetCSR.scala 33:17:@745.6]
  assign _T_31 = _T_30 | io_set; // @[SetCSR.scala 33:45:@746.6]
  assign _T_32 = reg$ | io_set; // @[SetCSR.scala 35:16:@750.6]
  assign _GEN_0 = io_csr_dataWrite ? _T_31 : _T_32; // @[SetCSR.scala 32:25:@743.4]
  assign io_csr_dataIn = reg$; // @[SetCSR.scala 29:17:@741.4]
  assign io_value = reg$; // @[SetCSR.scala 30:12:@742.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reg$ <= 32'h0;
    end else begin
      if (io_csr_dataWrite) begin
        reg$ <= _T_31;
      end else begin
        reg$ <= _T_32;
      end
    end
  end
endmodule
module AXIS_to_AXIS_InterruptController( // @[:@754.2]
  input         clock, // @[:@755.4]
  input         reset, // @[:@756.4]
  output        io_irq_readerDone, // @[:@757.4]
  output        io_irq_writerDone, // @[:@757.4]
  input         io_readBusy, // @[:@757.4]
  input         io_writeBusy, // @[:@757.4]
  input  [31:0] io_imr_dataOut, // @[:@757.4]
  input         io_imr_dataWrite, // @[:@757.4]
  output [31:0] io_imr_dataIn, // @[:@757.4]
  input  [31:0] io_isr_dataOut, // @[:@757.4]
  input         io_isr_dataWrite, // @[:@757.4]
  output [31:0] io_isr_dataIn // @[:@757.4]
);
  wire  SimpleCSR_clock; // @[SimpleCSR.scala 39:21:@759.4]
  wire  SimpleCSR_reset; // @[SimpleCSR.scala 39:21:@759.4]
  wire [31:0] SimpleCSR_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@759.4]
  wire  SimpleCSR_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@759.4]
  wire [31:0] SimpleCSR_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@759.4]
  wire [31:0] SimpleCSR_io_value; // @[SimpleCSR.scala 39:21:@759.4]
  wire  SetCSR_clock; // @[SetCSR.scala 42:21:@791.4]
  wire  SetCSR_reset; // @[SetCSR.scala 42:21:@791.4]
  wire [31:0] SetCSR_io_csr_dataOut; // @[SetCSR.scala 42:21:@791.4]
  wire  SetCSR_io_csr_dataWrite; // @[SetCSR.scala 42:21:@791.4]
  wire [31:0] SetCSR_io_csr_dataIn; // @[SetCSR.scala 42:21:@791.4]
  wire [31:0] SetCSR_io_value; // @[SetCSR.scala 42:21:@791.4]
  wire [31:0] SetCSR_io_set; // @[SetCSR.scala 42:21:@791.4]
  reg  readBusy; // @[InterruptController.scala 32:25:@768.4]
  reg [31:0] _RAND_0;
  reg  readBusyOld; // @[InterruptController.scala 33:28:@770.4]
  reg [31:0] _RAND_1;
  reg  writeBusy; // @[InterruptController.scala 35:26:@772.4]
  reg [31:0] _RAND_2;
  reg  writeBusyOld; // @[InterruptController.scala 36:29:@774.4]
  reg [31:0] _RAND_3;
  reg  writeBusyIrq; // @[InterruptController.scala 38:29:@776.4]
  reg [31:0] _RAND_4;
  reg  readBusyIrq; // @[InterruptController.scala 39:28:@777.4]
  reg [31:0] _RAND_5;
  wire  _T_59; // @[InterruptController.scala 41:35:@778.4]
  wire  _T_60; // @[InterruptController.scala 41:32:@779.4]
  wire [31:0] mask; // @[:@766.4 :@767.4]
  wire  _T_61; // @[InterruptController.scala 41:53:@780.4]
  wire  _T_62; // @[InterruptController.scala 41:46:@781.4]
  wire  _T_64; // @[InterruptController.scala 42:33:@783.4]
  wire  _T_65; // @[InterruptController.scala 42:30:@784.4]
  wire  _T_66; // @[InterruptController.scala 42:50:@785.4]
  wire  _T_67; // @[InterruptController.scala 42:43:@786.4]
  wire [1:0] irq; // @[Cat.scala 30:58:@788.4]
  wire [31:0] isr; // @[:@799.4 :@800.4]
  AXIS_to_AXIS_SimpleCSR SimpleCSR ( // @[SimpleCSR.scala 39:21:@759.4]
    .clock(SimpleCSR_clock),
    .reset(SimpleCSR_reset),
    .io_csr_dataOut(SimpleCSR_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_io_csr_dataIn),
    .io_value(SimpleCSR_io_value)
  );
  AXIS_to_AXIS_SetCSR SetCSR ( // @[SetCSR.scala 42:21:@791.4]
    .clock(SetCSR_clock),
    .reset(SetCSR_reset),
    .io_csr_dataOut(SetCSR_io_csr_dataOut),
    .io_csr_dataWrite(SetCSR_io_csr_dataWrite),
    .io_csr_dataIn(SetCSR_io_csr_dataIn),
    .io_value(SetCSR_io_value),
    .io_set(SetCSR_io_set)
  );
  assign _T_59 = writeBusy == 1'h0; // @[InterruptController.scala 41:35:@778.4]
  assign _T_60 = writeBusyOld & _T_59; // @[InterruptController.scala 41:32:@779.4]
  assign mask = SimpleCSR_io_value; // @[:@766.4 :@767.4]
  assign _T_61 = mask[0]; // @[InterruptController.scala 41:53:@780.4]
  assign _T_62 = _T_60 & _T_61; // @[InterruptController.scala 41:46:@781.4]
  assign _T_64 = readBusy == 1'h0; // @[InterruptController.scala 42:33:@783.4]
  assign _T_65 = readBusyOld & _T_64; // @[InterruptController.scala 42:30:@784.4]
  assign _T_66 = mask[1]; // @[InterruptController.scala 42:50:@785.4]
  assign _T_67 = _T_65 & _T_66; // @[InterruptController.scala 42:43:@786.4]
  assign irq = {readBusyIrq,writeBusyIrq}; // @[Cat.scala 30:58:@788.4]
  assign isr = SetCSR_io_value; // @[:@799.4 :@800.4]
  assign io_irq_readerDone = isr[1]; // @[InterruptController.scala 49:21:@804.4]
  assign io_irq_writerDone = isr[0]; // @[InterruptController.scala 48:21:@802.4]
  assign io_imr_dataIn = SimpleCSR_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@762.4]
  assign io_isr_dataIn = SetCSR_io_csr_dataIn; // @[SetCSR.scala 46:16:@795.4]
  assign SimpleCSR_clock = clock; // @[:@760.4]
  assign SimpleCSR_reset = reset; // @[:@761.4]
  assign SimpleCSR_io_csr_dataOut = io_imr_dataOut; // @[SimpleCSR.scala 41:16:@764.4]
  assign SimpleCSR_io_csr_dataWrite = io_imr_dataWrite; // @[SimpleCSR.scala 41:16:@763.4]
  assign SetCSR_clock = clock; // @[:@792.4]
  assign SetCSR_reset = reset; // @[:@793.4]
  assign SetCSR_io_csr_dataOut = io_isr_dataOut; // @[SetCSR.scala 46:16:@797.4]
  assign SetCSR_io_csr_dataWrite = io_isr_dataWrite; // @[SetCSR.scala 46:16:@796.4]
  assign SetCSR_io_set = {{30'd0}, irq}; // @[SetCSR.scala 44:16:@794.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  readBusy = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  readBusyOld = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  writeBusy = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  writeBusyOld = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  writeBusyIrq = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  readBusyIrq = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    readBusy <= io_readBusy;
    readBusyOld <= readBusy;
    writeBusy <= io_writeBusy;
    writeBusyOld <= writeBusy;
    if (reset) begin
      writeBusyIrq <= 1'h0;
    end else begin
      writeBusyIrq <= _T_62;
    end
    if (reset) begin
      readBusyIrq <= 1'h0;
    end else begin
      readBusyIrq <= _T_67;
    end
  end
endmodule
module AXIS_to_AXIS_WorkerCSRWrapper( // @[:@944.2]
  input         clock, // @[:@945.4]
  input         reset, // @[:@946.4]
  input  [31:0] io_csr_0_dataOut, // @[:@947.4]
  input         io_csr_0_dataWrite, // @[:@947.4]
  output [31:0] io_csr_0_dataIn, // @[:@947.4]
  output [31:0] io_csr_1_dataIn, // @[:@947.4]
  input  [31:0] io_csr_2_dataOut, // @[:@947.4]
  input         io_csr_2_dataWrite, // @[:@947.4]
  output [31:0] io_csr_2_dataIn, // @[:@947.4]
  input  [31:0] io_csr_3_dataOut, // @[:@947.4]
  input         io_csr_3_dataWrite, // @[:@947.4]
  output [31:0] io_csr_3_dataIn, // @[:@947.4]
  input  [31:0] io_csr_4_dataOut, // @[:@947.4]
  input         io_csr_4_dataWrite, // @[:@947.4]
  output [31:0] io_csr_4_dataIn, // @[:@947.4]
  input  [31:0] io_csr_5_dataOut, // @[:@947.4]
  input         io_csr_5_dataWrite, // @[:@947.4]
  output [31:0] io_csr_5_dataIn, // @[:@947.4]
  input  [31:0] io_csr_6_dataOut, // @[:@947.4]
  input         io_csr_6_dataWrite, // @[:@947.4]
  output [31:0] io_csr_6_dataIn, // @[:@947.4]
  input  [31:0] io_csr_7_dataOut, // @[:@947.4]
  input         io_csr_7_dataWrite, // @[:@947.4]
  output [31:0] io_csr_7_dataIn, // @[:@947.4]
  input  [31:0] io_csr_8_dataOut, // @[:@947.4]
  input         io_csr_8_dataWrite, // @[:@947.4]
  output [31:0] io_csr_8_dataIn, // @[:@947.4]
  input  [31:0] io_csr_9_dataOut, // @[:@947.4]
  input         io_csr_9_dataWrite, // @[:@947.4]
  output [31:0] io_csr_9_dataIn, // @[:@947.4]
  input  [31:0] io_csr_10_dataOut, // @[:@947.4]
  input         io_csr_10_dataWrite, // @[:@947.4]
  output [31:0] io_csr_10_dataIn, // @[:@947.4]
  input  [31:0] io_csr_11_dataOut, // @[:@947.4]
  input         io_csr_11_dataWrite, // @[:@947.4]
  output [31:0] io_csr_11_dataIn, // @[:@947.4]
  output [31:0] io_csr_12_dataIn, // @[:@947.4]
  output [31:0] io_csr_13_dataIn, // @[:@947.4]
  input  [31:0] io_csr_14_dataOut, // @[:@947.4]
  input         io_csr_14_dataWrite, // @[:@947.4]
  output [31:0] io_csr_14_dataIn, // @[:@947.4]
  input  [31:0] io_csr_15_dataOut, // @[:@947.4]
  input         io_csr_15_dataWrite, // @[:@947.4]
  output [31:0] io_csr_15_dataIn, // @[:@947.4]
  output        io_irq_readerDone, // @[:@947.4]
  output        io_irq_writerDone, // @[:@947.4]
  input         io_sync_readerSync, // @[:@947.4]
  input         io_sync_writerSync, // @[:@947.4]
  input         io_xferRead_done, // @[:@947.4]
  output [31:0] io_xferRead_length, // @[:@947.4]
  output        io_xferRead_valid, // @[:@947.4]
  input         io_xferWrite_done, // @[:@947.4]
  output [31:0] io_xferWrite_length, // @[:@947.4]
  output        io_xferWrite_valid, // @[:@947.4]
  output        io_xferWrite_first // @[:@947.4]
);
  wire  addressGeneratorRead_clock; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire  addressGeneratorRead_reset; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire  addressGeneratorRead_io_ctl_start; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire  addressGeneratorRead_io_ctl_busy; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire [31:0] addressGeneratorRead_io_ctl_lineLength; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire [31:0] addressGeneratorRead_io_ctl_lineCount; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire  addressGeneratorRead_io_xfer_done; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire [31:0] addressGeneratorRead_io_xfer_length; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire  addressGeneratorRead_io_xfer_valid; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire  addressGeneratorRead_io_xfer_first; // @[WorkerCSRWrapper.scala 32:36:@949.4]
  wire  transferSplitterRead_io_xferIn_done; // @[WorkerCSRWrapper.scala 33:36:@952.4]
  wire [31:0] transferSplitterRead_io_xferIn_length; // @[WorkerCSRWrapper.scala 33:36:@952.4]
  wire  transferSplitterRead_io_xferIn_valid; // @[WorkerCSRWrapper.scala 33:36:@952.4]
  wire  transferSplitterRead_io_xferOut_done; // @[WorkerCSRWrapper.scala 33:36:@952.4]
  wire [31:0] transferSplitterRead_io_xferOut_length; // @[WorkerCSRWrapper.scala 33:36:@952.4]
  wire  transferSplitterRead_io_xferOut_valid; // @[WorkerCSRWrapper.scala 33:36:@952.4]
  wire  addressGeneratorWrite_clock; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire  addressGeneratorWrite_reset; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire  addressGeneratorWrite_io_ctl_start; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire  addressGeneratorWrite_io_ctl_busy; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire [31:0] addressGeneratorWrite_io_ctl_lineLength; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire [31:0] addressGeneratorWrite_io_ctl_lineCount; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire  addressGeneratorWrite_io_xfer_done; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire [31:0] addressGeneratorWrite_io_xfer_length; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire  addressGeneratorWrite_io_xfer_valid; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire  addressGeneratorWrite_io_xfer_first; // @[WorkerCSRWrapper.scala 35:37:@955.4]
  wire  transferSplitterWrite_clock; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire  transferSplitterWrite_reset; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire  transferSplitterWrite_io_xferIn_done; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire [31:0] transferSplitterWrite_io_xferIn_length; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire  transferSplitterWrite_io_xferIn_valid; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire  transferSplitterWrite_io_xferIn_first; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire  transferSplitterWrite_io_xferOut_done; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire [31:0] transferSplitterWrite_io_xferOut_length; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire  transferSplitterWrite_io_xferOut_valid; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire  transferSplitterWrite_io_xferOut_first; // @[WorkerCSRWrapper.scala 36:37:@958.4]
  wire  ClearCSR_clock; // @[ClearCSR.scala 41:21:@978.4]
  wire  ClearCSR_reset; // @[ClearCSR.scala 41:21:@978.4]
  wire [31:0] ClearCSR_io_csr_dataOut; // @[ClearCSR.scala 41:21:@978.4]
  wire  ClearCSR_io_csr_dataWrite; // @[ClearCSR.scala 41:21:@978.4]
  wire [31:0] ClearCSR_io_csr_dataIn; // @[ClearCSR.scala 41:21:@978.4]
  wire [31:0] ClearCSR_io_value; // @[ClearCSR.scala 41:21:@978.4]
  wire [31:0] ClearCSR_io_clear; // @[ClearCSR.scala 41:21:@978.4]
  wire  StatusCSR_clock; // @[StatusCSR.scala 33:21:@987.4]
  wire [31:0] StatusCSR_io_csr_dataIn; // @[StatusCSR.scala 33:21:@987.4]
  wire [31:0] StatusCSR_io_value; // @[StatusCSR.scala 33:21:@987.4]
  wire  InterruptController_clock; // @[InterruptController.scala 54:22:@995.4]
  wire  InterruptController_reset; // @[InterruptController.scala 54:22:@995.4]
  wire  InterruptController_io_irq_readerDone; // @[InterruptController.scala 54:22:@995.4]
  wire  InterruptController_io_irq_writerDone; // @[InterruptController.scala 54:22:@995.4]
  wire  InterruptController_io_readBusy; // @[InterruptController.scala 54:22:@995.4]
  wire  InterruptController_io_writeBusy; // @[InterruptController.scala 54:22:@995.4]
  wire [31:0] InterruptController_io_imr_dataOut; // @[InterruptController.scala 54:22:@995.4]
  wire  InterruptController_io_imr_dataWrite; // @[InterruptController.scala 54:22:@995.4]
  wire [31:0] InterruptController_io_imr_dataIn; // @[InterruptController.scala 54:22:@995.4]
  wire [31:0] InterruptController_io_isr_dataOut; // @[InterruptController.scala 54:22:@995.4]
  wire  InterruptController_io_isr_dataWrite; // @[InterruptController.scala 54:22:@995.4]
  wire [31:0] InterruptController_io_isr_dataIn; // @[InterruptController.scala 54:22:@995.4]
  wire  SimpleCSR_clock; // @[SimpleCSR.scala 39:21:@1032.4]
  wire  SimpleCSR_reset; // @[SimpleCSR.scala 39:21:@1032.4]
  wire [31:0] SimpleCSR_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1032.4]
  wire  SimpleCSR_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1032.4]
  wire [31:0] SimpleCSR_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1032.4]
  wire [31:0] SimpleCSR_io_value; // @[SimpleCSR.scala 39:21:@1032.4]
  wire  SimpleCSR_1_clock; // @[SimpleCSR.scala 39:21:@1040.4]
  wire  SimpleCSR_1_reset; // @[SimpleCSR.scala 39:21:@1040.4]
  wire [31:0] SimpleCSR_1_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1040.4]
  wire  SimpleCSR_1_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1040.4]
  wire [31:0] SimpleCSR_1_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1040.4]
  wire [31:0] SimpleCSR_1_io_value; // @[SimpleCSR.scala 39:21:@1040.4]
  wire  SimpleCSR_2_clock; // @[SimpleCSR.scala 39:21:@1048.4]
  wire  SimpleCSR_2_reset; // @[SimpleCSR.scala 39:21:@1048.4]
  wire [31:0] SimpleCSR_2_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1048.4]
  wire  SimpleCSR_2_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1048.4]
  wire [31:0] SimpleCSR_2_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1048.4]
  wire [31:0] SimpleCSR_2_io_value; // @[SimpleCSR.scala 39:21:@1048.4]
  wire  SimpleCSR_3_clock; // @[SimpleCSR.scala 39:21:@1056.4]
  wire  SimpleCSR_3_reset; // @[SimpleCSR.scala 39:21:@1056.4]
  wire [31:0] SimpleCSR_3_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1056.4]
  wire  SimpleCSR_3_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1056.4]
  wire [31:0] SimpleCSR_3_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1056.4]
  wire [31:0] SimpleCSR_3_io_value; // @[SimpleCSR.scala 39:21:@1056.4]
  wire  SimpleCSR_4_clock; // @[SimpleCSR.scala 39:21:@1065.4]
  wire  SimpleCSR_4_reset; // @[SimpleCSR.scala 39:21:@1065.4]
  wire [31:0] SimpleCSR_4_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1065.4]
  wire  SimpleCSR_4_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1065.4]
  wire [31:0] SimpleCSR_4_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1065.4]
  wire [31:0] SimpleCSR_4_io_value; // @[SimpleCSR.scala 39:21:@1065.4]
  wire  SimpleCSR_5_clock; // @[SimpleCSR.scala 39:21:@1073.4]
  wire  SimpleCSR_5_reset; // @[SimpleCSR.scala 39:21:@1073.4]
  wire [31:0] SimpleCSR_5_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1073.4]
  wire  SimpleCSR_5_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1073.4]
  wire [31:0] SimpleCSR_5_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1073.4]
  wire [31:0] SimpleCSR_5_io_value; // @[SimpleCSR.scala 39:21:@1073.4]
  wire  SimpleCSR_6_clock; // @[SimpleCSR.scala 39:21:@1081.4]
  wire  SimpleCSR_6_reset; // @[SimpleCSR.scala 39:21:@1081.4]
  wire [31:0] SimpleCSR_6_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1081.4]
  wire  SimpleCSR_6_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1081.4]
  wire [31:0] SimpleCSR_6_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1081.4]
  wire [31:0] SimpleCSR_6_io_value; // @[SimpleCSR.scala 39:21:@1081.4]
  wire  SimpleCSR_7_clock; // @[SimpleCSR.scala 39:21:@1089.4]
  wire  SimpleCSR_7_reset; // @[SimpleCSR.scala 39:21:@1089.4]
  wire [31:0] SimpleCSR_7_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1089.4]
  wire  SimpleCSR_7_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1089.4]
  wire [31:0] SimpleCSR_7_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1089.4]
  wire [31:0] SimpleCSR_7_io_value; // @[SimpleCSR.scala 39:21:@1089.4]
  wire  StatusCSR_1_clock; // @[StatusCSR.scala 33:21:@1097.4]
  wire [31:0] StatusCSR_1_io_csr_dataIn; // @[StatusCSR.scala 33:21:@1097.4]
  wire [31:0] StatusCSR_1_io_value; // @[StatusCSR.scala 33:21:@1097.4]
  wire  StatusCSR_2_clock; // @[StatusCSR.scala 33:21:@1105.4]
  wire [31:0] StatusCSR_2_io_csr_dataIn; // @[StatusCSR.scala 33:21:@1105.4]
  wire [31:0] StatusCSR_2_io_value; // @[StatusCSR.scala 33:21:@1105.4]
  wire  SimpleCSR_8_clock; // @[SimpleCSR.scala 39:21:@1113.4]
  wire  SimpleCSR_8_reset; // @[SimpleCSR.scala 39:21:@1113.4]
  wire [31:0] SimpleCSR_8_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1113.4]
  wire  SimpleCSR_8_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1113.4]
  wire [31:0] SimpleCSR_8_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1113.4]
  wire [31:0] SimpleCSR_8_io_value; // @[SimpleCSR.scala 39:21:@1113.4]
  wire  SimpleCSR_9_clock; // @[SimpleCSR.scala 39:21:@1120.4]
  wire  SimpleCSR_9_reset; // @[SimpleCSR.scala 39:21:@1120.4]
  wire [31:0] SimpleCSR_9_io_csr_dataOut; // @[SimpleCSR.scala 39:21:@1120.4]
  wire  SimpleCSR_9_io_csr_dataWrite; // @[SimpleCSR.scala 39:21:@1120.4]
  wire [31:0] SimpleCSR_9_io_csr_dataIn; // @[SimpleCSR.scala 39:21:@1120.4]
  wire [31:0] SimpleCSR_9_io_value; // @[SimpleCSR.scala 39:21:@1120.4]
  reg [1:0] status; // @[WorkerCSRWrapper.scala 38:23:@962.4]
  reg [31:0] _RAND_0;
  reg  readerSync; // @[WorkerCSRWrapper.scala 40:27:@964.4]
  reg [31:0] _RAND_1;
  reg  readerSyncOld; // @[WorkerCSRWrapper.scala 41:30:@966.4]
  reg [31:0] _RAND_2;
  reg  writerSync; // @[WorkerCSRWrapper.scala 43:27:@968.4]
  reg [31:0] _RAND_3;
  reg  writerSyncOld; // @[WorkerCSRWrapper.scala 44:30:@970.4]
  reg [31:0] _RAND_4;
  reg  readerStart; // @[WorkerCSRWrapper.scala 46:28:@972.4]
  reg [31:0] _RAND_5;
  reg  writerStart; // @[WorkerCSRWrapper.scala 47:28:@973.4]
  reg [31:0] _RAND_6;
  wire [1:0] _T_207; // @[Cat.scala 30:58:@1010.4]
  wire [31:0] control; // @[WorkerCSRWrapper.scala 49:21:@974.4 WorkerCSRWrapper.scala 58:11:@986.4]
  wire  _T_208; // @[WorkerCSRWrapper.scala 65:56:@1011.4]
  wire  _T_209; // @[WorkerCSRWrapper.scala 65:68:@1012.4]
  wire [1:0] _T_210; // @[Cat.scala 30:58:@1013.4]
  wire [1:0] _T_211; // @[WorkerCSRWrapper.scala 65:44:@1014.4]
  wire [1:0] clear; // @[WorkerCSRWrapper.scala 65:42:@1015.4]
  wire  _T_214; // @[WorkerCSRWrapper.scala 67:20:@1017.4]
  wire  _T_215; // @[WorkerCSRWrapper.scala 67:35:@1018.4]
  wire  _T_216; // @[WorkerCSRWrapper.scala 67:60:@1019.4]
  wire  _T_217; // @[WorkerCSRWrapper.scala 67:50:@1020.4]
  wire  _T_218; // @[WorkerCSRWrapper.scala 67:75:@1021.4]
  wire  _T_219; // @[WorkerCSRWrapper.scala 67:65:@1022.4]
  wire  _T_221; // @[WorkerCSRWrapper.scala 68:20:@1024.4]
  wire  _T_222; // @[WorkerCSRWrapper.scala 68:35:@1025.4]
  wire  _T_223; // @[WorkerCSRWrapper.scala 68:60:@1026.4]
  wire  _T_224; // @[WorkerCSRWrapper.scala 68:50:@1027.4]
  wire  _T_225; // @[WorkerCSRWrapper.scala 68:75:@1028.4]
  wire  _T_226; // @[WorkerCSRWrapper.scala 68:65:@1029.4]
  AXIS_to_AXIS_AddressGenerator addressGeneratorRead ( // @[WorkerCSRWrapper.scala 32:36:@949.4]
    .clock(addressGeneratorRead_clock),
    .reset(addressGeneratorRead_reset),
    .io_ctl_start(addressGeneratorRead_io_ctl_start),
    .io_ctl_busy(addressGeneratorRead_io_ctl_busy),
    .io_ctl_lineLength(addressGeneratorRead_io_ctl_lineLength),
    .io_ctl_lineCount(addressGeneratorRead_io_ctl_lineCount),
    .io_xfer_done(addressGeneratorRead_io_xfer_done),
    .io_xfer_length(addressGeneratorRead_io_xfer_length),
    .io_xfer_valid(addressGeneratorRead_io_xfer_valid),
    .io_xfer_first(addressGeneratorRead_io_xfer_first)
  );
  AXIS_to_AXIS_TransferSplitter transferSplitterRead ( // @[WorkerCSRWrapper.scala 33:36:@952.4]
    .io_xferIn_done(transferSplitterRead_io_xferIn_done),
    .io_xferIn_length(transferSplitterRead_io_xferIn_length),
    .io_xferIn_valid(transferSplitterRead_io_xferIn_valid),
    .io_xferOut_done(transferSplitterRead_io_xferOut_done),
    .io_xferOut_length(transferSplitterRead_io_xferOut_length),
    .io_xferOut_valid(transferSplitterRead_io_xferOut_valid)
  );
  AXIS_to_AXIS_AddressGenerator addressGeneratorWrite ( // @[WorkerCSRWrapper.scala 35:37:@955.4]
    .clock(addressGeneratorWrite_clock),
    .reset(addressGeneratorWrite_reset),
    .io_ctl_start(addressGeneratorWrite_io_ctl_start),
    .io_ctl_busy(addressGeneratorWrite_io_ctl_busy),
    .io_ctl_lineLength(addressGeneratorWrite_io_ctl_lineLength),
    .io_ctl_lineCount(addressGeneratorWrite_io_ctl_lineCount),
    .io_xfer_done(addressGeneratorWrite_io_xfer_done),
    .io_xfer_length(addressGeneratorWrite_io_xfer_length),
    .io_xfer_valid(addressGeneratorWrite_io_xfer_valid),
    .io_xfer_first(addressGeneratorWrite_io_xfer_first)
  );
  AXIS_to_AXIS_TransferSplitter_1 transferSplitterWrite ( // @[WorkerCSRWrapper.scala 36:37:@958.4]
    .clock(transferSplitterWrite_clock),
    .reset(transferSplitterWrite_reset),
    .io_xferIn_done(transferSplitterWrite_io_xferIn_done),
    .io_xferIn_length(transferSplitterWrite_io_xferIn_length),
    .io_xferIn_valid(transferSplitterWrite_io_xferIn_valid),
    .io_xferIn_first(transferSplitterWrite_io_xferIn_first),
    .io_xferOut_done(transferSplitterWrite_io_xferOut_done),
    .io_xferOut_length(transferSplitterWrite_io_xferOut_length),
    .io_xferOut_valid(transferSplitterWrite_io_xferOut_valid),
    .io_xferOut_first(transferSplitterWrite_io_xferOut_first)
  );
  AXIS_to_AXIS_ClearCSR ClearCSR ( // @[ClearCSR.scala 41:21:@978.4]
    .clock(ClearCSR_clock),
    .reset(ClearCSR_reset),
    .io_csr_dataOut(ClearCSR_io_csr_dataOut),
    .io_csr_dataWrite(ClearCSR_io_csr_dataWrite),
    .io_csr_dataIn(ClearCSR_io_csr_dataIn),
    .io_value(ClearCSR_io_value),
    .io_clear(ClearCSR_io_clear)
  );
  AXIS_to_AXIS_StatusCSR StatusCSR ( // @[StatusCSR.scala 33:21:@987.4]
    .clock(StatusCSR_clock),
    .io_csr_dataIn(StatusCSR_io_csr_dataIn),
    .io_value(StatusCSR_io_value)
  );
  AXIS_to_AXIS_InterruptController InterruptController ( // @[InterruptController.scala 54:22:@995.4]
    .clock(InterruptController_clock),
    .reset(InterruptController_reset),
    .io_irq_readerDone(InterruptController_io_irq_readerDone),
    .io_irq_writerDone(InterruptController_io_irq_writerDone),
    .io_readBusy(InterruptController_io_readBusy),
    .io_writeBusy(InterruptController_io_writeBusy),
    .io_imr_dataOut(InterruptController_io_imr_dataOut),
    .io_imr_dataWrite(InterruptController_io_imr_dataWrite),
    .io_imr_dataIn(InterruptController_io_imr_dataIn),
    .io_isr_dataOut(InterruptController_io_isr_dataOut),
    .io_isr_dataWrite(InterruptController_io_isr_dataWrite),
    .io_isr_dataIn(InterruptController_io_isr_dataIn)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR ( // @[SimpleCSR.scala 39:21:@1032.4]
    .clock(SimpleCSR_clock),
    .reset(SimpleCSR_reset),
    .io_csr_dataOut(SimpleCSR_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_io_csr_dataIn),
    .io_value(SimpleCSR_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_1 ( // @[SimpleCSR.scala 39:21:@1040.4]
    .clock(SimpleCSR_1_clock),
    .reset(SimpleCSR_1_reset),
    .io_csr_dataOut(SimpleCSR_1_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_1_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_1_io_csr_dataIn),
    .io_value(SimpleCSR_1_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_2 ( // @[SimpleCSR.scala 39:21:@1048.4]
    .clock(SimpleCSR_2_clock),
    .reset(SimpleCSR_2_reset),
    .io_csr_dataOut(SimpleCSR_2_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_2_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_2_io_csr_dataIn),
    .io_value(SimpleCSR_2_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_3 ( // @[SimpleCSR.scala 39:21:@1056.4]
    .clock(SimpleCSR_3_clock),
    .reset(SimpleCSR_3_reset),
    .io_csr_dataOut(SimpleCSR_3_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_3_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_3_io_csr_dataIn),
    .io_value(SimpleCSR_3_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_4 ( // @[SimpleCSR.scala 39:21:@1065.4]
    .clock(SimpleCSR_4_clock),
    .reset(SimpleCSR_4_reset),
    .io_csr_dataOut(SimpleCSR_4_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_4_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_4_io_csr_dataIn),
    .io_value(SimpleCSR_4_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_5 ( // @[SimpleCSR.scala 39:21:@1073.4]
    .clock(SimpleCSR_5_clock),
    .reset(SimpleCSR_5_reset),
    .io_csr_dataOut(SimpleCSR_5_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_5_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_5_io_csr_dataIn),
    .io_value(SimpleCSR_5_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_6 ( // @[SimpleCSR.scala 39:21:@1081.4]
    .clock(SimpleCSR_6_clock),
    .reset(SimpleCSR_6_reset),
    .io_csr_dataOut(SimpleCSR_6_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_6_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_6_io_csr_dataIn),
    .io_value(SimpleCSR_6_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_7 ( // @[SimpleCSR.scala 39:21:@1089.4]
    .clock(SimpleCSR_7_clock),
    .reset(SimpleCSR_7_reset),
    .io_csr_dataOut(SimpleCSR_7_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_7_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_7_io_csr_dataIn),
    .io_value(SimpleCSR_7_io_value)
  );
  AXIS_to_AXIS_StatusCSR StatusCSR_1 ( // @[StatusCSR.scala 33:21:@1097.4]
    .clock(StatusCSR_1_clock),
    .io_csr_dataIn(StatusCSR_1_io_csr_dataIn),
    .io_value(StatusCSR_1_io_value)
  );
  AXIS_to_AXIS_StatusCSR StatusCSR_2 ( // @[StatusCSR.scala 33:21:@1105.4]
    .clock(StatusCSR_2_clock),
    .io_csr_dataIn(StatusCSR_2_io_csr_dataIn),
    .io_value(StatusCSR_2_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_8 ( // @[SimpleCSR.scala 39:21:@1113.4]
    .clock(SimpleCSR_8_clock),
    .reset(SimpleCSR_8_reset),
    .io_csr_dataOut(SimpleCSR_8_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_8_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_8_io_csr_dataIn),
    .io_value(SimpleCSR_8_io_value)
  );
  AXIS_to_AXIS_SimpleCSR SimpleCSR_9 ( // @[SimpleCSR.scala 39:21:@1120.4]
    .clock(SimpleCSR_9_clock),
    .reset(SimpleCSR_9_reset),
    .io_csr_dataOut(SimpleCSR_9_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_9_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_9_io_csr_dataIn),
    .io_value(SimpleCSR_9_io_value)
  );
  assign _T_207 = {readerStart,writerStart}; // @[Cat.scala 30:58:@1010.4]
  assign control = ClearCSR_io_value; // @[WorkerCSRWrapper.scala 49:21:@974.4 WorkerCSRWrapper.scala 58:11:@986.4]
  assign _T_208 = control[5]; // @[WorkerCSRWrapper.scala 65:56:@1011.4]
  assign _T_209 = control[4]; // @[WorkerCSRWrapper.scala 65:68:@1012.4]
  assign _T_210 = {_T_208,_T_209}; // @[Cat.scala 30:58:@1013.4]
  assign _T_211 = ~ _T_210; // @[WorkerCSRWrapper.scala 65:44:@1014.4]
  assign clear = _T_207 & _T_211; // @[WorkerCSRWrapper.scala 65:42:@1015.4]
  assign _T_214 = readerSyncOld == 1'h0; // @[WorkerCSRWrapper.scala 67:20:@1017.4]
  assign _T_215 = _T_214 & readerSync; // @[WorkerCSRWrapper.scala 67:35:@1018.4]
  assign _T_216 = control[3]; // @[WorkerCSRWrapper.scala 67:60:@1019.4]
  assign _T_217 = _T_215 | _T_216; // @[WorkerCSRWrapper.scala 67:50:@1020.4]
  assign _T_218 = control[1]; // @[WorkerCSRWrapper.scala 67:75:@1021.4]
  assign _T_219 = _T_217 & _T_218; // @[WorkerCSRWrapper.scala 67:65:@1022.4]
  assign _T_221 = writerSyncOld == 1'h0; // @[WorkerCSRWrapper.scala 68:20:@1024.4]
  assign _T_222 = _T_221 & writerSync; // @[WorkerCSRWrapper.scala 68:35:@1025.4]
  assign _T_223 = control[2]; // @[WorkerCSRWrapper.scala 68:60:@1026.4]
  assign _T_224 = _T_222 | _T_223; // @[WorkerCSRWrapper.scala 68:50:@1027.4]
  assign _T_225 = control[0]; // @[WorkerCSRWrapper.scala 68:75:@1028.4]
  assign _T_226 = _T_224 & _T_225; // @[WorkerCSRWrapper.scala 68:65:@1029.4]
  assign io_csr_0_dataIn = ClearCSR_io_csr_dataIn; // @[ClearCSR.scala 45:16:@982.4]
  assign io_csr_1_dataIn = StatusCSR_io_csr_dataIn; // @[StatusCSR.scala 35:16:@990.4]
  assign io_csr_2_dataIn = InterruptController_io_imr_dataIn; // @[InterruptController.scala 59:17:@1000.4]
  assign io_csr_3_dataIn = InterruptController_io_isr_dataIn; // @[InterruptController.scala 60:17:@1004.4]
  assign io_csr_4_dataIn = SimpleCSR_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1035.4]
  assign io_csr_5_dataIn = SimpleCSR_1_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1043.4]
  assign io_csr_6_dataIn = SimpleCSR_2_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1051.4]
  assign io_csr_7_dataIn = SimpleCSR_3_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1059.4]
  assign io_csr_8_dataIn = SimpleCSR_4_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1068.4]
  assign io_csr_9_dataIn = SimpleCSR_5_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1076.4]
  assign io_csr_10_dataIn = SimpleCSR_6_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1084.4]
  assign io_csr_11_dataIn = SimpleCSR_7_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1092.4]
  assign io_csr_12_dataIn = StatusCSR_1_io_csr_dataIn; // @[StatusCSR.scala 35:16:@1100.4]
  assign io_csr_13_dataIn = StatusCSR_2_io_csr_dataIn; // @[StatusCSR.scala 35:16:@1108.4]
  assign io_csr_14_dataIn = SimpleCSR_8_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1116.4]
  assign io_csr_15_dataIn = SimpleCSR_9_io_csr_dataIn; // @[SimpleCSR.scala 41:16:@1123.4]
  assign io_irq_readerDone = InterruptController_io_irq_readerDone; // @[WorkerCSRWrapper.scala 62:10:@1009.4]
  assign io_irq_writerDone = InterruptController_io_irq_writerDone; // @[WorkerCSRWrapper.scala 62:10:@1008.4]
  assign io_xferRead_length = transferSplitterRead_io_xferOut_length; // @[WorkerCSRWrapper.scala 90:15:@1134.4]
  assign io_xferRead_valid = transferSplitterRead_io_xferOut_valid; // @[WorkerCSRWrapper.scala 90:15:@1133.4]
  assign io_xferWrite_length = transferSplitterWrite_io_xferOut_length; // @[WorkerCSRWrapper.scala 93:16:@1144.4]
  assign io_xferWrite_valid = transferSplitterWrite_io_xferOut_valid; // @[WorkerCSRWrapper.scala 93:16:@1143.4]
  assign io_xferWrite_first = transferSplitterWrite_io_xferOut_first; // @[WorkerCSRWrapper.scala 93:16:@1142.4]
  assign addressGeneratorRead_clock = clock; // @[:@950.4]
  assign addressGeneratorRead_reset = reset; // @[:@951.4]
  assign addressGeneratorRead_io_ctl_start = readerStart; // @[WorkerCSRWrapper.scala 70:37:@1031.4]
  assign addressGeneratorRead_io_ctl_lineLength = SimpleCSR_1_io_value; // @[WorkerCSRWrapper.scala 72:42:@1047.4]
  assign addressGeneratorRead_io_ctl_lineCount = SimpleCSR_2_io_value; // @[WorkerCSRWrapper.scala 73:41:@1055.4]
  assign addressGeneratorRead_io_xfer_done = transferSplitterRead_io_xferIn_done; // @[WorkerCSRWrapper.scala 89:34:@1131.4]
  assign transferSplitterRead_io_xferIn_length = addressGeneratorRead_io_xfer_length; // @[WorkerCSRWrapper.scala 89:34:@1129.4]
  assign transferSplitterRead_io_xferIn_valid = addressGeneratorRead_io_xfer_valid; // @[WorkerCSRWrapper.scala 89:34:@1128.4]
  assign transferSplitterRead_io_xferOut_done = io_xferRead_done; // @[WorkerCSRWrapper.scala 90:15:@1136.4]
  assign addressGeneratorWrite_clock = clock; // @[:@956.4]
  assign addressGeneratorWrite_reset = reset; // @[:@957.4]
  assign addressGeneratorWrite_io_ctl_start = writerStart; // @[WorkerCSRWrapper.scala 76:38:@1064.4]
  assign addressGeneratorWrite_io_ctl_lineLength = SimpleCSR_5_io_value; // @[WorkerCSRWrapper.scala 78:43:@1080.4]
  assign addressGeneratorWrite_io_ctl_lineCount = SimpleCSR_6_io_value; // @[WorkerCSRWrapper.scala 79:42:@1088.4]
  assign addressGeneratorWrite_io_xfer_done = transferSplitterWrite_io_xferIn_done; // @[WorkerCSRWrapper.scala 92:35:@1141.4]
  assign transferSplitterWrite_clock = clock; // @[:@959.4]
  assign transferSplitterWrite_reset = reset; // @[:@960.4]
  assign transferSplitterWrite_io_xferIn_length = addressGeneratorWrite_io_xfer_length; // @[WorkerCSRWrapper.scala 92:35:@1139.4]
  assign transferSplitterWrite_io_xferIn_valid = addressGeneratorWrite_io_xfer_valid; // @[WorkerCSRWrapper.scala 92:35:@1138.4]
  assign transferSplitterWrite_io_xferIn_first = addressGeneratorWrite_io_xfer_first; // @[WorkerCSRWrapper.scala 92:35:@1137.4]
  assign transferSplitterWrite_io_xferOut_done = io_xferWrite_done; // @[WorkerCSRWrapper.scala 93:16:@1146.4]
  assign ClearCSR_clock = clock; // @[:@979.4]
  assign ClearCSR_reset = reset; // @[:@980.4]
  assign ClearCSR_io_csr_dataOut = io_csr_0_dataOut; // @[ClearCSR.scala 45:16:@984.4]
  assign ClearCSR_io_csr_dataWrite = io_csr_0_dataWrite; // @[ClearCSR.scala 45:16:@983.4]
  assign ClearCSR_io_clear = {{30'd0}, clear}; // @[ClearCSR.scala 43:18:@981.4]
  assign StatusCSR_clock = clock; // @[:@988.4]
  assign StatusCSR_io_value = {{30'd0}, status}; // @[StatusCSR.scala 37:18:@994.4]
  assign InterruptController_clock = clock; // @[:@996.4]
  assign InterruptController_reset = reset; // @[:@997.4]
  assign InterruptController_io_readBusy = addressGeneratorRead_io_ctl_busy; // @[InterruptController.scala 56:22:@998.4]
  assign InterruptController_io_writeBusy = addressGeneratorWrite_io_ctl_busy; // @[InterruptController.scala 57:23:@999.4]
  assign InterruptController_io_imr_dataOut = io_csr_2_dataOut; // @[InterruptController.scala 59:17:@1002.4]
  assign InterruptController_io_imr_dataWrite = io_csr_2_dataWrite; // @[InterruptController.scala 59:17:@1001.4]
  assign InterruptController_io_isr_dataOut = io_csr_3_dataOut; // @[InterruptController.scala 60:17:@1006.4]
  assign InterruptController_io_isr_dataWrite = io_csr_3_dataWrite; // @[InterruptController.scala 60:17:@1005.4]
  assign SimpleCSR_clock = clock; // @[:@1033.4]
  assign SimpleCSR_reset = reset; // @[:@1034.4]
  assign SimpleCSR_io_csr_dataOut = io_csr_4_dataOut; // @[SimpleCSR.scala 41:16:@1037.4]
  assign SimpleCSR_io_csr_dataWrite = io_csr_4_dataWrite; // @[SimpleCSR.scala 41:16:@1036.4]
  assign SimpleCSR_1_clock = clock; // @[:@1041.4]
  assign SimpleCSR_1_reset = reset; // @[:@1042.4]
  assign SimpleCSR_1_io_csr_dataOut = io_csr_5_dataOut; // @[SimpleCSR.scala 41:16:@1045.4]
  assign SimpleCSR_1_io_csr_dataWrite = io_csr_5_dataWrite; // @[SimpleCSR.scala 41:16:@1044.4]
  assign SimpleCSR_2_clock = clock; // @[:@1049.4]
  assign SimpleCSR_2_reset = reset; // @[:@1050.4]
  assign SimpleCSR_2_io_csr_dataOut = io_csr_6_dataOut; // @[SimpleCSR.scala 41:16:@1053.4]
  assign SimpleCSR_2_io_csr_dataWrite = io_csr_6_dataWrite; // @[SimpleCSR.scala 41:16:@1052.4]
  assign SimpleCSR_3_clock = clock; // @[:@1057.4]
  assign SimpleCSR_3_reset = reset; // @[:@1058.4]
  assign SimpleCSR_3_io_csr_dataOut = io_csr_7_dataOut; // @[SimpleCSR.scala 41:16:@1061.4]
  assign SimpleCSR_3_io_csr_dataWrite = io_csr_7_dataWrite; // @[SimpleCSR.scala 41:16:@1060.4]
  assign SimpleCSR_4_clock = clock; // @[:@1066.4]
  assign SimpleCSR_4_reset = reset; // @[:@1067.4]
  assign SimpleCSR_4_io_csr_dataOut = io_csr_8_dataOut; // @[SimpleCSR.scala 41:16:@1070.4]
  assign SimpleCSR_4_io_csr_dataWrite = io_csr_8_dataWrite; // @[SimpleCSR.scala 41:16:@1069.4]
  assign SimpleCSR_5_clock = clock; // @[:@1074.4]
  assign SimpleCSR_5_reset = reset; // @[:@1075.4]
  assign SimpleCSR_5_io_csr_dataOut = io_csr_9_dataOut; // @[SimpleCSR.scala 41:16:@1078.4]
  assign SimpleCSR_5_io_csr_dataWrite = io_csr_9_dataWrite; // @[SimpleCSR.scala 41:16:@1077.4]
  assign SimpleCSR_6_clock = clock; // @[:@1082.4]
  assign SimpleCSR_6_reset = reset; // @[:@1083.4]
  assign SimpleCSR_6_io_csr_dataOut = io_csr_10_dataOut; // @[SimpleCSR.scala 41:16:@1086.4]
  assign SimpleCSR_6_io_csr_dataWrite = io_csr_10_dataWrite; // @[SimpleCSR.scala 41:16:@1085.4]
  assign SimpleCSR_7_clock = clock; // @[:@1090.4]
  assign SimpleCSR_7_reset = reset; // @[:@1091.4]
  assign SimpleCSR_7_io_csr_dataOut = io_csr_11_dataOut; // @[SimpleCSR.scala 41:16:@1094.4]
  assign SimpleCSR_7_io_csr_dataWrite = io_csr_11_dataWrite; // @[SimpleCSR.scala 41:16:@1093.4]
  assign StatusCSR_1_clock = clock; // @[:@1098.4]
  assign StatusCSR_1_io_value = 32'h0; // @[StatusCSR.scala 37:18:@1104.4]
  assign StatusCSR_2_clock = clock; // @[:@1106.4]
  assign StatusCSR_2_io_value = 32'h0; // @[StatusCSR.scala 37:18:@1112.4]
  assign SimpleCSR_8_clock = clock; // @[:@1114.4]
  assign SimpleCSR_8_reset = reset; // @[:@1115.4]
  assign SimpleCSR_8_io_csr_dataOut = io_csr_14_dataOut; // @[SimpleCSR.scala 41:16:@1118.4]
  assign SimpleCSR_8_io_csr_dataWrite = io_csr_14_dataWrite; // @[SimpleCSR.scala 41:16:@1117.4]
  assign SimpleCSR_9_clock = clock; // @[:@1121.4]
  assign SimpleCSR_9_reset = reset; // @[:@1122.4]
  assign SimpleCSR_9_io_csr_dataOut = io_csr_15_dataOut; // @[SimpleCSR.scala 41:16:@1125.4]
  assign SimpleCSR_9_io_csr_dataWrite = io_csr_15_dataWrite; // @[SimpleCSR.scala 41:16:@1124.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  status = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  readerSync = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  readerSyncOld = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  writerSync = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  writerSyncOld = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  readerStart = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  writerStart = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    status <= {addressGeneratorRead_io_ctl_busy,addressGeneratorWrite_io_ctl_busy};
    readerSync <= io_sync_readerSync;
    readerSyncOld <= readerSync;
    writerSync <= io_sync_writerSync;
    writerSyncOld <= writerSync;
    if (reset) begin
      readerStart <= 1'h0;
    end else begin
      readerStart <= _T_219;
    end
    if (reset) begin
      writerStart <= 1'h0;
    end else begin
      writerStart <= _T_226;
    end
  end
endmodule
module AXIS_to_AXIS_Queue( // @[:@1148.2]
  input         clock, // @[:@1149.4]
  input         reset, // @[:@1150.4]
  output        io_enq_ready, // @[:@1151.4]
  input         io_enq_valid, // @[:@1151.4]
  input  [31:0] io_enq_bits, // @[:@1151.4]
  input         io_deq_ready, // @[:@1151.4]
  output        io_deq_valid, // @[:@1151.4]
  output [31:0] io_deq_bits // @[:@1151.4]
);
  reg [31:0] ram [0:511]; // @[Decoupled.scala 215:24:@1153.4]
  reg [31:0] _RAND_0;
  wire [31:0] ram__T_63_data; // @[Decoupled.scala 215:24:@1153.4]
  wire [8:0] ram__T_63_addr; // @[Decoupled.scala 215:24:@1153.4]
  wire [31:0] ram__T_49_data; // @[Decoupled.scala 215:24:@1153.4]
  wire [8:0] ram__T_49_addr; // @[Decoupled.scala 215:24:@1153.4]
  wire  ram__T_49_mask; // @[Decoupled.scala 215:24:@1153.4]
  wire  ram__T_49_en; // @[Decoupled.scala 215:24:@1153.4]
  reg [8:0] value; // @[Counter.scala 26:33:@1154.4]
  reg [31:0] _RAND_1;
  reg [8:0] value_1; // @[Counter.scala 26:33:@1155.4]
  reg [31:0] _RAND_2;
  reg  maybe_full; // @[Decoupled.scala 218:35:@1156.4]
  reg [31:0] _RAND_3;
  wire  _T_41; // @[Decoupled.scala 220:41:@1157.4]
  wire  _T_43; // @[Decoupled.scala 221:36:@1158.4]
  wire  empty; // @[Decoupled.scala 221:33:@1159.4]
  wire  _T_44; // @[Decoupled.scala 222:32:@1160.4]
  wire  do_enq; // @[Decoupled.scala 37:37:@1161.4]
  wire  do_deq; // @[Decoupled.scala 37:37:@1164.4]
  wire [9:0] _T_52; // @[Counter.scala 35:22:@1171.6]
  wire [8:0] _T_53; // @[Counter.scala 35:22:@1172.6]
  wire [8:0] _GEN_5; // @[Decoupled.scala 226:17:@1167.4]
  wire [9:0] _T_56; // @[Counter.scala 35:22:@1177.6]
  wire [8:0] _T_57; // @[Counter.scala 35:22:@1178.6]
  wire [8:0] _GEN_6; // @[Decoupled.scala 230:17:@1175.4]
  wire  _T_58; // @[Decoupled.scala 233:16:@1181.4]
  wire  _GEN_7; // @[Decoupled.scala 233:28:@1182.4]
  assign ram__T_63_addr = value_1;
  assign ram__T_63_data = ram[ram__T_63_addr]; // @[Decoupled.scala 215:24:@1153.4]
  assign ram__T_49_data = io_enq_bits;
  assign ram__T_49_addr = value;
  assign ram__T_49_mask = 1'h1;
  assign ram__T_49_en = io_enq_ready & io_enq_valid;
  assign _T_41 = value == value_1; // @[Decoupled.scala 220:41:@1157.4]
  assign _T_43 = maybe_full == 1'h0; // @[Decoupled.scala 221:36:@1158.4]
  assign empty = _T_41 & _T_43; // @[Decoupled.scala 221:33:@1159.4]
  assign _T_44 = _T_41 & maybe_full; // @[Decoupled.scala 222:32:@1160.4]
  assign do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 37:37:@1161.4]
  assign do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 37:37:@1164.4]
  assign _T_52 = value + 9'h1; // @[Counter.scala 35:22:@1171.6]
  assign _T_53 = value + 9'h1; // @[Counter.scala 35:22:@1172.6]
  assign _GEN_5 = do_enq ? _T_53 : value; // @[Decoupled.scala 226:17:@1167.4]
  assign _T_56 = value_1 + 9'h1; // @[Counter.scala 35:22:@1177.6]
  assign _T_57 = value_1 + 9'h1; // @[Counter.scala 35:22:@1178.6]
  assign _GEN_6 = do_deq ? _T_57 : value_1; // @[Decoupled.scala 230:17:@1175.4]
  assign _T_58 = do_enq != do_deq; // @[Decoupled.scala 233:16:@1181.4]
  assign _GEN_7 = _T_58 ? do_enq : maybe_full; // @[Decoupled.scala 233:28:@1182.4]
  assign io_enq_ready = _T_44 == 1'h0; // @[Decoupled.scala 238:16:@1188.4]
  assign io_deq_valid = empty == 1'h0; // @[Decoupled.scala 237:16:@1186.4]
  assign io_deq_bits = ram__T_63_data; // @[Decoupled.scala 239:15:@1190.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 512; initvar = initvar+1)
    ram[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[8:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  value_1 = _RAND_2[8:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_49_en & ram__T_49_mask) begin
      ram[ram__T_49_addr] <= ram__T_49_data; // @[Decoupled.scala 215:24:@1153.4]
    end
    if (reset) begin
      value <= 9'h0;
    end else begin
      if (do_enq) begin
        value <= _T_53;
      end
    end
    if (reset) begin
      value_1 <= 9'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_57;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_58) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module AXIS_to_AXIS( // @[:@1199.2]
  input         clock, // @[:@1200.4]
  input         reset, // @[:@1201.4]
  input  [31:0] io_control_dat_i, // @[:@1202.4]
  output [31:0] io_control_dat_o, // @[:@1202.4]
  input         io_control_cyc_i, // @[:@1202.4]
  input         io_control_stb_i, // @[:@1202.4]
  input         io_control_we_i, // @[:@1202.4]
  input  [29:0] io_control_adr_i, // @[:@1202.4]
  input  [3:0]  io_control_sel_i, // @[:@1202.4]
  output        io_control_ack_o, // @[:@1202.4]
  output        io_control_stall_o, // @[:@1202.4]
  output        io_control_err_o, // @[:@1202.4]
  input  [31:0] io_read_tdata, // @[:@1202.4]
  input         io_read_tvalid, // @[:@1202.4]
  output        io_read_tready, // @[:@1202.4]
  input         io_read_tuser, // @[:@1202.4]
  input         io_read_tlast, // @[:@1202.4]
  output [31:0] io_write_tdata, // @[:@1202.4]
  output        io_write_tvalid, // @[:@1202.4]
  input         io_write_tready, // @[:@1202.4]
  output        io_write_tuser, // @[:@1202.4]
  output        io_write_tlast, // @[:@1202.4]
  output        io_irq_readerDone, // @[:@1202.4]
  output        io_irq_writerDone, // @[:@1202.4]
  input         io_sync_readerSync, // @[:@1202.4]
  input         io_sync_writerSync // @[:@1202.4]
);
  wire  csrFrontend_clock; // @[DMATop.scala 38:27:@1204.4]
  wire  csrFrontend_reset; // @[DMATop.scala 38:27:@1204.4]
  wire [31:0] csrFrontend_io_ctl_dat_i; // @[DMATop.scala 38:27:@1204.4]
  wire [31:0] csrFrontend_io_ctl_dat_o; // @[DMATop.scala 38:27:@1204.4]
  wire  csrFrontend_io_ctl_cyc_i; // @[DMATop.scala 38:27:@1204.4]
  wire  csrFrontend_io_ctl_stb_i; // @[DMATop.scala 38:27:@1204.4]
  wire  csrFrontend_io_ctl_we_i; // @[DMATop.scala 38:27:@1204.4]
  wire [29:0] csrFrontend_io_ctl_adr_i; // @[DMATop.scala 38:27:@1204.4]
  wire  csrFrontend_io_ctl_ack_o; // @[DMATop.scala 38:27:@1204.4]
  wire [3:0] csrFrontend_io_bus_addr; // @[DMATop.scala 38:27:@1204.4]
  wire [31:0] csrFrontend_io_bus_dataOut; // @[DMATop.scala 38:27:@1204.4]
  wire [31:0] csrFrontend_io_bus_dataIn; // @[DMATop.scala 38:27:@1204.4]
  wire  csrFrontend_io_bus_write; // @[DMATop.scala 38:27:@1204.4]
  wire  csrFrontend_io_bus_read; // @[DMATop.scala 38:27:@1204.4]
  wire  readerFrontend_clock; // @[DMATop.scala 40:30:@1207.4]
  wire  readerFrontend_reset; // @[DMATop.scala 40:30:@1207.4]
  wire [31:0] readerFrontend_io_bus_tdata; // @[DMATop.scala 40:30:@1207.4]
  wire  readerFrontend_io_bus_tvalid; // @[DMATop.scala 40:30:@1207.4]
  wire  readerFrontend_io_bus_tready; // @[DMATop.scala 40:30:@1207.4]
  wire  readerFrontend_io_dataIO_ready; // @[DMATop.scala 40:30:@1207.4]
  wire  readerFrontend_io_dataIO_valid; // @[DMATop.scala 40:30:@1207.4]
  wire [31:0] readerFrontend_io_dataIO_bits; // @[DMATop.scala 40:30:@1207.4]
  wire  readerFrontend_io_xfer_done; // @[DMATop.scala 40:30:@1207.4]
  wire [31:0] readerFrontend_io_xfer_length; // @[DMATop.scala 40:30:@1207.4]
  wire  readerFrontend_io_xfer_valid; // @[DMATop.scala 40:30:@1207.4]
  wire  writerFrontend_clock; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_reset; // @[DMATop.scala 42:30:@1210.4]
  wire [31:0] writerFrontend_io_bus_tdata; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_bus_tvalid; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_bus_tready; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_bus_tuser; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_bus_tlast; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_dataIO_ready; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_dataIO_valid; // @[DMATop.scala 42:30:@1210.4]
  wire [31:0] writerFrontend_io_dataIO_bits; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_xfer_done; // @[DMATop.scala 42:30:@1210.4]
  wire [31:0] writerFrontend_io_xfer_length; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_xfer_valid; // @[DMATop.scala 42:30:@1210.4]
  wire  writerFrontend_io_xfer_first; // @[DMATop.scala 42:30:@1210.4]
  wire [31:0] csr_io_csr_0_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_0_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_0_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_1_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_2_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_2_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_2_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_3_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_3_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_3_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_4_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_4_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_4_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_5_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_5_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_5_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_6_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_6_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_6_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_7_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_7_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_7_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_8_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_8_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_8_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_9_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_9_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_9_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_10_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_10_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_10_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_11_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_11_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_11_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_12_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_13_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_14_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_14_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_14_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_15_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_csr_15_dataWrite; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_csr_15_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire [3:0] csr_io_bus_addr; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_bus_dataOut; // @[DMATop.scala 44:19:@1213.4]
  wire [31:0] csr_io_bus_dataIn; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_bus_write; // @[DMATop.scala 44:19:@1213.4]
  wire  csr_io_bus_read; // @[DMATop.scala 44:19:@1213.4]
  wire  ctl_clock; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_reset; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_0_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_0_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_0_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_1_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_2_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_2_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_2_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_3_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_3_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_3_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_4_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_4_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_4_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_5_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_5_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_5_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_6_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_6_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_6_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_7_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_7_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_7_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_8_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_8_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_8_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_9_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_9_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_9_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_10_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_10_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_10_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_11_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_11_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_11_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_12_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_13_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_14_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_14_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_14_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_15_dataOut; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_csr_15_dataWrite; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_csr_15_dataIn; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_irq_readerDone; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_irq_writerDone; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_sync_readerSync; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_sync_writerSync; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_xferRead_done; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_xferRead_length; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_xferRead_valid; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_xferWrite_done; // @[DMATop.scala 46:19:@1216.4]
  wire [31:0] ctl_io_xferWrite_length; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_xferWrite_valid; // @[DMATop.scala 46:19:@1216.4]
  wire  ctl_io_xferWrite_first; // @[DMATop.scala 46:19:@1216.4]
  wire  queue_clock; // @[Decoupled.scala 294:21:@1219.4]
  wire  queue_reset; // @[Decoupled.scala 294:21:@1219.4]
  wire  queue_io_enq_ready; // @[Decoupled.scala 294:21:@1219.4]
  wire  queue_io_enq_valid; // @[Decoupled.scala 294:21:@1219.4]
  wire [31:0] queue_io_enq_bits; // @[Decoupled.scala 294:21:@1219.4]
  wire  queue_io_deq_ready; // @[Decoupled.scala 294:21:@1219.4]
  wire  queue_io_deq_valid; // @[Decoupled.scala 294:21:@1219.4]
  wire [31:0] queue_io_deq_bits; // @[Decoupled.scala 294:21:@1219.4]
  AXIS_to_AXIS_WishboneCSR csrFrontend ( // @[DMATop.scala 38:27:@1204.4]
    .clock(csrFrontend_clock),
    .reset(csrFrontend_reset),
    .io_ctl_dat_i(csrFrontend_io_ctl_dat_i),
    .io_ctl_dat_o(csrFrontend_io_ctl_dat_o),
    .io_ctl_cyc_i(csrFrontend_io_ctl_cyc_i),
    .io_ctl_stb_i(csrFrontend_io_ctl_stb_i),
    .io_ctl_we_i(csrFrontend_io_ctl_we_i),
    .io_ctl_adr_i(csrFrontend_io_ctl_adr_i),
    .io_ctl_ack_o(csrFrontend_io_ctl_ack_o),
    .io_bus_addr(csrFrontend_io_bus_addr),
    .io_bus_dataOut(csrFrontend_io_bus_dataOut),
    .io_bus_dataIn(csrFrontend_io_bus_dataIn),
    .io_bus_write(csrFrontend_io_bus_write),
    .io_bus_read(csrFrontend_io_bus_read)
  );
  AXIS_to_AXIS_AXIStreamSlave readerFrontend ( // @[DMATop.scala 40:30:@1207.4]
    .clock(readerFrontend_clock),
    .reset(readerFrontend_reset),
    .io_bus_tdata(readerFrontend_io_bus_tdata),
    .io_bus_tvalid(readerFrontend_io_bus_tvalid),
    .io_bus_tready(readerFrontend_io_bus_tready),
    .io_dataIO_ready(readerFrontend_io_dataIO_ready),
    .io_dataIO_valid(readerFrontend_io_dataIO_valid),
    .io_dataIO_bits(readerFrontend_io_dataIO_bits),
    .io_xfer_done(readerFrontend_io_xfer_done),
    .io_xfer_length(readerFrontend_io_xfer_length),
    .io_xfer_valid(readerFrontend_io_xfer_valid)
  );
  AXIS_to_AXIS_AXIStreamMaster writerFrontend ( // @[DMATop.scala 42:30:@1210.4]
    .clock(writerFrontend_clock),
    .reset(writerFrontend_reset),
    .io_bus_tdata(writerFrontend_io_bus_tdata),
    .io_bus_tvalid(writerFrontend_io_bus_tvalid),
    .io_bus_tready(writerFrontend_io_bus_tready),
    .io_bus_tuser(writerFrontend_io_bus_tuser),
    .io_bus_tlast(writerFrontend_io_bus_tlast),
    .io_dataIO_ready(writerFrontend_io_dataIO_ready),
    .io_dataIO_valid(writerFrontend_io_dataIO_valid),
    .io_dataIO_bits(writerFrontend_io_dataIO_bits),
    .io_xfer_done(writerFrontend_io_xfer_done),
    .io_xfer_length(writerFrontend_io_xfer_length),
    .io_xfer_valid(writerFrontend_io_xfer_valid),
    .io_xfer_first(writerFrontend_io_xfer_first)
  );
  AXIS_to_AXIS_CSR csr ( // @[DMATop.scala 44:19:@1213.4]
    .io_csr_0_dataOut(csr_io_csr_0_dataOut),
    .io_csr_0_dataWrite(csr_io_csr_0_dataWrite),
    .io_csr_0_dataIn(csr_io_csr_0_dataIn),
    .io_csr_1_dataIn(csr_io_csr_1_dataIn),
    .io_csr_2_dataOut(csr_io_csr_2_dataOut),
    .io_csr_2_dataWrite(csr_io_csr_2_dataWrite),
    .io_csr_2_dataIn(csr_io_csr_2_dataIn),
    .io_csr_3_dataOut(csr_io_csr_3_dataOut),
    .io_csr_3_dataWrite(csr_io_csr_3_dataWrite),
    .io_csr_3_dataIn(csr_io_csr_3_dataIn),
    .io_csr_4_dataOut(csr_io_csr_4_dataOut),
    .io_csr_4_dataWrite(csr_io_csr_4_dataWrite),
    .io_csr_4_dataIn(csr_io_csr_4_dataIn),
    .io_csr_5_dataOut(csr_io_csr_5_dataOut),
    .io_csr_5_dataWrite(csr_io_csr_5_dataWrite),
    .io_csr_5_dataIn(csr_io_csr_5_dataIn),
    .io_csr_6_dataOut(csr_io_csr_6_dataOut),
    .io_csr_6_dataWrite(csr_io_csr_6_dataWrite),
    .io_csr_6_dataIn(csr_io_csr_6_dataIn),
    .io_csr_7_dataOut(csr_io_csr_7_dataOut),
    .io_csr_7_dataWrite(csr_io_csr_7_dataWrite),
    .io_csr_7_dataIn(csr_io_csr_7_dataIn),
    .io_csr_8_dataOut(csr_io_csr_8_dataOut),
    .io_csr_8_dataWrite(csr_io_csr_8_dataWrite),
    .io_csr_8_dataIn(csr_io_csr_8_dataIn),
    .io_csr_9_dataOut(csr_io_csr_9_dataOut),
    .io_csr_9_dataWrite(csr_io_csr_9_dataWrite),
    .io_csr_9_dataIn(csr_io_csr_9_dataIn),
    .io_csr_10_dataOut(csr_io_csr_10_dataOut),
    .io_csr_10_dataWrite(csr_io_csr_10_dataWrite),
    .io_csr_10_dataIn(csr_io_csr_10_dataIn),
    .io_csr_11_dataOut(csr_io_csr_11_dataOut),
    .io_csr_11_dataWrite(csr_io_csr_11_dataWrite),
    .io_csr_11_dataIn(csr_io_csr_11_dataIn),
    .io_csr_12_dataIn(csr_io_csr_12_dataIn),
    .io_csr_13_dataIn(csr_io_csr_13_dataIn),
    .io_csr_14_dataOut(csr_io_csr_14_dataOut),
    .io_csr_14_dataWrite(csr_io_csr_14_dataWrite),
    .io_csr_14_dataIn(csr_io_csr_14_dataIn),
    .io_csr_15_dataOut(csr_io_csr_15_dataOut),
    .io_csr_15_dataWrite(csr_io_csr_15_dataWrite),
    .io_csr_15_dataIn(csr_io_csr_15_dataIn),
    .io_bus_addr(csr_io_bus_addr),
    .io_bus_dataOut(csr_io_bus_dataOut),
    .io_bus_dataIn(csr_io_bus_dataIn),
    .io_bus_write(csr_io_bus_write),
    .io_bus_read(csr_io_bus_read)
  );
  AXIS_to_AXIS_WorkerCSRWrapper ctl ( // @[DMATop.scala 46:19:@1216.4]
    .clock(ctl_clock),
    .reset(ctl_reset),
    .io_csr_0_dataOut(ctl_io_csr_0_dataOut),
    .io_csr_0_dataWrite(ctl_io_csr_0_dataWrite),
    .io_csr_0_dataIn(ctl_io_csr_0_dataIn),
    .io_csr_1_dataIn(ctl_io_csr_1_dataIn),
    .io_csr_2_dataOut(ctl_io_csr_2_dataOut),
    .io_csr_2_dataWrite(ctl_io_csr_2_dataWrite),
    .io_csr_2_dataIn(ctl_io_csr_2_dataIn),
    .io_csr_3_dataOut(ctl_io_csr_3_dataOut),
    .io_csr_3_dataWrite(ctl_io_csr_3_dataWrite),
    .io_csr_3_dataIn(ctl_io_csr_3_dataIn),
    .io_csr_4_dataOut(ctl_io_csr_4_dataOut),
    .io_csr_4_dataWrite(ctl_io_csr_4_dataWrite),
    .io_csr_4_dataIn(ctl_io_csr_4_dataIn),
    .io_csr_5_dataOut(ctl_io_csr_5_dataOut),
    .io_csr_5_dataWrite(ctl_io_csr_5_dataWrite),
    .io_csr_5_dataIn(ctl_io_csr_5_dataIn),
    .io_csr_6_dataOut(ctl_io_csr_6_dataOut),
    .io_csr_6_dataWrite(ctl_io_csr_6_dataWrite),
    .io_csr_6_dataIn(ctl_io_csr_6_dataIn),
    .io_csr_7_dataOut(ctl_io_csr_7_dataOut),
    .io_csr_7_dataWrite(ctl_io_csr_7_dataWrite),
    .io_csr_7_dataIn(ctl_io_csr_7_dataIn),
    .io_csr_8_dataOut(ctl_io_csr_8_dataOut),
    .io_csr_8_dataWrite(ctl_io_csr_8_dataWrite),
    .io_csr_8_dataIn(ctl_io_csr_8_dataIn),
    .io_csr_9_dataOut(ctl_io_csr_9_dataOut),
    .io_csr_9_dataWrite(ctl_io_csr_9_dataWrite),
    .io_csr_9_dataIn(ctl_io_csr_9_dataIn),
    .io_csr_10_dataOut(ctl_io_csr_10_dataOut),
    .io_csr_10_dataWrite(ctl_io_csr_10_dataWrite),
    .io_csr_10_dataIn(ctl_io_csr_10_dataIn),
    .io_csr_11_dataOut(ctl_io_csr_11_dataOut),
    .io_csr_11_dataWrite(ctl_io_csr_11_dataWrite),
    .io_csr_11_dataIn(ctl_io_csr_11_dataIn),
    .io_csr_12_dataIn(ctl_io_csr_12_dataIn),
    .io_csr_13_dataIn(ctl_io_csr_13_dataIn),
    .io_csr_14_dataOut(ctl_io_csr_14_dataOut),
    .io_csr_14_dataWrite(ctl_io_csr_14_dataWrite),
    .io_csr_14_dataIn(ctl_io_csr_14_dataIn),
    .io_csr_15_dataOut(ctl_io_csr_15_dataOut),
    .io_csr_15_dataWrite(ctl_io_csr_15_dataWrite),
    .io_csr_15_dataIn(ctl_io_csr_15_dataIn),
    .io_irq_readerDone(ctl_io_irq_readerDone),
    .io_irq_writerDone(ctl_io_irq_writerDone),
    .io_sync_readerSync(ctl_io_sync_readerSync),
    .io_sync_writerSync(ctl_io_sync_writerSync),
    .io_xferRead_done(ctl_io_xferRead_done),
    .io_xferRead_length(ctl_io_xferRead_length),
    .io_xferRead_valid(ctl_io_xferRead_valid),
    .io_xferWrite_done(ctl_io_xferWrite_done),
    .io_xferWrite_length(ctl_io_xferWrite_length),
    .io_xferWrite_valid(ctl_io_xferWrite_valid),
    .io_xferWrite_first(ctl_io_xferWrite_first)
  );
  AXIS_to_AXIS_Queue queue ( // @[Decoupled.scala 294:21:@1219.4]
    .clock(queue_clock),
    .reset(queue_reset),
    .io_enq_ready(queue_io_enq_ready),
    .io_enq_valid(queue_io_enq_valid),
    .io_enq_bits(queue_io_enq_bits),
    .io_deq_ready(queue_io_deq_ready),
    .io_deq_valid(queue_io_deq_valid),
    .io_deq_bits(queue_io_deq_bits)
  );
  assign io_control_dat_o = csrFrontend_io_ctl_dat_o; // @[DMATop.scala 52:22:@1236.4]
  assign io_control_ack_o = csrFrontend_io_ctl_ack_o; // @[DMATop.scala 52:22:@1230.4]
  assign io_control_stall_o = 1'h0; // @[DMATop.scala 52:22:@1229.4]
  assign io_control_err_o = 1'h0; // @[DMATop.scala 52:22:@1228.4]
  assign io_read_tready = readerFrontend_io_bus_tready; // @[DMATop.scala 58:11:@1319.4]
  assign io_write_tdata = writerFrontend_io_bus_tdata; // @[DMATop.scala 59:12:@1326.4]
  assign io_write_tvalid = writerFrontend_io_bus_tvalid; // @[DMATop.scala 59:12:@1325.4]
  assign io_write_tuser = writerFrontend_io_bus_tuser; // @[DMATop.scala 59:12:@1323.4]
  assign io_write_tlast = writerFrontend_io_bus_tlast; // @[DMATop.scala 59:12:@1322.4]
  assign io_irq_readerDone = ctl_io_irq_readerDone; // @[DMATop.scala 61:10:@1328.4]
  assign io_irq_writerDone = ctl_io_irq_writerDone; // @[DMATop.scala 61:10:@1327.4]
  assign csrFrontend_clock = clock; // @[:@1205.4]
  assign csrFrontend_reset = reset; // @[:@1206.4]
  assign csrFrontend_io_ctl_dat_i = io_control_dat_i; // @[DMATop.scala 52:22:@1237.4]
  assign csrFrontend_io_ctl_cyc_i = io_control_cyc_i; // @[DMATop.scala 52:22:@1235.4]
  assign csrFrontend_io_ctl_stb_i = io_control_stb_i; // @[DMATop.scala 52:22:@1234.4]
  assign csrFrontend_io_ctl_we_i = io_control_we_i; // @[DMATop.scala 52:22:@1233.4]
  assign csrFrontend_io_ctl_adr_i = io_control_adr_i; // @[DMATop.scala 52:22:@1232.4]
  assign csrFrontend_io_bus_dataIn = csr_io_bus_dataIn; // @[DMATop.scala 53:14:@1240.4]
  assign readerFrontend_clock = clock; // @[:@1208.4]
  assign readerFrontend_reset = reset; // @[:@1209.4]
  assign readerFrontend_io_bus_tdata = io_read_tdata; // @[DMATop.scala 58:11:@1321.4]
  assign readerFrontend_io_bus_tvalid = io_read_tvalid; // @[DMATop.scala 58:11:@1320.4]
  assign readerFrontend_io_dataIO_ready = queue_io_enq_ready; // @[Decoupled.scala 297:17:@1224.4]
  assign readerFrontend_io_xfer_length = ctl_io_xferRead_length; // @[DMATop.scala 55:26:@1309.4]
  assign readerFrontend_io_xfer_valid = ctl_io_xferRead_valid; // @[DMATop.scala 55:26:@1308.4]
  assign writerFrontend_clock = clock; // @[:@1211.4]
  assign writerFrontend_reset = reset; // @[:@1212.4]
  assign writerFrontend_io_bus_tready = io_write_tready; // @[DMATop.scala 59:12:@1324.4]
  assign writerFrontend_io_dataIO_valid = queue_io_deq_valid; // @[DMATop.scala 50:9:@1226.4]
  assign writerFrontend_io_dataIO_bits = queue_io_deq_bits; // @[DMATop.scala 50:9:@1225.4]
  assign writerFrontend_io_xfer_length = ctl_io_xferWrite_length; // @[DMATop.scala 56:26:@1314.4]
  assign writerFrontend_io_xfer_valid = ctl_io_xferWrite_valid; // @[DMATop.scala 56:26:@1313.4]
  assign writerFrontend_io_xfer_first = ctl_io_xferWrite_first; // @[DMATop.scala 56:26:@1312.4]
  assign csr_io_csr_0_dataIn = ctl_io_csr_0_dataIn; // @[DMATop.scala 54:14:@1243.4]
  assign csr_io_csr_1_dataIn = ctl_io_csr_1_dataIn; // @[DMATop.scala 54:14:@1247.4]
  assign csr_io_csr_2_dataIn = ctl_io_csr_2_dataIn; // @[DMATop.scala 54:14:@1251.4]
  assign csr_io_csr_3_dataIn = ctl_io_csr_3_dataIn; // @[DMATop.scala 54:14:@1255.4]
  assign csr_io_csr_4_dataIn = ctl_io_csr_4_dataIn; // @[DMATop.scala 54:14:@1259.4]
  assign csr_io_csr_5_dataIn = ctl_io_csr_5_dataIn; // @[DMATop.scala 54:14:@1263.4]
  assign csr_io_csr_6_dataIn = ctl_io_csr_6_dataIn; // @[DMATop.scala 54:14:@1267.4]
  assign csr_io_csr_7_dataIn = ctl_io_csr_7_dataIn; // @[DMATop.scala 54:14:@1271.4]
  assign csr_io_csr_8_dataIn = ctl_io_csr_8_dataIn; // @[DMATop.scala 54:14:@1275.4]
  assign csr_io_csr_9_dataIn = ctl_io_csr_9_dataIn; // @[DMATop.scala 54:14:@1279.4]
  assign csr_io_csr_10_dataIn = ctl_io_csr_10_dataIn; // @[DMATop.scala 54:14:@1283.4]
  assign csr_io_csr_11_dataIn = ctl_io_csr_11_dataIn; // @[DMATop.scala 54:14:@1287.4]
  assign csr_io_csr_12_dataIn = ctl_io_csr_12_dataIn; // @[DMATop.scala 54:14:@1291.4]
  assign csr_io_csr_13_dataIn = ctl_io_csr_13_dataIn; // @[DMATop.scala 54:14:@1295.4]
  assign csr_io_csr_14_dataIn = ctl_io_csr_14_dataIn; // @[DMATop.scala 54:14:@1299.4]
  assign csr_io_csr_15_dataIn = ctl_io_csr_15_dataIn; // @[DMATop.scala 54:14:@1303.4]
  assign csr_io_bus_addr = csrFrontend_io_bus_addr; // @[DMATop.scala 53:14:@1242.4]
  assign csr_io_bus_dataOut = csrFrontend_io_bus_dataOut; // @[DMATop.scala 53:14:@1241.4]
  assign csr_io_bus_write = csrFrontend_io_bus_write; // @[DMATop.scala 53:14:@1239.4]
  assign csr_io_bus_read = csrFrontend_io_bus_read; // @[DMATop.scala 53:14:@1238.4]
  assign ctl_clock = clock; // @[:@1217.4]
  assign ctl_reset = reset; // @[:@1218.4]
  assign ctl_io_csr_0_dataOut = csr_io_csr_0_dataOut; // @[DMATop.scala 54:14:@1245.4]
  assign ctl_io_csr_0_dataWrite = csr_io_csr_0_dataWrite; // @[DMATop.scala 54:14:@1244.4]
  assign ctl_io_csr_2_dataOut = csr_io_csr_2_dataOut; // @[DMATop.scala 54:14:@1253.4]
  assign ctl_io_csr_2_dataWrite = csr_io_csr_2_dataWrite; // @[DMATop.scala 54:14:@1252.4]
  assign ctl_io_csr_3_dataOut = csr_io_csr_3_dataOut; // @[DMATop.scala 54:14:@1257.4]
  assign ctl_io_csr_3_dataWrite = csr_io_csr_3_dataWrite; // @[DMATop.scala 54:14:@1256.4]
  assign ctl_io_csr_4_dataOut = csr_io_csr_4_dataOut; // @[DMATop.scala 54:14:@1261.4]
  assign ctl_io_csr_4_dataWrite = csr_io_csr_4_dataWrite; // @[DMATop.scala 54:14:@1260.4]
  assign ctl_io_csr_5_dataOut = csr_io_csr_5_dataOut; // @[DMATop.scala 54:14:@1265.4]
  assign ctl_io_csr_5_dataWrite = csr_io_csr_5_dataWrite; // @[DMATop.scala 54:14:@1264.4]
  assign ctl_io_csr_6_dataOut = csr_io_csr_6_dataOut; // @[DMATop.scala 54:14:@1269.4]
  assign ctl_io_csr_6_dataWrite = csr_io_csr_6_dataWrite; // @[DMATop.scala 54:14:@1268.4]
  assign ctl_io_csr_7_dataOut = csr_io_csr_7_dataOut; // @[DMATop.scala 54:14:@1273.4]
  assign ctl_io_csr_7_dataWrite = csr_io_csr_7_dataWrite; // @[DMATop.scala 54:14:@1272.4]
  assign ctl_io_csr_8_dataOut = csr_io_csr_8_dataOut; // @[DMATop.scala 54:14:@1277.4]
  assign ctl_io_csr_8_dataWrite = csr_io_csr_8_dataWrite; // @[DMATop.scala 54:14:@1276.4]
  assign ctl_io_csr_9_dataOut = csr_io_csr_9_dataOut; // @[DMATop.scala 54:14:@1281.4]
  assign ctl_io_csr_9_dataWrite = csr_io_csr_9_dataWrite; // @[DMATop.scala 54:14:@1280.4]
  assign ctl_io_csr_10_dataOut = csr_io_csr_10_dataOut; // @[DMATop.scala 54:14:@1285.4]
  assign ctl_io_csr_10_dataWrite = csr_io_csr_10_dataWrite; // @[DMATop.scala 54:14:@1284.4]
  assign ctl_io_csr_11_dataOut = csr_io_csr_11_dataOut; // @[DMATop.scala 54:14:@1289.4]
  assign ctl_io_csr_11_dataWrite = csr_io_csr_11_dataWrite; // @[DMATop.scala 54:14:@1288.4]
  assign ctl_io_csr_14_dataOut = csr_io_csr_14_dataOut; // @[DMATop.scala 54:14:@1301.4]
  assign ctl_io_csr_14_dataWrite = csr_io_csr_14_dataWrite; // @[DMATop.scala 54:14:@1300.4]
  assign ctl_io_csr_15_dataOut = csr_io_csr_15_dataOut; // @[DMATop.scala 54:14:@1305.4]
  assign ctl_io_csr_15_dataWrite = csr_io_csr_15_dataWrite; // @[DMATop.scala 54:14:@1304.4]
  assign ctl_io_sync_readerSync = io_sync_readerSync; // @[DMATop.scala 62:11:@1330.4]
  assign ctl_io_sync_writerSync = io_sync_writerSync; // @[DMATop.scala 62:11:@1329.4]
  assign ctl_io_xferRead_done = readerFrontend_io_xfer_done; // @[DMATop.scala 55:26:@1311.4]
  assign ctl_io_xferWrite_done = writerFrontend_io_xfer_done; // @[DMATop.scala 56:26:@1316.4]
  assign queue_clock = clock; // @[:@1220.4]
  assign queue_reset = reset; // @[:@1221.4]
  assign queue_io_enq_valid = readerFrontend_io_dataIO_valid; // @[Decoupled.scala 295:22:@1222.4]
  assign queue_io_enq_bits = readerFrontend_io_dataIO_bits; // @[Decoupled.scala 296:21:@1223.4]
  assign queue_io_deq_ready = writerFrontend_io_dataIO_ready; // @[DMATop.scala 50:9:@1227.4]
endmodule
