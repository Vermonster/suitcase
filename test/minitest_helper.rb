# Testing frameworks
gem "minitest"
require "minitest/autorun"
require "mocha/setup"

# For making sure the dates will be valid
require "chronic"

# Debugger
require "pry"

# The gem
$: << File.dirname(__FILE__) + "/../lib"
$: << File.dirname(__FILE__)
require "suitcase"

# API keys
require "keys"

# Support files
require "support/fake_response"

