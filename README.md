# beat_up_selenium
Beat up your Selenium tests.

## How to run
1. Clone this repo.
1. `bundle update`
1. Set the environment variables `SAUCE_USERNAME` and `SAUCE_ACCESS_KEY`.
1. From the commandline, run `THREADS=30 bundle exec ruby beat_up.rb` and wait for it to finish or start throwing errors.

You can change the number of threads run by changing the value after THREADS.
