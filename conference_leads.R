library(tidyverse)
library(openxlsx)

# Import:
data <- read.xlsx("AWS_leads.xlsx")

# Remove extra columns:
data %>% select(Date:NOTE) -> data

# Remove duplicates:
data %>% 
    group_by_at(vars(First.Name:COUNTRY)) %>%
    arrange(desc(NOTE)) %>%
    slice(1) -> data # 2080
    
# Remove customers:
customers <- read.xlsx("companies.xlsx")
data %>% anti_join(customers) %>% #2054
    mutate(Source = "aws reInvent 2018") -> data

# Export:
write.xlsx(data, "aws_leads_clean.xlsx")

