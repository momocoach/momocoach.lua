local auth = require("momocoach.auth")
local math = require('math')
local M = {}


local mod = function(a,b)
  return a - math.floor(a/b)*b
end

function disp_time(time)
  local days = math.floor(time/86400)
  local hours = math.floor(mod(time, 86400)/3600)
  local minutes = math.floor(mod(time,3600)/60)
  local seconds = math.floor(mod(time,60))
  return string.format("%d:%02d:%02d:%02d",days,hours,minutes,seconds)
end

local function echo(message)
  vim.cmd('echom "[Momocoach] ' .. tostring(message):gsub('"', '\\"') .. '"')
end

function M.get()
  local userdata = auth.get_cred()
  local sw = vim.json.decode(vim.fn.system('curl -s ' .. ' https://api.momo.coach/stopwatch ' .. ' -H ' .. ' "Accept: application/json" ' .. ' -H ' .. ' "Authorization: Bearer ' .. userdata.secret .. '"' .. ' -H ' ..  ' "Clientid: ' .. userdata.clientid .. '" -A "momo.coach neovim plugin0.0.1"'))
  echo('duration: ' .. disp_time(sw.duration + (vim.fn.localtime()*1000 - sw.timestamp)/1000))
  vim.defer_fn(function() vim.cmd('echo ""') end, 5000)
end

function M.start()
  echo("TODO start")
end

function M.pause()
  echo("TODO pause")
end

function M.stop()
  echo("TODO stop")
end

return M
