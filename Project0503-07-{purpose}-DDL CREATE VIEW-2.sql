CREATE VIEW [Alloy Rooms] AS
SELECT romId, romType, romPrice, romStatus
FROM [JustRentIt.Room]
WHERE aptId = 'APT000001'
and romStatus = 'furnished';

CREATE VIEW [College Park Apartments] AS
SELECT aptName, aptPhoneNo, aptAddress, aptWebsite, aptCampsDistance
FROM [JustRentIt.Apartment]
WHERE nghId = 'NGH000001';

CREATE VIEW [Alloy Employees] AS
SELECT empFirstName, empLastName, empPhoneNo, empEmail, empPosition
FROM [JustRentIt.Employee]
WHERE aptId = 'APT000001';
