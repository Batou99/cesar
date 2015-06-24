defmodule ML do
  def find_decrypt_key(text) do
    load_dict
    { key, cost } = 0..25 
      |> Stream.map( fn(n) -> Task.async(fn -> { n, find_cost(text,n) } end) end) 
      |> Enum.map(&Task.await/1)
      |> Enum.min_by( fn({ key, cost }) -> cost end)
    key
  end

  def decrypt(text) do
    key = find_decrypt_key(text)
    IO.puts Cesar.decrypt(text, key)
  end

  def find_cost(text, key) do
    cryptext = Cesar.decrypt(text, key)
    words = String.split(cryptext, " ")
    # Total words - found words
    # The lower the number the more amount of words found
    Enum.count(words) - Dictionary.count(words)
  end

  def load_dict do
    Dictionary.start_link
    WordlistLoader.load_from_files
  end

end
