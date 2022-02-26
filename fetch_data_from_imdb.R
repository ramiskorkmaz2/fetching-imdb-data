library(rvest)
library(dplyr)
library(tidyverse)

url <- "https://www.imdb.com/search/title/?groups=best_picture_winner"
webpage <- read_html(url)

###
rank_data_html <- html_nodes(webpage, ".text-primary")
rank_data <- html_text(rank_data_html)
as.numeric(rank_data)

#####
title_data_html <- html_nodes(webpage, ".lister-item-header a")
title_data <- html_text(title_data_html)
head(title_data)

####
description_data_html <- html_nodes(webpage, ".ratings-bar+ .text-muted")
description_data <- html_text(description_data_html)
head(description_data)

description_data <- gsub("\n","", description_data)
head(description_data)

######
runtime_data_html <- html_nodes(webpage, ".runtime")
runtime_data <- html_text(runtime_data_html)
head(runtime_data)
runtime_data <- gsub(" min","", runtime_data)
runtime_data <- as.numeric(runtime_data)
head(runtime_data)

####
genre_data_html <- html_nodes(webpage, ".genre")
genre_data <- html_text(genre_data_html)
head(genre_data)
genre_data <- gsub("\n","",genre_data)
genre_data <- gsub(" ", "", genre_data)
genre_data <- gsub(",.*","",genre_data)
genre_data <- as.factor(genre_data)

#####
ratings_data_html <- html_nodes(webpage, ".ratings-imdb-rating strong")
ratings_data <- html_text(ratings_data_html)
head(ratings_data)
ratings_data <- as.numeric(ratings_data)

#####
voting_data_html <- html_nodes(webpage, ".sort-num_votes-visible span:nth-child(2)")
voting_data <- html_text(voting_data_html)
head(voting_data)
voting_data <- gsub(",","", voting_data)
voting_data <- as.numeric(voting_data)

####

director_data_html <- html_nodes(webpage, ".text-muted+ p a:nth-child(1)")
director_data <- html_text(director_data_html)
head(director_data)
director_data <- as.factor(director_data)

#####

actors_data_html <- html_nodes(webpage, ".lister-item-content .ghost+ a")
actors_data <- html_text(actors_data_html)
head(actors_data)
actors_data <- as.factor(actors_data)

#########
year_data_html <- html_nodes(webpage, ".text-muted.unbold")
year_data <- html_text(year_data_html)
year_data
year_data <- gsub("[()]", "", year_data)
year_data <- as.numeric(year_data)
sum(is.na(year_data))
year_data[22] <- 2016
year_data[28] <- 2015
year_data[38] <- 2004
#######

gross_data_html <- html_nodes(webpage, ".ghost~ .text-muted+ span")
gross_data <- html_text(gross_data_html)
head(gross_data)
gross_data <- gsub("M","",gross_data)
gross_data<- substring(gross_data,2,6)
length(gross_data)

a <- gross_data[1:18]
b <- gross_data[19: length(gross_data)]
gross_data <- append(a, list("NA"))
gross_data <- append(gross_data, b )

gross_data <- as.numeric(gross_data)

summary(gross_data)

#######
movies_data <- data.frame(Rank = rank_data,
                          Title = title_data,
                          Description = description_data,
                          Runtime = runtime_data,
                          Genre = genre_data,
                          Year = year_data,
                          Gross = gross_data,
                          Ratings = ratings_data,
                          Voting = voting_data,
                          Director = director_data,
                          Actor = actors_data)

str(movies_data)

ggplot(movies_data, aes(Runtime, fill = Genre), bins = 30) +
  geom_histogram()


ggplot(movies_data, aes(Runtime, Ratings)) + 
  geom_point(aes(size = Voting, col = Genre))

ggplot(movies_data, aes(Runtime, Gross)) +
  geom_point(aes(size = Ratings, col = Genre))
