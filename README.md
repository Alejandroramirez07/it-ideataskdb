This repository showcases my skills as an AWS-certified DevOps Engineer with experience in software development using Java and Python. The project now focuses on integrating a database (MySQL) into a cloud-native application and automating its infrastructure.

Project Description

This is a Java project created for the IT Idea task, demonstrating modern Object-Oriented Programming (OOP) principles—including the use of abstract classes, interfaces, enums, and custom exceptions.

The primary enhancement in this version is the integration with MySQL to manage and persist data for the "IT ideas calculator" functionality. The project structure and dependencies are managed with Maven.

Technologies Used

Category	Technologies
Languages	Java 21, SQL
Database	MySQL (for data persistence)
Cloud	AWS (Amazon Web Services)
DevOps	CI/CD Pipelines, Infrastructure as Code (e.g., Terraform or CloudFormation, if applicable)
Build Tool	Maven

Getting Started

To run this project, you'll need the following prerequisites and follow the steps for installation and configuration.

Prerequisites

    Java Development Kit (JDK) 21

    Maven

    MySQL Server (running locally or accessible via a network)

    (If applicable: AWS CLI and credentials configured)

Installation

    Clone the repository:
    Bash

git clone https://github.com/Alejandroramirez07/SolvdJavaProject1.git

Navigate to the project directory:
Bash

cd SolvdJavaProject1

Build the project using Maven:
Bash

    mvn clean install

MySQL Configuration

Before running the application, you must:

    Create a database named it_ideas (or modify the connection properties in the configuration files).

    Configure the database connection properties (username, password, and connection URL) within the project's configuration (e.g., in a src/main/resources/database.properties file or similar location).

Usage

This project provides a simple, yet robust, architecture for a data-driven application.

    Customization: The core logic, including data models and service layers, is designed to be easily edited to accommodate various "IT ideas calculator" requirements.

    Deployment: Fork this project and leverage its CI/CD readiness to deploy it to a platform like AWS Elastic Beanstalk or on a Tomcat server, ensuring your MySQL instance is correctly configured in your deployment environment.

This project is not licensed. Use it for all intents and purposes.
