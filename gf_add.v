module gf_add(a, b, y);

parameter m = 255;
parameter SIZE = $clog2(m);

input [SIZE-1:0] a, b;
output [SIZE-1:0] y;

assign y = a ^ b;

endmodule
