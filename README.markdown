## pdf-calendar
A Ruby script that generates PDF calendars using Apache FOP.

Showcase at <http://github.com/mat/pdf-calendar/wikis>
### Features

Supports

* multiple languages for weekdays and months
* DIN A4 and letter format

### Requirements
* Ruby, Apache FOP installation

### Quick Install
1. Install Apache FOP: <http://xmlgraphics.apache.org/fop/0.95/running.html>
2. Make sure that `fop` is in your PATH.


### How to Use
Start creating calendars. 

		ruby pdf-calendar.rb --year 2008
		ruby pdf-calendar.rb --year 2008 --title "mat's fancy calendar"
		ruby pdf-calendar.rb --year 2008 --pdf fancycal.pdf
		ruby pdf-calendar.rb --year 2008 --paper letter
		ruby pdf-calendar.rb --year 2008 --lang de
		ruby pdf-calendar.rb --help

Leaving out `--year` creates a calendar for the current year.

### Major Contributors
* Matthias Luedtke - Maintainer
