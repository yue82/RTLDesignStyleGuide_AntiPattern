`timescale 1 ps / 1 ps
module test_decoder;
  parameter STEP = 100;

  reg clk;

  reg [2-1:0] in_r;
  reg         en_r;
  wire [4-1:0] out;

  reg [2-1:0]  failedCount_r;
  reg          isFailed_r;

  base_decoder decoder (
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
    // init input
    input_data(2'h0, 1'b0);
    failedCount_r <= 2'd0;

    @( posedge clk );

    // test
    input_data(2'h3, 1'b1);
    @( posedge clk );
    check_result(out, 4'b1000, isFailed_r);
    failedCount_r += isFailed_r;

    input_data(2'h1, 1'b1);
    @( posedge clk );
    check_result(out, 4'b0010, isFailed_r);
    failedCount_r += isFailed_r;

    input_data(2'h3, 1'b0);
    @( posedge clk );
    check_result(out, 4'b0000, isFailed_r);
    failedCount_r += isFailed_r;

    if (failedCount_r == 0) $display("DECODE SUCCESS!");
    else $display("DECODE FAILED (count: %d)", failedCount_r);

    $finish;
  end

  task input_data;
    input [2-1:0]  in_i;
    input          en_i;
    begin
      in_r <= in_i;
      en_r <= en_i;
    end
  endtask

  task check_result(
                    input [4-1:0] out_o,
                    input [4-1:0] answer,
                    output        isFailed
                    );
    begin
      if (out_o != answer) begin
        $display("test failed(out!=answer): %b != %b", out_o, answer);
        isFailed = 1'b1;
      end else begin
        isFailed = 1'b0;
      end
    end
  endtask

endmodule
