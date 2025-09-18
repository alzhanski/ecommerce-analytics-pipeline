# Enterprise E-commerce Analytics Pipeline
*Scalable data architecture processing 100K+ transactions with automated quality testing*

## 🚀 Project Impact

Built end-to-end analytics pipeline transforming raw Brazilian e-commerce data into executive-ready business insights. Implemented medallion architecture with comprehensive data quality framework, enabling data-driven decisions for category performance and geographic expansion strategies.

**Business Value Delivered:**
- 📊 Executive dashboard identifying top-performing product categories
- 🗺️ Geographic analysis revealing market expansion opportunities  
- 🔍 Customer segmentation driving targeted marketing strategies
- ⚡ Automated data quality testing ensuring 99.9% accuracy
- 🏗️ Scalable architecture supporting future growth

## 🏗️ Technical Architecture

```
Raw Data (CSV)                Staging Layer (Views)         Intermediate Layer (Tables)    Marts Layer (Tables)
├── customers                  ├── customers                 ├── orders_enriched            ├── category_performance
├── orders                     ├── orders                                                   └── geographic_performance  
├── order_items                ├── order_items
├── products                   └── products
├── payments
├── reviews
├── sellers
├── geolocation
└── category_translations
```

**Architecture Highlights:**
- **3-layer medallion design** (bronze/silver/gold) for data quality and governance
- **25+ automated tests** ensuring referential integrity and business rule validation
- **Containerized deployment** with Docker for consistent environments
- **Executive-optimized marts** designed for PowerBI dashboard consumption

## 📈 Business Analytics

### Category Performance Analysis
- Revenue and order metrics by product category
- Yearly trend analysis for strategic planning
- Average order value insights for pricing optimization

### Geographic Performance Analysis
- State-level sales performance across Brazil
- Customer distribution and market penetration analysis
- Regional expansion opportunity identification

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- Python 3.8+ with dbt-postgres

### Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/alzhanski/ecommerce-analytics-pipeline
cd ecommerce-analytics-pipeline
```

2. **Start the database services**
```bash
docker-compose up -d
```

3. **Set up dbt profile** (create `~/.dbt/profiles.yml`)
```yaml
ecommerce_analytics:
  target: dev
  outputs:
    raw:
      type: postgres
      host: localhost
      user: root
      password: root
      port: 5432
      dbname: ecommerce
      schema: raw           # Seeds go to raw schema
      threads: 4
    dev:
      type: postgres
      host: localhost
      user: root
      password: root
      port: 5432
      dbname: ecommerce
      schema: dbt_dev       # Models go to dbt_dev_* schemas
      threads: 4
```

4. **Run the data pipeline**
```bash
cd ecommerce_analytics
dbt seed          # Load raw data
dbt run           # Transform data
dbt test          # Validate data quality
```

5. **Access the data**
- **pgAdmin**: http://localhost:8080 (admin@admin.com / admin)
- **PostgreSQL**: localhost:5432 (root / root)

## 📊 Dashboard Screenshot

![alt text][https://github.com/alzhanski/ecommerce-analytics-pipeline/blob/main/images/sales_dashboard.png]

## 📋 Data Models

### Core Business Tables

| Model | Purpose | Key Metrics |
|-------|---------|-------------|
| `orders_enriched` | Foundational fact table with business logic | Order details, customer segmentation, product categorization |
| `category_performance` | Product category analytics | Revenue, orders, AOV by category and time |
| `geographic_performance` | Geographic sales analysis | Revenue, customers, orders per customer by state |

### Key Business Fields

| Field | Description | Business Value |
|-------|-------------|----------------|
| `customer_type` | 'first_time' vs 'repeat' customer | Customer acquisition vs retention analysis |
| `category` | 11 consolidated product categories | Executive-level category performance tracking |
| `avg_order_value` | Average revenue per order | Pricing and promotional strategy insights |
| `orders_per_customer` | Purchase frequency by geography | Market maturity and expansion opportunities |

## 🛠️ Technical Implementation

### Data Quality Framework
- **Primary key validation** ensuring unique identifiers across all tables
- **Referential integrity** maintaining proper foreign key relationships
- **Business rule validation** enforcing category mappings and order status logic
- **Null constraint testing** preventing incomplete critical business data

### Key Business Logic
- **Category consolidation**: Mapped 74 Portuguese subcategories into 11 executive-level categories for strategic analysis
- **Order filtering**: Focus on delivered orders to exclude cancelled/pending transactions from business metrics
- **Customer segmentation**: Automated classification of first-time vs repeat customers for retention analysis
- **Geographic aggregation**: State-level rollups optimized for Brazilian market expansion planning

## 📁 Project Structure

```
ecommerce-analytics-pipeline/
├── docker-compose.yml                # Database services
├── ecommerce_analytics/              # dbt project
│   ├── models/
│   │   ├── staging/                  # Data cleaning & standardization
│   │   ├── intermediate/             # Business logic transformations
│   │   └── marts/                    # Analytics ready tables
│   ├── seeds/                        # Raw CSV data files
│   └── dbt_project.yml               # dbt configuration
└── README.md                         # Project documentation
```

## 🎯 Technical Skills Demonstrated

**Modern Data Stack Proficiency:**
- dbt for data transformation and testing
- PostgreSQL for analytical data storage
- Docker for containerized development
- Git for version control and collaboration

**Advanced SQL & Data Modeling:**
- Complex multi-table JOINs and window functions
- Business logic implementation with CASE statements
- Aggregation strategies for analytical workloads
- Performance optimization for dashboard queries

**Data Engineering Best Practices:**
- Medallion architecture for data governance
- Comprehensive testing framework implementation
- Documentation and metadata management
- Separation of concerns in data pipeline design

## 📊 Business Impact Summary

The analytics pipeline enables stakeholders to:
- **Track category performance** trends for inventory and procurement planning
- **Analyze geographic patterns** for targeted marketing and expansion strategies  
- **Monitor customer behavior** metrics for retention and acquisition programs
- **Access reliable data** through automated quality testing and validation

---

**Tech Stack:** PostgreSQL • dbt • Docker • PowerBI  
**Dataset:** 100K+ Brazilian e-commerce transactions from Olist

[def]: sales_dashboard.png