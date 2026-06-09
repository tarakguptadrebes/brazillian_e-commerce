from sqlalchemy import text
from dotenv import load_dotenv
from pathlib import Path
from brazillian_e_commerce.database import get_engine

BASE_DIR = Path(__file__).resolve().parent.parent.parent
SQL_DIR = BASE_DIR / 'sql'
load_dotenv(BASE_DIR / '.env')

def cleaning():

    engine = get_engine()

    sql_files = [
        'customers_clean.sql',
        'geolocation_clean.sql',
        'order_items_clean.sql',
        'order_payments_clean.sql',
        'order_reviews_clean.sql',
        'orders_clean.sql',
        'product_category_name_translation_clean.sql',
        'products_clean.sql',
        'sellers_clean.sql'
    ]

    with engine.begin() as conn:
        for sql_file in sql_files:
            sql_query = text((SQL_DIR / 'cleaning' / sql_file).read_text())
            conn.execute(sql_query)
            print(f"Executed {sql_file}")

if __name__ == '__main__':
    cleaning()
    