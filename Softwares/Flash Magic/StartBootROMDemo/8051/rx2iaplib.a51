; RX2IAPLIB
; In-Application-Programming Library for the Philips Rx2 Family
; This library was developed for the Raisonance and Keil Compilers for interfacing
; to C programs

; Version 1.00 (19-Jul-2000)
; by A. Ayre
; (C) Embedded Systems Academy 2000

$NOMOD51

; module name
NAME    RX2IAPLIB

; segments in this library
?DT?RX2IAPLIB                                   SEGMENT DATA
?PR?iap_read_manufacturer_id?RX2IAPLIB          SEGMENT CODE
?PR?_iap_init?RX2IAPLIB                         SEGMENT CODE
?PR?_iap_read_device_id?RX2IAPLIB               SEGMENT CODE
?PR?iap_read_security_bits?RX2IAPLIB            SEGMENT CODE
?PR?_iap_program_security_bits?RX2IAPLIB        SEGMENT CODE
?PR?_iap_program_data_byte?RX2IAPLIB            SEGMENT CODE
?PR?_iap_read_data_byte?RX2IAPLIB               SEGMENT CODE
?PR?_iap_erase_block?RX2IAPLIB                  SEGMENT CODE
?PR?iap_erase_chip?RX2IAPLIB                    SEGMENT CODE
?PR?iap_read_boot_vector?RX2IAPLIB              SEGMENT CODE
?PR?iap_read_status_byte?RX2IAPLIB              SEGMENT CODE
?PR?iap_erase_boot_vector_status_byte?RX2IAPLIB SEGMENT CODE
?PR?_iap_program_status_byte?RX2IAPLIB          SEGMENT CODE
?PR?_iap_program_boot_vector?RX2IAPLIB          SEGMENT CODE

; function names and global variables
        PUBLIC iap_freq
        PUBLIC iap_read_manufacturer_id
        PUBLIC _iap_init
        PUBLIC _iap_read_device_id
        PUBLIC iap_read_security_bits
        PUBLIC _iap_program_security_bits
        PUBLIC _iap_program_data_byte
        PUBLIC _iap_read_data_byte
        PUBLIC _iap_erase_block
        PUBLIC iap_erase_chip
        PUBLIC iap_read_boot_vector
        PUBLIC iap_read_status_byte
        PUBLIC iap_erase_boot_vector_status_byte
        PUBLIC _iap_program_status_byte
        PUBLIC _iap_program_boot_vector

; SFRs and sbits required
DPH     DATA    083H
DPL     DATA    082H
AUXR1   DATA    0A2H
EA      BIT     0AFH
CMOD    DATA    0D9H
ACC     DATA    0E0H
IE      DATA    0A8H

; global variables (data memory)
        RSEG  ?DT?RX2IAPLIB
?DT?RX2IAPLIB?BASE:
       iap_freq:   DS   1                ; device crystal frequency rounded down to nearest integer

; **********************************************************************
; function:    iap_read_manufacturer_id
; prototype:   unsigned char iap_read_manufacturer_id(void);
; description: returns manufacturer id (15H = Philips)
; **********************************************************************
        RSEG  ?PR?iap_read_manufacturer_id?RX2IAPLIB
iap_read_manufacturer_id:
        PUSH    IE                       ; disable interrupts
        CLR     EA  
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#00H
        MOV     DPTR,#0000H
        CALL    0FFF0H                   ; call iap routine
        MOV     R7,A                     ; id in accumulator
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_read_manufacturer_id

; **********************************************************************
; function:    iap_init
; prototype:   void iap_init(unsigned char frequency);
; description: sets the crystal frequency which is used by most of the
; functions in the library. passed is the crystal frequency being used
; rounded down to the nearest integer. 
; **********************************************************************
        RSEG  ?PR?_iap_init?RX2IAPLIB
_iap_init:
        MOV     iap_freq,R7
        RET     
; end of iap_read_manufacturer_id

; **********************************************************************
; function:    iap_read_device_id
; prototype:   unsigned char iap_read_device_id(unsigned char id_number);
; description: reads the device id number. id_number may be 1 or 2.
; **********************************************************************
        RSEG  ?PR?_iap_read_device_id?RX2IAPLIB
_iap_read_device_id:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#00H
        MOV     DPH,#00H
        MOV     DPL,R7                   ; id number to read
        CALL    0FFF0H                   ; call iap routine
        MOV     R7,A                     ; id in accumulator
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_read_device_id

; **********************************************************************
; function:    iap_read_security_bits
; prototype:   unsigned char iap_read_security_bits(void);
; description: reads the security bits. The bits are returned in bit
; positions 1 to 3 (bit 1 = security bit 1).
; **********************************************************************
        RSEG  ?PR?iap_read_security_bits?RX2IAPLIB
iap_read_security_bits:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#07H
        MOV     DPTR,#0000H
        CALL    0FFF0H                   ; call iap routine
        MOV     R7,A                     ; id in accumulator
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_read_security_bits

; **********************************************************************
; function:    iap_program_security_bits
; prototype:   void iap_program_security_bits(unsigned char bits);
; description: programs the security bits. The bits are stored in bit
; positions 1 to 3 (bit 1 = security bit 1).
; **********************************************************************
        RSEG  ?PR?_iap_program_security_bits?RX2IAPLIB
_iap_program_security_bits:
; prologue
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R6,#00H                  ; bit counter
        MOV     A,R7                     ; copy param into acc
        MOV     DPH,#00H
; end of prologue
?IAPTAG7:
        JNB     ACC.1,?IAPTAG8           ; test if lsb of acc is set
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#05H
        MOV     DPL,R6                   ; set DPTR to bit to program (0-index)
        CALL    0FFF0H
?IAPTAG8:
        CLR     C                        ; shift acc right one bit
        RRC     A
        INC     R6                       ; increment bit counter
        CJNE    R6,#003H,?IAPTAG9        ; have we gone through 3 bits?
?IAPTAG9:
        JC      ?IAPTAG7                 ; jump back to program next bit
; epologue
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of epilogue
; end of iap_program_security_bits

; **********************************************************************
; function:    iap_program_data_byte
; prototype:   unsigned char iap_program_data_byte(unsigned char val, unsigned int addr);
; description: programs a byte in the flash. passed is the byte and the
; 16-bit address. zero is returned for success, non zero is returned for
; failiure.
; **********************************************************************
        RSEG  ?PR?_iap_program_data_byte?RX2IAPLIB
_iap_program_data_byte:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#02H
        MOV     DPH,R4                   ; address to program
        MOV     DPL,R5
        MOV     A,R7                     ; data to write
        CALL    0FFF0H                   ; call iap routine
        MOV     R7,A                     ; id in accumulator
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_program_data_byte

; **********************************************************************
; function:    iap_read_data_byte
; prototype:   unsigned char iap_read_data_byte(unsigned int addr);
; description: reads a byte from the flash. passed is the 16-bit
; address.
; **********************************************************************
        RSEG  ?PR?_iap_read_data_byte?RX2IAPLIB
_iap_read_data_byte:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#03H
        MOV     DPH,R6                   ; address to program
        MOV     DPL,R7
        CALL    0FFF0H                   ; call iap routine
        MOV     R7,A                     ; id in accumulator
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_read_data_byte

; **********************************************************************
; function:    iap_erase_block
; prototype:   void iap_erase_block(unsigned char block);
; description: erases a block of flash. passed is a number indicating
; the block to erase
; **********************************************************************
        RSEG  ?PR?_iap_erase_block?RX2IAPLIB
_iap_erase_block:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#01H
        MOV     DPH,R7                   ; address to program
        MOV     DPL,#00H
        CALL    0FFF0H                   ; call iap routine
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_erase_block

; **********************************************************************
; function:    iap_erase_chip
; prototype:   void iap_erase_chip(void);
; description: erases the entire flash memory and returns to the
; bootloader
; **********************************************************************
        RSEG  ?PR?iap_erase_chip?RX2IAPLIB
iap_erase_chip:
        CLR     EA                       ; disable interrupts
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#08H
        CALL    0FFF0H                   ; call iap routine
        RET                              ; included for completeness - never reached
; end of iap_erase_chip

; **********************************************************************
; function:    iap_read_boot_vector
; prototype:   unsigned char iap_read_boot_vector(void);
; description: returns the byte stored in the boot vector
; **********************************************************************
        RSEG  ?PR?iap_read_boot_vector?RX2IAPLIB
iap_read_boot_vector:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#07H
        MOV     DPTR,#0002H
        CALL    0FFF0H                   ; call iap routine
        MOV     R7,A                     ; result returned in R7
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_read_boot_vector

; **********************************************************************
; function:    iap_read_status_byte
; prototype:   unsigned char iap_read_status_byte(void);
; description: returns the value of the status byte
; **********************************************************************
        RSEG  ?PR?iap_read_status_byte?RX2IAPLIB
iap_read_status_byte:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#07H
        MOV     DPTR,#0001H
        CALL    0FFF0H                   ; call iap routine
        MOV     R7,A                     ; result returned in R7
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_read_status_byte

; **********************************************************************
; function:    iap_erase_boot_vector_status_byte
; prototype:   void iap_erase_boot_vector_status_byte(void);
; description: erases the boot vector and status byte
; **********************************************************************
        RSEG  ?PR?iap_erase_boot_vector_status_byte?RX2IAPLIB
iap_erase_boot_vector_status_byte:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#04H
        MOV     DPH,#00H
        CALL    0FFF0H                   ; call iap routine
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_erase_boot_vector_status_byte

; **********************************************************************
; function:    iap_program_status_byte
; prototype:   void iap_program_status_byte(unsigned char status_byte);
; description: programs the status byte
; **********************************************************************
        RSEG  ?PR?_iap_program_status_byte?RX2IAPLIB
_iap_program_status_byte:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#06H
        MOV     A,R7                     ; new value to program
        MOV     DPTR,#0000H
        CALL    0FFF0H                   ; call iap routine
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_program_status_byte

; **********************************************************************
; function:    iap_program_boot_vector
; prototype:   void iap_program_boot_vector(unsigned char boot_vector);
; description: programs the boot vector
; **********************************************************************
        RSEG  ?PR?_iap_program_boot_vector?RX2IAPLIB
_iap_program_boot_vector:
        PUSH    IE                       ; disable interrupts
        CLR     EA
        PUSH    CMOD
        ANL     CMOD,#0DFH               ; disable watchdog
        ORL     AUXR1,#020H              ; enable bootrom
        MOV     R0,iap_freq              ; osc frequency
        MOV     R1,#06H
        MOV     A,R7                     ; new value to program
        MOV     DPTR,#0001H
        CALL    0FFF0H                   ; call iap routine
        ANL     AUXR1,#0DFH              ; disable bootrom
        POP     CMOD                     ; restore CMOD (restore watchdog state)
        POP     IE                       ; restore interrupts to initial state
        RET     
; end of iap_program_boot_vector

         END

