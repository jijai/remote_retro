defmodule RemoteRetroWeb.GroupHandlers do
  alias RemoteRetro.{Repo, Group}

  import Phoenix.Channel
  import ShorterMaps

  @group_edited "group_edited"

  def handle_in(@group_edited, ~m{id,label}, socket) do
    Repo.transaction fn ->
      group =
        Group
        |> Repo.get!(id)
        |> Group.changeset(~M{label})
        |> Repo.update!()

      broadcast!(socket, @group_edited, group)
    end

    {:reply, :ok, socket}
  rescue
    exception ->
      Honeybadger.notify(exception, metadata: %{handler: @group_edited}, stacktrace: __STACKTRACE__)
      {:reply, :error, socket}
  end
end
