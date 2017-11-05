module seven_seg_displayLab5(clk1k,firstdigit,seg1,seg2,anode,cathodes);
input clk1k;
input firstdigit;
input [3:0]seg1;
input [3:0]seg2;
output reg  [3:0]anode;
output reg  [6:0]cathodes;

reg [3:0]anode_cycle_output;
reg anode_cycle;
reg [6:0]seg_rom[15:0];

initial
  begin
  anode_cycle_output=4'b0000;
  anode_cycle=2'b00;
  anode=4'b1111;
  seg_rom[0]=7'b1000000; //0 gfedcba   ///A///
  seg_rom[1]=7'b1111001; //1           F     B
  seg_rom[2]=7'b0100100; //2           ///G///
  seg_rom[3]=7'b0110000; //3           E     C
  seg_rom[4]=7'b0011001; //4           ///D///
  seg_rom[5]=7'b0010010; //5
  seg_rom[6]=7'b0000010; //6
  seg_rom[7]=7'b1111000; //7
  seg_rom[8]=7'b0000000; //8
  seg_rom[9]=7'b0011000; //9
  seg_rom[10]=7'b0001000; //A
  seg_rom[11]=7'b0000011; //b
  seg_rom[12]=7'b1000110; //C
  seg_rom[13]=7'b0100001; //D
  seg_rom[14]=7'b0000110; //E
  seg_rom[15]=7'b0001110; //F
  end
always@(posedge clk1k) begin
    if(firstdigit==0)
    begin
        anode<=4'b1111;
    end
    else    
    begin
    case(anode_cycle)
    0:begin
        anode<=4'b1110;
        cathodes<=seg_rom[seg2];
      end
    1:begin
        anode<=4'b1101;
        cathodes<=seg_rom[seg1];
      end
    default:
      begin
        anode<=4'b1111;
      end
    endcase
    anode_cycle<=anode_cycle+1;
    if(anode_cycle==2)
        begin
            anode_cycle<=0;
        end
  end
 end 
endmodule
