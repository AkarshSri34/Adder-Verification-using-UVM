class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
 
  virtual add_if vif;
  transaction tr;
  
  function new(string name="driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    if(!(uvm_config_db#(virtual add_if)::get(this,"","vif",vif)))
       `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction 
  
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(tr);
      drive();
      seq_item_port.item_done();
    end
   endtask
       
   task drive();
     @(posedge vif.clk);
     vif.in1 = tr.in1;
     vif.in2 = tr.in2;
   endtask
endclass
