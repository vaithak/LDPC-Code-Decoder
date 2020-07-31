`include "VNU/VNU.v"
module VNUTest;
  //ports to instantiate in the module
  reg  [3-1 : 0][5-1 : 0] X;
  reg  [5-1 : 0]          Z;
  reg                     clk;
  reg                     en;
  wire [3-1 : 0][6-1 : 0] Y;
  wire                    hard_decision;

  VNU VNUTestModule
  (
    .X(X),
    .Z(Z),
    .clk(clk),
    .en(en),
    .Y(Y),
    .hard_decision(hard_decision)
  );

  //creating clock
  initial begin
    clk = 1'b1;
  end
  always #5 clk = ~clk;

  //testbench starts here
  initial begin
    $dumpvars(0, VNUTest);
    #2; // for the input to receive correctly

    //inputs
    X[0] = 5'd10;
    X[1] = 5'd25;
    X[2] = 5'd28;
    Z    = 5'd21;
    en = 1'b1;
    #20;
    $display("%b %b %b %b", hard_decision, Y[0], Y[1], Y[2]);

    X[0] = 5'd21;
    X[1] = 5'd3;
    X[2] = 5'd17;
    Z    = 5'd28;
    #20;
    $display("%b %b %b %b", hard_decision, Y[0], Y[1], Y[2]);

    X[0] = 5'd31;
    X[1] = 5'd31;
    X[2] = 5'd31;
    Z    = 5'd31;
    #20;
    $display("%b %b %b %b", hard_decision, Y[0], Y[1], Y[2]);

    X[0] = 5'd12;
    X[1] = 5'd5;
    X[2] = 5'd3;
    Z    = 5'd10;
    #20;
    $display("%b %b %b %b", hard_decision, Y[0], Y[1], Y[2]);

    X[0] = 5'd0;
    X[1] = 5'd0;
    X[2] = 5'd0;
    Z    = 5'd0;
    #20;
    $display("%b %b %b %b", hard_decision, Y[0], Y[1], Y[2]);

    X[0] = 5'd1;
    X[1] = 5'd2;
    X[2] = 5'd3;
    Z    = 5'd4;
    #20;
    $display("%b %b %b %b", hard_decision, Y[0], Y[1], Y[2]);
    $finish;
  end
endmodule
