-- 1. 平时进行管理的操作 --
select version(); # 展示数据库版本
show variables like 'character_set_database'; # 展示字符处理规则
show variables like 'collation_database'; # 展示排序规则
alter database educ_manage character set gbk; # 修改解码方式 
alter database educ_manage collate utf8mb4_0900_ai_ci; # 修改排序规则 
desc lesson; # 展示表结构 
show tables; # 展示所有表 


-- 2. 创建数据库的操作 -- 
create database new_dataBae;  # 默认方式创建数据库
use new_database_1; # 跳转到当前的数据库
create database if not exists new_dataBase_for_practice character set utf8mb4 collate utf8mb4_0900_as_cs;
show databases; # 展示当前所有数据库
show create database educ_manage; # 创建库信息 
alter database educ_manage character set utf8 collate utf8mb4_as_ci; # 同时修改排序规则和解码方式 

-- 3. 创建表的方式 -- 
select database(); # 展示当前所有库

create table if not exists new_table(
	name varchar(20),
    age tinyint default 20 comment 'the age of this people', # 添加默认值20岁
    id smallint comment 'the id number of this person' # 添加注释 
)character set utf8mb4 collate utf8mb4_0900_ai_ci; # create a table for this database;

show tables from educ_manage; # 展示这个数据库里所有的表 

-- 4. 删库跑路的方式 -- 
/* drop database educ_manage  drop database if exists educ_manage 多种多样的删库跑路方式 */
drop database `you're fired`; # 对于这种有空格有单引号的非标准库可以使用反引号将其扩起来

-- 5. 修改表的方式 -- 
alter table course add computer_science_score tinyint; # [first/after字段名] 在字段/末尾加上一行并给定名称类型 
alter table course change computer_science_score cs_score tinyint; # [first/after字段名] 给computer_science_score改名为cs_score 
alter table course rename lesson; # 将course改名为lesson
# alter table course drop cs_score 删除表中的某个字段
alter table course modify cs_score int; # [first/after字段名] 修改列的数据类型 
/* alter table course modify cs_score int after code 将cs_score列放到code列的后面 */ 

-- 6. 删除表的方式 -- 
/* truncate table course 清空表的数据，但是保留表的结构 */
/* drop table if exists course, id, code; 全部删除不留一丝痕迹 */