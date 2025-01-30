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
    
    connection = get_db_connection()
    if connection is None:
        return  
    
    try:
        with connection.cursor(dictionary=True) as cursor:
            cursor.execute("SELECT * FROM expenses")
            expenses = cursor.fetchall()
            for expense in expenses:
                print(expense)
    except mysql.connector.Error as e:
        print(f"Error executing query: {e}")
    finally:
        connection.close()  
        
def fetch_expenses_for_date(expenses_date):
    connection = get_db_connection()
    if connection is None:
        return  
    
    try:
        with connection.cursor(dictionary=True) as cursor:
            cursor.execute("SELECT * FROM expenses WHERE expense_date = %s", (expenses_date,))
            expenses = cursor.fetchall()
            for expense in expenses:
                print(expense)
    except mysql.connector.Error as e:
        print(f"Error executing query: {e}")
    finally:
        connection.close()

if __name__ == "__main__":
    #fetch_all_records()
    fetch_expenses_for_date("2024-08-01")
