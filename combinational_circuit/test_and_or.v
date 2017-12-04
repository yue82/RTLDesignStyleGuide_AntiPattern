`timescale 1 ps / 1 ps
module test_and_or;
parameter STEP = 100;

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
               .isAnd(isAnd),
               .out(out)
               );

initial begin
  // init input
  // todo

  // test
  // todo
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
