require 'spec_helper'

describe ManageEngine::AppManager do
  subject { ManageEngine::AppManager }

  it "can create a new server" do
    subject.should respond_to(:new)
  end

  describe "server" do
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
    end
  end
end
