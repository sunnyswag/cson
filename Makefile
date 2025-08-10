#  Define the command of tool
CC := gcc
AR := ar
MD := mkdir -p
RM := rm -rf

# Define the JSON parsing library used (cjson or jansson supported)
JSON_LIB := cjson
#JSON_LIB := jansson

#		output files
OUT_DIR := ./output
TARGET := $(OUT_DIR)/libcson.a

#		source files
SRC_DIR := ./src
SRC_FILES += $(wildcard $(SRC_DIR)/*.c)

ADP_SRC_DIR := ./adapter/$(JSON_LIB)
ADP_SRC_FILES += $(wildcard $(ADP_SRC_DIR)/*.c)

#		*.o
OBJS += $(patsubst $(SRC_DIR)/%.c, $(OUT_DIR)/%.o, $(SRC_FILES))
OBJS += $(patsubst $(ADP_SRC_DIR)/%.c, $(OUT_DIR)/%.o, $(ADP_SRC_FILES))

#		include path
INC_PATH += -I./inc/
INC_PATH += -I./3rd/inc/

all: $(TARGET) demo

$(TARGET):$(OBJS)
	@$(MD) $(OUT_DIR)
	@$(AR) rc $(TARGET) $(OBJS)

$(OUT_DIR)/%.o:$(SRC_DIR)/%.c
	@$(MD) $(OUT_DIR)
	@$(CC) $(INC_PATH) $(CFLAGS) -c $< -o $@

$(OUT_DIR)/%.o:$(ADP_SRC_DIR)/%.c
	@$(MD) $(OUT_DIR)
	@$(CC) $(INC_PATH) $(CFLAGS) -c $< -o $@

.PHONY: all clean debug demo demo-clean demo-debug

demo:
	@$(MAKE) -C demo

clean: 
	@$(RM) $(OUT_DIR)
	@$(MAKE) -C demo clean

debug: CFLAGS += -g
debug: clean $(TARGET) demo-debug

demo-debug:
	@$(MAKE) -C demo debug
