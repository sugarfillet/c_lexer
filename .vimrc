" Simple vim setup with some essential plugins
"
"   pathogen - https://github.com/tpope/vim-pathogen
"   taglist.vim - http://www.vim.org/scripts/script.php?script_id=273
"   NERD Tree - http://www.vim.org/scripts/script.php?script_id=1658
"   fugitive.vim -- http://www.vim.org/scripts/script.php?script_id=2975
"
"   INSTALL INSTRUCTIONS:
"     mkdir -p ~/.vim/autoload ~/.vim/bundle
"     cd ~/.vim/bundle
"     git clone https://github.com/tpope/vim-pathogen.git
"     git clone https://github.com/scrooloose/nerdtree.git
"     git clone https://github.com/tpope/vim-fugitive.git
"     git clone https://github.com/vim-scripts/taglist.vim.git
"     cd ~/.vim/autoload ; ln -s ../bundle/vim-pathogen/autoload/pathogen.vim

if filereadable(expand("$HOME/.vim/autoload/pathogen.vim"))
  silent! call pathogen#infect()
endif

syntax on
filetype plugin indent on

set timeoutlen=450  " Time to wait after ESC (default causes an annoying delay)
set ts=2
set sw=2
set expandtab
set bg=dark


" Don't use Ex mode, use Q for formatting
map Q gq
let maplocalleader = "," 

""""" Settings for NERDTree
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nmap <LocalLeader>nn :NERDTreeToggle<cr>

" ---------------------------------------------------------------------------
""""" Settings for taglist.vim
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1
nmap <LocalLeader>tt :Tlist<cr>
