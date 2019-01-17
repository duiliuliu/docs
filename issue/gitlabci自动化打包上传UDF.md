## 编写 udf

- idea 安装 MaxCompute Studio 插件
  - 本地安装
  - 插件库安装
- 创建 project
  new -> project -> MaxCompute Studio
  ![创建project](./image/创建项目.png)
- 创建 module
  new -> Module -> Maxcompute Java
  ![创建module](./image/创建模块.png)
- 编写 Java 类
  src/main/java 包上 new -> Maxcompute Java
  - 类继承 UDF
  - 主要方法 evaluate()

## 上传 udf

- docker 中运行：

  所以需要一个 docker 镜像，镜像中有 maven 环境，有 odps 客户端可以上传 udf，还有 git 客户端，可以拉取代码

  - maven 打包 udf 为可执行 jar

    `mvn clean install`

  - 然后使用 odps 客户端推送 jar 到 odps 上

    需要有 odps 客户端，安装：

    ```
    centos : sudo yum -y install odpscmd
    Ubuntu : sudo apt-get -y install odpscmd
    修改配置 ~/.odpscmd/odps_config.ini
        project_name=<project_name>
        access_id=<accessid>
        access_key=<accesskey>
        end_point=http://service.odps.aliyun.com/api
        tunnel_endpoint=http://dt.odps.aliyun.com
        log_view_host=http://logview.odps.aliyun.com
        https_check=true
    ```

    然后使用 odps 客户端推送 jar
    odps 连接需要

    ```
    odpscmd
    add jar UDFGetJsonID.jar
    ```

  - 创建函数

    `CREATE FUNCTION UDFGetJsonID AS com.qunhe.bigdata.UDFGetJsonID USING UDFGetJsonID.jar`

- 配置 gitlabci (配置 .gitlab-ci.yml)

  ```
    stages:
        - build
        - upload

    cache:
        paths:
            - FirstModule/target/*.jar

    build:
        stage: build
        script:
            - cd FirstModule
            - mvn clean package
        only:
            - master

    upload:
        stage: upload
        script:
            - odpscmd -e "add -f jar ./FirstModule/target/FirstModule-1.0-SNAPSHOT.jar"
            - odpscmd -e "CREATE FUNCTION UDFGetJsonID AS com.qunhe.bigdata.UDFGetJsonID USING FirstModule-1.0-SNAPSHOT.jar"
        only:
            - master

  ```

## 相关文档

- [JAVA UDF 开发](https://help.aliyun.com/document_detail/27811.html?spm=a2c4g.11186623.6.569.21e82343E8880r)
- [odps 资源操作](https://help.aliyun.com/document_detail/27831.html)
- [odps 函数操作](https://help.aliyun.com/document_detail/27832.html)
- [使用.gitlab-ci.yml 配置作业](https://gitlab.qunhequnhe.com/help/ci/yaml/README)
