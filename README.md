# DBT Bootcamp - teste

A comprehensive repository containing exercises and projects from the DBT Core bootcamp, demonstrating modern data transformation workflows and best practices.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Key Concepts](#key-concepts)

## Overview

This repository centralizes all exercises and projects from the DBT Core bootcamp led by Luciano Vasconcelos at Jornada de Dados. The bootcamp provides hands-on experience with DBT Core's main functionalities and demonstrates how they integrate into the modern data engineering lifecycle.

The project uses a local Postgres database with Northwind sample data, allowing developers to practice DBT Core concepts locally before deploying to production environments.

## Features

- **Local Development Environment**: Dockerized Postgres setup for easy local testing
- **Complete DBT Project Structure**: Models, tests, macros, and documentation
- **Real-World Dataset**: Uses the Northwind database for practical examples
- **Modern Python Tooling**: Managed with UV for dependency management
- **Production-Ready Patterns**: Best practices for DBT Core implementation

## Prerequisites

Before you begin, ensure you have the following installed:

- Docker and Docker Compose
- Python 3.13
- UV package manager (or others)
- Git

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/BrunoChiconato/dbt-bootcamp.git
   cd dbt-bootcamp
   ```

2. **Start the Postgres database**
   ```bash
   docker-compose up -d
   ```
   This will:
   - Start a Postgres container on port 5432
   - Create a persistent volume for data
   - Initialize the database with Northwind tables and data

3. **Install DBT Core dependencies**
   ```bash
   uv sync
   ```
   This installs DBT Core 1.9.0 with the Postgres adapter.

4. **Initialize DBT project**
   ```bash
   cd northwind
   dbt debug
   ```

## Usage

### Basic Commands

```bash
# Run all models
dbt run

# Load seed data
dbt seed

# Run tests
dbt test

# Generate documentation
dbt docs generate

# Serve documentation locally
dbt docs serve

# Build everything (seeds, models, tests, snapshots)
dbt build
```

### Development Workflow

1. **Modify models** in the `models/` directory
2. **Create tests** to validate your transformations
3. **Run models** to see results
4. **Generate documentation** to keep your project well-documented

## Project Structure

```
dbt-bootcamp/
├── docker-compose.yml    # Postgres container configuration
├── northwind.sql         # Database initialization script
├── pyproject.toml        # Python project configuration
├── uv.lock               # Locked dependencies
├── .python-version       # Python version specification
└── northwind/            # DBT project directory
    ├── dbt_project.yml   # DBT configuration
    ├── models/           # SQL models
    ├── macros/           # Reusable SQL macros
    ├── tests/            # Data tests
    ├── seeds/            # CSV seed files
    └── snapshots/        # SCD Type 2 history
```

## Key Concepts

The bootcamp covers the following DBT Core concepts:

1. **DBT Architecture**: Understanding how DBT fits into modern data stacks and the challenges it solves
2. **Core Commands**: Mastering `dbt init`, `dbt debug`, `dbt run`, and `dbt seed`
3. **Macros and Testing**: Implementing reusable logic and data quality checks
4. **Documentation**: Auto-generating project documentation with `dbt docs`
5. **Deployment**: Production deployment patterns using Google BigQuery

---

**Note**: The deployment section using Google BigQuery and advanced features like `dbt snapshot` will be added once that module is completed in the bootcamp.