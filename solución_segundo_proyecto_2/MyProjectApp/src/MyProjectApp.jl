module MyProjectApp

using Genie, Logging, LoggingExtras

function main()
  Base.eval(Main, :(const UserApp = MyProjectApp))

  Genie.genie(; context = @__MODULE__)

  Base.eval(Main, :(const Genie = MyProjectApp.Genie))
  Base.eval(Main, :(using Genie))
end

end
