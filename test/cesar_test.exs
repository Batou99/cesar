defmodule CesarTest do
  use ExUnit.Case
  use ShouldI, async: true

  with "#encrypt" do
    with "zero" do

      should "not encrypt" do
        assert "x" == Cesar.encrypt("x", 0)
      end
    end

    with "positive" do

      should "a -> b" do
        assert "b" == Cesar.encrypt("a", 1)
      end

      should "z -> a" do
        assert "a" == Cesar.encrypt("z", 1)
      end

      should "a -> b on fullround" do
        full_round = ?z - ?a + 1
        assert "b" == Cesar.encrypt("a", full_round + 1)
      end
    end

    with "negative" do

      should "a -> z" do
        assert "z" == Cesar.encrypt("a", -1)
      end

      should "z -> y" do
        assert "y" == Cesar.encrypt("z", -1)
      end
    end

    with "numbers" do
      should "not encrypt" do
        assert "1" == Cesar.encrypt("1", -1)
        assert "0" == Cesar.encrypt("0", 1)
      end
    end

    with "Uppercase" do
      should "keep case" do
        assert "C" == Cesar.encrypt("B", 1)
        assert "Z" == Cesar.encrypt("A", -1)
      end
    end

    with "Longer strings" do
      should "preserve case" do
        assert "Hola" == Cesar.encrypt("Hola", 0)
        assert "Ipmb" == Cesar.encrypt("Hola", 1)
      end
    end

  end

  with "#decrypt" do

    should "a -> b" do
      full_round = ?z - ?a + 1
      assert "a" == Cesar.decrypt("a", full_round)
    end

    should "be the opposite of encrypt" do
      string = "Pleaz don't go there (key: 99)"
      assert string == Cesar.encrypt(string, 99) |> Cesar.decrypt(99)
    end
  end

end
