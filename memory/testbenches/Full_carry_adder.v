
module fulladder(
  input X,               //defining 1 bit input X,Y,C_in and output C_out,S
  input Y, 
  input C_in, 

  output S, 
  output C_out
  );

  wire w1,w2,w3;       //wires to act as output from one GATE to pass information as input of another GATE

  // Computing Sum (S)
  xor gate_1(w1, X, Y);                 // xor gate with output w1 and input X,Y
  xor gate_2(S, w1, C_in);               //  xor gate with output S and input w1,C_in

  // Computing Carry (C_out)
  and gate_3(w2, X, Y);
  and gate_4(w3, w1, C_in);              //and gate with output w3 and input w1,C_in
  or gate_5(C_out, w2, w3);                 //or gate with output C_out and input w2,w3

endmodule
