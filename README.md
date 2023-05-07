### Gematria CLI

Use gematria directrly from your terminal!

![Sample graph](https://github.com/DavidValin/gematria-cli/raw/main/sample.png)

#### Features

```
[x] Search a word or phrase and find its hebrew, english and simple gematria value
[x] When retrieving a gematria value for a search term, find previous search terms with the same value
[x] Generate a visual graph with searched terms which have a relation between each other in hebrew, english or simple gematria tables
[x] Store all searches in a sqlite database in your user home directory (g.db filename)
```

#### Install

You need to have installed `ruby`. Once installed run:
`sudo make install`

This will install a command called `g`

### How to use it

##### Search a term

If you want to find the gematria values for a specific term (word or phrase) use `g <term>`; example:

`g be smart`
`g poseidon`
`g old friends`

The previous 3 terms match their hebrew gematrix value.

##### Search a term

If you want to generate a graphviz graph in PNG rendering its relations, perform a new search and add the `--graph` parameter; example:

`g isis --graph`

This will create 3 files in the current directory:
* `hbr.png` (graphviz graph with hebrew gematria value matches)
* `eng.png` (graphviz graph with english gematria value matches)
* `smp.png` (graphviz graph with simple gematria value matches)

### About mapping tables

https://www.gematrix.org/?word=abcdefghijklmnopqrstuvwxyz has been used as a reference to construct the mapping tables for "hebrew", "english" and "simple".

### About this program

Created in an evening, don't expect too much of it
