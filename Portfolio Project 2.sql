/*
Comparing Data of Life Excpectancy and GDP

Skills used: Joins, CTE's, Windows Functions, Aggregate Functions, Creating Views

*/ 

Select *
From Project1..LifeExpectancy 

--Select data that we are going to be starting with 

Select Entity, year, FemaleAge, MaleAge
From Project1..LifeExpectancy 
order by 1, 2

-- Female Age vs Male Age
-- Shows difference in life expectancy between females and males

Select Entity, year, FemaleAge, MaleAge, (FemaleAge-MaleAge) as AgeDifference
From Project1..LifeExpectancy
--Where Entity like '%states%'
order by 1, 2

-- Average Life Expectancy
-- Shows the average life expecatancy per year


Select Entity, year, FemaleAge, MaleAge, (FemaleAge+MaleAge)/2 as AverageAge
From Project1..LifeExpectancy
order by 1, 2

-- Countries with the highest Average life expectancy 

Select Entity, year, MAX((FemaleAge+MaleAge)/2) as HighestAverageAge
From Project1..LifeExpectancy
Group by Entity, year
order by 3 DESC

-- Countries with the highest average age gap between male and female over all years

Select Entity, AVG(FemaleAge)-AVG(MaleAge) as AverageAgeDiff
From Project1..LifeExpectancy 
Group by Entity
order by 2 DESC


-- Average life expectancy vs GDP
-- Data compares countries with the highest AverageGDP vs Average life expectancy 

Select Lif.Entity, lif.year, AVG(GDP.GDPPerCapita) OVER (Partition by Lif.entity) as AVGGDP, (lif.FemaleAge+lif.MaleAge)/2 as AverageAge
From Project1..LifeExpectancy lif
Join Project1..GDP GDP
	ON lif.Entity = GDP.Entity
	and lif.year = GDP.year
order by 4 DESC

-- Using a CTE to preform previous calculation 

With LifVsGDP
as
(
Select Lif.Entity, lif.year, AVG(GDP.GDPPerCapita) OVER (Partition by Lif.entity) as AVGGDP, (lif.FemaleAge+lif.MaleAge)/2 as AverageAge
From Project1..LifeExpectancy lif
Join Project1..GDP GDP
	ON lif.Entity = GDP.Entity
	and lif.year = GDP.year
)
Select *
From LifVsGDP
Where AverageAge > 80 

-- Creating View to store data for later visualizations

Create View LargestAgeGap as
Select Entity, AVG(FemaleAge)-AVG(MaleAge) as AverageAgeDiff
From Project1..LifeExpectancy 
Group by Entity
--order by 2 DESC