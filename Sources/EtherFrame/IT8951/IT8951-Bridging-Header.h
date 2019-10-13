//
//  IT8951-Bridging-Header.h
//  EtherFrame
//
//  Created by Michael Critz on 10/12/19.
//

#ifndef IT8951_Bridging_Header_h
#define IT8951_Bridging_Header_h

uint8_t IT8951_Init(void);
void IT8951_Cancel(void);
void IT8951DisplayExample(void);
void IT8951DisplayExample2(void);
void IT8951Display1bppExample2(void);
void IT8951DisplayExample3(void);
void IT8951_GUI_Example(void);
void IT8951_BMP_Example(uint32_t x, uint32_t y,char *path);

#endif /* IT8951_Bridging_Header_h */
