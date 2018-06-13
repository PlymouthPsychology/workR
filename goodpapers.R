## goodpapers.R
## Andy Wills
## GPL 3.0

## This script returns the number of good, recent, papers produced by each staff member
## capped to a given maximum

## Specify parameters
## I've picked ones here that make sense from a REF perspective 
## i.e. we should give time to the people who are writing our best REF papers
## but they can't return more than 5, however many they write.

from.year <- 2014 ## The earliest year of publication that counts
quart.point <- 3  ## The quartile on SNIP that counts as 'good' 2 = LQ, 3 = median, 4 = UQ.
n.cap <- 5 ## Maximum number of papers (ie. if >ncap then =ncap)

## Load packages
library(tidyverse)

## Load data
pubs <- read_csv("data/symplectic-report.csv") 

## Preprocess data

### Select and rename columns we need

needed <- c('ID', 'Username', 'Authors OR Creators', 
            'Publication date OR Date OR Presentation date OR Date awarded OR Presented date',
            'Title', 'Journal OR Published proceedings', 'Volume',
            'Pagination (start page)', 'Times cited (Scopus)',
            'SNIP rank', 'Status', 'Publication type')

gpubs <- pubs %>% select(needed)  

colnames(gpubs) <-  c('ID', 'Username', 'authors', 'year', 'title','journal',
                     'vol','page','cites','SNIP', 'status', 'pubtype')

### Kludge to fix kludgy year info from symplectic

gpubs$year <- as.numeric(substr(gpubs$year,1,4))  

### Filter to published journal articles
gpubs <- gpubs %>% 
  filter(status %in% c('Published', 'Published online')) %>% 
  filter(pubtype == "Journal article")

### Remove status and pubtype, as now superfluous
gpubs <- gpubs %>% select(-status, -pubtype)

## Filter to recent publications
gpubs <- gpubs %>% filter(year >= from.year)

## Define quartile
quartiles <- quantile(gpubs$SNIP, na.rm = TRUE)
qlevel <- quartiles[quart.point]

## Filter to papers above the lower quartile
gpubs <- gpubs %>% filter(SNIP > qlevel)

## Summarise by username
gpubsum <- gpubs %>% group_by(Username) %>% summarise(N = n())

##Cap
gpubsum <- gpubsum %>% mutate(Ncapped = pmin(n.cap, N))



