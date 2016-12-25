`include "processor_top.v"
module tb_processor_top();


  reg clk;
  processor_top processor_inst(clk);

  initial
  begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb_processor_top);
  end

  always begin
    #100 clk = ~clk;
  end



  always @(posedge clk)
  begin
    processor_inst.if_decoder_instruction = $urandom;
    processor_inst.if_decoder_instruction[27:25] = 0;
    processor_inst.decoder_reg_file_wr_addr = $urandom;
    processor_inst.decoder_reg_file_wr_data = $urandom;
    processor_inst.decoder_reg_file_wr_valid = $urandom;
  end

  initial
  begin
    processor_inst.reg_file_inst.reg0 = 0;
    processor_inst.reg_file_inst.reg1 = 1;
    processor_inst.reg_file_inst.reg2 = 2;
    processor_inst.reg_file_inst.reg3 = 3;
    processor_inst.reg_file_inst.reg4 = 4;
    processor_inst.reg_file_inst.reg5 = 5;
    processor_inst.reg_file_inst.reg6 = 6;
    processor_inst.reg_file_inst.reg7 = 7;
    processor_inst.reg_file_inst.reg8 = 8;
    processor_inst.reg_file_inst.reg9 = 9;
    processor_inst.reg_file_inst.reg10 = 10;
    processor_inst.reg_file_inst.reg11 = 11;
    processor_inst.reg_file_inst.reg12 = 12;
    processor_inst.reg_file_inst.reg13 = 13;
    processor_inst.reg_file_inst.reg14 = 14;
    processor_inst.reg_file_inst.reg15 = 15;
  end

  initial
  begin
    clk = 1'b0;
    #20000;
    $finish;
  end
endmodule
