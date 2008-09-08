$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

require 'pdf-calendar/calendar'
require 'pdf-calendar/languages'

module PDFCalendar
  VERSION = '0.0.1' unless defined?(PDFCalendar::VERSION)
end
