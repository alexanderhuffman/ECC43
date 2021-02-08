module swap_values(a, b, y, z);

parameter m = 255;
parameter SIZE = $clog2(m);

input [SIZE-1:0] a, b;
output [SIZE-1:0] y, z;

assign y = (a <= b) ? a : b;
assign z = (a <= b) ? b : a;

endmodule
