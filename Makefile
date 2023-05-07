setup:
	@bundle install
	@bundle exec rake db:create
	@bundle exec rake db:migrate
	@bundle exec rake db:seed
	@bundle exec rake db:create RAILS_ENV=test
	@bundle exec rake db:schema:load RAILS_ENV=test

run:
	@bundle exec rackup -p 3000

console:
	@bundle exec ruby ./bin/console.rb

test:
	@bundle exec rspec
