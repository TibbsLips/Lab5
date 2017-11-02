module DFF(d,clk,q);
input d;
input clk;
output reg q;

initial
  begin
    q<=0;
  end

always@(posedge clk)
  begin
    q<=d;
  end
endmodule


module DFF4bit(d,clk,q);
input [3:0]d;
input clk;
output reg [3:0]q;

initial
  begin
    q<=4'b0000;
  end
always@(posedge clk)
  begin
    q<=d;
  end
endmodule
