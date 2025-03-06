import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report
from sklearn.metrics import accuracy_score
from random import seed
from random import randrange
from csv import reader
import csv
from pandas import read_csv
import matplotlib.pyplot as plt
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import r2_score
def process(path):
    data=pd.read_csv("dataset.csv")    
    X=data.drop(["Fruit_id","state"],axis = 1) #droping out index from features too
    y=data["state"]

    #Splitting the data into test and training sets

    X_train,X_test, y_train, y_test = train_test_split(X,y, test_size=0.3)
    #Fitting the KNNClassifier to the training set

    rfc = KNeighborsClassifier(n_neighbors=7)
    rfc.fit(X_train, y_train)
    X_test=path
    x=np.asarray(X_test).reshape(1,-1)

    #Making prediction and checking the test set

    y_pred = rfc.predict(x)
    print("Prediction=",y_pred)
    res=""
    if y_pred[0]==0:
        res="Safe"
    else:
        res="UnSafe"
    return res
        
#process(22)
