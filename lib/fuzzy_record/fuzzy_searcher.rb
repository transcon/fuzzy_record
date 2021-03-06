class FuzzyRecord::FuzzySearcher
  def self.find(klass,args) new(klass,args).find end
  def initialize(klass,args)
    @class   = klass
    @records = @class.all
    @args    = args
    @search  = create_search
  end
  def find
    @records.select{ |record| include_record(record)}.sort_by{|record| sorter(record)}
  end
  private
  def generalize(str)        ".*#{str.gsub(/[^a-zA-Z&0-9]/, "").chars.to_a.join(".*")}.*" rescue(nil) end
  def ave(arry)              arry.sum.to_f / arry.length end
  def matches?(record,k,v)   !!(record.send(k) == v || record.send(k).to_s =~ /#{generalize(v)}/i) end
  def sorter(record)         ave(@search.map{|k,v| (v.to_s ^ record.send(k).to_s rescue(0))}) end
  def include_record(record) @search.map{|k,v| matches?(record,k,v)}.inject(:&) end

  def create_search
    return @args if @args.is_a? Hash
    [:fuzzy_name, :ident, :name].each do |field|
      return {field => @args} if @class.attribute_method?(field)
    end
  end
end
