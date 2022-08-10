-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/calvinhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/calvinhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/calvinhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/calvinhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/calvinhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["coc-eslint"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc-eslint",
    url = "https://github.com/neoclide/coc-eslint"
  },
  ["coc-json"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc-json",
    url = "https://github.com/neoclide/coc-json"
  },
  ["coc-lua"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc-lua",
    url = "https://github.com/josa42/coc-lua"
  },
  ["coc-prettier"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc-prettier",
    url = "https://github.com/neoclide/coc-prettier"
  },
  ["coc-pyright"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc-pyright",
    url = "https://github.com/fannheyward/coc-pyright"
  },
  ["coc-rust-analyzer"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc-rust-analyzer",
    url = "https://github.com/fannheyward/coc-rust-analyzer"
  },
  ["coc-stylua"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc-stylua",
    url = "https://github.com/xiyaowong/coc-stylua"
  },
  ["coc-tsserver"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc-tsserver",
    url = "https://github.com/neoclide/coc-tsserver"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  fzf = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\2\nô\5\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0˘\4function! RipgrepFzf(query, fullscreen)\n  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'\n  let initial_command = printf(command_fmt, shellescape(a:query))\n  let reload_command = printf(command_fmt, '{q}')\n  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}\n  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)\nendfunction\n\ncommand! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)\n\nnmap ; :Buffers<CR>\nnmap <Leader>a :RG<CR>\nnmap <Leader>t :GFiles<CR>\nnmap <Leader>tt :Files<CR>\n\n            \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["ghcmod-vim"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/ghcmod-vim",
    url = "https://github.com/eagletmt/ghcmod-vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/git-messenger.vim",
    url = "https://github.com/rhysd/git-messenger.vim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nÎ\1\0\0\3\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0•\1map <leader><leader>w :HopWordAC<cr>\nmap <leader><leader>b :HopWordBC<cr>\nmap <leader><leader>/ :HopChar1<cr>\nmap <leader><leader>m :HopWordMW<cr>\n\n            \bcmd\bvim\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  molokai = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/molokai",
    url = "https://github.com/tomasr/molokai"
  },
  mru = {
    config = { "\27LJ\2\nb\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Clet MRU_Max_Entries = 400\nmap <leader>m :MRU<CR>\n\n            \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/mru",
    url = "https://github.com/yegappan/mru"
  },
  nerdcommenter = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nè\2\0\0\4\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\0016\0\n\0009\0\v\0'\2\f\0B\0\2\1K\0\1\0Aset foldmethod=expr\nset foldexpr=nvim_treesitter#foldexpr()\n\bcmd\bvim\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\19ignore_install\1\2\0\0\vphpdoc\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["stabilize.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0" },
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["vim-airline"] = {
    config = { "\27LJ\2\n‡\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0¿\1let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'\nlet g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'\n\n\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-airline",
    url = "https://github.com/vim-airline/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-airline-themes",
    url = "https://github.com/vim-airline/vim-airline-themes"
  },
  ["vim-colors-solarized"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-colors-solarized",
    url = "https://github.com/altercation/vim-colors-solarized"
  },
  ["vim-expand-region"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-expand-region",
    url = "https://github.com/terryma/vim-expand-region"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-peekaboo"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-peekaboo",
    url = "https://github.com/junegunn/vim-peekaboo"
  },
  ["vim-rzip"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-rzip",
    url = "https://github.com/lbrayner/vim-rzip"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-sneak",
    url = "https://github.com/justinmk/vim-sneak"
  },
  ["vim-surround"] = {
    config = { "\27LJ\2\nw\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Xvmap Si S(i_<esc>f)\nau FileType mako vmap Si S\"i${ _(<esc>2f\"a) }<esc>\n            \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vim-vinegar",
    url = "https://github.com/tpope/vim-vinegar"
  },
  ["vimproc.vim"] = {
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/vimproc.vim",
    url = "https://github.com/shougo/vimproc.vim"
  },
  ["wilder.nvim"] = {
    config = { "\27LJ\2\nË\1\0\0\v\0\v\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0009\4\4\0009\6\5\0005\b\a\0005\t\6\0=\t\b\b9\t\t\0B\t\1\2=\t\n\bB\6\2\0A\4\0\0A\1\1\1K\0\1\0\16highlighter\22basic_highlighter\15highlights\1\0\1\14separator\t ¬∑ \1\0\1\fdefault\15StatusLine\27wildmenu_airline_theme\22wildmenu_renderer\rrenderer\15set_option\vwilder\frequire\0" },
    loaded = true,
    path = "/Users/calvinhuang/.local/share/nvim/site/pack/packer/start/wilder.nvim",
    url = "https://github.com/gelguy/wilder.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nÎ\1\0\0\3\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0•\1map <leader><leader>w :HopWordAC<cr>\nmap <leader><leader>b :HopWordBC<cr>\nmap <leader><leader>/ :HopChar1<cr>\nmap <leader><leader>m :HopWordMW<cr>\n\n            \bcmd\bvim\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: mru
time([[Config for mru]], true)
try_loadstring("\27LJ\2\nb\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Clet MRU_Max_Entries = 400\nmap <leader>m :MRU<CR>\n\n            \bcmd\bvim\0", "config", "mru")
time([[Config for mru]], false)
-- Config for: stabilize.nvim
time([[Config for stabilize.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0", "config", "stabilize.nvim")
time([[Config for stabilize.nvim]], false)
-- Config for: wilder.nvim
time([[Config for wilder.nvim]], true)
try_loadstring("\27LJ\2\nË\1\0\0\v\0\v\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0009\4\4\0009\6\5\0005\b\a\0005\t\6\0=\t\b\b9\t\t\0B\t\1\2=\t\n\bB\6\2\0A\4\0\0A\1\1\1K\0\1\0\16highlighter\22basic_highlighter\15highlights\1\0\1\14separator\t ¬∑ \1\0\1\fdefault\15StatusLine\27wildmenu_airline_theme\22wildmenu_renderer\rrenderer\15set_option\vwilder\frequire\0", "config", "wilder.nvim")
time([[Config for wilder.nvim]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
try_loadstring("\27LJ\2\nô\5\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0˘\4function! RipgrepFzf(query, fullscreen)\n  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'\n  let initial_command = printf(command_fmt, shellescape(a:query))\n  let reload_command = printf(command_fmt, '{q}')\n  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}\n  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)\nendfunction\n\ncommand! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)\n\nnmap ; :Buffers<CR>\nnmap <Leader>a :RG<CR>\nnmap <Leader>t :GFiles<CR>\nnmap <Leader>tt :Files<CR>\n\n            \bcmd\bvim\0", "config", "fzf.vim")
time([[Config for fzf.vim]], false)
-- Config for: vim-airline
time([[Config for vim-airline]], true)
try_loadstring("\27LJ\2\n‡\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0¿\1let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'\nlet g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'\n\n\bcmd\bvim\0", "config", "vim-airline")
time([[Config for vim-airline]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nè\2\0\0\4\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\0016\0\n\0009\0\v\0'\2\f\0B\0\2\1K\0\1\0Aset foldmethod=expr\nset foldexpr=nvim_treesitter#foldexpr()\n\bcmd\bvim\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\19ignore_install\1\2\0\0\vphpdoc\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: vim-surround
time([[Config for vim-surround]], true)
try_loadstring("\27LJ\2\nw\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Xvmap Si S(i_<esc>f)\nau FileType mako vmap Si S\"i${ _(<esc>2f\"a) }<esc>\n            \bcmd\bvim\0", "config", "vim-surround")
time([[Config for vim-surround]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
