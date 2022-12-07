//dataflow Verilog code for a simple 1-bit full subtracter.
module full_subtract(diff,borrowOut, a, b, borrowin);
	output		diff;
	output		borrowOut;
	input		a, b, borrowin;
	assign		{borrowOut, diff}=a-b-borrowin;
	//result of subtraction is two bits; the MSB is borrowOut and the LSB
	//is diff.
endmodule

module testingFS();
	
	reg		a,b,borrowin;
	wire		diff,borrowOut;
	full_subtract		fs(diff, borrowOut, a, b, borrowin);

	initial begin
            $dumpfile("Drill1_2.vcd");
	        $dumpvars(-1, testingFS);
	        $monitor("%b", borrowin);
	end

	initial begin
	a=1'b1; b=1'b1; borrowin=1'b0;
	end

	initial begin
	#10 a=1'b1;
	#10 a=1'b0; b=1'b1;
	#10 a=1'b1; b=1'b0;
	#10 borrowin=1'b1;
	end

	initial begin
	$display(" a b borrowin difference borrowOout time");
	$monitor(" %b %b %b %b %b %b ",a,b,borrowin,diff,borrowOut,
		$time);
	end
endmodule