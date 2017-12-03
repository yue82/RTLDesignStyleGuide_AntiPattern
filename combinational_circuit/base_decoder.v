module decoder (
                input [2-1:0]  in,
                input          en,
                output [4-1:0] out
                );

  function [4-1:0] dec;
    input [2-1:0]              in;
    input                      en;
    begin
      if (en)
        case (in)
          2'h0: dec = 4'b0001;
          2'h1: dec = 4'b0010;
          2'h2: dec = 4'b0100;
          2'h3: dec = 4'b1000;
          default: dec = 4'bxxxx;
        endcase // case (in)
      else
        dec = 4'b0000;
    end
  endfunction

  assign out = dec( in, en );

endmodule
