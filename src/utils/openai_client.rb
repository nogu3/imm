# frozen_string_literal: true

require 'openai'
require 'active_support'
require 'benchmark'
require_relative './loggable'

class OpenAIClient
  include Loggable

  def initialize
    api_key = ENV['API_KEY']
    raise NameError, 'Not define api key.Please define your api key.' if api_key == '<your-api-key>'

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
    response = ''
    result_time = Benchmark.realtime do
      response = request_without_benchmark(request_param)
    end

    logger.debug("response time is #{result_time} second.")

    failed(response) if error?(response)

    response
  end

  def request_without_benchmark(request_params)
    response = @client.chat(
      parameters: create_params(request_params)
    )

    logger.debug('response:')
    logger.debug(response)

    response
  end

  def create_params(request_params)
    {
      model: 'gpt-3.5-turbo',
      messages: [
        { role: 'system', content: request_params[:system_setting_character] },
        { role: 'user', content: request_params[:question] }
      ],
      temperature: 0.7
    }
  end

  def get_answer(response)
    response['choices'][0]['message']['content'].delete("\n")
  end

  def failed(response)
    logger.info('すみません。うまく答えられないので、開発者の助けがほしいです。')
    logger.info('stacktrace:')
    logger.info(response['error'])
    raise 'openai request failed.'
  end

  def error?(response)
    response['error'].present?
  end
end
