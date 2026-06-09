from brazillian_e_commerce.download_e_commerce_data import download
from brazillian_e_commerce.run_sql import cleaning
from brazillian_e_commerce.run_sql import analysis

def main():
    
    download()
    cleaning()
    analysis()

if __name__ == '__main__':
    main()