# C++嵌入式工程代码规范

## 1.Format
函数与宏函数名使用全小写字母加下划线：
```cpp
void some_function();
```

变量使用小驼峰：
```cpp
int someVariable;
```

类，枚举使用大驼峰：
```cpp
class SomeClass {};
enum SomeEnum {};
```

结构体和联合体使用typedef定义，名称全小写加下划线加_t：
```cpp
typedef struct {
} some_struct_t;

typedef union {
} some_union_t;
```

宏变量和const变量使用全大写加下划线：
```cpp
#define SOME_MACRO_VARIABLE 0

const int SOME_CONST_VARIABLE = 0;
```

## 2.细节规范
代码内禁止出现全局变量参数传递使用指针或引用方式实现，如果有需要使用全局变量的地方使用静态全局代替

.h文件的标准格式如下：
```cpp
#ifndef SOME_HEADERFILE_H
#define SOME_HEADERFILE_H

//这里放头文件
#include "main.h"

// 这里放宏变量与宏函数
#define SOME_VARIABLE 0

// 这里放定义的结构体
typedef struct {
    int a;
    int b;
} some_struct_t;

// 这里放定义的联合体
typedef union {
    struct {
        int c;
        int d;
    };
    double e;
};

// 这里放类的定义
class A {
// 私有成员变量放上面
private:
    int var;
// 公共成员变量放下面
public:
    // 构造函数放在私有成员变量或者公共成员变量的顶端
    A();
    ~A();

    void func();
}

//普通函数放这里
void some_function();

#endif
```

.cpp文件的标准格式如下：
```cpp
// 这里放引用的头文件
#include "some_header.h"

// 这里放静态全局常量
static const int CONST_A = 1;

// 这里放全局变量
static int varA;

// 这里放函数声明
void some_function();

// 这里放函数定义
void some_function() {
    varA = CONST_A;
}
```