//=========================================================================
// Behavioral Model of GCD Unit
//-------------------------------------------------------------------------
//

module exGCD_behav#( parameter W = 16 )
( 
  input      [W-1:0] inA, 
  input      [W-1:0] inB,
  output reg [W-1:0] out 
);

  reg [W-1:0] A;
  reg [W-1:0] B;
  reg [W-1:0] swap;
  
  integer  done;
  
  always @(*)
  begin

    done = 0;
    A = inA;
    B = inB;

    while ( !done )
    begin

      if ( A < B )
      begin
        swap = A;
        A = B;
        B = swap;
      end

      else if ( B != 0 )
        A = A - B;

      else
        done = 1;

    end
    
    out = A;
  end

endmodule
