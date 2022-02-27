# Fetching IMDB Data

![fetching-imdb-data](https://user-images.githubusercontent.com/70109399/155847719-b69f5680-cb50-4110-8c5b-31a39f2e404e.jpeg)

## Libraries

* rvest
* dplyr
* tidyverse

It is an end-to-end project. The main goal is  to practise on the web scraping using ´rvest´ package.
The ´Best Picture Winning´ category from the [IMDB](https://www.imdb.com/search/title/?groups=best_picture_winner&view=advanced) is the main source. The dataset includes 50 movies from different years. To make web scraping, the open source software [Selector Gadget](https://selectorgadget.com) extension is used.

First, we get the url from the from the website. Then, made it available using read_html function. The following data is scrapped from the website :
* **Rank** : The rank of the film from 1 to 50 sorted by popularity ascending
* **Title** : The title of the film
* **Description** : The description of the film
* **Runtime** : The duration of the film
* **Genre** : The genre of the film
* **Ratings** : The IMDB rating of the film.
* **Voting** : Votes cast in favor of the film
* **Director** : The main director of the film. If there is more than one, i select the first one.
* **Actor** :  The main artist of the film. If there is more than one, i select the first one.
* **Year** : The publishing year of the film.
* **Gross** : The gross earnings of the film in millions.

After different categories for each film is scrapped, i integrated them by data.frame function as called ´movies_data´. At the end, we have a histogram and 2 scatter plots for different categories.


The data structure is based on the [website](https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/)
