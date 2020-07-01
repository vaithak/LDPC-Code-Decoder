`include"RAM_SP_SR_RW.v"  //including the module file to be instantiated
module RAM_SP_SR_RW_test #
(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 8,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
);
  // clocking
  logic     clk = 1;
  always #5 clk = ~clk;

  //creating the wires for the module
  logic [ADDR_WIDTH - 1 : 0] address;
  logic [DATA_WIDTH - 1 : 0] data_in;
  logic                      write_en = 1;
  logic                      chip_sel = 1;
  logic [DATA_WIDTH - 1 : 0] data_out;

  integer i;//for declaring memory in initial block

  //instantiating the module
  RAM_SP_SR_RW block_ram
  (
    .clk(clk),
    .address(address),
    .data_in(data_in),
    .write_en(write_en),
    .chip_sel(chip_sel),

    .data_out(data_out)
  );


  //test cases
  initial begin
    $dumpfile("RAM_SP_SR_RW_test.vcd");
    $dumpvars(0, RAM_SP_SR_RW_test);

    #2//a delay of 2 time units

    //writing some data onto the first Address
    address  = 8'd0;
    data_in  = 8'd75;
    write_en = 1'b1;
    chip_sel = 1'b1;
    #10

    //writing data onto the second Address
    address = 8'd1;
    data_in = 8'd13;
    #10

    //test case 1:reading output from the first Address
    address = 8'd0;
    write_en = 1'b0;
    if(data_out != 8'd75) begin
      $display("first address read expected:%x actual:%x", 8'd75,data_out);
      $finish;
    end

    //test case 2:reading input from the secong Address
    address = 8'd1;
    write_en = 1'b0;
    if(data_out != 8'd13) begin
      $display("second address read expected:%x actual:%x",8'd13,data_out);
      $finish;
    end

    //changing value of data at address 1
    address = 8'd0;
    write_en = 1'b1;
    data_in = 8'd24;

    //reading from the first address
    address = 8'd0;
    write_en = 1'b0;
    if(data_out != 8'd24) begin
      $display("first address read expected:%x actual:%x",8'd24,data_out);
      $finish;
    end
    $display("PASSED!!!");
    $finish;
  end
endmodule
