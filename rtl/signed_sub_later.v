module signed_sub_later (
  input                 clk,
  input                 rst_n,
  input [4-1:0]         aIn,
  input [4-1:0]         bIn,
  output signed [5-1:0] subOut
);

  reg signed [5-1:0]    a_r;
  reg signed [5-1:0]    b_r;
  reg signed [5-1:0]    sub1_r;
  reg signed [5-1:0]    sub2_r;
  reg signed [6-1:0]    sub3_r;

  always @( posedge clk ) begin
    a_r <= aIn;   b_r <= bIn;
    sub1_r <= a_r - b_r;
    sub2_r <= sub1_r;
    sub3_r <= sub2_r;
  end

  assign subOut = sub3_r[4-1:0];

endmodule
