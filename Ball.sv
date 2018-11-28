module ball(input logic clk, input logic VSYNC, input logic paddleTouched, input logic [9:0] x, input logic [9:0] y, output logic ballDraw);

logic [9:0] ballX;
logic [9:0] ballY;
logic ball_inX, ball_inY;
logic CollisionX1, CollisionX2, CollisionY1, CollisionY2;
logic ball_dirX, ball_dirY;

initial
begin
	
	ballX = 320;
	ballY = 240;
	
end

always_ff @(posedge clk)begin
if(ball_inX==0) ball_inX <= (x==ballX) & ball_inY; else ball_inX <= !(x==ballX+8);
end

always_ff @(posedge clk)begin
if(ball_inY==0) ball_inY <= (y==ballY); else ball_inY <= !(y==ballY+8);
end

assign ballDraw = (ball_inX & ball_inY);

always_ff @(posedge clk) if(!VSYNC) CollisionX1<=0; else if(paddleTouched & (x==ballX   ) & (y==ballY+ 4)) CollisionX1<=1;
always_ff @(posedge clk) if(!VSYNC) CollisionX2<=0; else if(paddleTouched & (x==ballX+8) & (y==ballY+ 4)) CollisionX2<=1;
always_ff @(posedge clk) if(!VSYNC) CollisionY1<=0; else if(paddleTouched & (x==ballX+ 4) & (y==ballY   )) CollisionY1<=1;
always_ff @(posedge clk) if(!VSYNC) CollisionY2<=0; else if(paddleTouched & (x==ballX+ 4) & (y==ballY+8)) CollisionY2<=1;

always_ff @(posedge VSYNC)
begin
  if(ballX == 1)
	begin
		ball_dirX <= 0;
	end
	
  if( (ballX + 8) == 639)
	begin
		ball_dirX <= 1;
	end
	
  if(ballY == 1)
	begin
		ball_dirY <= 0;
	end
	
  if( (ballY + 8) == 479)
	begin
		ball_dirY <= 1;
	end
	
	
  if(~(CollisionX1 & CollisionX2))
	begin
	 if(CollisionX2) ball_dirX <= 1; else if(CollisionX1) ball_dirX <= 0;
    ballX <= ballX + (ball_dirX ? -1 : 1);
  end
  if(~(CollisionY1 & CollisionY2))        // if collision on both Y-sides, don't move in the Y direction
  begin
	 if(CollisionY2) ball_dirY <= 1; else if(CollisionY1) ball_dirY <= 0;
    ballY <= ballY + (ball_dirY ? -1 : 1);
  end
end
 

endmodule 