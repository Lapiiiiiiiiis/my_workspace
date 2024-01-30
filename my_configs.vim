set nu
set cursorline
set showcmd


if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

nmap <C-_>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>a :scs find a <C-R>=expand("<cword>")<CR><CR>
