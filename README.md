# LiveTrainStatus
# CS-F212 DBS Project Documentation

Project Name: DBS_PR_14 Live Train Running Status
Group No.: 75.
Team Member 1: Varun Sahni (2020A7PS0144P).
Team Member 2: Shivam Abhay Pande (2020A7PS0124P).

## 1. System Requirement Specifications (SRS)

**Required Softwares:** Required Softwares are listed below:

```
Frontend: Flutter
Backend: SQL, PHP.
```
## 2. System Modelling

**a. ER Diagram**
Entity-Relationship Diagram for the database design is given as follows:


**b. List of Tables Required**
List of Tables are as follows:
Train
Station
Delay
Schedule
Admin

**c. Schema Design**
1. Train Table

```
CREATE TABLE IF NOT EXISTS Train
(
ID INT NOT NULL,
Name VARCHAR(20) NOT NULL,
WorkingDays INT NOT NULL,
PRIMARY KEY (ID)
);
```
```
2. Station Table
```
```
CREATE TABLE IF NOT EXISTS Station
(
ID INT NOT NULL,
Name VARCHAR(20) NOT NULL,
City VARCHAR(20) NOT NULL,
PRIMARY KEY (ID)
);
```
```
3. Delay Table
```
```
CREATE TABLE IF NOT EXISTS Delay
(
Time INT NOT NULL,
ID INT NOT NULL AUTO_INCREMENT,
AdminID INT NOT NULL,
TrainID INT NOT NULL,
PRIMARY KEY (ID)
);
```

```
4. Schedule Table
```
```
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
```
```
5. Admin Table
```
```
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
```
**d. Data Normalization**
1. Train Table

```
Functional Dependency :.
Insertion, Deletion, Update Anamolies:.
Normal Form:.
2. Station Table
```
```
Functional Dependency :.
Insertion, Deletion, Update Anamolies:.
Normal Form:.
```
```
ID → Name , WorkingDays
None
4 NF
```
```
ID → Name , City
None
4 NF
```

```
3. Delay Table
```
```
Functional Dependency :.
Insertion, Deletion, Update Anamolies:.
Normal Form:.
4. Schedule Table
```
```
Functional Dependency :
.
Insertion, Deletion, Update Anamolies:.
Normal Form:.
5. Admin Table
```
```
Functional Dependency :
.
Insertion, Deletion, Update Anamolies:.
Normal Form:.
```
**e. Additional Components**
WorkingDays in Train Table is an integer as it is hashed using bitwise operations where Monday
represents 1, Tuesday represents 2, etc. This makes a multivalued attribute like WorkingDays
which would violate 1NF into 3NF and can be reverse engineered to find working days by bitwise
AND operation.
ID in Train Table is also hashed in a similar manner where the ID is the sum of all stations visited
like Station A represents 1, Station B represents 2, etc.

```
ID → Name , Time , AdminID , TrainID
None
4 NF
```
```
TrainID , StationID →
NextStationID , ArrivalTime , DepartureTime , Distance
None
3 NF
```
### ID →

```
Name , Password , Phone , Designation
None
4 NF
```

## 3. Limitations

```
1. As of now, no authentication service is used to verify log-ins to provide Admin access.
2. Delay function updates schedule for all dates and delay reversal is not optimal (add negative
minutes to delay to compensate).
3. Admin Privileges to add trains, stations and schdeules not implemented.
```
## 4. Future Work Possible Extending this Project

```
1. Adding guest log-in where a Guest can request delay entries and is to be verified by an Admin.
2. Delay function needs a re-work as well as additonal feature of location can be used based on EDA
of a station, ETA of next station and distance between them to interpolate and identify approximate
location.
3. Algorithms like Bellman-Ford or Djikstra can be used to find multiple options to travel from one
station to another.
4. Ticket Availability can be introduced as well as Booking consequently.
```
