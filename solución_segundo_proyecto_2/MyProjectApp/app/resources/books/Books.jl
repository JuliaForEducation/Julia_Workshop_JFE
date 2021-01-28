module Books

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Book

@kwdef mutable struct Book <: AbstractModel
  id::DbId = DbId()
end

end
