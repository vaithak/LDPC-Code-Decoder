// 1-bit full adder

module fulladder(
  input X,
  input Y,                //1 bit input define X,C_in,Y
  input C_in, 

  output S,           //1 bit output define S,C_out
  output C_out
  );

  wire w1,w2,w3;

  // Computing Sum (S)
  xor gate_1(w1, X, Y);            //xor,or and and GATE with input a and output b,c when defined as XOR/AND/OR gate(a,b,c)
  xor gate_2(S, w1, C_in);

  // Computing Carry (C_out)
  and gate_3(w2, X, Y);
  and gate_4(w3, w1, C_in);
  or gate_5(C_out, w2, w3);

endmodule



//testbench for full adder

module fulladder_tb();
  
  reg X,Y;// Inputs

  reg C_in;
  
  wire C_out ;   // Outputs
  wire  S;
  
  fulladder dut(              // Instantiate the Unit Under Test (UUT)    
    .X(X),
    .Y(Y),
    .C_in(C_in),
    .S(S),
    .C_out(C_out)
  );
  initial begin
    $dumpvars(1,tb);                    //to enable EPWave after run
    #2;                               //delay of 2ms and initializing inputs
    X=0;
    Y=0;
    C_in=0;
    
    #2;
    C_in=1;
   
    #2;
    X=3;
    Y=4;
    C_in=1;
    #5
    C_in=0;
    #6
    X=7;
    Y=9;
    #5
    C_in=1;
    #2
    X=4b'1000;
    Y=4b'1010;
    
    #2 $finish;
    
  end
  
endmodule
    
    

