from brazillian_e_commerce.download_e_commerce_data import download
from brazillian_e_commerce.clean_data import clean
from brazillian_e_commerce.analyse_data import analyse

def main():
    
    download()
    clean()
    analyse()

if __name__ == '__main__':
    main()