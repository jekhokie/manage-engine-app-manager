require_relative 'app_manager/version'
require_relative 'app_manager/server'
require_relative 'app_manager/api'

module ManageEngine
  module AppManager
    class << self
      # Public: Initializes a new ManageEngine::AppManager::Instance.
      #
      # host    - Host on which the ApplicationsManager server is running.
      # port    - Optional port on which the ApplicationsManager is listening (default = 9090).
      # api_key - REST key used to communicate with the AppManager service.
      # options - Optional hash used to configure this ManageEngine::AppManager::Instance (default = nil).
      #             :api_version - Version of the AppManager API to use (drives the schema)
      #
      # Examples
      #
      #   ManageEngine::AppManager.new :host => 'http://myHost.internal.com', :port => 9090
      #
      # Returns a ManageEngine::AppManager::Instance.
      #
      def new(args = nil)
        ManageEngine::AppManager::Server.new args
      end
    end
  end
end
