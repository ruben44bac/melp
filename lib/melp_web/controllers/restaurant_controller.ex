defmodule MelpWeb.RestaurantController do
  use MelpWeb, :controller

  alias Melp.Restaurants
  alias Melp.Restaurants.Restaurant

  action_fallback MelpWeb.FallbackController

  def index(conn, _params) do
    restaurants = Restaurants.list_restaurants()
    render(conn, "index.json", restaurants: restaurants)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    with {:ok, %Restaurant{} = restaurant} <- Restaurants.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.restaurant_path(conn, :show, restaurant))
      |> render("show.json", restaurant: restaurant)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant!(id)
    render(conn, "show.json", restaurant: restaurant)
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Restaurants.get_restaurant!(id)

    with {:ok, %Restaurant{} = restaurant} <- Restaurants.update_restaurant(restaurant, restaurant_params) do
      render(conn, "show.json", restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant!(id)

    with {:ok, %Restaurant{}} <- Restaurants.delete_restaurant(restaurant) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_restaurants_in_area(conn, %{"latitud" => lat, "longitud" => lng, "radio" => radio}) do
    with lat <- Decimal.new(lat),
      lat <- Decimal.to_float(lat),
      lng <- Decimal.new(lng),
      lng <- Decimal.to_float(lng),
      radio <- Decimal.new(radio),
      radio <- Decimal.to_float(radio),
      restaurants <- Restaurants.get_restaurants_in_area(lat, lng, radio) do
        render(conn, "index.json", restaurants: restaurants)
    end
  end

end
