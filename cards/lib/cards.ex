defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """
  
  
  @doc """
    returns a list of strings representing a deck of playing cards.
  
  ## Examples
    
      iex> deck = Cards.create_deck
      iex> deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
       "Five of Spades", "Six of Spades", "Seven of Spades", "Eight of Spades",
       "Nine of Spades", "Ten of Spades", "Jack of Spades", "Queen of Spades",
       "King of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
       "Four of Clubs", "Five of Clubs", "Six of Clubs", "Seven of Clubs",
       "Eight of Clubs", "Nine of Clubs", "Ten of Clubs", "Jack of Clubs",
       "Queen of Clubs", "King of Clubs", "Ace of Hearts", "Two of Hearts",
       "Three of Hearts", "Four of Hearts", "Five of Hearts", "Six of Hearts",
       "Seven of Hearts", "Eight of Hearts", "Nine of Hearts", "Ten of Hearts",
       "Jack of Hearts", "Queen of Hearts", "King of Hearts", "Ace of Diamonds",
       "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds",
       "Six of Diamonds", "Seven of Diamonds", "Eight of Diamonds",
       "Nine of Diamonds", "Ten of Diamonds", "Jack of Diamonds", 
       "Queen of Diamonds", "King of Diamonds"]
      
  """
  def create_deck  do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    
    #list comprehension
    for suit <- suits, value <- values do 
        "#{value} of #{suit}"
    end
  end
  
  @doc """
    Takes a deck of card and shuffles the order of the cards
  
  ## Examples
    
      iex> deck = Cards.create_deck
      iex> shuffled_deck = Cards.shuffle(deck)
      iex> deck != shuffled_deck
      true
      
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end
  
  @doc """
    Checks to see if deck contains card
    
  ## Examples
    
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      
  """
  def contains?(deck, card) do
    Enum.member?(deck,card)
  end
  
  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be
    in the hand.
    
  ## Examples
    
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
      
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
  
  @doc """
    Saves deck to filename
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end
  
  @doc """
    retrieves deck from filename
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist" 
    end
  end
  
  @doc """
    Combines functionality of methods to create a hand.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle #automatically inject deck into deal
    |> Cards.deal(hand_size)
  end
  
end

# start shell using iex -S mix