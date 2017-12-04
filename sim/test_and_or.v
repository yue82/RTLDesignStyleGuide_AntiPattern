`timescale 1 ps / 1 ps
module test_and_or;
  parameter STEP = 100;

  reg clk;

  reg [4-1:0] aIn_r;
  reg [4-1:0] bIn_r;
  reg         doAnd_r;
  reg         doOr_r;
  wire        isAnd;
  wire [4-1:0] out;

  reg [2-1:0]  failedCount_r;
  reg          isFailed_r;

  base_and_or and_or (
                      .aIn(aIn_r),
                      .bIn(bIn_r),
                      .doAnd(doAnd_r),
                      .doOr(doOr_r),
                      .isAnd(isAnd),
                      .out(out)
                      );

  always begin
    clk = 1;
    #( STEP/2 );
    clk = 0;
    #( STEP/2 );
  end

  initial begin
    // init input
    input_data(4'b0000, 4'b0000, 1'b0, 1'b0);
    failedCount_r <= 2'd0;

    @( posedge clk );

    // test
    input_data(4'b0101, 4'b0011, 1'b1, 1'b0);
    @( posedge clk );
    check_result(isAnd, out, doAnd_r, 4'b0001, isFailed_r);
    failedCount_r += isFailed_r;

    input_data(4'b0101, 4'b0011, 1'b0, 1'b1);
    @( posedge clk );
    check_result(isAnd, out, doAnd_r, 4'b0111, isFailed_r);
    failedCount_r += isFailed_r;

    input_data(4'b1111, 4'b1111, 1'b1, 1'b1);
    @( posedge clk );
    check_result(isAnd, out, 1'bx, 4'b000, isFailed_r);
    failedCount_r += isFailed_r;


    if (failedCount_r == 0) $display("AND_OR SUCCESS!");
    else $display("AND_OR FAILED (count: %d)", failedCount_r);

    $finish;
  end

  task input_data;
    input [4-1:0]  aIn_i;
    input [4-1:0]  bIn_i;
    input          doAnd_i;
    input          doOr_i;
    begin
      aIn_r <= aIn_i;
      bIn_r <= bIn_i;
      doAnd_r <= doAnd_i;
      doOr_r <= doOr_i;
    end
  endtask

  task check_result(
                    input         isAnd_o,
                    input [4-1:0] out_o,
                    input         doAnd_i,
                    input [4-1:0] answer,
                    output        isFailed
                    );
    begin
      if (isAnd_o != doAnd_i) begin
        $display("test failed(isAnd!=doAnd): %b != %b", isAnd_o, doAnd_i);
        isFailed = 1'b1;
      end else if (out_o != answer) begin
        $display("test failed(out!=answer): %b != %b", out_o, answer);
        isFailed = 1'b1;
      end else begin
        isFailed = 1'b0;
      end
    end
  endtask

endmodule
