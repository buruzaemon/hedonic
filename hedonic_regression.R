set.seed(1234)

fin = file.path("data", "housing.data")
df = read.table(fin, 
                sep=",", 
				col.names=c("CRIM", 
				            "ZN", 
							"INDUS", 
							"CHAS", 
							"NOX", 
				            "RM", 
							"AGE", 
							"DIS", 
							"RAD", 
							"TAX", 
							"PTRATIO", 
							"B",
							"LSTAT",
							"MEDV"))

str(df)

df$CHAS = as.factor(df$CHAS)
str(df)

# shuffle the rows in our data randomly
df = df[sample(nrow(df)),]
train = df[c(1:400),]
test  = df[c(401:506),]

# use all independent variables
#   Note the CRIM, INDUS, AGE, B appear to have little effect?
model1 = lm(MEDV ~ ., data=train)
summary(model1)

# model1 has Adjusted R-squared of 0.7192

# try another model w/out CRIM, INDUS, AGE, B
model2 = lm(MEDV ~ ZN+CHAS+NOX+RM+DIS+RAD+TAX+PTRATIO+LSTAT, data=df)
summary(model2)

# model2 has Adjusted R-squared of 0.722
# there is not much of a difference between model1 and model2

library(ggfortify)
#autoplot(model1, which=c(1,2))
autoplot(model1, which=c(1))
ggsave(file.path("images", "img01_model1_fitted-residuals.png"))
autoplot(model1, which=c(2))
ggsave(file.path("images", "img02_model1_normalqq.png"))

#autoplot(model2, which=c(1,2))
autoplot(model2, which=c(1))
ggsave(file.path("images", "img03_model2_fitted-residuals.png"))
autoplot(model2, which=c(2))
ggsave(file.path("images", "img04_model2_normalqq.png"))

y = test$MEDV
test = subset(test, select=-c(MEDV))

# using model1, make predictions
y_hat = predict(model1, test)

# measure accuracy via Mean Squared Error
sprintf("MSE for model1: %f", sum((y_hat - y)^2) / nrow(test))

# plot predicted MEDV vs actual MEDV
ggplot(data.frame(y_hat, y), aes(x=y_hat, y=y)) +
    geom_point(color='blue') +
	geom_abline(color='red', linetype=2) +
	xlab("Predicted") +
	ylab("Actual") +
	ggtitle("Accuracy of model1")
ggsave(file.path("images", "img05_model1_accuracy.png"))

# and now do the same for model2
y_hat = predict(model2, test)

# measure accuracy via Mean Squared Error
sprintf("MSE for model2: %f", sum((y_hat - y)^2) / nrow(test))

# plot predicted MEDV vs actual MEDV
ggplot(data.frame(y_hat, y), aes(x=y_hat, y=y)) +
    geom_point(color='blue') +
	geom_abline(color='red', linetype=2) +
	xlab("Predicted") +
	ylab("Actual") +
	ggtitle("Accuracy of model2")
ggsave(file.path("images", "img06_model2_accuracy.png"))
