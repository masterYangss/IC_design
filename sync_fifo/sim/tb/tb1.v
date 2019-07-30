module tb1();
  parameter FIFO_DATA_WIDTH = 32   ; 
  parameter FIFO_ADDR_WIDTH = 8    ;
  reg                           clk          ; //fifo clock 
  reg                           rst_n        ; //fifo clock reset (0: reset)
  reg                           fifo_wr_en   ; //fifo write enable(1: enable)
  reg                           fifo_rd_en   ; //fifo read enable(1: enable)
  reg   [FIFO_DATA_WIDTH-1:0]   fifo_wr_data ; //fifo write data
  
  wire                          fifo_full    ; //fifo full status
  wire                          fifo_empty   ; //fifo empty status
  wire  [FIFO_ADDR_WIDTH  :0]   fifo_data_cnt; //fifo valid data
  wire  [FIFO_DATA_WIDTH-1:0]   fifo_rd_data ; //fifo read



initial begin
clk=0;
rst_n=1;
fifo_wr_en=0;
fifo_rd_en=0;
fifo_wr_data=0;
#200
rst_n=0;
#300
rst_n=1;
#10
fifo_wr_en=1;
fifo_wr_data=2;
#10
fifo_wr_data=4;
#10
fifo_wr_data=6;
#10
fifo_wr_data=8;
fifo_rd_en=1;
#10
fifo_wr_data=10;
#10
fifo_wr_data=12;

#1000
$finish;



end


always#5 clk = ~clk;

initial begin
$vcdpluson;

end
 sync_fifo  u1
      (  
         .clk          (clk),
         .rst_n        (rst_n),
         .fifo_wr_en   (fifo_wr_en),     
         .fifo_rd_en   (fifo_rd_en),
         .fifo_wr_data (fifo_wr_data),  
         .fifo_full    (fifo_full),
         .fifo_empty   (fifo_empty),
         .fifo_data_cnt(fifo_data_cnt),
         .fifo_rd_data (fifo_rd_data)
      );

endmodule
