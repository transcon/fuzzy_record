require "fuzzy_record/version"

module FuzzyRecord
  module ClassMethods
    def fuzzy_search(args)
      if args.is_a? Hash
        search = args.map{|k,v| {k => generalize(v)}}.inject(:merge)
      else
        [:fuzzy_name, :ident, :name].each do |field|
          search = {field => args}
          break if self.respond_to?(field)
        end
      self.select{ |record| search.map{|k,v| record.send(k) =~ v}.inject(:|)}
    end
    private
    def generalize(str)
      return /.*#{str.gsub(/[^a-zA-Z&0-9]/, "").chars.to_a.join(".*")}.*/i
    end
  end
end
ActiveRecord::Base.include(FuzzyRecord)

