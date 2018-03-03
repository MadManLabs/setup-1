set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8

" --------
" File: .vimrc
" Description: Vim configuration
" Author: Ty-Lucas Kelley <tylucaskelley@gmail.com>
" Source: https://github.com/tylucaskelley/setup
" Last Modified: 24 February 2018
" --------

" -------- sections --------
"
" 1. general
" 2. ui, colors, fonts
" 3. files
" 4. navigation, tabs, buffers
" 5. text, indent, folding
" 6. search
" 7. helper functions
" 8. plugins
" 9. color scheme
"
" --------

" ----------
" 1. general
" ----------

" create a group for autocmd's in this file
augroup vimrc
    autocmd!
augroup END

" change leader key
let g:mapleader=','

" number of history lines to remember
set history=5000

" --------------------
" 2. ui, colors, fonts
" --------------------

" truecolor support
if has('termguicolors')
    set termguicolors
endif

" syntax highlighting
filetype plugin indent on
syntax enable

" dark theme
set background=dark

" show line at column 120
set colorcolumn=120

" show current command in bottom right
set showcmd

" highlight current line
set cursorline

" only redraw when necessary
set lazyredraw

" terminal bell settings
set noerrorbells
set visualbell
set t_vb=

" remove ESC key delays
set timeoutlen=1000
set ttimeoutlen=10

" show trailing spaces and TAB characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list

" show line and column numbers
set ruler
set number

" don't warn about unsaved changes to buffers
set hidden

" highlight matching braces
set showmatch
set matchtime=2

" filename completion
if has('wildmenu')
    " ignore some filetypes
    set wildignore+=*.a,*.o
    set wildignore+=*.pyc,*.egg
    set wildignore+=*.class,*.jar
    set wildignore+=.DS_Store,.Trashes,.Spotlight-V100
    set wildignore+=*.bmp,*.gif,*.ico,*.jpeg,*.jpg,*.png
    set wildignore+=.git,.svn,.hg

    " enable it
    set wildmenu
    set wildmode=longest:full,full
endif

" --------
" 3. files
" --------

" reload files edited outside of vim
set autoread

" re-read when entering buffer
augroup Autoread
    autocmd!
    autocmd FocusGained,BufEnter * :silent! !
augroup END

" recognize some specific files

augroup RecognizeFiles
    autocmd!
    autocmd BufRead,BufNewFile,BufFilePre .{artilleryrc,babelrc,eslintrc,jsdocrc,nycrc,stylelintrc,markdownlintrc,tern-project,tern-config} set filetype=json
    autocmd BufRead,BufNewFile,BufFilePre .{flake8,licenser,flowconfig} set filetype=dosini
    autocmd BufRead,BufNewFile,BufFilePre .sequelizerc set filetype=javascript
augroup END

" no concealing characters
set conceallevel=0

" no swaps and backups
set nobackup
set nowritebackup
set noswapfile

" persistent undo
set undofile
set undodir=~/.vim/undo

" ----------------------------
" 4. navigation, tabs, buffers
" ----------------------------

" send more chars at once
set ttyfast

" enable mouse mode
if !has('nvim')
    set ttymouse=xterm2
endif

set mouse=a

" make backspace work like other editors
set backspace=indent,eol,start
vnoremap <BS> d

" wrap to prev/next line with arrow keys
set whichwrap=<,>,h,l,[,]

" force use of hjkl for navigation in normal mode
nnoremap <Left> :echoe "use h to move left"<CR>
nnoremap <Right> :echoe "use l to move right"<CR>
nnoremap <Up> :echoe "use k to move up"<CR>
nnoremap <Down> :echoe "use j to move down"<CR>

" navigate between window splits with Ctrl ke,s,s,s
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" initiate commands with spacebar
nnoremap <Space> :

" move between tabs with Shift-l and Shift-h
nnoremap <S-l> gt
nnoremap <S-h> gT

" adjust indentation with Shift-Tab
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" close all open buffers
nnoremap <leader>x :bufdo bd<CR>

" quick window splitting
nnoremap <leader>h :split
nnoremap <leader>v :vsplit

" cd to current file's directory
set autochdir

" return to last edit position when opening a file
augroup last_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" pad scrolling with a few lines from window border
set scrolloff=10
set sidescrolloff=10

" always show status and tab bars
set laststatus=2
set showtabline=2

" close location list if parent window is quit
augroup LocList
    autocmd!
    autocmd QuitPre * silent! lclose
augroup END

" reload .vimrc
nnoremap <leader>. :source ~/.vimrc<CR>

" ------------------------
" 5. text, indent, folding
" ------------------------

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" system clipboard
if has('clipboard')
    set clipboard=unnamed
endif

" remove all trailing whitespace
nnoremap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" spaces instead of tabs, width of 4
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

" auto indent
filetype indent plugin on
set autoindent
set smartindent

" proper word wrapping
set wrap
set textwidth=0
set wrapmargin=0
set linebreak

" re-indent entire file
nnoremap <leader>i mzgg=G`z`

" grep-style regex
set magic

" max number of folds to create
set foldnestmax=10

" language-based folding
set foldmethod=indent

" display fold info
set foldcolumn=4

" folds open by default when reading file
set nofoldenable
set foldlevelstart=99

" use f to toggle fold open/close
nnoremap f za

" spellcheck for markdown and text files automatically
autocmd vimrc BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us

" toggle spellcheck
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" select entire file's contents
nnoremap <leader>a ggVG

" copy entire file's contents to system clipboard and return to previous cursor position
nnoremap <leader>c gg"+yG``

" ---------
" 6. search
" ---------

" use <Tab> in normal mode to start search
nnoremap <Tab> /

" realtime search
set incsearch

" highlight matches
set hlsearch

" ignore case when searching
set ignorecase

" turn off search highlight in current buffer
nnoremap <CR> :noh<CR><CR>

" -------------------
" 7. helper functions
" -------------------

" show highlight groups applied to current text
function! <SID>HighlightGroups()
    if !exists('*synstack')
        return
    endif

    echo map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
endfunction

nmap <leader>hl :call <SID>HighlightGroups()<CR>

" trim whitespace from a string
function! StrTrim(text)
    return substitute(a:text, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

" ----------
" 8. plugins
" ----------

if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/packages')

    " color scheme
    Plug 'morhetz/gruvbox'

    " lightline
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'

    let g:lightline={
        \ 'enable': { 'tabline': 1 },
        \ 'active': {
        \     'left': [
        \         [ 'mode', 'paste', 'spell' ],
        \         [ 'gitbranch', 'readonly', 'filename', 'modified' ]
        \     ],
        \     'right': [
        \         [ 'ale_errors', 'ale_warnings', 'ale_ok', 'lineinfo' ],
        \         [ 'fileformat', 'fileencoding', 'filetype' ]
        \     ]
        \ },
        \ 'component_expand': {
        \     'ale_errors': 'lightline#ale#errors',
        \     'ale_warnings': 'lightline#ale#warnings',
        \     'ale_ok': 'lightline#ale#ok'
        \ },
        \ 'component_type': {
        \     'ale_errors': 'error',
        \     'ale_warnings': 'warning',
        \     'ale_ok': 'left'
        \ },
        \ 'component_function': {
        \     'gitbranch': 'fugitive#head'
        \ },
    \ }

    " nicer start screen
    Plug 'mhinz/vim-startify'

    " show indent guides
    Plug 'Yggdroot/indentLine'

    let g:indentLine_setColors=0

    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " comment functions
    Plug 'scrooloose/nerdcommenter'

    " recognize indent settings per project
    Plug 'tpope/vim-sleuth'

    " editorconfig
    Plug 'editorconfig/editorconfig-vim'

    let g:EditorConfig_exclude_patterns = [ 'fugitive://.*', 'scp://.*' ]

    " close matching pairs automatically
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'

    let g:closetag_filenames='*.html,*.xhtml,*.phtml,*.xml,*.vue,*.jsx'

    " emmet
    Plug 'mattn/emmet-vim'

    " fuzzy file finder
    Plug 'Shougo/denite.nvim'

    nnoremap <leader>f :Denite file_rec<CR>

    " css colors
    Plug 'ap/vim-css-color'

    " javascript / typescript
    Plug 'pangloss/vim-javascript'

    let g:javascript_plugin_jsdoc=1
    let g:javascript_plugin_flow=1

    Plug 'leafgarland/typescript-vim'

    Plug 'elzr/vim-json'

    let g:vim_json_syntax_conceal=0

    Plug 'posva/vim-vue'

    " better markdown
    Plug 'plasticboy/vim-markdown'

    let g:vim_markdown_fenced_languages=[ 'csharp=cs', 'js=javascript', 'rb=ruby', 'c++=cpp', 'ini=dosini', 'bash=sh', 'viml=vim' ]
    let g:vim_markdown_conceal=0

    " latex
    Plug 'lervag/vimtex'

    let g:tex_flavor='latex'

    " look up documentation
    Plug 'keith/investigate.vim'

    let g:investigate_use_dash=1

    " csv files
    Plug 'chrisbra/csv.vim'

    let g:csv_delim=','
    let g:csv_nomap_cr=1
    let g:csv_nomap_space=1
    let g:csv_nomap_bs=1

    " syntax checking
    Plug 'w0rp/ale'

    let g:ale_linters = {
        \ 'css': [ 'stylelint' ],
        \ 'javascript': [ 'eslint' ],
        \ 'markdown': [ 'mdl' ],
        \ 'python': [ 'flake8' ],
        \ 'sass': [ 'stylelint' ],
        \ 'scss': [ 'stylelint' ]
    \ }

    " TODO: check status of https://github.com/w0rp/ale/pull/1377 to see about
    " markdownlint-cli vs mdl
    let g:ale_open_list=1
    let g:ale_echo_msg_format='[%linter%] %s'

    " autocompletion
    if has('mac')
        Plug 'Valloric/YouCompleteMe', { 'do': '/usr/bin/python ./install.py --all' }

        let g:ycm_key_list_select_completion=[ '<C-j>', '<C-n>', '<Down>' ]
        let g:ycm_key_list_previous_completion=[ '<C-k>', '<C-p>', '<Up>' ]
        let g:ycm_autoclose_preview_window_after_completion=1 " close window after completion accepted
    endif

    " snippets
    Plug 'SirVer/ultisnips'

    let g:UltiSnipsExpandTrigger='<C-e>'
    let g:UltiSnipsJumpForwardTrigger='<C-j>'
    let g:UltiSnipsJumpBackwardTrigger='<C-k>'

    " check for existence of custom snippets directory

    if !empty(glob('~/.vim/snips'))
        let g:UltiSnipsSnippetDirectories=[ 'UltiSnips', 'snips' ]
    endif

    call plug#end()
endif

" ---------------
" 9. color scheme
" ---------------

" set colorscheme after plugins done installing
try
    colorscheme gruvbox
    let g:lightline.colorscheme='gruvbox'

    " custom higlighting changes
    hi! link jsGlobalNodeObjects GruvboxAqua
    hi! link jsGlobalObjects GruvboxBlue
catch
    colorscheme ron
endtry
