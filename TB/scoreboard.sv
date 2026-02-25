class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(transaction, scoreboard) recieve;
  
  transaction item_q[$];
  
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    recieve= new("recieve", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(transaction tr);
    item_q.push_back(tr);
  endfunction
  
   task run_phase (uvm_phase phase);
    transaction tr;
    forever begin
      wait(item_q.size > 0);
      
      if(item_q.size > 0) begin
        tr = item_q.pop_front();
        $display("----------------------------------------------------------------------------------------------------------");
        if(tr.in1 + tr.in2 == tr.out) begin
          `uvm_info(get_type_name, $sformatf("Matched: in1 = %0d, in2 = %0d, out = %0d", tr.in1, tr.in2, tr.out),UVM_LOW);
        end
        else begin
          `uvm_error(get_name, $sformatf("NOT matched: in1 = %0d, in2 = %0d, out = %0d", tr.in1, tr.in2, tr.out));
        end
        $display("----------------------------------------------------------------------------------------------------------");
      end
    end
  endtask
  
endclass
