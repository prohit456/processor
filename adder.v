module adder (input [3:0] din0, input[3:0] din1, output reg[3:0] dout);

reg[4:0] carry;

always @(*)
begin
  carry[0] <= 0;
  dout[0] <= din0[0] ^ din1[0] ^ carry[0];
  carry[1] <= (carry[0] & din0[0]) | (carry[0] & din1[0]) | (din0[0] & din1[0]);

  dout[1] <= din0[1] ^ din1[1] ^ carry[1];
  carry[2] <= (carry[1] & din0[1]) | (carry[1] & din1[1]) | (din0[1] & din1[1]);
  
  dout[2] <= din0[2] ^ din1[2] ^ carry[2];
  carry[3] <= (carry[2] & din0[2]) | (carry[2] & din1[2]) | (din0[2] & din1[2]);

  dout[3] <= din0[3] ^ din1[3] ^ carry[3];
  carry[4] <= (carry[3] & din0[3]) | (carry[3] & din1[3]) | (din0[3] & din1[3]);

end


endmodule


module testbench();

logic[3:0] din0;
logic [3:0] din1;
wire[3:0] dout;
adder ad (.din0(din0),
          .din1(din1),
          .dout(dout));


initial begin
$monitor("%0d, ip0:%x, ip1:%x, op:%x\n", $time, din0, din1, dout);
end
initial
begin
$display("initial\n");
din0 = 5;
din1 = 7;

#5;
din0 = 5;
din1 = 8;

#5;
din0 = 3;
din1 = 8;
end

endmodule
