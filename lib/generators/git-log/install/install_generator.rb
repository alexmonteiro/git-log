require 'rails/generators'

module Git
  module Log
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        source_root(File.dirname(__FILE__) + '/../../../../config/')
        desc "This generator installs git-log.yml on config app directory"
      
        def copy_conf_file 
          copy_file ('git-log.yml'), (Rails.root.to_s+"/config/git-log.yml")
        end  
      
      end
    end
  end
end
