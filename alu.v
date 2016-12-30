`include "adder.v"
module alu(
input clk,
input[31:0] decoder_operand0,
input[31:0] decoder_operand1,
input[3:0] operation,
input bitwise_op,
input update_flags,
input use_flags,
input add_or_subtract,
input mem_wr_data,
input NOP,
input[1:0] sel,
output[31:0] alu_op);
// leave another 32 bit bus for multiplier output
//
wire cout;
wire[31:0] adder_out;
reg[31:0] operand0;
reg[31:0] operand1;

/* ========== Addition and subtraction ====================*/
adder adder_inst(
      .din0(operand0),
      .din1(operand1),
      .addn_sub(add_or_subtract),
      .clk(clk),
      .dout(adder_out),
      .carry_out(cout));
/* ========== Addition and subtraction =====================*/

/* ========================================================*/
// need to saturate outputs in ALU in case of operations like
// QSUB etc.
/* ========================================================*/

/* ============= Input Mux ================================*/
always @(*)
begin
  case (sel)
    2'b00 : operand1 = decoder_operand1;
    2'b01 : operand1 = alu_op;
    2'b10 : operand1 = mem_wr_data;
    2'b11 : operand1 = decoder_operand1;
  endcase
end
/* ============= Input Mux ================================*/


endmodule
