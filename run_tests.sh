#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

function run_set(){
    FILES=tests/*
    for f in $FILES
    do
      echo -en "\tProcessing $f\t\t"
      b=$(basename $f)
      bwav=$(basename "${f%.txt}.wav")
      cp $f $b
      ./bms1A $b
      rm $b
      ./bms1B $bwav
      diff $b $f > /dev/null
      RETVAL=$?
      [ $RETVAL -eq 0 ] && echo -e ${GREEN}Success${NC}
      [ $RETVAL -ne 0 ] && echo -e ${RED}Failure${NC}
      rm $b $bwav
    done
}

bitrates=(1000 1001 1002 1003 1004 1005 1006 1007 1008 1009 1010
          1020 1030 1040 1050 1060 1070 1080 1090 1100
          1200 1300 1400 1500 1600 1700 1800 1900 2000
         )

for bitrate in "${bitrates[@]}"
do
    echo "Bitrate $bitrate :"
    make clean >/dev/null && make ARGS=-DBITRATE=$bitrate >/dev/null
    run_set
done
