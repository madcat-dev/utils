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
" External plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
" {
    " enhances integration with the terminal
    Plug 'wincent/terminus'
    " отключаем мышь
    let g:TerminusMouse=0

    Plug 'xavierd/clang_complete'
    " Основные зависимости для поддержки плагинов
    " clang, libclang, ctags, ...
    " может понадобиться прописать let
    " g:clang_library_path='/usr/lib/llvm-3.5/lib/'
    " с указанием пути к библиотеке libclang
    "let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang-6.0.so.1'

    Plug 'mh21/errormarker.vim'
    " формат строки с ошибкой для gcc и sdcc, это нужно для errormarker
    let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

    Plug 'preservim/nerdcommenter'

    Plug 'preservim/nerdtree'        " Project and file navigation
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

    Plug 'preservim/tagbar'          " Class/module browser
    let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии
    let g:tagbar_iconchars = ['+', '~']
    " автоматически отображались при запуске vim
    "autocmd vimenter * TagbarToggle

    Plug 'fisadev/FixedTaskList.vim'  " Pending tasks list (find TODO, FIXME, XXX)

    " --- AirLine ---
    Plug 'vim-airline/vim-airline'          " Lean & mean status/tabline for vim

    Plug 'madcat-dev/xtheme.vim'

    " --- Python ---
    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    " Python mode (docs, refactor, lints,
    " highlighting, run and ipdb and more)
    Plug 'davidhalter/jedi-vim'             " Jedi-vim autocomplete plugin
    Plug 'mitsuhiko/vim-jinja'              " Jinja support for vim
    Plug 'mitsuhiko/vim-python-combined'    " Combined Python 2/3 for Vim

    " --- Git ---
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " --- Solidity ---
    Plug 'tomlion/vim-solidity'

    " --- Go ---
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " --- Others ---
    Plug 'tmhedberg/matchit'            " переход по тегам <> </>

    Plug 'romainl/vim-qf'
    autocmd FileType qf 7wincmd_       " Set min height from quickfix window

" } All of your Plugins must be added before the following line
call plug#end()

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
" отключаем пищалку и мигание
set t_vb=
set novisualbell
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
set foldmethod=indent
"set foldmethod=manual
"set foldmethod=syntax
" Колоночка, чтобы показывать плюсики для скрытия блоков кода:
"set foldcolumn=1

" Отключаем подсветку скобок
"let g:loaded_matchparen=1

if has('gui_running')
    set guifont=Iosevka\ Fixed\ Curly\ Medium\ 12
endif

" Закоментировать, если используются цвета терминала
"set termguicolors

" Установка цветовой схемы
try
    colorscheme xtheme
catch /.*/
    colorscheme default
endtry

" Подсвечивать колонку, на которой находится курсор
"set cursorcolumn
" Подсвечивать линию текста, на которой находится курсор
set cursorline
" Подсветить максимальную ширину строки
let &colorcolumn=80


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
let g:airline_theme='xtheme'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Биндинги, команды и прочее
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DeleteCurrentBuffer()
  let crbuf = bufnr('%')
  execute 'bp'
  execute 'bd! '.crbuf
endfunction

function! UnprintedToggle()
    if &list==1
        hi! NonText ctermfg=0
        execute 'set nolist'
    else
        hi! NonText ctermfg=196
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

" Навигатор по ФС
noremap  <F3> :NERDTreeToggle<CR>
" Навигатор классов/тегов
noremap  <F4> :TagbarToggle<CR>
" Панель системного вывода (ошибки, консольный вывод...)
map      <F5> <Plug>(qf_qf_toggle)
" Панель Запланированных задач (TODO...)
noremap  <F6> :TaskList<CR>
" Переключение буферов - педыдущий
noremap  <F7>          :bp<CR>
inoremap <F7>     <ESC>:bp<CR>
noremap  <S-Left>      :bp<CR>
inoremap <S-Left> <ESC>:bp<CR>
" Удалить текущий буффер
noremap  <F8>          :call g:DeleteCurrentBuffer()<CR>
inoremap <F8>     <ESC>:call g:DeleteCurrentBuffer()<CR>
" Переключение буферов - следующий
noremap  <F9>           :bn<CR>
inoremap <F9>      <ESC>:bn<CR>
noremap  <S-Right>      :bn<CR>
inoremap <S-Right> <ESC>:bn<CR>

" Показать/скрыть непечатные символы
noremap  <F10> :call g:UnprintedToggle()<CR>

if has("clipboard")
    " CTRL-X are Cut
    vnoremap <C-X> "+x
    " CTRL-C are Copy
    vnoremap <C-C> "+y
    " CTRL-V are Paste
    noremap  <C-V>      "+gP
    inoremap <C-V> <C-O>"+gP
else
    " CTRL-X are Cut
    vnoremap <C-X> "yx <Bar> :call system('xclip -sel clip', @y)<CR>
    " CTRL-C are Copy
    vnoremap <C-C> "yy <Bar> :call system('xclip -sel clip', @y)<CR>
    " CTRL-V are Paste
    noremap  <C-V> :let @y=system('xclip -o -sel clip')<Bar> normal "ygP<CR>
    inoremap <C-V> <C-O>:let @y=system('xclip -o -sel clip')<Bar> normal "ygP<CR>
endif

set listchars=tab:>-,nbsp:.,trail:.,extends:>,precedes:<,eol:$
let &showbreak = '^'
