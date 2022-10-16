
local ccart, ccart_fg, ccart_bg, ccart_adv_fg, ccart_adv_bg, ccart_width
ccart = ([[\159\143\143\143\143\143\143\143\144
\150\136\144     \150
\150\130 \131    \150
\150       \150
\150       \150
\150      \140\150
]]):gsub("\\130", "\130"):gsub("\\131", "\131"):gsub("\\136", "\136"):gsub("\\140", "\140"):gsub("\\143", "\143"):gsub("\\144", "\144"):gsub("\\150", "\149"):gsub("\\159", "\159")

ccart_fg = [[ffffffff7
f00fffff7
f0f0ffff7
ffffffff8
ffffffff8
f888888f8
fffffffff]]

ccart_bg = [[77777777f
7ffffffff
7ffffffff
8ffffffff
8ffffffff
88888888f
fffffffff]]

ccart_adv_fg = [[ffffffff4
f00fffff4
f0f0ffff4
ffffffff4
ffffffff4
f444444d4
fffffffff]]

ccart_adv_bg = [[44444444f
4ffffffff
4ffffffff
4ffffffff
4ffffffff
44444444f
fffffffff]]

ccart_width = 10


local lines, sw, sh = 1, term.getSize()
term.clear()
for i = 1, string.len(ccart), ccart_width do 
    term.setCursorPos(2, lines)
    --print(string.sub(ccart, i, i+ccart_width-2), string.sub(term.isColor() and ccart_adv_fg or ccart_fg, i, i+ccart_width-2), string.sub(term.isColor() and ccart_adv_bg or ccart_bg, i, i+ccart_width-2))
    term.blit(string.sub(ccart, i, i+ccart_width-2), string.sub(term.isColor() and ccart_adv_fg or ccart_fg, i, i+ccart_width-2), string.sub(term.isColor() and ccart_adv_bg or ccart_bg, i, i+ccart_width-2))
    print("  ")
    lines = lines + 1
end