require 'date'

module Calendar

class Layout

  attr_reader :month
  attr_reader :table

  # month is a Time, only year and month are considered, though
  def initialize(month)
    @month = month

    @table = fill_table_with_calendar(Array.new(6){Array.new(7)})
    tidy_table
  end

  def to_s
    str = ""
    
    each_week{ |week|
      str << week.map{ |day| sprintf("%2d", day)}.join(' ')
      str << "\n"
    }
    str.gsub(' 0', '  ')
  end
  
  def each_week
    @table.each{ |week| yield(week) }
  end
  
  def [](week,day)
    raise 'Week not in range 1..6.' unless (1..6) === week
    raise 'Day not in range 1..7.' unless (1..7) === day
    @table[week-1][day-1]
  end
  alias :get_day []

  private
  
  def fill_table_with_calendar(table)
    date = Date.new(@month.year, @month.month, 1)

    # Set day offset so that we get the sequence Monday...Sunday
    day_offset = (date.wday + 5)%7

    last_day_in_month = ((date >> 1) - 1).day

    1.upto(last_day_in_month){ |d|
      table[(d+day_offset)/7][(d+day_offset)%7] = d
    }
    table
  end
  
  def tidy_table
    if first_week_completely_blank?
      move_whole_calendar_one_week_up
      blank_last_week
    end
  end

  def first_week_completely_blank?
    @table[0].all? { |d| d.nil? }
  end

  def move_whole_calendar_one_week_up
    1.upto(5){ |week|
      0.upto(6) { |day|
        @table[week-1][day] = @table[week][day]
      }
    }
  end

  def blank_last_week
    0.upto(6) { |day| @table[5][day] = nil }
  end

  end # of Layout

end # of Calendar

