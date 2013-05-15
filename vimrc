"-------------------------------------------------------------------
"       VIM 配置
"
"      最后修改时间：2019-08-31
"-------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" vim 插件管理
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'                   " solarized 配色方案
Plug 'Townk/vim-autoclose'                                " 自动闭合括号
Plug 'Lokaltog/vim-powerline' , { 'branch': 'develop' }   " vim 状态栏
Plug 'yegappan/mru'                                       " 最近打开文件列表
Plug 'kien/ctrlp.vim'                                     " 项目文件搜索
Plug 'vim-scripts/a.vim'                                  " 项目文件跳转
Plug 'ludovicchabant/vim-gutentags'                       " 自动 tags 生成
Plug 'vim-scripts/DoxygenToolkit.vim'                     " Doxygen 注释生成
Plug 'Rip-Rip/clang_complete'                             " 代码自动补全
Plug 'ervandew/supertab'                                  " tab 键映射
Plug 'hurley25/c-support'                                 " C语言支持

call plug#end()
"----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" vim 内部设置
scriptencoding utf-8             " 设置编码

filetype plugin indent on        " 文件类型检测
syntax on                        " 使用语法高亮
set autoread                     " 正在编辑文件被其他程序改动时自动重新加载
set nocp                         " 使用不兼容 vi 的模式

set autoindent                   " 设置自动对齐(缩进和上一行一致)
set smartindent                  " 智能对齐方式
set wrap                         " 自动换行
set linebreak                    " 整词换行

set cindent                      " 使用 C/C++ 语言的自动缩进方式
set backspace=2                  " 设置退格键可用
set number                       " 显示行号
set cul                          " 显示当前行下划线
set showcmd			             " 显示输入的命令

set expandtab                    " tab 自动替换为空格
set tabstop=4                    " 设置制表符(tab键)的宽度
set softtabstop=4                " 设置软制表符的宽度
set shiftwidth=4                 " 自动缩进所使用的空白长度
set hlsearch                     " 搜索结果高亮

set cursorline                   " 高亮当前行

set laststatus=2                 " 总显示最后一个窗口的状态行
set t_Co=256                     " 开启vim 256色

set background=dark
colorscheme solarized            " 设置配色方案
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" 系统剪贴板映射
"set clipboard+=unnamed
"set clipboard=unnamedplus
"map <C-y> "+y
"map <C-p> "+p
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" 显示行末空格
highlight WhitespaceEOL ctermfg=red ctermbg=red
match WhitespaceEOL /\s\+$/

" 按下F2，删除所有行末空格
nnoremap <silent> <F2> :%s/\s\+$//<CR>
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" 显示历史打开文件
map <F3> :MRU<CR>
imap <F3> <ESC>:MRU<CR>
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" F4 切换粘贴和非粘贴模式
set pastetoggle=<F4>
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" F5 生成 tags
"map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<CR><CR>
"imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<CR><CR>

" tags 配置
set tags=./.tags;,.tags
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" vim-gutentags 配置
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" quickfix 设置
" 按下F6，执行make编译程序，并打开quickfix窗口，显示编译信息
map <F6> :make -j<CR><CR><CR> :copen<CR><CR>
" 按下F7，光标移到上一个错误所在的行
map <F7> :cp<CR>
" 按下F8，光标移到下一个错误所在的行
map <F8> :cn<CR>
" 按下F9，执行make clean
map <F9> :make clean<CR><CR><CR>
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" tpope/vim-projectionist
" 按下F10，在当前代码的 .c / .h 之间切换
nnoremap <silent> <F10> :A<CR>
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" vim-cpp-enhanced-highlight 设置
let g:cpp_class_scope_highlight = 1                     " 类作用域的高亮
let g:cpp_member_variable_highlight = 0                 " 高亮显示成员变量
let g:cpp_class_decl_highlight = 1                      " 声明中突出显示类名
let g:cpp_experimental_simple_template_highlight = 1    " 突出显示模板
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" DoxygenToolkit
let g:DoxygenToolkit_briefTag_funcName = "yes"

" for C++ style, change the '@' to '\'
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_briefTag_pre = "\\brief "
let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
let g:DoxygenToolkit_paramTag_pre = "\\param "
let g:DoxygenToolkit_returnTag = "\\return "
let g:DoxygenToolkit_throwTag_pre = "\\throw " " @exception is also valid
let g:DoxygenToolkit_fileTag = "\\file "
let g:DoxygenToolkit_dateTag = "\\date "
let g:DoxygenToolkit_authorTag = "\\author "
let g:DoxygenToolkit_versionTag = "\\version "
let g:DoxygenToolkit_blockTag = "\\name "
let g:DoxygenToolkit_classTag = "\\class "
let g:DoxygenToolkit_authorName = "Qianyi.lh, qianyi.lh@alibaba-inc.com"
"let g:doxygen_enhanced_color = 1
"let g:load_doxygen_syntax = 1
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" clang_complete
set completeopt=longest,menu
let g:clang_complete_copen=0
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_macros=1
let g:clang_use_library=1

let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"
elseif os == 'Linux'

endif

let g:clang_user_options="-std=c++11"
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" 设置超级TAB的补全
let g:SuperTabRetainCompletionType=0
let g:SuperTabDefaultCompletionType="<C-X><C-U>"
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" 预防手误
cnoremap Q! q!
cnoremap Q1 q!
command  Q  q
command  Wq wq
command  WQ wq
command  W  w
" ----------------------------------------------------------------------------------

" ----------------------------------------------------------------------------------
" 查字典 需要安装 ydcv
function! Mydict()
        let expl=system('ydcv ' . expand("<cword>"))
        windo if expand("%")=="dict-tmp" |q!|endif
        30vsp dict-tmp
        setlocal buftype=nofile bufhidden=hide noswapfile
        1s/^/\=expl/
        wincmd p
endf
map f :call Mydict()<CR><C-j><C-l>
" ----------------------------------------------------------------------------------

