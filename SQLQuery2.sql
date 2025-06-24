CREATE PROCEDURE GetVolunteerWithMostRemainingHoursForService
    @idService INT,
    @idVolunteer INT OUTPUT,
    @name NVARCHAR(100) OUTPUT,
    @phone NVARCHAR(20) OUTPUT
AS
BEGIN
    -- Temp table to store volunteers with remaining hours
    CREATE TABLE #VolunteerHours (
        VolunteerId INT,
        RemainingHours INT,
        Name NVARCHAR(100),
        PhoneNumber NVARCHAR(20)
    );

    -- Insert each volunteer with remaining hours using the function
    INSERT INTO #VolunteerHours (VolunteerId, RemainingHours, Name, PhoneNumber)
    SELECT 
        v.VolunteerId,
        dbo.GetRemainingMonthlyHoursForVolunteer(v.VolunteerId),
        v.Name,
        v.PhoneNumber
    FROM Volunteers v
    JOIN VolunteerService vs ON v.VolunteerId = vs.VolunteerId
    WHERE vs.ServiceId = @idService;

    -- Select the top volunteer with the most remaining hours
    SELECT TOP 1 
        @idVolunteer = VolunteerId,
        @name = Name,
        @phone = PhoneNumber
    FROM #VolunteerHours
    ORDER BY RemainingHours DESC;

    -- Cleanup
    DROP TABLE #VolunteerHours;
END;
