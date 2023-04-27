require_relative './answer_unit'
require_relative './aggregate_unit'
require_relative './choise_character_unit'

class Magi
  def initialize
    @choise_charcter_unit = ChoiseCharcterUnit.new
    @aggregate_unit = AggregateUnit.new
  end

  def question(content)
    characters = choise_charcters(content)
    @magi_units = characters.map { |character| AnswerUnit.new(character) }

    queue = Queue.new
    threads = @magi_units.map do|magi_unit|
      Thread.new do
        answer = magi_unit.question(content)
        puts magi_unit.to_s_question_answer(content, answer)

        summarize = magi_unit.summarize(answer)
        queue.push(summarize)
      end
    end

    threads.each(&:join)
    opinion = ""
    while !queue.empty?
      opinion += "#{queue.pop}\n"
      opinion += "\n"
    end
    answer = @aggregate_unit.question(opinion)
    puts @aggregate_unit.to_s_question_answer(opinion, answer)
    answer
  end

  def choise_charcters(user_question)
    @choise_charcter_unit.choise(user_question)
  end

  def all_characters(&)
    @magi_units.each(&)
  end
end