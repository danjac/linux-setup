syntax on
filetype on
filetype plugin indent on

"Open each buffer in its own tabpage
"set hidden
"set switchbuf=useopen
":au BufAdd,BufNewFile * nested tab sball

noremap <F3> :Autoformat<CR><CR>

"set background=dark
"colorscheme wombat
"colorscheme zenburn
"colorscheme wombat
"colorscheme molokai
"colorscheme solarized
"colorscheme github
"colorscheme twilight
"colorscheme slate
"colorscheme guardian
"colorscheme underwater
"colorscheme autumnleaf

if has('gui_running')
    set guioptions-=T
    set guioptions-=m
    "colorscheme github
    "colorscheme Tomorrow-Night
    colorscheme molokai
    " ------------------------------------------------------------------
    " Solarized Colorscheme Config
    " ------------------------------------------------------------------
    "#let g:solarized_contrast="high"    "default value is normal
    "let g:solarized_visibility="high"    "default value is normal
    "let g:solarized_diffmode="high"    "default value is normal
    "let g:solarized_hitrail=1    "default value is 0
    syntax enable
    "set background=dark
    " ------------------------------------------------------------------

    "autocmd VimEnter * NERDTree " enter NERDTree automatically when entering VIM
    "autocmd BufEnter * NERDTreeMirror " add folder tree to the left hand side for each tab
    "autocmd VimEnter * wincmd p " not sure, seems to add color :D

endif

autocmd BufWritePre *.go Fmt
autocmd BufWritePre *.py Autoformat
autocmd BufWritePre *.js Autoformat
autocmd BufWritePre *.html Autoformat

set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

nnoremap <F5> :GundoToggle<CR>

" Remove all trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


"autocmd BufWritePre *.py :%s/\s\+$//e
"autocmd BufWritePre * $put _ | $;?\(^\s*$\)\@!?+1,$d

"call pathogen#runtime_append_all_bundles()
call pathogen#infect()

"let g:syntastic_python_checker="flake8"

:hi LineNr ctermfg=darkgreen
:hi Comment ctermfg=darkgreen

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

:set title
:set nocompatible
:set tabstop=4
":set foldmethod=syntax
:set foldlevel=99
:set shiftwidth=4
:set autoindent
:set expandtab
:set ruler
:set incsearch
:set ignorecase
:set hlsearch
:set smarttab
:set smartindent
:set number
:set backupdir=~/.vimswaps,/tmp
:set guifont=Droid\ Sans\ Mono\ 9
:set shellslash
:set grepprg=grep\ -nH\ $*
:set tags=./tags;
:set mouse=""
:set fileformat=unix

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

noremap \ptags :! find . -name \*.py -print \| xargs $HOME/ptags

let g:tex_flavor='latex'

au BufNewFile * :exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')

autocmd FileType python highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType python match OverLength /\%81v.*/
"autocmd FileType python set omnifunc=pythoncomplete#Complete

au FileType coffee setl sw=2 sts=2 et
"au FileType javascript setl sw=2 sts=2 et
au FileType ruby setl sw=2 sts=2 et

au BufRead * try | execute "compiler ".&filetype | catch /./ | endtry

au BufNewFile,BufRead *.mak set filetype=mako
au BufNewFile,BufRead *.mako set filetype=mako

:vmap tg di_(<ESC>pa)<ESC>
:vmap tj di{{ _('<ESC>pa') }}<ESC>

"Open file at last position

if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif

"let g:pyflakes_use_quickfix = 0
let ropevim_vim_completion=1

"autocmd BufWritePost *.py call Flake8()

"show numbered tabs in gvim
set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
