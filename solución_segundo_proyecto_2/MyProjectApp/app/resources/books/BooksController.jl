# BooksController.jl
module BooksController
    # Build something great
    using Genie.Renderer.Html, SearchLight, Books

    function myfavoritebooks()
        html(:books, :myfavoritebooks, layout = :admin , books = all(Book))
    end

    module API
        using ..BooksController
        using Genie.Renderer.Json, SearchLight, Books

        function myfavoritebooks()
          json(:books, :myfavoritebooks, books = all(Book))
        end
    end
end
