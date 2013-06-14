module ManageEngine
  module AppManager
    class Server
      attr_accessor :host, :port

      def initialize(host, port, options = nil)
        self.host = host.to_s
        self.port = port.to_i
      end

      def valid?
        !self.host.empty? &&
        self.port != 0    &&
        self.port < 65535 &&
        self.port > 0
      end
    end
  end
end
