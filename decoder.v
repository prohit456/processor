module decoder(
input clk,
input[31:0] instruction,
input [31:0] rd_data0,
input [31:0] rd_data1,
input [31:0] rd_data2,
output reg[31:0] operand0,
output reg[3:0] rd_addr0,
output reg[3:0] rd_addr1,
output reg[3:0] rd_addr2,
output reg[31:0] operand1,
output reg[3:0] operation,
output reg bitwise_op,
output reg update_flags,
output reg use_flags,
output reg stall_if,
output reg NOP);

reg[31:0] comb_operand1;

// NOP is inserted if condition code does not satisfy the required condition
// code
//
// instruction[31:28] => condition. This specifies under what conditions
// should the instruction be executed
// instruction[25] => I bit. If this is set it signifies that its immediate
// data type
// instruction[24:21] => opcode
// instruction[20] => S. This specifies if condition codes can be updated or
// instruction[19:16] => Rn
// instruction[15:12] Rd
//
// not
// instruction[11:0] => shifter operand
//
// To generate 32 bit immediate, we sometimes use rotate
//

always @ (*)
begin
  // since data can always be fetched independent of its usage
  rd_addr1 = instruction[3:0];
  rd_addr2 = instruction[11:8]; // is it always the case?
  // generate rotated operand
  if (instruction[27:25] == 3'b001)
  begin
    case(instruction[11:8])
      0 : comb_operand1 = (instruction[7:0] >> 0 ) | (instruction[7:0] << 32 );
      1 : comb_operand1 = (instruction[7:0] >> 1 ) | (instruction[7:0] << 31 );
      2 : comb_operand1 = (instruction[7:0] >> 2 ) | (instruction[7:0] << 30 );
      3 : comb_operand1 = (instruction[7:0] >> 3 ) | (instruction[7:0] << 29 );
      4 : comb_operand1 = (instruction[7:0] >> 4 ) | (instruction[7:0] << 28 );
      5 : comb_operand1 = (instruction[7:0] >> 5 ) | (instruction[7:0] << 27 );
      6 : comb_operand1 = (instruction[7:0] >> 6 ) | (instruction[7:0] << 26 );
      7 : comb_operand1 = (instruction[7:0] >> 7 ) | (instruction[7:0] << 25 );
      8 : comb_operand1 = (instruction[7:0] >> 8 ) | (instruction[7:0] << 24 );
      9 : comb_operand1 = (instruction[7:0] >> 9 ) | (instruction[7:0] << 23 );
      10: comb_operand1 = (instruction[7:0] >> 10) | (instruction[7:0] << 22);
      11: comb_operand1 = (instruction[7:0] >> 11) | (instruction[7:0] << 21);
      12: comb_operand1 = (instruction[7:0] >> 12) | (instruction[7:0] << 20);
      13: comb_operand1 = (instruction[7:0] >> 13) | (instruction[7:0] << 19);
      14: comb_operand1 = (instruction[7:0] >> 14) | (instruction[7:0] << 18);
      15: comb_operand1 = (instruction[7:0] >> 15) | (instruction[7:0] << 17);
    endcase
  end
  else if (instruction[27:25] == 3'b000 )
  begin // reg_ops
    if (instruction[6:4] == 3'b000)
    begin // LSL with immediate
      //write code to generate carries
      comb_operand1 = rd_data1 << instruction[11:7];
    end // LSL with immediate
    else if (instruction[7:4] == 4'h1)
    begin // LSL with register
      comb_operand1 = rd_data1 << rd_data2;
    end // LSL with register
    else if (instruction[6:4] == 3'b010)
    begin // LSR with immediate
      comb_operand1 = rd_data1 >> instruction[11:7];
    end // LSR with immediate
    else if (instruction[7:4] == 4'b0011)
    begin // LSR with immediate
      comb_operand1 = rd_data1 >> rd_data2;
    end // LSR with immediate
    else if (instruction[6:4] == 3'b100)
    begin // ASR with immediate
      comb_operand1 = {({32{rd_data1[31]}} << (32 - instruction[11:7])) | rd_data1 >> instruction[11:7]};
      //comb_operand1 = {32{1'b1}}  | (rd_data1 >> instruction[11:7]);
    end // ASR with immediate
    else if (instruction[7:4] == 4'b0101)
    begin // ASR with register 
      if (rd_data2 < 32)
        comb_operand1 = ({32{rd_data1[31]}} << (32 - rd_data2)) | (rd_data1 >> rd_data2);
      else
        comb_operand1 = {32{rd_data1[31]}};
    end  // ASR with register
  end // reg_ops

  /* ======== Load Store Operations ==============*/
  // in case of most of load/store operations, offset value or register value
  // needs to be added to the base register and data needs to be written to
  // that particular register. Hence, we manipulate the operands and in ALU
  // phase we calculate the address to which we need to load or store
  // Instruction[24] is called P bit which specifies if we use post indexed
  // addressing or pre indexed addressing
  // Instruction[23] is called U bit which specifies whether we need to add
  // the offset or subtract it
  // Instruction[22] is called W bit which specifies if its an unsigned byte
  // or word access
  // Instruction[21] is called W bit, which when P=0 normal mem access is
  // performed with W=0 and unprevileged access when W=1. When P=1, W=0 base
  // is not updated, W=1 base is updated
  // Instruction[20] is L which distinguishes between Load and store
  /* ======== Load Store Operations ==============*/
  else if (instruction[27:25] == 3'b010)
  begin
  end
end

always @(posedge clk)
begin
  operand1 <= #1 comb_operand1;
end









endmodule
