import simplejson as json
import os
from pathlib import Path

HOME = Path(os.getenv("HOME", os.path.expanduser("~")))
CACHE = Path(os.getenv("XDG_CACHE_HOME", HOME / ".cache"))

with open(CACHE / "wal" / "colors.json") as colorsfile:
    try:
        wal = json.load(colorsfile)
        c.colors.tabs.bar.bg = wal['special']['background']
        c.colors.tabs.odd.bg = wal['colors']['color4']
        c.colors.tabs.selected.odd.bg = wal['colors']['color1']
        c.colors.tabs.even.bg = c.colors.tabs.odd.bg
        c.colors.tabs.selected.even.bg = c.colors.tabs.selected.odd.bg
        c.colors.tabs.pinned.even.bg = c.colors.tabs.odd.bg
        c.colors.tabs.pinned.odd.bg = c.colors.tabs.odd.bg
        c.colors.tabs.pinned.selected.odd.bg = c.colors.tabs.selected.odd.bg
        c.colors.tabs.pinned.selected.even.bg = c.colors.tabs.selected.odd.bg
        c.tabs.padding['left'] = 10
        c.tabs.padding['right'] = c.tabs.padding['left']
        c.tabs.padding['top'] = 4
        c.tabs.padding['bottom'] = c.tabs.padding['top']
        c.tabs.indicator.width = 10
        c.tabs.indicator.padding['top'] = 6
        c.tabs.indicator.padding['bottom'] = c.tabs.indicator.padding['top']
        c.tabs.indicator.padding['right'] = c.tabs.padding['left']
        c.colors.tabs.indicator.start = c.colors.tabs.odd.bg
        c.colors.tabs.indicator.stop = wal['colors']['color10']
        c.tabs.favicons.show = 'pinned'
    except json.JSONDecodeError as error:
        print(error)

config.load_autoconfig()
