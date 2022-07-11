defmodule Melp.Restaurants do
  @moduledoc """
  The Restaurants context.
  """

  import Ecto.Query, warn: false
  alias Melp.Repo
  alias Melp.Restaurants.Restaurant

  NimbleCSV.define(MyParser, separator: ",", escape: "\"")

  @doc """
  Returns the list of restaurants.

  ## Examples

      iex> list_restaurants()
      [%Restaurant{}, ...]

  """
  def list_restaurants do
    Repo.all(Restaurant)
  end

  @doc """
  Gets a single restaurant.

  Raises `Ecto.NoResultsError` if the Restaurant does not exist.

  ## Examples

      iex> get_restaurant!(123)
      %Restaurant{}

      iex> get_restaurant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_restaurant!(id), do: Repo.get!(Restaurant, id)

  @doc """
  Creates a restaurant.

  ## Examples

      iex> create_restaurant(%{field: value})
      {:ok, %Restaurant{}}

      iex> create_restaurant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_restaurant(attrs \\ %{}) do
    %Restaurant{}
    |> Restaurant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a restaurant.

  ## Examples

      iex> update_restaurant(restaurant, %{field: new_value})
      {:ok, %Restaurant{}}

      iex> update_restaurant(restaurant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_restaurant(%Restaurant{} = restaurant, attrs) do
    restaurant
    |> Restaurant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a restaurant.

  ## Examples

      iex> delete_restaurant(restaurant)
      {:ok, %Restaurant{}}

      iex> delete_restaurant(restaurant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_restaurant(%Restaurant{} = restaurant) do
    Repo.delete(restaurant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking restaurant changes.

  ## Examples

      iex> change_restaurant(restaurant)
      %Ecto.Changeset{data: %Restaurant{}}

  """
  def change_restaurant(%Restaurant{} = restaurant, attrs \\ %{}) do
    Restaurant.changeset(restaurant, attrs)
  end

  def read_csv() do
    __DIR__
    |> Path.join("restaurantes.csv")
    |> File.stream!
    |> MyParser.parse_stream
    |> Stream.map(fn [id, rating, name, site, email, phone, street, city, state, lat, lng] ->
      Map.new
      |> Map.put("id", Ecto.UUID.dump!(id))
      |> Map.put("rating", rating)
      |> Map.put("name", name)
      |> Map.put("site", site)
      |> Map.put("email", email)
      |> Map.put("phone", phone)
      |> Map.put("street", street)
      |> Map.put("city", city)
      |> Map.put("state", state)
      |> Map.put("lat", String.to_float(lat))
      |> Map.put("lng", String.to_float(lng))
    end)
    |> Enum.to_list()
    |> Enum.map(fn r -> create_restaurant(r) end)
  end

end
