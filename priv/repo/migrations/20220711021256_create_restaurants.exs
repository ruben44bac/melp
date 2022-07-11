defmodule Melp.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :rating, :integer
      add :name, :string
      add :site, :string
      add :email, :string
      add :phone, :string
      add :street, :string
      add :city, :string
      add :state, :string
      add :lat, :float
      add :lng, :float
    end
  end
end
