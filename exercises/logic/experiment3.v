module part1minterm(
    input a,b,c,
    output i
);
    // reference: !A!B + !BC + B!C

    wire notA,notB,notC,BnotC,notBC,notAnotB;

    not(notA,a);
    not(notB,b);
    not(notC,c);

    and(BnotC,b,notC);
    and(notBC,notB,c);
    and(notAnotB,notA,notB);

    or(i,notAnotB,notBC,BnotC);
endmodule
module part1Maxterm(
    input a,b,c,
    output i
);
    // reference: (!A+B+C)(!B+!C)
    
    wire notA,notB,notC,notABC,notBnotC;

    not(notA,a);
    not(notB,b);
    not(notC,c);

    or(notABC,notA,b,c);
    or(notBnotC,notB,notC);

    and(i,notABC,notBnotC);
endmodule
module part5Minterm(
    input a,b,c,d,
    output i
);
    // reference: !A!C!B+!ADB+!AD!C+A!BCD+AB!C

    wire notA,notB,notC,
        notAnotCnotB,notADB,
        notADnotC,notABCD,ABnotC;

    not(notA,a);
    not(notB,b);
    not(notC,c);

    and(notAnotCnotB,notA,notC,notB);
    and(notADB,notA,d,b);
    and(notADnotC,notA,d,notC);
    and(AnotBCD,a,notB,c,d);
    and(ABnotC,a,b,notC);

    or(i,notAnotCnotB,notADB,notADnotC,AnotBCD,ABnotC);
endmodule
module part5Maxterm(
    input a,b,c,d,
    output i
);
    // reference: (!A+!B+!C)(!A+B+C)(A+!B+D)(A+B+!C)(!C+D)

    wire notA,notB,notC,
        notAnotBnotC,notABC,AnotBD,
        ABnotC,notCD;

    not(notA,a);
    not(notB,b);
    not(notC,c);

    or(notAnotBnotC,notA,notB,notC);
    or(notABC,notA,b,c);
    or(AnotBD,a,notB,d);
    or(ABnotC,a,b,notC);
    or(notCD,notC,d);

    and(i,notAnotBnotC,notABC,AnotBD,ABnotC,notCD);
endmodule

module Lab3TestBench;
    reg a,b,c,d;
    wire oneMinterm,oneMaxterm,fiveMinterm,fiveMaxterm;

    part1minterm P1Min(a,b,c,oneMinterm);
    part1Maxterm P1Max(a,b,c,oneMaxterm);
    part5Minterm P5Min(a,b,c,d,fiveMinterm);
    part5Maxterm P5Max(a,b,c,d,fiveMaxterm);
    
    initial
        begin
            $dumpfile("experiment3.vcd");
            $dumpvars(-1, P1Min, P1Max, P5Min, P5Max);
            $monitor("%b", oneMinterm, oneMaxterm, fiveMinterm, fiveMaxterm);
        end
    

    initial begin
        #1 a=0;b=0;c=0;
        $display("part1 minterm: !A!B + !BC + B!C");
        $monitor("a=%b, b=%b, c=%b : i=%b",a,b,c,oneMinterm);
        #1 a=0;b=0;c=1;
        #1 a=0;b=1;c=0;
        #1 a=0;b=1;c=1;
        #1 a=1;b=0;c=0;
        #1 a=1;b=0;c=1;
        #1 a=1;b=1;c=0;
        #1 a=1;b=1;c=1;


        #1 a=0;b=0;c=0;
        $display("\npart1 maxterm: (!A+B+C)(!B+!C)");
        $monitor("a=%b, b=%b, c=%b : i1=%b",a,b,c,oneMaxterm);
        #1 a=0;b=0;c=1;
        #1 a=0;b=1;c=0;
        #1 a=0;b=1;c=1;
        #1 a=1;b=0;c=0;
        #1 a=1;b=0;c=1;
        #1 a=1;b=1;c=0;
        #1 a=1;b=1;c=1;

        #1 a=0;b=0;c=0;d=0;
        $display("\npart2 minterm: (A+B+!C+D)( A+B+!C+!D)( A+!B+C+D)( A+!B+!C+D)( !A+B+C+D)( !A+B+C+!D)( !A+B+!C+D)( !A+!B+!C+D)( !A+!B+!C+!D)");
        $monitor("a=%b, b=%b, c=%b, d=%b : i1=%b",a,b,c,d,fiveMinterm);
        #1 a=0;b=0;c=0;d=1;
        #1 a=0;b=0;c=1;d=0;
        #1 a=0;b=0;c=1;d=1;
        #1 a=0;b=1;c=0;d=0;
        #1 a=0;b=1;c=0;d=1;
        #1 a=0;b=1;c=1;d=0;
        #1 a=0;b=1;c=1;d=1;
        #1 a=1;b=0;c=0;d=0;
        #1 a=1;b=0;c=0;d=1;
        #1 a=1;b=0;c=1;d=0;
        #1 a=1;b=0;c=1;d=1;
        #1 a=1;b=1;c=0;d=0;
        #1 a=1;b=1;c=0;d=1;
        #1 a=1;b=1;c=1;d=0;
        #1 a=1;b=1;c=1;d=1;

        #1 a=0;b=0;c=0;d=0;
        $display("\npart2 maxterm:!A!B!C!D+!A!B!CD+!AB!CD+!ABCD+ A!BCD+ AB!C!D+ AB!CD");
        $monitor("a=%b, b=%b, c=%b, d=%b : i1=%b",a,b,c,d,fiveMaxterm);
        #1 a=0;b=0;c=0;d=1;
        #1 a=0;b=0;c=1;d=0;
        #1 a=0;b=0;c=1;d=1;
        #1 a=0;b=1;c=0;d=0;
        #1 a=0;b=1;c=0;d=1;
        #1 a=0;b=1;c=1;d=0;
        #1 a=0;b=1;c=1;d=1;
        #1 a=1;b=0;c=0;d=0;
        #1 a=1;b=0;c=0;d=1;
        #1 a=1;b=0;c=1;d=0;
        #1 a=1;b=0;c=1;d=1;
        #1 a=1;b=1;c=0;d=0;
        #1 a=1;b=1;c=0;d=1;
        #1 a=1;b=1;c=1;d=0;
        #1 a=1;b=1;c=1;d=1;
    end
endmodule
