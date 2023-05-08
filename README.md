### Gematria CLI

Use gematria directrly from your terminal!

![Sample graph](https://github.com/DavidValin/gematria-cli/raw/main/sample.png)

#### Features

```
[x] Search a word or phrase and find its hebrew, english and simple gematria value
[x] When retrieving a gematria value for a search term, find previous search terms with the same gematria value
[x] Generate a visual graph with searched terms which have a relation between each other in hebrew, english or simple gematria tables
[x] Store all searches in a sqlite database in your user home directory (g.db filename)
```

#### Install

You need to have `ruby` and `graphviz` installed. Once installed run:
* `sudo make`

This will install a command called `g`

### How to use it

##### Search a term

If you want to find the gematria values for a specific term (word or phrase) use `g <term>`; example:

* `g be smart`
* `g poseidon`
* `g old friends`

The previous 3 terms match their hebrew gematria value.

##### Search a term

If you want to generate a graphviz graph in PNG which renders relations based on the gematria values of all the searches stored in the database call:

`g --graph`

This will create one png file for each language + numerical match value (using hebrew, english and simple gematria tables)

### About mapping tables

https://www.gematrix.org/?word=abcdefghijklmnopqrstuvwxyz has been used as a reference to construct the mapping tables for "hebrew", "english" and "simple".

### About this program

Created in an evening, don't expect too much of it
