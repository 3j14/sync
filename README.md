# Sync – Simple Backup Utility
Simple macOS tray application to syncronize a folder using `rsync`.

This might not be the most elegant way to backup files, but it's simple and it works.
Using a small bash script, this swift application just provides an interface to controll `sync_files.sh`.


## Setup
You need the latest Xcode to configure `sync` for your system. There is no ready-to-use binary yet.

Import the project and change these lines in `StatusMenuController.swift`:
```Swift
task.arguments?.append("[SOURCE]")
task.arguments?.append("[DEST]")

// e.g. copy files from 'foo/bar' to '/Volumes/usb/foo/bar':
// task.arguments?.append("foo/bar")
// task.arguments?.append("/Volumes/usb/foo/bar")
```

You might want to change the text for the menu items in the `MainMenu.xib` file and add more items.

## License

The white refresh icon is made by Cole Bemis and is part of the awesome [feathericons](https://feathericons.com/) icon set, released under the MIT License.


Copyright 2019 Jonas Drotleff <jonas.drotleff@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
