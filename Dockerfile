FROM ubuntu:18.04

RUN apt-get --quiet update --yes && apt-get --quiet install --yes wget tar unzip python3-pip openjdk-8-jdk cmake python p7zip-full curl

# download android sdk
RUN wget -c --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN rm android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-28"
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools"
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;28.0.2"

# download android ndk r21, which extracts to /android-ndk-r21
RUN wget -c --quiet --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r21-linux-x86_64.zip
RUN unzip -d / android-ndk.zip
RUN rm android-ndk.zip

# download qt for android
RUN wget https://code.qt.io/cgit/qbs/qbs.git/plain/scripts/install-qt.sh && chmod +x ./install-qt.sh
RUN ./install-qt.sh --version 5.14.1 --target android --toolchain any qtbase qtscript qtandroidextras --directory ./qt_root