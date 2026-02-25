class transaction extends uvm_sequence_item;
  
  rand bit [7:0] in1,in2;
       bit [8:0] out;
  
  `uvm_object_utils(transaction)
  
  function new (string name ="transaction");
    super.new(name);
  endfunction
  
  constraint c1 {in1 <100;
                 in2 <100;}
endclass
