require './long_con_test_helper.rb'
require_relative '../lib/process_csv.rb'

# test class
class TestCSV < MiniTest::Unit::TestCase

  def test_fetch_suckers_csv_gets_all_rows
    @csv = ProcessCSV.new
    @file = '../public/people20.csv'
    assert_equal 19, @csv.fetch_CSV_data(@file).count
  end

  def test_concat_names_method
    @csv = ProcessCSV.new
    @test_row = ['Mrs.', '', 'E.', 'Stamm', ""]
    expected = 'Mrs. E. Stamm'
    assert_equal expected, @csv.concat_names(@test_row)
  end

  def test_concat_phone_method
    @csv = ProcessCSV.new
    @test_row = [1,678,523,6736,""]
    expected = '16785236736'
    assert_equal expected, @csv.concat_phone(@test_row)
  end

  def test_concat_rows_makes_hash
    @csv = ProcessCSV.new
    @test_row = ["Mrs.","Theresa","E.","Stamm","",1,678,523,6736,"","Reinger","kieran@runte.biz"]
    expected = {:name=>'Mrs. Theresa E. Stamm',
                :phone => '16785236736',
                :twitter=> 'Reinger',
                :email => 'kieran@runte.biz',
                :id => 1}
    assert_equal expected, @csv.concat_row(@test_row)
  end

  def test_fetch_single_sucker
    @csv = ProcessCSV.new
    @test_file = '../public/people20.csv'
    @id = 1
    expected = {:name=>'Mrs. Theresa E. Stamm',
                :phone => '16785236736',
                :twitter=> 'Reinger',
                :email => 'kieran@runte.biz',
                :id => 1}
    assert_equal expected, @csv.fetch_single_sucker(@test_file, @id)
  end
end
