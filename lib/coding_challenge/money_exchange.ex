defmodule CodingChallenge.MoneyExchange do
  @moduledoc """
  The MoneyExchange context.
  """

  import Ecto.Query, warn: false
  alias CodingChallenge.Repo

  alias CodingChallenge.MoneyExchange.CurrencyConversion

  @doc """
  Returns the list of currency_conversions.

  ## Examples

      iex> list_currency_conversions()
      [%CurrencyConversion{}, ...]

  """
  def list_currency_conversions do
    Repo.all(CurrencyConversion)
  end

  @doc """
  Gets a single currency_conversion.

  Raises `Ecto.NoResultsError` if the Currency conversion does not exist.

  ## Examples

      iex> get_currency_conversion!(123)
      %CurrencyConversion{}

      iex> get_currency_conversion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_currency_conversion!(id), do: Repo.get!(CurrencyConversion, id)

  @doc """
  Creates a currency_conversion.

  ## Examples

      iex> create_currency_conversion(%{field: value})
      {:ok, %CurrencyConversion{}}

      iex> create_currency_conversion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_currency_conversion(attrs \\ %{}) do
    %CurrencyConversion{}
    |> CurrencyConversion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a currency_conversion.

  ## Examples

      iex> update_currency_conversion(currency_conversion, %{field: new_value})
      {:ok, %CurrencyConversion{}}

      iex> update_currency_conversion(currency_conversion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_currency_conversion(%CurrencyConversion{} = currency_conversion, attrs) do
    currency_conversion
    |> CurrencyConversion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a currency_conversion.

  ## Examples

      iex> delete_currency_conversion(currency_conversion)
      {:ok, %CurrencyConversion{}}

      iex> delete_currency_conversion(currency_conversion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_currency_conversion(%CurrencyConversion{} = currency_conversion) do
    Repo.delete(currency_conversion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking currency_conversion changes.

  ## Examples

      iex> change_currency_conversion(currency_conversion)
      %Ecto.Changeset{data: %CurrencyConversion{}}

  """
  def change_currency_conversion(%CurrencyConversion{} = currency_conversion, attrs \\ %{}) do
    CurrencyConversion.changeset(currency_conversion, attrs)
  end
end
