require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# to PATCH and DELETE
use Rack::MethodOverride

# all the controllers I want to use
use UserController
use ReadingController

run ApplicationController