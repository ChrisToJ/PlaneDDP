options(rgl.useNULL=TRUE)
library(shinyRGL)
library(rgl)

shinyUI(pageWithSidebar(
    headerPanel("Calculation of the best-fitting 3D plane defined by 5 points"),
    sidebarPanel(
        h5("Coordinates:"),
        p("Please provide your input as shown below:"),
        p("x-coordinate,y-coordinate,z-coordinate"),
        textInput(inputId="P1", label = "Point 1", value=paste(round(runif(3)*c(5,5,1),2), collapse=",")),
        textInput(inputId="P2", label = "Point 2", value=paste(round(runif(3)*c(5,5,1),2), collapse=",")),
        textInput(inputId="P3", label = "Point 3", value=paste(round(runif(3)*c(5,5,1),2), collapse=",")),
        textInput(inputId="P4", label = "Point 4", value=paste(round(runif(3)*c(5,5,1),2), collapse=",")),
        textInput(inputId="P5", label = "Point 5", value=paste(round(runif(3)*c(5,5,1),2), collapse=",")),
        h5("Graphical parameter:"),
        numericInput("obs", "point size:", 0.1, min=0.01, max=10, 0.01)
    ),
    mainPanel(
        tabsetPanel(type = "tabs", 
                    tabPanel("Calculation", 
                             h4("Summary:"),
                             tableOutput("Mat"),
                             h4("Results:"),
                             tableOutput("res")),
                    tabPanel("Visualisation",
                             h4("3D model:"),
                             webGLOutput("myWebGL")),
                    tabPanel("Documentation", 
                             h4("Calculation of the best-fitting 3D plane:"),
                             h5("Summary"),
                             p("This ",em("planeR")," app allows the user to calculate the best fitting plane from a set of five reference 
                               points."),
                             h5("Input"),
                             p("For each of the five points the x-, y-, and z-coordinates are required. 
                                The numbers should be separated by a single ',' 
                                (as shown on the left panel with randomly generated initial values).
                                The points should not be positioned on a line since in this case the 3D plane would not be defined."),
                             p("For the 3D visualisation the point size can be adjusted."),
                             h5("Calculation & results"),
                             p("The values of the 5 points are shown in a table to allow the user to check the inputs.
                                As results of the calculations the centroid of the 5 points and the normal vector of the best-fitting plan
                                are displayed."),
                             h5("Visualisaton & 3D model"),
                             p("The five input points are shown in red. The centroid is shown in green. The normal vector is shown
                                as a blue line connecting the centroid with the blue sphere. The 3D model can be manipulated interactively
                                using e.g. the mouse: zooming (wheel), rotation (press button and move), etc. JavaScript has to be enabled."),
                             h5("Documentation"),
                             p("This document is intended to help the user to get started with the ", em("planeR"), " app."))
        )
    )
))
