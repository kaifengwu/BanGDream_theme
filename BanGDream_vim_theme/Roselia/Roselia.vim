" ========== 🌹 Roselia 主题设定 ==========

" 🌹 自动加载 Roselia 配色
colorscheme industry
hi Normal guibg=#1a1c2c guifg=#cdd6f4
"set background=dark
hi Normal guibg=NONE ctermbg=NONE guifg=#c8b0e3 " 正常文本
hi CursorLine guibg=NONE " 当前行
hi NormalNC guibg=NONE ctermbg=NONE guifg=#c8b0e3 " 非活动窗口的正常文本
hi Pmenu guibg=NONE guifg=#c8b0e3 ctermbg=NONE " 弹出菜单
hi PmenuSel guibg=#c8b0e3 guifg=#00AABB ctermbg=NONE " 弹出菜单选中项
highlight CocFloating guibg=NONE guifg=#c8b0e3
highlight CocMenuSel guibg=#881188 guifg=#DD2200 gui=bold
set winblend=0
highlight NonText guibg=NONE " 非文本字符
highlight EndOfBuffer guibg=NONE " 缓冲区末尾


" 清除已有 match
function! s:ClearCursorLineMatch()
  if exists('w:roselia_cursor_match_id')
    call matchdelete(w:roselia_cursor_match_id)
    unlet w:roselia_cursor_match_id
  endif
endfunction

" 更新匹配区域
function! s:UpdateCursorLineMatch()
  call s:ClearCursorLineMatch()

  let lnum = line('.')
  let text = getline(lnum)
  let length = strlen(text)

  if length > 0
    " 使用 matchaddpos 高亮 [行号, 起始列, 长度]
    let w:roselia_cursor_match_id = matchaddpos('RoseliaCursorLine', [[lnum, 1, length]])
  endif
endfunction

" 定义高亮颜色（你可以换颜色）
highlight RoseliaCursorLine guibg=#202234

" 每次移动光标都更新
augroup RoseliaCursorLine
  autocmd!
  autocmd CursorMoved,CursorMovedI * call <SID>UpdateCursorLineMatch()
  autocmd BufLeave,WinLeave * call <SID>ClearCursorLineMatch()
augroup END


" 🌹 Roselia 应援色代码高亮
" Yukina
highlight Keyword      guifg=#DD2200 gui=bold " 关键字，例如 if, else, for 等
highlight Statement    guifg=#DD2200 " 语句，例如 return, break, continue 等

" Sayo
highlight Function     guifg=#00AABB " 函数，例如 print(), len() 等
highlight Label        guifg=#00AABB " 标签，例如 goto 标签
highlight Delimiter    guifg=#00AABB " 分隔符，例如逗号, 分号, 括号等
highlight Comment    guifg=#00AABB " 分隔符，例如逗号, 分号, 括号等

" Lisa
highlight Identifier   guifg=#881188 " 标识符，例如变量名、函数名等
highlight vimAutoCmdSfxList     guifg=#881188
highlight Special      guifg=#881188 " 特殊字符，例如 @, #, $, %, & 等

" Rinko
highlight Type         guifg=#BBBBBB " 类型，例如 int, float, str 等
highlight scalaBlock   guifg=#BBBBBB 
" Ako
highlight Constant     guifg=#DD0088 " 常量，例如 True, False, None 等
highlight Number       guifg=#DD0088 " 数字，例如 1, 2.5, 3.14 等
highlight Boolean      guifg=#DD0088 " 布尔值，例如 True, False

" Roselia（#c8boe3）
highlight PreProc      guifg=#3344AA " 预处理指令，例如 #include, #define 等
highlight Todo         guifg=#3344AA " 待办事项，例如 TODO, FIXME 等
highlight WarningMsg   guifg=#3344AA " 警告信息，例如编译器警告
highlight vimMapRhs     guifg=#3344AA 
highlight vimMaplhs     guifg=#3344AA 
highlight vimUsrCmd     guifg=#3344AA 
highlight vimSetEqual   guifg=#3344AA 


highlight TSDelimiter    guifg=#3344AA " 语法树分隔符，例如逗号, 分号, 括号等
highlight TSConstructor  guifg=#3344AA " 语法树构造器，例如类, 函数等


function! DisplayRoseliaLogo()
  let buf = nvim_create_buf(v:false, v:true)

  " 内容文本
  let lines = [
        \ "							═══════════════🌹 Roselia 🌹 ═══════════════",
        \ "									 白金 燐子     宇田川 あこ",
		\ "										🎹				🥁",
		\ " ",
        \ "								今井 リサ    湊 友希那		氷川 紗夜",
		\ "								   🎸			🎤				🎸",
        \ "							════════════════════════════════════════════",
        \ "							   🌹 Welcome to the world of Roselia! 🌹",
		\ "								写代码也要拼尽全力，这才是Roselia!",
        \ "",
        \ "                              :xo...,.......dO'.....''',;,,,,,,xKd'",
        \ "                           .....';,.        .       .;ckl      .',;;;;'",
        \ "                  ..''..,..    .l.               .dXKkdx0Kc           ;:cc;.          .",
        \ "            .,,,,,''lklokKko' .k'              ;x:oc:',;xdxO.             .:ld' ..  l;c..",
        \ "          ;:'     'd,    .lNNl:o           :xONWxxWcKd,dW0c;lc'     .::cc     :xk0c0odl,l.",
        \ "      ..lo.      :K.       ,WWKc     cd.   ;NWWWcXWkoc,dxONcXWWk   do   xc      ,OXx0kl;.",
        \ "  .   ,0l       .Nk        .NWxx    ;'''':. 'ONK;oOWWldWWW0.0WX:  Ok    x.        l0;,.",
        \ "  ....kK        :WO       .OWl x,  .o..  .d   cONWxdx:kOdoxKd;   ;W:   :;          cK.",
        \ "    .lNX..      :WX.    'dKx.  .d:       o;  .cdNWWWWklK0NWKx.   cW;  c, .oo.      .Xl",
        \ "   '0xXWl       ;WWc,lOXx,       lxlc:;:c. .oko.ckxddo..xxd.     ;Wc l.  :XX:      ;N,",
        \ "      .kNN0Od:  .WW:  .OWl     '... ...             c,  .col.    ,WOo.    ..       dx",
        \ "         ..     .WWc   .NN:         .;:::od,   :oc::,   .;;ok,   ,W0     .oc      lXl;;cdc",
        \ "                cWW,    kWk       .dK,    lWc cW;   ; .kl  .No   dNX.    OWx     dN:   .NO",
        \ "               .0Wx     dWN'     c0Wl     'Wo  c0k,  :0W, .:,  .o.OWc...ocWx   'xWK     XK",
        \ "    .;..     .oNNl      .0W0.  ;x;cW0.  .;0xc    xWll.:WK'   .cl. oWl ;o.,Wk .l'.NW:   cNN. .",
        \ "     .:ollodkko;.        .lO0xd:   ;k0Okxl. .c::oOx,   :k0Oxdl.   .O0d,  ,WXd:   'k00xc.:Kkc",
        \ "",
        \ "",
        \ ]

  call nvim_buf_set_lines(buf, 0, -1, v:false, lines)

  " 定义 highlight group（一次性定义即可）
  hi! RoseliaTitle guifg=#c8b0e3 gui=bold
  hi! RoseliaSong guifg=#88ccff
  hi! Yukina      guifg=#881188
  hi! Sayo        guifg=#00AABB
  hi! Rinko       guifg=#BBBBBB
  hi! Ako         guifg=#DD0088
  hi! Lisa        guifg=#DD2200
  hi! RoseliaNote guifg=#DDDDFF 

  " 应用 highlight 到特定行/列
" 第 0 行：Roselia 顶部标题
call nvim_buf_add_highlight(buf, -1, 'RoseliaTitle', 0, 0, -1)

" 第 1 行：成员名字
call nvim_buf_add_highlight(buf, -1, 'Rinko', 1, 0,24)
call nvim_buf_add_highlight(buf, -1, 'Ako',   1, 24, 60)

" 第 2 行：乐器 emoji
call nvim_buf_add_highlight(buf, -1, 'Rinko', 2, 16, 17)  " 🎹
call nvim_buf_add_highlight(buf, -1, 'Ako',   2, 24, 25)  " 🥁

" 第 4 行：下方三人
call nvim_buf_add_highlight(buf, -1, 'Lisa',   4, 0,22)
call nvim_buf_add_highlight(buf, -1, 'Yukina', 4, 22,40)
call nvim_buf_add_highlight(buf, -1, 'Sayo',   4, 40,60)

" 第 5 行：下方 emoji
call nvim_buf_add_highlight(buf, -1, 'Lisa',   5, 15, 16)  " 🎸
call nvim_buf_add_highlight(buf, -1, 'Yukina', 5, 20, 21)  " 🎤
call nvim_buf_add_highlight(buf, -1, 'Sayo',   5, 26, 27)  " 🎸
" ASCII 图部分统一使用 RoseliaArt
for l in range(7, 26)
  call nvim_buf_add_highlight(buf, -1, 'RoseliaTitle', l, 0, -1)
endfor

" 最下方横线
call nvim_buf_add_highlight(buf, -1, 'RoseliaFooter', 27, 0, -1)

  " 设置浮窗
  let width = 100
  let height = len(lines)
  let opts = {
        \ 'relative': 'editor',
        \ 'width': width,
        \ 'height': height,
        \ 'col': (&columns - width) / 2,
        \ 'row': (&lines - height) / 2,
        \ 'style': 'minimal',
        \ 'border': 'rounded'
        \ }

  let win = nvim_open_win(buf, v:true, opts)

  " 绑定 <ESC>/<CR> 关闭浮窗
  call nvim_buf_set_keymap(buf, 'n', '<ESC>', ':bd!<CR>', {'silent': v:true})
  call nvim_buf_set_keymap(buf, 'n', '<CR>', ':bd!<CR>', {'silent': v:true})
endfunction

function! RandomPickOnBufRead(...)
  let folder = expand('$HOME/.config/nvim/themes/BanGDream_vim_theme/Roselia/Roselia_background')
  let files = split(globpath(folder, '*'), '\n')
  let count = len(files)

  if count == 0
    echom "📂 目标文件夹为空"
    return
  endif

  let statefile = '/tmp/roselia_wallpaper_index'
  let index = 0

  " 如果存在记录文件，读取上次 index
  if filereadable(statefile)
    let index = str2nr(readfile(statefile)[0])
  endif

  if a:0 > 0
    if a:1 == 1
      let index = 0
      echom "🎭 回到默认背景: " . fnamemodify(files[index], ':t')
    elseif a:1 == 2
      let index = (index + 1) % count
      echom "➡️  下一张背景: " . fnamemodify(files[index], ':t')
    else
      let index = rand() % count
      echom "🎲 随机选中背景: " . fnamemodify(files[index], ':t')
    endif
  else
    let index = rand() % count
    echom "🎲 随机选中背景: " . fnamemodify(files[index], ':t')
  endif

  " 写入新的 index
  call writefile([string(index)], statefile)

  " 建立链接
  let picked = files[index]
  let link_cmd = 'ln -sf "' . picked . '" ~/.config/wezterm/background.jpg'
  call system(link_cmd)
endfunction

