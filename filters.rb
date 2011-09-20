require "active_support/all"

module Filters
  def self.included(base)
    base.extend ClassMethods
    # Using Class#class_attribute from ActiveSupport here to make class attributes inheritance
    # behave like instance attributes.
    # See activesupport/core_ext/class/attribute.rb for more info.
    base.class_attribute :before_filters
    base.before_filters = []
    base.class_attribute :after_filters
    base.after_filters = []
    base.class_attribute :around_filters
    base.around_filters = []
  end
  
  module ClassMethods
    def before_filter(method)
      self.before_filters += [method]
    end
    
    def after_filter(method)
      self.after_filters += [method]
    end
    
    def around_filter(method)
      self.around_filters += [method]
    end
  end
  
  def filter
    process_proc = proc do
      before_filters.each { |method| send(method) }
      yield
      after_filters.each { |method| send(method) }
    end
    
    # Wrapping each proc in a new one for each around filter.
    around_filters.reverse.each do |method|
      proc = process_proc
      process_proc = proc { send(method, &proc) }
    end
    
    # Calling top level proc to start cascading effect.
    process_proc.call
  end
end