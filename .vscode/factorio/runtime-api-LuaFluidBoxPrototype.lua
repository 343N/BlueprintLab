---@meta
---@diagnostic disable

--$Factorio 1.1.69
--$Overlay 5
--$Section LuaFluidBoxPrototype
-- This file is automatically generated. Edits will be overwritten.

---A prototype of a fluidbox owned by some [LuaEntityPrototype](https://lua-api.factorio.com/latest/LuaEntityPrototype.html).
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html)
---@class LuaFluidBoxPrototype:LuaObject
---[R]
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.base_area)
---@field base_area double 
---[R]
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.base_level)
---@field base_level double 
---[R]  
---The entity that this belongs to.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.entity)
---@field entity LuaEntityPrototype 
---[R]  
---The filter, if any is set.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.filter)
---@field filter? LuaFluidPrototype 
---[R]
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.height)
---@field height double 
---[R]  
---The index of this fluidbox prototype in the owning entity.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.index)
---@field index uint 
---[R]  
---The maximum temperature, if any is set.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.maximum_temperature)
---@field maximum_temperature? double 
---[R]  
---The minimum temperature, if any is set.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.minimum_temperature)
---@field minimum_temperature? double 
---[R]  
---The class name of this object. Available even when `valid` is false. For LuaStruct objects it may also be suffixed with a dotted path to a member of the struct.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.object_name)
---@field object_name string 
---[R]  
---The pipe connection points.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.pipe_connections)
---@field pipe_connections FluidBoxConnection[] 
---[R]  
---The production type. "input", "output", "input-output", or "none".
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.production_type)
---@field production_type string 
---[R]  
---The render layer.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.render_layer)
---@field render_layer string 
---[R]  
---The secondary draw orders for the 4 possible connection directions.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.secondary_draw_orders)
---@field secondary_draw_orders int[] 
---[R]  
---Is this object valid? This Lua object holds a reference to an object within the game engine. It is possible that the game-engine object is removed whilst a mod still holds the corresponding Lua object. If that happens, the object becomes invalid, i.e. this attribute will be `false`. Mods are advised to check for object validity if any change to the game state might have occurred between the creation of the Lua object and its access.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.valid)
---@field valid boolean 
---[R]
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.volume)
---@field volume double 
local LuaFluidBoxPrototype={
---All methods and properties that this object supports.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaFluidBoxPrototype.html#LuaFluidBoxPrototype.help)
---@return string
help=function()end,
}


