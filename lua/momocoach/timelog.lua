local M = {}

local function echo(message)
  vim.cmd('echom "[Momocoach] ' .. tostring(message):gsub('"', '\\"') .. '"')
end

function M.create(params)
  echo("TODO create " .. table.concat(params, ', '))
end

function M.stopwatch()
  echo("TODO stopwatch")
end

return M
