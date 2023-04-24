# frozen_string_literal: true

require 'active_support'
require_relative './loggable'

class OpenAIClient
  include Loggable

  def initialize
    api_key = ENV['API_KEY']
    @client = OpenAI::Client.new(access_token: api_key)
  end

  def completions(question)
    response = request(question)

    logger.debug(response.body)

    if error?(response)
      puts 'すみません。うまく答えられないので、開発者の助けがほしいです。'
      puts 'stacktrace:'
      pp response
      return
    end

    get_answer(response)
  end

  def request(question)
    @client.completions(
      parameters: {
        model: 'text-davinci-003',
        prompt: question,
        max_tokens: 2028,
        temperature: 0.5
      }
    )
  end

  def get_answer(response)
    response['choices'][0]['text'].delete("\n")
  end

  def error?(response)
    response.code != 200
  end
end
