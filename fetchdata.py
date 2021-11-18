import requests
import csv
from bs4 import BeautifulSoup as bs
from datetime import date

# Divi
DIVI_TAGESREPORT_URL = 'https://www.divi.de/divi-intensivregister-tagesreport-archiv-csv?layout=table'
DIVI_SELECTOR = 'tr > td.edocman-document-title-td > a'
DIVI_FILENAME = 'divi_tagesreport.csv'
DIVI_LINKHEAD = 'https://www.divi.de/'

# RKI github Nowcasting
todaysDate = date.today().strftime('%Y-%m-%d')
GITHUB_RKI_URL = f'https://github.com/robert-koch-institut/SARS-CoV-2-Nowcasting_und_-R-Schaetzung/blob/main/Archiv/Nowcast_R_{todaysDate}.csv'
GITHUB_RKI_SELECTOR = '.BtnGroup > a#raw-url'
GITHUB_RKI_FILENAME = 'rki_nowcast.csv'
GITHUB_RKI_LINKHEAD = 'https://github.com'

# RKI github Impfungen Deutschland
GITHUB_RKI_IMPFUNG_BL_URL = f'https://github.com/robert-koch-institut/COVID-19-Impfungen_in_Deutschland/blob/master/Archiv/{todaysDate}_Deutschland_Bundeslaender_COVID-19-Impfungen.csv'
GITHUB_RKI_IMPFUNG_BL_FILENAME = 'rki_impfung_bundeslaender.csv'

GITHUB_RKI_IMPFUNG_IQ_URL = f'https://github.com/robert-koch-institut/COVID-19-Impfungen_in_Deutschland/blob/master/Archiv/{todaysDate}_Deutschland_Impfquoten_COVID-19.csv'
GITHUB_RKI_IMPFUNG_IQ_FILENAME = 'rki_impfung_impfquote.csv'


class DataFetcher:
    def __init__(self, url, selector, filename):
        self.url = url
        self.selector = selector
        self.filename = filename

    def runParser(self, linkhead, sep = ',', append = False):
        try:
            content = self.getContent(self.url)
            soup = bs(content, 'html.parser')
            link = soup.select(self.selector)[0].get('href')
        except IndexError:
            print(f'IndexError. Please double check URL and selector.\nURL: {self.url}\nselector: {self.selector}')
            return
        try:
            content = self.getContent(linkhead + link)
        except requests.exceptions.ConnectionError:
            print(f'Invalid Url. Please double check linkhead. If none is needed please provide \'\' as argument\nlinkhead: {linkhead}')
            return
        except requests.exceptions.MissingSchema:
            print(f'Please provie the appropriate schema like https or http')
            return
        csvText = bs(content, 'html.parser').text
        head = list(csvText.split('\n')[0].split(sep))
        data = csvText.split('\n')[1:]
        data = [list(x.split(sep)) for x in data]
        self.writefile(self.filename, head, data, append)

    def getContent(self, url):
        response = requests.get(url)
        content = response.content
        return content
    
    def writefile(self, filename, head, data, append = False):
        if append:
            with open(self.filename, 'a', newline = '') as file:
                writer = csv.writer(file, delimiter=',', quotechar = '"', quoting=csv.QUOTE_MINIMAL)
                writer.writerows(data)
        else:
            with open(self.filename, 'w', newline='') as file:
                writer = csv.writer(file, delimiter=',', quotechar = '"', quoting=csv.QUOTE_MINIMAL)
                writer.writerow(head)
                writer.writerows(data)

    def __del__(self):
        print(f'Fetching data from {self.url} completed.')


def main():
    DataFetcher(DIVI_TAGESREPORT_URL, DIVI_SELECTOR, DIVI_FILENAME).runParser(linkhead = DIVI_LINKHEAD, sep = ',')
    DataFetcher(GITHUB_RKI_URL , GITHUB_RKI_SELECTOR, GITHUB_RKI_FILENAME).runParser(linkhead = GITHUB_RKI_LINKHEAD, sep = ',')
    DataFetcher(GITHUB_RKI_IMPFUNG_BL_URL , GITHUB_RKI_SELECTOR, GITHUB_RKI_IMPFUNG_BL_FILENAME).runParser(linkhead = GITHUB_RKI_LINKHEAD, sep = ',')
    DataFetcher(GITHUB_RKI_IMPFUNG_IQ_URL , GITHUB_RKI_SELECTOR, GITHUB_RKI_IMPFUNG_IQ_FILENAME).runParser(linkhead = GITHUB_RKI_LINKHEAD, sep = ',')


if __name__ == '__main__':
    main()
    print('Done')

