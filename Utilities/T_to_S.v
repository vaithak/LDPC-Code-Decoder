/*-------------------------------------------------------------------------------
This module converts the input, represented in two's complement format, to sign-magnitude format.
For example: input = 111010  
             the first bit of the input being one indicates that it is a negative number.
             the two's complement of the input(add one extra 0 bit, input= 0111010) will be the output
             output= 1000110
--------------------------------------------------------------------------------*/

module T_to_S #(
  parameter DATA_WIDTH = 6
)
  
  //port declarations
(
  //input port
  input wire  [DATA_WIDTH - 1 : 0] inp,
  
  //output port
  output wire [DATA_WIDTH : 0] out      // 'out' will have one extra bit than 'inp'
);

  //register to store values assigned in the procedural block
reg [DATA_WIDTH : 0] x;

  //procedural block 
always @* begin
  if (inp[DATA_WIDTH-1] == 1'b1)         //if number is negative:
    x = (~inp)+1;                        //two's complement will do the required conversion                         
  else
    x = inp;                             //representation of a positive number is same in both formats
end

assign out = x;                          //outputs the value stored in register x 

endmodule
