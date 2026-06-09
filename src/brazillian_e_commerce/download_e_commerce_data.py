import kagglehub
import pandas as pd
import os
from brazillian_e_commerce.database import get_engine

path = kagglehub.dataset_download('olistbr/brazilian-ecommerce')
print('Path to dataset files:', path)

def download():

    engine = get_engine()

    datasets = {
        'olist_customers_dataset.csv': 'olist_customers',
        'olist_geolocation_dataset.csv': 'olist_geolocation',
        'olist_order_items_dataset.csv': 'olist_order_items',
        'olist_order_payments_dataset.csv': 'olist_order_payments',
        'olist_order_reviews_dataset.csv': 'olist_order_reviews',
        'olist_orders_dataset.csv': 'olist_orders',
        'olist_products_dataset.csv': 'olist_products',
        'olist_sellers_dataset.csv': 'olist_sellers',
        'product_category_name_translation.csv': 'product_category_name_translation'
    }

    for csv_file, table_name in datasets.items():

        file_path = os.path.join(path,csv_file)

        df = pd.read_csv(file_path)
        df.to_sql(table_name,con=engine,if_exists='replace',index=False,chunksize=10000)
   
if __name__ == '__main__':
    download()
