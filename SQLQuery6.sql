CREATE PROCEDURE dbo.GetUpcomingRequestsForVolunteer(@VolunteerId INT)
AS BEGIN
    SELECT 
        SS.Name AS SeekingServiceName,
        SS.PhoneNumber,
        SS.Address,
        S.ServiceName,
        R.RequestContent,
        R.Date
    FROM AssignedRequests AR
    INNER JOIN Requests R ON AR.RequestId = R.RequestId
    INNER JOIN SeekingServices SS ON R.SeekingServiceId = SS.SeekingServiceId
    INNER JOIN Services S ON R.ServiceId = S.ServiceId
    WHERE AR.VolunteerId = @VolunteerId
      AND R.Date >= GETDATE()
    ORDER BY R.Date ASC
END
use "E:\ofakim\shana bet work\c#\FinalProject\AfterBirthHelp\VolunteerOrganization.mdf"