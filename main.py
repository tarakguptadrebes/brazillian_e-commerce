from brazillian_e_commerce.download_e_commerce_data import download
from brazillian_e_commerce.clean_data import clean
from brazillian_e_commerce.indexes import init_indexes
from brazillian_e_commerce.transform_data import transform
from brazillian_e_commerce.haversine_formula import haversine
from brazillian_e_commerce.analyse_data import analyse

def main():
    
    download()
    clean()
    init_indexes()
    transform()
    haversine()
    analyse()

if __name__ == '__main__':
    main()