`include "CNU/CNU.v"
module CNUTest;
  //ports to instantiate in the module
  reg  [6-1 : 0][6-1 : 0] X;
  reg                     clk;
  reg                     en;
  wire [6-1 : 0][5-1 : 0] Y;
  wire                    p_bit;

  CNU CNUTestModule
  (
    .X(X),
    .clk(clk),
    .en(en),
    .Y(Y),
    .p_bit(p_bit)
  );

  //creating clock
  initial begin
    clk = 1'b1;
  end
  always #5 clk = ~clk;

  //testbench starts here
  initial begin
    $dumpvars(0, CNUTest);
    #2; // for the input to receive correctly

    //inputs
    X[0] = 6'b110101;
    X[1] = 6'b001010;
    X[2] = 6'b111001;
    X[3] = 6'b111100;
    X[4] = 6'b000011;
    X[5] = 6'b111111;
    en = 1'b1;
    #20;
    if(p_bit != 1'b0 || Y[0] != 5'b10000 || Y[1] != 5'b00000 || Y[2] != 5'b10000  || Y[3] != 5'b10000 || Y[4] != 5'b00000 || Y[5] != 5'b10000) begin
      $display("1st error exp: 0 10000 00000 10000 10000 00000 10000 %b %b %b %b %b %b %b", p_bit, Y[0], Y[1], Y[2], Y[3], Y[4], Y[5]);
      $finish;
    end
    else begin
      $display("1st PASSED!");
    end

    X[0] = 6'b110001;
    X[1] = 6'b100001;
    X[2] = 6'b000001;
    X[3] = 6'b000001;
    X[4] = 6'b100010;
    X[5] = 6'b000010;
    #20;
    if(p_bit != 1'b1 || Y[0] != 5'b00001 || Y[1] != 5'b10001 || Y[2] != 5'b10001 || Y[3] != 5'b10001 || Y[4] != 5'b10010 || Y[5] != 5'b10010) begin
      $display("2nd error exp: 1 00001 10001 10001 10001 10010 10010 act %b %b %b %b %b %b %b", p_bit, Y[0], Y[1], Y[2], Y[3], Y[4], Y[5]);
      $finish;
    end
    else begin
      $display("2nd PASSED!");
    end

    X[0] = 6'b101010;
    X[1] = 6'b011010;
    X[2] = 6'b000100;
    X[3] = 6'b100001;
    X[4] = 6'b110010;
    X[5] = 6'b010101;
    #20;
    if(p_bit != 1'b1 || Y[0] != 5'b10000 || Y[1] != 5'b00000 || Y[2] != 5'b10000 || Y[3] != 5'b10000 || Y[4] != 5'b00000 || Y[5] != 5'b00000) begin
      $display("3rd error exp: 1 10000 00000 10000 10000 00000 00000 act %b %b %b %b %b %b %b", p_bit, Y[0], Y[1], Y[2], Y[3], Y[4], Y[5]);
      $finish;
    end
    else begin
      $display("3rd PASSED!");
    end

    X[0] = 6'b110001;
    X[1] = 6'b000010;
    X[2] = 6'b100011;
    X[3] = 6'b000001;
    X[4] = 6'b110011;
    X[5] = 6'b010010;
    #20;
    if(p_bit != 1'b1 || Y[0] != 5'b00001 || Y[1] != 5'b10001 || Y[2] != 5'b10001 || Y[3] != 5'b10001 || Y[4] != 5'b00001 || Y[5] != 5'b00001) begin
      $display("4th error exp: 0 00001 10001 10001 10001 00001 00001 act %b %b %b %b %b %b %b", p_bit, Y[0], Y[1], Y[2], Y[3], Y[4], Y[5]);
      $finish;
    end
    else begin
      $display("4th PASSED!");
    end

    X[0] = 6'b101010;
    X[1] = 6'b010101;
    X[2] = 6'b111111;
    X[3] = 6'b000000;
    X[4] = 6'b110011;
    X[5] = 6'b001100;
    #20;
    $display("%b %b %b %b %b %b %b", Y[0], Y[1], Y[2], Y[3], Y[4], Y[5], p_bit);

    X[0] =6'd25;
    X[1] =6'd39;
    X[2] =6'd35;
    X[3] =6'd50;
    X[4] =6'd54;
    X[5] =6'd10;
    #20;
    $display("%b %b %b %b %b %b %b", Y[0], Y[1], Y[2], Y[3], Y[4], Y[5], p_bit);
    $finish;
  end
endmodule
