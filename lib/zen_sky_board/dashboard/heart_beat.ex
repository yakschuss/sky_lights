defmodule ZenSkyBoard.Dashboard.HeartBeat do
  use GenServer

  def start_link(uid) do
    GenServer.start_link(__MODULE__, uid)
  end

  def init(uid) do
    schedule_check()
    name = via_tuple(uid)
    state = %{name: name, uid: uid, expire_time: DateTime.utc_now}
    {:ok, state}
  end

  def handle_info(:check, state) do
    check_light_activity(state)
    schedule_check()
    {:noreply, state}
  end

  def handle_cast(:update, state) do
    Map.put(state, :expire_time, DateTime.utc_now)
    {:noreply, state}
  end

  # def handle_call(:stop, state) do
  #   {:stop, :normal}
  # end

  def reset_expiry(uid) do
    GenServer.cast(via_tuple(uid), :update)
  end

  defp schedule_check() do
    Process.send_after(self(), :check, 30000)
  end

  defp check_light_activity(state) do
    case expired?(state[:expire_time]) do
      false ->
        schedule_check()
      true ->
        ZenSkyBoard.Dashboard.get_light_by_uid(state[:uid])
        |> ZenSkyBoard.Dashboard.delete_light

        Process.exit(self(), :kill)
    end
  end

  defp expired?(time) do
    (DateTime.to_unix(DateTime.utc_now) - DateTime.to_unix(time)) > 30
  end

  defp via_tuple(uid) do
    {:via, Registry, {:light_registry, uid}}
  end

end
