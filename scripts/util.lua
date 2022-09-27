function string.starts(str, substr)
   return string.sub(str, 1, string.len(substr)) == substr
end

function isSingleplayer()
   local s = false
   for k,v in ipairs(game.players) do
      if s == false then
         s = true
      else 
         return false
      end
   end
   
   return true
end