module top(clk,ps2clk,ps2data,redstable,greenstable,bluestable,hsyncstable,vsyncstable,seg_anode,seg_cathodes,strobe);
input clk;
input ps2clk;                   //things from keyboard
input ps2data;
output wire [3:0]seg_anode;
output wire [6:0]seg_cathodes;
output wire strobe;
wire keycode1;
wire keycode2;
wire firstdigit;

output [3:0]redstable;          //things for display
output [3:0]greenstable;
output [3:0]bluestable;
output hsyncstable;
output vsyncstable;
wire [11:0]pixel;
wire pixclk;

wire [10:0]xcoord;
wire [10:0]ycoord;

pixelclk p(clk,pixclk);
kclk seven_seg_clk(clk,clk1k);

keyboardInput k(clk,ps2clk,ps2data,keycode1,keycode2,strobe,firstdigit);

seven_seg_displayLab5 seven(clk1k,firstdigit,keycode1,keycode2,seg_anode,seg_cathodes);

snakeControl s(keycode1,keycode2,strobe,pixclk,pixel,xcoord,ycoord);

monitor m(xcoord,ycoord,pixclk,pixel,redstable,greenstable,bluestable,hsyncstable,vsyncstable);
endmodule
