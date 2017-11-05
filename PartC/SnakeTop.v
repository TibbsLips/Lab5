module top(clk,ps2clk,ps2data,redstable,greenstable,bluestable,hsyncstable,vsyncstable,seg_anode,seg_cathode);
input clk;
input ps2clk;                   //things from keyboard
input ps2data;
output wire [3:0]seg_anode;
output wire [3:0]seg_cathode;
wire strobe;
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

keyboardInput k(clk,ps2clk,ps2data,keycode1,keycode2,strobe,firstdigit);

snakeControl s(keycode1,keycode2,strobe,pixclk,pixel,xcoord,ycoord);

monitor m(xcoord,ycoord,pixclk,pixel,redstable,greenstable,bluestable,hsyncstable,vsyncstable);
endmodule
