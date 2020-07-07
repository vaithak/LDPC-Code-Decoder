`include "AG.v"
module AgTest #
(
  parameter NUM_BITS = 8,
  parameter COUNT_FROM = 0
);
  logic clk = 1;
  always #5 clk = ~clk;

  //initializing wires to instantiate module
  logic                    enable;
  logic                    reset;
  logic [NUM_BITS - 1 : 0] address;

  //instantiating the module
  AG #(NUM_BITS, COUNT_FROM) Agtest_module(
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .address(address)
  );

  //test cases begins here
  integer i;
  initial begin
    $dumpfile("AG_test.vcd");
    $dumpvars(0, AgTest);

    #2; //to ensure input is given correctly

    //to initialize the address generator
    reset = 1'b1;
    enable = 1'b1;
    #10;

    //the actual test case
    //the expected answer is 1 2 3 4 5 6 7 8 9 10 10 10 11 12 12 12 13 14
    reset = 1'b0;
    for(i = 0; i < 10 ; i = i + 1) begin
      #10;
      $display("%d", address);
    end

    enable = 1'b0;
    #10;
    $display("%d", address);
    #10;
    $display("%d", address);

    enable = 1'b1;
    #10;
    $display("%d", address);
    #10;
    $display("%d", address);

    enable = 1'b0;
    #10;
    $display("%d", address);
    #10;
    $display("%d", address);

    enable = 1'b1;
    #10;
    $display("%d", address);
    #10;
    $display("%d", address);
    $display("over");
    $finish;
  end
endmodule
