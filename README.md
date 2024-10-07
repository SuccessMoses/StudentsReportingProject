# Student Performance Analysis Project

## Overview

This project aims to analyze student performance across various subjects and classes. It involves creating a database schema, manipulating data, calculating averages, and generating reports for individual students based on their registration numbers.

Repository Structure
The repository contains the following files and directories:

**data/**: This directory contains the CSV files used for the project.

**entity_relationship.PNG**: An image illustrating the relationships between the tables created in the database schema.

**project2.sql**: An SQL file used to define schemas, manipulate data (such as creating class averages), and execute the final queries.

**students_report.xlsx**: An Excel file where the data is loaded, and the report is created.

## Excel File Features

The Excel file includes a slicer for selecting the `classID` and `studentID` of the students for whom reports are to be generated.
Users can input the registration number (reg no) of the student, which utilizes the `XLOOKUP` function to pull in relevant information about the student.
