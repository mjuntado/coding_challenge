defmodule CodingChallengeWeb.ErrorJSONTest do
  use CodingChallengeWeb.ConnCase, async: true

  test "renders 404" do
    assert CodingChallengeWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert CodingChallengeWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
