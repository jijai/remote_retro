defmodule RemoteRetro.Group do
  use RemoteRetroWeb, :model

  @derive {Jason.Encoder, except: [:__meta__, :ideas]}
  schema "groups" do
    has_many(:ideas, RemoteRetro.Idea)

    field(:label, :string, default: "")

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:label])
  end
end
