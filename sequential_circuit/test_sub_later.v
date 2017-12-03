`timescale 1 ps / 1 ps
module test_sub_later;

  reg                 clk;
  reg                 rst_n;
  reg [4-1:0]         aIn_r;
  reg [4-1:0]         bIn_r;
  wire signed [5-1:0] subOut;

  sub_later sub_later (
                       .clk(clk),
                       .rst_n(rst_n),
                       .aIn(aIn_r),
                       .bIn(bIn_r),
                       .subOut(subOut)
                       );

  always begin
    clk = 1;
    #( STEP/2 );
    clk = 0;
    #( STEP/2 );
  end

  initial begin
    rst_n = 1'b0;
    #( STEP*3.5 );
    rst_n = 1'b1;
  end

  initial begin
    $shm_open ("./sub_later.shm");
    $shm_probe("ASCMTF");

    // init input
    // todo

    @( posedge rst_n );
    @( posedge clk );

    // test
    // todo
  end
endmodule
