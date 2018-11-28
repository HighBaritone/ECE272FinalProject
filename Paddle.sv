module Paddle(input logic clk, input logic upButton, input logic downButton, output logic [9:0] paddleCenterYPos);

localparam startingYPos = 240;

initial begin

paddleCenterYPos = startingYPos;

end

logic [9:0] paddleBottom;
logic [9:0] paddleTop;

assign paddleBottom = (paddleCenterYPos - 40);
assign paddleTop = (paddleCenterYPos + 40);

always_ff @ (posedge clk)
begin
	if(upButton == downButton)
		begin
			paddleCenterYPos <= paddleCenterYPos;
		end
	else if(downButton == 1'b0 & (paddleBottom > 0))
		begin
			paddleCenterYPos <= paddleCenterYPos - 1;
		end
	else if(upButton == 1'b0 & (paddleTop < 480))
		begin
			paddleCenterYPos <= paddleCenterYPos + 1;
		end
end 



endmodule