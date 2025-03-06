// set up an array of structures that define
// the start and end address of each flash block
code struct
{
  unsigned int start;
  unsigned int end;
} block_addresses[5] = {{0x0000, 0x1fff},
                        {0x2000, 0x3fff},
                        {0x4000, 0x7fff},
                        {0x8000, 0xbfff},
                        {0xc000, 0xffff},
                       };

// func: calc_checksum
// desc: calculates the checksum of a flash block
// passed: block = 0, 1, 2, 3 or 4 - flash block to check
// returns: 1 if block valid
// returns: 0 if block is invalid (contents changed)
unsigned char calc_checksum(unsigned char block)
{
  unsigned char checksum = 0x00;
  // initialize pointer to start of block
  unsigned char code *ptr = (unsigned char code *)block_addresses[block].start;
  // go through every location in block adding contents and truncating result to 8 bits
  while (1)
  {
    checksum += *ptr;
    if (ptr == (unsigned char code *)block_addresses[block].end) break;
    ptr++;
  }
  // calculate block checksum and compare with 55H
  // if 55H then return 1 else return 0
  if ((0xff - checksum + 1) == 0x55) return 1;
  return 0;
}
 
