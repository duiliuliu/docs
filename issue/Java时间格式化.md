# Java 时间格式化

业务： 需要对时间戳格式的数据进行转化为固定时间格式的数据。

simpleDateFormat在多线程情况下不安全，而且joda_time还支持格式化的时间加减算法，所以推荐使用joda_time

## SimpleDateFormat

SimpleDateFormat 是 Java 中非常常用的一个类，该类用来对日期字符串进行解析和格式化输出，但如果使用不小心会导致非常微妙和难以调试的问题，因为 DateFormat 和 SimpleDateFormat 类不都是线程安全的，在多线程环境下调用 format() 和 parse() 方法应该使用同步代码来避免问题。

```
SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_FORMAT);

System.out.println(simpleDateFormat.format(new Date(System.currentTimeMillis())));
```

## joda_time

```
new DateTime(System.currentTimeMillis()).toString(DATE_FORMAT);
```
