import pandas as pd
import matplotlib as plt
import numpy as np
from sklearn import linear_model
#from sklearn.model_selection cross_validation
from scipy.stats import norm

from sklearn.svm import SVC
from sklearn import svm
from sklearn.svm import LinearSVC
from sklearn.model_selection import train_test_split

from sklearn.metrics import accuracy_score
from random import seed
from random import randrange
from csv import reader
import csv
import numpy as np
import pandas as pd
from pandas import read_csv
import matplotlib.pyplot as plt
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import r2_score
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split


def process(path):
        data=pd.read_csv(path)    
        X=data.drop(["Fruit_id","state"],axis = 1) #droping out index from features too
        y=data["state"]
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
        model2=LogisticRegression(random_state = 0)
        model2.fit(X_train, y_train)
        y_pred = model2.predict(X_test)
        print("predicted")
        print(y_pred)
        print(y_test)
        result2=open("results/resultLR.csv","w")
        result2.write("ID,Predicted Value" + "\n")
        for j in range(len(y_pred)):
            result2.write(str(j+1) + "," + str(y_pred[j]) + "\n")
        result2.close()
        
        mse=mean_squared_error(y_test, y_pred)
        mae=mean_absolute_error(y_test, y_pred)
        r2=r2_score(y_test, y_pred)
        
        
        print("---------------------------------------------------------")
        print("MSE VALUE FOR Logistic Regression IS %f "  % mse)
        print("MAE VALUE FOR Logistic Regression IS %f "  % mae)
        print("R-SQUARED VALUE FOR Logistic Regression IS %f "  % r2)
        rms = np.sqrt(mean_squared_error(y_test, y_pred))
        print("RMSE VALUE FOR Logistic Regression IS %f "  % rms)
        ac=accuracy_score(y_test,y_pred)
        print ("ACCURACY VALUE Logistic Regression IS %f" % ac)
        print("---------------------------------------------------------")
        

        result2=open('results/LRMetrics.csv', 'w')
        result2.write("Parameter,Value" + "\n")
        result2.write("MSE" + "," +str(mse) + "\n")
        result2.write("MAE" + "," +str(mae) + "\n")
        result2.write("R-SQUARED" + "," +str(r2) + "\n")
        result2.write("RMSE" + "," +str(rms) + "\n")
        result2.write("ACCURACY" + "," +str(ac) + "\n")
        result2.close()
        
        
        df =  pd.read_csv('results/LRMetrics.csv')
        acc = df["Value"]
        alc = df["Parameter"]
        colors = ["#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#8c564b"]
        explode = (0.1, 0, 0, 0, 0)  
        
        fig = plt.figure()
        plt.bar(alc, acc,color=colors)
        plt.xlabel('Parameter')
        plt.ylabel('Value')
        plt.title('Logistic Regression Metrics Value')
        fig.savefig('results/LRMetricsValue.png') 
        plt.pause(5)
        plt.show(block=False)
        plt.close()
#process("dataset.csv")
