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

vim.pack.add({
	{src = 'https://github.com/ellisonleao/gruvbox.nvim'},
	{src = 'https://github.com/vague2k/vague.nvim'},
	{src = 'https://github.com/nvim-lualine/lualine.nvim'},
	{src = 'https://github.com/echasnovski/mini.pick'},
	{src = 'https://github.com/nvim-lualine/lualine.nvim'},
	{src = 'https://github.com/nvim-tree/nvim-tree.lua'},
	{src = 'https://github.com/neovim/nvim-lspconfig'},
	{src = 'https://github.com/archibate/lualine-time'},
	{src = 'https://github.com/akinsho/bufferline.nvim'},
	{src = 'https://github.com/mfussenegger/nvim-dap'},
	{src = 'https://github.com/igorlfs/nvim-dap-view'},
	{src = 'https://github.com/akinsho/toggleterm.nvim'},
	{src = 'https://github.com/nvim-mini/mini.completion'},
	{src = 'https://github.com/RRethy/vim-illuminate'}

})


require "mini.pick".setup()
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


-- helps
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.keymap.set('n', 's', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.keymap.set('i', ',s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

-- jumps
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.keymap.set("n", "ge", '<cmd> lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

-- actions
vim.keymap.set('n', ',wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.keymap.set('n', ',wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.keymap.set('n', ',wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.keymap.set('n', ',rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.keymap.set('n', ',a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.keymap.set('n', ',f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)


-- terminal 
local opts = {buffer = 0}
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-w>Right', [[<C-\><C-n><C-w>]], opts)
vim.keymap.set('t', '<C-w>Left', [[<C-\><C-n><C-w>]], opts)
vim.keymap.set('t', '<C-w>Up', [[<C-\><C-n><C-w>]], opts)
vim.keymap.set('t', '<C-w>Down', [[<C-\><C-n><C-w>]], opts)

-- C/C++ CONFIG

-- Function to prompt for args and run make with ARGS="..." run
function MakeRunWithArgs()
  vim.ui.input({ prompt = "Enter arguments for make run: " }, function(input)
    if input then
      -- Escape double quotes in the input
      local escaped_input = input:gsub('"', '\\"')
      -- Build the make command with ARGS
      local cmd = string.format('make ARGS="%s" run', escaped_input)
      -- Execute the command in Neovim
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
