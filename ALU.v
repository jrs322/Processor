module ALU(A, B, branch_addr, instr, out, co_flag, eq_flag, branch_flag);
  //Creat an 8-bit ALU for a pipeline CPU
  //Instructions available ADD, SUB, INC, DEC, AND, OR, XOR, NOT
  input[7:0] A, B;
  input[2:0] instr;
  input[5:0] branch_addr;
  output reg [7:0] out;
  output reg co_flag;
  output reg eq_flag;
  output reg branch_flag;
  initial begin
    co_flag <= 1'b0;
    eq_flag <= 1'b0;
    branch_flag <= 1'b0;
  end
  always @ (A or B) begin
    case (instr)
      3'b000: begin
        $display("Do nothing");
        branch_flag <= 1'b0;
        co_flag <= 1'b0;
        eq_flag <= 1'b0;
      end
      3'b001: begin
        $display("Add A + B into C");
        {co_flag, out} = A + B;
        branch_flag <= 1'b0;
        eq_flag <= 1'b0;
      end
      3'b010: begin
        $display("Sub: A - B into C");
        {co_flag, out} = A - B;
        branch_flag <= 1'b0;
        eq_flag <= 1'b0;
      end
      3'b011: begin
        $display("And: A & B into C");
        out = A & B;
        co_flag <= 1'b0;
        eq_flag <= 1'b0;
        branch_flag <= 1'b0;
      end
      3'b100: begin
        $display("not: ~A into C");
        out = ~A;
        branch_flag <= 1'b0;
        co_flag <= 1'b0;
        eq_flag <= 1'b0;
      end
      3'b101: begin
        $display("or: A | B into C");
        out = A | B;
        branch_flag <= 1'b0;
        co_flag <= 1'b0;
        eq_flag <= 1'b0;
      end
      3'b110:begin
        $display("Equal: A==B = 00000001");
        if (A == B)
          begin
            $display("Equal");
            out = 8'b01;
            eq_flag <= 1'b1;
            branch_flag <= 1'b0;
            co_flag <= 1'b0;
          end
        else
          begin
            $display("Not equal");
            out = 8'b0;
            eq_flag <= 1'b0;
            branch_flag <= 1'b0;
            co_flag <= 1'b0;
          end
      end
      3'b111: begin
        if (eq_flag) begin
          $display("branched");
          out = {2'b0, branch_addr};
          eq_flag <= 1'b0;
          branch_flag <= 1'b1;
          co_flag <= 1'b0;
        end
        else begin// not taken
          $display("not branched");
          out = 8'b0;
          eq_flag <= 1'b0;
          branch_flag <= 1'b1;
          co_flag <= 1'b0;
        end
      end
      default: $display("invalid mode doing nothing");
    endcase
  end
endmodule //ALU 8 bit
