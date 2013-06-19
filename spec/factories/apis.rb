FactoryGirl.define do
  factory :api, :class => "ManageEngine::AppManager::Api" do
    version "11"

    initialize_with { new(version) }
  end
end
