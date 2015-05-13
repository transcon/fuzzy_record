require "fuzzy_record/version"

module FuzzyRecord
  extend ActiveSupport::Concern
  module ClassMethods
    def fuzzy_search(args)
      if args.is_a? Hash
        search = args
      else
        [:fuzzy_name, :ident, :name].each do |field|
          search = {field => args}
          break if self.respond_to?(field)
        end
      end
      self.select{ |record| search.map{|k,v| matches?(k,v)}.sort_by{|record| sorter(k,v)}
    end
    private
    def generalize(str)
      return ".*#{str.gsub(/[^a-zA-Z&0-9]/, "").chars.to_a.join(".*")}.*"
    end
    def ave(arry)
      arry.sum.to_f / arry.length
    end
    def matches?(k,v)
      record.send(k) =~ /#{generalize(v)}/i}.inject(:|)
    end
    def sorter(k,v)
      ave(search.map{|k,v| record.send(k) ^ v})
    end
  end
end
ActiveRecord::Base.include(FuzzyRecord)

