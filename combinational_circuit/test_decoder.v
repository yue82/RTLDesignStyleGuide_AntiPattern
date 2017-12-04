`timescale 1 ps / 1 ps
module test_decoder;

  parameter STEP = 100;

  reg [2-1:0]  in_r;
  reg          en_r;
  wire [4-1:0] out;

  decoder decoder (
                   .in(in_r),
                   .en(en_r),
                   .out(out)
                   );

  initial begin
    $shm_open ("./decoder.shm");
    $shm_probe("ASCMTF");

    // init input
    // todo

    @( posedge clk );

    // test
    // todo
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
                    output        isFailed,
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
