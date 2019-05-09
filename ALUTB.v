module Testbench();
  //A, B, branch_addr, op, CLK, out, co_flag, zero_flag
  reg[7:0] in1, in2;
  reg[2:0] op;
  reg[5:0] addr;
  reg CLK;
  wire CO, BRANCH, EQ;
  wire[7:0] result;
  ALU alu(in1, in2, addr, op, CLK, result, CO, EQ, BRANCH);
  initial begin
    //initialized everythign to zero
    CLK <= 1'b0;
    #5 in1 <= 8'b0; in2 <= 8'b0; addr <= 6'b0; op <= 3'b0;
    // Test Add
    #10 in1 <= 8'b10010; in2 <= 8'b11; op <= 3'b1;
    $display("%d + %d = d", in1, in2, result);
    #10 in1 <= 8'b11111111; in2 <= 8'b11111111;
    $display("%d + %d = d", in1, in2, result);
    #10 in1 <= 8'b00000000; in2 <= 8'b00000001;
    $display("%d + %d = d", in1, in2, result);
    // Test Sub
    #10 in1 <= 8'b0; in2 <= 8'b111; op <= 3'b010;
    $display("%d + %d = d", in1, in2, result);
    #10 in1 <= 8'b111; in2 <= 8'b111;
    $display("%d + %d = d", in1, in2, result);
    // Test And
    #10 in1 <= 8'b101; in2 <= 8'b10101; op <= 3'b011;
    $display("%b & %b = %b", in1, in2, result);
    #10 in1 <= 8'b0; in2 <= 8'b11111111;
    $display("%b & %b = %b", in1, in2, result);
    #10 in1 <= 8'b11111111;
    $display("%b & %b = %b", in1, in2, result);
    //Test Not
    #10 in1 <= 8'b0; op <= 3'b100;
    $display("~ %b = %b", in1, result);
    //Test or
    #10 in1 <= 8'b10101; in2 <= 8'b11; op <= 3'b101;
    $display("%b | %b = %b", in1, in2, result);
    #10 in1 <= 8'b11111111; in2 <= 8'b0;
    $display("%b | %b = %b", in1, in2, result);
    // Test EQ
    #10 in1 <= 8'b10101; in2 <= 8'b10101; op <= 3'b110;
    $display("%b == %b = %d", in1, in2, result);
    #10 in1 <= 8'b11; in2 <= 8'b0;
    //Test BRANCH with EQ
    #10 in1 <= 8'b10101; in2 <= 8'b10101; op <= 3'b110;
    $display("%b == %b = %d", in1, in2, result);
    #10 addr <= 100100; op <= 3'b111;
    $display("addr = %b, result = %b", addr, result);
    #10 in1 <= 8'b10111; in2 <= 8'b10101; op <= 3'b110;
    $display("%b == %b = %d", in1, in2, result);
    #10 addr <= 101100; op <= 3'b111;
    $display("addr = %b, result = %b", addr, result);
  end
  always begin
    #5 CLK = ~CLK
  end
  always begin
    #10 $display("op = %b, A = %b, B = %b, flags[B: %b, C: %b, E: %b], result = %b",
                 op, in1, in2, BRANCH, CO, EQ, result);
    if (BRANCH) begin
      $display("Branch addr = %b", addr);
    end
endmodule //
