library(shiny)
library(e1071)
library(randomForest)
library(caret)

# Read Pregnancy datasets and convert the outcome variable to factor
data <- read.csv("data/Pregnancy.csv")
validation <- read.csv("data/Pregnancy_Test.csv")
data$PREGNANT <- factor(data$PREGNANT)
validation$PREGNANT <- factor(validation$PREGNANT)

# Split the data into training and test sets
inTrain <- createDataPartition(data$PREGNANT, p=0.8, list=FALSE)
training <- data[inTrain,]
testing <- data[-inTrain,]

set.seed(1231)

# Building two models below may take upto 60 sec, please be patient.

# Fit a prediction model using Random Forest
rffit <- train(PREGNANT ~ ., data=training, method="rf", verbose=FALSE)
cmrf <- confusionMatrix(testing$PREGNANT, predict(rffit, testing))

# Ft a prediction model using Genaralized Linear Model
lmfit <- train(PREGNANT ~ ., data=training, method="glm")
cmlm <- confusionMatrix(testing$PREGNANT, predict(lmfit, testing))

# Calculate out-of-sample error with validation ddataset
cmoosrf <- confusionMatrix(validation$PREGNANT, predict(rffit, validation))
cmooslm <- confusionMatrix(validation$PREGNANT, predict(lmfit, validation))

# Define server logic required to generate prediction using user inputs
shinyServer(function(input, output) {
        
        # Server code below,
        #       1. Initialize a dataframe
        #       2. A reactive function that populates user selections from UI into this dataframe
        #       3. Prediction using RF model
        #       4. Prediction using GLM model
        #       5. Model summary and showing user input changes

        # Initialize data frame with default values
        datatest <- data.frame(Implied.Gender = factor(c("F"), levels=c("F","M","U")), Home.Apt..PO.Box = factor(c("A"), levels=c("A","H","P")),
                               Pregnancy.Test = as.integer(0),
                               Birth.Control = as.integer(0),
                               Feminine.Hygiene = as.integer(0),
                               Folic.Acid = as.integer(0),
                               Prenatal.Vitamins = as.integer(0),
                               Prenatal.Yoga = as.integer(0),
                               Body.Pillow = as.integer(0),
                               Ginger.Ale = as.integer(0),
                               Sea.Bands = as.integer(0),
                               Cigarettes = as.integer(0),
                               Smoking.Cessation = as.integer(0),
                               Wine = as.integer(0),
                               Maternity.Clothes = as.integer(0),
                               Stopped.buying.ciggies = as.integer(0),
                               Stopped.buying.wine = as.integer(0))
        
        
        # This reactive function updates the data frame with user input selections
        cleanData <- reactive ({

                # Update user selections for gender and home type
                datatest[1] <- as.factor(input$gender)
                datatest[2] <- as.factor(input$home)

                if (!is.null(input$shopping)) {datatest[as.integer(input$shopping) + 2] <- as.integer(1)}
                if (!is.null(input$history))  {datatest[as.integer(input$history) + 15] <- as.integer(1)}
                
                # UI page is arranged in the order that makes sense to user entering data
                # Re arrange the columns of data frame to be consistent with the training/test/validation datasets 
                dto <- datatest
                dto <- data.frame(datatest[1:11], datatest[16], datatest[12:13], datatest[17], datatest[14:15])
        })
        
        # Prediction using Random Forest
        output$pred.rf <- renderPrint({
                
                if (predict(rffit, cleanData()) == 1) { "Pregnant"} else { "Not Pregnant"} 
        })

        # Prediction using Generalized Linear Model
        output$pred.lm <- renderPrint({

                if (predict(lmfit, cleanData()) == 1) { "Pregnant"} else {"Not Pregnant"}
        })
        
        # Show model performance summary data to user        
        output$lmsummary <- renderPrint({ cmlm })
        output$rfsummary <- renderPrint({ cmrf })
        output$ooslmsummary <- renderPrint({ cmooslm })
        output$oosrfsummary <- renderPrint({ cmoosrf})
        
        # Show user input selections
        output$inputvalue5 <- renderPrint(t(cleanData()[1,]))
        
})
