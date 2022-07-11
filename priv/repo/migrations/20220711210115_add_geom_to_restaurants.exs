defmodule Melp.Repo.Migrations.AddGeomToRestaurants do
  use Ecto.Migration

  def change do
    alter table(:restaurants) do
      add :geom,     :geometry
    end
  end
end
