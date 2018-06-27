## grant-preprocess.R
## Andy Wills
## GPL 3.0

## This script takes raw output from the Agresso report and turns it 
## into something more readable.

## Load packages
library(tidyverse)

## Load data
apps <- read_csv("data/grant-apps-agresso.csv") 
psych.staff <- read_csv("data/psych_staff.csv")

## Select relevant columns (and give useful names)
apps <- apps %>% select( c("Work order","Project Team - Name (T)",
                           "Project Team - Project Role",
                           "Project Team - Department", "Sponsor (T)",
                           "App Value", "Award Value", "App Date",
                           "Award Date", "Project status",
                           "Description"))

colnames(apps) <- c("WO","staff","role","depcode","sponsor",
                     "app.value", "award.value", "app.date",
                     "award.date", "status", "title")

## Convert money to numbers
moneyToDouble <- function(s){
  as.double(gsub("[.]", ".", gsub("[,]", "", s)))
}
apps$app.value <- moneyToDouble(apps$app.value)
apps$award.value <- moneyToDouble(apps$award.value)

## Ensure correct representation of dates
apps$app.date <- as.Date(apps$app.date,format="%d/%m/%Y")
apps$award.date <- as.Date(apps$award.date,format="%d/%m/%Y")

## Represent outcome of application simply

## Successful outcomes
## AWDNTSTART - Awarded, but not yet started
## PROGRESS   - Awarded, currently running
## COMPLETE   - Awarded, finished

## Unknown outcomes
## APPSUB   - Submitted, awaiting decision
## CONTNEG - "Continuing negotiations"

## Unsuccessful outcomes
## APPDEC   - Application declined

apps$success <- "awaiting outcome"

apps$success[apps$status %in% c("AWDNTSTART", "PROGRESS",
                                   "COMPLETE")] <- "awarded"

apps$success[apps$status == "APPDEC"] <- "declined"

## Order by work order
apps <- apps %>% arrange(WO)

## Subset to research grants ('TT' is 'other services rendered, which
## is mainly Plymouth Enterprise, but can also be research carried out
## for a commerical partner. Leigh Hannam's view is that such projects
## should not be classed as research).
apps <- apps[substring(apps$WO,1,2) == "RR",]

## Get just psychology staff apps and awards
apps <- apps[apps$staff %in% psych.staff$agname,]

## This will fail where no staff name was recorded -- drop those entries
apps <- apps[!is.na(apps$staff),]

## There are some duplicate entries for the same person and grant  - remove
dups <- c("RR103669-102", "RR106215-102", "RR106215-103",
          "RR106215-104")
apps <- apps[!(apps$WO %in% dups),]

## Order by name, then CI/PI, then app date
apps <- apps %>% arrange(staff, role, app.date)

## Cut out 'depcode' - superfluous
apps <- apps %>% select(-depcode)

## Save out cleaned-up data set
write.csv(apps, file="data/grant-apps.csv", row.names = FALSE)

