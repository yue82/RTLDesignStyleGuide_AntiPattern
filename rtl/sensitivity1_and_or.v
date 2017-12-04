module sensitivity1_and_or (
  input [4-1:0]  aIn,
  input [4-1:0]  bIn,
  input          doAnd,
  input          doOr,
  output         isAnd,
  output [4-1:0] out
);

  reg            isAnd_r;
  reg [4-1:0]    out_r;

  always @( aIn or bIn ) begin
    if (doAnd && !doOr) begin
      out_r = aIn & bIn;
      isAnd_r = 1'b1;
    end else if (doOr && !doAnd) begin
      out_r = aIn | bIn;
      isAnd_r = 1'b0;
    end else begin
      out_r = 4'b0000;
      isAnd_r = 1'bx;
    end
  end

  assign isAnd = isAnd_r;
  assign out = out_r;

endmodule
