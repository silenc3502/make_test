include $(PROJ_ROOT)/make_pre.mk

MATH_TECH_LIB_NAME = math_tech
MATH_TECH_LIB_SRCS = math_tech.c

OGL_HELPER_LIB_NAME = ogl_helper
OGL_HELPER_LIB_SRCS = ogl_helper.c

RADAR_PRINCIPLES_LIB_NAME = radar_principles
RADAR_PRINCIPLES_LIB_SRCS = burn_through_range.c doppler_frequency.c power_aperture.c pulse_train.c radar_range_equation.c range_resolution.c sdjpn.c self_screening_jammer.c stand_off_jammer.c

TARGET_SRCS = main.c snr_dr_rcs.c

BUILD_LIBS = -lmath_tech -logl_helper -lradar_principles

LIBS += -lm -lGL -lglut -lGLU

include $(PROJ_ROOT)/make_post.mk
