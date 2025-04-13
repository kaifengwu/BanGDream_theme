" ========== 🌄 Morfonica 主题设定 ==========

" 🌄 自动加载 Morfonica 配色
colorscheme industry
hi Normal guibg=#1a1c2c guifg=#cdd6f4
"set background=dark
hi Normal guibg=NONE ctermbg=NONE guifg=#c8b0e3 " 正常文本
hi CursorLine guibg=NONE " 当前行
hi NormalNC guibg=NONE ctermbg=NONE guifg=#c8b0e3 " 非活动窗口的正常文本
hi Pmenu guibg=NONE guifg=#c8b0e3 ctermbg=NONE " 弹出菜单
hi PmenuSel guibg=#c8b0e3 guifg=#EE6666 ctermbg=NONE " 弹出菜单选中项
highlight CocFloating guibg=NONE guifg=#c8b0e3
highlight CocMenuSel guibg=#6677CC guifg=#EE7744 gui=bold
set winblend=0
highlight NonText guibg=NONE " 非文本字符
highlight EndOfBuffer guibg=NONE " 缓冲区末尾


" 清除已有 match
function! s:ClearCursorLineMatch()
  if exists('w:morfonica_cursor_match_id')
    call matchdelete(w:morfonica_cursor_match_id)
    unlet w:morfonica_cursor_match_id
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
    let w:morfonica_cursor_match_id = matchaddpos('MorfonicaCursorLine', [[lnum, 1, length]])
  endif
endfunction

" 定义高亮颜色（你可以换颜色）
highlight MorfonicaCursorLine guibg=#202234

" 每次移动光标都更新
augroup MorfonicaCursorLine
  autocmd!
  autocmd CursorMoved,CursorMovedI * call <SID>UpdateCursorLineMatch()
  autocmd BufLeave,WinLeave * call <SID>ClearCursorLineMatch()
augroup END


" 🌄 Morfonica 应援色代码高亮
" Mashiro
highlight Keyword      guifg=#EE7744 gui=bold " 关键字，例如 if, else, for 等
highlight Statement    guifg=#EE7744 " 语句，例如 return, break, continue 等

" Touko
highlight Function     guifg=#EE6666 " 函数，例如 print(), len() 等
highlight Label        guifg=#EE6666 " 标签，例如 goto 标签
highlight Delimiter    guifg=#EE6666 " 分隔符，例如逗号, 分号, 括号等
highlight Comment    guifg=#EE6666 " 分隔符，例如逗号, 分号, 括号等

" Nanami
highlight Identifier   guifg=#6677CC " 标识符，例如变量名、函数名等
highlight vimAutoCmdSfxList     guifg=#6677CC
highlight Special      guifg=#6677CC " 特殊字符，例如 @, #, $, %, & 等

" Rui
highlight Type         guifg=#669988 " 类型，例如 int, float, str 等
highlight scalaBlock   guifg=#669988 
" Tsukushi
highlight Constant     guifg=#EE7788 " 常量，例如 True, False, None 等
highlight Number       guifg=#EE7788 " 数字，例如 1, 2.5, 3.14 等
highlight Boolean      guifg=#EE7788 " 布尔值，例如 True, False

" Morfonica（#c8boe3）
highlight PreProc      guifg=#B5B7ED " 预处理指令，例如 #include, #define 等
highlight Todo         guifg=#B5B7ED " 待办事项，例如 TODO, FIXME 等
highlight WarningMsg   guifg=#B5B7ED " 警告信息，例如编译器警告
highlight vimMapRhs     guifg=#B5B7ED 
highlight vimMaplhs     guifg=#B5B7ED 
highlight vimUsrCmd     guifg=#B5B7ED 
highlight vimSetEqual   guifg=#B5B7ED 


highlight TSDelimiter    guifg=#66ff66 " 语法树分隔符，例如逗号, 分号, 括号等
highlight TSConstructor  guifg=#66ff66 " 语法树构造器，例如类, 函数等


function! DisplayMorfonicaLogo()
  let buf = nvim_create_buf(v:false, v:true)

  " 内容文本
  let lines = [
        \ "														═══════════════🌄 Morfonica 🌄 ═══════════════",
        \ "																 羽沢 つぐみ      宇田川 巴",
		\ "																	🎹				  🥁",
		\ " ",
        \ "															上原 ひまり    美竹 蘭		青葉 モカ",
		\ "															   🎸			 🎤				🎸",
        \ "														══════════════════════════════════════════════",
        \ "														   🌄 Welcome to the world of Morfonica! 🌄",
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
  hi! MorfonicaTitle guifg=#B5B7ED gui=bold
  hi! MorfonicaSong guifg=#B5B7ED
  hi! Mashiro      guifg=#6677CC
  hi! Touko        guifg=#EE6666
  hi! Rui       guifg=#669988
  hi! Tsukushi         guifg=#EE7788
  hi! Nanami        guifg=#EE7744
  hi! MorfonicaNote guifg=#B5B7ED

  " 应用 highlight 到特定行/列
" 第 0 行：Morfonica 顶部标题
call nvim_buf_add_highlight(buf, -1, 'MorfonicaTitle', 0, 0, -1)

" 第 1 行：成员名字
call nvim_buf_add_highlight(buf, -1, 'Rui', 1, 0,32)
call nvim_buf_add_highlight(buf, -1, 'Tsukushi',   1, 32, 64)

" 第 2 行：乐器 emoji
call nvim_buf_add_highlight(buf, -1, 'Rui', 2, 16, 17)  " 🎹
call nvim_buf_add_highlight(buf, -1, 'Tsukushi',   2, 24, 25)  " 🥁

" 第 4 行：下方三人
call nvim_buf_add_highlight(buf, -1, 'Nanami',   4, 0,30)
call nvim_buf_add_highlight(buf, -1, 'Mashiro', 4, 30,44)
call nvim_buf_add_highlight(buf, -1, 'Touko',   4, 44,64)

" 第 5 行：下方 emoji
call nvim_buf_add_highlight(buf, -1, 'Nanami',   5, 15, 16)  " 🎸
call nvim_buf_add_highlight(buf, -1, 'Mashiro', 5, 20, 21)  " 🎤
call nvim_buf_add_highlight(buf, -1, 'Touko',   5, 26, 27)  " 🎸
" ASCII 图部分统一使用 MorfonicaArt
for l in range(7, 33)
  call nvim_buf_add_highlight(buf, -1, 'MorfonicaTitle', l, 0, -1)
endfor

" 最下方横线
call nvim_buf_add_highlight(buf, -1, 'MorfonicaFooter', 27, 0, -1)

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
  let folder = expand('$HOME/.config/nvim/themes/BanGDream_vim_theme/Morfonica/Morfonica_background')
  let files = split(globpath(folder, '*'), '\n')
  let count = len(files)

  if count == 0
    echom "📂 目标文件夹为空"
    return
  endif

  let statefile = '/tmp/morfonica_wallpaper_index'
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

