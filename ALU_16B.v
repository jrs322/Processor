
module ALU(A, B, instr, CLK, out, co_flag, zero_flag);
  //Creat an 8-bit ALU for a pipeline CPU
  //Instructions available ADD, SUB, INC, DEC, AND, OR, XOR, NOT
  input[7:0] A, B;
  input[2:0] instr;
  input CLK;
  output reg [7:0] out;
  output reg co_flag;
  output reg zero_flag;
  initial begin
    co_flag <= 1'b0;
    zero_flag <= 1'b0;
    branch_flag <= 1'b0;
  end
  always @ (posedge CLK ) begin
    generate
      genvar i;
      for(i=0; i < 8; i= i + 1) begin
        if(A[i]===1'bX or B[i] == 1'bx) $display("bus[%0d] is X",bus[i]);
        if(A[i]===1'bZ or B[i] == 1'bZ) $display("bus[%0d] is Z",bus[i]);
      end
      endgenerate
    case (instr)
      3'b000:
        begin //Do nothing
          $display("Doing Nothing");
        end
      3'b001:
        begin //ADD
          {co_flag, out} <= A + B;
          $display("Operation = ADD, result = %b", {co_flag, out});
        end
      3'b010:
        begin //SUB
          {co_flag, out} <= A - B;
          $display("Operation = SUB, result = %b", {co_flag, out});
        end
      3'b011:
        begin //AND
          out <= A & B;
          $display("Operation = AND, result = %b", out);
        end
      3'b100:
        begin //NOT
          out <= ~A;
          $display("Operation = NOT, result = %b", out);
        end
      3'b101:
        begin //BRANCH if input == C
          if 
        end
      3'b110:
        begin
        end
      3'b111:
        begin
        end
      default: #display("invalid mode doing nothing");
    endcase
  end
endmodule //ALU 8 bit
