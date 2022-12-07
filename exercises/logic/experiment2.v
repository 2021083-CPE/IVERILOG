module deMorgan(
    input a,b,
    output NAND1,negativeOR1,NOR1,negativeAND1
);
    wire notA,notB;

    not(notA,a);
    not(notB,b);

    nand(NAND1,a,b);             // ~((a)(b))
    or(negativeOR1,notA,notB);   // (~a)+(~b)

    nor(NOR1,a,b);               // ~(a+b)
    and(negativeAND1,notA,notB); // (~a)(~b)
endmodule

module oneB( //AND Gate
    input a,b,
    output x
);
    wire notA,notB,notAOrnotB;

    not(notA,a);
    not(notB,b);
    or(notAOrnotB,notA,notB);
    not(x,notAOrnotB);
endmodule

module twoA( //AND Gate
    input a,b,
    output x
);
    wire nor1,nor2;

    nor(nor1,a,a);
    nor(nor2,b,b);
    nor(x,nor1,nor2);
endmodule

module twoB( //OR Gate
    input a,b,
    output x
);
    wire nand1,nand2;

    nand(nand1,a,a);
    nand(nand2,b,b);
    nand(x,nand1,nand2);
endmodule

module Experiment2;
    reg a,b;
    wire
        NAND1,negativeOR1,NOR1,negativeAND1,
        oneBresult,
        twoAresult,
        twoBresult
        ;
    deMorgan A1(a,b,NAND1,negativeOR1,NOR1,negativeAND1);
    oneB B1(a,b,oneBresult);
    twoA A2(a,b,twoAresult);
    twoB B2(a,b,twoBresult);

    initial begin
        #1 $display("DeMorgan's Law");
        #1 a=0; b=0;
        #1 $display("~((a)(b))");
           $monitor("a=%b, b=%b, n=%b",a,b,NAND1);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
        #1 $display("(~a)+(~b)");
           $monitor("a=%b, b=%b, n=%b",a,b,negativeOR1);
        #1 a=1; b=0;
        #1 a=0; b=1;
        #1 a=0; b=0;
        #1 $display("Therefore, ~((a)(b)) = (~a)+(~b)\n");
        #1 $display("~(a+b)");
           $monitor("a=%b, b=%b, n=%b",a,b,NOR1);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
        #1 $display("(~a)(~b)");
           $monitor("a=%b, b=%b, n=%b",a,b,negativeAND1);
        #1 a=1; b=0;
        #1 a=0; b=1;
        #1 a=0; b=0;
        #1 $display("Therefore, ~(a+b) = (~a)(~b) \n");
        #1 $display("part 1B");
           $monitor("a=%b, b=%b, n=%b",a,b,oneBresult);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
        #1 $display("\npart 2A");
           $monitor("a=%b, b=%b, n=%b",a,b,twoAresult);
        #1 a=1; b=0;
        #1 a=0; b=1;
        #1 a=0; b=0;
        #1 $display("\npart 2B");
           $monitor("a=%b, b=%b, n=%b",a,b,twoBresult);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
    end
endmodule