require File.expand_path(File.dirname(__FILE__) + '/app_manager/version')
require File.expand_path(File.dirname(__FILE__) + '/app_manager/server')

module ManageEngine
  module AppManager
    class << self
      # Public: Initializes a new ManageEngine::AppManager::Instance.
      #
      # host    - Host on which the ApplicationsManager server is running.
      # port    - Port on which the ApplicationsManager is listening.
      # ssl     - Optional boolean indicating whether the server is listening using http-secure (default = false).
      # options - Optional hash used to configure this ManageEngine::AppManager::Instance (default = nil).
      #
      # Examples
      #
      #   ManageEngine::AppManager.new :host => 'http://myHost.internal.com', :port => 9090
      #
      # Returns a ManageEngine::AppManager::Instance.
      def new(host, port, options = nil)
        @server = ManageEngine::AppManager::Server.new host, port, options
      end
    end
  end
end
