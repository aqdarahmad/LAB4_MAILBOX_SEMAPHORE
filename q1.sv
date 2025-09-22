module q;

logic [15:0] mem[3:0];
logic [1:0] addr;
logic [15:0] wdata , rdata;

initial begin
addr = 2'b01;
wdata = 16'hABCD; 
fork 
write_mem();
read_mem();
join 
end

task write_mem;

$display("T = %0t Before the delay",$time);
#5;
mem[addr] <= wdata;

$display("T = %0t After the delay, ",$time);

endtask
//



task read_mem;

$display("T = %0t Before the delay, ",$time);
#4;
rdata <= mem[addr];

$display("T = %0t After the delay, ",$time);


endtask

endmodule
