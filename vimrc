set number

if has("cscope")
        set csprg=/usr/bin/cscope
        set csto=1
        set cst
        set nocsverb
        if filereadable("cscope.out")
           cs add cscope.out
        endif
        set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

set foldmethod=syntax
set foldlevel=100
set foldcolumn=0

" for taggggg
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
let g:tablineclosebutton=1


" for nerdtree
" auto exit if nothing left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" key mapping nerdtree toggle 
map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeMirror<CR>
" auto start nt tabs on start
let g:nerdtree_tabs_open_on_console_startup=1
let Tlist_Use_Right_Window=1


