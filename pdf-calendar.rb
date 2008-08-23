# Copyright (c) 2008 Matthias Luedtke
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.


require 'lib/liquid'

require 'tempfile'
require 'date'
require 'optparse'
require 'pp'
require 'ostruct'
require 'csv'

PDF_CALENDAR_VERSION = '0.1'

class Mark

  attr_reader :datestring, :text, :colorcode
  def initialize(datestring, text, colorcode)
     @datestring = datestring
     @text       = text
     @colorcode  = colorcode
  end

  def check_datestring
    @datestring =~ /\d{4}-\d{2}-\d{2}/
  end

  def check_colorcode
    @colorcode =~ /#([0-9A-Fa-e]){6}/
  end

  def check
    raise "Wrong datestring: #{@datestring}" unless check_datestring
    raise "Wrong colorcode: #{@colorcode}" unless check_colorcode
  end 

  def to_liquid
    %w( datestring text colorcode)
  end 

  def Mark.create_marks_from_csv(filename)
     lines = CSV.parse(IO.read(filename), ';')
     pp lines
     marks = lines.map{ |line| pp line; Mark.new(line[0],line[1],line[2]) }
     puts marks.length
     pp marks
     hashed_marks = {}
     marks.each{ |m| hashed_marks[m.datestring] = m }
	pp hashed_marks
     hashed_marks
     
  end
end

class Optparse
    # Return a structure describing the options.
    #
    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.year = Time.now.year
      options.pdf  = "calendar.pdf"
      options.fop_path = "fop"
      options.paper = "din-a4"

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: pdf_calendar.rb [options]"

        opts.separator ""
        opts.separator "Specific options:"

        opts.on("--pdf FILENAME", "Write calendar to FILENAME") do |fn|
          options.pdf = fn
        end

        opts.on("--title STR", "Set calendar title to STR") do |str|
          options.title = str
        end

        paper_formats = ['din-a4', 'letter']
        opts.on("--paper FORMAT", paper_formats, "Select paper format",
                "  (#{paper_formats.join(',')})") do |f|
          options.paper = f
        end

        opts.on("--fop PATH", "Path to 'fop' executable") do |path|
          options.fop_path = path
        end

        # Cast 'year' argument to Int.
        opts.on("--year N", Integer, "Create calendar for year N") do |n|
          options.year = n
        end

        opts.on("--marks FILENAME", "Create calendar for year N") do |f|
          options.marks = Mark.create_marks_from_csv(f)
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("-v", "--version", "Show version") do
          puts "Ruby PDF Calendar #{PDF_CALENDAR_VERSION}"
          exit
        end
      end

      opts.parse!(args)
      options
  end  # parse()
end  # class Optparse

class Calendar 

  attr_reader :month
  attr_reader :table

  # month is a Time, only year and month are considered, though
  def initialize(month)
    @table = init_table
    @month = month

    calc_table
  end

  def to_s
    str = ""
    
    @table.each_index { |i|
      r = @table[i]
      r.each_index { |j|
        str << "#{@table[i][j]} " #unless @table[i][j] == 0
      }
      str << "\n"
    }
    str
  end
  
  def each_week
    @table.each_index{ |i|
      yield(@table[i])
    }    
  end
  
  
  def get_day(week,day)
    raise 'Week not in range 1..6.' unless (1..6) === week
    raise 'Day not in range 1..7.' unless (1..7) === day
    @table[week-1][day-1]
  end

  def self.next_month(month)
    secs_per_day = 86400 
    month + secs_per_day * 35
  end
 
  def self.previous_month(month)
    secs_per_day = 86400 
    month - secs_per_day * 20
  end
   
  private
  
  def init_table
   days = Array.new(6)
    
    # Create 2 dimensional array
    days.each_index { |i|
    r = Array.new(7)
    r.each_index { |j|
        r[j] = nil
    }
    days[i] = r
    }
    
    days
  end
  
  def calc_table
    date = Date.new(@month.year, @month.month, 1)

    # Set day offset so that we get the sequence Monday ... Sunday
    day_offset = (date.wday + 5)%7

    # Calculate last day in month
    last_day_in_month = ((date >> 1) - 1).day

    1.upto(last_day_in_month){ |d|
      @table[(d+day_offset)/7][(d+day_offset)%7] = d
    }
  end

end # of Calendar


options = Optparse.parse(ARGV)
pp options

cal_title = options.title
month_names   = [nil] + %w(Januar Februar März April Mai Juni Juli August September Oktober November Dezember)
month_names   = [nil] + %w(January February March April May June July August September October November December)
weekday_names = %w(So Mo Di Mi Do Fr Sa)
weekday_names = %w(Sun Mon Tue Wed Thu Fri Sat)
year = options.year

cal = (1..12).to_a.map{ |month| Calendar.new(Time.mktime(year, month)) }.map{ |calendar| calendar.table} 

caltemplate = Liquid::Template.parse(File.read('caltemplate.xslfo.xml'))
fo_stylesheet = caltemplate.render( 'cal_title' => cal_title || year, 'weekdays' => weekday_names, 'month_names' => month_names, 'month' => cal[7], 'cal' => cal, 'paper' => options.paper, 'marks' => options.marks ) 

f = Tempfile.new('calendar.fo')
f.write(fo_stylesheet)
f.close

puts f.path

puts fo_stylesheet

`#{options.fop_path} #{f.path} #{options.pdf}`

