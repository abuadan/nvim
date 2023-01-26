# Testing

This folder contains a minimal version neovim setup to debug and test any plugin issues, the
configuration is run through;

```shell
nvim --clean -u minimal.lua
```
Update the `lua` file in order to test the offending plugin and provide any plugin maintainers with a minimal configuration setup
