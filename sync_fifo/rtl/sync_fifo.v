module sync_fifo#(
parameter WIDTH=32,
parameter DEPTH=4 //it represent depth=16

)
(
input clk,
input rst_n,
input wr_en,
input rd_en,
input [WIDTH-1:0] wr_data,

output rd_empty,
output wr_full,
output reg [WIDTH-1:0] rd_data
);

//define reg 
reg [WIDTH-1:0] fifo_mem[{(DEPTH){1'b1}}:0];
reg [DEPTH-1:0] wr_addr;
reg [DEPTH-1:0] rd_addr;
reg [DEPTH:0] cnt;

//reg memory

integer i;

always@(posedge clk or negedge rst_n)
	if(!rst_n) begin
		for(i=0;i<={(DEPTH){1'b0}};i=i+1)
		fifo_mem[i]<={(WIDTH){1'b0}};
	end
	else if(wr_en&(!wr_full))
		fifo_mem[wr_addr]<=wr_data;
		
always@(posedge clk or negedge rst_n)
	if(!rst_n) begin
		rd_data<={(WIDTH){1'b0}};
	end
	else if(rd_en&(!rd_empty))
		rd_data<=fifo_mem[rd_addr];

//addr 

always@(posedge clk or negedge rst_n)
	if(!rst_n)
		wr_addr<=0;
	else if(wr_en&&(!wr_full))
		wr_addr<=wr_addr+1'b1;
		
always@(posedge clk or negedge rst_n)
	if(!rst_n)
		rd_addr<=0;
	else if(rd_en&&(!rd_empty))
		rd_addr<=rd_addr+1'b1;
		
//counter for data
always@(posedge clk or negedge rst_n)
	if(!rst_n)
		cnt<=0;
	else if((wr_en&&(!wr_full))&&(!(rd_en&&(!rd_empty))))
		cnt<=cnt+1;
	else if((rd_en&&(!rd_empty))&&(!(wr_en&&(!wr_full))))
		cnt<=cnt-1;
	else if((wr_en&&(!wr_full))&&(rd_en&&(!rd_empty)))
		cnt<=cnt;
	else
		cnt<=0;
		
//wr_full rd_empty
assign wr_full=(cnt==({(DEPTH){1'b1}}+1))?1'b1:0;
assign rd_empty=(cnt==({(DEPTH){1'b1}}+1))?1'b1:0;		

endmodule				
