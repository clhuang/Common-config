local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim")
	use("jlanzarotta/bufexplorer")

	use({
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"](0)
		end,
	})
	use({
		"junegunn/fzf.vim",
		config = function()
			vim.cmd([[
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nmap ; :Buffers<CR>
nmap <Leader>a :RG<CR>
nmap <Leader>t :GFiles<CR>
nmap <Leader>tt :Files<CR>

            ]])
		end,
	})
	--use("junegunn/vim-peekaboo")
	--use("eagletmt/ghcmod-vim")
	use("tomasr/molokai")
	use("lbrayner/vim-rzip")
	use({
		"yegappan/mru",
		config = function()
			vim.cmd([[
let MRU_Max_Entries = 400
map <leader>m :MRU<CR>

            ]])
		end,
	})
	use("preservim/nerdcommenter")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				options = { theme = "moonfly" },
				sections = {
					lualine_c = { { "filename", path = 1 } },
				},
				inactive_sections = {
					lualine_c = { { "filename", path = 1 } },
				},
			})
		end,
	})
	use("altercation/vim-colors-solarized")
	use("github/copilot.vim")
	use({
		"phaazon/hop.nvim",
        commit = "caaccee",
		config = function()
			local hop = require("hop")
			hop.setup()
			local HintDirection = require("hop.hint").HintDirection
			vim.keymap.set("", ",,w", function()
				hop.hint_words({ direction = HintDirection.AFTER_CURSOR })
			end)
			vim.keymap.set("", ",,b", function()
				hop.hint_words({ direction = HintDirection.BEFORE_CURSOR })
			end)
			vim.keymap.set("", "s", function()
				hop.hint_char2({ direction = HintDirection.AFTER_CURSOR })
			end)
			vim.keymap.set("", "S", function()
				hop.hint_char2({ direction = HintDirection.BEFORE_CURSOR })
			end)
			vim.keymap.set("", ",,m", function()
				hop.hint_words({ multi_windows = true })
			end)
		end,
	})
	use("terryma/vim-expand-region")
	use("tpope/vim-fugitive")
	use("shougo/vimproc.vim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all", -- one of "all", "language", or a list of languages
				ignore_install = { "phpdoc" },
				highlight = {
					enable = true, -- false will disable the whole extension
				},
				indent = {
					enable = true,
				},
			})
			vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]])
		end,
	})
	use({ "airblade/vim-gitgutter", branch = "main" })
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	use("tpope/vim-vinegar")
	use("rhysd/git-messenger.vim")
	use({
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	})
	use({ "neoclide/coc.nvim", branch = "release" })
	use({ "neoclide/coc-tsserver", run = "yarn install --frozen-lockfile" })
	use({ "neoclide/coc-eslint", run = "yarn install --frozen-lockfile" })
	use({ "neoclide/coc-json", run = "yarn install --frozen-lockfile" })
	use({ "neoclide/coc-prettier", run = "yarn install --frozen-lockfile" })
	use({ "josa42/coc-lua", branch = "main", run = "yarn install --frozen-lockfile" })
	use({ "xiyaowong/coc-stylua", run = "yarn install --frozen-lockfile" })
	use({ "fannheyward/coc-rust-analyzer", run = "yarn install --frozen-lockfile" })
	use({ "fannheyward/coc-pyright", run = "yarn install --frozen-lockfile" })
	use({
		"gelguy/wilder.nvim",
		config = function()
			local wilder = require("wilder")
			-- Create the WilderAccent highlight by overriding the guifg attribute of Pmenu
			-- and return the name of the highlight
			local hl = wilder.make_hl("WilderAccent", "Pmenu", { {}, {}, { foreground = "#f4468f" } })

			wilder.set_option(
				"renderer",
				wilder.wildmenu_renderer({
					highlighter = wilder.basic_highlighter(),
					highlights = {
						accent = hl,
					},
				})
			)
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[
" if hidden is not set, TextEdit might fail.
" plugins: coc-tsserver, coc-prettier, coc-eslint, coc-json, coc-python
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ Coc_check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

function! Coc_check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use `[c` and `]c` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call Coc_show_documentation()<CR>

function! Coc_show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

autocmd ColorScheme * hi CocMenuSel ctermbg=237 guibg=#13354A
]])

vim.cmd([[
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))
]])

local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
