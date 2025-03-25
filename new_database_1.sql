select version(); # 展示数据库版本
create database new_dataBae;  # 默认方式创建数据库
use new_database_1; # 跳转到当前的数据库
create database if not exists new_dataBase_for_practice character set utf8mb4 collate utf8mb4_0900_as_cs;
show variables like 'character_set_database'; # 展示字符处理规则
show variables like 'collation_database'; # 展示排序规则
create table if not exists new_table(
	name varchar(20),
    age char(3) comment 'the age of this people',
    id smallint comment 'the id number of this person'
)character set utf8mb4 collate utf8mb4_0900_ai_ci; # create a table for this database
show databases; # 展示当前所有数据库
select database(); # 展示当前所有库
show tables from educ_刘家旺; # 展示这个数据库里所有的表 
show create database educ_刘家旺; # 创建库信息 
