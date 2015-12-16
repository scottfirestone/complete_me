Required Features

To complete the project, you will need to build an
autocomplete system which provides the following features:

Insert a single word to the autocomplete dictionary
Count the number of words in the dictionary
Populate a newline-separated list of words into the dictionary
Suggest completions for a substring
Mark a selection for a substring
Weight subsequent suggestions based on previous selections

We'll expect to interact with your completion
project from an interactive pry session,
following a model something like this:

# open pry from root project directory
require "./lib/complete_me"

completion = CompleteMe.new

completion.insert("pizza")

completion.count
=> 1

completion.suggest("piz")
=> ["pizza"]

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.count
=> 235886

completion.suggest("piz")
=> ["pizza", "pizzeria", "pizzicato"]
