#!/bin/bash
# Install imagemagick for Ubuntu 18.04.5
sudo apt update -y ;
sudo apt-get install -y fontconfig fontconfig-config fonts-dejavu-core fonts-droid-fallback fonts-noto-mono ghostscript gsfonts hicolor-icon-theme libxt6 libavahi-client3 libavahi-common-data libavahi-common3 libcairo2 libcups2 libcupsfilters1 libcupsimage2 libdatrie1 libdjvulibre-text libdjvulibre21 libfftw3-double3 libfontconfig1 libgraphite2-3 libgs9 libgs9-common libharfbuzz0b libijs-0.35 libilmbase12 libjbig0 libjbig2dec0 libjpeg-turbo8 libjpeg8 liblcms2-2 liblqr-1-0  libnetpbm10 libopenexr22 libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpaper-utils libpaper1 libpixman-1-0 libthai-data libthai0 libtiff5 libwmf0.2-7 libxcb-render0 libxcb-shm0 libxrender1 netpbm poppler-data;
sudo apt-get -qq install -y build-essential;
# wget https://www.imagemagick.org/download/ImageMagick.tar.gz
# tar xzf ImageMagick.tar.gz
# for i in ImageMagick-*; do echo cd $i; done
pwd;
if [[ -d "./ImageMagick" ]]; then rm -rf ImageMagick; fi;
git clone https://github.com/ImageMagick/ImageMagick.git ImageMagick;
cd ImageMagick;
git reset --hard $(curl --silent "https://api.github.com/repos/ImageMagick/ImageMagick/releases/latest" | grep '"target_commitish":' | sed -E 's/.*"([^"]+)".*/\1/');
./configure;
make;
sudo make install;
sudo ldconfig /usr/local/lib;
pwd;
cd ../;
pwd;
