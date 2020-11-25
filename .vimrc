set spell spelllang=en_us
" configure decent default of tab/shift and expandtab
" such that any file opened does not use tabs
set tabstop=2 shiftwidth=2 expandtab smarttab
" Configure indent, space, tab stuff with autocmd for specific file types
set autoindent 
autocmd FileType python setlocal tabstop=2 shiftwidth=2 textwidth=120 smarttab expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 smarttab expandtab
autocmd FileType css setlocal tabstop=2 shiftwidth=2 smarttab expandtab
autocmd FileType sh setlocal tabstop=2 shiftwidth=2 smarttab expandtab
autocmd FileType r setlocal tabstop=2 shiftwidth=2 smarttab expandtab
autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 cindent smartindent expandtab

" get commentary working better on random file types
autocmd FileType conf setlocal commentstring=#\ %s

" Breaks vi compatibility but solves all related issue
set nocompatible

" turn off the noises
set belloff=all

" Make no swap files. This disables backups, so if you crash without saving, problems.
" My vc and save habits meant it was frequently annoying, rarely helpful.  
set noswapfile
set nobackup
set nowritebackup

" Basic syntax highlighting. Needed to run polyglot.
syntax on

" command bar height, helps with coc appearance
set cmdheight=2

" Add fzf to rtp because apparently it needs that too
set rtp+=~/.fzf

" Options for plugins 

" Vim polyglot (syntax highlighting) turn off some languages I never use
" mostly to remind me that this is the syntax plugin I use.  
let g:polyglot_disabled = ['go', 'rust', 'c++']


" ALE linting options
" delay after typing completes to get linting.
let g:ale_completion_delay = 200
let g:ale_completion_max_suggestions = 40
let g:ale_completion_enabled = 1

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
" Have vim read changes when they are made to a file
set autoread

" set the leader for custom commands.
let mapleader = "\<Space>" " retain the default, space bar.

" A remap of escape so that exiting edit can be done without Ctrl-C
" apparently Ctrl-C can cause lots of problems.
inoremap jk <Esc> 
" Force use of jk by unmapping the other options
" inoremap <C-c> <nop>
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
nnoremap <leader>qn :cnext <cr>
nnoremap <leader>qp :cprev <cr>
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

" stop fzf Rg from searching file names.  
" Figure out what this does for vimscript exprience
command! -bang -nargs=* Rc call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Fuzzy search all file names
nnoremap <leader>fa :Files<cr>
" Fuzzy search all file names under git tracking
nnoremap <leader>fg :GFiles<cr>
" Fuzzy search buffer names
nnoremap <leader>fb :Buffers <cr>
" Fzf and Ripgrep to search only in file contents
nnoremap <leader>fc :Rc <cr>
" Fzf and Ripgrep to grep search both name and contents
nnoremap <leader>fn :Rg <cr>
" Find in lines of buffers currently open
nnoremap <leader>fl :Lines <cr>



" setup for coc.vim. Not all needed, but see what you do use,
" and weed out what you dont.

" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>r  <Plug>(coc-format-selected)
nmap <leader>r  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>cp  :<C-u>CocListResume<CR>
