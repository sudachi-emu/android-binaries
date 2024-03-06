#!/bin/bash
set -e

# ANDROID_NDK_ROOT and ANDROID_SDK_ROOT need to be set (possibly to ~/Android/Sdk/ndk/##.#.#######/ and ~/Android/Sdk respectively)

ARCH=x86_64
VERSION=v5.1.LTS

git clone --depth 1 --branch $VERSION https://github.com/arthenica/ffmpeg-kit.git
cd ffmpeg-kit

./android.sh --enable-x264 --enable-libvpx --enable-gpl --disable-arm-v7a{,-neon} --disable-arm64-v8a --disable-x86 --no-archive

cd ..

OUT_DIRECTORY=ffmpeg-android-$VERSION-$ARCH
mkdir $OUT_DIRECTORY
cp -r ffmpeg-kit/prebuilt/android-x86_64/{ffmpeg,libvpx,x264}/* $OUT_DIRECTORY/
cp $0 $OUT_DIRECTORY
tar c $OUT_DIRECTORY | xz -T0 > $OUT_DIRECTORY.tar.xz

