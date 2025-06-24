create procedure AmountOfVolunteersAndAcceptedRequestsForService(@idService INT,@volunteers INT OUTPUT,@acceptedRequests INT OUTPUT)
as begin
select @volunteers=count(VolunteerId) from VolunteerService
where ServiceId=@idService
select @acceptedRequests=count (*) from Requests
where ServiceId=@idService and RequestStatus="Accepted";
end;
use "E:\ofakim\shana bet work\c#\FinalProject\AfterBirthHelp\VolunteerOrganization.mdf"