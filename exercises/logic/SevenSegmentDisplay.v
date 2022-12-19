module SevenSegmentDisplay(
    input inputA,inputB,inputC,inputD,
    output a,b,c,d,e,f,g //these are the pins on the seven segment display
);
    wire notB,notC,notD,BD,notBnotD,notCnotD,CD,
        CnotD,BnotCD,notBC,BnotC,BnotD;

    //NOTE: On all logicGateMethods -> first arguement=output, all-other arguments=inputs
    //      OR methods with multiple inputs can be separated into multiple 2-input OR gates
    not(notB,inputB);
    not(notC,inputC);
    not(notD,inputD);

    and(BD,inputB,inputD);
    and(notBnotD,notB,notD); 
    or(a,inputA,inputC,BD,notBnotD); //pinA

    and(notCnotD,notC,notD);
    and(CD,inputC,inputD);
    or(b,notB,notCnotD,CD); //pinB

    or(c,inputB,notC,inputD); //pinC

    and(CnotD,inputC,notD);
    and(BnotCD,inputB,notC,inputD);
    and(notBC,notB,inputC);
    or(d,notBnotD,CnotD,BnotCD,notBC,inputA); //pinD

    or(e,notBnotD,CnotD); //pinE

    and(BnotC,inputB,notC);
    and(BnotD,inputB,notD);
    or(f,inputA,notCnotD,BnotC,BnotD); //pinF

    or(g,inputA,BnotC,notBC,CnotD); //pinG
endmodule

module SSDTB;
    reg w,x,y,z;
    wire a,b,c,d,e,f,g;

    SevenSegmentDisplay SSD(w,x,y,z,a,b,c,d,e,f,g);
    
    integer number = 0;

    initial
        begin
            $dumpfile("SevenSegmentDisplay.vcd");
	        $dumpvars(-1, SSD);
	        $monitor("%b", a,b,c,d,e,f,g);
        end

    initial 
        begin
            w=0; x=0; y=0; z=0;
            
            $display("Letter=Pin");
            $monitor("A=%b, B=%b, C=%b, D=%b, E=%b, F=%b, G=%b,",a,b,c,d,e,f,g);
            #10 w=0; x=0; y=0; z=1;
            #10 w=0; x=0; y=1; z=0;
            #10 w=0; x=0; y=1; z=1;
            #10 w=0; x=1; y=0; z=0;
            #10 w=0; x=1; y=0; z=1;
            #10 w=0; x=1; y=1; z=0;
            #10 w=0; x=1; y=1; z=1;
            #10 w=1; x=0; y=0; z=0;
            #10 w=1; x=0; y=0; z=1;
            #10 $finish;
        end
endmodule