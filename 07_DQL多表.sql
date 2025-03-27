# 一、准备表数据
-- 创建库
CREATE DATABASE IF NOT EXISTS test07_multidql;
USE test07_multidql;


# 二、合并结果集（垂直）
/*
   语法:
       union  #去重复行合并
       union all  #不去重复合并
   作用:
       将多个结果集,垂直拼接,统一返回
       汇总返回
   注意:
       合并的多个结果集之间的列数和类型要一一对应
       合并结果集,是垂直数据合并,数据行之间不会有关联,不要求合并的结果表存在主外键关系
       重复行,一行中的所有数据都重复

*/
# 演示:
# 准备数据
CREATE TABLE a(
   aid INT,
   aname VARCHAR(10)
);

CREATE TABLE b(
   bid INT,
   bname VARCHAR(10)
);


INSERT INTO a VALUES(1,'aaaa'),(2,'bbbb'),(3,'cccc');
INSERT INTO b VALUES(4,'aaaa'),(2,'bbbb'),(3,'cccc');

# 去重复合并 [将a和b的数据去重复合并成一个结果集]

SELECT aid ,aname FROM a
UNION
SELECT bid ,bname FROM b
UNION 
SELECT bid ,bname FROM b;

# 不去重复合并

SELECT aid ,aname FROM a
UNION ALL
SELECT bid ,bname FROM b
UNION ALL
SELECT bid ,bname FROM b;



# 三、多表连接查询（水平）

# 准备数据 【部门表，员工表，职位表】
DROP TABLE IF EXISTS `t_department`;

CREATE TABLE `t_department` (
  `did` INT NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `dname` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `description` VARCHAR(200) DEFAULT NULL COMMENT '部门简介',
  PRIMARY KEY (`did`),
  UNIQUE KEY `dname` (`dname`)
);

/*Data for the table `t_department` */
INSERT  INTO `t_department`(`did`,`dname`,`description`) 
VALUES (1,'研发部','负责研发工作'),
(2,'人事部','负责人事管理工作'),
(3,'市场部','负责市场推广工作'),
(4,'财务部','负责财务管理工作'),
(5,'后勤部','负责后勤保障工作'),
(6,'测试部','负责测试工作');


/*Table structure for table `t_job` */

DROP TABLE IF EXISTS `t_job`;

CREATE TABLE `t_job` (
  `jid` INT NOT NULL AUTO_INCREMENT COMMENT '职位编号',
  `jname` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '职位名称',
  `description` VARCHAR(200) DEFAULT NULL COMMENT '职位简介',
  PRIMARY KEY (`jid`),
  UNIQUE KEY `jname` (`jname`)
);


/*Data for the table `t_job` */
INSERT  INTO `t_job`(`jid`,`jname`,`description`) 
VALUES (1,'技术总监','负责技术指导工作'),
(2,'项目经理','负责项目管理工作'),
(3,'程序员','负责开发工作'),
(4,'测试员','负责测试工作'),
(5,'人事主管','负责人事管理管理'),
(6,'人事专员','负责人事招聘工作'),
(7,'运营主管','负责市场运营管理工作'),
(8,'市场员','负责市场推广工作'),
(9,'财务主管','负责财务工作'),
(10,'出纳','负责出纳工作'),
(11,'后勤主管','负责后勤管理工作'),
(12,'网络管理员','负责网络管理');



/*Table structure for table `t_employee` */

DROP TABLE IF EXISTS `t_employee`;

CREATE TABLE `t_employee` (
  `eid` INT PRIMARY KEY  AUTO_INCREMENT COMMENT '员工编号',
  `ename` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '员工姓名',
  `salary` DOUBLE NOT NULL COMMENT '薪资',
  `commission_pct` DECIMAL(3,2) DEFAULT NULL COMMENT '奖金比例',
  `birthday` DATE NOT NULL COMMENT '出生日期',
  `gender` ENUM('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `tel` CHAR(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号码',
  `email` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `address` VARCHAR(150) DEFAULT NULL COMMENT '地址',
  `work_place` SET('北京','深圳','上海','武汉') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '北京' COMMENT '工作地点',
  `hiredate` DATE NOT NULL COMMENT '入职日期',
  `job_id` INT DEFAULT NULL COMMENT '职位编号',
  `mid` INT DEFAULT NULL COMMENT '领导编号',
  `did` INT DEFAULT NULL COMMENT '部门编号'
);

/*Data for the table `t_employee` */

INSERT  INTO `t_employee`(`eid`,`ename`,`salary`,`commission_pct`,`birthday`,`gender`,`tel`,`email`,`address`,`work_place`,`hiredate`,`job_id`,`mid`,`did`) 
VALUES (1,'孙洪亮',28000,'0.65','1980-10-08','男','13789098765','shl@atguigu.com','白庙村西街','北京,深圳','2011-07-28',1,1,1),
(2,'何进',7001,'0.10','1984-08-03','男','13456732145','hj@atguigu.com','半截塔存','深圳,上海','2015-07-03',2,1,1),
(3,'邓超远',8000,NULL,'1985-04-09','男','18678973456','dcy666@atguigu.com','宏福苑','北京,深圳,上海,武汉','2014-07-01',3,7,1),
(4,'黄熙萌',9456,NULL,'1986-09-07','女','13609876789','hxm@atguigu.com','白庙村东街','深圳,上海,武汉','2015-08-08',8,22,3),
(5,'陈浩',8567,NULL,'1978-08-02','男','13409876545','ch888@atguigu.com','回龙观','北京,深圳,上海','2015-01-01',3,7,1),
(6,'韩庚年',12000,NULL,'1985-04-03','男','18945678986','hgn@atguigu.com','龙泽','深圳,上海','2015-02-02',3,2,1),
(7,'贾宝玉',15700,'0.24','1982-08-02','男','15490876789','jby@atguigu.com','霍营','北京,武汉','2015-03-03',2,1,1),
(8,'李晨熙',9000,'0.40','1983-03-02','女','13587689098','lc@atguigu.com','东三旗','深圳,上海,武汉','2015-01-06',4,1,1),
(9,'李易峰',7897,NULL,'1984-09-01','男','13467676789','lyf@atguigu.com','西山旗','武汉','2015-04-01',3,7,1),
(10,'陆风',8789,NULL,'1989-04-02','男','13689876789','lf@atguigu.com','天通苑一区','北京','2014-09-03',2,1,1),
(11,'黄冰茹',15678,NULL,'1983-05-07','女','13787876565','hbr@atguigu.com','立水桥','深圳','2014-04-04',4,1,1),
(12,'孙红梅',9000,NULL,'1986-04-02','女','13576234554','shm@atguigu.com','立城苑','上海','2014-02-08',3,7,1),
(13,'李冰冰',18760,NULL,'1987-04-09','女','13790909887','lbb@atguigu.com','王府温馨公寓','北京','2015-06-07',3,2,1),
(14,'谢吉娜',18978,'0.25','1990-01-01','女','13234543245','xjn@atguigu.com','园中园','上海,武汉','2015-09-05',5,14,2),
(15,'董吉祥',8978,NULL,'1987-05-05','男','13876544333','djx@atguigu.com','小辛庄','北京,上海','2015-08-04',6,14,2),
(16,'彭超越',9878,NULL,'1988-03-06','男','18264578930','pcy@atguigu.com','西二旗','深圳,武汉','2015-03-06',8,22,3),
(17,'李诗雨',9000,NULL,'1990-08-09','女','18567899098','lsy@atguigu.com','清河','北京,深圳,武汉','2013-06-09',8,22,3),
(18,'舒淇格',16788,'0.10','1978-09-04','女','18654565634','sqg@atguigu.com','名流花园','北京,深圳,武汉','2013-04-05',9,18,4),
(19,'周旭飞',7876,NULL,'1988-06-13','女','13589893434','sxf@atguigu.com','小汤山','北京,深圳','2014-04-07',10,18,4),
(20,'章嘉怡',15099,'0.10','1989-12-11','女','15634238979','zjy@atguigu.com','望都家园','北京','2015-08-04',11,20,5),
(21,'白露',9787,NULL,'1989-09-04','女','18909876789','bl@atguigu.com','西湖新村','上海','2014-06-05',12,20,5),
(22,'刘烨',13099,'0.32','1990-11-09','男','18890980989','ly@atguigu.com','多彩公寓','北京,上海','2016-08-09',7,22,3),
(23,'陈纲',13090,NULL,'1990-02-04','男','18712345632','cg@atguigu.com','天通苑二区','深圳','2016-05-09',3,2,1),
(24,'吉日格勒',10289,NULL,'1990-04-01','男','17290876543','jrgl@163.com','北苑','北京','2017-02-06',12,20,5),
(25,'额日古那',9087,NULL,'1989-08-01','女','18709675645','ergn@atguigu.com','望京','北京,上海','2017-09-01',3,2,1),
(26,'李红',5000,NULL,'1995-02-15','女','15985759663','lihong@atguigu.com','冠雅苑','北京','2021-09-01',12,23,1),
(27,'周洲',8000,NULL,'1990-01-01','男','13574528569','zhouzhou@atguigu.com','冠华苑','北京,深圳','2020-08-15',3,NULL,NULL);



# 3.1 内连接查询
/*
   语法:
       select 列 from 表1 as 别名 [inner] join 表2 别名 on 表1别名.主键 = 表2别名.外键;
       select 列 from 表1 as 别名, 表2 别名 where 表1别名.主键 = 表2别名.外键;
   作用:
       可以将多个表的数据行,正确的水平拼接到一个结果集中
       例如: 查询学生和学生对应分数...
       内连接查询到的结果要求[[两个表中必须存在相同的主外键]]! 没有周州
   注意:
       以上两种语法效果相同,但是推荐 inner join系列 [标准]
       为了避免错误数据行连接(笛卡尔积,连接查询,就是将多有行都水平拼接一遍),我们需要添加主外键相等
       多表中可能存在相同的列名,建议对列操作的时候使用: 表名.列名 | 表的别名.列名
       表可以在from后面起别名 表 as 别名 表 别名
       
*/

# 情景1: 基础语法和笛卡尔积 [不添加主外键相等,连接查询的实现原理]
# 查询[[员工编号、姓名以及所属部门的编号 ]]和[[部门名称]] -> 多表查询 -> 水平多表查询 -> 关系
# 标准语法  表1 别名 [inner] join 表2 别名 on 主 = 外
SELECT e.eid , e.ename, e.did , d.did , d.dname FROM t_employee e INNER JOIN t_department d;
SELECT COUNT(1) FROM t_employee e INNER JOIN t_department d; # 员工27 | 部门 6 = 162条
# 连接查询,就是将所有的行,都给你拼接一遍,拼成成单表! (笛卡尔积 | 连接查询的原理)
# 非标准语法  表1 别名 , 表2 别名 where 主 = 外
SELECT e.eid , e.ename, e.did , d.did , d.dname FROM t_employee e,t_department d;


# 情景2: 主外键条件和正确连接 
# 查询员工编号、姓名以及所属部门的编号和部门名称
SELECT e.eid , e.ename, e.did , d.did , d.dname FROM t_employee e 
                                                  INNER JOIN t_department d  ON e.did = d.did;
SELECT e.eid , e.ename, e.did , d.did , d.dname FROM 
                                                  t_employee e,t_department d WHERE e.did = d.did;    
# 获取正确数据,需要添加主外键相等条件 (唯一的要求)
# join标准语法 on 添加主外键
# 非标准语法 表1,表2  where 添加主外键相等即可                                                                                               

# 情景3: 标准inner join语法优化 
# 查询员工编号、姓名以及所属部门的编号和部门名称
# 27个员工 | 周州(27) did -> null没有部门
SELECT e.eid , e.ename, e.did , d.did , d.dname FROM t_employee e 
                                                   JOIN t_department d  ON e.did = d.did;

# inner join  == join == 内连接


# 情景4: 添加额外的条件筛选
# 查询员工编号大于10的[员工编号、姓名以及所属部门的编号和部门名称]
SELECT e.eid , e.ename, e.did , d.did , d.dname FROM t_employee e 
                                                  INNER JOIN t_department d  ON e.did = d.did
                                                  WHERE e.eid > 10;                                                  
                                                  
SELECT e.eid , e.ename, e.did , d.did , d.dname FROM 
                                                  t_employee e,t_department d 
                                                  WHERE e.did = d.did AND  e.eid > 10; 

# 如果有额外的条件(非主外键相等) 两种都正常添加where即可! 添加条件
# 理解: 多表查询 -> 表结果进行拼接 -> 依然正常使用查询语法


# 情景5: 多表(3+)查询并且添加额外的条件筛选
# 查询员工编号大于10的   员工编号、姓名以及所属部门的编号和部门名称,岗位名称
# 员工和部门 | 员工和岗位
# 多表查询就是一个伪命题! 多个两表查询! 
# 2张表 1个两表查询
# 3张彪 2个两表查询

SELECT e.eid , e.ename , e.did , d.did , d.dname , e.job_id , j.jname FROM t_employee e 
                                                INNER JOIN t_department d ON e.did = d.did
                                                INNER JOIN t_job j ON e.job_id = j.jid
                                                WHERE e.eid > 10;
SELECT e.eid , e.ename , e.did , d.did , d.dname , e.job_id , j.jname 
                                                FROM t_employee e , t_department d ,t_job j 
                                                WHERE e.did = d.did AND e.job_id = j.jid AND e.eid > 10;
/*
  1. 有三张表至少有两对主外键相等条件 and 
  2. 有N张表,至少有N-1对主外键相等条件 and
  3. 语法
     标准
     表1 INNER JOIN 表2 ON 主=外
         INNER JOIN 表3 ON 主=外
         INNER JOIN 表4 ON 主=外 ..
         where 其他的条件
     非标准
     from 表1 , 表2 ,表3 .... 表n where (n-1对的) 主外键相等and | 其他条件继续添加即可and 其他条件即可       
 
*/






# 3.2 外连接查询
/*
   语法:
       表1 别名 left | right [outer] join 表2 别名 on 主 = 外键
   作用:
       连接的作用和内连接一致
       外连接可以通过left或者right指定一个逻辑主表,逻辑主表的数据一定会显示全
   注意:
       内连接-> 必须存在主外键 主外键相等
       外连接-> 指定一个逻辑主表,一定会显示全
       外连接的outer可以省略  left join = left outer join 
       经验: 如果有逻辑主表,就将逻辑主表放在第一位, 后面全部是左外连接
*/


# 情景1: 基础语法和笛卡尔积 [外连接错误语法]
# 查询[所有]员工编号、姓名以及所属部门的编号和部门名称
# 注意:外连接必须添加主外键相等 错误代码： 1064
SELECT e.eid,e.ename, IFNULL(d.dname,'暂时未分配') FROM t_employee e  LEFT JOIN t_department d  ON e.did = d.did;
SELECT e.eid,e.ename, IFNULL(d.dname,'暂时未分配') FROM t_department d  RIGHT JOIN  t_employee e  ON e.did = d.did;

# 情景2: 主外键条件和正确连接 [正确语法] 
# 查询所有员工编号、姓名以及所属部门的编号和部门名称
SELECT e.eid,e.ename, IFNULL(d.dname,'暂时未分配') FROM t_department d  RIGHT JOIN  t_employee e  ON e.did = d.did;


# 情景3: 添加额外的条件筛选 
# 查询员工编号大于10的员工编号、姓名以及所属部门的编号和部门名称
SELECT e.eid,e.ename, IFNULL(d.dname,'暂时未分配') FROM t_department d  RIGHT JOIN  t_employee e  ON e.did = d.did
                                                   WHERE e.eid > 10;

# 情景4: 多表(3+)查询并且添加额外的条件筛选 
# 查询员工编号大于10的员工编号、姓名以及所属部门的编号和部门名称,岗位名称
# 先找到逻辑主表,把逻辑主表放在第一位,后续都是left join 
SELECT e.eid,e.ename, IFNULL(d.dname,'暂时未分配') , j.jname FROM t_employee e 
                                                        LEFT JOIN  t_department d   ON e.did = d.did
                                                        LEFT JOIN  t_job j ON e.job_id = j.jid
                                                   WHERE e.eid > 10;


# 3.3 自然连接查询
/*
   语法:
       natural join 自然内连接
       natural left | right join 自然外连接
   作用:
       可以达到内外连接的效果
       自动查找主外键相等(找到列名相同判定相等,两个表只有主外键命名相同)
       省略了on 主 = 外
   注意:
	自然连接 = 外连接 + 内连接的效果 [不太稳妥,如果其他列命名相同,也会判定等于出现错误数据]
	natural left | right join using(主外键列名)
*/
# 情景1: 自然内连接使用
# 查询所有有部门的员工编号、姓名以及所属部门的编号和部门名称
SELECT e.eid , e.ename , e.did , d.dname FROM t_employee e NATURAL JOIN t_department d; #省略了on
SELECT e.eid , e.ename , e.job_id , j.jname FROM t_employee e NATURAL JOIN t_job j; #省略了on 主外键命名不同

# 情景2: 自然外连接使用 
# 查询所有员工编号、姓名以及所属部门的编号和部门名称

SELECT e.eid , e.ename , e.did , d.dname FROM t_employee e NATURAL LEFT JOIN t_department d;


SELECT e.eid , e.ename , e.mid FROM t_employee e 


# 3.4 自连接查询
/*
   语法:
      自连接不是新的语法
      自连接是一种特殊的使用场景[同一个表连接多次查询多表数据]
   作用:
      自连接->查询的代码结构-> 以后的自连接场景->固定的代码结构
   注意:
      一个表中的数据引用一个表中令一行数据
      自连接依然使用内外自然连接实现
      自连接 != 自然连接
*/
# 情景1: 两次复用自连接
# 查询编号等于5号员工的编号,姓名,领导编号,领导姓名

SELECT e1.eid , e1.ename , e1.mid , e2.ename  FROM t_employee e1 LEFT JOIN t_employee e2 ON e1.mid = e2.eid 
                                                                 WHERE e1.eid = 5;

# 情景2: 多次复用自连接 
#查询编号等于5号员工的编号,姓名,领导编号,领导姓名 ,以及领导的领导编号和姓名

SELECT e1.eid , e1.ename , e1.mid , e2.ename , e2.mid , e3.ename  FROM t_employee e1 LEFT JOIN t_employee e2 ON e1.mid = e2.eid 
                                                                 LEFT JOIN t_employee e3 ON e2.mid = e3.eid 
                                                                 WHERE e1.eid = 5;



# 3.5 连接查询练习
# 力扣181题:  超过经理收入的员工











# 四、子查询（嵌套）

# 4.1 子查询介绍
/*
  概念:
     一个sql语句嵌套了另一个或者多个查询语句
  语法:
     子查询的结果
      标量子查询: 返回结果是一行一列,单个值,一般用于条件判定
      行子子查询: 返回结果是一行多列,一般用于或者插入数据的值,或者整体对比
      列子子查询: 返回结果是多行单列,一般用于条件对比,需要配合in any all等关键字
      表子子查询: 返回结果是多行多列,不能用于条件,一般用于查询的虚拟的中间表
*/


# 4.2 select嵌套子查询

# 4.2.1 标量子查询(单行单列) : 用于值 更新的值,插入的值,查询条件的值等等...
# 1.1 查询研发部门的所有员工信息 [间接条件]
# 查询研发部门的员工信息: 条件是研发部门 | 查询结果员工信息
# 步骤1: 根据部门名称查询部门的id
SELECT did FROM t_department WHERE dname = '研发部';
# 步骤2: 根据部门的id查询员工的集合
SELECT * FROM t_employee WHERE did = (  SELECT did FROM t_department WHERE dname = '研发部' );

# 1.2 查询每个部门的平均工资和公司的平均工资差
# 查询公司的平均工资
SELECT AVG(salary) FROM t_employee ;


# 查询每个部门的平均工资 [分组查询]
# 分组 分组字段和聚合函数
SELECT did , AVG(salary) , AVG(salary) - (SELECT AVG(salary) FROM t_employee) FROM t_employee GROUP BY did;




# 4.2.2 行子子查询(单行多列)
# 1.1 查询和白露性别和部门相同信息的员工

# 步骤1: 查询白露的性别和部门
SELECT gender , did FROM t_employee WHERE ename = '白露';
# 步骤2: 查询和白露信息相同的其他员工
SELECT * FROM t_employee WHERE (gender,did) = (SELECT gender , did FROM t_employee WHERE ename = '白露')
# gender = 子查询的gender and did = 子查询的did
SELECT * FROM t_employee WHERE (gender,did) IN (SELECT gender , did FROM t_employee WHERE ename = '白露')
# 行子子查询: 单行和多列,一般都是整体比较  (多列) in = (行子结果)


# 行子(单行多列) 拆分成多个标量子查询 (如干个单值)
SELECT gender FROM t_employee WHERE ename = '白露';
SELECT did FROM t_employee WHERE ename = '白露';

SELECT * FROM t_employee WHERE  gender = (SELECT gender FROM t_employee WHERE ename = '白露')
                                AND
                                did = (SELECT did FROM t_employee WHERE ename = '白露');



# 4.2.3 列子子查询(多行单列)
# 1.1 查询和“白露”，“谢吉娜”同一部门的员工姓名和电话。
# 步骤1: “白露”，“谢吉娜”所属部门did 
SELECT did FROM t_employee WHERE ename = '谢吉娜' OR ename = '白露'
SELECT did FROM t_employee WHERE ename IN ('谢吉娜' ,'白露')
# 步骤2: 查询2和5部门的员工信息  2 5 -> in
SELECT * FROM t_employee WHERE did IN (SELECT did FROM t_employee WHERE ename IN ('谢吉娜' ,'白露'))
SELECT * FROM t_employee WHERE did  NOT IN (SELECT did FROM t_employee WHERE ename IN ('谢吉娜' ,'白露'))
# 列子子查询还可以使用 any 任意一个值 ==  in  || all 是两个值  = and
SELECT * FROM t_employee WHERE did = ANY(SELECT did FROM t_employee WHERE ename IN ('谢吉娜' ,'白露'))

# 1.2 查询薪资比“白露”，“李诗雨”，“黄冰茹”三个人的薪资都要高的员工姓名和薪资

#步骤1: 查询他们三的工资
SELECT salary FROM t_employee WHERE ename IN ('李诗雨' ,'白露','黄冰茹')
#步骤2: 查询大于他们所有的 any all
SELECT * FROM t_employee WHERE salary > ALL(SELECT salary FROM t_employee WHERE ename IN ('李诗雨' ,'白露','黄冰茹'))



SELECT MAX(salary) FROM t_employee WHERE ename IN ('李诗雨' ,'白露','黄冰茹')
SELECT * FROM t_employee WHERE salary > (SELECT MAX(salary) FROM t_employee WHERE ename IN ('李诗雨' ,'白露','黄冰茹'))




# 4.2.4 表子子查询(多行单列)
#1.1 查询所有部门的 [[部门编号、部门名称]](部门表) + 连接查询(水平)+ [[部门平均薪资]] (员工表+分组查询)
# 步骤1:查询部门的平均工资 员工表 +分组
SELECT did , AVG(salary) avs FROM t_employee GROUP BY did;

# 步骤2: 查询部门的信息和平均工资
SELECT d.did,d.dname,temp.avs FROM t_department d  LEFT JOIN 
                                 (SELECT did , AVG(salary) avs FROM t_employee GROUP BY did) AS temp
                                  ON d.did = temp.did;



# 课后作业
# 1.1 显示部门平均工资比全公司的总平均工资高的部门编号、部门名称、部门平均薪资，
#并按照部门平均薪资升序排列。



# 4.3 update嵌套子查询
# 1.1 将“测试部”部门的员工薪资改为原来薪资的1.5倍。
# 步骤1: 查询测试部门对应的部门id
SELECT did FROM t_department WHERE dname = '测试部';
# 步骤2: 根据部门id修改员工的薪水
UPDATE t_employee SET salary = salary * 1.5 WHERE did =  (SELECT did FROM t_department WHERE dname = '研发部');

# 1.2 将没有部门的员工的部门改为“测试部”部门。
# 步骤1: 查询测试部门对应的部门id
SELECT did FROM t_department WHERE dname = '测试部';
# 步骤2: 修改语句
UPDATE t_employee SET did = (SELECT did FROM t_department WHERE dname = '测试部') 
                      WHERE did IS NULL;


# 1.3 修改“t_employee”表中“李冰冰”的薪资值等于“孙红梅”的薪资值。
# 步骤1: 查询孙红梅的薪资 [员工]
SELECT salary FROM t_employee WHERE ename = '孙红梅';
# 步骤2: 修改员工表的薪资 李冰冰 [员工]
UPDATE t_employee SET salary = (SELECT salary FROM t_employee WHERE ename = '孙红梅') WHERE ename  = '李冰冰';

# 错误代码： 1093
# You can't specify target table 't_employee' for update in FROM clause
# update占用了员工表的引用(再获取) ||  内部又要查询员工表的引用(先获取) [其中任何一方都不能直接修改]
# 将内层的子查询,再嵌套一层子查询,释放原有表的引用即可!
UPDATE t_employee SET salary = ( SELECT salary FROM  (SELECT salary FROM t_employee WHERE ename = '孙红梅') AS temp )
                 WHERE ename  = '李冰冰';


# 4.4 delete嵌套子查询
# 1.1 将“测试部”部门的员工删除。
# 步骤1: 我们先根据部门名称查询部门id
SELECT did FROM t_department WHERE dname = '测试部'
# 步骤2: 在员工表中完成根据部门id删除员工数据
DELETE FROM t_employee WHERE did = (SELECT did FROM t_department WHERE dname = '测试部');

# 1.2 从“t_employee”表中删除和“李冰冰”同一个部门的员工记录。。
# 步骤1: 先查询李冰冰对应的部门编号
SELECT did FROM t_employee WHERE ename = '李冰冰'
# 步骤2: 删除李冰冰部门的其他员工
DELETE FROM t_employee WHERE did = (SELECT did FROM t_employee WHERE ename = '李冰冰');
# 完成和内层是同一个表! 双方占有同一个表的引用! mysql的保护机制,不让这么操作
DELETE FROM t_employee WHERE did = (SELECT did FROM ( SELECT did FROM t_employee WHERE ename = '李冰冰' ) temp );





# 4.5 insert嵌套子查询

#1.1 创建表(employee),复制某个表的结构(t_employee)
CREATE TABLE employee LIKE t_employee;

#1.2 使用INSERT语句+子查询，复制数据，此时INSERT不用写values 
INSERT INTO employee (SELECT * FROM t_employee)

#1.3 同时复制表结构+数据 [创建表并复制数据]
CREATE TABLE employee1 AS (SELECT * FROM t_employee)




# 五、多表综合练习
# 准备表数据
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    NAME VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

INSERT INTO students (student_id, NAME, age, gender) VALUES
(1, '爱丽丝', 20, '女'),
(2, '鲍勃', 22, '男'),
(3, '查理', 21, '男');

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

INSERT INTO courses (course_id, course_name) VALUES
(101, '数学'),
(102, '物理'),
(103, '化学');

CREATE TABLE scores (
    student_id INT,
    course_id INT,
    score INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO scores (student_id, course_id, score) VALUES
(1, 101, 85),
(1, 102, 78),
(2, 101, 90),
(2, 102, 85),
(3, 101, 92),
(3, 102, 88),
(3, 103, 85);

# 题目
#1. 查询每位学生的[姓名、年龄] 学生表、[所选课程的名称] 课程表 以及对应的[成绩] 分数表，
# 如果学生没有选择课程，则成绩为 NULL。[学生是逻辑主表]
# 学生 -> 分数表 -> 课程表 [外连接查询]

SELECT stu.name, stu.age,cou.course_name , sc.score  FROM students stu 
                          LEFT JOIN scores sc  ON stu.student_id = sc.student_id
                          LEFT JOIN courses cou ON sc.course_id = cou.course_id;



#2. 查询没有选择任何课程的学生姓名。 (子查询)
# 条件: id 查询所有选课了学生
SELECT DISTINCT student_id FROM scores ; [列子子查询] IN  NOT IN  ANY ALL 
# 目标: 查询学生姓名(不在范围内)
SELECT * FROM students WHERE student_id NOT IN (SELECT DISTINCT student_id FROM scores )


#3. 查询每门课程的平均成绩，并列出平均成绩高于所有学生平均成绩的课程。(子查询)
# 1.查询所有的学生平均成绩
SELECT AVG(score) FROM scores ;
# 2.查询每个学科的平均成绩 分组后筛选 having 
SELECT course_id,  AVG(score) AS cavg 
                  FROM scores 
                  GROUP BY course_id
                  HAVING cavg > (SELECT AVG(score) FROM scores);

# 3.子查询条件嵌套


#4. 查询每位学生(姓名)所选课程的平均成绩，并按照平均成绩降序排列。
SELECT student_id , AVG(score) 学生平均成绩 
      FROM scores
      GROUP BY student_id 
      ORDER BY 学生平均成绩 DESC;
 
# 水平连接 学生和分数连接 + 高级处理 分组 排序... 

SELECT stu.name , AVG(score) avs
      FROM scores sc JOIN students stu ON sc.student_id = stu.student_id
      GROUP BY stu.name
      ORDER BY avs DESC;     






