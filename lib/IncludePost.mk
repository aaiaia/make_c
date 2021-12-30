# IncludePost.mk
 
ifeq ($(IS_SHARED),1)
SHARED_FLAGS = -fPIC
SHARED_SO_NAME = lib$(LIB_NAME).so.$(MAJOR_VERSION)
SHARED_REAL_NAME = $(SHARED_SO_NAME).$(MINOR_VERSION)
LIB_FULL_NAME = $(ROOT_LIB_DIR)/$(SHARED_REAL_NAME)
else
LIB_FULL_NAME = $(ROOT_LIB_DIR)/lib$(LIB_NAME).a
endif
$(info LIB_FULL_NAME = ${LIB_FULL_NAME})
 
#LIB_OBJS = $(LIB_SRCS:%.c=$(OBJS_DIR)/%.o)
#TEMP = $(subst $(ROOT_SRC_DIR), $(ROOT_OUT_DIR), $(LIB_SRCS))
#LIB_OBJS = $(TEMP:%.c=%.o)
LIB_ITEMS = $(patsubst %.c,%,$(subst $(ROOT_SRC_DIR)/, , $(LIB_SRCS)))
$(info LIB_ITEMS = $(LIB_ITEMS))
LIB_OBJS = $(patsubst %.c,%.o,$(subst $(ROOT_SRC_DIR), $(OBJS_DIR), $(LIB_SRCS)))
$(info LIB_OBJS = ${LIB_OBJS})
 
ALL_LIBS = -l$(LIB_NAME) $(DEPEND_LIBS) $(LIBS)
$(info ALL_LIBS = ${ALL_LIBS})

TARGET_ITEMS = $(patsubst %.c,%,$(subst $(ROOT_TRG_DIR)/, , $(TARGET_SRCS)))
$(info TARGET_ITEMS = $(TARGET_ITEMS))
TARGET_OBJS = $(patsubst %.c,%.o,$(subst $(ROOT_TRG_DIR), $(OBJS_DIR), $(TARGET_SRCS)))
$(info TARGET_OBJS = ${TARGET_OBJS})
TARGET_NAMES = $(TARGET_ITEMS:%=$(ROOT_OUT_DIR)/%)
$(info TARGET_NAMES = ${TARGET_NAMES})
 
.SUFFIXES : .c .o
 
all : lib subdirs targets
 
subdirs : 
	@echo "==================================================="
	@echo "subdirs"
	@echo "==================================================="
	@for dir in $(SUB_DIRS); do \
		$(MAKE) -C $$dir all; \
		if [ $$? != 0 ]; then exit 1; fi; \
	done
 
lib : $(LIB_FULL_NAME)
 
liball : $(LIB_FULL_NAME) 
	@echo "==================================================="
	@echo "liball"
	@echo "==================================================="
	@for dir in $(SUB_DIRS); do \
		$(MAKE) -C $$dir liball; \
		if [ $$? != 0 ]; then exit 1; fi; \
	done
 
targets : $(TARGET_NAMES)
 
$(LIB_FULL_NAME) : $(LIB_OBJS)
	@echo "==================================================="
	@echo "LIB_FULL_NAME"
	@echo "==================================================="
	@`[ -d $(ROOT_LIB_DIR)/$(OBJS_DIR) ] || $(MKDIR) -p $(ROOT_LIB_DIR)/$(OBJS_DIR)`
ifeq ($(IS_SHARED),1)
	$(CC) -shared -Wl,-soname,$(SHARED_SO_NAME) -o $@ $(LIB_OBJS)
	$(LN) -fs $(SHARED_REAL_NAME) $(SHARED_SO_NAME)
	$(LN) -fs $(SHARED_SO_NAME) lib$(LIB_NAME).so
	$(MV) $(SHARED_SO_NAME) lib$(LIB_NAME).so $(ROOT_LIB_DIR)/$(OBJS_DIR)/
else
	$(AR) rcv $@ $(LIB_OBJS)
	$(RANLIB) $@
endif
 
$(OBJS_DIR)/%.o : %.c
	@echo "==================================================="
	@echo "= Compiling $@"
	@echo "==================================================="
	@`[ -d $(OBJS_DIR) ] || $(MKDIR) -p $(OBJS_DIR)`
	$(if $(findstring $<, $(TARGET_SRCS)), \
		$(CC) $(CFLAGS) $(DBG_FLAGS) $(INC_DIRS) -c $< -o $@, \
		$(CC) $(CFLAGS) $(DBG_FLAGS) $(SHARED_FLAGS) $(INC_DIRS) -c $< -o $@)
 
.SECONDEXPANSION:
$(TARGET_NAMES): $$@.o
	@echo "==================================================="
	@echo "= Linking $@"
	@echo "==================================================="
ifeq ($(LIBS_CYCLING_DEPEND),1)
	$(CC) -o $@ $< $(LIB_DIRS) -Wl,-\( $(ALL_LIBS) -Wl,-\)
else
	$(CC) -o $@ $< $(LIB_DIRS) $(ALL_LIBS)
endif
 
depend :
	@`[ -d $(OBJS_DIR) ] || $(MKDIR) -p $(OBJS_DIR)`
	@$(RM) -f $(DEPEND_FILE)
	@echo "Abstract Library Source Dependency"
	@for ITEM in $(LIB_ITEMS); do \
        echo "item: $$ITEM, src: $(ROOT_SRC_DIR)/$$ITEM.c, obj: $(OBJS_DIR)/$$ITEM.o"; \
		$(CC) -MM -MT $(OBJS_DIR)/$$ITEM.o $(ROOT_SRC_DIR)/$$ITEM.c $(CFLAGS) $(DBG_FLAGS) $(SHARED_FLAGS) $(INC_DIRS) >> $(DEPEND_FILE); \
	done
	@echo "Abstract Target Source Dependency"
	@for ITEM in $(TARGET_ITEMS); do \
        echo "item: $$ITEM, src: $(PROJ_ROOT)/$$ITEM.c, obj: $(OBJS_DIR)/$$ITEM.o"; \
		$(CC) -MM -MT $(OBJS_DIR)/$$ITEM.o $(ROOT_TRG_DIR)/$$ITEM.c $(CFLAGS) $(DBG_FLAGS) $(INC_DIRS) >> $(DEPEND_FILE); \
	done
	@echo "DEPEND_FILE: $(DEPEND_FILE)"
 
dependall : depend
	@for dir in $(SUB_DIRS); do \
		$(MAKE) -C $$dir dependall; \
		if [ $$? != 0 ]; then exit 1; fi; \
	done
 
clean :
	$(RM) -fr $(OBJS_DIR) $(LIB_FULL_NAME)
ifeq ($(IS_SHARED),1)
	$(RM) -f $(ROOT_LIB_DIR)/$(OBJS_DIR)/lib$(LIB_NAME).so*
endif
 
cleanall : clean
	@for dir in $(SUB_DIRS); do \
		$(MAKE) -C $$dir cleanall; \
		if [ $$? != 0 ]; then exit 1; fi; \
	done
 
$(TARGET_NAMES) : $(LIB_FULL_NAME) \
	$(patsubst -l%, $(wildcard %.*), $(DEPEND_LIBS))
 
ifneq ($(MAKECMDGOALS), clean)
ifneq ($(MAKECMDGOALS), cleanall)
ifneq ($(MAKECMDGOALS), depend)
ifneq ($(MAKECMDGOALS), dependall)
ifneq ($(strip $(LIB_SRCS) $(TARGET_SRCS)),)
-include $(DEPEND_FILE)
endif
endif
endif
endif
endif
