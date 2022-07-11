defmodule Melp.Restaurants.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "restaurants" do
    field :city, :string
    field :email, :string
    field :lat, :float
    field :lng, :float
    field :name, :string
    field :phone, :string
    field :rating, :integer
    field :site, :string
    field :state, :string
    field :street, :string

  end

  @doc false
  def changeset_create(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:id, :rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng])
    |> validate_required([:rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng])
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng])
    |> validate_required([:rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng])
  end
end
