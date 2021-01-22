" *****************************************************************************
"   PLUG PACKAGES                                                             *
" *****************************************************************************
call plug#begin(expand('~/.config/nvim/plugged'))
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'  " Git commands in vim terminal
  Plug 'Raimondi/delimitMate' " Automating closing of quotes
  Plug 'dense-analysis/ale' " Lintern, Go to definition, finding reference, etc
  Plug 'Yggdroot/indentLine' " Display vertical lines at each identation level
  Plug 'itchyny/lightline.vim' " StatusBar
  Plug 'ctrlpvim/ctrlp.vim' " Search files
  Plug 'morhetz/gruvbox' " Theme
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Dependence of fzf.vim
  Plug 'junegunn/fzf.vim' " Search words, need to install ag in so
  Plug 'mattn/emmet-vim' " HTML emmet
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ } " Solargraph
call plug#end()

" *****************************************************************************
"   SET                                                                       *
" *****************************************************************************

set number
set tabstop=2 shiftwidth=2 expandtab
set colorcolumn=80

" *****************************************************************************
"   LET                                                                       *
" *****************************************************************************

" Custom configuration to show branchanme in status bar
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

"  Tell ale to debugg ruby files with Rubocop
let g:ale_fixers = {
      \    'ruby': ['rubocop'],
      \}

" Don't send stop signal to Solargraph server
let g:LanguageClient_autoStop = 0

" Use default IP and port to run Solargraph
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['tcp://localhost:7658']
    \ }

" *****************************************************************************
"   NNOREMAP                                                                  *
" *****************************************************************************

nnoremap <F3> :NERDTreeToggle <CR>

" Remap key for solargraph, currently solargraph don't work :(
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Remap key to switch between tabs
nnoremap tl  :tabnext<CR>
nnoremap th  :tabprev<CR>

" Rempay key for open word search
nnoremap <C-i> :Ag <Cr>

" *****************************************************************************
"   ANOTHER CONFIGS                                                           *
" *****************************************************************************

syntax on

" Configure ruby omni-completion to use the language client:
autocmd FileType ruby setlocal omnifunc=LanguageClient#complete

" Remove Whitespaces when save file
autocmd BufWritePre * :%s/\s\+$//e

" Set gruvbox theme
autocmd vimenter * ++nested colorscheme gruvbox

