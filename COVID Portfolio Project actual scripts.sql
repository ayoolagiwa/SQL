select * from CovidDeaths
select * from CovidVaccinations



--Select Data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
where continent is not null
--order by 1,2


--Total cases vs total deaths
--showing likelihood of death if one contacts covid in Nigeria

create view DeathChancesinNigeria as
select
location, date, total_cases, total_deaths,
(total_deaths/nullif(total_cases, 0)) * 100 as DeathPercentage
from CovidDeaths
where location in ('Nigeria') and continent is not null
--order by 1,2


--Looking at Total cases vs population
--shows what population percentage has been infected with covid in Nigeria

create view PercentagePopulationInfectedinNigeria as
select
location, date, total_cases, population,
(total_cases/nullif(population, 0)) * 100 as PercentagePopulationInfected
from CovidDeaths
where location in ('Nigeria') and continent is not null
--order by 1,2


--Countries with the highest infection rates compared to their population

create view HighestPercentagePopulationInfected as
select
location, population,
MAX(total_cases) as HighestInfectionCount,
MAX(total_cases/nullif(population, 0)) * 100 as PercentagePopulationInfected
from CovidDeaths
--where location in ('Nigeria')
where continent is not null
group by location, population
--order by PercntagePopulationInfected desc


--showing country with the highest death rate compared to their population

create view TotalDeathCountbyCountry as
select
location, continent, MAX(total_deaths) as TotalDeathCount
from CovidDeaths
--where location in ('Nigeria')
where continent is not null
group by location, continent
--order by TotalDeathCount desc


--Breaking things down further by continent
create view TotalDeathCountbyContinent as
select
location, MAX(total_deaths) as TotalDeathCount
from CovidDeaths
--where location in ('Nigeria')
where continent is null
group by location
--order by TotalDeathCount desc


--GLOBAL NUMBERS
create view GlobalNumbers as
select SUM(new_cases) as totalcases,
SUM(new_deaths) as totaldeaths,
SUM(new_deaths)/nullif(SUM(new_cases), 0) * 100 as DeathPercentage
--, total_deaths, (total_deaths/nullif(total_cases, 0)) * 100 as DeathPercentage
from CovidDeaths
--where location in ('Nigeria')
where continent is not null
--GROUP BY date  
--order by 1,2


create view DeaVAc as
select * 
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date



--Lookking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as int))
OVER (PARTITION BY dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3


	--USE CTE

;with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.New_Vaccinations
, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location,
	dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by 2,3
	)

select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



--TEMP TABLE

drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)


INSERT INTO #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.New_Vaccinations
, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location,
	dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by 2,3

	SELECT *, (RollingPeopleVaccinated/Population)*100
	From #PercentPopulationVaccinated



	--Creating view to store data for later visualization

	create view PercentPopulationVaccinated as
	Select dea.continent, dea.location, dea.date, dea.population, vac.New_Vaccinations
, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location,
	dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by 2,3


	select *  FROM [dbo].[PercentPopulationVaccinated]

