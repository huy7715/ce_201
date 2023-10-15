typedef enum logic [2:0] 
{
    ADD_SEL = 3'b000,
    SUB_SEL = 3'b001,
    SHR_SEL = 3'b010,
    SHL_SEL = 3'b011,
	AND_SEL = 3'b100,
    OR_SEL =  3'b101,
    XOR_SEL = 3'b110,
    NOT_SEL = 3'b111
}   alu_sel_t;  
module alu #(parameter WIDTH=32)
   (
    input logic [WIDTH-1:0]  in0,
    input logic [WIDTH-1:0]  in1,
    input alu_sel_t          sel,
    output logic             neg,
    output logic             pos,
    output logic             zero, 
    output logic [WIDTH-1:0] out
    );
      
   always_comb begin   
      case (sel)
        ADD_SEL : out = in0 + in1;
        SUB_SEL : out = in0 - in1;
        SHR_SEL : out = in0 >> 1;
        SHL_SEL : out = in0 <<1;
        AND_SEL : out = in0 & in1;
        OR_SEL  : out = in0 | in1; 
        XOR_SEL : out = in0 ^ in1;
        NOT_SEL : out = ~in0;
      endcase
   end

   // Use concurrent assignments for the flags. Logic types of unsigned by
   // default so we need to cast them to signed here.
   assign neg = signed'(out) < 0;
   assign pos = signed'(out) > 0;
   assign zero = out == 0;
endmodule

module alu_top
  #(
    parameter WIDTH=32
    )
   (
    input logic [WIDTH-1:0]  in0,
    input logic [WIDTH-1:0]  in1,
    input logic [2:0]        sel,
    output logic             neg,
    output logic             pos,
    output logic             zero, 
    output logic [WIDTH-1:0] out
    );
   alu #(.WIDTH(WIDTH)) alu (.sel(alu_sel_t'(sel)), .*);
   
endmodule 

