///   Statements 语句
/*  **概述
    在 Swift 中，有三种类型的语句：简单语句、编译器控制语句和控制流语句。简单语句是最常见的，用于构造表达式或者声明。编译器控制语句允许程序改变编译器的行为，包含编译配置语句和线路控制语句。

    控制流语句则用于控制程序执行的流程，Swift 中有多种类型的控制流语句：循环语句、分支语句和控制转移语句。循环语句用于重复执行代码块；分支语句用于执行满足特定条件的代码块；控制转移语句则用于改变代码的执行顺序。另外，Swift 提供了 do 语句，用于构建局部作用域，还用于错误的捕获和处理；还提供了 defer 语句，用于退出当前作用域之前执行清理操作。

    是否将分号（;）添加到语句的末尾是可选的。但若要在同一行内写多条独立语句，则必须使用分号。
*/

/// 循环语句
/*  **概述
   循环语句会根据特定的循环条件来重复执行代码块。Swift 提供四种类型的循环语句：for 语句、for-in 语句、while 语句和 repeat-while 语句。

   通过 break 语句和 continue 语句可以改变循环语句的控制流。
*/


/*  **For 语句

   for 语句只有在循环条件为真时重复执行代码块，同时计数器递增。

   for 语句的形式如下：

        for 初始化; 条件; 增量 {
             语句
        }

    初始化、条件和增量语句之间必须以分号相隔，循环体中的语句必须以花括号包裹。

    for 语句的执行流程如下：

    初始化只会被执行一次，通常用于声明和初始化在接下来的循环中需要使用的变量。
    判断条件的值。如果为 true，循环体中的语句将会被执行，然后转到第 3 步；如果为 false，循环体中的语句以及增量语句都不会被执行，for 语句至此执行完毕。
    执行增量语句，然后重复第 2 步。
    在初始化语句中定义的变量仅在 for 循环的作用域内有效。

    条件的结果必须符合 BooleanType 协议。
*/

/* **For-In 语句

for-in语句允许在重复执行代码块的同时，迭代集合（或遵循Sequence协议的任意类型）中的每一项。

for-in语句的形式如下：

    for item in collection {
        statements
    }

for-in语句在循环开始前会调用 collection 表达式的generate方法来获取

*/

/*  **While 语句

while语句当循环条件为真时，允许重复执行代码块。

while语句的形式如下：

    while condition {
      statements
    }

while语句的执行流程如下：

计算 condition 表达式： 如果为真true，转到第2步。如果为false，while至此执行完毕。
执行 statements ，然后转到第1步。
由于 condition 的值在 statements 执行前就已计算出，因此while语句中的 statements 可能会被执行若干次，也可能不会被执行。

condition 表达式的值的类型必须遵循BooleanType协议。同时，condition 表达式也可以使用可选绑定.
*/

/*  **Repeat-While 语句

repeat-while语句允许代码块被执行一次或多次。

repeat-while语句的形式如下：

    repeat {
       statements
    } while condition

repeat-while语句的执行流程如下：

执行 statements，然后转到第2步。
计算 condition 表达式： 如果为true，转到第1步。如果为false，repeat-while至此执行完毕。
由于 condition 表达式的值是在 statements 执行后才计算出，因此repeat-while语句中的 statements 至少会被执行一次。

condition 表达式的值的类型必须遵循BooleanType协议。同时，condition 表达式也可以使用可选绑定.
*/

/// 分支语句









