module halfCounter(input logic sys_clk, output logic clk_out);

always_ff @(posedge sys_clk)
  begin
		clk_out <= ~clk_out;
  end

endmodule