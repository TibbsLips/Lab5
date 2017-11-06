module monitor(collided,blackflag,snakeheightoffset,snakewidthoffset,xcoord,ycoord,pixclk,pixel,redstable,greenstable,bluestable,hsyncstable,vsyncstable); // pixel comes from switches
input [6:0]snakeheightoffset;
input [6:0]snakewidthoffset;
input pixclk;
input [11:0]pixel;
input [10:0]xcoord;
input [10:0]ycoord;
input blackflag;
input collided;
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

reg [3:0]red;
reg [3:0]green;
reg [3:0]blue;
reg displaycase;

initial
  begin
    displaycase=0; //display case is the generated signal to see if pixel is in visible region
    hcount=0; //was 0
    vcount=0; //was 0
    hsync =1;
    vsync =1;
    red=4'b0000;
    green=4'b0000;
    blue=4'b0000;
  end

always@(posedge pixclk)
begin
      hcount = hcount + 1;
      if(hcount >= 800) begin
        vcount = vcount + 1;
        hcount = 0;
      end

      if(hcount == 659)begin
        hsync = 0;
      end

      else if(hcount == 756)begin
        hsync = 1;
      end

      if(hcount>=639)
       begin
         displaycase=0;
       end

      if(vcount >= 525)
       begin
         vcount = 0;
       end

      if(vcount == 493)
       begin
        vsync = 0;
       end

      else if(vcount == 495)
       begin
        vsync = 1;
       end

     if(vcount>=479)
       begin
        displaycase=0;
       end

     if(displaycase==0)
       begin
        red=4'b0000;
        green=4'b0000;
        blue=4'b0000;
       end
     else
        begin
           if(((hcount>=xcoord-snakewidthoffset)&&(hcount<=xcoord+snakewidthoffset))&&((vcount>=ycoord-snakeheightoffset)&&(vcount<=ycoord+snakeheightoffset)))
                if(collided==0)
                begin
                     red=pixel[11:8];
                     green=pixel[7:4];
                     blue=pixel[3:0];
                end
                else
                begin
                       red=4'b0000;
                       green=4'b1111;
                       blue=4'b0000;
                end
             else if(blackflag==1)
                begin
                    red=4'b0000;
                    green=4'b0000; 
                    blue=4'b0000;
                end    
             else if(collided==1)
                begin
                    red=4'b1111;
                    green=4'b0000;
                    blue=4'b0000;
                end
             else 
                begin
                   red=4'b1111;
                   green=4'b1111;
                   blue=4'b1111;
                end   
        end

    displaycase=1;

  end
  DFF hsyncflop(hsync,pixclk,hsyncstable);
  DFF vsyncflop(vsync,pixclk,vsyncstable);
  DFF4bit redflop(red,pixclk,redstable);
  DFF4bit greenflop(green,pixclk,greenstable);
  DFF4bit blueflop(blue,pixclk,bluestable);

endmodule
