//module of 1-bit carry_adder

module fulladder(
  input X,   
  input Y, 
  input C_in, 

  output S, 
  output C_out
  );

  wire w1,w2,w3;

  // Computing Sum (S)
  xor gate_1(w1, X, Y);   //here w1 is result of xor gate respective inputs X,Y
  xor gate_2(S, w1, C_in);   //here S is result of xor gate respective inputs w1,C_in

  // Computing Carry (C_out)
  and gate_3(w2, X, Y);    //here w2 is result of and  gate respective inputs X,Y
  and gate_4(w3, w1, C_in);   //here w3 is result of xor gate respective inputs w1,C_in
  or gate_5(C_out, w2, w3);   //here C_out is result of or gate respective inputs w2,w3

endmodule


//6-bit adder module

module ripple_adder(
  input [5:0] X,
  input [5:0] Y,
  input C_in,
  output [5:0] S,
  output C_out
  );

 wire w1, w2, w3, w4, w5; //basiclly each wire is associated betwwen 6 full adder working as C_in in next full adder in series

 fulladder u1(X[0], Y[0], 1'b0, S[0], w1);
 fulladder u2(X[1], Y[1], w1, S[1], w2);
 fulladder u3(X[2], Y[2], w2, S[2], w3);
 fulladder u4(X[3], Y[3], w3, S[3], w4);
 fulladder u5(X[4], Y[4], w4, S[4], w5);
 fulladder u6(X[5], Y[5], w5, S[5], C_out);

endmodule 


