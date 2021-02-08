// Verilog does not permit inputs to be arrays, therefore vectors are flattened at input and output
// function multiplies gf polynomial by scalar
module gf_poly_scale(flat_p, scalar, flat_scaled_p);

parameter m = 255;
parameter SIZE = $clog2(m);
parameter n = 2; // p = a*x^n + b*x^(n-1) + ... c*x + d
parameter flat_size = (n+1)*SIZE;

input [flat_size-1:0] flat_p;
input [SIZE-1:0] scalar;
output [flat_size-1:0] flat_scaled_p;

wire [SIZE-1:0] p[0:n]; // creates polynomial vector with depth n+1
wire [SIZE-1:0] scaled_p[0:n]; // creates result vector with depth n+1

genvar i;

generate
	for (i = 0; i <= n; i = i + 1) begin
		assign p[i] = flat_p[((i+1)*SIZE)-1:i*SIZE];
		gf_mul #(.m(m), .SIZE(SIZE)) my_multiplier(.a(scalar), .b(p[i]), .y(scaled_p[i])); // scaled_p[i] = gf_mul(scalar, p[i])
		assign flat_scaled_p[((i+1)*SIZE)-1:i*SIZE] = scaled_p[i];
	end
endgenerate

endmodule
