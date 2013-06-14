require 'spec_helper'

describe ManageEngine::AppManager do
  subject { ManageEngine::AppManager }

  it "can create a new server" do
    subject.should respond_to(:new)
  end

  describe "server" do
    describe "attributes" do
      let(:manager_server) { FactoryGirl.build :server }

      it { manager_server.should respond_to(:host) }
      it { manager_server.should respond_to(:port) }
    end

    describe "valid?" do
      it "returns true for valid attributes" do
        FactoryGirl.build(:server).should be_valid
      end

      # host
      it "returns false for a missing host" do
        FactoryGirl.build(:server, :host => "").should_not be_valid
      end

      # port
      it "returns false for a missing port" do
        FactoryGirl.build(:server, :port => "").should_not be_valid
      end

      it "returns true for a port of type String" do
        FactoryGirl.build(:server, :port => "8080").should be_valid
      end

      it "returns false for a port outside of acceptable range 1-65535" do
        FactoryGirl.build(:server, :port => 70000).should_not be_valid
      end
    end
  end
end
