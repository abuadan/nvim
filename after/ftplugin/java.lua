-- In your Neovim jdtls configuration file (e.g., ~/.config/nvim/ftplugin/java.lua)

local jdtls_path = "..." -- 💀 Path to your eclipse.jdt.ls installation
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- Define the arguments to increase RAM and potentially improve performance
local extended_jvm_args = {
  "-Xms512m", -- Initial heap size (optional, but good practice)
  "-Xmx4G", -- 💀 MAXIMUM heap size (e.g., 4 Gigabytes)
  "-XX:+UseParallelGC", -- Optional: Use parallel garbage collector for performance
  -- Add any other standard jdtls arguments here
}

-- Combine existing cmd arguments with the extended JVM arguments
local cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ERROR",
  "-Xms1g", -- Example initial size, overridden by the above Xms512m if placed later
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.util.concurrent=ALL-UNNAMED",
  "-jar",
  vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar", 1),
  "-configuration",
  jdtls_path .. "/config_" .. vim.loop.os_uname().sysname:lower(),
  "-data",
  workspace_dir,
}

-- Ensure the custom arguments are integrated into the command list
-- You might need to adjust where you insert these depending on your exact config structure
-- If you are using `require('jdtls').start(...)`, you pass `cmd` in the options table

-- Example of how the final 'cmd' might look when defined in a single block in a starter config:
-- local config = {
--   cmd = {
--     'java',
--     '-Xms4g', -- Added here
--     '-Xmx8G', -- Added here
--     ... rest of the JDTLS launch command ...
--   },
--   ... other jdtls options ...
-- }
-- require('jdtls').start(config)z
