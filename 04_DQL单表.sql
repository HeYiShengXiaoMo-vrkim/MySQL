# 一、准备表数据
-- 创建库
CREATE DATABASE IF NOT EXISTS test04_dql;
USE test04_dql;


-- 创建员工表
DROP TABLE IF EXISTS `t_employee`;

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



# 2.1 基本语法（不指定条件）

# 演示非表查询、指定表、指定列的简单实现语法！

# 场景1: 非表查询
# 解释: 利用select关键字,快速输出一个运算结果或者函数,类似 java 控制台输出
# 语法: select 运算 , 函数
# 查询当前时间 now()
SELECT NOW();
# 场景2: 指定表查询结果
# 解释: 查询的时候,结果来至于某一张表或者多表!
# 语法:  select 查询表中的哪些列 列名,列名,列名 from 参照的表名
#        select 表名.列名, 列名,列名 from 参照的表名     # 表名.列名 多表的时候,需要这么,多表的列名可能重复!    
#        select * , 表名.*  from 表名;  * 就是表中的所有列
# 查询全部员工信息
SELECT * FROM t_employee;
SELECT t_employee.* FROM t_employee;
# 查询全部员工姓名和工资
SELECT ename,salary FROM t_employee;

# 场景3: 查询列并且起别名
# 解释: 查询时候可以给列起别名,为了匹配后期java数据格式
# 语法: select 列名 as 别名 , 列名 别名 from 表名
# 查询全部员工姓名和工资,名字显示为name名称
SELECT ename AS NAME,salary FROM t_employee;
SELECT ename NAME,salary FROM t_employee;

# 场景4: 去掉重复行数据
# 解释: 根据结果列进行重置值去除
# 语法: select distinct 列名, 列名 ,列名 from 表名;
# 查询员工的性别种类!
SELECT DISTINCT gender FROM t_employee;

# 场景5: 查询常数列
# 解释: 人为制造的一个值和一个列! (多个值,多个列)
# 语法:  select 列,列名,'值' as 列名 from 表名;
# 查询员工姓名和工资,并且添加一个公司company为尚硅谷
SELECT ename NAME,salary , '尚硅谷' company FROM t_employee;

# 2.2 基本SELECT查询练习
# 1. 查询所有员工信息
SELECT * FROM t_employee;
# 2. 查询所有员工信息，并且添加一列 etype,值固定为`总部`
SELECT * , '总部' etype FROM t_employee;
SELECT'总部' etype , *  FROM t_employee; # * 通配符,必须放在第一位!!
# 3. 查询所有员工姓名和工资以及工作地址
SELECT ename , salary , work_place FROM t_employee;
# 4. 查询所有员工姓名，月薪和年薪（年薪等于月薪*12,结果列字段为 姓名 , 月薪 ， 年薪 ）
SELECT ename 姓名,salary 月薪 , salary * 12 AS 年薪 FROM t_employee;
# 5. 查询所有员工姓名，月薪，每月奖金，每月总收入（结果列字段为 姓名 , 月薪 ， 奖金，月总 ）
SELECT ename  姓名 , salary  月薪 , salary * commission_pct 奖金 , salary +  salary * commission_pct 月总收入 FROM t_employee;
SELECT ename  姓名 , salary  月薪 , salary * IFNULL(commission_pct,0) 奖金 , salary +  salary * IFNULL(commission_pct,0) 月总收入 FROM t_employee;
# 因为,有些员工没有奖金, 奖金占比就是null, null 运算 任何值 = null
# ifnull(列,为null你给与的默认值) 0
# 6. 查询所有员工一共有几种薪资
SELECT DISTINCT salary FROM t_employee;


# 2.3 显示表结构
# 
# 场景1: 显示表结构
# 解释: 使用命令查看表中的列和列的特征
# 语法:  
#   describe 表名；
#   desc 表名；

DESC t_employee;



# 2.4 过滤数据（条件查询）
# 
# 场景1: 基本条件过来
# 解释: 就是对表的行数据进行筛选,符合条件的行,在进行结果列的查询!
# 语法: select 列信息 from 表信息 where [ 条件 and or xor 条件  and or xor 条件 ]  true | false 
# 总结：from   作用 执行参照和查询的表
#       where  作用 进行表中行的数据筛选
#       select 作用 进行符合条件行的数据类的筛选


# 2.5 基本SELECT查询练习（过滤条件）

# 1. 查询员工表结构，并分析
DESC t_employee;
# 2. 查询工资高于9000的员工信息
SELECT * FROM t_employee WHERE salary > 9000;
# 3. 查询年薪高于200000的员工姓名，薪资和年薪信息
SELECT ename,salary , salary * 12 AS 年薪  FROM t_employee WHERE salary > 20000;
# 4. 查询工资高于8000且性别为女的员工信息
SELECT * FROM t_employee WHERE salary > 8000 AND gender = '女';


SELECT 100, 100 + 0, 100 - 0, 100 + 50, 100 + 50 -30, 100 + 35.5, 100 - 35.5 ,
       3*5, 3*5.0, 3/5 , 100/0,5 DIV 2, -5 DIV 2 , 100 /(1-1);


# 3.1 算数运算符
# 
# 场景1: 对列进行算数运算
# 语法:  
/*   + - * [/ div] % mod
   注意:
     1. / 浮点除法 div  整数除法
     2. /0 不会抛出异常,结果是null
     3. 和浮点类型进行运算,结果也是浮点类型
     4. 优先级和之前一样,提升优先级 使用()
*/   


# 3.2 算数运算符练习题
# 1. 查询薪资奖金和大于20000的员工信息
SELECT * FROM t_employee WHERE salary + IFNULL(commission_pct,0) * salary > 20000;
# 2. 查询薪资减去奖金的差小于8000的员工信息
SELECT * FROM t_employee WHERE salary - IFNULL(commission_pct,0) * salary < 8000;
# 3. 查询所有员工的姓名,工资,奖金数额
SELECT ename,salary , salary * IFNULL(commission_pct,0) FROM t_employee
# 4. 查询员工编号是偶数的员工信息
SELECT * FROM t_employee WHERE eid % 2 = 0;





# 3.3 比较运算符
# 
# 对列进行算数运算
# 等于对比 = 不能做空判断  null = null -> false    null <=> null -> true (方言) -> is null
# 不等于对比 <> 标准语法  != mysql方言
# 大于,小于,大于等于,小于等于 > >= < <=
# 空值处理 is null  is not null 
# 区间比较 between min and max   not between min and max    1 5   -> 1 2 3 4 5 
# 范围比较  key in(x,y,z) key =x or  key = y  or key = z    not in 
# 模糊匹配  like  | not like -> key  like '赵%'   key like '_伟%'

# 3.4 比较运算符练习题
# 1. 查询员工编号为1的员工信息。
SELECT * FROM t_employee WHERE  eid = 1;
SELECT * FROM t_employee WHERE  eid = '1';
# 2. 查询薪资大于5000的员工信息。
SELECT * FROM t_employee WHERE salary > 5000;
# 3. 查询有奖金的员工信息。
SELECT * FROM t_employee WHERE commission_pct IS NOT NULL;
SELECT * FROM t_employee WHERE commission_pct IS  NULL;
SELECT * FROM t_employee WHERE commission_pct <=>  NULL;
# 4. 查询出生日期在 '1990-01-01' 和 '1995-01-01' 之间的员工信息。
SELECT * FROM t_employee WHERE birthday BETWEEN '1990-01-01' AND '1995-01-01';
# 5. 查询性别为女性的员工信息。
SELECT * FROM t_employee WHERE gender = '女'
# 6. 查询手机号码以 '138' 开头的员工信息。
SELECT * FROM t_employee WHERE tel LIKE '138________'
SELECT * FROM t_employee WHERE tel LIKE '138%'
# 7. 查询邮箱以 '@company.com' 结尾的员工信息。
SELECT * FROM t_employee WHERE email LIKE '%@atguigu.com'
# 8. 查询地址为NULL的员工信息。
SELECT * FROM t_employee WHERE address IS NULL;
# 9. 查询工作地点在 '北京'、'上海' 或 '深圳' 的员工信息。
SELECT * FROM t_employee WHERE work_place IN ('北京','上海', '深圳' )
# 10. 查询员工姓名以 '张' 开头的员工信息。
SELECT * FROM t_employee WHERE ename LIKE '张%';
# 11. 查询出生日期不在 '1980-01-01' 和 '2000-01-01' 之间的员工信息。
SELECT * FROM t_employee WHERE birthday NOT BETWEEN '1990-01-01' AND '1995-01-01';
# 12. 查询性别不是'男'的员工信息。
SELECT * FROM t_employee WHERE gender <> '男'; # 错误
SELECT * FROM t_employee WHERE gender != '男'; # 错误
# 13. 查询员工编号为奇数的员工信息。
SELECT * FROM t_employee WHERE eid % 2 = 1;

# 3.5 逻辑运算符
# 语法:  and && \\ or ||  \\ not !  \\ xor 
# 总结： 逻辑运算符号,可以将多个条件拼接到一起,最终生成一个结果!
# 特殊情况：数据库中非空 非0 代表true 反之为false ||  true -> 1 | false -> 0 

# 3.6 逻辑运算符练习题
# 1. 查询薪资大于5000并且工作地点为'北京'的员工信息。
SELECT * FROM t_employee WHERE salary > 5000  AND  work_place LIKE '%北京%';
FIND_IN_SET('值',列名) -> 值是否出现: 出现 1 不出现0 ;
SELECT ename , FIND_IN_SET('北京',work_place) FROM t_employee;
SELECT * FROM t_employee WHERE salary > 5000  AND  FIND_IN_SET('北京',work_place) = 1;
# 2. 查询奖金比例为NULL或者地址为NULL的员工信息。
SELECT * FROM t_employee WHERE commission_pct IS NULL OR address IS NULL;
# 3. 查询出生日期在 '1985-01-01' 之前或者薪资小于4000的员工信息。
SELECT * FROM t_employee WHERE birthday < '1985-01-01' OR salary < 4000;
# 4. 查询性别为'男'并且工作地点不为'上海'的员工信息。
SELECT * FROM t_employee WHERE gender = '男' AND FIND_IN_SET('上海',work_place) = 0;
# 5. 查询薪资大于6000或者邮箱以 '@gmail.com' 结尾的员工信息。
SELECT * FROM t_employee WHERE  salary  > 6000 OR email LIKE '%@gmail.com';
# 6. 查询工作地点为'上海'或者薪资小于4500的员工信息。
SELECT * FROM t_employee WHERE  salary < 4500 OR FIND_IN_SET('上海',work_place) = 1;
# 7. 查询员工编号为偶数并且地址不为NULL的员工信息。
SELECT * FROM t_employee WHERE eid % 2 = 0 AND  address IS NOT NULL;
# 8. 查询性别为'女'或者薪资小于等于5500的员工信息。
SELECT * FROM t_employee WHERE gender = '女' OR salary <= 5500;
# 9. 查询薪资大于5000且工作地点为'北京'或者'上海'的员工信息。
SELECT * FROM t_employee WHERE  salary > 5000 AND ( FIND_IN_SET('上海',work_place) = 1 OR FIND_IN_SET('北京',work_place) = 1 );
# 10. 查询邮箱中包含字母'b'并且地址为NULL的员工信息。
SELECT * FROM t_employee WHERE ename LIKE '%b%' AND  address IS NULL;



# 3.7 运算符优先级和结合性（左右）

# 第一阶梯：() 圆括号  
# 在MySQL中，圆括号（()）被认为是最高优先级的运算符。使用圆括号可以改变其他运算符的优先级！
SELECT * FROM TABLE WHERE (a + b) * c > d;

# 第二阶梯：一元运算符 -（符号）、！（非）、～（按位反）等
SELECT ! 1+1;

# 第三阶梯：算法运算符  *、/、%、DIV、MOD
SELECT 1 + 1 * 2 ;

# 第四阶梯：算数运算符 + - 
SELECT 1 + 2 * 3 >= 2 ;
# 第五阶梯：比较运算符 = > >= < <= != is LIKE IN 等

# 第六阶梯：逻辑运算符 and or xor 
SELECT 1 > 1 AND 1 = 1 ;

# 综合比较运算和演示
# result1和result2的答案！
SELECT
  ((-3 * 2 + 5) / 2) AS result1,
  NOT (3 + 1 = 4 AND 5 > 2 OR 7 >= 7) AS result2

SELECT
  ((-3 * 2 + 5) / (4 - 2)) + (10 % 3) AS result1,
   NOT ((3 + 1 = 4 AND (5 > 2 OR 7 >= 7)) OR (10 * 2 = 20)) AS result2  



# 4.3 单行函数/数值函数
# 语法:  abs()  ceil() floor() rand() rand(x) round(x) round(x,y) truncate(x,y)
# 总结： round(x,y) 会四舍五入 truncate(x,y) 直接截取
# 演示： 
SELECT ABS(-5),CEIL(2.3), CEIL(-2.3), FLOOR(2.3), FLOOR(-2.3), 
             TRUNCATE(RAND(),2),RAND(8),RAND(8), ROUND(2.3),ROUND(2.36,1),TRUNCATE(2.36,1);

# 4.4 单行函数/字符串函数
# 语法:  char_length(字符) 返回字符数  concat(x,x,x,x,x) 字符拼接  find_in_set(x,y) 去y的数据中找x出现的位置
# 总结： find_in_set(x,y)  y是一种set数据格式 'x,x,x,x,x' 中找x的存在 ,位置从1开始,找到第一个就终止!
# 演示： 
SELECT CHAR_LENGTH('abc') , CONCAT('%','娃娃','%') , FIND_IN_SET('aa','cc,dd,aa,bb,gg,aa');


# 4.5 单行函数/时间函数
# 语法:  
/*
   获取当前时间: now() curdate() curtime() 考虑系统的时区 | utc_date() utc_time() 不会考虑时区
   时间部分提取: year(时间) month(时间) week(时间) weekday(时间) 星期几 0是星期1  dayofweek(时间) 星期几 1 星期天 2 星期一
   时间运算: adddate | date_add(时间锚点,interval +-值 运算的时间单位的英文 day month year...)
             subdate | date_sub(时间锚点,interval +-值 运算的时间单位的英文 day month year...)
             addtime(时间,秒) 时间的+-秒的时间运算
             datediff(日期,日期) 算两个日期之间间隔的天
             timediff(时间,时间) 算两个时间间隔时间 时:分:秒
   时间格式化函数: date_format(时间，’格式字符串‘) time_format(时间，’格式字符串‘) -》 格式化时间生成一个自定义格式的时间字符串
                   str_to_date('非标注时间字符串','非标注时间字符串对应的格式') -》 非标注的时间字符串-》转成标注的时间
*/
# 演示： 
SELECT NOW(), CURDATE(), CURTIME(), UTC_DATE(),UTC_TIME(), YEAR(NOW()) , MONTH(NOW()) , WEEK(NOW()),
                 WEEKDAY(NOW()) , DAYOFWEEK(NOW()),DAY(NOW()) , DAYOFMONTH(NOW());
   
SELECT ADDDATE(NOW(),INTERVAL 1 MONTH)  ,  ADDDATE(NOW(),INTERVAL -1 MONTH) ,  ADDTIME('10:10:10',20) ,
          ABS(DATEDIFF(CURDATE(),'2024-11-11')) , TIMEDIFF('12:00:00','10:00:00');

SELECT NOW();
SELECT DATE_FORMAT(NOW(),'%Y年%m月%d日');
SELECT TIME_FORMAT(NOW(),'%H:%i:%s')
# 前端-> 2024年04月20日 -》str_to_date -> 标准时间 -》   '2024-04-20'
SELECT STR_TO_DATE('2024年04月20日' , '%Y年%m月%d日');

# 4.6 时间相关练习题

# 题目
# 1. 查询今天过生日的员工信息
#   2024-04-20 - 04-20
SELECT * FROM t_employee WHERE DAY(birthday) = DAY(NOW()) AND MONTH(birthday) = MONTH(NOW());
SELECT * FROM t_employee WHERE DATE_FORMAT(birthday,'%m-%d') = DATE_FORMAT(NOW(),'%m-%d');
# 2. 查询本月过生日的员工信息
SELECT * FROM t_employee WHERE MONTH(birthday) = MONTH(NOW());
# 3. 查询下月过程日的员工信息
SELECT * FROM t_employee WHERE MONTH(birthday) = MONTH(NOW()) +1;
SELECT * FROM t_employee WHERE MONTH(birthday) = MONTH(DATE_ADD(NOW(),INTERVAL 1 MONTH))
# 4. 查询员工姓名，工资，年龄(保留1位小数点)信息
SELECT ename, salary ,  ROUND(DATEDIFF(NOW(),birthday) / 365 , 1) AS age FROM t_employee;
# 5. 查询年龄在25-35之间的员工信息
SELECT * FROM t_employee WHERE  ROUND(DATEDIFF(NOW(),birthday) / 365 , 1) BETWEEN 25 AND 35;


# 4.7 单行函数/流程函数
# 语法:  
#    if(表达式,true_value,false_value) if函数处理有两个结果的流程
#    ifnull(列名,null_value) 处理列等于null的时候,我们赋予其他的默认值
#    case关键字: 处理多流程结果
#       第一种语法: case when 表达式 then result1  when 表达式2 then result2 ... else default_value end [as 别名]
#       第二种语法: case 列名 | 表达式  when 值 then result when 值 then 结果 ... else default_value end  ...
# 练习：
# 1. 此查询将根据员工的生日，如果生日1990年之前，则薪资涨幅为当前薪资的 10%，否则为 5%。[1990之前 和 1990之后 if]
SELECT ename ,salary , birthday , ROUND(IF(YEAR(birthday)>1990, salary * 1.05 ,salary*1.1),1) AS newSalary FROM t_employee;
# 2. 查询员工编号和姓名,以及生成一个type列,更具性别显示男员工or女员工。[男或者女 if函数]
SELECT eid,ename,gender,IF(gender='男','男员工','女员工') AS TYPE FROM t_employee;
# 3. 查询员工的姓名和工资以及奖金数额(奖金额=salary*commission_pct)。 ifnull(xx,0)  0.05
# null 和 其他数字进行运算 + - * / ... 都为null
SELECT ename,salary, salary * IFNULL(commission_pct,0.05) AS 奖金额度 FROM t_employee;
# 4. 查询姓名，性别，以及补助金额（补助按照性别基准值*commission_pct），男性基础2000，女性基准3000，
#其他0，commission_pct为null算0.1比例! / ifnull | case  
# 基于case when 
SELECT ename,gender,commission_pct ,
       CASE 
          WHEN gender = '男' THEN 2000*IFNULL(commission_pct,0.1)
          WHEN gender = '女' THEN 3000*IFNULL(commission_pct,0.1)
          ELSE 0
       END  AS 补助金额1
       FROM t_employee;   
# 基于 case 列名|表达式 when value then result
SELECT ename,gender,commission_pct ,
       CASE gender
          WHEN '男' THEN 2000*IFNULL(commission_pct,0.1)
          WHEN '女' THEN 3000*IFNULL(commission_pct,0.1)
          ELSE 0
       END  AS 补助金额2
       FROM t_employee; 
       
# 例子 更新中也使用case 
# set 列名 = case when then else end          



# 4.8 多行函数/聚合函数
/*
  语法:  
       avg(列名=>平均值=>数值类型)
       sum(列名=>数值和=>数值类型)
       min|max(列名=>最大值和最小值=>任意类型)
       count(列名 * 1 =>总数量 列名 列非空值出现的次数| 1 * 总条数 =>任意类型)
  总结: 
      聚合函数碰到null是如何处理的?  聚合函数时冷漠的,不计数,不处理,不关注!
      聚合函数之间是不能嵌套的!
*/
#1.求平均工资,最小和最大工资以及总工资  
SELECT AVG(salary),MIN(salary),MAX(salary),SUM(salary) FROM t_employee;       
#2.求最大年龄和最小年龄的员工生日    
SELECT MIN(birthday) AS 年龄最大员工的生日 , MAX(birthday) AS 年龄最小的员工生日 FROM t_employee; 
#3.求总员工数和有奖金的员工数             
SELECT COUNT(*) , COUNT(1) , COUNT(commission_pct) FROM t_employee;










# 5.1 分组查询
/*
  语法:  
       分组是将数据行分成若成个小组
       最终统计的是组的特性和数据( 分组列,聚合函数)
       group by 分组列,分组列...having 分组后的比较
  总结:
       1.分组查询只能查询的就是分组字段和聚合函数
       2.having是分组后的条件 | where是分组前的条件
*/
#1. 查询每种性别的员工数量以及性别平均工资 (先按照性别gender列分组,分组以后统计分组特性列和聚合函数即可 本次没有条件)

SELECT gender , COUNT(*) ,AVG(salary) FROM t_employee GROUP BY gender;

#2. 查询生日年份、性别相同的人数和平均工资( year())

SELECT YEAR(birthday),COUNT(*) , AVG(salary) FROM t_employee GROUP BY YEAR(birthday);

#3. 查询工资高于5000，每种性别的员工数量以及性别平均工资 [条件工资高于5000,分组前的筛选条件 where]
SELECT gender , COUNT(*) ,AVG(salary) FROM t_employee WHERE salary > 5000 GROUP BY gender;

#4. 查询平均工资高于11000的性别和性别人数 [按照性别分组,分组以后筛选平均工资大于5000的组](平均工资大于5000是分组后的条件 having)
SELECT gender , COUNT(*) ,AVG(salary) FROM t_employee GROUP BY gender HAVING AVG(salary) > 11000;
SELECT gender , COUNT(*) ,AVG(salary) AS av FROM t_employee GROUP BY gender HAVING av > 11000;
# having是分组后的条件 where是分组前的条件
# having只能在group by后面出现 where 随时可以出现
# having比较一般(99.999)都是聚合函数  where可以是任何参数的比较
# having可以使用select后面查询到的列的名称 || having在分组之后执行! 查询结果已经有了! 我们可以进行复用 
# 而where不能复用select列 where早于select列名


# 5.2 排序查询
/*
 语法:  
    order by 列名 asc | desc , 列名 asc | desc 
    细节1: 多列排序,只有上一列相同,第二列才会生效!
    细节2: asc正序 从小到大 desc 倒序 从大到小
    细节3: asc 默认值 可以不写 order by price , xxx desc;
    
*/
# 练习：
#1. 按照年龄正序排序，查询员工信息(从小到大)
SELECT * FROM t_employee ORDER BY birthday DESC;
#2. 按照工资倒序，查询员工信息
SELECT * FROM t_employee ORDER BY salary DESC;
#3. 按照工资倒序，如果工资相同，按照年龄正序排序查询员工信息(从小到大 生日从大到小)
SELECT * FROM t_employee ORDER BY salary DESC , birthday DESC;
#4. 查询有奖金的员工(where)，最终按照工资倒序显示员工信息
SELECT * FROM t_employee WHERE commission_pct IS NOT NULL  ORDER BY salary DESC;





# 5.3 切割查询
/*
  语法:
     limit  [offset偏移量 , ] number ; 
  总结:
     offset可以省略,偏移量0的时候,从头开始查询  limit 0 , 5 == limit 5;
     limit 10; 但是数据库一共有5条数据! 只会返回5条
     limit关键字真的影响数据, limit放在select语句的最后!
  分页公式推算: 已知 page(当前页从1开始) size(页容量)
     limit -> 分页查询 -> 前端会传递 page 和 size ->后台limit切割显示
     limit (page-1)*page,size;
*/
# 1. 查询工资最高的员工信息 [排序(工资倒序) | 切割 1 ]
SELECT * FROM t_employee ORDER BY salary DESC LIMIT 0 , 1;
SELECT * FROM t_employee ORDER BY salary DESC LIMIT 1;
# 2. 查询工资第二高的员工信息 [排序(工资倒序) | 切割 1,1]   2 3 4 limit 1 ,3 | 工资最少得三名员工
SELECT * FROM t_employee ORDER BY salary DESC LIMIT 1, 1;
# 3. 查询工资最高的女性员工信息
SELECT * FROM t_employee WHERE gender = '女' ORDER BY salary DESC LIMIT 1;



# 5.4 查询执行流程
# 总结:  
/*
   关键字的书写顺序: select 列名 from 表 where 条件 and | or 条件 group by 分组字段,分组字段 having 分组后条件
                                                order by 列名 asc | desc , 列名 asc | desc limit offset,number;
   关键字执行的顺序: from 数据源 where 筛选前置条件 group by 分组 having 分组后的数据过滤  select 显示列的信息
                                         order by 排序 limit 切割!                                                                  
    mysql8.0+版本,进行一些优化!
       1. where后面依然无法使用select产生的列,这时候,确实没有列的生成! 标准的sql中也是这么规定的!
       2. 经过优化和中间的虚拟表, group by 和 having后面使用 select产生的列
*/
# 演示：

SELECT gender,YEAR(birthday) AS br, COUNT(*) 
FROM t_employee 
WHERE br > 2000;

SELECT gender,YEAR(birthday) AS br, COUNT(*) ct 
FROM t_employee
GROUP BY gender,br 
HAVING ct > 1;



#5.5 单表综合练习答案
#1、创建数据库test01_library#
CREATE DATABASE IF NOT EXISTS test01_library CHARACTER SET 'utf8';

#指定使用哪个数据库
USE test01_library;

#2、创建表 books
CREATE TABLE books(
	id INT,
	`name` VARCHAR(50),
	`authors` VARCHAR(100) ,
	price FLOAT,
	pubdate YEAR ,
	note VARCHAR(100),
	num INT
);

#3、向books表中插入记录
# 1）不指定字段名称，插入第一条记录
INSERT INTO books 
VALUES(1,'Tal of AAA','Dickes',23,1995,'novel',11);
# 2）指定所有字段名称，插入第二记录
INSERT INTO books (id,NAME,`authors`,price,pubdate,note,num)
VALUES(2,'EmmaT','Jane lura',35,1993,'Joke',22);
# 3）同时插入多条记录（剩下的所有记录）
INSERT INTO books (id,NAME,`authors`,price,pubdate,note,num) VALUES
(3,'Story of Jane','Jane Tim',40,2001,'novel',0),
(4,'Lovey Day','George Byron',20,2005,'novel',30),
(5,'Old land','Honore Blade',30,2010,'Law',0),
(6,'The Battle','Upton Sara',30,1999,'medicine',40),
(7,'Rose Hood','Richard haggard',28,2008,'cartoon',28);

# 4、将小说类型(novel)的书的价格都增加5。(update)
# update 表名 set 列名 = 值 , 列名 = 值 , 列名 = 列名 运算 数值 where
UPDATE books SET price = price + 5 WHERE note = 'novel';

# 5、将名称为EmmaT的书的价格改为40，并将说明改为drama。
UPDATE books SET price = 40 , note = 'drama' WHERE NAME = 'EmmaT'

# 6、删除库存为0的记录。
# delete from 表名 | where 
DELETE FROM books WHERE num = 0;

# 7、统计书名中包含a字母的书 'name不知道全部的名称一部分,模糊查看 like'
SELECT * FROM books WHERE NAME LIKE '%a%'

# 8、统计书名中包含a字母的书的数量和库存总量 [多行函数 | 聚合函数 count sum]
SELECT COUNT(1),SUM(num) FROM books WHERE NAME LIKE '%a%'

# 9、找出“novel”类型的书，按照价格降序排列
# order by | where 
# 书写的时候: select 列名 from where group by having order by asc desc limit 
SELECT * FROM books WHERE note ='novel' ORDER BY price DESC;

# 10、查询图书信息，按照库存量降序排列，如果库存量相同的按照note升序排列
SELECT * FROM books ORDER BY num DESC , note;

# 11、按照note分类统计书的数量 [分组问题]
# 分组 select 分组字段,聚合函数
SELECT  note,COUNT(1) FROM books GROUP BY note;

# 12、按照note分类统计书的库存量，显示库存量超过30本的 [分组,统计每一组的num的和 和>30 having]
SELECT  note,SUM(num) AS nm FROM books GROUP BY note HAVING nm > 30;

# 13、查询所有图书，每页显示4本，显示第二页 分页查询
# limit offset , number; 分页: page = 2 | size = 5 ==> limit (page-1)*size , size; => limit 5,5;

SELECT * FROM books LIMIT 4,4;

# 14、按照note分类统计书的库存量，显示库存量最多的  [nm库存和排序,倒序+limit 1]

SELECT  note,SUM(num) AS nm FROM books GROUP BY note  ORDER BY  nm DESC  LIMIT 1;

# 15、查询书名达到10个字符的书，不包括里面的空格 (函数 | string的函数 char_length(column|字符串) | replace(字符串,'目标','替换的值') )

SELECT * FROM books WHERE  CHAR_LENGTH(REPLACE(NAME,' ','')) > 5;


/*
16、查询书名和类型，
 其中note值为 novel显示小说，law显示法律，medicine显示医药，cartoon显示卡通，joke显示笑话 不在这个内,成为其他类型
*/

# case 流程控制 | 两个结果 if()
# 用法1: case when 运算表达式 then 值  when 运算表达式 then 值  else 默认值 end as 别名
# 用法2: case 列名 | 表达式 when 值 then 结果  when 值 then 结果  else 结果 end as 别名
SELECT NAME,note,
         CASE 
            WHEN note = 'novel' THEN '小说'
             WHEN note = 'law' THEN '法律'
              WHEN note = 'medicine' THEN '医药'
               WHEN note = 'cartoon' THEN '卡通'
               WHEN note = 'joke' THEN '笑话'
               ELSE '其他'
         END AS TYPE  FROM books ;    

SELECT NAME,note,
         CASE note 
            WHEN 'novel' THEN '小说'
             WHEN 'law' THEN '法律'
              WHEN 'medicine' THEN '医药'
               WHEN 'cartoon' THEN '卡通'
               WHEN 'joke' THEN '笑话'
               ELSE '其他'
         END AS TYPE  FROM books ;             


# 17、查询书名、库存状态，其中num值超过30本的，显示滞销，30-10代表正常, 大于0并低于10的，显示畅销，为0的显示需要无货
SELECT NAME , num , 
         CASE 
            WHEN num > 30 THEN '滞销'
            WHEN num > 10 AND num <= 30  THEN '正常'
            WHEN num > 0 AND num <= 10  THEN  '畅销'
            ELSE '无库存'
         END AS 库存状态
            FROM books;   

# 18、统计每一种note的库存量，[并合计总量](分组)
# with rollup sql查询的子句,用于生成数据汇总行!
SELECT IFNULL(note,'总量'),SUM(num) FROM books GROUP BY note WITH ROLLUP;

# 19、统计每一种note的数量，并合计总量
SELECT IFNULL(note,'总量'),COUNT(*) FROM books GROUP BY note WITH ROLLUP;

# 20、统计库存量前三名的图书 [排序 倒序, limit 0 3 | limit 3]
SELECT * FROM books ORDER BY num DESC LIMIT 3;

# 21、找出最早出版的一本书
SELECT * FROM books ORDER BY pubdate ASC LIMIT 1;

# 22、找出novel中价格最高的一本书 [where order limit ]
SELECT * FROM books WHERE note = 'novel' ORDER BY price DESC LIMIT 1;

# 23、找出书名中字数最多的一本书，不含空格     
SELECT * FROM books ORDER BY CHAR_LENGTH(REPLACE(NAME,' ','')) DESC LIMIT 1;
 