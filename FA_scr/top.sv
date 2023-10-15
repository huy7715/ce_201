module btvn(
    input clk,Cin,
    input [63:0] X,
    input [63:0] Y,
    input reset,
    output Cout,
    output [63:0] S
    );

ff_1bit ff_1bit1 (.clk(clk),.reset(reset),.x_reg(X),.x_out(A));
ff_1bit ff_1bit2 (.clk(clk),.reset(reset),.x_reg(Y),.x_out(B));
ff_1bit ff_1bit3 (.clk(clk),.reset(reset),.x_reg(Cin),.x_out(in));

fulladder fulladder1 (.A(A),.B(B),.in(in),.Sum(Sum),.out(out));

ff_1bit ff_1bit4 (.clk(clk),.reset(reset),.x_reg(out),.x_out(Cout));
ff_1bit ff_1bit5 (.clk(clk),.reset(reset),.x_reg(Sum),.x_out(S));

endmodule
module fulladder(A,B,in,Sum,out);
input [63:0] A, B;
input in;
output [63:0] Sum;
output out;
     assign Sum = A ^ B ^ in;
     assign   out = (A & B) | (B & in) | (A & in);
endmodule
module ff_1bit(input clk,reset,x_reg,
          output reg x_out
           );
   always@(posedge clk or negedge reset)
begin
   if(~reset)
   x_out<=0;
   else
   x_out<=x_reg;
end
endmodule