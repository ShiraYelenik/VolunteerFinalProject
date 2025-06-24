CREATE PROCEDURE dbo.GetVolunteerMonthlyHours
    @VolunteerId INT,
    @totalHours INT OUTPUT,
    @avgHours FLOAT OUTPUT
AS
BEGIN
    SELECT 
        @totalHours = ISNULL(SUM(HoursPerMonth), 0),
        @avgHours = ISNULL(AVG(HoursPerMonth * 1.0), 0)
    FROM VolunteerService
    WHERE VolunteerId = @VolunteerId
END
use "E:\ofakim\shana bet work\c#\FinalProject\AfterBirthHelp\VolunteerOrganization.mdf"