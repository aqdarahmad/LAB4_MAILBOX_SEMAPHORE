module mailbox_example;

  
  mailbox my_mailbox;

  
  int val1;
  string name1;

  
  initial begin
    my_mailbox = new();
    val1  = 21;
    name1 = "Aqdar";

    fork
      task1(val1, name1);
      task2();
    join
  end

  
  task task1(input int val, input string str);
    begin
      $display("Task1: Before put - value: %0d, name: %s", val, str);
      
      my_mailbox.put(val);
      my_mailbox.put(str);
      $display("Task1: After put - value: %0d, name: %s", val, str);
    end
  endtask

  
  task task2;
    int val;
    string str;
    begin
      $display("Task2: Before get");
      
      my_mailbox.get(val);
      my_mailbox.get(str);
      $display("Task2: After get - value: %0d, name: %s", val, str);
    end
  endtask

endmodule

