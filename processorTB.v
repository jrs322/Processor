module processor_Testbench();
  reg[11:0] program_counter[127:0];
  reg[11:0] instruction;
  integer count;
  wire[2:0] in_addr1, in_addr2, opcode, branch_addr, dest_addr;
  pipelined_processor processor(clk, in_addr1, in_addr2, opcode, branch_addr, dest_addr, wr_success, branch_out, branch_flag);
  initial begin
    //this would fill with a program counter full of code
    instruction = program_counter[0];
  end
  always @ (posedge clk) begin
    if (branch_flag) instruction = program_counter[branch_out];
    else
      begin
        count = count + 1;
        instruction = program_counter[count];
      end
  end
endmodule
