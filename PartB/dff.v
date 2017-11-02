module DFF(d,clk,q);
input [3:0]d;
input clk;
output reg [3:0]q;

initial
  begin
    q<=0;
  end

always@(posedge clk)
  begin
    q<=d;
  end
endmodule    
