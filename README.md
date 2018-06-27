# workR
R scripts to support workload modelling

## Research 

[goodpapers.R](goodpapers.R) - Calculates number of good recent papers published by each staff member, from _Symplectic Elements_ data.

[grant-preprocess.R](grant-preprocess.R) - Takes an Agresso report on grant applications, processes it into a more useful form, and saves out as _grant-apps.csv_. This output is sufficiently human-readable to be used directly for PDR discussions. It could also be processed further by other R scripts.

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

### Grant data
I think any member of staff can do this.

1. Go to [Agresso][2] and log in.

2. Select 'Reports' menu.

3. Select 'Research'

4. Select _Listed Research project CI's per school_

5.  Click 'export'

6. Select report 'Predefined -> Browser [.xlsx]'

7. Open, and re-save as 'grant-apps-agresso.csv' into the data folder of your RStudio project. 
It's important you use this **exact name**.

[1]: https://elements.plymouth.ac.uk/login.html
[2]: https://agresso.plymouth.ac.uk/agresso/

### List of staff

Some of the above files contain information about staff from other Schools. 
The file _psych_staff.csv_, lists the people currently in the School of Psychology, 
which allows us to filter these other files down to a Psychology-only version. 
It is updated manually on this github repository. 

