include make_pre.mk

TARGET_SRCS = main.c snr_dr_rcs.c
BUILD_LIBS = -lmath_tech -logl_helper -lradar_principles
LIBS += -lm -lGL -lglut -lGLU
TARGET_OBJS = $(TARGET_SRCS:%.c=%.o)
TARGET_NAMES = radar_basic snr_dr_rcs

all:		$(TARGET_NAMES)

radar_basic:

.c.o:
	@echo "Compiling Main Target Source"
	$(CC) 
