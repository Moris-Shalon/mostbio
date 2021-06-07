#/bin/bash
sed -i 's/OPENCV[[:space:]]*=[[:space:]]*[[:digit:]]*/OPENCV=1/' darknet/Makefile
sed -i 's/GPU[[:space:]]*=[[:space:]]*[[:digit:]]*/GPU=1/' darknet/Makefile
sed -i 's/CUDNN[[:space:]]*=[[:space:]]*[[:digit:]]*/CUDNN=1/' darknet/Makefile
sed -i 's/CUDNN_HALF[[:space:]]*=[[:space:]]*[[:digit:]]*/CUDNN_HALF=1/' darknet/Makefile
