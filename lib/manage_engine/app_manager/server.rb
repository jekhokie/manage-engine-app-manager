module ManageEngine
  module AppManager
    class Server
      attr_accessor :host, :port, :api_key

      DEFAULT_PORT = 9090

      def initialize(args)
        unless args.nil?
          self.host    = args[:host]    ? args[:host].to_s     : nil
          self.port    = args[:port]    ? args[:port].to_i     : DEFAULT_PORT
          self.api_key = args[:api_key] ? args[:api_key].to_s  : nil
        end

        self.valid?
      end

      def valid?
        raise "Missing :host Parameter"                  if self.host.nil?    or self.host.empty?
        raise "Missing :api_key Parameter"               if self.api_key.nil? or self.api_key.empty?
        raise "Missing or Non-Numeric :port Parameter"   if self.port.nil?    or self.port      == 0 or
                                                                                 self.port.to_s == ""
        raise ":port not within range 1 < :port < 65535" if self.port.nil?    or self.port > 65535 or
                                                                                 self.port < 1
      end
    end
  end
end
