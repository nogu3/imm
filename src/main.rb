# frozen_string_literal: true

require_relative './magi/magi'
require_relative './utils/openai_client'

user_question = File.read('./test/question.txt', encoding: Encoding::UTF_8)

puts '少々お待ちを。'

puts "質問:"
puts user_question
puts ""

question = <<~EOS
以下の質問に最適な3人の人格を決めてください。
人格は半角のカンマ区切りで返すこと
質問:
#{user_question}
EOS
create_character = OpenAIClient.new
characters_str = create_character.completions(question)
characters = characters_str.split(/,|、/).map {|character| character.strip}

puts ""
puts "人格選定:"
puts question
puts ""
puts "人格:"
puts characters_str
puts ""

magi = Magi.new(*characters)
answer = magi.question(user_question)

puts "最終的な回答:"
puts answer
