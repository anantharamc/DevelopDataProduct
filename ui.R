library(shiny)

# Define UI for application that predicts a retail store shopper's household has a pregnant woman or not
# based on past shopping history for this customer and today's shopping list

shinyUI(fluidPage(

        # Application title
        titlePanel("BigBox Retail Store Marketing"),
        
        # Sidebar with two drop-down boxes and two checkbox groups
        sidebarLayout(
                sidebarPanel(

                        selectInput("gender", "Gender:",
                                    c("Female" = "F",
                                      "Male" = "M",
                                      "Unknown" = "U")),

                        selectInput("home", "Type of Home:",
                                    c("Apartment" = "A",
                                      "Home" = "H",
                                      "P.O.Box" = "P")),

                        checkboxGroupInput("shopping", label = h4("Shopping List"), 
                                           choices = list("Pregnancy Test" = 1, 
                                                          "Birth Control" = 2, 
                                                          "Feminine Hygiene" = 3,
                                                          "Folic Acid" = 4,
                                                          "Prenatal Vitamins" = 5,
                                                          "Prenatal Yoga" = 6,
                                                          "Body Pillow" = 7,
                                                          "Ginger Ale" = 8,
                                                          "Sea Bands" = 9,
                                                          "Cigarettes" = 10,
                                                          "Smoking Cessation" = 11,
                                                          "Wine" = 12,
                                                          "Maternity Clothes" = 13
                                                          ),
                                           selected = 0),

                        checkboxGroupInput("history", label = h4("Recent Shopping History"), 
                                           choices = list("Stopped Buying Cigarettes" = 1, 
                                                          "Stopped Buying Wine" = 2),
                                           selected = 0),
                        
                        submitButton("Submit")
                ),

               
                # Show prediction whether the shopper's household has a pregnant woman
                # based on recent shopping history as well as current shopping list
                
                mainPanel(
                        h4("When the app loads first time, please wait for 60sec while the Prediction models are built (until default predictions display 'Not Pregnant'). Thank you!"),
                        h5("Please see 'Help' tab for usage instructions"),
                        br(),
                        # There are 3 tabs in this app; 
                        # 1. Prediction
                        # 2. Model Summary
                        # 3. Help
                        tabsetPanel(
                                
                                # This first tab dispalys prediction from Random Forest model and GLM
                                tabPanel("Prediction", "RF Prediction", verbatimTextOutput("pred.rf"), "GLM Prediction", verbatimTextOutput("pred.lm"), "User Input", verbatimTextOutput("inputvalue5")),
                                
                                # Second tab shows model performance
                                tabPanel("Model Summary", "RF Model Summary - Test set", verbatimTextOutput("rfsummary"), "RF Model Summary - Validation set", verbatimTextOutput("oosrfsummary"), 
                                         " GLM Model Summary - Test set", verbatimTextOutput("lmsummary"), "GLM Model Summary - Validation set", verbatimTextOutput("ooslmsummary")), 
                                
                                # Third tab provides help text for the app
                                tabPanel("Help", 
                                                h4("Scenario"),
                                                "Imagine you are the Marketing Executive for a BigBox Retail Store. This app will help you predict whether a 
                                                customer can be targeted for marketing maternity products based on customer's shopping list.",
                                                br(),br(), 
                                                h4("Usage Instructions"), 
                                                "1) Please wait until models are generated", br(),
                                                "2) When the models are ready, you will see default prediction = Not Pregnant", br(),
                                                "3) Select any combination of input in the sidebar panel ", br(),
                                                "4) Press Submit button",
                                                br(),br(),
                                                h4("Outcome"),
                                                "1) If the model predicts 'Pregnant', then customer's household may be targeted for marketing maternity products", br(),
                                                "2) If the model predicts 'Not Pregnant' then the customer may not have a pregnant household"
                                          
                                         )
                        )
                )
        )
))