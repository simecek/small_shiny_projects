library(qtl)
library(QTLRel)
library(shiny)

# Define UI
shinyUI(pageWithSidebar(
  
  #  Application title
  headerPanel(""),
  
  # Sliders and radiobuttons
  sidebarPanel(
    
    # Heretability
    sliderInput("her", "Heritability:",  
                min = 1, max = 99, value = 50),
    br(), 
    
    # inference
    radioButtons("itype", "Scanone procedure:",
                 list("qtl" = "qtl",                      
                      "QTLRel" = "QTLRel",
                      "regress + qtl" = "regqtl")),
    
    checkboxInput(inputId = "trhold",
                  label = "Plot R/qtl 5% threshold (warning - time consuming)",
                  value = FALSE),
    HTML("<hr>"),
    
    # qtl position
    sliderInput("qtlsize", "QTL effect size:", 
                min=0, max=1, value=0),
    HTML("<i>0 = none, 1 = standard deviation of phenotype before QTL addition</i>"),
    br(), br(),
    sliderInput("qtlpos", "QTL position in the genome:", 
                min=0, max=1, value=0.5),
    HTML("<i>0 = first marker on Chr1, 1 = last marker on chrX</i>"),
    br(),
    HTML("<hr>"),
    
    
    # cross type
    radioButtons("ctype", "Cross type:",
                 list("Intercross" = "f2",
                      "Backcross" = "bc",
                      "Sib-mating RIS" = "risib")),
    br(),
    radioButtons("htype", "Heritability (genetic factor) generated as",
                 list("Kinship matrix" = "kinship",
                      "Percentage of first founder's genotype" = "f1",
                      "X% markers are causal with the same effect size" = "sameeffect")),
    conditionalPanel(condition = "input.htype == 'sameeffect'",
                     sliderInput("causal", "Percentage of causal markers:", 
                                 min=0, max=100, value=10),
                     br()),
    br(),
    
    #Number of chromosomes
    sliderInput("nchr", "Number of chromosomes:", 
                min=2, max=30, value=20, step=1),
    
    # Length of chromosome
    sliderInput("chrlen", "Length of chromosome in cM:", 
                min = 10, max = 200, value = 100),
    
    # Number of markers
    sliderInput("nmr", "Number of markers per chromosome:",
                min = 2, max = 30, value = 10),
    
    # Number of individuals
    sliderInput("nind", "Number of individuals:", 
                min = 10, max = 500, value = 250),
    
    # Ylim
    sliderInput("ylim", "Range of y-axis:",  
                min = 0, max = 10, value = c(0,5)),
    br(), 
    HTML("<hr>"),
    
    actionButton("button", "Generate New Data"),
    br(), br(),
    
    div("Petr Simecek, powered by R and Shiny, source code on ",
        a("Github", href="https://github.com/rakosnicek/small_shiny_projects"))
  ),
  
  # Show a table summarizing the values entered
  mainPanel(
    div(plotOutput("lodplot", width="1000px", height="700px"), align="center")
  )
))
