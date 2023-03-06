local err, warn, info, log = luatexbase.provides_module({
  name = "moonscript",
  version = "0.1",
  date = "2023/03/06",
  description = "Module moonscript.",
  author = "jperon",
  copyright = "2022-2023 - jperon",
  license = "MIT"
})
local concat, insert, remove
do
  local _obj_0 = table
  concat, insert, remove = _obj_0.concat, _obj_0.insert, _obj_0.remove
end
local loadstring
loadstring = require("moonscript.base").loadstring
local moonscript
moonscript = function(self)
  return loadstring(self)()
end
local _code
local begin_buffenv
begin_buffenv = function(env)
  _code = { }
  return luatexbase.add_to_callback('process_input_buffer', function(self)
    insert(_code, self)
    if not self:find("\\end[{]?" .. tostring(env) .. "[}]?") then
      return ''
    end
  end, 'readline')
end
local end_buffenv
end_buffenv = function()
  luatexbase.remove_from_callback('process_input_buffer', 'readline')
  remove(_code)
  return moonscript(concat(_code, '\n'))
end
return {
  moonscript = moonscript,
  begin_buffenv = begin_buffenv,
  end_buffenv = end_buffenv,
  loadstring = loadstring
}
