`timescale 1 ps / 1 ps
module test_decoder;

  reg          clk;
  reg [2-1:0]  in_r;
  reg          en_r;
  wire [4-1:0] out;

  decoder decoder (
                   .in(in_r),
                   .en(en_r),
                   .out(out)
                   );

  always begin
    clk = 1;
    #( STEP/2 );
    clk = 0;
    #( STEP/2 );
  end

  initial begin
    $shm_open ("./decoder.shm");
    $shm_probe("ASCMTF");

    // init input
    // todo

    @( posedge clk );

    // test
    // todo
  end
endmodule
