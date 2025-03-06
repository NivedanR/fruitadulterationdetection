extern unsigned char calc_checksum(unsigned char block);

// define macros to reserve checksum adjuster locations
#ifndef __RCXA__
#define RESERVE_BLOCK0_CHECKSUM unsigned int _rom _reserved1 _at(0x1ffe) = 0xffff
#define RESERVE_BLOCK1_CHECKSUM unsigned int _rom _reserved2 _at(0x3ffe) = 0xffff
#define RESERVE_BLOCK2_CHECKSUM unsigned int _rom _reserved3 _at(0x7ffe) = 0xffff
#define RESERVE_BLOCK3_CHECKSUM unsigned int _rom _reserved4 _at(0xbffe) = 0xffff
#define RESERVE_BLOCK4_CHECKSUM unsigned int _rom _reserved5 _at(0xfffe) = 0xffff
#else
#define RESERVE_BLOCK0_CHECKSUM at 0x1fff unsigned char code _reserved1 = 0xff
#define RESERVE_BLOCK1_CHECKSUM at 0x3fff unsigned char code _reserved2 = 0xff
#define RESERVE_BLOCK2_CHECKSUM at 0x7fff unsigned char code _reserved3 = 0xff
#define RESERVE_BLOCK3_CHECKSUM at 0xbfff unsigned char code _reserved4 = 0xff
#define RESERVE_BLOCK4_CHECKSUM at 0xffff unsigned char code _reserved5 = 0xff
#endif 
