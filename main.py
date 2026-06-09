from brazillian_e_commerce.download_e_commerce_data import download
from brazillian_e_commerce.clean_data import cleaning
from brazillian_e_commerce.analyse_data import analysis

def main():
    
    download()
    cleaning()
    analysis()

if __name__ == '__main__':
    main()