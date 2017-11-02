module keyTop(clk,ps2clk,ps2data,seg_anode,seg_cathodes,strobe);
input clk,ps2clk,ps2data;
output wire [3:0]seg_anode;
output wire [6:0]seg_cathodes;
output strobe;

wire [3:0]digit1;
wire [3:0]digit2;
assign digit1=4'b1101;
assign digit2=4'b0111;
//keyboardInput keys(clk,ps2clk,ps2data,digit1,digit2,strobe);
kclk seven_seg_clk(clk,clk1k);
seven_seg_displayLab5 seven(clk1k,digit1,digit2,seg_anode,seg_cathodes);

endmodule
