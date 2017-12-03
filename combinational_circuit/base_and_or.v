module and_or (
                input [4-1:0]  aIn,
                input [4-1:0]  bIn,
                input          doAnd,
                input          doOr,
                output         isAnd,
                output [4-1:0] out
               ) ;

  always @(aIn or bIn or doOr) begin
    if (doAnd && !doOr) begin
      out = aIn && bIn;
      isAnd = 1'b1;
    end else if (doOr && !doAnd) begin
      out = aIn || bIn;
      isAnd = 1'b0;
    end else begin
      out = 4'b0000;
      isAnd = 1'bx;
    end
  end

endmodule
