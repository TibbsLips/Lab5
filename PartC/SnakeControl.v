module snakeControl(keycode1,keycode2,strobe,pixclk,pixel,xcoord,ycoord);
input [3:0]keycode1;
input [3:0]keycode2;
input strobe;
input pixclk;

output reg [11:0]pixel;
output reg [10:0]xcoord;
output reg [10:0]ycoord;

#reg [10:0]headstartposition;
reg [6:0]length; //in case we want to expand length, make larger 40 is 0101000
reg [4:0]width;  //10 is 01010

intitial
begin
  length=7'b0101000;
  width=5'b01010;
  xcoord=11'b00000101000;
  ycoord=11'b00011110000;
end

always@(posedge pixclk)
begin
  if((keycode1==4'b0111)&&(keycode2==4'b0101))//up
    begin

    end
  if((keycode1==4'b0111)&&(keycode2==4'b0010))//down
    begin

    end
  if((keycode1==4'b0110)&&(keycode2==4'b1011))//left
    begin

    end
  if((keycode1==4'b0111)&&(keycode2==4'b0100))//right
    begin

    end



end



endmodule
