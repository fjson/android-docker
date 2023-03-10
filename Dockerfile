FROM debian:bullseye

RUN uname -a && uname -m

RUN apt-get update && \
    apt install unzip -y > /dev/null
    
# docker 容器支持中文， 否则当输出apk包含中文名称时会报错
RUN apt install locales -y > /dev/null && \
    locale-gen zh_CN

ENV LANG=zh_CN.UTF-8

ENV LC_ALL=zh_CN.UTF-8

ENV LANGUAGE=zh_CN.UTF-8
# 安装中文字体
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8


# 配置java环境
# 使用的oracle jdk，直接官网下载即可
COPY jdk-8u361-linux-x64.tar.gz ./

RUN  tar -zxvf jdk-8u361-linux-x64.tar.gz > /dev/null && \
    rm -rf jdk-8u361-linux-x64.tar.gz

ENV JAVA_HOME="$PWD/jdk1.8.0_361"

ENV JRE_HOME="$JAVA_HOME/jre"

ENV CLASSPATH="$JAVA_HOME/lib:$JRE_HOME/lib"

ENV PATH="$PATH:$JAVA_HOME/bin"
# 解决android构建日志中的中文乱码问题
ENV JAVA_OPTS="-Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF-8"

RUN java -version

# 设置Gradle环境
# https://services.gradle.org/distributions/gradle-6.5-all.zip
COPY gradle-6.5 ./gradle-6.5

ENV PATH="$PATH:$PWD/gradle-6.5/bin"

# 设置 android 环境
# Command line tools https://developer.android.com/studio 页面底部
# 使用sdkmanager(需要 java 11 + 的环境 )进行下载  ./cmdline-tools/bin/sdkmanager "build-tools;28.0.3" "platforms;android-28"
COPY android_sdk ./android_sdk

ENV ANDROID_HOME="$PWD/android_sdk"

ENV ANDROID_SDK_ROOT="$ANDROID_HOME"

ENV PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

# 设置NDK环境
# https://developer.android.com/ndk/downloads?hl=zh-cn
COPY android-ndk-r25c ./android-ndk-r25c

ENV NDKHOME="$PWD/android-ndk-r25c"

ENV PATH="$NDKHOME:$PATH"






