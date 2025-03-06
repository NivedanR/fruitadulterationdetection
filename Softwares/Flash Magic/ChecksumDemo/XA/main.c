// include header file
#include "checksum.h"

#ifdef __RCXA__
#define _huge far
#endif

// ensure last location in block 0 is reserved for checksum adjuster
RESERVE_BLOCK0_CHECKSUM;

// set up a pointer to the LEDs
unsigned char _huge *leds = (unsigned char _huge *)0xfffa0;

void main(void)
{
  // turn the LEDs off
  *leds = 0x00;

  // if block 0 checksum is correct (i.e. the block has not been altered
  // then turn both LEDs on
  if (calc_checksum(0)) *leds = 0xff;

  // loop forever
  while(1);
}
 
