
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


"Function to show current working directory
function! CurDir()
	let curdir = substitute(getcwd(), '/Users/simon/', "~/", "g")
	return curdir
endfunction
 
"Function to show whether you are in paste mode or not
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	else
		return ''
	endif
endfunction



"show line number 
set number

" Enable syntax highlighting
syntax enable

colorscheme desert
set background=dark


" Highlight search results
:set hlsearch


" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8



" Use Unix as the standard file type
:set ffs=unix,dos,mac



" Use spaces instead of tabs
:set expandtab


