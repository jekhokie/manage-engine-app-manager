# ManageEngine::AppManager [![Build Status](https://travis-ci.org/jekhokie/manage-engine-app-manager.png)](https://travis-ci.org/jekhokie/manage-engine-app-manager)

Ruby Interface to the ManageEngine ApplicationsManager

## Installation

Add this line to your application's Gemfile:

    gem 'manage-engine-app-manager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install manage-engine-app-manager

## Usage

    # create a new server API instance for ApplicationsManager version 11
    server = ManageEngine::AppManager.new :host    => '192.168.1.56',
                                          :port    => 9090,
                                          :api_key => 'f1e7b9f58d01ca274db68bd56bf82b2c',
                                          :options => { :api_version => '11' }

    # check whether the created server instance can connect to the ApplicationsManager server
    server.can_connect?   # true

    # retrieve a listing of all currently-monitored hosts
    server.monitored_hosts    # [ 'my.host.1', 'my.host.2' ]

    # retrieve a listing of all currently-monitored hosts and their respective services being monitored
    server.monitored_hosts_services   # { 'my.host.1' => [ 'Tomcat', 'JBoss', 'PostgreSQL' ], 'my.host.2' => [ 'PostgreSQL' ] }

    # check whether a host has a service currently being monitored -
    # note that the service name is case-insensitive
    server.has_monitored_service?("my.host.1", "Tomcat")    # true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
