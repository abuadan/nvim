-- Java (jdtls) tuning for large Gradle monorepos such as Starling's `platform`
-- (~2200 Gradle projects). Builds on LazyVim's `lang.java` extra.
--
-- The single biggest win is NOT importing the whole build: scope it with
-- `platform-scope <service>` (see ~/.local/bin/platform-scope, not tracked in dotfiles, and platform/docs/PARTIAL_INTELLIJ_IMPORTS.md),
-- which writes .projects/include.txt. jdtls drives Gradle, so it honours that scope.

-- First existing JDK home from a list of candidates.
local function first_dir(candidates)
  for _, dir in ipairs(candidates) do
    if vim.uv.fs_stat(dir) then
      return dir
    end
  end
end

local brew = "/opt/homebrew/opt"
local jdk21 = first_dir({
  brew .. "/openjdk@21/libexec/openjdk.jdk/Contents/Home",
  "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
})
local jdk25 = first_dir({ brew .. "/openjdk@25/libexec/openjdk.jdk/Contents/Home" })

-- Registers a JDK with jdtls only if it is installed.
local function runtimes()
  local list = {}
  if jdk21 then
    table.insert(list, { name = "JavaSE-21", path = jdk21, default = true })
  end
  if jdk25 then
    table.insert(list, { name = "JavaSE-25", path = jdk25 })
  end
  return list
end

return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  opts = function(_, opts)
    -- 'opts.cmd' is LazyVim's jdtls wrapper invocation ({ "<mason>/bin/jdtls", ... }).
    -- That wrapper only accepts JVM flags via a repeatable --jvm-arg=<flag> option; a bare
    -- "-Xmx8G" lands after "-jar ... -data ..." as an ignored program argument.
    -- JDTLS_FULL=1 nvim  -> importing the whole platform build (see `platform-scope --all`)
    -- JDTLS_XMX=10G nvim -> explicit override
    local xmx = vim.env.JDTLS_XMX or (vim.env.JDTLS_FULL and "12G" or "8G")
    local jvm_args = {
      "-Xmx" .. xmx, -- default jdtls heap is far too small for a large project
      "-Xms1G",
      "-XX:+UseG1GC",
      "-XX:ReservedCodeCacheSize=512m",
    }
    for _, arg in ipairs(jvm_args) do
      table.insert(opts.cmd, string.format("--jvm-arg=%s", arg))
    end

    -- Run jdtls itself on JDK 21 regardless of what `java` on PATH is (currently 27).
    if jdk21 then
      table.insert(opts.cmd, "--java-executable=" .. jdk21 .. "/bin/java")
    end

    -- Per-checkout workspace: `platform/platform` would otherwise always be named
    -- "platform", so every worktree would share (and corrupt) one index.
    -- Keep in sync with the cache path in ~/.local/bin/platform-scope.
    opts.project_name = function(root_dir)
      if not root_dir then
        return nil
      end
      local parent = vim.fs.basename(vim.fs.dirname(root_dir))
      return parent .. "_" .. vim.fs.basename(root_dir)
    end

    -- Always root at the Gradle build (settings.gradle[.kts]); never fall back to .git, which
    -- for platform is one directory above the Gradle root.
    opts.root_dir = function(path)
      return vim.fs.root(path, { "settings.gradle.kts", "settings.gradle", "gradlew" })
        or vim.fs.root(path, { "pom.xml", "build.gradle.kts", "build.gradle", ".git" })
    end

    -- Don't scan for main classes on huge projects (nvim-dap "performance killer").
    opts.dap_main = false

    -- Optional machine-local overrides (lua/local/jdtls.lua, git-excluded).
    local ok, localcfg = pcall(require, "local.jdtls")
    localcfg = ok and localcfg or {}

    opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
      java = {
        imports = {
          gradle = { wrapper = { checksums = localcfg.wrapper_checksums or {} } },
        },
        configuration = {
          runtimes = runtimes(),
        },
        import = {
          gradle = {
            enabled = true,
            wrapper = { enabled = true },
            -- platform sets org.gradle.isolated-projects=true, which rejects the init scripts
            -- jdtls injects ("cannot access Project.afterEvaluate on subprojects via allprojects").
            -- Turn it off for the editor import only; real builds are unaffected.
            arguments = "-Dorg.gradle.isolated-projects=false",
            -- JVM that runs Gradle for the import; the build itself fetches its own toolchains.
            java = { home = jdk21 },
          },
          -- Don't let jdtls write .project/.classpath/.settings into every module.
          generatesMetadataFilesAtProjectRoot = false,
          exclusions = {
            "**/node_modules/**",
            "**/.metadata/**",
            "**/archetype-resources/**",
            "**/META-INF/maven/**",
            "**/build/**",
            "**/.gradle/**",
          },
        },
        -- Only compile on demand (:lua require("jdtls").compile("incremental")); open buffers
        -- still get live diagnostics. A full autobuild on a monorepo pegs the CPU.
        autobuild = { enabled = false },
        maxConcurrentBuilds = 1,
        eclipse = { downloadSources = false },
        maven = { downloadSources = false },
        referencesCodeLens = { enabled = false },
        implementationsCodeLens = { enabled = false },
        signatureHelp = { enabled = true },
        completion = { maxResults = 50 },
        -- Eclipse's formatter doesn't match the project's style (spotless/ktlint).
        format = { enabled = false },
        project = {
          resourceFilters = { "node_modules", "\\.git", "\\.gradle" },
        },
      },
    })

    -- jdtls reads its *initial* preferences (including the Gradle wrapper trust list) from
    -- initializationOptions.settings; settings sent only via didChangeConfiguration arrive after
    -- the first import has already been refused. Send them both ways.
    opts.jdtls = function(config)
      config.init_options = config.init_options or {}
      config.init_options.settings = config.settings
      return config
    end

    return opts
  end,
  init = function()
    -- Warn once per checkout when jdtls is about to import every platform project.
    local warned = {}
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      group = vim.api.nvim_create_augroup("platform-full-import-warning", { clear = true }),
      callback = function(args)
        local root = vim.fs.root(args.buf, { "settings.gradle.kts", "settings.gradle" })
        if not root or warned[root] or vim.env.JDTLS_FULL or not vim.uv.fs_stat(root .. "/settings-dependencies.txt") then
          return
        end
        warned[root] = true
        if not vim.uv.fs_stat(root .. "/.projects/generated/include_with_dependencies.txt") then
          vim.notify(
            "jdtls will import the FULL platform build (thousands of projects).\n"
              .. "Scope it first: platform-scope <service> -c, then ./gradlew :projectsIncludeWithDependencies",
            vim.log.levels.WARN,
            { title = "jdtls" }
          )
        end
      end,
    })
  end,
}
