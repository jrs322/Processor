module register_file(clk, rd_addr1, rd_addr2, rd_en1, rd_en2, wr_addr, wr_en, wr_data
                     rd_out1, rd_out2, wr_success);
  input clk, rd_en1, rd_en2, wr_en;
  input[2:0] rd_addr1, rd_addr2, wr_addr;
  input[7:0] wr_data; 
  output[7:0] rd_out1, rd_out2;
  output reg wr_success;
  reg[7:0] reg_file[7:0] //creates 8 x 1 byte array
  initial begin
    generate
      genvar i;
      for (i = 0; i < 8; i = i + 1)
        begin
          reg_file[i] <= 8'b0;
          $display("initialized file %d, data = %b", i, reg_file[i]);
        end
    endgenerate
  end
  always @ (posedge clk )
    begin
      wr_success <= 1'b0;
      if(rd_en1)
        begin
          rd_out1 <= reg_file[rd_addr1];
          $display("read_enable = 1 and rd_out1 = %b rd_addr = %b", rd_out1, rd_addr1);
        end
      if(rd_en2)
        begin
          rd_out2 <= reg_file[rd_addr2];
          $display("read_enable = 1 and rd_out2 = %b rd_addr = %b", rd_out2, rd_addr2);
      else
        $display("nothing enabled not reading")
    end
  always @ (negedge clk )
    begin
      if (wr_en)
        begin
          reg_file[wr_addr] <= wr_data;
          wr_success <=1'b1;
          $display("with wr_en, wr_addr = %b wr_data = %b", wr_addr, wr_data);
        end
      else
        $display("")
    end
    always begin
      $monitor("reg0 = %d reg1 = %d reg2 = %d reg3 = %d reg4 = %d reg5 = %d reg6 = %d reg7 = %d",
                reg_file[0], reg_file[1], reg_file[2], reg_file[3], reg_file[4], reg_file[5]. reg_file[6], reg_file[7]);
    end

endmodule //
