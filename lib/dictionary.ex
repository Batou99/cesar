defmodule Dictionary do
  
  @name __MODULE__

  #####################################################################
  #  PUBLIC
  #####################################################################

  def start_link do
    Agent.start_link(fn -> HashDict.new end, name: @name)
  end

  def add_words(words, starting_with) do
    Agent.update(@name, &do_add_words(&1, words, starting_with))
  end

  def count([]), do: 0

  def count([head|tail]) do
    count(head) + count(tail)
  end

  def count(word) do
    starting_with = to_char_list(word) |> hd
    found = Agent.get(@name, fn(dict) -> Dict.get(dict, starting_with, []) |> Enum.member?(word) end)
    keys = Agent.get(@name, fn(dict) -> Dict.keys(dict) end)
    if found, do: 1, else: 0
  end

  #####################################################################
  #  PRIVATE
  #####################################################################

  defp do_add_words(dict, words, starting_with) do
    Dict.put(dict, starting_with, words)
  end

end

defmodule WordlistLoader do

  @path "data/words"

  # Load files in background
  def load_from_files do
    Enum.to_list(?a..?z) 
      |> to_string 
      |> String.split("", trim: true) 
      |> Stream.map(fn name -> Task.async(fn -> load_file(name) end) end)
      |> Enum.map(&Task.await/1)
  end

  defp load_file(letter) do
    filename = "#{@path}/#{letter}.txt"
    File.stream!(filename, [], :line) 
    |> Enum.map(&String.strip/1)
    |> Dictionary.add_words(to_char_list(letter) |> hd)
  end

  
end
