# Python Projects

This folder contains various Python projects, showcasing my skills in data analysis and web scraping. Below are brief descriptions of two notable projects: the BMI Calculator and the Web Scraping Project for cryptocurrency data.

## BMI Calculator

### Overview

The BMI Calculator is a simple Python application that allows users to calculate their Body Mass Index (BMI) based on their weight and height. The application provides a classification based on the calculated BMI value, helping users understand their weight status.

### Features

- User-friendly input for weight (in kg) and height (in meters).
- Classification of BMI into categories based on the following chart:

| BMI Range        | Classification      |
|------------------|---------------------|
| Below 18.5       | Underweight         |
| 18.5 - 24.9      | Normal weight       |
| 25.0 - 29.9      | Overweight          |
| 30.0 and above   | Obesity             |

### Technologies Used

- Python
- Jupyter Notebook

### How to Run

1. Ensure you have Python installed on your machine.
2. Download the project files.
3. Run the Jupyter Notebook and execute the cells to calculate BMI.

---

## Web Scraping Project: Cryptocurrency List

### Overview

This project demonstrates web scraping techniques to gather data on cryptocurrencies using Python libraries such as Beautiful Soup and Requests. The goal is to extract information from a cryptocurrency listing website and compile it into a structured format for analysis.

### Features

- Sends a request to fetch HTML content from a target webpage.
- Parses the HTML using Beautiful Soup to extract relevant cryptocurrency data.
- Organizes the data into a Pandas DataFrame for easy manipulation and analysis.
- Ability to export the DataFrame to CSV or other formats.

### Technologies Used

- Python
- Beautiful Soup
- Requests
- Pandas

### How to Run

1. Ensure you have the necessary libraries installed:
   ```bash
   pip install beautifulsoup4 requests pandas
