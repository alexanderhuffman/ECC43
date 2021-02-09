module gf_poly_mul_tb;

parameter m = 255;
parameter SIZE = $clog2(m);
parameter n = 2;
parameter flat_size = (n+1)*SIZE;
parameter large_array = 2*n;
parameter large_array_size = (large_array+1)*SIZE;

reg [flat_size-1:0] flat_p;
reg [flat_size-1:0] flat_q;
wire [large_array_size-1:0] flat_z;

gf_poly_mul #(.m(m), .SIZE(SIZE), .n(n), .flat_size(flat_size), .large_array(large_array), .large_array_size(large_array_size))
	dut(.flat_p(flat_p), .flat_q(flat_q), .flat_z(flat_z));

integer i;
integer j;
initial begin
	flat_p = 24'h040105; flat_q = 24'h020003; #5;
	$display("flat_p = %h flat_q = %h flat_z = %h",flat_p,flat_q,flat_z);
end

endmodule
