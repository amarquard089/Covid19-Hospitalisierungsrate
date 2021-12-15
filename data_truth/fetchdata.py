import requests
import csv
import time
from bs4 import BeautifulSoup as bs
from datetime import date
from selenium import webdriver

# Divi
DIVI_TAGESREPORT_URL = 'https://www.divi.de/divi-intensivregister-tagesreport-archiv-csv?layout=table'
DIVI_SELECTOR = 'tr > td.edocman-document-title-td > a'
DIVI_FILENAME = './DIVI/divi_tagesreport.csv'
DIVI_LINKHEAD = 'https://www.divi.de/'

# LMU
LMU_URL = 'https://corona.stat.uni-muenchen.de/nowcast/'
LMU_SELECTOR = 'a[href="#shiny-tab-tab_hosp"]'
LMU_SELECTOR2 = '#download_nowcast_hosp_res'
LMU_FILENAME = './LMU/nowcasting_lmu_hosp.csv'
LMU_LINKHEAD = 'https://corona.stat.uni-muenchen.de/nowcast/'

class DataFetcher:
    def __init__(self, url, selector, filename):
        self.url = url
        self.selector = selector
        self.filename = filename

    def runParser(self, linkhead, sep = ',', append = False, quoting = csv.QUOTE_MINIMAL, content = None):
        try:
            if content:
                content = content
            else:
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
            print(f'Please provide the appropriate schema like https or http')
            return
        csvText = bs(content, 'html.parser').text
        head = list(csvText.split('\n')[0].split(sep))
        head = [x.strip('"') for x in head]
        data = csvText.split('\n')[1:]
        data = [list(x.split(sep)) for x in data]
        data = [[x.strip('"') for x in y] for y in data]
        self.writefile(self.filename, head, data, append, quoting)

    def getContent(self, url):
        response = requests.get(url)
        content = response.content
        return content
    
    def writefile(self, filename, head, data, append, quoting):
        if append:
            with open(self.filename, 'a', newline = '') as file:
                writer = csv.writer(file, delimiter=',', quotechar = '"', quoting = quoting)
                writer.writerows(data)
        else:
            with open(self.filename, 'w', newline='') as file:
                writer = csv.writer(file, delimiter=',', quotechar = '"', quoting = quoting)
                writer.writerow(head)
                writer.writerows(data)

    def __del__(self):
        print(f'Fetching data from {self.url} completed.')


def openWithSeleniumReturnContent(url, selector):
    browser = webdriver.Firefox()
    browser.get(url)
    time.sleep(1)
    btn = browser.find_element_by_css_selector(selector)
    webdriver.ActionChains(browser).click(btn).perform()
    time.sleep(2)
    content = browser.page_source
    browser.close()
    return content

def main():
    #DataFetcher(DIVI_TAGESREPORT_URL, DIVI_SELECTOR, DIVI_FILENAME).runParser(linkhead = DIVI_LINKHEAD, sep = ',')
    content = openWithSeleniumReturnContent(LMU_URL, LMU_SELECTOR)
    DataFetcher(LMU_URL, LMU_SELECTOR2, LMU_FILENAME).runParser(linkhead = LMU_LINKHEAD, sep = ',',  content = content)
    

if __name__ == '__main__':
    main()
    print('Done')

