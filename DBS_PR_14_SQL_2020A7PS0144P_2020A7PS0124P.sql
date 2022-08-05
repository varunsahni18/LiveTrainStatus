/*Database*/
CREATE DATABASE IF NOT EXISTS railways;

USE railways;

/*Tables*/
CREATE TABLE IF NOT EXISTS Admin
(
  ID INT NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Password VARCHAR(20) NOT NULL,
  Phone NUMERIC(10),
  Designation VARCHAR(50),
  PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Station
(
  ID INT NOT NULL,
  Name VARCHAR(20) NOT NULL,
  City VARCHAR(20) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Train
(
  ID INT NOT NULL,
  Name VARCHAR(20) NOT NULL,
  WorkingDays INT NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Schedule
(
  ArrivalTime TIME,
  DepartureTime TIME,
  Distance INT,
  StationID INT NOT NULL,
  NextStationID INT,
  TrainID INT NOT NULL,
  FOREIGN KEY (StationID) REFERENCES Station(ID),
  FOREIGN KEY (NextStationID) REFERENCES Station(ID),
  FOREIGN KEY (TrainID) REFERENCES Train(ID)
);

CREATE TABLE IF NOT EXISTS Delay
(
  Time INT NOT NULL,
  ID INT NOT NULL AUTO_INCREMENT,
  AdminID INT NOT NULL,
  TrainID INT NOT NULL,
  PRIMARY KEY (ID)
);

/*Views*/
CREATE VIEW route AS
SELECT Station.Name 
FROM Schedule JOIN Station
ON Station.ID = Schedule.StationID
WHERE Schedule.TrainID = @TrainID
ORDER BY Schedule.ArrivalTime; 

CREATE VIEW etaeda AS
SELECT Train.Name AS Train, Schedule.ArrivalTime AS ETA, Schedule.DepartureTime AS EDA, Station.Name AS Station,
CASE
	WHEN Train.WorkingDays & POWER(2,(((DAYOFWEEK(CURDATE())-2)%7))) > 0 THEN 1
    ELSE 0
END AS Available
FROM Schedule JOIN Train
ON Train.ID = Schedule.TrainID
JOIN Station 
ON Station.ID = Schedule.StationID
ORDER BY Train.ID;

CREATE VIEW possroute AS
SELECT Train.Name AS TName, Station.Name AS SName, Schedule.ArrivalTime AS Time
FROM Schedule JOIN Train
ON Train.ID = Schedule.TrainID
JOIN Station 
ON Station.ID = Schedule.StationID
ORDER BY Train.ID; 

/*Insertion*/
INSERT INTO Admin VALUES(123, 'admin', 'password', 9876543210, 'Main Admin');
INSERT INTO Train VALUES(41, 'AD Express', 41);
INSERT INTO Train VALUES(259, 'AB Express', 66);
INSERT INTO Train VALUES(258, 'BI Express', 16);
INSERT INTO Train VALUES(354, 'BG Express', 36);
INSERT INTO Train VALUES(44, 'CF Express', 85);
INSERT INTO Train VALUES(148, 'CH Express', 127);
INSERT INTO Train VALUES(524, 'DJ Express', 9);
INSERT INTO Train VALUES(152, 'DE Express', 2);
INSERT INTO Train VALUES(145, 'EA Express', 17);
INSERT INTO Train VALUES(20, 'EC Express', 21);
INSERT INTO Train VALUES(544, 'FI Express', 42);
INSERT INTO Train VALUES(546, 'FB Express', 64);
INSERT INTO Train VALUES(232, 'GH Express', 4);
INSERT INTO Train VALUES(361, 'GA Express', 32);
INSERT INTO Train VALUES(644, 'HJ Express', 10);
INSERT INTO Train VALUES(168, 'HF Express', 74);
INSERT INTO Train VALUES(432, 'IE Express', 34);
INSERT INTO Train VALUES(296, 'ID Express', 69);
INSERT INTO Train VALUES(516, 'JC Express', 80);
INSERT INTO Train VALUES(620, 'JG Express', 68);
INSERT INTO Station VALUES(1, 'Station A', 'Ahmedabad');
INSERT INTO Station VALUES(2, 'Station B', 'Bangalore');
INSERT INTO Station VALUES(4, 'Station C', 'Chandigarh');
INSERT INTO Station VALUES(8, 'Station D', 'Delhi');
INSERT INTO Station VALUES(16, 'Station E', 'Ellenabad');
INSERT INTO Station VALUES(32, 'Station F', 'Faridabad');
INSERT INTO Station VALUES(64, 'Station G', 'Guwahati');
INSERT INTO Station VALUES(128, 'Station H', 'Hyderabad');
INSERT INTO Station VALUES(256, 'Station I', 'Indore');
INSERT INTO Station VALUES(512, 'Station J', 'Jammu');
INSERT INTO Schedule VALUES(NULL, '08:00', 350, 1, 32, 41);
INSERT INTO Schedule VALUES('12:30', '13:00', 50, 32, 8, 41);
INSERT INTO Schedule VALUES('13:30', NULL, NULL, 8, NULL, 41);
INSERT INTO Schedule VALUES(NULL, '06:00', 300, 1, 256, 259);
INSERT INTO Schedule VALUES('09:30', '10:00', 700, 256, 2, 259);
INSERT INTO Schedule VALUES('18:15', NULL, NULL, 2, NULL, 259);
INSERT INTO Schedule VALUES(NULL, '12:00', 700, 2, 256, 258);
INSERT INTO Schedule VALUES('21:30', NULL, NULL, 256, NULL, 258);
INSERT INTO Schedule VALUES(NULL, '00:00', 700, 2, 256, 354);
INSERT INTO Schedule VALUES('07:00', '07:30', 250, 256, 32, 354);
INSERT INTO Schedule VALUES('10:00', '11:00', 1200, 32, 64, 354);
INSERT INTO Schedule VALUES('23:00', NULL, NULL, 64, NULL, 354);
INSERT INTO Schedule VALUES(NULL, '16:00', 100, 4, 8, 44);
INSERT INTO Schedule VALUES('18:15', '18:30', 50, 8, 32, 44);
INSERT INTO Schedule VALUES('19:00', NULL, NULL, 32, NULL, 44);
INSERT INTO Schedule VALUES(NULL, '14:00', 65, 4, 16, 148);
INSERT INTO Schedule VALUES('15:10', '15:15', 30, 16, 128, 148);
INSERT INTO Schedule VALUES('15:45', NULL, NULL, 128, NULL, 148);
INSERT INTO Schedule VALUES(NULL, '07:00', 100, 8, 4, 524);
INSERT INTO Schedule VALUES('08:10', '08:30', 180, 4, 512, 524);
INSERT INTO Schedule VALUES('10:30', NULL, NULL, 512, NULL, 524);
INSERT INTO Schedule VALUES(NULL, '21:00', 40, 8, 128, 152);
INSERT INTO Schedule VALUES('21:40', '21:50', 30, 128, 16, 152);
INSERT INTO Schedule VALUES('22:30', NULL, NULL, 16, NULL, 152);
INSERT INTO Schedule VALUES(NULL, '12:30', 30, 16, 128, 145);
INSERT INTO Schedule VALUES('12:50', '13:00', 190, 128, 1, 145);
INSERT INTO Schedule VALUES('15:00', NULL, NULL, 1, NULL, 145);
INSERT INTO Schedule VALUES(NULL, '18:00', 50, 16, 4, 20);
INSERT INTO Schedule VALUES('18:45', NULL, NULL, 4, NULL, 20);
INSERT INTO Schedule VALUES(NULL, '13:00', 250, 32, 256, 544);
INSERT INTO Schedule VALUES('16:15', NULL, NULL, 256, NULL, 544);
INSERT INTO Schedule VALUES(NULL, '02:00', 250, 32, 256, 546);
INSERT INTO Schedule VALUES('05:40', '06:00', 700, 256, 2, 546);
INSERT INTO Schedule VALUES('15:00', NULL, NULL, 2, NULL, 546);
INSERT INTO Schedule VALUES(NULL, '05:00', 1200, 64, 32, 232);
INSERT INTO Schedule VALUES('16:00', '16:30', 50, 32, 8, 232);
INSERT INTO Schedule VALUES('17:30', '17:45', 40, 8, 128, 232);
INSERT INTO Schedule VALUES('18:30', NULL, NULL, 128, NULL, 232);
INSERT INTO Schedule VALUES(NULL, '01:00', 1300, 64, 8, 361);
INSERT INTO Schedule VALUES('13:00', '14:00', 50, 8, 32, 361);
INSERT INTO Schedule VALUES('14:30', '14:45', 250, 32, 256, 361);
INSERT INTO Schedule VALUES('18:00', '18:15', 350, 256, 1, 361);
INSERT INTO Schedule VALUES('23:15', NULL, NULL, 1, NULL, 361);
INSERT INTO Schedule VALUES(NULL, '17:00', 80, 128, 4, 644);
INSERT INTO Schedule VALUES('18:00', '18:20', 180, 4, 512, 644);
INSERT INTO Schedule VALUES('20:30', NULL, NULL, 512, NULL, 644);
INSERT INTO Schedule VALUES(NULL, '10:00', 40, 128, 8, 168);
INSERT INTO Schedule VALUES('10:40', '11:00', 50, 8, 32, 168);
INSERT INTO Schedule VALUES('12:00', NULL, NULL, 32, NULL, 168);
INSERT INTO Schedule VALUES(NULL, '17:00', 250, 256, 32, 432);
INSERT INTO Schedule VALUES('20:30', '21:00', 65, 32, 128, 432);
INSERT INTO Schedule VALUES('22:10', '22:30', 30, 128, 16, 432);
INSERT INTO Schedule VALUES('22:50', NULL, NULL, 16, NULL, 432);
INSERT INTO Schedule VALUES(NULL, '16:30', 250, 256, 32, 296);
INSERT INTO Schedule VALUES('20:00', '20:20', 50, 32, 8, 296);
INSERT INTO Schedule VALUES('21:00', NULL, NULL, 8, NULL, 296);
INSERT INTO Schedule VALUES(NULL, '08:30', 180, 512, 4, 516);
INSERT INTO Schedule VALUES('11:30', NULL, NULL, 4, NULL, 516);
INSERT INTO Schedule VALUES(NULL, '04:00', 180, 512, 4, 620);
INSERT INTO Schedule VALUES('06:45', '07:00', 100, 4, 8, 620);
INSERT INTO Schedule VALUES('08:30', '09:00', 50, 8, 32, 620);
INSERT INTO Schedule VALUES('09:45', '10:00', 1200, 32, 64, 620);
INSERT INTO Schedule VALUES('20:50', NULL, NULL, 64, NULL, 620);

/*DML*/
	/*Check if admin exists at the time of login*/
SELECT EXISTS (
  SELECT * FROM Admin WHERE ID = @AdminID AND Password = @Password
);

	/*Show details of Admin*/
SELECT * FROM Admin WHERE ID = @AdminID;

	/*Add delay details*/
INSERT INTO Delay(Time, AdminID, TrainID) VALUES(@Mins, @AdminID, @TrainID);
UPDATE Schedule
SET ArrivalTime = (ArrivalTime + interval @Mins minute ), DepartureTime = (DepartureTime + interval @Mins minute )
WHERE TrainID = @TrainID;

	/*Show Route*/
SELECT * FROM route;

	/*Train between relevant stations*/
SELECT p1.TName AS Train FROM possroute p1, possroute p2
WHERE (p1.SName = @Station1 AND p2.SName = @Station2 AND p1.Time<p2.Time AND p1.TName = p2.TName AND p1.TName = @TName);

	/*ETA and EDA*/
SELECT Station, ETA, EDA FROM etaeda
WHERE(Train = @TName AND Available > 0 AND CURRENT_TIME < CAST(ETA AS DATETIME));

/*Drop*/
DROP VIEW IF EXISTS route;
DROP VIEW IF EXISTS possroute;
DROP VIEW IF EXISTS etaeda;

DROP TABLE Admin;
DROP TABLE Station;
DROP TABLE Train;
DROP TABLE Schedule;
DROP TABLE Delay;

DROP DATABASE railways;