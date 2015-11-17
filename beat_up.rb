##Blank Selenium Test
require "selenium/webdriver"


def un
  ENV["SAUCE_USERNAME"]
end

def ak
  ENV["SAUCE_ACCESS_KEY"]
end

def auth
  "#{un}:#{ak}"
end

def server 
  "ondemand.saucelabs.com"
end

def port
  80
end

def endpoint
  "#{server}:#{port}/wd/hub"
end

def auth_endpoint
  "http://#{auth}@#{endpoint}"
end

def num_threads
  ENV["THREADS"].to_i
end

def caps
  {
    browserName: 'Firefox',
    platform: 'Windows 7',
    version: 42
  }
end

def sites
  [
    "http://www.sears.com",
    "http://www.msn.com",
    "http://www.saucelabs.com",
    "http://www.ford.com",
    "http://www.holden.com",
    "http://www.toyota.com.au",
    "http://www.moogle.com",
    "http://www.nintendo.com",
    "http://www.desk.com",
    "http://www.rubygems.org",
    "http://www.tesla.com"
  ]*10  
end

def visit_sites driver
  begin
    sites.each do |site|
        driver.navigate.to site

        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until do
          state = driver.execute_script "return document.readyState === 'complete'"
        end
    end
  rescue Selenium::WebDriver::Error::TimeOutError
    STDERR.puts "Timed out waiting for page to load"
  end
end

def run_selenium_test
  driver = Selenium::WebDriver.for :remote, :url => auth_endpoint, :desired_capabilities => caps
  visit_sites driver
  driver.quit
end

threads = []
num_threads.times do |thread|
  threads[thread] = Thread.new {
    run_selenium_test
  }
end

threads.each {|t| t.join}
