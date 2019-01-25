### Python 基础

python 是一门比较流行的高级编程语言， 是一门解释型语言

    - 解释型
      解释性语言通常把源程序编译成中间代码，然后用解释器把中间代码一条条翻译成目标机器代码，一条条执行。

      Python的工作过程：先把代码编译成字节码，在对字节码解释执行。字节码在python虚拟机程序里对应的是PyCodeObject对象，pyc文件是字节码在磁盘上的表现形式。
    - 编译型
      编译性语言写的程序在被执行之前，需要一个专门的编译过程，把程序编译成为机器语言的文件，比如exe文件，以后要运行的话就不用重新翻译了，直接使用编译的结果就行了（exe文件），因为翻译只做了一次，运行时不需要翻译，所以编译型语言的程序执行效率高

      Java则是编译型语言。编译为字节码文件(.class)，然后会经jvm平台编译为目标机器代码

    - 字节码    易跨平台迁移
    - 机器码    运行快速

- Python 简明约定
  - 编码
    - 通常使用 UDF-8 编码
    - Python2 遗留的习惯， 文件头部加入 # -\*- coding=utf-8 -\*-
  - 代码格式
    - 缩进
      一般使用四个空格进行缩进(javascript 规范为 2 个空格)
    - 行宽
      每行代码一般不应过长，太长可能是设计有缺陷
    - 引号
      单引号和双引号都可以用来表示一个字符串
      一般字典 key 使用单引号
    - 空行
      模块级函数和类定义之间空两行；
      类成员函数之间空一行；

        ```
        class A:

            def __init__(self):
                pass

            def hello(self):
                pass


        def main():
            pass   
        ```
  - import 语句
    import 语句应该分行书写
    ```
    # 正确的写法
    import os
    import sys

    # 不推荐的写法
    import sys,os

    # 正确的写法
    from subprocess import Popen, PIPE
    ```
    import语句应该使用 absolute import
    ```
    # 正确的写法
    from foo.bar import Bar

    # 不推荐的写法
    from ..bar import Bar
    ```
  - 空格
    运算符前后空格
    ```
    # 正确的写法
    i = i + 1
    submitted += 1
    x = x * 2 - 1
    hypot2 = x * x + y * y
    c = (a + b) * (a - b)

    # 不推荐的写法
    i=i+1
    submitted +=1
    x = x*2 - 1
    hypot2 = x*x + y*y
    c = (a+b) * (a-b)
    ```
  - 换行
    使用反斜杠\换行，二元运算符+ .等应出现在行末；长字符串也可以用此法换行
    ```
    session.query(MyTable).\
        filter_by(id=1).\
        one()

    print 'Hello, '\
        '%s %s!' %\
        ('Harry', 'Potter')
    ```
  - docstring(文档注释)
    一般公共模块、函数、类、方法，都应该写 docstring

  - 注释
    - “#”号后空一格，段落件用空行分开
      ```
        # 块注释
        # 块注释
        #
        # 块注释
        # 块注释
      ```
    - 文档注释 文档注释以 """ 开头和结尾, 首行不换行, 如有多行, 末行必需换行
        ```
        # -*- coding: utf-8 -*-
        """Example docstrings.

        This module demonstrates documentation as specified by the `Google Python
        Style Guide`_. Docstrings may extend over multiple lines. Sections are created
        with a section header and a colon followed by a block of indented text.

        Example:
            Examples can be given using either the ``Example`` or ``Examples``
            sections. Sections support any reStructuredText formatting, including
            literal blocks::

                $ python example_google.py

        Section breaks are created by resuming unindented text. Section breaks
        are also implicitly created anytime a new section starts.
        """
        ```
  - 命名规范
    - 模块
      模块名一般小写
      ```
        # 正确的模块名
        import decoder
        import html_parser

        # 不推荐的模块名
        import Decoder
      ```
    - 类名
      类名使用驼峰(CamelCase)命名风格，首字母大写，私有类可用一个下划线开头
      ```
        class Farm():
            pass

        class AnimalFarm(Farm):
            pass

        class _PrivateFarm(Farm):
            pass
      ```
      将相关的类和顶级函数放在同一个模块里. 不像Java, 没必要限制一个类一个模块.
    - 函数
      函数名一律小写，如有多个单词，用下划线隔开
      ```
        def run():
            pass

        def run_with_env():
            pass
      ```
    - 变量名
      变量名尽量小写, 如有多个单词，用下划线隔开
      ```
        if __name__ == '__main__':
            count = 0
            school_name = ''
      ```
    - 常量
      常量采用全大写，如有多个单词，使用下划线隔开
      ```
        MAX_CLIENT = 100
        MAX_CONNECTION = 1000
        CONNECTION_TIMEOUT = 600
      ```

- 数据类型
  - Numbers（数字）
    - int（有符号整型）
    - long（长整型[也可以代表八进制和十六进制]）
    - float（浮点型）
    - complex（复数）
  - String（字符串）
  - List（列表）
  - Tuple（元组）
  - Dictionary（字典）
- 语法结构
- 变量、函数定义

### Python 简单爬虫基础

- python 网络库 urllib
- Python 网络库 request
- Python 网页解析库 bs4
- Python 网页解析库 lxml
