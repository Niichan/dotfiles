colorscheme zenburn

execute pathogen#infect()

syntax on
filetype plugin indent on

set whichwrap=<,>,[,],b,
set backspace=indent,eol,start
set ruler
set number
set background=dark
set autoread
"set mouse=a

" Leader
let mapleader = ","
let g:mapleader = ","
nmap <leader>w :w!<cr>

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" But also have C-like languages use C spacing
" Thanks much jdhore
set ai
au BufRead,BufNewFile *.c,*.h,*.cpp,*.cxx,*.hpp,*.cc,*.c++,*.hh,*.hxx,*.ipp,*.moc,*.tcc,*.inl set cindent
au BufRead,BufNewFile *.c,*.h,*.cpp,*.cxx,*.hpp,*.cc,*.c++,*.hh,*.hxx,*.ipp,*.moc,*.tcc,*.inl set tabstop=8
au BufRead,BufNewFile *.c,*.h,*.cpp,*.cxx,*.hpp,*.cc,*.c++,*.hh,*.hxx,*.ipp,*.moc,*.tcc,*.inl set shiftwidth=8
set cinoptions=>s,e0,n0,f0,{0,}0,^0,=s,ps,t0,c3,+s,(2s,us,)20,*30,gs,hs

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
au Filetype lolcode setl et ts=4 sw=4

au BufRead APKBUILD setl noexpandtab softtabstop=0 tabstop=4 shiftwidth=4 nosmarttab

set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Default settings
"set tabstop=4
"set softtabstop=4
"set shiftwidth=4
"set nowrap
"set smarttab

set encoding=utf-8

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
	let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline,
	"")
	call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

command WQ wq
command Wq wq
command W w
command Q q

set ls=2

set wildmenu
set wildignore=*.o,*~,*.pyc

" Delete extra spaces 4 at a time
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Paste macros
" Thanks to jdhore
map <F8> :set paste<CR>
map <F9> :set nopaste<CR>
imap <F8> <C-O>:set paste<CR>
imap <F9> <nop>
set pastetoggle=<F9>
map <F3> gg=G:w<cr>

" Lvimrc
" if .lvimrc exists in parent directory of loaded file, load it as config
let lvimrc_path = expand('%:p:h') . '/.lvimrc'
if filereadable(lvimrc_path)
	execute 'so' lvimrc_path
endif

" Color column definition
let &colorcolumn="80,".join(range(121,999),",")
highlight ColorColumn ctermbg=52

" resume at line
autocmd BufReadPost *
			\ if ! exists("g:leave_my_cursor_position_alone") |
			\     if line("'\"") > 0 && line ("'\"") <= line("$") |
			\         exe "normal g'\"" |
			\     endif |
			\ endif

" text files at 78 cols
autocmd BufNewFile,BufRead *.txt
			\ if &tw == 0 && ! exists("g:leave_my_textwidth_alone") |
			\     setlocal textwidth=78 |
			\ endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" Spellchecking
map <leader>ss :setlocal spell!<cr>

" Gist
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_show_privates = 1
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

