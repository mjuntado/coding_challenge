defmodule CodingChallenge.MoneyExchangeTest do
  use CodingChallenge.DataCase

  alias CodingChallenge.MoneyExchange

  describe "currency_conversions" do
    alias CodingChallenge.MoneyExchange.CurrencyConversion

    import CodingChallenge.MoneyExchangeFixtures

    @invalid_attrs %{source_currency: nil, target_currency: nil, source_amount: nil, target_amount: nil}

    test "list_currency_conversions/0 returns all currency_conversions" do
      currency_conversion = currency_conversion_fixture()
      assert MoneyExchange.list_currency_conversions() == [currency_conversion]
    end

    test "get_currency_conversion!/1 returns the currency_conversion with given id" do
      currency_conversion = currency_conversion_fixture()
      assert MoneyExchange.get_currency_conversion!(currency_conversion.id) == currency_conversion
    end

    test "create_currency_conversion/1 with valid data creates a currency_conversion" do
      valid_attrs = %{source_currency: "some source_currency", target_currency: "some target_currency", source_amount: 120.5, target_amount: 120.5}

      assert {:ok, %CurrencyConversion{} = currency_conversion} = MoneyExchange.create_currency_conversion(valid_attrs)
      assert currency_conversion.source_currency == "some source_currency"
      assert currency_conversion.target_currency == "some target_currency"
      assert currency_conversion.source_amount == 120.5
      assert currency_conversion.target_amount == 120.5
    end

    test "create_currency_conversion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MoneyExchange.create_currency_conversion(@invalid_attrs)
    end

    test "update_currency_conversion/2 with valid data updates the currency_conversion" do
      currency_conversion = currency_conversion_fixture()
      update_attrs = %{source_currency: "some updated source_currency", target_currency: "some updated target_currency", source_amount: 456.7, target_amount: 456.7}

      assert {:ok, %CurrencyConversion{} = currency_conversion} = MoneyExchange.update_currency_conversion(currency_conversion, update_attrs)
      assert currency_conversion.source_currency == "some updated source_currency"
      assert currency_conversion.target_currency == "some updated target_currency"
      assert currency_conversion.source_amount == 456.7
      assert currency_conversion.target_amount == 456.7
    end

    test "update_currency_conversion/2 with invalid data returns error changeset" do
      currency_conversion = currency_conversion_fixture()
      assert {:error, %Ecto.Changeset{}} = MoneyExchange.update_currency_conversion(currency_conversion, @invalid_attrs)
      assert currency_conversion == MoneyExchange.get_currency_conversion!(currency_conversion.id)
    end

    test "delete_currency_conversion/1 deletes the currency_conversion" do
      currency_conversion = currency_conversion_fixture()
      assert {:ok, %CurrencyConversion{}} = MoneyExchange.delete_currency_conversion(currency_conversion)
      assert_raise Ecto.NoResultsError, fn -> MoneyExchange.get_currency_conversion!(currency_conversion.id) end
    end

    test "change_currency_conversion/1 returns a currency_conversion changeset" do
      currency_conversion = currency_conversion_fixture()
      assert %Ecto.Changeset{} = MoneyExchange.change_currency_conversion(currency_conversion)
    end
  end
end
