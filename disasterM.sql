-- ROLES TABLE
CREATE TABLE Roles (RoleID SERIAL PRIMARY KEY,RoleName VARCHAR(50) UNIQUE NOT NULL); 

INSERT INTO Roles (RoleName) VALUES ('Admin'), ('FieldAgent'), ('Analyst'), ('Public');

SELECT * FROM ROLES;

-- USERS TABLE
CREATE TABLE Users (UserID SERIAL PRIMARY KEY, Username VARCHAR(50) UNIQUE NOT NULL, Passwordd VARCHAR(255) NOT NULL,
FullName VARCHAR(100),RoleID INT  REFERENCES Roles(RoleID) ON DELETE CASCADE);

INSERT INTO Users (Username, Passwordd, FullName, RoleID) VALUES
('admin1', 'admin123', 'Josh Dsouza', 1),
('agent1', 'agent123', 'Sneha Shah', 2),
('analyst1', 'analyst123', 'Jimmy Shah', 3),
('agent2', 'ag9', 'Dhvija Doshi', 2),
('analyst2', 'anl39', 'Pooja Tiwari', 3),
('admin2', 'admin02', 'Maulik Salunkhe', 1),
('agent3', 'agent12', 'Niva Kapoor', 2),
('agent4', 'agent33', 'Akshay Kapoor', 2),
('analyst3', 'a12', 'Nitiksha Patel', 3),
('admin3', 'ad202', 'Krishna Desai', 1);

SELECT * FROM USERS; 

-- DISASTER TYPE TABLE
CREATE TABLE DisasterType (TypeID SERIAL PRIMARY KEY,TypeName VARCHAR(100) UNIQUE NOT NULL);

INSERT INTO DisasterType (TypeName) VALUES ('Flood'), ('Earthquake'), ('Cyclone'), ('Tsunami'), ('Wildfire'),
('Landslide'), ('Drought'), ('Heatwave'), ('Coldwave'), ('Thunderstorm'),('Hailstorm'), ('Chemical Spill'), 
('Pandemic'), ('Terror Attack'), ('Volcanic Eruption');

SELECT * FROM DisasterType; 

-- LOCATIONS TABLE
CREATE TABLE Locations (LocationID SERIAL PRIMARY KEY,City VARCHAR(100) NOT NULL,State VARCHAR(100) NOT NULL);

INSERT INTO Locations (City, State) VALUES ('Mumbai', 'Maharashtra'), ('Delhi', 'Delhi'), ('Bangalore', 'Karnataka'),
('Hyderabad', 'Telangana'), ('Ahmedabad', 'Gujarat'), ('Chennai', 'Tamil Nadu'),
('Kolkata', 'West Bengal'), ('Pune', 'Maharashtra'), ('Jaipur', 'Rajasthan'),
('Lucknow', 'Uttar Pradesh'), ('Kanpur', 'Uttar Pradesh'), ('Nagpur', 'Maharashtra'),
('Indore', 'Madhya Pradesh'), ('Bhopal', 'Madhya Pradesh'), ('Patna', 'Bihar'),
('Ludhiana', 'Punjab'), ('Agra', 'Uttar Pradesh'), ('Vadodara', 'Gujarat'),
('Nashik', 'Maharashtra'), ('Faridabad', 'Haryana'), ('Meerut', 'Uttar Pradesh'),
('Rajkot', 'Gujarat'), ('Amritsar', 'Punjab'), ('Varanasi', 'Uttar Pradesh'),
('Srinagar', 'Jammu and Kashmir');

SELECT * FROM Locations; 

-- DISASTERS TABLE 
CREATE TABLE Disasters (DisasterID SERIAL PRIMARY KEY,Title VARCHAR(100) NOT NULL,
TypeID INT  REFERENCES DisasterType(TypeID) ,TypeName VARCHAR(100) NOT NULL,Description TEXT,
DateReported DATE,
Status VARCHAR(50) NOT NULL CHECK (Status IN ('Active','Resolved','Ongoing','Warning','Critical','Under Control')));

INSERT INTO Disasters (Title, TypeID, TypeName, Description, DateReported, Status) VALUES
('Hailstorm in Indore', 11, 'Hailstorm', 'Damaged crops.', '2025-02-17', 'Resolved'),
('COVID-19 Outbreak in Pune', 13, 'Pandemic', 'Surge in cases.', '2020-04-05', 'Under Control'),
('Volcanic Activity in Andaman', 15, 'Volcanic Eruption', 'Tremors reported.', '2025-06-29', 'Active'),
('Tsunami Alert in Kolkata', 4, 'Tsunami', 'Tsunami warning issued.', '2025-07-11', 'Warning'),
('Landslide in Bhopal', 6, 'Landslide', 'Roads blocked.', '2025-07-05', 'Active'),
('Flood in Mumbai', 1, 'Flood', 'Heavy rainfall caused flooding.', '2025-07-10', 'Active'),
('Cyclone in Chennai', 3, 'Cyclone', 'Strong winds expected.', '2025-08-01', 'Warning'),
('Wildfire in Nagpur', 5, 'Wildfire', 'Forest fire spreading rapidly.', '2025-08-05', 'Critical');

SELECT * FROM DISASTERS; 


-- REPORTS TABLE
CREATE TABLE Reports (ReportID SERIAL PRIMARY KEY,DisasterID INT  REFERENCES Disasters(DisasterID),
DisasterTitle VARCHAR(100) NOT NULL, ReportDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,ReportText TEXT );

INSERT INTO Reports (DisasterID, DisasterTitle, ReportDate, ReportText) VALUES
(1, 'Hailstorm in Indore', '2025-07-10 08:30:00', 'Flood reached main road, blocking traffic.'),
(1, 'Hailstorm in Indore', '2025-07-10 12:15:00', 'Water levels rising.'),
(2, 'COVID-19 Outbreak in Pune', '2020-03-02 07:50:00', 'New restrictions imposed.'),
(2, 'COVID-19 Outbreak in Pune', '2021-04-10 09:15:00', 'Vaccination drive started.'),
(3, 'Volcanic Activity in Andaman', '2025-06-30 14:00:00', 'Ash clouds visible.'),
(3, 'Volcanic Activity in Andaman', '2025-07-01 09:00:00', 'Small eruption recorded.'),
(4, 'Tsunami Alert in Kolkata', '2025-07-11 10:00:00', 'Evacuation warning issued.'),
(5, 'Landslide in Bhopal', '2025-07-05 16:00:00', 'Highway closed.'),
(6, 'Flood in Mumbai', '2025-07-10 18:30:00', 'Local train services suspended.'),
(6, 'Flood in Mumbai', '2025-07-11 10:30:00', 'Water receding slowly.'),
(7, 'Cyclone in Chennai', '2025-08-01 14:00:00', 'Strong winds reported in coastal areas.'),
(8, 'Wildfire in Nagpur', '2025-08-05 12:00:00', 'Fire spreading towards residential areas.');

SELECT * FROM REPORTS;

-- EVACUATION CENTERS TABLE 
CREATE TABLE EvacuationCenters (CenterID SERIAL PRIMARY KEY, CenterName VARCHAR(100),
LocationID INT REFERENCES Locations(LocationID) , City VARCHAR(100), State VARCHAR(100), Capacity INT CHECK (Capacity > 0),
DisasterID INT REFERENCES Disasters(DisasterID));

INSERT INTO EvacuationCenters (CenterName, LocationID, City, State, Capacity, DisasterID) VALUES
('Indore Relief Camp', 13, 'Indore', 'Madhya Pradesh', 500, 1),
('Pune Community Hall', 8, 'Pune', 'Maharashtra', 300, 2),
('Kolkata School Shelter', 7, 'Kolkata', 'West Bengal', 200, 4),
('Bhopal Stadium Camp', 14, 'Bhopal', 'Madhya Pradesh', 1000, 5),
('Mumbai Sports Complex', 1, 'Mumbai', 'Maharashtra', 800, 6),
('Chennai Marina Camp', 6, 'Chennai', 'Tamil Nadu', 600, 7),
('Nagpur University Hall', 12, 'Nagpur', 'Maharashtra', 400, 8);

SELECT * FROM EVACUATIONCENTERS;
-------------------------
-- See role by username
SELECT Users.Username, Roles.RoleName, Users.FullName
FROM Users
INNER JOIN Roles ON Users.RoleID = Roles.RoleID
WHERE Users.Username = 'analyst3' AND Users.Passwordd = 'a12';


-- ADMIN VIEW (Full Disaster + Report + Center info)
CREATE VIEW AdminView AS SELECT
    Reports.ReportID,
    Reports.ReportDate,
    Reports.ReportText,
    Disasters.Title AS Disaster_Title,
    Disasters.TypeName AS Disaster_Type,
    Disasters.Description AS Disaster_Description,
    Disasters.Status AS Disaster_Status,
    Disasters.DateReported,
    EvacuationCenters.CenterID,
    EvacuationCenters.CenterName,
    EvacuationCenters.Capacity,
    EvacuationCenters.City AS Center_City,
    EvacuationCenters.State AS Center_State
FROM Reports INNER JOIN Disasters  ON Reports.DisasterID = Disasters.DisasterID
LEFT JOIN EvacuationCenters  ON Disasters.DisasterID = EvacuationCenters.DisasterID
ORDER BY Disasters.Title, Reports.ReportID;

SELECT * FROM ADMINVIEW; 

-- PUBLIC VIEW (Disaster + center info)
CREATE VIEW PublicView AS SELECT
    Disasters.Title AS Disaster_Title,
    Disasters.TypeName AS Disaster_Type,
    Disasters.Status,
    Disasters.Description,
	EvacuationCenters.CenterName,
    EvacuationCenters.City,
    EvacuationCenters.State
FROM Disasters LEFT JOIN EvacuationCenters  ON Disasters.DisasterID = EvacuationCenters.DisasterID
ORDER BY Disasters.Title;

SELECT * FROM PUBLICVIEW;

-- ANALYST VIEW
CREATE VIEW AnalystView AS
SELECT
    Disasters.Title AS DisasterTitle,
    Disasters.TypeName AS DisasterType,
    EvacuationCenters.City,
    EvacuationCenters.State,
    Disasters.DateReported,
    Disasters.Description AS DisasterDescription,
    Disasters.Status
FROM Disasters 
LEFT JOIN EvacuationCenters  ON Disasters.DisasterID = EvacuationCenters.DisasterID
ORDER BY Disasters.Title, Disasters.DateReported;

SELECT * FROM ANALYSTVIEW;

-- FIELD AGENT VIEW (update reports and check and update center capacity changes)
CREATE  VIEW FieldAgentView AS
SELECT
    Reports.ReportID,
    Reports.ReportDate,
    Reports.ReportText,
	Reports.DisasterTitle,
    EvacuationCenters.CenterName,
    EvacuationCenters.Capacity,
    EvacuationCenters.City,
    EvacuationCenters.State
FROM Reports
LEFT JOIN EvacuationCenters  ON Reports.DisasterID = EvacuationCenters.DisasterID
ORDER BY Reports.ReportID;

SELECT * FROM FIELDAGENTVIEW;