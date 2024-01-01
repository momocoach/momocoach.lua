# momo.coach.lua

A neovim plugin to interact with [momo.coach](https://momo.coach)

## Install


``` lua
return {
  "momocoach/momo.coach.lua"
}
```

### Authentification

Run `:Momo auth your_client_id your_secret_key` to store your credentials.

### Stop watch

Run `:Momo stopwatch start` to start the stop watch

Run `:Momo stopwatch` to get the current stop watch value

Run `:Momo stopwatch pause` to pause the stop watch

Run `:Momo stopwatch stop` to stop and reset the stopwatch.

### Create Timelog with current stop watch value

Run `:Momo timelog stopwatch 'your client or project' description`

### Create Timelog

Run `:Momo timelog create 01:11 'your client or project' description`

