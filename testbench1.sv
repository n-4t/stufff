module multiplier_tb;
    logic [7:0] SW;
    logic Clk, Reset_Load_Clear, Run;
    logic [3:0] hex_grid;
    logic [7:0] hex_seg, Aval, Bval;
    logic Xval;
    logic Shift, Clr_Ld, Add, Sub, M;

    multiplier DUT (
        .SW(SW),
        .Clk(Clk),
        .Reset_Load_Clear(Reset_Load_Clear),
        .Run(Run),
        .hex_grid(hex_grid),
        .hex_seg(hex_seg),
        .Aval(Aval),
        .Bval(Bval),
        .Xval(Xval)
    );

    // Directly access internal signals from DUT (multiplier)
    assign Shift = DUT.Shift;
    assign Clr_Ld = DUT.Clr_Ld;
    assign Add = DUT.Add;
    assign Sub = DUT.Sub;
    assign M = DUT.M;

    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;
    end

    initial begin
        // Test 1: 7 * -59
        Reset_Load_Clear = 1;
        Run = 0;
        SW = 8'b11000101;  // -59
        #10;
        Reset_Load_Clear = 0;
        SW = 8'b00000111;  // 7
        #10;
        Run = 1;
        #10;
        Run = 0;
        #200;

        // Test 2: -7 * 59
        Reset_Load_Clear = 1;
        SW = 8'b00111011;  // 59
        #10;
        Reset_Load_Clear = 0;
        SW = 8'b11111001;  // -7
        #10;
        Run = 1;
        #10;
        Run = 0;
        #200;

        // Test 3: consecutive -1 * -1
        Reset_Load_Clear = 1;
        SW = 8'b11111111;  // -1
        #10;
        Reset_Load_Clear = 0;
        SW = 8'b11111111;  // -1
        #10;
        Run = 1;
        #10;
        Run = 0;
        #200;
        
        Run = 1;
        #10;
        Run = 0;
        #200;

        $finish;
    end

    initial begin
        $monitor("Time=%0t SW=%h Reset=%b Run=%b Clr_Ld=%b Add=%b Sub=%b Shift=%b M=%b X=%b A=%h B=%h",
                 $time, SW, Reset_Load_Clear, Run, Clr_Ld, Add, Sub, Shift, M, Xval, Aval, Bval);
    end
endmodule