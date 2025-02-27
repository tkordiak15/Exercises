 # Tayler Kordiak, 02/18/2025, Exercise 7 for week 5 
{r, message=FALSE, warning=FALSE}
library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv'
covid = read_csv(url)
head(covid, 5)
data <- read.csv ("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv")
data <- read.csv ()
read(covid)
latest_data <- max(covid$date)
top_states <- covid %>% filter(date == latest_data) %>% group_by(state) %>% summarise(total_cases = sum(cases, na.rm = TRUE)) %>% arrange(desc(total_cases)) %>% slice_max(total_cases, n=6) %>% pull(state)
covid_top6 <- covid %>% filter(state %in% top_states) %>% group_by(state, date) %>% summarise(total_cases = sum(cases, na.rm = TRUE))
ggplot(data = covid_top6, aes(x = date, y = total_cases, group = state, colour = state)) + 
  geom_line(linewidth = 1) + 
  coord_cartesian(ylim = c(2500000, 12500000)) +
  labs(title = "COVID-19 Cases Over Time in the 6 Most Affected State in the United States", 
       x = "Date", y = "Number of Cases",
       caption = "Source: NY Times COVID-19 Data") +
  theme_minimal() +
  theme(legend.position = "none") 
daily_cases <- covid %>% group_by(date) %>% summarize(total_cases = sum(cases, na.rm = TRUE))
usa_plot <- ggplot(daily_cases, aes (x = date, y = total_cases)) + 
  geom_col(fill = "steelblue") + 
  labs(title = "Daily Total COVID-19 Cases in the United States", x = "Date", y = "Number of Cases", 
       caption = "Source: NY Times COVID-19 Data") +
  coord_cartesian(ylim =c(100000000, 104000000)) +
  theme_light()
