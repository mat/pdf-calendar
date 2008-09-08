require 'utils'
require '../lib/calendar'
require '../lib/languages'

class LanguagesTest < Test::Unit::TestCase
  def setup
    @weekdays_en_w_start_on_sunday = Calendar::Languages.weekdays('en', :sunday)
  end

  def test_weekdays_with_start_on_sunday
    assert_equal %w(Sun Mon Tue Wed Thu Fri Sat), @weekdays_en_w_start_on_sunday
  end

end
