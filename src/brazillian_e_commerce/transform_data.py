from sqlalchemy import text
from dotenv import load_dotenv
from pathlib import Path
from brazillian_e_commerce.database import get_engine

BASE_DIR = Path(__file__).resolve().parent.parent.parent
SQL_DIR = BASE_DIR / 'sql'
load_dotenv(BASE_DIR / '.env')

def transform():

    engine = get_engine()

    sql_files = [
        'customer_seller_geolocation.sql'
    ]

    with engine.begin() as conn:
        for sql_file in sql_files:
            sql_query = text((SQL_DIR / 'transformation' / sql_file).read_text())
            conn.execute(sql_query)
            print(f"Executed {sql_file}")

if __name__ == '__main__':
    transform()