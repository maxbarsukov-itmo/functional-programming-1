ESpec.configure fn(config) ->
  config.formatters [
    {ESpec.Formatters.Json, %{out_path: "cover/espec/results.json"}},
    {ESpec.Formatters.Html, %{out_path: "cover/espec/results.html"}},
    {ESpec.Formatters.Doc, %{diff_enabled?: false}}
  ]
end
