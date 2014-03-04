require_relative '../boot'
Bundler.require(:test)

DatabaseCleaner.strategy = :truncation

