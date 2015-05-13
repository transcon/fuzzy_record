require 'minitest/autorun'
require 'fuzzy_string'
require 'minitest/reporters'
require 'active_record'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class FuzzyRecordTest < MiniTest::Unit::TestCase
  def setup
    dummy_table_setup(test_table: [:name,:title])
  end
  def teardown
    dummy_table_teardown(:test_table)
  end
  def test_truthy
    assert_equal true, true
  end
  
  ### helper methods
  def dummy_table_setup(*tables)
    @migration = ActiveRecord::Migration
  end

  def dummy_table_teardown(*names)
    @migration = ActiveRecord::Migration
    @migration.suppress_messages do
      names.each do |name|
        @migration.drop_table(name.to_sym)
      end
    end
  end
end
class TestTable < ActiveRecord::Base
end