CREATE FUNCTION CheckIfServiceHasSufficientHours 
(
    @ServiceId INT, 
    @Month INT, 
    @Year INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @TotalDonatedHours INT;
    DECLARE @AvgRequestedHours FLOAT;
    DECLARE @Result BIT;

    SELECT @TotalDonatedHours = SUM(VS.HoursPerMonth)
    FROM VolunteerService VS
    WHERE VS.ServiceId = @ServiceId;

    SELECT @AvgRequestedHours = AVG(R.NumberOfHours * 1.0)
    FROM Requests R
    WHERE R.ServiceId = @ServiceId
      AND MONTH(R.Date) = @Month
      AND YEAR(R.Date) = @Year;

    IF @AvgRequestedHours IS NULL OR @AvgRequestedHours = 0
        SET @Result = 0;
    ELSE IF @TotalDonatedHours > @AvgRequestedHours
        SET @Result = 1;
    ELSE
        SET @Result = 0;

    RETURN @Result;
END
use "E:\ofakim\shana bet work\c#\FinalProject\AfterBirthHelp\VolunteerOrganization.mdf"
