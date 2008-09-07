class Mark

  attr_reader :datestring, :colorcode, :text
  def initialize(datestring, colorcode, text)
     @datestring = datestring
     @colorcode  = colorcode
     @text       = text
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

