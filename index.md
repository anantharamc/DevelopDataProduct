---
title       : BigBox Retail Store Marketing
subtitle    : Customer Shopping Analytics
author      : Anantha R. Chadalavada
job         : Data Scientist
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
github:
        user: anantharamc
        repo: DevelopDataProduct
---

## Overview

Imagine you are the Marketing Executive for BigBox Retail Store. You would like to improve sales of maternity products. You would like to do that by targeting marketing efforts towards potential customers who are likely to purchase maternity products.

### Question:

Can we predict whether a specific customer has a pregnant household?

### Methodology:

Luckily, BigBox Retail Store has lot of historical customer data on customer purchases including household's pregnant status. This app will build a machine learning prediction model on the historical data using Random Forest and Genaralized Linear Model.

* You will tell the app this customer's shopping list and demographic information
* App will predict whether the customer likely to have a pregant household


--- .class #id 

## Project Motivation & Data

1. This application is based on codebook and data published by "Data Smart" book written by John W. Foreman. (Chapters 6 & 10)
2. Data is available at http://www.wiley.com/go/datasmart
3. Download "Pregnancy.csv" and "Pregnancy_Test.csv" from the above website 

### Features

* Customer Implied.Gender (obtained by matching name against Census data)
* Customer address is home/apartment/P.O.Box
* Shopping list: Pregnancy test, Prenatal Vitamins, Ginger Ale, Birth Control ... etc.,
* Recent purchase history on Cigarettes and Wine; Bought them regularly and then recently stopped buying

---

## Feature Importance

The chart below shows variable importance from Random Forest Prediction model.

![plot of chunk unnamed-chunk-1](assets/fig/unnamed-chunk-1-1.png) 


---

## Results & Conclusions
