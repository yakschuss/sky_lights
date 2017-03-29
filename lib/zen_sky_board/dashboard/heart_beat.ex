defmodule ZenSkyBoard.Dashboard.HeartBeat do
  use GenServer

  def start_link(light) do
    GenServer.start_link(__MODULE__, light)
  end

  def init(light) do
    schedule_check()
    {:ok, light}
  end

  def handle_info(:check, light) do
    check_light_activity(light)
    schedule_check()
    {:noreply, light}
  end

  def handle_call(:update, light) do
    #update expire_time to + 30 secs
  end

  defp schedule_check() do
    Process.send_after(self(), :check, 30000)
  end

  defp check_light_activity(light) do
    case expired?(light)
      -> false
        schedule_check()
      -> true
        #destroy light
        #terminate/2
  end

  defp expired?(light) do
    # NaiveDateTime.diff(light.expire_time, DateTime.to_naive(DateTime.utc.now)) > 30

    {:ok, time} = DateTime.from_naive(light.expire_time, "Etc/UTC")

    (DateTime.to_unix(time) - DateTime.to_unix(DateTime.utc_now)) > 30
  end

end
