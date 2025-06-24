CREATE FUNCTION dbo.GetUniqueServiceCountForVolunteer( @VolunteerId INT)
RETURNS INT
AS
BEGIN
    DECLARE @UniqueServiceCount INT

    SELECT @UniqueServiceCount = COUNT(*)
    FROM VolunteerService VS1
    WHERE VS1.VolunteerId = @VolunteerId
      AND NOT EXISTS (
          SELECT 1
          FROM VolunteerService VS2
          WHERE VS2.ServiceId = VS1.ServiceId
            AND VS2.VolunteerId <> @VolunteerId
      )

    RETURN @UniqueServiceCount
END
use "E:\ofakim\shana bet work\c#\FinalProject\AfterBirthHelp\VolunteerOrganization.mdf"