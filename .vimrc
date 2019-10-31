
" Configure indent, space, tab stuff with autocmd for specific file types
autocmd FileType python setlocal tabstop=2 shiftwidth=2 softtabstop=2  textwidth=120 smarttab expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab
autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2  smarttab expandtab
autocmd FileType r setlocal tabstop=2 shiftwidth=2 softtabstop=2  smarttab expandtab
autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2 cindent smartindent expandtab

set autoindent 

" Breaks vi compatibility but solves all related issue
set nocompatible

" Make no swap files. This disables backups, so if you crash without saving, problems.
" My vc and save habits meant it was frequently annoying, rarely helpful.  
set noswapfile

" Options for plugins 

" YouCompleteMe (YCM) 
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_min_num_identifier_candidate_chars = 0
" Max number of semantic completion suggestions
let g:ycm_max_num_candidates = 40
" Max number of identifier completion suggestions
let g:ycm_max_num_identifier_candidates = 10

" ALE linting options
" delay after typing completes to get linting.
let g:ale_completion_delay = 200
let g:ale_completion_max_suggestions = 40
let g:ale_completion_enabled = 0

" Do a filetype set to fix an issue with ansible files
autocmd BufRead,BufNewFile *.yml set filetype=ansible.yaml
autocmd FileType ansible.yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2  smarttab expandtab

" Set specific linters to use based on file type.
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'r': ['lintr'],
\ 'sh': ['language_server','shell','shellcheck'],
\ 'awk': ['gawk'],
\}

" Add colorschemes. I put them in an /opt directory so they need to be loaded manually.
packadd! palenight.vim
packadd! vim-colors-solarized
packadd! gruvbox
packadd! ayu-vim
packadd! nord-vim
packadd! vim-one

" Set the colorscheme for the statusline.
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Fonts and Colorschemes, GUI and Terminal 
" Choose between the colorscheme plugins configured with vundle.
if has('gui_running')
   colorscheme palenight 
   set background=dark
   set guifont=Source\ code\ Pro\ Semibold\ 11
else
   set termguicolors 
   colorscheme gruvbox 
   set background=dark
endif

" General Configurations and settings
"
" line numbers
set number
" Allow hidden buffers, and more than one file in a split
set hidden
" Make backspace work in a sane way even if you won't use it.
set backspace=indent,eol,start
" Basic syntax highlighting. Might need to turn off at some point.
syntax on
" Have vim read changes when they are made to a file
set autoread

" set the leader for custom commands.
let mapleader = "\<Space>" " retain the default, space bar.

" A remap of escape so that exiting edit can be done without Ctrl-C
" apparently Ctrl-C can cause lots of problems.
inoremap jk <Esc> 
" Force use of jk by unmapping the other options
inoremap <C-c> <nop>
" C is control, <nop> means no operation.

" insert lines in normal mode easily
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Get regex without escapes, case insensitive searches
nnoremap / /\v\c
vnoremap / /\v\c

" Easier copy to and paste from system clipboard.
nnoremap <leader>p "+p
nnoremap <leader>y "+y
vnoremap <leader>y "+y
vnoremap <leader>p "+p

" Open quick fix window
nnoremap <leader>fl :copen <cr>
nnoremap <leader>fn :cnext <cr>
nnoremap <leader>fp :cprev <cr>
" work with location window
nnoremap <leader>ll :lopen <cr>
nnoremap <leader>ln :lnext <cr>
nnoremap <leader>lp :prev <cr>

" work with location window
nnoremap <leader>tl :tabn <cr>
nnoremap <leader>th :tabp <cr>

" Fast editing and sourcing of the vimrc file
" First opens for editing, second sources it.
" the <cr> is carriage return so you dont have to hit enter.
nnoremap  <leader>ev  :vsplit $MYVIMRC<cr>
nnoremap  <leader>sv  :source $MYVIMRC<cr>
" Similar command to edit bashrc and source it
nnoremap  <leader>eb  :vsplit ~/.bashrc<cr>
nnoremap  <leader>sb  !source ~/.bashrc<cr>
" And to edit Sources.list
nnoremap  <leader>es  :vsplit /etc/apt/sources.list<cr>

" Toggle NerdTree quickly
nnoremap <leader>nt :NERDTreeToggle<cr>

" Get FZF fuzzy finding more easily. Second one starts it in home dir.
nnoremap <leader>ff :FZF<cr>
nnoremap <leader>fh :FZF ~<cr>
" FZF uses Find as the base, so you can pass find options if
" you want it to act a certain way.

" Allow quick jumping to definitions
nnoremap <leader>ad :ALEGoToDefinition <cr>
nnoremap <leader>avs :ALEGoToDefinitionInVSplit <cr>
nnoremap <leader>as :ALEGoToDefinitionInSplit <cr>
nnoremap <leader>ydl :YcmComplete GoToDeclaration <cr>
nnoremap <leader>ydf :YcmComplete GoToDefinition <cr>
nnoremap <leader>yr :YcmComplete GoToReferences <cr>
