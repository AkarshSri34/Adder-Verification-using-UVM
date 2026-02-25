class test extends uvm_test;
  
  `uvm_component_utils(test)
  
  add_sequence seq;
  env e;
  
  function new (string name = "env", uvm_component parent );
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = add_sequence::type_id::create("seq");
    repeat(2) begin
      #5;
      seq.start(e.agt.seqr);
      
    end
    phase.drop_objection(this);
  endtask
  
endclass
