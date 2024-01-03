local math = require('math')
 
local M = {}

function M.echo(message)
  vim.cmd('echom "[Momocoach] ' .. tostring(message):gsub('"', '\\"') .. '"')
end

local mod = function(a,b)
  return a - math.floor(a/b)*b
end

function M.renderTimestamp(time)
  local hours = math.floor(time/3600)
  local minutes = math.floor(mod(time,3600)/60)
  local seconds = math.floor(mod(time,60))
  return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

function M.api(action, ci, sk)
  return 'curl -s https://api.momo.coach/' .. action ..
    ' -H "Accept: application/json" -H "Authorization: Bearer ' .. sk ..
    '" -H "Clientid: ' .. ci .. '" -A "momo.coach_neovim_plugin@1.0.0"'
end

return M
