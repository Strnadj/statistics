require 'test_helper'

class StatisticsTest < Minitest::Test

  def test_basic
    BasicModel.expects(:basic_num_stat).returns(1)
    assert_equal({ :basic_num => 1 }, BasicModel.statistics)
  end

  def test_statistics
    MockModel.expects(:basic_count_stat).returns(2)
    MockModel.expects(:symbol_count_stat).returns(2)
    MockModel.expects(:basic_sum_stat).returns(27)
    MockModel.expects(:chained_scope_count_stat).returns(4)
    MockModel.expects(:default_filter_stat).returns(5)
    MockModel.expects(:custom_filter_stat).returns(3)
    MockModel.expects(:cached_stat).returns(9)
    MockModel.expects(:total_amount_stat).returns(54)

    ["Basic Count",
    :symbol_count,
    "Basic Sum",
    "Chained Scope Count",
    "Default Filter",
    "Custom Filter",
    "Cached",
    "Total Amount"].each do |key|
      assert MockModel.statistics_keys.include?(key)
    end

    assert_equal({ "Basic Count" => 2,
                   :symbol_count => 2,
                   "Basic Sum" => 27,
                   "Chained Scope Count" => 4,
                   "Default Filter" => 5,
                   "Custom Filter" => 3,
                   "Cached" => 9,
                   "Total Amount" => 54 }, MockModel.statistics)
  end

  def test_get_stat
    MockModel.expects(:calculate).with(:count, :id, {}).returns(3)
    assert_equal 3, MockModel.get_stat("Basic Count")    

    MockModel.expects(:calculate).with(:count, :id, { :conditions => "user_id = '54321'"}).returns(4)
    assert_equal 4, MockModel.get_stat("Basic Count", :user_id => 54321)
  end
  
  def test_basic_stat
    MockModel.expects(:calculate).with(:count, :id, {}).returns(3)
    assert_equal 3, MockModel.basic_count_stat({})

    MockModel.expects(:calculate).with(:sum, 'amount', {}).returns(31)
    assert_equal 31, MockModel.basic_sum_stat({})
  end
  
  def test_chained_scope_stat
    MockModel.expects(:all).returns(MockModel)
    MockModel.expects(:named_scope).returns(MockModel)
    MockModel.expects(:calculate).with(:count, :id, {}).returns(5)
    assert_equal 5, MockModel.chained_scope_count_stat({})
  end

  def test_calculated_stat
    MockModel.expects(:basic_count_stat).returns(3)
    MockModel.expects(:basic_sum_stat).returns(33)

    assert_equal 99, MockModel.total_amount_stat({})

    MockModel.expects(:basic_count_stat).with(:user_id => 5).returns(2)
    MockModel.expects(:basic_sum_stat).with(:user_id => 5).returns(25)

    assert_equal 50, MockModel.total_amount_stat({:user_id => 5})

    MockModel.expects(:basic_count_stat).with(:user_id => 6).returns(3)
    MockModel.expects(:basic_sum_stat).with(:user_id => 6).returns(60)

    assert_equal 180, MockModel.total_amount_stat({:user_id => 6})
  end

  def test_default_filter_stat
    MockModel.expects(:calculate).with(:count, :id, {}).returns(8)
    assert_equal 8, MockModel.default_filter_stat({})

    MockModel.expects(:calculate).with(:count, :id, { :conditions => "user_id = '12345'" }).returns(2)
    assert_equal 2, MockModel.default_filter_stat( :user_id => '12345' )
  end
  
  def test_custom_filter_stat
    MockModel.expects(:calculate).with(:count, :id, {}).returns(6)
    assert_equal 6, MockModel.custom_filter_stat({})
    
    MockModel.expects(:calculate).with() do |param1, param2, param3|
        param1 == :count &&
        param2 == :id &&
        (param3 ==  { :conditions => "channel = 'chan5' AND DATE(created_at) > '#{Date.today.to_s(:db)}'" } ||
        param3 == { :conditions => "DATE(created_at) > '#{Date.today.to_s(:db)}' AND channel = 'chan5'" } )
    end.returns(3)
    assert_equal 3, MockModel.custom_filter_stat(:channel => 'chan5', :start_date => Date.today.to_s(:db))
  end

  def test_cached_stat
    MockModel.expects(:calculate).returns(6)
    assert_equal 6, MockModel.cached_stat({:channel => 'chan5'})

    MockModel.stubs(:calculate).returns(8)
    assert_equal 6, MockModel.cached_stat({:channel => 'chan5'})
    assert_equal 8, MockModel.cached_stat({})

    sleep(1)
    assert_equal 8, MockModel.cached_stat({:channel => 'chan5'})       
  end
  
end
