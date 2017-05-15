
from ranger.gui.color import *
from ranger.colorschemes.default import Default

class Scheme(Default):
    progress_bar_color = green
    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.directory and not context.marked and not context.link:
            fg = green

        if context.in_titlebar and context.hostname:
            fg = red if context.bad else blue

#The ending line of a theme
        return fg, bg, attr
