module ManageEngine
  module AppManager
    module Api
      class Version11
        attr_reader :connect_path

        ###########################
        # URL Response Methods
        ###########################

        def connect_path
          "/AppManager/xml/ListDashboards?apikey=%{api_key}"
        end

        def host_path
          "/AppManager/xml/ListServer?apikey=%{api_key}&type=%{type}"
        end

        ###########################
        # Processing Methods
        ###########################

        def connect_response_valid?(response)
          doc = Nokogiri::XML response
          status = doc.xpath("/AppManager-response/result/response")

          return (!status[0].nil? and status[0].attr("response-code") == "4000")
        end

        def hosts_services(response)
          host_services_list = Hash.new
          doc                = Nokogiri::XML response

          doc.xpath("/AppManager-response/result/response/Server").each do |server_xml|
            (host_services_list[server_xml.attr("Name")] = Array.new).tap do |server_monitors|
              server_xml.xpath("./Service").each_with_index do |service_xml, i|
                server_monitors.push service_xml.attr("TYPE")
              end
            end
          end

          host_services_list
        end

        def hosts(response)
          self.hosts_services(response).keys
        end
      end
    end
  end
end
