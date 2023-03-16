defmodule LittilComments.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string
      add :host, :string
      add :path, :string

      timestamps()
    end

    create index(:comments, [:host])
    create index(:comments, [:path])

    create unique_index(:comments, [:host, :path], name: :unique_host_path)
  end
end
