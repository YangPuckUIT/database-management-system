									--question 1--
EXEC sp_help 's_dept';

SELECT * FROM s_dept;
SELECT * FROM s_customer;
									--question 2--
SELECT name, phone
FROM s_customer;
									--question 3--
SELECT phone, name --phone first
FROM s_customer;
									--question 4--
SELECT userid
FROM s_emp
WHERE id = '23';
									--question 5--
SELECT 
    first_name + ' ' + last_name AS Employees, --ghép họ và tên lại
    dept_id -- mã ID thuộc về first và last name hay còn đc gọi là Employees
FROM s_emp
WHERE dept_id IN ('10', '50')
ORDER BY last_name ASC;
									--question 6--
SELECT *
FROM s_emp
WHERE last_name LIKE '%s%';
									--question 7--
SELECT userid, CONVERT(date, start_date) AS start_date
FROM s_emp
WHERE start_date BETWEEN '1990-05-05' AND '1991-05-26'
ORDER BY start_date ASC;
									--question 8--
SELECT last_name, salary
FROM s_emp
WHERE salary < 1000 OR salary > 2500;
									--question 9--
SELECT 
    last_name AS "Employee Name",
    salary AS "Monthly Salary"
FROM s_emp
WHERE salary > 1350
AND dept_id IN (31, 42, 50);
									--question 10--
SELECT last_name, start_date
FROM s_emp
WHERE YEAR(start_date) = 1991;
									--question 11--
SELECT first_name + ' ' + last_name AS full_name
FROM s_emp
WHERE manager_id IS NULL;
									--question 12--
SELECT *
FROM s_product
WHERE name LIKE 'Pro%';
									--question 13--
SELECT name, short_desc
FROM s_product
WHERE short_desc LIKE '%bicycle%';
									--question 14--
SELECT short_desc
FROM s_product;
--So, question 13 returned all descriptions containing the word "bicycle" with no rows missing.
									--question 15--
SELECT 
    id AS Employee_Number, 
    last_name AS Last_Name, 
    salary * 1.15 AS Increased_Salary
FROM s_emp;
									--question 16--
SELECT 
    last_name + ' (' + title + ')' AS ThongTin_NhanVien
FROM s_emp;
									--question 17--
SELECT 
    last_name,
    FORMAT(start_date, 'd"th" "of" MMMM yyyy') AS Start_date,
    FORMAT(
        DATEADD(DAY,
            (9 - DATEPART(WEEKDAY, DATEADD(MONTH, 6, start_date))) % 7,
            DATEADD(MONTH, 6, start_date)
        ),
        'd"th" "of" MMMM yyyy'
    ) AS salary_review_date
FROM s_emp;
									--question 18--
SELECT name AS product_name
FROM s_product
WHERE name LIKE '%ski%';
									--question 20--
SELECT 
    last_name,
    DATENAME(WEEKDAY, start_date) AS day_started
FROM s_emp;
									--question 21--
SELECT 
    first_name + ' ' + last_name + ' earns $' + CAST(salary AS VARCHAR(10)) + 
    ' monthly but wants $' + CAST(salary * 3 AS VARCHAR(10)) AS employee_statement
FROM s_emp;
									--question 22--
SELECT 
    e.last_name,
    e.dept_id,
    d.name AS dept_name
FROM s_emp e
LEFT JOIN s_dept d
    ON e.dept_id = d.id;
									--question 23--
SELECT 
    e.last_name,
    d.name AS dept_name,
    r.name AS region_name
FROM s_emp e
LEFT JOIN s_dept d
    ON e.dept_id = d.id
LEFT JOIN s_region r
    ON d.region_id = r.id
WHERE e.commission_pct IS NOT NULL AND e.commission_pct > 0;
									--question 25--
SELECT 
    p.name AS product_name,
    i.product_id AS product_number,
    i.quantity AS ORDERED
FROM s_item i
JOIN s_product p
    ON i.product_id = p.id
WHERE i.ord_id = '101';
									--question 26--
SELECT 
    c.id AS customer_number,
    e.last_name AS sales_rep_last_name
FROM s_customer c
JOIN s_emp e
    ON c.sales_rep_id = e.id
ORDER BY e.last_name;
									--question 27--
SELECT 
    c.id AS customer_number,
    c.name AS customer_name,
    o.id AS order_number
FROM s_customer c
LEFT JOIN s_ord o
    ON c.id = o.customer_id
ORDER BY c.id;
									--question 28--
SELECT 
    e.id AS employee_number,
    e.last_name AS employee_last_name,
    m.id AS manager_number,
    m.last_name AS manager_last_name
FROM s_emp e
LEFT JOIN s_emp m
    ON e.manager_id = m.id
ORDER BY e.last_name;
									--question 29--
SELECT *
FROM s_emp
WHERE MANAGER_ID IS NULL;
									--question 30--
SELECT 
    c.id AS customer_id,
    c.name AS customer_name,
    i.product_id,
    i.quantity
FROM s_customer c
JOIN s_ord o ON c.id = o.customer_id
JOIN s_item i ON o.id = i.ord_id
WHERE o.customer_id IN (
    SELECT o2.customer_id
    FROM s_ord o2
    GROUP BY o2.customer_id
    HAVING SUM(o2.total) > 100000
)
ORDER BY c.id, i.product_id;
									--question 31--
SELECT 
    MAX(total) AS Highest,
    MIN(total) AS Lowest
FROM s_ord;
									--question 32--
SELECT 
    title AS Job_Type,
    MIN(salary) AS Min_Salary,
    MAX(salary) AS Max_Salary
FROM s_emp
GROUP BY title
ORDER BY title;
									--question 33--
SELECT COUNT(DISTINCT manager_id) AS Number_of_Managers
FROM s_emp
WHERE manager_id IS NOT NULL;
									--question 34--
SELECT 
    ord_id AS Order_Number,
    COUNT(*) AS [Number of Items]
FROM s_item
GROUP BY ord_id
ORDER BY ord_id;
									--question 35--
SELECT 
    MANAGER_ID,
    MIN(SALARY) AS [Lowest Subordinate Salary]
FROM 
    S_EMP
WHERE 
    MANAGER_ID IS NOT NULL
GROUP BY 
    MANAGER_ID
HAVING 
    MIN(SALARY) >= 1000
ORDER BY 
    [Lowest Subordinate Salary];
									--question 36--
SELECT 
    PRODUCT_ID,
    COUNT(*) AS [Times Ordered]
FROM 
    S_ITEM
GROUP BY 
    PRODUCT_ID
HAVING 
    COUNT(*) >= 3
ORDER BY 
    [Times Ordered] DESC;
									--question 37--
SELECT 
    r.id AS Region_Number,
    r.name AS Region_Name,
    COUNT(d.id) AS Number_of_Departments
FROM 
    s_region r
LEFT JOIN 
    s_dept d ON r.id = d.region_id
GROUP BY 
    r.id, r.name;
									--question 38--
SELECT 
    ord_id AS Order_ID,
    SUM(quantity) AS Total_Item_Count
FROM 
    s_item
GROUP BY 
    ord_id
HAVING 
    SUM(quantity) >= 100;
									--question 39--
SELECT 
    c.NAME AS Customer_Name,
    COUNT(o.ID) AS [Number of Orders]
FROM 
    S_CUSTOMER c
LEFT JOIN 
    S_ORD o ON c.ID = o.CUSTOMER_ID
GROUP BY 
    c.ID, c.NAME
ORDER BY 
    [Number of Orders] DESC;
									--question 40--
SELECT 
    first_name,
    last_name,
    start_date
FROM 
    s_emp
WHERE 
    dept_id = (
        SELECT dept_id 
        FROM s_emp 
        WHERE last_name = 'Magee'
    );
									--question 41--
SELECT 
    id AS employee_number,
    first_name,
    last_name,
    userid AS user_name
FROM 
    s_emp
WHERE 
    salary > (SELECT AVG(salary) FROM s_emp);
									--question 42--
SELECT 
    p.name,
    p.short_desc
FROM 
    s_product p
WHERE 
    p.id NOT IN (
        SELECT i.product_id
        FROM s_item i
        JOIN s_ord o ON i.ord_id = o.id
        WHERE o.date_ordered BETWEEN '1992-09-01' AND '1992-09-30'
    );
									--question 43--
SELECT 
    e.LAST_NAME AS [Sales Rep Last Name],
    c.NAME AS Customer_Name,
    SUM(o.TOTAL) AS [Total Sales Orders],
    CEILING(DATEDIFF(day, e.START_DATE, GETDATE()) / 30.0) AS [Months of Service (Rounded Up)]
FROM 
    S_EMP e
INNER JOIN 
    S_CUSTOMER c ON e.ID = c.SALES_REP_ID
LEFT JOIN 
    S_ORD o ON c.ID = o.CUSTOMER_ID
INNER JOIN 
    S_DEPT d ON e.DEPT_ID = d.ID 
WHERE 
    d.REGION_ID IN (1, 2)
GROUP BY 
    e.LAST_NAME, c.NAME, e.START_DATE
ORDER BY 
    e.LAST_NAME, c.NAME;