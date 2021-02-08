module gf_poly_mul(flat_p, flat_q, flat_z, out0, out1, out2);

parameter m = 255;
parameter SIZE = $clog2(m);
parameter n = 2;
parameter flat_size = (n+1)*SIZE;
parameter large_array = 2*n;
parameter large_array_size = (large_array+1)*SIZE;

input [flat_size-1:0] flat_p;
input [flat_size-1:0] flat_q;
output [large_array_size-1:0] flat_z;

wire [SIZE-1:0] p[0:n];
wire [SIZE-1:0] q[0:n];
wire [SIZE-1:0] z[0:large_array];

wire [SIZE-1:0] initial_mult[0:large_array][0:n];
wire [large_array_size-1:0] flat_initial_mult[0:n];

wire [large_array_size-1:0] noHIGHZ[0:n];

genvar i;
genvar j;

generate
	for (i = 0; i <= n; i = i + 1) begin
		assign p[i] = flat_p[((i+1)*SIZE)-1:i*SIZE];
		assign q[i] = flat_q[((i+1)*SIZE)-1:i*SIZE];
		// perform initial multiplication
		for (j = 0; j <= n; j = j + 1) begin
			gf_mul #(.m(m), .SIZE(SIZE)) my_multiplier(.a(p[i]), .b(q[j]), .y(initial_mult[i+j][i]));
		end
	end

	// flatten initial_mult arrays so that gf_poly_add can be used
	for  (i = 0; i <= n; i = i + 1) begin
		for (j = 0; j <= large_array; j = j + 1) begin
			assign flat_initial_mult[i][((j+1)*SIZE)-1:j*SIZE] = initial_mult[j][i];
		end
	end

	// get rid of HIGHZ values in flat_initial_mult arrays
	// works, but is probably not synthesizable
/*
	for (i = 0; i <= n; i = i + 1) begin
		for (j = 0; j < large_array_size; j = j + 1) begin
			assign noHIGHZ[i][j] = (flat_initial_mult[i][j] === 1'bz) ? 1'b0 : flat_initial_mult[i][j];
		end
	end
*/

endgenerate

// for debugging
output [large_array_size-1:0] out0;
output [large_array_size-1:0] out1;
output [large_array_size-1:0] out2;

assign out0 = noHIGHZ[0];
assign out1 = noHIGHZ[1];
assign out2 = noHIGHZ[2];

endmodule
