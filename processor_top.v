`include "decoder.v"
`include "reg_file.v"
module processor_top(
input processor_clk);


reg[3:0]   decoder_reg_file_rdaddr0;
reg[3:0]   decoder_reg_file_rdaddr1;
reg[3:0]   decoder_reg_file_rdaddr2;
reg[3:0]   decoder_reg_file_wr_addr;
reg[31:0]  decoder_reg_file_wr_data;
reg        decoder_reg_file_wr_valid;
wire[31:0] reg_file_alu_rd_data0;
wire[31:0] reg_file_alu_rd_data1;
wire[31:0] reg_file_alu_rd_data2;
wire[3:0]  decoder_reg_file_rd_addr0;
wire[3:0]  decoder_reg_file_rd_addr1;
wire[3:0]  decoder_reg_file_rd_addr2;
wire[31:0] reg_file_decoder_rd_data0;
wire[31:0] reg_file_decoder_rd_data1;
wire[31:0] reg_file_decoder_rd_data2;
reg[31:0] if_decoder_instruction;
wire[31:0] decoder_alu_operand0;
wire[31:0] decoder_alu_operand1;
wire[3:0] decoder_alu_operation;




reg_file reg_file_inst(
.clk(processor_clk),
.rd_addr0(decoder_reg_file_rd_addr0),
.rd_addr1(decoder_reg_file_rd_addr1),
.rd_addr2(decoder_reg_file_rd_addr2),
.wr_addr (decoder_reg_file_wr_addr),
.wr_data (decoder_reg_file_wr_data),
.wr_valid(decoder_reg_file_wr_valid),
.rd_data0(reg_file_decoder_rd_data0),
.rd_data1(reg_file_decoder_rd_data1),
.rd_data2(reg_file_decoder_rd_data2),
.processor_mode(1'b0));


decoder decoder_inst(
.clk (processor_clk),
.instruction(if_decoder_instruction),
.rd_addr0(decoder_reg_file_rd_addr0),
.rd_addr1(decoder_reg_file_rd_addr1),
.rd_addr2(decoder_reg_file_rd_addr2),
.rd_data0(reg_file_decoder_rd_data0),
.rd_data1(reg_file_decoder_rd_data1),
.rd_data2(reg_file_decoder_rd_data2),
.operand0(decoder_alu_operand0),
.operand1(decoder_alu_operand1),
.operation(decoder_alu_operation),
.bitwise_op(decoder_alu_bitwise_op),
.update_flags(decoder_alu_update_flags),
.use_flags(decoder_alu_use_flags),
.stall_if(decoder_if_stall_if),
.NOP(decoder_alu_NOP));







endmodule
