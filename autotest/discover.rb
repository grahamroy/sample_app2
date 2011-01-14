Autotest.add_discovery { "rails" }
Autotest.add_discovery { "rspec2" }

# Save CPU cycles!
require 'autotest/fsevent' if RUBY_PLATFORM.include?('darwin')
