module topvga(clk,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,redstable,greenstable,bluestable,hsyncstable,vsyncstable);
input clk,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7;
output [3:0]redstable;
output [3:0]greenstable;
output [3:0]bluestable;
output hsyncstable;
output vsyncstable;

wire [11:0]pixel;
wire pixclk;

pixelclk p(clk,pixclk);
switchColor color(pixclk,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,pixel);
monitor m(pixclk,pixel,redstable,greenstable,bluestable,hsyncstable,vsyncstable);

endmodule
