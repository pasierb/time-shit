require 'test_helper'

class TestStorageCSVFileSystem < Test::Unit::TestCase

  def setup
    @folder = File.expand_path( File.join( __FILE__, "../../../tmp/time-shit"  ) )
    TimeShit::Config.stubs( :container ).returns( @folder )
  end

  def teardown
    if Dir.exists?( @folder )
      FileUtils.rm_rf("#{@folder}/.", secure: true)
      Dir.delete( @folder ) 
    end
  end

  def test_create_csv_directory
    assert !Dir.exists?( TimeShit::Config.container ), "CSV test directory (#{TimeShit::Config.container}) already exists"
    TimeShit::Storage::CSV.create_container
    assert Dir.exists?( TimeShit::Config.container ), "CSV test directory (#{TimeShit::Config.container}) not created"
  end

end

class TestStorageCSV < Test::Unit::TestCase

  def setup
    @folder = File.expand_path( File.join( __FILE__, "../../../tmp/time-shit"  ) )
    TimeShit::Config.stubs( :container ).returns( @folder )
    TimeShit::Storage::CSV.create_container

    Dir["test/time_shit/fixtures/*.csv"].each{|f| FileUtils.cp( f, 'tmp/time-shit' ) }  

    @date = Time.parse("2012-08-09")
    @timeshit = TimeShit::Storage::CSV.new( @date )
    @entry_1 = "2012-08-09"
  end

  def teardown
    if Dir.exists?( @folder )
      FileUtils.rm_rf("#{@folder}/.", secure: true)
      Dir.delete( @folder ) 
    end
  end

  def test_create_file
    date = Time.parse("2012-09-09")
    timeshit = TimeShit::Storage::CSV.new( date )
    
    assert !File.exists?( File.join( TimeShit::Config.container, timeshit.name ) )
    assert timeshit.save
    assert File.exists?( File.join( TimeShit::Config.container, timeshit.name ) )
  end

  def test_create_header
    date = Time.parse("2012-09-09")
    timeshit = TimeShit::Storage::CSV.new( date )

    assert timeshit.create_timesheet
    assert_equal %w(Date Start End), timeshit.sheet[0]
  end

  def test_missing_header_on_save
    date = Time.parse("2012-09-09")
    timeshit = TimeShit::Storage::CSV.new( date )

    assert timeshit.save
    assert_equal %w(Date Start End), timeshit.sheet[0]
  end

  def test_set_new_day_start
    key = "2012-08-13"
    @timeshit.set( key, :start => "09:00" )
    assert_equal "09:00", @timeshit.get( key ).start
  end

  def test_set_end
    key = "2012-08-12"
    assert_equal "10:00", @timeshit.get( key ).start, @timeshit.sheet.to_s
    @timeshit.set( key, :end => "19:00" )
    assert_equal "10:00", @timeshit.get( key ).start, @timeshit.sheet.to_s
    assert_equal "19:00", @timeshit.get( key ).end
  end

  def test_read_given_date
    entry = @timeshit.get( @entry_1 )
    assert_equal "08:00", entry.start
    assert_equal "16:00", entry.end 
  end

  def test_sheet
    assert_equal %w(Date Start End), @timeshit.sheet[0]
  end

end