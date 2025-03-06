// RX2IAPLIB Header File

#define SECURITY_BIT_1 0x02
#define SECURITY_BIT_2 0x04
#define SECURITY_BIT_3 0x08
#define SECURITY_BIT_1_SET(v) (v & SECURITY_BIT_1)
#define SECURITY_BIT_2_SET(v) (v & SECURITY_BIT_2)
#define SECURITY_BIT_3_SET(v) (v & SECURITY_BIT_3)

#define BLOCK_0 0x00
#define BLOCK_1 0x20
#define BLOCK_2 0x40
#define BLOCK_3 0x80
#define BLOCK_4 0xc0
#define BLOCK_0x0000_0x1FFF BLOCK_0
#define BLOCK_0x2000_0x3FFF BLOCK_1
#define BLOCK_0x4000_0x7FFF BLOCK_2
#define BLOCK_0x8000_0xBFFF BLOCK_3
#define BLOCK_0xC000_0xFFFF BLOCK_4

extern unsigned char iap_read_manufacturer_id(void);
extern void iap_init(unsigned char frequency);
extern unsigned char iap_read_device_id(unsigned char id_number);
extern unsigned char iap_read_security_bits(void);
extern void iap_program_security_bits(unsigned char bits);
extern unsigned char iap_program_data_byte(unsigned char val, unsigned int addr);
extern unsigned char iap_read_data_byte(unsigned int addr);
extern void iap_erase_block(unsigned char block);
extern void iap_erase_chip(void);
extern unsigned char iap_read_boot_vector(void);
extern unsigned char iap_read_status_byte(void);
extern void iap_erase_boot_vector_status_byte(void);
extern void iap_program_status_byte(unsigned char status_byte);
extern void iap_program_boot_vector(unsigned char boot_vector);
 
