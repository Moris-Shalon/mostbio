#!/bin/bash
datemsk=$(TZ="Europe/London" date +%Y%m%d-%H%M%S)
# hotfix for assert error
sed -i "s/    assert(x < m.w \&\& y < m.h \&\& c < m.c);/    \/\/ assert(x < m.w \&\& y < m.h \&\& c < m.c);/" darknet/src/image.c
# set rgb to 1.0 (enable text in labels)
sed -i -E 's|float (\w*) = get_color\([[:digit:]],\s?offset,\s?classes\)[[:space:]]*;$|& \1 = 1.0;|' darknet/src/image.c
# enable % (percentage) of accuracy in labels on images
sed -i -E 's/strcat\(labelstr, names\[selected_detections\[i\].best_class\]\);[[:space:]]*$/& int k; k = selected_detections\[i\].best_class; char bufferj\[100\]; sprintf\(bufferj, " : %.1f %% ", selected_detections\[i\].det.prob\[k\] * 100\); strcat \(labelstr, bufferj\);/' darknet/src/image.c
# part of sed
# printf("%s: %f\\n", "\1: ", \1\);
# move chart.png to charts/chart.png
# sed -i 's/save_mat_png(img, "chart.png");/save_mat_png(img, "charts\/chart.png");/' darknet/src/image_opencv.cpp
sed -i "s/save_mat_png(img, \"chart.png\");/save_mat_png(img, \"charts\/chart-$datemsk.png\");/" darknet/src/image_opencv.cpp
#change font size to 3 (30)
sed -i 's/image label = get_label_v3(alphabet, labelstr, (im\.h\*\.02));/image label = get_label_v3(alphabet, labelstr, (im.h*.03));/' darknet/src/image.c
# invert labels (set black background and white font for text)
sed -i 's/convert -fill black -background white -bordercolor white/convert -fill white -background black -bordercolor black/' darknet/data/labels/make_labels.py
# set font size x*10 (10,20,30,40,50,60,70,80)
sed -i -E 's/for (\w*) in \[([[:space:]]?[[:digit:]]*[[:space:]]?,?){8}\]/for \1 in [10,20,30,40,50,60,70,80]/' darknet/data/labels/make_labels.py
# set label file name to font size divided by 10
sed -i 's/s\/[[:digit:]]*-1/s\/10-1/' darknet/data/labels/make_labels.py
# change font
sed -i "s/font = .*/font = 'Futura-Normal'/" darknet/data/labels/make_labels.py
# 1 more hotfix for darknet
sed -i -E 's/\s{3,4}(network_predict\s*\(\s*\*net,\s*im\.data\)\s*;\s*$)/    if (net->batch != 1) set_batch_network(net, batch_size); \1/' darknet/src/network.c
