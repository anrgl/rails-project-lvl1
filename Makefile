install:
	bundle install

test:
	rake test

rubocop:
	bundle exec rubocop

.PHONY: test
