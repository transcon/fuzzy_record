require "fuzzy_record/version"
require "fuzzy_record/fuzzy_searcher"
require "active_record"
require "fuzzy_string"
module FuzzyRecord
  extend ActiveSupport::Concern
  module ClassMethods
    def fuzzy_search(args) FuzzySearcher.find(self,args) end
  end
end
ActiveRecord::Base.include(FuzzyRecord)

