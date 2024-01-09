This is a simple script that grabs the resources and levels of the H5-based Fireboy and Watergirl game from a certain online source, enabling you to play it offline and edit the levels.

> DISCLAIMER: This script is for nonprofit testing and educational purposes only. The author is not responsible for potential commercial and legal risks caused by abusing this script or files grabbed using it.

Usage:

1. Open a new tab in your browser, open DevTools (normally by pressing `F12`), and then visit the game page.
2. Navigate into each temple, and then an arbitrary level in that temple. This makes sure that all common resources are loaded. You do not have to play the game - just navigate in and out.
3. Switch to the Network panel of DevTools. Right click, and select 'Save all to HAR'. Save the HAR file into the `har` directory.
4. Open `common.py` and set `grab_url` `har_path` properly.
5. Run `1.unpack_har.py`.
6. Inspect `data/resource-list.json` manually to make sure things work.
7. Run `2.grab_files.py` and wait. This grabs all resource files from the online source.
8. The results will be found in the `output` directory.

Note that the `gameIndex.html` will likely not work if directly opened in the browser. Make sure to serve it through a local webserver. A simple way of doing this is using `npx serve`.

The level files can be edited using [Tiled](https://github.com/mapeditor/tiled). If you decide to use it, be notified that:

1. Tiled may need additional tileset atlasses to properly render the levels. You can use [the ones in this repository](./tiled-atlasses/) if you don't want to draw your own ones.
2. Please use the `json1.dll` plugin instead of `json.dll`. The latter will emit a newer json format which does not work with the game.
