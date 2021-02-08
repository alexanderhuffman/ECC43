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

// for debug
wire [large_array_size-1:0] out0;
wire [large_array_size-1:0] out1;
wire [large_array_size-1:0] out2;

gf_poly_mul #(.m(m), .SIZE(SIZE), .n(n), .flat_size(flat_size), .large_array(large_array), .large_array_size(large_array_size))
	dut(.flat_p(flat_p), .flat_q(flat_q), .flat_z(flat_z), .out0(out0), .out1(out1), .out2(out2));

integer i;
integer j;
initial begin
	flat_p = 24'h040105; flat_q = 24'h020003; #5;
	for (i = 0; i <= n; i = i + 1) begin
		for (j = 0; j < large_array_size; j = j + 1) begin
			$display("i = %d j = %d noHIGHZ = %b",i,j,dut.noHIGHZ[i][j]);
		end
	end
	// $display("flat_p = %h flat_q = %h flat_z = %h",flat_p,flat_q,flat_z);
end

endmodule
