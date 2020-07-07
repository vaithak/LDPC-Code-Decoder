module AG #
(
  parameter NUM_BITS = 8, //number of bits in the counter
  parameter COUNT_FROM = 0 //point where counting starts
)
(
  input  logic                    clk, //clock
  input  logic                    enable, //module enabling signal
  input  logic                    reset, //reset input
  output logic [NUM_BITS - 1 : 0] address //the address generated
);
  always @ (posedge clk) begin
    if(reset && enable) address <= COUNT_FROM;
    else if(enable) address <= address + 1;
  end
endmodule
