# BooksController.jl
module BooksController
    # Build something great
    using Genie.Renderer.Html
    struct Book
        title::String
        author::String
    end

    const MyFavoriteBooks = Book[
        Book("Antes de Partir","Jessica Warman")
        Book("Los Brujos de Ilamatepeque","Ramón Amaya")
        Book("Angelina", "Carlos F. Gutiérrez")
        Book("Vampiros","Froylán Turcios")
        Book("365 Dias Para Ser Mas Culto","David S. Kidder")
        Book("Ulises","James Joyce")
    ]

    function myfavoritebooks()
        html(:books, :myfavoritebooks, layout = :admin , books = BooksController.MyFavoriteBooks)
    end

    module API

    using ..BooksController
    using Genie.Renderer.Json

    function myfavoritebooks()
      json(:books, :myfavoritebooks, books = BooksController.MyFavoriteBooks)
    end

    end

end
