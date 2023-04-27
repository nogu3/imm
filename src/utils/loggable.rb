require 'logger'

module Loggable
  log_path = ENV['LOG_PATH']
  @@logger = Logger.new(log_path)
  @@logger.formatter = proc do |severity, datetime, progname, msg|
    now = Time.at(datetime, in: "+09:00").strftime('%Y-%m-%d %H:%M:%S.%L')
    log = "[ #{now} ][#{severity}]: #{msg}\n"
    puts log
    log
  end

  def logger
    @@logger
  end
end
