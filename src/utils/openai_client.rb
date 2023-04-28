# frozen_string_literal: true

require 'openai'
require 'active_support'
require 'benchmark'
require_relative './loggable'

class OpenAIClient
  include Loggable

  def initialize
    api_key = ENV['API_KEY']
    if api_key == "<your-api-key>"
      raise NameError,"Not define api key.Please define your api key."
    end
    @client = OpenAI::Client.new(access_token: api_key)
  end

  def chat(system_setting_character, question)
    request_param = {
      system_setting_character: system_setting_character,
      question: question
    }

    response = request(request_param)
    get_answer(response)
  end

  def request(request_param)
    response = ""
    is_error = false
    result_time = Benchmark.realtime do
      response, is_error = request_without_benchmark(request_param)
    end

    logger.debug("response time is #{result_time} second.")

    if is_error
      failed(response)
    end

    response
  end

  def request_without_benchmark(request_param)
    response = @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [
          { role: "system", content: request_param[:system_setting_character]},
          { role: "user", content: request_param[:question]}
        ],
        temperature: 1.2,
      }
    )

    logger.debug("response.body:")
    logger.debug(response.body)

    return response, error?(response)
  end

  def get_answer(response)
    response['choices'][0]['message']['content'].delete("\n")
  end

  def failed(response)
    logger.info('すみません。うまく答えられないので、開発者の助けがほしいです。')
    logger.info('stacktrace:')
    logger.info(response)
    raise RuntimeError, "openai request failed."
  end

  def error?(response)
    response.code != 200
  end
end
