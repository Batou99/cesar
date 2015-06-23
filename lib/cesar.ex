defmodule Cesar do
  #####################################################################
  #  PUBLIC
  #####################################################################
  
  def encrypt([], key), do: []

  def encrypt([ head | tail ], key) when head in ?A..?Z do
    normalized_key = modulo(key, ?Z-?A+1)
    [shift(head, normalized_key, ?A, ?Z)] ++ encrypt(tail, key)
  end

  def encrypt([ head | tail ], key) do
    normalized_key = modulo(key, ?z-?a+1)
    [shift(head, normalized_key)] ++ encrypt(tail, key)
  end

  def encrypt(string, key) do
    encrypt(String.to_char_list(string), key) |> to_string
  end

  def decrypt(string, key) do
    encrypt(string, -key)
  end

  #####################################################################
  #  PRIVATE
  #####################################################################
  
  defp shift(char, amount, start \\ ?a, finish \\ ?z)

  defp shift(_, amount, _start, _finish) when not is_integer(amount) do
    raise "Amount must be a number"
  end

  # No shift
  defp shift(char, 0, start, finish) when char in start..finish do
    char
  end

  defp shift(char, amount, start, finish) when char in start..finish do
    max_distance = finish - start + 1
    normalize(char, start..finish) |>
      + amount |>
      modulo(max_distance) |>
      denormalize(start..finish)
  end

  # Do not shift non char stuff like number
  # and spaces, symbols, etc if not in range
  defp shift(char, _, _, _) do
    char
  end

  defp normalize(char, start.._) do
    char - start
  end

  defp denormalize(char, start.._) do
    char + start
  end

  defp modulo(n, q) when is_integer(n) and n == abs(n) do
    rem(n,q)
  end

  defp modulo(n,q) when is_integer(n) do
    rem(n,q) + q
  end

end
