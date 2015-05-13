class FuzzyRecord::FuzzySearcher
  def self.find(klass,args) new(klass,args).find end
  def initialize(klass,args)
    @class  = klass
    @args   = args
    @search = create_search
  end
  def find
    @class.all.select{ |record| include_record(search,record)}.sort_by{|record| sorter(search,record)}
  end
  private
  def generalize(str) ".*#{str.gsub(/[^a-zA-Z&0-9]/, "").chars.to_a.join(".*")}.*" end
  def ave(arry) arry.sum.to_f / arry.length end
  def matches?(record,k,v) record.send(k) =~ /#{generalize(v)}/i end
  def sorter(search,record) ave(search.map{|k,v| record.send(k) ^ v}) end
  def include_record(search,record) search.map{|k,v| matches?(record,k,v)}.inject(:|) end

  def create_search
    return @args if @args.is_a? Hash
    [:fuzzy_name, :ident, :name].each do |field|
      return {field => args} if self.respond_to?(field)
    end
  end
end