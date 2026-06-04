SELECT location,date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
order by 1,2

-- Total Cases vs Total Deaths
-- shows likelihood of dying if you get infected in your country 

SELECT location, date, total_cases, total_deaths,
	(total_deaths/total_cases)*100 as deathpercentage
FROM coviddeaths
where location like '%india'
order by 1,2

-- Percentage of population infected in your country 

SELECT location, date, total_cases, population,
	(total_cases/population)*100 as Percentage_infected
FROM coviddeaths
where location like '%india'
order by 1,2

-- looking at countries with highest infection rate compared to population

SELECT location, population, MAX(total_cases) as HighestInfectionCount,
	MAX(total_cases/population)*100 as PercentagePopulationInfected
FROM coviddeaths
-- where location like '%india%'
group by location, population
order by PercentagePopulationInfected desc

-- showing countries with highest death count per population

SELECT location, max(cast(total_deaths as signed)) as TotalDeathCount
FROM coviddeaths
-- where location like '%india%'
where continent is not null
and location not in ('world', 'europe','north america','south america','european union','international')
group by location
order by TotalDeathCount desc

-- lets break things down by continent 

SELECT location, max(cast(total_deaths as signed)) as TotalDeathCount
FROM coviddeaths
-- where location like '%india%'
where continent = ''
group by location
order by TotalDeathCount desc

-- showing continents with highest death count

SELECT continent, max(cast(total_deaths as signed)) as TotalDeathCount
FROM coviddeaths
-- where location like '%india%'
where continent is not null
group by continent
order by TotalDeathCount desc

-- Global Numbers

SELECT date, sum(new_cases) as TotalCases, sum(cast(new_deaths as signed)) as TotalDeaths, 
sum(cast(new_deaths as signed))/sum(new_cases)*100
as deathpercentage
FROM coviddeaths
-- where location like '%india%'
where continent is not null
group by date 
order by 1,2

-- World

SELECT sum(new_cases) as TotalCases, sum(cast(new_deaths as signed)) as TotalDeaths, 
sum(cast(new_deaths as signed))/sum(new_cases)*100
as deathpercentage
FROM coviddeaths
-- where location like '%india%'
where continent is not null
-- group by date 
order by 1,2


-- looking at total population vs vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location, dea.date) as 
RollingPeopleVaccinated
from coviddeaths dea
join covidvaccination vac on 
dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- Use CTE

with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated) as (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location, dea.date) as 
RollingPeopleVaccinated
from coviddeaths dea
join covidvaccination vac on 
dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
-- order by 2,3 
)
select *, (rollingpeoplevaccinated/population)*100 as Population vaccinated
 from popvsvac

-- Temp table
drop temporary table if exists PercentPopulationVaccinated;
create temporary table PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
);
insert into PercentPopulationVaccinated
select dea.continent, dea.location, dea.date,nullif(dea.population,'') as population, nullif(vac.new_vaccinations,'') as new_vaccinations,
sum(cast(nullif(vac.new_vaccinations,'') as signed)) over (partition by dea.location order by dea.location, dea.date) as 
RollingPeopleVaccinated
from coviddeaths dea
join covidvaccination vac on 
dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null;
-- order by 2,3
select *, (rollingpeoplevaccinated/population)*100 
from PercentPopulationVaccinated


-- Creating view to store data for later visualisation

create view PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date,nullif(dea.population,'') as population, nullif(vac.new_vaccinations,'') as new_vaccinations,
sum(cast(nullif(vac.new_vaccinations,'') as signed)) over (partition by dea.location order by dea.location, dea.date) as 
RollingPeopleVaccinated
from coviddeaths dea
join covidvaccination vac on 
dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null;
-- order by 2,3