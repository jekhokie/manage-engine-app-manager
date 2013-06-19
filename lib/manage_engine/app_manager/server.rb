require "net/http"

module ManageEngine
  module AppManager
    class Server
      attr_accessor :host, :port, :api_key
      attr_reader   :api_version, :api

      DEFAULT_PORT        = 9090
      DEFAULT_API_VERSION = "11"

      def initialize(args)
        # initialize default attributes
        self.port    = DEFAULT_PORT
        @api_version = DEFAULT_API_VERSION

        # assign overrideable attributes
        unless args.nil?
          self.host        = args[:host]    ? args[:host].to_s    : nil
          self.port        = args[:port]    ? args[:port].to_i    : DEFAULT_PORT
          self.api_key     = args[:api_key] ? args[:api_key].to_s : nil

          unless (extra_opts = args[:opts]).nil?
            @api_version = extra_opts[:api_version].to_s if extra_opts[:api_version]
          end
        end

        begin
          # build a new API object
          @api = ManageEngine::AppManager::Api.new(@api_version)
        rescue Exception => e
          raise e.message
        end

        self.valid?
      end

      def valid?
        raise "Missing :host Parameter"                  if self.host.nil?        or self.host.empty?
        raise "Missing :api_key Parameter"               if self.api_key.nil?     or self.api_key.empty?
        raise "Missing or Non-Numeric :port Parameter"   if self.port.nil?        or self.port      == 0 or
                                                                                     self.port.to_s == ""
        raise ":port not within range 1 < :port < 65535" if self.port.nil?        or self.port > 65535 or
                                                                                     self.port < 1
        raise ":api_version cannot be blank"             if @api_version.nil? or @api_version.to_s == ""

        true
      end

      def api_version=(api_version)
        begin
          # build a new API object
          @api         = ManageEngine::AppManager::Api.new(api_version)
          @api_version = api_version
        rescue Exception => e
          raise e.message
        end
      end

      def root_url
        "http://#{self.host}:#{self.port}/"
      end

      def can_connect?
        begin
          response = Net::HTTP.start(self.host, self.port) do |http|
            http.get(@api.connect_path % { :api_key => self.api_key })
          end

          valid_response = @api.connect_response_valid?(response.body)
        rescue Exception => e
          raise e.message
        end

        return valid_response
      end

      def monitored_hosts_services
        begin
          can_connect?

          response = Net::HTTP.start(self.host, self.port) do |http|
            http.get(@api.host_path % { :api_key => self.api_key, :type => "all" })
          end

          valid_response = @api.hosts_services(response.body)
        rescue Exception => e
          raise e.message
        end
      end

      def monitored_hosts
        self.monitored_hosts_services.keys
      end
    end
  end
end
