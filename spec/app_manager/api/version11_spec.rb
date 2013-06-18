require 'spec_helper'

describe ManageEngine::AppManager::Api::Version11 do
  subject { ManageEngine::AppManager::Api.new("11") }

  it "returns the connect_path" do
    subject.should respond_to(:connect_path)
    subject.connect_path.should be_instance_of(String)
  end
end
