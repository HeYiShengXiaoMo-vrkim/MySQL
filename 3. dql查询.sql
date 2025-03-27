# 1.1 select的非常规用法 
select now(); # 输出现在的时间 
select version(); # 查询数据库版本 
select 1+1; # 进行加减法运算 
# 1.2 select查询指定表 
  # 1.2.1 查询单个表 
select Sno,Sname,Sage from student; 
  # 1.2.2 查询多个表的内容 
select lesson.*, student.Sbirth from lesson,student;
# 1.3 select查询列起别名 
select Cname as 'name', Ccredit as credit from lesson; # as可以省略
# 1.4 select去除重复行 
select distinct Cname,Ccredit from lesson;
# 1.5 select查询常数 
select '数据库' as lesson from lesson; # 无论表中原来的数据是什么，都会返回相同的常量 '数据库'