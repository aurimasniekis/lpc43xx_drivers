OUT_DIR = ./Output/

CFLAGS += -g -Wall -I include

CC      = arm-none-eabi-gcc
AR      = arm-none-eabi-ar
CFLAGS += -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffast-math
CFLAGS += -fno-common -Os -g -ggdb3 -fverbose-asm
CFLAGS += -ffunction-sections -fdata-sections -D CORE_M4 -Wall

CSRC = $(wildcard Sources/*.c) $(wildcard Sources/ip/*.c) $(wildcard Sources/chip/*.c)
OBJS = $(CSRC:.c=.o)

CFLAGS += -IIncludes

all: lib_lpc43xx_drivers.a

clean:
	$(RM) $(OBJS) Output/lib_lpc43xx_drivers.a

lib_lpc43xx_drivers.a: $(OBJS)
	$(RM) $@
	$(AR) ru $(OUT_DIR)$@ $^

%.o: %.c
	@echo 'Compiling file: $<'
	$(CC) $(CFLAGS) -c $< -o $@