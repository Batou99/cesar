defmodule DictionaryTest do
  use ExUnit.Case

    setup do
      Dictionary.start_link
      Dictionary.add_words(["hey", "ho"], ?h)
    end

    test "be zero if not found" do
      assert 0 == Dictionary.count("yo")
    end

    test "be zero if not found" do
      assert 0 == Dictionary.count("yo")
    end

    test "be one if found", context do
      Dictionary.start_link
      Dictionary.add_words(["hey", "ho"], ?h)
      assert 1 == Dictionary.count("hey")
    end

    test "add one per word found" do
      assert 2 == Dictionary.count(["ho", "hey"])
      assert 1 == Dictionary.count(["yo", "hey"])
    end

    test "be zero for space" do
      assert 0 == Dictionary.count("")
    end

end

