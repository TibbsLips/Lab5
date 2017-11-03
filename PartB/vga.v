module monitor(clk, pixel,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,redstable,greenstable,bluestable,hsyncstable,vsyncstable);
input clk;
input [11:0]pixel;
input sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7;
 reg [10:0]hcount; //800 is 11 0010 0000
 reg [10:0]vcount; //525 is 10 0000 1101 made it 11 bits to account for negative number
output  [3:0]redstable; //error for these if reg
output  [3:0]greenstable;
output  [3:0]bluestable;
output  hsyncstable;
output  vsyncstable;

reg hsync;
reg vsync;

wire pixclk;

//red 	#FF0000
//green	#008000
//blue  #0000FF
reg [3:0]red;
reg [3:0]green;
reg [3:0]blue;

initial
  begin
    hcount=0;
    vcount=0;
    hsync =1;
    vsync =1;
    red=4'b0000;
    green=4'b0000;
    blue=4'b0000;
  end
pixelclk viewclk(clk,pixclk);

always@(posedge pixclk) //This is for hcount/hsync
  begin
    hcount<=hcount+1;
    if(hcount==799) //may need 799, was 800
        begin
          hcount<=0;
          hsync<=hsync;
        end
    else if(hcount==658)//may need to be 658 so next clock it will set it was 659
        begin
          hsync<=0;
        end
    else if(hcount==755) //may need to be 755 for next clk was 756, maybe one less for each since they run through flops
        begin
          hsync<=1;
        end

  end
// is there a logic issue here? if hcount changes to 800 will it become 0 before evaluate vcount?
always@(hcount)       //This is for vcount/vsync
  begin
    if(hcount==799) //was 800
      begin
        vcount<=vcount+1;
          if(vcount==524)//was 525
            begin
              vcount<=0;
              vsync<=vsync;
            end
          else if(vcount==492)//was 493
            begin
              vsync<=0;
            end
          else if(vcount==494)//was 495
            begin
              vsync<=1;
            end

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
          red<=pixel[11:8]; //these will be sent from the switches, need to add somewhere here maybe
          green<=pixel[7:4];
          blue<=pixel[3:0];
        end
  end



//  end
  DFF hsyncflop(hsync,pixclk,hsyncstable);
  DFF vsyncflop(vsync,pixclk,vsyncstable);
  DFF4bit redflop(red,pixclk,redstable);
  DFF4bit greenflop(green,pixclk,greenstable);
  DFF4bit blueflop(blue,pixclk,bluestable);

endmodule
