module PongTopLevel(input logic SYS_CLK, input logic kbData, input logic kbClock, output logic HSYNC_PIN, output logic VSYNC_PIN,
output logic [3:0] R, output logic [3:0] G, output logic [3:0] B);

logic halfClock;
logic active;

logic leftPaddleDraw;
logic rightPaddleDraw;

logic leftUp, leftDown;
KBTopLevel keyboard(.kbData(kbData), .kbClock(kbClock), .upButton(leftUp), .downButton(leftDown));

logic rightUp, rightDown;

assign rightUp = leftUp;
assign rightdown = leftDown;

logic border;

logic bothPaddles;

halfCounter clk (.sys_clk(SYS_CLK), .clk_out(halfClock));

logic [9:0] x;
logic [9:0] y;

vga display(.clk(halfClock), .hSync(HSYNC_PIN), .vSync(VSYNC_PIN), .x(x), .y(y), .active(active));

logic [3:0] r;
logic [3:0] g;
logic [3:0] b;

logic [9:0] leftPaddleYPos;
Paddle leftPaddle(.clk(VSYNC_PIN), .upButton(leftUp), .downButton(leftDown), .paddleCenterYPos(leftPaddleYPos));

logic [9:0] rightPaddleYPos;
Paddle rightPaddle(.clk(VSYNC_PIN), .upButton(rightUp), .downButton(rightDown), .paddleCenterYPos(rightPaddleYPos));

assign leftPaddleDraw = (((x == 25 | x == 24 | x == 26) & (y >= (leftPaddleYPos - 40) & y <= (leftPaddleYPos + 40))));
assign rightPaddleDraw = (((x == 615 | x == 614 | x == 616) & (y >= (rightPaddleYPos - 40) & y <= (rightPaddleYPos + 40))));

assign bothPaddles = (leftPaddleDraw | rightPaddleDraw);

logic ballDraw;
ball pongBall(.clk(SYS_CLK), .VSYNC(VSYNC_PIN), .paddleTouched(bothPaddles), .x(x), .y(y), .ballDraw(ballDraw));

assign r = (leftPaddleDraw | rightPaddleDraw | ballDraw) ? 4'b1111 : 4'b0000;

assign g = (leftPaddleDraw | rightPaddleDraw | ballDraw) ? 4'b1111 : 4'b0000;

assign b = (leftPaddleDraw | rightPaddleDraw | ballDraw) ? 4'b1111 : 4'b0000;

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
