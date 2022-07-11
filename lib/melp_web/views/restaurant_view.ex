defmodule MelpWeb.RestaurantView do
  use MelpWeb, :view
  alias MelpWeb.RestaurantView

  def render("index.json", %{restaurants: restaurants}) do
    %{data: render_many(restaurants, RestaurantView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{data: render_one(restaurant, RestaurantView, "restaurant.json")}
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{
      id: restaurant.id,
      rating: restaurant.rating,
      name: restaurant.name,
      site: restaurant.site,
      email: restaurant.email,
      phone: restaurant.phone,
      street: restaurant.street,
      city: restaurant.city,
      state: restaurant.state,
      lat: restaurant.lat,
      lng: restaurant.lng,
      geom: restaurant.geom
    }
  end
end
