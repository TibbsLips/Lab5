module keyboardInput(clk,ps2clk,ps2data,keycode1,keycode2,strobe,firstdigit);
input clk,ps2clk,ps2data;
output reg [3:0]keycode1; //changed from output reg
output reg [3:0]keycode2; //changed from output reg
output reg firstdigit;
output reg strobe;
reg [24:0] strobetime;
reg strobeenable;
reg [21:0]shiftregister;

initial
begin
  firstdigit<=0;
  keycode1=4'b0000;                              //8 bits to represent 2 hex values
  keycode2=4'b0000;
  strobe=0;
  strobetime=25'b0000000000000000000000000;
  strobeenable=0;
  shiftregister=22'b0000000000000000000000;
end

always@(negedge ps2clk)
begin
    shiftregister={ps2data,shiftregister[21:1]};

    if(shiftregister[8:1]==8'b11110000)
      begin
        firstdigit=1; //turn on display with first digit
        strobeenable<=1;
        keycode1<=shiftregister[19:16];
        keycode2<=shiftregister[15:12];
        shiftregister<=22'b0000000000000000000000;
      end
    else
      begin
        if(firstdigit==0)
            begin
            firstdigit=0;
            end
        else
            begin
            firstdigit=1;
            end
        strobeenable<=0;
        keycode1<=keycode1;
        keycode2<=keycode2;
        shiftregister<=shiftregister;
      end

end

always@(posedge clk)
begin

case(strobeenable)

    0:begin
        strobe<=0;
        strobetime<=25'b0000000000000000000000000;
      end
    1:begin
        if(strobetime<10000000)
            begin
            strobe<=1;
            strobetime<=strobetime+1;
            end
        else
            begin
            strobetime<=strobetime+1;
            if(strobetime>=10000000)
                begin
                strobetime<=10000000;
                end
            strobe<=0;
            end
      end

endcase

end

endmodule
