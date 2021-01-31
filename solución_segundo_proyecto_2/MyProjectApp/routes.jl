using Genie.Router
using Genie.Renderer.Html, Genie.Requests
using BooksController

route("/") do
  serve_static_file("welcome.html")
end

route("/name", method = POST) do
    "Felicidades $(postpayload(:name, "joven anónimo"))"
end

route("/mfbooks", BooksController.myfavoritebooks)

route("/api/v1/mfbooks", BooksController.API.myfavoritebooks)
