CREATE FUNCTION GetRemainingMonthlyHoursForVolunteer (@id INT)
RETURNS INT
AS
BEGIN
    DECLARE @monthlyHours INT;
    DECLARE @alreadyAssignedHours INT;

    SELECT @monthlyHours = HoursPerMonth
    FROM VolunteerService
    WHERE VolunteerId = @id;

    SELECT @alreadyAssignedHours = SUM(NumberOfHours)
    FROM Requests r
    JOIN AssignedRequests a ON r.IdRequests = a.IdRequests
    JOIN Volunteers v ON a.VolunteerId = v.VolunteerId
    WHERE v.VolunteerId = @id;

    IF @alreadyAssignedHours IS NULL
        SET @alreadyAssignedHours = 0;

    RETURN @monthlyHours - @alreadyAssignedHours;
END
use "E:\ofakim\shana bet work\c#\FinalProject\AfterBirthHelp\VolunteerOrganization.mdf"