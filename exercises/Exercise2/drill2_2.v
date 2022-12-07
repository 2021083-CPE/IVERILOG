//This Verilog test bench illustrates the different Verilog operators
module drill2_2;
	reg[3:0]Ctr,Xnr,Fdr;
	initial begin
		Ctr=4'd0; Fdr=4'11;
		#5 Xnr=(Ctr !=0) ? (Ctr *+1):^Fdr;
		#10 $display(Xnr);
		#15 Xnr=-9%2; Fdr=52<8'hFF;
		#20 $display(Xnr," ",Fdr);
		#25 Ctr=Xnr&&Fdr; Fdr=Xnr&Fdr;
		#30 $display(Ctr,Fdr);
		#35 Ctr=Ctr<<2; Fdr=Xnr>>1;
		#40 $display(Ctr, Fdr);
		#100 $finish;
	end
endmodule