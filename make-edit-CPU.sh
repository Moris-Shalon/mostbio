#/bin/bash
sed -i 's/OPENCV[[:space:]]*=[[:space:]]*[[:digit:]]*/OPENCV=1/' darknet/Makefile
sed -i 's/OPENMP[[:space:]]*=[[:space:]]*[[:digit:]]*/OPENMP=1/' darknet/Makefile
sed -i 's/AVX[[:space:]]*=[[:space:]]*[[:digit:]]*/AVX=1/' darknet/Makefile

