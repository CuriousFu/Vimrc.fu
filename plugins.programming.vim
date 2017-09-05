" plugins.programming.vim
"
" Maintained by Claud D. Park <posquit0.bj@gmail.com>
" http://www.posquit0.com/
""Plugin unite {{{
Plug 'Shougo/unite.vim'
""}}}

"" Plugin: Vim Polyglot {{{
  " A collection of language packs for Vim
  Plug 'sheerun/vim-polyglot'
  " No conceal in JSON
  let g:vim_json_syntax_conceal=0
  " Enable syntax highlighting for JSDocs
  let g:javascript_plugin_jsdoc=1
"" }}}

"" Plugin: ALE {{{
  " Asynchronous Lint Engine
 " Plug 'w0rp/ale'
  " Enable ALE
  let g:ale_enable=1
  " Set the language specific linters
  let g:ale_linters={
  \ 'javascript': ['eslint'],
  \ 'python': ['flake8'],
  \ }
  " Set aliases from one filetype to another
  let g:ale_linter_aliases={
  \ 'javascript': ['javascript', 'javascript.jsx', 'jsx'],
  \ }
  " No lint everytime for my battery
  let g:ale_lint_on_text_changed='normal'
  " Run after the delay
  let g:ale_lint_delay=400
  " Run on opening a file
  let g:ale_lint_on_enter=1
  " Run on saving a file
  let g:ale_lint_on_save=1
  " Run on leaving insert mode
  let g:ale_lint_on_insert_leave=1
  " Don't open loclist
  let g:ale_open_list=0
  " Customize the output format of statusline
  let g:ale_statusline_format=['⨉ %d', '⚠ %d', '⬥ ok']
  " Customize the echo message
  let g:ale_echo_msg_error_str='E'
  let g:ale_echo_msg_warning_str='W'
  let g:ale_echo_msg_format='[%severity%:%linter%] %s'
"" }}}

"" Plugin: NeoMake {{{
  " Async :make and linting framework for Vim/NeoVim
   Plug 'neomake/neomake', { 'for': [
   \ 'c', 'cpp', 'java', 'python', 'javascript', 'scala', 'sh', 'vim'
   \ ] }
  " Open the location-list or quickfix list with preserving the cursor
  let g:neomake_open_list=2
  " Set the height of hte location-list or quickfix list
  let g:neomake_list_height=6
  " Echo the error for the current line
  let g:neomake_echo_current_error=1
  " Place signs by errors recognized
  let g:neomake_place_signs=1
  " Set the appearance of the signs
  let g:neomake_error_sign={'text': '✖', 'texthl': 'NeomakeErrorSign'}
  let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningSign'}
  let g:neomake_message_sign={'text': '➤', 'texthl': 'NeomakeMessageSign'}
  let g:neomake_info_sign={'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
  " Highlight the columns of errors recognized
  let g:neomake_highlight_columns=1
  " Highlight the lines of errors recognized
  let g:neomake_highlight_lines=0
  " Change highlight color for the columns recognized
  augroup neomake_highlights_hook
    autocmd!
    autocmd ColorScheme * highlight NeomakeError
      \ term=bold cterm=bold guibg=red ctermbg=red
    autocmd ColorScheme * highlight NeomakeErrorSign
      \ term=bold cterm=bold guifg=red ctermfg=red
  augroup END
  " Run Neomake at save and when reading a file
  function! NeomakeHook()
    if exists(':Neomake')
      augroup neomake_hook
        autocmd!
        autocmd BufWritePost * Neomake
      augroup END
    endif
  endfunction
  autocmd VimEnter * call NeomakeHook()
  " Set makers for each filetype
  let g:neomake_c_enabled_makers=['clang']
  let g:neomake_c_clang_args=['-std=c11', '-Wall', '-Wextra', '-fsyntax-only']
  let g:neomake_cpp_enable_makers=['clang']
  let g:neomake_cpp_clang_args=[
  \ '-std=c++14', '-Wall', '-Wextra', '-fsyntax-only'
  \ ]
  let g:neomake_java_enabled_makers=['javac']
  let g:neomake_python_enabled_makers=['flake8']
  let g:neomake_javascript_enabled_makers=['eslint']
  let s:eslint_path=system('PATH=$(npm bin):$PATH && which eslint')
  let b:neomake_javascript_eslint_exe=substitute(
  \ s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', ''
  \ )
  let g:neomake_scala_enabled_makers=['scalac']
  let g:neomake_sh_enabled_makers=['shellcheck']
  let g:neomake_vim_enabled_makers=['vint']
"" }}}

"" Plugin: Syntastic {{{
  " Syntax checking for Vim with external syntax checker
  " TODO: Too slow because of synchronous job
  " Plug 'scrooloose/syntastic'
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list=1
  let g:syntastic_loc_list_height=5
  let g:syntastic_auto_loc_list=1
  let g:syntastic_check_on_open=1
  let g:syntastic_check_on_wq=0
  " Symbols
  let g:syntastic_error_symbol='✘'
  let g:syntastic_warning_symbol='▲'
  " For C / C++
  let g:syntastic_cpp_compiler='clang++'
  let g:syntastic_cpp_compiler_options=' -std=c++11'
  " For Python
  let g:syntastic_python_checkers=['flake8']
  " For Scala & Java
  " let g:syntastic_scala_checkers=['fsc', 'scalac']
  " For Javascript & Node.JS
  let g:syntastic_javascript_checkers=['eslint']
  let s:eslint_path=system('PATH=$(npm bin):$PATH && which eslint')
  let b:syntastic_javascript_eslint_exec=substitute(s:eslint_path,
  \ '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
  " For Shell Script(sh, bash)
  let g:syntastic_sh_checkers=['shellcheck']
"" }}}

"" Plugin: Deoplete(NeoVIM only) {{{
 "  Dark powered asynchronous completion framework
  if has('nvim')
   Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
    " Python source for Deoplete
    Plug 'zchee/deoplete-jedi', { 'for': ['python'] }
    " Javascript source for Deoplete
    Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript'] }
    " Add extra filetypes
    let g:tern#filetypes=['jsx', 'javascript.jsx', 'vue']
    let g:tern#command=['tern']
    let g:tern#arguments=['--persistent']
    if executable('gocode')
      " Go source for Deoplete
      Plug 'zchee/deoplete-go', { 'do': 'make', 'for': ['go'] }
      " By default(not set), Find the gocode binary in $PATH environment
      let g:deoplete#sources#go#gocode_binary=$GOPATH.'/bin/gocode'
      " By default, the completion word list is in the sort order of gocode
      " Available values are [package, func, type, var, const]
      let g:deoplete#sources#go#sort_class=['package', 'func', 'type', 'var', 'const']
      " Use static json caching Go stdlib package API
      let g:deoplete#sources#go#use_cache=1
      let g:deoplete#sources#go#json_directory='~/.cache/deoplete/go/$GOOS_$GOARCH'
    endif
  endif
  " Vim source for Neocomplete/Deoplete
  Plug 'Shougo/neco-vim', { 'for': ['vim'] }
  " Insert mode completion of words in adjacent tmux panes
  Plug 'wellle/tmux-complete.vim'
  " Run deoplete automatically
  let g:deoplete#enable_at_startup=1
  " When a capital letter is included in input, does not ignore
  let g:deoplete#enable_smart_case=1
  " Set the number of the input completion at the time of key input
  let g:deoplete#auto_complete_start_length=2
  " Set the limit of candidates
  let g:deoplete#max_list=32
  " Close the preview window after completion is done
  autocmd CompleteDone * pclose!
  " Disable the preview window
  set completeopt-=preview
"" }}}

"" Plugin: Language Servers {{{
  " Language server for JavaScript and TypeScript
  Plug 'sourcegraph/javascript-typescript-langserver', { 'do': 'npm install && npm run build' }
"" }}}

"" Plugin: LanguageClient(NeoVIM only) {{{
  " Support Language Server Protocol for NeoVIM
  if has('nvim')
    " Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
    " Automatically start language servers
    let g:LanguageClient_autoStart=1
    " Define commands to execute to start language servers
    let g:LanguageClient_serverCommands={
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['pyls'],
    \ 'javascript': ['node', '$VIM_HOME/plugged/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ 'javascript.jsx': ['node', '$VIM_HOME/plugged/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ 'jsx': ['node', '$VIM_HOME/plugged/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ }
    " Disable diagnostics integration
    let g:LanguageClient_diagnosticsEnable=0
    " Set selection UI used when there are multiple entries
    let g:LanguageClient_selectionUI='fzf'

    " nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    " nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
  endif
"" }}}

"" Plugin: UltiSnips {{{
  " Snippet engine for Vim
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  " Configure keys trigerring UltiSnips
  let g:UltiSnipsExpandTrigger='<Tab>'
  let g:UltiSnipsJumpForwardTrigger='<Tab>'
  let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
  let g:UltiSnipsListSnippets='<Tab>l'
  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit='vertical'
"" }}}
"" Plugin: Endwise {{{
" Wisely add `end` in ruby, vim, etc
  Plug 'tpope/vim-endwise', { 'for': [
  \ 'ruby', 'vim', 'sh', 'zsh', 'matlab', 'snippets'
  \ ] }
"" }}}
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"YCM和Ultisnips按键冲突解决方案（只使用TAB键，无错误）
"如果有snips，直接按tab键就可以完成添加
"tab键往下走，shfit+tab键往上走

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

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
"" Plugin: NERD Commenter {{{
  " For intensely orgasmic commenting
  Plug 'scrooloose/nerdcommenter'
  " Comment the whole lines in visual mode
  let g:NERDCommentWholeLinesInVMode=1
  " Add space after the left delimiter and before the right delimiter
  let g:NERDSpaceDelims=1
  " Remove spaces around comment delimiters
  let g:NERDRemoveExtraSpaces=1
"" }}}

"" Plugin: Codi {{{
  " The interactive scratchpad for hackers
  Plug 'metakirby5/codi.vim'
  " Set shortcut to toggle Codi
  nnoremap <Leader><Leader>c :Codi!!<CR>
  xnoremap <Leader><Leader>c :Codi!!<CR>
"" }}}

" Javascript & Node
"" Plugin: Tern for Vim {{{
  " TODO: Key mapping
  " Tern-based Javascript editing support
  " Hook into omni completion to handle autocompletion and provide more
  function! BuildTern(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
      !npm install
    endif
  endfunction
  Plug 'marijnh/tern_for_vim', { 'for': ['javascript'], 'do': function('BuildTern') }
  " Set timeout
  let g:tern_request_timeout=1
  " Display argument type hints when the cursor is left over a function
  let g:tern_show_argument_hints='on_hold'
  " Display function signature in the completion menu
  let g:tern_show_signature_in_pum='0'
  " Disable Shortcuts
  let g:tern_map_keys=0
"" }}}

"" Plugin: Vim Node {{{
  " Tools and environment to make Vim superb for developing with Node.js
  Plug 'moll/vim-node'
"" }}}

"" Plugin: Javascript Libraries Syntax {{{
  " Syntax file for JavaScript libraries
  Plug 'othree/javascript-libraries-syntax.vim',{'for': 'JavaScript'}
  " Set up used libraries
  let g:used_javascript_libs='react,jquery,underscore,handlebars'
"" }}}

" HTML & CSS
"" Plugin: Emmet {{{
  " Provide Zen-coding for Vim
  Plug 'mattn/emmet-vim', {
  \ 'for': [
  \   'html', 'haml', 'jinja', 'hbs', 'html.handlebars', 'xml',
  \   'css', 'less', 'sass', 'javascript'
  \ ]
  \}
  " Enable all functions, which is equal to
  " n: normal, i: insert: v: visual, a: all
  let g:user_emmet_mode='a'
  " Remap the default Emmet leader key <C-Y>
  let g:user_emmet_leader_key='<C-Y>'
  " Customize the behavior of the languages
  let g:user_emmet_settings={
  \ 'javascript.jsx': {
  \   'extends': 'jsx',
  \ },
  \ 'javascript': {
  \   'extends': 'jsx',
  \ },
  \ 'xml': {
  \   'extends': 'html',
  \ },
  \ 'haml': {
  \   'extends': 'html',
  \ },
  \ 'jinja': {
  \   'extends': 'html',
  \ },
  \ 'hbs': {
  \   'extends': 'html',
  \ },
  \ 'html.handlebars': {
  \   'extends': 'html',
  \ },
  \}
"" }}}


" Markdown
"" Plugin: Goyo {{{
  " Distraction-free writing
  Plug 'junegunn/goyo.vim'
  " Integrate with other plugins
  function! s:goyo_enter()
    silent !tmux set status off
    set colorcolumn=
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
    "LocalIndentGuide -hl -cc
  endfunction

  function! s:goyo_leave()
    silent !tmux set status on
    set colorcolumn=80
    set showmode
    set showcmd
    set scrolloff=3
    Limelight!
    LocalIndentGuide +hl +cc
  endfunction
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
"" }}}

"" Plugin: Limelight {{{
  " Hyperfocus-writing in Vim
  Plug 'junegunn/limelight.vim'
  " Set coefficient value
  let g:limelight_default_coefficient=0.7
  " Configure the number of preceding/following paragraphs to include
  let g:limelight_paragraph_span=1
  " Set shortcut to toggle limelight
  nnoremap <Leader><Leader>l :Limelight!!<CR>
  xnoremap <Leader><Leader>l :Limelight!!<CR>
"" }}}

" plugin  {{{1 "

"if has ("nvim")
"  Plug 'roxma/nvim-completion-manager'
"else
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
"imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"" }}} "
"" Plugin: Vim Instant Markdown {{{
  " Instant markdown Previews from Vim
  " Plug 'suan/vim-instant-markdown'
  " Only refresh on specific events
  let g:instant_markdown_slow=1
  " Manually control to launch the preview window
  " Command(:InstantMarkdownPreview)
  let g:instant_markdown_autostart=1
  " Allow external content like images
  let g:instant_markdown_allow_external_content=1
"" }}}
""{{{
""pumvisible() ? "\" : "\
" pumvisible() ? "\"" : "\
if !has ("nvim")
"Plug 'Valloric/YouCompleteMe', {'do': './install.py --all'}
endif
"" "
" YCM 补全菜单配色
" 菜单#2a5caa#afdfe4
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#00ae9d guibg=#281f1d
" 选中项
"highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
"highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900

let g:ycm_global_ycm_extra_conf = $VIM_HOME.'/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 让Vim的补全菜单行为与一般IDE一致
set completeopt=longest,menu
" 不用每次提示加载.ycm_extra_conf.py文件
let g:ycm_confirm_extra_conf = 0
" 关闭ycm的syntastic
let g:ycm_show_diagnostics_ui = 0

" 评论中也应用补全
let g:ycm_complete_in_comments = 1
" 两个字开始补全
let g:ycm_min_num_of_chars_for_completion = 2
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags
" set tags+=/data/misc/software/misc./vim/stdcpp.tags
set tags+=$VIM_HOME.'/tags/stdcpp.tags
set tags+=$VIM_HOME.'/tags/sys_tags
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=1
" 关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
"""
let g:ycm_collect_identifiers_from_comments_and_strings = 1
"""Plugin: asyncrun.vim {{{
  "This plugin takes the advantage of new apis in Vim 8 (and NeoVim) to enable
  "you to run shell commands in background and read output in the quickfix
  "window in realtime:
  Plug 'skywind3000/asyncrun.vim'
"""}}}
nnoremap <leader>g :call CompileAndRun()<CR>

function! CompileAndRun()
  exec 'w'
  if &filetype == 'c'
    exec "AsyncRun! gcc % -o %<; time ./%<"
  elseif &filetype == 'cpp'
    exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
  elseif &filetype == 'go'
    exec "! go run %"
  elseif &filetype == 'java'
    exec "AsyncRun! javac %; time java %<"
  elseif &filetype == 'python'
    exec "AsyncRun! time python %"
  elseif &filetype == 'ruby'
    exec "AsyncRun! time ruby %"
  elseif &filetype == 'rust'
    exec "AsyncRun! rustc % -o %<; time ./%<"
  elseif &filetype == 'sh'
    exec "AsyncRun! time bash %"
  endif
endfunction

