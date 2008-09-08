require 'utils'
require '../src/calendar'

class LayoutTest < Test::Unit::TestCase
  def setup
    @august_2008 = Calendar::Layout.new(Time.mktime(2008,8))
    @september_2008 = Calendar::Layout.new(Time.mktime(2008,9))
    @september_2008_sunday_start = Calendar::Layout.new(Time.mktime(2008,9), :weekstart => :sunday)
  end

  def test_layout_for_august_2008_first_row
    (1..4).each do |i|
      assert_equal nil, @august_2008[1,i]
    end
    assert_equal 1, @august_2008[1,5]
    assert_equal 2, @august_2008[1,6]
    assert_equal 3, @august_2008[1,7]
  end
 
  def test_layout_for_august_2008_last_row
    assert_equal 25, @august_2008[5,1]
    assert_equal 31, @august_2008[5,7]
  end

  def test_layout_for_september_2008_should_have_no_empty_first_week
    (1..7).each do |i|
      assert_not_nil @september_2008[1,i]
    end
  end

  def test_layout_for_september_2008_should_have_empty_last_week
    (1..7).each do |i|
      assert_nil @september_2008[6,i]
    end
  end

  def test_layout_for_september_2008_sunday_start_first_week
    assert_nil @september_2008_sunday_start[1,1]
    assert_equal 1, @september_2008_sunday_start[1,2]
    assert_equal 2, @september_2008_sunday_start[1,3]
    assert_equal 3, @september_2008_sunday_start[1,4]
    assert_equal 4, @september_2008_sunday_start[1,5]
    assert_equal 5, @september_2008_sunday_start[1,6]
    assert_equal 6, @september_2008_sunday_start[1,7]
  end

  def test_layout_for_september_2008_sunday_start_last_week
    assert_equal 28, @september_2008_sunday_start[5,1]
    assert_equal 29, @september_2008_sunday_start[5,2]
    assert_equal 30, @september_2008_sunday_start[5,3]
    assert_nil       @september_2008_sunday_start[5,4]
    assert_nil       @september_2008_sunday_start[5,5]
    assert_nil       @september_2008_sunday_start[5,6]
    assert_nil       @september_2008_sunday_start[5,7]
  end

#  def test_logger_should_use_STDERR_by_default
#    logger = Capistrano::Logger.new
#    assert_equal STDERR, logger.device
#  end
 
#  def test_logger_should_use_output_option_if_output_responds_to_puts
#    logger = Capistrano::Logger.new(:output => STDOUT)
#    assert_equal STDOUT, logger.device
#  end
 
#  def test_logger_should_open_file_if_output_does_not_respond_to_puts
#    File.expects(:open).with("logs/capistrano.log", "a").returns(:mock)
#    logger = Capistrano::Logger.new(:output => "logs/capistrano.log")
#    assert_equal :mock, logger.device
#  end
 
#  def test_close_should_not_close_device_if_device_is_default
#    logger = Capistrano::Logger.new
#    logger.device.expects(:close).never
#    logger.close
#   end
end
