use hr;
create table employee (
emp_id int not null,
First_name varchar(50) not null ,
last_name varchar(50) not null , 
salary int not null , 
joining_Date  datetime not null ,
Department varchar(50) not null ,
primary key (emp_id));
describe employee;

insert into employee (emp_id,First_name,last_name,salary,joining_Date,Department)
values('001','Manish','Agarwal','700000','2019-04-20 09:00:00','HR');
insert into employee values('002','Niranjan','Bose','20000','2019-02-11 09:00:00','DA');
insert into employee values ('003','Vivek','Singh','100000','2019-01-20 09:00:00','DA');
insert into employee values ('004','Asutosh','Kapoor','700000','2019-03-20 09:00:00','HR');
insert into employee values ('005','Vihaan','Banerjee','300000','2019-06-11 09:00:00','DA');
insert into employee values ('006','Atul','Diwedi','400000','2019-05-11 09:00:00','Account');
insert into employee values ('007','Satyendra','Tripathi','95000','2019-03-20 09:00:00','Account');
insert into employee values ('008','Pritika','Bhatt','80000','2019-02-11 09:00:00','DA');
select*from employee;



create table variables_details(
emp_Ref_id int not null,
Variables_Date datetime not null , 
Variables_amount int not null,
foreign key(emp_Ref_id) references employee(emp_id)
);
insert into variables_details (emp_Ref_id,Variables_Date,Variables_amount) 
values ('1' , '2019-02-20 00:00:00' , '15000');
insert into variables_details values ('2','2019-06-11 00:00:00','30000');
insert into variables_details values ('3','2019-02-20 00:00:00','42000');
insert into variables_details values('4','2019-02-20 00:00:00' ,'14500');
insert into variables_details values ('5','2019-06-11 00:00:00','23500');

select *from variables_details;


create table Designation_table(
emp_Ref_id int not null ,
emp_title varchar(50) not null ,
Affected_from datetime not null ,
foreign key(emp_Ref_id) references employee(emp_id));


insert into  Designation_table (emp_Ref_id,emp_title,Affected_from) 
values ('1','Asst.Manager','2019-02-20 00:00:00'),
('2','Senior analyst','2019-01-11 00:00:00'),
('8','Senior analyst','2019-04-06 00:00:00'),
('5','Manager','2019-10-06 00:00:00'),
('4' , 'Asst.manager' , '2019-12-06 00:00:00'),
('7','Team lead' , '2019-06-06 00:00:00'),
('6','Team lead','2019-09-06 00:00:00'),
('3','Senior Analyst','2019-08-06 00:00:00');

select *from Designation_table;




create table Salary_Updation (
Emp_id int not null,
 Salary int not null , 
joining_Date  datetime not null ,
project char(2) not null,
foreign key(Emp_id) references employee(emp_id)
);

insert into Salary_Updation (Emp_id,salary,joining_Date,project)
values ('001','700000','2019-04-20 09:00:00','P1'),
('008','80000','2019-02-11 09:00:00' , 'P2'),
('003' , '100000' , '2019-01-20 09:00:00' , 'P3'),
('004' , '700000' , '2019-03-20 09:00:00' , 'P1'),
('005' , '300000','2019-06-11 09:00:00', 'P1'),
('004' , '570000' , '2019-01-20 09:00:00' , 'P4'),
('002' , '20000','2019-02-11 09:00:00' , 'P3'),
('008' , '68000' , '2019-01-11 09:00:00' , 'P2');

select*from Salary_Updation;

select concat(First_name,' ',last_name) as Fullname , Department,Variables_amount  from employee e join variables_details v on 
v.emp_Ref_id=e.emp_id where Variables_amount in('42000','14500') order by Variables_amount desc; #highest and lowest receiver of Variable_amount

create table employee_copy as
(SELECT * from employee where 1=2);

select  First_name, emp_title , (e.salary + Variables_amount) as VariableSalary from employee e, 
variables_details v, Designation_table d, Salary_Updation S where e.emp_id = v.emp_Ref_id and 
v.emp_Ref_id = d.emp_Ref_id and S.Emp_id = e.emp_id 
and First_name in ('Manish','Vivek') order by VariableSalary desc;  #highest and 2nd lowest salary 

select emp_id from employee; # emp_id from table employee

select * from employee where mod(emp_id,2)!=0 order by emp_id asc;

SELECT emp_id ,salary  as  "recent salary" , date_format(joining_Date , '%M %e, %Y') as date_column
from employee
group by emp_id; 

SELECT e.First_name , e.emp_id
FROM employee e 
LEFT JOIN Salary_Updation S  ON e.emp_id = S.Emp_id
WHERE S.project IS NULL; #Employee details who are not working on any project.

select  emp_id,First_name ,last_name, salary,joining_Date,Department ,
emp_Ref_id , emp_title,Affected_from
  from employee cross join Designation_table;
  
select  emp_id,First_name, emp_title,Affected_from ,Variables_amount  from Designation_table D, Employee e,variables_details v where D.emp_Ref_id = v.emp_Ref_id
and e.emp_id = v.emp_Ref_id
and emp_title like '%A%'and Affected_from >'2019-07-01'
order by Variables_amount desc ;

#Four joins 

#1)inner join-returns rows when there is a match in both tables.
 
 #2) left join-returns all rows from the left table, even if there are no matches in the right table. 

# 3)right join-returns all rows from the right table, even if there are no matches in the left table. 

#4)full join-returns rows when there is a match in one of the tables.

select concat(First_name,' ',last_name) as Fullname , Department,Variables_amount  from employee e right join variables_details v on 
v.emp_Ref_id=e.emp_id where Variables_amount in('42000','14500') order by Variables_amount desc; 

select  First_name, emp_title , (e.salary + Variables_amount) as VariableSalary from employee e inner join
variables_details v on e.emp_id = v.emp_Ref_id left join Designation_table d on e.emp_id = d.emp_Ref_id 
right join Salary_Updation S on S.Emp_id = e.emp_id 
and First_name in ('Manish','Vivek') order by VariableSalary desc; #used inner join to combine employee and variables_details and used left join to return of emp_dept

#cross join - CROSS JOIN returns the cartesian product of the sets of records from the two or more joined tables.
select  emp_id,First_name ,last_name, salary,joining_Date,Department ,
emp_Ref_id , emp_title,Affected_from
  from employee cross join Designation_table;
  
  
  # The select statement is used to get the required data from the database according to the conditions, if any. This data is returned in the form of a table
  # for example 
  select * from employee;
  
  #The where- clause is used to filter out data i.e it returns information that satisfies a certain condition
  
  select * from employee where emp_id = 1;
  
  # Group by - mostly used with aggregate functions to group the result set according to the value of a column
  
  select avg(salary) , department from employee group by department;
  
  # Having - used along with Group By clause because Where clause could not be used by aggregate functions
  
  select count(salary) , department from employee group by department having count(salary)>2;
 
 # Order by - used to sort the results in ascending or descending order
 
 select emp_id, First_name , salary from employee order by salary desc;
