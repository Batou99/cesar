defmodule Cesar do
  def shift(char, amount, start \\ ?a, finish \\ ?z)

  def shift(_, amount, _start, _finish) when not is_integer(amount) do
    raise "Amount must be a number"
  end

  # No shift
  def shift(char, 0, start, finish) when char in start..finish do
    char
  end

  def shift(char, amount, start, finish) when char in start..finish do
    max_distance = finish - start + 1
    normalize(char, start..finish) |>
      + amount |>
      modulo(max_distance) |>
      denormalize(start..finish)
  end

  # Do not shift non char stuff like number
  # and spaces, symbols, etc if not in range
  def shift(char, _, _, _) do
    char
  end

  def normalize(char, start.._) do
    char - start
  end

  def denormalize(char, start.._) do
    char + start
  end

  def encrypt([], key), do: []

  def encrypt([ head | tail ], key) when head in ?A..?Z do
    [shift(head, key, ?A, ?Z)] ++ encrypt(tail, key)
  end

  def encrypt([ head | tail ], key) do
    [shift(head, key)] ++ encrypt(tail, key)
  end

  def encrypt(string, key) do
    encrypt(String.to_char_list(string), key) |> to_string
  end

  def decrypt(string, key) do
    encrypt(string, -key)
  end
  
  defp modulo(n, q) when is_integer(n) and n == abs(n) do
    rem(n,q)
  end

  defp modulo(n,q) when is_integer(n) do
    rem(n,q) + q
  end

end
