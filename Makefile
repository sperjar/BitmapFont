CC  = 	g++
CFLAGS = -O2 -g -Wall -c

SOURCES = bitmapfont.cpp block.cpp
OBJECTS = $(SOURCES:.cpp=.o)
TARGET = bitmapfont 
FONTS = ASC12 ASC16 ASC48 HZK12 HZK14 HZK16 HZK16F HZK16S HZK24F HZK24H HZK24K HZK24S HZK32 HZK40 HZK48

:$(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@
	mkdir -p output/

%.o: %.cpp
	$(CC) $(CFLAGS) $< -o $@

SOURCES_HACK = hackfont.cpp block.cpp
OBJECTS_HACK = $(SOURCES_HACK:.cpp=.o)
TARGET_HACK = hackfont

$(TARGET_HACK): $(OBJECTS_HACK)
	$(CC) $(OBJECTS_HACK) -o $@

SOURCES_SEARCH = searchfont.cpp block.cpp
OBJECTS_SEARCH = $(SOURCES_SEARCH:.cpp=.o)
TARGET_SEARCH = searchfont

$(TARGET_SEARCH): $(OBJECTS_SEARCH)
	$(CC) $(OBJECTS_SEARCH) -o $@

allfonts:$(FONTS)

hacksample: $(TARGET_HACK) $(TARGET)
	mkdir -p font_hack/
	./$< font/HZK16 font_hack/HZK16_0 0x49 0x01 0x01
	mkdir -p output/	
	./bitmapfont font_hack/HZK16_0 2 > output/HZK16_0.txt

all: $(TARGET_HACK) $(TARGET) $(TARGET_SEARCH)

clean:
	rm -rfv $(OBJECTS) $(TARGET)
	rm -rfv $(OBJECTS_HACK) $(TARGET_HACK)	
	rm -rfv $(OBJECTS_SEARCH) $(TARGET_SEARCH)
	rm -rfv output/
	rm -rfv font_hack/
	
ASC12: FONT_NAME = ASC12
ASC12: BYTE_IN_ROW = 1
ASC12: ASC12.txt

ASC16: FONT_NAME = ASC16
ASC16: BYTE_IN_ROW = 1
ASC16: ASC16.txt

ASC48: FONT_NAME = ASC48
ASC48: BYTE_IN_ROW = 3
ASC48: ASC48.txt

HZK12: FONT_NAME = HZK12
HZK12: BYTE_IN_ROW = 2
HZK12: HZK12.txt
	
HZK14: FONT_NAME = HZK14
HZK14: BYTE_IN_ROW = 2
HZK14: HZK14.txt

HZK16: FONT_NAME = HZK16
HZK16: BYTE_IN_ROW = 2
HZK16: HZK16.txt

HZK16F: FONT_NAME = HZK16F
HZK16F: BYTE_IN_ROW = 2
HZK16F: HZK16F.txt

HZK16S: FONT_NAME = HZK16S
HZK16S: BYTE_IN_ROW = 2
HZK16S: HZK16S.txt

HZK24F: FONT_NAME = HZK24F
HZK24F: BYTE_IN_ROW = 3
HZK24F: HZK24F.txt

HZK24H: FONT_NAME = HZK24H
HZK24H: BYTE_IN_ROW = 3
HZK24H: HZK24H.txt

HZK24K: FONT_NAME = HZK24K
HZK24K: BYTE_IN_ROW = 3
HZK24K: HZK24K.txt

HZK24S: FONT_NAME = HZK24S
HZK24S: BYTE_IN_ROW = 3
HZK24S: HZK24S.txt

HZK32: FONT_NAME = HZK32
HZK32: BYTE_IN_ROW = 4
HZK32: HZK32.txt

HZK40: FONT_NAME = HZK40T
HZK40: BYTE_IN_ROW = 5
HZK40: HZK40T.txt

HZK48: FONT_NAME = HZK48
HZK48: BYTE_IN_ROW = 6
HZK48: HZK48.txt

%.txt: $(TARGET)
	./$(TARGET) font/$(FONT_NAME) $(BYTE_IN_ROW) > output/$@

