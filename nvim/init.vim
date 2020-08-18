"  __  __       _   _       _
" |  \/  |_   _| \ | |_   _(_)_ __ ___  _ __ ___
" | |\/| | | | |  \| \ \ / / | '_ ` _ \| '__/ __|
" | |  | | |_| | |\  |\ V /| | | | | | | | | (__
" |_|  |_|\__, |_| \_| \_/ |_|_| |_| |_|_|  \___|
"         |___/
"           * Originated by Rainbow Chen *

" Auto load plugs for the first time uses
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let s:vim_cachedir = $HOME. "/.cache/nvim/"

" nocompatible mode
set nocompatible
" open filetype, plugin, indent
filetype plugin indent on
" syntax enable
syntax on

set encoding=utf-8
set title
set autoread
set number
set relativenumber
set cursorline
set wrap
set showcmd
set ruler
set wildmenu
set history=100
" for map timeout
set timeout
set timeoutlen=1500
" for keycode timeout
set nottimeout
set hlsearch
set incsearch
set ignorecase
set smartcase
set whichwrap=b,s
set shiftwidth=4
set tabstop=4
set softtabstop=4
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=6
set autoindent
set smartindent
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
" disable textwidth auto wrap
set formatoptions=q
set laststatus=2
" set working directory to the current file
set updatetime=100
set updatecount=100
set autochdir
set indentexpr=
set lazyredraw
set virtualedit=block
set termguicolors
set noshowmode
" shutdown the error bell
set noerrorbells
set novisualbell
set vb t_vb=
" recommender render 256 colors
set t_Co=256
" for preview of the substitue
set inccommand=split

" swap file
let &directory = s:vim_cachedir. "swap"
" file backup
let &backupdir = s:vim_cachedir. "backup"
" undo file
let &undodir = s:vim_cachedir. "undo"
" view file
let &viewdir = s:vim_cachedir. "view"
" shada file
let &shadafile = s:vim_cachedir. "shada"

" file path of swap, backup, undo, view and vimtex&vista plugin files
for d in [ &directory, &backupdir, &undodir, &viewdir,
	 \ s:vim_cachedir."vimtex", s:vim_cachedir."vista" ]
    call mkdir(d, "p", 0700)
endfor

set backup
set backupext=.bak
set undofile
set shada='1000,f1,<500

" cursor shape in i mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" cursor shape in r mode
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" cursor shape in normal mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" let vim with terminal be better
let &t_ut = ''

" go back the last line where you quit vim
autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                  \ |   exe "normal! g`\"" | endif
" automatically deletes all trailing whitespace and newlines at end of file on save
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" leader map
let g:mapleader=" "

" make task run on floaterm
function! s:runner_proc(opts)
  let curr_bufnr = floaterm#curr()
  if has_key(a:opts, 'silent') && a:opts.silent == 1
    FloatermHide!
  endif
  let cmd = 'cd ' . shellescape(getcwd())
  call floaterm#terminal#send(curr_bufnr, [cmd])
  call floaterm#terminal#send(curr_bufnr, [a:opts.cmd])
  stopinsert
  if &filetype == 'floaterm' && g:floaterm_autoinsert
    call floaterm#util#startinsert()
  endif
endfunction

let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.floaterm = function('s:runner_proc')
let g:asynctasks_term_pos = 'floaterm'

" Compile function
func! FileRun()
    exec "w"
    if &filetype == 'markdown'
	exec "MarkdownPreview"
    elseif &filetype == 'tex'
	silent! exec "VimtexStop"
	silent! exec "VimtexCompile"
    else
	set splitbelow
	exec "AsyncTask file-run"
    endif
endfunc

call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}
Plug 'mzlogin/vim-markdown-toc'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/vim-easy-align'
Plug 'Chiel92/vim-autoformat'
Plug 'liuchengxu/vista.vim'
Plug 'kshenoy/vim-signature'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-xtabline'
Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'lambdalisue/suda.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'voldikss/vim-floaterm'
Plug 'metakirby5/codi.vim'
Plug 'wellle/targets.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'andymass/vim-matchup'
Plug 'osyo-manga/vim-anzu'
Plug 'tpope/vim-repeat'
" Plug 'brooth/far.vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" themes
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'connorholyday/vim-snazzy'
Plug 'arzg/vim-colors-xcode'
Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'
Plug 'nerdypepper/agila.vim'

call plug#end()

" ayu
let ayucolor = "mirage"

"onedark
let g:onedark_terminal_italics = 1

" nord
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

" xcode
augroup vim-colors-xcode
    autocmd!
augroup END
autocmd vim-colors-xcode ColorScheme * hi Comment cterm=italic gui=italic
autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italic

" gruvbox
let g:gruvbox_italic=1

" vim colorscheme
colorscheme gruvbox

" airline
" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
if !exists('g:airline_symbols')
  let g:airline_symbol = {}
endif
function! s:update_git_status()
	      let g:airline_section_b = "%{get(g:,'coc_git_status','')}"
endfunction
let g:airline_section_b = "%{get(g:,'coc_git_status','')}"
autocmd User CocGitStatusChange call s:update_git_status()

" coc.nvim
let g:coc_global_extensions = [
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-xml',
    \ 'coc-yaml',
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-python',
    \ 'coc-pyright',
    \ 'coc-vimlsp',
    \ 'coc-sh',
    \ 'coc-vimtex',
    \ 'coc-sql',
    \ 'coc-git',
	\ 'coc-lists',
    \ 'coc-snippets',
    \ 'coc-template',
    \ 'coc-explorer',
    \ 'coc-floaterm',
    \ 'coc-highlight',
    \ 'coc-yank',
    \ 'coc-calc',
    \ 'coc-tasks']
"" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" common operation
noremap <LEADER>cd :CocCommand<CR>
nmap gn <Plug>(coc-diagnostic-next)
nmap gd <Plug>(coc-definition)
nmap gD <Plug>(coc-declaration)
nmap gi <Plug>(coc-implementation)
nmap gt <Plug>(coc-type-definition)
nmap gr <Plug>(coc-references)
nmap gR <Plug>(coc-rename)
nmap gl <Plug>(coc-openlink)
nmap goi <Plug>(coc-funcobj-i)
nmap goa <Plug>(coc-funcobj-a)
nnoremap <silent> g; :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" coc-clangd
noremap gh :CocCommand clangd.switchSourceHeader<CR>
" coc-snippets
imap <C-e> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_prev = '<c-k>'
let g:coc_snippet_next = '<c-j>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
" coc-template
nmap <LEADER>tp <Plug>(coc-template)
" coc-explorer
noremap <LEADER>n :CocCommand explorer<CR>
" coc-highlight
" autocmd CursorHold * silent call CocActionAsync('highlight')
" coc-yank
nnoremap <silent> <LEADER>y  :CocList -A --normal yank<CR>

" rainbow
let g:rainbow_active = 1

" vim-surround
nmap <LEADER>" ysmW"
nmap <LEADER>' ysmW'
nmap <LEADER>) ysmW)
nmap <LEADER>{ ysmW{
nmap <LEADER>[ ysmW[
nmap <LEADER>/ ysmW*ysmW/f*a<SPACE><ESC>f*m<SPACE><ESC>b

" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = 'g<C-n>'
let g:multi_cursor_start_key           = 'g<A-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<ESC>'

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1

" vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1

" markdown
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" vim-fzf
noremap <LEADER>ff :Files<CR>
noremap <LEADER>fg :GFiles<CR>
noremap <LEADER>fb :Buffers<CR>
noremap <LEADER>fc :Colors<CR>
noremap <LEADER>fl :Lines<CR>
noremap <LEADER>ft :Tags<CR>
noremap <LEADER>fm :Marks<CR>
noremap <LEADER>fw :Windows<CR>
noremap <LEADER>fh :History<CR>
noremap <LEADER>fs :Snippets<CR>
noremap <LEADER>fM :Maps<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<C-d>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-l>"
let g:UltiSnipsSnippetDirectories = [$HOME.'.config/nvim/Ultisnips/', $HOME.'.config/nvim/plugged/vim-snippets/UltiSnips/']
let g:UltiSnipsEditSplit="horizontal"

" vimspector
nnoremap <F3> :VimspectorReset<CR>
nnoremap <F4> :call vimspector#Restart()<CR>
nnoremap <F5> :call vimspector#Continue()<CR>
nnoremap <F8> :call vimspector#AddFunctionBreakpoint('<cexpr>')<CR>
nnoremap <F9> :call vimspector#ToggleBreakpoint()<CR>
nnoremap <F10> :call vimspector#StepOver()<CR>
nnoremap <F11> :call vimspector#StepInto()<CR>
nnoremap <F12> :call vimspector#StepOut()<CR>
function! s:read_template_into_buffer(template)
    " has to be a function to avoid the extra space fzf#run insers otherwise
    execute '0r ~/.config/nvim/vimspector_json_templation/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
    \   'source': 'ls -1 ~/.config/nvim/vimspector_json_templation',
    \   'down': 20,
    \   'sink': function('<sid>read_template_into_buffer')
    \ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=🔴 texthl=Normal
sign define vimspectorBPDisabled text=🔵 texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad

" vim-markdown-toc
let g:vmt_auto_update_on_save = 1
let g:vmt_dont_insert_fence = 0
let g:vmt_cycle_list_item_markers = 1
let g:vmt_include_headings_before = 0
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" vim-table-mode
noremap <LEADER>tm :TableModeToggle<CR>
let g:table_mode_relign_map = '<LEADER>tr'

" vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" vista
noremap T :Vista!!<CR>
noremap <C-t> :Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
let g:vista_executive_for = {
  \ 'c': 'coc',
  \ 'cpp': 'coc',
  \ }

" vim-autoformat
noremap <LEADER>af :Autoformat<CR>

" vim-signature
let g:SignatureMap = {
    \ 'Leader'             :  "h",
    \ 'PlaceNextMark'      :  "h,",
    \ 'ToggleMarkAtLine'   :  "h.",
    \ 'PurgeMarksAtLine'   :  "h-",
    \ 'DeleteMark'         :  "dh",
    \ 'PurgeMarks'         :  "h<SPACE>",
    \ 'PurgeMarkers'       :  "h<BS>",
    \ 'GotoNextLineAlpha'  :  "']",
    \ 'GotoPrevLineAlpha'  :  "'[",
    \ 'GotoNextSpotAlpha'  :  "`]",
    \ 'GotoPrevSpotAlpha'  :  "`[",
    \ 'GotoNextLineByPos'  :  "]'",
    \ 'GotoPrevLineByPos'  :  "['",
    \ 'GotoNextSpotByPos'  :  "]`",
    \ 'GotoPrevSpotByPos'  :  "[`",
    \ 'GotoNextMarker'     :  "]-",
    \ 'GotoPrevMarker'     :  "[-",
    \ 'GotoNextMarkerAny'  :  "]=",
    \ 'GotoPrevMarkerAny'  :  "[=",
    \ 'ListBufferMarks'    :  "h/",
    \ 'ListBufferMarkers'  :  "h?"
    \ }

" vim-easymotion
" Disable default mappings
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
" <Leader>f{char} to move to {char}
vmap /f <Plug>(easymotion-bd-f)
nmap /f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap /s <Plug>(easymotion-overwin-f2)
" Move to line
vmap /l <Plug>(easymotion-bd-jk)
nmap /l <Plug>(easymotion-overwin-line)
" Move to word
vmap  /w <Plug>(easymotion-bd-w)
nmap /w <Plug>(easymotion-overwin-w)

" xtabline
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
autocmd vimenter * :XTabTheme default
let g:xtabline_settings.indicators = {
  \ 'modified': '[+]',
  \ 'pinned': '[📌]',
  \}
let g:xtabline_settings.icons = {
  \'pin': '📌',
  \'star': '★',
  \'book': '📖',
  \'lock': '🔒',
  \'hammer': '🔨',
  \'tick': '✔',
  \'cross': '✖',
  \'warning': '⚠',
  \'menu': '☰',
  \'apple': '🍎',
  \'linux': '🐧',
  \'windows': '⌘',
  \'git': '',
  \'palette': '🎨',
  \'lens': '🔍',
  \'flag': '🏁',
  \}

" gitgutter
let g:gitgutter_map_keys = 0
nmap <LEADER>hn <Plug>(GitGutterNextHunk)
nmap <LEADER>hp <Plug>(GitGutterPrevHunk)
nmap <LEADER>hs <Plug>(GitGutterStageHunk)
nmap <LEADER>hu <Plug>(GitGutterUndoHunk)

" Goyo
nnoremap <LEADER>gy :Goyo<CR>
let g:goyo_width = '80'
let g:goyo_height = '80%'

" suda.vim
nnoremap <LEADER>S :w suda://%<CR>
let g:suda#prompt = '(. > .) password please: '

" asynctasks.vim
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']

" vimtex
let g:vimtex_mappings_enabled = 0
let g:vimtex_cache_root = '~/.cache/nvim/vimtex'
let g:vimtex_view_method = 'zathura'

" floaterm
let g:floaterm_keymap_toggle = '<F1>'

" targets.vim
let g:targets_aiAI = 'amAM'
let g:targets_mapped_aiAI = 'aiAI'

" vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" vim-matchup
let g:matchup_mappings_enabled = 0
nmap % <plug>(matchup-%)
nmap goa v<plug>(matchup-%)

" vim-which-key
nnoremap <silent> <LEADER> :WhichKey '<SPACE>'<CR>

" lazygit
noremap <LEADER>gi :FloatermNew lazygit<CR>
noremap <LEADER>R :FloatermNer ranger<CR>

" Open the vimrc file
noremap <LEADER>rc :edit $MYVIMRC<CR>
" shut dowm the highlight of last search
noremap <LEADER><CR> :nohlsearch<CR>
" move cursor to other window
noremap <LEADER>l <C-w>l
noremap <LEADER>i <C-w>k
noremap <LEADER>j <C-w>h
noremap <LEADER>k <C-w>j
" swith the position of current window
noremap <LEADER>L <C-w>L
noremap <LEADER>I <C-w>K
noremap <LEADER>J <C-w>H
noremap <LEADER>K <C-w>J
" substitute
noremap <LEADER>s :%s///g<left><left><left>
" switch upper or lower
noremap <LEADER>u ~h
" cute font
noremap <LEADER>fr :r !figlet<SPACE>
" go to next buffer
noremap <LEADER>bn :bnext<CR>
" go to previous buffer
noremap <LEADER>bp :bprevious<CR>
" go to the buffer that you view just before
noremap <LEADER>bb <C-^>
" delete current buffer
noremap <LEADER>bd :bdelete<CR>
" alter the keymap between colemak with normal us keyboard
noremap <LEADER>bc :source $HOME/.vim/insert-colemak.vim<CR>
noremap <LEADER>bu :source $HOME/.vim/insert-normal.vim<CR>
" plus 1 to value in current location
noremap <LEADER>. <C-a>
" minus 1 to value in current location
noremap <LEADER>, <C-x>
" jump to the next placehold and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" search
noremap // /

" go next or previous searched text and keep in middle of screen
nnoremap - Nzz
nnoremap = nzz
" change indent
nnoremap < <<
nnoremap > >>
" go into insert mode
noremap m i
noremap M I
" mark
noremap h m
" movement
noremap j h
noremap J b
noremap k j
noremap K 5j
noremap i k
noremap I 5k
noremap L w
" visual movement
noremap gk gj
noremap gi gk

" move current line up
noremap <C-i> :move -2<CR>
" move current line down
noremap <C-k> :move +1<CR>
" move cusor to head of current line
noremap <C-j> 0
" move cusor to end of current line
noremap <C-l> $
" <C-u> go to older position, <C-o> go to newer position
noremap <C-o> <C-i>
noremap <C-u> <C-o>
" use sys-clipboard in normal mode
nnoremap <C-y> "+yy
nnoremap <C-p> o<Esc>"+p

" go the end of the current line but ignore the return char
xnoremap <C-l> g_
" use sys-clipboard in v mode
xnoremap <C-y> "+y
xnoremap <C-p> "+p

" command mode movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-j> <Left>
cnoremap <C-l> <Right>

" insert mode movement inner current line
inoremap <C-j> <Esc>I
inoremap <C-l> <Esc>A
" re-select view block after indent in v mode
xnoremap < <gv
xnoremap > >gv
" save
nnoremap S :w<CR>
nnoremap s <nop>
" quit
nnoremap Q :q<CR>
" refresh my vimrc
nnoremap R :source $MYVIMRC<CR>

" split windows
nnoremap sl :set splitright<CR>:vsplit<CR>
nnoremap sj :set nosplitright<CR>:vsplit<CR>
nnoremap si :set nosplitbelow<CR>:split<CR>
nnoremap sk :set splitbelow<CR>:split<CR>

" alter size of the current window
noremap <up> :resize +5<CR>
noremap <down> :resize -5<CR>
noremap <left> :vertical resize+5<CR>
noremap <right> :vertical resize-5<CR>

" tab operation
nnoremap tj :-tabnext<CR>
nnoremap te :tabedit<CR>
nnoremap tl :+tabnext<CR>
nnoremap tmj :-tabmove<CR>
nnoremap tml :+tabmove<CR>
" make current window widest on left or top
nnoremap sv <C-w>H
nnoremap sh <C-w>K
" rotate windows
nnoremap sr <C-w>r
nnoremap sR <C-w>R

" compile and run (file scope or project scope)
noremap <F6> :AsyncTask file-build<CR>
noremap <F7> :call FileRun()<CR>
noremap <LEADER><F6> :AsyncTask project-build<CR>
noremap <LEADER><F7> :AsyncTask project-run<CR>

exec "nohlsearch"
