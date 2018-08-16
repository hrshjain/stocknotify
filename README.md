# README

## StockNotify
A stock market notification service

### Starting the app
~~Type `rails s` in the terminal.~~
1. Open the folder `stocknotify`.
2. Type `vagrant up` in the terminal.
3. On the browser, access http://localhost:3000/. If it does not work, access http://localhost:3000/admin/.
4. You will be taken to the log-in page. The username is Greg's SFU email `ggbaker@sfu.ca` with the password `password`.
5. From there, you can play around with our site! We recommend **updating and creating a new stock notification** to check the different functionalities - particularly e-mail and stocks.
* You need Rails 5.1.6 or lower.
* You need Ruby 2.5.1 or lower.

### Other notes about using the app
* Upon starting `vagrant up`, login credentials and notifications will be created. E-mails will pop-up in your browser.
* Whenever a stock notification is being saved, graph content is being added. "Bad jobs" are running in the background every minute. These include updating the graphs and checking if the current stock price exceeds the boundaries of the uppoer and lower limits.
* The group has worked hard to apply real dynamic data on the dashboard's yearly stock graphs. However, the hourly stock graphs contain hard-coded data. To note, graph values are first stored in a database, and operations are being performed using JavaScript to display graphs.
* Using the letter_openeger gem, e-mails will be opened in your browser window instead of your e-mail.
* SMS functionality is working completely and properly. The user won't be able to use SMS because the group is only using Twilio's trial account. With a pro account, the user will be able to receive SMSs. To clarify, they are being sent to Harsh Jain's phone.

## Project Checkpoint: _July 20, 2018_
### Accomplishments tackled to this date

* Database design for the different stocks, stock notifications, and user details
* Improvement and polishing of the user interface

## Final Implementation: _August 6, 2018_
### Accomplishments tackled to this date

* Updating the stock name and price at the creation of every notification
* Sending an e-mail and an SMS every time a notification is subscribed, unsubscribed, and exceeds the boundaries of the upper and lower limits
* Creating SMS and email content, specification for subscribed, unsubscribed, and limit exceeding situations
* Managing two databases for stock updates and stock comparisons
* Uploading charts on dashboard with current stock prices, and giving real-time stock information every minute
* Graphs are implemented using scheduled jobs. E-mail and SMS are also monitored using scheduled jobs.
* Adding a sign-up functionality and sign-up page in addition to login
* Displaying the top 10 most popular stocks and their current prices at the minute
* Improvement and polishing of the user interface: page titles, stock and user characteristics, chart layouts, etc.
* Completion of the StockNotify poster
* Development-mode configuration management using "vagrant up"

### Accomplishments that we missed

* The hourly charts are hard-coded.
* We did not have time to implement user collaboration. It was complicated because of the ActiveAdmin gem.
* Using SQLite, not PostgreSQL becuase of time pressure.

## CMPT 470 Team 4
### Members

* Harsh Jain
* Matthew Nguyen
* Angel Singh
* Josh Fernandez