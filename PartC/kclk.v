module kclk(clk,clk1k);
input clk;
output clk1k;
reg [17:0] counter;
assign clk1k=counter[17];
initial begin
    counter=0;
    end

   always@(posedge clk)
   begin
    counter<=counter+1;
    end
endmodule     
