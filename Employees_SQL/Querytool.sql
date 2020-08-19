
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

SELECT public."Employees"."Emp_Number", public."Employees"."First_Name", public."Employees"."Last_Name", public."Employees"."Sex", public."Salaries"."Salary"
FROM public."Employees"
JOIN public."Salaries"
ON (public."Employees"."Emp_Number" = public."Salaries"."Emp_Number");

-- . 2. List first name, last name, and hire date for 
--employees who were hired in 1986.
SELECT public."Employees"."First_Name", public."Employees"."Last_Name", public."Employees"."Sex", public."Employees"."hire_date"
FROM public."Employees"
WHERE hire_date > '1985-12-31'
AND hire_date < '1987-01-01';

--3. List the manager of each department with the 
--following information: department number, 
--department name, the manager's employee number, 
--last name, first name.
SELECT public."Dept_Manager"."Dept_Number", 
public."Dept_Manager"."Emp_Number", 
public."Employees"."Last_Name",
public."Employees"."First_Name",
public."Department"."Dept_Name"
FROM public."Dept_Manager"
JOIN public."Employees"
ON (public."Employees"."Emp_Number" = public."Dept_Manager"."Emp_Number")
JOIN public."Department"
ON (public."Department"."Dept_Number" = public."Dept_Manager"."Dept_Number");

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT public."Department"."Dept_Name",
public."Employees"."Emp_Number",
public."Employees"."Last_Name",
public."Employees"."First_Name"
FROM public."Employees"
JOIN public."Dept_Empt"
ON (public."Dept_Empt"."Emp_Number" = public."Employees"."Emp_Number")
JOIN public."Department"
ON (public."Dept_Empt"."Dept_Number" = public."Department"."Dept_Number");


--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
