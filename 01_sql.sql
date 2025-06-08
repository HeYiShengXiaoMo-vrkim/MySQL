-- ====================================================================
-- MySQL 常用操作整理
-- ====================================================================

-- --------------------------------------------------------------------
-- 一、通用管理与信息查看命令
-- --------------------------------------------------------------------

-- 1.1 查看数据库服务器信息
SELECT VERSION(); -- 显示数据库版本
SHOW VARIABLES LIKE 'character_set_database'; -- 显示数据库的默认字符集
SHOW VARIABLES LIKE 'collation_database';   -- 显示数据库的默认排序规则
SHOW DATABASES; -- 显示所有数据库

-- 1.2 查看当前使用的数据库
SELECT DATABASE(); -- 显示当前正在使用的数据库名称

-- 1.3 查看数据库的创建信息 (包括字符集和排序规则)
SHOW CREATE DATABASE educ_manage; -- 将 'educ_manage' 替换为你想查看的数据库名

-- 1.4 查看表信息
SHOW TABLES; -- 显示当前数据库中的所有表
SHOW TABLES FROM educ_manage; -- 显示指定数据库 'educ_manage' 中的所有表
DESC lesson; -- 显示 'lesson' 表的结构 (DESCRIBE lesson 的缩写)


-- --------------------------------------------------------------------
-- 二、数据库 (Database) 操作
-- --------------------------------------------------------------------

-- 2.1 创建数据库
CREATE DATABASE new_database; -- 以默认设置创建数据库
CREATE DATABASE IF NOT EXISTS new_database_for_practice -- 如果数据库不存在则创建
    CHARACTER SET utf8mb4       -- 指定字符集
    COLLATE utf8mb4_0900_ai_ci; -- 指定排序规则 (ai: accent insensitive, ci: case insensitive)
                                -- utf8mb4_0900_as_cs (as: accent sensitive, cs: case sensitive)

-- 2.2 切换数据库
USE new_database_1; -- 将当前会话的默认数据库切换到 'new_database_1'

-- 2.3 修改数据库属性
ALTER DATABASE educ_manage CHARACTER SET gbk; -- 修改 'educ_manage' 数据库的字符集为 gbk
ALTER DATABASE educ_manage COLLATE utf8mb4_0900_ai_ci; -- 修改 'educ_manage' 数据库的排序规则
ALTER DATABASE educ_manage -- 同时修改字符集和排序规则
    CHARACTER SET utf8
    COLLATE utf8mb4_unicode_ci; -- (示例中使用 unicode_ci，更通用)

-- 2.4 删除数据库
DROP DATABASE educ_manage; -- 删除名为 'educ_manage' 的数据库 (谨慎操作！)
DROP DATABASE IF EXISTS `you're fired`; -- 如果数据库存在则删除。
                                        -- 注意: 数据库名若包含特殊字符或空格，需用反引号 `` 包裹。


-- --------------------------------------------------------------------
-- 三、表 (Table) 操作
-- --------------------------------------------------------------------

-- 3.1 创建表
CREATE TABLE IF NOT EXISTS new_table (
    name VARCHAR(20),
    age TINYINT DEFAULT 20 COMMENT 'the age of this people', -- 'age' 列，TINYINT类型，默认值为20，并添加注释
    id SMALLINT COMMENT 'the id number of this person'      -- 'id' 列，SMALLINT类型，并添加注释
) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; -- 为表指定字符集和排序规则 (可选，默认继承数据库设置)

-- 3.2 修改表结构 (ALTER TABLE)
-- 3.2.1 添加列
ALTER TABLE course ADD computer_science_score TINYINT; -- 在表末尾添加新列 'computer_science_score'
ALTER TABLE course ADD new_column VARCHAR(50) FIRST; -- 在表开头添加新列 'new_column'
ALTER TABLE course ADD another_column INT AFTER name; -- 在 'name' 列之后添加新列 'another_column'

-- 3.2.2 修改列名和类型 (CHANGE)
ALTER TABLE course CHANGE computer_science_score cs_score TINYINT; -- 将 'computer_science_score' 列名改为 'cs_score'，类型仍为 TINYINT
ALTER TABLE course CHANGE cs_score cs_score_new_type INT COMMENT 'new comment'; -- 只修改类型和注释，列名不变

-- 3.2.3 修改列的数据类型或属性 (MODIFY)
ALTER TABLE course MODIFY cs_score INT; -- 将 'cs_score' 列的数据类型修改为 INT
ALTER TABLE course MODIFY cs_score VARCHAR(10) DEFAULT 'N/A' AFTER id; -- 修改类型，设置默认值，并移动到 'id' 列之后

-- 3.2.4 删除列
ALTER TABLE course DROP cs_score; -- 删除 'course' 表中的 'cs_score' 列

-- 3.2.5 修改表名
ALTER TABLE course RENAME TO lesson; -- 将 'course' 表名修改为 'lesson'

-- 3.3 删除表
DROP TABLE lesson; -- 删除 'lesson' 表 (数据和结构都删除)
DROP TABLE IF EXISTS course, student_ids, codes; -- 如果表存在则删除，可一次删除多张表

-- 3.4 清空表数据 (保留表结构)
TRUNCATE TABLE lesson; -- 清空 'lesson' 表中的所有数据，比 DELETE FROM 快，且不记录binlog（某些情况下）


-- --------------------------------------------------------------------
-- 四、数据操作语言 (DML - Data Manipulation Language)
-- --------------------------------------------------------------------

-- 4.1 插入数据 (INSERT INTO)
-- 4.1.1 插入完整行数据 (所有列按表定义顺序提供值)
-- 注意: 字符串和日期类型的值需要用单引号括起来。
INSERT INTO lesson VALUES ('value_for_col1', 'value_for_col2', 123456, 'value_for_col4');
-- 示例修正: INSERT INTO student (Ssex, Sname, Sno, Sdept) VALUES ('male', 'Charlie', '123456', 'UC');

-- 4.1.2 插入指定列的数据 (未指定的列会使用默认值或NULL)
INSERT INTO lesson (column1, column2, column3) VALUES ('value1', 1, NULL);

-- 4.1.3 一次插入多行数据
INSERT INTO lesson (column1, column2, column3) VALUES
    ('value1_row1', 1, NULL),
    ('value2_row2', 2, NULL),
    ('value3_row3', 3, 'some_text');

-- 4.2 更新数据 (UPDATE)
-- 4.2.1 更新表中部分行的数据 (使用 WHERE 子句指定条件)
-- 注意: 字符串值需用单引号。条件中的值如果也是字符串，同样需要单引号。
UPDATE student SET Ssex = '女' WHERE Sno = 'PRI001'; -- 假设Sno是字符串类型
UPDATE student SET Sage = Sage + 1 WHERE Sdept = 'CS';

-- 4.2.2 更新表中所有行的数据 (不使用 WHERE 子句，或 WHERE 条件为真)
-- 注意: 如果 Sname 列是字符串类型，'小芳' 应该用单引号。
UPDATE student SET Ssex = '女', Sname = '小芳'; -- 这会将所有学生的性别改为'女'，名字改为'小芳' (通常不这么用，除非特定场景)

-- 4.3 删除数据 (DELETE FROM)
-- 4.3.1 删除表中所有行的数据 (保留表结构)
DELETE FROM student; -- 数据可恢复 (如果开启binlog并配置得当)，比 TRUNCATE 慢

-- 4.3.2 删除表中部分行的数据 (使用 WHERE 子句指定条件)
-- 注意: 字符串值需用单引号。
DELETE FROM student WHERE Ssex = '女';
DELETE FROM student WHERE Sage < 18;

-- 4.4 查询数据 (SELECT)
-- (这里只列出你提到的，SELECT 有非常丰富的功能)
SELECT lesson.* FROM lesson; -- 查询 'lesson' 表中的所有列和所有行 (等同于 SELECT * FROM lesson;)
SELECT Sno, Sname FROM student WHERE Sdept = 'IS' ORDER BY Sno DESC; -- 查询信息系学生学号姓名，按学号降序排列


-- --------------------------------------------------------------------
-- 五、总结与注意事项
-- --------------------------------------------------------------------
-- 1. SQL语句通常以分号 (;) 结尾。
-- 2. 字符串和日期类型的值必须用单引号 ('value') 括起来。
-- 3. 标识符 (数据库名、表名、列名) 如果包含特殊字符、空格或是SQL保留关键字，需要用反引号 (``) 括起来，例如 `my table`。
-- 4. SQL关键字不区分大小写 (如 SELECT, select, Select 均可)，但表名和数据库名在某些操作系统上是区分大小写的 (Linux区分，Windows不区分)。建议养成一致的风格 (如关键字大写，自定义名称小写)。
-- 5. 执行 `DROP` 和 `DELETE` (无 `WHERE` 子句) 以及 `TRUNCATE` 操作前务必谨慎，确保已备份数据或清楚操作后果。
