# Blinkit Quick-Commerce Retail Operations & Inventory Performance Analysis

## 🎯 The Business Problem
In high-velocity quick-commerce distribution models, supply chain profitability hinges on hyper-localized inventory efficiency. Operational managers face an active trade-off: overstocking ties up valuable working capital and increases waste, while understocking creates devastating product stockouts that breach strict customer delivery Service Level Agreements (SLAs). 

This project transforms fragmented operational tracking sheets into a unified, relational analytical data model. The objective is to monitor end-to-end sales transactions, quantify category-level revenue velocity, and provide rapid inventory distribution signals to minimize delivery leakages.

---

## 🛠️ Tech Stack & Analytical Pipeline
*   **Analytics Platform:** Microsoft Excel (Advanced)
*   **Data Architecture Engine:** Power Query & Excel Data Model (Power Pivot)
*   **Schema Design:** Normalized Multi-Table Relational Schema
*   **Key Features Engine:** Pivot Architecture, KPI Aggregation, Cross-Table Slicers, Relational Mapping

---

## 🚀 Data Engineering & Relational Architecture

Instead of analyzing a single unorganized flat file, this architecture explicitly maps out the true transactional mechanics of retail infrastructure by splitting data into specialized tables:

### 1. The Relational Schema
*   **`blinkit_orders` (Transaction Headers):** Captures high-level order metadata, tracking macro purchase timing and fulfillment statuses.
*   **`blinkit_order_items` (Transaction Details):** Maps individual line items back to parental orders, functioning as the primary transactional bridge.
*   **`blinkit_products` (Dimension):** Houses distinct stock-keeping unit (SKU) details, cost boundaries, and retail pricing metrics.
*   **`blinkit_inventory` (Operational Fact):** Tracks localized storage levels, replenishment rates, and warehouse capacity margins.

### 2. ETL Processing & ETL Transformation
*   Utilized **Power Query** to parse raw source arrays, scrub duplicate entry boundaries, transform column configurations, and ensure categorical data alignment across keys.
*   Mapped relationships using explicit IDs (`order_id`, `product_id`) within the Excel Data Model to ensure calculations seamlessly cascade across tables without relying on system-slowing `VLOOKUP` or `XLOOKUP` loops.

### 3. Business Intelligence Aggregations
*   Generated high-impact operations metrics including **Total Revenue**, **Absolute Order Volumes**, and **Fulfillment Velocity**.
*   Built structured matrix pivot views broken down by product categories to flag exactly which inventory items are moving the fastest versus which SKUs are stagnating in warehouses.

---

## 💡 Core Data Insights

1.  **Fulfillment Velocity Alignment:** Isolating specific category data points reveals a sharp concentration of high-volume sales across specific grocery segments. Standard supply chains should prioritize automated daily replenishment rules for these fast-moving goods.
2.  **Working Capital Optimization:** Cross-referencing stock volumes in `blinkit_inventory` against actual historical demand loops inside `blinkit_order_items` uncovers specific slow-moving SKUs that are disproportionately consuming warehouse shelf space.
3.  **Relational Database Integrity:** Building a distinct star-adjacent schema prevents processing lags and ensures that as transactional volumes scale, the analytics layer remains lightweight, stable, and highly responsive.
