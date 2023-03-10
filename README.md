## 创建Android Docker 构建容器

### 下载必要的依赖

- JDK 使用oracle官网下载对应的版本即可
- Android SDK 使用[adkmanager](https://developer.android.com/studio)进行下载

  ```bash
  # sdkmanager运行需要JDK11以上的环境，可先使用JDK11下载好build-tools和platforms，下载完成之后再将JDK替换成项目编译使用的JDK
  # 根据项目使用的build-tools、platforms修改版本号
  ./cmdline-tools/bin/sdkmanager "build-tools;28.0.3" "platforms;android-28" --sdk_root="./android_sdk"
  ```
- 下载[Gradle](https://services.gradle.org/distributions/gradle-6.5-all.zip)，项目根目录有**gradlew**文件可以不用安装
- 下载[NDK](https://developer.android.com/ndk/downloads?hl=zh-cn)，项目中没有使用NDK可以不用下载

### 修改 Dokerfile

根据具体文件夹名称调整Dockerfile中的目录名称

### 构建Image

```bash
docker build -t android:1.0 .
```

### Gradle缓存

- -v /root/.gradle:/root/.gradle
