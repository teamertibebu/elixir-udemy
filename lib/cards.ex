defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
  Creates a deck.
  """
  def create_deck do
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

  @doc """
  Checks if a given card is a member of the hand/deck.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Jack of Hearts")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Loads a deck/hand from the file system.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File Does Not Exist."
    end
  end

  @doc """
  Shuffles a deck.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Takes a deck and `hand_size` as arguments and deals a hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> hand = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    {hand, _} = Enum.split(deck, hand_size)
    hand
  end

  @doc """
  Saves a deck/hand to the file system.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.save(deck, "my_new_deck")
      :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Creates a deck, shuffles it, and deals a hand with the given hand size.
  """

  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end
