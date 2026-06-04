# Global COVID-19 Data Exploration & Epidemiological Modeling

## 🎯 The Business Problem
Public health organizations, healthcare supply chains, and global policy groups require highly accurate, granular data to understand the velocity of infectious diseases, track mortality vectors, and evaluate the operational efficiency of containment strategies. Raw health datasets are frequently massive, disorganized, and full of structural anomalies.

This project utilizes advanced SQL querying to ingest, clean, and analyze global public health data across two core segments: absolute mortality reporting and worldwide vaccination distribution metrics. The objective is to isolate risk indicators, track historical infection velocity, and compute dynamic rolling vaccination coverage metrics across varying populations.

---

## 🛠️ Tech Stack & SQL Architecture
*   **Database Environment:** SQL (MySQL / MS SQL Server compatible)
*   **Advanced Logic Applied:** Common Table Expressions (CTEs), Window Functions, Temporary Tables, Multi-Table Joins, Numeric Data Aggregations, Explicit Data Type Conversions (`CAST`)

---

## 🚀 Analytical Deep-Dive & Query Mechanics

The underlying codebase (`SQL project.sql`) executes a progressive multi-stage extraction pipeline:

### 1. Population Mortality Trajectories
*   **Localized Fatality Risk:** Evaluated the real-time likelihood of critical outcomes by isolating localized regions (e.g., matching targeted parameters like India) and computing dynamic `deathpercentage` ratios (`total_deaths / total_cases * 100`).
*   **Population Penetration Tracking:** Calculated absolute per-capita infection rates over time to measure virus transmission velocity across distinct populations.

### 2. Macro-Level Ingestion & Structural Cleanups
*   **Global Outlier Mitigation:** Implemented explicit geographic boundary filters (`where continent is not null`) to systematically eliminate structural population duplicates (such as macro-world aggregates like 'World' or 'European Union') from skewing country-level comparative metrics.
*   **Data Type Re-casting:** Converted string-based metrics into explicitly signed numeric categories using `CAST(total_deaths as signed)` to execute accurate calculation over high-volume `MAX()` groupings.

### 3. Advanced Vaccination Pipelines (Window Functions & CTEs)
*   **Partitioned Rolling Totals:** Engineered a dynamic rolling vaccination tracker utilizing partitioned window functions:
```sql
    SUM(CAST(vac.new_vaccinations as signed)) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.location, dea.date
    ) as RollingPeopleVaccinated
    ```
*   **CTEs (`PopvsVac`):** Encapsulated the partitioned rolling calculations inside a structured **Common Table Expression** to cleanly execute downstream arithmetic operations, circumventing SQL's structural limitation of referencing newly generated window aliases inline.
*   **Temporary Tables:** Deployed optimized session-specific architecture (`create temporary table PercentPopulationVaccinated`) to store transient calculated records, enabling highly efficient iterative querying during intensive exploratory sessions.

---

## 💡 Core Data Insights

1.  **Transmission vs. Mortality Independence:** High-volume case velocity does not automatically correlate to linear mortality rate increases. Population densities combined with regional medical support access heavily dictate local survival margins.
2.  **Vaccination Operational Scalability:** By analyzing the rolling vaccination percentages through the CTE architecture, clear geographic inflection points emerge where distribution networks successfully scaled up deliveries to outpace community transmission trends.
3.  **Data Discrepancy Integrity:** Explicit filtering for continent nulls proved essential; failing to isolate regional aggregates would have artificially inflated global summaries by repeating national counts across geographic buckets.
