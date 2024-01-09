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


function M.renderTimestampWithoutSecond(time)
  local hours = math.floor(time/3600)
  local minutes = math.floor(mod(time,3600)/60)
  return string.format("%02d:%02d", hours, minutes)
end

function M.api(action, ci, sk)
  return 'curl -s https://api.momo.coach/' .. action ..
    ' -H "Accept: application/json" -H "Authorization: Bearer ' .. sk ..
    '" -H "Clientid: ' .. ci .. '" -A "momo.coach_neovim_plugin@1.1.0"'
end

function M.isValidTimeFormat(str)
  return string.match(str, "^%d%d:%d%d$") ~= nil and
    tonumber(string.sub(str, 1, 2)) <= 23 and
    tonumber(string.sub(str, 4, 5)) <= 59
end

function M.getCurrentDate()
    local date = os.date("*t")
    return string.format("%04d-%02d-%02d", date.year, date.month, date.day)
end

return M
