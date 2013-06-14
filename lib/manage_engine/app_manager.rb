require "manage_engine/app_manager/version"

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
      def new(host, port, ssl = false, options = nil)
        ManageEngine::AppManager::Instance.new(host, port, ssl, options)
      end
    end
  end
end
