
CREATE TABLE "Department" (
    "Dept_Number" VARCHAR(50)   NOT NULL,
    "Dept_Name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "Dept_Number"
     )
);

CREATE TABLE "Dept_Empt" (
    "Emp_Number" INTEGER   NOT NULL,
    "Dept_Number" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_Dept_Empt" PRIMARY KEY (
        "Emp_Number","Dept_Number"
     )
);

CREATE TABLE "Dept_Manager" (
    "Dept_Number" VARCHAR(50)   NOT NULL,
    "Emp_Number" INTEGER   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "Dept_Number","Emp_Number"
     )
);

CREATE TABLE "Employees" (
    "Emp_Number" INTEGER   NOT NULL,
    "Emp_Title" VARCHAR(50)   NOT NULL,
    "Birth_Date" date   NOT NULL,
    "First_Name" VARCHAR(50)   NOT NULL,
    "Last_Name" VARCHAR(50)   NOT NULL,
    "Sex" VARCHAR(50)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Emp_Number"
     )
);

CREATE TABLE "Salaries" (
    "Emp_Number" INTEGER   NOT NULL,
    "Salary" INTEGER   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "Emp_Number","Salary"
     )
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR(50)   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Dept_Empt" ADD CONSTRAINT "fk_Dept_Empt_Emp_Number" FOREIGN KEY("Emp_Number")
REFERENCES "Employees" ("Emp_Number");

ALTER TABLE "Dept_Empt" ADD CONSTRAINT "fk_Dept_Empt_Dept_Number" FOREIGN KEY("Dept_Number")
REFERENCES "Department" ("Dept_Number");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_Dept_Number" FOREIGN KEY("Dept_Number")
REFERENCES "Department" ("Dept_Number");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_Emp_Title" FOREIGN KEY("Emp_Title")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Emp_Number" FOREIGN KEY("Emp_Number")
REFERENCES "Employees" ("Emp_Number");


--1. List the following details of each employee: 
--employee number, last name, first name, sex, and salary.
-- First select employee number, first name, last name, sex from employees table

SELECT "Employees"."Emp_Number", "Employees"."First_Name", "Employees"."Last_Name", "Employees"."Sex", "Salaries"."Salary"
FROM "Employees"
JOIN public."Salaries"
ON ("Employees"."Emp_Number" = "Salaries"."Emp_Number");


-- . 2. List first name, last name, and hire date for 
--employees who were hired in 1986.
SELECT "Employees"."First_Name", "Employees"."Last_Name", "Employees"."Sex", "Employees"."hire_date"
FROM "Employees"
WHERE hire_date > '1985-12-31'
AND hire_date < '1987-01-01';

--3. List the manager of each department with the 
--following information: department number, 
--department name, the manager's employee number, 
--last name, first name.
SELECT "Dept_Manager"."Dept_Number", 
"Dept_Manager"."Emp_Number", 
"Employees"."Last_Name",
"Employees"."First_Name",
"Department"."Dept_Name"
FROM "Dept_Manager"
JOIN "Employees"
ON ("Employees"."Emp_Number" = "Dept_Manager"."Emp_Number")
JOIN "Department"
ON ("Department"."Dept_Number" = "Dept_Manager"."Dept_Number");

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT "Department"."Dept_Name",
public."Employees"."Emp_Number",
public."Employees"."Last_Name",
public."Employees"."First_Name"
FROM "Employees"
JOIN "Dept_Empt"
ON ("Dept_Empt"."Emp_Number" = "Employees"."Emp_Number")
JOIN "Department"
ON ("Dept_Empt"."Dept_Number" = "Department"."Dept_Number");


--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT "Employees"."Last_Name",
"Employees"."First_Name",
"Employees"."Sex"
FROM "Employees"
WHERE "Employees"."First_Name" = 'Hercules'
AND "Employees"."Last_Name" LIKE 'W%';

--6. List all employees in the Sales department, 
--including their employee number, last name, first name, 
--and department name.

SELECT 
"Employees"."Emp_Number",
"Employees"."Last_Name",
"Employees"."First_Name",
"Dept_Empt"."Dept_Number",
"Department"."Dept_Name"
FROM "Employees"
LEFT JOIN "Dept_Empt"
ON "Employees"."Emp_Number"="Dept_Empt"."Emp_Number"
INNER JOIN "Department"
ON "Department"."Dept_Number"="Dept_Empt"."Dept_Number"
WHERE "Department"."Dept_Name"='Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT 
"Employees"."Emp_Number",
"Employees"."Last_Name",
"Employees"."First_Name",
"Dept_Empt"."Dept_Number",
"Department"."Dept_Name"
FROM "Employees"
LEFT JOIN "Dept_Empt"
ON "Employees"."Emp_Number"="Dept_Empt"."Emp_Number"
INNER JOIN "Department"
ON "Department"."Dept_Number"="Dept_Empt"."Dept_Number"
WHERE "Department"."Dept_Name"='Sales' OR "Department"."Dept_Name"='Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT "Last_Name", COUNT(*) AS freq
FROM "Employees"
GROUP BY "Last_Name"
ORDER BY Freq DESC;