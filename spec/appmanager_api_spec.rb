require 'spec_helper'

describe ManageEngine::AppManager do
  subject { ManageEngine::AppManager }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end
end
