# frozen_string_literal: true

require_relative './magi/magi'
require_relative './utils/openai_client'

user_question = File.read('./test/question.txt', encoding: Encoding::UTF_8)

puts '少々お待ちを。'

puts "質問:"
puts user_question
puts ""

magi = Magi.new("楽観的", "悲観的", "否定的", "大阪のおばちゃん")
answer = magi.question(user_question)

puts "最終的な回答:"
puts answer
