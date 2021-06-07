# mostbio
How to train model: upload YOLOv4-mostbio.ipynb to your Google Colab, open it in Google Colab and click Run All (or Ctrl+F9).

Prerequeisites to train model on Ubuntu 18.04 or 20.04:
1. Python 3.8
2. NVidia drivers installed to train or GPU with CUDA acceleration (not necessary for training on CPU).

Steps to train model locally on Ubuntu 18.04 or 20.04:
1. clone the repo with command 
```git clone --recursive https://github.com/ZChuckMoris/mostbio.git```
2. cd to repo's directory
```cd mostbio```
3. edit darknet's sources with darknet-sed.sh
```sh darknet-sed.sh```
4. install ImageMagick using install-imagemagick.sh
```sh install-imagemagick.sh```
5. make labels for bndbox
```sh make-labels-for-bndbox.sh```
6. install OpenCV:
```sudo apt install libopencv-dev```
7. run make-edit-GPU.sh if you are training on CPU or make-edit-CPU.sh if you with to train on CPU:
* 7.a. GPU:
```sh make-edit-GPU.sh```
* 7.b. GPU:
```sh make-edit-CPU.sh```
8. cd to darknet folder
```cd darknet```
9. make darket from sources:
```make```
10. download pre-trained weights for YOLOv4-tiny (what I used) or YOLOv4:
* 10.a. YOLOv4-tiny:
```wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v4_pre/yolov4-tiny.conv.29```
* 10.b. YOLOv4:
```wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v4_pre/yolov4.conv.137```
11. generate train.txt and test.txt for images in data/train and data/test:
```python3 ../generate_train.py```
12. run cfg-train.sh to edit your cfg file for training:
```sh ../cfg-train.sh```
13. train you model with next command:
* 13.a. YOLOv4-tiny:
```./darknet detector train data/obj.data cfg/yolov4-tiny-custom.cfg yolov4-tiny.conv.29 -dont_show -map ```
* 13.b. YOLOv4:
```./darknet detector train data/obj.data cfg/yolov4-custom.cfg yolov4.conv.137 -dont_show -map```
14. run cfg-test.sh to edit your cfg file for testing:
```sh ../cfg-test.sh```
15. test your detection on random image:
```randomimage=$(ls data/test/*.jpg | sort -R | tail -1); ./darknet detector test data/obj.data cfg/yolov4-tiny-custom.cfg /mydrive/yolov4/backup/yolov4-tiny-custom_last.weights $randomimage -thresh 0.3; echo $randomimage```
