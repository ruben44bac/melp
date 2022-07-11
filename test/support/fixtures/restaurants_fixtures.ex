defmodule Melp.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Melp.Restaurants` context.
  """

  @doc """
  Generate a restaurant.
  """
  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
        city: "some city",
        email: "some email",
        id: "7488a646-e31f-11e4-aace-600308960662",
        lat: 120.5,
        lng: 120.5,
        name: "some name",
        phone: "some phone",
        rating: 42,
        site: "some site",
        state: "some state",
        street: "some street"
      })
      |> Melp.Restaurants.create_restaurant()

    restaurant
  end
end
