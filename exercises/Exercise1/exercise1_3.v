module exercise1_3(
    output var1,x_4,
    input x_1,x_2,x_3);

    xor EOR1(x_4,x_1,x_2,x_3);
    xor EOR2(var1, x_1, x_2, x_3,x_4);
endmodule

module testbench1_3;
    reg x1,x2,x3;
    wire var1,x4;

    exercise1_3 tb3(var1,x4,x1,x2,x3);

    initial
        begin
            $dumpfile("exercise1_3.vcd");
	        $dumpvars(-1, tb3);
	        $monitor("%b", var1,x4);
        end

    initial
        begin
            x1=0; x2=0; x3=0;

            $display("Simulating output for circuit1_3");
            $monitor($time,,,"x_1=%b, x_2=%b, x_3=%b, X_4=%b, var1=%b",x1,x2,x3,x4,var1);

            #1 x1=0; x2=0; x3=1;
            #1 x1=0; x2=1; x3=0;
            #1 x1=0; x2=1; x3=1;
            #1 x1=1; x2=0; x3=0;
            #1 x1=1; x2=0; x3=1;
            #1 x1=1; x2=1; x3=0;
            #1 x1=1; x2=1; x3=1;
            #2 $finish;
        end
endmodule