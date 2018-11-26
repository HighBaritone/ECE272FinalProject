module Lab6(input logic SYS_CLK, output logic HSYNC_PIN, output logic VSYNC_PIN,
output logic [3:0] R, output logic [3:0] G, output logic [3:0] B);

logic halfClock;
logic active;

halfCounter clk (.sys_clk(SYS_CLK), .clk_out(halfClock));

logic [9:0] x;
logic [9:0] y;

vga display(.clk(halfClock), .hSync(HSYNC_PIN), .vSync(VSYNC_PIN), .x(x), .y(y), .active(active));

logic [3:0] r;
logic [3:0] g;
logic [3:0] b;

assign r = y[3] | (x==256) ? 4'b1111: 4'b0000;
assign g = (x[5] ^ x[6]) | (x==256) ? 4'b1111: 4'b0000;
assign b = x[4] | (x==256) ? 4'b1111: 4'b0000;

always_ff @(posedge halfClock)
begin
	if(active == 1'b1) begin
		R <= r;
		G <= g;
		B <= b;
		end
	else begin
		R <= 4'b0000;
		G <= 4'b0000;
		B <= 4'b0000;
		end
end
endmodule