module tb();
parameter WIDTH=4;
reg clk 		;
reg rst_n		;
reg wr_en		;
reg rd_en		;
reg [WIDTH-1:0] wr_data	;

wire rd_empty		;
wire wr_full		;
wire  [WIDTH-1:0] rd_data;


initial begin
clk=0;
rst_n=1;
wr_en=0;
rd_en=0;
wr_data=0;
#200
rst_n=0;
#300
rst_n=1;
wr_en=1;
wr_data=4;
#10
wr_data=3;
#10
wr_data=2;
#10
wr_data=1;
#10
wr_data=1;
#10
wr_data=0;
rd_en=1;
#10
wr_data=4;
#10
wr_data=5;
#10
wr_data=7;
#300
$finish;

end



always #5 clk=~clk;

sync_fifo u1(
.clk 		(clk),
.rst_n		(rst_n),
.wr_en		(wr_en),
.rd_en		(rd_en),
.wr_data	(wr_data),
.rd_empty	(rd_empty),	
.wr_full	(wr_full),	
.rd_data	(rd_data)
);

initial begin 
$vcdpluson;
end



endmodule
