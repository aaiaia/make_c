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
SRC_DIR = ./

# 오브젝트 파일 디렉토리
OBJ_DIR = ./obj

# 생성하고자 하는 실행 파일 이름
#TARGET = main
TARGET = test_llist 

# Make 할 소스 파일들
# wildcard 로 SRC_DIR 에서 *.cc 로 된 파일들 목록을 뽑아낸 뒤에
# notdir 로 파일 이름만 뽑아낸다.
# (e.g SRCS 는 foo.cc bar.cc main.cc 가 된다.)
#SRCS = $(notdir $(wildcard $(SRC_DIR)/*.cc))
SRCS = $(notdir $(wildcard $(SRC_DIR)/*.$(SOURCE_FILE_EXT)))

#OBJS = $(SRCS:.cc=.o)
#DEPS = $(SRCS:.cc=.d)
OBJS = $(SRCS:.$(SOURCE_FILE_EXT)=.o)
DEPS = $(SRCS:.$(SOURCE_FILE_EXT)=.d)


# OBJS 안의 object 파일들 이름 앞에 $(OBJ_DIR)/ 을 붙인다.
OBJECTS = $(patsubst %.o,$(OBJ_DIR)/%.o,$(OBJS))
DEPS = $(OBJECTS:.o=.d)

all: test_llist

#$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cc
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.$(SOURCE_FILE_EXT)
	mkdir $(OBJ_DIR) 2> /dev/null || true
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@ -MD $(LDFLAGS)
	#$(CC) $(CXXFLAGS) $(INCLUDE) -c $< -o $@ -MD $(LDFLAGS)

$(TARGET) : $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(TARGET) $(LDFLAGS)
	#$(CC) $(CXXFLAGS) $(OBJECTS) -o $(TARGET) $(LDFLAGS)

.PHONY: clean all
clean:
	rm -f $(OBJECTS) $(DEPS) $(TARGET)

-include $(DEPS)

