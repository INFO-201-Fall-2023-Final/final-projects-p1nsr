library(shiny)
library(plotly)
library(hrbrthemes)
library(rsconnect)
source("CleanedDataset.R")

global_df <- read.csv("unified_avg_data.csv")
arrangeData_df <- read.csv("arrangeData_2021.csv")
oil_data_df <- read.csv("oil_data.csv")

#Home page of the App 
home_panel <- fluidPage(
  style = "background-color: #f6fef6; width = 100%;",
  div(titlePanel(em("Climate Change: CO2 and People")), style = "text-align: center;"),
  br(),
  div(img(src = "climate.jpg", height = "25%", width = "42%"), style="text-align: center;"),
  h1(em("Welcome!")),
  p("The rising carbon emissions across the globe is one of the most pressing 
  issues facing our planet and species. The relationship between the sure 
  in carbon emissions over the last three decades and the changes in human factors such as 
  the escalating population, new materials, and modern practices
  is not something that can be ignored. In our analysis between these two issues, 
  we aim to shed light on the ramifications we have and will continue to experience 
  if no changes are made. We have made a dataset which contains information on the 
  rise of population and carbon emissions from 1990-2021."),
  
  br(),
  h3("Why Does This Matter?"),
  p("The threat posed by climate change and the exponential rise in global population demands 
our immediate attention and action. More carbon in our atmosphere is proven to lead to a 
rise in global warming, shifts in weather patterns, and more extreme weather events. Furthermore, 
ocean acidification and air pollution are two major factors in the loss of biodiversity and 
livable conditions. The melting of the ice caps is causing rising sea levels which poses a 
threat to coastal communities across the globe. Our project aims to find the nuances of the 
connection between increasing populations and carbon emissions."),

  br(),
  h3("Why Should You Care?"),
  p("Understanding the connection between these two factors is more than an educational endeavor; it’s 
  a call to action for anyone who has the best interest of humans in mind. We hold the ability to 
  shape a sustainable future for our planet and generations yet to come. This project should serve 
  as a wakeup call to start making informed decisions that mitigate the impact of population growth
  and carbon emissions.")
)

#First page analyzing the Global CO2 and Population Growth (1990-2021)
page1_panel <- fluidPage(
  style = "background-color: #f6fef6",
  titlePanel(em("Global Average CO2 And Population through 1990")),
  p("In this section we will analyze the Global Population growth and Average CO2 Emission 
    through the years of 1990 to 2021! Since the world has grown so rapidly we wanted
    to examine wheter the rapid effects of climate change has been affected due to
    our rapid population growth and CO2 intake."),
  p("Below we will analyze this through a bubbleplot:"),
  br(),
  h3("Examining the trend between 1990 and 2021"),
  sidebarLayout(
    sidebarPanel(
      h4("Controls"),
      sliderInput(
        inputId = "pop_slider",
        label = "Filter by Population (Billions)",
        min = 5,
        max = 8,
        value = 8
      ),
    ),
    mainPanel(
      plotlyOutput(outputId = "co2_pop"),
    ),
  ),
  h3("Findings"),
  p("Looking at our graph, there seems to be a strong linear correlation 
    between the the global population and average CO2 emissions through the past
    31 years. This could indicate that the rapid growth in population and the need 
    for CO2 in our modern world has an almost 1:1 ratio. This could possibly mean that
    since there are more people each year, there is more of a need to use CO2 emitted
    services to keep with the modern lifestyle. The rise in CO2 is a worrying
    factor to the health of our enviroment and we should find more things to substitute to mitigate these 
    harms of climate change.")
)

#Second Page of the App 
page2_panel <- fluidPage(
  style = "background-color: #f6fef6",
  titlePanel(em("Average Amount of Oil Through the Years 1990-2021")),
  p("Now let's move on to something most people use: Oil. Since the world has become oil-dependent to run our modern lifestyles, 
    we wanted to investigate the amounts of CO2 that oil has emitted from people the past 31 years. In this analysis, we will take a look at the
    average amount of oil emissions since the year 1990 and see if this highly
    controversial substance can be seen as a factor in rapid climate change. Lastly, we will 
    also take a look at CO2 emissions and comapare both trends."),
  br(),
  h3("Examining the Average Oil Through the Decades:"),
  br(),
  sidebarLayout(
    sidebarPanel(
  selectInput(
    inputId = "Years",
    label = "Select a year",
    choices = global_df$Year
     ),
    ),
      mainPanel(
        h5("CO2 Table"),
        tableOutput(outputId = "table"),
        plotlyOutput(outputId = "plot_oil"),
#        plotlyOutput(outputId = "bar_oil")
        p("Now lets take a look at our CO2 emissions each year and see if it follows
          along the oil's upwards trend!"),
        plotlyOutput(outputId = "co2_oil")
      )
  ),
  h3("Findings"),
  p("Looking at the two graphs, there is a clear indication of a rapid increase and acceleration in both 
  emissions from 1990 to 2021. Something that seemed interesting was how there was a large dip around
  2020, and this is most likely due to the pandemic shutting down travel and CO2 emitted industries. But continuing on with the
  rapid trend increase in CO2 emissions, this is likely due to a number of human factors, including population growth, economic growth, and the increased use of fossil fuels. The burning of fossil fuels releases greenhouse gases into the atmosphere,
  which trap heat and contribute to climate change.
  This is a worrying trend, as it suggests that climate change is happening faster than we thought, and we should figure out alternatives such
  as clean energy to potenitally fix this.")
  )

#Third Page of the App 
page3_panel <- fluidPage(
  style = "background-color: #f6fef6",
  titlePanel(em("Comparing Top Emitted Countries in 2021")),
  p("Now let's take a look at this CO2 emission problem on a specfic scale. Following
    the trend of looking at the effects of people on the climate, we can now narrow
    down our focus at countries that have contributed the most in the CO2 industry.
    This page will take a look at the most recent year in the dataset, 2021, and analyze
    the top ten countries that could be a factor in identifying the effects of climate change."),
  br(),
  h3("Examining Countries Total Emissions (2021): "),
  br(),
  mainPanel(
    tabsetPanel(
      tabPanel("Barplot", plotlyOutput(outputId = "countries_bar")),
      
      tabPanel("Table",
               h5("2021 Top 10 Countries (2021)"), 
               tableOutput(outputId = "ten_table")
              ),
    ),
    br(),
    h3("Findings"),
    p("Taking a peek at the chart, China is the top emitter of carbon dioxide gas in the world, with 11,472 MT emitted in 2021, while
    the United States is the second top emitter, with 5,007 MT emitted in 2021. It's really suprising to see a significant margin between these two, but this can be explained
    due to China's manufacturing and producing large percentage of the world's goods.
    Furthermore, this chart clearly shows that the top 10 emitting countries are all mostly developed countries and all have played a signifcant part in contributing to the world's growth.
    This indicates that these developed countries should find better solutions to reduce their carbon emissions, as they have contributed the most to the problem.
    Overall, this data shows that carbon dioxide emissions are a global problem, and that all countries need to take action to reduce their emissions.")
  )
)

#Contains the pages 
ui <- navbarPage(
  "Global CO2 and People",
  tabPanel("Home", home_panel),
  tabPanel("Page 1", page1_panel),
  tabPanel("Page 2", page2_panel),
  tabPanel("Page 3", page3_panel)
)

server <- function(input, output){
  
#First page bubble plot
  output$co2_pop <- renderPlotly({
    co2_pop_filter <- filter(global_avg_data, global_pop <= input$pop_slider)
    co2_pop <- ggplot(co2_pop_filter, aes(x = global_pop, y = avg_co2)) +
      geom_point(size = co2_pop_filter$avg_co2 * .01, aes(col = -avg_co2, alpha = .7)) +
      geom_smooth(method = lm, se = FALSE) +
      labs(
        color = "Avg CO2 (Mega Tons)"
      ) + xlab("Global Population (Billions)") + ylab("Global CO2 Emission (MT)") + 
      ggtitle("Global Population and CO2") 
    plot(co2_pop)
  })

#Second page table
  output$table <- renderTable({
    year_df <- filter(oil_data_df, Year == input$Years)
    return(year_df)
  })

#Second page scatterplot 
  output$plot_oil <- renderPlotly({
    oil <- ggplot(global_df, aes(x = Year, y = avg_oil_co2)) +
      geom_line() +
      geom_point(aes(col = avg_oil_co2)) +
      scale_color_gradient(low = "yellow", high = "red") +
      scale_color_gradient(low = "yellow", high = "red") + geom_line() +
      xlab("Years") + ylab("Global Oil CO2 Emission (MT)") + 
      ggtitle("Years and Global Oil Emission") + labs(col = "Oil CO2 Emission (MT)")
    plot(oil)
  })
  
#Second page scatterplot (co2 vs oil)
  output$co2_oil <- renderPlotly({
    co2_oil_plot <- ggplot(global_df, aes(x = Year, y = avg_co2)) +
      geom_point(aes(col = avg_co2)) +
      scale_color_gradient(low = "yellow", high = "red") + geom_line() +
      xlab("Global Population (Billions)") + ylab("Average CO2 Emission (MMT)") + 
      xlab("Years") + ylab("Global CO2 Emissions (MT)") + 
      ggtitle("Years and Global CO2 Emission") + labs(col = "CO2 Emission (MT)")
    plot(co2_oil_plot)
  })

#Third page (barplot)  
  output$countries_bar <- renderPlotly({
    country_barplot <- ggplot(arrangeData_df, aes(x=Country, fill = Country, y=Total)) + 
      geom_bar(stat = "identity")  +
      scale_fill_manual(values = c("red", "blue", "green", "yellow", "orange", "purple", "lightblue", "darkgreen", "white", "gold")) +
      theme(legend.position="none") +
      coord_flip() + ylab("CO2 Emissions (MT)") + xlab("Countries") + 
      ggtitle("Top 10 Countries (2021)") 
    plot(country_barplot)
})

#Third page (Table)
  output$ten_table <- renderTable({
    return(arrangeData_df)
  })
  
  
}

shinyApp(ui = ui, server = server)
