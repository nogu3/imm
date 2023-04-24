# frozen_string_literal: true

# require 'openai'
require_relative './magi/magi_unit'
require_relative './utils/openai_client'

user_question = File.read('./test/question.txt', encoding: Encoding::UTF_8)

puts '少々お待ちを。'

# client = OpenAIClient.new
# answer = client.completions(user_question)
magi_unit = MagiUnit.new("楽観的")
answer = magi_unit.question(user_question)

puts answer
