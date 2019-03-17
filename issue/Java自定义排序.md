做什么 怎么做 效果

## 前言

在很多场景中，我们需要对容器中的对象进行排序，那么我们可以有两种实现方法：

- 对于需要排序的类实现 Comparable 接口(类内部方法)
- 实现 Comparetor 接口，在用
  `Collections.sort(List<T> list, Comparator<? super T> c)` 时传入

对容器的排序使用`Colections.sort()`

Colections.sort()的调用有两种：分别对应我们前面所述的两种排序接口的实现:

- 需排序的类实现 Comparable 接口，在内部实现 compareTo 方法，定义排序规则，在真
  正排序时会通过调用 O1.compareTo(O2)

  ```
      public static <T extends Comparable<? super T>> void sort(List<T> list) {
          list.sort(null);
      }
  ```

- 在外部创建类实现 Comparetor 接口，compare 方法中自定义排序规则，传入
  Comparetor 实现类对象，排序时调用 compare(O1,O2)

  ```
      public static <T> void sort(List<T> list, Comparator<? super T> c) {
          list.sort(c);
      }
  ```

我们不管通过 O1.compareTo(O2)还是 compare(O1,O2)方法，最终需要返回一个 int 值，
其结果真正需要的是：正数、负数、0，分别表示大于、小于、等于

> 源码中解释： Compares its two arguments for order. Returns a negative
> integer,zero, or a positive integer as the first argument is less than, equal
> to, or greater than the second.

**对于排序结果，我们在排序规则内部使用 O1-O2 则是正序排序，反之为逆序排序**

## 实现效果

1. 对要排序的类实现 Comparable 接口，实现 CompareTo 方法

我们可以创建一个实现 Comparable 接口的类，重写 compareTo 方法

```
class SortObject implements Comparable {
    private final String name;
    private final int count;

    public SortObject(final String name, final int count) {
        this.name = name;
        this.count = count;
    }

    @Override
    public int compareTo(final Object o) {
        final SortObject obj = (SortObject) o;
        // O1.compare(O2)中，使用O2比较O1,排序结果为逆序
        return obj.count - this.count;
    }

    @Override
    public String toString() {
        return "SortObject{" +
                "name='" + name + '\'' +
                ", count=" + count +
                '}';
    }
}
```

然后通过 Colections.sort() 进行排序

```
   public static void main(final String[] args) {
        final List<SortObject> sortObjectList = new ArrayList<>(4);
        sortObjectList.add(new SortObject("o1", 1));
        sortObjectList.add(new SortObject("o2", 7));
        sortObjectList.add(new SortObject("o3", 4));
        sortObjectList.add(new SortObject("o4", 12));

        System.out.println(sortObjectList);
        System.out.println("================sort==============");
        Collections.sort(sortObjectList);
        System.out.println(sortObjectList);
    }
```

可以看到其结果

```
[SortObject{name='o1', count=1}, SortObject{name='o2', count=7}, SortObject{name='o3', count=4}, SortObject{name='o4', count=12}]
================sort==============
[SortObject{name='o4', count=12}, SortObject{name='o2', count=7}, SortObject{name='o3', count=4}, SortObject{name='o1', count=1}]
```

2. 通过 lambda 表达式创建 Comparetor 匿名对象覆盖 compare 方法

此处我们需要一个普通的类，在排序是外部加入排序规则

```
class SortObject {
    private final String name;
    private final int count;

    public SortObject(final String name, final int count) {
        this.name = name;
        this.count = count;
    }

    public int getCount() {
        return count;
    }

    @Override
    public String toString() {
        return "SortObject{" +
                "name='" + name + '\'' +
                ", count=" + count +
                '}';
    }
}
```

接着，我们需要一个实现 Comparetor 接口的类去创建我们的排序规则，然后传入
Collections.sort 中，此处我们使用 lambda 表达式

```
    public static void main(final String[] args) {
        final List<SortObject> sortObjectList = new ArrayList<>(4);
        sortObjectList.add(new SortObject("o1", 1));
        sortObjectList.add(new SortObject("o2", 7));
        sortObjectList.add(new SortObject("o3", 4));
        sortObjectList.add(new SortObject("o4", 12));

        System.out.println(sortObjectList);
        System.out.println("================sort==============");
        // 这儿o1去比较o2，所以结果为正序，如果需要逆序，则o2-o1
        Collections.sort(sortObjectList, (o1, o2) -> o1.getCount() - o2.getCount());
        System.out.println(sortObjectList);
    }
```

可以看到其结果

```
[SortObject{name='o1', count=1}, SortObject{name='o2', count=7}, SortObject{name='o3', count=4}, SortObject{name='o4', count=12}]
================sort==============
[SortObject{name='o1', count=1}, SortObject{name='o3', count=4}, SortObject{name='o2', count=7}, SortObject{name='o4', count=12}]
```

## 原理剖析

核心代码：

```
private static void mergeSort(Object[] src,
                              Object[] dest,
                              int low, int high, int off,
                              Comparator c) {
    int length = high - low;

    // Insertion sort on smallest arrays
    //当数组的长度小于某个阈值(这里官方定义是7)使用冒泡排序法
    if (length < INSERTIONSORT_THRESHOLD) {
        for (int i=low; i<high; i++)
            //这里就调用到我们定义的排序规则，即当dest[j-1]>dest[j]时，
            //交换两个元素的顺序
            for (int j=i; j>low && c.compare(dest[j-1], dest[j])>0; j--)
                swap(dest, j, j-1);
        return;
    }

    // Recursively sort halves of dest into src
    // 如果数组比较长，就递归调用
    int destLow  = low;
    int destHigh = high;
    low  += off;
    high += off;
    //下面这一句相当于int mid = (low+high)/2;
    //在代码中为了避免溢出常写成int mid = low + (high - low)/2,
    //这里使用位移运算符是因为在计算机中，位移运算要以除法运算快。
    int mid = (low + high) >>> 1;
    mergeSort(dest, src, low, mid, -off, c);
    mergeSort(dest, src, mid, high, -off, c);

    // If list is already sorted, just copy from src to dest.  This is an
    // optimization that results in faster sorts for nearly ordered lists.
    //如果数组已经是有序，就直接将数组复制到目标数组中。
    //这里的条件是前面一半的数组已经是有序的，后面一半的数组也是有序的，
    //当前面数组的最后一个值小于后面数组的第一个值，则数组整体有序。
    if (c.compare(src[mid-1], src[mid]) <= 0) {
       System.arraycopy(src, low, dest, destLow, length);
       return;
    }

    // Merge sorted halves (now in src) into dest
    // 合并两个排序的数组
    for(int i = destLow, p = low, q = mid; i < destHigh; i++) {
        if (q >= high || p < mid && c.compare(src[p], src[q]) <= 0)
            dest[i] = src[p++];
        else
            dest[i] = src[q++];
    }
}
```

我们可以看到，排序算法用的是冒泡排序，不过当序列长度超过 7 时，则使用递归.
