`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "transaction.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"
module top;
  
  add_if vif();
  
  bit clk;
  bit reset;
  always #2 clk = ~clk;
  
  initial begin
    clk = 0;
    reset = 1;
    #5; 
    reset = 0;
   
  end
  
assign vif.clk   = clk;
assign vif.reset = reset;
  
  adder DUT(.clk(vif.clk),.reset(vif.reset),.in1(vif.in1),.in2(vif.in2),.out(vif.out));
  
  initial begin
    uvm_config_db#(virtual add_if)::set(null, "*", "vif", vif);
  end
  initial begin
    run_test("test");
  end
  
  initial begin
  $dumpfile("dump.vcd"); 
  $dumpvars;
  #500 $finish;
end
  
endmodule
