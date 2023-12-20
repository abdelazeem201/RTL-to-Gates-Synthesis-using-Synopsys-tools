//=========================================================================
// RTL Model of GCD Unit
//-------------------------------------------------------------------------
//

`include "vcTest.v"

module gcdTestHarness_rtl;

  reg clk = 0;
  always #`CLOCK_PERIOD clk = ~clk;

  `VC_TEST_SUITE_BEGIN( "gcdGCDUnit_rtl" )
  
  //--------------------------------------------------------------------
  // Instantiate modules
  //--------------------------------------------------------------------

  // Reset register

  reg  reset_ext;
  wire reset;
  
  vcDFF_pf#(1) reset_pf
  ( 
    .clk  (clk), 
    .d_p  (reset_ext), 
    .q_np (reset) 
  );
  
  // Test source
  
  wire [63:0] src_bits;
  wire [31:0] #0.1 src_bits_A = src_bits[63:32];
  wire [31:0] #0.1 src_bits_B = src_bits[31:0];
  wire        #0.1 src_val;
  wire        src_rdy;
  wire        src_done;
 
  vcTestSource#(64) src
  (
    .clk   (clk),
    .reset (reset),
    .bits  (src_bits),
    .val   (src_val),
    .rdy   (src_rdy),
    .done  (src_done)
  );

  // GCD unit
  
  wire [31:0] result_bits_data;
  wire        result_val;
  wire        #0.1 result_rdy;
  
  gcdGCDUnit_rtl#(32) gcd
  ( 
    .clk              (clk),
    .reset            (reset),

    .operands_bits_A  (src_bits_A),
    .operands_bits_B  (src_bits_B),  
    .operands_val     (src_val),
    .operands_rdy     (src_rdy),

    .result_bits_data (result_bits_data), 
    .result_val       (result_val),
    .result_rdy       (result_rdy)

  );

  // Test sink
  
  wire sink_done;
  
  vcTestSink#(32) sink
  (
    .clk   (clk),
    .reset (reset),
    .bits  (result_bits_data),
    .val   (result_val),
    .rdy   (result_rdy),
    .done  (sink_done)    
  );

  wire done = src_done && sink_done;
  
  //--------------------------------------------------------------------
  // Run tests
  //--------------------------------------------------------------------

  initial
  begin
    $vcdpluson;

    src.m[0] = { 32'd27,  32'd15  }; sink.m[0] = { 32'd3  };
    src.m[1] = { 32'd21,  32'd49  }; sink.m[1] = { 32'd7  };
    src.m[2] = { 32'd25,  32'd30  }; sink.m[2] = { 32'd5  };
    src.m[3] = { 32'd19,  32'd27  }; sink.m[3] = { 32'd1  };
    src.m[4] = { 32'd40,  32'd40  }; sink.m[4] = { 32'd40 };
    src.m[5] = { 32'd250, 32'd190 }; sink.m[5] = { 32'd10 };
    src.m[6] = { 32'd5,   32'd250 }; sink.m[6] = { 32'd5  };
    src.m[7] = { 32'd0,   32'd0   }; sink.m[7] = { 32'd0  };
    
    #2000 $vcdplusoff;
  end

  `VC_TEST_CASE_BEGIN( 0, "gcdGCDUnit_rtl" )
  begin

    // Strobe reset
    #1;   reset_ext = 1'b1;
    #20;  reset_ext = 1'b0;

    // Run long enough that tests should be done
    #1500;

    // Check to make sure it is actually done
    `VC_TEST_CHECK( "Is sink finished?", done )
    
  end
  `VC_TEST_CASE_END

  `VC_TEST_SUITE_END( 1 )
endmodule
