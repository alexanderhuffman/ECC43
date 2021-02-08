module gf_poly_add(flat_p, flat_q, flat_z);

parameter m = 255;
parameter SIZE = $clog2(m);
parameter n = 2;
parameter flat_size = (n+1)*SIZE;

input [flat_size-1:0] flat_p, flat_q;
output [flat_size-1:0] flat_z;

wire [SIZE-1:0] p[0:n];
wire [SIZE-1:0] q[0:n];
wire [SIZE-1:0] z[0:n];

genvar i;

generate
	for (i = 0; i <= n; i = i + 1) begin
		assign p[i] = flat_p[((i+1)*SIZE)-1:i*SIZE];
		assign q[i] = flat_q[((i+1)*SIZE)-1:i*SIZE];
		assign z[i] = p[i] ^ q[i];
		assign flat_z[((i+1)*SIZE)-1:i*SIZE] = z[i];
	end
endgenerate

endmodule
