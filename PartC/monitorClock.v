module pixelclk(clk,pclk);
inout clk;
output reg pclk;

reg [2:0]counter;

initial
begin
  counter=0;
  pclk=0;
end

always@(posedge clk)
begin
  if(counter==1) //divide clock by 4 to get 25MHz
    begin
      counter<=0;
      pclk<=~pclk;
    end
  else
    begin
      counter<=counter+1;
    end
end
endmodule
