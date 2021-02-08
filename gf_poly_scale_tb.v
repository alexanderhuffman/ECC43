module gf_poly_scale_tb;

parameter m = 255;
parameter SIZE = $clog2(m);
parameter n = 2; // p = a*x^n + b*x^(n-1) + ... c*x + d
parameter flat_size = (n+1)*SIZE;

reg [flat_size-1:0] flat_p;
reg [SIZE-1:0] scalar;
wire [flat_size-1:0] flat_scaled_p;

gf_poly_scale #(.m(m), .SIZE(SIZE), .n(n), .flat_size(flat_size)) dut(.flat_p(flat_p), .scalar(scalar), .flat_scaled_p(flat_scaled_p));

integer i;
initial begin
	flat_p = 24'h020407; scalar = 8'd5; #10;
	for (i = 0; i <= n; i = i + 1) begin
		$display("i = %d p = %d scaled_p = %d",i,dut.p[i],dut.scaled_p[i]);
	end
	$display("flat_scaled_p = %h",flat_scaled_p);
end

endmodule
