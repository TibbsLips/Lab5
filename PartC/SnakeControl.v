module snakeControl(keycode1,keycode2,strobe,pixclk,pixel,xcoord,ycoord);
input [3:0]keycode1;
input [3:0]keycode2;
input strobe;
input pixclk;

output reg [11:0]pixel;
output reg [10:0]xcoord;
output reg [10:0]ycoord;

#reg [10:0]headposition;
reg [6:0]length; //in case we want to expand length, make larger 40 is 0101000
reg [6:0]width;  //10 is 01010
reg [6:0]vertical;
reg [6:0]horizontal;
reg [1:0]snakedirection; //00=right, 01=down, 10=left, 11=up
intitial
begin
  snakedirection=2'b00;
  length=7'b0101000;
  width= 7'b0001010;
  vertical=7'b0001010;  //start out going right-> the width will be on the vertical
  horizontal=7'b0101000; //start out going right-> the length will be on the horizontal
  xcoord=11'b00000101000; //40 px for the length of the snake
  ycoord=11'b00011110000; //240 px halfway down screen
end

always@(posedge pixclk)
begin
  if((keycode1==4'b0111)&&(keycode2==4'b0101)&&(snakedirection!=2'b01))//up
    begin
      snakedirection<=2'b11;
    end
  if((keycode1==4'b0111)&&(keycode2==4'b0010)&&(snakedirection!=2'b11))//down
    begin
      snakedirection<=2'b01;
    end
  if((keycode1==4'b0110)&&(keycode2==4'b1011)&&(snakedirection!=2'b00))//left
    begin
      snakedirection<=2b'10;
    end
  if((keycode1==4'b0111)&&(keycode2==4'b0100)&&(snakedirection!=2'b10))//right
    begin
      snakedirection<=2'b00;
    end
///above was to update position, below is to update the coordinates and the pixel
  if(snakedirection==2'b11) //up
    begin
      ycoord<=ycoord+1;
    end
  if(snakedirection==2'b01) //down
    begin
      ycoord<=ycoord-1;
    end
  if(snakedirection==2'b10) //left
    begin
      xcoord<=xcoord-1;
    end
  if(snakedirection==2'b00) //right
    begin
      xcoord<=xcoord+1;
    end
////now for pixel color




end


endmodule
