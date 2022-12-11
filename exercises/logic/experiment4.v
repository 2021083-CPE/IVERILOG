module part1(
    input a,b,
    output f
);
    assign f = (~a & b)|(a & ~b);
endmodule

module part3(
    input a,b,c,
    output g
);
    wire notC,AB,AC,BnotC;

    not(notC,c);
    and(AB,a,b);
    and(AC,a,c);
    and(BnotC,b,notC);
    or(g,AC,BnotC,AB);
endmodule

module part5(
    input a,b,c,d,
    output h
);
    wire ABC,CD,notCD,nor1,and2;

    and(ABC,a,b,c);
    or(CD,c,d);
    not(notCD,CD);
    nor(nor1,ABC,notCD);
    and(and2,notCD,ABC);
    or(h,and2,d,nor1);
endmodule

module Lab4TB;
    reg a,b,c,d;
    wire f,g,h;

    part1 p1(a,b,f);
    part3 p3(a,b,c,g);
    part5 p5(a,b,c,d,h);

    initial
        begin
            $dumpfile("experiment4.vcd");
	        $dumpvars(-1, p1,p3,p5);
	        $monitor("%b",  f,g,h);
        end
    initial begin
        #1 a=0; b=0;
        #1 $display("part1");
           $monitor($time,,,"a=%b, b=%b : f=%b",a,b,f);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;

        #1 a=0; b=0; c=0;
        #1 $display("part3");
           $monitor($time,,,"a=%b, b=%b, c-%b : g=%b",a,b,c,g);
        #1 a=0; b=0; c=1;
        #1 a=0; b=1; c=0;
        #1 a=0; b=1; c=1;
        #1 a=1; b=0; c=0;
        #1 a=1; b=0; c=1;
        #1 a=1; b=1; c=0;
        #1 a=1; b=1; c=1;

        #1 a=0; b=0; c=0; d=0;
        #1 $display("part5");
           $monitor($time,,,"a=%b, b=%b, c-%b, d=%b : h=%b",a,b,c,d,h);
        #1 a=0; b=0; c=0; d=1;
        #1 a=0; b=0; c=1; d=0;
        #1 a=0; b=0; c=1; d=1;
        #1 a=0; b=1; c=0; d=0;
        #1 a=0; b=1; c=0; d=1;
        #1 a=0; b=1; c=1; d=0;
        #1 a=0; b=1; c=1; d=1;
        #1 a=1; b=0; c=0; d=0;
        #1 a=1; b=0; c=0; d=1;
        #1 a=1; b=0; c=1; d=0;
        #1 a=1; b=0; c=1; d=1;
        #1 a=1; b=1; c=0; d=0;
        #1 a=1; b=1; c=0; d=1;
        #1 a=1; b=1; c=1; d=0;
        #1 a=1; b=1; c=1; d=1;
    end
endmodule