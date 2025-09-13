# E-commerce Analytics with dbt & PostgreSQL

A data analytics project built to practice modern data engineering skills using real Brazilian e-commerce data. This project demonstrates foundational dbt concepts, SQL transformations, and business intelligence thinking through a complete data pipeline.

## 🎯 Learning Objectives

This project was created to practice and demonstrate:
- **dbt fundamentals** - Applying concepts from the official dbt Fundamentals course
- **SQL transformations** - Building clean, testable data models
- **Modern data stack** - Using Docker, PostgreSQL, and dbt together
- **Business intelligence** - Creating analytics-ready datasets for visualization
- **Data quality** - Implementing proper testing and validation

## 📊 Project Overview

Using the **Olist Brazilian e-commerce dataset** from Kaggle, I built an end-to-end analytics pipeline following the **medallion architecture** pattern. The pipeline transforms raw CSV data into clean, business-ready datasets optimized for PowerBI dashboards.

**Key Features:**
- 🏗️ **3-layer data architecture** (staging → intermediate → marts)
- 🧪 **Data quality testing** using dbt's built-in test framework
- 🐳 **Containerized development** with Docker for portability
- 📈 **Business-ready analytics** focused on core e-commerce KPIs
- 🎨 **PowerBI optimization** with clean, aggregated mart tables

## 🗄️ Data Architecture

```
Raw Data (CSV Seeds)           Staging Layer (Views)         Intermediate Layer (Tables)    Marts Layer (Tables)
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

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- Python 3.8+ with dbt-postgres

### Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/retail-insights-factory
cd retail-insights-factory
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

## 📈 Business Analytics

### Category Performance Analysis
- Revenue and order metrics by product category
- Yearly trend analysis for business planning
- Average order value insights for pricing strategies

### Geographic Performance Analysis  
- State-level sales performance across Brazil
- Customer distribution and market penetration
- Regional business opportunities identification

## 🛠️ Technical Implementation

### Data Modeling Approach
- **Staging Layer**: Clean and standardize raw data using consistent naming
- **Intermediate Layer**: Apply business logic and create enriched fact tables
- **Marts Layer**: Aggregate metrics optimized for business users and visualization

### Data Quality Framework
- **Primary key validation** ensuring unique identifiers
- **Referential integrity** maintaining proper relationships
- **Categorical validation** enforcing business rules
- **Null constraints** preventing incomplete data

### Key Business Logic
- **Category consolidation**: Simplified Portuguese categories to English
- **Order filtering**: Focus on delivered orders for accurate revenue calculation
- **Date dimensions**: Extract year/quarter/month for temporal analysis
- **Customer metrics**: Calculate order frequency and value patterns

## 📁 Project Structure

```
retail-insights-factory/
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

## 🎯 Key Learning Outcomes

Through building this project, I gained hands-on experience with:

**dbt Fundamentals:**
- Model organization and layering strategies
- Testing framework for data quality assurance
- Documentation and metadata management
- Source and model configuration

**SQL & Data Modeling:**
- Complex JOIN operations across multiple tables
- Window functions for analytical calculations
- CASE statements for business logic implementation
- Aggregation and grouping for summary metrics

**Modern Data Stack:**
- Containerized development environments
- Version control for analytics code
- Separation of concerns in data pipelines
- Production-ready data architecture patterns

## 🔄 Data Pipeline Workflow

1. **Extract**: Load Olist CSV datasets as dbt seeds
2. **Transform**: 
   - **Staging**: Clean and standardize raw data
   - **Intermediate**: Apply business logic and create fact tables
   - **Marts**: Aggregate into analytics-ready tables
3. **Load**: Materialize as PostgreSQL tables/views
4. **Test**: Validate data quality with comprehensive testing
5. **Visualize**: Connect marts to PowerBI for stakeholder dashboards

## 📊 Business Impact

The final mart models enable business stakeholders to:
- **Track category performance** over time for inventory planning
- **Analyze geographic trends** for market expansion decisions  
- **Monitor key metrics** like revenue, orders, and customer behavior
- **Create executive dashboards** with reliable, tested data

## 🎓 Skills Demonstrated

This project showcases foundational data analytics skills including:
- **Modern tooling proficiency** (dbt, Docker, PostgreSQL)
- **SQL expertise** with complex transformations
- **Business intelligence thinking** focused on stakeholder value
- **Data quality mindset** with comprehensive testing
- **Documentation skills** for maintainable analytics code

## 💡 Future Enhancements

Potential areas for continued learning and development:
- Advanced analytics (customer lifetime value, cohort analysis)
- Incremental model strategies for larger datasets
- Custom dbt macros for reusable business logic
- CI/CD pipeline integration with GitHub Actions
- Advanced visualization techniques in PowerBI

## 🤝 About This Project

This project represents my journey learning modern data analytics tools and practices. I focused on building solid fundamentals rather than complex advanced features, emphasizing clean code, proper testing, and business value creation.

The goal was to demonstrate competency with industry-standard tools while maintaining realistic complexity appropriate for someone starting their data analytics career.

---

*Built with curiosity and attention to detail. Ready to contribute to data-driven business decisions.*