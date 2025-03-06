extern unsigned char calc_checksum(unsigned char block);

// define macros to reserve checksum adjuster locations
#define RESERVE_BLOCK0_CHECKSUM unsigned char code _reserved1 _at_ 0x1fff
#define RESERVE_BLOCK1_CHECKSUM unsigned char code _reserved2 _at_ 0x3fff
#define RESERVE_BLOCK2_CHECKSUM unsigned char code _reserved3 _at_ 0x7fff
#define RESERVE_BLOCK3_CHECKSUM unsigned char code _reserved4 _at_ 0xbfff
#define RESERVE_BLOCK4_CHECKSUM unsigned char code _reserved5 _at_ 0xffff
 
