# workR
R scripts to support workload modelling

## Research 

[goodpapers.R](goodpapers.R) - Calculates number of good recent papers published by each staff member, from _Symplectic Elements_ data.

## Updating the data
Data for these scripts largely has to be pulled manually from various other databases. Here's how:

### Publication data
You need a _research admin_ account on Symplectic Elements to do this. If you don't have such an account, you can still use the last version of the data someone uploaded - just skip to the next section.

1. Go to [Sympletic Elements][1] and log in.

2. Go to Research Admin -> Basic Reports.

3. Go to "Select Groups". Click "+" next to "Faculty of Health and Human Sciences". Tick box by "School of Psychology".

4. Set "Date from:" - **Pick 1st Jan 2014**. 

5. Set "Date to" - **Pick today's date**.

6. Under section 4.i., set _Element_ to "Publication", set _Type_ to "All"", set _Return_ to "Simple rows". Click "Display all fields".

7. Click "Get report". Wait a bit.

8. Save the CSV file you get into the _data_ folder with the name _symplectic-report.csv_. It's important you use this **exact name**.


[1]: https://elements.plymouth.ac.uk/login.html


