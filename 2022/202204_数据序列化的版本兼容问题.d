#### 要老代码解析新数据，只能在数据后面追加

#### ceph中的encode
ceph中的两个接口encode，decode参数太一样，encode中，会有一个version和compat_version。
version么，就是当前struct的版本，compat_version，表示可以兼容的最低版本，如果compat_version，比如变成2，表示兼容的最低版本是2，也就是说和版本1已经不兼容。
如果是版本1的decode逻辑就会出错。所以，除非发生大的变化，compt_version不会发生变化，要发生变化，需要非常谨慎。


#### ceph中的decode
decode部分，会设置一个v，这个v表示，当前的decode支持的数据版本，比如：
```
DECODE_START(2, bl);
```
如果2的比从序列化中解析出来的struct_compat小，那么就会抛出异常，就是decode只能支持到版本2，但是从数据解析出来的版本确是3，说明数据太新。
所以，如果数据更新之后，已经不兼容了，compat_version上涨了，这里就会出错。


#### 处于兼容性考虑，一般只在最后追加字段。
