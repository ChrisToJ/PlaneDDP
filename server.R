options(rgl.useNULL=TRUE)
library(shinyRGL)
library(rgl)

calc_opt_plane <- function(M) {
    M <- as.matrix(M)
    # determine centroid of the points
    centroid <- apply(M, 1, mean)
    centred <- sweep(M, 1, centroid, "-")
    # determine normal vector of best-fitting plane
    s <- svd(centred)
    normal <- s$u[,match(min(s$d), s$d)]
    cbind(centroid,normal)
}
str2vec <- function(input) {
    result <- as.numeric(unlist(strsplit(input,",|;| ")))
    # replace NA by 0
    result[is.na(result)] <- 0
    # if fewer than 3 numbers entered
    if (length(result) < 3)
        result <- c(result, c(0,0,0))
    # only return the first 3 numbers
    result[1:3]
}

cat("This App calculates the best fitting plane through a set of 5 points...\n")

shinyServer(
    function(input, output, session) {
        
        p1 <- reactive(str2vec(input$P1))
        p2 <- reactive(str2vec(input$P2))
        p3 <- reactive(str2vec(input$P3))
        p4 <- reactive(str2vec(input$P4))
        p5 <- reactive(str2vec(input$P5))
        Matrix <- reactive({
            df <- data.frame(
                Point      = cbind(str2vec(input$P1),
                                   str2vec(input$P2),
                                   str2vec(input$P3),
                                   str2vec(input$P4),
                                   str2vec(input$P5))
            )
            rownames(df) = c("x","y","z")
            df
        })
        output$Mat <- renderTable({Matrix()})
        
        result <- reactive({
            df <- data.frame(
                calc_opt_plane(Matrix())
            )
            rownames(df) = c("x","y","z")
            df
        })
        output$res <- renderTable({result()})
        
        output$text1 <- renderText(paste(p1(), collapse=", "))
        output$text2 <- renderText(paste(p2(), collapse=", "))
        output$text3 <- renderText(paste(p3(), collapse=", "))
        output$text4 <- renderText(paste(p4(), collapse=", "))
        output$text5 <- renderText(paste(p5(), collapse=", "))
        
        output$myWebGL <- renderWebGL({
            mat <- result()
            mat[,2] <- mat[,2]+mat[,1]
            rad <- input$obs
            points3d(t(Matrix()), col=c("red","blue","green"), cex=3, pch=19, expand=2)
            spheres3d(t(Matrix()), radius=rad, col='red')
            
            lines3d(t(mat), col='blue')
            spheres3d(t(mat), radius=rad, col=c("green","blue"))
            
            axes3d()
        })
        output$num <- renderPrint({ input$obs })
    }
)

