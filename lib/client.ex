defmodule Client do
  def main(argv) do
    argv
      |> parse_args
      |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args)
    case parse do
      { _ , [ action , file, key ], _ } -> 
        { value, _ } = Integer.parse(key) 
        { action, file, value }
    end
  end

  def process({ encrypt, file, key }) do
    Reader.encrypt(file, key)
  end

  def process({ decrypt, file, key }) do
    Reader.decrypt(file, key)
  end
end
