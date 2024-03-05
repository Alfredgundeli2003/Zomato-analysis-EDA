use apple;
create table Dept ( deptno int primary key,
	dname varchar(20) not null,
    loc varchar(20));
    drop table Employee;
    
create table Employee( empno int,
	ename varchar(20) not null,
    job varchar(20) not null,
    mgr int , hiredate date,
    sal decimal(10, 2) default 0,
    comm decimal(10, 2),
    deptno int ,
    foreign key (deptno) references Dept(deptno));
    
insert into Dept( deptno, dname, loc) values
(10, 'OPERATIONS', 'BOSTON'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'ACCOUNTING', 'NEW YORK');
    
select * from Dept;
insert into Employee (empno, ename, job, mgr, hiredate, sal, comm, deptno) values
(7369, 'SMITH', 'CLERK', 7902, '1890-12-17', 800.00,NULL ,20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20), 
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400.00, 30), 
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30), 
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 2975.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30), 
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, NULL, 20), 
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30), 
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);

select * from Employee;

#Q1
select ename, sal from Employee where sal>1000.00;

#Q4
select * from Employee 
where hiredate < '1981-10-01';

#Q5
select ename from Employee
where substring(ename, 2,1 ) ='I';

#Q6
select ename, sal, sal*0.40 as Allowances, sal*0.1 as PF,
(sal+(sal*0.4)-sal*0.1) as net_salary
from Employee;

#Q7

SELECT e1.ename AS Employee_Name, e1.job AS Designation
FROM Employee e1
LEFT JOIN Employee e2 ON e1.empno = e2.mgr
WHERE e2.empno IS NULL;

#Q8
select empno, ename, sal from Employee order by sal asc;

#Q9
select count(distinct job) as total_jobs from Employee;

#Q10
select sum(sal) as Total_payble_Salary from Employee
where job = 'SALESMAN';

#Q11
select deptno,
       job,
       avg(sal) as average_monthly_salary
from Employee
group by deptno, job;

#Q12
select Employee.ENAME as empname, Employee.sal as salary, dept.dname as deptname
from Employee
join DEPT on Employee.deptno = dept.deptno;

#Q13
create table JobGrades (
  grade char(1) not null primary key,
  lowest_sal int not null,
  highest_sal int not null
);

insert into JobGrades (grade, lowest_sal, highest_sal)
values
  ('A', 0, 999),
  ('B', 1000, 1999),
  ('C', 2000, 2999),
  ('D', 3000, 3999),
  ('E', 4000, 5000);
  
select * from JobGrades;

#Q14

SELECT Employee.ENAME AS Last_Name, Employee.SAL AS Salary, GRADE.grade AS Corresponding_Grade
FROM Employee
JOIN JobGrades AS GRADE ON Employee.SAL BETWEEN GRADE.lowest_sal AND GRADE.highest_sal;

#q15
      select concat(Employee.ename, ' Report to ', manager.ename, '.') as "Emp Report to Mgr."
from Employee
left join Employee as manager on Employee.mgr = manager.empno;

#Q16
select ename as Empname, (sal+ifnull(comm, 0)) as 'Total Sal' from Employee;

#q17
SELECT ename AS Empname, sal AS Sal
FROM employee
WHERE empno % 2 != 0;

#q18
SELECT 
    ename AS Empname,
    (SELECT COUNT(*) FROM employee e2 WHERE e2.sal > e1.sal) + 1 AS Rank_in_Organisation,
    (SELECT COUNT(*) FROM employee e3 WHERE e3.sal > e1.sal AND e3.deptno = e1.deptno) + 1 AS Rank_in_Department
FROM 
    employee e1;
    
#Q19
SELECT ename AS Empname, sal AS Salary
FROM employee
ORDER BY sal DESC
LIMIT 3;

#Q20
SELECT e1.ename AS Empname, e1.deptno
FROM employee e1
JOIN (
    SELECT deptno, MAX(sal) AS max_sal
    FROM employee
    GROUP BY deptno
) e2 ON e1.deptno = e2.deptno AND e1.sal = e2.max_sal;
##OR##
#20 
SELECT e1.ename AS Empname, d.dname AS Department
FROM employee e1
JOIN dept d ON e1.deptno = d.deptno
JOIN (
    SELECT deptno, MAX(sal) AS max_sal
    FROM employee
    GROUP BY deptno
) e2 ON e1.deptno = e2.deptno AND e1.sal = e2.max_sal;




















    