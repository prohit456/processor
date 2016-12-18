// use geda
module div();

reg[31:0] num, den,  rem;
wire[31:0] quo;
reg[31:0] shifted_den, tmp_num;
reg[31:0] delayed_shifted_den, delayed_num;
reg clk;
reg div_en;
wire vld;



// clock module to run subtractions at a faster rate
always
begin
  #10 clk <= ~clk;
end

initial
begin
  clk = 1'b0;
end

divider_module dm(.clk(clk), 
                   .num(num),
                   .den(den),
                   .q(quo),
                   .vld(vld));
// shift the register such that msb is one
always @(den, num)
begin
   if (den[3])
   begin
     shifted_den = den;
     $display("3\n");
   end
   else if (den[2])
   begin
     shifted_den = {den[2:0], 1'b0};
     $display("2\n");
   end
   else if (den[1])
   begin
     shifted_den = {den[1:0], 2'b00};
     $display("1\n");
   end
   else if (den[0])
   begin
     shifted_den = {den[0], 3'b000};
     $display("0\n");
   end
end

// to check if the numerator or denominator changed


//initial
//begin
//$monitor("%0d:a:%0x, b:%0x\n", $time, dm.a, dm.b);
//end


initial begin

$monitor("%0d:num:%x, den:%x, quo:%x vld:%x, div_en:%0d\n", $time, num, den, quo, vld, div_en);
den = 1;
#3000;
num = 4;
den = 2;
#5000;
num = 8;
den = 2;
#5000;
num = 9;
den = 2;
#5000;
num = 9;
den = 3;
#5000;
num = 90;
den = 4;
#5000;
$finish;

end

initial
begin
    $dumpfile("test.vcd");
    $dumpvars(0,div);
end
   

endmodule


module divider_module(input clk, input[31:0] num, input[31:0] den, output reg[31:0] q, output reg vld);

reg[31:0] a, b;
wire[31:0] c;
wire c_out;
wire end_of_d;
reg  div_en;
reg [31:0] shifted_den;
reg [31:0] delayed_shifted_den;
reg [31:0] delayed_num;
reg stop_div;

//priority mux logic which makes denominator shifted such that msb of the
//resultant 32bit is 1
always @(den, num)
begin
   if (den[31])
   begin
     shifted_den = den;
   end
   else if (den[30])
   begin
     shifted_den = {den[30:0], 1'b0};
   end
   else if (den[29])
   begin
     shifted_den = {den[29:0], 2'b00};
   end
   else if (den[28])
   begin
     shifted_den = {den[28:0], 3'b000};
   end
   else if (den[27])
   begin
     shifted_den = {den[27:0], 4'd0};
   end
   else if (den[26])
   begin
     shifted_den = {den[26:0], 5'd0};
   end
   else if (den[25])
   begin
     shifted_den = {den[25:0], 6'd0};
   end
   else if (den[24])
   begin
     shifted_den = {den[24:0], 7'd0};
   end
   else if (den[23])
   begin
     shifted_den = {den[23:0], 8'd0};
   end
   else if (den[22])
   begin
     shifted_den = {den[22:0], 9'd0};
   end
   else if (den[21])
   begin
     shifted_den = {den[21:0], 10'd0};
   end
   else if (den[20])
   begin
     shifted_den = {den[20:0], 11'd0};
   end
   else if (den[19])
   begin
     shifted_den = {den[19:0], 12'd0};
   end
   else if (den[18])
   begin
     shifted_den = {den[18:0], 13'd0};
   end
   else if (den[17])
   begin
     shifted_den = {den[17:0], 14'd0};
   end
   else if (den[16])
   begin
     shifted_den = {den[16:0], 15'd0};
   end
   else if (den[15])
   begin
     shifted_den = {den[15:0], 16'd0};
   end
   else if (den[14])
   begin
     shifted_den = {den[14:0], 17'd0};
   end
   else if (den[13])
   begin
     shifted_den = {den[13:0], 18'd0};
   end
   else if (den[12])
   begin
     shifted_den = {den[12:0], 19'd0};
   end
   else if (den[11])
   begin
     shifted_den = {den[11:0], 20'd0};
   end
   else if (den[10])
   begin
     shifted_den = {den[10:0], 21'd0};
   end
   else if (den[9])
   begin
     shifted_den = {den[9:0], 22'd0};
   end
   else if (den[8])
   begin
     shifted_den = {den[8:0], 23'd0};
   end
   else if (den[7])
   begin
     shifted_den = {den[7:0], 24'd0};
   end
   else if (den[6])
   begin
     shifted_den = {den[6:0], 25'd0};
   end
   else if (den[5])
   begin
     shifted_den = {den[5:0], 26'd0};
   end
   else if (den[4])
   begin
     shifted_den = {den[4:0], 27'd0};
   end
   else if (den[3])
   begin
     shifted_den = {den[3:0], 28'd0};
   end
   else if (den[2])
   begin
     shifted_den = {den[2:0], 29'd0};
   end
   else if (den[1])
   begin
     shifted_den = {den[1:0], 30'd0};
   end
   else if (den[0])
   begin
     shifted_den = {den[0:0], 31'd0};
   end
end

always @(posedge clk)
begin
  delayed_shifted_den <= #1 shifted_den;
  delayed_num  <= #1 num;
end

always @(posedge clk)
begin
   if ((delayed_shifted_den != shifted_den) | (delayed_num != num))
   begin
     div_en <= #1 1;
   end
   else
   begin
     div_en <= #1 0;
   end
end



sub s(.a(a), .b(b), .c(c), .ns_b(den), .c_out(c_out), .eod(end_of_d));

always @(posedge clk)
begin
  if (div_en == 1)
  begin
    $display("pulse is one\n");
    a <= #1 num;
    b <= #1 shifted_den;
    q <= 32'd0;
    vld <= #1 1'b0;
    stop_div <= #1 1'b0;
  end

  else if (!end_of_d)
  begin
             q <= #1 {q[30:0], !c_out};
             a <= #1 (c_out == 1'd1) ? a : c;
             b <= #1 b >> 1'b1;
  end
  
  else if (stop_div == 0)
  begin
    q <= #1 {q[30:0], !c_out};
    vld <= #1 1'b1;
    stop_div <= #1 1;
  end

end


endmodule


module sub( input[31:0] a, input[31:0] b, input[31:0] ns_b, output reg[31:0] c, output reg c_out, output reg eod);


reg[32:0] tmp_c;
always @(*)
begin
  tmp_c = {1'b1, a} - b; 
  c_out =  ~tmp_c[32];
  c =  tmp_c[31:0];
  if (ns_b == b)
  begin
      eod = 1;
  end
  else
  begin
      eod = 0;
  end
  
end

initial
begin
  $display("inside inuitial\n");
end

endmodule

