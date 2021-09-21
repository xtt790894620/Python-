-- 1. 数据库操作

-- 刷新权限
FLUSH PRIVILEGES;

-- 列出所有存在的数据库
SHOW DATABASES;

-- 使用某数据库
USE mysql;

-- 列出数据库中的所有表
SHOW TABLES

-- 列出表中所有字段及字段属性
DESCRIBE javmodels

-- 创建数据库
CREATE DATABASE NBA;

-- 删除数据库
DROP DATABASE NBA;


-- ***************************************************************************************** --


-- 2. 表操作

-- 创建表, 语法
CREATE TABLE [表明] (字段1 字段类型 [属性] [索引] [注释], ### 注意字段之间才使用逗号隔开  
		     字段2 字段类型 [属性] [索引] [注释],
                     字段3 字段类型 [属性] [索引] [注释])
USE NBA;

-- 创建表实例，注意细节问题
-- 创建表之前，需要先选定数据库
CREATE TABLE `stars`(
`id` INT(5) NOT NULL AUTO_INCREMENT COMMENT'序号',
`name` VARCHAR(10) NOT NULL COMMENT'球星姓名',
`age` INT(3) NOT NULL COMMENT'年龄',
`teamid` INT(3) NOT NULL COMMENT'所属球队编号',
PRIMARY KEY(`id`),
KEY `FK_teamid`(`teamid`),
CONSTRAINT `FK_teamid` FOREIGN KEY (`teamid`) REFERENCES `NBAteams` (`teamid`)
)ENGINE = INNODB DEFAULT CHARSET=utf8

-- 查看数据库定义
SHOW CREATE DATABASE NBA;

-- 查看数据表定义
SHOW CREATE TABLE stars; # 结果是整个create关键词后的语句

-- 查看表的列属性
DESCRIBE stars;

-- 修改数据表名
ALTER TABLE stars RENAME AS NBAstars;

-- 添加字段,ADD关键字后跟create的一项即可
ALTER TABLE NBAstars ADD `avgscore` INT(10) NOT NULL COMMENT'场均得分';

-- 修改字段
ALTER TABLE NBAstars MODIFY `avgscore` INT(5) NOT NULL DEFAULT 10;

-- 将旧的字段整体替换成新的字段
ALTER TABLE NBAstars CHANGE `avgscore` `avgpoints` INT(3) NOT NULL DEFAULT 15;

-- 删除字段
ALTER TABLE NBAstars DROP `avgpoints`;

-- 删除表
DROP TABLE 表名



-- ***************************************************************************************** --


-- 3. 表关联，外键

-- 什么是外键：两个相互关联的表，某字段是表1的主键，是表2的某个字段，两个表可以通过该字段相关关联起来(join on t1.字段=t2.字段)，则该字段称为表2的外键

-- 外键的创建方法 创建表的时候 创建表以后使用alter修改指定外键


-- 如果想要修改字段名，需要将后面的必要信息添加上
ALTER TABLE nbastars CHANGE team_id teamid INT(3) NOT NULL 


-- 类似于下面这样
ALTER TABLE NBAstars CHANGE `avgscore` `avgpoints` INT(3) NOT NULL DEFAULT 15;

-- 注意：声明外键关联是在外键所在的表内声明，而不是在将相同字段作为主键的表内声明

# 创建球队表
CREATE TABLE NBAteams(
`teamid` INT(3) NOT NULL AUTO_INCREMENT,
`teamname` VARCHAR(20) NOT NULL,
PRIMARY KEY(`teamid`)
)

-- 在关联的表分别创建之后，使用alter添加外键关联
ALTER TABLE `nbastars`
ADD CONSTRAINT `FK_teamid` FOREIGN KEY (`teamid`) REFERENCES `NBAteams` (`teamid`);

-- 具有外键关联的两个表，需要先删除从表(外键所在的表)，再删除主表
-- 同理，创建两个相互关联的表，需要先创建主表（主键所在的表），再创建从表

-- 删除外键
ALTER TABLE NBAstars DROP FOREIGN KEY `FK_teamid`; -- 这里的FK_teamid是外键的别名

-- 删除外键以后，还存在默认生成的所用，需要手动删除
ALTER TABLE NBAstars DROP INDEX FK_teamid;


DESCRIBE NBAteams
-- 插入数据，insert
-- 语法 insert into 表明（字段名1,字段名2） valuse(值1,值2)
-- 其中字段名可以省略不写，但values部分需要跟字段一一对应

INSERT INTO NBAteams VALUES(1,'lakers')

INSERT INTO NBAteams (`teamid`,`teamname`) VALUES(2, 'nets')

-- 同时插入多条数据
INSERT INTO NBAteams VALUES(3,'heat'),(4,'bulls')


SELECT * FROM NBAteams

-- 修改数据
UPDATE NBAteams SET teamname='worriors' WHERE teamid=1

-- 删除数据,如不指定筛选条件，将删去整个表，自增值不会重置
DELETE FROM nbateams WHERE teamid = 1

-- truncate 用于清空数据表，但保持表结构，索引，约束, 但自增值会重置，不记录日志





-- ***************************************************************************************** --
-- 4. 数据查询语言
-- SQL语句的核心部分，在牛客网上进行进一步巩固和整理
-- 一些常见的问题  七种join: full outer jion是求并集(如果不清晰，查看菜鸟教程经典图示)




-- ***************************************************************************************** --
-- 5. 常用SQL函数熟悉

-- 操作数据函数 其实基本上和python中的关键字是差不多的
SELECT ABS(-5); -- 绝对值

SELECT CEIL(5.2)

SELECT FLOOR(5.2) 

SELECT ROUND(15.36, 1) -- 舍去小数(四舍五入原则)

SELECT RAND(6)  -- 取随机数

SELECT SIGN(5) -- 查看输入参数的符号，负数返回-1，正数返回1,0返回0


-- 字符串处理函数(常用)

SELECT CHAR_LENGTH('许滔滔一定可以的') -- 字符串长度

SELECT CONCAT('许滔滔','希崎杰西卡') -- 合并字符串

SELECT INSERT('许滔滔',1,3,'希崎杰西卡') -- 抹去 i-j 之间的字符后，整体替换

SELECT LEFT('kobe bryant', 4) -- 左侧截取

SELECT RIGHT('kobe bryant', 5) -- 右侧截取

SELECT REPLACE('kobe bryant', 'b', 'a') -- 要替换的字符串， 被替换的字符串， 替换的字符串

SELECT SUBSTR('kobe', 1,4) -- 截取子串，i-j位置

-- 其余如果在刷题中遇到，可以在此积累

-- 索引，事务等高阶内容单独总结

-- 用户及权限管理

CREATE USER 用户名 IDENTIFIED BY [PASSWORD] 密码(字符串) -- 增加新的用户

SET PASSWORD = PASSWORD('123456') -- 密码重置


