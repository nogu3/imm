# frozen_string_literal: true

require 'openai'
require_relative './utils/openai_client'

user_question = File.read('./test/question.txt')

puts '少々お待ちを。'

client = OpenAIClient.new
answer = client.completions(user_question)

puts answer
