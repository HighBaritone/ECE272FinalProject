module vga(input logic clk, output logic hSync, output logic vSync,
output logic active, output logic [9:0] x, output logic [9:0] y);

//FRAME WINDOWS

localparam HorizFrontPorchEnd = 16;              // horizontal sync start
localparam HSyncEnd = 16 + 96;         // horizontal sync end
localparam HorizBackPorchEnd = 16 + 96 + 48;    // horizontal active pixel start
localparam VertFrontPorchEnd = 480 + 10;        // vertical sync start
localparam VSyncEnd = 480 + 10 + 2;    // vertical sync end
localparam EndofFrame = 480;             // vertical active pixel end
localparam MaxHoriz   = 800;             // complete line (pixels)
localparam MaxVert = 525;             // complete screen (lines)

initial
begin
	hSync = 1'b1;
	vSync = 1'b1;
end

logic [9:0] horiz_count;  // current line position
logic [9:0] vert_count;   // current vertical position

assign hSync = ~((horiz_count >= HorizFrontPorchEnd) & (horiz_count < HSyncEnd));
assign vSync = ~((vert_count >= VertFrontPorchEnd) & (vert_count < VSyncEnd));

assign x = (horiz_count < HorizBackPorchEnd) ? 0 : (horiz_count - HorizBackPorchEnd);
assign y = (vert_count >= EndofFrame) ? (EndofFrame - 1) : (vert_count);

assign active = ~((horiz_count < HorizBackPorchEnd) | (vert_count > EndofFrame - 1));

always_ff @ (posedge clk)
 begin
			if (horiz_count == MaxHoriz)  // end of line
				begin
				 horiz_count <= 0;
				 vert_count <= vert_count + 1;
				end
			else 
				 horiz_count <= horiz_count + 1;

			if (vert_count == MaxVert)  // end of screen
				 vert_count <= 0;
 end
endmodule