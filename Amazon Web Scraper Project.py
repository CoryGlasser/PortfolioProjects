#!/usr/bin/env python
# coding: utf-8

# # Amazon Web Scraper Project

# In[4]:


# import libraries

from bs4 import BeautifulSoup
import requests
import time
import datetime


# In[38]:


# connect to website and pull data

URL = 'https://www.amazon.com/Funny-Data-Systems-Business-Analyst/dp/B07FNW9FGJ/ref=sr_1_3?dchild=1&keywords=data%2Banalyst%2Btshirt&qid=1626655184&sr=8-3&customId=B0752XJYNL&th=1'

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}
 
page = requests.get(URL, headers = headers)

soup1 = BeautifulSoup(page.content, 'html.parser')

soup2 = BeautifulSoup(soup1.prettify(), 'html.parser')

title = soup2.find(id = 'productTitle').text.strip()

price = soup2.find("span",{'class':"a-offscreen"}).text.strip()


print(title)
print(price)


# In[43]:


#create timestamp for when data is collected

import datetime

today = datetime.date.today()

print(today)


# In[44]:


# create csv and write headers and data into file

import csv

header = ['Title', 'Price', 'Date']
data = [title, price, today]

with open('C:/Users/coryg/OneDrive/Documents/AmazonWebScraperDataset.csv', 'w', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(header)
    writer.writerow(data)
     


# In[ ]:


import pandas as pd

df = pd.read_csv('C:/Users/coryg/OneDrive/Documents/AmazonWebScraperDataset.csv')

print(df)


# In[ ]:


# appending data to csv

with open('C:/Users/coryg/OneDrive/Documents/AmazonWebScraperDataset.csv', 'a+', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(data)


# In[ ]:


# combine all of the above into one function

def check_price():
    URL = 'https://www.amazon.com/Funny-Data-Systems-Business-Analyst/dp/B07FNW9FGJ/ref=sr_1_3?dchild=1&keywords=data%2Banalyst%2Btshirt&qid=1626655184&sr=8-3&customId=B0752XJYNL&th=1'
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}
    page = requests.get(URL, headers = headers)
    soup1 = BeautifulSoup(page.content, 'html.parser')
    soup2 = BeautifulSoup(soup1.prettify(), 'html.parser')
    title = soup2.find(id = 'productTitle').text.strip()
    price = soup2.find("span",{'class':"a-offscreen"}).text.strip()
    
    import datetime
    today = datetime.date.today()
   
    import csv
    header = ['Title', 'Price', 'Date']
    data = [title, price, today]
    
    with open('C:/Users/coryg/OneDrive/Documents/AmazonWebScraperDataset.csv', 'a+', newline='', encoding='UTF8') as f:
        writer = csv.writer(f)
        writer.writerow(data)
        


# In[ ]:


# Runs check_price every day and inputs data into csv

while(True):
    check_price()
    time.sleep(86400)


# In[ ]:


import pandas as pd

df = pd.read_csv(r'C:/Users/coryg/OneDrive/Documents/AmazonWebScraperDataset.csv')

print(df)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




