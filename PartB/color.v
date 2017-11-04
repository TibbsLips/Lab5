module switchColor(pixclk,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,pixel);
input pixclk;
input sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7;
output reg [11:0]pixel;

always@(posedge pixclk)
begin
    if(sw0==1)//Black
      begin
        pixel<=12'b000000000000;
      end
    else if(sw1==1)//blue
      begin
        pixel<=12'b000000001111;
      end
    else if(sw2==1)//brown
      begin
        pixel<=12'b010000100000;
      end
    else if(sw3==1)//cyan
      begin
        pixel<=12'b000010001000;
      end
    else if(sw4==1)//red
      begin
        pixel<=12'b111100000000;
      end
    else if(sw5==1)//magenta
      begin
        pixel<=12'b101000001000;
      end
    else if(sw6==1)//yellow
      begin
        pixel<=12'b111111110000;
      end
    else if(sw7==1)//white
      begin
        pixel<=12'b111111111111;
      end
    else
      begin//Black
        pixel<=12'b000000000000;
      end
  end
  endmodule
