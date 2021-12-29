#CC = g++
CC = gcc

# 사용자 추가, 확장자 선정
SOURCE_FILE_EXT = c

# C++ 컴파일러 옵션
#CXXFLAGS = -Wall -O2
# C 컴파일러 옵션
CFLAGS = -lm -Wall

# 링커 옵션
LDFLAGS =

# 헤더파일 경로
#INCLUDE = -Iinclude/
INCLUDE = -I./

# 소스 파일 디렉토리
#SRC_DIR = ./src
SRC_DIR = .

# 오브젝트 파일 디렉토리
#OBJ_DIR = ./obj
OBJ_DIR = .

# 생성하고자 하는 실행 파일 이름
#TARGET = main
TARGET = c_lib

# Make 할 소스 파일들
# wildcard 로 SRC_DIR 에서 *.cc 로 된 파일들 목록을 뽑아낸 뒤에
# notdir 로 파일 이름만 뽑아낸다.
# (e.g SRCS 는 foo.cc bar.cc main.cc 가 된다.)
#SRCS = $(notdir $(wildcard $(SRC_DIR)/*.cc))
SRCS = $(notdir $(wildcard $(SRC_DIR)/*.$(SOURCE_FILE_EXT)))
SRCS_PARSE_USING_SHELL_CMD = $(shell find -L ${SRC_DIR} -type f \( -iname "*.c" -o -iname "*.cpp" -o -iname "*.s" \) )
$(info =============================================================)
$(info SRCS = ${SRCS})
$(info SRCS_PARSE_USING_SHELL_CMD = ${SRCS_PARSE_USING_SHELL_CMD})
$(info =============================================================)
$(info )

#OBJS = $(SRCS:.cc=.o)
#DEPS = $(SRCS:.cc=.d)
OBJS = $(SRCS:.$(SOURCE_FILE_EXT)=.o)
$(info =============================================================)
$(info OBJS = ${OBJS})
$(info =============================================================)
$(info )
DEPS = $(SRCS:.$(SOURCE_FILE_EXT)=.d)
$(info =============================================================)
$(info DEPS = ${DEPS})
$(info =============================================================)
$(info )

# OBJS 안의 object 파일들 이름 앞에 $(OBJ_DIR)/ 을 붙인다.
#OBJECTS = $(patsubst %.o,$(OBJ_DIR)/%.o,$(OBJS))
OBJECTS = ${OBJS}
$(info =============================================================)
$(info OBJECTS = ${OBJECTS})
$(info =============================================================)
$(info )
DEPS = $(OBJECTS:.o=.d)
$(info =============================================================)
$(info DEPS = ${DEPS})
$(info =============================================================)
$(info )

#all: $(TARGET)

#$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cc	# for C++
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.$(SOURCE_FILE_EXT)
	@echo "============================================================"
	@echo "TEST PRINT($$ @), $@"
	@echo "TEST PRINT($$^), $^"
	@echo "TEST PRINT($$<), $<"
	@echo "info src: ${SRCS}, obj: ${OBJS}, dep: ${DEPS}"
	@echo "============================================================"
	@echo "= Compiling $@"
	@echo "============================================================"
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@ -MMD $(LDFLAGS)
#	$(CC) $(CXXFLAGS) $(INCLUDE) -c $< -o $@ -MMD $(LDFLAGS)	# for C++
	@echo "============================================================"
	@echo ""

test/testLib_llist.o :  $(OBJECTS) test/testLib_llist.c
	@echo "============================================================"
	@echo "= Compiling $@"
	@echo "============================================================"
	$(CC) $(CFLAGS) $(INCLUDE) -c test/testLib_llist.c -o $@ -MMD $(LDFLAGS)
	@echo "============================================================"
	@echo ""

test/test_llist.o : $(OBJECTS) test/testLib_llist.o test/test_llist.c
	@echo "============================================================"
	@echo "= Compiling $@"
	@echo "============================================================"
	$(CC) $(CFLAGS) $(INCLUDE) -c test/test_llist.c -o $@ -MMD $(LDFLAGS)
	@echo "============================================================"
	@echo ""

test/test_stack.o : $(OBJECTS) test/testLib_llist.o test/test_stack.c
	@echo "============================================================"
	@echo "= Compiling $@"
	@echo "============================================================"
	$(CC) $(CFLAGS) $(INCLUDE) -c test/test_stack.c -o $@ -MMD $(LDFLAGS)
	@echo "============================================================"
	@echo ""

test/test_queue.o : $(OBJECTS) test/testLib_llist.o test/test_queue.c
	@echo "============================================================"
	@echo "= Compiling $@"
	@echo "============================================================"
	$(CC) $(CFLAGS) $(INCLUDE) -c test/test_queue.c -o $@ -MMD $(LDFLAGS)
	@echo "============================================================"
	@echo ""

#$(TARGET) : $(OBJECTS)
#	$(CC) $(CFLAGS) $(OBJECTS) -o $(TARGET) $(LDFLAGS)
#	$(CC) $(CXXFLAGS) $(OBJECTS) -o $(TARGET) $(LDFLAGS)	# for C++

test_llist : $(OBJECTS) test/testLib_llist.o test/test_llist.o
	@echo "============================================================"
	@echo "= Linking $@"
	@echo "============================================================"
	$(CC) $(CFLAGS) $(OBJECTS) test/testLib_llist.o test/test_llist.o -o test/test_llist $(LDFLAGS)
	@echo "============================================================"
	@echo ""

test_stack : $(OBJECTS) test/testLib_llist.o test/test_stack.o
	@echo "============================================================"
	@echo "= Linking $@"
	@echo "============================================================"
	$(CC) $(CFLAGS) $(OBJECTS) test/testLib_llist.o test/test_stack.o -o test/test_stack $(LDFLAGS)
	@echo "============================================================"
	@echo ""

test_queue : $(OBJECTS) test/testLib_llist.o test/test_queue.o
	@echo "============================================================"
	@echo "= Linking $@"
	@echo "============================================================"
	$(CC) $(CFLAGS) $(OBJECTS) test/testLib_llist.o test/test_queue.o -o test/test_queue $(LDFLAGS)
	@echo "============================================================"
	@echo ""

test : test_llist test_stack test_queue
	make test_llist
	make test_stack
	make test_queue

clean_llist:
	rm -f ./test/testLib_llist.o ./test/testLib_llist.d
	rm -f ./test/test_llist ./test/test_llist.o ./test/test_llist.d

clean_stack:
	rm -f ./test/testLib_llist.o ./test/testLib_llist.d
	rm -f ./test/test_stack ./test/test_stack.o ./test/test_stack.d

clean_queue:
	rm -f ./test/testLib_llist.o ./test/testLib_llist.d
	rm -f ./test/test_queue ./test/test_queue.o ./test/test_queue.d

clean_test:
	make clean_llist
	make clean_stack
	make clean_queue
	make clean

clean:
	rm -f $(OBJECTS) $(DEPS) $(TARGET)
#	rmdir $(OBJ_DIR)

ifneq ($(MAKECMDGOALS), clean)
ifneq ($(SRCS),)
-include $(DEPS)
endif
endif
