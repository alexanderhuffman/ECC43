module gf_mul_tb;

parameter m = 255;
parameter SIZE = $clog2(m);

reg [SIZE-1:0] a, b;
wire [SIZE-1:0] y;

gf_mul #(.m(m), .SIZE(SIZE)) dut(.a(a), .b(b), .y(y));

initial begin
	a = 14; b = 34; #10;
	$display("a = %d b = %d y = %d",a,b,y);
	// $display("gf_loga = %d gf_logb = %d gf_exp_index = %d gf_expy = %d",dut.gf_loga,dut.gf_logb,dut.index,dut.gf_expy); #10;

	a = 29; b = 127; #10;
	$display("a = %d b = %d y = %d",a,b,y);
	// $display("gf_loga = %d gf_logb = %d gf_exp_index = %d gf_expy = %d",dut.gf_loga,dut.gf_logb,dut.index,dut.gf_expy); #10;

	a = 5; b = 0; #10;
	$display("a = %d b = %d y = %d",a,b,y);
end

endmodule
