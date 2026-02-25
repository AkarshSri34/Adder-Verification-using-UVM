class env extends uvm_env;
  `uvm_component_utils(env)
  
  agent agt;
  scoreboard sc;
 
  function new (string name = "env", uvm_component parent );
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = agent::type_id::create("agt",this);
    sc=scoreboard::type_id::create("sc",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    agt.mon.collect.connect(sc.recieve);
  endfunction
  
endclass
