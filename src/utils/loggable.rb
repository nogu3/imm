require 'logger'

module Loggable
  log_path = ENV['LOG_PATH']
  @@logger = Logger.new(log_path)

  def logger
    @@logger
  end
end
