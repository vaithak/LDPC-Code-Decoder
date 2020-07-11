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
    X=1;
    Y=1;
    C_in=1;
    #5
    X=0;
    Y=1
    C_in=0;
    #6
    X=1;
    Y=0;
    C_in=0;
    #5
    X=1;
    Y=0
    C_in=1;
    #5;
    X=0;
    Y=1;
    C_in=1;
    #5;
    X=1;
    Y=1;
    C_in=1
    #2 $finish;

  end

endmodule
