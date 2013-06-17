FactoryGirl.define do
  factory :server, :class => "ManageEngine::AppManager::Server" do
    host        "localhost"
    port        9090
    api_key     "f1e7b9f58d01ca274db68bd56bf82b2c"
    api_version "11"

    initialize_with {
      new(:host => host, :port => port, :api_key => api_key, :opts => { :api_version => api_version })
    }
  end
end
