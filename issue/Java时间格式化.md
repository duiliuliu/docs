# Java 时间格式化

业务： 需要对时间戳格式的数据进行转化为固定时间格式的数据。

simpleDateFormat 在多线程情况下不安全，而且 joda_time 还支持格式化的时间加减算法，所以推荐使用 joda_time

## SimpleDateFormat

SimpleDateFormat 是 Java 中非常常用的一个类，该类用来对日期字符串进行解析和格式化输出，但如果使用不小心会导致非常微妙和难以调试的问题，因为 DateFormat 和 SimpleDateFormat 类不都是线程安全的，在多线程环境下调用 format() 和 parse() 方法应该使用同步代码来避免问题。

```
SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_FORMAT);

System.out.println(simpleDateFormat.format(new Date(System.currentTimeMillis())));
```

- 对于 SimpleDateFormat 非线程安全的解决-- 可用 threadlocal

将 SimpleDateFormat 维护在线程的本地变量中，就不会发生线程安全问题了，不过会有**耗费资源**的问题

```
private static ThreadLocal<SimpleDateFormat> formatThreadlocal;


public static SimpleDateFormat getFormat(){
    if (formatThreadlocal.get() == null) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_FORMAT);
        formatThreadlocal.set(simpleDateFormat);
        return simpleDateFormat;
    }else{
        //③直接返回线程本地变量
        return formatThreadlocal.get();
    }
}

```

## joda_time

```
new DateTime(System.currentTimeMillis()).toString(DATE_FORMAT);
```
