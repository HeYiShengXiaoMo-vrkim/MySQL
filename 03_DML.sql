# 3. 数据操作语言

/*
  3.1 数据操作语言[插入]
      语法
        全列插入[不推荐]
          insert into 表名 values | value (值,值,值...) 
          值的数量要等于表的所有列的数量
          值的类型和顺序要和表的类的类型和顺序一一对应
        指定列插入[推荐]
          insert into 表名 (列名,列名...) values | value (值,值,值...) 
          值的数量要等于表的指定的列的数量
          值的类型和顺序要和[指定列的]顺序一一对应
        多行插入
           insert into 表名 (列名,列名...) values | value (值,值,值...) ,(值,值,值...),(值,值,值...)
           insert into 表名 values | value (值,值,值...) ,(值,值,值...),(值,值,值...)
      注意
         1. values 或者 value 推荐使用values
         2. 插入的是字符串或者时间类型 ''
         3. 值的顺序和类型要和表的列名或者指定的列名一一对应     
      练习
        # 1.插入一名学生的所有信息，包括学号、名字、年龄、生日和身高。
        # 2.插入一名学生的学号、名字、年龄，其他列使用默认值。
        # 3.插入两名学生的信息，包括学号、名字、年龄、生日和身高。
        # 4.插入一名学生的信息，只提供学号、名字和年龄，其他列为空值。

*/
#创建数据库dml_d1 create database ifnot exists dml_dl;
CREATE DATABASE IF NOT EXISTS dml_d1;
#指定使用数据库 use dml_dl;
USE dml_d1;
create table students(
  stu_id int comment'',
  stu_name varchar(20) comment'',
  stu_age tinyint unsigned comment'',
  stu_birthday date comment '',
  stu_height decimal(4,1) default 200 comment''
);
CREATE TABLE students ( 
      stu_id INT COMMENT '学号', 
      stu_name VARCHAR(100) COMMENT '姓名', 
      stu_age TINYINT UNSIGNED COMMENT '年龄', 
      stu_birthday DATE COMMENT '生日', 
      stu_height DECIMAL(4, 1) DEFAULT 200 COMMENT '身高，保留一位小数'
);

# 1.插入一名学生的所有信息，包括学号、名字、年龄、生日和身高。
  /* 
  insert into students values
  */
INSERT INTO students VALUES (1,'二狗子',18,'1990-06-06',185.5); 
INSERT INTO students(stu_name,stu_age,stu_birthday,stu_height,stu_id) VALUES ('二狗子',18,'1990-06-06',185.5,2);
# 2.插入一名学生的学号、名字、年龄，其他列使用默认值。  insert into 表名(列名称) values (填充值)
INSERT INTO students (stu_id,stu_name,stu_age) VALUES (3,'驴蛋蛋',29);
# 3.插入两名学生的信息，包括学号、名字、年龄、生日和身高。 insert into students values (全填完),(全填完)
INSERT INTO students VALUES (4,'狗剩子',20,'2020-02-20',223.5),(5,'石头子',18,'2020-02-20',223.5);
# 4.插入一名学生的信息，只提供学号、名字和年龄，其他列为空值。 对于空值我们可以使用null填充
INSERT INTO students(stu_id,stu_name,stu_age,stu_birthday,stu_height) VALUES 
        (6,'小笨蛋',20,NULL,NULL);



/*
  3.2 数据操作语言[修改]
      语法
        全表修改(全行修改)
          update 表名 set 列名 = 新值 , 列名 = 值 , 列名 = 值 ...
        条件修改(条件筛选行) 
          update 表名 set 列名 = 新值 , 列名 = 值 , 列名 = 值 ... where 条件
      注意
        1. 不添加where,代表修改一个表中的所有行的数据,反之,只修改符合where条件的
        2. 如果修改多个列 set 列名 = 值 , 列名 = 值 
      练习
       # 1.将学号为8的学生的姓名改为'黄六'。
       # 2.将年龄小于20岁的学生的身高增加2.0。
       # 3.将学号为11的学生的生日修改为'2003-07-10',且年龄改成21。
       # 4.将所有学生的年龄减少1岁。

*/

# 插入学生数据准备数据
INSERT INTO students (stu_id, stu_name, stu_age, stu_birthday, stu_height) # 小括号里面填名称
VALUES
    (6, '张三', 21, '2002-05-10', 175.5),
    (7, '李四', 20, '2003-02-15', 168.0),
    (8, '王五', 22, '2001-09-20', 180.2),
    (9, '赵六', 19, '2004-03-08', 165.8),
    (10, '钱七', 23, '2000-12-01', 172.3),
    (11, '孙八', 20, '2003-06-25', 160.5),
    (12, '周九', 21, '2002-11-18', 175.0),
    (13, '吴十', 22, '2001-04-30', 168.7),
    (14, '郑十一', 19, '2004-08-12', 185.5),
    (15, '王十二', 23, '2000-07-05', 170.1);

# 1.将学号为8的学生的姓名改为'黄六'。 update students set stu_name = '黄流' where stu_id = 8;
UPDATE students SET stu_name = '黄六' WHERE stu_id = 8;
# 2.将年龄小于20岁的学生的身高增加2.0 (原有基础上添加2.0 )。 update students set stu_height = stu_height + 2 where stu_age < 20;
UPDATE students SET stu_height = stu_height + 2 WHERE stu_age < 20; # - * / 可以使用原列进行运算
# 3.将学号为11的学生的生日修改为'2003-07-10',且年龄改成21。update students set stu_birthday = '2003-01-10', stu_age=21 where stu_birthday = '2003-01-10'
UPDATE students SET stu_birthday = '2003-07-10' , stu_age = 21 WHERE stu_id = 11;
# 4.将所有学生的年龄增加1岁。update students set stu_age = stu_age + 1;  update students set stu_age = stu_age + 1; 
UPDATE students SET stu_age = stu_age + 1 ;


/*
  3.3 数据操作语言[删除]
      语法
       全表删除 
         delete from  表名;
       条件行删除 
         delete from  表名 where 条件;
      注意
        1. 开发中很少使用全表删除
        2. delete删除和清空表truncate 删除,都会删除表中的全部数据,truncate 不仅删除表数据,会删除数据库id的最大记录值!
      练习
        # 1.将年龄大于23的学员移除。
delete from students where stu_age> 23;
        # 2.将身高高于200且学号大于10的数据移除
delete from students where height>200 and id>10;
        # 3.将身高高于200或学号大于10的数据移除
delete from students where height>200 or id >10;
        # 4.将所有学生数据移除
delete from students;

*/

# 1.将年龄大于23的学员移除。
DELETE FROM students WHERE stu_age > 23;
# 2.将身高高于200且学号大于10的数据移除
DELETE FROM students WHERE  stu_height > 200 AND stu_id > 10;
# 3.将身高高于200或学号大于10的数据移除
DELETE FROM students WHERE  stu_height > 200 OR stu_id > 10;
# 4.将所有学生数据移除
DELETE FROM students;
