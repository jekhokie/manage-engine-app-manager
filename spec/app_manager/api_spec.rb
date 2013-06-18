require 'spec_helper'

describe ManageEngine::AppManager::Api do
  subject { ManageEngine::AppManager::Api }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end

  describe "new" do
    it "should return a new Api instance" do
      ManageEngine::AppManager::Api.new("11").should be_instance_of(ManageEngine::AppManager::Api::Version11)
    end
  end
end
