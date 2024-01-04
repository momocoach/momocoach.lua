# momocoach.lua

A neovim plugin to interact with [momo.coach](https://momo.coach)

## Install

for example with lazy.nvim

``` lua
return {
  "momocoach/momocoach.lua"
}
```

### Authentification

Create a secret key and a client_id in the user section of [momo.coach](https://momo.coach)

Run `:Momo auth signin your_client_id your_secret_key` to store your credentials.

Run `:Momo auth signout` to remove your credentials.

### Stop watch

Run `:Momo stopwatch` to get the current stop watch value

Run `:Momo stopwatch start` to start the stop watch

Run `:Momo stopwatch pause` to pause the stop watch

Run `:Momo stopwatch stop` to stop and reset the stopwatch.

### Create Timelog with current stop watch value on current date

Run `:Momo timelog stopwatch your_client_or_project your super log description`

### Create Timelog on current date

Run `:Momo timelog create 01:11 your_client_or_project your super log description`

