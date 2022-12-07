//Verilog model circuit of Fig 1.1
module circuit1_1(A,B,C,X);

	input		A,B,C;
	output	X;
	wire		wire1, wire2, wire3;

	not		NOT(wire2,A);
	xor		EOR2(wire1,B,C);
	and 		AND(wire3, wire1, A);
	nor		NOR(X, wire3, wire2);

endmodule

module testbench1_1;
	reg		A,B,C;
	wire		Z;
	circuit1_1	tb1(A,B,C,Z);
	
	initial
        	begin
            	$dumpfile("drill1_1.vcd");
	        	$dumpvars(-1, tb1);
	        	$monitor("%b", Z);
        	end

	initial
	begin
		A=1'b0; B=1'b0; C=1'b0;	
		$display("Simulating output for circuit1_1");
		$monitor($time,,,"A=%b B=%b C=%b Z=%b",A,B,C,Z);

		#2 A=1'b0; B=1'b0; C=1'b1;
		#1 A=1'b0; B=1'b1; C=1'b0;
		#1 A=1'b0; B=1'b1; C=1'b1;
		#1 A=1'b1; B=1'b0; C=1'b0;
		#1 A=1'b1; B=1'b0; C=1'b1;
		#1 A=1'b1; B=1'b1; C=1'b0;
		#1 A=1'b1; B=1'b1; C=1'b1;
		#2 $finish;
	end
endmodule