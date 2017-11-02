module keyboardInput(clk,ps2clk,ps2data,keycode1,keycode2,strobe);
input clk,ps2clk,ps2data;
output reg [3:0]keycode1; //changed from output reg
output reg [3:0]keycode2; //changed from output reg

output reg strobe;
integer strobetime;
reg strobeenable;

reg [21:0]shiftregister;

initial
begin
  keycode1=4'b0000;                              //8 bits to represent 2 hex values
  keycode2=4'b0000;
  strobe=0;
  strobetime=0;
  strobeenable=0;
  shiftregister=22'b0000000000000000000000;
end

always@(negedge ps2clk)
begin
    //shiftregister={shiftregister[20:0],ps2data};
    shiftregister={ps2data,shiftregister[21:1]};

    //if(shiftregister[20:13]==8'b11110000) //may need to be 00001111
    if(shiftregister[8:1]==8'b11110000)
      begin
        strobeenable<=1;
      //  keycode1<=shiftregister[9:6];    //if so these will be reversed
        keycode1<=shiftregister[19:16];

      //  keycode2<=shiftregister[5:2];
        keycode2<=shiftregister[15:12];

        shiftregister<=22'b0000000000000000000000;
      end
    else
      begin
        strobeenable<=0;
        keycode1<=keycode1;
        keycode2<=keycode2;
        shiftregister<=shiftregister;
      end

end

always@(posedge clk)
begin
  if(strobeenable==1)               //if strobe enable is 1 we should strobe for 100 ms
    begin
      if(strobetime<=10000000)
          begin
            strobe<=1;
            strobetime<=strobetime+1;
          end
      else
        begin
          strobe<=0;                  //after 100ms we should turn strobe off and reset timer
          strobetime<=0;
        end
    end
  else                                //if strobe enable is 0, we should not strobe

    begin
      if(strobe==1)
          begin
	   if(strobetime<=10000000)
	      begin
		strobe<=strobe;
           	strobetime<=strobetime+1;
	      end
	   else
	      begin
		strobe<=0;
		strobetime<=0;
	      end
         end
      else
        begin
          strobe<=0;                  //after 100ms we should turn strobe off and reset timer
          strobetime<=0;
        end
    end
end

endmodule
