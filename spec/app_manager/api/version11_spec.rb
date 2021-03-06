require 'spec_helper'

describe ManageEngine::AppManager::Api::Version11 do
  context "url response methods" do
    describe "connect_path" do
      it "returns the connect_path for AppManager" do
        FactoryGirl.build(:api, :version => "11").connect_path.should be_instance_of(String)
      end
    end

    describe "host_path" do
      it "returns the host_path for AppManager" do
        FactoryGirl.build(:api, :version => "11").host_path.should be_instance_of(String)
      end
    end
  end

  context "processing methods" do
    describe "connect_response_valid?" do
      let(:api)              { FactoryGirl.build :api, :version => "11" }
      let(:valid_response)   { File.open(File.dirname(__FILE__) + "/../../fixtures/valid_connect.xml", "r").read }
      let(:invalid_response) { File.open(File.dirname(__FILE__) + "/../../fixtures/invalid_connect.xml", "r").read }
      let(:non_xml)          { "ABC123" }

      it "returns true for a valid response" do
        api.connect_response_valid?(valid_response).should == true
      end

      it "returns false for an invalid response" do
        api.connect_response_valid?(invalid_response).should == false
      end

      it "returns false for non-found response" do
        api.connect_response_valid?(non_xml).should == false
      end
    end

    describe "host_services" do
      let(:api)       { FactoryGirl.build :api, :version => "11" }
      let(:all_hosts) { File.open(File.dirname(__FILE__) + "/../../fixtures/all_hosts.xml", "r").read }

      it "returns a hash of service arrays" do
        api.hosts_services(all_hosts).should == { "test-vm.local.host"  => [ "Service Monitoring", "Tomcat", "Tomcat", "JBoss", "PostgreSQL" ],
                                                  "test2-vm.local.host" => [ "Service Monitoring", "Tomcat", "PostgreSQL" ] }
      end
    end

    describe "hosts" do
      let(:api)       { FactoryGirl.build :api, :version => "11" }
      let(:all_hosts) { File.open(File.dirname(__FILE__) + "/../../fixtures/all_hosts.xml", "r").read }

      it "returns an array of hosts being monitored" do
        api.hosts(all_hosts).should == [ "test-vm.local.host", "test2-vm.local.host" ]
      end
    end

    describe "host_services" do
      let(:api)       { FactoryGirl.build :api, :version => "11" }
      let(:all_hosts) { File.open(File.dirname(__FILE__) + "/../../fixtures/all_hosts.xml", "r").read }

      describe "for no monitored hosts" do
        it "raises an error" do
          expect{ api.host_services("bogusVM", "ABC") }.to raise_error
        end
      end

      describe "for an unknown host" do
        it "raises an error" do
          expect{ api.host_services("bogusVM", all_hosts) }.to raise_error
        end
      end

      describe "for a known host" do
        it "returns an array of monitored services" do
          api.host_services("test-vm.local.host", all_hosts).should == [ "Service Monitoring", "Tomcat", "JBoss", "PostgreSQL" ]
        end
      end
    end
  end
end
