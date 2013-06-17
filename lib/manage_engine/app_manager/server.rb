module ManageEngine
  module AppManager
    class Server
      attr_accessor :host, :port, :api_key, :api_version

      DEFAULT_PORT        = 9090
      DEFAULT_API_VERSION = "11"

      def initialize(args)
        # initialize default attributes
        self.port        = DEFAULT_PORT
        self.api_version = DEFAULT_API_VERSION

        # assign overrideable attributes
        unless args.nil?
          self.host        = args[:host]    ? args[:host].to_s    : nil
          self.port        = args[:port]    ? args[:port].to_i    : DEFAULT_PORT
          self.api_key     = args[:api_key] ? args[:api_key].to_s : nil

          unless (extra_opts = args[:opts]).nil?
            self.api_version = extra_opts[:api_version].to_s if extra_opts[:api_version]
          end
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
        raise ":api_version cannot be blank"             if self.api_version.nil? or self.api_version.to_s == ""

        true
      end
    end
  end
end
