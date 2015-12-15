class Dictionary
  attr_reader :content, :word_count

  def initialize
    @content = []
    @word_count = @content.size
  end

end
