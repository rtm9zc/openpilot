CC = clang
CXX = clang++

PHONELIBS = ../../phonelibs

WARN_FLAGS = -Werror=implicit-function-declaration \
             -Werror=incompatible-pointer-types \
             -Werror=int-conversion \
             -Werror=return-type \
             -Werror=format-extra-args

CFLAGS = -std=gnu11 -g -fPIC -O2 $(WARN_FLAGS)
CXXFLAGS = -std=c++11 -g -fPIC -O2 $(WARN_FLAGS)

ZMQ_FLAGS = -I$(PHONELIBS)/zmq/aarch64/include
ZMQ_LIBS = -L$(PHONELIBS)/zmq/aarch64/lib \
           -l:libczmq.a -l:libzmq.a \
           -lgnustl_shared

.PHONY: all
all: sensord

-include ../common/cereal.mk

OBJS = sensors.o \
       $(CEREAL_OBJS)

DEPS := $(OBJS:.o=.d)

sensord: $(OBJS)
	@echo "[ LINK ] $@"
	$(CXX) -fPIC -o '$@' $^ \
            $(CEREAL_LIBS) \
            $(ZMQ_LIBS) \
            -lhardware

sensors.o: sensors.cc
	@echo "[ CXX ] $@"
	$(CXX) $(CXXFLAGS) \
           -I$(PHONELIBS)/android_system_core/include \
           $(CEREAL_CFLAGS) \
           $(ZMQ_FLAGS) \
           -I../ \
           -I../../ \
           -c -o '$@' '$<'

.PHONY: clean
clean:
	rm -f sensord $(OBJS) $(DEPS)

-include $(DEPS)
