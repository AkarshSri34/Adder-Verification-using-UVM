class add_sequence extends uvm_sequence #(transaction);
  
  `uvm_object_utils(add_sequence)
  
  transaction tr;
  
  function new (string name = "add_sequence" );
    super.new(name);
  endfunction
  
  task body();
    repeat (3)begin
      tr = transaction::type_id::create("tr");
      start_item(tr);
      tr.randomize();
      finish_item(tr);
    end
  endtask
  
endclass
