module snakeControl(keycode1,keycode2,strobe,pixclk,pixel,xcoord,ycoord,snakeheightoffset,snakewidthoffset,blackflag);
input [3:0]keycode1;
input [3:0]keycode2;
input strobe;
input pixclk;

output reg [11:0]pixel;
output reg [10:0]xcoord;
output reg [10:0]ycoord;
output reg [6:0]snakeheightoffset;
output reg [6:0]snakewidthoffset;
output reg blackflag;

//reg [10:0]headposition;
reg [6:0]length; //in case we want to expand length, make larger 40 is 0101000
reg [6:0]width;  //10 is 01010
reg [6:0]vertical;
reg [6:0]horizontal;
reg [1:0]snakedirection; //00=right, 01=down, 10=left, 11=up
reg [1:0]gamestate; //state for features
initial
begin
  blackflag=1;
  gamestate=2'b00;
  snakeheightoffset=7'b0000000;
  snakewidthoffset= 7'b0000000;
  snakedirection=2'b00;
  xcoord=11'b00000000000;
  ycoord=11'b00011110000; //240 px halfway down screen
end

always@(posedge pixclk)
begin
if((keycode1==4'b0001)&&(keycode2==4'b1011))
    begin
       gamestate<=2'b01;
    end
if((keycode1==4'b0111)&&(keycode2==4'b0110))
    begin
       gamestate<=2'b00;
    end
if((keycode1==4'b0100)&&(keycode2==4'b1101))
    begin
       gamestate<=2'b10;
    end    
if((gamestate==2'b10)&&(keycode1==4'b0010)&&(keycode2==4'b1101))
    begin
        gamestate<=2'b01;
    end        
    
case(gamestate)

0:begin
    blackflag<=1;
    snakedirection<=2'b00;
    snakeheightoffset<=5;
    snakewidthoffset<=20;
    xcoord=11'b00000000000;
    ycoord=11'b00011110000;
    pixel=12'b000000000000;
  end
1:begin    
  blackflag<=0;
  if((keycode1==4'b0111)&&(keycode2==4'b0101)&&(snakedirection!=2'b01)&&(snakedirection!=2'b11))//up
    begin
      snakedirection<=2'b11;                                           //update direction
      snakeheightoffset<=20;
      snakewidthoffset<=5;
    end
  if((keycode1==4'b0111)&&(keycode2==4'b0010)&&(snakedirection!=2'b11)&&(snakedirection!=2'b01))//down
    begin
      snakedirection<=2'b01;
      snakeheightoffset<=20;
      snakewidthoffset<=5;
    end
  if((keycode1==4'b0110)&&(keycode2==4'b1011)&&(snakedirection!=2'b00)&&(snakedirection!=2'b10))//left
    begin
      snakedirection<=2'b10;
      snakeheightoffset<=5;
      snakewidthoffset<=20;
    end
  if((keycode1==4'b0111)&&(keycode2==4'b0100)&&(snakedirection!=2'b10)&&(snakedirection!=2'b00))//right
    begin
      snakedirection<=2'b00;
      snakeheightoffset<=5;
      snakewidthoffset<=20;
    end
///above was to update position, below is to update the coordinates and the pixel
  if(snakedirection==2'b11) //up
    begin
      ycoord<=ycoord-1;
      if(ycoord>=480)      //sync ycoord with vcount
      begin
        ycoord<=0;
      end
    end
  if(snakedirection==2'b01) //down
    begin
      ycoord<=ycoord+1;
      if(ycoord<=0)
      begin
        ycoord<=0;
      end
    end
  if(snakedirection==2'b10) //left
    begin
      xcoord<=xcoord-1;
      if(xcoord<=0)
      begin
        xcoord<=0;
      end
    end
  if(snakedirection==2'b00) //right
    begin
      xcoord<=xcoord+1;
      if(xcoord>=640)
      begin
        xcoord<=0;
      end
    end
////now for pixel color
  if((snakedirection==2'b11)&&(ycoord>=0)) //up
    begin
      pixel<=12'b000000001111;            //blue
    end
  else if((snakedirection==2'b01)&&(ycoord<=480)) //down
    begin
      pixel<=12'b000000001111;            //blue
    end
  else if((snakedirection==2'b10)&&(xcoord>=0)) //left
    begin
      pixel<=12'b000000001111;            //blue
    end
  else if((snakedirection==2'b00)&&(xcoord<=800)) //right
    begin
      pixel<=12'b000000001111;            //blue
    end
  else
    begin
        pixel<=12'b111111111111;          //white
    end
end
2:begin
    blackflag<=0;
    snakedirection=snakedirection;
    snakeheightoffset<=snakeheightoffset;
    snakewidthoffset<=snakewidthoffset;
    xcoord<=xcoord;
    ycoord<=ycoord;
    pixel<=pixel;
  end
3:begin
    blackflag<=0;
    snakedirection=snakedirection;
    snakeheightoffset<=snakeheightoffset;
    snakewidthoffset<=snakewidthoffset;
    xcoord<=xcoord;
    ycoord<=ycoord;
    pixel<=pixel;
  end  

endcase

end

endmodule
