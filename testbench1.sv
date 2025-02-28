`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2025 05:03:26 PM
// Design Name: 
// Module Name: lc3_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "types.sv"
import SLC3_TYPES::*;

module lc3_tb();
    timeunit 10ns;
    timeprecision 1ns;
    
    logic        clk;
    logic        reset;
    logic        run_i;
    logic        continue_i;
    logic [15:0] sw_i;
  //  logic [15:0] hex_display_debug;
    logic [15:0] led_o;
    logic [7:0]  hex_seg_left;
	logic [3:0]  hex_grid_left;
	logic [7:0]  hex_seg_right;
	logic [3:0]  hex_grid_right;
//    logic [15:0] mem_rdata;
//    logic [15:0] mem_wdata;
//    logic [15:0] mem_addr;
//    logic        mem_mem_ena;
//    logic        mem_wr_ena;

    processor_top processor(.*);
    //instantiate cpu and memory
//    cpu CPU (
//        .clk(clk),
//        .reset(reset),
//        .run_i(run_i),
//        .continue_i(continue_i),
//        .hex_display_debug(hex_display_debug),
//        .led_o(led_o),
//        .mem_rdata(mem_rdata),
//        .mem_wdata(mem_wdata),
//        .mem_addr(mem_addr),
//        .mem_mem_ena(mem_mem_ena),
//        .mem_wr_ena(mem_wr_ena)
//    );
    
    
//    test_memory mem (
//        .clk(clk),
//        .reset(reset),
//        .data(mem_wdata),
//        .address(mem_addr[9:0]), // 10-bit address from memory interface
//        .ena(mem_mem_ena),
//        .wren(mem_wr_ena),
//        .readout(mem_rdata)
//    );
    
    
    initial begin: CLOCK_INIT
        clk = 0;
     end
     
     always begin: CLOCK_GEN
        #1 clk = ~clk; // 100 MHz clock (10ns period)
    end
    
    initial begin: test
        reset = 1;
        run_i = 0;
        continue_i = 0;
        sw_i = 16'b0001001001000010;    //R1 <-- R1 AND R2, hopefully
        
        //display internal vars to console
        //$monitor ("Time: %0t | State: %s | PC: %h | IR: %h | MAR: %h | MDR: %h | Mem_addr: %h | Mem_rdata: %h | Led_o: %h",$time, CPU.cpu_control.state.name(), CPU.pc, CPU.ir, CPU.mar, CPU.mdr, mem_addr, mem_rdata, led_o);
        
        
        repeat (2) @(posedge clk);
    //    #2
        reset <= 0;
        run_i <= 1;
     //   #20
        repeat (20) @(posedge clk);  //wait 3 cycles
//        continue_i <=1;
//        #10
//        continue_i <=0;


        $finish();
    end
endmodule
