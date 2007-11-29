module Hobo
  
  module Dryml
    
    class NoParameterError < RuntimeError; end
    
    class TagParameters < Hash
      
      def initialize(parameters, exclude_names=nil)
        if exclude_names.blank?
          update(parameters)
        else
          parameters.each_pair { |k, v| self[k] = v unless k.in?(exclude_names) }
        end
      end
      
      def method_missing(name, default_content="")
        if name =~ /\?$/
          has_key?(name[0..-2])
        else
          self[name]._?.call(default_content) || ""
        end
      end
      
      undef_method :default
      
      def [](param_name)
        fetch(param_name, nil)
      end
        
    end
    
  end
  
end
