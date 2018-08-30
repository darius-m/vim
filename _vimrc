" Force use of utf-8
set encoding=utf-8

" Add modeline functionality -- it's disabled by default on some distros
set modeline

filetype plugin on

" Mapping from usenet.
imap jj <Esc>

" Per-filetype settings
autocmd FileType java		setlocal tw=78 cin foldmethod=marker
autocmd FileType c,cpp		setlocal tw=80 cindent noexpandtab
autocmd FileType python		setlocal autoindent expandtab sts=4 sw=4 tw=78
autocmd FileType haskell	setlocal tw=72 sw=2 sts=2 et
autocmd FileType tex		setlocal tw=72 sw=2 sts=2 ai et noexpandtab spell spelllang=en_us
" 'linebreak' won't work without 'nolist'
autocmd FileType creole		setlocal tw=0 fo=t wrap nolist linebreak
autocmd FileType mail		setlocal tw=72 fo=tql
autocmd FileType lua		setlocal sts=4 sw=4 ai et
autocmd FileType rust		setlocal cin
autocmd FileType sh		setlocal sts=4 sw=4 si et
autocmd FileType asm		setlocal noexpandtab

" Custom filetypes per extension. Not sure this is the recommended way to do it.
autocmd BufRead,BufNewFile *.wiki setlocal ft=creole
autocmd BufRead,BufNewFile *.tex setlocal ft=tex
autocmd BufRead,BufNewFile *.cool setlocal ft=cool
autocmd BufRead,BufNewFile *.cl setlocal ft=cool
autocmd BufRead,BufNewFile *.miC setlocal ft=C
autocmd BufRead,BufNewFile *.g setlocal ft=antlr
autocmd BufRead,BufNewFile *.rkt setlocal ft=scheme
autocmd BufRead,BufNewFile *.[sS] setlocal ft=asm
autocmd BufRead,BufNewFile *.asm setlocal ft=asm
autocmd BufRead,BufNewFile Makefile.* setlocal ft=make
autocmd BufRead,BufNewFile SConstruct* setlocal ft=python tw=0
autocmd BufRead,BufNewFile SConscript* setlocal ft=python tw=0

" Use vundle for plugin management
set nocompatible
"filetype off
" You will need to install Vundle and YouCompleteMe to use the following
" (commented) lines
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()

"Plugin 'Valloric/YouCompleteMe'

"call vundle#end()
filetype plugin indent on
" vundle end
" Done youcompleteme

set autowrite
set nowrap

" Use /tmp as directory for temporary files
set dir=/tmp

" Ripped off from Alexandru Mosoi
set statusline=%<%f\ %y%h%m%r%=%-24.(0x%02B,%l/%L,%c%V%)\ %P
set laststatus=2
set wildmenu

set softtabstop=4
" /ripoff

" Ripped off from Cosmin Ratiu, on SO list; 30 Jun 2009
if has("cscope")
        " Look for a 'cscope.out' file starting from the current directory,
        " going up to the root directory.
        let s:dirs = split(getcwd(), "/")
        let s:cscope = 0
        let s:ctags = 0
        while s:dirs != []
                let s:path = "/" . join(s:dirs, "/")
                if (s:cscope == 0 && filereadable(s:path . "/cscope.out"))
                        execute "cs add " . s:path . "/cscope.out " . s:path . " -v"
                        let s:cscope = 1
                endif

                if (s:ctags == 0 && filereadable(s:path . "/tags"))
                        execute "set tags=" . s:path . "/tags"
                        let s:ctags = 1
                endif

                if (s:cscope == 1 && s:ctags == 1)
                        break
                endif

                let s:dirs = s:dirs[:-2]
        endwhile

        set csto=0	" Use cscope first, then ctags
        set cst		" Only search cscope
        set csverb	" Make cs verbose

        nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

        nmap <C-\|>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\|>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\|>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\|>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\|>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\|>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-\|>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-\|>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

        " Open a quickfix window for the following queries.
        "set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
endif

" More tabs -- we have enough memory.
set tabpagemax=20

" Mark tabs and spaces
set list listchars=tab:᚛·,

map Q gq

" Highlight current line
set cursorline

" Open new vertical splits to the right of current one.
set splitright

set hidden
set smartcase
set ignorecase

syntax on

nnoremap <F9> :cwindow<CR>
nnoremap <F10> :ccl<CR>

nnoremap - gT
nnoremap = gt
nnoremap <F2> gT
nnoremap <F3> gt

nnoremap <F5> :cp<CR>
nnoremap <F6> :cn<CR>

nnoremap <C-s> nop

vnoremap <C-k> :<C-u>silent! '<,'>m '<-2<CR>`[V`]
vnoremap <C-j> :<C-u>silent! '<,'>m '>+1<CR>`[V`]

nnoremap <silent> <leader>, :noh<cr>

" Set folding options
autocmd ColorScheme * highlight Folded ctermbg=black ctermfg=41
set foldlevel=5
" Fold methods and structures automatically
set foldmethod=syntax

nmap , <leader>
" Toggle folding under the cursor using C-f;
" if in insert mode, return to normal and close fold
nnoremap <C-f> za
inoremap <C-f> <esc>zc
" Toggle foldings file-wide using C-g;
" if used in insert mode, first return to normal mode
nnoremap <C-g> :call ToggleFileFolds()<CR>
inoremap <C-g> <esc>:call ToggleFileFolds()<CR>i
" Make [[ go a little bit further back than the beginning accolade of
" a function, hopefully finding the function name
nnoremap <silent> [[ [[:call search('^[[:alpha:]_]', 'bc')<CR>
" Go to previous buffer when deleting the buffer in stead of killing the
" current split (or tab)
nnoremap <silent> <leader>b :bp\|bd#<CR>

" Make ci\X and di\X commands act similar to ci" and di" respectively
nnoremap <silent> ci( hf(ci(
nnoremap <silent> ci[ hf[ci[
nnoremap <silent> ci{ hf{ci{
nnoremap <silent> di( hf(di(
nnoremap <silent> di[ hf[di[
nnoremap <silent> di{ hf{di{

" Make also C-w work in insert mode
inoremap <silent> <C-w>h <C-o><C-w>h
inoremap <silent> <C-w>j <C-o><C-w>j
inoremap <silent> <C-w>k <C-o><C-w>k
inoremap <silent> <C-w>l <C-o><C-w>l

function ToggleFileFolds()
        if &foldlevel == 0
                normal zR
        else
                normal zM
        endif
endfunction

" Align subsequent lines to open parantheses in C sources.  Via andradaq.
set cinoptions=(0,W4

" Restore position inside previously opened file.  From vim.wikia.
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Set colorscheme and other quality of life stuff
set t_Co=256
colorscheme mopkai

set mouse=i
set completeopt=longest,menuone
set number relativenumber
set colorcolumn=80

" Aid to help with hex editing
command -bar Hex call ToggleHex()
function ToggleHex()
        if !exists("b:editHex") || !b:editHex
                let b:editHex=1
                %!xxd -g1
        else
                let b:editHex=0
                %!xxd -r
        endif
endfunction

command -bar GitBlame execute '!git blame "%" -L ' . line(".") . ',' . line(".")
nnoremap <leader>g :GitBlame<CR>

" Enter key will select a list item, if a list is visible
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Enable recursive search
set path+=**

" Highlight trailing whitespaces
highlight UselessWhitespace ctermbg=darkred
match UselessWhitespace /\s\+$/
autocmd ColorScheme * highlight UselessWhitespace ctermbg=darkred

set bs=2
