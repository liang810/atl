/** Question 1:  Find the number of emails that mention “Obama” in the ExtractedBodyText of the email. **/
select count(ID) from Emails where ExtractedBodyText like "%Obama%";
/** Question 2: Among people with Aliases, find the average number of Aliases each person has. **/
select avg(num) from (select count(Alias) as num from Aliases group by PersonID);
/** Question 3: Find the MetadataDateSent on which the most emails were sent and the number of emails that were sent on * that date. Note that that many emails do not have a date -- don’t include those in your count. **/
select max(num), MetadataDateSent from (select count(*) as num, MetadataDateSent from Emails where MetadataDateSent != "" group by MetadataDateSent);
/** Question 4: Find out how many distinct ids refer to Hillary Clinton. Remember the hint from the homework spec! **/
select count(*) + 1 from (select * from Persons where Name == "Hillary Clinton") S, Aliases A where A.PersonID == S.ID;
/** Question 5: Find the number of emails in the database sent by Hillary Clinton. Keep in mind that there are multiple * aliases (from the previous question) that the email could’ve been sent from. **/
select count(*) from Emails E, (select * from Persons where Name == "Hillary Clinton") S where SenderPersonID == S.Id;
/** Question 6: Find the names of the 5 people who emailed Hillary Clinton the most. **/
create view emailids as select * from EmailReceivers E, (select * from Persons where Name == "Hillary Clinton") S where E.PersonId == S.Id;
create view ids as select SenderPersonId, count(*) as num from emailids I, Emails E where I.EmailId == E.Id group by SenderPersonID;
select Name from Persons P, ids I where P.Id == I.SenderPersonId order by num desc limit 5;
/** Question 7: Find the names of the 5 people that Hillary Clinton emailed the most. **/
create view emailid as select * from Emails E, (select * from Persons where Name == "Hillary Clinton") S where E.SenderPersonId == S.Id;
create view id as select PersonId, count(*) as num from emailid I, EmailReceivers E where E.EmailId == I.Id group by PersonId;
select Name from Persons P, id I where P.Id == I.PersonId order by num desc limit 5;