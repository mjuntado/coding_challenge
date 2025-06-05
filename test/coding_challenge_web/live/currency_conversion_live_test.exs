defmodule CodingChallengeWeb.CurrencyConversionLiveTest do
  use CodingChallengeWeb.ConnCase

  import Phoenix.LiveViewTest
  import CodingChallenge.MoneyExchangeFixtures

  @create_attrs %{source_currency: "some source_currency", target_currency: "some target_currency", source_amount: 120.5, target_amount: 120.5}
  @update_attrs %{source_currency: "some updated source_currency", target_currency: "some updated target_currency", source_amount: 456.7, target_amount: 456.7}
  @invalid_attrs %{source_currency: nil, target_currency: nil, source_amount: nil, target_amount: nil}

  defp create_currency_conversion(_) do
    currency_conversion = currency_conversion_fixture()
    %{currency_conversion: currency_conversion}
  end

  describe "Index" do
    setup [:create_currency_conversion]

    test "lists all currency_conversions", %{conn: conn, currency_conversion: currency_conversion} do
      {:ok, _index_live, html} = live(conn, ~p"/currency_conversions")

      assert html =~ "Listing Currency conversions"
      assert html =~ currency_conversion.source_currency
    end

    test "saves new currency_conversion", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/currency_conversions")

      assert index_live |> element("a", "New Currency conversion") |> render_click() =~
               "New Currency conversion"

      assert_patch(index_live, ~p"/currency_conversions/new")

      assert index_live
             |> form("#currency_conversion-form", currency_conversion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#currency_conversion-form", currency_conversion: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/currency_conversions")

      html = render(index_live)
      assert html =~ "Currency conversion created successfully"
      assert html =~ "some source_currency"
    end

    test "updates currency_conversion in listing", %{conn: conn, currency_conversion: currency_conversion} do
      {:ok, index_live, _html} = live(conn, ~p"/currency_conversions")

      assert index_live |> element("#currency_conversions-#{currency_conversion.id} a", "Edit") |> render_click() =~
               "Edit Currency conversion"

      assert_patch(index_live, ~p"/currency_conversions/#{currency_conversion}/edit")

      assert index_live
             |> form("#currency_conversion-form", currency_conversion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#currency_conversion-form", currency_conversion: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/currency_conversions")

      html = render(index_live)
      assert html =~ "Currency conversion updated successfully"
      assert html =~ "some updated source_currency"
    end

    test "deletes currency_conversion in listing", %{conn: conn, currency_conversion: currency_conversion} do
      {:ok, index_live, _html} = live(conn, ~p"/currency_conversions")

      assert index_live |> element("#currency_conversions-#{currency_conversion.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#currency_conversions-#{currency_conversion.id}")
    end
  end

  describe "Show" do
    setup [:create_currency_conversion]

    test "displays currency_conversion", %{conn: conn, currency_conversion: currency_conversion} do
      {:ok, _show_live, html} = live(conn, ~p"/currency_conversions/#{currency_conversion}")

      assert html =~ "Show Currency conversion"
      assert html =~ currency_conversion.source_currency
    end

    test "updates currency_conversion within modal", %{conn: conn, currency_conversion: currency_conversion} do
      {:ok, show_live, _html} = live(conn, ~p"/currency_conversions/#{currency_conversion}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Currency conversion"

      assert_patch(show_live, ~p"/currency_conversions/#{currency_conversion}/show/edit")

      assert show_live
             |> form("#currency_conversion-form", currency_conversion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#currency_conversion-form", currency_conversion: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/currency_conversions/#{currency_conversion}")

      html = render(show_live)
      assert html =~ "Currency conversion updated successfully"
      assert html =~ "some updated source_currency"
    end
  end
end
