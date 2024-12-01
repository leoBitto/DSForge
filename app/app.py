import streamlit as st
import pandas as pd
import os

def load_data():
    """
    Carica tutti i file CSV dalla cartella 'final'
    """
    final_data_path = '/app/data/final'
    dataframes = {}
    
    try:
        for filename in os.listdir(final_data_path):
            if filename.endswith('.csv'):
                filepath = os.path.join(final_data_path, filename)
                df_name = os.path.splitext(filename)[0]
                dataframes[df_name] = pd.read_csv(filepath)
        
        return dataframes
    
    except Exception as e:
        st.error(f"Errore nel caricamento dei dati: {e}")
        return {}

def main():
    st.set_page_config(
        page_title="Data Analysis Dashboard",
        page_icon="📊",
        layout="wide"
    )
    
    st.title("Data Analysis Dashboard")
    
    # Caricamento dati
    with st.spinner('Caricamento dati...'):
        dataframes = load_data()
    
    if not dataframes:
        st.warning("Nessun dato trovato nelle cartelle final.")
        return
    
    # Sidebar per la selezione del dataset
    st.sidebar.header("Seleziona Dataset")
    selected_dataset = st.sidebar.selectbox(
        "Scegli un dataset",
        list(dataframes.keys())
    )
    
    # Mostra dataset selezionato
    st.subheader(f"Dataset: {selected_dataset}")
    
    # Opzioni di visualizzazione
    view_mode = st.radio(
        "Modalità di visualizzazione", 
        ["Anteprima", "Statistiche", "Grafico"]
    )
    
    df = dataframes[selected_dataset]
    
    if view_mode == "Anteprima":
        st.dataframe(df)
    
    elif view_mode == "Statistiche":
        st.write(df.describe())
    
    elif view_mode == "Grafico":
        # Assumendo che ci siano colonne numeriche
        numeric_columns = df.select_dtypes(include=['int64', 'float64']).columns
        
        if len(numeric_columns) >= 2:
            x_col = st.selectbox("Asse X", numeric_columns)
            y_col = st.selectbox("Asse Y", numeric_columns[numeric_columns != x_col])
            
            st.scatter_chart(data=df, x=x_col, y=y_col)
        else:
            st.warning("Serve più di una colonna numerica per creare grafici.")

if __name__ == "__main__":
    main()