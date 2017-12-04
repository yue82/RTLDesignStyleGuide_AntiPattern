`timescale 1 ps / 1 ps
module test_sub_later;
parameter STEP = 100;

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
  // init input
  aIn_r <= 4'b0;
  // todo

  @( posedge rst_n );
  @( posedge clk );

  // test
  // todo
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
                  input signed [5-1:0] subOut_o,
                  input signed [5-1:0] answer,
                  output               isFailed
                  );
  begin
    if (subOut_o != answer) begin
      $display("test failed(subOut!=answer): %d != %d", subOut_o, answer);
      isFailed = 1'b1;
    end else begin
      isFailed = 1'b0;
    end
  end
endtask

endmodule
