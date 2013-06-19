module ManageEngine
  module AppManager
    module Api
      class Version11
        attr_reader :connect_path

        def connect_path
          "/AppManager/xml/ListDashboards?apikey=%{api_key}"
        end

        def connect_response_valid?(response)
          doc = Nokogiri::XML response
          status = doc.xpath("/AppManager-response/result/response")

          return (!status[0].nil? and status[0].attr("response-code") == "4000")
        end
      end
    end
  end
end
