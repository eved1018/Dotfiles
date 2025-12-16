-- TODO
	-- add way to toggle macro directives, and/or syntax highlight all c code even if "InactiveCode"  
	-- dont load clangd if cant find complile.json + option to set path to compile.json
	-- swet makeprg to use bear and be in the right place
	-- proper colors in quickfix after makeprg 
	-- jump/list todos 
	-- delete unused plugins

-- basic configs
vim.opt.winborder = "rounded"
vim.opt.showmode = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.wildmenu = true
vim.opt.wildoptions = 'pum'
vim.opt.showbreak = '+++'
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.autoindent = true
vim.opt.ruler = true
vim.opt.splitright = true
vim.opt.backspace = "indent,eol,start"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.mouse = 'a'
vim.o.splitbelow = true
vim.opt.splitright = true
vim.cmd([[autocmd FileType * set formatoptions-=cro]])


-- Plugins

-- look into https://github.com/stevearc/oil.nvim
-- look into https://github.com/chentoast/marks.nvim
-- look into https://github.com/folke/todo-comments.nvim/
-- look into https://github.com/folke/trouble.nvim/tree/main

vim.pack.add({
	-- ui 
	{src = 'https://github.com/vague2k/vague.nvim'}, 
	{src = 'https://github.com/nvim-lualine/lualine.nvim'}, 
	{src = 'https://github.com/archibate/lualine-time'},
	{src = 'https://github.com/akinsho/bufferline.nvim'},
	{src = 'https://github.com/RRethy/vim-illuminate'},
	-- file explorer 
	{src = 'https://github.com/echasnovski/mini.pick'},
	{src = 'https://github.com/nvim-tree/nvim-tree.lua'},
	{src = 'https://github.com/airblade/vim-rooter'},
	
	-- lsp 
	{src = 'https://github.com/neovim/nvim-lspconfig'},
	{src = 'https://github.com/mfussenegger/nvim-dap'},
	{src = 'https://github.com/igorlfs/nvim-dap-view'},
	{src = 'https://github.com/nvim-treesitter/nvim-treesitter'},
	{src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim'},
	{src = 'https://github.com/nvim-mini/mini.completion'},

	
	-- -- Compile mode
	-- {src = 'https://github.com/m00qek/baleia.nvim'},
	-- {src = 'https://github.com/nvim-lua/plenary.nvim'},
	-- {src = 'https://github.com/ej-shafran/compile-mode.nvim'},
	-- other
	{src = 'https://github.com/akinsho/toggleterm.nvim'},
	{src = 'https://github.com/kdheepak/lazygit.nvim'},

})


local function pack_clean()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end


require("mini.pick").setup()
require("nvim-tree").setup {view = {side = "left"}}
require("toggleterm").setup{}
require("mini.completion").setup()
require("illuminate").configure()

-- LSP
vim.lsp.enable( {"clangd", "ty", "ruff"})
vim.lsp.config['ty'] = {root_markers = {"ty.toml", "pyproject.toml", ".git", ".py" }}
vim.lsp.config['ruff'] = {root_markers = {"ty.toml", "pyproject.toml", ".git", ".py" }}


-- KEYMAPS
local opts = { noremap=true, silent=true }

-- leader
vim.keymap.set('n', '<leader>t', ":NvimTreeToggle<CR>")
vim.keymap.set('n', '<leader>b', ":bNext<CR>")
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set("n", "<leader>pc", pack_clean)

-- lsp helps
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.keymap.set('n', 's', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

-- lsp jumps
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.keymap.set("n", "ge", '<cmd> lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

-- lsp actions
vim.keymap.set('n', ',wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.keymap.set('n', ',wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.keymap.set('n', ',wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.keymap.set('n', ',rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.keymap.set('n', ',a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.keymap.set('n', ',f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

-- yanks
vim.keymap.set({ "v", "x", "n" }, "<C-y>", '"+y', { desc = "System clipboard yank." })

-- buffers
vim.keymap.set('n', '<C-b>', ":ls<CR>:b")


-- terminal 
local opts = {noremap = true}
vim.keymap.set('n', '<C-j>', ':ToggleTerm  <CR>', opts)
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
vim.keymap.set('t', '<C-w>Right' , '<C-\\><C-n><C-w><Right>', opts)
vim.keymap.set('t', '<C-w><Left>', '<C-\\><C-n><C-w><Left>', opts)
vim.keymap.set('t', '<C-w><Down>', '<C-\\><C-n><C-w><Down>', opts)
vim.keymap.set('t', '<C-w><Up>'  , '<C-\\><C-n><C-w><Up>', opts)

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CMD>startinsert<CR>", {noremap= true, silent = true})
	end,
})

-- WildMenu 
vim.api.nvim_set_keymap('c', '<Up>', 'wildmenumode() ? "<Left>" : "<Up>"', {expr = true, noremap=true})
vim.api.nvim_set_keymap('c', '<Down>', 'wildmenumode() ? "<Right>" : "<Down>"', {expr = true, noremap=true})
vim.api.nvim_set_keymap('c', '<Left>', 'wildmenumode() ? "<Up>" : "<Left>"', {expr = true, noremap=true})
vim.api.nvim_set_keymap('c', '<Right>', 'wildmenumode() ? "<Down>" : "<Right>"', {expr = true, noremap=true})

-- C/C++ CONFIG
-- COMPILATION -----------------------------
-- TODO set to bear -- make 

-- TODO make this relative to root folder
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {'*.c', '*.h'},
  callback = function()
	  local cmd = string.format("bear -- make")
    vim.opt_local.makeprg = cmd
  end
})

-- Function to prompt for args and run make with ARGS="..." run
function MakeRunWithArgs()
  vim.ui.input({ prompt = "Enter arguments for make run: " }, function(input)
    if input then
      local escaped_input = input:gsub('"', '\\"')
      local cmd = string.format('make ARGS="%s" run', escaped_input)
      vim.cmd(cmd)
    else
      print("MakeRunWithArgs cancelled")
    end
  end)
end

vim.keymap.set('n', '<leader>M', MakeRunWithArgs, { desc = "Run make with ARGS", noremap = true, silent = true })
vim.keymap.set('n', '<leader>m', ':w<CR> :mak! <CR>')


vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "*",
  command = "cwindow",
})

--- Compile Mode --------

-- vim.g.compilation_directory =

-- vim.g.compile_mode = {
-- 	-- for an empty prompt
-- 	default_command = "bear -- make",
-- 	-- baleia_setup = true
-- }


-- DEBUG -----------------------------
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- same config for C
dap.configurations.c = dap.configurations.cpp


-- UI
require('lualine').setup{
	extensions = {'quickfix'},
	sections = {
		lualine_z = {
			{'cdate'},
			{'ctime', format = '%-I:%M' }}

	}
}
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme vague]])
