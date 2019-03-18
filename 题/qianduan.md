HTML 、CSS、WebAPI

HTML 中，head 标签下有哪些常见的内容，它们的作用分别是什么？
为什么通常建议把 CSS 的 link 标签放在 head 下，而把 JS 的 script 标签放在 body 的末尾？有没有例外的情况？
script 标签的 async 和 defer 的含义是什么
HTML 的 attribute 和 property 有什么差别？
常见的 CSS class 的组织方式和命名规范？如何避免样式冲突，保持可维护性？
浏览器是如何匹配到一条 CSS 语法对应的元素的？
浏览器的 event loop 是什么？在工作中有哪些场景需要考虑event loop？
JS

JS 里变量提升是什么？
JS 里的闭包是什么？
JS 里的原型链是怎么回事？原型链的顶端是什么？如何判断一个变量是不是一个类的实例？
如何遍历一个对象上的所有属性？
Function.prototype.bind 的作用是什么？如何实现？
实现 debounce
实现 throttle
实现计算  fibonacci 数的函数 fib(num)

fib(0)                              // 0
fib(1)                              // 1
fib(10)                             // 55
fib(20)                             // 6765
实现 includes(array, item) 方法

includes([1, 3, 8, 10], 8)            // true
includes([1, 3, 8, 8, 15], 15)        // true
includes([1, 3, 8, 10, 15], 9)        // false
实现 reduceAsync(promiseArray, callback)：

let a = () => Promise.resolve('a')
let b = () => Promise.resolve('b')
let c = () => new Promise(resolve => setTimeout(() => resolve('c'), 100))
await reduceAsync([a, b, c], (acc, value) => [...acc, value], [])
// ['a', 'b', 'c']
await reduceAsync([a, c, b], (acc, value) => [...acc, value], ['d'])
// ['d', 'a', 'c', 'b']


工程经验

实现一个 AutoComplete 组件，例如淘宝首页的搜索框，它的 API 如何设计，DOM 结构如何设计？当用户输入很快、请求响应很慢的时候如何处理？如何取消之前的请求？
跨域问题是如何产生的？常见的解决方式有哪些？
开发多语言 web 应用时需要考虑哪些方面？
期望使用一项较新的 JS、CSS 语法或者浏览器特性时，如何解决浏览器的兼容性问题？有没有具体的例子？
为什么要使用 webpack，使用过它的哪些特性？
你使用过哪些前端框架，为什么要用它，它能解决什么问题？它有没有什么缺点？
最近了解过哪些新技术？对它们有什么看法？
