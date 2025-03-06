#include "rx2iaplib.h"
#include "reg51rx2.h"

// declare a pointer to the LEDs on the Phytec PhyCORE development board
unsigned char xdata *leds = (unsigned char xdata *)0xffa0;
// the command which will place the device into BootROM mode
const char code bootrom_init_cmd[] = "boot";
// pointer used to keep track of how much of the command has been received
const char code *pcmd = bootrom_init_cmd;

// function uart_init
// initializes the UART to 8-N-1, 9600 baud @ 20MHz
// using Timer 2 as baud rate generator
void uart_init(void)
{
  RCLK = 1;                                        // use timer 2 for transmit and receive
  TCLK = 1;
  RCAP2H = 255;                                    // 9600 baud @ 20MHz, 6 clock mode
  RCAP2L = 126;
  SCON = 0x52;                                     // mode 1, 8-bit, reception enable
  TR2 = 1;                                         // timer 2 run
}

// UART interrupt
void uart_isr(void) interrupt 4 using 1
{
  // if byte received...
  if (RI)
  {
    RI = 0;
   	
	// if next character in command...
    if (SBUF == *pcmd)
	{
      // echo character
      while (!TI);
  	  TI = 0;
	  SBUF = *pcmd;

	  // move to next character in command
	  pcmd++;
	  // if null terminator reached then whole command received
	  if (!*pcmd)
 	  {
	    // echo '.' to indicate success
	    while (!TI);
		TI = 0;
		SBUF = '.';
		// disable interrupts
	    EA = 0;
		// reprogram status byte to FFH - results in BootROM always executing
		// after reset
	    iap_erase_boot_vector_status_byte();
        iap_program_boot_vector(0xFC);
	    iap_program_status_byte(0xFF);
        // start watchdog timer and wait for reset to occurr
        WDTRST = 0x1E;
	    WDTRST = 0xE1;
		while(1);
	  }
	}
	else
	{
      // character received wasn't next character in command
	  // so start over again
      pcmd = bootrom_init_cmd;
	  // application processing of serial input goes here
	}
  }
}

void main(void)
{
  unsigned int i;

  // initialize uart
  uart_init();

  // initialize IAP library, 20MHz oscillator frequency
  iap_init(20);

  // enable serial interrupt and enable interrupts
  ES = 1;
  EA = 1;

  // turn LEDs off
  *leds = 0x00;

  while(1)
  {
    // toggle LEDs to show application is executing
    *leds = ~*leds;
	for (i = 0; i < 10000; i++);
  }
}

