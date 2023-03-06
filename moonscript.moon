err, warn, info, log = luatexbase.provides_module
  name:         "moonscript",
  version:      "0.1",  --MOONSCRIPT_VERSION
  date:         "2023/03/06",  --MOONSCRIPT_DATE
  description:  "Module moonscript.",
  author:       "jperon",
  copyright:    "2022-2023 - jperon",
  license:      "MIT"

import concat, insert, remove from table
import loadstring from require"moonscript.base"

moonscript = =>
  loadstring(@)!

local _code
begin_buffenv = (env) ->
  _code = {}
  luatexbase.add_to_callback 'process_input_buffer',
    =>
      insert _code, @
      '' if not @find "\\end[{]?#{env}[}]?",
    'readline'

end_buffenv = ->
  luatexbase.remove_from_callback 'process_input_buffer', 'readline'
  remove _code
  moonscript concat _code, '\n'

:moonscript, :begin_buffenv, :end_buffenv, :loadstring
