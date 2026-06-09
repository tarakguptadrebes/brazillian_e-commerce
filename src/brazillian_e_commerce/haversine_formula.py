import pandas as pd
import numpy as np
from brazillian_e_commerce.database import get_engine

def haversine():

    engine = get_engine()

    R = 6371

    df = pd.read_sql('SELECT * FROM customer_seller_geolocation',engine)
    
    y_c = df['geolocation_lat_customer']*np.pi/180
    x_c = df['geolocation_lng_customer']*np.pi/180
    y_s = df['geolocation_lat_seller']*np.pi/180
    x_s = df['geolocation_lng_seller']*np.pi/180

    a = np.sin((y_s-y_c)/2)**2 + np.cos(y_c)*np.cos(y_s)*np.sin((x_s-x_c)/2)**2
    c = 2*np.arcsin(np.sqrt(a))
    d = R*c

    df['distance'] = d
    df.to_sql('order_haversine_distance',engine,if_exists='replace',index=False)

if __name__ == '__main__':
    haversine()