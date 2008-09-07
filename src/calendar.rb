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

