To be able to run these tests you need to do 2 things:

1. Use BITRATE macro in your encoder:

    Also this macro must be settable with compiler

        #ifndef BITRATE
            #define BITRATE 1000
        #endif

2. Makefile must be able to forward ARGS:

        bms1A: bms1A.cpp
            $(CC) $(CFLAGS) $(LIBS) ${ARGS} $^ -o $@ libsndfile.a

Then just run `./run_tests.sh`

