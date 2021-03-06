Dir[File.expand_path(File.dirname(__FILE__) + '/api/*.rb')].each { |file| require file }

module ManageEngine
  module AppManager
    module Api
      class << self
        # Public: Initializes a new ManageEngine::AppManager::Api::Version.
        #
        # version - Version of the API to instantiate.
        #
        # Examples
        #
        #   ManageEngine::AppManager::Api.new :api_version => '11'
        #
        # Returns a ManageEngine::AppManager::Api.
        #
        def new(version)
          if self.supported_versions.include? version
            new_api = self.const_get("Version#{version}").new
          else
            raise "Invalid API version - acceptable versions are: #{self.supported_versions}"
          end

          new_api
        end

        def supported_versions
          [ '11' ]
        end
      end
    end
  end
end
