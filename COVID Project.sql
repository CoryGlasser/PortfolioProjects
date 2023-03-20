/*
Covid 19 Data Exploarion

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

Select *
From PortfolioProject.dbo.CovidDeaths
WHERE continent is not null
ORDER BY 3,4


-- Data selection
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject.dbo.CovidDeaths
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
-- Percentage of contracting covid and death
Select Location, date, total_cases, total_deaths, cast(total_deaths as bigint)/NULLIF(cast(total_cases as float),0)*100 AS DeathPercentage
From PortfolioProject.dbo.CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

-- Looking at Total Cases vs Population
-- Percentage of population who got Covid (uses scientific notation)
Select Location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
From PortfolioProject.dbo.CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

-- Looking at countries with highest infection rate compared to population
Select Location, Population, MAX(cast(total_cases AS int)) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
From PortfolioProject.dbo.CovidDeaths
--WHERE location like '%states%'
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC

-- Showing countries with highest death count per population
Select Location, MAX(cast(total_deaths AS int)) AS TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY Location
ORDER BY TotalDeathCount DESC

-- Breaking things down by continent
Select Location, MAX(cast(total_deaths AS int)) AS TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
WHERE Continent is null 
		AND Location <> 'High Income' 
		AND Location <> 'Upper middle income' 
		AND Location <> 'Lower middle income' 
		AND Location <> 'Low income'
GROUP BY Location
ORDER BY TotalDeathCount DESC

-- Global Numbers
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
--Group By date
order by 1,2

-- Looking at total population vs vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as CumulativeVaccination
, (CumulativeVaccination/population)*100
FROM CovidDeaths AS dea
Join CovidVaccinations AS vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

-- CTE
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, CumulativeVaccination)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as CumulativeVaccination
--, (CumulativeVaccination/population)*100
FROM CovidDeaths AS dea
Join CovidVaccinations AS vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (CumulativeVaccination/population)*100
From PopvsVac

-- TEMP table
DROP TABLE if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
CumulativeVaccination numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as CumulativeVaccination
--, (CumulativeVaccination/population)*100
FROM CovidDeaths AS dea
Join CovidVaccinations AS vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3

Select *, (CumulativeVaccination/population)*100
From #PercentPopulationVaccinated

--Creating view to store data for later visualizations
Create view DeathCountByContinent as
Select Location, MAX(cast(total_deaths AS int)) AS TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
WHERE Continent is null 
		AND Location <> 'High Income' 
		AND Location <> 'Upper middle income' 
		AND Location <> 'Lower middle income' 
		AND Location <> 'Low income'
GROUP BY Location
--ORDER BY TotalDeathCount DESC