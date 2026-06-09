from sqlalchemy import text
from dotenv import load_dotenv
from pathlib import Path
from brazillian_e_commerce.database import get_engine

BASE_DIR = Path(__file__).resolve().parent.parent.parent
SQL_DIR = BASE_DIR / 'sql'
load_dotenv(BASE_DIR / '.env')

def analysis():

    engine = get_engine()

    sql_files = [
        'avg_approval_time_by_payment_type.sql',
        'avg_delivery_time_by_day_of_the_week.sql',
        'order_weight.sql',
        'avg_fulfillment_duration_by_seller.sql'
    ]

    with engine.begin() as conn:
        for sql_file in sql_files:
            sql_query = text((SQL_DIR / 'analysis' / sql_file).read_text())
            conn.execute(sql_query)
            print(f"Executed {sql_file}")

if __name__ == '__main__':
    analysis()
