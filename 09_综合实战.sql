
# 准备数据
CREATE DATABASE test09_sql;

USE test09_sql;


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE salaries (
    employee_id INT PRIMARY KEY,
    salary DECIMAL(10, 2)
);

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    department_id INT
);


-- 插入员工信息
INSERT INTO employees (employee_id, first_name, last_name, department_id)
VALUES
    (1, 'John', 'Doe', 1),
    (2, 'Jane', 'Smith', 2),
    (3, 'Michael', 'Johnson', 1),
    (4, 'Emily', 'Brown', NULL),
    (5, 'David', 'Williams', 3),
    (6, 'Sarah', 'Jones', 1);

-- 插入部门信息
INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'HR'),
    (2, 'Finance'),
    (3, 'IT');

-- 插入员工薪资信息
INSERT INTO salaries (employee_id, salary)
VALUES
    (1, 50000),
    (2, 60000),
    (3, 55000),
    (4, 48000),
    (5, 70000),
    (6, 52000);

-- 插入经理信息
INSERT INTO managers (manager_id, department_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);


# 实现
#1、找出每个部门的平均工资。 部门的信息 , 平均工资
#  员工表 和 薪资表
#  查询语法: 连表查询 -> 员工表 | 分组查询 -> 分组字段 和 聚合函数

SELECT d.department_name,AVG(s.salary) AS sav FROM employees e 
          LEFT JOIN salaries s ON e.employee_id = s.employee_id
          LEFT JOIN departments d ON e.department_id = d.department_id
          GROUP BY d.department_name;

#2、列出每个部门的经理姓名以及他们管理的员工数目。

# 查询每个部门以及部门对应的经理的名称
SELECT * FROM departments d 
                    LEFT JOIN managers m ON d.department_id = m.department_id
                    LEFT JOIN employees e1 ON e1.employee_id = m.manager_id;

# 查询每个员工以及员工对应的部门以及部门的名称
SELECT d.department_name , CONCAT(e1.first_name,e1.last_name) AS manager_name , COUNT(1) ct FROM departments d 
                    LEFT JOIN managers m ON d.department_id = m.department_id
                    LEFT JOIN employees e1 ON e1.employee_id = m.manager_id
                    LEFT JOIN employees e2 ON e2.department_id = d.department_id
                    GROUP BY manager_name,d.department_name ;

	
#3、列出没有分配到部门的员工。
SELECT * FROM employees WHERE department_id IS NULL;

#4、列出每个部门的员工数目以及该部门的总工资。

SELECT e.department_id,AVG(s.salary) , COUNT(1) FROM employees  e 
         LEFT JOIN salaries s ON e.employee_id = s.employee_id
         GROUP BY e.department_id;

#5、列出每个员工的名字以及他们的薪资等级（低于平均工资的员工为低级别，高于平均工资的员工为高级别）。

# id , 姓名 , 薪水等级 -> 比较 平均薪水 [流程语句 case when | 聚合函数单独使用,窗口函数]

SELECT e.employee_id,CONCAT(e.first_name,e.last_name) , s.salary ,
       CASE 
          WHEN s.salary < AVG(salary) OVER () THEN '低级别'
          ELSE '高级别'
       END AS salary_level   

FROM employees e LEFT JOIN salaries s ON e.employee_id = s.employee_id;


#6、找出薪资排名前10的员工。
SELECT * FROM employees e LEFT JOIN salaries s ON e.employee_id = s.employee_id
                          ORDER BY s.salary DESC LIMIT 1,1;

#7、找出至少有2名员工的部门。
# 至少有2名员工的部门  > 2 分组后的条件
# where 分组前的条件
# on 主 = 外
# having -> group by 分组后的条件

SELECT department_id , COUNT(1) num FROM employees e GROUP BY department_id HAVING num > 2;


#8、找出每个部门的平均工资，但排除经理的薪资。



SELECT e.department_id,AVG(s.salary) FROM employees  e 
         LEFT JOIN salaries s ON e.employee_id = s.employee_id
         WHERE e.employee_id NOT IN (SELECT manager_id FROM  managers)
         GROUP BY e.department_id


#9、列出每个部门的员工姓名、薪资，以及该部门内工资排名。
# rank() 多行函数->窗口函数使用
SELECT  e.first_name,s.salary,e.department_id , 
         RANK() OVER(PARTITION BY e.department_id ORDER BY s.salary DESC)
         FROM employees  e 
         LEFT JOIN salaries s ON e.employee_id = s.employee_id
         

#10、找出每个部门薪资最低的员工。

# from where select 

SELECT * FROM (SELECT  e.first_name,s.salary,e.department_id , 
         RANK() OVER(PARTITION BY e.department_id ORDER BY s.salary ASC) num
         FROM employees  e 
         LEFT JOIN salaries s ON e.employee_id = s.employee_id )  temp WHERE temp.num = 1 ;
        

