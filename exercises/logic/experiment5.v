module halfAdder(
    input A, B, 
    output Sum, Carry
);
    and(Carry,A,B);
    xor(Sum,A,B);
endmodule

module fullAdder(
    input a,b,c_In, 
    output sum,c_out
);
    wire xor1,and1,and2;

    xor(xor1,a,b);
    xor(sum,xor1,c_In);
    and(and2,a,b);
    and(and1,xor1,c_In);
    or(c_out,and1,and2);
endmodule

module halfSubtract(
    input A,B, 
    output D,bOut
);
    wire not1;

    xor(D,A,B);
    not(not1,A);
    and(bOut,B,not1);
endmodule

module fullSubtract(
    input A,B,bIn,
    output D,bOut
);
    wire not1,xor1,and1,not2,and2;

    not(not1,A);
    xor(xor1,A,B);
    and(and1,not1,B);
    not(not2,xor1);
    xor(D,xor1,bIn);
    and(and2,not2,bIn);
    or(bOut,and2,and1);
endmodule

module Lab5TB;
    reg a,b,c_In,bIn;
    wire sum,carry,
         sum1,c_out,
         D,bOut,
         D1,bOut1
    ;

    halfAdder HFADD(a,b,sum,carry);
    fullAdder FLADD(a,b,c_In,sum1,c_out);
    halfSubtract HFSUB(a,b,D,bOut);
    fullSubtract FFSUB(a,b,bIn,D1,bOut1);

    initial
        begin
            $dumpfile("experiment5.vcd");
	        $dumpvars(-1, HFADD,FLADD,HFSUB,FFSUB);
	        $monitor("%b",  sum,carry,
                            sum1,c_out,
                            D,bOut,
                            D1,bOut1);
        end
    initial begin
        #1 a=0; b=0;
        #1 $display("Simulating Half Adder");
           $monitor("A=%b, B=%b, sum=%b, carry=%b", a,b,sum,carry);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
        
        #1 a=0; b=0; c_In=0;
        #1 $display("Simulating Full Adder");
           $monitor("A=%b, B=%b, c_In=%b, sum=%b, C_out=%b",a,b,c_In,sum1,c_out);
        #1 a=0; b=0; c_In=1;
        #1 a=0; b=1; c_In=0;
        #1 a=0; b=1; c_In=1;
        #1 a=1; b=0; c_In=0;
        #1 a=1; b=0; c_In=1;
        #1 a=1; b=1; c_In=0;
        #1 a=1; b=1; c_In=1;

        #1 a=0; b=0; 
        #1 $display("Simulating Half Subtract");
           $monitor("A=%b, B=%b, D=%b, bOut=%b",a,b,D,bOut);
        #1 a=0; b=1; 
        #1 a=1; b=0; 
        #1 a=1; b=1; 

        #1 a=0; b=0; bIn=0;
        #1 $display("Simulating Full Subtract");
           $monitor("A=%b, B=%b, bIn=%b, D=%b, bOut=%b", a,b,bIn,D1,bOut1);
        #1 a=0; b=0; bIn=1;
        #1 a=0; b=1; bIn=0;
        #1 a=0; b=1; bIn=1;
        #1 a=1; b=0; bIn=0;
        #1 a=1; b=0; bIn=1;
        #1 a=1; b=1; bIn=0;
        #1 a=1; b=1; bIn=1;

        #1 $finish;  
    end
endmodule