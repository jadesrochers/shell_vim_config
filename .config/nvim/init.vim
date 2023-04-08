 " Indicate which plugins to install
  call plug#begin('~/.local/share/nvim/plugged')
  Plug 'tpope/vim-commentary'
  " This is the old command to set up fzf, but it worked well on linux
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
  " This is the new one, might have been a fluke but did not work
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  " For help - :help fzf
  Plug 'junegunn/fzf.vim'
  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  Plug 'Vimjas/vim-python-pep8-indent'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'zchee/deoplete-jedi'
  " For markdown syntax highlight
  Plug 'tpope/vim-markdown'
  " Color scheme
  Plug 'sainnhe/sonokai'
  call plug#end()
  " :PlugInstall       to install all
  " :PlugUpdate        Update them
  " :PlugStatus        Check status, shows if they installed right

  " Enable deoplete by default
  let g:deoplete#enable_at_startup = 1

  " Syntax highlight stuff
  " Important!!
  if has('termguicolors')
    set termguicolors
  endif
  " Colorshceme config - optional, checkout https://github.com/sainnhe/sonokai/blob/master/doc/sonokai.txt
  " let g:sonokai_style = 'Maia' 
  " then activate it
  colorscheme sonokai

  " line numbers
  set number
  " Allow hidden buffers, and more than one file in a split
  set hidden
  " Make backspace work in a sane way even if you won't use it.
  set backspace=indent,eol,start
  " Have vim read changes when they are made to a file
  set autoread

  " Try and work out why my file spacing/indenting is not working in any way
  " and in fact seems completely wrong
  :filetype on
  autocmd FileType python setlocal expandtab smartindent ts=4 sw=4 textwidth=120 fileformat=unix
  autocmd FileType javascript setlocal expandtab smartindent ts=4 sw=4 sts=4 
  autocmd FileType javascriptreact setlocal expandtab smartindent ts=4 sw=4 sts=4 
  autocmd FileType html setlocal expandtab smartindent ts=2 sw=2 sts=2 
  autocmd FileType css setlocal expandtab smartindent ts=4 sw=4 sts=4

  " set the leader for custom commands.
  let mapleader = "\<Space>" " retain the default, space bar.

  " A remap of escape so that exiting edit can be done without Ctrl-C
  " apparently Ctrl-C can cause lots of problems.
  inoremap jj <Esc>

  " Easier copy to and paste from system clipboard.
  nnoremap <leader>p "+p
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  vnoremap <leader>p "+p

  " To find more options, :h fzf-vim-commands
  " Fuzzy search all file names
  nnoremap <leader>fa :Files<cr>
  " Fuzzy search all file names under git tracking
  nnoremap <leader>fg :GFiles<cr>
  " Fuzzy search buffer names
  nnoremap <leader>fb :Buffers <cr>
  " Fzf and Ripgrep to grep search both name and contents
  nnoremap <leader>fn :Rg <cr>
  " Find in lines of buffers currently open
  nnoremap <leader>fl :Lines <cr>
  " Find in Command History
  nnoremap <leader>fh :History: <cr>
  " Find in Search History
  nnoremap <leader>fs :History/ <cr>


