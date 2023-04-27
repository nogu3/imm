class ChoiseCharcterUnit < MagiUnit
  def question_content(content)
    question_content = <<~"EOS"
    以下の質問に最適な3人の人格を決めてください。
    人格は半角のカンマ区切りで返すこと
    質問:
    #{content}
    EOS
    question_content
  end

  def choise(user_question)
    characters_str = question(user_question)
    characters_str.split(/,|、/).map {|character| character.strip}
  end
end