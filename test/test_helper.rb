ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def custom_logger
    @custom_logger ||= Logger.new('factorybot.log')
  end
  
  FactoryBot.define do
    to_create { |instance| custom_logger.info("Created #{instance.class} with attributes: #{instance.attributes}") }
  end
  # Add more helper methods to be used by all tests here...
end
