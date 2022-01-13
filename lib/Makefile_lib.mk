# To compile, RELEASE, type cmd: `make RELEASE=1 ...`
DEPEND_FILE = $(OBJS_DIR)/depend_file

CC = gcc
AR = ar
RANLIB = ranlib
RM = rm
MKDIR = mkdir

ifeq ($(RELEASE), 1)
OBJS_DIR = Release
DBG_FLAGS = -O2 -DNDEBUG
else
OBJS_DIR = Debug
DBG_FLAGS = -g -O0 -DDEBUG
endif

LIB_NAME = Mylib
LIB_FULL_NAME = lib$(LIB_NAME).a

LIB_SRCS = $(notdir $(wildcard ./*.c))
LIB_OBJS = $(LIB_SRCS:%.c=$(OBJS_DIR)/%.o)
$(info LIB_SRCS:${LIB_SRCS})
$(info LIB_OBJS:${LIB_OBJS})

LIBS = -lpthread
LIBS += -l$(LIB_NAME)
LIB_DIR = -L.

TARGET_DIR = ./dummy
TARGET_SRCS = ${TARGET_DIR}/$(notdir $(wildcard ${TARGET_DIR}/*.c))
TARGET_OBJS = $(TARGET_SRCS:${TARGET_DIR}/%.c=${TARGET_DIR}/%.o)
TARGET_NAMES = $(TARGET_SRCS:${TARGET_DIR}/%.c=${TARGET_DIR}/%)
$(info TARGET_DIR:${TARGET_DIR})
$(info TARGET_SRCS:${TARGET_SRCS})
$(info TARGET_OBJS:${TARGET_OBJS})
$(info TARGET_NAMES:${TARGET_NAMES})

.SUFFIXES : .c .o

all : $(LIB_FULL_NAME) $(TARGET_NAMES)

$(LIB_FULL_NAME) : $(LIB_OBJS)
	$(AR) rcv $@ $(LIB_OBJS)
	$(RANLIB) $@

#.c.o:
$(OBJS_DIR)/%.o : %.c
	@echo "================================================"
	@echo "= Compiling $@ "
	@echo "================================================"
	@`[ -d $(OBJS_DIR) ] || $(MKDIR) $(OBJS_DIR)
	$(CC) $(CFLAGS) $(DBG_FLAGS) -c $< -o $@

.SECONDEXPANSION:
$(TARGET_NAMES): $$@.o
	$(CC) -o $@ $< $(LIB_DIR) $(LIBS)

depend :
	@`[ -d $(OBJS_DIR) ] || $(MKDIR) $(OBJS_DIR)
	@$(RM) -f $(DEPEND_FILE)
	@for FILE in $(LIB_SRCS:%.c=%) $(TARGET_SRCS:%.c=%); do \
		$(CC) -MM -MT $(OBJS_DIR)/$FILE.o $FILE.c >> $(DEPEND_FILE); \
	done

clean :
	rm -rf $(OBJS_DIR)

ifneq ($(MAKECMDGOALS), clean)
ifneq ($(MAKECMDGOALS), depend)
ifneq ($(strip $(LIB_SRCS) $(TARGET_SRCS)),)
-include $(DEPEND_FILE)
endif
endif
endif
