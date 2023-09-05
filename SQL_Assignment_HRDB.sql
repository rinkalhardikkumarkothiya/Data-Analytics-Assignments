create database hrdb;
use hrdb;
select * from countries ;
select * from departments ;  ;
select * from employees;
select * from jobs ;
select * from job_history;
select * from locations ;
select * from regions ;

/*-----ASSIGNMENT (bassic)------*/

/*----Database Name: HR-----*/


/*1.------- Display all information in the tables EMP and DEPT. */
select*from employees inner join departments on employees.department_id=departments.department_id;
select*from employees;
select*from departments;

/*2. ------Display only the hire date and employee name for each employee.*/ 
select hire_date,concat(first_name," ",last_name)as"employee_name"
from employees;

/*3.------ Display the ename concatenated with the job ID, separated by a comma and space, and*/ 
/*name the column Employee and Title */
select concat(first_name," ",last_name," , ",job_id)as "employee_and_title" 
from employees;

/*4.----- Display the hire date, name and department number for all clerks. */
select hire_date,concat(first_name," ",last_name)as "name",department_id as "department_number"
from employees left join jobs on employees.job_id=jobs.job_id 
where job_title like "%clerk%";
 
 select hire_date,concat(first_name," ",last_name)as "name",department_id as "department_number"
 from employees
 where job_id in(select job_id from jobs where job_title like "%clerk%");
 
/*5.--------- Create a query to display all the data from the EMP table. Separate each column by a */
/*comma. Name the column THE OUTPUT */
select concat_ws(" , ",first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,
manager_id,department_id)as "the_output"
from employees; 

/*6.----- Display the names and salaries of all employees with a salary greater than 2000. */
select concat_ws(" ",first_name,last_name)as"names",salary 
from employees where salary >=2000;


/*7. ---------Display the names and dates of employees with the column headers "Name" and "Start */
/*Date" */
select concat_ws(" ",first_name,last_name)as "name",hire_date as"start_date"
from employees;


/*8.----- Display the names and hire dates of all employees in the order they were hired. */
select concat_ws(" ",first_name,last_name)as "names",hire_date
from employees 
order by hire_date;


/*9.------Display the names and salaries of all employees in reverse salary order.*/ 
select concat_ws(" ",first_name,last_name)as"names",salary 
from employees
order by salary desc;

/*-------10. Display 'ename" and "deptno" who are all earned commission and display salary in */
/*reverse order.*/ 
select concat(first_name," ",last_name)as "ename",department_id as"deptno",salary 
from employees 
where not commission_pct ="null"
order by salary desc;
select first_name as names ,department_id, count(salary)
from employees
group by  commission_pct
order by  count(salary) desc;

/*11.-------- Display the last name and job title of all employees who do not have a manager */
select e.last_name , j.job_title, j.job_id
from employees e
join jobs j
on e.job_id=j.job_id
where  job_title not like "%manager%" ; 

select last_name,job_id
from employees
where job_id in(select job_id from jobs where job_title not like "%manager%");
 
/*------12. Display the last name, job, and salary for all employees whose job is sales representative */
/*or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000*/ 
select last_name,job_title,salary 
from employees
left join jobs on employees.job_id=jobs.job_id
where job_title ="sales representative" or job_title= "stock clerk"and salary not in (2500,3500,5000);


/*-----Database Name: HR-----------*/
/*1)------- Display the maximum, minimum and average salary and commission earned. */
select max(salary)as"maximum salary",min(salary)as "minimum salary",avg(salary)as "average salary",
max(commission_pct)as "maximum commission",min(commission_pct)as "minimum commission",
avg(commission_pct)as "average commisssion" 
from employees;

/*2)------ Display the department number, total salary payout and total commission payout for */
/*each department.*/ 
select department_id as "department number",sum(salary)as"total salary payout",sum(commission_pct)
as"total commission payout"from employees
group by department_id;

/*3)----- Display the department number and number of employees in each department. */
select department_id as "department number",employee_id as "number of employees"
from employees
group by department_id;

/*4)---- Display the department number and total salary of employees in each department. */
select department_id as "department number",sum(salary)as "total salary of employees"
from employees
group by department_id;

/*5)------ Display the employee's name who doesn't earn a commission. Order the result set 
without using the column name*/
select concat_ws(" ",first_name,last_name)as "employees name",commission_pct
from employees
where  commission_pct is null;

/*6)------ Display the employees name, department id and commission. If an Employee doesn't 
earn the commission, then display as 'No commission'. Name the columns appropriately */
select concat_ws(" ",first_name,last_name)as "employees name",department_id,
case
    when commission_pct is null then "no commission"
    else commission_pct
end as commission    
from employees;

/*7)----- Display the employee's name, salary and commission multiplied by 2. If an Employee */
/*doesn't earn the commission, then display as 'No commission. Name the columns */
/*appropriately*/
select concat_ws(" ",first_name,last_name)as "employees name",salary,
case
    when commission_pct is null then "no commission"
    else commission_pct*2
end as commission    
from employees;

/*8)------ Display the employee's name, department id who have the first name same as another */
/*employee in the same department*/
     select   concat(first_name,"  ",last_name) as employee_Name, department_id,
	(select department_name from departments d
	 where e.department_id = d.department_id) department 
	 from employees e 
	 order by department;

/*9)------- Display the sum of salaries of the employees working under each Manager. */
select sum(salary)as"sum of salaries of the employees",job_title
from employees
left join jobs on employees.job_id=jobs.job_id
where job_title like"%manager%";

select SUM(salary) , j.job_title
	from employees e
    join jobs j
    on e.job_id=j.job_id
	where job_title ='Stock Manager';


/*10) -------Select the Managers name, the count of employees working under and the department */
/*ID of the manager. */
select concat(first_name," ", last_name)as "employee name" , department_id,job_title
from employees
left join jobs on employees.job_id=jobs.job_id
where job_title like "%manager%";

/*11) --------Select the employee name, department id, and the salary. Group the result with the */
/*manager name and the employee last name should have second letter 'a! */
select concat(first_name," ", last_name)as "employee name" , department_id, salary 
from employees 
where last_name like "_a%";

/*12)----- Display the average of sum of the salaries and group the result with the department id. */
/*Order the result with the department id. */
select department_id, avg(salary),sum(salary)
	from employees 
	group by department_id;

/*13) ------Select the maximum salary of each department along with the department id */
select department_id, max(salary) 
from employees
group by department_id;

/*14)------ Display the commission, if not null display 10% of salary, if null display a default value 1*/
select commission_pct,
case
    when commission_pct IS NULL then '1'
    else salary*0.10
end as commission    
from employees;


/*-------Database Name: HR ------*/
/*1.------- Write a query that displays the employee's last names only from the string's 2-5th*/
/*position with the first letter capitalized and all other letters lowercase, Give each column an */
/*appropriate label.*/
select concat(upper(substring(last_name,2,1)),lower(substring(last_name,2,5)))
    from employees;
    

/*2. ------Write a query that displays the employee's first name and last name along with a " in */
/*between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the */
/*month on which the employee has joined.*/
select concat(first_name,"-",last_name),monthname(hire_date)as"month"
from employees;

/*3.------ Write a query to display the employee's last name and if half of the salary is greater than */
/*ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of */
/*1500 each. Provide each column an appropriate label. */
select last_name , if ((salary/2)>10000,(salary+salary*0.10)+1500,(salary+salary*11.5/100)+1500)
from employees;

/*4.----- Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, */
/*department id, salary and the manager name all in Upper case, if the Manager name */
/*consists of 'z' replace it with '$! */
select concat_ws(" ",substr(E.employee_id,1,2),0,0,substr(E.employee_id,3,1),"E") as employee, E.department_id,E.salary,
replace(concat_ws(" ",upper(M.first_name),upper(M.last_name)),"z","$")as "manager name"
from employees E left join employees M on M.employee_id = E.manager_id;

/*5.------ Write a query that displays the employee's last names with the first letter capitalized and */
/*all other letters lowercase, and the length of the names, for all employees whose name */
/*starts with J, A, or M. Give each column an appropriate label. Sort the results by the */
/*employees' last names */
select last_name,concat(upper(substring(last_name,1,1)),lower(substring(last_name,2))) 
as "capitalized",length(last_name)as"length"
from employees
where last_name like "A%"or last_name like  "J%" or last_name like   "M%"
order by last_name;

/*6.------ Create a query to display the last name and salary for all employees. Format the salary to */
/*be 15 characters long, left-padded with $. Label the column SALARY */
select last_name,lpad(salary,15,'$')as "SALARY" from employees;

/*7. -------Display the employee's name if it is a palindrome */
select first_name from employees where first_name =reverse(first_name);

/*8.------ Display First names of all employees with initcaps. */
select upper(first_name) 
	from employees;

/*9.------- From LOCATIONS table, extract the word between first and second space from the */
/*STREET ADDRESS column. */
select concat("_","_",street_address) as STREET_ADDRESS
	from locations;


/*10.------ Extract first letter from First Name column and append it with the Last Name. Also add */
/*"@systechusa.com" at the end. Name the column as e-mail address. All characters should */
/*be in lower case. Display this along with their First Name. */
select first_name ,lower(concat_ws(" ",(substring(first_name,1,1)),last_name,"@systechusa.com"))
as "e-mail address" from employees;

/*11.------- Display the names and job titles of all employees with the same job as Trenna. */
select concat(first_name," ",last_name)as "names",job_title from employees left join jobs 
on employees.job_id=jobs.job_id
where job_title like "%sales representative%";


/*12.------- Display the names and department name of all employees working in the same city as */
/*Trenna. */
select concat_ws(" ",first_name,last_name)as "names",department_name,city from departments  join employees 
on departments.department_id=employees.department_id join locations on departments.location_id=locations.location_id
where city like"%toronto%";


/*13.------ Display the name of the employee whose salary is the lowest. */
select concat(first_name," ",last_name) as "name"from employees
where salary=(select min(salary)as "minimum salary" from employees);

/*14------ Display the names of all employees except the lowest paid.*/
select concat_ws(" ",first_name,last_name)as "names" from employees
where salary >(select min(salary)from employees);

/*-----Database Name: HR-----*/
/*1. ------Write a query to display the last name, department number, department name for all */
/*employees. */
select e.last_name, e.department_id as "department_number",d.department_name from employees e left join 
departments d on e.department_id=d.department_id;

/*2.----- Create a unique list of all jobs that are in department 4. Include the location of the */
/*department in the output. */
select distinct job_id, location_id
	from employees, departments
	where employees.department_id = departments.department_id
	and employees.department_id = 4;
    
/*3.------ Write a query to display the employee last name,department name,location id and city of */
/*all employees who earn commission. */
select e.last_name,d.department_name,l.location_id,l.city from departments d left join employees e
on d.department_id=e.department_id left join locations l 
on d.location_id=l.location_id
where commission_pct is not null;

/*4.------- Display the employee last name and department name of all employees who have an 'a' */
/*in their last name */
select e.last_name,d.department_name from employees e left join departments d on e.department_id=d.department_id
where last_name like "%a%";

/*5.----- Write a query to display the last name,job,department number and department name for */
/*all employees who work in ATLANTA. */
select e.last_name,e.job_id,d.department_id as "department number",d.department_name ,l.city from departments d
left join employees e on d.department_id=e.department_id left join locations l on d.location_id=l.location_id
where city like "%toronto%";

/*6.------- Display the employee last name and employee number along with their manager's last */
/*name and manager number. */
select e.last_name as emp_name, e.employee_id as emp_id ,m.last_name as Manager , m.employee_id as m_id
	from employees e join employees m
	on(e.manager_id = m.employee_id);

/*7.------- Display the employee last name and employee number along with their manager's last */
/*name and manager number (including the employees who have no manager). */
select  e.last_name as "employee last name",e.employee_id as"employee number",m.last_name as "manager name",
m.manager_id as "manager number" 
from employees e join employees m on m.employee_id=e.manager_id;
 
/*8.------ Create a query that displays employees last name,department number,and all the */
/*employees who work in the same department as a given employee. */
select  e.last_name as "employees last name",e.department_id as "department number",d.department_name from employees e 
left join departments d on e.department_id=d.department_id;


/*9. ------Create a query that displays the name,job,department name,salary,grade for all */
/*employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) */
select concat(first_name," ",last_name)as "name",job_id,department_name,salary,
case
    when salary >=5000 then "A"
    when salary >=3000 then "B"
    else "C"
end as "grade based on salary"
from employees left join  departments on employees.department_id=departments.department_id;  

/*10.----- Display the names and hire date for all employees who were hired before their */
/*managers along withe their manager names and hire date. Label */
select e.first_name as  "E names",e.hire_date as "E hire date",m.first_name as "M name",m.hire_date as "M hire date"
from employees e 
inner join employees m on e.manager_id=m.employee_id where m.hire_date > e.hire_date;
	/*------Database Name: HR------*/
/*1.------ Write a query to display the last name and hire date of any employee in the same */
/*department as SALES. */
select e.last_name, e.hire_date
from employees e left join departments d on e.department_id=d.department_id
where department_name like "%sales%";
    
/*2.------- Create a query to display the employee numbers and last names of all employees who */
/*earn more than the average salary. Sort the results in ascending order of salary. */
select employee_id as "employee number" ,last_name,salary
	from employees
	where salary > (select avg(salary) from employees)
	order by salary asc;

/*3.-------- Write a query that displays the employee numbers and last names of all employees who */
/*work in a department with any employee whose last name contains a' u */
select employee_id, last_name
from employees
where department_id in (select department_id from employees where last_name like "%u%");

/*4.------- Display the last name, department number, and job ID of all employees whose */
/*department location is ATLANTA. */
 select last_name, department_id, job_id
	from employees
	where department_id in (select department_id from departments where location_id = 1700);

/*5. -------Display the last name and salary of every employee who reports to FILLMORE. */
select last_name, salary
	from employees
	where manager_id = (select employee_id from employees where last_name = "king");


/*6.------ Display the department number, last name, and job ID for every employee in the */
/*OPERATIONS department. */
select department_id, last_name, job_id
	from employees
	where department_id in (select department_id from departments where department_name = "IT");
    
/*7.----- Modify the above query to display the employee numbers, last names, and salaries of all */
/*employees who earn more than the average salary and who work in a department with any */
/*employee with a 'u'in their name. */
select employee_id, last_name, salary
	from employees
	where department_id in (select department_id from employees where last_name like "%u%")
	and salary > (select avg(salary)from employees);

/*8.------- Display the names of all employees whose job title is the same as anyone in the sales */
/*dept. */
select concat(first_name," ",last_name)as "names",job_title from employees left join jobs on employees.job_id=jobs.job_id
where job_title like "%sales%";

/*9.------- Write a compound query to produce a list of employees showing raise percentages, */
/*employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, */
/*employees in department 2 are given a 10% raise, employees in departments 4 and 5 are */
/*given a 15% raise, and employees in department 6 are not given a raise. */
select '05% raise' raise, employee_id, salary, 
salary *.05 new_salary
from  employees
where  department_id IN (1,3)
union
select '10% raise', employee_id, salary, salary * .10
from   employees
where  department_id = 2
union
select '15% raise', employee_id, salary, salary * .15 
from   employees
where  department_id IN (4,5)
union
select 'no raise', employee_id, salary, salary
from employees
where  department_id = 6;

/*10.-------- Write a query to display the top three earners in the EMPLOYEES table. Display their last */
/*names and salaries. */
select last_name,salary
	from employees
	order by salary desc limit 3;

/*11. --------Display the names of all employees with their salary and commission earned. Employees */
/*with a null commission should have O in the commission column */
select  concat(first_name,"  ",last_name) as employee_Name, 
case 
when commission_pct is NULL then '0' 
else commission_pct 
end as commission, salary
	from employees ;
    

/*12.------ Display the Managers (name) with top three salaries along with their salaries and */
/*department information.*/
select  m.last_name as "manager name",e.salary,e.department_id
from employees e join employees m on m.employee_id=e.manager_id
order by  salary desc limit 3;




/*---Date Function------*/
/*1) Find the date difference between the hire date and resignation_date for all the */
/*employees. Display in no. of days, months and year(1 year 3 months 5 days).*/
/*Emp_ID Hire Date Resignation_Date*/
/*1 1/1/2000 7/10/2013*/
/*2 4/12/2003 3/8/2017*/
/*3 22/9/2012 21/6/2015*/
/*4 13/4/2015 NULL*/
/*5 03/06/2016 NULL*/
/*6 08/08/2017 NULL*/
/*7 13/11/2016 NULL */
/*2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, */
/*yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900) */
/*3) Calcuate experience of the employee till date in Years and months(example 1 year and 3 */
/*months) */
/*Use Getdate() as input date for the below three questions. */
/*4) Display the count of days in the previous quarter */
/*5) Fetch the previous Quarter's second week's first day's date */
/*6) Fetch the financial year's 15th week's dates (Format: Mon DD YYYY) */
/*7) Find out the date that corresponds to the last Saturday of January, 2015 using with */
/*clause. */
/*Use Airport database for the below two question:*/
/*8) Find the number of days elapsed between first and last flights of a passenger.*/
/*9) Find the total duration in minutes and in seconds of the flight from Rostov to Moscow*/