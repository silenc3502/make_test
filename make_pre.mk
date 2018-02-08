CC = gcc
AR = ar
RANLIB = ranlib
RM = rm
MKDIR = mkdir
MAKE = make

MAIN_SRC_DIRS = $(PROJ_ROOT)/src
MAIN_OUT_DIR = $(PROJ_ROOT)/build
MAIN_LIB_DIR = $(MAIN_OUT_DIR)/lib

INC_DIRS = -I$(MAIN_SRC_DIRS)/math_tech
INC_DIRS += -I$(MAIN_SRC_DIRS)/opengl
INC_DIRS += -I$(MAIN_SRC_DIRS)/radar_principles

ifeq ($(RELEASE), 1)
OBJS_DIR = release
CC_FLAGS = -O2
else
OBJS_DIR = debug
CC_FLAGS = -g -O0 -DDEBUG
endif

LIB_DIRS = -L$(MAIN_LIB_DIR)/$(OBJS_DIR)
