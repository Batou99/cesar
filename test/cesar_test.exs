defmodule CesarTest do
  use ExUnit.Case
  use ShouldI, async: true

  with "#shift" do
    with "zero" do

      should "not shift", context do
        assert ?x == Cesar.shift(?x, 0)
      end
    end

    with "positive" do

      should "a -> b", context do
        assert ?b == Cesar.shift(?a, 1)
      end

      should "z -> a", context do
        assert ?a == Cesar.shift(?z, 1)
      end
    end

    with "negative" do

      should "a -> z", context do
        assert ?z == Cesar.shift(?a, -1)
      end

      should "z -> y", context do
        assert ?y == Cesar.shift(?z, -1)
      end
    end

    with "numbers" do
      should "not shift" do
        assert ?1 == Cesar.shift(?1, -1)
        assert ?0 == Cesar.shift(?0, 1)
      end
    end

    with "Uppercase" do
      should "keep case" do
        assert ?B == Cesar.shift(?A, 1, ?A, ?Z)
        assert ?Z == Cesar.shift(?A, -1, ?A, ?Z)
      end
    end
  end

  with "#encrypt" do
    should "preserve case" do
      assert "Hola" == Cesar.encrypt("Hola", 0)
      assert "Ipmb" == Cesar.encrypt("Hola", 1)
    end
  end

end
