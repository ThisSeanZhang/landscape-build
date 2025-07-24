#!/bin/bash

rm -rf armbian/userpatches/overlay
mkdir -p armbian/userpatches/overlay
cp -rf  ./sharefiles/* armbian/userpatches/overlay

rm -rf armbian/userpatches/customize-image.sh
cp -f ./customize-image.sh armbian/userpatches/customize-image.sh
