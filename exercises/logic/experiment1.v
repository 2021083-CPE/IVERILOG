module Lab1Experiment;
    reg i1,i2;
    wire not1,not2,and1,or1;

    not(not1,i1);
    not(not2,i2);
    and(and1,i1,i2);
    or(or1,i1,i2);
initial
    begin
	$dumpfile("Lab1CPE314.vcd");
	        $dumpvars(-1, i1,i2,not1,not2,and1,or1);
	        $monitor("%b", i1,i2,not1,not2,and1,or1);
    end

    initial begin
        #1 i1=0;
        #1 $display("NOT Gate");
        #1 $monitor("x=%b,n=%b",i1,not1);
        #1 i1=1;
        #1 i1=0; i2=0;
        #1 $display("AND Gate");
        #1 $monitor("x=%b,y=%b,n=%b",i1,i2,and1);
        #1 i1=0; i2=1;
        #1 i1=1; i2=0;
        #1 i1=1; i2=1;
        #1 $display("OR Gate");
        #1 $monitor("x=%b,y=%b,n=%b",i1,i2,or1);
        #1 i1=1; i2=0;
        #1 i1=0; i2=1;
        #1 i1=0; i2=0;
    end
endmodule
