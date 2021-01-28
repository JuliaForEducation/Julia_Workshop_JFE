using Genie.Router
using BooksController

route("/") do
  serve_static_file("welcome.html")
end

route("/mfbooks", BooksController.myfavoritebooks)

route("/api/v1/mfbooks", BooksController.API.myfavoritebooks)
