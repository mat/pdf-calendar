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

		ruby bin/pdf-calendar.rb --year 2008
		ruby bin/pdf-calendar.rb --year 2008 --title "Fancy Calendar"
		ruby bin/pdf-calendar.rb --year 2008 --pdf fancycal.pdf
		ruby bin/pdf-calendar.rb --year 2008 --paper letter
		ruby bin/pdf-calendar.rb --year 2008 --lang de
		ruby bin/pdf-calendar.rb --year 2008 --weekstart sunday
		ruby bin/pdf-calendar.rb --help

Leaving out `--year` creates a calendar for the current year.

### Major Contributors
* Matthias Luedtke - Maintainer
