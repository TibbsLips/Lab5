module monitor(clk, pixel,hcount,vcount,redstable,greenstable,bluestable,hsyncstable,vsyncstable);
input clk;
input [11:0]pixel;

output reg [9:0]hcount; //800 is 11 0010 0000
output reg [9:0]vcount; //525 is 10 0000 1101
output reg [3:0]redstable;
output reg [3:0]greenstable;
output reg [3:0]bluestable;
output reg hsyncstable;
output reg vsyncstable;

reg hsync;
reg vsync;

wire pixclk;

//red 	#FF0000
//green	#008000
//blue  #0000FF
reg [3:0]red;
reg [3:0]green;
reg [3:0]blue;

inital
  begin
    hcount=0;
    vcount=0;
    hsync =1;
    vsync =1;
    red=4'b0000;
    green=4'b0000;
    blue=4'b0000;
  end
pixelclk viewclk(clk,pixclk)

always@(posedge pixclk) //This is for hcount/hsync
  begin
    hcount<=hcount+1;
    if(hcount==800)
        begin
          hcount<=0;
          hsync<=hsync;
        end
    else if(hcount==659)
        begin
          hcount<=hcount;
          hsync<=0;
        end
    else if(hcount==756)
        begin
          hcount<=hcount;
          hsync<=1;
        end

//    if(hcount>=640)     //no display
//      begin
//        red<=4'b0000;
//        green<=4'b0000;
//        blue<=4'b0000;
//      end
//    else
//      begin
//        red<=pixel[11:8];
//        green<=pixel[7:4];
//        blue<=pixel[3:0];
//      end
  end
// is there a logic issue here? if hcount changes to 800 will it become 0 before evaluate vcount?
always@(hcount)       //This is for vcount/vsync
  begin
    if(hcount==800)
      begin
        vcount<=vcount+1;
          if(vcount==525)
            begin
              vcount<=0;
              vsync<=vsync;
            end
          else if(vcount==493)
            begin
              vcount<=vcount;
              vsync<=0;
            end
          else if(vcount==495)
            begin
              vcount<=vcount;
              vsync<=1;
            end

//          if(vcount>=480) //no display
//            begin
//              red=4'b0000;
//              green=4'b0000;
//              blue=4'b0000;
//            end
//          else
//            begin
//              red<=pixel[11:8];
//              green<=pixel[7:4];
//              blue<=pixel[3:0];
//            end
      end
  end
always@(hcount,vcount)
  begin
      if(hcount>=639|vcount>=479)
        begin
          red=4'b0000;
          green=4'b0000;
          blue=4'b0000;
        end
      else
        begin
          red<=pixel[11:8];
          green<=pixel[7:4];
          blue<=pixel[3:0];
        end
  end



  end
  DFF(red,pixclk,redstable);
  DFF(green,pixclk,greenstable);
  DFF(blue,pixclk,bluestable);
  DFF4bit(hsync,pixclk,hsyncstable);
  DFF4bit(vsync,pixclk,vsyncstable);
endmodule
