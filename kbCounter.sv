module kbCounter(input logic kbClock, output logic [3:0] count);

always_ff @ (negedge kbClock)
begin
	if(count <= 10) count <= count + 1;
	else count <= 1;
end

endmodule 