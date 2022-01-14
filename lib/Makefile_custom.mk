# default C language make environment
CC = gcc
CFLAGS =		# gcc compile flags, when use compile and linking
# default C++ language make environment
CXX = g++
CXXFLAGS =		# g++ compile flags
CPPFLAGS =		# c++ compile flags
# default shared library environments
LDFLAGS =		# shared library flags(common used)
# default other make environment
AR = ar         # Static Library Archiving tools. The GNU ar program creates, modifies, and extracts from archives.
# define Shell command to make variable
RANLIB = ranlib # ranlib generates an index to the contents of an archive and stores it in the archive.
RM = rm
MV = mv
MKDIR = mkdir
MAKE = make
LN = ln
###########################
###### Configuration ######
###########################

###### Library Conf. ######
MAJOR_VERSION = 1# 1
MINOR_VERSION = 0# 0

#### Depend file prefix ###
DEPEND_FILE_PREFIX = depend_file

###########################
##### Release Version #####
###########################
OBJS_DIR_NAME = debug
###########################
### Library Srcs & Objs ###
###########################
LIB_SRC_DIR_NAME = src

LIB_SRCS := $(subst ./,,$(shell find -L ./$(LIB_SRC_DIR_NAME) -type f \( -iname "*.c" -o -iname "*.s" \) ))
$(info LIB_SRCS = ${LIB_SRCS})
#LIB_ITEMS = $(patsubst %.c,%,$(subst $(LIB_SRC_DIR_NAME)/,,$(LIB_SRCS)))
LIB_ITEMS = $(patsubst %.c,%,$(LIB_SRCS))
$(info LIB_ITEMS = ${LIB_ITEMS})
#LIB_OBJS := $(patsubst %.c,%.o,$(subst $(LIB_SRC_DIR_NAME),$(OBJS_DIR_NAME),$(LIB_SRCS)))
LIB_OBJS := $(LIB_SRCS:%.c=$(OBJS_DIR_NAME)/%.o)
$(info LIB_OBJS = ${LIB_OBJS})

LIB_INC_DIRS = -Iinclude
$(info LIB_INC_DIRS = ${LIB_INC_DIRS})

DEPEND_FILE_POSTFIX_LIB = lib
DEPEND_FILE_LIB = $(OBJS_DIR_NAME)/$(DEPEND_FILE_PREFIX).$(DEPEND_FILE_POSTFIX_LIB)
###########################
##### Library Config ######
###########################
LIB_NAME = basic
$(info LIB_NAME = ${LIB_NAME})
LIB_DIR_NAME = lib

COMMON_LIB_NAME = lib$(LIB_NAME)
# Set variable to static library
STATIC_LIB_KEYWD = static
STATIC_LIB_SUFFIX = .a
STATIC_LIB_NAME = $(COMMON_LIB_NAME)$(STATIC_LIB_SUFFIX)
$(info STATIC_LIB_NAME = ${STATIC_LIB_NAME})

STATIC_LIB_DEPEND_FILE = $(DEPEND_FILE_LIB).$(STATIC_LIB_KEYWD)

# Set variable to shared library
SHARED_LIB_KEYWD = shared
SHARED_FLAGS = -fPIC
$(info SHARED_FLAGS = ${SHARED_FLAGS})
SHARED_LIB_SUFFIX = .so
SHARED_LIB_NAME = $(COMMON_LIB_NAME)$(SHARED_LIB_SUFFIX)
$(info SHARED_LIB_NAME = ${SHARED_LIB_NAME})
SHARED_LIB_NAME_VER_SUFFIX = .$(MAJOR_VERSION).$(MINOR_VERSION)
SHARED_LIB_NAME_VER = $(SHARED_LIB_NAME)$(SHARED_LIB_NAME_VER_SUFFIX)

SHARED_LIB_DEPEND_FILE = $(DEPEND_FILE_LIB).$(SHARED_LIB_KEYWD)
###########################
##### App Srcs & Objs #####
###########################
APP_SRC_DIR_NAME = app

APP_SRCS := $(subst ./,,$(shell find -L ./$(APP_SRC_DIR_NAME) -type f \( -iname "*.c" -o -iname "*.s" \) ))
$(info APP_SRCS = ${APP_SRCS})
#APP_ITEMS = $(patsubst %.c,%,$(subst $(APP_SRC_DIR_NAME)/,,$(APP_SRCS)))
APP_ITEMS = $(patsubst %.c,%,$(APP_SRCS))
$(info APP_ITEMS = ${APP_ITEMS})
#APP_OBJS := $(patsubst %.c,%.o,$(subst $(APP_SRC_DIR_NAME),$(OBJS_DIR_NAME),$(APP_SRCS)))
APP_OBJS := $(APP_SRCS:%.c=$(OBJS_DIR_NAME)/%.o)
$(info APP_OBJS = ${APP_OBJS})

APP_INC_DIRS = -I$(APP_SRC_DIR_NAME) $(LIB_INC_DIRS)
$(info APP_INC_DIRS = ${APP_INC_DIRS})

DEPEND_FILE_POSTFIX_APP = app
DEPEND_FILE_APP = $(OBJS_DIR_NAME)/$(DEPEND_FILE_PREFIX).$(DEPEND_FILE_POSTFIX_APP)
###########################
### Application Config ####
###########################
# blank = compile using object
# static = compile use static library
# shared = compile use shared library
APP_USE_LIB_MODE =
###########################
#### Outputs & Target #####
###########################
OUT_DIR_NAME = out
##### Config for Lib #####
OUT_LIB_DIR = $(OUT_DIR_NAME)/$(OBJS_DIR_NAME)/$(LIB_DIR_NAME)
$(info OUT_LIB_DIR = $(OUT_LIB_DIR))
OUT_LIB_PATH_STATIC = $(OUT_LIB_DIR)/$(STATIC_LIB_NAME)
$(info OUT_LIB_PATH_STATIC = $(OUT_LIB_PATH_STATIC))
OUT_LIB_PATH_SHARED = $(OUT_LIB_DIR)/$(SHARED_LIB_NAME)
$(info OUT_LIB_PATH_SHARED = $(OUT_LIB_PATH_SHARED))
OUT_LIB_PATH_COMMON = $(OUT_LIB_DIR)/$(COMMON_LIB_NAME)
##### Config for App #####
OUT_ITEMS_APP = $(APP_OBJS:%.o=%)
$(info OUT_ITEMS_APP = $(OUT_ITEMS_APP))
OUT_APP = $(OUT_ITEMS_APP:%=$(OUT_DIR_NAME)/%)
$(info OUT_APP = ${OUT_APP})
###########################
#### Include to Library####
###########################
INC_LIB_PATH = -L$(OUT_LIB_DIR)
$(info INC_LIB_PATH = $(INC_LIB_PATH))

INC_LIB_NAMES = -l$(patsubst lib%.a,%,$(LIB_NAME))
$(info INC_LIB_NAMES = $(INC_LIB_NAMES))
###########################
###########################
###########################

#.SUFFIXES : .c .o

###########################
###########################
###########################
test.test :
ifeq ($(APP_USE_LIB_MODE),)
	@echo "APP_USE_LIB_MODE: blank"
else ifeq ($(APP_USE_LIB_MODE),static)
	@echo "APP_USE_LIB_MODE: $(APP_USE_LIB_MODE)"
else ifeq ($(APP_USE_LIB_MODE),shared)
	@echo "APP_USE_LIB_MODE: $(APP_USE_LIB_MODE)"
else
	@echo "APP_USE_LIB_MODE: unknown"
endif
	@echo "$(suffix $(DEPEND_FILE_LIB))"
	@echo "$(suffix $(DEPEND_FILE_APP))"
ifeq ($(suffix $(DEPEND_FILE_LIB)),.$(DEPEND_FILE_POSTFIX_LIB))
	@echo "ifeq($(suffix $(DEPEND_FILE_LIB)),.$(DEPEND_FILE_POSTFIX_LIB)) is true"
endif
ifeq ($(suffix $(DEPEND_FILE_APP)),.$(DEPEND_FILE_POSTFIX_APP))
	@echo "ifeq($(suffix $(DEPEND_FILE_APP)),.$(DEPEND_FILE_POSTFIX_APP)) is true"
endif
# Not Working Case
ifeq ($(suffix $@),.test)
	@echo "ifeq ((suffix @),.testExt) is true"
endif

all : app

depend : depend_lib depend_app 
depend_lib : $(DEPEND_FILE_LIB)
depend_app : $(DEPEND_FILE_APP)

lib : lib_static lib_shared
lib_static : depend_lib $(OUT_LIB_PATH_STATIC)
lib_shared : depend_lib $(OUT_LIB_PATH_SHARED)

app : depend_app lib $(OUT_APP)

clean :
	@echo "==================================================="
	@echo "= TARGET: $@"
	@echo "==================================================="
	$(RM) -rf $(OBJS_DIR_NAME)
	$(RM) -rf $(OUT_DIR_NAME)
	@echo "==================================================="
	@echo "= $@: Done"
	@echo "==================================================="

$(DEPEND_FILE_LIB) : $(LIB_SRCS)
	@echo "==================================================="
	@echo "= Abstract Library Source Dependency"
	@echo "= Target: $@"
	@echo "= suffix: $(suffix $@)"
	@echo "==================================================="
	@`[ -d $(OBJS_DIR_NAME) ] || $(MKDIR) -p $(OBJS_DIR_NAME)`
	@$(RM) -f $@
	@for ITEM in $(LIB_ITEMS); do \
		echo "item: $$ITEM, src: $$ITEM.c, obj: $(OBJS_DIR_NAME)/$$ITEM.o"; \
		$(CC) -MM -MT $(OBJS_DIR_NAME)/$$ITEM.o $$ITEM.c $(CFLAGS) $(LIB_INC_DIRS) >> $@; \
	done
	@echo "==================================================="
	@echo "Done"
	@echo "==================================================="

$(DEPEND_FILE_APP) : $(APP_SRCS)
	@echo "==================================================="
	@echo "= Abstract Application Source Dependency"
	@echo "= Target: $@"
	@echo "==================================================="
	@`[ -d $(OBJS_DIR_NAME) ] || $(MKDIR) -p $(OBJS_DIR_NAME)`
	@$(RM) -f $@
	@for ITEM in $(APP_ITEMS); do \
		echo "item: $$ITEM, src: $$ITEM.c, obj: $(OBJS_DIR_NAME)/$$ITEM.o"; \
		$(CC) -MM -MT $(OBJS_DIR_NAME)/$$ITEM.o $$ITEM.c $(CFLAGS) $(APP_INC_DIRS) >> $@; \
	done
	@echo "DEPEND_FILE_APP: $(DEPEND_FILE_APP)"
	@echo "==================================================="
	@echo "Done"
	@echo "==================================================="

##### General Rule ######################################
##### Dependency is DEPEND_FILE_LIB DEPEND_FILE_APP #####
$(OBJS_DIR_NAME)/%.o :
	@echo "==================================================="
	@echo "= Compile: $@"
	@echo "= Source(1st depend. file): $<"
	@echo "= location: $(dir $@)"
	@echo "==================================================="
	@`[ -d $(dir $@) ] || $(MKDIR) -p $(dir $@)`
	$(if $(findstring $<, $(APP_SRCS)), \
		$(CC) $(CFLAGS) $(APP_INC_DIRS) -c $< -o $@, \
		$(CC) $(CFLAGS) $(LIB_INC_DIRS) -c $< -o $@)
	@echo "==================================================="
	@echo "= $@: Done"
	@echo "==================================================="

$(OUT_LIB_PATH_STATIC) : $(LIB_OBJS)
	@echo "==================================================="
	@echo "= Make Static Library"
	@echo "= Target: $@"
	@echo "= Depends: $(LIB_OBJS)"
	@echo "= location: $(dir $@)"
	@echo "==================================================="
	@`[ -d $(dir $@) ] || $(MKDIR) -p $(dir $@)`
	$(AR) rcv $@ $(LIB_OBJS)
	$(RANLIB) $@
	@echo "==================================================="
	@echo "Done"
	@echo "==================================================="

$(OUT_LIB_PATH_SHARED) : $(LIB_OBJS)
	@echo "==================================================="
	@echo "= Make Shared Library"
	@echo "= Target: $@"
	@echo "= Depends: $(LIB_OBJS)"
	@echo "= location: $(dir $@)"
	@echo "==================================================="
	@`[ -d $(dir $@) ] || $(MKDIR) -p $(dir $@)`
	$(CC) -shared -Wl,-soname,$(SHARED_LIB_NAME) -o $@$(SHARED_LIB_NAME_VER_SUFFIX) $(LIB_OBJS)
	$(LN) -fs $(SHARED_LIB_NAME_VER) $@
	@echo "==================================================="
	@echo "Done"
	@echo "==================================================="

$(OUT_DIR_NAME)/% : $(APP_OBJS)
	@echo "==================================================="
	@echo "= Linking: $@"
	@echo "= Object file: $(patsubst $(OUT_DIR_NAME)/%,%.o,$@)"
	@echo "==================================================="
	@`[ -d $(dir $@) ] || $(MKDIR) -p $(dir $@)`
	$(CC) -o $@ $(patsubst $(OUT_DIR_NAME)/%,%.o,$@) $(INC_LIB_PATH) $(INC_LIB_NAMES)
	@echo "==================================================="
	@echo "= $@: Done"
	@echo "==================================================="

%:
	@echo "==================================================="
	@echo "= TARGET: $@, Do nothing"
	@echo "==================================================="

ifneq ($(MAKECMDGOALS), clean)
ifneq ($(MAKECMDGOALS), depend)
ifneq ($(MAKECMDGOALS), depend_lib)
ifneq ($(MAKECMDGOALS), depend_app)
-include $(DEPEND_FILE_LIB)
-include $(DEPEND_FILE_APP)
endif
endif
endif
endif
