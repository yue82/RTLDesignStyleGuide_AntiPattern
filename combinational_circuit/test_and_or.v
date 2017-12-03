`timescale 1 ps / 1 ps
module test_and_or;

  reg          clk;
  reg [4-1:0]  aIn_r;
  reg [4-1:0]  bIn_r;
  reg          doAnd_r;
  reg          doOr_r;
  wire         isAnd;
  wire [4-1:0] out;

  and_or and_or (
                 .aIn(aIn_r),
                 .bIn(bIn_r),
                 .doAnd(doAnd_r),
                 .doOr(doOr_r),
                 .out(out)
                 );

  always begin
    clk = 1;
    #( STEP/2 );
    clk = 0;
    #( STEP/2 );
  end

  initial begin
    $shm_open ("./and_or.shm");
    $shm_probe("ASCMTF");

    // init input
    // todo

    @( posedge clk );

    // test
    // todo
  end
endmodule
