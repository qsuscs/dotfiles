"set encoding=utf-8
"set guifont=-adobe-courier-medium-r-normal-*-*-100-*-*-m-*-iso10646-1
"set guifontwide=-adobe-courier-medium-r-normal-*-*-100-*-*-m-*-iso10646-1

" vim-plug autoinstall with validation, because I'm paranoid
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/08e78d8a5ea874bebbd7f39de7bb540d9b539963/plug.vim
  if sha256(join(readfile(glob('~/.vim/autoload/plug.vim'), 'b'), "\n")) == 'dfe8982d428de33f2b1315d77f479aa1d354d25d37ae2d2dc105353847022270'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  else
    call delete(glob('~/.vim/autoload/plug.vim'))
  endif
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/DirDiff.vim', { 'commit': '6c111f8b10c464afa45c6b62820bf3b50828c627' }
Plug 'vim-scripts/LargeFile', { 'commit': '3941a37b2b0288524300348a39521a46539bf9f6' }
Plug 'exvim/ex-matchit', { 'commit': 'f0ef9f72a5ef37fd69981a5246fd834039f65b90' }
Plug 'vim-scripts/info.vim', { 'commit': '520a2b33a035770504b37041f12d9017ee213d70' }
Plug 'jneen/ragel.vim', { 'commit': '898a06e8e0e48b4d589949a29fb511090cdf3f45' }
Plug 'vim-scripts/taglist.vim', { 'commit': '53041fbc45398a9af631a20657e109707a455339' }
Plug 'cbracken/vala.vim', { 'commit': '6fdc58c98bdd1e2b10bfbe9999c8a95457b3cd2f' }
Plug 'nvie/vim-flake8', { 'commit': 'a806163181ad41ec036096a2f235871682fd64cf' }
Plug 'tpope/vim-fugitive', { 'commit': 'd4fb2a2f5c2023f477beae6aef47cf0457351e6e' }
Plug 'airblade/vim-gitgutter', { 'commit': '50a7062909d91a290fae04219887b1b45f3138db' }
Plug 'jamessan/vim-gnupg', { 'commit': '22cbc6b6ab1623edd2e325d256245d21580f912a' }
Plug 'cespare/vim-toml', { 'commit': '85ba8277a6e331a56fce920d62bfdacce5bc5a80' }
call plug#end()

if has("gui_gtk")
	set guifont=Bitstream\ Vera\ Sans\ Mono\ Bold\ 10
endif

" overwrite default
set nocompatible
set modelines=5
set backspace=start,indent,eol
set laststatus=2
set showcmd
set showmatch
set ignorecase
set incsearch
set hlsearch
set magic
set autowrite
set nostartofline
set visualbell
set whichwrap=b,s,h,l,<,>,[,]
set colorcolumn=80

" I want -w instead of -b
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-w ' | endif
  if has("gui_win32")
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        let cmd = '""' . $VIMRUNTIME . '\diff"'
        let eq = '"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
  else
    silent execute "!diff " . opt . v:fname_in . " " . v:fname_new .
	\  " > " . v:fname_out
  endif
endfunction

" windows and buffers
set hidden
set winheight=5
set statusline=%1*[%n]%*\ %<%f\ %(%2*(%H%M%R%Y)%*%)%=%-10(%3*[%3b,%2B]%*%)\ %-14.(%l,%c%V%)\ %P

"colorscheme tobias1
" in color scheme
set background=dark
hi Normal guifg=white guibg=black
hi StatusLine   cterm=none ctermfg=white ctermbg=darkblue gui=bold guifg=white guibg=darkblue
hi User1 ctermfg=red    ctermbg=darkblue guifg=red    guibg=darkblue
hi User2 ctermfg=cyan   ctermbg=darkblue guifg=cyan   guibg=darkblue
hi User3 ctermfg=yellow ctermbg=darkblue guifg=yellow guibg=darkblue
hi SpecialKey   ctermfg=3 guifg=#444444

" mouse stuff (I don't want mouse support in console vim)
if !has("gui_running")
  set mouse=
endif
set mousemodel=popup_setpos

" linebreak and list don't work together... :(
"set linebreak
" cool invisible chars
set showbreak=◣
set list listchars=tab:»·,trail:·
" Here to test - here is a very long line to test the showbreak command and my terminals are getting longer and longer... The last things on these lines is a testcase for list and listchars 	      

" Funny things for completion:
set complete=.,w,b,u,t,i,k
set dictionary+=/usr/share/dict/american-english

" syntax!
syntax on
filetype plugin indent on

" key mappings
set pastetoggle=<F8>
map <F8>  :set paste?<CR>
map <silent> <c-l> :silent nohl<CR>

" spell
map <F9>   :setlocal spell spelllang=de_20<CR>
map <S-F9> :setlocal spell spelllang=en_gb<CR>
map <esc><F9> :setlocal nospell<CR>

" tags
map <C-E> <C-]>
set tags+=./tags;

" filetype plugin for Io
au BufNewFile,BufRead *.io			setf io

" restore old behavior
map Q gq

" ===================================================================
" VIM - Editing and updating the vimrc:
" As I often make changes to this file I use these commands
" to start editing it and also update it:
  if has("unix")
    let vimrc='~/.vimrc'
  else
" ie:  if has("dos16") || has("dos32") || has("win32")
    let vimrc='$VIM\_vimrc'
  endif
  nn  ,u :source <C-R>=vimrc<CR><CR>
  nn  ,v :edit   <C-R>=vimrc<CR><CR>
" ===================================================================

"       ,# = comment current inner paragraph with '#':
nmap ,#   vip:s/^/#/<CR>
"       ,# = comment current text selection  with '#':
vmap ,#      :s/^/#/<CR>
" 001006:  Commenting selected lines in C style:
vmap ,c :s#^#// #<cr>'<O/*<esc>'>o*/<esc>gv

" DirDiff
let g:DirDiffExcludes = ".svn,.*.swp"
let g:DirDiffSort = 0
let g:DirDiffDynamicDiffText = 0

" Options for specific projects
au BufNewFile,BufRead */dosage/*	set expandtab sw=4 sts=4
