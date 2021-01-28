module Books

    import SearchLight: AbstractModel, DbId, save!
    import Base: @kwdef

    export Book

    @kwdef mutable struct Book <: AbstractModel
      id::DbId = DbId()
      title::String = ""
      author::String = ""
    end

end
