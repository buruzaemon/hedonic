# Hedonic Regression
Quick example of using linear regression for real estate valuation for homes
in the Boston suburbs.


## Summary 

R's [`lm`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/lm.html)
function for linear model fitting was used for a Hedonic regression to predict
with fair accuracy the median value of owner-occupied homes. While there was
some doubt as to the effect of independent variables `CRIM,` `INDUS`, `AGE`
and `B`, a model including all the independent variables available seemed to
work best at prediction.

### Cleaning the data

The original `data/housing.data` had columns delimited by varying amounts of
whitespace, so vim was used to clean up the file and change the delimiters to
commas.

### Fitting a linear model for Hedonic Regression

The basic model used was

    model1 = lm(MEDV ~ ., data=...)

This specifies the `MEDV` column as the dependent variable, and treats all
other columns as independent variables. Note that the `CHAS` column was
converted from an integer to a factor.

As the model using all independent variables was reporting questionable
levels of effect of independent variables `CRIM,` `INDUS`, `AGE` and `B`,
a second model not including those variables was also created.

Plots for fitted-values vs. residuals, as well as those for theoretical
quantiles vs. standardized residuals seemed to show very little difference
between the two models. However, the first model using all thirteen of the
available independent variables had a lower Adjusted R-squared value of
0.7192, compared to the second model using nine independent variables
(Adjusted R-squared of 0.722).

### Verifying the models

The data was randomly shuffled and then split into a training set with
400 rows, with the remaining 106 rows used for validation.

[Mean squared error](https://en.wikipedia.org/wiki/Mean_squared_error)
was used to measure the differences in accuracy between our two models,
with a lower score implying greater accuracy.

The results:
* model 1: 18.756444 
* model 2: 18.896384 

A plot of the predicted `MEDV` vs. the actual `MEDV` values was created.
The accuracy of the model is visually interpreted as the distance of a 
point from the diagonal line y=x. 

As the points in this plot seem to lie fairly close to the diagonal,
we conclude that the linear model works very well for Hedonic regression.
R's `lm` and `predict` functions are well-documented, easy-to-use,
and the results are reasonably simple to interpret and comprehend.


## Data

* Data was obtained on 2016年 9月 22日 木曜日 00:32:22
* URL: https://archive.ics.uci.edu/ml/datasets/Housing
* Number of Instances: 506
* Number of Attributes: 13 continuous attributes (including "class" attribute "MEDV"), 1 binary-valued attribute
* Attribute Information:
  * `CRIM` ... per capita crime rate by town
  * `ZN` ... proportion of residential land zoned for lots over 25,000 sq.ft.
  * `INDUS` ... proportion of non-retail business acres per town 
  * `CHAS` ... Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
  * `NOX` ... nitric oxides concentration (parts per 10 million) 
  * `RM` ... average number of rooms per dwelling
  * `AGE` ... proportion of owner-occupied units built prior to 1940
  * `DIS` ... weighted distances to five Boston employment centres 
  * `RAD` ... index of accessibility to radial highways
  * `TAX` ... full-value property-tax rate per $10,000 
  * `PTRATIO` ... pupil-teacher ratio by town 
  * `B` ... 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
  * `LSTAT` ... % lower status of the population 
  * `MEDV` ... Median value of owner-occupied homes in $1000's 
* No missing attributes in the data were found 
  

## References
The following references were used in this study, and are also stored under `docs`.
* [Valuation Using Hedonic Pricing Models](http://scholarship.sha.cornell.edu/cgi/viewcontent.cgi?article=1058&context=crer), Monson, 2009
* [Hedonic Housing Prices and the Demand for Clean Air](http://www.colorado.edu/ibs/crs/workshops/R_1-11-2012/root/Harrison_1978.pdf), Harrison & Rubinfeld, 1978
