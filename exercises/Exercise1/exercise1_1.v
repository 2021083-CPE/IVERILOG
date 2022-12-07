module exercise1_1(W,X,Y,Z);
    output[3:0] W; //4bit vector, depth of 1
    input X,Y;
    input Z;
    wire X1,Y1,Z1;

    not G1(X1,X);
    not G2(Y1,Y);
    not G3(Z1,Z);
    nand G4(W[0],X1,Y1,Z1), G5(W[1],X1,Y,Z1), G6(W[2],X,Y1,Z1), G7(W[3],X,Y,Z1);
endmodule

module testbench1_1;

	reg X,Y,Z;
	wire [0:3]W;
	exercise1_1 tb1(W, X, Y, Z);
	
    initial
        begin
            $dumpfile("exercise1_1.vcd");
	        $dumpvars(-1, tb1);
	        $monitor("%b", Z);
        end
	
	initial
	begin
	 X=1'b0; Y=1'b0; Z=1'b0;
	 $display("Simulating output for circuit1_1");

	 #2 X=1'b0; Y=1'b0; Z=1'b1;
	 #1 X=1'b0; Y=1'b1; Z=1'b0;
	 #1 X=1'b0; Y=1'b1; Z=1'b1;
	 #1 X=1'b1; Y=1'b0; Z=1'b0;
	 #1 X=1'b1; Y=1'b0; Z=1'b1;
	 #1 X=1'b1; Y=1'b1; Z=1'b0;
	 #1 X=1'b1; Y=1'b1; Z=1'b1;
	 #2 $finish;
	end
endmodule