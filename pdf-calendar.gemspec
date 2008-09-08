Gem::Specification.new do |s|
  s.files = ["LICENSE",
 "README.markdown",
 "Rakefile",
 "lib/pdf-calendar",
 "lib/pdf-calendar/mark.rb",
 "lib/pdf-calendar/calendar.rb",
 "lib/pdf-calendar/languages.rb",
 "lib/pdf-calendar.rb",
 "bin/pdf-calendar",
 "test/calendar_test.rb",
 "test/languages_test.rb",
 "test/utils.rb",
 "templates/default.xslfo.xml",
 "examples/2008-german-holidays.csv",
 "examples/example-calendar-2008.png",
 "examples/example-calendar-2008.pdf"]
  s.rubygems_version = "1.2.0"
  s.homepage = "http://github.com/mat/pdf-calendar"
  s.loaded = "false"
  s.summary = "PDF calendars. For a whole year. Using Ruby and Apache FOP."
  s.bindir = "bin"
  s.description = "PDF calendars. For a whole year. Using Ruby and Apache FOP."
  s.platform = "ruby"
  s.date = "Mon Sep 08 00:00:00 +0200 2008"
  s.authors = ["Matthias L\303\274dtke"]
  s.name = "pdf-calendar"
  s.required_rubygems_version = ">= 0"
  s.has_rdoc = "false"
  s.require_paths = ["lib"]
  s.specification_version = "2"
  s.version = "0.1.0"
  s.executables = ["pdf-calendar"]
  s.email = "email at matthias-luedtke dot de"
  s.required_ruby_version = ">= 0"
end