set nocompatible
filetype off
set number
set showmatch
set incsearch
set cursorline
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

"Plugin to manage plugin
Bundle 'gmarik/vundle'
"Plugin for spell checker
"Nothing to do, check when file saving
Bundle 'scrooloose/syntastic'
"Bottom status bar, no need to tune for now
Bundle 'bling/vim-airline'
set laststatus=2
"Bundle 'mhinz/vim-startify'
"Solarized color for vim nothing to do
Bundle 'altercation/vim-colors-solarized'
"Undo tree appears on left panel when F5 press
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/clearsilver'
Bundle 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>
"Use to move into the file, '\\w' to match word for example read docs
Bundle 'Lokaltog/vim-easymotion'
"Language pack for syntax/indent
Bundle 'sheerun/vim-polyglot'
"Snippets pack, look inside .vim/bundle/vim-snippets/snippets
"Example #!<TAB> generate a shabang
Bundle 'honza/vim-snippets'
"Need Exuberant-ctags so disable for now
"Bundle 'majutsushi/tagbar'
"Snippets managers
Bundle 'SirVer/ultisnips'
"let g:UltiSnipsExpandTrigger="<c-tab>"
"Commentary manager 'gcc' to comment a line for example
Bundle 'tpope/vim-commentary'
"Testing a new tab completioner
"Need install cmake & launch ~/.vim/bundle/youcompleteme/install.sh
"CTRL+E to complete snippets see function to the end of vimrc
"Bundle 'Valloric/YouCompleteMe'
" Bundle 'ervandew/supertab'
"Some interesting default options for vim
Bundle 'tpope/vim-sensible'
"tmux integration for vim
Bundle 'benmills/vimux'
"Prompt for a command to run map need to vim into tmux
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vm :VimuxPromptCommand("make ")<CR>
"open a file easyly with <CTRL+P>
Bundle 'kien/ctrlp.vim'
"Vimux with some python utils : C-c execute the selected block in ipython
"None functional  
Bundle 'DavidEGx/ctrlp-smarttabs'

Bundle 'julienr/vimux-pyutils'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "X"
let g:syntastic_warning_symbol = "X"


filetype plugin indent on " Whatss Fuc ??



function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
nmap <silent> <F3> :NERDTreeToggle<CR>
let g:ctrlp_extensions = ['smarttabs']
" pluging pour CtrlP tab next/forward touche F4
nnoremap <F4> :CtrlPSmartTabs<CR>
