module q;

  logic [15:0] mem [0:3];   // 4 memory locations, each 16-bit
  logic [1:0] addr;         // 2-bit address (0 to 3)
  logic [15:0] wdata, rdata;

  // Create a semaphore with 1 key (acts like a mutex)
  semaphore mem_lock = new(1);

  initial begin
    addr  = 2'b01;        // target memory location
    wdata = 16'hABCD;     // sample write data

    fork
      write_mem();
      read_mem();
    join
  end

  task write_mem;
    $display("T = %0t [Writer] Before acquiring lock", $time);
    mem_lock.get(1);  // acquire lock

    #5;
    mem[addr] = wdata;  
    $display("T = %0t [Writer] Wrote %h to mem[%0d]", $time, wdata, addr);

    mem_lock.put(1);  // release lock
    $display("T = %0t [Writer] Released lock", $time);
  endtask

  task read_mem;
    $display("T = %0t [Reader] Before acquiring lock", $time);
    mem_lock.get(1);  // acquire lock

    #4;
    rdata = mem[addr];
    $display("T = %0t [Reader] Read %h from mem[%0d]", $time, rdata, addr);

    mem_lock.put(1);  // release lock
    $display("T = %0t [Reader] Released lock", $time);
  endtask

endmodule

