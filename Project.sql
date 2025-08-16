-- Filling Lat and Longtitude by neighbourhood average
SELECT neighbourhood , AVG(CAST(lat AS Float)) AS Average_Latitude, AVG(CAST(long AS Float)) AS Average_Longitude 
INTO #TEMP
FROM dbo.FACT
GROUP BY neighbourhood

UPDATE dbo.FACT
SET lat = B.Average_Latitude, long = B.Average_Longitude
FROM dbo.FACT A INNER JOIN #TEMP B
ON A.neighbourhood = B.neighbourhood
WHERE A.long is NULL

SELECT * FROM dbo.FACT WHERE long IS NULL
SELECT * FROM #TEMP ORDER BY neighbourhood

-- Handling instant_bookable
ALTER TABLE dbo.FACT
ALTER COLUMN service_fee Float
UPDATE dbo.FACT
SET instant_bookable = 0
WHERE instant_bookable IS NULL

-- 
UPDATE dbo.FACT
SET review_rate_number = 0
WHERE review_rate_number IS NULL

SELECT COUNT(*)
FROM dbo.FACT
WHERE number_of_reviews IS NULL

SELECT room_type
FROM dbo.FACT
GROUP BY room_type

CREATE TABLE DIM_HOST
(
	Host_Info_ID INT PRIMARY KEY IDENTITY(1,1),
	Host_ID BIGINT,
	Host_Name NVARCHAR(50),
	Host_Identity_Verified NVARCHAR(20)
)

CREATE TABLE DIM_LOCATION
(
	Location_ID INT PRIMARY KEY IDENTITY(1,1),
	Country NVARCHAR(25),
	Country_Code NVARCHAR(2),
	Neighbourhood_Group NVARCHAR(50),
	Neighbourhood NVARCHAR(50)
)

CREATE TABLE DIM_CANCELLATION_POLICY
(
	Cancellation_ID INT PRIMARY KEY IDENTITY(1,1),
	Policy_Name NVARCHAR(25),

)

CREATE TABLE DIM_LIVING
(
	Living_ID INT PRIMARY KEY IDENTITY(1,1),
	ROOM_NAME NVARCHAR(MAX),
	Room_Type NVARCHAR(25),
	Construction_Year INT
)

CREATE TABLE DIM_REVIEW_RATING
(
	Rating_ID INT PRIMARY KEY IDENTITY(1,1),
	Rating_Number INT
)

CREATE TABLE FACT_RENT
(
	ID INT,
	Host_Info_ID INT REFERENCES DIM_HOST(Host_Info_ID),
	Location_ID INT REFERENCES DIM_LOCATION(Location_ID),
	Cancellation_ID INT REFERENCES DIM_CANCELLATION_POLICY(Cancellation_ID),
	Living_ID INT REFERENCES DIM_LIVING(Living_ID),
	Rating_ID INT REFERENCES DIM_REVIEW_RATING(Rating_ID),
	Lat Float,
	Long Float,
	Instant_Bookable BIT,
	Price Float,
	Service_Fee Float,
	Minimum_Nights INT,
	Number_Of_Reviews INT,
	Last_Review DATE,
	Reviews_Per_Month Float,
	Host_Listing_Count INT,
	Availability_365 INT
)

INSERT INTO DIM_HOST
SELECT DISTINCT host_id, host_name, host_identity_verified
FROM dbo.FACT

INSERT INTO DIM_LOCATION
SELECT DISTINCT country, country_code, neighbourhood_group, neighbourhood
FROM dbo.FACT

INSERT INTO DIM_CANCELLATION_POLICY
SELECT DISTINCT cancellation_policy
FROM dbo.FACT

INSERT INTO DIM_LIVING
SELECT DISTINCT NAME, room_type, Construction_year
FROM dbo.FACT

INSERT INTO DIM_REVIEW_RATING
SELECT DISTINCT review_rate_number
FROM dbo.FACT


TRUNCATE TABLE FACT_RENT

INSERT INTO FACT_RENT
SELECT DISTINCT F.id, H.Host_Info_ID, L.Location_ID, C.Cancellation_ID, LI.Living_ID, R.Rating_ID, F.lat, F.long, F.instant_bookable,
		F.price, F.service_fee, F.minimum_nights, F.number_of_reviews, F.last_review, F.reviews_per_month, F.calculated_host_listings_count,
		F.availability_365
FROM FACT F
LEFT JOIN DIM_HOST H
ON F.host_id = H.Host_ID AND F.host_name = H.Host_Name AND F.host_identity_verified = H.Host_Identity_Verified
LEFT JOIN DIM_LOCATION L
ON F.country = L.Country AND F.country_code = L.Country_Code 
	AND F.neighbourhood_group = L.Neighbourhood_Group AND F.neighbourhood = L.Neighbourhood
LEFT JOIN DIM_CANCELLATION_POLICY C
ON F.cancellation_policy = C.Policy_Name
LEFT JOIN DIM_LIVING LI
ON F.NAME = LI.ROOM_NAME AND F.room_type = LI.Room_Type AND ISNULL(F.Construction_year, 0) = ISNULL(LI.Construction_Year, 0)
LEFT JOIN DIM_REVIEW_RATING R
ON F.review_rate_number = R.Rating_Number

SELECT * FROM DIM_HOST

SELECT MAX(LEN(neighbourhood)) from dbo.FACT
SELECT TOP 100 * FROM dbo.FACT