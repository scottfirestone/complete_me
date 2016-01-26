require_relative './lib/complete_me'

Shoes.app {
  background skyblue
  complete_me = CompleteMe.new
  dictionary = File.read('/usr/share/dict/words')
  complete_me.populate(dictionary)
  @stack = stack( margin: 75){
    style(:margin_left => '50%', :left => '-25%')
    @title = para 'Autocomplete Word'
    @fragment = edit_line
    @push_me = button "Lookup"
    @suggestions = para ''
    flow do
      @push_me.click do
        words = complete_me.suggest(@fragment.text).reverse.join(", ")
        @suggestions.text = words
      end
    end
  }
  @stack.style font: 'Arial'
}
