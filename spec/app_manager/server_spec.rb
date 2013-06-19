require 'spec_helper'

describe ManageEngine::AppManager::Server do
  subject { ManageEngine::AppManager::Server }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end

  describe "attributes" do
    let(:manager_server) { FactoryGirl.build :server }

    it { manager_server.should respond_to(:host)    }
    it { manager_server.should respond_to(:port)    }
    it { manager_server.should respond_to(:api_key) }
  end

  describe "valid?" do
    it "returns true for valid attributes" do
      expect { FactoryGirl.build(:server) }.to_not raise_error
    end

    # host
    it "raises error for a missing host" do
      expect{ FactoryGirl.build(:server, :host => "") }.to raise_error
    end

    # port
    it "raises error for a missing port" do
      expect{ FactoryGirl.build(:server, :port => "") }.to raise_error
    end

    it "returns true for a port of type String" do
      expect{ FactoryGirl.build(:server, :port => "8080") }.to_not raise_error
    end

    it "raises error for an invalid port of type String" do
      expect{ FactoryGirl.build(:server, :port => "abc") }.to raise_error
    end

    it "raises error for a port outside of acceptable range 1-65535" do
      expect{ FactoryGirl.build(:server, :port => 70000) }.to raise_error
    end

    # api_key
    it "raises error for a missing api_key" do
      expect{ FactoryGirl.build(:server, :api_key => "") }.to raise_error
    end

    # api_version
    it "returns true for a valid api_version" do
      expect{ FactoryGirl.build(:server, :api_version => "11") }.to_not raise_error
    end

    it "raises error for an unspecified api_version" do
      expect{ FactoryGirl.build(:server, :api_version => "") }.to raise_error
    end

    it "raises error for an unsupported api_version" do
      expect{ FactoryGirl.build(:server, :api_version => "X") }.to raise_error
    end
  end

  describe "api_version" do
    before :each do
      @manage_server = FactoryGirl.build :server
    end

    it "assigns the corresponding API version when the version exists" do
      @manage_server.api_version = "11"
      @manage_server.api_version.should == "11"
    end

    it "raises error when the version does not exist" do
      expect{ @manage_server.api_version=("13") }.to raise_error
    end

    it "retains the previous version when a specified version does not exist" do
      @manage_server.stub('api_version=').and_return true

      @manage_server.api_version = "13"
      @manage_server.api_version.should == "11"
    end
  end

  describe "root_url" do
    let(:host)           { "my.host" }
    let(:port)           { "9001" }
    let(:manager_server) { FactoryGirl.build :server, :host => host, :port => port }

    it "returns the root url for the location of the AppManager service" do
      manager_server.root_url.should == "http://#{host}:#{port}/"
    end
  end

  describe "can_connect?" do
    let(:host)    { "my.host" }
    let(:port)    { "9001" }
    let(:api_key) { "abc123" }

    describe "for a non-reachable server" do
      let(:manager_server) { FactoryGirl.build :server }

      it "should raise exception" do
        expect{ manager_server.can_connect? }.to raise_error
      end
    end

    describe "for valid connection credentials" do
      let(:manager_server) { FactoryGirl.build :server, :host => host, :port => port, :api_version => "11", :api_key => api_key }

      before :each do
        FakeWeb.register_uri(:get, "http://#{host}:#{port}/AppManager/xml/ListDashboards?apikey=#{api_key}", :body => File.open(File.dirname(__FILE__) + "/../fixtures/valid_connect.xml", "r").read)
      end

      it "should return true" do
        manager_server.can_connect?.should be_true
      end
    end

    describe "for invalid connection credentials" do
      let(:manager_server) { FactoryGirl.build :server, :host => host, :port => port, :api_version => "11", :api_key => "BOGUS" }

      before :each do
        FakeWeb.register_uri(:get, "http://#{host}:#{port}/AppManager/xml/ListDashboards?apikey=#{api_key}", :body => File.open(File.dirname(__FILE__) + "/../fixtures/invalid_connect.xml", "r").read)
      end

      it "should return true" do
        expect{ manager_server.can_connect? }.to raise_error
      end
    end
  end

  describe "all_hosts_services" do
    let(:host)           { "my.host" }
    let(:port)           { "9001" }
    let(:api_key)        { "abc123" }
    let(:manager_server) { FactoryGirl.build :server, :host => host, :port => port, :api_version => "11", :api_key => api_key }

    describe "for an instance with servers being monitored" do
      before :each do
        # required for can_connect?
        FakeWeb.register_uri(:get, "http://#{host}:#{port}/AppManager/xml/ListDashboards?apikey=#{api_key}", :body => File.open(File.dirname(__FILE__) + "/../fixtures/valid_connect.xml", "r").read)
        FakeWeb.register_uri(:get, "http://#{host}:#{port}/AppManager/xml/ListServer?apikey=#{api_key}&type=all", :body => File.open(File.dirname(__FILE__) + "/../fixtures/all_hosts.xml", "r").read)
      end

      it "returns a hash of service arrays" do
        manager_server.all_hosts_services.should == { "test-vm.local.host"  => [ "Service Monitoring", "Tomcat", "Tomcat", "JBoss", "PostgreSQL" ],
                                                      "test2-vm.local.host" => [ "Service Monitoring", "Tomcat", "PostgreSQL" ] }
      end
    end

    describe "for a non-reachable server" do
      let(:manager_server) { FactoryGirl.build :server }

      it "should raise exception" do
        expect{ manager_server.all_hosts_services }.to raise_error
      end
    end
  end
end
