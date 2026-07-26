CREATE DATABASE Assignment5;
GO

USE Assignment5;
GO

CREATE TABLE CUSTOMER (
    CUSTOMER_ID VARCHAR(10) PRIMARY KEY,
    FULL_NAME   VARCHAR(100) NOT NULL,
    ADDRESS     VARCHAR(200),
    PHONE       VARCHAR(15),
    DOB         DATE,
    TOTAL_SALES DECIMAL(15,2) DEFAULT 0,
    REG_DATE    DATE
);

CREATE TABLE EMPLOYEE (
    EMPLOYEE_ID VARCHAR(10) PRIMARY KEY,
    FULL_NAME   VARCHAR(100) NOT NULL,
    HIRE_DATE   DATE,
    PHONE       VARCHAR(15)
);

CREATE TABLE PRODUCT (
    PRODUCT_ID        VARCHAR(10) PRIMARY KEY,
    PRODUCT_NAME      VARCHAR(100) NOT NULL,
    UNIT              VARCHAR(20),
    COUNTRY_OF_ORIGIN VARCHAR(50),
    PRICE             DECIMAL(15,2) NOT NULL
);

CREATE TABLE INVOICE (
    INVOICE_NO   VARCHAR(10) PRIMARY KEY,
    INVOICE_DATE DATE,
    CUSTOMER_ID  VARCHAR(10),
    EMPLOYEE_ID  VARCHAR(10) NOT NULL,
    TOTAL_VALUE  DECIMAL(15,2),

    CONSTRAINT FK_INVOICE_CUSTOMER
        FOREIGN KEY (CUSTOMER_ID)
        REFERENCES CUSTOMER(CUSTOMER_ID),

    CONSTRAINT FK_INVOICE_EMPLOYEE
        FOREIGN KEY (EMPLOYEE_ID)
        REFERENCES EMPLOYEE(EMPLOYEE_ID)
);

CREATE TABLE INVOICE_DETAIL (
    INVOICE_NO VARCHAR(10),
    PRODUCT_ID VARCHAR(10),
    QUANTITY   INT NOT NULL,

    PRIMARY KEY (INVOICE_NO, PRODUCT_ID),

    CONSTRAINT FK_DETAIL_INVOICE
        FOREIGN KEY (INVOICE_NO)
        REFERENCES INVOICE(INVOICE_NO),

    CONSTRAINT FK_DETAIL_PRODUCT
        FOREIGN KEY (PRODUCT_ID)
        REFERENCES PRODUCT(PRODUCT_ID)
);

-- câu 1
ALTER TABLE PRODUCT
ADD CONSTRAINT CK_PRODUCT_PRICE
CHECK (PRICE >= 500);
-- câu 2
ALTER TABLE CUSTOMER
ADD CONSTRAINT CK_CUSTOMER_REG_DOB
CHECK (REG_DATE > DOB);
-- câu 3
CREATE TRIGGER TRG_INVOICE_DATE_CUSTOMER
ON INVOICE
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN CUSTOMER c ON i.CUSTOMER_ID = c.CUSTOMER_ID
        WHERE i.INVOICE_DATE <= c.REG_DATE
    )
    BEGIN
        RAISERROR ('Invoice date must be after customer registration date', 16, 1);
        ROLLBACK;
    END
END;
-- câu 4
CREATE TRIGGER TRG_INVOICE_DATE_EMPLOYEE
ON INVOICE
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN EMPLOYEE e ON i.EMPLOYEE_ID = e.EMPLOYEE_ID
        WHERE i.INVOICE_DATE <= e.HIRE_DATE
    )
    BEGIN
        RAISERROR ('Invoice date must be after employee hire date', 16, 1);
        ROLLBACK;
    END
END;
-- câu 5
CREATE TRIGGER TRG_UPDATE_CUSTOMER_TOTAL_SALES
ON INVOICE
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE CUSTOMER
    SET TOTAL_SALES = ISNULL((
        SELECT SUM(TOTAL_VALUE)
        FROM INVOICE
        WHERE CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
    ), 0);
END;
-- câu 6
CREATE TRIGGER TRG_UPDATE_INVOICE_TOTAL
ON INVOICE_DETAIL
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE INVOICE
    SET TOTAL_VALUE = (
        SELECT SUM(d.QUANTITY * p.PRICE)
        FROM INVOICE_DETAIL d
        JOIN PRODUCT p ON d.PRODUCT_ID = p.PRODUCT_ID
        WHERE d.INVOICE_NO = INVOICE.INVOICE_NO
    )
    WHERE INVOICE_NO IN (
        SELECT INVOICE_NO FROM inserted
        UNION
        SELECT INVOICE_NO FROM deleted
    );
END;
-- For the MOOC Database in assignment 3
-- 7. The head of a faculty must be a lecturer of that faculty
CREATE TRIGGER TRG_FACULTY_HEAD_CHECK
ON faculty
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted f
        JOIN lecturer l ON f.Head_id = l.Lecturer_id
        WHERE l.Faculty_id <> f.Faculty_id
    )
    BEGIN
        RAISERROR ('Faculty head must be a lecturer of the same faculty', 16, 1);
        ROLLBACK;
    END
END;
-- 8. A student's class must be consistent with their enrollment duration
CREATE TRIGGER TRG_STUDENT_CLASS_CHECK
ON enrollment
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted e
        JOIN student s ON e.Student_number = s.Student_number
        JOIN section sec ON e.Section_identifier = sec.Section_identifier
        WHERE sec.Year <> (YEAR(e.Enrollment_date) + s.Class - 1)
    )
    BEGIN
        RAISERROR ('Student class is inconsistent with enrollment duration', 16, 1);
        ROLLBACK;
    END
END;
-- 9. The number of enrolled students of a section must not exceed the capacity of that section.
CREATE TRIGGER TRG_SECTION_CAPACITY_CHECK
ON enrollment
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM section s
        JOIN (
            SELECT Section_identifier, COUNT(*) AS TotalStudents
            FROM enrollment
            GROUP BY Section_identifier
        ) e ON s.Section_identifier = e.Section_identifier
        WHERE e.TotalStudents > s.Capacity
    )
    BEGIN
        RAISERROR ('Section capacity exceeded', 16, 1);
        ROLLBACK;
    END
END;
-- 10. A student must complete all prerequisites for a course before enrolling in its section.
CREATE TRIGGER TRG_PREREQUISITE_CHECK
ON enrollment
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted e
        JOIN section s ON e.Section_identifier = s.Section_identifier
        JOIN prerequisite p ON s.Course_number = p.Course_number
        WHERE NOT EXISTS (
            SELECT 1
            FROM grade_report gr
            JOIN section s2 ON gr.Section_identifier = s2.Section_identifier
            WHERE gr.Student_number = e.Student_number
              AND s2.Course_number = p.Prerequisite_course_number
        )
    )
    BEGIN
        RAISERROR ('Student has not completed all prerequisites', 16, 1);
        ROLLBACK;
    END
END;
