console:
	@bundle exec ruby ./bin/console.rb
run:
	@bundle exec rackup -p 3000
setup:
	@bundle install
	@bundle exec rake db:create
	@bundle exec rake db:migrate
	@bundle exec rake db:seed
	@bundle exec rake db:test:prepare
