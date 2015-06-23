defmodule Reader do

  def encrypt(file, key) do
    process(file,key,&Cesar.encrypt/2)
  end

  def decrypt(file, key) do
    process(file,key,&Cesar.decrypt/2)
  end

  defp process(file, key, function) do
    File.stream!(file) |> Enum.map(fn (line) -> function.(line, key) end) |> IO.write
  end
end
