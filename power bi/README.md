# Corporate Chocolate Sales Performance & Supply Chain Intelligence Dashboard

## 🎯 The Business Problem
Global consumer packaged goods (CPG) companies managing international confectionery distribution chains must balance fluctuating supply costs against regional sales performance. Without centralized business intelligence, corporate leadership struggles to identify low-margin product lines, spot underperforming global distributors, and track seasonal revenue shifts across distinct geographic markets.

This project delivers an interactive executive tracking dashboard built in Power BI. By ingestion and modeling transactional sales logs, the solution surfaces high-level financial KPIs, evaluates product portfolio profitability (SKU-level margins), and ranks B2B distributor efficiency.

---

## 🛠️ Tech Stack & Business Intelligence Architecture
*   **Analytics Platform:** Microsoft Power BI Desktop
*   **Data Modeling Engine:** Power BI Relational Model (Star Schema Optimized)
*   **Calculations Engine:** DAX (Data Analysis Expressions)
*   **ETL & Transformation:** Power Query (M Language for column standardizations)

---

## 🚀 Data Modeling & DAX Engineering

### 1. The Star Schema Data Model
To maximize reporting performance and enable seamless cross-filtering, the data model was restructured into a robust Star Schema layout:
*   **Fact Table:** Transactional sales ledgers detailing shipment-level metrics, units sold, and explicit financial line items.
*   **Dimension Tables:** Dedicated lookup dimensions for **Products** (SKU attributes, ingredients, cost tiers), **Geography** (international markets, regional zones), **Distributors** (B2B vendor classifications), and a standardized **Date Table** to support advanced time intelligence.
*   **Relationships:** Established clean, single-direction `1-to-many (1:*)` relationships to ensure fast visual rendering and accurate filtering logic.

### 2. Custom DAX Measures
Authored custom DAX expressions to compute critical business health indicators beyond standard baseline aggregations:
*   **Margin Analysis:** Built dynamic formulas to isolate gross profit percentages across shifting product sizes and vendor brackets.
*   **Time Intelligence:** Programmed calendar-aligned measures to track temporal sales trajectories, enabling interactive period-over-period performance comparisons.
*   **Categorical Performance:** Leveraged logical evaluation measures to isolate top-tier distribution accounts and flag trailing product lines.

---

## 📊 Dashboard Visual Interface & Layout
*(Note: Since .pbix files cannot be viewed directly on GitHub, take 1-2 high-resolution screenshots of your dashboard visuals, save them in your power bi folder, and link them below so a reviewer can see your UI/UX skills instantly!)*

*   **Executive Financial & Product Performance Overview**
    <!-- ![Dashboard Overview](visuals/dashboard_main.png) -->

### Visual Hierarchy Principles Applied:
*   **High-Impact KPI Cards:** Positioned across the primary top row to provide stakeholders with immediate clarity on baseline operational metrics (Total Revenue, Shipments, Net Profit Margins).
*   **Geographic & Matrix Breakdowns:** Utilized map distributions and structural matrices to let regional managers instantly drill down from global trends into specific local store performances.
*   **Purposeful Color Palette:** Styled using a professional, cohesive palette aligned with the product theme without causing visual noise or metric confusion.

---

## 💡 Core Data Insights

1.  **Product Margin Nuances:** High-volume chocolate product lines do not always yield the highest net profits. Factoring in manufacturing overheads and ingredient tiers reveals specific specialty SKUs that drive significantly tighter profit margins despite lower unit sales numbers.
2.  **Distributor Value Concentration:** Evaluating distributor metrics via matrix views highlights a minor concentration of B2B partners generating a majority of total sales volumes, indicating a need for strategic client relationship management.
3.  **Data-Driven Inventory Alignment:** Correlating monthly transactional patterns allows supply chain managers to optimize warehouse allocations ahead of seasonal demand spikes, minimizing stockout costs.
