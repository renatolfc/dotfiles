filetype off
syntax on
filetype plugin indent on

" Use Vim settings, rather then Vi settings
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"Basic options
set encoding=utf-8
set scrolloff=5
set autoindent
set showcmd
set showmode
set wildmenu
"set wildmode=list:longest
set visualbell
set cursorline

set ruler
set rulerformat=%55(%5l,%-6(%c%V%)\ %P\ -\ %{strftime('%a\ %b\ %e\ %H:%M')}%)
set relativenumber
set laststatus=2
set undofile
set lazyredraw
set history=2000 " keep 2000 lines of command line history
set matchtime=5
set mouse=a "let the mouse work on the CLI
set updatecount=50
set autochdir
set fileformat=unix " Fuck you windows users
set cursorcolumn

"Backup
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/swap
set undodir=$HOME/.vim/undo

"Leader
let mapleader = "\\"

"Plugin loading {{{
call plug#begin('~/.vim/plugged')
    Plug 'mileszs/ack.vim'
    Plug 'kien/ctrlp.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'simnalamburt/vim-mundo'
    Plug 'tpope/vim-fugitive'
    Plug 'tomasr/molokai'
    Plug 'neomake/neomake'
    Plug 'jnurmine/Zenburn'
    Plug 'luochen1990/rainbow'
    Plug 'scrooloose/nerdtree'
    Plug 'ervandew/taglisttoo'
    Plug 'fatih/vim-go'
    Plug 'rhysd/vim-grammarous'
    Plug 'lervag/vimtex'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'davidbeckingsale/writegood.vim'
    " Snippets {{{
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " }}}
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    let g:deoplete#enable_at_startup = 1
call plug#end()
" }}}

"Searching
set ignorecase
set smartcase
set incsearch
set wrapscan
set showmatch
set hlsearch
set gdefault
nmap <tab> %
vmap <tab> %

"Wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85
"Visible tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬
set showmatch

" Color scheme
syntax on
" zenburn options
let g:zenburn_High_Contrast = 1
let g:zenburn_alternate_Visual = 1
let g:zenburn_force_dark_Background = 1

" solarized options
let g:solarized_termcolors=16
let g:solarized_style="dark"
let g:solarized_italic=1
let g:solarized_contrast="high"

" molokai options
let g:molokai_original = 1

colorscheme zenburn

" NERD Tree
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l

set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
set foldmethod=marker

" ctags
map <silent> <F4> :TlistToggle<CR>
map <Leader>u :TlistUpdate<CR>
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
imap <S-Tab> <C-X><C-O>
let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function'

" Make selecting inside an HTML tag less dumb
nnoremap Vit vitVkoj
nnoremap Vat vatV

" Diff
nmap <leader>d :!hg diff %<CR>

" Rainbows
let g:rainbow_active = 0
nmap <leader>R :RainbowToggle<CR>

" Edit vim stuff
nmap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Add Ctrl-J as the keyword for snippets
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" Snippet creation
nmap <leader>es <C-w><C-v><C-l>:e ~/.vim/snippets/<cr>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Ropevim
let ropevim_enable_shortcuts = 0
let ropevim_guess_project = 1
noremap <leader>rr :RopeRename<CR>
vnoremap <leader>rm :RopeExtractMethod<CR>
noremap <leader>roi :RopeOrganizeImports<CR>

" Gui
if has("gui_running")
    set guifont=Fira\ Code\ 9
    set guioptions-=m
    set guioptions-=T
endif

" chmod +x
map <leader>x !chmod +x %

" Python extra syntax file highlight options
let python_highlight_all=1

filetype on
filetype plugin on
filetype plugin indent on

autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" Scons syntax highlighting
au BufNewFile,BufRead SCons* set filetype=scons

" Pressing Backspace in visual mode deletes
vmap <BS> x

" Defines a 'go to definition' mnemonic
map gd <C-]>

" Command to edit URLs
let g:netrw_http_cmd = "wget -q -O"

" Brings the Man function into the local context
runtime ftplugin/man.vim
" Helper function for reading man pages formatted by vim
fun! ReadMan()
    let s:man_word = expand('<cword>')
    :exe ":Man " . s:man_word
endfun
map K :call ReadMan()<CR>

" FuzzyFinder & Ctrl-P mappings
noremap <Leader>f :FZF<Return>
map <Leader>b :FufBuffer<Return>
map <Leader>p :CtrlPMixed<Return>

" Make trailing whitespace be flagged as bad.
highlight BadWhitespace ctermbg=red guibg=red

" Make Control-C yank the selection
vmap <C-c> "+y

" Correct handling of jar and xpi files as zip
au BufReadCmd *.jar,*.xpi call zip#Browse(expand("<amatch>"))

" Eclim settings
let g:EclimBrowser = 'firefox'
au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
" au BufNewFile,BufRead *.java set noexpandtab

" Set default omni function for completing python code
au FileType python set omnifunc=pythoncomplete#Complete
" Force *.md to be recognized as markdown
au BufNewFile,BufRead *.md set ft=markdown spell

function! ToggleBackground()
    if (g:solarized_style=="dark")
    let g:solarized_style="light"
    set bg=light
    colorscheme solarized
else
    let g:solarized_style="dark"
    set bg=dark
    colorscheme solarized
endif
endfunction
command! Togbg call ToggleBackground()

nnoremap <F12> :call ToggleBackground()<CR>
inoremap <F12> <ESC>:call ToggleBackground()<CR>a
vnoremap <F12> <ESC>:call ToggleBackground()<CR>
nnoremap <F11> :GundoToggle<CR>

nnoremap <S-TAB> <ESC>gT
nnoremap <TAB> <ESC>gt

inoremap <C-Space> <C-X><C-U>

setlocal nowrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
    silent! iunmap <buffer> k
    silent! iunmap <buffer> j
    silent! iunmap <buffer> 0
    silent! iunmap <buffer> $
  else
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
    noremap  <buffer> <silent> k gk
    noremap  <buffer> <silent> j gj
    noremap  <buffer> <silent> 0 g0
    noremap  <buffer> <silent> $ g$
  endif
endfunction
call ToggleWrap()

if has("gui_running")
	set columns=90
	set lines=50
endif

call neomake#configure#automake('nrwi', 500)

let g:grammarous#languagetool_cmd = 'languagetool'

" draw background correctly in kitty
let &t_ut=''

" LaTeX {{{
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'
"let g:vimtex_compiler_latexmk = {
"      \ 'options': [
"      \     '-verbose',
"      \     '-file-line-error',
"      \     '-synctex=1',
"      \     '-interaction=nonstopmode',
"      \     '-lualatex',
"      \]}
" }}}
