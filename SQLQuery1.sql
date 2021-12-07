SELECT [location], [date], [total_cases],[new_cases],[total_deaths],[population]
FROM [PortfolioProjects].[dbo].['CovidDeaths']

-- Looking at Total Cases vs Total Deaths
-- Show the likelihood of a person dying in the United States


SELECT [location], [date], [total_cases],[total_deaths], (total_deaths/total_cases) *100 AS DeathPercentage
FROM [PortfolioProjects].[dbo].['CovidDeaths']
WHERE [location] = 'United States'
ORDER BY 1, 2

-- Looking at the Total Cases vs Population
--Shows what percentage of the population got Covid in 2021


SELECT [location], [date], [total_cases],[total_deaths], (total_cases/population) *100 AS Infected_Population
FROM [PortfolioProjects].[dbo].['CovidDeaths']
WHERE [location] = 'United States' AND [date] > '2020-12-31'
ORDER BY [date]


-- Looking at Countries with Highest Infection Rate compared to Population


SELECT [location], [population], MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentofPopulationInfected
FROM [PortfolioProjects].[dbo].['CovidDeaths']
GROUP BY [location], [population]
ORDER BY PercentofPopulationInfected desc

-- Showing Death Counts of Countries


SELECT [location], MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM [PortfolioProjects].[dbo].['CovidDeaths']
WHERE [continent] is not null
GROUP BY [location]
ORDER BY TotalDeathCount desc

-- Showing Death Counts of Continents


SELECT location, MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM [PortfolioProjects].[dbo].['CovidDeaths']
WHERE [continent] is null
GROUP BY location
ORDER BY TotalDeathCount desc

-- Looking at Total Population vs Vaccinations


SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations
FROM PortfolioProjects.dbo.['CovidDeaths'] d
INNER JOIN PortfolioProjects.dbo.CovidVaccinations v ON d.location = v.location
															 AND d.date = v.date
WHERE d.continent is not null
ORDER BY d.location, d.date

