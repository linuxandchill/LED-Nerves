defmodule LedBlink do
  use Application
  require Logger
  alias Nerves.Leds

  @on_time 500
  @off_time 500

   def start(_type, _args) do
    led_list = Application.get_env(:rpi3_led_blink, :led_list)
    Logger.debug "list of leds to blink is #{inspect led_list}"
    Enum.each(led_list, &start_blink(&1))
    {:ok, self}
  end

  defp start_blink(led_key) do
    Logger.debug "blinking led #{inspect led_key}"
    Leds.set [{
      led_key,
      [
        trigger: "timer",
        delay_off: @off_time,
        delay_on: @on_time
      ]
    }]
  end

  
end
