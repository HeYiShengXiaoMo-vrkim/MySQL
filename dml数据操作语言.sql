-- 1. 插入表的方式 --
# 1.1 所有的数据都插入一遍,字符串要加单引号,多个value之间要用,隔开
insert into lesson values ('male', 'charlie', 123456, 'uc'); 
# 1.2 对特定的行进行信息添加,未添加的列是默认值,可以添加空值
insert into lesson (column1, column2, column3) values ('value1', 1, null); 
# 1.3 可以一次添加多行数据,中间使用逗号隔开
insert into lesson (column1, column2, column3) values ('value1', 1, null), ('value2', 2, null); 

show tables;
desc student;
select lesson.* from lesson; 
 
-- 2. 更新表的方式 --
# 2.1 修改表部分行数据 
update student set Ssex=‘女’ where Sno=‘PRI’; # 字符串（例如性别"女"）应使用单引号括起来，否则 SQL 认为女是一个标识符。另外，条件中的 PRI 也可能需要用引号，如果它是一个字符串类型的值。
# 2.2 修改表中所有行的数据 
update student set Ssex=‘女’, Sname=`小芳`;

-- 3. 删除行的方式 -- 
# 3.1 删除所有行 
delete from student;
# 3.2 删除部分行
delete from student where Ssex=‘女’;