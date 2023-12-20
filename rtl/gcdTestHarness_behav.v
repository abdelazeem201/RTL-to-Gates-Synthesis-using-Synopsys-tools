//=========================================================================
// Test Harness for Behavioral Model of GCD
//-------------------------------------------------------------------------
//

module exGCDTestHarness_behav;

  //--------------------------------------------------------------------
  // Instantiate DUT
  //--------------------------------------------------------------------
  
  reg  [15:0] inA, inB;
  wire [15:0] out;

  exGCD_behav#(16) gcd_unit
  ( 
    .inA (inA), 
    .inB (inB), 
    .out (out) 
  );

  //--------------------------------------------------------------------
  // Run tests
  //--------------------------------------------------------------------
  
  initial
  begin    

    $display(" Entering Test Suite: exGCD_behav");
    
    // 3 = GCD( 27, 15 )
    
    inA = 27;
    inB = 15;
    #10;
    if ( out == 3 )
      $display( "  [ passed ] Test ( gcd(27,15) ) succeeded, [ %x == %x ]", out, 3 );
    else
      $display( "  [ FAILED ] Test ( gcd(27,15) ) failed, [ %x != %x ]", out, 3 );

    // 7 = GCD( 21, 49 )
    
    inA = 21;
    inB = 49;
    #10;
    if ( out == 7 )
      $display( "  [ passed ] Test ( gcd(21,49) ) succeeded, [ %x == %x ]", out, 7 );
    else
      $display( "  [ FAILED ] Test ( gcd(21,49) ) failed, [ %x != %x ]", out, 7 );

    // 5 = GCD( 25, 30 )
    
    inA = 25;
    inB = 30;
    #10;
    if ( out == 5 )
      $display( "  [ passed ] Test ( gcd(25,30) ) succeeded, [ %x == %x ]", out, 5 );
    else
      $display( "  [ FAILED ] Test ( gcd(25,30) ) failed, [ %x != %x ]", out, 5 );

    // 1 = GCD( 19, 27 )
    
    inA = 19;
    inB = 27;
    #10;
    if ( out == 1 )
      $display( "  [ passed ] Test ( gcd(19,27) ) succeeded, [ %x == %x ]", out, 1 );
    else
      $display( "  [ FAILED ] Test ( gcd(19,27) ) failed, [ %x != %x ]", out, 1 );    

    // 40 = GCD( 40, 40 )
    
    inA = 40;
    inB = 40;
    #10;
    if ( out == 40 )
      $display( "  [ passed ] Test ( gcd(40,40) ) succeeded, [ %x == %x ]", out, 40 );
    else
      $display( "  [ FAILED ] Test ( gcd(40,40) ) failed, [ %x != %x ]", out, 40 );    
 
    // 10 = GCD( 250, 190 )
    
    inA = 250;
    inB = 190;
    #10;
    if ( out == 10 )
      $display( "  [ passed ] Test ( gcd(250,190) ) succeeded, [ %x == %x ]", out, 10 );
    else
      $display( "  [ FAILED ] Test ( gcd(250,190) ) failed, [ %x != %x ]", out, 10 );

    // 0 = GCD( 0, 0 )
    
    inA = 0;
    inB = 0;
    #10;
    if ( out == 0 )
      $display( "  [ passed ] Test ( gcd(0,0) ) succeeded, [ %x == %x ]", out, 0 );
    else
      $display( "  [ FAILED ] Test ( gcd(0,0) ) failed, [ %x != %x ]", out, 0 );

    $display("");
    $finish;
    
  end    

endmodule
