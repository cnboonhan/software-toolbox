""" SETTINGS
let mapleader=","
set hidden  "  Hides buffers instead of closing them
set wildmenu " An navigable menu will appear on entering <Tab> after :command
set wildmode=longest:full,full " Choice of displaying autocomplete after :command
set mouse=a " Allows point and click 
filetype plugin indent on " Enable filetype detection, ftplugins and indent scripts
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent " Formatting settings
set incsearch ignorecase smartcase hlsearch " Search settings
set wrap breakindent " Wrapping text will be indented properly
set encoding=utf-8
set relativenumber
set clipboard=unnamedplus " Use the system clipboard for yanking
set foldmethod=syntax
map Q <Nop>

""" PLUGINS 
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' } 
Plug 'kassio/neoterm'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'morhetz/gruvbox'
Plug 'puremourning/vimspector'
call plug#end()

" colorscheme
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme gruvbox 

" Ensure vim does not clear clipboard on exit
autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) . 
            \ ' | xclip -selection clipboard')

" Shortcut to allow deleting without copying to clipboard
nnoremap <space>d "_d
xnoremap <space>d "_d
xnoremap <space>p "_dP

""" PLUGIN CONFIGURATIONS

" YouCompletMe
let g:ycm_autoclose_preview_window_after_completion = 1

" Vimspector
" Start Debug / Continue until Break: F5
" Step Over: F10
" Step Into: F11
" Complete Current Function: F12
" Toggle Breakpoint: F9
" Stop Debug:   F3
" Restart with Same Options: F4
" Pause: F6
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_test_plugin_path = expand( '<sfile>:p:h:h' )
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
set noequalalways

let &rtp = &rtp . ',' . g:vimspector_test_plugin_path

" EasyMotion
 let g:EasyMotion_do_mapping = 1
 map <space> <Plug>(easymotion-prefix)

" NERDTREE / TAGBAR 
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
nmap <leader>q :NERDTreeToggle<CR>
nmap <leader>Q :TagbarToggle<CR>

""" MISC 
" Removes highlights from searches
nmap <leader><leader> :noh<CR>
" Reloads the init.vim file quickly
nmap <leader>r :so $HOME/.vimrc<CR> 

" YouCompleteMe specific Configurations
nmap <silent>gd :YcmCompleter GoTo<CR>
nmap <silent>gf :YcmCompleter GoToDefinition<CR>
nmap <silent>gc :YcmCompleter GoToDeclaration<CR>
nmap <silent>gi :YcmCompleter GoToInclude<CR>
nmap <silent>gt :YcmCompleter GetType<CR>

" DENITE specific configurations
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of grep
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)


"   ;         - Browser currently open buffers
"   <leader>f - Browse list of files in current directory
"   <leader>F - Search current directory for occurences of given term and close window if no results
"   <leader>g - Search current directory for occurences of word under cursor
nnoremap <leader>; :Denite buffer<CR>
nnoremap <leader>f :DeniteProjectDir file/rec<CR>
nnoremap <leader>F :Denite grep:. -no-empty<CR>

nnoremap <leader>d :DeniteProjectDir -input=<c-r>=expand("<cword>")<cr> file/rec<CR>
nnoremap <leader>D :DeniteProjectDir -input=<c-r>=expand("<cWORD>")<cr> file/rec<CR>
nnoremap <leader>g :Denite grep -input=<c-r>=expand("<cword>")<cr><CR> 
nnoremap <leader>G :Denite grep -input=<c-r>=expand("<cWORD>")<cr><CR> 

nnoremap <leader>c :Denite command_history<CR>
vnoremap <leader>c :<C-u>Denite command_history<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction
