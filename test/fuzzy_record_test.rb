require "test_helper"
class FuzzyRecordTest < TestCase
  def test_search_responds_to_name
    FlyingTable.create(test_tables: {name: :string, title: :string})
    first  = TestTable.create(name: 'A very long string')
    second = TestTable.create(name: 'A very longer string')
    search = TestTable.fuzzy_search('a very long')
    assert_equal 2, search.count
    assert_equal first, search.first
    FlyingTable.destroy(:test_tables)
  end

  def test_search_responds_to_ident
    FlyingTable.create(ident_test_tables: {ident: :string, name: :string, title: :string})
    first  = IdentTestTable.create(name: 'A very long string',   ident: 'a longer string')
    second = IdentTestTable.create(name: 'A very longer string', ident: 'a long string')
    search = IdentTestTable.fuzzy_search('a long string')
    assert_equal 2, search.count
    assert_equal second, search.first
    FlyingTable.destroy(:ident_test_tables)
  end

  def test_search_responds_to_fuzzy_name
    FlyingTable.create(fuzzy_test_tables: {fuzzy_name: :string, ident: :string, name: :string,title: :string})
    first  = FuzzyTestTable.create(ident: 'a longer string', fuzzy_name: 'a string')
    second = FuzzyTestTable.create(ident: 'a long string',   fuzzy_name: 'a stringer')
    search = FuzzyTestTable.fuzzy_search('a string')
    assert_equal 2, search.count
    assert_equal first, search.first
    FlyingTable.destroy(:fuzzy_test_tables)
  end

  def test_search_responds_to_any_name
    FlyingTable.create(any_name_test_tables: {fuzzy_name: :string, ident: :string, name: :string,title: :string})
    first  = AnyNameTestTable.create(ident: 'a longer string', title: 'a string')
    second = AnyNameTestTable.create(ident: 'a long string',   title: 'a stringer')
    search = AnyNameTestTable.fuzzy_search(title: 'a string')
    assert_equal 2, search.count
    assert_equal first, search.first
    FlyingTable.destroy(:any_name_test_tables)
  end

  def test_search_responds_to_multiple_name
    FlyingTable.create(multiple_name_test_tables: {fuzzy_name: :string, ident: :string, name: :string,title: :string})
    first  = MultipleNameTestTable.create(ident: 'a long string',   title: 'a string')
    second = MultipleNameTestTable.create(ident: 'a longer string', title: 'a stringer')
    search = MultipleNameTestTable.fuzzy_search(title: 'a string', ident: 'a longer string')
    assert_equal 1, search.count
    assert_equal second, search.first
    FlyingTable.destroy(:multiple_name_test_tables)
  end
end
