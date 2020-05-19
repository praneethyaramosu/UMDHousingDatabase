--COUNT(*) Statements

SELECT COUNT(*)
FROM [JustRentIt.Apartment]

SELECT COUNT(*)
FROM [JustRentIt.Company]

SELECT COUNT(*)
FROM [JustRentIt.Corenter]

SELECT COUNT(*)
FROM [JustRentIt.Employee]

SELECT COUNT(*)
FROM [JustRentIt.Lease]

SELECT COUNT(*)
FROM [JustRentIt.Neighborhood]

SELECT COUNT(*)
FROM [JustRentIt.Own]

SELECT COUNT(*)
FROM [JustRentIt.Renter]

SELECT COUNT(*)
FROM [JustRentIt.Room]

SELECT COUNT(*)
FROM[JustRentIt.Lease]


--Which Neighborhood should a renter choose if he or she wants to live in a safest apartment?
SELECT nghName as 'Neighborhood Name', nghHealthCenter as 'Number of Health Centers', nghShopping as 'Number of shopping centers', nghEntertainment as 'Number of entertainment centers', nghDinning as 'Number of dining centers', nghTransportation as 'Number of transportation centers', nghEmployers as 'Number of Employers', nghCrimeIndex as 'Criminal Index'
FROM [JustRentIt.Neighborhood]
WHERE nghCrimeIndex <= ALL ( SELECT nghCrimeIndex
							 FROM [JustRentIt.Neighborhood] );


--Which is the apartment that has the highest google reviews?

SELECT aptName as 'Apartment Name', aptPhoneNo as 'Phone Number', aptAddress as 'Address', aptWebsite as 'Website', aptOpenDate as 'Open Date', aptCampsDistance as 'Distance to Campus', aptGoogleReview as 'Google Reviews (/5)'
FROM [JustRentIt.Apartment]
WHERE aptGoogleReview >= ALL( SELECT aptGoogleReview
								FROM [JustRentIt.Apartment]);


--What are the top 5 apartments for renters who care so much about the distance to school?

SELECT TOP 5 aptName as 'Apartment Name', aptPhoneNo as 'Phone Number', aptAddress as 'Address', aptWebsite as 'Website', aptOpenDate as 'Open Date', aptCampsDistance as 'Distance to Campus', aptGoogleReview as 'Google Reviews (/5)'
FROM [JustRentIt.Apartment]
ORDER BY aptCampsDistance;




--What are the apartments that renters can have easy access to health centers and entertainment facilities?

SELECT aptName as 'Apartment Name', aptPhoneNo as 'Phone Number', aptAddress as 'Address', aptWebsite as 'Website', aptOpenDate as 'Open Date', aptCampsDistance as 'Distance to Campus', aptGoogleReview as 'Google Reviews (/5)', nghHealthCenter as 'Number of Health Centers', nghEntertainment as 'Number of Entertainment Facilities'
FROM [JustRentIt.Neighborhood] as n, [JustRentIt.Apartment] as a
WHERE n.nghId = a.nghId AND (nghHealthCenter+nghEntertainment+nghDinning) IN ( SELECT MAX(nghHealthCenter+nghEntertainment+nghDinning) as Total_Facilities
																				FROM [JustRentIt.Neighborhood])
ORDER BY aptName, aptAddress;




--What are the prices of apartments according to their furniture status?

SELECT aptName as 'Apartment Name', r.romStatus as ' Room Status' ,MIN(romPrice) as Minimum_Room_Price, MAX(romPrice) as Maximum_Room_Price, AVG(romPrice) as Average_Room_Price
FROM [JustRentIt.Room] as r, [JustRentIt.Apartment] as a
WHERE r.aptId = a.aptId
GROUP BY r.aptId,aptName, r.romStatus
ORDER BY aptName;



--What are the prices of rooms in different apartments?

SELECT aptName as 'Apartment Name', aptPhoneNo as 'Phone Number', aptAddress as 'Address', aptWebsite as 'Website', aptOpenDate as 'Open Date', aptCampsDistance as 'Distance to Campus', aptGoogleReview as 'Google Reviews (/5)', MIN(romPrice) as Minimum_Room_Price, MAX(romPrice) as Maximum_Room_Price, AVG(romPrice) as Average_Room_Price
FROM [JustRentIt.Room] as r, [JustRentIt.Apartment] as a
WHERE r.aptId = a.aptId
GROUP BY r.aptId,aptName,aptPhoneNo, aptAddress, aptWebsite, aptOpenDate, aptCampsDistance, aptGoogleReview
ORDER BY Minimum_Room_Price, Maximum_Room_Price;