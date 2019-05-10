module processor(clk, in_addr1, in_addr2, opcode, branch_addr, dest_addr, wr_success, branch_out, branch_flag);
  //Instructions
  //OPCODE = 11:9
  //CREG = 8:6
  //AREG = 5:3
  //BREG = 2:0
  //BRANCH ADDR = 5:0
  input clk;
  input[2:0] in_addr1, in_addr2, dest_addr, opcode;
  input[5:0] branch_addr;
  output wr_success;
  output reg[7:0] branch_out;
  output reg branch_flag;
  reg[7:0] alu_in1, alu_in2, alu_out, wr_data;
  reg co_flag, eq_flag, rd_en1, rd_en2, wr_en;
  ALU alu(alu_in1, alu_in2, branch_addr, opcode, clk, alu_out, co_flag, eq_flag, branch_flag);
  register_file RAM(clk, in_addr1, in_addr2, rd_en1, rd_en2, dest_addr, wr_en, wr_data, alu_in1, alu_in2, wr_success);

  //control logic here
  always @(in_addr1 or in_addr2 or opcode) begin
    case(opcode)
      3'b000:begin //nothing
        rd_en1 <= 1'b0;
        rd_en2 <= 1'b0;
        wr_en <= 1'b0;
      end
      3'b001:begin //add
        rd_en1 <= 1'b1;
        rd_en2 <= 1'b1;
        wr_en <= 1'b1;
      end
      3'b010: begin //sub
        rd_en1 <= 1'b1;
        rd_en2 <= 1'b1;
        wr_en <= 1'b1;
      end
      3'b011: begin //and
        rd_en1 <= 1'b1;
        rd_en2 <= 1'b1;
        wr_en <= 1'b1;
      end
      3'b100: begin //not
        rd_en1 <= 1'b1;
        rd_en2 <= 1'b0;
        wr_en <= 1'b1;
      end
      3'b101: begin //or
        rd_en1 <= 1'b1;
        rd_en2 <= 1'b1;
        wr_en <= 1'b1;
      end
      3'b110: begin //equal
        rd_en1 <= 1'b1;
        rd_en2 <= 1'b1;
        wr_en <= 1'b1;
      end
      3'b111: begin //branch
        rd_en1 <= 1'b1;
        rd_en2 <= 1'b0;
        wr_en <= 1'b0;
        if(branch_flag) branch_out=alu_out;
      end
    endcase
  end
endmodule
