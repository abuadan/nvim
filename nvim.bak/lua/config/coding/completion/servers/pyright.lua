local lsputils = require "lspconfig.utils"
return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "off",
      },
    },
  },
  root_dir = lsputils.root_pattern { ".git", "pyporject.toml", "requirements.txt" },
}
