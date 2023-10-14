" просматриваем ман-страницы в отдельном окне vim'a с подсвечиванием и т.п.
" Эта директива должна быть в начале файла .vimrc, иначе она перезапишет
" остальные настройки.
"-------------------------------------------------------------------------
" :Man man
"-------------------------------------------------------------------------
" Local mappings:
" CTRL-] Jump to the manual page for the word under the cursor.
" CTRL-T Jump back to the previous manual page.

:runtime! ftplugin/man.vim


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle - плагин для управления плагинами (и такое бывает). С его помощью
" можно ставить плагины просто указывая их имена в ~/.vimrc.
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" {
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " enhances integration with the terminal
    Plugin 'wincent/terminus'
    " отключаем мышь
    let g:TerminusMouse=0

    " Основные зависимости для поддержки плагинов
    " clang, libclang, ctags, ... 
    "
    " может понадобиться прописать let
    " g:clang_library_path='/usr/lib/llvm-3.5/lib/'
    " с указанием пути к библиотеке libclang
    "let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang-6.0.so.1'

    Plugin 'xavierd/clang_complete'
    Plugin 'mh21/errormarker.vim'
    " формат строки с ошибкой для gcc и sdcc, это нужно для errormarker
    let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

    Plugin 'preservim/nerdcommenter'

    Plugin 'preservim/nerdtree'        " Project and file navigation
    " меняем значки свернуто/развернуто для директорий
    " минус '-' вызывает ошибку в выполнении, нужно подбирать
    let g:NERDTreeDirArrowExpandable = '+'
    let g:NERDTreeDirArrowCollapsible = '~'
    " игноррируемые файлы с расширениями
    let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$', '\.swp$', '\.git$']
    " автоматически отображались при запуске vim
    "autocmd vimenter * NERDTree | wincmd w
    " если не заданы аргументы получить фокус
    autocmd vimenter * if !argc() | NERDTree | endif
    " устанавливаем размер панели
    "let g:NERDTreeWinSize=15

    Plugin 'majutsushi/tagbar'          " Class/module browser
    let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии
    let g:tagbar_iconchars = ['+', '~']
    " автоматически отображались при запуске vim
    "autocmd vimenter * TagbarToggle

    Plugin 'fisadev/FixedTaskList.vim'  " Pending tasks list (find TODO, FIXME, XXX)

    Plugin 'rosenfeld/conque-term'      " Consoles as buffers
    " :ConqueTerm bash
    " :ConqueTermSplit <command>
    " :ConqueTermVSplit <command>
    " :ConqueTermTab <command>

    " --- AirLine ---
    Plugin 'vim-airline/vim-airline'          " Lean & mean status/tabline for vim
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'arcticicestudio/nord-vim'

    " --- Python ---
    Plugin 'python-mode/python-mode'    " Python mode (docs, refactor, lints, 
                                        " highlighting, run and ipdb and more)
    Plugin 'davidhalter/jedi-vim' 		" Jedi-vim autocomplete plugin
    Plugin 'mitsuhiko/vim-jinja'		" Jinja support for vim
    Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim

    " --- Git ---
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'

    " --- Solidity ---
    Plugin 'tomlion/vim-solidity'

    " --- Go ---
    Plugin 'fatih/vim-go'

    " --- Others ---
    Plugin 'tmhedberg/matchit'          " переход по тегам <> </>

    Plugin 'matze/vim-move'             " перемещение блоков <C-j> или <C-k>
    let g:move_key_modifier = 'C'

    Plugin 'romainl/vim-qf'
    autocmd FileType qf 7wincmd_       " Set min height from quickfix window

" } All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" БАЗОВЫЕ НАСТРОЙКИ
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Позволим конфигурационным файлам в проекте изменять настройки vim'a
" Включим чтение конфигурационных файлов .vimrc в текущей директории
"set exrc                                                                     
" Запретим опасные команды в локальных .vimrc файлах (эта опция должна идти
" в вашем ~/.vimrc после запрещаемых команд, таких как write)
set secure
" Запретим создание swap- и backup-файлов
set nobackup
set nowritebackup
set noswapfile
set noundofile
" backspace без глюков
set bs=indent,eol,start
" кодировка по умолчанию
set fileencoding=utf-8
set encoding=utf-8 
set termencoding=utf-8 
set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le
set fileformat=unix
" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без
" необходимости сохранения каждый раз когда переключаешься между ними
set hidden
" переносить строки
set wrap
" Перенос строк по словам, а не по буквам
set linebreak
" Включение/отключение режима «вклейки» (set paste / set nopaste)
set nopaste
" включаем мыша
"set mouse=a
" принудительно вырубаем мыша
set mouse=
set ttymouse=
set t_RV=
" вырубим выполнение команд из открываемого файла
set nomodeline

" Автоматически обновить содержимое
set autoread
autocmd FocusGained * checktime

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ВНЕШНИЙ ВИД
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Отступы пробелами, а не табуляциями, где нужно укажем впециально
set expandtab
" Ширина строки 80 символов (для автопереноса)
"set textwidth=80
set textwidth=0
" Ширина табуляции в колонках
set tabstop=4
set softtabstop=4
" Количество пробелов (колонок) одного отступа
set shiftwidth=4
" Новая строка будет с тем же отступом, что и предыдущая
set autoindent
" Умная расстановка отступов (например, отступ при начале нового блока)
set smartindent
" Подсвечивать синтаксис
syntax on
" Указывать номера строк
set number
" включение дополнительной информации о статусной строке
set statusline=%<%f%h%m%r\[%{strlen(&ft)?&ft:'none'}]%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P 
set laststatus=2
" Показывать положение курсора всё время
set ruler
" Включаем bash-подобное дополнение командной строки                            
set wildmode=longest:list,full
" Дополнительная информация в строке состояния
set wildmenu
" Не делать все окна одинакового размера                                        
set noequalalways                                                               
" Высота окон по-умолчанию                                             
set winheight=20
" Ширина окна по-умолчанию
set winwidth=20
" Минимальная высота окна
set winminheight=0
" Минимальная ширина окна
set winminwidth=0
" Показывать незавершённые команды в статусбаре
set showcmd

" Фолдинг
set foldenable
set foldlevel=100
"set foldmethod=indent
"set foldmethod=manual
set foldmethod=syntax
" Колоночка, чтобы показывать плюсики для скрытия блоков кода:
"set foldcolumn=1

" Отключаем подсветку скобок
let g:loaded_matchparen=1

" отключаем пищалку и мигание
set t_vb= 
set novisualbell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " 256 colors
"let g:solarized_termcolors=256
set background=dark
" закоментировать, если используются цвета терминала
"set termguicolors

try
    colorscheme nord
catch /.*/
    "colorscheme default
endtry

" Подсвечивать колонку, на которой находится курсор
"set cursorcolumn
" Подсвечивать линию текста, на которой находится курсор
set cursorline
hi CursorLine ctermbg=234
" Подсветить максимальную ширину строки
let &colorcolumn=80
hi ColorColumn ctermbg=233
" переопределение цветов курсора
if &term =~ "xterm\\|rxvt"
    "silent !echo -ne "\033]12;orange\007"
    "" reset cursor when vim exits
    "autocmd VimLeave * silent !echo -ne "\033]112\007"
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ПОИСК
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Игнорировать регистр при поиске                                               
set ignorecase
set smartcase
" Подсвечивать поиск                                                            
set hlsearch
" Использовать последовательный поиск                                         
set incsearch


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ЯЗЫКИ
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" закомментировать, если нужна документация по методу/классу
set completeopt-=preview

" С/C++ файлы
" Расставлять отступы в стиле С
autocmd filetype c,cpp set cin

" MAKE-файлы                                                                       
" В make-файлах нам не нужно заменять табуляцию пробелами                          
autocmd filetype make set noexpandtab                                              
autocmd filetype make set nocin

" HTML-файлы                                                                       
" Не расставлять отступы в стиле С в html файлах                                
autocmd filetype html set noexpandtab                                           
autocmd filetype html set nocin                                                 
autocmd filetype html set textwidth=160

" CSS-файлы                                                                     
" Не расставлять отступы в стиле C и не заменять табуляцию пробелами
autocmd filetype css set noexpandtab            
autocmd filetype css set nocin

" PYTHON-файлы
" Не расставлять отступы в стиле С
autocmd filetype python set nocin

" SNIPPETS-файлы
autocmd filetype snippets set noexpandtab
autocmd filetype snippets set nocin


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Биндинги, команды и прочее
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DeleteCurrentBuffer()
  let crbuf = bufnr('%')
  execute 'bp'
  execute 'bd! ' . crbuf
endfunction

function! ListToggle()
    if &list==1
        execute 'set nolist'
    else
        execute 'set list'
    endif
endfunction

" По нажатию Ctrl+F проверить поект на ошибки                                   
autocmd filetype c,cpp  map <C-F> :call g:ClangUpdateQuickFix()<CR>
autocmd filetype go     map <C-F> :GoLint<CR>
autocmd filetype python map <C-F> :PymodeLint<CR>

" Remap code completion to Ctrl+Space
if &filetype!='python'
    inoremap <Nul> <C-X><C-O>
endif

noremap  <F3> :NERDTreeToggle<CR>
inoremap <F3> <ESC>:NERDTreeToggle<CR>
vnoremap <F3> <ESC>:NERDTreeToggle<CR>

noremap  <F4> :TagbarToggle<CR>
inoremap <F4> <ESC>:TagbarToggle<CR>
vnoremap <F4> <ESC>:TagbarToggle<CR>

map      <F5> <Plug>(qf_qf_toggle)
imap     <F5> <ESC><Plug>(qf_qf_toggle)
vmap     <F5> <ESC><Plug>(qf_qf_toggle)

noremap  <F6> :TaskList<CR>     
inoremap <F6> <ESC>:TaskList<CR>     
vnoremap <F6> <ESC>:TaskList<CR>     

" Показать/скрыть непечатные символы
noremap  <F9> :call g:ListToggle()<CR>     
inoremap <F9> <ESC>:call g:ListToggle()<CR>     
vnoremap <F9> <ESC>:call g:ListToggle()<CR>     

" Удалить текущий буффер
noremap  <F8> :call g:DeleteCurrentBuffer()<CR>     
inoremap <F8> <ESC>:call g:DeleteCurrentBuffer()<CR>     
vnoremap <F8> <ESC>:call g:DeleteCurrentBuffer()<CR>     

" Переключение буферов - педыдущий
noremap  <S-Left> :bp<CR>
inoremap <S-Left> <ESC>:bp<CR>
vnoremap <S-Left> <ESC>:bp<CR>
noremap  <S-F7> :bp<CR>
inoremap <S-F7> <ESC>:bp<CR>
vnoremap <S-F7> <ESC>:bp<CR>

" Переключение буферов - следующий
noremap  <S-Right> :bn<CR>
inoremap <S-Right> <ESC>:bn<CR>
vnoremap <S-Right> <ESC>:bn<CR>
noremap  <F7> :bn<CR>
inoremap <F7> <ESC>:bn<CR>
vnoremap <F7> <ESC>:bn<CR>

" Cut
vnoremap <C-c> "+x
" Copy
vnoremap <C-c> "+y
" Paste
noremap  <C-v> "+Pa
inoremap <C-v> <ESC>"+pa

" Select all
noremap  <C-A> gg<S-V><S-G>
inoremap <C-A> <ESC>gg<S-V><S-G>
vnoremap <C-A> <ESC>gg<S-V><S-G>

" Save
noremap  <C-S> :w!<CR>
inoremap <C-S> <ESC>:w!<CR>
vnoremap <C-S> <ESC>:w!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clang-completer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Включить дополнительные подсказки (аргументы функций, шаблонов и т.д.)        
let g:clang_snippets=1                                                          
" Периодически проверять проект на ошибки                                       
let g:clang_periodic_quickfix=0
" Подсвечивать ошибки                                                           
let g:clang_hl_errors=1
" Автоматически закрывать окно подсказок после выбора подсказки                 
let g:clang_close_preview=1                                              
" Чтобы открыть окно с расшифровкой ошибок нужно набрать :copen, закрыть :cclose 
" Также можно увидеть декларацию функции нажав Ctrl+]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python-mode settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" отключаем автокомплит по коду 
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" документация
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" проверка кода
let g:pymode_lint = 1
let g:pymode_lint_ignore = ["E501","W601","C0110"]
" провека кода после сохранения
let g:pymode_lint_write = 0

" поддержка virtualenv
let g:pymode_virtualenv = 1

" установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

let g:pymode_quickfix_minheight = 7
let g:pymode_quickfix_maxheight = 7

" отключить autofold по коду
let g:pymode_folding = 0

" возможность запускать код
let g:pymode_run = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jedi-vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jedi#show_call_signatures = 1 " show call signatures
let g:jedi#popup_on_dot = 0         " enable autocomplete on dot
let g:jedi#popup_select_first = 0   " disable first select from auto-complete


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-go settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = 'goimports'  " Run goimports along gofmt on each save     
let g:go_list_type = "quickfix"

let g:go_auto_type_info = 1         " Automatically get signature/type info for object under cursor

let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1

let g:go_quickfix_height = 7


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" настройки Vim-Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" настройка символов оформления
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
