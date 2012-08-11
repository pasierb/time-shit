require 'test_helper'

class TestStorageCSV < Test::Unit::TestCase

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

  def test_create_file
    TimeShit::Storage::CSV.create_container
    timeshit = TimeShit::Storage::CSV.new

    assert !File.exists?( File.join( TimeShit::Config.container, timeshit.name ) )
    assert timeshit.save
    assert File.exists?( File.join( TimeShit::Config.container, timeshit.name ) )
  end

end