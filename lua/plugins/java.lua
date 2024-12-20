-- local home = os.getenv("HOME")
-- local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- local workspace_dir = workspace_path .. project_name
-- local os_config = "linux"
-- if vim.fn.has("mac") == 1 then
--   os_config = "mac"
-- end
-- local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config
--
-- -- Define the arguments to increase RAM and potentially improve performance
-- local extended_jvm_args = {
--   "-XX:+UseParallelGC", -- Optional: Use parallel garbage collector for performance
--   -- Add any other standard jdtls arguments here
--   -- "-Xms512m", -- Initial heap size (optional, but good practice)
--   "-Xmx4G", -- 💀 MAXIMUM heap size (e.g., 4 Gigabytes)
--   "server",
--   "Xms8192m",
--   "Xmx12288m",
--   "XX:ReservedCodeCacheSize=512m",
--   "XX:+UseG1GC",
--   "XX:SoftRefLRUPolicyMSPerMB=50",
--   "ea",
--   "Dsun.io.useCanonCaches=false",
--   "Djava.net.preferIPv4Stack=true",
--   "XX:-OmitStackTraceInFastThrow",
-- }
--
-- -- Combine existing cmd arguments with the extended JVM arguments
-- local cmd = {
--   "java",
--   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--   "-Dosgi.bundles.defaultStartLevel=4",
--   "-Declipse.product=org.eclipse.jdt.ls.core.product",
--   "-Dlog.protocol=true",
--   "-Dlog.level=ERROR",
--   -- "-Xms1g", -- Example initial size, overridden by the above Xms512m if placed later
--   extended_jvm_args,
--   "--add-modules=ALL-SYSTEM",
--   "--add-opens",
--   "java.base/java.util=ALL-UNNAMED",
--   "--add-opens",
--   "java.base/java.util.concurrent=ALL-UNNAMED",
--   "-jar",
--   vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
--   "-configuration",
--   jdtls_path .. "/config_" .. vim.loop.os_uname().sysname:lower(),
--   "-data",
--   workspace_dir,
-- }
--
-- return {
--   "mfussenegger/nvim-jdtls",
--   ft = "java",
--   opts = function(_, opts)
--     opts.cmd = opts.cmd or { vim.fn.exepath("jdtls") }
--     table.insert(opts.cmd, 2, cmd)
--     -- jdtl = {
--     -- cmd = cmd,
--     -- {
--     --     "java",
--     --     "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--     --     "-Dosgi.bundles.defaultStartLevel=4",
--     --     "-Declipse.product=org.eclipse.jdt.ls.core.product",
--     --     "-Dlog.protocol=true",
--     --     "-Dlog.level=ALL",
--     --     "-Xms1g",
--     --     "--add-modules=ALL-SYSTEM",
--     --     "--add-opens",
--     --     "java.base/java.util=ALL-UNNAMED",
--     --     "--add-opens",
--     --     "java.base/java.lang=ALL-UNNAMED",
--     --     "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
--     --     "-jar",
--     --     vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
--     --     "-configuration",
--     --     home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config,
--     --     "-data",
--     --     workspace_dir,
--     --   },
--     -- }
--   end,
-- }
--
-- local home = os.getenv("HOME")
-- local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- local workspace_dir = workspace_path .. project_name
-- local os_config = "linux"
-- if vim.fn.has("mac") == 1 then
--   os_config = "mac"
-- end
-- local jdtls_config_dir = home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config
--
-- -- Define the arguments to increase RAM and potentially improve performance
-- -- Ensure these are simple strings without redundant entries
-- local jvm_memory_args = {
--   "-Xmx4G", -- MAXIMUM heap size (e.g., 4 Gigabytes)
--   "-Xms1G", -- Initial heap size
--   "-XX:+UseG1GC", -- Use G1 garbage collector
--   "-XX:ReservedCodeCacheSize=512m",
--   "-XX:SoftRefLRUPolicyMSPerMB=50",
--   "-ea",
--   "-Dsun.io.useCanonCaches=false",
--   "-Djava.net.preferIPv4Stack=true",
--   "-XX:-OmitStackTraceInFastThrow",
-- }
--
-- -- The base arguments for launching the server
-- local base_args = {
--   "java",
--   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--   "-Dosgi.bundles.defaultStartLevel=4",
--   "-Declipse.product=org.eclipse.jdt.ls.core.product",
--   "-Dlog.protocol=true",
--   "-Dlog.level=ERROR",
--   "--add-modules=ALL-SYSTEM",
--   "--add-opens",
--   "java.base/java.util=ALL-UNNAMED",
--   "--add-opens",
--   "java.base/java.util.concurrent=ALL-UNNAMED",
--   "-jar",
--   -- Resolve the exact path to the launcher JAR
--   vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
--   "-configuration",
--   jdtls_config_dir,
--   "-data",
--   workspace_dir,
-- }
--
-- -- Combine the two lists into the final 'cmd' table
-- -- We use vim.list_extend to properly merge the tables.
-- local cmd = {}
-- vim.list_extend(cmd, jvm_memory_args) -- Add memory args first
-- vim.list_extend(cmd, base_args) -- Append the rest of the arguments
--
-- -- Optional: If you use Lombok via Mason, uncomment and adjust this line.
-- -- table.insert(cmd, 2, "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar")
--
-- -- This table is ready to be passed to require('jdtls').start_or_attach(config)
-- -- If using LazyVim's structure, you would assign 'cmd' to opts.cmd in your plugin definition.
--
-- -- Example of how to use this within a complete manual Neovim setup:
-- -- require('jdtls').start_or_attach({
-- --     cmd = cmd,
-- --     root_dir = require('jdtls.internal').root_dir,
-- --     -- settings = { ... other jdtls settings ... }
-- -- })
--
-- -- If using this file inside LazyVim via lua/plugins/java-custom.lua:
-- return {
--   "mfussenegger/nvim-jdtls",
--   ft = "java",
--   opts = function(_, opts)
--     opts.cmd = cmd -- Assign the complete, correct command list
--     return opts
--   end,
-- }
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  opts = function(_, opts)
    -- 'opts.cmd' is provided by LazyVim's Java extra.
    -- We are extending this command list, not replacing it entirely.

    local custom_jvm_args = {
      "-Xmx4G", -- Set maximum RAM to 4GB
      "-Xms1G", -- Set initial RAM to 1GB
      "-XX:+UseG1GC", -- Use G1 garbage collector
      "-XX:ReservedCodeCacheSize=512m",
      -- Add other specific args here if needed
      --   "-XX:+UseParallelGC", -- Optional: Use parallel garbage collector for performance
      -- Add any other standard jdtls arguments here
      -- "-Xms512m", -- Initial heap size (optional, but good practice)
      "-Xmx4G", -- 💀 MAXIMUM heap size (e.g., 4 Gigabytes)
      "server",
      "Xms8192m",
      "Xmx12288m",
      "XX:ReservedCodeCacheSize=512m",
      "XX:+UseG1GC",
      "XX:SoftRefLRUPolicyMSPerMB=50",
      "ea",
      "Dsun.io.useCanonCaches=false",
      "Djava.net.preferIPv4Stack=true",
      "XX:-OmitStackTraceInFastThrow",
    }

    -- Insert the JVM arguments into the 'cmd' list.
    -- These MUST be positioned before the '-jar' argument in the list.
    -- The default LazyVim cmd starts with {"java", ...}

    -- We can prepend our args right after the initial "java" entry
    -- for i = 1, #custom_jvm_args do
    -- table.insert(opts.full_cmd, 2, custom_jvm_args[i])
    -- end
    vim.list_extend(opts.cmd, custom_jvm_args)
    -- Optional: If you need Lombok support with Mason:
    -- local home = os.getenv("HOME")
    -- table.insert(opts.cmd, 2, "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar")

    -- Ensure 'root_dir' is set if it somehow gets lost (LazyVim usually handles this):
    -- if not opts.root_dir then
    --   opts.root_dir = require("jdtls.internal").root_dir
    -- end

    return opts -- Return the modified options table to LazyVim
  end,
}
