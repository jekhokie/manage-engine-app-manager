require 'spec_helper'

describe ManageEngine::AppManager do
  subject { ManageEngine::AppManager }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end

  describe "new" do
    it "returns a new Server instance" do
      ManageEngine::AppManager.new(:host => "http://www.google.com/", :api_key => "12490y51ti3g").should be_instance_of(ManageEngine::AppManager::Server)
    end
  end
end
