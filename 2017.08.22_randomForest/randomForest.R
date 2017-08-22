
library(randomForest)
library(titanic)

results <- list()

# download Titanic Survivors data
data <- read.table("http://math.ucdenver.edu/RTutorial/titanic.txt", h=T, sep="\t")
# make survived into a yes/no
data$Survived <- as.factor(ifelse(data$Survived==1, "yes", "no"))                 

# split into a training and test set
idx <- runif(nrow(data)) <= .75
data.train <- data[idx,]
data.test <- data[-idx,]

# train a random forest
rf <- randomForest(Survived ~ PClass + Age + Sex, 
                   data=data.train, importance=TRUE, na.action=na.omit)

# how important is each variable in the model
imp <- importance(rf)
o <- order(imp[,3], decreasing=T)
imp[o,]
#             no      yes MeanDecreaseAccuracy MeanDecreaseGini
#Sex    51.49855 53.30255             55.13458         63.46861
#PClass 25.48715 24.12522             28.43298         22.31789
#Age    20.08571 14.07954             24.64607         19.57423

# confusion matrix [[True Neg, False Pos], [False Neg, True Pos]]
results[["basic"]] <- table(data.test$Survived, predict(rf, data.test), dnn=list("actual", "predicted"))
#      predicted
#actual  no yes
#   no  427  16
#   yes 117 195
results[["basic"]]


###########################TITANTIC##############
data <- titanic_train
data$Survived <- as.factor(ifelse(data$Survived==1, "yes", "no"))                 
data$Pclass <- as.factor(data$Pclass)
data$Sex <- as.factor(data$Sex)
data$Cabin <- as.factor(data$Cabin)
data$Embarked <- as.factor(data$Embarked)

# split into a training and test set
idx <- runif(nrow(data)) <= .75
data.train <- data[idx,]
data.valid <- data[-idx,]

# train a random forest
rf <- randomForest(Survived ~ Pclass + Sex, 
                   data=data.train, importance=TRUE, na.action=na.omit)

# how important is each variable in the model
imp <- importance(rf)
o <- order(imp[,3], decreasing=T)
imp[o,]
#             no      yes MeanDecreaseAccuracy MeanDecreaseGini
#Sex    51.49855 53.30255             55.13458         63.46861
#PClass 25.48715 24.12522             28.43298         22.31789
#Age    20.08571 14.07954             24.64607         19.57423

# confusion matrix [[True Neg, False Pos], [False Neg, True Pos]]
results[["rf1"]] <- table(data.valid$Survived, predict(rf, data.valid), dnn=list("actual", "predicted"))
results[["rf1"]]

###########################TITANTIC 2##############

# train a random forest
rf <- randomForest(Survived ~ Pclass + Sex + Age + Embarked, 
                   data=data.train, importance=TRUE, na.action=na.omit)

# how important is each variable in the model
imp <- importance(rf)
o <- order(imp[,3], decreasing=T)
imp[o,]
#             no      yes MeanDecreaseAccuracy MeanDecreaseGini
#Sex    51.49855 53.30255             55.13458         63.46861
#PClass 25.48715 24.12522             28.43298         22.31789
#Age    20.08571 14.07954             24.64607         19.57423

# confusion matrix [[True Neg, False Pos], [False Neg, True Pos]]
results[["rf2"]] <- table(data.valid$Survived, predict(rf, data.valid), dnn=list("actual", "predicted"))
results[["rf2"]]

###########################TITANTIC 3##############

# train a random forest
rf <- randomForest(Survived ~ Pclass + Sex + Age + Embarked + SibSp + Parch, 
                   data=data.train, importance=TRUE, na.action=na.omit)

# how important is each variable in the model
imp <- importance(rf)
o <- order(imp[,3], decreasing=T)
imp[o,]
#             no      yes MeanDecreaseAccuracy MeanDecreaseGini
#Sex    51.49855 53.30255             55.13458         63.46861
#PClass 25.48715 24.12522             28.43298         22.31789
#Age    20.08571 14.07954             24.64607         19.57423

# confusion matrix [[True Neg, False Pos], [False Neg, True Pos]]
results[["rf3"]] <- table(data.valid$Survived, predict(rf, data.valid), dnn=list("actual", "predicted"))
results[["rf3"]] 

### Predicted that you would respond yes, but actually No, not that costly
### Predicted you respond No, but actually Yes, very costly

utilmat <- matrix(c(1, -1, 0, 50), nrow = 2, byrow = TRUE)
