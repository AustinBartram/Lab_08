module top(
    input [15:0] sw,     // switches
    input btnL, btnU,    // mux select
    input btnD, btnR,    // demux select
    input btnC,          // enable
    output [15:0] led    // outputs
);

    // -------------------------
    // Select signals
    // -------------------------

    wire [1:0] mux_sel;
    wire [1:0] demux_sel;

    assign mux_sel   = {btnU, btnL};   // select sender
    assign demux_sel = {btnR, btnD};   // select receiver


    // -------------------------
    // Multiplexer output
    // -------------------------

    wire [3:0] internet_line;

    assign internet_line =
        btnC ?
        (mux_sel == 2'b00 ? sw[3:0]   :   // CEO
         mux_sel == 2'b01 ? sw[7:4]   :   // You
         mux_sel == 2'b10 ? sw[11:8]  :   // Fred
                           sw[15:12])    // Jill
        : 4'b0000;


    // -------------------------
    // Demultiplexer outputs
    // -------------------------

    wire [3:0] local_lib;
    wire [3:0] fire;
    wire [3:0] school;
    wire [3:0] rib_shack;

    assign local_lib = (demux_sel == 2'b00) ? internet_line : 4'b0000;
    assign fire      = (demux_sel == 2'b01) ? internet_line : 4'b0000;
    assign school    = (demux_sel == 2'b10) ? internet_line : 4'b0000;
    assign rib_shack = (demux_sel == 2'b11) ? internet_line : 4'b0000;


    // -------------------------
    // Connect to LEDs
    // -------------------------

    assign led[3:0]    = local_lib;   // Library
    assign led[7:4]    = fire;        // Fire Department
    assign led[11:8]   = school;      // School
    assign led[15:12]  = rib_shack;   // Rib Shack

endmodule
