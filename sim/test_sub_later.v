`timescale 1 ps / 1 ps
module test_sub_later;
  parameter STEP = 100;

  reg                 clk;

  reg                 rst_n;
  reg [4-1:0]         aIn_r;
  reg [4-1:0]         bIn_r;
  wire signed [5-1:0] subOut;

  reg [2-1:0]         failedCount_r;
  reg                 isFailed_r;

  base_sub_later sub_later (
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
    // init input
    input_data(4'd0, 4'd0);
    failedCount_r <= 2'd0;

    @( posedge rst_n );
    @( posedge clk );

    // test
    input_data(4'd10, 4'd6);
    @( posedge clk );
    input_data(4'd5, 4'd8);
    @( posedge clk );
    input_data(4'd3, 4'd3);

    repeat (3) @( posedge clk );

    check_result(subOut, 4, isFailed_r);
    failedCount_r += isFailed_r;
    @( posedge clk );
    check_result(subOut, -3, isFailed_r);
    failedCount_r += isFailed_r;
    @( posedge clk );
    check_result(subOut, 0, isFailed_r);
    failedCount_r += isFailed_r;

    if (failedCount_r == 0) $display("SUB SUCCESS!");
    else $display("SUB FAILED (count: %d)", failedCount_r);

    $finish;
  end

  task input_data;
    input [4-1:0]  aIn_i;
    input [4-1:0]  bIn_i;
    begin
      aIn_r <= aIn_i;
      bIn_r <= bIn_i;
    end
  endtask

  task check_result(
                    input signed [5-1:0] subOut_i,
                    input signed [5-1:0] answer,
                    output               isFailed
                    );
    begin
      if (subOut_i != answer) begin
        $display("test failed(subOut!=answer): %d != %d", subOut_i, answer);
        isFailed = 1'b1;
      end else begin
        isFailed = 1'b0;
      end
    end
  endtask

endmodule
