# powerpoint-renumber-layouts

## Description

Those scripts can be used to tidy up a Powerpoint file by renumbering the name of the layouts. If your master is named "Covers" then the layouts will be named:
- Covers 1
- Covers 2
- etc...

The script will *NOT* update your original file but will create a new file appending "NEW" to the filename in the same folder of the original file. Nevertheless you should always make a backup of your files before running these scripts to prevent any loss of data.

## Executing

Running is straightforward:
```
./rename_layouts.sh <path to pptx file>
```

The script will rename all layouts for master slides that start with some words. You can check and change the list of words by changing the `matches` variable in the `update_layouts.sh` script.

## Compatibility

These scripts were tested on MacOS.
