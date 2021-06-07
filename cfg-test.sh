# need to set our custom cfg to test mode
#cd cfg
#cd /content/darknet/
sed -i 's/subdivisions[[:space:]]*=[[:space:]]*[[:digit:]]*/subdivisions=32/' cfg/yolov4_custom.cfg
sed -i 's/subdivisions[[:space:]]*=[[:space:]]*[[:digit:]]*/subdivisions=4/' cfg/yolov4-tiny-custom.cfg

#set max_chart_lost (maximum Y on chart.png) to 5 \
# set number of filters before yolo layer to 45 ((classes+5)*3)
# set number of yolo classes to 10
# set max_batches to 100000 (10 classes * 10000)
# set steps to 80000 (100000*0,8) and 90000 (100000*0,9)

for i in "cfg/yolov4-custom.cfg" "cfg/yolov4-tiny-custom.cfg"; do
  sed -i 's/batch[[:space:]]*=[[:space:]]*[[:digit:]]*/batch=1/' $i;
  sed -i 's/channels[[:space:]]*=[[:space:]]*[[:digit:]]*/channels=1/' $i;
  if [[ $( grep 'max_chart_loss' $i) -ne 0 ]]; then sed -i -E 's/max_chart_loss\s*=\s*[[:digit:]]*/max_chart_loss=1/' $i; fi;
  if [[ $( grep 'max_chart_loss' $i) -eq 0 ]]; then sed -i -E 's/(hue.*)/\1\nmax_chart_loss=1/' $i; fi;
  sed -E -i ':a;N;$!ba;s/(size=1\nstride=1\npad=1\n)filters\s*=\s*[[:digit:]]*/\1filters=45/g' $i;
  sed -i 's/classes\s*=\s*[[:digit:]]*/classes = 10/' $i;
  sed -i 's/max_batches\s*=\s*[[:digit:]]*/max_batches = 100000/' $i;
  sed -i 's/steps\s*=\s*[[:digit:]]*,[[:digit:]]*/steps = 80000,90000/' $i;
done

#cd ..
