SELECT * FROM csv_table.`cran_logs_2015-01-01 (2)`;
-- 9.1 give the total number of recordings in this table
select count(*) FROM csv_table.`cran_logs_2015-01-01 (2)`;

 
-- 9.2 the number of packages listed in this table?
select count(distinct (package)) FROM csv_table.`cran_logs_2015-01-01 (2)`;

-- 9.3 How many times the package "Rcpp" was downloaded?
select count(*)   FROM csv_table.`cran_logs_2015-01-01 (2)` where package="RCPP";

-- 9.4 How many recordings are from China ("CN")?
select count(country) from csv_table.`cran_logs_2015-01-01 (2)` where country="CN";

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
select count(package) as pakage from csv_table.`cran_logs_2015-01-01 (2)` 
group by package 
order by package desc limit 2 ;       
	
-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
select a.package, count(*) 
from 
(select * from csv_table.`cran_logs_2015-01-01 (2)` 
	where 
		substr(time, 1, 5)<"11:00" 
        and 
        substr(time, 1, 5)>"09:00")
as a
group by a.package 
order by 2 desc;


-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
select  count(package) from csv_table.`cran_logs_2015-01-01 (2)` where country in ("CN","JP","SG") ;

-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
SELECT 
    TEMP.country
FROM
    (SELECT 
        country, COUNT(*) AS downloads
    FROM
         csv_table.`cran_logs_2015-01-01 (2)`
    GROUP BY country) AS TEMP
WHERE
    TEMP.downloads > (SELECT 
            COUNT(*)
        FROM
             csv_table.`cran_logs_2015-01-01 (2)`
        WHERE
            country = 'CN');
 
-- 9.9 Print the average length of the package name of all the UNIQUE packages
select avg(length (package)) from   csv_table.`cran_logs_2015-01-01 (2)`;

-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).

-- 9.11 Print the name of the package whose download count is bigger than 1000.
  SELECT package
FROM csv_table.`cran_logs_2015-01-01 (2)`
GROUP BY package
HAVING count(*) > 1000;

-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).



