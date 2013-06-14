FactoryGirl.define do
  factory :server, :class => "ManageEngine::AppManager::Server" do
    host "localhost"
    port 9090

    initialize_with { new(host, port) }
  end
end
