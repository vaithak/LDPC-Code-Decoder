module full_adder 
  (
   i_bit1,
   i_bit2,
   i_carry,
   o_sum,
   o_carry
   );
 
  input  i_bit1;
  input  i_bit2;
  input  i_carry;
  output o_sum;
  output o_carry;
 
  wire   w_WIRE_1;
  wire   w_WIRE_2;
  wire   w_WIRE_3;
       
  assign w_WIRE_1 = i_bit1 ^ i_bit2;
  assign w_WIRE_2 = w_WIRE_1 & i_carry;
  assign w_WIRE_3 = i_bit1 & i_bit2;
 
  assign o_sum   = w_WIRE_1 ^ i_carry;
  assign o_carry = w_WIRE_2 | w_WIRE_3;
   
endmodule // full_adder