module Books

    import SearchLight: AbstractModel, DbId, save!
    import Base: @kwdef

    export Book

    @kwdef mutable struct Book <: AbstractModel
      id::DbId = DbId()
      title::String = ""
      author::String = ""
    end

    function seed()
    MyFavoriteBooks = [
    ("Antes de Partir","Jessica Warman")
    ("Los Brujos de Ilamatepeque","Ramón Amaya")
    ("Angelina", "Carlos F. Gutiérrez")
    ("Vampiros","Froylán Turcios")
    ("365 Dias Para Ser Mas Culto","David S. Kidder")
    ("Ulises","James Joyce")
    ]

    for b in MyFavoriteBooks
        Book(title = b[1], author = b[2]) |> save!
    end
end
