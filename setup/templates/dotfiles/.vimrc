set encoding=utf-8
set fileencoding=utf-8

" --------
" File: .vimrc
" Description: Vim / Neovim configuration
" Author: Ty-Lucas Kelley <tylucaskelley@gmail.com>
" Source: https://tylucaskelley.com
" Last Modified: 09 May 2018
" --------

" -------- sections --------
"
" 1. general
" 2. key mappings
" 3. ui, colors, fonts
" 4. files
" 5. navigation, tabs, buffers
" 6. text, indent, folding
" 7. search
" 8. helper functions
" 9. plugins
"
" --------

" ----------
" 1. general
" ----------

" use , as leader key
let g:mapleader=','

" longer command history
set history=5000

" get rid of escape key delay
set timeoutlen=1000
set ttimeoutlen=10

" allow for filetype-specific plugins
filetype plugin indent on

" ---------------
" 2. key mappings
" ---------------

" kill search result highlighting
nnoremap <silent> <CR> :noh<CR><CR>

" toggle spellcheck
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" select entire file's contents
nnoremap <leader>a ggVG

" delete everything in a file
nnoremap <leader>d ggdG

" copy entire file's contents to system clipboard and return to previous cursor position
nnoremap <leader>c gg"+yG``

" force use of hjkl for navigation in normal mode
nnoremap <Left> :echoe "use h to move left"<CR>
nnoremap <Right> :echoe "use l to move right"<CR>
nnoremap <Up> :echoe "use k to move up"<CR>
nnoremap <Down> :echoe "use j to move down"<CR>

" navigate between window splits with Ctrl keys
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" initiate commands with spacebar
nnoremap <Space> :

" move between tabs with Shift-l and Shift-h
nnoremap <S-l> gt
nnoremap <S-h> gT

" initiate a search with <Tab> in normal mode
nnoremap <Tab> /

" close all open buffers
nnoremap <leader>x :bufdo bd<CR>

" split windows
nnoremap <leader>h :split<CR>
nnoremap <leader>v :vsplit<CR>

" resize window splits to be equal
nnoremap <leader>e <C-w>=

" reload .vimrc
nnoremap <leader>. :source ~/.vimrc<CR>

" remove all trailing whitespace in file
nnoremap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" re-indent entire file
nnoremap <leader>i mzgg=G`z`

" use f to toggle fold open/close
nnoremap f za

" toggle spellcheck
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" select entire file's contents
nnoremap <leader>a ggVG

" copy entire file's contents to system clipboard and return to previous cursor position
nnoremap <leader>c gg"+yG``

" adjust indentation
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" backspace to delete in visual mode
vnoremap <BS> d

" helpful git stuff
augroup GitRebase
    autocmd!
    autocmd FileType gitrebase nnoremap <buffer> <leader>s :2,$s/^pick/squash/<CR>
augroup END

" --------------------
" 3. ui, colors, fonts
" --------------------

" support truecolor
if has('termguicolors')
    set termguicolors
endif

" turn on syntax highlighting
syntax enable

" dark background
set background=dark

" show line at column 120
set colorcolumn=120

" show current command in bottom right
set showcmd

" highlight current line
set cursorline

" only redraw when needed
set lazyredraw

" terminal bell settings
set noerrorbells
set visualbell
set t_vb=

" display special characters
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" line and column numbers
set ruler
set number

" don't warn about unsaved changes to buffers
set hidden

" highlight matching braces
set showmatch
set matchtime=2

" show result of various commands like search/replace before you commit
if has('nvim')
    set inccommand=split
endif

" --------
" 4. files
" --------

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
" 5. navigation, tabs, buffers
" ----------------------------

" make backspace work like other editors
set backspace=indent,eol,start

" send more chars at once
set ttyfast

" enable mouse mode
if !has('nvim')
    set ttymouse=xterm2
endif

set mouse=a

" wrap to prev/next line with arrow keys
set whichwrap=<,>,h,l,[,]

" open splits below and to the right
set splitright
set splitbelow

" don't cd to current file's directory automatically
set noautochdir

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

" ------------------------
" 6. text, indent, folding
" ------------------------

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" sync with system clipboard
if has('clipboard')
    set clipboard=unnamed
endif

" spaces instead of tabs, width of 4
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

" auto indent
set autoindent
set smartindent

" proper word wrapping
set wrap
set textwidth=0
set wrapmargin=0
set linebreak

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

" spellcheck for markdown and text files automatically
augroup Spelling
    autocmd!
    autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us
augroup END

" ---------
" 7. search
" ---------

" add the g flag to search and replace
set gdefault

" real-time search
set incsearch

" highlight matches
set hlsearch

" ignore case when searching
set ignorecase

" -------------------
" 8. helper functions
" -------------------

" show highlight groups applied to current text
function! <SID>HighlightGroups()
    if !exists('*synstack')
        return
    endif

    echo map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
endfunction

" trim whitespace from a string
function! StrTrim(text)
    return substitute(a:text, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

" ----------
" 9. plugins
" ----------

if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/packages')

    " ----------
    " ui changes
    " ----------

    " color schemes
    Plug 'morhetz/gruvbox'

    " lightline
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'

    let g:lightline={
        \ 'enable': { 'tabline': 1 },
        \ 'active': {
        \     'left': [
        \         [ 'mode', 'paste', 'spell' ],
        \         [ 'gitbranch', 'readonly', 'relativepath', 'modified' ]
        \     ],
        \     'right': [
        \         [ 'ale_errors', 'ale_warnings', 'ale_ok', 'lineinfo' ],
        \         [ 'fileformat', 'fileencoding', 'filetype', 'bufnum' ]
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

    let g:startify_bookmarks=[ '~/.vimrc', '~/.bashrc' ]

    " show indent guides
    Plug 'Yggdroot/indentLine'

    let g:indentLine_setColors=0

    " ---
    " git
    " ---

    " git wrapper
    Plug 'tpope/vim-fugitive'

    " show diff in gutter
    Plug 'airblade/vim-gitgutter'

    " -----
    " files
    " -----

    " autocomplete in search
    Plug 'vim-scripts/SearchComplete'

    " add in keywords to close code blocks (e.g. endif, end, done, etc.)
    Plug 'tpope/vim-endwise'

    " reload files changed outside of vim
    Plug 'djoshea/vim-autoread'

    " quick commenting of lines (<leader>cc being most useful)
    Plug 'scrooloose/nerdcommenter'

    let g:NERDSpaceDelims=1
    let g:NERDDefaultAlign='left'
    let g:NERDCommentEmptyLines=1
    let g:NERDTrimTrailingWhitespace=1

    " fuzzy file finding
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

    let g:fzf_command_prefix='Fzf'

    let g:fzf_colors = {
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment']
    \ }

    " initiate file search
    nnoremap <silent> <leader>f :FzfFiles<CR>
    nnoremap <silent> <leader>r :FzfAg<C-R><C-W><CR>

    " match pairs
    Plug 'jiangmiao/auto-pairs'

    let g:AutoPairsFlyMode=0

    " recognize indent settings per project
    Plug 'tpope/vim-sleuth'

    " ---------------
    " syntax checking
    " ---------------

    Plug 'w0rp/ale'

    let g:ale_open_list=1
    let g:ale_echo_msg_format='[%linter%] %s'
    let g:ale_linters = {
        \ 'css': [ 'stylelint' ],
        \ 'javascript': [ 'eslint' ],
        \ 'markdown': [ 'markdownlint' ],
        \ 'python': [ 'flake8' ],
        \ 'ruby': [ 'rubocop' ],
        \ 'sass': [ 'stylelint' ],
        \ 'scss': [ 'stylelint' ]
    \ }

    " -------------------------
    " filetype-specific plugins
    " -------------------------

    " html / css
    Plug 'ap/vim-css-color'
    Plug 'mattn/emmet-vim'
    Plug 'alvan/vim-closetag'

    let g:closetag_filenames='*.html,*.xhtml,*.phtml,*.xml,*.vue,*.jsx,*.js'

    " javascript / typescript
    Plug 'pangloss/vim-javascript'

    let g:javascript_plugin_jsdoc=1
    let g:javascript_plugin_flow=1

    Plug 'leafgarland/typescript-vim'

    " jsx
    Plug 'mxw/vim-jsx'

    let g:jsx_ext_required=0

    " vue
    Plug 'posva/vim-vue'

    " graphql
    Plug 'jparise/vim-graphql'

    " json
    Plug 'elzr/vim-json'

    let g:vim_json_syntax_conceal=0

    " php / blade
    Plug 'jwalton512/vim-blade'

    " markdown
    Plug 'plasticboy/vim-markdown'

    let g:vim_markdown_fenced_languages=[ 'csharp=cs', 'js=javascript', 'rb=ruby', 'c++=cpp', 'ini=dosini', 'bash=sh', 'viml=vim' ]
    let g:vim_markdown_conceal=0

    " ruby / rails
    Plug 'vim-ruby/vim-ruby'
    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-bundler'

    " csv
    Plug 'chrisbra/csv.vim'

    let g:csv_delim=','
    let g:csv_nomap_cr=1
    let g:csv_nomap_space=1
    let g:csv_nomap_bs=1

    " latex
    Plug 'lervag/vimtex'

    let g:tex_flavor='latex'

    " vim
    Plug 'junegunn/vader.vim'

    " -------
    " testing
    " -------

    " kick off tests
    Plug 'tpope/vim-dispatch'
    Plug 'janko-m/vim-test'

    nnoremap <leader>t :TestFile<CR>
    nnoremap <leader>T :TestNearest<CR>

    let g:test#strategy='dispatch'

    " -----
    " misc.
    " -----

    " make vim project-aware
    Plug 'airblade/vim-rooter'

    let g:rooter_resolve_links=1

    " look up documentation
    Plug 'keith/investigate.vim'

    let g:investigate_use_dash=1

    " override plugin settings
    set conceallevel=0

    call plug#end()
end

" set colorscheme after plugin stuff is done
try
    colorscheme gruvbox
    let g:lightline.colorscheme='gruvbox'

    " higlighting changes
    hi! link jsGlobalNodeObjects GruvboxAqua
    hi! link jsGlobalObjects GruvboxBlue
catch
    colorscheme ron
endtry
