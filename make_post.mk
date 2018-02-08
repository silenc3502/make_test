LIB_FULL_NAMES = $(MAIN_LIB_DIR)/$(OBJS_DIR)/lib$(MATH_TECH_LIB_NAME).a
LIB_FULL_NAMES += $(MAIN_LIB_DIR)/$(OBJS_DIR)/lib$(OGL_HELPER_LIB_NAME).a
LIB_FULL_NAMES += $(MAIN_LIB_DIR)/$(OBJS_DIR)/lib$(RADAR_PRINCIPLES_LIB_NAME).a

LIB_SRCS = $(MATH_TECH_LIB_SRCS) $(OGL_HELPER_LIB_SRCS) $(RADAR_PRINCIPLES_LIB_SRCS)

LIB_OBJS = $(LIB_SRCS:%.c$(OBJS_DIR)/%.o)

LIB_NAMES = $(MATH_TECH_LIB_NAME) $(OGL_HELPER_LIB_NAME) $(RADAR_PRINCIPLES_LIB_NAME)

#ALL_LIBS = -l$(LIB_NAMES) $(BUILD_LIBS) $(LIBS)
ALL_LIBS = $(BUILD_LIBS) $(LIBS)

#TARGET_OBJS = $(TARGET_SRCS:%.c=$(OBJS_DIR)/%.o)

#TARGET_DIR = $(MAIN_SRC_DIRS)/main_prog
#OBJS = $($(TARGET_DIR):%.c=%.o)

#TARGET_OBJS = $(TARGET_SRCS:%.c=$(OBJS_DIR)/%.o)
#TARGET_NAMES = $(TARGET_SRCS:%.c=$(OBJS_DIR)/%)

.SUFFIXES : .c .o

all : lib subdirs targets

subdirs:
	@for dir in $(SUB_DIRS); do \
		$(MAKE) -C $$dir all; \
		if [ $$? != 0 ]; then exit 1; fi; \
	done
	@echo "subdirs = $(SUB_DIRS)"

ifeq ($(LIB_NAMES), )
libs :

else
libs : $(LIB_FULL_NAMES)
	@for dir in $(SUB_DIRS); do \
		$(MAKE) -C $$dir liball; \
		if [ $$? != 0 ]; then exit 1; fi; \
	done
endif

lib:	$(LIB_FULL_NAMES)

#libs:	$(LIB_FULL_NAMES)
#	@for dir in $(SUB_DIRS); do \
#		$(MAKE) -C $$dir liball; \
#		if [ $$? != 0 ]; then exit 1; fi; \
#	done

#targets:		radar_basic snr_dr_rcs
targets:		$(TARGET_NAMES)
#targets:		$(TARGET_SRCS)
#targets:		$(TARGET_OBJS)

$(LIB_FULL_NAMES):	$(LIB_OBJS)
	@echo "Making Lib"
	@`[ -d $(MAIN_LIB_DIR)/$(OBJS_DIR) ] || $(MKDIR) -p $(MAIN_LIB_DIR)/$(OBJS_DIR)`
	#$(MKDIR) -p $(MAIN_LIB_DIR)/$(OBJS_DIR)
	$(AR) rcv $@ $(LIB_OBJS)
	$(RANLIB) $@

#$(MAIN_SRC_DIRS)/main_prog/%.o : %.c
#$(OBJS_DIR)/%.o : %.c
#	@echo "Compiling $@ "
#	@`[ -d $(OBJS_DIR) ] || $(MKDIR) $(OBJS_DIR)`
#	$(CC) $(CFLAGS) $(CC_FLAGS) $(INC_DIRS) -c $< -o $@

$(OBJS_DIR)/%.o : %.c
	@echo "***********************"
	@echo "Compiling"
	@echo "***********************"
	@`[ -d $(OBJS_DIR) ] || $(MKDIR) $(OBJS_DIR)`
	$(CC) $(CFLAGS) $(CC_FLAGS) $(INC_DIRS) -c $< -o $@

#.SECONDEXPANSION:
#$(TARGET_NAMES):	$$@.o
#	@echo "***********************"
#	@echo "Compiling"
#	@echo "***********************"
#	$(CC) -o $@ $< $(LIB_DIRS) $(ALL_LIBS)

#$(TARGET_SRCS):
$(TARGET_OBJS):
	@echo "***********************"
	@echo "Compiling"
	@echo "***********************"
	@echo "$(shell pwd)"
	$(CC) -c $(TARGET_SRCS) $(LIB_DIRS) $(ALL_LIBS) $(INC_DIRS) $(CC_FLAGS)

	#@echo "Check Lib Dir $(LIB_DIRS)"
	#@echo "Check All Lib $(ALL_LIBS)"
	#$(CC) -o $@ $< $(LIB_DIRS) $(ALL_LIBS) $(INC_DIRS) $(TARGET_DIR)/main.c
	#$(CC) -o $@ $(TARGET_DIR)/main.o $(LIB_DIRS) $(ALL_LIBS) $(INC_DIRS)

#main.o:
#	$(CC) -c $(TARGET_DIR)/main.c $(LIB_DIRS) $(ALL_LIBS) $(INC_DIRS)

#.SECONDEXPANSION:
#$(TARGET_NAMES): $$@.o
#	@echo "Linking $@ "
#ifeq ($(LIBS_CYCLING_DEPEND),1)
#	$(CC) -o $@ $< $(LIB_DIRS) -Wl,-\( $(ALL_LIBS) -Wl,-\)
#else
#	$(CC) -o $@ $< $(LIB_DIRS) $(ALL_LIBS)
#endif

clean :
	$(RM) -rf build
 
cleanall : clean
	@for dir in $(SUB_DIRS); do \
		$(MAKE) -C $$dir cleanall; \
		if [ $$? != 0 ]; then exit 1; fi; \
	done
 
$(TARGET_NAMES) : $(LIB_FULL_NAMES) \
	$(BUILD_LIBS:-l%=$(MAIN_LIB_DIR)/$(OBJS_DIR)/lib%.a)
 
ifneq ($(MAKECMDGOALS), clean)
ifneq ($(MAKECMDGOALS), cleanall)
ifneq ($(strip $(LIB_SRCS) $(TARGET_SRCS)),)
endif
endif
endif
