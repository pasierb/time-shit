require 'test_helper'

class TestCLI < Test::Unit::TestCase

  def setup
    @build = TimeShit::CLI.new
  end

  def test_start_if_no_args_passed
    assert_not_nil @build.options[:start]
  end

  def test_no_end_if_no_args_passed
    assert_nil @build.options[:end]
  end

  def test_end_option
    @build = TimeShit::CLI.new( ["-e"] )
    assert_not_nil @build.options[:end]
  end

end