require 'yaml'

module Git
  module Log
    class MetaLog            
      #get attributes defined on git-log.yml file
      def self.log_attr
       path = File.dirname(__FILE__) + '/../../config/git-log.yml'
       if defined?(Rails.root)
         if File.exists?((Rails.root.to_s  + "/config/git-log.yml"))
           path = (Rails.root.to_s  + "/config/git-log.yml")
         end
       end
       YAML.load(File.open(path))
      end

      #method to return class attr_accessor attributes
      def self.attributes
        log_attr["git-log-attr"].keys
      end
      
      # Constructor with dinamic set of attributes
      def initialize(*args)
        class <<self
          self
        end.class_eval do          
          # define attrr_accessors
          self.log_attr['git-log-attr'].keys.each do |attr_varname|
           attr_accessor attr_varname
          end
        end
        # set values
        # self.class = Metalog
        self.class.log_attr['git-log-attr'].keys.each_with_index {|attribute, index| self.send("#{attribute}=", args[index])}
      end

    end
  end
end