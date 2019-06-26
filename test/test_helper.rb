ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def file_fixture_blob(name)
    {
      io: file_fixture(name).open,
      filename: name
    }
  end

  setup do
    Upload.delete_all
  end
end
