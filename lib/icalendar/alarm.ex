defmodule ICalendar.Alarm do

  defstruct trigger: nil,
            repeat: 0,
            duration: nil,
            action: "DISPLAY",
            description: ""

end

defimpl ICalendar.Serialize, for: ICalendar.Alarm do
  alias ICalendar.Util.KV

  def to_ics(event, _options \\ []) do
    contents = to_kvs(event)

    """
    BEGIN:VALARM
    #{contents}END:VALARM
    """
  end

  defp to_kvs(event) do
    event
    |> Map.from_struct()
    |> Enum.map(&to_kv/1)
    |> List.flatten()
    |> Enum.sort()
    |> Enum.join()
  end

  defp to_kv({key, value}) do
    key
    |> to_string()
    |> String.upcase()
    |> KV.build(value)
  end
end
