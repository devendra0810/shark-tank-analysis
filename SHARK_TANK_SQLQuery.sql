select * from project..data

-- 1.total episodes

select max(epno) from project..data
select count(distinct epno) from project..data

-- 2.pitches 

select count(distinct brand) from project..data

--3.pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select AmountInvestedlakhs, case when AmountInvestedlakhs>0 then 1 else 0 end as converted_not_converted from project..data) a

-- 4.total male

select sum(male) from project..data

-- 5.total female

select sum(female) from project..data

--gender ratio

select sum(female)/sum(male) from project..data

-- 6.total invested amount

select sum(AmountInvestedlakhs) from project..data

-- 7.avg equity taken

select avg(a.EquityTakenp) from
(select * from project..data where EquityTakenp>0) a

--8.highest deal taken

select max(amountinvestedlakhs) from project..data 

--9.highest equity taken

select max(equitytakenp) from project..data

-- 10.startups having at least one women

select sum(a.female_count) from (
select female,case when female>0 then 1 else 0 end as female_count from project..data) a

--11.pitches converted having atleast one women

select * from project..data


select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from project..data where deal!='No Deal')) a)b

-- 12.avg team members

select avg(teammembers) from project..data

-- amount invested per deal

select avg(a.amountinvestedlakhs) amount_invested_per_deal from
(select * from project..data where deal!='No Deal') a

-- 13.avg age group of contestants

select avgage,count(avgage) cnt from project..data group by avgage order by cnt desc

-- 14.location group of contestants

select location,count(location) cnt from project..data group by location order by cnt desc

-- 15.sector group of contestants

select sector,count(sector) cnt from project..data group by sector order by cnt desc


--16.partner deals

select partners,count(partners) cnt from project..data  where partners!='-' group by partners order by cnt desc

-- 17.making the matrix


select * from project..data

select 'Ashneer' as keyy,count(ashneeramountinvested) from project..data where (ashneeramountinvested) is not null


select 'Ashneer' as keyy,count(ashneeramountinvested) from project..data where ashneeramountinvested is not null AND ashneeramountinvested!=0

SELECT 'Ashneer' as keyy,SUM(C.ASHNEER AMOUNT INVESTED),AVG(C.ASHNEEREQUITYTAKENP) 
FROM (SELECT * FROM PROJECT..DATA  WHERE ASHNEEREQUITYTAKENP!=0 AND ASHNEER EQUITY TAKEN% IS NOT NULL) C


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count(ashneeramountinvested) total_deals_present from project..data where ashneeramountinvested is not null) a

inner join (
select 'Ashneer' as keyy,count(ashneeramountinvested) total_deals from project..data 
where ashneeramountinvested is not null AND ashneeramountinvested!=0) b 

on a.keyy=b.keyy) m

inner join 

(SELECT 'Ashneer' as keyy,SUM(C.ASHNEERAMOUNTINVESTED) total_amount_invested,
AVG(C.ASHNEEREQUITYTAKENP) avg_equity_taken
FROM (SELECT * FROM PROJECT..DATA  WHERE ASHNEEREQUITYTAKENP!=0 AND ASHNEEREQUITYTAKENP IS NOT NULL) C) n

on m.keyy=n.keyy

-- 18.which is the startup in which the highest amount has been invested in each domain/sector


select c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 

from project..data) c

where c.rnk=1