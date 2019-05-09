// Testbench for verilog register system.

// Testbench for verilog register system.

module Mem_Testbench ();
  reg clk, RD_en1, RD_en2, WR_en;
  reg[2:0] RD_addr1, RD_addr2, WR_addr;
  reg[7:0] WR_data;
  wire wr_success;
  wire[7:0] RD_out1, RD_out2;
  register_file reg_file(clk, RD_addr1, RD_addr2, RD_en1, RD_en2, WR_addr, WR_en, WR_data,
                         RD_out1, RD_out2, wr_success);
  initial begin
    clk = 1'bx; RD_en1 = 1'b0; RD_en2 = 1'b0;
    RD_addr1 = 3'b0; RD_addr2 = 3'b0; WR_addr = 3'b0;
    $monitor("wr_success = %b, RD_out = %b, RD_out2 = %b", wr_success, RD_out1, RD_out2);
    //First Read with nothing
    clk <= 1'b1;
    //Test write to reg_addr 1 with value
    #5
    clk <= 1'b0; WR_en <= 1'b1; WR_addr <= 3'b001; WR_data <= 8'b0011;
    // Test Read from reg_addr 1 from prev write
    #5
    clk <= 1'b1; RD_en1 <= 1'b1; RD_en2 <= 1'b0;
    RD_addr1 <= 3'b001; RD_addr2 <= 3'b0;
    // Test Write to reg_addr 2 with value
    #5
    clk <= 1'b0; WR_en <= 1'b1; WR_addr <= 3'b001; WR_data <= 8'b0101;
    // Test Read from reg_addr 2 from prev
    #5
    clk <= 1'b1; RD_en1 <= 1'b0; RD_en2 <= 1'b1;
    RD_addr1 <= 3'b0; RD_addr2 <= 3'b010;
    // Test Read from two values at the same time
    #5 clk <= 0'b0;
    #5
    clk <= 1'b1; RD_en1 <= 1'b1; RD_en2 <= 1'b1;
    RD_addr1 <= 3'b001; RD_addr2 <= 3'b010;
    $finish;
  end
endmodule
