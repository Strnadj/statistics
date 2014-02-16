require 'bundler/setup'
require 'minitest/autorun'
require 'statistics'
require 'minitest/unit'
require 'mocha/mini_test'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

class Rails
  def self.cache
    ActiveSupport::Cache::MemoryStore.new
  end
end

class BasicModel < ActiveRecord::Base
  define_statistic :basic_num, :count => :all
end

class MockModel < ActiveRecord::Base
  define_statistic "Basic Count", :count => :all
  define_statistic :symbol_count, :count => :all
  define_statistic "Basic Sum", :sum => :all, :column_name => 'amount'
  define_statistic "Chained Scope Count", :count => [:all, :named_scope]
  define_statistic "Default Filter", :count => :all
  define_statistic "Custom Filter", :count => :all, :filter_on => { :channel => 'channel = ?', :start_date => 'DATE(created_at) > ?', :blah => 'blah = ?' }
  define_statistic "Cached", :count => :all, :filter_on => { :channel => 'channel = ?', :blah => 'blah = ?' }, :cache_for => 1.second

  define_calculated_statistic "Total Amount" do
    defined_stats('Basic Sum') * defined_stats('Basic Count')
  end

  filter_all_stats_on(:user_id, "user_id = ?")
end
