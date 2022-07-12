defmodule Melp.Repo.Migrations.AddGeomToRestaurants do
  use Ecto.Migration

  def change do


    execute "CREATE EXTENSION IF NOT EXISTS postgis;"

    alter table(:restaurants) do
      add :geom,     :geometry
    end
  end
end
