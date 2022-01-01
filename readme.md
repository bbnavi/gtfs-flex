# bbnavi/gtfs-flex

**Generate a [GTFS-Flex v2](https://github.com/MobilityData/gtfs-flex/blob/130eb67c7dfac846b74625747e2623429d9f8f64/spec/reference.md) feed for [bbnavi](https://bbnavi.de).**

[![CC0-licensed](https://img.shields.io/github/license/bbnavi/gtfs-flex.svg)](LICENSE)

This feed augments the official VBB data in the [DELFI](https://www.delfi.de) [GTFS dataset](https://de.data.public-transport.earth/gtfs-germany.zip) by adding these lines:

- [RufBus lines 476, 477 & 478 in Angermünde](https://uvg-online.com/rufbus-angermuende/)


## Obtaining the feed

If you want to use this feed, just download [the repo as a ZIP archive](https://github.com/bbnavi/gtfs-flex/archive/refs/heads/main.zip).



## Building the feed

You need [`qsv`](https://github.com/jqnatividad/qsv), which you can download from [its latest release](https://github.com/jqnatividad/qsv/releases/latest).

```shell
git clone https://github.com/bbnavi/gtfs-flex.git
cd gtfs-flex
./build.sh
```
