require "git-log/version"
require "generators/git-log/install/install_generator"

module Git
  module Log
    # Your code goes here...
    #@logs = Git::Log::Log.find_logs
    require "git-log/metalog"
            
    # Execute git command and put the result on array of Log class
    def self.find_logs
      logs = []
      logs_array = self.execute_git_command
      logs_array.each do |log|
        args = eval(log)
        logs.push(Git::Log::MetaLog.new(*args))
      end
      logs        
    end
    
    private
    #git repository path
    def self.git_path
      if defined?(Rails.root)
        Rails.root
      else
        Dir.pwd
      end
    end
    
    # Execute git command with parameters defined on git-log.yml
    def self.execute_git_command
      git_log_conf = Git::Log::MetaLog.log_attr["git-log-conf"]
      #`git log --pretty=format:'[\"%cd\",\"%an\",\"%s\"]' -n 5 --no-merges`.split(/\r?\n/) 
      `git log #{git_log_conf["max-count"]} #{git_log_conf["no-merges"]} --pretty=format:'#{Git::Log::MetaLog.log_attr["git-log-attr"].values.inspect}' '#{git_path}'`.split(/\r?\n/) 
    end
    
    
  end
end
