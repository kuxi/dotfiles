""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       VIM config
"                         hlysig
"                    hlysig@gmail.com
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make Vim behave in a more useful way. This is most likely not
" needed where Vim enables this when it finds a .vimrc.
set nocompatible

" Init pathogen
call pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn of bells.
set visualbell t_vb=

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Enable 256 colors.
set t_Co=256

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable persistent undo.
set undofile                " Save undo's after file closes
set undodir=~/.vim/undo     " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=1000         " number of lines to save for undo
set history=700             " Sets how many lines of history VIM 
                            " has to remember

set nowritebackup           " No backup files, no swaps.
set nobackup   
set noswapfile

" Set to auto read when a file is changed from the outside
set autoread

"" Setup Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


"""""" Github repos
" REQUIRED. Manages vim bundles

Bundle 'gmarik/vundle'
" Tree viewer for folders in vim
Bundle 'scrooloose/nerdtree'
" Syntax highlighting/linting for a bunch of languages
Bundle 'scrooloose/syntastic'
" Colorscheme
Bundle 'vim-scripts/twilight256.vim'
" Allows automatically appending ) after a ( etc
Bundle 'Townk/vim-autoclose'
" Latex support
Bundle 'jcf/vim-latex'
" Fuzzy file, tag, etc finder
Bundle 'kien/ctrlp.vim'
" Git plugin - gives you git blame and other goodies in vim :)
Bundle 'tpope/vim-fugitive'
" Enable all sorts of python goodies (lint, syntax etc.)
Bundle 'klen/python-mode'
" Rust syntax highlighting
" DOESN't work :/
" 'wting/rust'
" Awesome haskell syntax highlighting
Bundle 'dag/vim2hs'
" Scala goodies for vim
Bundle 'derekwyatt/vim-scala'
" List file overview in a sidebar
Bundle 'majutsushi/tagbar'
" cool status line for vim (helpful for buffer tabs)
Bundle 'bling/vim-airline'
" ctrl-w o to zoom in/out on a window split
Bundle 'vim-scripts/ZoomWin'
" syntax highlighting for reactjs
Bundle 'mxw/vim-jsx'
" Syntax highlighting for elm
Bundle 'lambdatoast/elm.vim'
" Haskell devtools for type definitions and declarations
Bundle 'bitc/vim-hdevtools'
" ghc-mod vim integration (type definition, linter, error checker)
Bundle 'eagletmt/ghcmod-vim'
" Interactive cmd runner for 
Bundle 'Shougo/vimproc.vim'

" Don't know how to use this properly...
" Bundle 'c.vim'
""

filetype on
filetype plugin on                  " Enable filetype plugins
filetype indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look and feel settings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show line numbers.
set nu

" Select colorscheme
colorscheme twilight256
"set background=light

" Enable syntax coloring
syntax on

" Enable the use of the mouse for all modes (normal mode, 
" visual mode, insert mode and command line mode)
set mouse=a

" Enable hidden buffers. 
set hidden

" Set wildmenu when we are <tab> to finish command in command mode.
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Set the vim title in the terminal titlebar. 
set title

" Height of the command bar
set cmdheight=2

" Change the font if we are running gui version of vim.
if has("gui_running")
    set gfn=Monaco:h12
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search settings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text edit settings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set ai
set backspace=indent,eol,start
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bind F7 to check if a file has changed.
:map <F7> :checktime<CR>
:map! <F7> <C-O>:checktime<CR>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
"
" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>

" Bind Enable to toggle line numbers. 
nnoremap <F4> :set nu!<CR>

" Bind F3 to to toggle highlight search.
nnoremap <F3> :set hlsearch!<CR>

" Bind leader p to toggle paste and nopaste
nnoremap <leader>p :set paste!<CR>


fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
    endif
endfunction



" Bind leader m to toggle mouse
nnoremap <leader>m :call <SID>ToggleMouse()<CR>
"set mouse=a

map <space> /
map <s-space> ?

" Disable highlight when <leader>c is pressed
map <silent> <leader>c :noh<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree settings. 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bind leader n to open NerdTree.
nnoremap <leader>n :NERDTree .<CR>

let NERDTreeIgnore = ['\.pyc$']

map <C-f> :NERDTreeFind<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status settings and such.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
" Bind leader c to enable to highlight current line.
:hi CursorLine cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkgray guifg=white
:nnoremap <Leader><CR> :set cursorline!<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for LaTeX suit.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Tex_ViewRule_pdf='Preview'
map <f2> :w<cr><leader>ll
map <f3> :w<cr><leader>lv
map <f4> :w<cr><leader>rf
" map <f5> :w<cr><leader>za


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert mode mappings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" inoremap CL console.log();<Esc>hha


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for Powerline.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Setup powerline
"set rtp += ~/.vim/
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
let g:Powerline_symbols = 'fancy'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set tabs for filetypes. 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 nofoldenable
autocmd Filetype html setlocal ts=4 sts=4 sw=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically set go syntax highlighting for .go files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.go setfiletype go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically set go syntax highlighting for .rs files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.rs setfiletype rust

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts for tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap tj :bprevious<CR>
nnoremap tk :bnext<CR>
nnoremap tq :bp <BAR> bd #<CR>
nnoremap tl :ls<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_javascript_checkers=['jsxhint']
let g:syntastic_java_checkers=['javac']
let g:syntastic_haskell_checkers=['hdevtools', 'hlint']
let g:syntastic_rust_checkers=['rustc']
" Skip between next/previous location
nmap <leader>e :lnext<cr>
nmap <leader>E :lprev<cr>
nmap <leader>C :SyntasticCheck<cr>:Errors<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Ctrl-P
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Python-mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pymode_folding = 0
let g:pymode_rope = 0
" let g:pymode_rope_lookup_project = 0
let g:pymode_doc = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python file specific config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable c like macro behavior for '#' at start of line
autocmd FileType python setl nosmartindent
" Mark the 80th column so you can clearly see when you're
" not being pep-8 friendly
autocmd FileType python set colorcolumn=80


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Haskell file specific config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace common haskell stuff with unicode equivalent
" e.g. sum [1,2] becomes Σ [1, 2]
let g:haskell_conceal_wide = 1
" Remove the annoying background color on concealed elements
autocmd FileType haskell hi Conceal ctermbg=NONE

autocmd FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
autocmd FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
autocmd FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

map <silent> tu :call GHC_BrowseAll()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C/C++ file specific config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType cpp map <C-m> :!make run<CR>
