set nocompatible

" git-plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" -- Plugin not needed for vim-zoom; functionality is built in:
"     zoom current window, if vertical:   <Ctrl-W>|
"     zoom current window, if horizontal: <Ctrl-W>_
"     restore:                            <Ctrl-W>=
"     ... works, but that 'restore' really makes all windows have the equal size
" -- Notes:
"     https://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
 
" -- Shorthand for: https://github.com/dhruvasagar/vim-zoom
" -- Use <Ctrl-W>m to toggle zoom of current window
Plug 'dhruvasagar/vim-zoom'

" CtrlP
"   - http://ctrlpvim.github.io/ctrlp.vim/#installation
"   - CtrlP
Plug 'ctrlpvim/ctrlp.vim'

" -- Buffergator (via https://vimawesome.com/plugin/buffergator)
" -- use \b to summon
" -- docs: https://github.com/jeetsukumaran/vim-buffergator/blob/master/doc/buffergator.txt
" -- local docs:
Plug 'jeetsukumaran/vim-buffergator'

" C2H - use :C2H to switch from cpp to h file.  Bound to '#' below.
Plug 'linluk/vim-c2h'

" Initialize plugin system (Use PlugInstall to install newly-added plugins.)
call plug#end()

" Buffergator configuration {{{
" --- could sort buffers like I want (sort_regime=filepath)
" --- could not find a way to iterate prev/next in displayed (sorted) order;
"     it always uses MRU order
let g:buffergator_autodismiss_on_select = 0
let g:buffergator_autoupdate = 1
let g:buffergator_mru_cycle_local_to_window = 0
let g:buffergator_show_full_directory_path = 0
let g:buffergator_display_regime = "basename"
let g:buffergator_sort_regime = "bufnum"

" enable to display Buffergator at startup, then move focus back to the file
"autocmd VimEnter * BuffergatorOpen
"autocmd VimEnter * wincmd w
" }}}

" CtrlP configuration {{{
" ref: https://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_root_markers = ['basics']
" }}}

" Allow finding tags file.
set tags=tags;

filetype off

set viminfo='20,\"50             " read/write a .viminfo file, don't store more
			                           " than 50 lines of registers
set history=50                   " keep 50 lines of command line history
set ruler                        " show the cursor position all the time
set bs=2                         " always backspace
set hlsearch                     " Highlihting the last used search pattern
set incsearch                    " Incremental searching
set restorescreen                " Restore the screen at exit
set ls=2                         " Always display the status line
set noshowmatch

if has("syntax")
  syntax on                     " Syntax highlighting
endif

" Make home/end work
map <ESC>[H <Home>
map <ESC>[F <End>
map! <ESC>[H <Home>
map! <ESC>[F <End>

" Map the delete key and the backspace key
map <ESC>[3~ x
map <C-?> <C-H>
map! <C-?> <C-H>
map! <C-?> <C-H>


" Set conforming indenting
set ts=2
set sw=2
set et

set smartindent

let showmarks_enable=0

set nowrap

" If editing a changelog, don't expand tabs - note that setlocal is needed
" to only affect the buffer with the file of that filetype.
autocmd FileType changelog setlocal noexpandtab
autocmd FileType ChangeLog setlocal noexpandtab
autocmd FileType make setlocal noexpandtab

" disable automatic comment continuation for specific filetypes:
autocmd FileType h,c,cpp setlocal formatoptions-=c
autocmd FileType h,c,cpp setlocal formatoptions-=r
autocmd FileType h,c,cpp setlocal formatoptions-=o

" Prevent smartindent's forcing of # chars to the
" beginning of the line.  See :help smartindent
" inoremap # X#

" turn off the beep and visual bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" make it so lots of files get opened at once;
" this fixes the ^^ problem, where ^^ or :n would
" be disallowed because there were changes to the
" current file that weren't saved.
set hid

" from Dave Paul:
set guioptions-=m
set guioptions-=T " don't want no stupid toolbar or menu

" map Control-K and Control-L to previous and next buffers,
" respectively; this requires the 'set hid', above to 
" work in a good way.
noremap <C-k> :bp<CR>
inoremap <C-k> <Esc>:bp<CR>
noremap <C-l> :bn<CR>
inoremap <C-l> <Esc>:bn<CR>
" --- end from Dave

" map # (in non-editing mode) to :C2H, using plugin
noremap # :C2H<CR>

" map equals (=) in command mode to :noh,
" to hide the selection; same key as vile.
noremap <Char-61> :noh<CR>

" abbreviation expansions (in insert mode), depending on current work
iabbrev #l line_handler_tradeweb_institutional_rfq_reply
iabbrev #t tradeweb_institutional
iabbrev #T TradewebInstitutional

" put swap files somewhere else, so they don't
" annoy the config server
" if has("win32")
" 	set dir=%TEMP%\\vimtmp
" else
" 	set dir=~/.vimtmp
" 	" other unix settings; set guifont:
" 	set guifont=DejaVu\ Sans\ Mono\ 9
" 
" 	" make the clipboard work right
" 	set clipboard=unnamed
" endif

" turn on line numbers
set number

" ruler stuff has no effect with custom status line...
set ruler
set rulerformat=%24(L\ %4l/%4L\ (%P)\ C%3v%)


" show the status bar all the time
set laststatus=2

" ... but it was tough to get this right, and I gave up and settled
" with just the rulerformat above.
" --- set statusline=%-70(%r%m%h%w\ %t\ (%f)\ %y%)%25(L\ %4l/%4L\ (%P)\ C\ %4c%)

set showcmd
set showmode

" highlight search matches, enable incremental searching
set hlsearch
set incsearch

" smartcase will turn off ignorecase if the search
" string has upper-case letters
set ignorecase
set smartcase

if &term == "screen"
  set t_Co=256
endif

" set the color scheme
" colorscheme koehle
" colorscheme desert256

" hi WarningMsg	  term=standout  cterm=bold  ctermfg=white  guifg=white
" hi PreProc		  term=underline  ctermfg=darkgrey	guifg=darkgrey
hi StatusLine   term=bold           cterm=bold          ctermfg=black   guifg=black   ctermbg=yellow  guibg=yellow
hi StatusLineNC term=bold           cterm=bold          ctermfg=black   guifg=black   ctermbg=white   guibg=white
hi Search       term=bold           cterm=bold          ctermfg=black   guifg=black   ctermbg=yellow  guifg=yellow

" prevent clobbering the terminal's background color
hi Normal ctermbg=none                                    
hi NonText ctermbg=none

set fdm=marker
set foldlevel=999

