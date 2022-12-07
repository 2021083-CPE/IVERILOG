timescale 10 ns/100 ps
/*The time unit is set to 10 ns. During the simulation, all delay values will be
multiplied by 10 ns, and all delays will be rounded with 100 ps precision.*/

'define SIZE 8
'define STOP $finish
'define REGME reg [8*31:0]
'ifdef TEST_1
	'include "drill1_1.v"
'else
	'include "drill1_2.v"
'endif

module testbench;
	'REGME regVar;
	reg	a,b,borrowIn;
	wire	diff, borrowOut;
	full_subtract	fs(diff, borrowOut, a, b, borrowIn);

	initial begin
		a=1'b1; b=1'b1; borrowIn=1'b0;
	end

	initial begin
		#10 a=1'b1;
		#10 a=1'b0; b=1'b1;
		#10 a=1'b1; b=1'b0;
		#10 borrowIn=1'b1;
	end
	initial begin
		$display(" a b borrowIn difference borrowOut time");
		$monitor("%b %b  %b %b %b %d", a, b, borrowIn, diff,borrowOut, $time);
	#10 'STOP;
	end
endmodule	