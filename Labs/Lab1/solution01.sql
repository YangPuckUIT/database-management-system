CREATE DATABASE Assignment1;
GO
USE Assignment1;
GO


CREATE TABLE Supplier (
    SNO VARCHAR(10) PRIMARY KEY,
    SName VARCHAR(50) NOT NULL,
    Status INT,
    City VARCHAR(50)
);


CREATE TABLE Part (
    PNO VARCHAR(10) PRIMARY KEY,
    PName VARCHAR(50) NOT NULL,
    Color VARCHAR(20),
    Weight DECIMAL(5,2),
    City VARCHAR(50)
);


CREATE TABLE Project (
    JNO VARCHAR(10) PRIMARY KEY,
    JName VARCHAR(50) NOT NULL,
    City VARCHAR(50)
);


CREATE TABLE Shipment (
    SNO VARCHAR(10) NOT NULL,
    PNO VARCHAR(10) NOT NULL,
    Qty INT CHECK (Qty > 0), 
    PRIMARY KEY (SNO, PNO),
    FOREIGN KEY (SNO) REFERENCES Supplier(SNO),
    FOREIGN KEY (PNO) REFERENCES Part(PNO)
);


CREATE TABLE Shipment_for_Project (
    SNO VARCHAR(10) NOT NULL,
    PNO VARCHAR(10) NOT NULL,
    JNO VARCHAR(10) NOT NULL,
    Qty INT CHECK (Qty > 0),
    PRIMARY KEY (SNO, PNO, JNO),
    FOREIGN KEY (SNO) REFERENCES Supplier(SNO),
    FOREIGN KEY (PNO) REFERENCES Part(PNO),
    FOREIGN KEY (JNO) REFERENCES Project(JNO)
);


ALTER TABLE Part
ADD CONSTRAINT chk_bolt_city CHECK (
    (PName = 'Bolt' AND City = 'Paris') OR (PName <> 'Bolt')
);


INSERT INTO Supplier VALUES
('S1', 'Smith', 20, 'London'),
('S2', 'Jones', 10, 'Paris'),
('S3', 'Blake', 30, 'Paris'),
('S4', 'Clark', 20, 'London'),
('S5', 'Adams', 30, 'Athens');


INSERT INTO Part VALUES
('P1', 'Nut', 'Red', 12.0, 'London'),
('P2', 'Bolt', 'Green', 17.0, 'Paris'),
('P3', 'Screw', 'Blue', 17.0, 'Oslo'),
('P4', 'Screw', 'Red', 14.0, 'London'),
('P5', 'Cam', 'Blue', 12.0, 'Paris'),
('P6', 'Cog', 'Red', 19.0, 'London');


INSERT INTO Shipment VALUES
('S1', 'P1', 300),
('S1', 'P2', 200),
('S1', 'P3', 400),
('S1', 'P4', 200),
('S1', 'P5', 100),
('S1', 'P6', 100),
('S2', 'P1', 300),
('S2', 'P2', 400),
('S3', 'P2', 200),
('S4', 'P2', 200),
('S4', 'P4', 300),
('S4', 'P5', 400);


SELECT * FROM Supplier;
SELECT * FROM Part;
SELECT * FROM Shipment;
