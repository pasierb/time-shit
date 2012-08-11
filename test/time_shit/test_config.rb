require 'test_helper'

class TestConfig < Test::Unit::TestCase

  def test_default_config
    assert_equal File.join( Dir.home, "time-shit" ), TimeShit::Config.container 
  end

end