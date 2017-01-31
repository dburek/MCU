#--------------------------------------------------------------------
#
# On command line:
#
# make all = Make software.
#
# make clean = Clean out built project files.
#
# make program = Download the hex file to the device, using avrdude.
#
#--------------------------------------------------------------------

# Cross compiler details
CROSS_COMPILER = avr-
AS = $(CROSS_COMPILER)as
LD = $(CROSS_COMPILER)ld
CC = $(CROSS_COMPILER)gcc
OBJDUMP = $(CROSS_COMPILER)objdump
OBJCOPY = $(CROSS_COMPILER)objcopy

# MCU name 
MCU = atmega32

# Object files directory
OBJDIR = obj

# Target file name
TARGET = template

# Include files directory
INCDIR = include

# Source files directory
SRCDIR = src

# List Assembler source files
SRC = $(wildcard $(patsubst %, %/*.s, $(SRCDIR)))

# All relocatable object files
OBJ = $(addprefix $(OBJDIR)/, $(notdir $(patsubst %.s, %.o, $(SRC))))

# List of dependency files
DEPS = $(patsubst %.o, %.d, $(OBJ))

# Executable object files
ELF = $(OBJDIR)/$(TARGET).elf
HEX = $(OBJDIR)/$(TARGET).hex
BIN = $(OBJDIR)/$(TARGET).bin

#---------------- Assembler flags ---------------------
#	
# -mmcu		device model	
# -adhlns:	create listing
# -I		include directory paths
# -MD		create dependency files 
# 
ASFLAGS = -mmcu $(MCU) -I $(INCDIR) -adhlns=$(<F:%.s=$(OBJDIR)/%.lst) -MD $(@:.o=.d)

#---------------- Linker flags ---------------------
#
# -Map		create map file		
#
LDFLAGS = -Map=$(OBJDIR)/$(TARGET).map

# Programming settings (avrdude)
PROGRAMMER = stk500v2
PORT = /dev/ttyUSB0
FLASH = -U flash:w:$(HEX)

# Make searching path
VPATH = $(SRCDIR) $(INCDIR)

# Default target
all: begin build end

# Build target
build: elf hex bin

elf: $(ELF)
hex: $(HEX)
bin: $(BIN)

$(ELF):	$(OBJ) 
	$(LD) $^ $(LDFLAGS) -o $@

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex $< $@	

$(BIN):	$(ELF)
	$(OBJCOPY) -O binary $< $@	

$(OBJDIR)/%.o: %.s
	$(AS) $< $(ASFLAGS) -o $@

# Clean project
clean:
	rm -rf $(OBJDIR)/*

# Program the device
program:
	avrdude -p $(MCU) -c $(PROGRAMMER) -P $(PORT) $(FLASH)

# Disassembly
diasm:	$(ELF)
	$(OBJDUMP) $(ELF) -D

# Phony targets
.PHONY: begin clean build program diasm end

# Include dependancy files
-include $(DEPS)
