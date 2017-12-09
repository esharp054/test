// testbench for register_file.v
module register_file_tb;
    reg clk;
    reg [4:0]  r1_addr;
    reg [4:0]  r2_addr;
    reg [4:0]  wr_addr;
    reg [31:0] wr_data;
    reg reg_write;

    wire [31:0] r1_data;
    wire [31:0] r2_data;

    register_file test(clk,r1_addr,r1_data,r2_addr,r2_data,wr_addr,wr_data,reg_write);

    // Test Case 1:
    // Write '42' to register 2, verify with Read 1 and 2
    initial
    begin
        wr_addr = 5'd2;
        wr_data = 32'd42;
        reg_write = 1;
        r1_addr = 5'd2;
        r2_addr = 5'd2;
        #1 clk=1; #1 clk=0;	// Generate single clock pulse
        // Verify expectations and report test result
        if((r1_data != 42) || (r2_data != 42))
            $display("Test Case 1 Failed");
        else
            $display("Test Case 1 Succeed");
        $display($time," reg_write=%b",reg_write);
        $display($time," r1_data=%d,r2_data=%d,wr_data=%d",r1_data,r2_data,wr_data);
    end

    // Test Case 2:
    // Write '41' to register 2, verify write enable signal
    initial
    begin
        #2 wr_addr = 5'd2;
        #2 wr_data = 32'd41;
        #2 reg_write = 0;
        #2 r1_addr = 5'd2;
        #2 r2_addr = 5'd2;
        // Verify expectations and report test result
        if((r1_data != 41) && (r2_data != 41))
            $display("Test Case 2 Succeed");
        else
            $display("Test Case 2 Failed");
        $display($time," reg_write=%b",reg_write);
        $display($time," r1_data=%d,r2_data=%d,wr_data=%d",r1_data,r2_data,wr_data);
    end

endmodule
