require "connection_adapter"

module ActiveRecord
  class Base < Object
    @@connection = SqliteAdapter.new

    def initialize(attributes)
      @attributes = attributes
    end
    
    def method_missing(name, *args)
      columns = @@connection.columns(self.class.table_name)
      
      if columns.include?(name)
        @attributes[name]
      else
        super
      end
    end

    def id
      @attributes[:id]
    end

    def self.find(id)
      attributes = @@connection.find(id, table_name)
      new(attributes)
    end

    def self.all
      @@connection.find_all(table_name).map do |attributes|
        new(attributes)
      end
      # Whitout `map`
      # array = []
      # @@connection.find_all(table_name).each do |attributes|
      #   array << new(attributes)
      # end
      # array
    end
    
    def self.table_name
      name.downcase + "s"
    end
  end
end