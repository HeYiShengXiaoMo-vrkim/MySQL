
# 准备数据
CREATE DATABASE test08_other;

USE test08_other;

CREATE TABLE `t_employee` (
  `eid` INT NOT NULL COMMENT '员工编号',
  `ename` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '员工姓名',
  `salary` DOUBLE NOT NULL COMMENT '薪资',
  `commission_pct` DECIMAL(3,2) DEFAULT NULL COMMENT '奖金比例',
  `birthday` DATE NOT NULL COMMENT '出生日期',
  `gender` ENUM('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `tel` CHAR(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号码',
  `email` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `address` VARCHAR(150) DEFAULT NULL COMMENT '地址',
  `work_place` SET('北京','深圳','上海','武汉') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '北京' COMMENT '工作地点'
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT  INTO `t_employee`(`eid`,`ename`,`salary`,`commission_pct`,`birthday`,`gender`,`tel`,`email`,`address`,`work_place`) 
VALUES (1,'孙洪亮',28000,'0.65','1980-10-08','男','13789098765','shl@atguigu.com','白庙村西街','北京,深圳'),
(2,'何进',7001,'0.10','1984-08-03','男','13456732145','hj@atguigu.com','半截塔存','深圳,上海'),
(3,'邓超远',8000,NULL,'1985-04-09','男','18678973456','dcy666@atguigu.com','宏福苑','北京,深圳,上海,武汉'),
(4,'黄熙萌',9456,NULL,'1986-09-07','女','13609876789','hxm@atguigu.com','白庙村东街','深圳,上海,武汉'),
(5,'陈浩',8567,NULL,'1978-08-02','男','13409876545','ch888@atguigu.com','回龙观','北京,深圳,上海'),
(6,'韩庚年',12000,NULL,'1985-04-03','男','18945678986','hgn@atguigu.com','龙泽','深圳,上海'),
(7,'贾宝玉',15700,'0.24','1982-08-02','男','15490876789','jby@atguigu.com','霍营','北京,武汉'),
(8,'李晨熙',9000,'0.40','1983-03-02','女','13587689098','lc@atguigu.com','东三旗','深圳,上海,武汉'),
(9,'李易峰',7897,NULL,'1984-09-01','男','13467676789','lyf@atguigu.com','西山旗','武汉'),
(10,'陆风',8789,NULL,'1989-04-02','男','13689876789','lf@atguigu.com','天通苑一区','北京'),
(11,'黄冰茹',15678,NULL,'1983-05-07','女','13787876565','hbr@atguigu.com','立水桥','深圳'),
(12,'孙红梅',9000,NULL,'1986-04-02','女','13576234554','shm@atguigu.com','立城苑','上海'),
(13,'李冰冰',18760,NULL,'1987-04-09','女','13790909887','lbb@atguigu.com','王府温馨公寓','北京'),
(14,'谢吉娜',18978,'0.25','1990-01-01','女','13234543245','xjn@atguigu.com','园中园','上海,武汉'),
(15,'董吉祥',8978,NULL,'1987-05-05','男','13876544333','djx@atguigu.com','小辛庄','北京,上海'),
(16,'彭超越',9878,NULL,'1988-03-06','男','18264578930','pcy@atguigu.com','西二旗','深圳,武汉'),
(17,'李诗雨',9000,NULL,'1990-08-09','女','18567899098','lsy@atguigu.com','清河','北京,深圳,武汉'),
(18,'舒淇格',16788,'0.10','1978-09-04','女','18654565634','sqg@atguigu.com','名流花园','北京,深圳,武汉'),
(19,'周旭飞',7876,NULL,'1988-06-13','女','13589893434','sxf@atguigu.com','小汤山','北京,深圳'),
(20,'章嘉怡',15099,'0.10','1989-12-11','女','15634238979','zjy@atguigu.com','望都家园','北京'),
(21,'白露',9787,NULL,'1989-09-04','女','18909876789','bl@atguigu.com','西湖新村','上海'),
(22,'刘烨',13099,'0.32','1990-11-09','男','18890980989','ly@atguigu.com','多彩公寓','北京,上海'),
(23,'陈纲',13090,NULL,'1990-02-04','男','18712345632','cg@atguigu.com','天通苑二区','深圳'),
(24,'吉日格勒',10289,NULL,'1990-04-01','男','17290876543','jrgl@163.com','北苑','北京'),
(25,'额日古那',9087,NULL,'1989-08-01','女','18709675645','ergn@atguigu.com','望京','北京,上海'),
(26,'李红',5000,NULL,'1995-02-15','女','15985759663','lihong@atguigu.com','冠雅苑','北京'),
(27,'周洲',8000,NULL,'1990-01-01','男','13574528569','zhouzhou@atguigu.com','冠华苑','北京,深圳');


#一、数据库事务

# 1.1 事务手动提交

/*
  事务关闭和开启自动提交
    手动提交
      set autocommit = 0 | false 
    自动提交
      set autocommit = 1 | true | 每次新建连接默认都是自动提交
  查看是否是自动提交
      show variables like 'autocommit';
  注意:
    每次新建连接都是默认值 自动提交 都需要主动设置一下
    事务动作
       set autocommit = false;
       sql
       sql
       sql
       commit /rollback
       sql
       commit /rollback
       
*/
# 转到cmd演示 不要使用小海豚




# 1.2 事务开启独立事务

/*
   语法:
     start transaction;
     sql
     sql
     commit / rollback;
     
     start transaction;
     sql
     sql
     commit / rollback;
     
   注意:
     前提,不关是自动提交还是手动提交都可以使用
     开启一个独立的事务空间
     避免删库跑路的事情发生,事务不支持ddl语句的回滚
 */


# 1.3 事务隔离级别
/*
  隔离作用:
     并发的事务之间避免干扰
  隔离级别:
     事务的隔离性的高低和强弱,由具体的隔离级别决定!
     read-uncommitted 最弱的级别  脏读 不可重复读 幻读
     read-committed oracle默认    避免了脏读 | 不可重复读 幻读
     repeatable-read mysql默认  避免了脏读 不可重复读 | 幻读
     serializable  不会发生任何并发问题
  隔离问题:
     脏读: 一个事务读取了另一个事务未提交的数据,真的错误
     不可重复读: 一个事务读取了另一个事务提交的修改数据! [不符合一致性原则,不是数据错误]
     幻读: 一个事务读取了另一个事务提交的插入和删除数据! [不符合一致性原则,不是数据错误]
  修改和查看语法:	
     select @@transaction_isolation;
     set transaction_isolation = 隔离级别
  总结和建议:
     隔离级别越高,数据约安全,性能约低
     建议: 设置第二个隔离级别read-committed
*/

CREATE TABLE t_bank(
   ACCOUNT VARCHAR(20) NOT NULL UNIQUE COMMENT '银行账号' ,
   money INT COMMENT '银行金额'
)

INSERT INTO t_bank VALUES ('zhangsan',10000),('lisi',10000);

# 场景: zhangsan欠lisi 1000块钱
# 通过还钱演示 脏读 | 不可重复读 | 幻读



#二、用户权限控制

/*
  1.创建用户
    create user '账号'@'访问主机地址 localhost | ip地址 | %' identified by '密码'
  2.赋予权限
    grant 权限,权限,权限 on 数据库名.表名(* 任何库和表) to '账号'@'主机地址'
  3.回收权限
    revoke 权限,权限,权限 on 数据库名.表名 from '账号'@'主机地址'
  4.删除用户
    drop user '用户名'
  5.查看用户和权限
    select user,host from mysql.user;
    show grants fro '账号'@'主机地址'
*/


#三、数据备份和还原

# binlog操作

# 3.1 准备数据和日志文件

#1. 清空原有的日志文件
RESET MASTER;

#2. 准备数据,插入数据 -> 000001日志文件
CREATE DATABASE test08_binlog;
USE test08_binlog;
CREATE TABLE table_01(
  id INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20) NOT NULL
);
INSERT INTO table_01(NAME) VALUES('二狗子'),('驴蛋蛋');

#3. 重启一个新的日志文件 -> 000002日志文件
FLUSH LOGS;

#4. 将删除数据和插入数据植入第二个日志文件 -> 000002日志文件
DELETE FROM table_01 WHERE id = 2; #删除驴蛋蛋
INSERT INTO table_01(NAME) VALUES('狗剩子');
SELECT * FROM table_01;


# 3.2 查看日志文件和命令清单
# 查看日志文件
SHOW BINARY LOGS; 
# 某个日志文件的命令清单
SHOW BINLOG EVENTS; #查看第一个日志的清单 000001
SHOW BINLOG EVENTS IN '清单文件名' FROM pos LIMIT OFFSET , NUMBER; # from从哪个位置开始查询


SHOW BINARY LOGS;

SHOW BINLOG EVENTS;

SHOW BINLOG EVENTS IN 'my_logbin.000002';

SHOW BINLOG EVENTS IN 'my_logbin.000002' FROM 391 LIMIT 1 , 2;

# 3.3 查看详细内容

# 这个命令需要再cmd中执行!不是mysql的链接情况
mysqlbinlog -v binlog日志文件


# 3.4 跳过步骤找回数据
mysqlbinlog my-logbin.000001> d:/my_binlog.000001.sql # 将其他的日志完整导出
mysqlbinlog --stop-POSITION=删除命令的开始的pos my-logbin.000002> d:/my_binlog.391.sql # 02日志删除之前
mysqlbinlog --start-POSITION=删除命令的下一个命令开始pos my-logbin.000002> d:/my_binlog.441.sql ​# 02日志删除之后


SHOW BINLOG EVENTS IN 'my_logbin.000002'



# 四、数据库（8+）新特性

# 准备数据
CREATE TABLE goods(
 id INT PRIMARY KEY AUTO_INCREMENT,
 category_id INT,
 category VARCHAR(15),
 NAME VARCHAR(30),
 price DECIMAL(10,2),
 stock INT,
 upper_time DATETIME
);


INSERT INTO goods(category_id,category,NAME,price,stock,upper_time)
VALUES
(1, '女装/女士精品', 'T恤', 39.90, 1000, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '连衣裙', 79.90, 2500, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '卫衣', 89.90, 1500, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '牛仔裤', 89.90, 3500, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '百褶裙', 29.90, 500, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '呢绒外套', 399.90, 1200, '2020-11-10 00:00:00'),
(2, '户外运动', '自行车', 399.90, 1000, '2020-11-10 00:00:00'),
(2, '户外运动', '山地自行车', 1399.90, 2500, '2020-11-10 00:00:00'),
(2, '户外运动', '登山杖', 59.90, 1500, '2020-11-10 00:00:00'),
(2, '户外运动', '骑行装备', 399.90, 3500, '2020-11-10 00:00:00'),
(2, '户外运动', '运动外套', 799.90, 500, '2020-11-10 00:00:00'),
(2, '户外运动', '滑板', 499.90, 1200, '2020-11-10 00:00:00');


/*
  语法:
     多行函数 over (partition by 列名  [分组]  order by 列名 desc | asc) 

*/


# 聚合函数也是窗口函数 [理解]
# 查询所有的商品编号,价格,和类别名以及整体平均价格

SELECT id , NAME ,price, category , AVG(price) OVER () FROM goods;

SELECT id , NAME , price , category , AVG(price) OVER() FROM goods ;

# 查询所有的商品编号,价格,和类别名以及类别平均价格
SELECT id , NAME ,price, category , AVG(price) OVER (PARTITION BY category) FROM goods;

SELECT id , NAME , price , category , AVG(price) OVER(PARTITION BY category_id) FROM goods ;
# 






#1. 序号函数: row_number() 
# 举例1：查询 goods 数据表中每个商品分类下价格降序排列的各个商品信息。

SELECT ROW_NUMBER() OVER(PARTITION BY category ORDER BY price DESC) AS num,id , category , NAME ,price FROM goods;

SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num, id,
 category_id, category, NAME, price, stock FROM goods;
# 窗口函数 over (partition by 分组 order by 排序 )

#举例2：查询 goods 数据表中每个商品分类下价格最高的3种商品信息。
SELECT * FROM ( SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num, 
id, category_id, category, NAME, price, stock FROM goods) t
 WHERE row_num <= 3;
 
 
 
 

#2. 序号函数: rank()
# 举例：使用RANK()函数获取 goods 数据表中各类别的价格从高到低排序的各商品信息。SELECT RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
    id, category_id, category, NAME, price, stock
    FROM goods;

#举例2：使用RANK()函数获取 goods 数据表中类别为“女装/女士精品”的价格最高的4款商品信息
 SELECT * FROM(
    SELECT RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
    id, category_id, category, NAME, price, stock
    FROM goods) t
    WHERE category_id = 1 AND row_num <= 4;


#3. 序号函数: dense_rank()
# 举例1: 使用DENSE_RANK()函数获取 goods 数据表中各类别的价格从高到低排序的各商品信息。
SELECT DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num, id, category_id, category, NAME, price, stock  FROM goods;

#举例2: 使用DENSE_RANK()函数获取 goods 数据表中类别为“女装/女士精品”的价格最高的4款商品信息。
SELECT * FROM( SELECT DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,  id, category_id, category, NAME, price, stock FROM goods) t WHERE category_id = 1 AND row_num <= 3;


#4.分步函数: PERCENT_RANK()
#  
#(rank - 1) 1 / (rows - 1) 

# 举例1：计算 goods 数据表中名称为“女装/女士精品”的类别下的商品的PERCENT_RANK值。
#写法一：
SELECT RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS r,PERCENT_RANK() 
OVER (PARTITION BY category_id ORDER BY price DESC) AS pr,id, category_id, category, 
NAME, price, stock FROM goods WHERE category_id = 1;




#写法二:
SELECT RANK() OVER w AS r,
     PERCENT_RANK() OVER w AS pr,
     id, category_id, category, NAME, price, stock
     FROM goods
     WHERE category_id = 1 WINDOW w AS (PARTITION BY category_id ORDER BY price DESC);
     

#5. 前后函数: LAG(expr,n)
# LAG(expr,n)函数返回当前行的前n行的expr的值。

# 举例：查询goods数据表中前一个商品价格与当前商品价格的差值。
SELECT id, category, NAME, price, pre_price, price - pre_price AS diff_price
   FROM (SELECT  id, category, NAME, price,LAG(price,1) OVER w AS pre_price FROM goods
   WINDOW w AS (PARTITION BY category_id ORDER BY price)) t;


#6. 首尾函数: FIRST_VALUE(expr)
# FIRST_VALUE(expr)函数返回第一个expr的值。
# 举例：按照价格排序，查询第1个商品的价格信息。
SELECT id, category, NAME, price, stock,FIRST_VALUE(price) OVER w AS first_price
    FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);


# 公用表表达式


     
     