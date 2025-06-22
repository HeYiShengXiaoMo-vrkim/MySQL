-- 2.1 not null 列约束
create table emp1(
  e_name varchar(20) not null,
  e_age int
)
desc emp1; -- 展示信息
## 创建表以后修改
alter table emp1 modify e_age int not null; 
## 删除非空约束
alter table emp1 modify e_name varchar(20);
alter table emp1 modify e_age int null; 

-- 2.2 默认值约束
# 无法加到主键或者唯一上，其他都可以，插入数据不给赋值显示默认值
create table emp2(
  name varchar(20) defalt 'zhang san',
  age int not null
  )
alter table emp2 modify age int default 18 not null;
# 输入数据
insert into emp2 (name) values ('zhang san') 
select * from emp2; 
# 删除默认值约束
alter table emp2 modify name varchar(20);

-- 2.3 检查约束
-- (限制检查某个条件是否满足某个范围,check(表达式)自定义约束类型)
-- alter table 表名 add constraint 约束名 check (表达式)
-- 检查约束属于表级别的约束，但是限制列,mysql8+新特性，万能约束
create table emp3(
  -- 性别必须男或者女，年龄必须大于十八
  gender char,
  check (gender in ('男','女')),
  age int
  )
  -- 查看约束类型
  desc emp3;
  from information schema,table_constriants
  where table_schema = 'test05_constriant'
  and table_name = 'emp3';

alter table emp3 add constraint age_check (age > 18); -- 添加限制约束add constraint 
alter table emp3 drop constraint emp3_chk_1; -- 删除约束,使用上面的那个代码查看约束后再删除
-- 3.1 唯一约束
-- (限定某个字段，表中数据唯一,可以为空,同一个表可以有多个唯一约束,唯一约束可以组合（列1，列2）-> unique)
-- 3.1.1 创建约束
create table emp4(
  name varchar(20),
  class int,
  phone varchar(11), 
  unique key(phone,class)
);
-- 查看约束类型
  desc emp3;
  from information schema,table_constriants
  where table_schema = 'test05_constriant'
  and table_name = 'emp3';
-- 3.1.2修改
desc emp7
alter table 表名 add constraint constraint_name(列名,列名); 
-- 3.1.3删除约束
alter table emp7 drop constraint emp7_name; # 要使用上面的查看代码查看约束类型

-- 3.2 主键的概念
-- 表中数据至少有一列是不重复的，避免整行数据不重复，主键列
-- 分类 1.自定义主键（人为创建的，使命就是不重复） 2.自然主键（不死人为创造的，但是自然环境下就是不重复的）
-- 主键列：针对主键列的数据约束和限制，确保主键列不会出现错误
-- 3.2.1 添加
create table 表名称(
    字段名 数据类型 primary key
    e_id int primary key
    primary key (e_id, e_name)
  )
-- 3.2.2 创建
alter table emp8 add primary key (e_id) 
-- 3.2.3 删除
alter table epm8 drop primary key; # 不需要写主键约束的名，一个表只有一个主键约束
-- 3.3 自增长约束
-- 限定某个整数类字段，插入数据不需要维护，值自动增长
-- auto_increment 关键字，自增长字段设置0或者null，列数据会自增长
-- 添加的位置只能是主键和唯一列，每个表只能添加一个自己增长的约束，只能是整数类型，插入不指定列或者0，null就会自增长，可以插入你对应的值
create table 表名称(
  字段名 数据类型 primary key auto-increment 
  e_id int primary key auto_increment,
  e_name varchar(20)
)
desc emp9;

-- 修改
alter table emp10 modify e_id int auto_increment;
-- 删除
alter table emp10 modify e_id int; -- 只要进行更改，然后内容发生变化就行了
insert into emp9 (e_name) values ("ergozi"),("lvdandan"); -- 不指定的情况下进行增长
insert into emp9 (e_id, e_name) values (10, 'xiaoui'); -- 插入会记当前的最大值，不管中间缺失如何，都会按照最大值进行增长，中间不会回退

-- 4.1 外键约束
-- 引用或者参照其他表主键列，我们称为外键，外键的值范围应当对应引用主键的范围
-- 外键约束：外键应该引用主键的值，如果不添加约束，可能会出现错误数据
-- 每个表可以包含多个外键，外键是跨表引用其他表的主键，外键可是任何类型，关系型数据库，关系就是主外建关系，存在主外键关系，删除主表数据时，可能会因为子表引用而删除失败，可以先删除子表的所有引用数据之后再删除
-- 外键没有外键约束也是外键，最好添加外键约束 
create table 主表名称(
  字段1 数据类型 primary key
);
# 子表中添加主外键约束
create table 子表名称(
  字段1 数据类型 primary key
  [constraint<外键约束名称>] foreign key(外键) references 主表名(主键) [on update xx][on delete xx]
);
-- 4.1.1 创建约束
create table student(
  sid int primary key auto_increment,
  sname varchar(20)
); # 表一
create table score1(
  cid int primary key auto_increment,
  number int,
  sid int,
  constraint s_s_1_kf foreign key (sid) references student1(sid)
); # 表二

-- 4.1.2 删除约束
# 1. 删除约束
alter table score2 drop foreign key s_s_2_kf;
# 2. 删除外键索引
show index from score2;
alter table score2 drop index s_s_2_kf;
-- 4.2 外键约束等级设计
cascade 在父表上update/delete记录时候，同步update/delete子表的匹配记录
set full 在父表上update/delete记录时，将子表上匹配记录的列设为null,但是要注意子表的外键列不为not null
no action如果子表中有匹配的记录，则不允许对父表对应候选键进行update/delete操作
restrict[默认] 同no action,都是立即检查外键约束
set default父表有变更时，子表将外键列设置成一个默认的值，但innoda不能识别
最好是采用on update cascade on delete restrict的方式
