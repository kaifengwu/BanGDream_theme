" ========== 🌄 Afterglow 主题设定 ==========

" 🌄 自动加载 Afterglow 配色
colorscheme industry
hi Normal guibg=#1a1c2c guifg=#cdd6f4
"set background=dark
hi Normal guibg=NONE ctermbg=NONE guifg=#c8b0e3 " 正常文本
hi CursorLine guibg=NONE " 当前行
hi NormalNC guibg=NONE ctermbg=NONE guifg=#c8b0e3 " 非活动窗口的正常文本
hi Pmenu guibg=NONE guifg=#c8b0e3 ctermbg=NONE " 弹出菜单
hi PmenuSel guibg=#c8b0e3 guifg=#00CCAA ctermbg=NONE " 弹出菜单选中项
highlight CocFloating guibg=NONE guifg=#c8b0e3
highlight CocMenuSel guibg=#EE0022 guifg=#FF9999 gui=bold
set winblend=0
highlight NonText guibg=NONE " 非文本字符
highlight EndOfBuffer guibg=NONE " 缓冲区末尾


" 清除已有 match
function! s:ClearCursorLineMatch()
  if exists('w:afterglow_cursor_match_id')
    call matchdelete(w:afterglow_cursor_match_id)
    unlet w:afterglow_cursor_match_id
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
    let w:afterglow_cursor_match_id = matchaddpos('AfterglowCursorLine', [[lnum, 1, length]])
  endif
endfunction

" 定义高亮颜色（你可以换颜色）
highlight AfterglowCursorLine guibg=#202234

" 每次移动光标都更新
augroup AfterglowCursorLine
  autocmd!
  autocmd CursorMoved,CursorMovedI * call <SID>UpdateCursorLineMatch()
  autocmd BufLeave,WinLeave * call <SID>ClearCursorLineMatch()
augroup END


" 🌄 Afterglow 应援色代码高亮
" Ran
highlight Keyword      guifg=#FF9999 gui=bold " 关键字，例如 if, else, for 等
highlight Statement    guifg=#FF9999 " 语句，例如 return, break, continue 等

" Moca
highlight Function     guifg=#00CCAA " 函数，例如 print(), len() 等
highlight Label        guifg=#00CCAA " 标签，例如 goto 标签
highlight Delimiter    guifg=#00CCAA " 分隔符，例如逗号, 分号, 括号等
highlight Comment    guifg=#00CCAA " 分隔符，例如逗号, 分号, 括号等

" Himari
highlight Identifier   guifg=#EE0022 " 标识符，例如变量名、函数名等
highlight vimAutoCmdSfxList     guifg=#EE0022
highlight Special      guifg=#EE0022 " 特殊字符，例如 @, #, $, %, & 等

" Tsugumi
highlight Type         guifg=#FFEEBB " 类型，例如 int, float, str 等
highlight scalaBlock   guifg=#FFEEBB 
" Tomoe
highlight Constant     guifg=#BB0033 " 常量，例如 True, False, None 等
highlight Number       guifg=#BB0033 " 数字，例如 1, 2.5, 3.14 等
highlight Boolean      guifg=#BB0033 " 布尔值，例如 True, False

" Afterglow（#c8boe3）
highlight PreProc      guifg=#E53344 " 预处理指令，例如 #include, #define 等
highlight Todo         guifg=#E53344 " 待办事项，例如 TODO, FIXME 等
highlight WarningMsg   guifg=#E53344 " 警告信息，例如编译器警告
highlight vimMapRhs     guifg=#E53344 
highlight vimMaplhs     guifg=#E53344 
highlight vimUsrCmd     guifg=#E53344 
highlight vimSetEqual   guifg=#E53344 


highlight TSDelimiter    guifg=#66ff66 " 语法树分隔符，例如逗号, 分号, 括号等
highlight TSConstructor  guifg=#66ff66 " 语法树构造器，例如类, 函数等


function! DisplayAfterglowLogo()
  let buf = nvim_create_buf(v:false, v:true)

  " 内容文本
  let lines = [
        \ "														═══════════════🌄 Afterglow 🌄 ═══════════════",
        \ "																 羽沢 つぐみ      宇田川 巴",
		\ "																	🎹				  🥁",
		\ " ",
        \ "															上原 ひまり    美竹 蘭		青葉 モカ",
		\ "															   🎸			 🎤				🎸",
        \ "														══════════════════════════════════════════════",
        \ "														   🌄 Welcome to the world of Afterglow! 🌄",
		\ "															       ~写~代~码~要~加~油~哦~!",
        \ "",
		\ "                                                        .lxkdc.                                                                                       ",
		\ "                                                    'xNWK  xNO;                                            ..                                         ",
		\ "                              ..':lllc,            dNWK     lWX                                          'kNWXo                                       ",
		\ "                             .c0NN:  xWWNo        .0WW:                                                  dNWN, NO                                     ",
		\ "                          :ONWK      0WWWo      'XWWl                                                  kWWX  .NN.                                     ",
		\ "                        :KWWX.       kWWWK     'XWWO     .oxl                                        .0WW0  .0W.                                      ",
		\ "                      ,0WWW;         kWWWX     0WWX     ;XWN.   .                 :;                 OWWx  :XX     ..                                 ",
		\ "                    dNWWK           OWWWO    dWWWd..';oNWWOloooc.,loo;   c'..';dKN'   .coodkd,     xWWK;c0X    ;oONNo    .:c'   .     ...             ",
		\ "                   .0WWWd           .XWWWXO0KXWWWWWWNNWWWN'     lXWx.ON' oWWNNWWWK    xWWWX.cNWk   ,NWWKXK   .oXWWXXWNc  cNWN.  :0O,  oWWX.           ",
		\ "                  ;XWWW.            :NWWNc  :WWWK    xNWN'    .OWWXx0X. 'XWo,OWWd    xWWWl   xWX. .0WWX.    ;KWWk  oWWXOKWWX   oNWN. .KWWX            ",
		\ "                 cNWWN,             kWWW0   oWWW.   :WWWc    cKWWX     :XW; OWWx   cKWWWX  .oNWX:kWWWN, .'oKWWWX,.dNWN OWWN. .OWWN  '0WW0             ",
		\ "                cNWWN.             .NWWW:  .NWWX    0WWN. 'oK:.NWO...c0Nc  .KWNo,oXNx:kKXxxO0NWWNd 'NWNXNWx ;NWNXNWNd  cWWK:dNWWWo'xNWN.              ",
		\ "               :NWWN'              xWWWK   lWWW0    cNWWXNWWk::xNWNNWWNOdxxkXWWWWWWXOOkOKK0k0WWWXkxxONWWWOolclONWNO:...,KWWWX:  KNWWN;                ",
		\ "              ;NWWWc         .'', ,XWWWKodkXWWWNKKXXNNWWWWWNNNNNNXXKK00kk;           .dKWWWWWX              .kO0KKXNNNNNNWWWXkkkOXNXxl:;'...,'        ",
		\ "             ;NNNWO. ..',cloxk0KXNNNNNWWWNNNXK0Ox.                                  ;kXWN0xNK                                 'O0KNNWWWWWWNNX0c       ",
		\ "        ....lXNNNNXKXNNWWWWNNX, 'KNNNNo                                           :KNNN' ,KX                               .,codkOKNNXK               ",
		\ " ..';ldk0KNWNNNNNNWWNK'         .KNNNX                                           dNNNO  :XX                            :x0NWWNNNWWNX0Okkkkkkkkkxxxdol:",
		\ ".0NNWNNNNNNNNNNNX.             .0NNNN;                                           ;NNNxo0N:                             oNNNX0:              .O0KXNNNNW",
		\ " XNNNNNNXKXNNNNN'              kNNNNK                                                                                                                 ",
		\ "  :K'    ;XNNNNK.             dNNNNX.                                                                                                                 ",
		\ "        .KNNNNNO              :KNNX.                                                                                                                  ",
		\ "         KNNNNN.                                                                                                                                      ",
		\ "           ;oo.                                                                                                                                       ",
        \ "",
        \ "",
        \ ]

  call nvim_buf_set_lines(buf, 0, -1, v:false, lines)

  " 定义 highlight group（一次性定义即可）
  hi! AfterglowTitle guifg=#E53344 gui=bold
  hi! AfterglowSong guifg=#E53344
  hi! Ran      guifg=#EE0022
  hi! Moca        guifg=#00CCAA
  hi! Tsugumi       guifg=#FFEEBB
  hi! Tomoe         guifg=#BB0033
  hi! Himari        guifg=#FF9999
  hi! AfterglowNote guifg=#E53344

  " 应用 highlight 到特定行/列
" 第 0 行：Afterglow 顶部标题
call nvim_buf_add_highlight(buf, -1, 'AfterglowTitle', 0, 0, -1)

" 第 1 行：成员名字
call nvim_buf_add_highlight(buf, -1, 'Tsugumi', 1, 0,28)
call nvim_buf_add_highlight(buf, -1, 'Tomoe',   1, 28, 64)

" 第 2 行：乐器 emoji
call nvim_buf_add_highlight(buf, -1, 'Tsugumi', 2, 16, 17)  " 🎹
call nvim_buf_add_highlight(buf, -1, 'Tomoe',   2, 24, 25)  " 🥁

" 第 4 行：下方三人
call nvim_buf_add_highlight(buf, -1, 'Himari',   4, 0,30)
call nvim_buf_add_highlight(buf, -1, 'Ran', 4, 30,44)
call nvim_buf_add_highlight(buf, -1, 'Moca',   4, 44,64)

" 第 5 行：下方 emoji
call nvim_buf_add_highlight(buf, -1, 'Himari',   5, 15, 16)  " 🎸
call nvim_buf_add_highlight(buf, -1, 'Ran', 5, 20, 21)  " 🎤
call nvim_buf_add_highlight(buf, -1, 'Moca',   5, 26, 27)  " 🎸
" ASCII 图部分统一使用 AfterglowArt
for l in range(7, 33)
  call nvim_buf_add_highlight(buf, -1, 'AfterglowTitle', l, 0, -1)
endfor

" 最下方横线
call nvim_buf_add_highlight(buf, -1, 'AfterglowFooter', 27, 0, -1)

  " 设置浮窗
  let width = 152
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
  let folder = expand('$HOME/.config/nvim/themes/BanGDream_vim_theme/Afterglow/Afterglow_background')
  let files = split(globpath(folder, '*'), '\n')
  let count = len(files)

  if count == 0
    echom "📂 目标文件夹为空"
    return
  endif

  let statefile = '/tmp/afterglow_wallpaper_index'
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

