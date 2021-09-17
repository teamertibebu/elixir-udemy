defmodule Cards do
  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end

  defp create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Diamonds", "Hearts"]

    _cards = for val <- values, suit <- suits, do: "#{val} of #{suit}"
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File Does Not Exist."
    end
  end

  defp shuffle(deck) do
    Enum.shuffle(deck)
  end

  defp deal(deck, hand_size) do
    {hand, _} = Enum.split(deck, hand_size)
    hand
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end
end
