module gf_poly_eval(flat_p, x, y);

parameter m = 255;
parameter SIZE = $clog2(m);
parameter n = 2;
parameter flat_size = (n+1)*SIZE;

input [flat_size-1:0] flat_p;
input [SIZE-1:0] x;
output [SIZE-1:0] y;

wire [SIZE-1:0] p[0:n];
wire [SIZE-1:0] x_pow[0:n];
wire [SIZE-1:0] mult_result[0:n];
wire [SIZE-1:0] sum_result[0:n-1];

genvar i;

generate
	for (i = 0; i <= n; i = i + 1) begin
		assign p[i] = flat_p[((i+1)*SIZE)-1:i*SIZE];
		gf_pow #(.m(m), .SIZE(SIZE)) my_pow(.a(x), .power(i[SIZE-1:0]), .y(x_pow[i]));
		gf_mul #(.m(m), .SIZE(SIZE)) my_multiplier(.a(p[i]), .b(x_pow[i]), .y(mult_result[i]));
	end

	// perform first gf_add operation
	assign sum_result[0] = mult_result[0] ^ mult_result[1];

	// perform the rest of the gf_add operations
	for (i = 0; i < n-1; i = i + 1) begin
		gf_add #(.m(m), .SIZE(SIZE)) my_adder(.a(sum_result[i]), .b(mult_result[i+2]), .y(sum_result[i+1]));
	end

	assign y = sum_result[n-1];

endgenerate

endmodule
