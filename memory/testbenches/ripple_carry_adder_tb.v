module tb();
  
  reg[5:0] X,Y; //reg X,Y,C_in are register to store information
  reg C_in;
  wire C_out ;
  wire [5:0] S;  //wire is used to pass on information from c_out of one full adder to other full adder's C_in
  
  ripple_adder dut(
    .X(X),                       //preparing X,Y,C_in,C_out for test cases
    .Y(Y),
    .C_in(C_in),
    .S(S),
    .C_out(C_out)
  );
  initial begin
    $dumpvars(1,tb);         //dumping variable to conduct simulation
    #5;
    X=0;
    Y=0;
    C_in=0;
    #5;
    X=4;
    Y=5;
    C_in=1;
    #5
    X=4'b1000;
    Y=4'b0100;
    #5
    C_in=1;
    
  end
  
endmodule
    
    
