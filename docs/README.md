Ecco una versione aggiornata della documentazione per il tuo progetto **DSForge**, con tutte le modifiche apportate:

---

# **DSForge**  
A template for Data Science and Data Analytics projects

## **Overview**
DSForge is a template designed to streamline the setup of Data Science projects. It includes separate environments for development and production, each with distinct purposes and configurations. The development environment leverages Jupyter Notebook for exploratory data analysis, while the production environment integrates tools like Streamlit and Airflow for automated workflows and user interfaces.

---

## **Folder Structure**

### **Base Folders**
- `data`: Contains raw, processed, and final data in three distinct subfolders:
  - `raw`: Unprocessed source data.
  - `processed`: Cleaned and prepared data.
  - `final`: Aggregated or final datasets.
- `docs`: Contains documentation and additional resources.
- `models`: Stores trained models for predictions or further analysis.
- `notebooks`: Contains Jupyter notebooks for development, data exploration, and model training.
- `scripts`: Contains Python scripts used for automated data processing or analysis.
- `tests`: Contains unit tests and other test files for the project's codebase.
- `shared`: Acts as a shared workspace between development and production, hosting the `data` directory.

---

## **Environments**

### **Development Environment**
- Configured using Docker and a `manager.sh` script for container management.
- Runs a Jupyter Notebook server with:
  - Mounted `notebooks` folder for development work.
  - Mounted `shared/data` folder as `/data` in the container for seamless access to `raw`, `processed`, and `final` data.
- **Key Features**:
  - Custom Dockerfile installs dependencies listed in `requirements.txt`.
  - Simplified access to Jupyter Notebook without authentication tokens.
  - Script commands: `start`, `stop`, `restart`, `status`, `logs`, and `build`.

### **Production Environment**
*(To be implemented)*  
- Planned services:
  - Streamlit for creating interactive dashboards.
  - Airflow for automating data workflows triggered by file additions in `shared/data`.

---

## **Key Features Added**
1. **Development Environment**:
   - A Docker-based setup for Jupyter Notebook.
   - `manager.sh` script for container lifecycle management.
   - Disabled token-based authentication for easier local access.
2. **Data Organization**:
   - Defined `raw`, `processed`, and `final` data structure.
   - Shared `data` directory between development and production environments.
3. **Example Notebook**:
   - An initial example notebook demonstrates how to read and preview data from `raw`.

---

## **Usage Instructions**

### **Development Setup**
1. Build the Docker image:
   ```bash
   ./manager.sh build
   ```
2. Start the Jupyter Notebook container:
   ```bash
   ./manager.sh start
   ```
3. Access the Jupyter interface:
   Open your browser and navigate to [http://localhost:8888](http://localhost:8888).

### **Folder Conventions**
- Always add new source data to the `data/raw` folder.
- Use Jupyter Notebooks in the `notebooks` folder to process and clean data, saving results in `data/processed`.
- Save finalized datasets or aggregated results in `data/final`.

---

## **Future Work**
- Implement and document the production environment with Streamlit and Airflow.
- Add examples for using Airflow to automate workflows based on file additions.
- Enhance the `scripts` directory with reusable Python functions for data transformations.

---

Questa versione riflette tutte le modifiche implementate finora. Se hai altre specifiche o desideri aggiungere ulteriori dettagli, possiamo integrarle!