class monitor extends uvm_monitor;
  `uvm_component_utils(monitor);
  
  uvm_analysis_port#(transaction) collect;
  transaction tr;
  
  function new(string name="monitor",uvm_component parent);
    super.new(name,parent);
    collect = new("collect",this);
    tr=transaction::type_id::create("tr");
  endfunction
  
  virtual add_if vif;
  
  function void build_phase(uvm_phase phase);
    if(!(uvm_config_db#(virtual add_if)::get(this,"","vif",vif)))
       `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction 
  
  task run_phase(uvm_phase phase);
    forever begin
      wait(!vif.reset);
      @(posedge vif.clk);
      tr.in1 = vif.in1;
      tr.in2 = vif.in2;
      `uvm_info(get_type_name, $sformatf("in1 = %0d, in2 = %0d", tr.in1, tr.in2), UVM_HIGH);
      tr.out = vif.out;
      collect.write(tr);
    end
  endtask
endclass
