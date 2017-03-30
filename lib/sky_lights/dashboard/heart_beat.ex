defmodule SkyLights.Dashboard.HeartBeat do
  use GenServer

  def start_link(uid) do
    name = via_tuple(uid)
    GenServer.start_link(__MODULE__, uid, name: name)
  end

  def init(uid) do
    schedule_check()
    state = %{uid: uid, expire_time: DateTime.utc_now}
    {:ok, state}
  end

  def handle_info(:check, state) do
    check_light_activity(state)
    {:noreply, state}
  end

  def handle_cast(:update, state) do
    new_state = Map.put(state, :expire_time, DateTime.utc_now)
    {:noreply, new_state}
  end

  def handle_cast(:stop, state) do
    SkyLights.Dashboard.get_light_by_uid(state[:uid])
    |> SkyLights.Dashboard.delete_light

    SkyLights.Web.DashboardChannel.broadcast_delete(state[:uid])
    {:stop, :normal, state}
  end

  def reset_expiry(uid) do
    GenServer.cast(via_tuple(uid), :update)
  end

  def terminate_process(uid) do
    GenServer.cast(via_tuple(uid), :stop)
  end

  defp schedule_check() do
    Process.send_after(self(), :check, 30000)
  end

  defp check_light_activity(state) do
    case expired?(state[:expire_time]) do
      false ->
        schedule_check()
      true ->
        terminate_process(state[:uid])
    end
  end

  defp expired?(time) do
    (DateTime.to_unix(DateTime.utc_now) - DateTime.to_unix(time)) > 30
  end

  defp via_tuple(uid) do
    {:via, Registry, {:light_registry, uid}}
  end
end
