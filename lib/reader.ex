defmodule Reader do

  def encrypt(file, key) do
    process(file, key, &Cesar.encrypt/2)
  end

  def decrypt(file, key) do
    process(file, key, &Cesar.decrypt/2)
  end

  def ml(file) do
    test_string = File.stream!(file) 
                  |> Enum.take(5) 
                  |> Enum.map(&String.strip/1) 
                  |> Enum.join(" ") 
                  |> String.replace(~r/[".,]/,"")
    key = ML.find_decrypt_key(test_string)
    decrypt(file, key)
  end

  defp process(file, key, function) do
    File.stream!(file) |> Enum.map(fn (line) -> function.(line, key) end) |> IO.write
  end
end
