select * from census..Data1$;
select * from census..Sheet1$;
--Retreving number of rows in dataset
select count(*) from census..Data1$;
select count(*) from census..Sheet1$;

--Retreving data for only two states
select Data1$.District, Data1$.Growth, Data1$.Literacy,Data1$.Sex_Ratio,Sheet1$.District,Sheet1$.Area_km2, Sheet1$.Population 
from census..Data1$
join census..Sheet1$ on Data1$.State = Sheet1$.State
where Data1$.State = 'Gujarat' OR Data1$.State ='Maharashtra';

--Retreving total polpulation of India
select SUM(Population)as Totalpolpulation from census..Sheet1$ ;

--Retreving Average growth
select AVG(Growth)*100 as average_growth from census..Data1$;

--Retreving Average growth by state
select state, AVG(Growth)*100 as average_growth from census..Data1$
group by  State
order by average_growth desc;

--Retreving Average sex ration by state above 90%
select state, round(AVG(Sex_Ratio),0)as average_sex_ratio from census..Data1$
group by State
having round(AVG(Sex_Ratio),0)>90;

--top 10 state having highest growth ratio with order higher to lowest
select top 10 state, AVG(growth)*100 as average_growth from census..Data1$ group by State
order by average_growth desc; 
  
  --bottom 10 state having highest growth ratio with order  lowest to higher
  select top 10 state, AVG(growth)*100 as average_growth from census..Data1$ group by State
order by average_growth asc; 

--TOP 3 And bottom 3 state with litraccy

--creating table for first table for top 3 literacy

drop table if exists #topstate
create table #topstate
(State nvarchar(255),
Litracy float)

insert into #topstate
select top 3 state,round(avg(Literacy),0) from census..Data1$ group by State
order by State desc

select * from #topstate
order by Litracy desc;

--creating table for second table for bottom 3 literacy

drop table if exists #bottomstate
create table #bottomstate
(State nvarchar(255),
litracy float)

insert into #bottomstate
select top 3 state,round(avg(Literacy),0) from census..Data1$ group by State
order by State asc

select * from #bottomstate
order by litracy asc;

--Union all operator for combining final output
select * from(
select TOP 3* from #topstate order by #topstate.Litracy desc) a
union 
select* from(
select TOP 3 * from #bottomstate order by #bottomstate.litracy asc) b;


--states with starting letter 3
select distinct state from census..Data1$
where State like'a%';