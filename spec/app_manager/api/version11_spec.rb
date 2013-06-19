require 'spec_helper'

describe ManageEngine::AppManager::Api::Version11 do
  subject { ManageEngine::AppManager::Api::Version11 }

  describe "connect_path" do
    it "returns the connect_path for AppManager" do
      FactoryGirl.build(:api, :version => "11").connect_path.should be_instance_of(String)
    end
  end

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
end
