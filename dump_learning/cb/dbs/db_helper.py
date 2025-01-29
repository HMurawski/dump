import mysql.connector
import os
from dotenv import load_dotenv

# Wczytaj zmienne środowiskowe
load_dotenv()
host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
database = os.getenv("DB_NAME")

def get_db_connection():
    """Tworzy i zwraca połączenie do bazy danych."""
    try:
        connection = mysql.connector.connect(
            host=host,
            port=port,
            user=user,
            password=password,
            database=database
        )
        return connection
    except mysql.connector.Error as e:
        print(f"Error connecting to database: {e}")
        return None

def fetch_all_records():
    """Pobiera wszystkie rekordy z tabeli 'expenses' i wyświetla je."""
    connection = get_db_connection()
    if connection is None:
        return  # Jeśli nie udało się połączyć, zakończ działanie
    
    try:
        with connection.cursor(dictionary=True) as cursor:
            cursor.execute("SELECT * FROM expenses")
            expenses = cursor.fetchall()
            for expense in expenses:
                print(expense)
    except mysql.connector.Error as e:
        print(f"Error executing query: {e}")
    finally:
        connection.close()  # Zamykamy połączenie

if __name__ == "__main__":
    fetch_all_records()
