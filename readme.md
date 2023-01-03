# bbnavi/gtfs-flex

**Generate a [GTFS-Flex v2](https://github.com/MobilityData/gtfs-flex/blob/130eb67c7dfac846b74625747e2623429d9f8f64/spec/reference.md) feed for [bbnavi](https://bbnavi.de).**

[![CC0-licensed](https://img.shields.io/github/license/bbnavi/gtfs-flex.svg)](LICENSE)

**This feed is an entirely separate feed.** It augments the official data in the [DELFI](https://www.delfi.de) [GTFS Berlin-Brandenburg cutout](https://gtfs.mfdz.de/DELFI.BB.gtfs.zip) used within bbnavi by specifying these lines:

- [RufBus lines 476, 477 & 478 in Angermünde](https://uvg-online.com/rufbus-angermuende/)
- [RufBus lines 487 & 488 in Gartz](https://uvg-online.com/rufbus-gartz/)


## Obtaining the feed

If you want to use this feed, download it from [the respective `opendata.bbnavi.de` page](https://opendata.bbnavi.de/vbb-gtfs-flex/index.html):

```shell
wget 'https://opendata.bbnavi.de/vbb-gtfs-flex/gtfs-flex.zip'
```


## Building the feed

You need [`qsv`](https://github.com/jqnatividad/qsv), which you can download from [its latest release](https://github.com/jqnatividad/qsv/releases/latest).

```shell
git clone https://github.com/bbnavi/gtfs-flex.git
cd gtfs-flex
./build.sh
```
