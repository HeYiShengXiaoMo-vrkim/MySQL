# 1. DDL之数据库操作
/*
  1.1 数据库创建
      创建数据库
      create database 数据库名;
      判断再创建数据库
      create database if not exists 数据库名;
      创建数据库指定字符集
      create database 数据库名 character set 字符集;
      创建数据库指定排序方式
      create database 数据库名 collate 排序方式;
      创建数据库指定字符集和排序方式
      create database 数据库名 character set 字符集 collate 排序方式;
      查询数据库的字符集和排序方式
      mysql8: 默认 utf8mb4 utf8mb4_0900_ai_ci
      show variables like 'character_set_database';
      show variables like 'collation_database';
      练习: 
          创建ddl_d1库,指定字符集为utf8,且排序方式用大小写敏感的utf8mb4_0900_as_cs模式   
*/
CREATE DATABASE IF NOT EXISTS ddl_d1 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;



/*
  1.2 数据库查看
      查看所有库
      show databases;
      查看当前使用库
      select database();
      查看库下所有表
      show tables from 数据库名;
      查看创建库的信息和语句
      show create database 数据库名;
      选中和切换库;
      use 数据库名;
      注意: 对数据进行操作之前,必须要选中库! use 数据库; use 数据库名;
*/
/*
  1.2 数据库查看
  查看所有库 
  show databases;
  查看当前使用的库
  select database();
  查看库下所有表
  show tables from 数据库名;
  查看创建库的信息和语句
  show create database 数据库名;
  选中和切换数据库;
  use 数据库名;
  对数据进行操作之前，必须要选中库！选中数据库之后才可以对数据进行操作,use 数据库名,use 数据库 ，show databases展示当前所有库； select database();查看当前所使用的库;show tables from 数据库名; show create database 数据库名;
*/
SHOW DATABASES; #展示当前的所有库

SELECT DATABASE(); #展示当前使用的数据库 
 
USE mysql; # 转换到mysql这个数据库中 

SHOW TABLES FROM mysql; # 查看库下所有表

SHOW CREATE DATABASE ddl_d1; # 查看ddl_dl这个数据库的创建信息


/*
  1.3 数据库修改
      修改字符集
      alter database 数据库名 character set 字符集;
      修改排序方式
      alter database 数据库名 collate 排序方式;
      修改字符集和排序方式
      alter database 数据库名 character set 字符集 collate 排序方式;
      注意: 数据库中没有修改名称的指令,如果你想改名字,备份数据,删除旧库,创建新库,恢复数据即可!
*/
/*
  1.3 数据库修改 
  修改字符集 
  alter database 数据库名 character set 字符集 
  修改排序方式 
  alter database 数据库名 collate 排序方式
  修改字符集和排序方式 
  alter database 数据库名 character set 字符集 collate 排序方式；
  数据库中没有用修改名称的指令，如果想要改名字，备份数据，删除旧库，创建新库，恢复数据即可！
  alter database 数据库名 character set 字符集 
  修改排序方式
  alter database 数据库名 collate 排序方式 
  修改字符集和排序方式 
  alter database 数据库名 character set 字符集 collate 排序方式
  数据库中没有可以用于修改名称的指令，如果想要修改名字，备份数据，删除旧库，创建新库，恢复数据即可
  */

/*
  1.4 数据库删除
      直接删除
      drop database 数据库名;
      判断删除
      drop database if exists 数据库名;
      注意: 删除是一个危险命令,确认明确,再操作!!
*/
/*
  1.4数据库删除 
  直接删除
  drop database 数据库名； drop database 数据库名 
  判断删除
  drop database if exists 数据库名； drop database if exists 数据库名;
  删除是一个危险指令，确认明确，在操作
  */

/*
  1.5 数据库管理练习
      场景1：
      假设你正在为一个多语言的博客平台设计数据库。你需要创建一个名为 blog_platform 的数据库，
      支持存储多语言的文章和评论。由于博客平台可能包含来自不同语言的用户，你决定使用 utf8mb4字符集，
      排序方式选择默认值，以支持广泛的 Unicode 字符
    create database if not exists blog_platform character set utf8mb4;
  use blog_platform;
      场景2:
      查看数据库字符集和排序规则
    show varibles like 'character_set_database';
  show variables like 'collation_database';
      场景3:
      假设在后续的发展中，你决定将排序方式修改为 utf8mb4_0900_as_cs，以实现大小写敏感的比较。
  alter database collate utf8mb4_0900_as_cs;
      场景4:
      查看数据库字符集和排序规则
  show create database blog_platform;
      场景5:
      项目惨遭放弃，需要删除项目库，并且跑路
  drop database if exists blog_platform;
  show databases;
*/

CREATE DATABASE IF NOT EXISTS blog_platform CHARACTER SET utf8mb4;

USE blog_platform; #********这里修改数据之前要先use到当前的数据库

SHOW VARIABLES LIKE 'character_set_database';
SHOW VARIABLES LIKE 'collation_database';

ALTER DATABASE blog_platform COLLATE utf8mb4_0900_as_cs;

show create database blog_platform;

DROP DATABASE IF EXISTS blog_platform;

SHOW DATABASES;


# 2. DDL之数据表操作
/*
  2.1 建表语法
  建表语法总结
   
   create table [if not exist] 表名(
     # 列的信息
     列名 类型 [列的约束] [列的注释],
     列名 类型 [列的约束] [列的注释],
     ...
     列名 类型 [列的约束] [列的注释]
   
   )[描述][注释]
  
  建表事项
    1. 表名 列名 列类型必须填写的  表明列名和列类型是必须填写的
    2. 推荐使用if not exists   推荐使用if not exists
    3. 注释不是必须得,但是是很有必要的!  注释不是必要的，但是是很有必要的 
    4. 列之间使用,隔开,最后一列没有,  列之间使用，隔开，最后一列没有
*/
/*
2. create table [if not exist] 表名{
  列名 类型 [列的约束] [列的注释],
  */

/*
  2.2 建表实战
  建表语法总结
  场景1:
  假设你正在设计一个简单的在线图书管理系统。需要创建一个名为 book_libs 
  的数据库,你决定使用 utf8mb4 字符集，排序方式选用大小写敏感的utf8mb4_0900_as_cs。
create database book_libs character set utf8mb4 collate utf8mb4_0900_as_cs;
  use book_libs;
  场景2:
  创建一个图书表books，判断不存在再创建，并且手动设置books表字符集为utf8mb4，添加表注释内容 。
  同时图书表books中应该以下列：
      图书名称book_name列,类型为varchar(20)，添加注释。
      图书价格book_price列,类型为double(4,1)，添加注释。
      图书数量book_num列,类型为int，添加注释。
  按以上要求完成图书表的创建！
  CREATE TABLE IF NOT EXISTS books (
    book_name VARCHAR(20) COMMENT '图书名称',
    book_price DECIMAL(4,1) COMMENT '图书价格（单位：元）',
    book_num INT COMMENT '图书库存数量'
) CHARACTER SET utf8mb4 COMMENT '图书信息表';
  create table if not exists books(
    book_name varchar(20) comment '',
  book_price decimal(4,1) comment '',
  book_num int comment ''
  )character set utf8mb4 comment '';
*/

CREATE DATABASE IF NOT EXISTS book_libs CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;

USE book_libs;


CREATE TABLE IF NOT EXISTS books(
  # 列的信息
  book_name VARCHAR(20) COMMENT '图书名',
  book_price DOUBLE(4,1) COMMENT '图书价格',
  book_num INT COMMENT '图书数量'
)CHARSET = utf8mb4 COMMENT '图书表';



SHOW TABLES FROM book_libs;


/*
  2.3 建表类型[整数]
  整数类型(类型,占有空间,范围)
  
  标准sql:
     int / integer   4字节  无符号 0 - 2/32-1  有符号 -2 31 / 2 / 31 -1 
     smallint        2字节  无符号 0 - 2/16-1  有符号 -2 17 / 2 / 17 -1
  
  mysql方言:
  tiny(1) small(2) medium(3) int(4) big(8)
     tinyint         1字节  无符号 0 - 2/8 -1  有符号 -2 7 / 2/7-1
     mediumint       3字节  无符号 0 - 2/24 -1  有符号 -2 23 / 2/23-1
     bigint          8字节  无符号 0 - 2/64 -1  有符号 -2 63 / 2/63-1
     
  有符号: 列名 整数类型 -> 有符号| 有符号 有负值和正值
          列名 整数类型 unsigned -> 无符号|无符号 没有负值,都是正值,将负值部分,绝对值后,加入正值部分!
          
  注意: 选合适范围,范围合适先占有空间最小的!           
  
  创建一个ddl_d1库中,创建一个t1表,包含: 年龄和学号(范围不确定,但是没有负值)
  create database ddl_d1;
  use ddl_d1;
  create table t1(
  age tinyint comment'',
  id mediumint comment''
)comment'';
*/

CREATE TABLE t1(
   t1_age TINYINT UNSIGNED COMMENT '年龄,无符号,范围就是 0 - 255',
   t1_number BIGINT UNSIGNED COMMENT '学号,最大的,且没有负号'
)


/*
  2.4 建表类型[浮点/定值]
  浮点类型(类型,M,D)
     float(m,d)   4字节   m 24   d 8
     double(m,d)  8字节   m 53   d 30
  定值类型(类型,M,D)
     decimal(m,d) 动态占有 m 65   d 30
  使用对比:
     精度要求不高,例如:身高,体重 float / double 
     精度要求特别高,钱 工资,价格 decimal 

*/


/*
  2.5 建表类型[浮点/定值]
  浮点类型(类型,M,D)
     float(m,d)   4字节   m 24   d 8
     double(m,d)  8字节   m 53   d 30
  定值类型(类型,M,D)
     decimal(m,d) 动态占有 m 65   d 30
  使用对比:
     精度要求不高,例如:身高,体重 float / double 
     精度要求特别高,钱 工资,价格 decimal 

*/


/*
  2.6 建表类型[字符串]
  字符串类型
     char 固定长度类型 一旦声明固定占有对应的空间 M 最大255 [性能较好]
     varchar 可变长度类型 一旦声明,可以插入小于的长度,自动进行伸缩 M 占有的空间不能超过一行的最大显示65535字节 [性能一般]
     text 大文本类型,声明不要指定长度,有固定的大小限制, text [65535] , 不占有一行的最大限制空间
  细节理解
     1. char声明的时候可以不写m char = char(1)
     2. char声明了最大长度限制,输入的文本小于长度限制,会在右侧补全空格 char(5) -> 'abc' -> 'abc  '
     3. char类型在读取的时候,会自动去掉右侧的空格 'abc  ' -> 'abc'
     4. varchar声明的时候,必须添加m限制 varchar(m)
     5. mysql4.0以下版本 varchar(20) -> 20字节限制  mb3 -> 6
     6. mysql5.0以上版本 varchar(20) -> 20字符限制
     7. varchar类型中识别空格,插入空格 读取也是有空格
  演示varchar最大限制
     前提: mysql中一行数据最大的占有空间是65535字节,除了TEXT or BLOBs类型的列(不占有65535限制 法外狂徒)
           一行-> name1列 -> name1列占有的最大空间65535字节
           varchar类型默认会使用1字节标识是否为null -> 65535-1 = 65534字节
           字符集utf8mb4 1个字符 = 4个字节   65534 / 4 = 16383
  解决方案 :
     1. 缩小字符大小限制 m变小 [不合理]
     2. 可以修改字符集 [不合理]
     3. 可以将字符串类型变成TEXT,不占有一行的限制
     
*/


CREATE TABLE t1(
   name1 VARCHAR(16000),
   name2 TEXT
)CHARSET=utf8mb4;


/*
  2.7 建表类型[时间类型]
  时间类型 
     year    1 yyyy | yy   '1910' | 1910
     time    3 HH:MM:SS    '10:10:10' 
     date    3 YYYY-MM-DD  '1910-10-10'
     datetime 8 YYYY-MM-DD HH:MM:SS '1910-10-10 10:10:10'
     timestamp 4 YYYY-MM-DD HH:MM:SS '1970-10-10 10:10:10'
  注意情况
     1. year可以写两位年 00 - 99  00-69 =2000 - 2069 70 - 99 = 1970 - 1999 推荐四位的年
     2. 时间类型,要遵循他们的格式插入,插入的时候就是按字符插入,时间默认不会自动赋值
  扩展自动填写时间:
     1.插入默认添加时间
        datatime | timestamp default current_timestamp 
     2.修改默认更改时间
        datatime | timestamp default current_timestamp on update current_timestamp 
  演示: 创建t2表,
         注册日期 字段插入自动添加时间,更新数据不变
         更新日期 字段插入自动添加时间,更新数据时间改变
*/

CREATE TABLE t2(
  name1 VARCHAR(20),
  reg_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '注册日期,插入数据自动维护时间',
  up_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT  '更新日期,插入数据填写时间,更新数据自动改变时间'
)



/*
  2.8 创建表实战
  
  场景2：
  创建一个学生表(student)来存储借书的学员信息，其中应包含学生姓名、年龄、身高、生日以及注册时间和更新时间等属性。
  
  student -> 字符集 -> 默认
    姓名 -> stu_name  varchar(20)
    性别 -> stu_sex  char
    年龄 -> stu_age   tinyint unsigned
    身高 -> stu_height double(4,1)
    生日 -> stu_birthday date 
    注册 -> stu_regtime datetime default current_timestamp 
    更新 -> stu_uptime  datetime default current_timestamp on update current_timestamp 
  
*/


CREATE TABLE student(
  stu_name VARCHAR(20) COMMENT '学生姓名',
  stu_sex CHAR COMMENT '学生性别,默认一个字符',
  stu_age TINYINT UNSIGNED COMMENT '学生年龄,无符号',
  stu_height DOUBLE(4,1) COMMENT '学生身高',
  stu_birthday DATE COMMENT '学生生日',
  stu_regtime DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '注册日期',
  stu_uptime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期'
)



/*
  2.8 修改和删除表
      修改表中列
        添加列
          alter table 表名 add 列名 类型 [first|alter 列名] ;
        修改列名
          alter table 表名 change 原列名 新列名 新类型 [first|alter 列名] ;
        修改列类型
          alter table 表名 modify 列名 新类型 [first|alter 列名] ;
        删除列
          alter table 表名 drop 列名;
      修改表名
         alter table rename [to] 新表名;
      删除表
         drop table [if exists ] 表名;
      清空表数据
         truncate  table 表名;
*/


/*
  2.9 表操作实战
      要求1：创建表格employees
      要求2：将表employees的mobile字段修改到code字段后面。
      要求3：将表employees的birth字段改名为birthday;
      要求4：修改sex字段，数据类型为char（1）。
      要求5：删除字段note；
      要求6：增加字段名favoriate_activity，数据类型为varchar（100）；
      要求7：将表employees的名称修改为 employees_info

*/

CREATE TABLE  employeess(

   emp_num INT,
   last_name VARCHAR(50),
   first_name VARCHAR(50),
   mobile VARCHAR(25),
   CODE INT,
   job_time VARCHAR(50),
   birth DATE,
   note VARCHAR(255),
   sex VARCHAR(5)
)


# 要求2：将表employees的mobile字段修改到code字段后面。
ALTER TABLE employeess MODIFY mobile VARCHAR(25) AFTER CODE;

# 要求3：将表employees的birth字段改名为birthday;
ALTER TABLE employeess CHANGE birth birthday DATE;

# 要求4：修改sex字段，数据类型为char（1）。
ALTER TABLE employeess MODIFY sex CHAR(1);

DESC employeess;

# 要求5：删除字段note；
ALTER TABLE employeess DROP note;

#要求6：增加字段名favoriate_activity，数据类型为varchar（100）；
ALTER TABLE employeess ADD favoriate_activity VARCHAR(100);

#要求7：将表employees的名称修改为 employees_info
ALTER TABLE employeess RENAME employees_info;












