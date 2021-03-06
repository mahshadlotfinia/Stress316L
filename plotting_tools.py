"""
Created on January 28, 2021
COnverting the obtained dataset to csv

@author: Soroosh Tayebi Arasteh <soroosh.arasteh@fau.de>
https://github.com/starasteh/
"""

import os
import pandas as pd


# x

data_xls = pd.read_excel('./xneural.xlsx', 'Sheet1', encoding='utf-8', header=None)
data_xls = data_xls.rename(columns={0:'strain', 1:'strain_rate'})

new_data = pd.DataFrame(columns=['strain', 'strain_rate'])
# data_xls = data_xls.to_csv('your_csv.csv', encoding='utf-8', index=False)
new_data = new_data.append(data_xls)

new_data.to_csv('./features.csv', index=False)


# y

data_xls = pd.read_excel('./yneural.xlsx', 'Sheet1', encoding='utf-8', header=None)
data_xls = data_xls.rename(columns={0:'stress'})

new_data = pd.DataFrame(columns=['stress'])
# data_xls = data_xls.to_csv('your_csv.csv', encoding='utf-8', index=False)
new_data = new_data.append(data_xls)

new_data.to_csv('./labels.csv', index=False)



# x; with downsampling with a factor of 15

data_xls = pd.read_excel('./xneural.xlsx', 'Sheet1', encoding='utf-8', header=None)
data_xls = data_xls.rename(columns={0:'strain', 1:'strain_rate'})

new_data = pd.DataFrame(columns=['strain', 'strain_rate'])
for index, row in data_xls.iterrows():
    if index%15 == 0:
        new_data = new_data.append(row)
new_data.to_csv('./features_decresead.csv', index=False)



# y; with downsampling with a factor of 15

data_xls = pd.read_excel('./yneural.xlsx', 'Sheet1', encoding='utf-8', header=None)
data_xls = data_xls.rename(columns={0:'stress'})

new_data = pd.DataFrame(columns=['stress'])
for index, row in data_xls.iterrows():
    if index%15 == 0:
        new_data = new_data.append(row)
new_data.to_csv('./labels_decresead.csv', index=False)
