module reg_file(
input clk,
input[3:0] rd_addr0,
input[3:0] rd_addr1,
input[3:0] rd_addr2,
input[3:0] wr_addr,
input[31:0] wr_data,
input wr_valid,
input processor_mode,
output reg[31:0] rd_data0,
output reg[31:0] rd_data1,
output reg[31:0] rd_data2);

// temporary registers. Need to add more registers later to use in previleged
// modes
reg[31:0] reg0;
reg[31:0] reg1;
reg[31:0] reg2;
reg[31:0] reg3;
reg[31:0] reg4;
reg[31:0] reg5;
reg[31:0] reg6;
reg[31:0] reg7;
reg[31:0] reg8;
reg[31:0] reg9;
reg[31:0] reg10;
reg[31:0] reg11;
reg[31:0] reg12;
reg[31:0] reg13;
reg[31:0] reg14;
reg[31:0] reg15;
reg[31:0] reg16;

// if necessary use one hot mux to meet timing
always @(*)
begin
  case (rd_addr0)
    0  : rd_data0 = #1 reg0;
    1  : rd_data0 = #1 reg1;
    2  : rd_data0 = #1 reg2;
    3  : rd_data0 = #1 reg3;
    4  : rd_data0 = #1 reg4;
    5  : rd_data0 = #1 reg5;
    6  : rd_data0 = #1 reg6;
    7  : rd_data0 = #1 reg7;
    8  : rd_data0 = #1 reg8;
    9  : rd_data0 = #1 reg9;
    10 : rd_data0 = #1 reg10;
    11 : rd_data0 = #1 reg11;
    12 : rd_data0 = #1 reg12;
    13 : rd_data0 = #1 reg13;
    14 : rd_data0 = #1 reg14;
    15 : rd_data0 = #1 reg15;
  endcase
end

always @(*)
begin
  case (rd_addr1)
      0  : rd_data1 = #1 reg0;
      1  : rd_data1 = #1 reg1;
      2  : rd_data1 = #1 reg2;
      3  : rd_data1 = #1 reg3;
      4  : rd_data1 = #1 reg4;
      5  : rd_data1 = #1 reg5;
      6  : rd_data1 = #1 reg6;
      7  : rd_data1 = #1 reg7;
      8  : rd_data1 = #1 reg8;
      9  : rd_data1 = #1 reg9;
      10 : rd_data1 = #1 reg10;
      11 : rd_data1 = #1 reg11;
      12 : rd_data1 = #1 reg12;
      13 : rd_data1 = #1 reg13;
      14 : rd_data1 = #1 reg14;
      15 : rd_data1 = #1 reg15;
  endcase
end

always @(*)
begin
  case (rd_addr2)
      0  : rd_data2 = #1 reg0;
      1  : rd_data2 = #1 reg1;
      2  : rd_data2 = #1 reg2;
      3  : rd_data2 = #1 reg3;
      4  : rd_data2 = #1 reg4;
      5  : rd_data2 = #1 reg5;
      6  : rd_data2 = #1 reg6;
      7  : rd_data2 = #1 reg7;
      8  : rd_data2 = #1 reg8;
      9  : rd_data2 = #1 reg9;
      10 : rd_data2 = #1 reg10;
      11 : rd_data2 = #1 reg11;
      12 : rd_data2 = #1 reg12;
      13 : rd_data2 = #1 reg13;
      14 : rd_data2 = #1 reg14;
      15 : rd_data2 = #1 reg15;
  endcase
end





always @(posedge clk)
begin
  if (wr_valid)
  begin
    case (wr_addr)
      0  : reg0 <= #1 wr_data;
      1  : reg1 <= #1 wr_data;
      2  : reg2 <= #1 wr_data;
      3  : reg3 <= #1 wr_data;
      4  : reg4 <= #1 wr_data;
      5  : reg5 <= #1 wr_data;
      6  : reg6 <= #1 wr_data;
      7  : reg7 <= #1 wr_data;
      8  : reg8 <= #1 wr_data;
      9  : reg9 <= #1 wr_data;
      10 : reg10 <= #1 wr_data;
      11 : reg11 <= #1 wr_data;
      12 : reg12 <= #1 wr_data;
      13 : reg13 <= #1 wr_data;
      14 : reg14 <= #1 wr_data;
      15 : reg15 <= #1 wr_data;
    endcase
  end
end





endmodule


